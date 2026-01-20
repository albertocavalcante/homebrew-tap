class Bazelle < Formula
  desc "Polyglot Gazelle CLI for Bazel BUILD file generation"
  homepage "https://github.com/albertocavalcante/bazelle"
  version "0.1.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/albertocavalcante/bazelle/releases/download/v#{version}/bazelle-darwin-arm64.tar.gz"
      sha256 "TBD_DARWIN_ARM64_SHA256"
    end
    on_intel do
      url "https://github.com/albertocavalcante/bazelle/releases/download/v#{version}/bazelle-darwin-amd64.tar.gz"
      sha256 "TBD_DARWIN_AMD64_SHA256"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/albertocavalcante/bazelle/releases/download/v#{version}/bazelle-linux-arm64.tar.gz"
      sha256 "TBD_LINUX_ARM64_SHA256"
    end
    on_intel do
      url "https://github.com/albertocavalcante/bazelle/releases/download/v#{version}/bazelle-linux-amd64.tar.gz"
      sha256 "TBD_LINUX_AMD64_SHA256"
    end
  end

  def install
    bin.install "bazelle"
  end

  test do
    # Basic smoke test - bazelle should print help without errors
    system "#{bin}/bazelle", "--help"
  end
end
