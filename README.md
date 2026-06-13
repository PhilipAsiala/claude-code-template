# Claude Code Template (with Ollama + AWS Bedrock)

A ready-to-use, version-controlled template for **Claude Code** that replaces the old single-YAML approach from Continue.dev with modular, individual Markdown command files.

This template is especially useful for teams that need:

- Reproducible, auditable development workflows (e.g. IRS delivery / compliance-heavy environments)
- Local development with open models via Ollama
- Seamless transition to production-grade models on AWS Bedrock (including GovCloud)

## Why This Approach Is Better

Moving from a single YAML configuration file in Continue to Claude Code actually makes your setup more modular and easier to version-control.

Instead of defining everything in one giant block, Claude Code uses individual Markdown files for your commands. These files live in `.claude/commands/` and are committed to your repository.

**Benefits**
- Each workflow is a discrete, reviewable file
- Easy to add, modify, or disable specific commands per project
- The same commands travel with the code when you clone onto a bastion or CI environment
- Global rules can be enforced via a root `CLAUDE.md`

## Repository Structure

```
.
├── .claude/
│   ├── commands/
│   │   ├── plan.md
│   │   ├── step.md
│   │   ├── git-guardrails.md
│   │   ├── jira-epic.md
│   │   ├── evidence-log.md
│   │   └── dev-cycle.md
│   └── README.md
├── CLAUDE.md                 # ← Global rules (auto-applied to every session)
├── README.md
└── .gitignore
```

## 1. Local Development with Ollama

Claude Code works beautifully with local models through Ollama (v0.15+ has built-in Anthropic API compatibility).

### Step A: Pull a strong coding model

```bash
ollama pull qwen2.5-coder:7b
# or
ollama pull llama3.1:8b
```

### Step B: Launch Claude Code wired to Ollama

Instead of the normal `claude` command, use Ollama's wrapper:

```bash
ollama launch claude --model qwen2.5-coder:7b
```

That's it. Claude Code will start using your local model at `127.0.0.1:11434`.

### Using Your Custom Commands

Once inside Claude Code, type any of the slash commands:

- `/plan`
- `/step`
- `/git-guardrails`
- `/jira-epic`
- `/evidence-log`
- `/dev-cycle`

Each command reads its corresponding file from `.claude/commands/`.

## 2. The Switch to AWS Bedrock (Production / Bastion)

The `.claude/commands/` directory (and `CLAUDE.md`) are committed to git. When you clone the project on an AWS bastion host (or any secure environment), your entire workflow library comes with it.

### On the AWS side (no prompt changes required)

1. Create or edit `~/.claude/settings.json` (user home, **not** inside the repo):

```json
{
  "env": {
    "CLAUDE_CODE_USE_BEDROCK": "1",
    "ANTHROPIC_DEFAULT_SONNET_MODEL": "global.anthropic.claude-sonnet-4-5-20250929-v1:0"
  }
}
```

For GovCloud you will typically use a model ARN in the `aws-us-gov` partition, for example:

```json
"ANTHROPIC_DEFAULT_SONNET_MODEL": "arn:aws-us-gov:bedrock:us-gov-west-1::foundation-model/anthropic.claude-sonnet-4-5-20250929-v1:0"
```

2. Simply run the normal command on the bastion:

```bash
claude
```

Claude Code will pick up the environment variables from `~/.claude/settings.json` and route all requests through Bedrock using the bastion's IAM role. Your exact same slash commands (`/plan`, `/step`, `/evidence-log`, etc.) continue to work unchanged.

## 3. Global Enforcement with CLAUDE.md (Recommended for Compliance)

For mandatory processes (your "dev-cycle" / IRS delivery workflow), you have two choices:

- Keep it as an opt-in slash command: `.claude/commands/dev-cycle.md`
- **Enforce it for every conversation** by placing the rules in `CLAUDE.md` at the repository root.

When `CLAUDE.md` exists, Claude Code automatically reads it at the start of every session. This is the strongest way to guarantee that critical compliance steps are never skipped.

## 4. Adding or Customizing Commands

1. Create a new file: `.claude/commands/my-new-workflow.md`
2. (Optional) Add a frontmatter block to restrict tools:

```markdown
---
allowed-tools: ["Bash", "Read", "Edit", "Write"]
---
# My New Workflow

Detailed instructions here...
```

3. Commit and push. The new `/my-new-workflow` command is immediately available to anyone who clones the repo.

## 5. Using This Repository as a Template

1. Click the green **"Use this template"** button on GitHub (or "Create a new repository from this template").
2. Clone your new copy.
3. (Optional but recommended) Customize `CLAUDE.md` and the command files for your team's specific processes.
4. Add real Jira integration details, internal links, evidence storage conventions, etc.
5. Commit. Your team now has a living, versioned set of AI-assisted workflows.

After forking/copying, go to your new repo → **Settings → General** and check **"Template repository"** if you want others to be able to use the same "Use this template" flow.

## Recommended Models & Notes

**Local (fast iteration):**
- `qwen2.5-coder:7b` or `14b` — excellent coding performance
- `llama3.1:8b` or `70b` (if you have the RAM)

**AWS Bedrock (production / regulated environments):**
- Claude Sonnet 4 / 4.5 family (the IDs above are examples — always verify current model IDs in the Bedrock console for your partition)

## Security & Compliance Notes

- Never commit `~/.claude/settings.json` or any file containing API keys / IAM credentials.
- The `.gitignore` in this template helps protect common secret locations.
- On bastion hosts, rely on IAM roles rather than long-lived keys.
- All custom commands are plain text and auditable — perfect for change control and security reviews.

## Contributing Improvements

Pull requests that improve the command library, add new compliance-friendly workflows, or refine the Ollama ↔ Bedrock handoff documentation are very welcome.

---

This template gives you the best of both worlds:
- Fast, private local development with Ollama
- Production-grade, centrally governed models via AWS Bedrock
- Portable, version-controlled, and auditable AI workflows that travel with your code
