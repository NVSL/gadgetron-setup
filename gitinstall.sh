#!/usr/bin/env bash

# Envisioned workload:
#  1.  Create a new development direcotry: 'mkdir Gadgetron'
#  2.  git clone git@146.148.85.41:swanson/test-pyinstall.git
#  3.  execute 'pyinstall/gitinstall.sh'
#  4.  Update your PATH (this script prints out the command you should execute)

#  You should have all the gadgetron tools in 'Gadgetron/' ready for your hacking/committing etc.  All dependencies should be properly tracked and installed a private virtualenv.

GADGETRON_ROOT=$1
shift

if [ ".$GADGETRON_ROOT" = "." ]; then
    GADGETRON_ROOT=$PWD
fi

if [ ".$PYTHON_ENV" = "." ]; then
    PYTHON_ENV=$GADGETRON_ROOT/python_venv
fi


if ! [ -e $PYTHON_ENV/bin/python ]; then
    rm -rf $PYTHON_ENV
    virtualenv $PYTHON_ENV
fi

PYTHON_ENV=$(cd $GADGETRON_ROOT/python_venv; pwd -P) # get the canonical path

PATH=$PYTHON_ENV/bin:$PATH

packages="test-Swoop test-Koala2"

for p in $packages; do
    git clone ssh://git@146.148.85.41/swanson/${p}.git
    (cd $p; python setup.py develop)
done

echo PATH=$PYTHON_ENV/bin:\$PATH

