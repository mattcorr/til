# How to enable PS Remoting

It can be useful to have this enabled so you can remotely query server settings across the network.

To enable PowerShell Remoting enter in:

```text
Enable-PSRemoting -Force
```

Once done command like `Invoke-Command -Computer <serverName>` will work. This works from PowerShell 2.0 and higher.

