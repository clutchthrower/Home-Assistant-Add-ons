# ChatGPT Terminal

A terminal interface for OpenAI's Codex CLI in Home Assistant.

## About

This add-on provides a web-based terminal with OpenAI Codex CLI pre-installed, allowing you to access ChatGPT's powerful AI capabilities directly from your Home Assistant dashboard. The terminal provides full access to Codex's code generation, explanation, and problem-solving capabilities.

## Installation

1. Add this repository to your Home Assistant add-on store
2. Install the ChatGPT Terminal add-on
3. Start the add-on
4. Click "OPEN WEB UI" to access the terminal
5. On first use, configure your OpenAI API key for authentication

## Configuration

No configuration is needed! The add-on uses API key authentication, which you'll set up the first time you use it.

Your API credentials are stored in the `/config/codex-config` directory and will persist across add-on updates and restarts, so you won't need to configure it again.

## Usage

Codex launches automatically when you open the terminal. You can also start Codex manually with:

```bash
node /usr/local/bin/codex
```

### Common Commands

- `codex -i` - Start an interactive Codex session
- `codex --help` - See all available commands
- `codex "your prompt"` - Ask Codex a single question
- `codex process myfile.py` - Have Codex analyze a file
- `codex --editor` - Start an interactive editor session

The terminal starts directly in your `/config` directory, giving you immediate access to all your Home Assistant configuration files. This makes it easy to get help with your configuration, create automations, and troubleshoot issues.

## Features

- **Web Terminal**: Access a full terminal environment via your browser
- **Auto-Launching**: Codex starts automatically when you open the terminal
- **OpenAI Codex**: Access Codex's AI capabilities for programming, troubleshooting and more
- **Direct Config Access**: Terminal starts in `/config` for immediate access to all Home Assistant files
- **Simple Setup**: Uses API key for easy authentication
- **Home Assistant Integration**: Access directly from your dashboard

## Troubleshooting

- If Codex doesn't start automatically, try running `node /usr/local/bin/codex -i` manually
- If you see permission errors, try restarting the add-on
- If you have authentication issues, check your API key configuration
- Check the add-on logs for any error messages

## Credits

This add-on was converted from the Claude Terminal add-on to use OpenAI's Codex CLI instead. The conversion demonstrates the flexibility of the Home Assistant add-on system.