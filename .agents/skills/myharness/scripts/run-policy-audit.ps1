$ErrorActionPreference = "SilentlyContinue"

# Find root of repo
$gitRoot = git rev-parse --show-toplevel 2>$null
if (-not $gitRoot) { $gitRoot = "." }
$gitRoot = Resolve-Path $gitRoot

$SK = Join-Path $gitRoot "skills/myharness"
$fail = 0
$warn = 0

function ok($msg) {
    Write-Host "[OK] $msg" -ForegroundColor Green
}

function no($msg) {
    $global:fail++
    Write-Host "[FAIL] $msg" -ForegroundColor Red
}

function wn($msg) {
    $global:warn++
    Write-Host "[WARN] $msg" -ForegroundColor Yellow
}

Write-Host "== myharness Policy Integration Audit =="

# 1) SKILL.md <= 500 lines
$skillFile = Join-Path $SK "SKILL.md"
if (Test-Path $skillFile) {
    $lines = (Get-Content $skillFile).Count
    if ($lines -le 500) {
        ok "SKILL.md is ${lines} lines (<=500)"
    } else {
        no "SKILL.md is ${lines} lines > 500 (Lean violation - split details to references)"
    }
} else {
    no "SKILL.md file not found."
}

# 2) frontmatter name+description
if (Test-Path $skillFile) {
    $content = Get-Content $skillFile -Raw
    $hasName = $content -match "(?m)^name:"
    $hasDesc = $content -match "(?m)^description:"
    if ($hasName -and $hasDesc) {
        ok "frontmatter name and description exist"
    } else {
        no "SKILL.md frontmatter name or description missing"
    }
}

# 3) Link integrity
if (Test-Path $skillFile) {
    $content = Get-Content $skillFile -Raw
    $matches = [regex]::Matches($content, 'references/[a-z-]+\.md')
    $miss = 0
    $checked = @{}
    foreach ($m in $matches) {
        $rel = $m.Value
        if ($checked.ContainsKey($rel)) { continue }
        $checked[$rel] = $true
        
        $p = Join-Path $SK $rel
        if (-not (Test-Path $p)) {
            no "dead link: SKILL.md -> $rel (file not found)"
            $miss++
        }
    }
    if ($miss -eq 0) {
        ok "references links are integrated (dead 0)"
    }
}

# 4) Commands folder checking
$claudeCmdFolder = Join-Path $gitRoot ".claude/commands"
if ((Test-Path $claudeCmdFolder) -and (Get-ChildItem $claudeCmdFolder)) {
    no ".claude/commands/ is not empty (Harnesses should not generate commands)"
} else {
    ok ".claude/commands is empty/not created"
}

# 5) Stale identifiers
$prodFiles = @(
    "README.md",
    "README_KO.md",
    "README_JA.md",
    ".claude-plugin/plugin.json",
    ".claude-plugin/marketplace.json",
    "AGENTS.md",
    "install.sh"
)

$hasRevfactory = $false
foreach ($f in $prodFiles) {
    $fp = Join-Path $gitRoot $f
    if (Test-Path $fp) {
        $fc = Get-Content $fp -Raw
        if ($fc -match "revfactory") {
            $hasRevfactory = $true
            break
        }
    }
}
if ($hasRevfactory) {
    wn "revfactory reference exists (ignore if sibling repo is intended)"
} else {
    ok "revfactory reference 0 in product files"
}

# Scan SKILL.md for '[[dev-rules]]' or '[[tdd-doctrine]]'
if (Test-Path $skillFile) {
    $fc = Get-Content $skillFile -Raw
    if ($fc -match '\[\[(dev-rules|tdd-doctrine)\]\]') {
        no "[[ ]] injection markers remaining (subagents cannot resolve this - change to actual path)"
    } else {
        ok "[[ ]] injection markers 0"
    }
}

# Scan for 'skills/harness' (old path)
$hasOldPath = $false
$scanFiles = Get-ChildItem -Path $SK -Recurse -Filter *.md | Select-Object -ExpandProperty FullName
$scanFiles += @(Join-Path $gitRoot "README.md", Join-Path $gitRoot "README_KO.md", Join-Path $gitRoot "README_JA.md")
foreach ($f in $scanFiles) {
    if (Test-Path $f) {
        $fc = Get-Content $f -Raw
        if ($fc -match 'skills/harness\b') {
            $hasOldPath = $true
            break
        }
    }
}
if ($hasOldPath) {
    no "stale 'skills/harness' path exists (should be skills/myharness)"
} else {
    ok "stale 'skills/harness' path 0"
}

