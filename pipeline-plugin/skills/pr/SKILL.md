---
description: Step 14 of the pipeline. Open the code PR linked to Linear, after the conformance check passed and the human said go. Run in a code repo.
disable-model-invocation: true
---

Run in a **code repo**.

1. Confirm the human said go in this conversation and `.pipeline/conformance-report.md` has `result: pass`, and no code changed since that check: `git diff --quiet <code_commit> HEAD -- . ':!.pipeline'` (`code_commit` from the report). If either fails, stop: rerun `/pipeline:verify-design`.
2. Commit any remaining pipeline documents (the conformance report) and push `work/<project>`. The findings archive is ignored and stays on its own branch.
3. Run `${CLAUDE_PLUGIN_ROOT}/scripts/attach-findings.sh`. If it reports `unreachable`, stop. Then open a PR with the repo's PR template. Fill every field:
   - Linear issue, design branch and SHA, AC results from the test reports, approved deviations.
   - **Findings**: every finding of this project with its decision and link (`synced_to`).
   - **Known issues**: every finding whose `synced_to` is `known issue in code PR`, with its summary and impact.
4. Link the PR to the Linear issue and project.
5. Report readiness on the design PR. Find it as findings-sync does: `git -C design remote get-url origin`, then `gh pr list -R <design-repo> --head <design_branch> --json number,url`. Post the comment `[<repo>] code PR ready: <code PR URL>, conformance pass at design <design_sha short>`. Tell the human to tick this subsystem's box under "Affected subsystems".
6. Report the PR link. Do not merge.
