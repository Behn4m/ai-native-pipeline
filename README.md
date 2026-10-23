# Done.ai.native

Kit for the AI-native development pipeline: one system design repo as the base for every code repo, with one agent session per repo. The flow is in [diagrams/ai-native-development-pipeline.drawio](diagrams/ai-native-development-pipeline.drawio) and the rules are in [PIPELINE.md](PIPELINE.md).

## Contents

| Path | Purpose |
|---|---|
| `PIPELINE.md` | Rulebook: roles, steps, gates, ID conventions. Read once before joining a project. |
| `diagrams/` | Pipeline diagram (draw.io). |
| `scaffolds/design-repo/` | Starting files for a new system design repo: `CLAUDE.md`, design doc templates, PR template (decision record). |
| `scaffolds/code-repo/` | Starting files for each code repo: `CLAUDE.md`, PR template, plugin settings. |
| `pipeline-plugin/` | Claude Code plugin. One skill per agent-run step, the artifact templates those skills fill, and the hook that keeps `design/` read-only. |
| `linear/` | Linear project and issue templates. |
| `.claude-plugin/marketplace.json` | Makes this folder a local plugin marketplace. |

## Set up a project

1. **Design repo.** Create a new repo and copy everything from `scaffolds/design-repo/` into it. Fill `prd.md` (step 1).
2. **Code repos.** For each domain repo, copy `scaffolds/code-repo/` into it, fill the domain section of its `CLAUDE.md`, and add the design repo as a submodule at `design/`.
3. **Plugin.** In Claude Code, run once per machine:
   - `/plugin marketplace add ~/Done.ai.native`
   - `/plugin install pipeline@done-ai-native`
4. **Linear.** Create the project and issues from `linear/`.

## Skills

| Step | Skill | Runs in |
|---|---|---|
| 2 | `/pipeline:design <project>` | Design repo |
| 3 | `/pipeline:spec <domain>` | Code repo |
| 4 | `/pipeline:plan <linear-issue>` | Code repo |
| 5 | `/pipeline:verify-plan` | Code repo, independent subagent |
| any | `/pipeline:finding` | Any repo. The only skill an agent may invoke on its own. |
| 7 | `/pipeline:build` | Code repo, only after the plan is approved |
| 8 | `/pipeline:verify-sim` | Code repo |
| 9 | `/pipeline:verify-real` | Code repo, with you running the hardware |
| 11 | `/pipeline:pr` | Code repo, after you say go |
| 13–14 | `/pipeline:merge` | Code repo |

Steps 1, 6, 10 and 12 are human decisions and have no skill.
