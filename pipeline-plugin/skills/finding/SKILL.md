---
description: Record a design finding (gap, contradiction or wrong assumption) in the findings archive and pause the affected task. Use whenever the system design is missing something, contradicts itself or is wrong, instead of coding around it. Usable at any step in a code repo.
allowed-tools: Bash(git worktree *) Bash(git fetch *) Bash(git -C .pipeline/findings *) Bash(git check-ignore *)
---

Never work around a design problem. Record it and pause.

## 1. Make sure the archive is attached

The archive is the branch `pipeline/findings`, checked out as a worktree at `.pipeline/findings/`. If `.pipeline/findings/.git` does not exist:

- Remote branch exists (`git fetch origin pipeline/findings` succeeds): `git worktree add .pipeline/findings pipeline/findings`
- Otherwise create it: `git worktree add --orphan -b pipeline/findings .pipeline/findings`, then commit an empty README there and `git -C .pipeline/findings push -u origin pipeline/findings`.

Confirm `git check-ignore .pipeline/findings` succeeds. If not, stop and tell the human to add `.pipeline/findings/` to `.gitignore`.

## 2. Write the finding

1. `git -C .pipeline/findings pull --rebase`.
2. Project = `design_branch` in `docs/spec.md` without the `design/` prefix.
3. Pick the next free ID in `.pipeline/findings/<project>/` (F-001, F-002, ...).
4. Fill `.pipeline/findings/<project>/F-xxx.md` from `${CLAUDE_PLUGIN_ROOT}/templates/finding.md` with `status: open`: IDs involved, evidence, impact, options, one recommendation. Leave Decision and Design change empty.
5. Set `scope`:
   - `cross-domain` if it touches a DF ID, a CON ID that applies to other domains, a CMP owned by another domain, or an AC of another domain.
   - `domain` otherwise.
   Explain the choice under Scope reason.
6. `git -C .pipeline/findings add <project>/F-xxx.md`, commit `F-xxx: <title>`, push.

## 3. Pause and report

1. Stop work on the affected task. Do not edit code for it until the finding is decided.
2. Tell the human: the finding ID, scope, one-line summary, options and recommendation, and ask which option they choose.
3. When the human answers in this conversation, write their choice under Decision, set `status: decided`, commit and push.
   - **domain**: the build may continue and implement the decision.
   - **cross-domain**: tell the human to run `/pipeline:findings-sync` now; the build on this task waits until the change is applied to the design and `/pipeline:spec` is rerun.
