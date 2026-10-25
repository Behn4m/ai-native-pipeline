# CLAUDE.md: <repo name>

@design/CLAUDE.md

## Domain

- **Domain:** <frontend / backend / app / hw / ...>
- **Owned components:** <CMP IDs from design/components.md>
- **Linear project:** <link>

## Rules

- `design/` is the system design submodule. It is read-only; a hook blocks edits.
- Never define or change an interface. Interfaces live in `design/dataflow.md`. If one is missing or wrong, run `/pipeline:finding`.
- Never code around a gap, contradiction or wrong assumption. Run `/pipeline:finding` and pause the affected task.
- Build only from a plan with `status: approved` in `docs/plan.md`, never past an `open` finding, and never past a cross-domain decision that isn't applied to the design yet.
- Pipeline documents:
  - `docs/spec.md`: domain spec (step 3)
  - `docs/detailed-design.md`, `docs/plan.md`: implementation plan (step 4)
  - `.pipeline/`: verify report, test reports, conformance report
  - `.pipeline/findings/`: findings archive, a worktree of the `pipeline/findings` branch. Ignored by code branches; commit there with `git -C .pipeline/findings`.
- Use the pipeline skills for each step (`/pipeline:spec`, `/pipeline:plan`, ...). See the kit COOKBOOK for the order.

## Build and test

- **Build:** <command>
- **Unit tests:** <command>
- **Lint:** <command>
- **Simulation:** <command or procedure>
