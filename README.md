# GridLab document templates

Templates for GridLab / HES-SO Valais-Wallis documents.

**One folder per document type.** Everything that type needs lives inside it:
the source, the assets it depends on, the script that builds it, and the
build output. A type folder can be copied out or handed to someone on its
own — nothing is shared behind its back.

```
gridlab-templates/
└── beamer/          presentation (LaTeX / Beamer)
```

Types to come — `powerpoint/`, `letter/`, `article/`, `poster/` — are simply
new folders next to `beamer/`, in whatever tooling suits them. No shared
top level to keep in sync; if two types end up needing the same logo, each
keeps its own copy.

Each type folder carries its own `README.md`; start there.

## Convention for a new type

```
<type>/
├── README.md        what it is, how to build it, how to customise it
├── <source files>   main.tex, the .pptx, ...
├── <assets>         logos, styles, anything the source needs
├── make-build.sh    produces everything under build/
└── build/           output, git-ignored
```
