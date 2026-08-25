# Demo

`demo.tex` is a presentation about the theme: 14 slides, each showing one
feature and naming the macro behind it. The maths, text, plot and
customisation slides are tables pairing every command with its result. `demo.pdf` is the compiled version, kept in the repo so it can be
read without a TeX installation.

___
**Institutional use only** This template is intended for use by authorized members of the Gridlab HES-SO Valais. The institutional name, logo, and other brand assets remain the property of the lab and may not be used without authorization.
___

Covered: title page, section dividers, `\topicslide` and `\closingslide`,
blocks and columns,
the maths helpers (`\const`, `\uunderbrace`, `\vvector`, `\phase`,
`\cancel`), the text helpers (`\say`, `\todo`, `\watermark`), the plot
environments (`q1simpleplot`, `plot`, `phasorbox`, `phasorbox_clean`,
`\vectorarrow`, `\addplanelabel`), the TikZ flowchart styles, and the colour
and logo settings.

## Build

```sh
../make-build.sh        # writes ../build/demo.pdf and copies it here
```

Or `pdflatex demo.tex` twice from this directory.

`demo.tex` loads the theme by relative path
(`\usepackage{../gridlab/beamerthemegridlab}`), so it has to be compiled from
this directory. `../main.tex` uses the portable form instead and is the file
to start a presentation from.
