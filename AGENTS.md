# AGENTS.md

This file provides guidance to AI Coding Agents like OpenCode (https://opencode.ai/) when working with code in this repository.

## Repository Overview

This is the OpenCode Research-Plan-Implement Framework - a structured workflow framework for AI-assisted software development. The framework emphasizes thorough research, detailed planning, and systematic implementation with persistent documentation.

## Commands

### Framework Installation & Setup
```bash
# Install framework in target repository
./setup.sh /path/to/target/repo

# Manual installation (from framework repo)
cp -r .opencode /path/to/target/repo/
cp -r thoughts /path/to/target/repo/
cp PLAYBOOK.md /path/to/target/repo/
```

### Workflow Commands (in target repositories using this framework)
1. `/1_research_codebase` - Deep codebase exploration with parallel AI agents
2. `/2_create_plan` - Create detailed, phased implementation plans
3. `/3_validate_plan` - Verify implementation matches plan
4. `/4_implement_plan` - Execute plan systematically
5. `/5_save_progress` - Save work session state
6. `/6_resume_work` - Resume from saved session

## High-Level Architecture

### Framework Structure
```
opencode-research-plan-implement/
├── .opencode/
│   ├── agents/                   # Specialized AI agent definitions
│   │   ├── codebase-locator.md   # Finds relevant files efficiently
│   │   ├── codebase-analyzer.md  # Analyzes code implementation details
│   │   └── codebase-pattern-finder.md # Identifies patterns to follow
│   ├── commands/                 # Numbered workflow command definitions
│   │   └── [1-6]_*.md           # Each phase of the workflow
│   └── settings.local.json      # Permission settings (allows find/ls)
├── thoughts/                     # Persistent context storage structure
│   └── shared/
│       ├── research/            # Research findings (YYYY-MM-DD_*.md)
│       ├── plans/               # Implementation plans
│       └── sessions/            # Work session summaries
├── PLAYBOOK.md                   # Comprehensive guide
├── README.md                     # Quick start guide
└── setup.sh                      # Automated installation script
```

### Key Architectural Concepts

1. **Parallel Agent System**: The research phase spawns multiple specialized AI agents that work concurrently to explore different aspects of a codebase, dramatically improving research speed and thoroughness.

2. **Persistent Context Storage**: All research findings, plans, and session summaries are stored as markdown files in the `thoughts/` directory, building a knowledge base over time that persists across Agent sessions.

3. **Phased Workflow**: The numbered commands enforce a structured approach: Research → Plan → Implement → Validate → Save/Resume. Each phase builds on the previous ones.

4. **Framework Agnostic**: The setup.sh script customizes the framework for JavaScript, Python, Go, or other projects, generating appropriate CLAUDE.md templates and command customizations.

5. **Session Management**: Commands 5 and 6 allow saving and resuming work state, enabling long-running tasks to span multiple Claude sessions.

### Integration Points

- **Command System**: Each `.opencode/commands/*.md` file defines a slash command that modifies Claude's behavior for that specific workflow phase
- **Agent Definitions**: The `.opencode/agents/*.md` files define specialized sub-agents with focused capabilities
- **Settings**: The `settings.local.json` enables specific bash commands (find, ls) needed by the framework
- **Documentation Templates**: The framework creates template files for research findings and plans to ensure consistency

### Usage in Target Repositories

When this framework is installed in a target repository:
1. Developers invoke numbered commands to progress through the workflow
2. Research findings accumulate in `thoughts/shared/research/`
3. Implementation plans are saved to `thoughts/shared/plans/`
4. The framework guides systematic, well-documented development
5. All context persists between Agent sessions for continuity
