#!/bin/bash

function start {
echo "--------------EXPERIMENTAL SCRIPT FOR LINUX, MIGHT NOT WORK---------------"
echo "--------------------------------------------------------------------------"
echo "-                               cminstaller                              -"
echo "--------------------------------------------------------------------------"
echo " "
echo "NOTE: Use this script at your own risk!"
echo "We are not responsible for dead kittens, any injuries or broken devices!"
echo "Use this script only for Nexus devices. Other devices may not work or in worst case brick!"
echo " "
echo "This script needs root permissions. Please type in your password when prompted."
echo " "
echo "Are you sure to flash CyanogenMod?"
read -p "Press enter to continue..." cont
checkfiles
}

function checkfiles {
if [ ! -f adb ]
then
	echo "adb is missing."
	missingfile
fi
if [ ! -f fastboot ]
then
	echo "fastboot is missing."
	missingfile
fi
if [ ! -f cm.zip ]
then
	echo "cm.zip is missing."
	missingfile
fi
if [ ! -f recovery.img ]
then
	echo "recovery.img is missing."
	missingfile
fi
isunlocked
}

function missingfile {
echo "Please place it in the same directory with this file and continue."
read -p "Press enter to continue..." cont
checkfiles
}

function isunlocked {
sudo chmod a+x adb
sudo chmod a+x fastboot
echo "Is your devices bootloader unlocked?"
echo "1 -- YES"
echo "2 -- NO"
choix="Notset"
echo -n "Type 1 or 2: "
read choix
if [ $choix == "1" ]
then
	fastboot
elif [ $choix == "2" ]
then
	unlock
else
	echo "Invalid  choice. Type only 1 or 2."
	isunlocked
fi
}

function unlock {
echo "Turn on your device and activate USB debuging in Developers Options"
read -p "Press enter to continue..." cont
sudo ./adb devices
echo "Continue if you see your device in list above."
read -p "Press enter to continue..." cont
sudo ./adb reboot bootloader
echo "Continue when your device is in Fastboot mode."
read -p "Press enter to continue..." cont
sudo ./fastboot devices
echo "Continue if you see your device in list above."
read -p "Press enter to continue..." cont
echo "Your device will be now unlocked"
echo "NOTE: All your data will be lost now!"
read -p "Press enter to continue..." cont
echo "Unlocking device..."
sudo ./fastboot oem unlock
echo "Follow the instructions on the devices screen to unlock your bootloader."
echo "Use volume buttons to select and confirm with power button."
echo "Continue when your device has been unlocked successfully."
read -p "Press enter to continue..." cont
echo "Check if the device has rebooted to android."
echo 'If not, reboot it manually by selecting "Reboot" in bootloader'
echo "with volume keys and confirm with power button."
echo "Continue when the device has rebooted."
read -p "Press enter to continue..." cont
echo "Turn on USB debugging again since all data was lost when the device was unlocked"
sudo ./adb devices
echo "Continue if you see your device in list above."
read -p "Press enter to continue..." cont
sudo ./adb reboot bootloader
echo "Continue when your device is in Fastboot mode."
read -p "Press enter to continue..." cont
sudo ./fastboot devices
echo "Continue if you see your device in list above."
read -p "Press enter to continue..." cont
echo "Look at the last line on your devices screen."
echo 'If the last line is "Lock State : Unlocked", you can continue.'
read -p "Press enter to continue..." cont
flashrecovery
}

function fastboot {
echo "Turn on your device and activate USB debuging in Developers Options."
read -p "Press enter to continue..." cont
sudo ./adb devices
echo "Continue if your device is listed."
read -p "Press enter to continue..." cont
sudo ./adb reboot bootloader
echo "Continue when your device is in Fastboot mode."
read -p "Press enter to continue..." cont
sudo ./fastboot devices
echo "Continue if you see your device in list above."
read -p "Press enter to continue..." cont
recovery
}

function recovery {
echo "Have you flashed a custom recovery (Select NO if unsure)?"
echo "1 -- YES"
echo "2 -- NO"
choix="Notset"
echo -n "Type 1 or 2: "
read choix
if [ $choix == "1" ]
then
	flash
elif [ $choix == "2" ]
then
	flashrecovery
else
	echo "Invalid  choice. Type only 1 or 2."
	recovery
fi
}

function flashrecovery {
echo "Continue to flash custom recovery"
read -p "Press enter to continue..." cont
echo "Flashing recovery.img..."
sudo ./fastboot flash recovery recovery.img
echo "If the flash was successful you can continue"
read -p "Press enter to continue..." cont
flash
}

function flash {
echo "Now booting to recovery"
sudo ./fastboot boot recovery.img
choice
}

function choice {
echo "Root only or CyanogenMod ?"
echo "1 -- CyanogenMod (Root included)"
echo "2 -- Rooting only"
choix="Notset"
echo -n "Type 1 or 2: "
read choix
if [ $choix == "1" ]
then
	cyanogen
elif [ $choix == "2" ]
then
	rooting
else
	echo "Invalid  choice. Type only 1 or 2."
	choice
fi
}

function rooting {
echo So you don't want to flash CyanogenMod ? No problem , this is your choice ;)
read -p "Press enter to continue..." cont
sudo ./adb devices
echo "Continue if you see your device listed above."
read -p "Press enter to continue..." cont
sudo ./adb sideload superuser.zip

function cyanogen {
echo "With your recovery, wipe Data, Cache and Dalvik Cache (Under andvanced options) and then start the ADB sideload mode and continue."
read -p "Press enter to continue..." cont
sudo ./adb devices
echo "Continue if you see your device listed above."
read -p "Press enter to continue..." cont
echo "Flashing cm.zip"
sudo ./adb sideload cm.zip
gappschoice
}

function gappschoice {
echo "Do you want to flash Google Apps?"
echo "1 -- YES"
echo "2 -- NO"
choix="Notset"
echo -n "Type 1 or 2: "
read choix
if [ $choix == "1" ]
then
	if [ ! -f gapps.zip ]
	then
		echo "gapps.zip is missing."
		echo "Please place it in the same directory with this file and continue."
		read -p "Press enter to continue..." cont
		gappschoice
	fi
	flashgapps
elif [ $choix == "2" ]
then
	finish
else
	echo "Invalid  choice. Type only 1 or 2."
	gappschoice
fi
}

function flashgapps {
echo "If You got out of ADB sideload mode after the first zip flashed successfully restart sideload mode and continue"
read -p "Press enter to continue..." cont
echo "Flashing gapps.zip"
sudo ./adb sideload gapps.zip
finish
}

function finish {
echo "COOL! CyanogenMod has been flashed! :)"
echo "Continue to reboot the device."
read -p "Press enter to continue..." cont
sudo ./adb reboot
echo "Enjoy your new shiny custom ROM!"
read -p "Press enter to continue..." cont
exit
}

start

