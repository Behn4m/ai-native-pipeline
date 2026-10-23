#!/bin/bash
# Blocks file edits inside the design/ submodule of a code repo.
input=$(cat)
path=$(printf '%s' "$input" | sed -n 's/.*"file_path"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | head -1)
[ -z "$path" ] && exit 0
root="${CLAUDE_PROJECT_DIR:-$PWD}"
case "$path" in
  "$root"/design/*|design/*)
    echo "Blocked: design/ is the read-only system design submodule. Run /pipeline:finding instead of editing it." >&2
    exit 2 ;;
esac
exit 0
