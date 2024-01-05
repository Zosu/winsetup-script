# powershell script for actions that require powershell
# calls winsetup.bat at the end

$minver = 1.6 # minimum set winget version at time of script creation
$winget_link = "ms-windows-store://pdp?rtc=1&hl=en-us&gl=us&productid=9NBLGGH4NNS1&mode=mini&pos=2552%2C-8%2C1936%2C1048&referrer=storeforweb&source=https%3A%2F%2Flearn.microsoft.com%2F"

$wingetver = winget -v
Write-Host "Detected Winget Version:" $wingetver
$wingetver = $wingetver.SubString(1)

if ($wingetver -lt $minver){
    Write-Host "Please update WinGet in order to have the script run properly."
    Write-Host "Click the update button for app installer. Once it has been updated rerun the script."
    Start-Process $winget_link
    Pause
    Exit
}
Write-Host "The setup script will now proceed to run."
Write-Host "Please remain present for any prompts."
Pause

# A little unintuitive, but the file locations are in relation to the setupscript.bat file

Start-Process -FilePath "Script_Files\winsetup.bat" -Verb RunAs


Exit