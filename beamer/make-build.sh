#!/bin/sh
# Build everything this template produces, into ./build:
#
#   build/main.pdf              the template, compiled
#   build/demo.pdf              the feature tour in demo/
#   build/beamer-overleaf.zip   main.tex + gridlab/, ready to drop on Overleaf
#
# demo/demo.pdf is refreshed from build/demo.pdf; it is the one build product
# tracked in the repo.
#
# The theme is taken from ./gridlab when it is not installed in the TeX tree,
# so nothing has to be installed first.
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

# The demo lives in demo/ and loads the theme from ../gridlab, so it has to
# be compiled from inside that directory.
for pass in 1 2; do
  (cd demo && pdflatex -interaction=nonstopmode -halt-on-error \
                       -output-directory=../build demo.tex >/dev/null 2>&1) || {
    echo "pdflatex failed on demo pass $pass -- see build/demo.log" >&2
    exit 1
  }
done
cp build/demo.pdf demo/demo.pdf
echo "build/demo.pdf (also refreshed demo/demo.pdf)"

STAGE=$(mktemp -d)
trap 'rm -rf "$STAGE"' EXIT
cp main.tex "$STAGE/"
cp -R gridlab "$STAGE/gridlab"
rm -f build/beamer-overleaf.zip
(cd "$STAGE" && zip -qr "$HERE/build/beamer-overleaf.zip" . -x '*.DS_Store')
echo "build/beamer-overleaf.zip"
