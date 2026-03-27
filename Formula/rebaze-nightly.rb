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
      sha256 "407e2f117fd9dadf9571345b0a12e391b6080ef5a21ca773203cf60733c01890"
    else
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-darwin-amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "58dac16e95d21edf7d126826bc53606e212e3517dc51b497537fe61e9cbb94c9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-linux-aarch64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "b3058e6e503376800750393a24f16d196b427b8cf81df286e784a22a3fc9787f"
    else
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-linux-amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "9e68906a78f078b7692ae6e3b7143591b6bd19fd171eb36246273a1c190629ef"
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
