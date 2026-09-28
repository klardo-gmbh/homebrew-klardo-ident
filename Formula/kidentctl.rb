# Rendered and published by scripts/sync-homebrew-tap.sh onto
# klardo-gmbh/homebrew-klardo-ident (docs/24-public-quickstart-repo.md §3.2).
# Nobody edits the tap directly: a push from here overwrites this one file.
class Kidentctl < Formula
  desc "Admin CLI for KlardoIdent, an OAuth 2.0 / OpenID Connect authorization server"
  homepage "https://klardo-ident.com"
  version "0.5.4"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/klardo-gmbh/klardo-ident/releases/download/v0.5.4/kident_v0.5.4_darwin-arm64.tar.gz"
      sha256 "513c457de90676d549107cabe5b079e08e647e363b0114e11815a4a2a37a1335"
    else
      odie "kidentctl publishes an Apple Silicon build only; install the Linux binary under Rosetta, or ask about an Intel build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/klardo-gmbh/klardo-ident/releases/download/v0.5.4/kident_v0.5.4_linux-arm64.tar.gz"
      sha256 "7c25d312d0b0da42814ea82d04fd2891fc37f6a7354e1156cde6c6905b666452"
    else
      url "https://github.com/klardo-gmbh/klardo-ident/releases/download/v0.5.4/kident_v0.5.4_linux-amd64.tar.gz"
      sha256 "cff2e918ad96db4105e1e27713a2d6cbe737e532cd6b523f9a08b5cb1e3c4338"
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
