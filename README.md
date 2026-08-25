# GridLab document templates

LaTeX (and other) templates for GridLab / HES-SO Valais-Wallis documents,
plus the shared `gridlab` LaTeX package they build on.

```
gridlab-templates/
├── gridlab/                  shared LaTeX package: Beamer theme + logos
│   ├── beamerthemegridlab.sty
│   ├── logo_gridlab.png
│   └── logo_hesso.png
├── templates/
│   ├── beamer/               presentation template  (ready)
│   ├── article/              paper / report         (placeholder)
│   ├── letter/               letterhead             (placeholder)
│   └── poster/               poster                 (placeholder)
├── install.sh                link gridlab/ into your personal TeX tree
└── scripts/
    └── make-overleaf-zip.sh  bundle a template + gridlab/ for Overleaf
```

The `gridlab/` folder is deliberately self-contained: the style file and the
images it needs sit side by side, so the *same folder* can either be linked
into a TeX tree or copied into a project (Overleaf, or a zip for a colleague).

## Install once per machine

```sh
./install.sh
```

This symlinks `gridlab/` into `$TEXMFHOME/tex/latex/` (on macOS:
`~/Library/texmf/tex/latex/gridlab`), so `\usetheme{gridlab}` works from any
`.tex` anywhere on the machine, logos included. Because it is a symlink,
edits made in this repo take effect immediately — no reinstall.

Undo with `rm ~/Library/texmf/tex/latex/gridlab`.

## Use a template

Copy a template folder next to your work and edit `main.tex`:

```sh
cp -R templates/beamer ~/somewhere/my-talk
```

The templates load the theme with

```latex
\IfFileExists{gridlab/beamerthemegridlab.sty}
  {\usepackage{gridlab/beamerthemegridlab}}   % gridlab/ folder next to main.tex
  {\usetheme{gridlab}}                        % installed in the TeX tree
```

so the same file compiles whether the theme is installed or travelling with
the document. Nothing to change when moving between the two.

## Overleaf

Overleaf has no personal TeX tree, so the package travels with the project:

```sh
./scripts/make-overleaf-zip.sh beamer     # -> build/beamer-overleaf.zip
```

Drag that zip onto an Overleaf project (Menu → Upload, or drop it on the file
panel). It contains `main.tex` plus the `gridlab/` folder; the `\IfFileExists`
line above then picks the in-project copy automatically.

Manual equivalent: upload `main.tex` and the `gridlab/` folder as-is.
Requires TeX Live 2020 or newer (Menu → Settings → TeX Live version); older
versions lack the `\CurrentFilePath` kernel feature the theme uses to find its
own logos from a project subfolder.

## Adding a template

Create `templates/<name>/` with a `main.tex` and a short `README.md`. If it
uses the shared logos, load them by bare file name (`logo_hesso.png`) and let
the `gridlab` package supply the search path, rather than hard-coding paths.
