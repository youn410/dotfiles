---
name: git-create-pr
description: "Create a pull request from the current branch with a structured description. Use when the user wants to create a PR, open a pull request, or push a branch and make a PR. Trigger phrases: 'create a PR', 'make a pull request', 'PRを作って', 'PRを作成して', 'プルリクを作る', 'open a PR'. Pushes the branch if needed and writes a PR body using the repo's PR template if one exists, otherwise uses the default Summary/Background/Changes/Impact structure. Confirms language (Japanese or English) with the user."
allowed-tools: Bash(git push:*), Bash(git branch:*), Bash(git rev-parse:*), Bash(gh pr create:*), Glob, Read
---

# Purpose
Create a consistent Pull Request from existing commits.

Always do the following:
- Confirm the current branch
- Ask for confirmation before pushing to remote
- Create a PR summarizing the changes
- PR title in English, PR body in the language confirmed with the user
- Focus on purpose, background, and impact - not a log of operations

# Command Policy
- Do not run commands outside of allowed-tools
- Avoid unnecessary commands that trigger permission prompts
- Command substitution (`$(...)` and backticks) is allowed, but only with commands inside allowed-tools

# Steps

1. Ask the user whether the PR body should be written in Japanese or English

2. Get the current branch name
  - `git branch --show-current`

3. If the branch has not been pushed yet, show the push command and ask the user for confirmation before running it:
  - `git push -u origin <current-branch>`

4. Detect PR template using Glob. Check these paths in order (stop at first match):
  - `.github/pull_request_template.md`
  - `.github/PULL_REQUEST_TEMPLATE.md`
  - `docs/pull_request_template.md`
  - `PULL_REQUEST_TEMPLATE.md`

  If found: read the file with the Read tool and use it as the body template (see "Using a Repo Template" below).
  If not found: use the default body template (see "Default Body Template" below).

5. Create the Pull Request
  - `gh pr create --base <base-branch> --title "<title>" --body "<filled-body>"`
  - Default base branch is `main` unless the user specifies otherwise.

# Using a Repo Template

When a PR template file is found:
- Read its full contents with the Read tool
- Fill in all placeholder sections (e.g. `<Replace me>`, `* description here`, `TICKET-*`) with relevant content derived from the branch's commits and diff
- Check the appropriate checkboxes (e.g. `- [x] Bug fix`) based on the nature of the change
- Do not remove any sections from the template - keep the structure intact
- Translate free-text sections into the language confirmed with the user; leave headings/labels as-is

# Default Body Template

Use this when no repo template is found:

```
### Summary
Overview of the changes

### Background
Why this change is necessary

### Changes
- Key changes (bullet points)

### Impact
User impact, comatibility, risks

### Notes (optional)
Additional context for reviewers
```

# Confluence Usage (background reference only)
IF the user provides a Confluence page URL, page ID, or title:
- Use confluence-mcp to read the content
- Use it as primary source material for understanding background - do not copy it verbatim
- Do not include the Confluence link in the PR body

Skip this step if no Confluence link is provided.

# Prohibited
- Vague titles are not allowed
- Do not simply copy commit log messages
- Always include purpose and background
- Never include a `Co-Authored-By` trailer
- Never include any text indicating the PR was created by Claude (e.g., `🤖 Generated with Claude Code`)
