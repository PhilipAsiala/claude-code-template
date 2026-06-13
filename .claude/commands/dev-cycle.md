---
allowed-tools: ["Read"]
---

# /dev-cycle — Full IRS Delivery Workflow Reference

This command prints or walks through the **mandatory IRS-compliant delivery workflow** for this project.

It is provided primarily as a reference and reminder. The authoritative version lives in the root `CLAUDE.md` file, which is automatically loaded every session.

## When to Use This Command

- At the start of a new story or epic
- When a team member (or auditor) wants to understand the required process
- If anyone suggests skipping steps — re-run this to re-establish the rules

## Quick Reference (Summary)

The full mandatory flow is:

1. **Story Intake** — Confirm Jira ID + acceptance criteria
2. **Git Guardrails** — `/git-guardrails <id> "<summary>"`
3. **Planning** — `/plan <id>` (produce steps + full evidence checklist)
4. **Step Execution** — `/step N` (one step at a time + evidence after each)
5. **Continuous Evidence** — `/evidence-log` after every step
6. **Git Hygiene & PR** — Keep branch current, good commits, reference story + evidence in PR
7. **Jira Closure** — Update story with final evidence and status

## Key Non-Negotiables

- Never work on protected branches directly.
- Never implement without an approved plan in the current session.
- Evidence must be captured and committed — "I tested it" is not evidence.
- One step at a time. Finish the evidence for the current step before moving on.

## Full Rules

The complete, binding version of these rules is in the `CLAUDE.md` file at the root of the repository.

You can ask me to read and re-state any section of `CLAUDE.md` at any time.

---

**Remember:** These processes exist so that the team can move quickly while remaining fully auditable. Following them is how we maintain trust with stakeholders and pass reviews.
