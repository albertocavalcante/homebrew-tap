class Gvy < Formula
  RELEASE_VERSION = "0.5.4".freeze
  VSCODE_API = "^1.144.0".freeze

  desc "Groovy language server and editor extension"
  homepage "https://github.com/albertocavalcante/gvy"
  url "https://github.com/albertocavalcante/gvy/releases/download/v#{RELEASE_VERSION}/gls-#{RELEASE_VERSION}.jar"
  sha256 "ceda96ae2d6964faaf748df10e1f43818e06e09fb72e097d8bb44d27116f6390"
  license "Apache-2.0"

  depends_on "unzip" => :test
  depends_on "openjdk@17"

  resource "extension" do
    url "https://github.com/albertocavalcante/gvy/releases/download/v#{RELEASE_VERSION}/gvy-#{RELEASE_VERSION}.vsix",
        using: :nounzip
    sha256 "128a9f76b8595611196890b4305702b8005335f64b75f1f83e24f6172196a93b"
  end

  def install
    libexec.install "gls-#{version}.jar"
    # Keep a project's JAVA_HOME intact while running the server on its own JDK.
    (bin/"gvy").write <<~SH
      #!/bin/bash
      exec "#{Language::Java.java_home("17")}/bin/java" -Xmx2g -jar "#{libexec}/gls-#{version}.jar" "$@"
    SH
    resource("extension").stage do
      libexec.install "gvy-#{version}.vsix" => "gvy.vsix"
    end

    (bin/"gvy-install-extension").write <<~SHELL
      #!/bin/bash
      set -euo pipefail

      usage() {
        echo "Usage: gvy-install-extension [--dry-run] [editor-command]"
        echo "Installs the Homebrew-bundled gvy #{version} release."
        echo "Requires VS Code API #{VSCODE_API}, including compatible Cursor/VSCodium builds."
      }

      find_editor() {
        local command_name="$1" app_name apps_root candidate
        if command -v "$command_name" >/dev/null 2>&1; then
          command -v "$command_name"
          return
        fi
        case "$command_name" in
        code) app_name="Visual Studio Code" ;;
        cursor) app_name="Cursor" ;;
        codium) app_name="VSCodium" ;;
        code-insiders) app_name="Visual Studio Code - Insiders" ;;
        *) return 1 ;;
        esac
        for apps_root in /Applications "${HOME:-}/Applications"; do
          candidate="$apps_root/$app_name.app/Contents/Resources/app/bin/$command_name"
          if [[ -x "$candidate" ]]; then
            printf '%s\\n' "$candidate"
            return
          fi
        done
        return 1
      }

      dry_run=0
      editor_requested=0
      editor=""
      while [[ $# -gt 0 ]]; do
        case "$1" in
        -h | --help)
          usage
          exit 0
          ;;
        --dry-run) dry_run=1 ;;
        -*)
          echo "Unknown option: $1" >&2
          usage >&2
          exit 2
          ;;
        *)
          if [[ "$editor_requested" -eq 1 || -z "$1" ]]; then
            usage >&2
            exit 2
          fi
          editor="$1"
          editor_requested=1
          ;;
        esac
        shift
      done

      if [[ "$editor_requested" -eq 0 ]]; then
        for candidate in code cursor codium code-insiders cursor-insiders; do
          if editor=$(find_editor "$candidate"); then
            break
          fi
        done
      else
        requested_editor="$editor"
        if ! editor=$(find_editor "$editor"); then
          echo "Editor command not found: $requested_editor" >&2
          exit 1
        fi
      fi
      if [[ -z "$editor" ]]; then
        echo "No editor found. Pass its CLI path or enable its shell command." >&2
        exit 1
      fi

      vsix="#{libexec}/gvy.vsix"
      if [[ ! -r "$vsix" ]]; then
        echo "Bundled VSIX not found. Run brew reinstall albertocavalcante/tap/gvy." >&2
        exit 1
      fi
      if [[ "$dry_run" -eq 1 ]]; then
        printf 'Would install %s using %s.\\n' "$vsix" "$editor"
        echo "Required editor API: VS Code #{VSCODE_API} (checked by the editor when installing)."
        exit 0
      fi
      echo "Installing gvy #{version} with $editor..."
      if "$editor" --install-extension "$vsix"; then
        echo "Open a Groovy file, or reload your editor window to activate gvy."
      else
        result=$?
        echo "Editor installation failed (exit $result). This VSIX requires VS Code API #{VSCODE_API}." >&2
        exit "$result"
      fi
    SHELL
  end

  def caveats
    <<~EOS
      Install the bundled extension into your editor:
        gvy-install-extension
      To select another editor:
        gvy-install-extension cursor
        gvy-install-extension codium
      To preview the selection without installing:
        gvy-install-extension --dry-run

      The VSIX requires VS Code API #{VSCODE_API}. Cursor/VSCodium builds
      with an older VS Code API cannot install this release.

      Java 17 is included. If the editor asks for Java, select this JDK:
        #{Language::Java.java_home("17")}
      For another LSP editor, configure its server command as: gvy
    EOS
  end

  test do
    assert_match "Groovy Language Server", shell_output("#{bin}/gvy --help")
    assert_match version.to_s, shell_output("#{bin}/gvy version")
    (testpath/"project-jdk/bin").mkpath
    (testpath/"project-jdk/bin/java").write "#!/bin/sh\nexit 99\n"
    (testpath/"project-jdk/bin/java").chmod 0755
    with_env("JAVA_HOME" => (testpath/"project-jdk").to_s) do
      assert_match version.to_s, shell_output("#{bin}/gvy version")
    end

    assert_path_exists libexec/"gvy.vsix"
    assert_equal version, resource("extension").version
    manifest = JSON.parse(Utils.safe_popen_read("unzip", "-p", (libexec/"gvy.vsix").to_s, "extension/package.json"))
    assert_equal version.to_s, manifest.fetch("version")
    assert_equal VSCODE_API, manifest.fetch("engines").fetch("vscode")
    help = shell_output("#{bin}/gvy-install-extension --help")
    assert_includes help, VSCODE_API
    assert_includes help, "--dry-run"

    # Record arguments without installing anything into a real editor.
    (testpath/"fake editor").write <<~SH
      #!/bin/bash
      printf '%s\\n' "$@" > "#{testpath}/editor-args"
    SH
    (testpath/"fake editor").chmod 0755
    preview = shell_output("#{bin}/gvy-install-extension --dry-run '#{testpath}/fake editor'")
    assert_includes preview, "fake editor"
    refute_path_exists testpath/"editor-args"
    system bin/"gvy-install-extension", testpath/"fake editor"
    assert_equal ["--install-extension", "#{libexec}/gvy.vsix"],
                 (testpath/"editor-args").read.lines.map(&:chomp)
    (testpath/"editor-args").unlink
    (testpath/"bin").mkpath
    cp testpath/"fake editor", testpath/"bin/code"
    ENV.prepend_path "PATH", testpath/"bin"
    assert_match "Usage:", shell_output("#{bin}/gvy-install-extension '' 2>&1", 2)
    assert_match "Unknown option", shell_output("#{bin}/gvy-install-extension --unknown 2>&1", 2)
    assert_match "Editor command not found", shell_output("#{bin}/gvy-install-extension gvy-missing-editor 2>&1", 1)
    refute_path_exists testpath/"editor-args"
    system bin/"gvy-install-extension"
    assert_match "--install-extension", (testpath/"editor-args").read

    (testpath/"broken-editor").write "#!/bin/bash\nexit 23\n"
    (testpath/"broken-editor").chmod 0755
    output = shell_output("#{bin}/gvy-install-extension #{testpath}/broken-editor 2>&1", 23)
    refute_match "Open a Groovy file", output
    assert_includes output, VSCODE_API
  end
end
