#!/usr/bin/env bash

# Envisioned workload:
#  1.  Create a new development direcotry: 'mkdir Gadgetron'
#  2.  git clone git@github.com:NVSL/gadgetron-setup.git
#  3.  execute 'gadgetron-setup/gitinstall.sh'
#  4.  Update your PATH (this script prints out the command you should execute)

#  You should have all the gadgetron tools in 'Gadgetron/' ready for your hacking/committing etc.  All dependencies should be properly tracked and installed a private virtualenv.

GADGETRON_ROOT=$1
shift

if [ ".$GADGETRON_ROOT" = "." ]; then
    GADGETRON_ROOT=$PWD
fi

if [ ".$USE_VENV" != "." ]; then
    
    if [ ".$PYTHON_ENV" = "." ]; then
	PYTHON_ENV=$GADGETRON_ROOT/python_venv
    fi


    if ! [ -e $PYTHON_ENV/bin/python ]; then
	rm -rf $PYTHON_ENV
	virtualenv $PYTHON_ENV
    fi

    #PYTHON_ENV=$(cd $GADGETRON_ROOT/python_venv; pwd -P) # get the canonical path

    PATH=$PYTHON_ENV/bin:$PATH
fi

packages="BOBBuilder gadgetron-vm-util" #test-Swoop test-Koala2"

for p in $packages; do
    if [ -e $p ]; then
	(cd $p; git pull)
    else
	git clone git@github.com:NVSL/$p.git
    fi
    
    if [ -e $p/Makefile ]; then
	(cd $p; make)
    fi
done

if [ ".$USE_VENV" != "." ]; then
    echo PATH=$PYTHON_ENV/bin:\$PATH
fi

