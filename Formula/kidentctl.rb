# Rendered and published by scripts/sync-homebrew-tap.sh onto
# klardo-gmbh/homebrew-klardo-ident (docs/24-public-quickstart-repo.md §3.2).
# Nobody edits the tap directly: a push from here overwrites this one file.
class Kidentctl < Formula
  desc "Admin CLI for KlardoIdent, an OAuth 2.0 / OpenID Connect authorization server"
  homepage "https://klardo-ident.com"
  version "0.5.6"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/klardo-gmbh/klardo-ident/releases/download/v0.5.6/kident_v0.5.6_darwin-arm64.tar.gz"
      sha256 "2d57355c58802b740c612e9a657bd618e9b132df068b3ccf15d8a4c3137fb2a3"
    else
      odie "kidentctl publishes an Apple Silicon build only; install the Linux binary under Rosetta, or ask about an Intel build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/klardo-gmbh/klardo-ident/releases/download/v0.5.6/kident_v0.5.6_linux-arm64.tar.gz"
      sha256 "c7a5027c3392d65c4380ccc7ec352eec1b6d5f7709707e32854f101e2b626463"
    else
      url "https://github.com/klardo-gmbh/klardo-ident/releases/download/v0.5.6/kident_v0.5.6_linux-amd64.tar.gz"
      sha256 "111360e5a511d726ad6e924af0e4ce5829e08e7378368b279d273c1043720abc"
    end
  end

  def install
    # The tarball's one top-level directory (kident_vX.Y.Z_<goos>-<goarch>/) is
    # what Homebrew stages into and changes into automatically, so the path
    # here is relative to its contents, not to the tarball root.
    bin.install "kidentctl"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/kidentctl --version")
  end
end
