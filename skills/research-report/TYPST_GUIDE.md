# Typst Guide (for research-report)

**Golden rule: never invent syntax or pin a package version from memory.** If unsure, scaffold minimally, then **compile** and fix from the real error messages. Prefer conventions already in the user's file.

## Validation (do this before finishing)

```bash
typst compile report/<name>.typ        # produces the PDF; surfaces every syntax error
typst --version                        # confirm availability
```

If `typst` is not installed, say so in the CLI and offer install options (do not silently skip):
`cargo install --locked typst-cli`, your distro package, or download from the Typst releases page.
Still write valid syntax even when you cannot compile locally.

PDF text extraction (Mode A input): Read tool reads PDFs directly; for long/clean dumps use
`pdftotext -layout <file.pdf> -` (pdftotext is available on this machine).

## Minimal document skeleton

```typ
#set document(title: "Title", author: "Author")
#set page(numbering: "1")
#set par(justify: true)
#set text(lang: "pt")           // match the report language

= Introduction
Body text...
```

## LNCS template (default when user omits a template)

LNCS is distributed via Typst Universe. **Discover the real, current name/version instead of guessing** — e.g. browse https://typst.app/universe (search "lncs"/"springer") or check installed packages. A typical import looks like:

```typ
#import "@preview/<lncs-package>:<version>": lncs   // resolve the exact name+version by compiling
#show: lncs.with(
  title: "…",
  authors: (…),
  abstract: [ … ],
)
```

If the user supplied their own template file, `#import` / `#include` that file verbatim and follow its API. **Honor user-provided templates and syntax over anything here.**

## Figures and images

```typ
#figure(
  image("figures/roc_convnext.png", width: 80%),
  caption: [ROC curve — ConvNeXt ensemble.],
) <fig:roc>
```
Reference with `@fig:roc`.

## Missing-image placeholder (use when the file does not exist)

```typ
#figure(
  rect(width: 80%, height: 5cm, stroke: 1pt + gray)[
    #align(center + horizon)[*[PLACEHOLDER]* Missing: <what it should show> \
    Obtain via: <script / notebook / command>]
  ],
  caption: [PLACEHOLDER — replace with real figure.],
) <fig:placeholder-name>
```
Track every placeholder and list them in the final CLI message (what + how to obtain).

## Tables

```typ
#figure(
  table(
    columns: 3,
    table.header[Model][Accuracy][AUC],
    [ConvNeXt], [0.91], [0.96],
  ),
  caption: [Results.],
) <tab:results>
```

## Citations and bibliography

```typ
// refs.bib in BibTeX format
Prior work @vaswani2017.
#bibliography("refs.bib", style: "springer-lecture-notes-in-computer-science")
```
Only cite sources that exist; do not invent references. If a citation is needed but unknown, leave
`// [audit] citation needed: <claim>` rather than fabricating an entry.

## Common pitfalls

- Math goes in `$ … $`; multi-letter names need spacing/quotes: `$"acc"_"val"$`, `$alpha$`.
- Code blocks: ```` ```python … ``` ````.
- Strings use `"`; content blocks use `[ … ]`.
- A `#show: template.with(...)` rule must come before body content.
- Compile-driven development: when an import/style fails, read the error and adjust — don't guess repeatedly.
