#!/bin/bash

# OpenCode Framework Update Script
# Quick wrapper to run setup.sh in update mode

set -e

echo "🔄 OpenCode Framework Update"
echo "================================"
echo ""

# Get target directory
if [ -z "$1" ]; then
    # Try current directory first
    if [ -d ".opencode" ]; then
        TARGET_DIR="."
        echo "📁 Updating framework in current directory"
    else
        read -p "Enter the path to your repository: " TARGET_DIR
    fi
else
    TARGET_DIR="$1"
fi

# Validate target directory
if [ ! -d "$TARGET_DIR" ]; then
    echo "❌ Error: Directory '$TARGET_DIR' does not exist"
    exit 1
fi

# Check if framework is installed
if [ ! -d "$TARGET_DIR/.opencode" ]; then
    echo "❌ Error: No framework installation found in '$TARGET_DIR'"
    echo "Run setup.sh first to install the framework"
    exit 1
fi

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Run setup.sh from the framework directory
echo "Running update process..."
echo ""

# Auto-select update option by piping "1" to setup.sh
echo "1" | "$SCRIPT_DIR/setup.sh" "$TARGET_DIR"
