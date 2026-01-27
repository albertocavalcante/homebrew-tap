class Rebaze < Formula
  desc "CLI tool to migrate projects to Bazel"
  homepage "https://github.com/albertocavalcante/rebaze"
  url "https://github.com/albertocavalcante/rebaze.git",
      revision: "f9e2e5bccd98dc1fb655780283897cdc14c74543"
  version "0.1.0"
  license "Apache-2.0"
  head "https://github.com/albertocavalcante/rebaze.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/rebaze-cli")
  end

  test do
    assert_match "rebaze", shell_output("#{bin}/rebaze --version")
  end
end
