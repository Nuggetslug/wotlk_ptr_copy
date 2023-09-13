@echo off
cls
@setlocal enableextensions
@cd /d "%~dp0"
if not exist _classic_ptr_ echo _classic_ptr_ directory not found^! This script is either in the wrong location or the WoTLK PTR is not installed. & goto :README_YELL
set /P prereq_assumptions_met=Have you the installed the WoTLK PTR Client, copied all desired characters to PTR, and logged into each character as per the readme? (Y/N) 
if /I "%prereq_assumptions_met%" EQU "N" goto :README_YELL

echo:
echo --------------------------
echo Step 0. Script prep
echo --------------------------

set /A num_addons=0
set "live_dir=%~dp0_classic_"
set "ptr_dir=%~dp0_classic_ptr_"
set addon_dir=Interface\Addons
set wtf_acct_dir=WTF\Account

set config_cache_file=config-cache.wtf
set bindings_cache_file=bindings-cache.wtf
set config_file=Config.wtf
set macros_cache_file=macros-cache.txt

set "live_addons_dir=%live_dir%\%addon_dir%"
set "ptr_addons_dir=%ptr_dir%\%addon_dir%"

set "live_wtf_acct_dir=%live_dir%\%wtf_acct_dir%"
set "ptr_wtf_acct_dir=%ptr_dir%\%wtf_acct_dir%"

set "ptr_realm_name=Classic PTR Realm 1"

echo WoTLK Install Directory is %live_dir%
echo WoTLK PTR Install Directory is %ptr_dir%
setlocal ENABLEDELAYEDEXPANSION

echo Detecting account names...
set account_name=placeholder
for /F "delims=" %%d in ('dir /b "%live_wtf_acct_dir%"') do (
	set /P "correct_acct=Found account name %%d, is this the correct account? (Y/N) "
	if /I "!correct_acct!" EQU "Y" set "account_name=%%d" & goto :FOUND_ACCT
)
:NO_ACCT_FOUND
echo No accounts left to search, please try again after checking your account name!
goto :END

:FOUND_ACCT
echo Using account name %account_name%.

echo:
echo --------------------------
echo Step 1. Copy all addons from Live to PTR
echo --------------------------
echo Detecting Addons from Live servers...
for /F "delims=" %%d in ('dir /b "%live_addons_dir%"') do set /A num_addons=!num_addons! + 1
echo %num_addons% addons found on WoTLK Live client.

echo:

echo Cleaning addons directory in WoTLK PTR directory...
del "%ptr_addons_dir%\*" /s /q 1>nul
for /F "delims=" %%d in ('dir /b "%ptr_addons_dir%\.*"') do echo %%d
echo Completed.

echo:

echo Copying %num_addons% addons to WoTLK PTR client...
xcopy "%live_addons_dir%" "%ptr_addons_dir%" /s /e /q

echo:
echo --------------------------
echo Step 2. Copy account settings
echo --------------------------
for /F "delims=" %%d in ('dir /a:d /b "%ptr_wtf_acct_dir%\*"') do (
	set ptr_acct_name=%%d
	
	if exist "%live_dir%WTF\%config_file%" echo Copying client based account settings.... & xcopy "%live_dir%WTF\%config_file%" "%ptr_dir%WTF\" /y /q & echo:
	
	if exist "%live_wtf_acct_dir%\%account_name%\%bindings_cache_file%" echo Copying account wide keybinds %bindings_cache_file%... & xcopy "%live_wtf_acct_dir%\%account_name%\%bindings_cache_file%" "%ptr_wtf_acct_dir%\!ptr_acct_name!\" /y /q & echo:
	
	if exist "%live_wtf_acct_dir%\%account_name%\%macros_cache_file%" echo Copying account wide macros %macros_cache_file%... & xcopy "%live_wtf_acct_dir%\%account_name%\%macros_cache_file%" "%ptr_wtf_acct_dir%\!ptr_acct_name!\" /y /q & echo:
	
	if exist "%live_wtf_acct_dir%\%account_name%\%config_cache_file%" echo Copying account wide interface settings %config_cache_file%... & xcopy "%live_wtf_acct_dir%\%account_name%\%config_cache_file%" "%ptr_wtf_acct_dir%\!ptr_acct_name!\" /y /q & echo:
	
	echo --------------------------
	echo Step 3. Copy character-specific settings
	echo --------------------------
	for /F "delims=" %%e in ('dir /b /a:d "%ptr_wtf_acct_dir%\!ptr_acct_name!\%ptr_realm_name%\*"') do (
		set char_name=%%e

		if /I "!char_name!" NEQ "SavedVariables" (
			echo Found WoTLK PTR Character named !char_name!.
			set correct_server=n
			set server_name=placeholder
			for /F "delims=" %%f in ('dir /b /a:d "%live_wtf_acct_dir%\%account_name%\"') do (
				set temp_server=%%f
				if /I "!temp_server!" NEQ "SavedVariables" (
					if /I "!correct_server!" NEQ "Y" (
						set /P "correct_server=Found Live WoTLK server name %%f, is this the correct server for !char_name! on Live WoTLK? (Y/N) "
						if /I "!correct_server!" EQU "Y" set "server_name=!temp_server!"
					)
				)
			)
			if /I "!server_name!" EQU "placeholder" (
				echo No servers left to search, skipping !char_name!...
				echo:
			) else (
				set "curr_live_character_dir=%live_wtf_acct_dir%\%account_name%\!server_name!\!char_name!"
				set "curr_ptr_character_dir=%ptr_wtf_acct_dir%\!ptr_acct_name!\%ptr_realm_name%\!char_name!"
				echo Using Live WoTLK server name !server_name! for !char_name!.
				echo:
				
				if exist "!curr_live_character_dir!" (
					if exist "!curr_ptr_character_dir!" (										
						echo Copying addon settings for !char_name!...				
						xcopy "!curr_live_character_dir!\SavedVariables\*.*" "!curr_ptr_character_dir!\SavedVariables\" /y /q /e
						
						if exist "!curr_live_character_dir!\%config_cache_file%" echo: & echo Copying character based settings %config_cache_file% for !char_name!... & xcopy "!curr_live_character_dir!\%config_cache_file%" "!curr_ptr_character_dir!\" /y /q
						
						if exist "!curr_live_character_dir!\%bindings_cache_file%" echo: & echo Copying character-based keybinds %bindings_cache_file% for !char_name!... & xcopy "!curr_live_character_dir!\%bindings_cache_file%" "!curr_ptr_character_dir!\" /y /q
						
						if exist "!curr_live_character_dir!\%macros_cache_file%" echo: & echo Copying character-based macros %macros_cache_file% for !char_name!... & xcopy "!curr_live_character_dir!\%macros_cache_file%" "!curr_ptr_character_dir!\" /y /q
						
						echo Finished character copy of !char_name!-!server_name! to WoTLK PTR
						echo:
					) else (
						echo PTR character directory !curr_ptr_character_dir! does not exist. Skipping...
					)
				) else (
					echo Live character directory !curr_live_character_dir! does not exist. Skipping...
				)					
			)
		)
	)
)

echo --------------------------
echo DATA MIGRATION TO WOTLK PTR COMPLETED^^!
echo --------------------------
goto :END


:README_YELL
echo Please read through the readme on the github page before continuing with this script!
goto :END 

:END
pause