# How to check the system up time

If you want to quickly and easily see how long a server has been running for since its last reboot then use this function:

```powershell
function Get-SystemUptime 
{
   $os = Get-WmiObject win32_operatingsystem
   $uptime = (Get-Date) - ($os.ConvertToDateTime($os.lastbootuptime))
   Write-Output "Uptime: $($Uptime.Days) days, $($Uptime.Hours) hours, $($Uptime.Minutes) minutes"
}
```

