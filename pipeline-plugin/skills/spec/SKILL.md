---
description: Step 3 of the pipeline. Derive this code repo's domain spec (docs/spec.md) from the system design branch. Run in a code repo.
argument-hint: <domain>
disable-model-invocation: true
---

Run in a **code repo**. `design/` is read-only.

Domain: $ARGUMENTS

1. Ask the human for the design branch if not given. Run `git -C design fetch`, check out that branch in the submodule, and record `git -C design rev-parse HEAD` as `design_sha`.
2. Read the design CLAUDE.md, then the diff between design main and the branch (`git -C design diff origin/main...HEAD`).
3. Fill `docs/spec.md` from `${CLAUDE_PLUGIN_ROOT}/templates/spec.md`:
   - Owned components: the CMP IDs whose domain is $ARGUMENTS.
   - Responsibilities: trace to UF steps.
   - Interfaces: cite DF IDs only. Never define or extend one.
   - Constraints and acceptance criteria: only the CON and AC IDs that apply to this domain.
   - Design diff impact: what the branch changes for this domain.
4. If the design is missing something this domain needs, contradicts itself, or rests on a wrong assumption, run `/pipeline:finding` and stop.
5. Report the spec summary and any open points. Do not start the plan.
