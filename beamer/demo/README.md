# Demo — feature tour

`demo.tex` is a presentation *about* the theme: 18 slides, each showing one
feature and naming the macro behind it. Read it when you want to know what
`beamerthemegridlab.sty` offers beyond plain Beamer, or copy a slide out of
it as a starting point.

Covered: title page and section dividers, `\topicslide`, blocks and columns,
`fitemize`, the maths helpers (`\const`, `\uunderbrace`, `\vvector`,
`\phase`), the text helpers (`\say`, `\todo`, `\LANG`, `\watermark`), the
plot environments (`q1simpleplot`, `plot`, `phasorbox`, `phasorbox_clean`,
`\vectorarrow`, `\addplanelabel`), the TikZ flowchart styles, and rebranding.

`demo.pdf` next to it is the compiled result, committed on purpose: it is
the one build product in the repo, so the tour can be read without a TeX
installation. `make-build.sh` refreshes it.

## Build

```sh
../make-build.sh        # -> ../build/demo.pdf, copied here as demo.pdf
```

Or, from this directory, `pdflatex demo.tex` twice.

Unlike `../main.tex`, this file loads the theme with an explicit relative
path (`\usepackage{../gridlab/beamerthemegridlab}`), because it sits one
level below the package. It has to be compiled from *this* directory for
that path to resolve — which is what `make-build.sh` does. Start a real
presentation from `../main.tex` instead, which is portable.
