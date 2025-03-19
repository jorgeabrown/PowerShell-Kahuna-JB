# Define a list of domain computers
$computers = Get-ADComputer -Filter * | Select-Object -ExpandProperty Name

# Credentials (if required for remote access)
$credential = Get-Credential

# Set the size threshold (in bytes) - 4 GB
$threshold = 4GB

foreach ($computer in $computers) {
    try {
        Invoke-Command -ComputerName $computer -Credential $credential -ScriptBlock {
            # Define the size threshold
            $threshold = 4GB

            # Get all user profile paths
            $profiles = Get-ChildItem "C:\Users" | Where-Object { $_.PSIsContainer }

            foreach ($profile in $profiles) {
                $recycleBinPath = Join-Path -Path $profile.FullName -ChildPath "Recycle.Bin"

                if (Test-Path -Path $recycleBinPath) {
                    # Calculate the total size of the Recycle Bin
                    $totalSize = Get-ChildItem -Path "$recycleBinPath\*" -Recurse | Measure-Object -Property Length -Sum | Select-Object -ExpandProperty Sum

                    # Check if the total size exceeds the threshold
                    if ($totalSize -gt $threshold) {
                        Write-Host "Clearing Recycle Bin for: $($profile.FullName) (Size: $([math]::Round($totalSize / 1GB, 2)) GB)"
                        Remove-Item -Path "$recycleBinPath\*" -Recurse -Force
                    } else {
                        Write-Host "Recycle Bin for $($profile.FullName) is below the threshold (Size: $([math]::Round($totalSize / 1GB, 2)) GB)"
                    }
                }
            }
        }
    } catch {
        Write-Warning "Failed to process $computer: $_"
    }
}
Write-Host "Completed checking recycle bins for all users across the domain."
