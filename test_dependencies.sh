#!/bin/bash

# Test framework for dependency management
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
TEST_DIR="$SCRIPT_DIR/test"
MOCK_DIR="$TEST_DIR/mock_install_scripts"
INSTALL_SH_PATH="$SCRIPT_DIR/install.sh"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test counter
TESTS_RUN=0
TESTS_PASSED=0

# Function to run a test
run_test() {
    local test_name="$1"
    local test_function="$2"
    
    echo -e "\n${YELLOW}Running test: $test_name${NC}"
    TESTS_RUN=$((TESTS_RUN + 1))
    
    if $test_function; then
        echo -e "${GREEN}✓ PASS${NC}"
        TESTS_PASSED=$((TESTS_PASSED + 1))
    else
        echo -e "${RED}✗ FAIL${NC}"
    fi
}

# Function to setup test environment
setup_test_env() {
    rm -rf "$TEST_DIR"
    mkdir -p "$MOCK_DIR"
    
    # Track execution log
    export EXECUTION_LOG="$TEST_DIR/execution.log"
    > "$EXECUTION_LOG"
}

# Function to create a mock install script
create_mock_script() {
    local name="$1"
    local depends="$2"
    
    cat > "$MOCK_DIR/${name}.sh" << EOF
#!/bin/bash
# DEPENDS: $depends
echo "Executed: $name" >> "\$EXECUTION_LOG"
EOF
    chmod +x "$MOCK_DIR/${name}.sh"
}

# Test 1: Direct dependencies should work
test_direct_dependencies() {
    setup_test_env
    
    # Create scripts: B depends on A
    create_mock_script "base" ""
    create_mock_script "app" "base"
    
    # Initialize executed scripts array for this test
    declare -a executed_scripts
    
    # Reset executed scripts array
    executed_scripts=()
    
    # Execute app (should also execute base)
    cd "$TEST_DIR"
    execute_script "$MOCK_DIR/app.sh"
    
    # Check execution log
    if [ -f "$EXECUTION_LOG" ] && grep -q "Executed: base" "$EXECUTION_LOG" && grep -q "Executed: app" "$EXECUTION_LOG"; then
        # Check order: base should come before app
        local base_line=$(grep -n "Executed: base" "$EXECUTION_LOG" | cut -d: -f1)
        local app_line=$(grep -n "Executed: app" "$EXECUTION_LOG" | cut -d: -f1)
        if [ "$base_line" -lt "$app_line" ]; then
            echo "✓ Direct dependencies work: base executed before app"
            return 0
        fi
    fi
    echo "✗ Direct dependencies failed or wrong order"
    return 1
}

# Test 2: Transitive dependencies work correctly
test_transitive_dependencies() {
    setup_test_env
    
    # Create scripts: C depends on B, B depends on A
    create_mock_script "foundation" ""
    create_mock_script "middleware" "foundation"
    create_mock_script "application" "middleware"
    
    # Initialize executed scripts array for this test
    declare -a executed_scripts
    
    # Reset executed scripts array
    executed_scripts=()
    
    # Execute application (should execute middleware and foundation, but won't due to current limitation)
    cd "$TEST_DIR"
    execute_script "$MOCK_DIR/application.sh"
    
    # Check if all three were executed (this should FAIL with current implementation)
    local foundation_executed=0
    local middleware_executed=0
    local application_executed=0
    
    if [ -f "$EXECUTION_LOG" ]; then
        foundation_executed=$(grep -c "Executed: foundation" "$EXECUTION_LOG" 2>/dev/null || echo 0)
        middleware_executed=$(grep -c "Executed: middleware" "$EXECUTION_LOG" 2>/dev/null || echo 0)
        application_executed=$(grep -c "Executed: application" "$EXECUTION_LOG" 2>/dev/null || echo 0)
    fi
    
    echo "Execution counts: foundation=$foundation_executed, middleware=$middleware_executed, application=$application_executed"
    
    # Check if all dependencies were executed in correct order
    if [ "$foundation_executed" -eq 1 ] && [ "$middleware_executed" -eq 1 ] && [ "$application_executed" -eq 1 ]; then
        # Verify execution order: foundation -> middleware -> application
        local foundation_line=$(grep -n "Executed: foundation" "$EXECUTION_LOG" | cut -d: -f1)
        local middleware_line=$(grep -n "Executed: middleware" "$EXECUTION_LOG" | cut -d: -f1)
        local application_line=$(grep -n "Executed: application" "$EXECUTION_LOG" | cut -d: -f1)
        
        if [ "$foundation_line" -lt "$middleware_line" ] && [ "$middleware_line" -lt "$application_line" ]; then
            echo "✓ Transitive dependencies work correctly: foundation -> middleware -> application"
            return 0
        else
            echo "✗ Wrong execution order for transitive dependencies"
            return 1
        fi
    else
        echo "✗ Not all transitive dependencies were executed"
        return 1
    fi
}

# Core functions from install.sh for testing
get_dependencies() {
    local script="$1"
    grep '^# DEPENDS:' "$script" 2>/dev/null | sed 's/^# DEPENDS: *//' || true
}

is_executed() {
    local script="$1"
    [[ " ${executed_scripts[*]} " =~ " ${script} " ]]
}

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
            local dep_path="$(dirname "$script")/${dep}.sh"
            if [ -f "$dep_path" ]; then
                echo "  → Dependency: $dep" >&2
                execute_script "$dep_path"
            else
                echo "  ⚠️  Warning: Dependency $dep not found" >&2
            fi
        done
    fi
    
    # Execute the script itself
    echo "Installing: $script_name" >&2
    "$script"
    executed_scripts+=("$script_name")
}

# Function to show test summary
show_summary() {
    echo -e "\n${YELLOW}Test Summary:${NC}"
    echo "Tests run: $TESTS_RUN"
    echo "Tests passed: $TESTS_PASSED"
    echo "Tests failed: $((TESTS_RUN - TESTS_PASSED))"
    
    if [ $TESTS_PASSED -eq $TESTS_RUN ]; then
        echo -e "${GREEN}All tests passed!${NC}"
    else
        echo -e "${RED}Some tests failed!${NC}"
    fi
}

# Run tests
echo "Testing dependency management in install.sh"

run_test "Direct dependencies" test_direct_dependencies
run_test "Transitive dependencies" test_transitive_dependencies

show_summary

# Cleanup
rm -rf "$TEST_DIR"