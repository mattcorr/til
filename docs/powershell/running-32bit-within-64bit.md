# How to run powershell in 32 bit mode within 64 bit

Sometimes there are cases when you need to run some powershell code in 32 bit mode rather than the default of 64 bit. _\(this is usually for some imported DLLs that wont quite work in 64 bit like_ [_BizTalk Powershell_](https://psbiztalk.codeplex.com/)_\)_

This is a way to do that within a single script with some parameters:

```text
param (
    [string] $value1,
    [int] $value2
)

$32bitPSCode = {
    param (
        [string] $value1,
        [int] $value2
    )
  Write-Host "Some 32 bit processing with $value1 and $value2"
}

Invoke-Command -ScriptBlock $32bitPSCode -ArgumentList @($value1, $value2) -ConfigurationName microsoft.powershell32 -ComputerName $env:COMPUTERNAME
```

