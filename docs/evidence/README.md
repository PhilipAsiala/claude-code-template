# Evidence Convention

This directory contains the audit evidence packages for stories.

## Layout

```
docs/evidence/
└── PROJ-1234/               # One directory per Jira story
    ├── plan.md              # The approved implementation plan
    ├── step-01.md
    ├── step-02.md
    ├── test-results/
    ├── decisions/
    └── final-summary.md
```

## Why committed evidence?

- Auditors and reviewers can reconstruct exactly what was done.
- Evidence is versioned together with the code changes.
- `/evidence-log`, `/step`, and `/plan` commands are designed to create and maintain these files.

## Usage with the commands

- `/plan` will produce the initial checklist and can write `plan.md` here.
- `/step N` should append a `step-XX.md` file (or update existing) with real output.
- `/evidence-log show PROJ-1234` should read from this directory.
- `/evidence-log append ...` writes structured evidence.

## Sample Data

The `PROJ-1234/` directory contains example files generated using the template commands. Use them to:

- Understand the expected quality and format of evidence.
- Test that `/evidence-log` and `/step` can locate and manipulate the right files.
- Onboard new team members.

**Never** delete or alter real evidence directories without a Jira-linked reason and approval.
