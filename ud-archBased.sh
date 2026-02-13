#!/bin/bash

###################################################################################################################################################
# Ask user whether they want to perform a dist-upgrade (updates packages 
# while potentially installing new ones/uninstalling incompatible ones)
# or a regular upgrade (only updates packages that already have required packages 
# installed; regular upgrade won't touch already-installed apps)
#
# Source: https://unix.stackexchange.com/a/748003
##################################################################################################################################################

clear;
echo -e '\e[5m\e[34m'
echo 'Author: Ranjeev Grewal'
echo 'Email : ranjeev.grrewal1349@gmail.com'
echo -e '\e[0m'
echo

# to keep the option-choosing going if the user types in something that isn't recognized
while [[ true ]];
do

	#read user input
	read -p "Please press 'r' for a regular upgrade, or 'c' for a comprehensive upgrade  : " updateChoice;

	# setting the variable and exiting the loop accordingly
	if [[ $updateChoice == 'r'  || $updateChoice == 'R' ]] ;
		then 
		UpdateType="regular upgrade"
		break
	elif [[ $updateChoice == 'c' || $updateChoice == 'C' ]];
		then 
		UpdateType="comprehensive upgrade"
		break
	else
		echo "Invalid response. Please try again: ";
		echo
	fi
done

echo "OK. Proceeding with a $UpdateType:";
sleep 1

# keep going until the user enters a valid answer
while [[ true ]];
do
	# asking if the user wants to update the keyring too 
	read -p "Do you want to update the Arch Linux keyring before beginning your system upgrade (y/n)?  " refreshKeyring;
	
	if [[ $refreshKeyring == 'Y' || $refreshKeyring == 'y' ]]
		then
		RefreshKeyringString="(chosen to update keyring. Please note that the process involves a regular update, which will begin now.)";
		break;
	elif [[ $refreshKeyring == 'N' || $refreshKeyring == 'n' ]];
		then
		RefreshKeyringString="(proceeding without updating keyring)";
		break;
	else
		RefreshKeyringString="(invalid choice, please try again.)";
	fi

	echo $RefreshKeyringString;

done

if [[ $refreshKeyring == 'Y' || $refreshKeyring == 'y' ]]
	then
	echo 'Refreshing the keyring:'
	sleep 1
	sudo pacman -Sy archlinux-keyring && sudo pacman -Su;
fi

# can easily be modified for package manager of choice

if [[ $updateChoice == 'r' || $updateChoice == 'R' ]];
	then 
	if [[ $refreshKeyring == 'Y' || $refreshKeyring == 'y' ]];
		then
		echo
		echo "Your requested keyring refresh needed to perform a regular system update as part of the process. This has already been done."
		echo
	else
		echo
		echo "Performing regular update now."
		sleep 1.5
		sudo pacman -Syu
	fi
elif [[ $updateChoice == 'c' || $updateChoice == 'C' ]];
	then
	echo
	echo "Performing comprehensive upgrade now."
	echo
	sleep 1.5
	sudo pacman -Syyu
fi