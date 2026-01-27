class RebazeNightly < Formula
  desc "CLI tool to migrate projects to Bazel (nightly build)"
  homepage "https://github.com/albertocavalcante/rebaze"
  version "nightly"
  license "Apache-2.0"

  # Auto-updated by CI - do not edit manually
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-darwin-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000001" # darwin-arm64
    else
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-darwin-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000002" # darwin-amd64
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-linux-aarch64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000003" # linux-arm64
    else
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-linux-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000004" # linux-amd64
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
