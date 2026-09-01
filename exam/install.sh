#!/bin/sh
# Link the examsheet LaTeX package into your personal TeX tree, so that
# \usepackage{examsheet} works from any .tex on this machine.
#
# A symlink is used on purpose: edits in this repo take effect immediately,
# with no reinstall step.
set -e

REPO=$(cd "$(dirname "$0")" && pwd)
: "${TEXMFHOME:=$(kpsewhich -var-value TEXMFHOME)}"
DEST="$TEXMFHOME/tex/latex"

mkdir -p "$DEST"
ln -sfn "$REPO/examsheet" "$DEST/examsheet"
echo "linked $DEST/examsheet -> $REPO/examsheet"

# Confirm the TeX installation can now see it.
if TEXMFHOME="$TEXMFHOME" kpsewhich examsheet.sty; then
  echo "OK: \\usepackage{examsheet} is ready to use."
else
  echo "WARNING: kpsewhich cannot find examsheet.sty" >&2
  exit 1
fi
