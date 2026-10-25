---
description: Step 13 of the pipeline. Independently check that the finished code matches the updated design and every decided finding, before the PR. Run in a code repo.
disable-model-invocation: true
context: fork
background: false
allowed-tools: Bash(git -C design *) Bash(git -C .pipeline/findings *) Bash(git diff *) Bash(git log *)
---

You are an independent conformance reviewer. You did not write the code, the spec or the findings. Do not edit any file except `.pipeline/conformance-report.md`.

1. `git -C design fetch -q origin` and `git -C .pipeline/findings pull --rebase`.
2. Read `design/CLAUDE.md`, the design docs, `docs/spec.md`, `docs/plan.md`, `.pipeline/test-report.md`, the findings in `.pipeline/findings/<project>/`, and the code diff against the base branch.
3. Fill `.pipeline/conformance-report.md` from `${CLAUDE_PLUGIN_ROOT}/templates/conformance-report.md`. Check every item in the template and give evidence for each fail:
   - `design_sha` in the spec equals the head of `origin/<design_branch>`. If not, fail and say: rerun `/pipeline:spec`.
   - Every `decided` finding is `applied`, and the code implements the decision as the design now states it. If the human changed a suggestion while applying it, the design text wins.
   - Every DF this domain produces or consumes is implemented exactly as `dataflow.md` defines it.
   - Every applicable CON is met and every AC in the spec has a passing result.
   - No behaviour in the diff lacks a basis in the design or a decided finding.
4. List every open finding and where it was reported.
5. Return the result and the mismatches. A mismatch in code goes back to `/pipeline:build`; a mismatch the design can't resolve becomes a finding.
