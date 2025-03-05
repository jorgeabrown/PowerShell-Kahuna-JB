$GroupName = "Sales"
$OUName = "Sales"
$DomainDN = "DC=Adatum,DC=com"
$OUPath = "OU=$OUName,$DomainDN"

if (Get-ADuser -filter * -SearchBase $OUPath | ForEach-Object {Add-ADGroupMember -Identity $GroupName -Members $_.SamAccountName}) {
    Write-Host "All users in $OUName have been added to the $GroupName group."
} else {
    Write-Host "Failed to add users to the $GroupName group."
}