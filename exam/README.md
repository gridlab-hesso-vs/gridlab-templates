# Written exam

Template for a written exam in LaTeX: a front page with the exam identity and
the rules, numbered questions with lettered subquestions, squared or ruled
space to write the answers in, and — from the same source — an answer key.

**Points are declared once, on the subquestions.** The total next to each
question heading, the total on the front page and the marking table are all
counted from them, so they cannot drift out of step with the paper as you edit
it.

`main.tex` is the template to start from; `demo/demo.pdf` is a real exam
written with it, and `demo/demo-solutions.pdf` is that same file built as the
answer key.

The sheet is deliberately neutral — no logo, no colour, black on white so it
photocopies and scans cleanly. Add your own heading if your school wants one.

## Using the template

### On Overleaf

- Download [`exam-overleaf.zip`](https://github.com/gridlab-hesso-vs/gridlab-templates/raw/main/exam/exam-overleaf.zip).
- In Overleaf, *New Project → Existing project (.zip)*, and drop the zip on it.
- Edit `main.tex`.

Alternatively, upload `main.tex` and the `examsheet/` folder instead.

### With a local LaTeX distribution

Copy this folder and compile:

```sh
cp -R . ~/somewhere/my-exam
cd ~/somewhere/my-exam
pdflatex main.tex && pdflatex main.tex     # twice: the point totals
```

The copy includes `examsheet/`, so nothing has to be installed first. This
works the same on macOS (MacTeX), Linux (TeX Live) and Windows (MiKTeX or TeX
Live).

**Compile twice.** The points shown next to a question are only known once the
whole question has been read, so they travel through the `.aux` file exactly
like a table of contents does. On the first pass they read `?? pts` in red,
and the package warns that a rerun is needed.

To keep the package in one place rather than in every exam, install it once —
that is, put the `examsheet` folder where TeX looks for packages, so
`\usepackage{examsheet}` works from any `.tex` on the machine.

**macOS (MacTeX) and Linux (TeX Live)**

```sh
./install.sh
```

It symlinks `examsheet/` into your personal tree —
`~/Library/texmf/tex/latex/examsheet` on macOS, `~/texmf/tex/latex/examsheet`
on Linux — so edits made here apply everywhere. `kpsewhich -var-value
TEXMFHOME` prints the tree it uses, and `kpsewhich examsheet.sty` prints a path
once it worked. No `texhash` step is needed. Undo with
`rm -r "$(kpsewhich -var-value TEXMFHOME)/tex/latex/examsheet"` — on a symlink
that removes the link only, leaving this folder untouched.

To copy instead of symlink:

```sh
mkdir -p "$(kpsewhich -var-value TEXMFHOME)/tex/latex"
cp -R examsheet "$(kpsewhich -var-value TEXMFHOME)/tex/latex/"
```

**Windows, MiKTeX**

1. Open MiKTeX Console → *Settings* → *Directories*. If no user root
   directory is listed, add one, e.g. `C:\Users\<you>\texmf`.
2. Copy the `examsheet` folder into `tex\latex\` inside that root, so that
   `C:\Users\<you>\texmf\tex\latex\examsheet\examsheet.sty` exists.
3. MiKTeX Console → *Tasks* → *Refresh file name database*.

**Windows, TeX Live**

Copy the `examsheet` folder into `%USERPROFILE%\texmf\tex\latex\` — the tree
`kpsewhich -var-value TEXMFHOME` prints. No refresh step.

```powershell
mkdir "$env:USERPROFILE\texmf\tex\latex" -Force
Copy-Item -Recurse examsheet "$env:USERPROFILE\texmf\tex\latex\"
```

On either Windows distribution, `install.sh` also works as-is from Git Bash
or WSL. Check the result with `kpsewhich examsheet.sty`.

Once installed, `main.tex` can be copied on its own, without the `examsheet`
folder beside it. It covers both cases:

```latex
\IfFileExists{examsheet/examsheet.sty}
  {\usepackage[french]{examsheet/examsheet}}   % examsheet/ next to main.tex
  {\usepackage[french]{examsheet}}             % installed in the TeX tree
```

## Contents

```
exam/
├── main.tex              the template
├── examsheet/            the LaTeX package
│   └── examsheet.sty
├── demo/                 an exam written with it, source and PDFs
├── exam-overleaf.zip     main.tex + examsheet/, ready for Overleaf
├── install.sh            link examsheet/ into the TeX tree
├── make-build.sh         build the PDFs and the Overleaf zip
└── build/                output, git-ignored
```

## Build

```sh
./make-build.sh
```

Writes `build/main.pdf`, `build/demo.pdf`, `build/demo-solutions.pdf` and
`build/exam-overleaf.zip`, and refreshes the three build products tracked in
the repo: `demo/demo.pdf`, `demo/demo-solutions.pdf` and `exam-overleaf.zip`.
Re-run it and commit those whenever the package or `main.tex` changes.

## Package options

```latex
\usepackage[french]{examsheet}
```

| Option | What it does |
| --- | --- |
| `french` | labels in French (default) |
| `english` | labels in English |
| `solutions` | typeset the answer key: print the `solution` blocks and drop the blank answer space |
| `keepspace` | with `solutions`, keep the answer space as well |
| `nobabel` | do not load babel — load it yourself |

## Writing the exam

**The exam identity**, in the preamble; `\makeexamtitle` then prints the front
matter. Anything you leave unset is left out.

| Command | |
| --- | --- |
| `\examtitle{...}` | the title, on the front page |
| `\examsubtitle{...}` | a line under it, e.g. the academic year |
| `\examshorttitle{...}` | what goes in the running head (defaults to the title) |
| `\examdate{...}`, `\examduration{...}` | shown on the line under the title |
| `\examinstructions{...}` | the instructions paragraph |
| `\exammaterial{...}` | the permitted-material paragraph |
| `\makeexamtitle` | print all of the above, plus the name and ID fields |
| `\markingtable` | a table of every question, its points, and a box for the score |

**Questions.** Give the points on the subquestions and the headings add them
up; give them on the question itself when it has no subquestions.

```latex
\question{Ligne électrique}          % heading shows the sum: (3 pts)
\subquestion[1.5]{First part...}     % (a)
\subquestion[1.5]{Second part...}    % (b)

\question[2]{A question on its own}  % no subquestions: state the points here
```

`\subq` is an alias for `\subquestion`. Subquestions are lettered (a), (b),
(c) and restart with each question.

**Answer space.** All of it collapses in `solutions` mode, so the answer key
stays short.

| Command | |
| --- | --- |
| `\shortanswer` | squared paper, 3 rows |
| `\mediumanswer` | 8 rows |
| `\longanswer` | 15 rows |
| `\verylonganswer` | 25 rows |
| `\answergrid{n}` | squared paper, `n` rows |
| `\answerlines{n}` | `n` ruled lines instead |
| `\answerblank{5cm}` | plain empty space |

The grid is full text width and breaks over a page boundary, so a long answer
space near the bottom of a page continues on the next one rather than leaving
a hole. `\renewcommand{\answergridstep}{0.5}` changes the cell size, in cm.

**True/false and multiple choice.**

```latex
\begin{truefalse}
  \tfitem[0.5]{A statement to judge.}   % (a) + tick boxes + space to justify
  \tfitem[0.5]{Another one.}
\end{truefalse}

\begin{choices}
  \choice{One option}
  \choice{Another option}
\end{choices}
```

`\tfitem` points count towards the question total like subquestion points do.
`\renewcommand{\tfrows}{2}` changes how much room each item leaves for the
justification; `\tickbox` and `\truefalsebox` are available on their own.

**The answer key.** Write the expected answer next to the question, and it is
printed only when the package is loaded with `[solutions]`:

```latex
\begin{solution}
  Les pertes valent $P_\mathrm{loss} = R I^2$, d'où $V \ge 354$~kV.
\end{solution}
```

`\sol{...}` is the one-liner form. To build both PDFs from one source, add the
option on the command line rather than editing the file:

```sh
pdflatex -jobname=exam-solutions \
  "\PassOptionsToPackage{solutions}{examsheet}\input{main.tex}"
```

## Customise

Page margins: `geometry` is already loaded, so `\geometry{margin=2.5cm}` in
your preamble is enough. The default is A4 with 2 cm margins.

Labels: every fixed string is a macro, so a one-off change needs no new
language option — `\renewcommand{\exslblname}{Nom de famille}`, and likewise
`\exslblid`, `\exslblpage`, `\exslblpts`, `\exslblpt`, `\exslblq`,
`\exslbltotal`, `\exslblduration`, `\exslbldate`, `\exslblquestion`,
`\exslblsubject`, `\exslblscore`, `\exslblsol`, `\exslblkey`, `\exslbltrue`,
`\exslblfalse`, `\exslblinstr`, `\exslblmaterial`.

Blank fields to fill in by hand: `\examfield{Label}{6cm}` prints a label and a
rule of that width. It is what the header and the front page use.
