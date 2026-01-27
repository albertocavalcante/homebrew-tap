class Copybara < Formula
  desc "Tool for transforming and moving code between repositories"
  homepage "https://github.com/google/copybara"
  version "20260127-alberto.native-image.4"
  license "Apache-2.0"

  # Native binaries from fork with GraalVM Native Image
  # Auto-updated by CI - do not edit manually
  on_macos do
    # Only Apple Silicon supported - Intel Macs can use Rosetta 2
    url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-darwin-arm64.gz"
    sha256 "aeba6ec9f30243eb672a51d3b167cf2c732148161e9b509094384a8407a6802c"
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-linux-arm64.gz"
      sha256 "6ecde34d45d0acd9b1213bd751a557b9aeab5984067fe2e29a70fc5e366b4c0a"
    else
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-linux-x64.gz"
      sha256 "55de3f4173fe1ce83f459dd01fcc7e7df71701dc539ea7ce63368665887b0ea0"
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
