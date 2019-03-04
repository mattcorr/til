Write-Host "Starting..." 
$files = Get-ChildItem -Path . -Recurse -File | Where-Object {$_.DirectoryName -notlike  "*images*" -and
                                                              $_.DirectoryName -notlike "*til"}
$directories = $files.Directory | Select-Object -ExpandProperty name | Sort-Object  -Unique

$summaryText = "# Summary`n`n"
$currentPath = Get-Location | Select-Object -ExpandProperty Path
foreach ($directory in $directories)
{
    Write-Host "Processing folder : $directory" -f Cyan
    $summaryText += "* $directory`n"
    $dirFiles = $files | Where-Object DirectoryName -like "*/$directory"
    foreach ($file in $dirFiles)
    {
        $title = Get-Content -Path $file.FullName | Select-String '# *'| Select-Object -first 1
        $summaryText += "`t* [$($title -replace '# ', '')]($($file.FullName -replace $currentPath,'.'))`n"
    }
}
$summaryText += "`n---`n"
$summaryText | Out-File -FilePath './Summary.md' -Encoding utf8
Write-Host "Summary.md updated!" -f Green 
