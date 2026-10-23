---
description: Step 11 of the pipeline. Commit, push and open the code PR linked to Linear, after the human has said go. Run in a code repo.
disable-model-invocation: true
---

Run in a **code repo**, only after the human reviewed the diff and said go.

1. Confirm the human said go in this conversation. If not, stop.
2. Commit the work, including `docs/` and `.pipeline/`. Push the work branch.
3. Open a PR with the repo's PR template. Fill every field: Linear issue, design SHA, AC results from the test reports, approved deviations, findings raised.
4. Link the PR to the Linear issue and project.
5. Report the PR link. Do not merge.
