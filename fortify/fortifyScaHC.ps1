$FORTIFY_HOME = "C:\Program Files\Fortify\Fortify_SCA_and_Apps_22.1.0"

function Get-FortifyInSystemPath {
    try{
        return $env:Path.split(";") | ?{$_ -like "*fortify*"}
        }
    catch{
        return 0
        }
}

function Get-ScaVersion {
    try{
        return $FORTIFY_HOME.split("_")[-1]
        }
    catch{
        return 0
        }
}

function Get-License {
    try{
        [string[]]$license = (Get-Content $FORTIFY_HOME"\fortify.license")
        return $license
        
        }
    catch{
        return 0
    }
}

function Get-Config {
    try{
        [string[]]$config = (Get-Content $FORTIFY_HOME"\Core\config\server.properties")
        return $config
        
        }
    catch{
        return 0
    }
}

function Get-RuleVersion {
    try {
        $ver = (Get-Content -Head 10 $FORTIFY_HOME"\Core\config\ExternalMetadata\externalmetadata.xml") | ?{$_ -match "<Version>(.*?)</Version>"}
        return $Matches.1
    }
    catch{
        return 0
    }

}

function Get-SystemInfo {
    try{
        return (Get-ComputerInfo | select OsName,OsVersion,@{Name="Memory"; Expression={([math]::round(($_.CsTotalPhysicalMemory / 1GB),2))}},CsNumberOfLogicalProcessors,CsNumberOfProcessors,OsLocale, TimeZone, @{Name="OsUpDays"; Expression={ $_.OsUptime.Days}})
        }
    catch{
        return 0
        }
}

function Get-DiskInfo {
    try{
        return Get-WmiObject -Class win32_logicaldisk | select DeviceId, @{n="Size";e={[math]::Round($_.Size/1GB,2)}},@{n="FreeSpace";e={[math]::Round($_.FreeSpace/1GB,2)}}
        
        }
    catch{
        return 0
    }
}


$results = [ordered]@{ScaVersion=Get-ScaVersion; `
             RuleVersion=Get-RuleVersion; `
             FortifyInSystemPath=Get-FortifyInSystemPath; `
             Config=Get-Config; `
             License=Get-License; `
             DiskInfo=Get-DiskInfo; `
             SystemInfo=Get-SystemInfo
             
           }


$results | ConvertTo-Json -Depth 2
$results | ConvertTo-Json -Depth 2 | Out-File CW_SCA_HC_$(hostname).json 
