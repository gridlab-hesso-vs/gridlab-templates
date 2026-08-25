#!/bin/sh
# Build everything this template produces, into ./build:
#
#   build/main.pdf              the compiled example presentation
#   build/beamer-overleaf.zip   main.tex + gridlab/, ready to drop on Overleaf
#
# Needs nothing installed: the theme is picked up from ./gridlab when it is
# not in the TeX tree.
set -e

HERE=$(cd "$(dirname "$0")" && pwd)
cd "$HERE"
mkdir -p build

# Twice: the "n / total" frame counter in the footer needs a second pass.
for pass in 1 2; do
  pdflatex -interaction=nonstopmode -halt-on-error -output-directory=build \
           main.tex >/dev/null 2>&1 || {
    echo "pdflatex failed on pass $pass -- see build/main.log" >&2
    exit 1
  }
done
echo "build/main.pdf"

STAGE=$(mktemp -d)
trap 'rm -rf "$STAGE"' EXIT
cp main.tex "$STAGE/"
cp -R gridlab "$STAGE/gridlab"
rm -f build/beamer-overleaf.zip
(cd "$STAGE" && zip -qr "$HERE/build/beamer-overleaf.zip" . -x '*.DS_Store')
echo "build/beamer-overleaf.zip"
