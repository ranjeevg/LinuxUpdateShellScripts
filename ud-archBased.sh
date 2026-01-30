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

# asking if the user wants to update the keyring too 
read -p "Do you want to update the arch linux keyring before beginning your system upgrade (y/N)?" refreshKeyring;

-- keep going until the user enters a valid answer
while [[true]];
do
	if [[ $refreshKeyring == 'Y' || $refreshKeyring == 'y' ]]
	then
	RefreshKeyringString = "(chosen to update keyring. Please note that the process involves a regular update, which will begin now.)";
	break;
	elif [[$refreshKeyring == 'N' || $refreshKeyring == 'n'];]
	RefreshKeyringString = "(proceeding without updating keyring)";
	break;
	else
	RefreshKeyringString = "(invalid choice, please try again.)";
	echo;
	fi

done

echo
echo $RefreshKeyringString;

if [[ $refreshKeyring == 'Y' || $refreshKeyring == 'y' ]]
	then
	sudo pacman -Sy archlinux-keyring && sudo pacman -Su;
fi

echo 'Refreshing the keyring:'
sleep 1

# can easily be modified for package manager of choice

if [[ $updateChoice == 'r' || $updateChoice == 'R' ]];
	then 
	echo
	# perhaps reword it to sound friendlier later?
	echo "Your requested keyring refresh needed to perform a regular system update as part of the process. This has already been done."
	echo
elif [[ $updateChoice == 'c' || $updateChoice == 'C' ]];
	then
	sudo pacman -Syyu
fi