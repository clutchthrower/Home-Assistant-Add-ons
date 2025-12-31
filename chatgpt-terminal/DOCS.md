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

### First-Time Setup (Authentication)

**Method 1: Configuration Page (Easiest! ⭐)**
1. On your computer where you're already logged into Codex, find: `~/.codex/auth.json`
2. Copy the entire file contents
3. Go to **Settings** → **Add-ons** → **ChatGPT Terminal** → **Configuration**
4. Paste the contents into the **"Auth JSON"** text box
5. Click **Save**
6. Restart the add-on
7. Done! ✅

**Method 2: Terminal Helper**
1. Open the terminal - it will run the auth helper automatically
2. Paste your auth.json contents when prompted
3. Press Ctrl+D when done
4. Done! ✅

**Method 3: Using File Editor**
1. Install the "File Editor" add-on in Home Assistant
2. Access the terminal and create the file at: `/data/home/.codex/auth.json`
3. Paste your auth.json contents
4. Save and restart the ChatGPT Terminal add-on
5. Done! ✅

Your authentication is stored in the container's home directory (`~/.codex/auth.json` which maps to `/data/home/.codex/auth.json`) and will persist across updates and restarts.

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

**Can't find auth.json on your computer:**
- Log into Codex on your PC first: `codex login`
- The auth file is typically at: `~/.codex/auth.json` (Linux/Mac) or `%USERPROFILE%\.codex\auth.json` (Windows)

**Auth helper not accepting pasted content:**
- Make sure you copied the ENTIRE file content
- Verify it's valid JSON (should start with `{` and end with `}`)
- Try using File Editor method instead

**Codex not starting:**
- Check that auth.json exists: `ls -la ~/.codex/auth.json` in the terminal
- Verify the file has valid JSON: `cat ~/.codex/auth.json`
- Try running auth helper manually: `codex-auth-helper.sh`

### General Issues

- If you see permission errors, try restarting the add-on
- Check the add-on logs for any error messages
- To manually start Codex: run `codex` in the terminal

## Credits

This add-on was converted from the Claude Terminal add-on to use OpenAI's Codex CLI instead. The conversion demonstrates the flexibility of the Home Assistant add-on system.