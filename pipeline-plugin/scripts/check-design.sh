#!/bin/bash
# SessionStart: warn when the design branch moved since docs/spec.md was written,
# and list findings that need attention. Never blocks; output is added to the session.
root="${CLAUDE_PROJECT_DIR:-$PWD}"
spec="$root/docs/spec.md"
[ -f "$spec" ] || exit 0
[ -d "$root/design" ] || exit 0

field() { sed -n "s/^$1:[[:space:]]*//p" "$spec" | head -1 | tr -d '[:space:]'; }
branch=$(field design_branch)
sha=$(field design_sha)
case "$branch" in ""|"<"*) exit 0 ;; esac

timeout 15 git -C "$root/design" fetch -q origin "$branch" 2>/dev/null
head=$(git -C "$root/design" rev-parse -q --verify "origin/$branch" 2>/dev/null)
if [ -n "$head" ] && [ "$head" != "$sha" ]; then
  echo "Pipeline: the design branch $branch moved since docs/spec.md was written (spec ${sha:0:7}, branch ${head:0:7})."
  echo "Rerun /pipeline:spec <subsystem> $branch before planning or building."
fi

project=${branch#design/}
dir="$root/.pipeline/findings/$project"
if [ -d "$dir" ]; then
  open=$(grep -l '^status:[[:space:]]*open' "$dir"/F-*.md 2>/dev/null | xargs -r -n1 basename -s .md | tr '\n' ' ')
  waiting=$(grep -l '^scope:[[:space:]]*cross-system' "$dir"/F-*.md 2>/dev/null | xargs -r grep -l -E '^status:[[:space:]]*(decided|synced)' 2>/dev/null | xargs -r -n1 basename -s .md | tr '\n' ' ')
  [ -n "$open" ] && echo "Pipeline: open findings waiting for a decision: $open"
  [ -n "$waiting" ] && echo "Pipeline: cross-system decisions not yet applied to the design: $waiting"
fi
exit 0
