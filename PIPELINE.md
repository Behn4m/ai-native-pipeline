# Pipeline rulebook

The system design repo is the single source of truth. Code repos implement against it and never change it. Every gap found during implementation goes to a human; agents never code around it. Every decision reaches the design before the code merges.

## Roles

| Role | Where | Does |
|---|---|---|
| Product management (human) | Linear, design repo | Scopes, decides findings, gives green light, applies design suggestions, confirms merges. |
| Design session (agent) | Design repo | The only agent that edits design docs. Writes the high-level design. |
| Implementation session (agent, one per code repo) | Code repo | Writes the domain spec, plan and code. Reads design through the `design/` submodule only. Records findings and proposes design changes. |
| Reviewer (independent subagent) | Code repo | Checks the plan (step 5) and the finished code (step 13) against the design. Never saw them being written. |

## Steps

| # | Step | Owner | Input | Output | Gate |
|---|---|---|---|---|---|
| 1 | Domain scope | Human | Need | `prd.md`, Linear project and milestones | |
| 2 | High-level design | Design session | `prd.md` | Design branch, updated design docs, design PR stating the decision | |
| 3 | Spec system design | Implementation session | Design branch | `docs/spec.md` | |
| 4 | Implementation plan | Implementation session | `docs/spec.md` | `docs/detailed-design.md`, `docs/plan.md` | |
| 5 | Verify plan | Reviewer | Spec, plan, design, `prd.md` | `.pipeline/verify-report.md` with deviations | Must pass |
| 6 | Green light | Human | Verify report | Plan `status: approved`, or revise | Human |
| 7 | Build | Implementation session | Approved plan, decided findings | Code on a work branch | Plan approved, no blocking findings |
| 8 | Verify on simulation | Implementation session | Code, acceptance criteria | `.pipeline/test-report.md` | |
| 9 | Verify on real scenario | Human and implementation session | Code, acceptance criteria | `.pipeline/test-report.md` | |
| 10 | Review diff | Human | Diff and reports | Go, or back to step 7 | Human |
| 11 | Findings sync | Implementation session | Findings archive | Design PR suggestions (decided), issues or known issues (open) | |
| 12 | Apply design suggestions | Human | Design PR suggestions | Design branch updated; `/pipeline:spec` rerun | Human |
| 13 | Conformance check | Reviewer | Code, spec, updated design, findings | `.pipeline/conformance-report.md` | Must pass |
| 14 | Commit, push, open PR | Implementation session | Go, conformance pass | Code PR linked to Linear | |
| 15 | Confirm merge | Human | Both PRs | Explicit confirmation | Human |
| 16 | Merge design PR first | Human | Confirmation | Design main updated | |
| 17 | Point submodule at design main, merge code PR | Implementation session | Design main | Code PR squash-merged | |

## Findings

A finding is a gap, contradiction or wrong assumption in the design, found at any step.

### Where findings live

Each code repo has a **findings archive**: a branch `pipeline/findings` that shares no history with the code and is never merged. It is checked out as a git worktree at `.pipeline/findings/`, which code branches ignore. Findings never enter `main` or a code PR; they stay as the record of gaps and decisions.

```
pipeline/findings
└── <project>/
    ├── F-001.md
    └── F-002.md
```

`/pipeline:finding` creates the worktree and the branch if they don't exist, and commits and pushes every change to the archive branch. Nobody switches branches.

### Scope

Every finding is classified when it is raised:

| Scope | Means | Path to the design |
|---|---|---|
| `domain` | Only this domain's behaviour is affected. | Batched. Synced to the design at step 11, before the PR. |
| `cross-domain` | It touches an interface (`DF-`), a shared constraint (`CON-`), a component another domain owns, or another domain's acceptance criteria. | Immediately. Build on the affected task waits until the design is updated, so every domain complies. |

### Lifecycle

| Status | Set by | Means |
|---|---|---|
| `open` | `/pipeline:finding` | Raised, waiting for a human decision. |
| `decided` | Human | Decision written in the finding. |
| `synced` | `/pipeline:findings-sync` | Sent to the design PR as a suggestion, or reported as an issue or known issue. |
| `applied` | `/pipeline:spec` | The decision is on the design branch and in this repo's spec. |
| `closed` | `/pipeline:merge` | The design PR with the decision is merged. |

### Flow

1. The agent raises the finding and pauses the affected task.
2. You decide and write the decision in the finding.
3. **Domain finding:** the build continues and implements the decision. The decision reaches the design at step 11.
4. **Cross-domain finding:** run `/pipeline:findings-sync` now, apply the suggestion on the design PR, rerun `/pipeline:spec`, then continue the build. Other domains are warned at session start that the design moved and rerun their spec.
5. **At step 11**, every decided finding becomes a suggestion on the design PR. Every open finding becomes either a GitHub issue in the design repo or a known issue in the code PR description; you choose per finding.
6. **At step 13**, the reviewer checks that the code matches the updated design and that every decision is in it.

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
| `F-` | Findings archive, `<project>/` | Finding. Cite it as `<repo>#F-001` outside its repo. |

## Rules

- Design docs hold no code and no history. Decisions live in design PR descriptions and comments.
- Interfaces are defined only in `dataflow.md`. A spec that needs a new or changed interface raises a cross-domain finding.
- The `design/` submodule is read-only in code repos. A hook enforces this.
- Code is built only from a plan with `status: approved`, and never past an `open` finding or an unapplied cross-domain decision.
- Every decision reaches the design before the code PR opens.
- The design PR merges before the code PR.
