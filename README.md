# GridLab document templates

Templates for GridLab / HES-SO Valais-Wallis documents.

```
gridlab-templates/
└── beamer/          presentation (LaTeX / Beamer)
```

Each document type has its own folder, containing its source, its assets, its
build script and its output. Further types — `powerpoint/`, `letter/`,
`article/`, `poster/` — go in folders next to `beamer/`, in whatever tooling
they use.

See the README inside a type folder for how to use it.

## Layout of a type folder

```
<type>/
├── README.md        what it is, how to use and build it
├── <source files>   main.tex, a .pptx, ...
├── <assets>         logos, styles, whatever the source needs
├── make-build.sh    writes everything into build/
└── build/           output, git-ignored
```
