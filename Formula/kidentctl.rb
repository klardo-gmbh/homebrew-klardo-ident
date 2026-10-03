# Rendered and published by scripts/sync-homebrew-tap.sh onto
# klardo-gmbh/homebrew-klardo-ident (docs/24-public-quickstart-repo.md §3.2).
# Nobody edits the tap directly: a push from here overwrites this one file.
class Kidentctl < Formula
  desc "Admin CLI for KlardoIdent, an OAuth 2.0 / OpenID Connect authorization server"
  homepage "https://klardo-ident.com"
  version "0.5.5"
  license "Proprietary"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/klardo-gmbh/klardo-ident/releases/download/v0.5.5/kident_v0.5.5_darwin-arm64.tar.gz"
      sha256 "ffa6750dae7051751bfb7a6b0e383266c29edd10354bc133a1d8e5e9ded266b1"
    else
      odie "kidentctl publishes an Apple Silicon build only; install the Linux binary under Rosetta, or ask about an Intel build."
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/klardo-gmbh/klardo-ident/releases/download/v0.5.5/kident_v0.5.5_linux-arm64.tar.gz"
      sha256 "6c6436c164708759357ad8d789f12de4a1c8ebaa7cff920e7e514b1cb611739c"
    else
      url "https://github.com/klardo-gmbh/klardo-ident/releases/download/v0.5.5/kident_v0.5.5_linux-amd64.tar.gz"
      sha256 "80aad58ad23fe38dcaff7901afcd95ae8cd5880ff4c8b7bfe3212ab6f6d9d0c7"
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
