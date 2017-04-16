# How to use a Select-Object to create your custom object array for you

Often when I am creating custom data, I usually:

1. run a query to get the data I want
2. iterate through that returned list and create new objects 
3. add these objects to a separate array holder
4. return that.

You can merge this with something like:

```powershell
 $drives = [System.IO.DriveInfo]::GetDrives() |
    Where-Object {$_.TotalSize} |
    Select-Object   @{Name='Name';     Expr={$_.Name}},
                    @{Name='Label';    Expr={$_.VolumeLabel}},
                    @{Name='Size(GB)'; Expr={[int32]($_.TotalSize / 1GB)}},
                    @{Name='Free(GB)'; Expr={[int32]($_.AvailableFreeSpace / 1GB)}},
                    @{Name='Free(%)';  Expr={[math]::Round($_.AvailableFreeSpace / $_.TotalSize,2)*100}},
                    @{Name='Format';   Expr={$_.DriveFormat}},
                    @{Name='Type';     Expr={[string]$_.DriveType}},
                    @{Name='Computer'; Expr={$ComputerName}}

$drives | ConvertTo-Json -Compress
```

Saves time and makes the code faster and more readable!

Credit for the above code is [here](https://xainey.github.io/2017/powershell-electron-demo/).