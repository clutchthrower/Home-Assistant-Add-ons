# ChatGPT Codex CLI Terminal Home Assistant Add-on Documentation

## Overview

ChatGPT Terminal provides a web-based terminal interface with ChatGPT Codex CLI pre-installed, allowing you to access ChatGPT's powerful AI capabilities directly from your Home Assistant dashboard. ChatGPT Codex CLI is an AI coding assistant by OpenAI that can help you with Home Assistant configuration, automation creation, debugging, and general coding tasks.

## Installation

Follow these steps to install the add-on:

1. Navigate to your Home Assistant instance
2. Go to Settings -> Add-ons -> Add-on Store
3. Click the three dots in the top right corner and select "Repositories"
4. Add the URL of this repository and click "Add"
5. Find the "ChatGPT Terminal" add-on and click on it
6. Click "Install"

## Configuration

No configuration is needed! The add-on uses OAuth authentication, so you'll be prompted to log in to your Anthropic account the first time you use it.

## Usage

The ChatGPT Codex CLI launches automatically when you open the terminal. You can interact with it using the following commands:

### Common Commands

- `codex` - Start an interactive ChatGPT session
- `codex --help` - See all available commands
- `codex "your prompt"` - Ask ChatGPT a single question
- `codex review myfile.py` - Have ChatGPT analyze a file
- `codex resume` - Resume a previous interactive session

All your files are stored in `/config/.codex`, which persists between restarts.

## Home Assistant-Specific Use Cases

ChatGPT Terminal is particularly useful for Home Assistant tasks. Here are some example uses:

### 1. Automation Creation and Debugging

```
# Create a new automation
codex "create an automation that turns on lights when motion is detected, but only if it's dark"

# Debug an existing automation
codex "why isn't my automation working? Here's the code: [paste automation code]"
```

### 2. YAML Configuration Help

```
# Get help with syntax
codex "what's wrong with this YAML? [paste YAML]"

# Create a new configuration
codex "create a configuration for a zigbee device with these capabilities: [list capabilities]"
```

### 3. Entity Management

```
# Clean up entity names
codex "suggest better names for these entities: [paste entity list]"

# Create a template sensor
codex "create a template sensor that averages these temperature sensors: [paste sensor IDs]"
```

### 4. Custom Component Development

```
# Create a new integration
codex "help me create a custom integration for my smart coffee maker"

# Debug integration issues
codex "why is my custom component failing to load? Here's the error: [paste error]"
```

## Troubleshooting

### Common Issues

1. **Authentication Issues**: 
   - If you're having trouble with OAuth login, try clearing your browser cookies
   - Make sure you have a valid OpenAI account with billing enabled

2. **Connection Problems**: 
   - Check your internet connection
   - Verify the add-on can reach https://api.openai.com/v1

3. **Terminal Connection Issues**:
   - If the terminal disconnects, try refreshing the page
   - Check if the add-on is still running in Home Assistant

### Logs

Check the add-on logs for detailed information about any issues:

1. Go to the add-on page in Home Assistant
2. Click the "Logs" tab

## Security Considerations

ChatGPT Terminal is designed with security in mind:

- The add-on runs in an isolated container
- Your code and queries go directly to OpenAI's API
- OAuth authentication ensures secure access to your account

To further enhance security:
- Log out when not actively using the terminal
- Monitor the add-on logs for unusual activity
- Keep your OpenAI account secure with a strong password

## Support

- For issues with the add-on itself, please open an issue on the GitHub repository
- For ChatGPT Codex CLI-specific issues, refer to the [OpenAI documentation](https://developers.openai.com/codex)
- For billing or API questions, visit [OpenAI's support site](https://help.openai.com/en/)

## Credits

This add-on was created by [heytcass](https://github.com/heytcass) with the assistance of Claude Code itself! The entire development process, debugging, and documentation were all completed using Claude's AI capabilities.

## License

This add-on is provided under the MIT License. ChatGPT Codex CLI itself is subject to OpenAI's Commercial Terms of Service.
