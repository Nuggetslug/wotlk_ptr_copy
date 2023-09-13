# wotlk_ptr_copy
Copies WoTLK Classic addons, character configuration, macros, game settings to the WoTLK PTR install.

# Assumptions / Prerequisite Steps
1. You have downloaded and installed the PTR Client (follow this to enable PTR on your account [Enable PTR Account](https://us.battle.net/support/en/article/000211136?_gl=1*l4v1j7*_ga*NDE1NDM1NDI5LjE2NzY0MzUxNjU.*_ga_VYKNV7C0S3*MTY5NDQ3NDMwMi4zLjAuMTY5NDQ3NDMwMi42MC4wLjA))
2. The _classic_ and _classic_ptr_ directories exist within the same /World of Warcraft/ directory (Usually C:/Program Files (x86)/World of Warcraft/). This should be true if you installed the PTR Client with default options.
3. You have used the "Copy Character" function (from character select screen) to copy *all* desired characters.
4. You have logged into each of the above character(s) one time.

# How To Use
1. Place ptr_copy.bat in the same parent directory that contains /\_classic\_/ and /\_classic_ptr\_/ directories
	- This should directly in the /path//to/something/World of Warcraft/ directory
	- You can open this exact location by clicking the Cog icon on the right-hand portion of the "Play" button in Battle.net Launcher and clicking "Show in Explorer"
2. After verifying you have run all steps in the above "Assumptions / Prerequisite Steps" section, double click on ptr_copy.bat to start the copy process. 
3. The script will prompt multiple times (yes/no prompts) to confirm some information. This is due to the World of Warcraft install potentially housing multiple accounts and the fact that live characters can come from any server but all combine onto one PTR server. 
	- For example: you could have a character named Nuggetslug on two different live servers and only one copy of Nuggetslug on the PTR server, so the script needs to know which live server to pull character-specific configurations from. You also may have character information on multiple servers if you did a server transfer.

# Notes
1. The "Copy Account Data" will do some *but not all* data copying and is optional for this script.
2. This will *completely wipe any existing PTR config* and copy all Live WoTLK data into your PTR data for both account-wide and character-specific settings.

# Sample Output
	Have you the installed the WoTLK PTR Client, copied all desired characters to PTR, and logged into each character as per the readme? (Y/N) y

	--------------------------
	Step 0. Script prep
	--------------------------
	WoTLK Install Directory is D:\Program Files (x86)\World of Warcraft\_classic_
	WoTLK PTR Install Directory is D:\Program Files (x86)\World of Warcraft\_classic_ptr_
	Detecting account names...
	Found account name <redacted>, is this the correct account? (Y/N) y
	Using account name <redacted>.

	--------------------------
	Step 1. Copy all addons from Live to PTR
	--------------------------
	Detecting Addons from Live servers...
	46 addons found on WoTLK Live client.

	Cleaning addons directory in WoTLK PTR directory...
	Completed.

	Copying 46 addons to WoTLK PTR client...
	5289 File(s) copied

	--------------------------
	Step 2. Copy account settings
	--------------------------
	Copying account wide keybinds bindings-cache.wtf...
	1 File(s) copied

	Copying account wide macros macros-cache.txt...
	1 File(s) copied

	Copying account wide interface settings config-cache.wtf...
	1 File(s) copied

	--------------------------
	Step 3. Copy character-specific settings
	--------------------------
	Found WoTLK PTR Character named Nuggetslug.
	Found Live WoTLK server name Pagle, is this the correct server for Nuggetslug on Live WoTLK? (Y/N) y
	Using Live WoTLK server name Pagle for Nuggetslug.

	Copying addon settings for Nuggetslug...
	34 File(s) copied

	Copying character based settings config-cache.wtf for Nuggetslug...
	1 File(s) copied

	Copying character-based macros macros-cache.txt for Nuggetslug...
	1 File(s) copied
	Finished character copy of Nuggetslug-Pagle to WoTLK PTR

	Found WoTLK PTR Character named Slugnugget.
	Found Live WoTLK server name Pagle, is this the correct server for Slugnugget on Live WoTLK? (Y/N) n
	Found Live WoTLK server name Sulfuras, is this the correct server for Slugnugget on Live WoTLK? (Y/N) y
	Using Live WoTLK server name Sulfuras for Slugnugget.

	Copying addon settings for Slugnugget...
	6 File(s) copied

	Copying character based settings config-cache.wtf for Slugnugget...
	1 File(s) copied
	Finished character copy of Slugnugget-Sulfuras to WoTLK PTR

	--------------------------
	DATA MIGRATION TO WOTLK PTR COMPLETED!
	--------------------------
	Press any key to continue . . .