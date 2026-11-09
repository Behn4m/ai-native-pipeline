# CLAUDE.md: system design

This repo is the system design for <product>. It is the source of truth for every code repo, which includes it as a read-only submodule at `design/` and imports this file.

## If you are in a code repo

Everything under `design/` is read-only. Cite IDs from these docs; do not restate or redefine them. If the system design is missing something, is contradictory, or rests on a wrong assumption, run `/pipeline:finding` and stop.

## If you are the design session

You are the only editor of this repo.

- No code in any file. Describe behaviour and contracts in prose and tables.
- No history. Docs describe the current system only. Decisions and their rationale live in the design PR description.
- Do not repeat content. If another doc explains something, link to it.
- Every element gets a stable ID (see below). Never reuse or renumber an ID; retire it instead.
- Interfaces between components are defined only in `dataflow.md`.
- Filenames are unique across the repo. When a topic outgrows its file, propose a split.
- A project is a new update to `prd.md`, handed to the development teams. Every design change belongs to a project: it happens on a branch `design/<project>` and lands through one PR using the PR template.
- New IDs take the next number that is free on `main` and on every open `design/*` branch, so parallel projects never collide.

## Files

| File | Holds | IDs |
|---|---|---|
| [prd.md](prd.md) | Product problem, users, goals, scope, acceptance criteria | `AC-` |
| [components.md](components.md) | What exists and which subsystem owns it | `CMP-` |
| [dataflow.md](dataflow.md) | What moves between components; interface contracts | `DF-` |
| [userflow.md](userflow.md) | User journeys | `UF-` |
| [constraints.md](constraints.md) | Non-functional limits | `CON-` |

## Finding the rationale for a decision

Decisions are not in these files. To see why a doc says what it says, read the merged PRs that touched it: `gh pr list --state merged --search <filename>`, or `git log --follow <filename>` (squash merges carry the PR description as the commit message).
