$ErrorActionPreference = 'Stop'

if (-not (Test-Path .\process\tools\build_core_markdown.py)) {
    throw "Shared tools are missing from process/. See Build in README.md."
}

$python = Get-Command python -ErrorAction Stop

& $python.Source .\process\tools\build_core_markdown.py --assembly ImmunizationCDS.qmd --check
if ($LASTEXITCODE -ne 0) {
    throw "Generated core Markdown is out of date."
}

& $python.Source .\process\tools\check_content.py --include "LICENSE-CONTENT.md" --include "CODE_OF_CONDUCT.md"
if ($LASTEXITCODE -ne 0) {
    throw "Content checks failed."
}

Write-Host "Repository validation passed."
