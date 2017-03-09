# How to run powershell in 32 bit mode within 64 bit

Sometimes there are cases when you need to run some powershell code in 32 but mode rather than the default of 64 bit.
This is a way to do that within a single script with some parameters:

```powershell
    param (
        [string] $value1,
        [int] $value2
    )

$32bitPowerShellCode = {
    param (
        [string] $value1,
        [int] $value2
    )
  Write-Host "Some 32 bit processing with $value1 and $value2"
}


Invoke-Command -ScriptBlock $32bitPowerShellCode -ArgumentList @($value1, $value2) -ConfigurationName microsoft.powershell32 -ComputerName $env:COMPUTERNAME 
```
