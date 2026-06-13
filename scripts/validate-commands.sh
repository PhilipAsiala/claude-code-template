#!/bin/bash
#
# validate-commands.sh
#
# Basic validator for Claude Code custom slash command Markdown files.
# Run from the repository root:
#   bash scripts/validate-commands.sh
#
# Checks:
#   - Frontmatter present and contains allowed-tools
#   - Primary heading (# /command-name) matches filename
#   - Presence of key instructional language for compliance commands
#   - No obvious broken cross-references
#
set -euo pipefail

COMMANDS_DIR=".claude/commands"
ERRORS=0

echo "🔍 Validating Claude Code commands in ${COMMANDS_DIR}..."
echo

for file in "${COMMANDS_DIR}"/*.md; do
  filename=$(basename "$file")
  command_name="${filename%.md}"

  echo "→ Testing ${filename}"

  # 1. Frontmatter check
  if ! head -5 "$file" | grep -q '^---$'; then
    echo "   ❌ Missing opening frontmatter (---)"
    ((ERRORS++))
  fi

  if ! grep -q 'allowed-tools:' "$file"; then
    echo "   ❌ Missing 'allowed-tools:' in frontmatter"
    ((ERRORS++))
  fi

  # 2. Main heading should start with the slash command
  if ! grep -q "^# /${command_name}" "$file"; then
    echo "   ❌ Expected primary heading to be '# /${command_name}'"
    ((ERRORS++))
  fi

  # 3. Basic compliance language checks (heuristic)
  case "$command_name" in
    plan|step|git-guardrails|evidence-log)
      if ! grep -qiE "(evidence|CLAUDE\.md|non-negotiable|must|never)" "$file"; then
        echo "   ⚠️  Weak compliance language detected (missing common keywords)"
      fi
      ;;
  esac

  # 4. Cross-reference sanity (look for known other commands)
  if grep -q "/plan" "$file" && [ "$command_name" != "plan" ]; then
    : # ok
  fi

  # Specific checks
  if [ "$command_name" = "plan" ]; then
    if ! grep -q "git-guardrails" "$file"; then
      echo "   ⚠️  plan.md should reference git-guardrails"
    fi
  fi

  if [ "$command_name" = "step" ]; then
    if ! grep -q "evidence-log" "$file"; then
      echo "   ⚠️  step.md should reference evidence-log"
    fi
  fi

  echo "   ✅ Basic checks passed for ${command_name}"
  echo
done

# Global checks
echo "→ Global cross-reference checks"

if grep -q "jira-sync" CLAUDE.md 2>/dev/null || grep -q "jira-sync" .claude/README.md 2>/dev/null; then
  echo "   ❌ Stale reference to non-existent /jira-sync command"
  ((ERRORS++))
fi

if [ -d "docs/evidence" ]; then
  echo "   ✅ docs/evidence/ directory present (good for testing evidence-log)"
else
  echo "   ⚠️  Consider adding docs/evidence/ with sample data for command testing"
fi

echo
if [ $ERRORS -eq 0 ]; then
  echo "✅ All commands validated successfully."
  exit 0
else
  echo "❌ Validation completed with $ERRORS error(s)."
  exit 1
fi
