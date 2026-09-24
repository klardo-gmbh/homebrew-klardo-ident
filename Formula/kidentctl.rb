# Rendered and published by scripts/sync-homebrew-tap.sh onto
# klardo-gmbh/homebrew-klardo-ident (docs/24-public-quickstart-repo.md §3.2).
# Nobody edits the tap directly: a push from here overwrites this one file.
class Kidentctl < Formula
  desc "Admin CLI for KlardoIdent, an OAuth 2.0 / OpenID Connect authorization server"
  homepage "https://klardo-ident.com"
  version "0.5.3"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/klardo-gmbh/klardo-ident/releases/download/v0.5.3/kident_v0.5.3_darwin-arm64.tar.gz"
      sha256 "842ebbeab44b5fdd58493046a7f7ded3eab1501fd295ed6b18fdf9c36451ed3f"
    else
      odie "kidentctl publishes an Apple Silicon build only; install the Linux binary under Rosetta, or ask about an Intel build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/klardo-gmbh/klardo-ident/releases/download/v0.5.3/kident_v0.5.3_linux-arm64.tar.gz"
      sha256 "277677454cf3dd2d72b25443446b17ecc0eabdfb146af13a796c3a0095d1dce7"
    else
      url "https://github.com/klardo-gmbh/klardo-ident/releases/download/v0.5.3/kident_v0.5.3_linux-amd64.tar.gz"
      sha256 "8cf577d4258d859d76b94870a460e6f935bb946751e8399fba89c0476b15c7ca"
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
