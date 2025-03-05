### Create variables for users, OU, and Group
$users = Get-ADuser -filter {City -eq "London"} -Properties city
$OUPath = "OU=$OUName,$DomainDN"
$GroupName = "London Users"

### Loop through all users and move them to the OU and add them to the group
foreach ($user in $users) {
    Move-ADObject -Identity $user.DistinguishedName -TargetPath $OUPath
    Add-ADGroupMember -Identity $GroupName -Members $user
}