### Set $age variable to -90 days
$age = (Get-Date).AddDays(-90)

### Get all users that have not logged in for 90 days
Get-ADUser -Filter {LastLogonTimeStamp -lt $age -and enabled -eq $true} -Properties LastLogonTimeStamp