# .claude/commands

This directory contains custom slash commands for Claude Code.

Each `.md` file becomes a first-class `/command` that can be invoked in any Claude Code session for this project.

## How It Works

- Filename (without `.md`) = the slash command name.
  - `plan.md` → type `/plan`
  - `git-guardrails.md` → type `/git-guardrails`
- Optional YAML frontmatter at the top of the file can restrict which tools the command is allowed to use.
- All files in this directory are committed to git. When teammates (or your future self on a bastion) clone the repo, the commands travel with the code.

## Recommended Core Commands (included in this template)

| Command            | Purpose                                      | Typical Trigger                     |
|--------------------|----------------------------------------------|-------------------------------------|
| `/plan`            | Break story into steps + define evidence     | Start of work on a new story        |
| `/step`            | Execute one step and capture evidence        | After plan is approved              |
| `/git-guardrails`  | Enforce branch naming, base branch hygiene   | Before any coding changes           |
| `/jira-epic`       | Pull or update Jira epic/story context       | Intake or status updates            |
| `/evidence-log`    | View / append / format compliance evidence   | End of every step                   |
| `/dev-cycle`       | Re-state or walk the full mandatory workflow | When user wants a reminder          |

See [TESTING.md](../TESTING.md) for detailed instructions on how to test these commands, including sample data under `docs/evidence/PROJ-1234/`.

## Adding New Commands

Simply create a new file:

```bash
.claude/commands/my-custom-review.md
```

Then in Claude Code you can immediately use:

```
/my-custom-review
```

## Frontmatter Example (Tool Restriction)

```markdown
---
allowed-tools: ["Read", "Bash", "Edit"]
---
# My Restricted Command

This command can only read files and run bash...
```

## Best Practices for Command Authors

- Be extremely explicit about order of operations.
- Tell the model what success looks like for the command.
- Include examples of good output.
- Reference `CLAUDE.md` when the command must obey global rules.
- Keep commands focused — one responsibility per file.

These commands are the living documentation of *how we work*.
