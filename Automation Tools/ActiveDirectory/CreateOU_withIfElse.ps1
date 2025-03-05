### Create the variables
$OUName = "London"
$DomainDN = "DC=Adatum,DC=com"
$OUPath = "OU=$OUName,$DomainDN"

### Check if the OU already exists
if (Get-ADOrganizationalUnit -Filter {DistinguishedName -eq $OUPath} -SearchBase $DomainDN  -ErrorAction SilentlyContinue) {
    Write-Output "The OU $OUName already exists"
} else { 
### Create the OU
New-ADOrganizationalUnit -Name $OUName -Path $DomainDN
Write-Output "The OU $OUName has been created."
}

### Clean
Remove-ADOrganizationalUnit -Identity $OUPath