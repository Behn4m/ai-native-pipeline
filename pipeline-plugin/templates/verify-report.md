---
result: pass / fail
plan: docs/plan.md
design_sha: <commit>
---

# Verify report

## Checks

| Check | Result | Notes |
|---|---|---|
| Every spec item maps to the plan | pass / fail | |
| Every cited ID exists in the system design | pass / fail | |
| No interface defined outside dataflow.md | pass / fail | |
| Every AC in the spec has a test | pass / fail | |
| Plan respects every applicable CON | pass / fail | |
| Plan matches this project's `prd.md` change | pass / fail | |
| Regression ACs without an automated test | none / listed | Warning only: each is listed under Questions for green light |

## Deviations for approval

| Deviation | Reason | Impact | Design change needed |
|---|---|---|---|
| <deviation> | <reason> | <impact> | yes / no |

## Questions for green light

- <product question>
