### 
$salesusers = Get-ADUser -Filter * -SearchBase "OU=Sales,DC=Adatum,DC=Com" | Select-Object samAccountName

foreach ($user in $salesusers) {
    Set-ADUser -Identity $user.samAccountName -AccountExpirationDate (Get-Date).AddDays(14) -PasswordNeverExpires $false -Verbose
}

###
$today = Get-Date
$expirationDate = $today.AddDays(14)
$expiringUsers = Get-ADUser -filter {AccountExpirationDate -le $expirationDate} -Properties AccountExpirationDate | Select-Object Name, UserprincipalName, AccountExpirationDate