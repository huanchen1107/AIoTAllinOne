#!/bin/bash

# start.sh - Helper script to initialize Git config, read handover notes, and suggest tasks.
# Date: 2026-07-27

echo "=========================================================="
echo "          🤖 AIoT Project Initialization 🤖               "
echo "=========================================================="
echo ""

# 1. Auto connect to GitHub
echo "🔗 [1/3] Configuring GitHub Connection..."
git config user.name "Huan Chen"
git config user.email "huanchen1107@gmail.com"

# Ensure remote is correctly set up
REMOTE_URL="https://github.com/huanchen1107/AIoTAllinOne.git"
if git remote | grep -q "^origin$"; then
    git remote set-url origin "$REMOTE_URL"
else
    git remote add origin "$REMOTE_URL"
fi

echo "✅ Git User: Huan Chen (huanchen1107@gmail.com)"
echo "✅ Remote URL: $REMOTE_URL"
echo ""

# 2. Check handover.md for work summary done last time
HANDOVER_FILE="handover.md"
echo "📝 [2/3] Checking Handover Notes..."
if [ -f "$HANDOVER_FILE" ]; then
    echo "Found $HANDOVER_FILE. Showing summary of work done last time:"
    echo "--------------------------------------------------------"
    # Print the "Work Summary (Last Time)" section specifically, or the whole file if not formatted.
    # Let's show the lines under "Work Summary (Last Time)" up to the next section
    sed -n '/## Work Summary/,/##/p' "$HANDOVER_FILE" | grep -v '##' | sed '/^[[:space:]]*$/d'
    echo "--------------------------------------------------------"
else
    echo "⚠️  $HANDOVER_FILE not found. Creating a new template..."
    cat << 'EOF' > "$HANDOVER_FILE"
# Handover Notes

## Work Summary (Last Time)
- Configured local Git details and successfully pushed initial README.md to GitHub remote.
- Created `start.sh` startup script.

## Hints / Action Items for Today
- [ ] Design the architecture for the AIoT All-in-One project.
- [ ] Determine key tech stack components (Node.js, Python, PHP, etc.) since we are in XAMPP directory.
- [ ] Start implementing the initial backend service or mock hardware sensors.
EOF
    echo "Created initial $HANDOVER_FILE. Please review it."
    echo "--------------------------------------------------------"
    sed -n '/## Work Summary/,/##/p' "$HANDOVER_FILE" | grep -v '##' | sed '/^[[:space:]]*$/d'
    echo "--------------------------------------------------------"
fi
echo ""

# 3. Give hints for today's work
echo "💡 [3/3] Hints for Today's Work..."
if [ -f "$HANDOVER_FILE" ]; then
    echo "--------------------------------------------------------"
    # Print lines under "Hints / Action Items for Today"
    sed -n '/## Hints \/ Action Items for Today/,$p' "$HANDOVER_FILE" | grep -v '##' | sed '/^[[:space:]]*$/d'
    echo "--------------------------------------------------------"
else
    echo "- Design the project layout and database structure if applicable."
    echo "- Plan the communication protocol (MQTT, HTTP, WebSockets) between IoT and Cloud."
fi
echo ""
echo "🚀 Happy coding! Use './start.sh' anytime to re-run this check."
