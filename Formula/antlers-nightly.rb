class AntlersNightly < Formula
  desc "Polyglot native dependency resolver for JVM ecosystems (nightly build)"
  homepage "https://github.com/albertocavalcante/antlers"
  version "nightly-26b16b6"
  license any_of: ["Apache-2.0", "MIT"]

  # Auto-updated by CI - do not edit manually
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-darwin-arm64.tar.gz"
      sha256 "179c80ef2a317040be7442139feb112d64ffc49e7647bca12585871e6475f56c"
    else
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-darwin-amd64.tar.gz"
      sha256 "f908d2ddeca440b23544e134ca5baa55df16075323090cc2c384e06f71707c6b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-linux-aarch64.tar.gz"
      sha256 "beba1ed1bde2216c10b4720af565df56071cacedb43f3c8ce49f81bddb230a4a"
    else
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-linux-amd64.tar.gz"
      sha256 "f830ef5f09c15f7fbd78c7d0e3c6774777052ab1403a5359fedc56763364ec64"
    end
  end

  conflicts_with "antlers", because: "both install `antlers` and `atl` binaries"

  def install
    bin.install "antlers"
    bin.install_symlink "antlers" => "atl"
  end

  test do
    assert_match "antlers", shell_output("#{bin}/antlers --version")
  end
end
