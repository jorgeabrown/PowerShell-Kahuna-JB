# This script will gather the uptime, CPU usage, and free memory of all servers in the domain and output the results to a CSV file.
# If you do not want to keep the data, remove -Append from the Export-Csv command.

### Query AD for all servers in the domain
$servers = Get-ADComputer -filter * -Properties * | Where-Object { $_.OperatingSystem -like "*Server*" } | Select-Object Name

### Loop through each server and gather the required information
foreach ($server in $servers) {
  Try {
    $uptime = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $server.Name | Select-Object CSName,LastBootUpTime
    $cpu = Get-CimInstance -ClassName Win32_Processor -ComputerName $server.Name | Measure-Object -Property LoadPercentage -Average
    $memory = (Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $server.Name).FreePhysicalMemory / 1KB

### Create a custom object with the gathered information and export it to a CSV file
    $results = [PSCustomObject]@{
        Date = Get-Date
        ServerName = $uptime.CSName
        UptimeDays = (Get-Date) - $uptime.LastBootUpTime
        AvgCPU = [math]::Round($cpu.Average, 2)
        FreeMemoryMB = $memory
    }
    $results | Export-Csv -Path "C:\Reports\ServerReport.csv" -NoTypeInformation -Append
} catch {
### If an error occurs, write a warning message to the console
    Write-Warning "Failed to query $server.Name"
  }
}

