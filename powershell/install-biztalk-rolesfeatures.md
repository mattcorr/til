# How to install BizTalk roles and features via PowerShell

When-ever you look at installation documentation for BizTalk servers, the first step is usually a list of roles and features you need to install. For each client however, this list might be a little different based on their needs and requirements.

PowerShell makes this easy to automate by the `Install-WindowsFeature` command

**NOTE:** First, ensure your servers are running at least [PowerShell 5.0](https://www.microsoft.com/en-us/download/details.aspx?id=54616).

Running the `Get-WindowsFeature` command will show all the roles and features that are available to install. Select the ones that applicable for your BizTalk server setup. Now you can create a script to automate this installation.

This sample script below used for installing BizTalk Roles and Features also takes into account if the Windows Server source folder is not in the default location. This can sometimes be the case on locked down corporate networks.

```text
param (
  [string] $sourceFolder = ""
)

Write-Host "Installing the Roles and Features required for a BizTalk Server" -f Cyan
if ($sourceFolder -ne "")
{
    if ((Test-Path -Path $sourceFolder) -eq $false)
    {
    Write-Error "Unable to find folder $sourceFolder. Please check and try again" -ErrorAction Stop
    }
    else
    {
    Write-Host "Confirmed that $sourceFolder is a valid folder." -f Green
    }
}

if ($sourceFolder -eq "")
{
    Install-WindowsFeature -Name 'Web-Server' -IncludeManagementTools
    Install-WindowsFeature -Name 'Web-Http-Redirect'
    Install-WindowsFeature -Name 'Web-Log-Libraries', 'Web-Request-Monitor', 'Web-Http-Tracing'
    Install-WindowsFeature -Name 'Web-Dyn-Compression', 'Web-Basic-Auth', 'Web-Client-Auth', 'Web-Digest-Auth', 'Web-Cert-Auth', 'Web-IP-Security', 'Web-Url-Auth', 'Web-Windows-Auth'
    Install-WindowsFeature -Name 'Web-App-Dev', 'Web-Mgmt-Compat', 'NET-Framework-Features' -IncludeAllSubFeature
    Install-WindowsFeature -Name 'Web-Scripting-Tools', 'NET-WCF-HTTP-Activation45', 'NET-WCF-Pipe-Activation45', 'NET-WCF-TCP-Activation45'
}
else
{
    Install-WindowsFeature -Name 'Web-Server' -IncludeManagementTools -Source $sourceFolder
    Install-WindowsFeature -Name 'Web-Http-Redirect' -Source $sourceFolder
    Install-WindowsFeature -Name 'Web-Log-Libraries', 'Web-Request-Monitor', 'Web-Http-Tracing' -Source $sourceFolder
    Install-WindowsFeature -Name 'Web-Dyn-Compression', 'Web-Basic-Auth', 'Web-Client-Auth', 'Web-Digest-Auth', 'Web-Cert-Auth', 'Web-IP-Security', 'Web-Url-Auth', 'Web-Windows-Auth' -Source $sourceFolder
    Install-WindowsFeature -Name 'Web-App-Dev', 'Web-Mgmt-Compat', 'NET-Framework-Features' -IncludeAllSubFeature -Source $sourceFolder
    Install-WindowsFeature -Name 'Web-Scripting-Tools', 'NET-WCF-HTTP-Activation45', 'NET-WCF-Pipe-Activation45', 'NET-WCF-TCP-Activation45' -Source $sourceFolder
}
Write-Host 'All done.' -f Cyan
```

If there are any suggestions on how to improve this, let me know.

