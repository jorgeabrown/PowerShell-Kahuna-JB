$admingroups = (Get-ADGroup -Filter {name -like "*Admin*"}).samaccountname
$groupmembershipdata =$null
[PSCustomObject]@{}

foreach ($group in $admingroups) {
  #$groupmembershipdata = Get-ADGroupMember -Identity $group.samaccountname | ForEach-Object {
   $groupmembershipdata = Get-ADGroupMember -Identity ($group)
       
       $GMember
       [PSCustomObject]@{
           GroupName = $groupmembershipdata.name
           #Membername = $groupmembershipdata.Name
           Membername = ($groupmembershipdata.name)
           DistinguishedName = ($groupmembershipdata.DistinguishedName)
           #DistinguishedName = ($GMName.DistinguishedName)
           ObjectType = ($groupmembershipdata.Objectclass)
               }
        foreach($GMember in $groupmembershipdata) {


      $groupmembershipdata | Export-Csv -Path \\LON-DC1\WorkFiles\Reports\GroupMembership.csv -NoTypeInformation
       
   }
}
