### Set variables for the group, OU, domain, and users
$GroupName = "IT Admins"
$OUName = "Users,OU=IT"
$DomainDN = "DC=homelab,DC=com"
$OUPath = "OU=$OUName,$DomainDN"
$users = Get-ADUser -Filter * -SearchBase $OUPath

### Loop through users and add them to the group if they are not already a member
foreach ($user in $users) {
    $isMember = Get-ADGroupMember -Identity $GroupName -Recursive | Where-Object { $_.distinguishedName -eq $user.distinguishedName }

    if (-not $isMember) {
        Add-ADGroupMember -Identity $GroupName -Members $user
        Write-Host "Added $($user.Name) to $GroupName"
    } else {
        Write-Host "$($user.Name) is already a member of $GroupName"
    }
    }