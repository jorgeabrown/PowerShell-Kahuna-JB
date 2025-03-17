### Import CSV file into the $users variable
$users = Import-CSV -Path "C:\users.csv"

### Loop through each user in the $users variable
foreach ($user in $users) {

try {
    $path = "OU=" + $user.Department + ",DC=Adatum,DC=com"
    $upn = $user.First + "@adatum.com"
    $display = $user.First + " " + $user.Last
    New-ADUser -Name $display -SamAccountName $user.First -UserPrincipalName $upn -GivenName $user.First -Surname $user.Last -DisplayName $display -Path $path -AccountPassword (ConvertTo-SecureString "P@ssw0rd" -AsPlainText -Force) -Enabled $true
            Write-Host "User $display created successfully" -ForegroundColor Green
} catch {
            Write-Host "Failed to create user $display" -ForegroundColor Red
            Write-Host $_.Exception.Message
        }
                         }               