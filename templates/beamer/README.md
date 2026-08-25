# Beamer presentation template

`main.tex` — 16:9 GridLab presentation: title page, section dividers, a
footer with author / short title / frame number, and the utility macros from
`beamerthemegridlab.sty` (math helpers, filled lists, `pgfplots` wrappers,
phasor boxes).

## Compile

```sh
pdflatex main.tex && pdflatex main.tex     # twice, for the frame count
```

Works two ways with no edit to `main.tex`:

- the theme installed in your TeX tree (repo root: `./install.sh`);
- a copy of the repo's `gridlab/` folder sitting next to `main.tex` — what
  `scripts/make-overleaf-zip.sh` produces for Overleaf.

## Customise

Colours — before the theme is loaded (hex, no `#`):

```latex
\def\themeprimary{376092}     % main colour
\def\themesecondary{ED7D31}   % accent colour
```

Logos — the theme's own defaults (HES-SO on the title row, GridLab bottom
right) apply with no setup. Override with `\titlelogos`,
`\titlebottomlogo` (+ `\titlebottomlogox`, `\titlebottomlogoheight`) and
`\cornerlogo`, or set one empty to switch it off.

Your own figures: put them where you like and point `\graphicspath` at them;
the theme's logo paths are appended after yours, so a picture of yours with
the same name wins.
