#!/bin/bash

mkdir ~/bin
PATH=~/bin:$PATH
curl http://commondatastorage.googleapis.com/git-repo-downloads/repo > ~/bin/repo &&chmod a+x ~/bin/repo
chmod a+x ~/bin/repo

ln -s /usr/bin/python2 ~/bin/python
ln -s /usr/bin/python2-config ~/bin/python-config

rm -rf /home/$USER/Desktop/ClickHereFirst.desktop
