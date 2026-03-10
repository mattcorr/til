# How to upgrade a Reverse Proxy SSL certificate in your SF Cluster

First you need to get the new certificate and add it to the Certificate store via the MMC.exe snap in.

**VERY IMPORTANT**: Once added, ensure you add permissions to the private key for the following:

* local NETWORK SERVICE account
* any Active directory user accounts or groups that your Service Fabric service will run as

Once this i

TODO : need to see what commands or actions need to happen after we install the certificate to get the cluster to pick up the new cert.

_We know rebooting the server will work, but does seem a bit drastic._

