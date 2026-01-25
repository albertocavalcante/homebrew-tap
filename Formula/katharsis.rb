class Katharsis < Formula
  desc "macOS menu bar app that purifies external drives of AppleDouble metadata"
  homepage "https://github.com/albertocavalcante/katharsis"
  version "0.1.0"
  license "MIT"

  depends_on :macos

  on_macos do
    url "https://github.com/albertocavalcante/katharsis/releases/download/v#{version}/katharsis-darwin-universal.tar.gz"
    # TODO: Update SHA256 after first release
    # Run: shasum -a 256 katharsis-darwin-universal.tar.gz
    sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  end

  def install
    bin.install "katharsis"
  end

  test do
    assert_match "katharsis", shell_output("#{bin}/katharsis --help", 2)
  end
end
