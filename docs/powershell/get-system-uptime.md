---
description: 'Get a system''s uptime in PowerShell from its last reboot time.'
---

# How to check the system up time

If you want to quickly and easily see how long a server has been running for since its last reboot then use this function:

!!! note "Important Note"
    This has been updated in March 2026 to use a more modern cmdlet. (**Get-WmiObject** is now obsolete)
   

```powershell
function Get-SystemUptime {
    $os = Get-CimInstance -ClassName Win32_OperatingSystem
    $uptime = (Get-Date) - $os.LastBootUpTime

    [pscustomobject]@{
        Days    = $uptime.Days
        Hours   = $uptime.Hours
        Minutes = $uptime.Minutes
    }
}
```
