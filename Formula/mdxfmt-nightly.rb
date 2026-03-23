class MdxfmtNightly < Formula
  desc "MDX/Markdown formatter (nightly build)"
  homepage "https://github.com/albertocavalcante/mdxfmt"
  version "nightly"
  license "MIT"

  # Auto-updated by CI - do not edit manually
  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/mdxfmt/releases/download/nightly/mdxfmt-darwin-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/albertocavalcante/mdxfmt/releases/download/nightly/mdxfmt-darwin-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/albertocavalcante/mdxfmt/releases/download/nightly/mdxfmt-linux-arm64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    else
      url "https://github.com/albertocavalcante/mdxfmt/releases/download/nightly/mdxfmt-linux-amd64.tar.gz"
      sha256 "0000000000000000000000000000000000000000000000000000000000000000"
    end
  end

  def install
    bin.install "mdxfmt"
  end

  test do
    (testpath/"test.md").write <<~MARKDOWN
      #  Hello

      World
    MARKDOWN

    system bin/"mdxfmt", "-w", "test.md"
    assert_match "# Hello", (testpath/"test.md").read
  end
end
