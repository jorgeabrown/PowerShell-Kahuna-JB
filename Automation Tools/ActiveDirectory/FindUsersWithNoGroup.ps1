$GroupName = "Sales"
$OUName = "Sales"
$DomainDN = "DC=Adatum,DC=com"
$OUPath = "OU=$OUName,$DomainDN"
$users = Get-ADUser -Filter * -SearchBase $OUPath

foreach ($user in $users) {
    $isMember = Get-ADGroupMember -Identity $GroupName -Recursive | Where-Object { $_.distinguishedName -eq $user.distinguishedName }

    if (-not $isMember) {
        Add-ADGroupMember -Identity $GroupName -Members $user
        Write-Host "Added $($user.SamAccountName) to $GroupName"
    } else {
        Write-Host "$($user.SamAccountName) is already a member of $GroupName"
    }
    }