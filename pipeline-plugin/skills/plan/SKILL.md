---
description: Step 4 of the pipeline. Write docs/detailed-design.md and docs/plan.md from the domain spec. No code. Run in a code repo.
argument-hint: <linear-issue>
disable-model-invocation: true
---

Run in a **code repo**. No code in this step.

Linear issue: $ARGUMENTS

1. Read `docs/spec.md` and every design doc it cites. Confirm `design_sha` in the spec matches `git -C design rev-parse HEAD`; if not, stop and ask whether to rerun `/pipeline:spec`.
2. Fill `docs/detailed-design.md` from `${CLAUDE_PLUGIN_ROOT}/templates/detailed-design.md`.
3. Fill `docs/plan.md` from `${CLAUDE_PLUGIN_ROOT}/templates/plan.md` with `status: draft`:
   - Every spec item maps to a module and task.
   - Every AC maps to a test.
   - Every place the plan narrows or departs from the spec is listed under Deviations.
   - Open points are split into design questions and product questions.
   - Tasks are small enough to build and test one at a time.
4. If a design question blocks the plan, run `/pipeline:finding` and stop.
5. Report the plan summary and tell the human to run `/pipeline:verify-plan`.
