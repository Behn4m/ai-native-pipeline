---
description: Step 11 of the pipeline, and immediately after a cross-system finding is decided. Turn decided findings into suggestions on the design PR and report open ones as design repo issues or known issues. Run in a code repo.
argument-hint: [F-xxx | all]
disable-model-invocation: true
allowed-tools: Bash(git -C .pipeline/findings *) Bash(git -C design *) Bash(gh pr *) Bash(gh issue *) Bash(gh api *)
---

Run in a **code repo**. You never edit the design repo's files. You propose; the human applies.

Scope: $ARGUMENTS (empty or `all` = every finding of this project; `F-xxx` = that finding only).

## 1. Collect

1. `git -C .pipeline/findings pull --rebase`.
2. Project = `design_branch` in `docs/spec.md` without the `design/` prefix. Read every finding in `.pipeline/findings/<project>/` in scope. Skip `synced`, `applied` and `closed`.
3. Find the design repo and PR: `git -C design remote get-url origin`, then `gh pr list -R <design-repo> --head <design_branch> --json number,url`. No PR: stop and tell the human to run `/pipeline:design <project>` first.

## 2. Decided findings → design suggestions

For each `decided` finding:

1. Work out the exact design change the decision needs: which file in `design/`, which section or table, the new text. Keep to the design repo's rules: no code, no history, cite IDs. Write it under Design change in the finding.
2. Post it on the design PR, starting the comment with `[<repo>#F-xxx] decided: <option>` and one line of reason:
   - If the lines to change are in the PR's diff: a review comment with a GitHub `suggestion` block (`gh api repos/<design-repo>/pulls/<n>/comments` with `path`, `line`, `side: RIGHT`, `commit_id`), so the human can commit it in one click.
   - Otherwise: a PR comment with the file, section and proposed text, for the human to apply or hand to `/pipeline:design <project>`.
3. Set `status: synced` and `synced_to: <comment URL>`.

## 3. Open findings → issues or known issues

For each `open` finding, show the human its summary and ask: **design repo issue** or **known issue**?

- Issue: `gh issue create -R <design-repo> --title "[<repo>#F-xxx] <title>" --body <finding content> --label finding`. Set `synced_to: <issue URL>`.
- Known issue: set `synced_to: known issue in code PR`. `/pipeline:pr` lists it in the PR description.

Set `status: synced`. Ask in one message for all open findings, not one at a time.

## 4. Record and report

1. Commit and push the archive: `git -C .pipeline/findings commit -am "Sync <project> findings"`, then push.
2. Report a table: finding, scope, status, where it went.
3. Tell the human what's next: apply the suggestions on the design PR, then run `/pipeline:spec <subsystem> <design_branch>` here. That run marks applied findings `applied`.
