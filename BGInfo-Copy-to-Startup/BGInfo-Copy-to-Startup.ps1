<#
.SYNOPSIS
    Script for create link for BGInfo and copy it to Startup folder for current user

.DESCRIPTION
    Copy BGInfo.exe and BGInfo.bgi to folder c:\BGInfo and then start this Script
    After that, BGInfo will be launched automatically after the user logs into the system

.NOTES
    Version:        1.1
    Author:         Yaroslav Basiy
    Github:         yaroslavbasiy

.LINK
    https://docs.microsoft.com/en-us/sysinternals/downloads/bginfo

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
