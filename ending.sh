#!/bin/bash

# ending.sh - Verify workspace, write work log, update README/handover, and push to GitHub.
# Date: 2026-07-27

echo "=========================================================="
echo "          🏁 AIoT Session Completion 🏁                   "
echo "=========================================================="
echo ""

# 1. Verify workspace consistency
echo "🔍 [1/3] Verifying workspace and checking changes..."
CHANGES=$(git status --porcelain)
if [ -z "$CHANGES" ]; then
    echo "ℹ️ No local changes to commit. Everything is clean."
else
    echo "📦 Modified/untracked files:"
    git status -s
    echo ""
fi

# Basic file syntax verification
echo "Running syntax and consistency checks..."
VALID=true

# Check Python syntax if python is available
if command -v python >/dev/null 2>&1; then
    PYTHON_FILES=$(find . -name "*.py" -not -path "*/.*")
    if [ -n "$PYTHON_FILES" ]; then
        echo "Checking Python files..."
        for file in $PYTHON_FILES; do
            if python -m py_compile "$file" >/dev/null 2>&1; then
                echo "  ✓ $file (Syntax OK)"
            else
                echo "  ✗ $file (Syntax Error)"
                VALID=false
            fi
        done
    fi
fi

# Check JS syntax if node is available
if command -v node >/dev/null 2>&1; then
    JS_FILES=$(find . -name "*.js" -not -path "*/node_modules/*" -not -path "*/.*")
    if [ -n "$JS_FILES" ]; then
        echo "Checking JS files..."
        for file in $JS_FILES; do
            if node --check "$file" >/dev/null 2>&1; then
                echo "  ✓ $file (Syntax OK)"
            else
                echo "  ✗ $file (Syntax Error)"
                VALID=false
            fi
        done
    fi
fi

if [ "$VALID" = true ]; then
    echo "✅ Verification complete: Code looks consistent!"
else
    echo "⚠️ Verification failed: Some files contain syntax errors. Please fix them before pushing."
    read -p "Do you still want to proceed with logging and pushing? (y/n): " PROCEED
    if [[ ! "$PROCEED" =~ ^[Yy]$ ]]; then
        echo "Exiting."
        exit 1
    fi
fi
echo ""

# 2. Gather work summary and next actions
echo "📝 [2/3] Writing work summaries and updates..."

# Prompt for work summary
echo "Enter a summary of work completed this session (e.g. Implemented hardware dashboard):"
read -r SUMMARY

if [ -z "$SUMMARY" ]; then
    echo "❌ Summary cannot be empty. Exiting."
    exit 1
fi

# Prompt for next actions
echo "Enter action items for next time (Press Enter on an empty line to finish):"
TODO_ITEMS=""
while true; do
    read -r -p "- [ ] " item
    if [ -z "$item" ]; then
        break
    fi
    TODO_ITEMS="${TODO_ITEMS}- [ ] ${item}\n"
done

# Fallback default todo item if empty
if [ -z "$TODO_ITEMS" ]; then
    TODO_ITEMS="- [ ] Plan next development steps.\n"
fi

TIMESTAMP_LONG=$(date "+%Y-%m-%d %H:%M:%S")
TIMESTAMP_SHORT=$(date "+%Y-%m-%d")

# A. Update log.md (Prepending latest activity)
LOG_FILE="log.md"
NEW_LOG_ENTRY="## [$TIMESTAMP_LONG] Update
- $SUMMARY

"
if [ -f "$LOG_FILE" ]; then
    (echo "$NEW_LOG_ENTRY"; cat "$LOG_FILE") > "${LOG_FILE}.tmp" && mv "${LOG_FILE}.tmp" "$LOG_FILE"
    echo "✅ Updated $LOG_FILE (prepended new entry)."
else
    echo -e "# Project Activity Log\n\n$NEW_LOG_ENTRY" > "$LOG_FILE"
    echo "✅ Created $LOG_FILE with initial log entry."
fi

# B. Update README.md (Adding to 'Recent Updates' or creating the section)
README_FILE="README.md"
if [ -f "$README_FILE" ]; then
    if grep -q "## 📅 Recent Updates" "$README_FILE"; then
        # Insert updates under the title
        awk -v update="### $TIMESTAMP_SHORT\n- $SUMMARY\n" '/## 📅 Recent Updates/ { print; print update; next }1' "$README_FILE" > "${README_FILE}.tmp" && mv "${README_FILE}.tmp" "$README_FILE"
        echo "✅ Updated $README_FILE ('Recent Updates' section)."
    else
        # Create 'Recent Updates' section before 'Contributing' or 'License'
        INSERT_BLOCK="## 📅 Recent Updates

### $TIMESTAMP_SHORT
- $SUMMARY

---

"
        if grep -q "## 🤝 Contributing" "$README_FILE"; then
            awk -v block="$INSERT_BLOCK" '/## 🤝 Contributing/ { print block; print; next }1' "$README_FILE" > "${README_FILE}.tmp" && mv "${README_FILE}.tmp" "$README_FILE"
            echo "✅ Added 'Recent Updates' section to $README_FILE before Contributing."
        else
            echo -e "\n$INSERT_BLOCK" >> "$README_FILE"
            echo "✅ Appended 'Recent Updates' section to $README_FILE."
        fi
    fi
else
    echo "⚠️  $README_FILE not found, skipping README update."
fi

# C. Update handover.md (Rewriting with finished work and next steps)
HANDOVER_FILE="handover.md"
cat << EOF > "$HANDOVER_FILE"
# Handover Notes

## Work Summary (Last Time)
- $SUMMARY

## Hints / Action Items for Today
$(echo -e "$TODO_ITEMS")
EOF
echo "✅ Updated $HANDOVER_FILE for the next session."
echo ""

# 3. Commit and push to GitHub
echo "🚀 [3/3] Committing and pushing changes to GitHub..."
git add .
git commit -m "Update: $SUMMARY"

# Get active branch
BRANCH=$(git branch --show-current)
if [ -z "$BRANCH" ]; then
    BRANCH="main"
fi

# Push
git push -u origin "$BRANCH"
echo ""
echo "🎉 Session complete! All files verified, logs updated, and pushed to GitHub."
