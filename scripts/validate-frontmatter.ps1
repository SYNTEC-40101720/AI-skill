$ErrorActionPreference = 'Stop'

function Get-Frontmatter {
    param(
        [Parameter(Mandatory = $true)]
        [string]$FilePath
    )

    $content = Get-Content -Path $FilePath -Raw
    if ($content -notmatch '(?s)^---\s*\r?\n(.*?)\r?\n---\s*') {
        return $null
    }

    $raw = $Matches[1]
    $map = @{}
    foreach ($line in ($raw -split "`r?`n")) {
        if ($line -match '^\s*([A-Za-z0-9_-]+)\s*:\s*(.*?)\s*$') {
            $key = $Matches[1].Trim()
            $value = $Matches[2].Trim().Trim('"').Trim("'")
            $map[$key] = $value
        }
    }
    return $map
}

$errors = New-Object System.Collections.Generic.List[string]
$warnings = New-Object System.Collections.Generic.List[string]

$skillFiles = Get-ChildItem -Path 'skills' -Filter 'SKILL.md' -Recurse -File -ErrorAction SilentlyContinue
if (-not $skillFiles -or $skillFiles.Count -eq 0) {
    $errors.Add('No skill files found under skills/**/SKILL.md') | Out-Null
}

foreach ($file in $skillFiles) {
    $frontmatter = Get-Frontmatter -FilePath $file.FullName
    $displayPath = $file.FullName.Replace((Get-Location).Path + '\\', '')

    if ($null -eq $frontmatter) {
        $errors.Add("[$displayPath] missing YAML frontmatter block") | Out-Null
        continue
    }

    foreach ($required in @('name', 'description')) {
        if (-not $frontmatter.ContainsKey($required) -or [string]::IsNullOrWhiteSpace($frontmatter[$required])) {
            $errors.Add("[$displayPath] missing required field: $required") | Out-Null
        }
    }

    if (-not $frontmatter.ContainsKey('argument-hint') -or [string]::IsNullOrWhiteSpace($frontmatter['argument-hint'])) {
        $warnings.Add("[$displayPath] missing recommended field: argument-hint") | Out-Null
    }
}

$promptFiles = Get-ChildItem -Path 'prompts' -Filter '*.prompt.md' -Recurse -File -ErrorAction SilentlyContinue
foreach ($file in $promptFiles) {
    $frontmatter = Get-Frontmatter -FilePath $file.FullName
    $displayPath = $file.FullName.Replace((Get-Location).Path + '\\', '')

    if ($null -eq $frontmatter) {
        $errors.Add("[$displayPath] missing YAML frontmatter block") | Out-Null
        continue
    }

    foreach ($required in @('name', 'description')) {
        if (-not $frontmatter.ContainsKey($required) -or [string]::IsNullOrWhiteSpace($frontmatter[$required])) {
            $errors.Add("[$displayPath] missing required field: $required") | Out-Null
        }
    }
}

if ($errors.Count -gt 0) {
    Write-Host "Frontmatter validation failed:" -ForegroundColor Red
    foreach ($err in $errors) {
        Write-Host " - $err" -ForegroundColor Red
    }
    exit 1
}

if ($warnings.Count -gt 0) {
    Write-Host "Frontmatter validation warnings:" -ForegroundColor Yellow
    foreach ($warn in $warnings) {
        Write-Host " - $warn" -ForegroundColor Yellow
    }
}

Write-Host 'Frontmatter validation passed for skills and prompts.' -ForegroundColor Green
