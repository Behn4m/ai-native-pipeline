---
result: pass / fail
design_branch: <design/project>
design_sha: <commit checked against>
code_commit: <commit>
---

# Conformance report

## Checks

| Check | Result | Notes |
|---|---|---|
| Spec `design_sha` is the current design branch head | pass / fail | |
| Every decided finding is on the design branch (status `applied`) | pass / fail | |
| Every decided finding is implemented in the code | pass / fail | |
| Every DF this subsystem produces or consumes matches `dataflow.md` | pass / fail | |
| Every applicable CON is met | pass / fail | |
| Every AC in the spec has a passing test result | pass / fail | |
| No behaviour in the code lacks a design or finding basis | pass / fail | |

## Mismatches

| Where | Design says | Code does | Next |
|---|---|---|---|
| <file / ID> | <text> | <text> | re-implement / finding |

## Open findings going into the PR

| Finding | Reported as |
|---|---|
| F-xxx | design repo issue #n / known issue |
