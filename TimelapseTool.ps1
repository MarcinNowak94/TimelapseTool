Import-Module .\PML.psm1


$LogDir = "$env:USERPROFILE\Pictures\Screenshots\Timelapse\"
$Directory = "$LogDir$(get-date -f yyyy-MM-dd)"


if (!(Test-Path $Directory)) {
    New-Item -Path $Directory -ItemType Directory
}


#setup loop
$TimeStart=Get-Date
$screenshots=0
Do { 
 FullScreenshot "$Directory\$screenshots.jpg"
 #FullScreenshot "$Directory\$(get-date -f yyyy-MM-dd_hh-mm-ss).jpg"
 $screenshots++
 Start-Sleep -Seconds 45
}
Until ( [ System.Environment ]:: HasShutdownStarted )

"$(get-date)`tMade $screenshots `tscreenshots since $Timestart" | Out-File -Append "$LogDir\Timelapse.log"



<#
#<WIP>

https://www.ffmpeg.org/ffmpeg-formats.html
#Stream fails 
ffmpeg -r 10 -i $Directory\%d2.jpg -c:v libx264 -r 30 -pix_fmt yuv420p "$Directory\OUTPUT_FILE.mp4"


$i=0;

Get-ChildItem $Directory | %{ Rename-Computer $_.FullName "$i.jpg"; i++}
#>