class Bossa < Formula
  desc "Unified CLI for managing dev environment - workspaces, refs, packages"
  homepage "https://github.com/albertocavalcante/bossa"
  version "0.1.0"
  license "MIT"

  depends_on arch: :arm64
  depends_on :macos

  url "https://github.com/albertocavalcante/bossa/releases/download/v#{version}/bossa-darwin-arm64.tar.gz"
  sha256 "e24bce27338aea8291858dbde10e581d47be9ce9c745c4c61eaeb2f01ef6e159"

  def install
    bin.install "bossa"
  end

  test do
    system "#{bin}/bossa", "--version"
  end
end
