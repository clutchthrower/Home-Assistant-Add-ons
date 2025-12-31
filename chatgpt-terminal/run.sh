#!/usr/bin/with-contenv bashio

# Enable strict error handling
set -e
set -o pipefail

# Initialize environment for OpenAI Codex CLI using /data (HA best practice)
init_environment() {
    # Use /data exclusively - guaranteed writable by HA Supervisor
    local data_home="/data/home"
    local config_dir="/data/.config"
    local cache_dir="/data/.cache"
    local state_dir="/data/.local/state"
    local codex_config_dir="/data/.config/codex"

    bashio::log.info "Initializing OpenAI Codex environment in /data..."

    # Create all required directories
    if ! mkdir -p "$data_home" "$config_dir/codex" "$cache_dir" "$state_dir" "/data/.local"; then
        bashio::log.error "Failed to create directories in /data"
        exit 1
    fi

    # Set permissions
    chmod 755 "$data_home" "$config_dir" "$cache_dir" "$state_dir" "$codex_config_dir"

    # Set XDG and application environment variables
    export HOME="$data_home"
    export XDG_CONFIG_HOME="$config_dir"
    export XDG_CACHE_HOME="$cache_dir"
    export XDG_STATE_HOME="$state_dir"
    export XDG_DATA_HOME="/data/.local/share"

    # OpenAI-specific environment variables
    export OPENAI_CONFIG_DIR="$codex_config_dir"
    export OPENAI_HOME="/data"

    # Migrate any existing authentication files from legacy locations
    migrate_legacy_auth_files "$codex_config_dir"

    bashio::log.info "Environment initialized:"
    bashio::log.info "  - Home: $HOME"
    bashio::log.info "  - Config: $XDG_CONFIG_HOME"
    bashio::log.info "  - Codex config: $OPENAI_CONFIG_DIR"
    bashio::log.info "  - Cache: $XDG_CACHE_HOME"
}

# One-time migration of existing authentication files
migrate_legacy_auth_files() {
    local target_dir="$1"
    local migrated=false

    bashio::log.info "Checking for existing authentication files to migrate..."

    # Check common legacy locations (including old Claude paths for migration)
    local legacy_locations=(
        "/root/.config/anthropic"
        "/root/.anthropic"
        "/root/.config/openai"
        "/config/claude-config"
        "/config/codex-config"
        "/tmp/codex-config"
    )

    for legacy_path in "${legacy_locations[@]}"; do
        if [ -d "$legacy_path" ] && [ "$(ls -A "$legacy_path" 2>/dev/null)" ]; then
            bashio::log.info "Migrating auth files from: $legacy_path"
            
            # Copy files to new location
            if cp -r "$legacy_path"/* "$target_dir/" 2>/dev/null; then
                # Set proper permissions
                find "$target_dir" -type f -exec chmod 600 {} \;
                
                # Create compatibility symlink if this is a standard location
                if [[ "$legacy_path" == "/root/.config/openai" ]] || [[ "$legacy_path" == "/root/.openai" ]]; then
                    rm -rf "$legacy_path"
                    ln -sf "$target_dir" "$legacy_path"
                    bashio::log.info "Created compatibility symlink: $legacy_path -> $target_dir"
                fi
                
                migrated=true
                bashio::log.info "Migration completed from: $legacy_path"
            else
                bashio::log.warning "Failed to migrate from: $legacy_path"
            fi
        fi
    done

    if [ "$migrated" = false ]; then
        bashio::log.info "No existing authentication files found to migrate"
    fi
}

# Install required tools
install_tools() {
    bashio::log.info "Installing additional tools..."
    if ! apk add --no-cache ttyd jq curl; then
        bashio::log.error "Failed to install required tools"
        exit 1
    fi
    bashio::log.info "Tools installed successfully"
}

# Setup session picker script
setup_session_picker() {
    # Copy session picker script from built-in location
    if [ -f "/opt/scripts/codex-session-picker.sh" ]; then
        if ! cp /opt/scripts/codex-session-picker.sh /usr/local/bin/codex-session-picker; then
            bashio::log.error "Failed to copy codex-session-picker script"
            exit 1
        fi
        chmod +x /usr/local/bin/codex-session-picker
        bashio::log.info "Session picker script installed successfully"
    else
        bashio::log.warning "Session picker script not found, using auto-launch mode only"
    fi

    # Setup authentication helper if it exists
    if [ -f "/opt/scripts/codex-auth-helper.sh" ]; then
        chmod +x /opt/scripts/codex-auth-helper.sh
        bashio::log.info "Authentication helper script ready"
    fi
}

# Legacy monitoring functions removed - using simplified /data approach

# Determine Codex launch command based on configuration
get_codex_launch_command() {
    local auto_launch_codex
    local auth_file="${OPENAI_CONFIG_DIR:-/data/.config/codex}/auth.json"

    # Get configuration value, default to false
    auto_launch_codex=$(bashio::config 'auto_launch_codex' 'false')

    # Check if auth file exists
    if [ ! -f "$auth_file" ]; then
        # No auth file - run auth helper automatically
        echo "clear && echo 'Welcome to ChatGPT Terminal!' && echo '' && echo 'No authentication found. Running setup helper...' && sleep 2 && /opt/scripts/codex-auth-helper.sh && exec bash"
    elif [ "$auto_launch_codex" = "true" ]; then
        # Auth exists and auto-launch enabled
        echo "clear && echo 'Welcome to ChatGPT Terminal!' && echo '' && echo 'Starting Codex...' && sleep 1 && node \$(which codex)"
    else
        # Auth exists but auto-launch disabled - show session picker
        if [ -f /usr/local/bin/codex-session-picker ]; then
            echo "clear && /usr/local/bin/codex-session-picker"
        else
            # Fallback if session picker is missing
            bashio::log.warning "Session picker not found, dropping to bash"
            echo "clear && echo 'Welcome to ChatGPT Terminal!' && echo '' && echo 'Run: codex' && bash"
        fi
    fi
}


# Start main web terminal
start_web_terminal() {
    local port=7682
    bashio::log.info "Starting web terminal on port ${port}..."
    
    # Log environment information for debugging
    bashio::log.info "Environment variables:"
    bashio::log.info "OPENAI_CONFIG_DIR=${OPENAI_CONFIG_DIR}"
    bashio::log.info "HOME=${HOME}"

    # Get the appropriate launch command based on configuration
    local launch_command
    launch_command=$(get_codex_launch_command)

    # Log the configuration being used
    local auto_launch_codex
    auto_launch_codex=$(bashio::config 'auto_launch_codex' 'true')
    bashio::log.info "Auto-launch Codex: ${auto_launch_codex}"
    
    # Run ttyd with improved configuration
    exec ttyd \
        --port "${port}" \
        --interface 0.0.0.0 \
        --writable \
        bash -c "$launch_command"
}

# Run health check
run_health_check() {
    if [ -f "/opt/scripts/health-check.sh" ]; then
        bashio::log.info "Running system health check..."
        chmod +x /opt/scripts/health-check.sh
        /opt/scripts/health-check.sh || bashio::log.warning "Some health checks failed but continuing..."
    fi
}

# Main execution
main() {
    bashio::log.info "Initializing ChatGPT Terminal add-on..."

    # Run diagnostics first (especially helpful for VirtualBox issues)
    run_health_check

    init_environment
    install_tools
    setup_session_picker
    start_web_terminal
}

# Execute main function
main "$@"