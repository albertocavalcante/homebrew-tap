class Copybara < Formula
  desc "Tool for transforming and moving code between repositories"
  homepage "https://github.com/google/copybara"
  version "20260127-alberto.native-image.3"
  license "Apache-2.0"

  # Native binaries from fork with GraalVM Native Image
  # Auto-updated by CI - do not edit manually
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-darwin-arm64.gz"
      sha256 "f7053c621b231ec186f50da672e0d733daca90f867cdf79a398031ee4faf1035"
    else
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-darwin-x64.gz"
      sha256 "ef1c9ab58d7aa04d9a943107785d4381d6ee5a1d1482baf10d4fe8b6421e2e84"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-linux-arm64.gz"
      sha256 "91dae90fe9720cc96ab67c6e72ebfe62379c2421ddd7177443debc3ce0e7b0ab"
    else
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-linux-x64.gz"
      sha256 "7c3568554f8aa35998499784c8c454c6bbf35d5c33f7ed0796c68b9b598005bf"
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
