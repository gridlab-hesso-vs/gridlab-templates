#!/bin/sh
# Link the shared gridlab LaTeX package into your personal TeX tree, so that
# \usetheme{gridlab} works from any .tex on this machine.
#
# A symlink is used on purpose: edits in this repo take effect immediately,
# with no reinstall step.
set -e

REPO=$(cd "$(dirname "$0")" && pwd)
: "${TEXMFHOME:=$(kpsewhich -var-value TEXMFHOME)}"
DEST="$TEXMFHOME/tex/latex"

mkdir -p "$DEST"
ln -sfn "$REPO/gridlab" "$DEST/gridlab"
echo "linked $DEST/gridlab -> $REPO/gridlab"

# Confirm the TeX installation can now see it.
if TEXMFHOME="$TEXMFHOME" kpsewhich beamerthemegridlab.sty; then
  echo "OK: \\usetheme{gridlab} is ready to use."
else
  echo "WARNING: kpsewhich cannot find beamerthemegridlab.sty" >&2
  exit 1
fi
