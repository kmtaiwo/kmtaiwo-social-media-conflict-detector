<#
  Copies this package (kmtaiwo-social-media-conflict-detector) into your local clone of
  https://github.com/kmtaiwo/kmtaiwo-social-media-conflict-detector

  Does NOT delete or modify the Social-Sphere-Project monorepo source.

  Usage:
    cd ...\kola-taiwo\kmtaiwo-social-media-conflict-detector\scripts
    .\sync-to-github-clone.ps1
    .\sync-to-github-clone.ps1 -CloneDir "D:\repos\kmtaiwo-social-media-conflict-detector"
#>
param(
    [string]$CloneDir = (Join-Path $env:USERPROFILE "Documents\projects\kmtaiwo-social-media-conflict-detector")
)

$ErrorActionPreference = "Stop"
$PackageRoot = Split-Path -Parent $PSScriptRoot

Write-Host "Package (source): $PackageRoot"
Write-Host "GitHub clone:     $CloneDir"

if (-not (Test-Path $CloneDir)) {
    Write-Host "Creating clone directory..."
    New-Item -ItemType Directory -Path $CloneDir -Force | Out-Null
}

# robocopy: copy package into clone (exclude junk; preserve clone's .git via /XD only on source - source has no .git)
& robocopy.exe $PackageRoot $CloneDir /E /XD ".venv" "venv" "__pycache__" ".ipynb_checkpoints" /NFL /NDL /NJH /NJS | Out-Null
$rc = $LASTEXITCODE
# robocopy: 0-7 = success with various copy counts
if ($rc -ge 8) {
    Write-Host "robocopy failed with code $rc" -ForegroundColor Red
    exit 1
}

Write-Host "Done. In the clone: git add -A && git commit && git push" -ForegroundColor Green
