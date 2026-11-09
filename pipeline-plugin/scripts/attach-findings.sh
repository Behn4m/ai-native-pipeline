#!/bin/bash
# Attach the findings archive (branch pipeline/findings) as a worktree at
# .pipeline/findings/, or update it if it is already attached.
# A clone checks out only one branch, and a worktree is local to each machine,
# so a fresh clone never has this folder until this script runs.
# Prints one line and exits:
#   0  attached / updated / none (no archive exists yet) / not a code repo
#   1  unreachable: could not confirm the archive state; do not build past it
root="${CLAUDE_PROJECT_DIR:-$(git rev-parse --show-toplevel 2>/dev/null)}"
[ -n "$root" ] && cd "$root" || exit 0
# Only code repos: they have the design submodule.
git config -f .gitmodules --get-regexp '^submodule\..*\.path$' 2>/dev/null | grep -q ' design$' || exit 0

# Stall limits instead of `timeout`, which macOS does not ship.
export GIT_HTTP_LOW_SPEED_LIMIT=1000 GIT_HTTP_LOW_SPEED_TIME=10
export GIT_SSH_COMMAND="${GIT_SSH_COMMAND:-ssh} -o ConnectTimeout=10"
dir=.pipeline/findings

# Trailing slash: the ignore rule matches the folder even before it exists.
git check-ignore -q "$dir/" 2>/dev/null \
  || echo "Findings: .pipeline/findings/ is not in .gitignore. Add it before recording findings."

if [ -e "$dir/.git" ]; then
  if git -C "$dir" pull -q --rebase 2>/dev/null; then
    echo "Findings: archive updated at $dir."; exit 0
  fi
  echo "Findings: unreachable. Could not update $dir from origin; it may be stale."; exit 1
fi

if [ -e "$dir" ] && [ -n "$(ls -A "$dir" 2>/dev/null)" ]; then
  echo "Findings: unreachable. $dir exists but is not a worktree; move it aside and rerun."; exit 1
fi

git ls-remote --exit-code origin refs/heads/pipeline/findings >/dev/null 2>&1
case $? in
  0) ;;
  2) echo "Findings: none. No archive exists yet; /pipeline:finding creates it."; exit 0 ;;
  *) echo "Findings: unreachable. Could not reach origin to check for pipeline/findings."; exit 1 ;;
esac

# Explicit refspec: shallow and single-branch clones do not track other branches.
git fetch -q origin +refs/heads/pipeline/findings:refs/remotes/origin/pipeline/findings 2>/dev/null \
  || { echo "Findings: unreachable. Fetching pipeline/findings failed."; exit 1; }
git worktree prune
mkdir -p .pipeline
if git show-ref -q --verify refs/heads/pipeline/findings; then
  git worktree add -q "$dir" pipeline/findings && git -C "$dir" pull -q --rebase 2>/dev/null
else
  git worktree add -q -b pipeline/findings "$dir" origin/pipeline/findings \
    && git config branch.pipeline/findings.remote origin \
    && git config branch.pipeline/findings.merge refs/heads/pipeline/findings
fi || { echo "Findings: unreachable. Could not create the worktree at $dir."; exit 1; }
echo "Findings: archive attached at $dir."
exit 0
