#!/bin/sh
# Build everything this template produces, into ./build:
#
#   build/main.pdf              the template, compiled
#   build/demo.pdf              the example exam in demo/
#   build/demo-solutions.pdf    the same exam as an answer key
#   build/exam-overleaf.zip     main.tex + examsheet/, ready for Overleaf
#
# demo/demo.pdf, demo/demo-solutions.pdf and exam-overleaf.zip are refreshed
# from build/; they are the build products tracked in the repo, so all three
# can be downloaded straight from GitHub without running this script.
#
# The package is taken from ./examsheet when it is not installed in the TeX
# tree, so nothing has to be installed first.
set -e

HERE=$(cd "$(dirname "$0")" && pwd)
cd "$HERE"
mkdir -p build

# Twice, everywhere below: the point totals, the marking table and the
# "n / total" page counter all go through the .aux file.
for pass in 1 2; do
  pdflatex -interaction=nonstopmode -halt-on-error -output-directory=build \
           main.tex >/dev/null 2>&1 || {
    echo "pdflatex failed on main.tex pass $pass -- see build/main.log" >&2
    exit 1
  }
done
echo "build/main.pdf"

# The demo lives in demo/ and loads the package from ../examsheet, so it has
# to be compiled from inside that directory.
for pass in 1 2; do
  (cd demo && pdflatex -interaction=nonstopmode -halt-on-error \
                       -output-directory=../build demo.tex >/dev/null 2>&1) || {
    echo "pdflatex failed on demo pass $pass -- see build/demo.log" >&2
    exit 1
  }
done
cp build/demo.pdf demo/demo.pdf
echo "build/demo.pdf (also refreshed demo/demo.pdf)"

# The same source again, with the package option that reveals the solutions.
# This is how you produce the answer key for your own exam.
for pass in 1 2; do
  (cd demo && pdflatex -interaction=nonstopmode -halt-on-error \
                       -output-directory=../build -jobname=demo-solutions \
                       "\PassOptionsToPackage{solutions}{examsheet}\input{demo.tex}" \
                       >/dev/null 2>&1) || {
    echo "pdflatex failed on demo-solutions pass $pass -- see build/demo-solutions.log" >&2
    exit 1
  }
done
cp build/demo-solutions.pdf demo/demo-solutions.pdf
echo "build/demo-solutions.pdf (also refreshed demo/demo-solutions.pdf)"

STAGE=$(mktemp -d)
trap 'rm -rf "$STAGE"' EXIT
cp main.tex "$STAGE/"
cp -R examsheet "$STAGE/examsheet"
rm -f build/exam-overleaf.zip
(cd "$STAGE" && zip -qr "$HERE/build/exam-overleaf.zip" . -x '*.DS_Store')
cp build/exam-overleaf.zip exam-overleaf.zip
echo "build/exam-overleaf.zip (also refreshed exam-overleaf.zip)"
