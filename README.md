# Home Assistant Add-ons

This repository contains custom Home Assistant add-ons for AI-powered terminal interfaces.

## Installation

To add this repository to your Home Assistant instance:

1. Go to **Settings** → **Add-ons** → **Add-on Store**
2. Click the three dots menu in the top right corner
3. Select **Repositories**
4. Add the URL: `https://github.com/clutchthrower/home-assistant-chatgpt`
5. Click **Add**

## Available Add-ons

### Claude Terminal

A web-based terminal interface with Anthropic's Claude Code CLI pre-installed. This add-on provides a terminal environment directly in your Home Assistant dashboard, allowing you to use Claude's powerful AI capabilities for coding, automation, and configuration tasks.

Features:
- Web terminal access through your Home Assistant UI
- Pre-installed Claude Code CLI that launches automatically
- Direct access to your Home Assistant config directory
- OAuth authentication with Anthropic
- Access to Claude's complete capabilities including:
  - Code generation and explanation
  - Debugging assistance
  - Home Assistant automation help
  - Learning resources

[Documentation](claude-terminal/DOCS.md)

### ChatGPT Terminal

A web-based terminal interface with OpenAI's Codex CLI pre-installed. This add-on provides a terminal environment directly in your Home Assistant dashboard, allowing you to use ChatGPT's powerful AI capabilities for coding, automation, and configuration tasks.

Features:
- Web terminal access through your Home Assistant UI
- Pre-installed OpenAI Codex CLI that launches automatically
- Direct access to your Home Assistant config directory
- API key authentication with OpenAI
- Includes Python 3, git, vim, and other development tools
- Access to Codex's complete capabilities including:
  - Code generation and explanation
  - Debugging assistance
  - Home Assistant automation help
  - Learning resources

[Documentation](chatgpt-terminal/DOCS.md)

## Support

If you have any questions or issues with this add-on, please create an issue in this repository.

## Credits

- **Claude Terminal** - Created by [heytcass](https://github.com/heytcass)
- **ChatGPT Terminal** - Converted from Claude Terminal to use OpenAI's Codex CLI

## License

This repository is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
