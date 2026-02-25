class AntlersNightly < Formula
  desc "Polyglot native dependency resolver for JVM ecosystems (nightly build)"
  homepage "https://github.com/albertocavalcante/antlers"
  version "nightly-26b16b6"
  license any_of: ["Apache-2.0", "MIT"]

  # Auto-updated by CI - do not edit manually
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-darwin-arm64.tar.gz"
      sha256 "d17f222eddc624c0779e5fc9d5843ac876f7863c3eeae613db152ff68956d053"
    else
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-darwin-amd64.tar.gz"
      sha256 "2eb57aacd681b2c2356765b2c2be15f6589b2a302435ba862449bf5d29b569df"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-linux-aarch64.tar.gz"
      sha256 "c0bf00208842157c70ee56e0fa2e758d00797dbd82762123ec716944e01a1dfe"
    else
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-linux-amd64.tar.gz"
      sha256 "2ff3f8a581f758a532def7b44b7a75a419d9e6246b000f6e943da0ab8315a57c"
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
