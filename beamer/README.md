# Beamer presentation

Template for GridLab presentation in Latex: title page, section dividers, footer with author,
short title and frame number, and utility macros for maths, lists, plots and
flowcharts. `main.tex` is the template; `demo/demo.pdf` shows what the theme
provides.



## Using the template

### On Overleaf

Download **`beamer-overleaf.zip`** from this folder — on GitHub, click the
file, then *Download raw file*. Nothing to build or install.

In Overleaf, *New Project → Upload Project* and drop the zip on it, then edit
`main.tex`. The zip holds `main.tex` and the `gridlab/` folder with the theme
and the logos; it is rebuilt by `make-build.sh` and committed, so it always
matches the template in this folder.

To add the template to an Overleaf project you already have, upload `main.tex`
and the `gridlab/` folder as they are — the zip is only a convenience for
starting a new one.

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

The copy includes `gridlab/`, so nothing has to be installed first. This works
the same on macOS (MacTeX), Linux (TeX Live) and Windows (MiKTeX or TeX
Live).

To keep the theme in one place rather than in every talk, install it once —
that is, put the `gridlab` folder where TeX looks for packages, so
`\usetheme{gridlab}` works from any `.tex` on the machine, logos included.

**macOS (MacTeX) and Linux (TeX Live)**

```sh
./install.sh
```

It symlinks `gridlab/` into your personal tree — `~/Library/texmf/tex/latex/gridlab`
on macOS, `~/texmf/tex/latex/gridlab` on Linux — so edits made here apply
everywhere. `kpsewhich -var-value TEXMFHOME` prints the tree it uses, and
`kpsewhich beamerthemegridlab.sty` prints a path once it worked. No `texhash`
step is needed. Undo with
`rm -r "$(kpsewhich -var-value TEXMFHOME)/tex/latex/gridlab"` — on a symlink that
removes the link only, leaving this folder untouched.

To copy instead of symlink:

```sh
mkdir -p "$(kpsewhich -var-value TEXMFHOME)/tex/latex"
cp -R gridlab "$(kpsewhich -var-value TEXMFHOME)/tex/latex/"
```

**Windows, MiKTeX**

1. Open MiKTeX Console → *Settings* → *Directories*. If no user root
   directory is listed, add one, e.g. `C:\Users\<you>\texmf`.
2. Copy the `gridlab` folder into `tex\latex\` inside that root, so that
   `C:\Users\<you>\texmf\tex\latex\gridlab\beamerthemegridlab.sty` exists.
3. MiKTeX Console → *Tasks* → *Refresh file name database*.

**Windows, TeX Live**

Copy the `gridlab` folder into `%USERPROFILE%\texmf\tex\latex\` — the tree
`kpsewhich -var-value TEXMFHOME` prints. No refresh step.

```powershell
mkdir "$env:USERPROFILE\texmf\tex\latex" -Force
Copy-Item -Recurse gridlab "$env:USERPROFILE\texmf\tex\latex\"
```

On either Windows distribution, `install.sh` also works as-is from Git Bash
or WSL. Check the result with `kpsewhich beamerthemegridlab.sty`.

Once installed, `main.tex` can be copied on its own, without the `gridlab`
folder beside it.

`main.tex` covers both cases:

```latex
\IfFileExists{gridlab/beamerthemegridlab.sty}
  {\usepackage{gridlab/beamerthemegridlab}}   % gridlab/ next to main.tex
  {\usetheme{gridlab}}                        % installed in the TeX tree
```

## Contents

```
beamer/
├── main.tex              the template
├── gridlab/              the LaTeX package: theme + logos
│   ├── beamerthemegridlab.sty
│   ├── logo_gridlab.png
│   └── logo_hesso.png
├── demo/                 feature tour, source and PDF
├── beamer-overleaf.zip   main.tex + gridlab/, ready for Overleaf
├── install.sh            link gridlab/ into the TeX tree
├── make-build.sh         build the PDFs and the Overleaf zip
└── build/                output, git-ignored
```

## Build

```sh
./make-build.sh
```

Writes `build/main.pdf`, `build/demo.pdf` and `build/beamer-overleaf.zip`, and
refreshes the two build products tracked in the repo, `demo/demo.pdf` and
`beamer-overleaf.zip`. Re-run it and commit those two whenever the theme or
`main.tex` changes. No installation is required: `main.tex` finds the theme in
`./gridlab`.

## What the theme provides

`demo/demo.pdf` is a 14-slide tour: title page, section dividers and closing
slide, blocks and columns, the maths and text helpers, the plot and phasor
environments, the flowchart styles. Each slide names the macro that produced
it, and the macros are listed in tables pairing each command with what it
produces.

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
