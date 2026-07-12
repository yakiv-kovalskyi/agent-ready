#!/usr/bin/env sh
# agent-ready — drop the AI-collaboration conventions into a repository.
#
#   ./install.sh [--force] [TARGET_DIR]
#
# TARGET_DIR defaults to the current directory. Safe and idempotent: an existing
# file is never overwritten unless you pass --force.

set -eu

FORCE=0
TARGET=""
for arg in "$@"; do
  case "$arg" in
    --force) FORCE=1 ;;
    -h|--help) echo "usage: $0 [--force] [TARGET_DIR]"; exit 0 ;;
    -*) echo "unknown option: $arg" >&2; exit 2 ;;
    *)
      if [ -n "$TARGET" ]; then
        echo "error: multiple target directories given: '$TARGET' and '$arg'" >&2
        exit 2
      fi
      TARGET="$arg"
      ;;
  esac
done
TARGET="${TARGET:-.}"

KIT="$(cd "$(dirname "$0")" && pwd)"

copy() { # <src-abs> <dest-rel-to-target>
  src="$1"
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
# Every file under templates/ ships as-is; templates/adapters/* land at the
# target's root (stripping the adapters/ prefix). Add a template file on disk
# and it's installed automatically — nothing here to keep in sync.
find "$KIT/templates" -type f | sort | while IFS= read -r src; do
  rel="${src#"$KIT"/templates/}"
  case "$rel" in
    adapters/*) rel="${rel#adapters/}" ;;
  esac
  copy "$src" "$rel"
done

cat <<'EOF'

Done. Next:
  1. Open AGENTS.md and fill in the <ANGLE-BRACKET> blanks (build/test/run, conventions).
  2. Delete adapter files for tools you don't use (CLAUDE.md, .github/…, .cursor/…).
  3. Commit it. Your repo is now agent-ready.
EOF
