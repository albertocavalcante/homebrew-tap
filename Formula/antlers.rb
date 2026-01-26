class Antlers < Formula
  desc "Polyglot native dependency resolver for JVM ecosystems"
  homepage "https://github.com/albertocavalcante/antlers"
  url "https://github.com/albertocavalcante/antlers.git",
      revision: "8e0a523950a10817b4ea41320bd0e5acf2deac5a"
  version "0.1.0"
  license any_of: ["Apache-2.0", "MIT"]
  head "https://github.com/albertocavalcante/antlers.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/antlers-cli")
    bin.install_symlink "antlers" => "atl"
  end

  test do
    assert_match "Native JVM dependency resolver", shell_output("#{bin}/antlers --help")
  end
end
