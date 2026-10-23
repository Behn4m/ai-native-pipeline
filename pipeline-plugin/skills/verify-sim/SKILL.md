---
description: Step 8 of the pipeline. Run the acceptance criteria in simulation, classify every failure, and write the test report. Run in a code repo.
disable-model-invocation: true
---

Run in a **code repo**.

1. Take the ACs marked sim or both from `docs/spec.md` and their tests from the plan's Test mapping.
2. Run the simulation from CLAUDE.md for each.
3. Fill `.pipeline/test-report.md` from `${CLAUDE_PLUGIN_ROOT}/templates/test-report.md` with `level: sim`. Increment `attempt` if a sim report for this commit's work already exists.
4. Classify every failure:
   - **implementation**: go back to `/pipeline:build` for that task.
   - **design**: run `/pipeline:finding` and stop.
   - **environment**: fix the setup and rerun.
5. If the same AC fails on attempt 3, run `/pipeline:finding` and stop.
6. When all pass, report and tell the human to run `/pipeline:verify-real`.
