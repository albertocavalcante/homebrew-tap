class Copybara < Formula
  desc "Tool for transforming and moving code between repositories"
  homepage "https://github.com/google/copybara"
  version "20260127-alberto.native-image.2"
  license "Apache-2.0"

  # Native binaries from fork with GraalVM Native Image
  # Auto-updated by CI - do not edit manually
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-darwin-arm64.gz"
      sha256 "c45e2758ac0242b43e46a1b2fcecb7b4593ebb770bbf14738d48ad024ed43858"
    else
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-darwin-x64.gz"
      sha256 "aafee57c2eae7f8e29d5eea17e2b35d9d45bbe6bf7c015eb0e625615f9b3b454"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-linux-arm64.gz"
      sha256 "832f08c628bab18b789cce8f694086e80814eaeb448e18379b885a9e218482b7"
    else
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-linux-x64.gz"
      sha256 "97fdd30c895bc92bd5bd3a0b932a91911cc11048b6823ae266d5afb612bb4ec9"
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
