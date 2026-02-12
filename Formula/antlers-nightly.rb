class AntlersNightly < Formula
  desc "Polyglot native dependency resolver for JVM ecosystems (nightly build)"
  homepage "https://github.com/albertocavalcante/antlers"
  version "nightly-26b16b6"
  license any_of: ["Apache-2.0", "MIT"]

  # Auto-updated by CI - do not edit manually
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-darwin-arm64.tar.gz"
      sha256 "b49990b637e848e32bf24c297de09c317d4f7e25dbdce0ceb81b2a1486a6a232"
    else
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-darwin-amd64.tar.gz"
      sha256 "84e67976f91b2a3332ccd81fbab69423441ac4948224deed2aca6c62caa6bcc4"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-linux-aarch64.tar.gz"
      sha256 "3c1c1e5025fefa2f45270975ee3eb7f4ca6dbbae4b5d9b6bffcb1d44d9f4b8ed"
    else
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-linux-amd64.tar.gz"
      sha256 "b9501f6fb6edfdad28a30619259acc4a1cd499c073e7db3ef456cc2522306100"
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
