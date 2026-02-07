class RebazeNightly < Formula
  desc "CLI tool to migrate projects to Bazel (nightly build)"
  homepage "https://github.com/albertocavalcante/rebaze"
  version "nightly-01e93b9"
  license "Apache-2.0"

  # Private repository - requires HOMEBREW_GITHUB_API_TOKEN environment variable
  # Set it with: export HOMEBREW_GITHUB_API_TOKEN="your_github_token"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-darwin-arm64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "3a69f9ed2d5931f7b30611c24e77f3f0b4cd8cf2e4e57d42987cecb38d953ee6"
    else
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-darwin-amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "fa38bf501353c467a5226823d7cd6d166c94d13b6c76707ffe0dbb4503e9f423"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-linux-aarch64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "aeebd709d4824cd7e936edb6d6e88715dc6066ed1226978211717e98d7d837ac"
    else
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-linux-amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "35e73a8f2225c9bd5d04c3f1daae603cc0ddd28c44d5e1530e545625972a3b52"
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
