class Slack < Formula
  desc "CLI using xoxc/cookie browser session auth"
  homepage "https://github.com/albertocavalcante/slack-cli"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/albertocavalcante/slack-cli/releases/download/v#{version}/slack-darwin-arm64.tar.gz"
      sha256 "dea10ee66bea306990ef508d9fe0596b5e3e6079b985c1717ddd40ffda2d5e67"
    end
    on_intel do
      url "https://github.com/albertocavalcante/slack-cli/releases/download/v#{version}/slack-darwin-amd64.tar.gz"
      sha256 "7412e88d4701a364a1262acd92f71286992b0c1f2f3da9468ce31ed2a45171e3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/albertocavalcante/slack-cli/releases/download/v#{version}/slack-linux-arm64.tar.gz"
      sha256 "bfa3c4d5bc01dcec789dd20e4b9a98159e70c72a02ea13fd0e3909c52febb3b4"
    end
    on_intel do
      url "https://github.com/albertocavalcante/slack-cli/releases/download/v#{version}/slack-linux-amd64.tar.gz"
      sha256 "5202b534214a5b936fd25a341dc4c072ff3c2ebbcc902e342cfc5978b18c2859"
    end
  end

  def install
    bin.install "slack"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/slack --version")
  end
end
