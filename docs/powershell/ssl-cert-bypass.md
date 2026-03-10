# Set Powershell to skip SSL certificate checks

## NOTE: This is NOT a recommended practice! You should have valid certificates and CA Servers!

If you are trying to query a web site and you have invalid SSL certificates, Powershell is by default very strict on what it accepts. You will often end up with errors like:

```text
Invoke-WebRequest : The underlying connection was closed: Could not establish trust relationship for the SSL/TLS secure channel.
```

or

```text
Invoke-WebRequest : The request was aborted: Could not create SSL/TLS secure channel.
```

When you try to use `Invoke-WebRequest` or `Invoke-RestMethod` on a web URL with old or insecure certificates or CAs. Example:

```text
PS C:\Users\CorrM1> Invoke-WebRequest -Uri https://badwebsite.with.crap.certs:1943/application/service
```

To get around this, try running the script fragment below before you make your remote calls.

This performs bypasses for the certificate issues.

```text
add-type @"
    using System.Net;
    using System.Security.Cryptography.X509Certificates;
    public class TrustAllCertsPolicy : ICertificatePolicy {
        public bool CheckValidationResult(
            ServicePoint srvPoint, X509Certificate certificate,
            WebRequest request, int certificateProblem) {
            return true;
        }
    }
"@
[System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
```

