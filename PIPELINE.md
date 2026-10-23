# Pipeline rulebook

The system design repo is the single source of truth. Code repos implement against it and never change it. Every gap found during implementation goes back to a human; agents never code around it.

## Roles

| Role | Where | Does |
|---|---|---|
| Product management (human) | Linear, design repo `prd.md` | Scopes, decides findings, gives green light, confirms merges. |
| Design session (agent) | Design repo | The only editor of design docs. Writes the high-level design. |
| Implementation session (agent, one per code repo) | Code repo | Writes the domain spec, plan and code. Reads design through the `design/` submodule only. |

## Steps

| # | Step | Owner | Input | Output | Gate |
|---|---|---|---|---|---|
| 1 | Domain scope | Human | Need | `prd.md`, Linear project and milestones | |
| 2 | High-level design | Design session | `prd.md` | Design branch, updated design docs, design PR stating the decision | |
| 3 | Spec system design | Implementation session | Design branch | `docs/spec.md` | |
| 4 | Implementation plan | Implementation session | `docs/spec.md` | `docs/detailed-design.md`, `docs/plan.md` | |
| 5 | Verify | Independent reviewer subagent | Spec, plan, design, `prd.md` | `.pipeline/verify-report.md` with deviations | Must pass |
| 6 | Green light | Human | Verify report | Plan `status: approved`, or revise | Human |
| 7 | Build | Implementation session | Approved plan | Code on a work branch | Plan approved |
| 8 | Verify on simulation | Implementation session | Code, acceptance criteria | `.pipeline/test-report.md` | |
| 9 | Verify on real scenario | Human and implementation session | Code, acceptance criteria | `.pipeline/test-report.md` | |
| 10 | Review diff | Human | Diff and reports | Go, or back to step 7 | Human |
| 11 | Commit, push, open PR | Implementation session | Go | Code PR linked to Linear | |
| 12 | Confirm merge | Human | Both PRs | Explicit confirmation | Human |
| 13 | Merge design PR first | Human or design session | Confirmation | Design main updated | |
| 14 | Point submodule at design main, merge code PR | Implementation session | Design main | Code PR squash-merged | |

## Findings

A finding is a gap, contradiction or wrong assumption in the design, found at any step. The agent writes it with `/pipeline:finding` and stops. The human decides. The decision is recorded on the design branch through a design PR, and the implementation session re-pulls the submodule and returns to step 3.

## Test failures

At steps 8 and 9 every failure is classified:

- **Implementation**: back to step 7.
- **Design**: raise a finding.
- **Environment**: fix the setup, rerun.

After 3 failed attempts on the same acceptance criterion, stop and raise a finding.

## IDs

Every design element has a stable ID. Specs, plans, tests and PRs cite IDs instead of restating content.

| Prefix | Defined in | Meaning |
|---|---|---|
| `AC-` | `prd.md` | Acceptance criterion |
| `CMP-` | `components.md` | Component |
| `DF-` | `dataflow.md` | Interface between components |
| `UF-` | `userflow.md` | User flow |
| `CON-` | `constraints.md` | Constraint |
| `F-` | Code repo `.pipeline/findings/` | Finding |

## Rules

- Design docs hold no code and no history. Decisions live in design PR descriptions.
- Interfaces are defined only in `dataflow.md`. A spec that needs a new or changed interface raises a finding.
- The `design/` submodule is read-only in code repos. A hook enforces this.
- Code is built only from a plan with `status: approved`.
- The design PR merges before the code PR.
