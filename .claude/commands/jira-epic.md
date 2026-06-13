---
allowed-tools: ["Read", "Bash", "Edit"]
---

# /jira-epic — Jira Context, Intake, and Status Synchronization

Help the team stay in sync with Jira for the current Epic or Story.

## Capabilities

- Pull the latest description, acceptance criteria, and comments for a given Epic or Story key.
- Help draft clear updates or evidence summaries that can be posted back to Jira.
- Suggest status transitions (e.g. "In Progress" → "In Review") based on the current state of the git branch and evidence.
- Extract or maintain links between code branches, PRs, and Jira issues.

## Expected Behavior

1. If the user provides a key (e.g. `PROJ-567`), fetch and display the key information:
   - Summary / Title
   - Description
   - Acceptance Criteria (parse if in a structured field or description)
   - Current status and assignee
   - Recent comments (especially evidence or decisions)
   - Linked issues / Epic

2. Offer to generate a concise status comment suitable for pasting into Jira that includes:
   - Current branch
   - Latest evidence location
   - Which plan step we are on
   - Any blockers

3. If the story appears to be missing key acceptance criteria or context, flag this explicitly (this is a compliance requirement).

## Notes for Regulated Environments

- Jira is often the system of record for audit purposes.
- Every significant step should eventually have a corresponding Jira comment or attachment.
- When generating text for Jira, keep language factual, professional, and traceable ("Evidence captured in commit `def456` and `docs/evidence/PROJ-1234/step-03.md`").

## Limitations

This command cannot actually call the Jira API unless the environment has `jira` CLI or API credentials configured and the user explicitly allows the necessary `Bash` or network tools. In many bastion environments this will be disabled.

When direct access is unavailable:
   - Ask the user to paste the current Jira content.
   - Generate well-formatted Markdown that they can copy into Jira themselves.
   - Offer to format evidence logs as Jira-compatible attachments.

## Example Invocation

```
/jira-epic PROJ-901 "Please pull the latest acceptance criteria and draft a progress comment for where we are on step 2."
```
