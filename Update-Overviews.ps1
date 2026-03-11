<#
.SYNOPSIS
Updates the category overview README files for the MkDocs site.

.DESCRIPTION
Scans the markdown files under the docs directory, reads each page title and
description front matter, and regenerates the README.md file in each category
folder with a list of linked articles and their descriptions.

.NOTES
Run this script from the repository root so the docs path resolves correctly.
#>

Write-Host "Starting overview update..."

function Get-MarkdownDocumentData {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    $raw = Get-Content -Path $Path -Raw
    $description = $null
    $title = $null

    if ($raw -match "(?s)\A---\r?\n(.*?)\r?\n---\r?\n") {
        $frontMatter = $matches[1]
        if ($frontMatter -match "(?m)^description:\s*['""]?(.*?)['""]?\s*$") {
            $description = $matches[1].Trim() -replace "''", "'"
        }
    }

    if ($raw -match "(?m)^#\s+(.+?)\s*$") {
        $title = $matches[1].Trim()
    }

    [PSCustomObject]@{
        Description = $description
        Title = $title
    }
}

function ConvertTo-YamlSingleQuoted {
    param(
        [Parameter(Mandatory = $true)]
        [AllowEmptyString()]
        [string]$Value
    )

    return "'" + ($Value -replace "'", "''") + "'"
}

$docsPath = Join-Path (Get-Location) "docs"
$categoryDirectories = Get-ChildItem -Path $docsPath -Directory | Sort-Object Name

foreach ($categoryDirectory in $categoryDirectories) {
    $readmePath = Join-Path $categoryDirectory.FullName "README.md"
    if (-not (Test-Path $readmePath)) {
        continue
    }

    $categoryData = Get-MarkdownDocumentData -Path $readmePath
    $categoryTitle = if ($categoryData.Title) { $categoryData.Title } else { $categoryDirectory.Name }
    $categoryDescription = if ($categoryData.Description) {
        $categoryData.Description
    }
    else {
        "$categoryTitle notes."
    }

    Write-Host "Processing category: $categoryTitle" -ForegroundColor Cyan

    $articleFiles = Get-ChildItem -Path $categoryDirectory.FullName -File -Filter "*.md" |
        Where-Object { $_.Name -ne "README.md" } |
        Sort-Object Name

    $output = [System.Collections.Generic.List[string]]::new()
    $output.Add("---")
    $output.Add("description: $(ConvertTo-YamlSingleQuoted -Value $categoryDescription)")
    $output.Add("---")
    $output.Add("")
    $output.Add("# $categoryTitle")
    $output.Add("")

    foreach ($articleFile in $articleFiles) {
        $articleData = Get-MarkdownDocumentData -Path $articleFile.FullName
        $articleTitle = if ($articleData.Title) { $articleData.Title } else { [System.IO.Path]::GetFileNameWithoutExtension($articleFile.Name) }
        $articleDescription = if ($articleData.Description) { $articleData.Description } else { "No description available." }
        $articleDescription = $articleDescription -replace "''", "'"
        $output.Add("- [$articleTitle]($($articleFile.Name)): $articleDescription")
    }

    $content = ($output -join [Environment]::NewLine) + [Environment]::NewLine
    Set-Content -Path $readmePath -Value $content -Encoding utf8
}

Write-Host "README.md overview pages updated!" -ForegroundColor Green
