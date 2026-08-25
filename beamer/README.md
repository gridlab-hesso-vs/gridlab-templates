# Beamer presentation

16:9 GridLab presentation: title page, section dividers, footer with author /
short title / frame number, and utility macros (math helpers, filled lists,
`pgfplots` wrappers, phasor boxes).

```
beamer/
├── main.tex          the presentation — start here
├── gridlab/          the LaTeX package it needs: theme + logos
│   ├── beamerthemegridlab.sty
│   ├── logo_gridlab.png
│   └── logo_hesso.png
├── demo/             feature tour: every macro the theme adds, on a slide
├── install.sh        link gridlab/ into your TeX tree (optional, once)
├── make-build.sh     build the PDFs and the Overleaf zip
└── build/            output (git-ignored)
```

## Build

```sh
./make-build.sh
```

Produces `build/main.pdf`, `build/demo.pdf` and `build/beamer-overleaf.zip`.
Nothing needs to be installed first — `main.tex` finds the theme in
`./gridlab`.

To compile by hand instead: `pdflatex main.tex` twice (the second pass fills
in the frame counter).

## Start a presentation from this template

```sh
cp -R . ~/somewhere/my-talk       # takes gridlab/ along, stays self-contained
```

Or, if you'd rather not carry `gridlab/` in every talk, install it once:

```sh
./install.sh                      # symlinks gridlab/ into $TEXMFHOME/tex/latex
```

Then `\usetheme{gridlab}` works from any `.tex` on the machine and you can
copy `main.tex` alone. Because it is a symlink, edits here take effect
everywhere immediately. Undo with `rm ~/Library/texmf/tex/latex/gridlab`.

`main.tex` handles both cases without an edit:

```latex
\IfFileExists{gridlab/beamerthemegridlab.sty}
  {\usepackage{gridlab/beamerthemegridlab}}   % gridlab/ next to main.tex
  {\usetheme{gridlab}}                        % installed in the TeX tree
```

## Overleaf

Drag `build/beamer-overleaf.zip` onto an Overleaf project (Menu → Upload, or
drop it on the file panel). It holds `main.tex` plus `gridlab/`, and the line
above picks the in-project copy on its own.

Needs TeX Live 2020 or newer (Menu → Settings → TeX Live version): older
versions lack the `\CurrentFilePath` kernel feature the theme uses to locate
its own logos from a project subfolder.

## What the theme can do

`demo/demo.tex` is a tour of it: title page and dividers, blocks, filled
lists, the maths and text helpers, the plot and phasor environments, the
flowchart styles. Each slide names the macro that produced it, and most put
the source next to the result.

Read it without building anything: **`demo/demo.pdf`** is committed and kept
up to date by `make-build.sh`.

## Customise

Colours — before the theme is loaded (hex, no `#`):

```latex
\def\themeprimary{376092}     % main colour
\def\themesecondary{ED7D31}   % accent colour
```

Logos — the theme's defaults (HES-SO on the title row, GridLab bottom right)
apply with no setup. Override with `\titlelogos`, `\titlebottomlogo` (placed
with `\titlebottomlogox`, `\titlebottomlogoheight`) and `\cornerlogo`, or set
one empty to switch it off.

Your own figures: put them where you like and point `\graphicspath` at them.
The theme's logo paths are appended after yours, so a picture of yours with
the same name wins.
