### Create the variables
$OUName = "London"
$DomainDN = "DC=Adatum,DC=com"
$OUPath = "OU=$OUName,$DomainDN"
$GroupName = "London Users"
$GroupPath = "CN=$GroupName,$OUPath"

### Check if the group already exists
if (Get-ADGroup -filter {DistinguishedName -eq $GroupPath} -ErrorAction SilentlyContinue) {
    Write-Output "The group $GroupName already exists"
### If the group does not exist, create it    
} else {
    New-ADGroup -Name $GroupName -Path $OUPath -GroupScope Global -GroupCategory Security
    Write-Output "The group $GroupName has been created."
}

### Clean
Remove-ADGroup -Identity $GroupPath