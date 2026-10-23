---
description: Step 7 of the pipeline. Implement the approved plan on a work branch, building and testing after every change. Run in a code repo.
disable-model-invocation: true
---

Run in a **code repo**.

1. Read `docs/plan.md`. If its `status` is not `approved`, stop and say green light is missing.
2. Confirm `design_sha` in the plan matches `git -C design rev-parse HEAD`. If not, stop.
3. Create or switch to a work branch named after the Linear issue.
4. Implement tasks in plan order. After every change, run the build, unit tests and lint from CLAUDE.md. Fix failures before moving on.
5. Implement only what the plan says. If the plan is wrong in a small, local way, note it for the human. If the design is wrong or missing something, run `/pipeline:finding` and stop.
6. Do not commit or push; that is step 11.
7. Report: tasks done, build and unit test status, and anything that deviated from the plan. Then tell the human to run `/pipeline:verify-sim`.
