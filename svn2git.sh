#!/usr/bin/env bash

DIR=$1
GIT=$2
shift
shift

echo Checking out $1 from svn, and moving it to git@146.148.85.41:$USER/$GIT.git
echo If git@146.148.85.41:$USER/$GIT.git does not exist, this will fail.

git svn clone --authors-file=names.mapped svn+ssh://bbfs-01.calit2.net/grw/Gordon/svn/trunk/Gadgets/$DIR
cd $DIR
git remote add origin git@146.148.85.41:$USER/$GIT.git
git push -u origin master
