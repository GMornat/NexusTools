@echo off
cls
echo °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
echo °                               cminstaller                               °
echo °°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°°
echo Are you sure to flash CyanogenMod ?
pause
echo Turn on your device and activate USB debuging in Developers Options
pause
adb devices
adb reboot bootloader
echo When you are in Fastboot Mode , continue the script
pause
fastboot oem unlock
echo Follow the instructions for unlocking your bootloader , then continue
pause
echo Your phone will reboot in Fastboot Mode . Look at the last line
echo If the last line of this mode is "Lock State : Unlocked" , you can skip
pause
fastboot flash recovery recovery.img
echo If the flash is success , then you can boot in recovery with Volume keys
echo and select it with POWER button , when you are in your favorite recovery ,
echo continue the script .
pause
echo Start the ADB sideload mode :) , then continue !
pause
adb sideload cm.zip
echo If you get out ADB sideload mode after a first flash success , restart it
echo and continue
pause
adb sideload gapps.zip
echo COOL ! Now CyanogenMod is installed :)
echo Reboot your device with commands in the recovery mode you are :)
echo WELCOME TO CYANOGENMOD !
