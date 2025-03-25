#Script to find Active Directory users that are disabled and have not logged on in the last Six Months and save to a CSV file
#Author: Lucas Kowe
$Users = Get-ADUser -Filter * -Properties LastLogonDate,Enabled | Where-Object { $_.Enabled -eq $false -and $_.LastLogonDate -lt (Get-Date).AddMonths(-6) }
$Users | Select-Object Name,LastLogonDate,Enabled | Export-Csv -Path C:\Temp\DisabledUsers.csv -NoTypeInformation
