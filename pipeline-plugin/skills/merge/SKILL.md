---
description: Step 17 of the pipeline, in each code repo after the design PR is merged (step 16): point the design submodule at design main, squash-merge the code PR and close the project's findings. Run in a code repo.
disable-model-invocation: true
---

Run in a **code repo**, only after the human confirmed the merge (step 15) and merged the design PR (step 16).

1. Confirm the design PR is merged into design main. If not, stop: the design PR merges first, once every affected subsystem's code PR is open.
2. Run `git -C design fetch` and check out design main in the submodule.
3. Check that design main has the design branch content this repo was built against. Squash merges rewrite commits, so compare content, not ancestry. With `<sha>` = `design_sha` from `docs/spec.md`: `base=$(git -C design merge-base <sha> origin/main)`, `files=$(git -C design diff --name-only $base <sha>)`, then `git -C design diff --quiet <sha> origin/main -- $files`. If it reports differences, stop and show `git -C design diff --stat <sha> origin/main -- $files`: either the spec is stale or design main changed files this project touched since. The human decides whether to rerun `/pipeline:spec` and `/pipeline:verify-design`.
4. Commit the submodule update on the work branch and push.
5. Ask the human for explicit confirmation, then squash-merge the code PR.
6. Run `${CLAUDE_PLUGIN_ROOT}/scripts/attach-findings.sh`. If it reports `unreachable`, stop before closing findings. In the findings archive, set every `applied` finding of this project to `closed`, then commit and push (`git -C .pipeline/findings`). Leave `synced` open findings as they are; their issue or known issue tracks them.
7. Report the merge and remind the human to close the Linear issue.
