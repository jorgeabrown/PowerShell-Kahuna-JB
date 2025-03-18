### List of Target Computers
$computerList = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name

### 
$baseSharedrive = "\\LON-DC1\Logs"

### Script to run on each computer
$scriptBlock = {
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
foreach ($computer in $computerList) {
    $computerfolderpath = Join-Path -Path $baseSharedrive -ChildPath $computer
    $TestPath = Test-Path -Path $computerfolderpath -PathType Any

 if ($TestPath -eq $false) {
    New-Item -Path $computerfolderpath -ItemType Directory
    }
    $results = Invoke-Command -ComputerName $computer -ScriptBlock $scriptBlock
    $filepath = Join-Path -Path $computerfolderpath -ChildPath "UserLogonLog.csv"
    $results | Export-csv -path $filepath -NoTypeInformation
  }