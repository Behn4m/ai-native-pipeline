# Changelog

Release history of the pipeline. Versions match `version` in [pipeline-plugin/.claude-plugin/plugin.json](pipeline-plugin/.claude-plugin/plugin.json).

## Unreleased

- `prd.md` describes the product; each project is a new update to it, handed to the development teams. Terms (product, project, milestone) defined in [PIPELINE.md](PIPELINE.md#terms). Milestones move to the Linear project and the design PR. Specs split project ACs (must pass in sim and real) from regression ACs (automated tests stay green). New IDs are allocated across main and all open design branches.
- Terminology: "System design" for the design repo, "Subsystem design" and "Subsystem spec" for code repos. `docs/detailed-design.md` is now `docs/subsystem-design.md`.
- Diagram updated to the 17 steps.
- Findings archive is attached automatically (new `attach-findings.sh`, run at session start and by every skill that reads findings), so fresh and shallow clones see open findings; skills stop if the archive can't be reached.
- Design PR merges once per project, after every affected subsystem's code PR is open with a passing conformance check; `/pipeline:pr` reports readiness on the design PR, `/pipeline:merge` checks design main by content (squash-safe), and the session-start hook reports a merged/deleted design branch.
- Code repos work on `work/<project>` from step 3; skills commit and push their outputs there (build after every task), reports record real commits, and step 14 only opens the PR.
- Added this changelog.

## 0.2.1 — 2026-10-25

- Renamed "domain" to "subsystem"; finding scopes are `local` and `cross-system`.

## 0.2.0 — 2026-10-24

- Findings archive on a `pipeline/findings` branch per code repo.
- New `/pipeline:findings-sync` and `/pipeline:verify-design` (conformance check).
- SessionStart hook warns about design changes and pending findings.
- Steps renumbered to 17.

## 0.1.1 — 2026-10-24

- `/pipeline:spec` takes the design branch and records it in the spec.

## 0.1.0 — 2026-10-23

- First release: rulebook, diagram, scaffolds, plugin and Linear templates.
