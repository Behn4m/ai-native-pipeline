---
description: Step 2 of the pipeline. Write or update the high-level system design on a design branch and open the design PR. Also applies finding decisions posted as comments on the design PR. Run in the design repo.
argument-hint: <project-slug>
disable-model-invocation: true
---

Run in the **design repo**. Follow its CLAUDE.md strictly: no code, no history, link instead of repeating, stable IDs, interfaces only in dataflow.md.

Project: $ARGUMENTS

1. Read `prd.md`. If its scope or acceptance criteria are missing or ambiguous, list the questions and stop.
2. Create or switch to branch `design/$ARGUMENTS`.
3. Read the design PR's comments (`gh pr view --comments`). Comments starting with `[<repo>#F-xxx] decided:` are finding decisions from code repos. Apply only the ones the human asks you to apply in this conversation, exactly as proposed unless the human changes them. Suggestions the human already committed need nothing.
4. Update `components.md`, `dataflow.md`, `userflow.md`, `constraints.md` and, if the human asked, `prd.md`. New elements get the next free ID. Retired IDs stay listed as retired. A changed DF gets its version bumped.
5. Check: every CMP has an owning domain; every DF has producer, consumer, payload, errors and version; every AC is pass/fail and names its domains.
6. Commit and push the branch. Open or update a draft PR using the repo's PR template. The PR description is the decision record: fill every section, and list each applied finding under Trigger.
7. Report: the branch name, the changed IDs, and the affected domains (these decide which code repos run step 3).
