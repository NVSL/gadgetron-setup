#!/usr/bin/env bash

DIR=$1  # Directory in our svn you want to import
GIT=$2  # name of git repo on our gitlab server (you need to create this ahead of time. it should be empty)

echo $DIR
echo $GIT

if [ ".$DIR" = "." -o ".$GIT" = "." ]; then
   echo "usage: svn2git.sh <path relative to svn+ssh://bbfs-01.calit2.net/grw/Gordon/svn/trunk/Gadgets> <GIT repo name>"
   exit 0
fi 

GITREPO=git@github.com:NVSL/$2.git

echo Checking out svn+ssh://bbfs-01.calit2.net/grw/Gordon/svn/trunk/Gadgets/$1 from svn, and moving it to $GETREPO
echo If $GITREPO does not exist, this will fail.

echo git svn clone --authors-file=$GADGETRON_ROOT/Tools/pyinstall/names.mapped svn+ssh://bbfs-01.calit2.net/grw/Gordon/svn/trunk/Gadgets/$DIR
echo cd $(echo $DIR| perl -ne '@a =split("/"); print "$a[-1]"')
echo git remote add origin $GITREPO
echo git push -u origin master
