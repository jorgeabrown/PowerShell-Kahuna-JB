$groupmembershipdata = Get-ADGroupMember -Identity "$group.samaccountname" | ForEach-Object {
 Get-ADGroupMember -Identity "Enterprise Admins"

 $groupmembershipdata | Select-Object * | Out-GridView
 $group | Select-Object * | Out-GridView

 $admingroups = Get-ADGroup -Filter {name -like "*Admin*"} | Select-object samaccountname, distinguishedname | Out-GridView

 $admingroups = Get-ADGroup -Filter {name -like "*Admin*"} | Select-object * | Out-GridView

 $groupmembershipdata = Get-ADGroupMember -Identity "$group.samaccountname"

  $groupmembershipdata = Get-ADGroupMember -Identity ($group.samaccountname) | Select-Object * | Out-GridView

  $group

  Get-ADGroupMember -Identity Administrators | Select-Object * | Out-GridView