---
name: git-commit
description: "Commit code changes with conventional commits split by intent. Use when the user wants to commit, stage, or save changes to git. Trigger phrases: 'commit this', 'commit my chages', 'コミットして', 'この変更をコミット', 'stage and commit'. Produces emoji-prefix conventional commits (feat, fix, refactor, improve, etc.), never commits on main/master. Splits commits by intent even within a single file."
permissionMode: dontAsk
---

# Purpose
Understand the changes and create commits at the appropriate granularity based on intent and scope.

# Pre-flight Check
1. Run `git status -sb` to confirm the current branch
2. If the branch is `main` or `master`, **stop immediately** and ask the user to switch branches - do not stage or commit anything

# Reference Materials
If the user provides reference materials (links, docs, design notes, ticket IDs, etc.), use them to inform the commit intent, granularity, and message. Ask for clarification before proceeding if anything is unclear.

# Command Policy
- Use only `git status`, `git diff`, `git diff --staged`, and `git log` to assess stage - run all three diff variants to avoid missing pre-staged changes
- Do not run commands outside of allowed-tools
- Avoid unnecessary commands that trigger permission prompts

# Commit Flow
1. Run `git status -sb` to check state and branch (stop if main/master)
2. Review all changes:
  - `git diff` - unstaged changes
  - `git diff --staged` - already-staged changes
  - `git log --oneline -5` - recent commit style for reference
3. Classify all changes by **intent** (new feature, bug fix, refactor, behavior improvement, breaking change, deletion)
4. If multiple intents exist, **split into separate commits** - even within a single file
5. For each group: `git add` → verify with `git diff --staged` → `git commit`
6. Run `git status -sb` at the end to confirm no remaining changes

# Prefix Reference

| Prefix | When to use |
| ------ | ----------- |
| ⚒️ fix | Non-urgent bug fix |
| 🔥 hotfix | Urgent bug fix with production impact |
| ✨ feat | New file or feature |
| 🔧 improve | Improvement that does'nt break existing behavior |
| 🔀 change | Breaking change or contract change |
| 🧹 refactor | Code restructuring with no external behavior change |
| 🚫 disable | Temporary disable or comment-out |
| 🗑️ remove | Delete a file or feature |
| 🚀 upgrade | Library or framework version update |
| ↩️ revert | Roll back a previous change |

# Commit Message Rules

**Language:** English by default. Use the language the user specifies if given.

**Format (one line as a rule):**
- `<Prefix>: <concise summary>`
- Add minimal bullet points only when the change is complex enough to cause misunderstanding
- Forbidden: vague summaries like `fix: multiple updates`

**Content:** Summarize the purpose or value - not a list of operations. Include a scope when the impact is significant (e.g., `(auth)`, `(cdn)`).

# Prohibited
- Never run or main/master - always stop
- Never include a `Co-Authored-By` trailer
- Never include any text indicating the commit was created by Claude (e.g., `🤖 Generated with Claude Code`)
