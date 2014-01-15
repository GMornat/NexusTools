@echo off
cls
echo °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°�
echo °                               cminstaller                             A�
echo °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°�
echo -
echo NOTE: Use this script at your own risk!
echo We are not responsible for dead kittens, any injuries or broken devices!
echo Use this script only for Nexus devices. Other devices may not work or
echo in worst case brick!
echo -
echo Are you sure to flash CyanogenMod (or Superuser) ?
pause
:choiceall
echo Rooting or CyanogenMod ?
echo 1 -- CyanogenMod (root included)
echo 2 -- Rooting only
set choix="Notset"
set /p choix=Type 1 or 2: 
if "%choix%"=="1" (
	goto :checkfilescm
) else if "%choix%"=="2" (
	goto :rootfiles
) else (
	echo Invalid  choice. Type only 1 or 2.
	goto :choiceall
)

:checkfilescm
if not exist adb.exe (
	echo adb.exe is missing.
	goto :missingfile
)
if not exist fastboot.exe (
	echo fastboot.exe is missing.
	goto :missingfile
)
if not exist AdbWinApi.dll (
	echo AdbWinApi.dll is missing.
	goto :missingfile
)
if not exist AdbWinUsbApi.dll (
	echo AdbWinUsbApi.dll is missing.
	goto :missingfile
)
if not exist cm.zip (
	echo cm.zip is missing.
	goto :missingfile
)
if not exist recovery.img (
	echo recovery.img is missing.
	goto :missingfile
)
goto :isunlocked

:rootfiles
if not exist adb.exe (
	echo adb.exe is missing.
	goto :missingfile
)
if not exist fastboot.exe (
	echo fastboot.exe is missing.
	goto :missingfile
)
if not exist AdbWinApi.dll (
	echo AdbWinApi.dll is missing.
	goto :missingfile
)
if not exist AdbWinUsbApi.dll (
	echo AdbWinUsbApi.dll is missing.
	goto :missingfile
)
if not exist superuser.zip (
	echo superuser.zip is missing.
	goto :missingfile
)
if not exist recovery.img (
	echo recovery.img is missing.
	goto :missingfile
)
goto :isunlocked

:missingfile
echo Please place it in the same directory with this file and continue.
pause
goto :checkfiles

:isunlocked
echo Is your devices bootloader unlocked?
echo 1 -- YES
echo 2 -- NO
set choix="Notset"
set /p choix=Type 1 or 2: 
if "%choix%"=="1" (
	goto :fastboot
) else if "%choix%"=="2" (
	goto :unlock
) else (
	echo Invalid  choice. Type only 1 or 2.
	goto :isunlocked
)

:unlock
echo Turn on your device and activate USB debuging in Developers Options
pause
adb devices
echo Continue if you see your device in list above.
pause
adb reboot bootloader
echo Continue when your device is in Fastboot mode.
pause
fastboot devices
echo Continue if you see your device in list above.
pause
echo Your device will be now unlocked
echo NOTE: All your data will be lost now!
pause
echo Unlocking device...
fastboot oem unlock
echo Follow the instructions on the devices screen to unlock your bootloader.
echo Use volume buttons to select and confirm with power button.
echo Continue when your device has been unlocked successfully.
pause
echo Check if the device has rebooted to android.
echo If not, reboot it manually by selecting "Reboot" in bootloader
echo with volume keys and confirm with power button.
echo Continue when the device has rebooted.
pause
echo Turn on USB debugging again since all data was lost when the device
echo was unlocked
adb devices
echo Continue if you see your device in list above.
pause
adb reboot bootloader
echo Continue when your device is in Fastboot mode.
pause
fastboot devices
echo Continue if you see your device in list above.
pause
echo Look at the last line on your devices screen.
echo If the last line is "Lock State : Unlocked", you can continue.
pause
goto :flashrecovery

:fastboot
echo Turn on your device and activate USB debuging in Developers Options.
pause
adb devices
echo Continue if your device is listed.
pause
adb reboot bootloader
echo Continue when your device is in Fastboot mode.
pause
fastboot devices
echo Continue if you see your device in list above.
pause
goto :recovery

:recovery
echo Have you flashed a custom recovery (Select NO if unsure)?
echo 1 -- YES
echo 2 -- NO
set choix="Notset"
set /p choix=Type 1 or 2: 
if "%choix%"=="1" (
	goto :flash
) else if "%choix%"=="2" (
	goto :flashrecovery
) else (
	echo Invalid  choice. Type only 1 or 2.
	goto :recovery
)

:flashrecovery
echo Continue to flash custom recovery
pause
echo Flashing recovery.img...
fastboot flash recovery recovery.img
echo If the flash was successful you can continue
pause
goto :flash

:flash
echo Now booting to recovery
fastboot boot recovery.img
echo Only root your device , or install CyanogenMod ?
echo 1 -- CyanogenMod (rooting included)
echo 2 -- Rooting only
set choix="Notset"
set /p choix=Type 1 or 2: 
if "%choix%"=="1" (
	goto :flashcm
) else if "%choix%"=="2" (
	goto :superuser
) else (
	echo Invalid  choice. Type only 1 or 2.
	goto :flash
)

:superuser
echo You wanted to flash only Superuser. No problem :)
echo You can still install CyanogenMod in the future !
echo Turn on ADB sideload in your recovery and and continue the script
pause
adb sideload superuser.zip
echo Cool your device is now rooted !
Continue the script to reboot
pause
adb reboot
goto :superuserend

:flashcm
echo With your recovery, wipe Data, Cache and Dalvik Cache (Under andvanced options) and then
echo start the ADB sideload mode and continue.
pause
adb devices
echo Continue if you see your device listed above.
pause
echo Flashing cm.zip
adb sideload cm.zip
:gappschoice

:gappschoice
echo Do you want to flash Google Apps?
echo 1 -- YES
echo 2 -- NO
set choix="Notset"
set /p choix=Type 1 or 2: 
if "%choix%"=="1" (
	if not exist gapps.zip (
		echo gapps.zip is missing.
		echo Please place it in the same directory with this file and continue.
		pause
		goto :gappschoice
	)
	goto :flashgapps
) else if "%choix%"=="2" (
	goto :finish
) else (
	echo Invalid  choice. Type only 1 or 2.
	goto :gappschoice
)

:flashgapps
echo If You got out of ADB sideload mode after the first zip flashed successfully
echo restart sideload mode and continue
pause
echo Flashing gapps.zip
adb sideload gapps.zip
goto :finish

:finish
echo COOL! CyanogenMod has been flashed! :)
echo Continue to reboot the device.
pause
adb reboot
echo Enjoy your new shiny custom ROM!
pause
goto :exit

:superuserend
echo You didn't want to flash CyanogenMod , no problem , this is your choice :)
echo You can re-use the script to install it in the future
pause
goto :exit

:exit
