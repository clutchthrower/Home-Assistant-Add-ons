# ChatGPT Terminal for Home Assistant

A secure, web-based terminal with OpenAI Codex CLI pre-installed for Home Assistant.

![ChatGPT Terminal Screenshot](https://github.com/heytcass/home-assistant-addons/raw/main/chatgpt-terminal/screenshot.png)

*ChatGPT Terminal running in Home Assistant*

## What is ChatGPT Terminal?

This add-on provides a web-based terminal interface with OpenAI Codex CLI pre-installed, allowing you to use ChatGPT's powerful AI capabilities directly from your Home Assistant dashboard. It gives you direct access to OpenAI's Codex AI assistant through a terminal, ideal for:

- Writing and editing code
- Debugging problems
- Learning new programming concepts
- Creating Home Assistant scripts and automations

## Features

- **Web Terminal Interface**: Access Codex through a browser-based terminal using ttyd
- **Auto-Launch**: Codex starts automatically when you open the terminal
- **Latest OpenAI Codex CLI**: Pre-installed with OpenAI's official CLI (@latest)
- **No Configuration Needed**: Uses API key authentication for easy setup
- **Direct Config Access**: Terminal starts in your `/config` directory for immediate access to all Home Assistant files
- **Home Assistant Integration**: Access directly from your dashboard
- **Panel Icon**: Quick access from the sidebar with the code-braces icon
- **Multi-Architecture Support**: Works on amd64, aarch64, and armv7 platforms
- **Secure Credential Management**: Persistent authentication with safe credential storage
- **Automatic Recovery**: Built-in fallbacks and error handling for reliable operation
- **Development Tools**: Includes Python 3, git, vim, jq, tree, and wget for enhanced scripting capabilities
- **Python Libraries**: Pre-installed with requests, aiohttp, yaml, and beautifulsoup4 for API and automation work

## Quick Start

The terminal automatically starts Codex when you open it. You can immediately start using commands like:

```bash
# Ask Codex a question directly
codex "How can I write a Python script to control my lights?"

# Start an interactive session
codex -i

# Get help with available commands
codex --help

# Debug authentication if needed
codex-auth debug

# Log out and re-authenticate
codex-logout
```

## Installation

1. Add this repository to your Home Assistant add-on store
2. Install the ChatGPT Terminal add-on
3. Start the add-on
4. Click "OPEN WEB UI" or the sidebar icon to access
5. On first use, configure your OpenAI API key for authentication

## Configuration

The add-on requires no configuration. All settings are handled automatically:

- **Ports**: Web interface on 7682, OAuth callback on 1455
- **Authentication**: OAuth with OpenAI (credentials stored securely in `/config/codex-config/`)
- **Terminal**: Full bash environment with OpenAI Codex CLI pre-installed
- **Volumes**: Access to both `/config` (Home Assistant) and `/addons` (for development)

### First-Time OAuth Setup

When authenticating for the first time, Codex will provide an OAuth URL. **If your Home Assistant is on a different device**, you need to modify the URL:

```bash
# Original URL from Codex:
http://localhost:1455/auth/callback...

# Change to (replace with your HA IP):
http://YOUR_HA_IP:1455/auth/callback...
```

Example: `http://192.168.1.100:1455/auth/callback...`

## Troubleshooting

### Authentication Issues
If you have authentication problems:
```bash
codex-auth debug    # Show credential status
codex-logout        # Clear credentials and re-authenticate
```

### Container Issues
- Credentials are automatically saved and restored between restarts
- Check add-on logs if the terminal doesn't load
- Restart the add-on if Codex commands aren't recognized

## Architecture

- **Base Image**: Home Assistant Alpine Linux base (3.19)
- **Container Runtime**: Compatible with Docker/Podman
- **Web Terminal**: ttyd for browser-based access
- **Process Management**: s6-overlay for reliable service startup
- **Networking**: Ingress support with Home Assistant reverse proxy

## Security

Version 1.0.2 includes important security improvements:
- ✅ **Secure Credential Management**: Limited filesystem access to safe directories only
- ✅ **Safe Cleanup Operations**: No more dangerous system-wide file deletions
- ✅ **Proper Permission Handling**: Consistent file permissions (600) for credentials
- ✅ **Input Validation**: Enhanced error checking and bounds validation

## Documentation

For detailed usage instructions, see the [documentation](DOCS.md).

## Version History

### v1.0.2 (Current) - Security & Bug Fix Release
- 🔒 **CRITICAL**: Fixed dangerous filesystem operations
- 🐛 Added missing armv7 architecture support
- 🔧 Pinned NPM packages and improved error handling

### v1.0.1
- Improved credential management
- Enhanced startup reliability

### v1.0.0
- Initial stable release
- Web terminal interface with ttyd
- Pre-installed OpenAI Codex CLI
- API key authentication support

## Useful Links

- [OpenAI Codex Documentation](https://platform.openai.com/docs/guides/code)
- [Get an OpenAI API Key](https://platform.openai.com/api-keys)
- [OpenAI Codex GitHub Repository](https://github.com/openai/openai-codex)
- [Home Assistant Add-ons](https://www.home-assistant.io/addons/)

## Credits

This add-on was converted from the Claude Terminal add-on to use OpenAI's Codex CLI instead. The conversion demonstrates the flexibility of the Home Assistant add-on system.

## License

This project is licensed under the MIT License - see the [LICENSE](../LICENSE) file for details.