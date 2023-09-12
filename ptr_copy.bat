@echo off

:PROMPT
set /P prereq_assumptions_met=Have you the installed the WoTLK PTR Client, copied all desired characters to PTR, and logged into each character as per the readme? (Y/N) 
IF /I "%prereq_assumptions_met%" EQU "N" goto :readme_yell
IF /I "%prereq_assumptions_met%" EQU "n" goto :readme_yell

echo:
echo Starting PTR Configuration Copy...

set /A num_addons=0
set "live_dir=%~dp0_classic_\"
set "ptr_dir=%~dp0_classic_ptr_\"
set addon_dir=Interface\Addons\

set "live_addons_dir=%live_dir%%addon_dir%"
set "ptr_addons_dir=%ptr_dir%%addon_dir%"

echo WoTLK Install Directory is %live_dir%
echo WoTLK PTR Install Directory is %ptr_dir%
setlocal ENABLEDELAYEDEXPANSION

rem Step 1. Copy all addons from Live to PTR
echo:
echo Detecting Addons from Live servers...
for /F "delims=" %%d in ('dir /b "%live_addons_dir%"') do set /A num_addons=!num_addons! + 1
echo %num_addons% addons found on WoTLK client.

echo Cleaning addons directory in WoTLK PTR directory...
del /S /Q "%ptr_addons_dir%\*"
for /d %%d in ("%ptr_addons_dir%\*") do @rd /s /q "%%d"
echo Completed.

echo Copying %num_addons% addons to WoTLK PTR client...
xcopy "%live_addons_dir%" "%ptr_addons_dir%" /s /e /q

rem Step 2. Copy addon settings

pause
rem exit

:readme_yell
echo:
echo Please read through the readme on the github page before continuing with this script!
pause
