---
description: Step 8 of the pipeline. Run the acceptance criteria in simulation, classify every failure, and write the test report. Run in a code repo.
disable-model-invocation: true
---

Run in a **code repo**.

1. The working tree must be clean (everything committed) so the report names a real commit. If not, stop and tell the human to finish `/pipeline:build`.
2. Take the project ACs marked sim or both from `docs/spec.md` and their tests from the plan's Test mapping.
3. Run the simulation from CLAUDE.md for each, and run the full automated test suite for the regression ACs.
4. Fill `.pipeline/test-report.md` from `${CLAUDE_PLUGIN_ROOT}/templates/test-report.md` with `level: sim` and `commit:` = `git rev-parse HEAD`. Increment `attempt` if a sim report for this commit's work already exists.
5. Commit `.pipeline/test-report.md` (`test: sim attempt <n>`) and push. Commit every attempt, passing or not.
6. Classify every failure:
   - **implementation**: go back to `/pipeline:build` for that task.
   - **design**: run `/pipeline:finding` and stop.
   - **environment**: fix the setup and rerun.
7. A failing regression test is classified the same way. If the same AC fails on attempt 3, run `/pipeline:finding` and stop.
8. When all pass, report and tell the human to run `/pipeline:verify-real`.
