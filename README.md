# ai-native-pipeline

A pipeline for building products with AI coding agents. A system design repo is the single source of truth, each code repo has its own agent session, and humans make the decisions at defined gates.

## What this pipeline is

Agents write code fast, but on their own they drift. They make up interfaces, work around gaps without telling anyone, and grade their own work. This pipeline prevents that by giving every agent the same context and limits:

- **One source of truth.** A system design repo (`prd.md`, `components.md`, `dataflow.md`, `userflow.md`, `constraints.md`) describes the whole product. Only the design session edits it.
- **One agent per domain.** Each code repo (frontend, backend, app, HW…) has its own session, and sessions run in parallel. Every code repo includes the design repo as a read-only submodule and imports its `CLAUDE.md`, so all agents share the same system model.
- **Spec before code.** Each agent turns the design into a domain spec and a plan before it writes any code. An independent reviewer checks the plan against the design.
- **Findings, not workarounds.** When an agent finds a gap or contradiction, it records it in a findings archive and pauses. You decide. Decisions that affect other domains go into the design straight away; the rest are proposed as design changes before the code merges, and a reviewer checks the code matches the updated design.
- **Humans at the gates.** You set the scope, approve deviations, review the diff and confirm merges. Agents do everything in between.
- **Same method everywhere.** The pipeline ships as a Claude Code plugin:
  - Skills fix the procedure for each step.
  - Templates fix the output format.
  - Hooks enforce the rules that must never break.

The full flow is in [diagrams/ai-native-development-pipeline.drawio](diagrams/ai-native-development-pipeline.drawio). The rules are in [PIPELINE.md](PIPELINE.md).

## Long-term use

| How often | What | Where |
|---|---|---|
| Once per machine | Install the plugin | Claude Code |
| Once per product | Create the design repo and code repos | [Initialize repos](#initialize-repos) |
| Every feature | Run the loop: write the PRD, run skills, decide at gates | Design and code repos ([COOKBOOK.md](COOKBOOK.md)) |
| Every few features | Improve the pipeline | This repo |

**Day to day**, you work in the design and code repos, not here. The skills carry the procedure, and your job is the gates: green light, findings, diff review, merge.

**Improve the pipeline** by treating this repo as a product:

- Review findings, revise loops and test failures every few features.
  - A recurring kind of finding means a design template is missing a field.
  - A recurring deviation means a spec template or a constraint is unclear.
- When an instruction is ignored more than once, move it into a hook.
- Add a skill or template only when a manual step keeps repeating.
- Release through PRs: bump `version` in `pipeline-plugin/.claude-plugin/plugin.json` and add a changelog entry. Projects update when they're ready, so a change never breaks a feature in progress.

**New contributors** read `PIPELINE.md` once and install the plugin. After that, the skills guide them.

## Initialize repos

### 1. Install the plugin (once per machine)

In Claude Code:

```
/plugin marketplace add Behn4m/ai-native-pipeline
/plugin install pipeline@done-ai-native
```

Type `/pipeline:` to check that the skills are listed.

### 2. Create the design repo (once per product)

1. Create a repo, e.g. `<product>-design`.
2. Copy everything from `scaffolds/design-repo/` into it.
3. Fill the `<placeholders>` in `CLAUDE.md`.
4. Commit to `main`. Each feature then starts on a `design/<project>` branch with `prd.md` filled in.

### 3. Create a code repo (once per domain)

1. Create a repo, e.g. `<product>-backend`.
2. Copy everything from `scaffolds/code-repo/` into it.
3. Add the design repo as a submodule:

   ```
   git submodule add <design-repo-url> design
   ```

4. In `CLAUDE.md`, fill:
   - The **Domain** section: domain, owned `CMP-` IDs, Linear project.
   - The **Build and test** commands.
5. Commit. The scaffold's `.gitignore` keeps the findings archive out of code branches.
6. After the first `/pipeline:finding` creates the `pipeline/findings` branch, protect it on GitHub: no deletion, no merging into `main`.

### 4. Set up Linear

Create the project and issues from [linear/](linear/).

Then run your first feature with [COOKBOOK.md](COOKBOOK.md).

## Contents

| Path | Purpose |
|---|---|
| `PIPELINE.md` | Rulebook: roles, steps, gates, IDs |
| `COOKBOOK.md` | Recipes: feature loop, findings, test failures, changing the pipeline |
| `diagrams/` | Pipeline diagram |
| `scaffolds/` | Starter files copied once into new design and code repos |
| `pipeline-plugin/` | Claude Code plugin: skills, templates, hooks |
| `linear/` | Linear project and issue templates |
