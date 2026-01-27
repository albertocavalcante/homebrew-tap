class RebazeNightly < Formula
  desc "CLI tool to migrate projects to Bazel (nightly build)"
  homepage "https://github.com/albertocavalcante/rebaze"
  version "nightly-7eff68c"
  license "Apache-2.0"

  # Auto-updated by CI - do not edit manually
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-darwin-arm64.tar.gz"
      sha256 "63eeb26023e39fcb98a3f95a70e54921af5527cf5cff8a44de76fe0fea679cb6"
    else
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-darwin-amd64.tar.gz"
      sha256 "1536a59ace5a3c96de5d24134beb0b8e564938d288048c4a9e4a919874529f9c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-linux-aarch64.tar.gz"
      sha256 "f60feba929afcb25c8fee8d7616cb374770994f65813e063eba76f3685950244"
    else
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-linux-amd64.tar.gz"
      sha256 "062db0e90583a6e64b357a0f27c9c43b11ebcb8d5adc2e66fc523bebf6572ab9"
    end
  end

  conflicts_with "rebaze", because: "both install rebaze binary"

  def install
    bin.install "rebaze"
  end

  test do
    assert_match "rebaze", shell_output("#{bin}/rebaze --version")
  end
end
