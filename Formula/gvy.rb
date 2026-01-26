class Gvy < Formula
  desc "Tools for Apache Groovy (Language Server, utilities)"
  homepage "https://github.com/albertocavalcante/gvy"
  url "https://github.com/albertocavalcante/gvy/releases/download/v0.3.0/gvy-0.3.0-generic.jar"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "Apache-2.0"

  depends_on "openjdk@17"

  def install
    libexec.install "gvy-#{version}-generic.jar"
    bin.write_jar_script libexec/"gvy-#{version}-generic.jar", "gvy", java_version: "17"
  end

  test do
    output = shell_output("#{bin}/gvy --version")
    assert_match "gvy version #{version}", output
  end
end
