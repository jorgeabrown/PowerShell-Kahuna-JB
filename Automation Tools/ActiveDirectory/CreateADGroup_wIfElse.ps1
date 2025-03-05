### Create the variables
$OUName = "London"
$DomainDN = "DC=Adatum,DC=com"
$OUPath = "OU=$OUName,$DomainDN"
$ADGroup = "London Users"
$GroupPath = "CN=$ADGroup,$OUPath"

### Check if the group already exists
if (Get-ADGroup -filter {DistinguishedName -eq $GroupPath} -SearchBase $OUPath -ErrorAction SilentlyContinue) {
    Write-Output "The group $ADGroup already exists"
### If the group does not exist, create it    
} else {
    New-ADGroup -Name $ADGroup -Path $OUPath -GroupScope Global -GroupCategory Security
    Write-Output "The group $ADGroup has been created."
}

### Clean
Remove-ADGroup -Identity $GroupPath