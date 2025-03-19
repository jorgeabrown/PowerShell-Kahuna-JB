$servers = Get-ADComputer -filter * -Properties * | Where-Object { $_.OperatingSystem -like "*Server*" } | Select-Object Name

foreach ($server in $servers) {
    $uptime = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $server.Name | Select-Object CSName,LastBootUpTime
    $cpu = Get-CimInstance -ClassName Win32_Processor -ComputerName $server.Name | Measure-Object -Property LoadPercentage -Average
    $memory = (Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $server.Name).FreePhysicalMemory / 1KB

    $results = [PSCustomObject]@{
        Date = Get-Date
        ServerName = $uptime.CSName
        UptimeDays = (Get-Date) - $uptime.LastBootUpTime
        AvgCPU = [math]::Round($cpu.Average, 2)
        FreeMemoryMB = $memory
    }
}
$results | Export-Csv -Path "C:\Reports\ServerReport.csv" -NoTypeInformation -Append
