# ChatGPT Codex CLI Terminal for Home Assistant

This repository contains a custom add-on that integrates OpenAI's ChatGPT Codex CLI with Home Assistant.

## Installation

To add this repository to your Home Assistant instance:

1. Go to **Settings** → **Add-ons** → **Add-on Store**
2. Click the three dots menu in the top right corner
3. Select **Repositories**
4. Add the URL: `https://github.com/clutchthrower/home-assistant-chatgpt`
5. Click **Add**

## Add-ons

### ChatGPT Codex CLI

A web-based terminal interface with ChatGPT Codex CLI pre-installed. This add-on provides a terminal environment directly in your Home Assistant dashboard, allowing you to use ChatGPT's powerful AI capabilities for coding, automation, and configuration tasks.

Features:
- Web terminal access through your Home Assistant UI
- Pre-installed ChatGPT Codex CLI that launches automatically
- Direct access to your Home Assistant config directory
- No configuration needed (uses OAuth)
- Access to ChatGPT's complete capabilities including:
  - Code generation and explanation
  - Debugging assistance
  - Home Assistant automation help
  - Learning resources

[Documentation](chatgpt-terminal/DOCS.md)

## Support

If you have any questions or issues with this add-on, please create an issue in this repository.

## Credits

The original Claude Terminal add-on was created by [heytcass](https://github.com/heytcass). This version has been converted to use OpenAI's Codex CLI instead of Anthropic's Claude Code CLI.

## License

This repository is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
