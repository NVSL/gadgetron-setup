#!/usr/bin/env bash

DIR=$1  # Directory in our svn you want to import
GIT=$2  # name of git repo on our gitlab server (you need to create this ahead of time. it should be empty)

echo Checking out $1 from svn, and moving it to git@146.148.85.41:$USER/$GIT.git
echo If git@146.148.85.41:$USER/$GIT.git does not exist, this will fail.

git svn clone --authors-file=names.mapped svn+ssh://bbfs-01.calit2.net/grw/Gordon/svn/trunk/Gadgets/$DIR
cd $DIR
git remote add origin git@146.148.85.41:$USER/$GIT.git
git push -u origin master
