class AntlersNightly < Formula
  desc "Polyglot native dependency resolver for JVM ecosystems (nightly build)"
  homepage "https://github.com/albertocavalcante/antlers"
  version "nightly-26b16b6"
  license any_of: ["Apache-2.0", "MIT"]

  # Auto-updated by CI - do not edit manually
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-darwin-arm64.tar.gz"
      sha256 "8b26e55d2edee58aa53558053821a85b5dfe94deeb97c97a2a2b4534c2881a92"
    else
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-darwin-amd64.tar.gz"
      sha256 "ad735640f83a940c079fb14a42dd999fba51cb591410d257368403ace54fa004"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-linux-aarch64.tar.gz"
      sha256 "bc93f80e74149ac6f9181fcd53f9ff8c9beb91bab35c28ae81f282c242d37f69"
    else
      url "https://github.com/albertocavalcante/antlers/releases/download/nightly/antlers-linux-amd64.tar.gz"
      sha256 "c1bc54a17455402f137640f4d97000e9128fea504d3943105aaff81066dface1"
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
