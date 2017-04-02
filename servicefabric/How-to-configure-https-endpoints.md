# How to configure HTTPS endpoints in WebAPI services

There are three areas that need to be modified.

_(this assumes you use the standard service template code)_

## Service Manifest

Define the `Protocol` to be **https**. You also might want to change the port as well. I have set it to the security default of **443**.

```xml
  <Resources>
    <Endpoints>
      <Endpoint Protocol="https" Name="ServiceEndpoint" Type="Input" Port="443" />
    </Endpoints>
  </Resources>
</ServiceManifest>
```

## Application Manifest

In the ApplicationManifest xml, the certificate needs to be referenced in the `<Certificates>` section at the bottom.

**IMPORTANT NOTE:** 
When replacing the cert thumbnail for the `X509FindValue` take extra care when copying it from the MMC Certificates properties window. You will most likely include a hidden character at the start of the thumbnail.

Next ensure in the `<Policies>` section, you mention which certificate is linked to which service. 

Ensure the `EndPointRef` matches up with the Endpoint name in the ServiceManifest.xml

```xml
  <ServiceManifestImport>
    <ServiceManifestRef ServiceManifestName="TestServicePkg" ServiceManifestVersion="1.0.0" />
    <ConfigOverrides />
    <Policies>
      <EndpointBindingPolicy CertificateRef="TestServiceCert" EndpointRef="ServiceEndpoint"/>
    </Policies>
  </ServiceManifestImport>
  <DefaultServices>
    <Service Name="TestService">
      <StatelessService ServiceTypeName="TestServiceType" InstanceCount="[TestService_InstanceCount]">
        <SingletonPartition />
      </StatelessService>
    </Service>
  </DefaultServices>
  <Certificates>
    <EndpointCertificate Name="TestServiceCert" X509FindValue="FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF F0" X509StoreName="MY" />
  </Certificates>
</ApplicationManifest>
```

So far, this matches us with the instructions Microsoft have documented [here](https://docs.microsoft.com/en-us/azure/service-fabric/service-fabric-service-manifest-resources), but it seems one additional step is required.. 

## Update OwinCommunicationListener.cs

If you are using the WebAPI Service Template, a OwinCommunicationListener.cs file is generated. This is useful but it is hard coded to be http.

The `OpenAsync` method should be updated to the following:

```csharp
public Task<string> OpenAsync(CancellationToken cancellationToken)
{
    var serviceEndpoint = this.serviceContext.CodePackageActivationContext.GetEndpoint(this.endpointName);
    int port = serviceEndpoint.Port;
    var protocol = serviceEndpoint.Protocol; // <- UPDATED

    if (this.serviceContext is StatefulServiceContext)
    {
        StatefulServiceContext statefulServiceContext = this.serviceContext as StatefulServiceContext;
        
        this.listeningAddress = string.Format(
            CultureInfo.InvariantCulture,
            "{0}://+:{1}/{2}{3}/{4}/{5}", // <- UPDATED
            protocol,                     // <- UPDATED
            port,
            string.IsNullOrWhiteSpace(this.appRoot)
                ? string.Empty
                : this.appRoot.TrimEnd('/') + '/',
            statefulServiceContext.PartitionId,
            statefulServiceContext.ReplicaId,
            Guid.NewGuid());
    }
    else if (this.serviceContext is StatelessServiceContext)
    {
        
        this.listeningAddress = string.Format(
            CultureInfo.InvariantCulture,
            "{0}://+:{1}/{2}",      // <- UPDATED
            protocol,               // <- UPDATED
            port,
            string.IsNullOrWhiteSpace(this.appRoot)
                ? string.Empty
                : this.appRoot.TrimEnd('/') + '/');
    }
    else
    {
        throw new InvalidOperationException();
    }
```

Now when your service is deployed, the https endpoint _should_ work as expected.
