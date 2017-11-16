# Error logging in Octopus

## Issue
When you have scripted steps in Octopus, you can usually use `Write-Error` to sent out an error message and stop the deployment.
But it looks a bit ugly and you still have to dive in to the logs to find the real error message.

It is best to use the built n Octopus function `Fail-Step <string>`

If you use this in your script, if it is triggered it makes your logs look much more readable.

## Usage

in your script have something like:

``` powershell

if ($errorOccured)
{
    Fail-Step "There was error with the processing and the details are.... "
}
else
{
    Write-Host "All validation passed. Continuing the deployment.
}
```

## Reference

* [Octopus documentation about script error handling](https://octopus.com/docs/deploying-applications/custom-scripts#Customscripts-ErrorhandlinginPowerShellscripts)