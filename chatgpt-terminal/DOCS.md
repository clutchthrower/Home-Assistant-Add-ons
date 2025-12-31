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

No configuration is needed! The add-on uses OAuth authentication, which you'll complete the first time you use it.

Your OAuth credentials are stored in the `/config/codex-config` directory and will persist across add-on updates and restarts, so you won't need to authenticate again.

### OAuth Authentication Setup

When you first run Codex, it will provide an OAuth URL like:
```
https://auth.openai.com/oauth/authorize?...&redirect_uri=http://localhost:1455/auth/callback...
```

**If Home Assistant is on a different device:**
1. **Replace `localhost` with your Home Assistant IP address** in the OAuth URL
2. Example: Change `http://localhost:1455` to `http://192.168.1.100:1455` (use your HA IP)
3. Paste the modified URL into your browser
4. Complete the OpenAI authentication
5. The browser will redirect back to the addon, completing the authentication

**Alternative:** Access the terminal directly on the Home Assistant machine (if possible) to avoid this step.

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

### Authentication Issues

**OAuth redirect not working:**
- Make sure you replaced `localhost` with your Home Assistant IP address in the OAuth URL
- Ensure port 1455 is accessible (the addon automatically exposes it)
- Try accessing the terminal from the Home Assistant machine directly

**"Connection refused" on callback:**
- Verify your Home Assistant IP address is correct
- Check that the addon is running when you complete the OAuth flow
- Restart the addon and try authentication again

### General Issues

- If Codex doesn't start automatically, try running `node /usr/local/bin/codex -i` manually
- If you see permission errors, try restarting the add-on
- Check the add-on logs for any error messages

## Credits

This add-on was converted from the Claude Terminal add-on to use OpenAI's Codex CLI instead. The conversion demonstrates the flexibility of the Home Assistant add-on system.