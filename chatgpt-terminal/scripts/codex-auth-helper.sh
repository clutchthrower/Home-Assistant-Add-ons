#!/bin/bash

# Codex Authentication Helper
# Helps users set up authentication by copying auth.json content

AUTH_DIR="${OPENAI_CONFIG_DIR:-$HOME/.codex}"
AUTH_FILE="$AUTH_DIR/auth.json"

show_banner() {
    clear
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║          🔐 Codex Authentication Setup Helper                ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
}

show_instructions() {
    echo "To use Codex, you need to copy your authentication file."
    echo ""
    echo "On your computer where you're already logged into Codex:"
    echo "  1. Locate your auth file at: ~/.codex/auth.json"
    echo "  2. Open the file and copy its contents"
    echo "  3. Paste the contents below"
    echo ""
    echo "Or, if you prefer:"
    echo "  - Use File Editor addon to create: /config/codex-config/auth.json"
    echo "  - Copy/paste your auth.json contents there"
    echo "  - Then restart this addon"
    echo ""
}

paste_auth_json() {
    echo "Paste your auth.json contents below, then press Ctrl+D when done:"
    echo "---"

    # Read multi-line input until EOF (Ctrl+D)
    auth_content=$(cat)

    if [ -z "$auth_content" ]; then
        echo ""
        echo "❌ No content provided"
        return 1
    fi

    # Validate it looks like JSON
    if ! echo "$auth_content" | jq empty 2>/dev/null; then
        echo ""
        echo "❌ Invalid JSON format. Please check your auth.json file."
        return 1
    fi

    # Create directory if it doesn't exist
    mkdir -p "$AUTH_DIR"

    # Save the auth content
    echo "$auth_content" > "$AUTH_FILE"
    chmod 600 "$AUTH_FILE"

    echo ""
    echo "✅ Authentication file saved successfully!"
    echo ""
    echo "Location: $AUTH_FILE"
    echo ""
    echo "You can now use Codex. Run 'codex' to start."
    return 0
}

main() {
    show_banner
    show_instructions

    # Check if auth file already exists
    if [ -f "$AUTH_FILE" ]; then
        echo "⚠️  Authentication file already exists at: $AUTH_FILE"
        echo ""
        echo -n "Do you want to replace it? (y/N): "
        read -r response
        if [[ ! "$response" =~ ^[Yy]$ ]]; then
            echo "Cancelled. Your existing auth file is unchanged."
            exit 0
        fi
        echo ""
    fi

    paste_auth_json

    if [ $? -eq 0 ]; then
        echo ""
        echo "Press Enter to continue..."
        read -r
        exit 0
    else
        echo ""
        echo "Press Enter to try again or Ctrl+C to exit..."
        read -r
        main
    fi
}

# Run main function
main "$@"
