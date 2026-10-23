# CLAUDE.md: <repo name>

@design/CLAUDE.md

## Domain

- **Domain:** <frontend / backend / app / hw / ...>
- **Owned components:** <CMP IDs from design/components.md>
- **Linear project:** <link>

## Rules

- `design/` is the system design submodule. It is read-only; a hook blocks edits.
- Never define or change an interface. Interfaces live in `design/dataflow.md`. If one is missing or wrong, run `/pipeline:finding` and stop.
- Never code around a gap, contradiction or wrong assumption. Run `/pipeline:finding` and stop.
- Build only from a plan with `status: approved` in `docs/plan.md`.
- Pipeline documents:
  - `docs/spec.md`: domain spec (step 3)
  - `docs/detailed-design.md`, `docs/plan.md`: implementation plan (step 4)
  - `.pipeline/`: verify report, findings, test reports
- Use the pipeline skills for each step (`/pipeline:spec`, `/pipeline:plan`, ...). See the kit README for the list.

## Build and test

- **Build:** <command>
- **Unit tests:** <command>
- **Lint:** <command>
- **Simulation:** <command or procedure>
