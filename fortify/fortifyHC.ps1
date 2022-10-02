# powershell "IEX(New-Object Net.WebClient).downloadString('https://raw.githubusercontent.com/intrapus/appsec/master/fortify/fortifyHC.ps1')" 
# powershell "(New-Object Net.WebClient).downloadFile('https://raw.githubusercontent.com/intrapus/appsec/master/fortify/fortifyHC.ps1','fortifyHC.ps1');./fortifyHC.ps1 -mode sys,ssc"


param (
    [String[]]$MODE,
    [String]$SCA_HOME,
    [String]$SSC_HOME
)

function Get-ScaPath {
    try{
        return  Split-Path $env:Path.split(";") | ?{$_ -like "*fortify*"}
        }
    catch{
        return 0
        }
}

function Get-ScaVersion {
    try{
        return $SCA_HOME.split("_")[-1]
        }
    catch{
        return 0
        }
}

function Get-ScaLicense {
    try{
        [string[]]$license = (Get-Content $SCA_HOME"\fortify.license") | ?{$_ -notlike "#*"} | ?{$_ -notlike ""}
        return $license       
        }
    catch{
        return 0
    }
}

function Get-ScaConfig {
    try{
        [string[]]$config = (Get-Content $SCA_HOME"\Core\config\server.properties") | ?{$_ -notlike "#*"} | ?{$_ -notlike ""}
        return $config       
        }
    catch{
        return 0
    }
}

function Get-RuleVersion {
    try {
        $ver = (Get-Content -Head 10 $SCA_HOME"\Core\config\ExternalMetadata\externalmetadata.xml") | ?{$_ -match "<Version>(.*?)</Version>"}
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

function Get-SscConfig {
    try{
        [string[]]$app = (Get-Content $SSC_HOME"\ssc\conf\app.properties") | ?{$_ -notlike "#*"} | ?{$_ -notlike ""}
        [string[]]$datasource = (Get-Content $SSC_HOME"\ssc\conf\datasource.properties") | ?{$_ -notlike "#*"} | ?{$_ -notlike ""}
        [string[]]$version = (Get-Content $SSC_HOME"\ssc\conf\version.properties") | ?{$_ -notlike "#*"} | ?{$_ -notlike ""}
        return [ordered]@{Version=$version; Datasource=$datasource; App=$app}      
        }
    catch{
        return 0
    }
}

function Get-SscLicense {
    try{
        [string[]]$license = (Get-Content $SSC_HOME"\fortify.license") | ?{$_ -notlike "#*"} | ?{$_ -notlike ""}
        return $license       
        }
    catch{
        return 0
    }
}

function Get-TomcatInfo {
    try {
        $service = get-service | ?{$_.name -like "*tomcat*" -and $_.status -eq "running"} | select name,servicename,displayname
        $process = get-process | ?{$_.processname -eq $service.servicename} | select name,path,id
        $sockets = Get-NetTCPConnection -State Listen | ?{$_.owningprocess -eq $process.id} | select localaddress, localport, owningprocess
        return [ordered]@{Service=$service; Process=$process; Sockets=$sockets}
    }
    catch{
        return 0
    }
}


$MODE = If ($MODE) {$MODE} Else {@('SCA','SYS')}
$SCA_HOME = If ($SCA_HOME) {$SCA_HOME} Else {Get-ScaPath}
$SSC_HOME = If ($SSC_HOME) {$SSC_HOME} Else {"C:\Fortify\home"}
$RES = [ordered]@{}

if ($MODE -contains "SYS"){

    $SYS_RES = [ordered]@{
        DiskInfo=Get-DiskInfo; `
        SystemInfo=Get-SystemInfo
    }

    $RES += $SYS_RES
}

if ($MODE -contains "SCA"){

    $SCA_RES = [ordered]@{
        ScaVersion=Get-ScaVersion; `
        RuleVersion=Get-RuleVersion; `
        ScaPath=$SCA_HOME; `
        ScaConfig=Get-ScaConfig; `
        ScaLicense=Get-ScaLicense 
    }

    $RES += $SCA_RES
}


if ($MODE -contains "SSC"){

    $SYS_RES = [ordered]@{
        SscConfig=Get-SscConfig; `
        SscLicense=Get-SscLicense; `
        TomcatInfo=Get-TomcatInfo
    }

    $RES += $SYS_RES
}


$JSON_RES = $RES | ConvertTo-Json -Depth 3
$JSON_RES | Out-File CW_FORTIFY_HC_$(hostname).json 
