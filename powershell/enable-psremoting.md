# How to enable PS Remoting

It can be useful to have this enabled so you can remotely query server settings across the network.

To enable PowerShell Remoting enter in:

``` powershell
Enable-PSRemoting -Force
```

ONce done command like `Invoke-Command -Computer <serverName> ` will work.
This works from PS 2.0 and higher.