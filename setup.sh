#!/bin/bash

# OpenCode Research-Plan-Implement Framework Setup Script
# This script helps you adopt the framework in your repository

set -e

echo "🚀 OpenCode Framework Setup"
echo "================================"
echo ""

# Get target directory
if [ -z "$1" ]; then
    read -p "Enter the path to your repository: " TARGET_DIR
else
    TARGET_DIR="$1"
fi

# Validate target directory
if [ ! -d "$TARGET_DIR" ]; then
    echo "❌ Error: Directory '$TARGET_DIR' does not exist"
    exit 1
fi

# Check if .opencode already exists
if [ -d "$TARGET_DIR/.opencode" ]; then
    echo "ℹ️  .opencode directory already exists in $TARGET_DIR"

    # Check for existing commands and agents
    if [ -d "$TARGET_DIR/.opencode/commands" ] || [ -d "$TARGET_DIR/.opencode/agents" ]; then
        echo "📦 Found existing framework installation"
        echo ""
        echo "What would you like to do?"
        echo "1) Update framework (overwrite with latest versions)"
        echo "2) Skip existing files (only add new ones)"
        echo "3) Cancel"
        read -p "Choose option (1/2/3): " INSTALL_OPTION
        
        case $INSTALL_OPTION in
            1)
                echo "📥 Updating framework to latest version..."
                UPDATE_MODE="true"
                ;;
            2)
                echo "🔀 Adding new files only, keeping existing ones..."
                UPDATE_MODE="false"
                ;;
            *)
                echo "Setup cancelled"
                exit 0
                ;;
        esac
    fi
else
    # Create .opencode if it doesn't exist
    mkdir -p "$TARGET_DIR/.opencode"
    UPDATE_MODE="false"
fi

# Check if thoughts already exists
if [ -d "$TARGET_DIR/thoughts" ]; then
    echo "⚠️  Warning: thoughts directory already exists in $TARGET_DIR"
    read -p "Do you want to merge with existing thoughts? (y/N): " MERGE
    if [ "$MERGE" != "y" ] && [ "$MERGE" != "Y" ]; then
        echo "Setup cancelled"
        exit 0
    fi
fi

echo ""
echo "📁 Creating directory structure..."

# Create directories if they don't exist
mkdir -p "$TARGET_DIR/.opencode/agents"
mkdir -p "$TARGET_DIR/.opencode/commands"
mkdir -p "$TARGET_DIR/thoughts/shared/research"
mkdir -p "$TARGET_DIR/thoughts/shared/plans"
mkdir -p "$TARGET_DIR/thoughts/shared/sessions"
mkdir -p "$TARGET_DIR/thoughts/shared/cloud"

echo "📝 Copying framework files..."

