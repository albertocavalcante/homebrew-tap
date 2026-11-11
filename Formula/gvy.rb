class Gvy < Formula
  desc "Groovy language server and editor extension"
  homepage "https://github.com/albertocavalcante/gvy"
  url "https://github.com/albertocavalcante/gvy/releases/download/v0.5.4/gls-0.5.4.jar"
  sha256 "ceda96ae2d6964faaf748df10e1f43818e06e09fb72e097d8bb44d27116f6390"
  license "Apache-2.0"

  depends_on "openjdk@17"

  resource "extension" do
    url "https://github.com/albertocavalcante/gvy/releases/download/v0.5.4/gvy-0.5.4.vsix", using: :nounzip
    sha256 "128a9f76b8595611196890b4305702b8005335f64b75f1f83e24f6172196a93b"
  end

  def install
    libexec.install "gls-#{version}.jar"
    bin.write_jar_script libexec/"gls-#{version}.jar", "gvy", "-Xmx2g", java_version: "17"
    resource("extension").stage do
      libexec.install "gvy-#{version}.vsix" => "gvy.vsix"
    end

    (bin/"gvy-install-extension").write <<~SHELL
      #!/bin/bash
      set -euo pipefail

      if [[ $# -gt 1 ]]; then
        echo "Usage: gvy-install-extension [editor-command]" >&2
        exit 2
      fi
      if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
        echo "Usage: gvy-install-extension [editor-command]"
        echo "Installs the Homebrew-bundled release into VS Code, Cursor, or VSCodium."
        exit 0
      fi

      editor="${1:-}"
      if [[ -z "$editor" ]]; then
        for candidate in code cursor codium code-insiders cursor-insiders; do
          if command -v "$candidate" >/dev/null 2>&1; then
            editor="$candidate"
            break
          fi
        done
      fi
      if [[ -z "$editor" ]] || ! command -v "$editor" >/dev/null 2>&1; then
        echo "Editor command not found: ${editor:-code, cursor, or codium}." >&2
        echo "Enable your editor's shell command, then run gvy-install-extension <editor-command>." >&2
        exit 1
      fi

      vsix="#{libexec}/gvy.vsix"
      if [[ ! -r "$vsix" ]]; then
        echo "Bundled VSIX not found. Run brew reinstall albertocavalcante/tap/gvy." >&2
        exit 1
      fi
      echo "Installing the Homebrew-bundled gvy extension with $editor..."
      "$editor" --install-extension "$vsix"
      echo "Open a Groovy file, or reload your editor window to activate gvy."
    SHELL
  end

  def caveats
    <<~EOS
      Install the bundled extension into your editor:
        gvy-install-extension
      To select another editor:
        gvy-install-extension cursor
        gvy-install-extension codium

      Java 17 is included. If the editor asks for Java, select this JDK:
        #{Language::Java.java_home("17")}
      For another LSP editor, configure its server command as: gvy
    EOS
  end

  test do
    assert_match "Groovy Language Server", shell_output("#{bin}/gvy --help")
    assert_match version.to_s, shell_output("#{bin}/gvy version")
    assert_path_exists libexec/"gvy.vsix"
    assert_match "Usage:", shell_output("#{bin}/gvy-install-extension --help")

    # Record arguments without installing anything into a real editor.
    (testpath/"fake editor").write <<~SH
      #!/bin/bash
      printf '%s\\n' "$@" > "#{testpath}/editor-args"
    SH
    (testpath/"fake editor").chmod 0755
    system bin/"gvy-install-extension", testpath/"fake editor"
    assert_equal ["--install-extension", "#{libexec}/gvy.vsix"],
                 (testpath/"editor-args").read.lines.map(&:chomp)
    (testpath/"editor-args").unlink
    (testpath/"bin").mkpath
    cp testpath/"fake editor", testpath/"bin/code"
    ENV.prepend_path "PATH", testpath/"bin"
    assert_match "Editor command not found", shell_output("#{bin}/gvy-install-extension gvy-missing-editor 2>&1", 1)
    refute_path_exists testpath/"editor-args"
    system bin/"gvy-install-extension"
    assert_match "--install-extension", (testpath/"editor-args").read

    (testpath/"broken-editor").write "#!/bin/bash\nexit 23\n"
    (testpath/"broken-editor").chmod 0755
    output = shell_output("#{bin}/gvy-install-extension #{testpath}/broken-editor 2>&1", 23)
    refute_match "Open a Groovy file", output
  end
end
