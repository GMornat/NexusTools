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
echo Are you sure to flash CyanogenMod?
pause
goto :isunlocked

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
echo If not reboot it manually by selecting "Reboot" in bootloader
echo with volume keys and confirm with power button.
echo Continue when the device has rebooted.
pause
echo Turn on USB debugging again since all data was lost when the device
echo was unlocked
adb devices
echo Continue if you see your device in list above.
pause
adb reboot bootloader
pause
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

:exit
