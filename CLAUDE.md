# CLAUDE.md — Mandatory Project Rules (Auto-Applied)

> **This file is automatically read by Claude Code at the beginning of every session.**
> These rules take precedence and must be followed without exception.

## Core Principle: IRS-Compliant Delivery Workflow

You are operating in an environment with strict delivery, audit, and compliance requirements (commonly referred to as the "IRS delivery workflow" or "dev-cycle").

**You must never skip steps in this workflow.** When a user gives you a task, your first action is to determine where we are in the cycle and execute the next required action. Do not jump straight to coding.

## The Mandatory Dev-Cycle (Every Story / Change)

1. **Story Intake & Context**
   - Obtain or confirm the Jira Story ID (or Epic).
   - Read the full acceptance criteria and any linked epic description.
   - If the story is unclear or acceptance criteria are incomplete, stop and ask clarifying questions before proceeding.

2. **Git Guardrails (always first technical step)**
   - Verify the base branch (usually `main` or `develop`) is up to date.
   - Create (or switch to) a compliant feature branch using the established naming convention.
   - Never work directly on protected branches.

3. **Planning (/plan)**
   - Break the work into small, verifiable steps.
   - Identify all artifacts that will constitute "evidence" (tests, logs, screenshots, data samples, architecture decisions, security considerations, etc.).
   - Note any compliance, security, data-handling, or regulatory implications.
   - Produce a clear, numbered plan that can be executed one step at a time.

4. **Step-by-Step Execution (/step)**
   - Work on **one step at a time**.
   - After completing a step, immediately update the evidence log (see below).
   - Run relevant tests, linters, and security scans for that step.
   - Only move to the next step after the current one is documented and passing.

5. **Evidence Logging (continuous)**
   - Maintain a living evidence record for the story.
   - Evidence must be committed alongside code changes (or referenced via stable links).
   - Typical evidence includes:
     - Test output and coverage reports
     - Manual test results or screenshots
     - Architecture or security decision records
     - Jira comments or status updates
     - Any regulatory or audit artifacts

6. **Git Hygiene & Pull Request**
   - Keep commits focused and well-described.
   - Rebase or merge latest base branch before opening a PR.
   - PR description must reference the Jira story and summarize evidence.
   - Address all feedback before merging.

7. **Story Closure**
   - Update Jira with the final status, links to PRs, and evidence location.
   - Confirm all acceptance criteria are demonstrably met.
   - Only then mark the story as done in Jira.

## Non-Negotiable Rules

- **No direct edits to `main` / protected branches** without explicit exception and guardrails.
- **No implementation without a plan** that has been reviewed in the current session.
- **No "it works on my machine"** — evidence must be captured and committed.
- **When in doubt, create more evidence, not less.**
- If the user asks you to skip a step "just this once", you must politely refuse and explain which compliance control would be violated.

## How to Use the Slash Commands Together

The individual commands in `.claude/commands/` exist to help you execute the above workflow reliably:

- `/git-guardrails <story-id> <short-summary>` — Enforce branch hygiene
- `/plan <story-id>` — Produce the implementation plan + evidence list
- `/step [step-number]` — Execute the next (or specified) step and capture evidence
- `/evidence-log [action]` — View, append, or format evidence for the current story
- `/jira-epic [epic-key]` or `/jira-sync` — Pull latest context or push updates
- `/dev-cycle` — (Optional) Re-print or walk through the full mandatory workflow

You should proactively suggest the next appropriate command when the user is working on a story.

## Model & Environment Awareness

- When running locally via Ollama, these rules still apply fully.
- When running on AWS via Bedrock, the same rules apply (the model is stronger but the process is identical).
- Never relax these rules based on which model is currently active.

---

**These rules exist to protect the project, the team, and the organization. They are not optional guidance — they are mandatory operating procedure for this repository.**
