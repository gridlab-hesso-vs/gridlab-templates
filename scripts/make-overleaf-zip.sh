#!/bin/sh
# Bundle a template together with the gridlab package into a zip that can be
# dropped straight onto an Overleaf project (Menu -> Upload, or drag & drop).
#
#   ./scripts/make-overleaf-zip.sh [template]     (default: beamer)
set -e

REPO=$(cd "$(dirname "$0")/.." && pwd)
TPL=${1:-beamer}
SRC="$REPO/templates/$TPL"

[ -d "$SRC" ] || { echo "no such template: $TPL" >&2; exit 1; }
ls "$SRC"/*.tex >/dev/null 2>&1 || { echo "$TPL has no .tex yet" >&2; exit 1; }

OUT="$REPO/build/$TPL-overleaf.zip"
STAGE=$(mktemp -d)
trap 'rm -rf "$STAGE"' EXIT

cp "$SRC"/*.tex "$STAGE/"
cp -R "$REPO/gridlab" "$STAGE/gridlab"

mkdir -p "$REPO/build"
rm -f "$OUT"
(cd "$STAGE" && zip -qr "$OUT" . -x '*.DS_Store')
echo "$OUT"
