---
description: Steps 16–17 of the pipeline. After the design PR is merged, point the design submodule at design main, squash-merge the code PR and close the project's findings. Run in a code repo.
disable-model-invocation: true
---

Run in a **code repo**, only after the human confirmed the merge (step 15).

1. Confirm the design PR is merged into design main. If not, stop: the design PR merges first.
2. Run `git -C design fetch` and check out design main in the submodule.
3. Check that design main contains everything at the `design_sha` in `docs/spec.md`. If design main changed anything this repo depends on, stop and report it.
4. Commit the submodule update on the work branch and push.
5. Ask the human for explicit confirmation, then squash-merge the code PR.
6. In the findings archive, set every `applied` finding of this project to `closed`, then commit and push (`git -C .pipeline/findings`). Leave `synced` open findings as they are; their issue or known issue tracks them.
7. Report the merge and remind the human to close the Linear issue.
