class Copybara < Formula
  desc "Tool for transforming and moving code between repositories"
  homepage "https://github.com/google/copybara"
  version "20260127-claude.native-image.1"
  license "Apache-2.0"

  # Native binaries from fork with GraalVM Native Image
  # Auto-updated by CI - do not edit manually
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-darwin-arm64.gz"
      sha256 "0fdaf8be5c3d726e9d621f76edf17c222e3e628088d3e839cb8627872b224d86"
    else
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-darwin-x64.gz"
      sha256 "c14e52f7512f4636d4d2e770b9a84289ce49442321fd14bcc12f123c75d0669f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-linux-arm64.gz"
      sha256 "2de7b6f808a5d4092f4bc9cc5595c7aeb1868a5de9435b8f67918172f25a37cd"
    else
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-linux-x64.gz"
      sha256 "827c15734c7fbbad10c9d7ad7e9411914b931bea8f9e90ee549fe8249296fe10"
    end
  end

  def install
    # The download is a gzipped binary, gunzip extracts it
    bin.install "copybara"
  end

  test do
    # Basic smoke test
    assert_match "copybara", shell_output("#{bin}/copybara --help", 2)
  end
end
