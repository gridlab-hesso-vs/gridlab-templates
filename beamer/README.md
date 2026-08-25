# Beamer presentation

A 16:9 GridLab presentation: title page, section dividers, footer with author,
short title and frame number, and utility macros for maths, lists, plots and
flowcharts. `main.tex` is the template; `demo/demo.pdf` shows what the theme
provides.

## Using the template

### On Overleaf

```sh
./make-build.sh          # writes build/beamer-overleaf.zip
```

Upload that zip to an Overleaf project (Menu → Upload, or drop it on the file
panel) and edit `main.tex`. The zip contains `main.tex` and the `gridlab/`
folder, which holds the theme and the logos.

Without the script: upload `main.tex` and the `gridlab/` folder as they are.

Overleaf must be set to TeX Live 2020 or newer (Menu → Settings → TeX Live
version). Earlier versions do not provide `\CurrentFilePath`, which the theme
uses to find its logos inside a project subfolder.

### With a local LaTeX distribution

Copy this folder and compile:

```sh
cp -R . ~/somewhere/my-talk
cd ~/somewhere/my-talk
pdflatex main.tex && pdflatex main.tex     # twice: the frame counter
```

The copy includes `gridlab/`, so nothing else is needed (MacTeX, TeX Live,
MiKTeX).

To keep the theme in one place rather than in every talk, install it once:

```sh
./install.sh
```

This symlinks `gridlab/` into `$TEXMFHOME/tex/latex` (macOS:
`~/Library/texmf/tex/latex/gridlab`). `\usetheme{gridlab}` then works from any
`.tex` on the machine, logos included, and `main.tex` can be copied on its
own. Edits made here apply everywhere, since it is a symlink. Remove it with
`rm ~/Library/texmf/tex/latex/gridlab`.

`main.tex` covers both cases:

```latex
\IfFileExists{gridlab/beamerthemegridlab.sty}
  {\usepackage{gridlab/beamerthemegridlab}}   % gridlab/ next to main.tex
  {\usetheme{gridlab}}                        % installed in the TeX tree
```

## Contents

```
beamer/
├── main.tex          the template
├── gridlab/          the LaTeX package: theme + logos
│   ├── beamerthemegridlab.sty
│   ├── logo_gridlab.png
│   └── logo_hesso.png
├── demo/             feature tour, source and PDF
├── install.sh        link gridlab/ into the TeX tree
├── make-build.sh     build the PDFs and the Overleaf zip
└── build/            output, git-ignored
```

## Build

```sh
./make-build.sh
```

Writes `build/main.pdf`, `build/demo.pdf` and `build/beamer-overleaf.zip`, and
refreshes `demo/demo.pdf`. No installation is required: `main.tex` finds the
theme in `./gridlab`.

## What the theme provides

`demo/demo.pdf` is a 14-slide tour: title page, section dividers and closing
slide, blocks and columns, the maths and text helpers, the plot and phasor
environments, the flowchart styles. Each slide names the macro that produced
it, and most show the source next to the result.

## Customise

Colours, set before the theme is loaded (hex, no `#`):

```latex
\def\themeprimary{376092}     % main colour
\def\themesecondary{ED7D31}   % accent colour
```

The closing slide is `\closingslide`, placed outside any frame. It shows a
headline and the `\author` and `\institute` from the title block, with the
school logo bottom left and the lab logo bottom right:

```latex
\def\closingtitle{Thank you}          % headline for the whole deck
\def\closingnote{Questions?}          % an extra line underneath
\def\closingleftlogo{logo.png}        % bottom-left logo, empty to drop it
\def\closingtop{0.16\paperheight}     % how high the text block sits
\closingslide                         % or \closingslide[Merci !] for one slide
```

Logos default to HES-SO on the title row and GridLab bottom right. Override
with `\titlelogos`, `\titlebottomlogo` (positioned by `\titlebottomlogox` and
`\titlebottomlogoheight`) and `\cornerlogo`; set one empty to switch it off.

Text inside the plot environments — tick labels, axis labels and the labels
placed by `\addplanelabel` and `\vectorarrow` — uses `\plotfont`, which is
`\small`. Change it in the preamble, or in a group for a single plot:

```latex
\renewcommand{\plotfont}{\scriptsize}                  % all plots
{\renewcommand{\plotfont}{\tiny} \begin{plot}...}      % just this one
```

For your own figures, point `\graphicspath` at their folder. The theme's logo
paths are searched after yours, so a picture of yours with the same name is
used.
