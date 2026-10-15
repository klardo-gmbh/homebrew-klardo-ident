# Rendered and published by scripts/sync-homebrew-tap.sh onto
# klardo-gmbh/homebrew-klardo-ident (docs/24-public-quickstart-repo.md §3.2).
# Nobody edits the tap directly: a push from here overwrites this one file.
class Kidentctl < Formula
  desc "Admin CLI for KlardoIdent, an OAuth 2.0 / OpenID Connect authorization server"
  homepage "https://klardo-ident.com"
  version "0.5.7"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/klardo-gmbh/klardo-ident/releases/download/v0.5.7/kident_v0.5.7_darwin-arm64.tar.gz"
      sha256 "ba01b8787c35aa5afadf68c4075dc7c4a7ff638bbb947f79a36f060b2b20186b"
    else
      odie "kidentctl publishes an Apple Silicon build only; install the Linux binary under Rosetta, or ask about an Intel build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/klardo-gmbh/klardo-ident/releases/download/v0.5.7/kident_v0.5.7_linux-arm64.tar.gz"
      sha256 "d1d2c9510a8a6d84b39b51e1e247bdd5d8880f7a5963ed11131a8b99f47f7a79"
    else
      url "https://github.com/klardo-gmbh/klardo-ident/releases/download/v0.5.7/kident_v0.5.7_linux-amd64.tar.gz"
      sha256 "34f21d36ed71ea65562ce859ddc55075e636784d34d81427211aed29f913ea69"
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
