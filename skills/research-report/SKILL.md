---
name: research-report
description: Audits an academic report (Typst or PDF) against the open project's source code to surface inconsistencies and propose expert, master's-level corrections — or authors a brand-new Typst report from scratch when none is supplied. Use when the user mentions a relatório/report, a .typ or PDF file, asks to compare a report against code, requests a Typst/LNCS report, or wants report review, correction, or generation.
---

# Research Report — Audit & Authoring

Act as a researcher holding a **master's degree in the report's topic**: precise, evidence-driven, and critical. You either (A) review an existing report against the code, or (B) write a new one. The final output is always a complete report file — never a loose list of comments.

## Step 0 — Detect mode

- A **.typ or PDF path is given, or a report file exists** in the project (look in `report/`, `docs/`, `paper/`, repo root) → **Mode A (Audit)**.
- **Nothing exists / user asks for a new report** → **Mode B (Author)**.

If genuinely ambiguous, ask once. Otherwise proceed.

## Iron rules (both modes)

1. **Never invent syntax preferences.** Use only: (a) the template/syntax the user explicitly states, (b) conventions already present in their report, (c) documented defaults from [TYPST_GUIDE.md](TYPST_GUIDE.md). If a template is omitted, default to **LNCS**. Do not guess package versions or invent commands — verify (see TYPST_GUIDE.md "Validation").
2. **Match the report's language** (the user writes in Portuguese — keep PT unless the existing report is in another language).
3. **Ground every claim in the actual code.** No metric, hyperparameter, architecture, or filename goes in the report unless it is read from the source, configs, notebooks, or output logs. Cite where you found it.
4. **Always end** with a **Conclusion** and **Future Work** section that explicitly lists improvements, strengths, and weaknesses of the solution.
5. **Missing images → leave a clearly-labelled placeholder** in the report (see TYPST_GUIDE.md). Never fabricate a figure. Collect every gap and report it in the CLI at the end (Step Final).
6. **Output is a file**: the corrected report (Mode A) or the new report (Mode B), saved as `.typ`.

## Mode A — Audit an existing report

1. **Extract content.** `.typ` → Read directly. PDF → Read tool, or for long/clean text run `pdftotext -layout <file.pdf> -`. Capture the report's claims: architecture, methods, datasets, hyperparameters, metrics/results, figures, file references.
2. **Survey the code.** Explore `src/`, `models/`, `scripts/`, `config*.yaml`, `notebooks/`, `experiments/`, `outputs/`. Build a ground-truth picture of what was actually implemented and measured.
3. **Diff claims vs. reality.** Flag each inconsistency: wrong numbers, renamed/removed components, methods described but not implemented (or vice-versa), stale results, mismatched dataset splits, broken figure/file references.
4. **Apply corrections in place**, preserving the user's existing syntax/style exactly. For each non-trivial fix leave a short Typst comment `// [audit] <what & why>` so the user can review.
5. **Improve as an expert**: tighten the narrative, fix methodology gaps, strengthen the conclusion/future-work. Do not change the meaning of correct content.
6. Ensure the report ends with Conclusion + Future Work (Iron rule 4); add it if absent.

## Mode B — Author a new report

Tell the **story of how the final solution was reached**, then explain it — not a dry feature dump. Suggested arc (adapt to topic): Introduction & problem → Background/related work → Initial approach and *why it fell short* → Iterations/experiments that led to the final design → Final method explained → Results & analysis → **Conclusion + Future Work** (improvements, strengths, weaknesses).

1. Confirm the **template** (default LNCS) and scaffold per [TYPST_GUIDE.md](TYPST_GUIDE.md).
2. Reconstruct the journey from **git history, code, configs, notebooks, and output logs** — derive the real experiments and numbers; never invent results.
3. Write the narrative report, inserting real figures where available and placeholders where not.
4. Save as `report/<name>.typ` (or the path the user gives).

## Step Final — Validate & report gaps in the CLI

- Validate syntax: `typst compile <file.typ>` if available (see TYPST_GUIDE.md for install/fallback). Fix errors before finishing.
- In your CLI reply, give a short **changelog** (Mode A: inconsistencies found + fixes; Mode B: structure produced) and a **"Missing images"** list: each placeholder, what it should show, and exactly how to obtain it (which script/notebook to run, which command, or what to plot).

See [TYPST_GUIDE.md](TYPST_GUIDE.md) for Typst/LNCS syntax, figures, citations, placeholders, and validation.
