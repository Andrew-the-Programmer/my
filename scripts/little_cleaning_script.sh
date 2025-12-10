!/bin/bash

# https://forums.linuxmint.com/viewtopic.php?f=213&t=250801
 
OLDCONF=$(dpkg -l|grep "^rc"|awk '{print $2}')
CURKERNEL=$(uname -r|sed 's/-*[a-z]//g'|sed 's/-386//g')
LINUXPKG="linux-(image|headers|ubuntu-modules|restricted-modules)"
METALINUXPKG="linux-(image|headers|restricted-modules)-(generic|i386|server|common|rt|xen)"
OLDKERNELS=$(dpkg -l|awk '{print $2}'|grep -E $LINUXPKG |grep -vE $METALINUXPKG|grep -v $CURKERNEL)

# Standard Bash Color definitions
LIGHT_RED="\e[91m"
LIGHT_GREEN="\e[92m"
LIGHT_YELLOW="\e[93m"
REVERSE_RED="\e[101m"
DEFAULT="\e[39m"

clear
echo -e $LIGHT_RED"**********************************"$DEFAULT
echo -e $LIGHT_RED"*** Start Cleaning MyLinuxMint ***"$DEFAULT
echo -e $LIGHT_RED"**********************************"$DEFAULT

 
if [ $USER != root ]; then
  echo -e $REVERSE_RED"Error: must be root"
  echo -e $REVERSE_RED"Exiting..."$DEFAULT
  exit 0
fi

echo -e
echo -e $LIGHT_GREEN"Cleaning apt cache..."$DEFAULT
aptitude -v clean

echo -e
echo -e $LIGHT_GREEN"Removing old config files..."$DEFAULT
sudo aptitude -v purge $OLDCONF
 
echo -e 
echo -e $LIGHT_GREEN"Removing old kernels..."$DEFAULT
sudo aptitude -v purge $OLDKERNELS

echo -e
echo -e $LIGHT_GREEN"Removing thumbnails..."$DEFAULT
rm -v -f ~/.cache/thumbnails/*/*.png ~/.thumbnails/*/*.png
rm -v -f ~/.cache/thumbnails/*/*/*.png ~/.thumbnails/*/*/*.png

echo -e
echo -e $LIGHT_GREEN"Removing logfiles..."$DEFAULT
sudo rm -r -v -f /var/log/* 
 
echo -e
echo -e $LIGHT_GREEN"Removing Temporary Files ..."$DEFAULT
rm -r -v -f /tmp/* &> /dev/null

echo -e
echo -e $LIGHT_GREEN"Removing Browser & Mail Cache (Chromium & FireFox, Evolution) ..."$DEFAULT
rm -r -v -f ~/.cache/chromium
rm -r -v -f ~/.cache/mozilla
rm -r -v -f ~/.cache/evolution

echo -e 
echo -e $LIGHT_YELLOW"Emptying the Trash Can using the Trash-cli utility ..."$DEFAULT
trash-empty 

echo -e
echo -e $LIGHT_RED"***********************"$DEFAULT
echo -e $LIGHT_RED"*** End-Of-Cleaning ***"$DEFAULT
echo -e $LIGHT_RED"***********************"$DEFAULT
echo -e
