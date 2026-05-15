# Themes, Formatters, and LSP Complete Reference

Source: <https://opencode.ai/docs/themes>, <https://opencode.ai/docs/formatters>, <https://opencode.ai/docs/lsp>

## Themes

### Theme Configuration

```json
{
  "themes": {
    "selected": "tokyonight"
  }
}
```

### Built-in Themes

| Theme | Description |
|-------|-------------|
| `tokyonight` | Tokyo Night theme |
| `everforest` | Everforest theme |
| `ayu` | Ayu theme |
| `catppuccin` | Catppuccin theme |
| `gruvbox` | Gruvbox theme |
| `kanagawa` | Kanagawa theme |
| `nord` | Nord theme |
| `one-nvim` | Atom One theme |

### Terminal Requirements

Themes require terminals with true color support:
- iTerm2 (macOS)
- Konsole (Linux)
- Windows Terminal
- Alacritty
- WezTerm
- Ghostty

### System Theme

```json
{
  "themes": {
    "selected": "system"
  }
}
```

Follows system dark/light mode.

### Custom Themes

```json
{
  "themes": {
    "custom": {
      "name": "my-theme",
      "colors": {
        "bg": "#1a1b26",
        "bg-alt": "#24283b",
        "fg": "#a9b1d6",
        "fg-alt": "#7aa2f7",
        "red": "#f7768e",
        "green": "#9ece6a",
        "yellow": "#e0af68",
        "blue": "#7aa2f7",
        "magenta": "#bb9af7",
        "cyan": "#7dcfff",
        "orange": "#ff9e64",
        "pink": "#ff007c"
      }
    }
  }
}
```

### Theme Hierarchy

1. Custom theme (highest priority)
2. Selected built-in theme
3. System default

## Formatters

### Enable/Disable Formatters

```json
{
  "formatter": true   // Enable all
  "formatter": false  // Disable all
}
```

### Per-Language Formatters

```json
{
  "formatter": {
    "typescript": "prettier",
    "javascript": "prettier",
    "python": "black",
    "rust": "rustfmt",
    "go": "gofmt",
    "java": "google-java-format"
  }
}
```

### Built-in Formatters

| Language | Formatter | Notes |
|----------|-----------|-------|
| TypeScript/JavaScript | Prettier | `prettier --write` |
| Python | Black | `black .` |
| Rust | rustfmt | `cargo fmt` |
| Go | gofmt | `gofmt -w` |
| JSON | jq | `jq .` |
| C/C++ | ClangFormat | `clang-format` |

### Prettier Configuration

```json
{
  "formatter": {
    "typescript": {
      "prettier": {
        "singleQuote": true,
        "trailingComma": "es5",
        "semi": true,
        "printWidth": 80
      }
    }
  }
}
```

### Disable Per Language

```json
{
  "formatter": {
    "typescript": false,
    "python": "black"
  }
}
```

### Formatter How It Works

1. After AI edits, formatter runs on modified files
2. Uses language-specific formatter
3. Respects project formatter config if present

### Custom Formatters

```json
{
  "formatter": {
    "typescript": {
      "command": "npx prettier --write",
      "extensions": [".ts", ".tsx"]
    },
    "python": {
      "command": "black",
      "extensions": [".py"]
    }
  }
}
```

### Experimental Formatter Flag

```bash
OPENCODE_FORMATTER_EXPERIMENTAL=1 opencode
```

## LSP (Language Server Protocol)

### Enable/Disable LSP

```json
{
  "lsp": true,    // Enable with defaults
  "lsp": false    // Disable all
}
```

### LSP Configuration

```json
{
  "lsp": {
    "typescript": {
      "command": "typescript-language-server",
      "args": ["--stdio"],
      "initializationOptions": {
        "preferences": {
          "importModuleSpecifierEnding": "js"
        }
      }
    },
    "python": {
      "command": "pyright-langserver",
      "args": ["--stdio"]
    }
  }
}
```

### Built-in LSP Servers

OpenCode auto-discovers LSP servers in PATH:
- TypeScript: `typescript-language-server`, `tsserver`
- Python: `python-lsp-server`, `pyright`
- Rust: `rust-analyzer`
- Go: `gopls`
- Java: `jdtls`

### LSP Commands

```bash
# Check LSP status
opencode lsp status

# Restart LSP
opencode lsp restart
```

### LSP Features

| Feature | Description |
|---------|-------------|
| Completions | Auto-complete code |
| Diagnostics | Show errors/warnings |
| Go to Definition | Jump to definition |
| Find References | Find all references |
| Hover | Show hover info |
| Rename | Rename symbol |

### Per-Project LSP

Place LSP config in `.opencode/lsp.json`:
```json
{
  "typescript": {
    "command": "typescript-language-server",
    "args": ["--stdio"]
  }
}
```

### LSP Initialization Options

```json
{
  "lsp": {
    "typescript": {
      "command": "tsserver",
      "initializationOptions": {
        "preferences": {
          "includeInlayParameterNames": true,
          "includeCompletionsForModuleExports": true
        },
        "strict": true
      }
    }
  }
}
```

### Disable LSP for Language

```json
{
  "lsp": {
    "python": false,
    "rust": true
  }
}
```

### Experimental LSP

```json
{
  "experimental": {
    "lsp": true
  }
}
```

### LSP Debugging

Check LSP logs:
```bash
# View at ~/.config/opencode/logs/
```

## Combined Configuration Example

```json
{
  "themes": {
    "selected": "tokyonight",
    "custom": {
      "colors": {
        "bg": "#1a1b26",
        "fg": "#a9b1d6"
      }
    }
  },

  "formatter": {
    "typescript": "prettier",
    "python": "black"
  },

  "lsp": {
    "typescript": {
      "command": "typescript-language-server",
      "args": ["--stdio"]
    },
    "python": {
      "command": "pyright-langserver",
      "args": ["--stdio"]
    }
  }
}
```

## Formatter + LSP Workflow

1. User edits code via AI
2. LSP provides diagnostics
3. AI fixes issues
4. Formatter formats code
5. User receives clean code

## Terminal Theme Compatibility

| Terminal | True Color | Themes |
|----------|------------|--------|
| WezTerm | ✅ | All |
| Alacritty | ✅ | All |
| Ghostty | ✅ | All |
| iTerm2 | ✅ | All |
| Windows Terminal | ✅ | All |
|_cmd.exe_ | ❌ | None (limited) |