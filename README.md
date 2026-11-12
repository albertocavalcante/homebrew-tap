# Homebrew Tap

Homebrew tap for tools and apps by [@albertocavalcante](https://github.com/albertocavalcante).

## Installation

```bash
brew tap albertocavalcante/tap
```

## Available Formulas

| Formula             | Description                                                              | Install                                              |
| ------------------- | ------------------------------------------------------------------------ | ---------------------------------------------------- |
| **antlers**         | Polyglot native dependency resolver for JVM ecosystems                   | `brew install albertocavalcante/tap/antlers`         |
| **antlers-nightly** | Antlers nightly build (prebuilt binaries, auto-updated)                  | `brew install albertocavalcante/tap/antlers-nightly` |
| **bazelle**         | Polyglot Gazelle CLI for Bazel BUILD file generation                     | `brew install albertocavalcante/tap/bazelle`         |
| **rebaze**          | CLI tool to migrate projects to Bazel                                    | `brew install albertocavalcante/tap/rebaze`          |
| **rebaze-nightly**  | Rebaze nightly build (prebuilt binaries, auto-updated)                   | `brew install albertocavalcante/tap/rebaze-nightly`  |
| **bossa**           | Unified CLI for managing dev environment - workspaces, refs, packages    | `brew install albertocavalcante/tap/bossa`           |
| **gvy**             | Tools for Apache Groovy (Language Server, utilities)                     | `brew install albertocavalcante/tap/gvy`             |
| **gomodfmt**        | Opinionated formatter for go.mod files                                   | `brew install albertocavalcante/tap/gomodfmt`        |
| **mdxfmt-nightly**  | MDX/Markdown formatter (nightly build, prebuilt binaries, auto-updated)  | `brew install albertocavalcante/tap/mdxfmt-nightly`  |
| **copybara**        | Tool for transforming and moving code between repositories               | `brew install albertocavalcante/tap/copybara`        |
| **katharsis**       | macOS menu bar app that purifies external drives of AppleDouble metadata | `brew install albertocavalcante/tap/katharsis`       |
| **reapictl**        | Provider-neutral CLI for debugging Remote Execution API deployments      | `brew install albertocavalcante/tap/reapictl`        |
| **slack**           | CLI using xoxc/cookie browser session auth                               | `brew install albertocavalcante/tap/slack`           |
| **tfc**             | Automation CLI for HCP Terraform and Terraform Cloud                     | `brew install albertocavalcante/tap/tfc`             |

## Usage

### antlers

```bash
# Install stable (builds from source)
brew install albertocavalcante/tap/antlers

# Or install nightly (prebuilt binaries)
brew install albertocavalcante/tap/antlers-nightly

# Run
antlers --help
atl --help  # alias

# Update
brew upgrade antlers
```

### rebaze

```bash
# Install stable (builds from source)
brew install albertocavalcante/tap/rebaze

# Or install nightly (prebuilt binaries)
brew install albertocavalcante/tap/rebaze-nightly

# Run
rebaze --help
rebaze analyze /path/to/project

# Update
brew upgrade rebaze
```

### bazelle

```bash
brew install albertocavalcante/tap/bazelle
bazelle update /path/to/your/project
```

### bossa

```bash
brew install albertocavalcante/tap/bossa
bossa --help
```

### gvy

```bash
brew install albertocavalcante/tap/gvy
gvy-install-extension
```

Homebrew installs Java 17, the server, and a checksum-verified VSIX. The server uses
its packaged JDK even when a project sets an older `JAVA_HOME`.

The VSIX requires **VS Code API 1.144 or newer**. Cursor and VSCodium work only when
their bundled VS Code API meets that requirement; their product version is different.
An incompatible editor rejects installation, and the helper preserves its error.

Choose an editor or preview the selected command:

```bash
gvy-install-extension cursor     # compatible Cursor build
gvy-install-extension codium     # compatible VSCodium build
gvy-install-extension --dry-run  # preview without installing
gvy version                     # standalone server version
```

The helper uses PATH and standard macOS application locations, including
`~/Applications`. It does not change settings or force an incompatible installation.
For another LSP client, use `gvy` as its server command (stdio).

To update, run `brew update`, `brew upgrade gvy`, and `gvy-install-extension` again.
Uninstalling the formula does not uninstall the extension. Keep a previous VSIX for
editor rollback.

Maintainers: the release version and VS Code API requirement each have one declaration
in `Formula/gvy.rb`. Bump both artifact hashes with the release version. Tests verify
that the VSIX version and engine match the formula. Compare release `checksums.txt`
and GitHub asset digests, then fetch, audit, and test the formula. Publishing automation
is tracked in [gvy#1675](https://github.com/albertocavalcante/gvy/issues/1675).

### gomodfmt

```bash
brew install albertocavalcante/tap/gomodfmt
gomodfmt --help
```

### mdxfmt

```bash
# Install nightly (prebuilt binaries)
brew install albertocavalcante/tap/mdxfmt-nightly

# Format files
mdxfmt -w .
mdxfmt -l .
mdxfmt -d file.md

# Update
brew upgrade mdxfmt-nightly
```

### copybara

```bash
brew install albertocavalcante/tap/copybara
copybara --help
```

### katharsis

```bash
brew install albertocavalcante/tap/katharsis
# Launch from Applications or menu bar
```

### slack

```bash
brew install albertocavalcante/tap/slack
slack setup
slack history CRH3QF91B -n 20
slack search "deploy failed"
```

### reapictl

```bash
brew install albertocavalcante/tap/reapictl
reapictl version
reapictl doctor --endpoint grpcs://example.invalid:443
```

Current caveat:

- this formula builds from the Git source repo
- `reapictl` is private right now, so installs require GitHub access on the
  machine running Homebrew

### tfc

```bash
brew install albertocavalcante/tap/tfc
tfc help
```

Current caveat:

- this formula builds from the Git source repo
- `tfc` is private right now, so installs require GitHub access on the machine
  running Homebrew

## Development

```bash
# Install dev tools
brew install dprint lefthook ghalint pinact node shellcheck shfmt

# Setup git hooks
lefthook install

# Format files
dprint fmt

# Check formatting
dprint check

# Lint GitHub Actions workflows
ghalint run -c tools/lint/ghalint.yaml
pinact run --verify -c tools/lint/pinact.yaml

# Check the audit helper and its failure paths
shellcheck tools/audit-formulas.sh
shfmt -d -i 2 tools/audit-formulas.sh
node --test tools/test-audit-formulas.mjs
```

## Links

- [antlers](https://github.com/albertocavalcante/antlers) - Native JVM dependency resolver
- [bazelle](https://github.com/albertocavalcante/bazelle) - Polyglot Gazelle CLI
- [bossa](https://github.com/albertocavalcante/bossa) - Dev environment CLI
- [gvy](https://github.com/albertocavalcante/gvy) - Tools for Apache Groovy
- [gomodfmt](https://github.com/albertocavalcante/gomodfmt) - go.mod formatter
- [mdxfmt](https://github.com/albertocavalcante/mdxfmt) - MDX/Markdown formatter
- [katharsis](https://github.com/albertocavalcante/katharsis) - AppleDouble metadata cleaner
- [reapictl](https://github.com/albertocavalcante/reapictl) - REAPI operator and debugging CLI
- [copybara](https://github.com/google/copybara) - Code transformation tool (native binaries from fork)
- [rebaze](https://github.com/albertocavalcante/rebaze) - Build system migration tool
- [slack-cli](https://github.com/albertocavalcante/slack-cli) - Slack CLI with browser session auth
- [tfc](https://github.com/albertocavalcante/tfc) - Terraform Cloud automation CLI
