class Copybara < Formula
  desc "Tool for transforming and moving code between repositories"
  homepage "https://github.com/google/copybara"
  version "20260127"
  license "Apache-2.0"

  # Native binaries from fork with GraalVM Native Image
  # Auto-updated by CI - do not edit manually
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-darwin-arm64.gz"
      sha256 "7716e7c5ec4094c3332ed8f7cfe18a3ddd398e422a28bc1f703d460990360d2f"
    else
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-darwin-x64.gz"
      sha256 "f5c132fd78b7c9c7a93a403ba2c679a2b7eadeb84cd253d3286ad16333b1b97b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-linux-arm64.gz"
      sha256 "944f4f313619062941fe5a57164f08f207d7e3bd28f54eaa12b6566b47ad97a4"
    else
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-linux-x64.gz"
      sha256 "6760653d5ffbdb8515faf75d30ecd06b3a2fc4a7683a6c4a0640a88c5f8e79c1"
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
