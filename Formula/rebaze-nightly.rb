class RebazeNightly < Formula
  desc "CLI tool to migrate projects to Bazel (nightly build)"
  homepage "https://github.com/albertocavalcante/rebaze"
  version "nightly-7498b7a"
  license "Apache-2.0"

  # Private repository - requires HOMEBREW_GITHUB_API_TOKEN environment variable
  # Set it with: export HOMEBREW_GITHUB_API_TOKEN="your_github_token"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-darwin-arm64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "0a7efc84f98e9090f06821e45e7a443f34a626de8f47ae83bbce46fb083029c6"
    else
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-darwin-amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "a0751b8f736adec047ff70b61ddd330b8b7b453c7b8d4661c816697c7a703d27"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-linux-aarch64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "657593a5398e6de1dac5adfbd8ab16d6d67c4a826c202849f7dcc7cb55482770"
    else
      url "https://github.com/albertocavalcante/rebaze/releases/download/nightly/rebaze-linux-amd64.tar.gz",
          using: GitHubPrivateRepositoryReleaseDownloadStrategy
      sha256 "c5c64768960f6539527df9b45fb082938b06f9da2e6321044c519d4dcbc8b9a2"
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
