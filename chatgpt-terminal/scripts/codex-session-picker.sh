#!/bin/bash

# Codex Session Picker - Interactive menu for choosing Codex session type
# Provides options for new session, continue, resume, manual command, or regular shell

show_banner() {
    clear
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                   🤖 ChatGPT Terminal                        ║"
    echo "║                   Interactive Session Picker                ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo ""
}

show_menu() {
    echo "Choose your Codex session type:"
    echo ""
    echo "  1) 🆕 New interactive session (default)"
    echo "  2) ⏩ Continue most recent conversation (-c)"
    echo "  3) 📋 Resume from conversation list (-r)"
    echo "  4) ⚙️  Custom Codex command (manual flags)"
    echo "  5) 🔐 Authentication helper (if paste doesn't work)"
    echo "  6) 🐚 Drop to bash shell"
    echo "  7) ❌ Exit"
    echo ""
}

get_user_choice() {
    local choice
    # Send prompt to stderr to avoid capturing it with the return value
    printf "Enter your choice [1-7] (default: 1): " >&2
    read -r choice
    
    # Default to 1 if empty
    if [ -z "$choice" ]; then
        choice=1
    fi
    
    # Trim whitespace and return only the choice
    choice=$(echo "$choice" | tr -d '[:space:]')
    echo "$choice"
}

launch_codex_new() {
    echo "🚀 Starting new Codex session..."
    sleep 1
    exec node "$(which codex)"
}

launch_codex_continue() {
    echo "⏩ Continuing most recent conversation..."
    sleep 1
    exec node "$(which codex)" -c
}

launch_codex_resume() {
    echo "📋 Opening conversation list for selection..."
    sleep 1
    exec node "$(which codex)" -r
}

launch_codex_custom() {
    echo ""
    echo "Enter your Codex command (e.g., 'codex --help' or 'codex -p \"hello\"'):"
    echo "Available flags: -c (continue), -r (resume), -p (print), --model, etc."
    echo -n "> codex "
    read -r custom_args

    if [ -z "$custom_args" ]; then
        echo "No arguments provided. Starting default session..."
        launch_codex_new
    else
        echo "🚀 Running: codex $custom_args"
        sleep 1
        # Use eval to properly handle quoted arguments
        eval "exec node \$(which codex) $custom_args"
    fi
}

launch_auth_helper() {
    echo "🔐 Starting authentication helper..."
    sleep 1
    exec /opt/scripts/codex-auth-helper.sh
}

launch_bash_shell() {
    echo "🐚 Dropping to bash shell..."
    echo "Tip: Run 'codex' manually when ready"
    sleep 1
    exec bash
}

exit_session_picker() {
    echo "👋 Goodbye!"
    exit 0
}

# Main execution flow
main() {
    while true; do
        show_banner
        show_menu
        choice=$(get_user_choice)
        
        case "$choice" in
            1)
                launch_codex_new
                ;;
            2)
                launch_codex_continue
                ;;
            3)
                launch_codex_resume
                ;;
            4)
                launch_codex_custom
                ;;
            5)
                launch_auth_helper
                ;;
            6)
                launch_bash_shell
                ;;
            7)
                exit_session_picker
                ;;
            *)
                echo ""
                echo "❌ Invalid choice: '$choice'"
                echo "Please select a number between 1-7"
                echo ""
                printf "Press Enter to continue..." >&2
                read -r
                ;;
        esac
    done
}

# Handle cleanup on exit
trap 'exit_session_picker' EXIT INT TERM

# Run main function
main "$@"