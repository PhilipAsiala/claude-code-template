---
allowed-tools: ["Read", "Edit", "Write", "Bash", "Grep"]
---

# /step — Execute One Step of the Approved Plan + Capture Evidence

You are executing work under a strict compliance regime. You must complete **exactly one step** of the previously approved plan and produce high-quality, committed evidence before stopping.

## Inputs
- The step number (or "next" if the user does not specify).
- The current plan (you should have it from previous `/plan` context or the user will provide it).
- The Jira Story ID.

## Execution Rules (Non-Negotiable)

1. **One step only.** Do not continue to the next step even if the current one feels easy.
2. **Follow the plan exactly.** If you discover the plan was wrong or incomplete, stop, document the issue, and propose an updated plan rather than improvising.
3. **Capture evidence as you go.** Evidence must be real output (test results, command output, files created, screenshots if visual, etc.).
4. **Update the evidence log** for the story before finishing (see `/evidence-log`).
5. **Run verification** that the step defines (tests, linters, manual checks).

## Workflow You Must Follow

1. Read the relevant plan step.
2. Perform the work for that step only (edit files, run commands, create artifacts).
3. Verify the step's definition of done.
4. Immediately append high-quality evidence to the story's evidence record:
   - Prefer committed files inside the repository (e.g. `docs/evidence/PROJ-1234/`). 
   - Include command output, test reports, key file diffs, decision records, etc.
5. Summarize for the user:
   - What was done
   - Evidence location
   - Status of the step (PASS / BLOCKED)
   - Recommended next command (`/step 3`, `/evidence-log`, `/git-guardrails` for a rebase, etc.)

## Evidence Standards

Good evidence is:
- **Verifiable** — someone else can re-run or re-read it later.
- **Timestamped** (include command output that shows dates when possible).
- **Committed** to the repository alongside the code change.
- **Referenced from Jira** (you should suggest or perform the Jira update).

Bad evidence (avoid):
- "I tested it and it works"
- Console output that only existed in your terminal and was not captured
- Changes with no tests or logs when the plan called for them

## Git Behavior During Steps

- Make small, focused commits when appropriate.
- Use clear commit messages that reference the story ID and step number.
- Do not push to the remote until the user explicitly asks (or the plan says to).

## When the Step Is Blocked

If you cannot complete the step:
- Clearly state the blocker.
- Document what you tried in the evidence log.
- Suggest the next action (research spike, ask user for decision, update plan, etc.).
- Do **not** skip to another step.

## Final Output for the User

Always end a `/step` invocation with:

```
Step X of PROJ-1234 completed (or blocked).

Evidence: <link or path to evidence file(s)>

Recommended next action: /step X+1   OR   /evidence-log show   OR   ...
```

This discipline is what allows the team to pass audits and deliver with confidence.
