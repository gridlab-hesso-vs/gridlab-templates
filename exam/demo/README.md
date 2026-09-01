# Demo

`demo.tex` is a complete exam written with `examsheet.sty`, kept as the
worked example for the template: seven questions, subquestions carrying the
points, every size of answer space, a figure, a true/false block, two answer
keys and the marking table.

`demo.pdf` is the paper handed to the students, `demo-solutions.pdf` is the
same source built with the `solutions` option — the answers appear and the
blank space collapses. Both are kept in the repo so they can be read without a
TeX installation.

___
**Institutional use only** This template is intended for use by authorized members of the Gridlab HES-SO Valais. The institutional name, logo, and other brand assets remain the property of the lab and may not be used without authorization.
___

## Build

```sh
../make-build.sh        # writes both PDFs into ../build and copies them here
```

Or, from this directory:

```sh
pdflatex demo.tex && pdflatex demo.tex
pdflatex -jobname=demo-solutions \
  "\PassOptionsToPackage{solutions}{examsheet}\input{demo.tex}"
```

Twice each: the point totals and the marking table go through the `.aux` file.

`demo.tex` loads the package by relative path
(`\usepackage[french]{../examsheet/examsheet}`), so it has to be compiled from
this directory. `../main.tex` uses the portable form instead and is the file
to start an exam from.
