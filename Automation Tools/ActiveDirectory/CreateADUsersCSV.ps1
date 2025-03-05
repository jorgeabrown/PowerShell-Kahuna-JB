### Import CSV file into the $users variable
$users = Import-CSV -Path C:\Users\User\users.csv

### Loop through each user in the $users variable
foreach ($user in $users) {
    $path = "OU=" + $u.Department + ",DC=Domain,DC=com"
    $upn = $user.UserID + "@domain.com:"
    $display = $user.First + " " + $user.Last
    Write-Host "Creating $display in $path"
    New-ADUser -GivenName $user.First -Surname $user.Last -Name $display -DisplayName $display -SamAccountName $user.UserID -UserprincipalName $UPN -Path $path -Department $u.Department
                          }