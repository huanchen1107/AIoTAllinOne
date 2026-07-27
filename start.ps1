# start.ps1 - Helper script to initialize Git config, read handover notes, and suggest tasks.
# Date: 2026-07-27
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "          🤖 AIoT Project Initialization 🤖               " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host ""

# 1. Auto connect to GitHub
Write-Host "🔗 [1/3] Configuring GitHub Connection..." -ForegroundColor Yellow
git config user.name "Huan Chen"
git config user.email "huanchen1107@gmail.com"

$RemoteUrl = "https://github.com/huanchen1107/AIoTAllinOne.git"
$Remotes = git remote
if ($Remotes -contains "origin") {
    git remote set-url origin $RemoteUrl
} else {
    git remote add origin $RemoteUrl
}

Write-Host "✅ Git User: Huan Chen (huanchen1107@gmail.com)" -ForegroundColor Green
Write-Host "✅ Remote URL: $RemoteUrl" -ForegroundColor Green
Write-Host ""

# 2. Check handover.md for work summary done last time
$HandoverFile = "handover.md"
Write-Host "📝 [2/3] Checking Handover Notes..." -ForegroundColor Yellow

if (Test-Path $HandoverFile) {
    Write-Host "Found $HandoverFile. Showing summary of work done last time:" -ForegroundColor Green
    Write-Host "--------------------------------------------------------" -ForegroundColor Gray
    $Content = Get-Content $HandoverFile -Raw
    if ($Content -match "(?is)## Work Summary \(Last Time\)\s*\r?\n(.*?)(?=\r?\n##|$)") {
        $Summary = $Matches[1].Trim()
        Write-Host $Summary
    } else {
        Write-Host "Could not parse Work Summary from $HandoverFile."
    }
    Write-Host "--------------------------------------------------------" -ForegroundColor Gray
} else {
    Write-Host "⚠️  $HandoverFile not found. Creating a new template..." -ForegroundColor Red
    $Template = @"
# Handover Notes

## Work Summary (Last Time)
- Initialized project structure and workspace configuration.
- Configured git startup and ending scripts.

## Hints / Action Items for Today
- [ ] Define the project architecture for AIoT.
- [ ] Initialize the project directories.
"@
    Set-Content -Path $HandoverFile -Value $Template -Encoding utf8
    Write-Host "Created initial $HandoverFile. Please review it." -ForegroundColor Green
}
Write-Host ""

# 3. Give hints for today's work
Write-Host "💡 [3/3] Hints for Today's Work..." -ForegroundColor Yellow
if (Test-Path $HandoverFile) {
    Write-Host "--------------------------------------------------------" -ForegroundColor Gray
    $Content = Get-Content $HandoverFile -Raw
    if ($Content -match "(?is)## Hints / Action Items for Today\s*\r?\n(.*)") {
        $Hints = $Matches[1].Trim()
        Write-Host $Hints
    } else {
        Write-Host "Could not parse Hints from $HandoverFile."
    }
    Write-Host "--------------------------------------------------------" -ForegroundColor Gray
} else {
    Write-Host "- Define the project layout and database structure."
    Write-Host "- Plan the communication protocol."
}
Write-Host ""
Write-Host "🚀 Happy coding! Run '.\start.ps1' anytime to re-run this check." -ForegroundColor Cyan
