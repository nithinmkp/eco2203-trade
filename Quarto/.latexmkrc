# .latexmkrc — latexmk configuration for ECO 2203 beamer slides
# Bypass Quarto's hardcoded -halt-on-error by ignoring %O and
# hardcoding exactly the flags we need for xelatex.
my $xe = "\"C:\\Users\\Nithin M\\AppData\\Local\\Programs\\MiKTeX\\miktex\\bin\\x64\\xelatex.exe\"";
$pdf_mode = 5;  # 5 = xelatex → generates XDV then converts
$xelatex = "$xe -no-pdf -interaction=nonstopmode -disable-installer -recorder %S";
$out_dir = '';
$bibtex_use = 0;
$force_mode = 1;
