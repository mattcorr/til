# Check .NET Framework versions installed

If you want to quickly check what version of .NET is installed on a server, use the PowerShell below:

```powershell
Write-Output $(Get-ChildItem 'HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP' -recurse |
Get-ItemProperty -name Version -ErrorAction 0 |  Where-Object { $_.PSChildName -like "v*" -or $_.PsChildname -eq "Full"} |
Select PSChildName, Version | Sort-Object -Property Version -Descending)
```

**HINT:** You can also put this script as a remote script block if you want to query the .NET versions installed across many servers.