class Gls < Formula
  desc "Modern Groovy Language Server (GLS)"
  homepage "https://github.com/albertocavalcante/groovy-devtools"
  url "https://github.com/albertocavalcante/groovy-devtools/releases/download/v0.3.0/gls-0.3.0-generic.jar"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "Apache-2.0"

  depends_on "openjdk@17"

  def install
    libexec.install "gls-#{version}-generic.jar"
    bin.write_jar_script libexec/"gls-#{version}-generic.jar", "gls", java_version: "17"
  end

  test do
    output = shell_output("#{bin}/gls --version")
    assert_match "gls version #{version}", output
  end
end
