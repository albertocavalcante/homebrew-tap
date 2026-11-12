class RebazeNightly < Formula
  desc "CLI tool to migrate projects to Bazel (nightly build)"
  homepage "https://github.com/albertocavalcante/rebaze"
  version "nightly-87a8a40"
  license "Apache-2.0"

  # Private repository - requires HOMEBREW_GITHUB_API_TOKEN environment variable
  # Set it with: export HOMEBREW_GITHUB_API_TOKEN="your_github_token"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-darwin-arm64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "43919b1a75ef2401fdf7012703f7e87b68058877c91e1ef1599fc9eb130e0967"
    else
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-darwin-amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "faefb20496c13e4b5ce6796e6f40e500703fa24756ec82ef1834e859ac6cab62"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-linux-aarch64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "747f81cef8516ff4a54b97723d0e4d2237ac192a4a18b979ddd8d48f9aad4075"
    else
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-linux-amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "7528f84e0d53148ca312c3128afa98caa57bb4d3c3fee847ead040c611679302"
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
