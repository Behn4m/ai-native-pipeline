---
description: Step 14 of the pipeline. Commit, push and open the code PR linked to Linear, after the conformance check passed and the human said go. Run in a code repo.
disable-model-invocation: true
---

Run in a **code repo**.

1. Confirm the human said go in this conversation and `.pipeline/conformance-report.md` has `result: pass` for the current code. If not, stop.
2. Commit the work, including `docs/` and `.pipeline/` (the findings archive is ignored and stays on its own branch). Push the work branch.
3. Open a PR with the repo's PR template. Fill every field:
   - Linear issue, design branch and SHA, AC results from the test reports, approved deviations.
   - **Findings**: every finding of this project with its decision and link (`synced_to`).
   - **Known issues**: every finding whose `synced_to` is `known issue in code PR`, with its summary and impact.
4. Link the PR to the Linear issue and project.
5. Report the PR link. Do not merge.
