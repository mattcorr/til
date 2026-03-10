# Configure settings to auto format PowerShell code

After watching an [interesting video](https://www.youtube.com/watch?v=LJNdK0QrIo8) from [Trevor Sullivan](https://trevorsullivan.net/) about how to configure [Visual Studio Code](https://code.visualstudio.com/) for PowerShell development, I found the following settings great for my personal preferences.

NOTE: Others might not prefer this type of style, but it works well for me.

```javascript
{
    "editor.minimap.enabled": true,
    "workbench.iconTheme": "vscode-icons",

    "powershell.scriptAnalysis.enable": true,
    "terminal.integrated.shell.osx": "/usr/local/bin/powershell",
    "powershell.integratedConsole.focusConsoleOnExecute": false,
    "powershell.codeFormatting.newLineAfterOpenBrace": false,
    "powershell.codeFormatting.whitespaceBeforeOpenParen": true,
    "powershell.codeFormatting.ignoreOneLineBlock": true,
    "powershell.codeFormatting.newLineAfterCloseBrace": true,
    "powershell.codeFormatting.alignPropertyValuePairs": true,
    "powershell.codeFormatting.whitespaceAfterSeparator": true,
    "powershell.codeFormatting.whitespaceAroundOperator": true,
    "powershell.codeFormatting.openBraceOnSameLine": false,
    "editor.formatOnSave": true,
    "editor.formatOnType": true
}
```

As you type and when you save PowerShell files, they are auto formatted. Also the Script Analyst is enabled.

Pretty cool! :\)

