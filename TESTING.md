# Testing the Claude Code Commands

This document explains how to test the custom slash commands in `.claude/commands/`.

## 1. Automated Validation (Recommended First Step)

The repository includes a basic validator:

```bash
bash scripts/validate-commands.sh
```

It checks:
- Frontmatter syntax (`---` + `allowed-tools`)
- Primary heading matches the command filename (e.g. `# /plan`)
- Cross-command references
- Presence of `docs/evidence/` (used by evidence-related commands)

Run this after any edits to the command files.

## 2. Manual Testing with Claude Code + Ollama (Primary Method)

### Prerequisites
- Ollama v0.15+
- A good coding model pulled: `ollama pull qwen2.5-coder:7b`
- Launch with the wrapper so it uses your local model:

```bash
ollama launch claude --model qwen2.5-coder:7b
```

### Recommended Test Scenario

Use the sample story that ships with the template:

**Jira Story**: `PROJ-1234` — "Add audit logging to user service"

The template provides concrete test data under:

```
docs/evidence/PROJ-1234/
├── plan.md
└── step-01.md
```

### Test Each Command

In Claude Code, try these invocations (in rough recommended order):

1. **/dev-cycle**
   - Purpose: Reminder of the overall mandatory workflow.
   - Expected: It should point you at `CLAUDE.md` and list the 7 steps.

2. **/git-guardrails PROJ-1234 "add-audit-logging"**
   - Should attempt real `git` commands (fetch, branch creation).
   - If you're not in a real git repo or have no remote, it should gracefully explain what it would do and what the correct branch name must be.
   - Verify it never suggests working directly on `main`.

3. **/plan PROJ-1234**
   - Should read the existing `docs/evidence/PROJ-1234/plan.md` or produce a new plan.
   - Must produce the exact output structure defined in the command.
   - Must reference git guardrails and suggest `/step 1`.
   - Must not start writing implementation code.

4. **/step 1** (or `/step` after a plan)
   - Must do **exactly one step**.
   - Must produce real artifacts + append evidence using file writes.
   - Must finish by printing the exact "Step X of PROJ-1234 ..." block.
   - Must suggest the next command (usually `/evidence-log` or `/step 2`).

5. **/evidence-log show PROJ-1234**
   - Should list or render content from `docs/evidence/PROJ-1234/`.

6. **/evidence-log append PROJ-1234 step-99 "Some test evidence here..."**
   - Should create or append a file under the evidence directory.

7. **/jira-epic PROJ-1234**
   - Since no real Jira is connected in most local setups, it should ask you to paste Jira content or generate a well-formatted update you can copy/paste into Jira.
   - It must emphasize traceability ("Evidence captured in ...").

8. **/dev-cycle** (again at the end)
   - Re-confirm that the global rules were followed.

### Tips for Good Tests

- Always provide the story ID.
- After each command, review the files it created or modified (`git status`, `git diff`).
- Pay special attention to whether it respected "one step only" and "capture real evidence".
- If the model skips steps or starts coding too early, the prompt needs strengthening.

## 3. Testing on AWS Bedrock (Bastion / Secure Environment)

1. Set up `~/.claude/settings.json` with `CLAUDE_CODE_USE_BEDROCK`.
2. Run plain `claude`.
3. Repeat the same sequence above.
4. The commands themselves require no changes — only the underlying model changes.

The sample evidence in `docs/evidence/PROJ-1234/` gives you a head start and a way to verify the commands are locating and manipulating the correct artifacts.

## 4. Adding New Test Cases

- Add more story directories under `docs/evidence/`.
- Update the validator in `scripts/validate-commands.sh` when you introduce new conventions.
- Consider adding a `tests/commands/` directory with expected prompt fragments if you want more rigorous prompt regression testing in the future.

Happy testing! Following the commands rigorously is itself the best test that the compliance system works.
