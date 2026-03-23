class Reapictl < Formula
  desc "Provider-neutral CLI for debugging Remote Execution API deployments"
  homepage "https://github.com/albertocavalcante/reapictl"
  url "https://github.com/albertocavalcante/reapictl.git",
      revision: "4af0db99edaab248a5da5a5f18a2e4ca92695677"
  version "0.1.0"
  head "https://github.com/albertocavalcante/reapictl.git", branch: "main"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w"), "."
  end

  test do
    assert_match "version=", shell_output("#{bin}/reapictl version")
  end
end
