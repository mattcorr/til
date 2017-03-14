# How to query Service Fabric via PowerShell

Install the latest version of the **Microsoft Service Fabric SDK and Tools** on your local dev VM via the [Web Platform Tools](https://www.microsoft.com/web/downloads/platform.aspx).

This will include the ServiceFabric PowerShell module.

There is [detailed help](https://docs.microsoft.com/en-us/powershell/servicefabric/vlatest/servicefabric) about the module's commandlets available. 

In a nutshell you connect to the Service Fabric and then can run commands against it. Nice and easy :)

```powershell
Connect-ServiceFabricCluster -ConnectionEndpoint "localhost:19000"

Get-ServiceFabricNode | Format-Table -Property NodeName, NodeStatus, HealthState, NodeUpTime, CodeVersion
```

will return something like:

```
NodeName NodeStatus HealthState NodeUpTime CodeVersion 
-------- ---------- ----------- ---------- ----------- 
_Node_4          Up          Ok 00:53:55   5.4.164.9494
_Node_3          Up          Ok 00:53:55   5.4.164.9494
_Node_2          Up          Ok 00:53:55   5.4.164.9494
_Node_1          Up          Ok 00:53:55   5.4.164.9494
_Node_0          Up          Ok 00:53:55   5.4.164.9494
```

