# How to determine server uptime

Ever wonder how long your windows server has been running for?

Here's some PowerShell to help work that out:

```powershell
$wmi = Get-WMIObject -Class Win32_OperatingSystem
$sysuptime = (Get-Date) - $wmi.ConvertToDateTime($wmi.LastBootUpTime)
Write-Host "$($env:COMPUTERNAME) has been running for : $($sysuptime.days) Days, $($sysuptime.hours) Hours, $($sysuptime.minutes) Minutes, $($sysuptime.seconds) Seconds"
```
