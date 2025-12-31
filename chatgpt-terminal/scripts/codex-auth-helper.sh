#!/bin/bash

# Codex Authentication Helper
# Provides alternative authentication methods when clipboard paste doesn't work

show_auth_menu() {
    clear
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║               🔐 Codex Authentication Helper                  ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
    echo "Choose authentication method:"
    echo ""
    echo "Options:"
    echo "  1) 🔗 OAuth Callback URL (Recommended for remote access)"
    echo "  2) 📋 Manual auth code input"
    echo "  3) 📁 Read code from file (/config/auth-code.txt)"
    echo "  4) 🔄 Retry standard authentication"
    echo "  5) ❌ Exit"
    echo ""
}

handle_oauth_callback() {
    clear
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║           OAuth Callback URL Authentication                  ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
    echo "Instructions:"
    echo "1. Run 'codex' in the terminal to start authentication"
    echo "2. Copy the OAuth URL and paste in your browser"
    echo "3. Complete authentication on OpenAI's website"
    echo "4. When browser tries to redirect to localhost:1455, it will fail"
    echo "5. Copy the ENTIRE callback URL from your browser's address bar"
    echo "6. Paste it below (it will look like: http://localhost:1455/auth/callback?code=...)"
    echo ""
    echo -n "Paste the callback URL here: "
    read -r callback_url

    if [ -z "$callback_url" ]; then
        echo "❌ No URL provided"
        return 1
    fi

    # Extract the path and query string
    callback_path=$(echo "$callback_url" | sed 's|^https\?://[^/]*||')

    if [[ ! "$callback_path" =~ ^/auth/callback ]]; then
        echo "❌ Invalid callback URL. Should contain '/auth/callback'"
        return 1
    fi

    echo ""
    echo "✅ Sending callback to Codex CLI..."

    # Send the callback to the local Codex server
    response=$(curl -s -w "\n%{http_code}" "http://localhost:1455${callback_path}" 2>&1)
    http_code=$(echo "$response" | tail -n1)

    if [ "$http_code" = "200" ] || [ "$http_code" = "302" ]; then
        echo "✅ Authentication successful!"
        echo ""
        echo "You can now use Codex. Run 'codex' to start."
        sleep 2
        return 0
    else
        echo "❌ Authentication failed (HTTP $http_code)"
        echo ""
        echo "Make sure Codex is running and waiting for authentication."
        echo "Try running 'codex' in another terminal session first."
        return 1
    fi
}

manual_auth_input() {
    echo ""
    echo "Please enter your authentication code:"
    echo "(You can try pasting with Ctrl+Shift+V, right-click, or type manually)"
    echo ""
    echo -n "Code: "
    read -r auth_code

    if [ -z "$auth_code" ]; then
        echo "❌ No code provided"
        return 1
    fi

    # Save to temp file for Codex to read
    echo "$auth_code" > /tmp/codex-auth-code
    echo ""
    echo "✅ Code saved. Starting Codex authentication..."
    sleep 1

    # Try to pipe the code to Codex
    echo "$auth_code" | node "$(which codex)"
}

read_auth_from_file() {
    local auth_file="/config/auth-code.txt"

    echo ""
    echo "Looking for authentication code in: $auth_file"

    if [ -f "$auth_file" ]; then
        auth_code=$(cat "$auth_file")
        if [ -z "$auth_code" ]; then
            echo "❌ File exists but is empty"
            return 1
        fi

        echo "✅ Code found. Starting Codex authentication..."
        sleep 1

        # Try to pipe the code to Codex
        echo "$auth_code" | node "$(which codex)"

        # Clean up the file after use
        rm -f "$auth_file"
        echo "🧹 Cleaned up auth code file"
    else
        echo "❌ File not found: $auth_file"
        echo ""
        echo "To use this method:"
        echo "1. Create the file in Home Assistant's config directory"
        echo "2. Paste your authentication code in the file"
        echo "3. Save the file and try again"
        return 1
    fi
}

retry_standard_auth() {
    echo ""
    echo "🔄 Starting standard Codex authentication..."
    echo ""
    echo "Tips for pasting in the web terminal:"
    echo "• Try Ctrl+Shift+V"
    echo "• Try right-clicking"
    echo "• Try the browser's Edit menu > Paste"
    echo "• On mobile, long-press may show paste option"
    echo ""
    sleep 2
    exec node "$(which codex)"
}

main() {
    while true; do
        show_auth_menu

        echo -n "Enter your choice [1-5]: "
        read -r choice

        case "$choice" in
            1)
                handle_oauth_callback
                if [ $? -eq 0 ]; then
                    exit 0
                fi
                echo ""
                echo "Press Enter to continue..."
                read -r
                ;;
            2)
                manual_auth_input
                if [ $? -eq 0 ]; then
                    exit 0
                fi
                echo ""
                echo "Press Enter to continue..."
                read -r
                ;;
            3)
                read_auth_from_file
                if [ $? -eq 0 ]; then
                    exit 0
                fi
                echo ""
                echo "Press Enter to continue..."
                read -r
                ;;
            4)
                retry_standard_auth
                ;;
            5)
                echo "👋 Exiting..."
                exit 0
                ;;
            *)
                echo "❌ Invalid choice"
                sleep 1
                ;;
        esac
    done
}

# Run main function
main "$@"