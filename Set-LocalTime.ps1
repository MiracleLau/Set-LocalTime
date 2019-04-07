<#
.SYNOPSIS
This tool can get the time on the HTTP server to synchronize the local time

.DESCRIPTION
Administrator privileges are required to use this program

.PARAMETER url
Http server,default is http://baidu.com

.PARAMETER WhatIf
Show ServerTime,but didn't set local time

.EXAMPLE
PS > Set-LocalTime
Get time from: http://baidu.com
Set local time
Success£¬Local time is:2019/04/06 18:08:12

.EXAMPLE
PS > Set-LocalTime -WhatIf
Get time from http://baidu.com
Server:http://baidu.com`tTime:2019/04/06 18:08:12

.LINK
http://blog.sodsec.com
#>

param(
    [string]$url,
    [switch]$WhatIf
)

if(!$url){
    $url="http://baidu.com"
}

try{
    Write-Host "Get time from ${url}"
    $req = Invoke-WebRequest -Method Head -TimeoutSec 3  -Uri $url
    $time = $req.Headers['Date'].todatetime([CultureInfo]::CurrentCulture).tostring('G')
    if($WhatIf){
        Write-Host "Server: ${url}`tTime:${time}"
    }else{
        Write-Host "Set Local Time"
        Set-Date -Date $time | Out-Null
        Write-Host "Success£¬Local Time Is:"
        Get-Date -Format G
    }
}catch{
    Write-Error $_
}
