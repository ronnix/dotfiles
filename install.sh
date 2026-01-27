#!/bin/bash -e

# Function to show usage
show_usage() {
    echo "Usage: $0 [module1] [module2] ..."
    echo "       $0 --list"
    echo ""
    echo "If no modules are specified, all modules will be installed."
    echo "Use --list to see available modules."
    echo ""
    echo "Examples:"
    echo "  $0                    # Install all modules"
    echo "  $0 zsh python         # Install only zsh and python (with dependencies)"
    echo "  $0 --list             # List available modules"
}

# Function to list available modules
list_modules() {
    echo "Available modules:"
    for script in install.sh.d/*.sh; do
        local module_name=$(basename "$script" .sh)
        local deps=$(grep '^# DEPENDS:' "$script" 2>/dev/null | sed 's/^# DEPENDS: *//' || true)
        if [ -n "$deps" ]; then
            echo "  $module_name (depends on: $deps)"
        else
            echo "  $module_name"
        fi
    done
}

# Parse command line arguments early
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
    show_usage
    exit 0
elif [ "$1" = "--list" ] || [ "$1" = "-l" ]; then
    list_modules
    exit 0
fi

#
# Extra install steps with dependency management
#

# Function to extract dependencies from script comments
get_dependencies() {
    local script="$1"
    grep '^# DEPENDS:' "$script" 2>/dev/null | sed 's/^# DEPENDS: *//' || true
}

# Function to check if a script has already been executed
is_executed() {
    local script="$1"
    [[ " ${executed_scripts[*]} " =~ " ${script} " ]]
}

# Function to execute a script and its dependencies
execute_script() {
    local script="$1"
    local script_name=$(basename "$script")
    
    # Skip if already executed
    if is_executed "$script_name"; then
        return 0
    fi
    
    # Get and execute dependencies first
    local deps=$(get_dependencies "$script")
    if [ -n "$deps" ]; then
        for dep in $deps; do
            local dep_path="install.sh.d/${dep}.sh"
            if [ -f "$dep_path" ]; then
                echo "  → Dependency: $dep"
                execute_script "$dep_path"
            else
                echo "  ⚠️  Warning: Dependency $dep not found"
            fi
        done
    fi
    
    # Execute the script itself
    echo "Installing: $script_name"
    "$script"
    executed_scripts+=("$script_name")
}

# Array to track executed scripts
declare -a executed_scripts

# Determine platform-specific module
case $(uname -s) in
  Linux)
    PLATFORM_MODULE="linux"
    ;;
  Darwin)
    PLATFORM_MODULE="macos"
    ;;
  *)
    echo "❌ Unsupported platform: $(uname -s)"
    exit 1
    ;;
esac

# Parse command line arguments for module selection
if [ $# -gt 0 ]; then
    # Install specific modules (always include platform module first)
    echo "Installing platform module ($PLATFORM_MODULE) and specific modules: $*"
    
    # Install platform module first
    platform_script="install.sh.d/${PLATFORM_MODULE}.sh"
    if [ -f "$platform_script" ]; then
        execute_script "$platform_script"
    fi
    
    # Then install requested modules
    for module in "$@"; do
        script_path="install.sh.d/${module}.sh"
        if [ -f "$script_path" ]; then
            execute_script "$script_path"
        else
            echo "❌ Module '$module' not found. Use --list to see available modules."
            exit 1
        fi
    done
else
    # Install all modules (default behavior)
    echo "Installing all modules..."
    for script in install.sh.d/*.sh; do
        execute_script "$script"
    done
fi
