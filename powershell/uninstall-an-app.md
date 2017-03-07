
# How to uninstall an application in PowerShell

Need to do the following:
Stop the application
Remove the application
Uninstall the application (from add remove programs)


Note. need to run all these in 32 bt PowerShell.

## Stop the Application
The best way to do this is to use the BizTalk PowerShell module.

```powershell
```

## Remove the application
The same as above.
```powershell
```

## Remove the application

```powershell
Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\* | Where-Object DisplayName -like 'NPBS.*' | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate, UninstallString | Format-Table –AutoSize
```

DON'T use the **Win32_Product** WMI object. It takes way too long. Plus read [here for more info](https://blogs.technet.microsoft.com/heyscriptingguy/2013/11/15/use-powershell-to-find-installed-software/).


