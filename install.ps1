param(
    [switch]$Global = $false
)

$ErrorActionPreference = "Continue"

Write-Output "== Installing Harness Factory Multi-Runtime (Windows) =="

$repoRoot = (Get-Location).Path
Write-Output "Repo Root: $repoRoot"

if ([string]::IsNullOrEmpty($PSScriptRoot)) {
    $PSScriptRoot = $repoRoot
}
$srcPath = Join-Path $PSScriptRoot "skills/myharness"
Write-Output "Source Path: $srcPath"

# --- 1. Antigravity Global Customizations ---
$globalParentDir = "C:\Users\lucks\.gemini\config"
$globalConfigDir = Join-Path $globalParentDir "skills"
$globalDest = Join-Path $globalConfigDir "myharness"

if ($Global) {
    Write-Output "Global installation requested."
    if (Test-Path $globalParentDir) {
        if (-not (Test-Path $globalConfigDir)) {
            New-Item -ItemType Directory -Path $globalConfigDir -Force | Out-Null
            Write-Output "Antigravity Global: Created skills directory under $globalParentDir"
        }
    }
}

if ($Global -and (Test-Path $globalConfigDir)) {
    if (Test-Path $globalDest) {
        $item = Get-Item $globalDest
        if ($item.Attributes -match "ReparsePoint") {
            Remove-Item $globalDest -Force
        } else {
            $gitHash = git rev-parse --short HEAD 2>$null
            if (-not $gitHash) { $gitHash = "old" }
            $backupPath = "$globalDest.bak.$gitHash"
            Rename-Item -Path $globalDest -NewName $backupPath -ErrorAction SilentlyContinue
            Write-Output "Antigravity Global: Backed up old version to $backupPath"
        }
    }
    
    # Try Junction first (does not require Administrator privileges)
    try {
        New-Item -ItemType Junction -Path $globalDest -Value $srcPath -Force | Out-Null
        Write-Output "Antigravity Global: Linked $globalDest -> $srcPath (Junction)"
    } catch {
        # Fallback to copy
        try {
            Copy-Item -Path $srcPath -Destination $globalDest -Recurse -Force
            Write-Output "Antigravity Global: Copied to $globalDest (Fallback)"
        } catch {
            Write-Warning "Antigravity Global: Installation failed. Proceeding with local install."
        }
    }
} else {
    Write-Output "Antigravity Global: Skipping global installation (Local-only mode)"
}

# --- 2. Local Project Customizations (.agents/skills) ---
$localConfigDir = Join-Path $repoRoot ".agents/skills"
$localDest = Join-Path $localConfigDir "myharness"

Write-Output "Local Dest: $localDest"

if (-not (Test-Path $localConfigDir)) {
    Write-Output "Creating local config directory..."
    New-Item -ItemType Directory -Path $localConfigDir -Force | Out-Null
}

if (Test-Path $localDest) {
    Write-Output "Removing existing local dest..."
    if (Test-Path $localDest -PathType Container) {
        cmd /c rmdir /s /q "$localDest" 2>$null
    } else {
        Remove-Item $localDest -Force -ErrorAction SilentlyContinue
    }
}

Write-Output "Copying source to local dest..."
try {
    Copy-Item -Path $srcPath -Destination $localDest -Recurse -Force
    Write-Output "Local Customization: Copied to $localDest successfully."
} catch {
    Write-Warning "Local Customization: Copy failed. Trying Junction..."
    try {
        New-Item -ItemType Junction -Path $localDest -Value $srcPath -Force | Out-Null
        Write-Output "Local Customization: Linked $localDest -> $srcPath (Junction)"
    } catch {
        Write-Error "Local Customization: All installation attempts failed."
    }
}

# --- 3. Update Antigravity skills.json (Optional Manual Registration) ---
# Standard root (.agents/skills) 아래의 스킬은 자동 발견되므로 필수가 아니지만,
# 명시적 등록을 위해 .agents/skills.json 파일이 존재할 경우 항목을 추가합니다.
$skillsJsonFile = Join-Path $repoRoot ".agents/skills.json"
if (Test-Path $skillsJsonFile) {
    try {
        $jsonObj = Get-Content -Raw -Path $skillsJsonFile | ConvertFrom-Json
        if ($null -eq $jsonObj.entries) {
            $jsonObj.entries = @()
        }
        $hasEntry = $false
        foreach ($entry in $jsonObj.entries) {
            if ($entry.path -eq "skills/myharness") {
                $hasEntry = $true
                break
            }
        }
        if (-not $hasEntry) {
            $entriesList = [System.Collections.Generic.List[PSObject]]($jsonObj.entries)
            $newEntry = [PSCustomObject]@{
                path = "skills/myharness"
            }
            $entriesList.Add($newEntry)
            $jsonObj.entries = $entriesList.ToArray()
            $jsonObj | ConvertTo-Json -Depth 10 | Out-File -FilePath $skillsJsonFile -Encoding utf8
            Write-Output "Antigravity Manifest: Registered myharness in $skillsJsonFile"
        } else {
            Write-Output "Antigravity Manifest: myharness already registered in $skillsJsonFile"
        }
    } catch {
        Write-Warning "Manifest: Failed to update $skillsJsonFile"
    }
}

# --- 4. Append pointers to .agents/AGENTS.md ---
$agentsRulesFile = Join-Path $repoRoot ".agents/AGENTS.md"

# Construct Korean trigger word "하네스" (Harness) safely using char codes to avoid encoding bugs
$krHarness = "$([char]0xD558)$([char]0xB124)$([char]0xC2A4)"

$pointerText = @(
    "",
    "## Harness: myharness (Antigravity & Windows)",
    "- **Trigger**: 'build a harness', 'harness configuration', 'audit the harness', 'update the harness' or Korean '$krHarness'",
    "- **Action**: Meta-skill to build agent teams and skills. Uses PowerShell (.ps1) tools on Windows.",
    "- **Details**: Refer to `my_harness/skills/myharness/SKILL.md` and follow Phase 0 to 7."
) -join "`r`n"

if (Test-Path $agentsRulesFile) {
    $rulesContent = Get-Content $agentsRulesFile -Raw
    if ($rulesContent -notmatch "myharness") {
        Add-Content -Path $agentsRulesFile -Value $pointerText -Encoding utf8
        Write-Output "Local AGENTS.md: Added myharness pointer rules"
    } else {
        Write-Output "Local AGENTS.md: myharness pointer rules already exist"
    }
} else {
    $headerText = "# AGENTS.md - Antigravity & Codex Project Rules" + $pointerText
    $headerText | Out-File -FilePath $agentsRulesFile -Encoding utf8
    Write-Output "Local AGENTS.md: Created file and added pointer rules"
}

# --- 5. Run review tools check ---
Write-Output "`n-- Checking review tools --"
$checkScript = Join-Path $srcPath "scripts/check-review-tools.ps1"
if (Test-Path $checkScript) {
    & $checkScript
}

Write-Output "`nInstallation Complete."
Write-Output "- Local: .agents/skills/myharness"
Write-Output "- Global: $globalDest"
exit 0