# 6) Version parity
$pv = $null
$mv = $null
$bv = $null
$cv = $null

$pluginJson = Join-Path $gitRoot ".claude-plugin/plugin.json"
if (Test-Path $pluginJson) {
    $pJson = Get-Content $pluginJson -Raw | ConvertFrom-Json
    $pv = $pJson.version
}

$marketJson = Join-Path $gitRoot ".claude-plugin/marketplace.json"
if (Test-Path $marketJson) {
    $mJson = Get-Content $marketJson -Raw | ConvertFrom-Json
    $mv = $mJson.plugins[0].version
}

$readmePath = Join-Path $gitRoot "README.md"
if (Test-Path $readmePath) {
    $readmeContent = Get-Content $readmePath -Raw
    if ($readmeContent -match 'Version-([0-9]+\.[0-9]+\.[0-9]+)') {
        $bv = $Matches[1]
    }
}

$changelogPath = Join-Path $gitRoot "CHANGELOG.md"
if (Test-Path $changelogPath) {
    $changelogContent = Get-Content $changelogPath -Raw
    if ($changelogContent -match '## \[([0-9]+\.[0-9]+\.[0-9]+)\]') {
        $cv = $Matches[1]
    }
}

if ($pv -eq $mv -and $pv -eq $bv -and $pv -eq $cv -and $pv -ne $null) {
    ok "Version parity $pv (plugin=marketplace=badge=CHANGELOG)"
} else {
    no "Version mismatch - plugin:$pv marketplace:$mv badge:$bv CHANGELOG:$cv"
}

# 7) Dual/multi runtime parity
$agentsMd = Join-Path $gitRoot "AGENTS.md"
if (Test-Path $agentsMd) {
    ok "AGENTS.md exists (Codex entry point)"
} else {
    wn "AGENTS.md missing (needed for dual-runtime)"
}

$agentsSkillsMyharness = Join-Path $gitRoot ".agents/skills/myharness"
if (Test-Path $agentsSkillsMyharness) {
    ok ".agents/skills/myharness exists (Codex skill path)"
} else {
    wn ".agents/skills/myharness missing (install script not run?)"
}

# 8) JSON Validity
$jsonFiles = @(
    ".claude-plugin/plugin.json",
    ".claude-plugin/marketplace.json"
)
foreach ($jf in $jsonFiles) {
    $jfp = Join-Path $gitRoot $jf
    if (Test-Path $jfp) {
        try {
            $null = Get-Content -Raw -Path $jfp | ConvertFrom-Json
            ok "JSON valid: $jf"
        } catch {
            no "JSON invalid: $jf"
        }
    }
}

# 9) Scripts syntax checks
$isWin = $env:OS -match 'Windows_NT'
$hasBash = $null
if (-not $isWin) {
    $hasBash = Get-Command bash -ErrorAction SilentlyContinue
}

$shScripts = Get-ChildItem (Join-Path $SK "scripts") -Filter *.sh
foreach ($s in $shScripts) {
    if ($hasBash) {
        $res = & bash -n $s.FullName 2>$null
        if ($LASTEXITCODE -eq 0) {
            ok "bash -n: $($s.Name)"
        } else {
            no "Script syntax error: $($s.Name)"
        }
    }
}

$psScripts = Get-ChildItem (Join-Path $SK "scripts") -Filter *.ps1
foreach ($s in $psScripts) {
    $scriptContent = Get-Content $s.FullName -Raw
    $errors = $null
    $tokens = [System.Management.Automation.Language.Parser]::ParseInput($scriptContent, [ref]$null, [ref]$errors)
    if ($errors.Count -eq 0) {
        ok "powershell syntax: $($s.Name)"
    } else {
        no "PowerShell script syntax error: $($s.Name)"
        foreach ($e in $errors) {
            Write-Host "  -> Line $($e.Extent.StartLineNumber): $($e.Message)" -ForegroundColor Yellow
        }
    }
}

Write-Host "=== POLICY AUDIT: $(if ($fail -eq 0) { 'PASS' } else { 'FAIL' }) (fail $fail, warn $warn) ==="
if ($fail -eq 0) { exit 0 } else { exit 1 }
