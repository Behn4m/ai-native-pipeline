---
description: Step 7 of the pipeline. Implement the approved plan and decided findings on a work branch, building and testing after every change. Run in a code repo.
disable-model-invocation: true
---

Run in a **code repo**.

1. Read `docs/plan.md`. If its `status` is not `approved`, stop and say green light is missing.
2. Confirm `design_sha` in the spec matches `git -C design rev-parse HEAD`. If not, stop and ask the human to rerun `/pipeline:spec`.
3. Read the findings in `.pipeline/findings/<project>/` (project = `design_branch` in the spec without `design/`):
   - `open`: do not work on the affected task. Work on other tasks, or stop if none are left.
   - `decided`, scope `local`: implement the decision in the affected task.
   - `decided` or `synced`, scope `cross-system`: do not work on the affected task until it is `applied`.
   - `applied`: the design already states the decision; follow the design.
4. Create or switch to a work branch named after the Linear issue.
5. Implement tasks in plan order. After every change, run the build, unit tests and lint from CLAUDE.md. Fix failures before moving on.
6. Implement only what the plan, the design and decided findings say. If the plan is wrong in a small, local way, note it for the human. If the design is wrong or missing something, run `/pipeline:finding` and pause that task.
7. Do not commit or push code; that is step 14.
8. Report: tasks done, tasks paused on findings, build and unit test status, and anything that deviated from the plan. Then tell the human to run `/pipeline:verify-sim`.
