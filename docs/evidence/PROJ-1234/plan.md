## Plan for PROJ-1234: Add audit logging to user service

**Compliance Notes**
- This change touches authentication-related code and user PII (user IDs + action metadata).
- Must produce:
  - Security review decision record
  - Evidence that no PII is logged in plaintext
  - Automated test coverage for the new logging path
  - Jira comment with links to evidence

**Implementation Steps**

1. **Add audit log model and interface**
   - Details: Define minimal AuditLog struct and interface in internal/audit.
   - Verification: `go test ./internal/audit/...` passes with table tests.
   - Evidence to capture: test output + the new source file.

2. **Implement logging middleware / hook in user service**
   - Details: Instrument login, profile update, and permission change paths.
   - Verification: Manual + automated tests exercise all three paths; no secrets in logs.
   - Evidence to capture: test results, sample log lines (redacted), security decision record.

3. **Add configuration and feature flag**
   - Details: Make audit logging controllable via config (default off in dev).
   - Verification: Flag works in both states.
   - Evidence to capture: config change diff + test demonstrating flag.

4. **Update OpenAPI / docs and add security decision record**
   - Details: Document new log fields.
   - Verification: Docs build, ADR reviewed.
   - Evidence to capture: ADR in decisions/ + PR description reference.

**Evidence Checklist**
- [x] Approved plan (this file)
- [ ] Step 1 evidence (step-01.md + test output)
- [ ] Step 2 evidence (including security decision record)
- [ ] Step 3 + 4 evidence
- [ ] Final summary
- [ ] Jira story updated with evidence links

**Next Action**
Run `/git-guardrails PROJ-1234 "add-audit-logging"` (if not done), then `/step 1`.
