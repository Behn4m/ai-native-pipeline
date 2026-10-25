---
description: Step 3 of the pipeline. Derive this code repo's domain spec (docs/spec.md) from a system design branch. Run in a code repo.
argument-hint: <domain> <design-branch>
arguments: [domain, branch]
disable-model-invocation: true
allowed-tools: Bash(git -C design *) Bash(git -C .pipeline/findings *)
---

Run in a **code repo**. `design/` is read-only.

- Domain: $domain
- Design branch: $branch

## Design state

The submodule was fetched and checked out at `$branch` before this skill loaded. Commit:

!`git -C design fetch -q origin && git -C design checkout -q $branch && git -C design pull -q --ff-only && git -C design rev-parse HEAD`

## Changes on $branch vs design main

!`git -C design diff origin/main...HEAD`

## Steps

1. Record the commit above as `design_sha` and `$branch` as `design_branch` in the spec header.
2. Read `design/CLAUDE.md`, then the changes above, then every design doc that touches domain $domain.
3. Fill `docs/spec.md` from `${CLAUDE_PLUGIN_ROOT}/templates/spec.md`:
   - Owned components: the CMP IDs whose domain is $domain.
   - Responsibilities: trace to UF steps.
   - Interfaces: cite DF IDs only. Never define or extend one.
   - Constraints and acceptance criteria: only the CON and AC IDs that apply to this domain.
   - Design diff impact: what the changes above mean for this domain. "None" if nothing.
4. If the design is missing something this domain needs, contradicts itself, or rests on a wrong assumption, run `/pipeline:finding` and stop.
5. If `.pipeline/findings/` exists: `git -C .pipeline/findings pull --rebase`, then for every `synced` finding of this project whose Design change now appears in the design (as committed, or as the human edited it), set `status: applied`. Commit and push the archive.
6. Report the spec summary, findings now applied, and any open points. Do not start the plan.
