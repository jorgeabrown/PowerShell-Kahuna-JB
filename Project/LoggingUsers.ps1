### List the computers you want to run this script on
$computerList = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name

### Specify location of where you want the logs to go to
$baseSharedrive = "\\LON-DC1\Logs"

### Script to run on each computer
$scriptBlock = {

### Filter for logon and logoff events in the last 12 hours
    $filter = @{
        Logname = "Security"
        ID      = 4624, 4634
        StartTime = (Get-Date).AddHours(-12)
    }
    Get-WinEvent -FilterHashtable $filter | ForEach-Object {
        [PSCustomObject]@{
            ComputerName = $env:COMPUTERNAME
            UserName     = ($_ | Select-Object -ExpandProperty Properties)[5].Value
            EventID      = $_.ID
            TimeCreated  = $_.TimeCreated
            EventType    = if ($_.ID -eq 4624) { "Logon" } else { "Logoff" }
        }
    }
}

### Loop through each computer and create a folder for the logs
foreach ($computer in $computerList) {
    $computerfolderpath = Join-Path -Path $baseSharedrive -ChildPath $computer
    $TestPath = Test-Path -Path $computerfolderpath -PathType Any

### Test if the folder exists, if not create it
 if ($TestPath -eq $false) {
    New-Item -Path $computerfolderpath -ItemType Directory
    }
### Run the script on the computer and export the results to a CSV
    $results = Invoke-Command -ComputerName $computer -ScriptBlock $scriptBlock
    $filepath = Join-Path -Path $computerfolderpath -ChildPath "UserLogonLog.csv"
    $results | Export-csv -path $filepath -NoTypeInformation -Append
  }