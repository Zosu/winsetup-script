@echo off
REM Just the start for the script chain so no execution policy needs to be changed and for easier use
powershell.exe -executionpolicy bypass -file "Script_Files\setup_ps_script.ps1"

echo Please restart to apply all changes
echo Don't forget to check startup programs!
pause
