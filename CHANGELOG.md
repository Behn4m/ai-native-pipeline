# Changelog

Release history of the pipeline. Versions match `version` in [pipeline-plugin/.claude-plugin/plugin.json](pipeline-plugin/.claude-plugin/plugin.json).

## Unreleased

- Terminology: "System design" for the design repo, "Subsystem design" and "Subsystem spec" for code repos. `docs/detailed-design.md` is now `docs/subsystem-design.md`.
- Diagram updated to the 17 steps.
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
