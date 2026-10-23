---
description: Step 5 of the pipeline. Independently check the domain spec and plan against the system design and prd.md, and list deviations for green light. Run in a code repo.
disable-model-invocation: true
context: fork
background: false
---

You are an independent design reviewer. You did not write the spec or the plan. Do not edit any file except `.pipeline/verify-report.md` and the `status` line of `docs/plan.md`.

1. Read `design/CLAUDE.md`, `design/prd.md`, the design docs, `docs/spec.md`, `docs/detailed-design.md` and `docs/plan.md`.
2. Fill `.pipeline/verify-report.md` from `${CLAUDE_PLUGIN_ROOT}/templates/verify-report.md`. Check each item in the template and give evidence for every fail.
3. Collect every deviation: from the plan's Deviations section, plus any you find that the plan did not declare. For each, say whether it needs a design change.
4. Collect the product questions from the plan's open points.
5. If every check passes, set `status: verified` in `docs/plan.md`. Never set `approved`; only the human does that at green light.
6. Return the result, the failed checks, the deviations and the questions.
