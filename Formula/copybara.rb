class Copybara < Formula
  desc "Tool for transforming and moving code between repositories"
  homepage "https://github.com/google/copybara"
  version "20250127-test.5"
  license "Apache-2.0"

  # Native binaries from fork with GraalVM Native Image
  # Auto-updated by CI - do not edit manually
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-darwin-arm64.gz"
      sha256 "9c9c4bbb483b91733f60ab20168af49402fb36eed715fcd1b4a8ad9f0e52263d"
    else
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-darwin-x64.gz"
      sha256 "34e2e97dce64988f64f4ecd252fdb1485f7b415c5ac10a4b1d30afc48ec080d1"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-linux-arm64.gz"
      sha256 "c72f35a99a3f06153620ae8222b3a36695e7d33e19b4d60dee655a563aef1632"
    else
      url "https://github.com/albertocavalcante/fork-copybara/releases/download/v#{version}/copybara-linux-x64.gz"
      sha256 "149a3d847ca52f69097e74e3e9db5683061e6d7dba21ee496ae0906ec0866ab7"
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
