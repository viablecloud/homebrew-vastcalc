# homebrew-vastcalc

Homebrew tap for **VASTCalc** — a VAST storage sizing calculator (ported
from a VAST NCP sizing spreadsheet) with two tools:

- **`vastcalc_cli`** — headless demo binary; prints a sizing table for a
  fixed example scenario across a sweep of rack counts and exits. Useful
  for scripting or a quick sanity check.
- **`vastcalc_tui`** — an interactive terminal UI with five screens:
  - **Design Advisor** (customer-facing): state a GPU platform, GPU count,
    power cap, and workload profile in plain terms — the tool picks the
    EBox hardware automatically (no part number ever entered), validated
    against NVIDIA reference-architecture anchor points (NCP Standard,
    NCP Enhanced, DGX-C), and can generate a physical rack layout for the
    result.
  - **EBox Sizing** (storage-expert-facing, NCP platform): pick EBox type,
    SSD density, workload profile, and GPU platform directly; see the
    sizing table (GPUs, EBoxes, power, licensed capacity, read/write
    bandwidth) recompute live.
  - **C&D Sizing** (storage-expert-facing, Ceres v2 / CBox+DBox platform):
    the same style of direct sizing table for the C&D hardware line.
  - **Rack Diagram**: hand-place devices into a 42U rack elevation and see
    live RU/kg/W totals, with 2U-device extension handled automatically.
  - **Glossary**: reference definitions for the domain terms the other
    screens use.

Two full, screenshotted walkthroughs are included:

- **[docs/VASTCalc_TUI_Playbook.pdf](docs/VASTCalc_TUI_Playbook.pdf)** —
  SE-facing forward sizing: a customer requirement sized directly in EBox
  Sizing, then laid out physically in Rack Diagram, with both screens'
  numbers cross-checked against each other.
- **[docs/VASTCalc_DesignAdvisor_Playbook.pdf](docs/VASTCalc_DesignAdvisor_Playbook.pdf)**
  — customer-facing inverse sizing through Design Advisor, including a
  deliberate wrong turn (an invalid NVIDIA reference-architecture
  combination) and the guardrail rejecting it with an explanation.

## Install

```bash
brew tap viablecloud/vastcalc
brew install vastcalc
```

```bash
vastcalc_cli          # headless demo table
vastcalc_tui          # interactive terminal UI
```

## What this tap is (and isn't)

This tap distributes **precompiled universal binaries only** (Apple
Silicon + Intel, verified on both) plus the SKU catalog data they need at
runtime — it builds nothing from source, and the underlying source code
is not published here or anywhere public. `Formula/vastcalc.rb` downloads
a binary release tarball from this same repo's
[Releases](../../releases) page; there's no `cmake`/compiler dependency
for anyone installing it.

**No GUI in this release**: VASTCalc also has a Qt-based GUI, but it has
never been built or verified (no Qt install in the environment this was
packaged from) — this release ships the CLI and TUI only, which cover the
same sizing/rack-layout functionality.

**License / distribution terms**: no license is declared for this
binary distribution — all rights reserved by default. This tap exists to
make an internally-developed tool conveniently installable; it is not an
open-source release.

## Requirements

macOS only (uses `ncurses`/`curses`, provided by the OS — no extra
dependency needed). Both Apple Silicon (arm64) and Intel (x86_64) are
supported via a single universal binary.

## Version history

- **v0.1.0** — first release: Design Advisor, EBox Sizing, C&D Sizing,
  Rack Diagram, and Glossary screens, plus `vastcalc_cli`.
