Function Get-CorpCompSysinfo {
    [cmdletbinding()]
    Param(
        [string[]]$ComputerName
        )
    
    ForEach($computer in $ComputerName) {
    
    $compsys = Get-CimInstance -ClassName Win32_ComputerSystem -ComputerName $ComputerName
    $Bios = Get-CimInstance -ClassName Win32_BIOS -ComputerName $ComputerName
    $properties = [ordered] @{
                 'Computername' = $computer;
                 'BiosSerial'   = $bios.SerialNumber;
                 'Manufacturer' = $compsys.Manufacturer;
                 'Model'        = $compsys.Model;
                   }
            $outputobject = New-Object -TypeName psobject -Property $properties
            Write-Output $outputobject
                                        }
                            }