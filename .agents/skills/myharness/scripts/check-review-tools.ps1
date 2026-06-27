# Windows PowerShell version of check-review-tools.sh
# Usage: .\check-review-tools.ps1 [runner]

$ErrorActionPreference = "SilentlyContinue"

$avail = @()
$tools = @("codex", "claude", "agy", "gemini")

foreach ($t in $tools) {
    if ($t -eq "gemini" -and $avail -contains "agy") {
        # Skip gemini since agy is already detected (agy preferred)
        continue
    }
    $path = Get-Command $t -ErrorAction SilentlyContinue
    if ($null -ne $path) {
        Write-Output "$($t): `[OK] Registered ($($path.Source))"
        $avail += $t
    } else {
        Write-Output "$($t): `[NO] Not Installed"
    }
}

# Resolve Runner: Arguments > Env:REVIEW_RUNNER > Autodetect
$runner = ""
if ($args.Count -gt 0) {
    $runner = $args[0]
} elseif ($null -ne $env:REVIEW_RUNNER) {
    $runner = $env:REVIEW_RUNNER
}

# Validate Runner
if ($runner -ne "" -and $runner -ne "claude" -and $runner -ne "codex" -and $runner -ne "agy") {
    Write-Output "note: runner='$runner' not allowed (claude|codex|agy only) -> fallback to autodetect."
    $runner = ""
}

if ($runner -eq "") {
    $hasClaude = $false
    $hasCodex = $false
    $hasAgy = $false
    
    if ($null -ne $env:CLAUDECODE -or $null -ne $env:CLAUDE_CODE) { $hasClaude = $true }
    if ($null -ne $env:CODEX_SANDBOX -or $null -ne $env:CODEX_HOME -or $null -ne $env:CODEX_THREAD_ID) { $hasCodex = $true }
    if ($null -ne $env:ANTIGRAVITY_IDE -or $null -ne $env:AGY_WORKSPACE) { $hasAgy = $true }
    
    if ($hasAgy) {
        $runner = "agy"
    } elseif ($hasClaude -and $hasCodex) {
        $runner = "claude"
        Write-Output "note: ambiguous runtime -> assume claude. Specify runner explicitly if needed."
    } elseif ($hasClaude) {
        $runner = "claude"
    } elseif ($hasCodex) {
        $runner = "codex"
    } else {
        $runner = "agy" # 기본적으로 Antigravity IDE에서 돌리므로 agy를 기본값으로 지정
        Write-Output "note: autodetect failed -> assume agy."
    }
}

# agy vs gemini coexistence
if ($avail -contains "agy" -and $avail -contains "gemini") {
    Write-Output "note: agy and gemini coexist -> prefer agy (gemini is legacy)"
}

# Determine Reviewers (exclude runner)
$reviewers = @()
foreach ($t in $avail) {
    if ($t -eq $runner) { continue }
    $reviewers += $t
}

# filter gemini if agy is present in reviewers
if ($reviewers -contains "agy" -and $reviewers -contains "gemini") {
    $filtered = @()
    foreach ($r in $reviewers) {
        if ($r -ne "gemini") { $filtered += $r }
    }
    $reviewers = $filtered
}

# Print status lines at the end (mandatory output)
if ($avail.Count -eq 0) {
    Write-Output "AVAILABLE: none"
} else {
    Write-Output "AVAILABLE: $($avail -join ' ')"
}

Write-Output "RUNNER: $runner"

if ($reviewers.Count -eq 0) {
    Write-Output "REVIEWERS: none"
} else {
    Write-Output "REVIEWERS: $($reviewers -join ' ')"
}

exit 0
