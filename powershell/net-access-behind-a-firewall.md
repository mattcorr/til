# How to query the Internet behind a NTLM Proxy on a corporate network

Sometimes at client sites, we need to use PowerShell scripts to invoke REST APIs through a Proxy. If the Proxy required NTLM authentication it can be an utter pain to get this to work correctly.

`Invoke-RestMethod` has the `-Proxy` and `ProxtCredentials` parameters, but you should use this instead:

```powershell
$proxyUri = [System.Uri]"http://10.xx.xx.xxx:8080"
$proxy = New-Object System.Net.WebProxy($proxyUri)
$proxy.Credentials = New-Object System.Net.NetworkCredential("accountname", "password")

[System.Net.WebRequest]::DefaultWebProxy = $proxy
[System.Net.WebRequest]::DefaultWebProxy.BypassProxyOnLocal = $true

$result = Invoke-RestMethod  -Uri $urlToCall -ContentType "application/json" -Headers $header
```

This should give you the results you need!