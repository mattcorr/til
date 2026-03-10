# How to remove special chars in JSON file format

Sometimes you want to write out an object in JSON format to a file. This is fine and what you would normally use [ConvertTo-Json](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/convertto-json?view=powershell-7) for.

The only issue is the generated JSON will convert some chars like `<` to `\u003c` which is not ideal for your JSON output. This seems to be a limitation with the PowerShell command.

To fix this, use this Regex snippet below to replace the escaped tokens in your output to make the file more readable.

```text
  $data | ConvertTo-Json -Depth 10 | ForEach-Object { [Regex]::Replace($_, "\\u(?<Value>[a-zA-Z0-9]{4})", { param($m) ([char]([int]::Parse($m.Groups['Value'].Value, [System.Globalization.NumberStyles]::HexNumber))).ToString() } )} | Out-File $OutputFilename -Force
```

This will turn your output from:

```javascript
"Key":  "WLSProtocol",
    "Values":  {
                    "Test":  "\u003chttpsTransport  maxReceivedMessageSize=\"1255360\"/\u003e",
                    "Staging":  "\u003chttpsTransport  maxReceivedMessageSize=\"1255360\"/\u003e",
                    "Production":  "\u003chttpsTransport  maxReceivedMessageSize=\"1255360\"/\u003e"
                }
```

to

```javascript
    "Key": "WLSProtocol",
    "Values": {
        "Test": "<httpsTransport  maxReceivedMessageSize=\"1255360\"/>",
        "Staging": "<httpsTransport  maxReceivedMessageSize=\"1255360\"/>",
        "Production": "<httpsTransport  maxReceivedMessageSize=\"1255360\"/>",
    }
```

**Note:** you still will need to escape some chars like `"` and `\` but these are more managable.

* [Reference Source](https://stackoverflow.com/questions/47779157/convertto-json-and-convertfrom-jason-with-special-characters/47779605#47779605)

