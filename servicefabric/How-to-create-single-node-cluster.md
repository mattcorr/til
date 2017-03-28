# How to create a single node cluster (offline)

To create a single node Service Fabric cluster you would follow [this page](https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-cluster-creation-for-windows-server) from the Service Fabric documentation.

This would generally be fine, but it does assume your server will be connected to the Internet.

If your server is hidden behind a corporate firewall and not able to access the internet, it is important to follow the instructions in the link above in section **"Download the Service Fabric standalone package"** and to set the property **enableTelemetry** to `false`.

_This is documented, but it is easy to miss!_

The location in the cluster jcon config is in the `Properties` section. I would put under the `reliabilityLevel` so it is clearly visible.

```json
"properties": {
    "reliabilityLevel": "Bronze",
    "enableTelemetry": false,
    "diagnosticsStore": 
    {
        "metadata":  "Please replace the diagnostics file share with an actual file share accessible from all cluster machines.",
        "dataDeletionAgeInDays": "7",
        "storeType": "FileShare",
        "IsEncrypted": "false",
        "connectionstring": "c:\\ProgramData\\SF\\DiagnosticsStore"
    },
    "nodeTypes": [
        {
        "name": "NodeType0",
        "clientConnectionEndpointPort": "19000",
        "clusterConnectionEndpointPort": "19001",
        "leaseDriverEndpointPort": "19002",
        "serviceConnectionEndpointPort": "19003",
```

Always run the `TestConfiguration.ps1` script before you create the cluster. This should be run on the server you are planning to create the cluster on.

Expected output should be something like:

```
PS C:\temp\Service-Fabric-Installs\SF-Install-5.5.216.0> .\TestConfiguration.ps1 -ClusterConfigFilePath .\ClusterConfig.Demo.json -FabricRuntimePackagePath ..\MicrosoftAzureServiceFabric.5.5.216.0.cab
Trace folder already exists. Traces will be written to existing trace folder: C:\temp\Service-Fabric-Installs\SF-Install-5.5.216.0\DeploymentTraces
Running Best Practices Analyzer...
Best Practices Analyzer completed successfully.


LocalAdminPrivilege        : True
IsJsonValid                : True
IsCabValid                 : True
RequiredPortsOpen          : True
RemoteRegistryAvailable    : True
FirewallAvailable          : True
RpcCheckPassed             : True
NoConflictingInstallations : True
FabricInstallable          : True
DataDrivesAvailable        : True
Passed                     : True
```

