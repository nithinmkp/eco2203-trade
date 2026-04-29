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

    if (Test-Path $tex) {
        function Fix-CaptionLabels([string]$s) {
            $needle = "\caption{"  # literal \caption{
            $i = 0
            $sb = New-Object System.Text.StringBuilder

            while ($true) {
                $pos = $s.IndexOf($needle, $i)
                if ($pos -lt 0) {
                    [void]$sb.Append($s.Substring($i))
                    break
                }

                [void]$sb.Append($s.Substring($i, $pos - $i))

                $j = $pos + $needle.Length
                while ($j -lt $s.Length -and [char]::IsWhiteSpace($s[$j])) { $j++ }

                if ($j + 7 -le $s.Length -and $s.Substring($j, 7) -eq "\label{") {
                    $k = $j + 7
                    $endLabel = $s.IndexOf('}', $k)
                    if ($endLabel -lt 0) {
                        [void]$sb.Append($needle)
                        $i = $pos + $needle.Length
                        continue
                    }

                    $label = $s.Substring($k, $endLabel - $k)
                    $captionStart = $endLabel + 1

                    $t = $captionStart
                    $depth = 1
                    while ($t -lt $s.Length) {
                        $ch = $s[$t]
                        if ($ch -eq '{') { $depth++ }
                        elseif ($ch -eq '}') {
                            $depth--
                            if ($depth -eq 0) { break }
                        }
                        $t++
                    }

                    if ($depth -ne 0) {
                        [void]$sb.Append($needle)
                        $i = $pos + $needle.Length
                        continue
                    }

                    $captionText = $s.Substring($captionStart, $t - $captionStart)
                    [void]$sb.Append("\caption{" + $captionText + "}`r`n\label{" + $label + "}")
                    $i = $t + 1
                } else {
                    [void]$sb.Append($needle)
                    $i = $pos + $needle.Length
                }
            }

            return $sb.ToString()
        }

        $raw = Get-Content $tex -Raw
        $patched = Fix-CaptionLabels $raw
        if ($patched -ne $raw) {
            Set-Content -Path $tex -Value $patched -NoNewline
        }

        Write-Host " ✓"
    } else {
        Write-Host " ✗ (tex not generated)" -ForegroundColor Red
    }
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
