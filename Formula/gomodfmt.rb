class Gomodfmt < Formula
  desc "Opinionated formatter for go.mod files"
  homepage "https://github.com/albertocavalcante/gomodfmt"
  url "https://github.com/albertocavalcante/gomodfmt.git",
      tag:      "v0.1.0",
      revision: "93597de50224a6aedc77af6c47cf315728e4697c"
  license "MIT"
  head "https://github.com/albertocavalcante/gomodfmt.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/gomodfmt"
  end

  test do
    (testpath/"go.mod").write <<~EOS
      module test

      go 1.24

      require (
        github.com/zzz/pkg v1.0.0
        github.com/aaa/pkg v1.0.0
      )
    EOS

    system bin/"gomodfmt", "-w", "go.mod"
    assert_match "github.com/aaa/pkg", (testpath/"go.mod").read
  end
end
