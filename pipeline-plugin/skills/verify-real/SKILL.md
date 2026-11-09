---
description: Step 9 of the pipeline. Guide the human through the acceptance criteria on the real product environment and write the test report. Run in a code repo.
disable-model-invocation: true
---

Run in a **code repo**. The human runs the hardware or real environment; you prepare, record and classify.

1. The working tree must be clean (everything committed) so the report names a real commit. If not, stop and tell the human to finish `/pipeline:build`.
2. Take the ACs marked real or both from `docs/spec.md`.
3. Give the human a numbered checklist: for each AC, setup, action and the exact observation that means pass.
4. Wait for the human's results. Ask for logs or measurements where the AC needs them.
5. Fill `.pipeline/test-report.md` from `${CLAUDE_PLUGIN_ROOT}/templates/test-report.md` with `level: real` and `commit:` = `git rev-parse HEAD`.
6. Commit `.pipeline/test-report.md` (`test: real attempt <n>`) and push. Commit every attempt, passing or not.
7. Classify failures the same way as in simulation. Design failures go to `/pipeline:finding` (a test finding).
8. When all pass, summarise results and the diff for the human's review (step 10).
