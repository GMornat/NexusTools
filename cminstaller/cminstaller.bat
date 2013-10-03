@echo off
cls
echo °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°�
echo °                               cminstaller                             A�
echo °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°�
echo NOTE: Use this script at your own risk!
echo We are not responsible for dead kittens, any injuries or broken devices!
echo Use this script only for Nexus devices. Other devices may not work or
echo in worst case brick!
echo
echo Are you sure to flash CyanogenMod?
pause
echo IS YOUR BOOTLOADER UNLOCKED?
echo 1 -- YES
echo 2 -- NO
set /p choix=Que voulez vous faire?
if "%choix%"=="1" goto :fastboot
if "%choix%"=="2" goto :unlock

:unlock
echo Turn on your device and activate USB debuging in Developers Options
pause
adb devices
echo Continue if you see your device in list.
pause
adb reboot bootloader
echo Continue when your device is in Fastboot mode.
pause
echo Unlocking device...
fastboot oem unlock
echo Follow the instructions on the devices screen to unlock your bootloader.
echo Continue when your device has been unlocked successfully.
pause
echo Your phone will reboot in Fastboot Mode . Look at the last line
echo If the last line in this mode is "Lock State : Unlocked", you can continue.
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
goto :recovery

:recovery
echo Have you flashed a custom recovery (Select NO if unsure)?
echo 1 -- YES
echo 2 -- NO
set /p choix=Que voulez vous faire?
if "%choix%"=="1" goto :flash
if "%choix%"=="2" goto :flashrecovery

:flashrecovery
echo Continue to flash recovery.img
pause
echo Flashing recovery...
fastboot flash recovery recovery.img
echo If the flash was successful you can continue
pause
goto :flash

:flash
echo Now booting to recovery
fastboot boot recovery.img
echo With your recovery , wipe Data , Cache and Dalvik and then
echo start the ADB sideload mode :) and continue !
pause
echo Flashing cm.zip
adb sideload cm.zip
echo Do you want to flash Google Apps?
echo 1 -- YES
echo 2 -- NO
set /p choix=Que voulez vous faire?
if "%choix%"=="1" goto :flashgapps
if "%choix%"=="2" goto :finish

:flashgapps
echo If You got out of ADB sideload mode after the first zip flashed successfully
echo restart sideload mode and continue
pause
echo Flashing gapps.zip
adb sideload gapps.zip
goto :finish

:finish
echo COOL! Now CyanogenMod is installed :)
echo Continue to reboot the device.
pause
adb reboot
echo WELCOME TO CYANOGENMOD!
echo Enjoy your new shiny custom ROM!
goto :exit

:exit
