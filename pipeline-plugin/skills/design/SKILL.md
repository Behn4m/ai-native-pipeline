---
description: Step 2 of the pipeline. Write or update the high-level system design on a design branch and open the design PR. Run in the design repo.
argument-hint: <project-slug>
disable-model-invocation: true
---

Run in the **design repo**. Follow its CLAUDE.md strictly: no code, no history, link instead of repeating, stable IDs, interfaces only in dataflow.md.

Project: $ARGUMENTS

1. Read `prd.md`. If its scope or acceptance criteria are missing or ambiguous, list the questions and stop.
2. Create or switch to branch `design/$ARGUMENTS`.
3. If this run answers a finding, read the finding and the human's decision first, and change only what the decision requires.
4. Update `components.md`, `dataflow.md`, `userflow.md`, `constraints.md` and, if the human asked, `prd.md`. New elements get the next free ID. Retired IDs stay listed as retired.
5. Check: every CMP has an owning domain; every DF has producer, consumer, payload, errors and version; every AC is pass/fail and names its domains.
6. Commit and push the branch. Open or update a draft PR using the repo's PR template. The PR description is the decision record: fill every section.
7. Report: the branch name, the changed IDs, and the affected domains (these decide which code repos run step 3).
