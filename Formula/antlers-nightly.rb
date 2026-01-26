class AntlersNightly < Formula
  desc "Polyglot native dependency resolver for JVM ecosystems (nightly build)"
  homepage "https://github.com/albertocavalcante/antlers"
  version "nightly"
  license any_of: ["Apache-2.0", "MIT"]

  # Auto-updated by CI - do not edit manually
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-darwin-arm64.tar.gz"
      sha256 "7a003ee177ce17d7b72be0e751e99f1fc903b24c14516c8ca1851e86115ab9e9" # darwin-arm64
    else
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-darwin-amd64.tar.gz"
      sha256 "0d3e99d77196992714d623aacf24bdde2be2400c0b2232e60448889e8dc7d1ba" # darwin-amd64
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-linux-aarch64.tar.gz"
      sha256 "515bd6246c86c65f712735cb11abc4e490b9ea3ee46be77d0256bc09ef87d01c" # linux-arm64
    else
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-linux-amd64.tar.gz"
      sha256 "1ade74fcfef9f453c9a56f38adaa1b3e1f7433c6a87afefc3d27c00f5b0bfab5" # linux-amd64
    end
  end

  conflicts_with "antlers", because: "both install `antlers` and `atl` binaries"

  def install
    bin.install "antlers"
    bin.install_symlink "antlers" => "atl"
  end

  test do
    assert_match "Native JVM dependency resolver", shell_output("#{bin}/antlers --help")
  end
end
