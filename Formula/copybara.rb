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
    sha256 "55f0825fc70a05e4b2745457388b52f7b54de66e875f1de8381f8af4db5336dd"
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-linux-arm64.gz"
      sha256 "46ee60ec2ecca48591f3a85cc9a5e52a313518776fe4d25eb97cde82e1e74ec2"
    else
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-linux-x64.gz"
      sha256 "b86c01cbe92a33e68d4ff7e90e44b168edc36612b009aeb4ad9ca7ff5f14c6b2"
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
