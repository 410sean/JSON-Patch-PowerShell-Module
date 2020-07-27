[Reflection.Assembly]::LoadFile("$PSScriptRoot/lib/Microsoft.AspNetCore.JsonPatch.dll")
[Reflection.Assembly]::LoadFile("$PSScriptRoot\lib\Newtonsoft.Json.dll")
Get-ChildItem "$PSScriptRoot/scripts/*.ps1" | ForEach-Object { . $_ }