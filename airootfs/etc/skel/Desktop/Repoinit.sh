#!/bin/bash

mkdir ~/bin
PATH=~/bin:$PATH
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo &&chmod a+x ~/bin/repo
chmod a+x ~/bin/repo

yaourt -S --noconfirm android-sdk 
yaourt -S --noconfirm android-sdk-platform-tools

