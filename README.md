# GridLab document templates

___
**Institutional use only** These templates are intended for use by authorized members of the Gridlab HES-SO Valais. The institutional name, logo, and other brand assets remain the property of the lab and may not be used without authorization.
___

Templates for GridLab / HES-SO Valais-Wallis documents.

```
gridlab-templates/
└── beamer/          presentation (LaTeX / Beamer)
```

Each document type has its own folder, containing its source, its assets, its
build script and its output. Further types might come: `powerpoint/`, `letter/`,
`article/`, `poster/`, and they will go in folders next to `beamer/`.

See the README inside a type folder for how to use it — including how to
install the LaTeX theme locally on macOS, Linux and Windows, and how to
take a template to Overleaf.

## Layout of a type folder

```
<type>/
├── README.md        what it is, how to use and build it
├── <source files>   main.tex, a .pptx, ...
├── <assets>         logos, styles, whatever the source needs
├── make-build.sh    writes everything into build/
└── build/           output, git-ignored
```
