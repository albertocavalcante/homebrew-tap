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
| **slack**           | CLI using xoxc/cookie browser session auth                               | `brew install albertocavalcante/tap/slack`           |

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
gvy --version
```

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

## Development

```bash
# Install dev tools
brew install dprint lefthook ghalint pinact

# Setup git hooks
lefthook install

# Format files
dprint fmt

# Check formatting
dprint check

# Lint GitHub Actions workflows
ghalint run -c tools/lint/ghalint.yaml
pinact run --verify -c tools/lint/pinact.yaml
```

## Links

- [antlers](https://github.com/albertocavalcante/antlers) - Native JVM dependency resolver
- [bazelle](https://github.com/albertocavalcante/bazelle) - Polyglot Gazelle CLI
- [bossa](https://github.com/albertocavalcante/bossa) - Dev environment CLI
- [gvy](https://github.com/albertocavalcante/gvy) - Tools for Apache Groovy
- [gomodfmt](https://github.com/albertocavalcante/gomodfmt) - go.mod formatter
- [mdxfmt](https://github.com/albertocavalcante/mdxfmt) - MDX/Markdown formatter
- [katharsis](https://github.com/albertocavalcante/katharsis) - AppleDouble metadata cleaner
- [copybara](https://github.com/google/copybara) - Code transformation tool (native binaries from fork)
- [rebaze](https://github.com/albertocavalcante/rebaze) - Build system migration tool
- [slack-cli](https://github.com/albertocavalcante/slack-cli) - Slack CLI with browser session auth
