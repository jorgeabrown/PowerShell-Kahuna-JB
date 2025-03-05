$users = Get-ADuser -filter {City -eq "London"} -Properties city
$OUPath = "OU=$OUName,$DomainDN"
$GroupName = "London Users"

foreach ($user in $users) {
    Move-ADObject -Identity $user.DistinguishedName -TargetPath $OUPath
    Add-ADGroupMember -Identity $GroupName -Members $user
}