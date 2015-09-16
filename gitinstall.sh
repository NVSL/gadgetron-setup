#!/usr/bin/env bash

GADGETRON_ROOT=$1
shift

if [ ".$GADGETRON_ROOT" = "." ]; then
    GADGETRON_ROOT=$PWD/".."
fi

VENV=$GADGETRON_ROOT/python_venv


third_party_packages="jinja2" #cython lxml pypng beautifulsoup4 requests svgwrite Mako clang bintrees numpy jinja2 Sphinx asciitree"
#third_party_packages="cython lxml pypng beautifulsoup4 requests svgwrite Mako clang bintrees numpy jinja2 Sphinx asciitree"

gadgetron_packages="test-Swoop test-Koala2"

virtualenv $VENV
VENV=$(cd $GADGETRON_ROOT/python_venv; pwd -P) # get the canonical path

PATH=$VENV/bin:$PATH

pip install $third_party_packages

for p in $gadgetron_packages; do
    pip install git+http://146.148.85.41/swanson/${p}.git
done

echo PATH=$VENV/bin:\$PATH
