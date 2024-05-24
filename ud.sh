#! /bin/bash
#
# This is the autoupdate script for Arch-based distributions.
#
clear
echo -e  '\e[5m\e[34mAuthor: Ranjeev Grewal\e[0m'
echo
# note: to use pacman, simply replace yay with pacman, with a sudo beginning the command
yay -Syu --cleanafter #apparently using 2 y's forces a complete system update
##
echo
#
# NOTE: the color comes just from the \e[93m bit. There are other color codes online at the URL below:
#
#  https://misc.flogisoft.com/bash/tip_colors_and_formatting
#
echo
echo -e "The update operation has completed successfully. \e[93mKhattam :)\e[0m" 
#
#
###############################################################################################
