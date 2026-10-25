# Cookbook

Recipes for running work through the pipeline. Setup is in the [README](README.md#initialize-repos); rules are in [PIPELINE.md](PIPELINE.md).

## Run a feature through the pipeline

| # | Who | Where | Do |
|---|---|---|---|
| 1 | You | Linear + design repo | Create the project from `linear/project-template.md`. Fill `prd.md` on branch `design/<project>`, including `AC-` IDs. |
| 2 | Design session | Design repo | `/pipeline:design <project>` → design PR opened |
| 3 | Code session | Each affected code repo | `/pipeline:spec <domain> design/<project>` → `docs/spec.md` |
| 4 | Code session | Code repo | `/pipeline:plan <linear-issue>` → `docs/plan.md`, `docs/detailed-design.md` |
| 5 | Reviewer subagent | Code repo | `/pipeline:verify-plan` → `.pipeline/verify-report.md` |
| 6 | You | | Read the report. To approve, set `status: approved` in `plan.md`. To revise, go back to step 4. |
| 7 | Code session | Code repo | `/pipeline:build` |
| 8 | Code session | Code repo | `/pipeline:verify-sim` |
| 9 | You + session | Real environment | `/pipeline:verify-real` |
| 10 | You | | Review the diff. Say "go" or send it back to build. |
| 11 | Code session | Code repo | `/pipeline:pr` |
| 12 | You | | Confirm the merge. |
| 13 | You / design session | Design repo | Merge the design PR. |
| 14 | Code session | Code repo | `/pipeline:merge` |

## Handle a finding

1. The agent stops and writes `.pipeline/findings/F-xxx.md`.
2. You decide, and write the decision in the finding.
3. Run `/pipeline:design <project>` in the design repo. This records the decision in the design PR.
4. Back in the code repo, rerun `/pipeline:spec <domain> design/<project>`. It fetches the updated branch.

## Handle a test failure

The test report classifies each failure:

- **implementation** → `/pipeline:build`
- **design** → becomes a finding (see above)
- **environment** → fix the setup and rerun.

On the 3rd failure of the same AC, it becomes a finding.

## Change the pipeline

1. Edit the skill, template or hook in this repo.
2. Bump `version` in `pipeline-plugin/.claude-plugin/plugin.json`.
3. Open a PR and merge it.
4. Everyone runs `/plugin marketplace update done-ai-native`.

## Quick rules

- Never edit `design/` from a code repo. A hook blocks it.
- Only you set `status: approved`.
- The design PR merges before the code PR.
- Cite IDs, don't copy content.