# Copy commands - handle update vs skip mode
echo "  Installing commands..."
for cmd_file in .opencode/commands/*.md; do
    filename=$(basename "$cmd_file")
    if [ -f "$TARGET_DIR/.opencode/commands/$filename" ]; then
        if [ "$UPDATE_MODE" = "true" ]; then
            # In update mode, overwrite existing files
            cp "$cmd_file" "$TARGET_DIR/.opencode/commands/"
            echo "    🔄 Updated $filename"
        else
            echo "    ⚠️  $filename already exists, skipping..."
        fi
    else
        cp "$cmd_file" "$TARGET_DIR/.opencode/commands/"
        echo "    ✅ Installed $filename"
    fi
done

# Copy agents - handle update vs skip mode
echo "  Installing agents..."
for agent_file in .opencode/agents/*.md; do
    filename=$(basename "$agent_file")
    if [ -f "$TARGET_DIR/.opencode/agents/$filename" ]; then
        if [ "$UPDATE_MODE" = "true" ]; then
            # In update mode, overwrite existing files
            cp "$agent_file" "$TARGET_DIR/.opencode/agents/"
            echo "    🔄 Updated $filename"
        else
            echo "    ⚠️  $filename already exists, skipping..."
        fi
    else
        cp "$agent_file" "$TARGET_DIR/.opencode/agents/"
        echo "    ✅ Installed $filename"
    fi
done

# Copy playbook if it doesn't exist or ask to update
if [ -f "$TARGET_DIR/PLAYBOOK.md" ]; then
    echo ""
    read -p "PLAYBOOK.md already exists. Update it? (y/N): " UPDATE_PLAYBOOK
    if [ "$UPDATE_PLAYBOOK" = "y" ] || [ "$UPDATE_PLAYBOOK" = "Y" ]; then
        cp PLAYBOOK.md "$TARGET_DIR/"
        echo "✅ Updated PLAYBOOK.md"
    else
        echo "ℹ️  Kept existing PLAYBOOK.md"
    fi
else
    cp PLAYBOOK.md "$TARGET_DIR/"
    echo "✅ Installed PLAYBOOK.md"
fi

# Check if AGENTS.md exists and offer to append framework section
if [ -f "$TARGET_DIR/AGENTS.md" ]; then
    echo ""
    echo "📝 AGENTS.md Configuration"
    echo "=========================="
    echo ""
    echo "AGENTS.md already exists in the target repository."
    read -p "Would you like to append a section about the Research-Plan-Implement framework commands? (y/N): " APPEND_AGENTS

    if [ "$APPEND_AGENTS" = "y" ] || [ "$APPEND_AGENTS" = "Y" ]; then
        echo "" >> "$TARGET_DIR/AGENTS.md"
        echo "## Research-Plan-Implement Framework" >> "$TARGET_DIR/AGENTS.md"
        echo "" >> "$TARGET_DIR/AGENTS.md"
        echo "This repository uses the Research-Plan-Implement framework with the following workflow commands:" >> "$TARGET_DIR/AGENTS.md"
        echo "" >> "$TARGET_DIR/AGENTS.md"
        echo "1. \`/1_research_codebase\` - Deep codebase exploration with parallel AI agents" >> "$TARGET_DIR/AGENTS.md"
        echo "2. \`/2_create_plan\` - Create detailed, phased implementation plans" >> "$TARGET_DIR/AGENTS.md"
        echo "3. \`/3_validate_plan\` - Verify implementation matches plan" >> "$TARGET_DIR/AGENTS.md"
        echo "4. \`/4_implement_plan\` - Execute plan systematically" >> "$TARGET_DIR/AGENTS.md"
        echo "5. \`/5_save_progress\` - Save work session state" >> "$TARGET_DIR/AGENTS.md"
        echo "6. \`/6_resume_work\` - Resume from saved session" >> "$TARGET_DIR/AGENTS.md"
        echo "7. \`/7_research_cloud\` - Analyze cloud infrastructure (READ-ONLY)" >> "$TARGET_DIR/AGENTS.md"
        echo "" >> "$TARGET_DIR/AGENTS.md"
        echo "Research findings are saved in \`thoughts/shared/research/\`" >> "$TARGET_DIR/AGENTS.md"
        echo "Implementation plans are saved in \`thoughts/shared/plans/\`" >> "$TARGET_DIR/AGENTS.md"
        echo "Session summaries are saved in \`thoughts/shared/sessions/\`" >> "$TARGET_DIR/AGENTS.md"
        echo "Cloud analyses are saved in \`thoughts/shared/cloud/\`" >> "$TARGET_DIR/AGENTS.md"
        echo "✅ Appended framework section to AGENTS.md"
    else
        echo "ℹ️  Skipping AGENTS.md modification"
    fi
else
    echo ""
    echo "ℹ️  No AGENTS.md found in target repository."
    echo "    Consider creating one to provide OpenCode with project-specific guidance."
fi

# Create a sample research template
echo "📚 Creating sample templates..."

cat > "$TARGET_DIR/thoughts/shared/research/TEMPLATE.md" << 'EOF'
---
date: YYYY-MM-DD HH:MM:SS
researcher: OpenCode
topic: "Research Topic"
tags: [research, codebase]
status: complete
---

# Research: [Topic]

## Research Question
[What we're investigating]

## Summary
[High-level findings]

## Detailed Findings
[Specific discoveries with code references]

## Architecture Insights
[Patterns and design decisions]

## Open Questions
[Areas needing further investigation]
EOF

cat > "$TARGET_DIR/thoughts/shared/plans/TEMPLATE.md" << 'EOF'
# Implementation Plan Template

## Overview
[What we're building and why]

## Current State Analysis
[What exists now]

## Desired End State
[What success looks like]

## Phase 1: [Name]

### Changes Required:
- [File]: [Changes needed]

### Success Criteria:
#### Automated:
- [ ] Tests pass
- [ ] Linting passes

#### Manual:
- [ ] Feature works as expected

## Testing Strategy
[How we'll verify this works]
EOF

echo ""
if [ "$UPDATE_MODE" = "true" ]; then
    echo "🎉 Framework Updated Successfully!"
    echo "===================================="
    echo ""
    echo "Framework updated in: $TARGET_DIR"
    echo ""
    echo "📋 Update Summary:"
    echo "- Commands and agents updated to latest versions"
    echo "- Your research documents and plans are preserved"
    echo ""
    echo "💡 To revert changes:"
    echo "- Use git: 'git checkout -- .opencode/'"
    echo ""
    echo "📖 To update framework in the future:"
    echo "- Run: ./setup.sh $TARGET_DIR"
    echo "- Choose option 1 (Update framework)"
else
    echo "🎉 Setup Complete!"
    echo "=================="
    echo ""
    echo "Framework installed in: $TARGET_DIR"
    echo ""
    echo "📖 Next Steps:"
    echo "1. Review $TARGET_DIR/PLAYBOOK.md for usage instructions"
    echo "2. Try the workflow with a simple task:"
    echo "   - /1_research_codebase"
    echo "   - /2_create_plan"
    echo "   - /4_implement_plan"
    if [ "$APPEND_AGENTS" = "y" ] || [ "$APPEND_AGENTS" = "Y" ]; then
        echo "3. Framework commands have been added to your AGENTS.md"
    fi
    echo ""
    echo "💡 Tips:"
    echo "- Commands are numbered to show the typical flow"
    echo "- Research documents accumulate in thoughts/shared/research/"
    echo "- Plans serve as technical specifications"
    echo "- Use parallel agents for faster research"
    echo "- Use git to track and manage framework changes"
    echo ""
    echo "🔄 To update framework in the future:"
    echo "- Run: ./setup.sh $TARGET_DIR"
    echo "- Choose option 1 (Update framework)"
fi
echo ""
echo "Happy coding! 🚀"
