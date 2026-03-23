class Tfc < Formula
  desc "Automation CLI for HCP Terraform and Terraform Cloud"
  homepage "https://github.com/albertocavalcante/tfc"
  url "https://github.com/albertocavalcante/tfc.git",
      revision: "f3a1a2754fd2407a5c223837a15717662a79f157"
  version "0.1.0"
  license "MIT"
  head "https://github.com/albertocavalcante/tfc.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "./cmd/tfc"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/tfc help")
  end
end
