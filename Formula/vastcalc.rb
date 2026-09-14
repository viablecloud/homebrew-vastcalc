class Vastcalc < Formula
  desc "VAST storage sizing calculator (CLI + TUI), ported from a VAST NCP sizing spreadsheet"
  homepage "https://github.com/viablecloud/homebrew-vastcalc"
  url "https://github.com/viablecloud/homebrew-vastcalc/releases/download/v0.1.1/vastcalc-0.1.1-macos-universal.tar.gz"
  sha256 "a59bd189d7dbf38ba2ebd9e3e08247874dc7c38703f75ce332245a89923fb07a"
  license :cannot_represent
  version "0.1.1"

  # Precompiled universal (arm64 + x86_64) binaries — this tap ships no
  # source and builds nothing. catalog.json MUST be installed as a sibling
  # of the two binaries (same bin/ directory): both resolve it relative to
  # their own location (following the /opt/homebrew/bin symlink back to
  # the real Cellar path) whenever no path is given on the command line.
  # See this repo's README.md for the full story and the two docs/ PDFs
  # for step-by-step usage walkthroughs.

  def install
    bin.install "vastcalc_cli"
    bin.install "vastcalc_tui"
    bin.install "catalog.json"
  end

  test do
    # vastcalc_cli is a headless demo binary that runs to completion with
    # no args and no tty requirement — a real smoke test, not just an
    # existence check. It also exercises the catalog-resolution path this
    # tap depends on (finding catalog.json next to itself).
    system "#{bin}/vastcalc_cli"

    # vastcalc_tui is an ncurses TUI (initscr() requires a real tty, which
    # brew's test sandbox doesn't reliably provide) — just confirm it
    # installed as an executable rather than attempting to run it.
    assert_predicate bin/"vastcalc_tui", :executable?
  end
end
