# Homebrew Tap

Homebrew tap for developer tools by [@albertocavalcante](https://github.com/albertocavalcante).

## Installation

```bash
brew tap albertocavalcante/tap
```

## Available Formulas

| Formula | Description | Install |
|---------|-------------|---------|
| **bazelle** | Polyglot Gazelle CLI for Bazel BUILD file generation | `brew install albertocavalcante/tap/bazelle` |
| **gls** | Modern Groovy Language Server | `brew install albertocavalcante/tap/gls` |

## Usage

### bazelle

```bash
# Install
brew install albertocavalcante/tap/bazelle

# Run on your project
bazelle update /path/to/your/project

# Update
brew upgrade bazelle
```

### gls

```bash
# Install
brew install albertocavalcante/tap/gls

# Run
gls --version

# Update
brew upgrade gls
```

## Development

```bash
# Install dev tools
brew install dprint lefthook

# Setup git hooks
lefthook install

# Format files
dprint fmt

# Check formatting
dprint check
```

## Links

- [bazelle](https://github.com/albertocavalcante/bazelle) - Polyglot Gazelle CLI
- [groovy-devtools](https://github.com/albertocavalcante/groovy-devtools) - Groovy Language Server
