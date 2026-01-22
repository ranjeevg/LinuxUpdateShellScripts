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
		UpdateType="conservative upgrade"
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

# reusing our good friends $UpdateChoice and $UpdateType
# the main purpose is to verify if the user wants to refresh the keyring

echo 'Refreshing the keyring:'
pacman -Sy archlinux-keyring
sleep 1

# can easily be modified for package manager of choice

if [[ $updateChoice == 'r' || $updateChoice == 'R' ]];
	then 
	sudo pacman -Syu
elif [[ $updateChoice == 'c' || $updateChoice == 'C' ]];
	then
	sudo pacman -Syyu
fi