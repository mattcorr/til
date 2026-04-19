---
description: 'Replace a Service Fabric reverse proxy SSL certificate safely.'
---

# How to upgrade a Reverse Proxy SSL certificate in your SF Cluster

First you need to get the new certificate and add it to the Certificate store via the MMC.exe snap in.

**VERY IMPORTANT**: Once added, ensure you add permissions to the private key for the following:

* local NETWORK SERVICE account
* any Active directory user accounts or groups that your Service Fabric service will run as

## Get the cluster to pick up the certificate

The less drastic option is to push a Service Fabric configuration upgrade rather than rebooting the whole server.

For a standalone cluster, update the reverse proxy certificate entry in `ClusterConfig.json`. If you are using thumbprints, update the `ReverseProxyCertificate` thumbprint. If possible, prefer `ReverseProxyCertificateCommonNames` for future renewals so you are not tied to a single thumbprint.

After updating the cluster config, test it against the current config:

```powershell
.\TestConfiguration.ps1 `
    -ClusterConfigFilePath .\ClusterConfig.New.json `
    -OldClusterConfigFilePath .\ClusterConfig.Current.json
```

Then start a monitored cluster configuration upgrade:

```powershell
Connect-ServiceFabricCluster
Start-ServiceFabricClusterConfigurationUpgrade -ClusterConfigPath .\ClusterConfig.New.json
Get-ServiceFabricClusterUpgrade
```

This applies the change upgrade-domain by upgrade-domain instead of rebooting everything at once.

If the cluster config already points to the correct certificate and you only need the local node process to reload it, restart the Service Fabric node process one node at a time:

```powershell
Connect-ServiceFabricCluster
Restart-ServiceFabricNode -NodeName "Node01" -CommandCompletionMode Verify
```

Wait for the node and cluster health to return to OK before restarting the next node.


!!! warning
    However, if this is not an option we know rebooting the server will work, but it could be considered overkill.
