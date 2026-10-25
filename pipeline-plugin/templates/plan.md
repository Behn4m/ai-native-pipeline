---
status: draft
linear_issue: <link>
design_sha: <design submodule commit>
---

# Implementation plan: <work item>

`status` moves draft → verified (step 5) → approved (step 6, human only). Build starts only at approved.

## Approach

<Key choices in one paragraph.>

## Mapping

| Spec item | Module / file | Task |
|---|---|---|
| UF / DF / CON ID | <where> | T1 |

## Test mapping

| AC ID | Test type | Location |
|---|---|---|
| AC-xxx | unit / sim / real | <path or procedure> |

## Dependencies

- <other subsystem's DF ID that must be live, new libraries>

## Deviations

Places this plan narrows or departs from the spec. Each one needs approval at green light.

| What | Why | Design change needed |
|---|---|---|
| <deviation> | <reason> | yes / no |

## Open points

- **Design questions** (become findings): <question>
- **Product questions** (for green light): <question>

## Risks

- <risk, what would reveal it>

## Tasks

1. T1: <small step that builds and tests on its own>
