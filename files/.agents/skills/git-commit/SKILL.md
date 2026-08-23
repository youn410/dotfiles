---
name: git-commit
description: Commit code changes with conventional commits split by intent. Use when the user wants Codex to commit, stage, or save changes to git, including trigger phrases like "commit this", "commit my changes", "コミットして", "この変更をコミット", or "stage and commit". Produces emoji-prefix conventional commits (feat, fix, refactor, improve, etc.), never commits on main/master/default, and splits commits by intent even within a single file.
---

# Purpose
Understand the changes and create commits at the appropriate granularity based on intent and scope.

# Pre-flight Check
1. Run `git status -sb` to confirm the current branch.
2. Determine the repository default branch from local metadata when available, preferably with `git symbolic-ref refs/remotes/origin/HEAD --short` (for example, `origin/develop` means `develop` is the default branch).
3. If the current branch is `main`, `master`, or the default branch, **stop immediately** and ask the user to switch branches; do not stage or commit anything.

# Reference Materials
If the user provides reference materials (links, docs, design notes, ticket IDs, etc.), use them to inform the commit intent, granularity, and message. Ask for clarification before proceeding if anything is unclear.

# Command Policy
- Use only `git status`, `git diff`, `git diff --staged`, and `git log` to assess state; run all diff variants needed to avoid missing pre-staged changes
- Use `git add` and `git commit` only after reviewing and grouping changes by intent
- Do not use destructive commands such as `git reset --hard`, `git checkout --`, or `git restore` unless the user explicitly asks
- Avoid unnecessary commands that trigger permission prompts

# Commit Flow
1. Run `git status -sb` to check state and branch; determine the default branch from local metadata when available (stop if the current branch is `main`, `master`, or the default branch).
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
| 🔧 improve | Improvement that doesn't break existing behavior |
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

**Content:** Summarize the purpose or value - not a list of operations. Include a scope when the impact is significant (e.g.,
`(auth)`, `(cdn)`).

# Prohibited
- Never commit on `main`, `master`, or the default branch; always stop
- Never include a `Co-Authored-By` trailer
- Never include any text indicating the commit was created by Codex
