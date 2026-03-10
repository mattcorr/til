Write-Host "Starting..."

$docsPath = Join-Path (Get-Location) "docs"
$files = Get-ChildItem -Path $docsPath -Recurse -File -Filter "*.md" | Where-Object {
    $_.DirectoryName -notlike "*assets*" -and
    $_.Name -ne "index.md" -and
    $_.Name -ne "Summary.md"
}
$directories = $files.Directory | Select-Object -ExpandProperty Name | Sort-Object -Unique

$summaryText = "# Summary`n`n"
foreach ($directory in $directories)
{
    Write-Host "Processing folder : $directory" -ForegroundColor Cyan
    $summaryText += "* $directory`n"

    $dirFiles = $files | Where-Object { $_.Directory.Name -eq $directory }
    foreach ($file in $dirFiles)
    {
        $title = Get-Content -Path $file.FullName | Select-String '^# ' | Select-Object -First 1
        $relativePath = $file.FullName.Replace($docsPath, ".").Replace("\", "/")
        $summaryText += "`t* [$($title -replace '^# ', '')]($relativePath)`n"
    }
}

$summaryText += "`n---`n"
$summaryPath = Join-Path $docsPath "Summary.md"
$summaryText | Out-File -FilePath $summaryPath -Encoding utf8
Write-Host "Summary.md updated!" -ForegroundColor Green
