---
allowed-tools: ["Read", "Edit", "Write", "Bash"]
---

# /plan — Create Implementation Plan + Evidence Requirements

You are helping the team deliver work under strict audit and compliance requirements.

## Primary Goal
Produce a clear, numbered, step-by-step implementation plan for the current Jira story (or the story ID provided by the user). The plan must be small enough that each step can be executed and evidenced in a single focused `/step` invocation.

## Required Inputs
- Jira Story ID (e.g. PROJ-1234). Ask the user if not provided.
- Full story title and acceptance criteria (fetch from Jira if tools allow, otherwise ask user to paste).
- Any linked Epic or parent context.

## What the Plan Must Contain

1. **Story Summary** (1-2 sentences)
2. **Compliance & Risk Considerations**
   - Data sensitivity / PII
   - Security implications
   - Regulatory or audit impact
   - Any special evidence that auditors will expect
3. **Numbered Steps** (actionable, small, testable)
   - Each step must have a clear "Definition of Done" for that step.
   - Include verification method (automated test, manual test script, log snippet, screenshot, etc.).
4. **Evidence Checklist**
   - List every artifact that must be produced and committed for this story.
   - Examples: unit test output, integration test results, architecture decision record, before/after screenshots, data migration logs, security scan results, Jira comments.
5. **Branch & Git Hygiene Notes** (reference the git-guardrails command)
6. **Rollback / Roll-forward Considerations** (if relevant)

## Output Format

Use this exact structure (Markdown):

```markdown
## Plan for PROJ-1234: <Story Title>

**Compliance Notes**
- ...

**Implementation Steps**

1. **Title of step 1**
   - Details...
   - Verification: ...
   - Evidence to capture: ...

2. ...

**Evidence Checklist**
- [ ] ...
- [ ] ...

**Next Action**
Run `/git-guardrails PROJ-1234 "short summary"` then begin with step 1 using `/step 1`.
```

## Rules
- Do not start implementing anything.
- Do not write code in the plan.
- If acceptance criteria are missing or ambiguous, explicitly call this out in the plan and ask for clarification before finalizing.
- Keep the total number of steps reasonable (usually 5–12 for a normal story).
- Reference `CLAUDE.md` rules where relevant.

After the plan is produced, ask the user to review it and confirm they want to proceed to execution (or request changes). Only after explicit approval should you suggest running `/step`.
