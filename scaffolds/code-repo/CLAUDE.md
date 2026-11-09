# CLAUDE.md: <repo name>

@design/CLAUDE.md

## Subsystem

- **Subsystem:** <frontend / backend / app / hw / ...>
- **Owned components:** <CMP IDs from design/components.md>
- **Linear project:** <link>

## Rules

- `design/` is the system design submodule. It is read-only; a hook blocks edits.
- Never define or change an interface. Interfaces live in `design/dataflow.md`. If one is missing or wrong, run `/pipeline:finding`.
- Never code around a gap, contradiction or wrong assumption. Run `/pipeline:finding` and pause the affected task.
- Work only on `work/<project>`. Skills commit and push there; never push to main. Main changes only at step 17 (`/pipeline:merge`, squash).
- Build only from a plan with `status: approved` in `docs/plan.md`, never past an `open` finding, and never past a cross-system decision that isn't applied to the system design yet.
- Pipeline documents:
  - `docs/spec.md`: subsystem spec (step 3)
  - `docs/subsystem-design.md`, `docs/plan.md`: implementation plan (step 4)
  - `.pipeline/`: verify report, test reports, conformance report
  - `.pipeline/findings/`: findings archive, a worktree of the `pipeline/findings` branch. Ignored by code branches; commit there with `git -C .pipeline/findings`. Attached automatically at session start.
- Use the pipeline skills for each step (`/pipeline:spec`, `/pipeline:plan`, ...). See the kit COOKBOOK for the order.

## Build and test

- **Build:** <command>
- **Unit tests:** <command>
- **Lint:** <command>
- **Simulation:** <command or procedure>
