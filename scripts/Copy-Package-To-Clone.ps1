<#
.SYNOPSIS
  Copies this standalone package into your local GitHub clone, then runs git add (optional commit/push).

.PARAMETER CloneDir
  Absolute path to the folder that is a git clone of kmtaiwo-social-media-conflict-detector (contains .git).

.PARAMETER CommitAndPush
  If set, runs git commit and git push after git add.

.EXAMPLE
  .\Copy-Package-To-Clone.ps1 -CloneDir "C:\Users\kola_\Documents\projects\Social-Sphere-Project\kmtaiwo-social-media-conflict-detector"
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$CloneDir,
    [switch]$CommitAndPush
)

$ErrorActionPreference = "Stop"
$PackageRoot = Split-Path -Parent $PSScriptRoot

if (-not (Test-Path (Join-Path $CloneDir ".git"))) {
    Write-Error "Not a git repo: $CloneDir (missing .git)"
}

Write-Host "From: $PackageRoot"
Write-Host "To:   $CloneDir"
& robocopy.exe $PackageRoot $CloneDir /E /XD ".venv" "venv" "__pycache__" ".ipynb_checkpoints" /NFL /NDL /NJH /NJS | Out-Null
$rc = $LASTEXITCODE
if ($rc -ge 8) { Write-Error "robocopy failed with code $rc" }

Set-Location $CloneDir
git add -A
git status

if ($CommitAndPush) {
    git commit -m "Sync standalone conflict-detector package from monorepo"
    git push -u origin main
  Write-Host "Done. Check https://github.com/kmtaiwo/kmtaiwo-social-media-conflict-detector" -ForegroundColor Green
} else {
  Write-Host "Next: git commit -m `"your message`" ; git push -u origin main" -ForegroundColor Cyan
}
