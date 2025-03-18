# This script will find user accounts that will expire within 14 days and export the results to a CSV file. It will also provide an email template for notifying the users.

### Set users with an expiration date of 14 days from today so you can test the script and see the results.
$salesusers = Get-ADUser -Filter * -SearchBase "OU=Sales,DC=Adatum,DC=Com" | Select-Object samAccountName

foreach ($user in $salesusers) {
    Set-ADUser -Identity $user.samAccountName -AccountExpirationDate (Get-Date).AddDays(14) -PasswordNeverExpires $false -Verbose
}

### Set variables for the current date, expiration date, and the users that are expiring within 14 days.
$today = Get-Date
$expirationDate = $today.AddDays(14)
$expiringUsers = Get-ADUser -filter {AccountExpirationDate -le $expirationDate -and AccountExpirationDate -gt $today} -Properties AccountExpirationDate | Select-Object Name, UserprincipalName, AccountExpirationDate

### Check if there are any expiring users and export the results to a CSV file. It will show a count of the expiring users and provide an email template.
if ($expiringUsers.count -gt 0) {
    Write-Host "There were $($expiringUsers.count) expiring users found. You can find the list in the ExpiringUsers.csv file." -ForegroundColor Red
    $expiringUsers | Export-Csv -Path "C:\Reports\ExpiringUsers.csv" -NoTypeInformation
    Write-Host "Results exported to C:\Reports" -ForegroundColor Magenta
    Write-Host "Here is an email template: ALCON, if you are on the TO line, your account is set to expire within 14 days. Please complete your cyber training
    and contact your supervisor for further guidance." -ForegroundColor Yellow
} else {
    Write-Host "No expiring users found." -ForegroundColor Green
}