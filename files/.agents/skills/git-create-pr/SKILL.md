---
name: git-create-pr
description: Create a pull request from the current git branch with a structured description. Use when the user wants Codex to create a PR, open a PR, open a pull request, push a branch and make a PR, or use trigger phrases like "create a PR", "make a pull request", "PR を作って", "PR を作成して", "プルリクを作る", or "open a PR". Pushes the branch if needed after confirmation, uses the repo's PR template when available, applies local labels from local.md, and writes a purpose/background/changes/impact focused PR body.
---

# Purpose
Create a consistent Pull Request from existing commits.

Always do the following:
- Confirm the current branch
- Stop on `main`, `master`, or the default branch unless the user explicitly asks to create a PR from that branch
- Ask for confirmation before pushing to remote
- Create a PR summarizing the changes
- PR title in English, PR body in the language confirmed with the user
- Focus on purpose, background, and impact - not a log of operations

# Command Policy
- Use git and GitHub CLI commands needed to inspect branch state, commit history, remotes, templates, and PR creation
- Do not use destructive git commands such as `git reset --hard`, `git checkout --`, or `git restore` unless the user explicitly asks
- Avoid unnecessary commands that trigger permission prompts
- Ask before pushing a branch or creating the PR when the user has not already clearly requested that action

# Steps

1. Ask the user whether the PR body should be written in Japanese or English.

2. Get the current branch name
  - `git branch --show-current`
  - If the current branch is `main`, `master`, or the default branch, stop and ask whether the user wants to switch branches

3. Inspect the branch changes and recent commits so the PR body is based on actual content, not only commit messages:
  - `git status -sb`
  - `git log --oneline --decorate -20`
  - Compare against the base branch when it is known, or after step 7

4. If the branch has not been pushed yet, show the push command and ask the user for confirmation before running it:
  - `git push -u origin <current-branch>`

5. Detect PR template by checking these paths in order (stop at first match):
  - `.github/pull_request_template.md`
  - `.github/PULL_REQUEST_TEMPLATE.md`
  - `docs/pull_request_template.md`
  - `PULL_REQUEST_TEMPLATE.md`

  If found: read the file with the Read tool and use it as the body template (see "Using a Repo Template" below).
  If not found: use the default body template (see "Default Body Template" below).

6. Check for additional PR labels
  - Read `local.md` from this skill folder (skip if the file does not exist)
  - Look for a `## PR Labels` section; extract any label names listed under it (lines starting with `- `)
  - These labels will be passed to `gh pr create` in the next step

7. Detect the default base branch
  - Run `gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name'` to get the repo's default branch
  - Use the result as the base branch unless the user specifies otherwise

8. Create the Pull Request
  - `gh pr create --base <base-branch> --title "<title>" --body "<filled-body>" [--label "<label>" ...]`
  - Include one `--label "<name>"` argument for each label found in step 6 (if any)

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
User impact, compatibility, risks

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
- Never include any text indicating the PR was created by Codex
