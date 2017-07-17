#!/bin/bash

 CL_BLU="\033[34m"
 CL_RST="\033[0m"

echo -e ${CL_BLU}"    _____     ______    _____       __     __  ${CL_BLU}";
echo -e ${CL_BLU}"   / ___ \   (____  )  (_   _)     (_ \   / _) ${CL_BLU}";
echo -e ${CL_BLU}"  / /   \_)      / /     | |         \ \_/ /   ${CL_BLU}";
echo -e ${CL_BLU}" ( (  ____   ___/ /_     | |          \   /    ${CL_BLU}";
echo -e ${CL_BLU}" ( ( (__  ) /__  ___)    | |   __     / _ \    ${CL_BLU}";
echo -e ${CL_BLU}"  \ \__/ /    / /____  __| |___) )  _/ / \ \_  ${CL_BLU}";
echo -e ${CL_BLU}"   \____/    (_______) \________/  (__/   \__) ${CL_RST}";
echo "GZLx build environment finalizer. Internet connection required! Make sure all steps are completed.";

while true
do 
  PS3='Select options in order:'
  options=("Create Needed Symlinks" "Get Android SDK" "Set Global Name" "Set Global Email" "Quit")
  select opt in "${options[@]}"
do
    case $opt in
     "Create Needed Symlinks")
        echo "Installing repo and symlinking python2.";
        mkdir ~/bin
        PATH=~/bin:$PATH
        curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo &&chmod a+x  ~/bin/repo
        chmod a+x ~/bin/repo
        ln -s /usr/bin/python2 ~/bin/python
        ln -s /usr/bin/python2-config ~/bin/python-config
        clear 
        break;
        ;;
     "Get Android SDK")
        echo "Downloading and installing Android-SDK.";
        yaourt -S android-sdk --noconfirm
        yaourt -S android-sdk-platform-tools --noconfirm
        clear 
        break;
        ;;
    "Set Global Name")
        export username="$1"
        if [ -z $username ];
        then
        echo -e "Please enter a username"
        read username
        fi
        git config --global user.name "${username}"
        echo "Done.";
        sleep 1
        clear 
        break;
        ;;
    "Set Global Email")
        export username="$1"
        if [ -z $username ];
        then
        echo -e "Please enter your git email"
        read username
        fi
        git config --global user.email "${username}"
        echo "Done.";
        sleep 1
        clear 
        break;
        ;;
     "Quit")
        exit 
        ;;
        *) echo invalid option;;
    esac
done
done
