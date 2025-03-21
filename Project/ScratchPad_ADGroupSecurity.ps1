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



#Scenario 1
$admingroups = (Get-ADGroup -Filter {name -like "*Admin*"}).samaccountname

foreach ($group in $admingroups) {
    $groupmembershipdata = Get-ADGroupMember -Identity ($group)
        foreach ($GMName in $groupmembershipdata){ 
            #$GMName.DistinguishedName
            $GroupName = $group
            $Membername = $GMName.name
            $DistinguishedName = $GMName.DistinguishedName
            $ObjectType = $GMName.Objectclass
    
       }
        $GMExpInfo = $GroupName,$Membername,$DistinguishedName,$ObjectType
        $GMExpInfo
        pause
       #$GMExpInfo | Export-Csv -Path \\LON-DC1\WorkFiles\Reports\GroupMembership.csv -NoTypeInformation -Append

        
    }

 #Scenario 2
 
 $admingroups = (Get-ADGroup -Filter {name -like "*Admin*"}).samaccountname
 $groupmembershipdata =$null

foreach ($group in $admingroups) {
   #$groupmembershipdata = Get-ADGroupMember -Identity $group.samaccountname | ForEach-Object {
    $groupmembershipdata = Get-ADGroupMember -Identity ($group)
        foreach($GMember in $groupmembershipdata) { 
        $GMember
        [PSCustomObject]@{
            GroupName = $groupmembershipdata.name
            #Membername = $groupmembershipdata.Name
            Membername = ($groupmembershipdata.name)
            DistinguishedName = ($groupmembershipdata.DistinguishedName)
            #DistinguishedName = ($GMName.DistinguishedName)
            ObjectType = ($groupmembershipdata.Objectclass)
                }

        Pause
        #$groupmembershipdata | Export-Csv -Path \\LON-DC1\WorkFiles\Reports\GroupMembership.csv -NoTypeInformation
        
    }
}

