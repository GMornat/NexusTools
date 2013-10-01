#!/bin/bash

cyanogenmodinstall () {
echo "Install Cyanogenmod"
read -p "Waiting to activate USB debuging and continue"
adb reboot bootloader
echo "When you're on Fastboot Mode , continue the script"
sudo fastboot flash recovery recovery.img
echo "If the flash is success , then you can boot in recovery with Volume keys"
echo "and select it with POWER button , when you are in your favorite recovery ,"
read -p "continue the script ."
echo "With your recovery , wipe Data , Cache and Dalvik and then ,"
read -p "start the ADB sideload mode :) and continue !"
adb sideload cm.zip
echo "If you get out ADB sideload mode after a first flash success , restart it"
read -p "and continue"
adb sideload gapps.zip
echo "COOL ! Now CyanogenMod is installed :)"
echo "Reboot your device with commands in the recovery mode you are :)"
echo "WELCOME TO CYANOGENMOD !"

}

bootloaderunlock () {
read -p "Turn on your device and activate USB debuging in Developers Options"
adb devices
adb reboot bootloader
read -p "When you are in Fastboot Mode , continue the script"
sudo fastboot oem unlock
read -p "Follow the instructions for unlocking your bootloader , then continue"
echo "Your phone will reboot in Fastboot Mode . Look at the last line"
read -p "If the last line of this mode is Lock State : Unlocked , you can continue"
echo "For safety , we will reboot"
sudo fastboot reboot

}

echo "-----------------"
echo "|  cminstaller  |"
echo "-----------------"
echo "Are you sure to flash CyanogenMod ?"
read -p "Press any Key to continue "
while true
do
echo "IS YOUR BOOTLOADER UNLOCKED ?"
echo "1-- YES"
echo "2-- NO"
read -p "Your Choice:" Choice
if [ "$Choice" = "2" ]
  then
    bootloaderunlock
    break
elif [ "$Choice" = "1" ]
  then
    echo "Skipping bootloader unlock"
    cyanogenmodinstall
    break
else
echo "Wrong input"
fi
done


