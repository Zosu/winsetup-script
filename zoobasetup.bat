@echo off

REM Check for admin permissions
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Success: Administrative permissions confirmed.
) else (
    echo Error: script not running with admin permisisons! Rerun as administrator.
    pause
    exit
)

REM Disable mouse enhanced pointer precision
echo Disabling mouse enhanced pointer precision
reg add "HKCU\Control Panel\Mouse" /v MouseSpeed /t REG_SZ /d 0 /f

REM Disable keyboard accessibility shortcuts
reg add "HKCU\Control Panel\Accessibility\StickyKeys" /v Flags /t REG_SZ /d 506 /f
reg add "HKCU\Control Panel\Accessibility\Keyboard Response" /v Flags /t REG_SZ /d 122 /f
reg add "HKCU\Control Panel\Accessibility\ToggleKeys" /v Flags /t REG_SZ /d 58 /f
echo Sticky Keys and Filter Keys shortcuts and Toggle Keys have been disabled.

REM Change file explorer settings for better security and convenience
echo Changing explorer settings for convenience and security (Default launch to This PC, show hidden files, show all file extensions)
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v LaunchTo /t REG_DWORD /d 1 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v Hidden /t REG_DWORD /d 1 /f
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v HideFileExt /t REG_DWORD /d 0 /f

REM Set DNS settings
echo Setting DNS settings to cloudflare's DNS
for /f "skip=2 tokens=3*" %%i in ('netsh interface show interface') do (
    netsh interface ipv4 set dnsservers "%%j" static 1.1.1.1 primary
    netsh interface ipv4 add dnsservers "%%j" 1.0.0.1 index=2
)

REM Install Browsers
echo Installing Browsers
winget install -e --id Google.Chrome -i
winget install -e --id Mozilla.Firefox -i

REM Install Packages
echo Installing software Packages
winget install -e --id EclipseAdoptium.Temurin.17.JDK

REM Install game software
echo Installing gaming software
winget install -e --id Valve.Steam
winget install -e --id Discord.Discord
winget install -e --id Mojang.MinecraftLauncher

REM Install misc tools
echo Installing misc tools
winget install -e --id VideoLAN.VLC
winget install -e --id 7zip.7zip
winget install -e --id OBSProject.OBSStudio
winget install -e --id GIMP.GIMP
winget install -e --id PuTTY.PuTTY
winget install -e --id WinSCP.WinSCP
winget install -e --id WireGuard.WireGuard
:: winget install -e --id CodeSector.TeraCopy 


REM Install helpful computer tools
echo making folder for computer tools
mkdir C:\Computer_Tools
echo Installing helpful computer tools
winget install -e --id REALiX.HWiNFO --location "C:\Computer_Tools\HWiNFO64"
winget install -e --id TechPowerUp.GPU-Z --location "C:\Computer_Tools\GPU-Z"
winget install -e --id CPUID.HWMonitor --location "C:\Computer_Tools\HWMonitor"
winget install -e --id AntibodySoftware.WizTree --location "C:\Computer_Tools\WizTree"
winget install -e --id HandBrake.HandBrake --location "C:\Computer_Tools\HandBrake"
winget install -e --id MediaArea.MediaInfo.GUI --location "C:\Computer_Tools\MediaInfo"
winget install -e --id Wagnardsoft.DisplayDriverUninstaller --location "C:\Computer_Tools\DDU"
winget install -e --id CrystalDewWorld.CrystalDiskInfo --location "C:\Computer_Tools\CrystalDiskInfo"
winget install -e --id BitSum.ParkControl --location "C:\Computer_Tools\ParkControl"
winget install -e --id Resplendence.WhoCrashed --location "C:\Computer_Tools\WhoCrashed"
winget install -e --id Resplendence.LatencyMon --location "C:\Computer_Tools\LatencyMon"
winget install -e --id Rufus.Rufus --location "C:\Computer_Tools\Rufus"
winget install -e --id MoritzBunkus.MKVToolNix --location "C:\Computer_Tools\MKVToolNix"
winget install -e --id NirSoft.BlueScreenView --location "C:\Computer_Tools\BlueScreenView"
winget install -e --id Maxon.CinebenchR23 --location "C:\Computer_Tools\CinebenchR23"

REM Installations that need options selected
winget install -e --id NickeManarin.ScreenToGif -i
winget install -e --id Logitech.LGS -i

echo Done!
echo Restart to apply all changes.
echo Check startup settings
pause
