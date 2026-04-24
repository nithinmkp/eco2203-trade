# render-all.ps1
# Builds ECO 2203 course: HTML/RevealJS via Quarto, Beamer PDFs via latexmk directly.
# Run from: D:\Teaching\international trade\Quarto\

$quartoDir = "D:\Teaching\international trade\Quarto"
$docsDir   = "D:\Teaching\international trade\docs"
Set-Location $quartoDir

Write-Host "=== Step 1: Render HTML/RevealJS for all lectures ===" -ForegroundColor Cyan
quarto render --to html 2>&1 | Where-Object { $_ -match "Rendering|Output|ERROR|WARN" }

Write-Host "`n=== Step 2: Generate Beamer .tex files ===" -ForegroundColor Cyan
$lectures = Get-ChildItem "Lecture*.qmd" | Sort-Object Name
foreach ($qmd in $lectures) {
    Write-Host "  tex: $($qmd.Name)" -NoNewline
    quarto render $qmd.Name --to beamer -M keep-tex:true 2>&1 | Out-Null
    $tex = $qmd.BaseName + ".tex"
    if (Test-Path $tex) { Write-Host " ✓" } else { Write-Host " ✗ (tex not generated)" -ForegroundColor Red }
}

Write-Host "`n=== Step 3: Compile .tex → PDF via latexmk ===" -ForegroundColor Cyan
foreach ($qmd in $lectures) {
    $base = $qmd.BaseName
    $tex  = "$base.tex"
    $pdf  = "$base.pdf"

    if (-not (Test-Path $tex)) {
        Write-Host "  SKIP $base (no .tex)" -ForegroundColor Yellow
        continue
    }

    Write-Host "  pdf: $base" -NoNewline
    # Delete fdb cache so latexmk does not skip due to stale "up-to-date" status
    Remove-Item "$base.fdb_latexmk","$base.xdv","$base.pdf" -ErrorAction SilentlyContinue

    & latexmk -g $tex 2>&1 | Out-Null
    # Second pass for cross-references
    & latexmk -g $tex 2>&1 | Out-Null

    if (Test-Path $pdf) {
        $kb = [int]((Get-Item $pdf).Length / 1KB)
        Copy-Item $pdf "$docsDir\$pdf" -Force
        Write-Host " ✓ ($kb KB → docs/)" -ForegroundColor Green
    } else {
        Write-Host " ✗ (PDF not generated)" -ForegroundColor Red
    }
}

Write-Host "`n=== Step 4: Rebuild website index ===" -ForegroundColor Cyan
quarto render index.qmd 2>&1 | Where-Object { $_ -match "Output|ERROR" }

Write-Host "`nDone! Check docs/ for all HTML and PDF files." -ForegroundColor Green
