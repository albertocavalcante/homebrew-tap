class Bossa < Formula
  desc "Unified CLI for managing dev environment - workspaces, refs, packages"
  homepage "https://github.com/albertocavalcante/bossa"
  version "0.3.0"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  url "https://github.com/albertocavalcante/bossa/releases/download/v#{version}/bossa-darwin-arm64.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"

  def install
    bin.install "bossa"
  end

  test do
    system "#{bin}/bossa", "--version"
  end
end
