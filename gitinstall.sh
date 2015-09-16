#!/usr/bin/env bash

# Envisioned workload:
#  1.  Create a new development direcotry: 'mkdir Gadgetron'
#  2.  git clone <git-url> to get contents of what is now Tools/pyinstall/
#  3.  execute 'pyinstall/gitinstall.sh'
#  4.  Update your PATH (this script prints out the command you should execute)

#  You should have all the gadgetron tools in 'Gadgetron/' ready for your hacking/committing etc.  All dependencies should be properly tracked and installed a private virtualenv.

GADGETRON_ROOT=$1
shift

if [ ".$GADGETRON_ROOT" = "." ]; then
    GADGETRON_ROOT=$PWD
fi

VENV=$GADGETRON_ROOT/python_venv


#third_party_packages="jinja2" #cython lxml pypng beautifulsoup4 requests svgwrite Mako clang bintrees numpy jinja2 Sphinx asciitree"
#third_party_packages="cython lxml pypng beautifulsoup4 requests svgwrite Mako clang bintrees numpy jinja2 Sphinx asciitree"

gadgetron_packages="test-Swoop test-Koala2"

virtualenv $VENV
VENV=$(cd $GADGETRON_ROOT/python_venv; pwd -P) # get the canonical path

PATH=$VENV/bin:$PATH

#pip install $third_party_packages

for p in $gadgetron_packages; do
    git clone http://146.148.85.41/swanson/${p}.git
    (cd $p; python setup.py develop)
done

echo PATH=$VENV/bin:\$PATH
