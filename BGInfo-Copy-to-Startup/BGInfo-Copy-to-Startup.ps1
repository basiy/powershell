<#
.SYNOPSIS
    Script for create link for BGInfo and copy it to Startup folder for current user

#>

$SourceAppWorkDir  = "c:\BGInfo"
$SourceApp         = "c:\BGInfo\bginfo.exe"
$SourceAppArg      = "c:\BGInfo\bginfo.bgi /timer:00"


$SourceItem = "c:\BGInfo\Bginfo.lnk"
$UserStartup = $env:APPDATA+"\Microsoft\Windows\Start Menu\Programs\Startup"

# Create link for file bginfo.exe with arguments
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$SourceItem")
$Shortcut.TargetPath = $SourceApp
$Shortcut.Arguments = $SourceAppArg
$Shortcut.WorkingDirectory = $SourceAppWorkDir
$Shortcut.Save()

# Copy link to Startup folder for current user
Copy-Item -Path $SourceItem -Destination $UserStartup -Recurse
