# Troubleshooting Complete Reference

Source: <https://opencode.ai/docs/troubleshooting>

## Overview

Common issues and their solutions for OpenCode.

## Quick Checks

### 1. Disable Plugins

If OpenCode behaves unexpectedly:
```json
{
  "plugin": []
}
```

Or use env var:
```bash
OPENCODE_PURE=1 opencode
```

### 2. Check Global Config

```bash
cat ~/.config/opencode/opencode.json
```

### 3. Check Plugin Directories

```bash
ls -la .opencode/plugin/
ls -la .opencode/plugins/
```

### 4. Clear Cache

```bash
# Remove cache
rm -rf ~/.cache/opencode/

# Remove logs
rm -rf ~/.config/opencode/logs/
```

## Logs

### Log Location

- Linux/macOS: `~/.config/opencode/logs/`
- Windows: `%APPDATA%\opencode\logs\`

### Log Levels

```json
{
  "logLevel": "DEBUG|INFO|WARN|ERROR"
}
```

### Debug Mode

```bash
opencode --debug
```

## Common Issues

### OpenCode Won't Start

#### Check 1: Validate Config
```bash
# Check JSON validity
cat ~/.config/opencode/opencode.json | python -m json.tool > /dev/null && echo "Valid" || echo "Invalid"
```

#### Check 2: Escape Hatch
```bash
OPENCODE_DISABLE_PROJECT_CONFIG=1 opencode
```

#### Check 3: Check Schema
Fetch <https://opencode.ai/config.json> and validate.

#### Check 4: Permissions
```bash
chmod 600 ~/.config/opencode/opencode.json
```

### Authentication Issues

#### Clear Auth Data
```bash
opencode auth logout
opencode auth login
```

#### Check API Key
```bash
echo $ANTHROPIC_API_KEY
```

#### Provider-specific
```bash
# Anthropic
opencode auth login anthropic

# OpenAI
opencode auth login openai

# Google
opencode auth login google
```

### Model Not Available

#### Check 1: List Models
```bash
opencode models list
```

#### Check 2: Provider Config
```json
{
  "provider": {
    "anthropic": {
      "options": {
        "apiKey": "${ANTHROPIC_API_KEY}"
      }
    }
  }
}
```

#### Check 3: Valid Model String
Must be `provider/model-id` format:
- `anthropic/claude-sonnet-4-6` ✅
- `claude-sonnet-4-6` ❌ (missing provider)

### ProviderInitError

```bash
# Check provider package
npm list @anthropic-ai/sdk

# Reinstall if needed
npm install @anthropic-ai/sdk
```

### AI_APICallError

#### Network Issues
```bash
# Check connectivity
curl -I https://api.anthropic.com

# Check proxy
echo $HTTP_PROXY
echo $HTTPS_PROXY
```

#### Rate Limiting
Wait and retry, or check <https://status.anthropic.com>

#### Invalid API Key
```bash
# Verify key format
echo $ANTHROPIC_API_KEY | head -c 10
```

### Copy/Paste Not Working (Linux)

#### Wayland Issues
```bash
# Check if using Wayland
echo $XDG_SESSION_TYPE
```

If Wayland, ensure clipboard manager is running:
```bash
# Install wl-clipboard
sudo apt install wl-clipboard

# Or X11 fallback
export WAYLAND_DISPLAY=
opencode
```

#### X11 Issues
```bash
# Ensure DISPLAY is set
echo $DISPLAY

# Test clipboard
xclip -selection clipboard -o
```

### Windows WebView2 Runtime

#### Install WebView2
1. Download from <https://developer.microsoft.com/en-us/microsoft-edge/webview2/>
2. Install Runtime

#### Or use WSL
```bash
wsl -e opencode
```

### Windows Performance Issues

#### Use WSL
```bash
wsl -e opencode
```

#### Or disable effects
```json
{
  "tui": {
    "disable_animations": true
  }
}
```

## Desktop App Issues

### Clear Desktop Default Server URL

Windows:
```cmd
reg delete "HKCU\Software\OpenCode" /f
```

macOS:
```bash
rm ~/Library/Preferences/ai.opencode.plist
```

### Reset Desktop App Storage

```bash
# Linux
rm -rf ~/.config/opencode/

# macOS
rm -rf ~/Library/Application\ Support/opencode/

# Windows
rmdir /s /q %APPDATA%\opencode
```

## Server Connection Issues

### Check Server Status
```bash
opencode server status
```

### Restart Server
```bash
opencode serve --restart
```

### Check Port
```bash
lsof -i :4096
```

### Firewall Issues
```bash
# Allow port
sudo ufw allow 4096
```

## Environment Variables

### Check All Variables
```bash
env | grep OPENCODE
env | grep -i anthropic
env | grep -i openai
```

### Reset Environment
```bash
unset OPENCODE_CONFIG
unset OPENCODE_PURE
unset OPENCODE_DISABLE_PROJECT_CONFIG
```

## Plugin Troubleshooting

### Plugin Not Loading

1. Check file location: `.opencode/plugin/*.ts`
2. Check file extension: must be `.ts` or `.js`
3. Check syntax: run `npx tsc --noEmit your-plugin.ts`
4. Check config: ensure in `"plugin": []` array

### Plugin Conflict

Disable all and enable one by one:
```json
{
  "plugin": ["plugin-a"]
}
```

Then:
```json
{
  "plugin": ["plugin-b"]
}
```

## MCP Troubleshooting

### MCP Not Starting

1. Check command format (must be array):
```json
{
  "mcp": {
    "server": {
      "type": "local",
      "command": ["npx", "-y", "@package"]
    }
  }
}
```

2. Run command manually:
```bash
npx -y @package
```

3. Check logs:
```bash
ls ~/.config/opencode/logs/
```

### MCP Auth Issues

```bash
# Re-authenticate
opencode mcp auth <name>

# Check token
echo $TOKEN_NAME
```

## Getting Help

### Check Version
```bash
opencode --version
```

### Generate Debug Report
```bash
opencode debug --report
```

### Check System Info
```bash
opencode debug --sysinfo
```

### Contact Support
Email: contact@anoma.ly
Docs: <https://opencode.ai/docs/troubleshooting>

## Reset Everything

```bash
# Nuclear option - reset all config
rm -rf ~/.config/opencode/
rm -rf ~/.cache/opencode/
opencode --init
```

## Debug Commands

```bash
# Verbose logging
opencode --log-level DEBUG

# Show config
opencode config --show

# Validate config
opencode config --validate

# Test provider
opencode provider test anthropic

# Check updates
opencode update --check
```