
# How to uninstall a BizTalk application

It can be handy as part of a BizTalk application deployment to remove an old or newer version there.
This assumes you use the [BTDF](https://biztalkdeployment.codeplex.com/) for deploying an application.

When you use BTDF, it installs the windows menu, a selectable option to un-deploy the application. 

The script below simulates stopping the BizTalk application and then un-deploying the application from the server.

**Note:** Need to run all these in 32 bit PowerShell. _Why??_ This is due to BizTalk PowerShell requiring 32 bit to access its features correctly.

Because of this requirement, we need to wrap the script in a code block. More info about how to do that [here](./running-32bit-within-64bit.html).

The following assumptions are made in the script below:

* There is a fixed installation path.
* BizTalk 2016 is being used.
* BizTalk is installed on either C or D drive.


```powershell
param (
    [string] $ApplicationName,
    [string] $BiztalkSQlServer = ".",
    [string] $DeployDb,
    [string] $msBuildPath
)

$powershell32bitCode = {
param (
    [string] $ApplicationName,
    [string] $BiztalkSQlServer = ".",
    [string] $DeployDb,
    [string] $msBuildPath
)

# ---------------------------------------------------------------------------------------------------------------------------------------------

Write-Host "Loading BizTalk PowerShell..."
if ((Get-Module -Name "BizTalkFactory.PowerShell.Extensions") -eq $null) 
{
    Write-Host "Initialising BizTalkFactory.PowerShell.Extensions..." 
    $InitializeDefaultBTSDrive = $false
    # check the two locations that BizTalk 2016 could be installed
    if (Test-Path "D:\Program Files (x86)\Microsoft BizTalk Server 2016\SDK\Utilities\PowerShell\BizTalkFactory.PowerShell.Extensions.dll" -PathType Leaf)
    {
        $BizTalkPSDll = "D:\Program Files (x86)\Microsoft BizTalk Server 2016\SDK\Utilities\PowerShell\BizTalkFactory.PowerShell.Extensions.dll"
    }
    else
    {
        $BizTalkPSDll = "C:\Program Files (x86)\Microsoft BizTalk Server 2016\SDK\Utilities\PowerShell\BizTalkFactory.PowerShell.Extensions.dll"
    }
    Import-Module $BizTalkPSDll -DisableNameChecking
    }

# Ensure no drive exists already
If (Test-Path BizTalk:)
{
	Remove-PSDrive -Name "BizTalk"
}

# create the PS-Drive
$output = New-PSDrive -Name "BizTalk" -PSProvider BizTalk -Root "BizTalk:\" -Instance $BiztalkSQlServer -Database BizTalkMgmtDb -Scope Global

if ($output -eq $null)
{
    Write-Error "Unable to create the PS Drive to query the Biztalk environment. Check permissions and networks to ensure you have access from this PC to $BiztalkSQlServer ." -ErrorAction Stop
    return
}

Write-Host "Searching for BizTalk application $ApplicationName..."
$app = Get-ChildItem -Path 'BizTalk:\Applications' | Where-Object Name -eq $ApplicationName
# Stop the application
if ($app -eq $null) 
{
    Write-Error "Unable to find a BizTalk applications with name '$ApplicationName'. Check the configuration and try again." -ErrorAction Stop
}
if ($app.Status -ne "Stopped")
{
    Write-Host "Stopping $ApplicationName app..."
    $app | Stop-Application -StopOption StopAll 
}
else
{
    Write-Host "BizTalk application $ApplicationName is already stopped."
}

# uninstall the application
$appInstallPath =  "C:\Program Files (x86)\$ApplicationName for BizTalk\1.0"

if ((Test-Path $appInstallPath -PathType Container) -eq $false)
{
    Write-Error "Unable to find folder $appInstallPath to uninstall the application." -ErrorAction Stop
}

$projFile = Join-Path -Path $appInstallPath  -ChildPath "\Deployment\Deployment.btdfproj"
$undeployArgs = @("`"$projFile`"", "/p:DeployBizTalkMgmtDB=$DeployDb;Configuration=Server;InstallDir=`"$appInstallPath`"", "/target:Undeploy")

Write-Host "For un-deployment running: $msBuildPath $undeployArgs" -f 
& $msBuildPath $undeployArgs

Write-Host " All done"
}

# The only actual line in the script. It will run all the code above in a PowerShell 32 bit session. This is required for the Biztalk PowerShell.
Invoke-Command -ScriptBlock $powershell32bitCode -ArgumentList @($ApplicationName, $BiztalkSQlServer, $DeployDb, $msBuildPath) -ConfigurationName microsoft.powershell32 -ComputerName $env:COMPUTERNAME
```

