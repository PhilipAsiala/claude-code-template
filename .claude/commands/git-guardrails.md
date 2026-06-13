---
allowed-tools: ["Bash", "Read"]
---

# /git-guardrails — Enforce Safe Git & Branching Practices

Execute Git guardrails for the provided Jira Story ID and change summary.

## Primary Behavior

If repository access is available, perform the commands directly in this order:

1. **Verify base branch is up-to-date**
   - Determine the primary branch (`main`, `master`, or `develop` — ask if unclear).
   - `git fetch origin`
   - `git checkout <base-branch>`
   - `git pull --ff-only origin <base-branch>`
   - If fast-forward fails, warn the user and stop. They must reconcile manually.

2. **Create and switch to a compliant feature branch**
   - Branch name format (strict):
     ```
     <story-id>/<kebab-case-short-summary>
     ```
     Example: `PROJ-1234/add-user-audit-logging`

   - The story ID must be in the branch name.
   - The summary must be short (3–6 words), lowercase, kebab-case.
   - Do not use slashes after the first one.

3. **Confirm clean working tree** (or explicitly note uncommitted changes).

4. **Report status**
   - Show current branch
   - Show last commit on the new branch
   - Remind user of the next recommended command (`/plan` or `/step`)

## Additional Guardrails

- **Never allow direct work on protected branches** (`main`, `master`, `develop`, `release/*`) unless the user provides an explicit written exception with a Jira reference.
- If the user is already on a non-compliant branch, offer to create the correct branch from the current commit or abort.
- Before any significant work, you may also run:
  - `git status --porcelain`
  - Check for large untracked files or secrets that should be in `.gitignore`.

## When Running on AWS Bastion or CI

The same rules apply. The only difference is that the git remote may be an internal mirror. The branch naming and base-branch hygiene requirements remain mandatory.

## Output Template

```
Git Guardrails — PROJ-1234

✓ Base branch 'main' is up to date (commit abc1234)
✓ Created and switched to branch: PROJ-1234/add-user-audit-logging
✓ Working tree is clean

Next: Run `/plan PROJ-1234` to create the implementation plan.
```

If any step fails, clearly explain the failure and what the human must do before retrying the guardrails command.
