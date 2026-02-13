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
echo 'Email : ranjeev.grewal1349@gmail.com'
echo -e '\e[0m';
echo

# to keep the option-choosing going if the user types in something that isn't recognized
while [[ true ]];
do

	#read user input
	read -p "Please press 'a' for a regular upgrade, or 'd' for a dist-upgrade: " updateChoice;

	# setting the variable and exiting the loop accordingly
	if [[ $updateChoice == 'a'  || $updateChoice == 'A' ]] ;
		then 
		UpdateType="regular upgrade"
		break
	elif [[ $updateChoice == 'd' || $updateChoice == 'D' ]];
		then 
		UpdateType="comprehensive 'dist-upgrade'"
		break
	else
		echo "Invalid response. Please try again: ";
	fi
done

echo "OK. Updating packagelist before proceeding with a $UpdateType:";
sleep 1

# apt needs a repo update for both scenarios
sudo apt update;

# upgrade or dist-upgrade based on user selection

if [[ $updateChoice == 'a' || $updateChoice == 'A' ]];
	then 
	sudo apt upgrade
elif [[ $updateChoice == 'd' || $updateChoice == 'D' ]];
	then
	sudo apt dist-upgrade
fi