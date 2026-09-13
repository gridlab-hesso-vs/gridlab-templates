#!/bin/sh
# Build everything this template produces, into ./build:
#
#   build/main.pdf              the template, compiled
#   build/demo.pdf              the feature tour in demo/
#   build/beamer-overleaf.zip   main.tex + theme + logos, ready for Overleaf
#
# demo/demo.pdf and beamer-overleaf.zip are refreshed from build/; they are the
# build products tracked in the repo, so both can be downloaded straight from
# GitHub without running this script.
set -e

HERE=$(cd "$(dirname "$0")" && pwd)
cd "$HERE"
mkdir -p build

# \usetheme{gridlab} is resolved from ./gridlab, so nothing has to be
# installed first.
export TEXINPUTS="$HERE/gridlab//:$TEXINPUTS"

# Twice each: the "n / total" frame counter in the footer needs a second pass.
for doc in main.tex demo/demo.tex; do
  for pass in 1 2; do
    pdflatex -interaction=nonstopmode -halt-on-error -output-directory=build \
             "$doc" >/dev/null 2>&1 || {
      echo "pdflatex failed on $doc, pass $pass -- see build/$(basename "$doc" .tex).log" >&2
      exit 1
    }
  done
  echo "build/$(basename "$doc" .tex).pdf"
done
cp build/demo.pdf demo/demo.pdf
echo "(also refreshed demo/demo.pdf)"

# Flat layout: the theme and its logos sit next to main.tex, where
# \usetheme{gridlab} finds them on Overleaf or any local TeX install.
STAGE=$(mktemp -d)
trap 'rm -rf "$STAGE"' EXIT
cp main.tex gridlab/beamerthemegridlab.sty gridlab/*.png "$STAGE/"
rm -f build/beamer-overleaf.zip
(cd "$STAGE" && zip -qr "$HERE/build/beamer-overleaf.zip" . -x '*.DS_Store')
cp build/beamer-overleaf.zip beamer-overleaf.zip
echo "build/beamer-overleaf.zip (also refreshed beamer-overleaf.zip)"
