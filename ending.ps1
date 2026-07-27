# ending.ps1 - Verify workspace, write work log, update README/handover, and push to GitHub.
# Date: 2026-07-27

param (
    [string]$Summary,
    [string[]]$Todos
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "          🏁 AIoT Session Completion 🏁                   " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

# 1. Verify workspace consistency
Write-Host "🔍 [1/3] Verifying workspace and checking changes..." -ForegroundColor Yellow
$Changes = git status --porcelain
if ([string]::IsNullOrEmpty($Changes)) {
    Write-Host "ℹ️ No local changes to commit. Everything is clean." -ForegroundColor Gray
} else {
    Write-Host "📦 Modified/untracked files:" -ForegroundColor Cyan
    git status -s
    Write-Host ""
}

# Basic file syntax verification
Write-Host "Running syntax and consistency checks..." -ForegroundColor Yellow
$Valid = $true

# Check Python syntax if python is available
if (Get-Command python -ErrorAction SilentlyContinue) {
    $PyFiles = Get-ChildItem -Filter *.py -Recurse -File | Where-Object { $_.FullName -notmatch "\\\." }
    if ($PyFiles) {
        Write-Host "Checking Python files..." -ForegroundColor Yellow
        foreach ($file in $PyFiles) {
            python -m py_compile $file.FullName *>$null
            if ($LASTEXITCODE -eq 0) {
                Write-Host "  ✓ $($file.Name) (Syntax OK)" -ForegroundColor Green
            } else {
                Write-Host "  ✗ $($file.Name) (Syntax Error)" -ForegroundColor Red
                $Valid = $false
            }
        }
    }
}

# Check JS syntax if node is available
if (Get-Command node -ErrorAction SilentlyContinue) {
    $JsFiles = Get-ChildItem -Filter *.js -Recurse -File | Where-Object { $_.FullName -notmatch "node_modules" -and $_.FullName -notmatch "\\\." }
    if ($JsFiles) {
        Write-Host "Checking JS files..." -ForegroundColor Yellow
        foreach ($file in $JsFiles) {
            node --check $file.FullName *>$null
            if ($LASTEXITCODE -eq 0) {
                Write-Host "  ✓ $($file.Name) (Syntax OK)" -ForegroundColor Green
            } else {
                Write-Host "  ✗ $($file.Name) (Syntax Error)" -ForegroundColor Red
                $Valid = $false
            }
        }
    }
}

# Check PHP syntax if php is available
if (Get-Command php -ErrorAction SilentlyContinue) {
    $PhpFiles = Get-ChildItem -Filter *.php -Recurse -File | Where-Object { $_.FullName -notmatch "\\\." }
    if ($PhpFiles) {
        Write-Host "Checking PHP files..." -ForegroundColor Yellow
        foreach ($file in $PhpFiles) {
            php -l $file.FullName *>$null
            if ($LASTEXITCODE -eq 0) {
                Write-Host "  ✓ $($file.Name) (Syntax OK)" -ForegroundColor Green
            } else {
                Write-Host "  ✗ $($file.Name) (Syntax Error)" -ForegroundColor Red
                $Valid = $false
            }
        }
    }
}

if (-not $Valid) {
    Write-Host "⚠️ Verification failed: Some files contain syntax errors. Please fix them before pushing." -ForegroundColor Red
    $Proceed = Read-Host "Do you still want to proceed with logging and pushing? (y/n)"
    if ($Proceed -notmatch "^[Yy]$") {
        Write-Host "Exiting." -ForegroundColor Red
        exit 1
    }
} else {
    Write-Host "✅ Verification complete: Code looks consistent!" -ForegroundColor Green
}
Write-Host ""

# 2. Gather work summary and next actions
Write-Host "📝 [2/3] Writing work summaries and updates..." -ForegroundColor Yellow

# Prompt for work summary if not provided as argument
if ([string]::IsNullOrEmpty($Summary)) {
    $Summary = Read-Host "Enter a summary of work completed this session (e.g. Implemented hardware dashboard)"
}

if ([string]::IsNullOrEmpty($Summary)) {
    Write-Host "❌ Summary cannot be empty. Exiting." -ForegroundColor Red
    exit 1
}

# Prompt for next actions if not provided as argument
$TodoList = ""
if ($null -eq $Todos -or $Todos.Count -eq 0) {
    Write-Host "Enter action items for next time (Press Enter on an empty line to finish):"
    $InputItems = @()
    while ($true) {
        $item = Read-Host "- [ ] "
        if ([string]::IsNullOrEmpty($item)) { break }
        $InputItems += "- [ ] $item"
    }
    $TodoList = $InputItems -join "`n"
} else {
    $TodoList = ($Todos | ForEach-Object { "- [ ] $_" }) -join "`n"
}

# Fallback default todo item if empty
if ([string]::IsNullOrEmpty($TodoList)) {
    $TodoList = "- [ ] Plan next development steps."
}

$TimestampLong = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$TimestampShort = Get-Date -Format "yyyy-MM-dd"

# A. Update log.md (Prepending latest activity with TIMESTAMP on the first row)
$LogFile = "log.md"
$TimestampLine = "# Last Updated: $TimestampLong"
$NewLogEntry = "## [$TimestampLong] Update`n- $Summary"

if (Test-Path $LogFile) {
    $OldContent = Get-Content $LogFile
    # Strip any existing "# Last Updated" line
    $OldContentFiltered = $OldContent | Where-Object { $_ -notmatch "^# Last Updated:" }
    # Prepend new entry
    $NewContent = @($TimestampLine, "", $NewLogEntry, "") + $OldContentFiltered
    # Remove excessive blank lines at the top of content
    $NewContent | Set-Content -Path $LogFile -Encoding utf8
    Write-Host "✅ Updated $LogFile (prepended new entry and updated timestamp on first row)." -ForegroundColor Green
} else {
    $NewContent = @($TimestampLine, "", "# Project Activity Log", "", $NewLogEntry)
    $NewContent | Set-Content -Path $LogFile -Encoding utf8
    Write-Host "✅ Created $LogFile with timestamp on the first row." -ForegroundColor Green
}

# B. Update README.md (Adding to 'Recent Updates' or creating the section)
$ReadmeFile = "README.md"
if (Test-Path $ReadmeFile) {
    $ReadmeContent = Get-Content $ReadmeFile -Raw
    $UpdateText = "### $TimestampShort`n- $Summary`n`n"
    
    if ($ReadmeContent -match "## 📅 Recent Updates") {
        # Insert updates under the title
        $ReadmeContent = $ReadmeContent -replace "(## 📅 Recent Updates\s*\r?\n)", "`$1$UpdateText"
        $ReadmeContent | Set-Content -Path $ReadmeFile -Encoding utf8
        Write-Host "✅ Updated $ReadmeFile ('Recent Updates' section)." -ForegroundColor Green
    } else {
        # Create 'Recent Updates' section before 'Contributing'
        $InsertBlock = "## 📅 Recent Updates`n`n$UpdateText---`n`n"
        if ($ReadmeContent -match "## 🤝 Contributing") {
            $ReadmeContent = $ReadmeContent -replace "(## 🤝 Contributing)", "$InsertBlock`$1"
            $ReadmeContent | Set-Content -Path $ReadmeFile -Encoding utf8
            Write-Host "✅ Added 'Recent Updates' section to $ReadmeFile before Contributing." -ForegroundColor Green
        } else {
            $ReadmeContent = $ReadmeContent + "`n`n" + $InsertBlock
            $ReadmeContent | Set-Content -Path $ReadmeFile -Encoding utf8
            Write-Host "✅ Appended 'Recent Updates' section to $ReadmeFile." -ForegroundColor Green
        }
    }
} else {
    Write-Host "⚠️  $ReadmeFile not found, skipping README update." -ForegroundColor Yellow
}

# C. Update handover.md (Rewriting with finished work and next steps)
$HandoverFile = "handover.md"
$HandoverContent = @"
# Handover Notes

## Work Summary (Last Time)
- $Summary

## Hints / Action Items for Today
$TodoList
"@
$HandoverContent | Set-Content -Path $HandoverFile -Encoding utf8
Write-Host "✅ Updated $HandoverFile for the next session." -ForegroundColor Green
Write-Host ""

# 3. Commit and push to GitHub
Write-Host "🚀 [3/3] Committing and pushing changes to GitHub..." -ForegroundColor Yellow
git add .
git commit -m "Update: $Summary"

$Branch = git branch --show-current
if ([string]::IsNullOrEmpty($Branch)) {
    $Branch = "main"
}

git push -u origin $Branch
Write-Host ""
Write-Host "🎉 Session complete! All files verified, logs updated, and pushed to GitHub." -ForegroundColor Cyan
