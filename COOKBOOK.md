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
| 11 | Code session | Code repo | `/pipeline:findings-sync` → decided findings become design PR suggestions; you choose issue or known issue for open ones |
| 12 | You | Design PR on GitHub | Commit the suggestions (edit them if needed). Then rerun `/pipeline:spec <domain> design/<project>` in the code repo. |
| 13 | Reviewer subagent | Code repo | `/pipeline:verify-design` → `.pipeline/conformance-report.md`. Fail: back to step 7. |
| 14 | Code session | Code repo | `/pipeline:pr` |
| 15 | You | | Confirm the merge. |
| 16 | You | Design repo | Merge the design PR. |
| 17 | Code session | Code repo | `/pipeline:merge` |

## Handle a finding

The agent raises it with `/pipeline:finding`, writes it to the findings archive (`.pipeline/findings/<project>/F-xxx.md`, on the `pipeline/findings` branch), pauses the affected task and asks you to choose an option. Answer in the terminal.

**Domain finding** (only this domain is affected):

1. You choose. The agent records the decision and continues the build with it.
2. The decision reaches the design at step 11, together with the others.

**Cross-domain finding** (touches an interface, a shared constraint or another domain's component):

1. You choose. The agent records the decision; the affected task stays paused.
2. Run `/pipeline:findings-sync F-xxx`. It posts the design change on the design PR.
3. Commit the suggestion on GitHub.
4. Rerun `/pipeline:spec <domain> design/<project>`. The finding becomes `applied` and the build continues.
5. Other domains see "design changed, rerun `/pipeline:spec`" when their next session starts.

**Undecided at the end** (step 11): you choose per finding between a GitHub issue in the design repo or a known issue in the code PR description.

## Handle a test failure

The test report classifies each failure:

- **implementation** → `/pipeline:build`
- **design** → becomes a finding (see above)
- **environment** → fix the setup and rerun.

On the 3rd failure of the same AC, it becomes a finding.

## Look up why something was decided

- **The design says X:** the merged design PR that changed that file holds the decision, and its comments hold the findings behind it.
- **A finding's full history:** the `pipeline/findings` branch of the code repo that raised it, under `<project>/`.

## Change the pipeline

1. Edit the skill, template or hook in this repo.
2. Bump `version` in `pipeline-plugin/.claude-plugin/plugin.json`.
3. Open a PR and merge it.
4. Everyone runs `/plugin marketplace update done-ai-native`.

## Quick rules

- Never edit `design/` from a code repo. A hook blocks it.
- Only you set `status: approved` on a plan and decide findings.
- Cross-domain decisions reach the design before the build continues; domain decisions reach it before the PR.
- The design PR merges before the code PR.
- Cite IDs, don't copy content.
