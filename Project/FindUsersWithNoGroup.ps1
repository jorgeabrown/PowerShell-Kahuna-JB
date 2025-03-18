# This script will find users in a specific OU that are not a part of the OU's group, and add them to the group if they are not already a member.

### Set variables for the group, OU, domain, and users
$GroupName = "IT"
$OUName = "IT"
$DomainDN = "DC=Adatum,DC=com"
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