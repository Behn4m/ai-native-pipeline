---
description: Step 9 of the pipeline. Guide the human through the acceptance criteria on the real product environment and write the test report. Run in a code repo.
disable-model-invocation: true
---

Run in a **code repo**. The human runs the hardware or real environment; you prepare, record and classify.

1. Take the ACs marked real or both from `docs/spec.md`.
2. Give the human a numbered checklist: for each AC, setup, action and the exact observation that means pass.
3. Wait for the human's results. Ask for logs or measurements where the AC needs them.
4. Fill `.pipeline/test-report.md` from `${CLAUDE_PLUGIN_ROOT}/templates/test-report.md` with `level: real`.
5. Classify failures the same way as in simulation. Design failures go to `/pipeline:finding` (a test finding).
6. When all pass, summarise results and the diff for the human's review (step 10).
