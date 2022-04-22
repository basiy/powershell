$SourceItem = "c:\BGInfo\Bginfo.lnk"
$UserStartup = $env:APPDATA+"\Microsoft\Windows\Start Menu\Programs\Startup"

Copy-Item -Path $SourceItem -Destination $UserStartup -Recurse
