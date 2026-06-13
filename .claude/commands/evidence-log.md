---
allowed-tools: ["Read", "Write", "Edit", "Bash"]
---

# /evidence-log — Maintain the Audit Evidence Record for a Story

This command helps create, view, append to, and format the official evidence package for a Jira story.

## Why This Matters

In regulated delivery environments, evidence is not optional. It must be:
   - Captured at the time of the work
   - Committed to the repository
   - Traceable back to the Jira story
   - Sufficient for an auditor or reviewer to reconstruct what was done and why

## Standard Evidence Location

By convention we store evidence under:

```
docs/evidence/<STORY-ID>/
```

Inside that folder you will typically find:

- `plan.md` (copy or reference of the approved plan)
- `step-01.md`, `step-02.md`, ... (one file per executed step with output)
- `test-results/`
- `decisions/`
- `screenshots/` or other artifacts
- `final-summary.md`

## Command Behaviors

**Show current evidence**
```
/evidence-log show PROJ-1234
```

**Append evidence for a step** (you will be given the content or will generate it from recent work)
```
/evidence-log append PROJ-1234 step-03 "Test output and explanation..."
```

**Initialize evidence folder for a new story**
```
/evidence-log init PROJ-1234
```

**Generate a final evidence package summary** (suitable for attaching to Jira)
```
/evidence-log finalize PROJ-1234
```

## What Good Evidence Files Contain

- Date/time of execution
- Exact commands run (with output)
- Relevant file paths changed + short diff summary
- Verification results (tests passed, scans clean, manual checks performed)
- Any deviations from the plan + justification
- Links or references to commits and PRs

## Rules

- Never claim evidence exists that you did not actually capture and write to disk.
- Prefer structured Markdown files over loose terminal dumps.
- If visual evidence (screenshots, diagrams) is required, note the filename and location even if you cannot capture the image yourself.
- At story completion, the evidence folder + the PR description together should allow a stranger to understand the change and be confident it meets the acceptance criteria.

## Integration with Other Commands

- `/plan` produces the initial evidence checklist.
- `/step` should end by calling (or instructing the user to call) evidence-log append.
- `/git-guardrails` results can be included as early evidence.

Treat the evidence log as a first-class deliverable of the story, not an afterthought.
