#!/usr/bin/env sh
# agent-ready — drop the AI-collaboration conventions into a repository.
#
#   ./install.sh [--force] [TARGET_DIR]
#
# TARGET_DIR defaults to the current directory. Safe and idempotent: an existing
# file is never overwritten unless you pass --force.

set -eu

FORCE=0
TARGET="."
for arg in "$@"; do
  case "$arg" in
    --force) FORCE=1 ;;
    -h|--help) echo "usage: $0 [--force] [TARGET_DIR]"; exit 0 ;;
    -*) echo "unknown option: $arg" >&2; exit 2 ;;
    *) TARGET="$arg" ;;
  esac
done

KIT="$(cd "$(dirname "$0")" && pwd)"

copy() { # <src-rel-to-kit> <dest-rel-to-target>
  src="$KIT/$1"
  dest="$TARGET/$2"
  if [ -e "$dest" ] && [ "$FORCE" -ne 1 ]; then
    echo "  skip   $2  (exists — pass --force to replace)"
    return 0
  fi
  mkdir -p "$(dirname "$dest")"
  cp "$src" "$dest"
  echo "  add    $2"
}

if [ ! -d "$TARGET" ]; then
  echo "target directory does not exist: $TARGET" >&2
  exit 1
fi

echo "Installing agent-ready into: $TARGET"
copy templates/AGENTS.md                                  AGENTS.md
copy templates/memory/MEMORY.md                           memory/MEMORY.md
copy templates/memory/EXAMPLE.md                          memory/EXAMPLE.md
copy templates/adapters/CLAUDE.md                         CLAUDE.md
copy templates/adapters/.github/copilot-instructions.md   .github/copilot-instructions.md
copy templates/adapters/.cursor/rules/agents.mdc          .cursor/rules/agents.mdc

cat <<'EOF'

Done. Next:
  1. Open AGENTS.md and fill in the <ANGLE-BRACKET> blanks (build/test/run, conventions).
  2. Delete adapter files for tools you don't use (CLAUDE.md, .github/…, .cursor/…).
  3. Commit it. Your repo is now agent-ready.
EOF
