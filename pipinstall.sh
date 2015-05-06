#!/usr/bin/env bash

dependencies="cython lxml pypng beautifulsoup4 requests svgwrite Mako clang bintrees numpy jinja2 Sphinx asciitree"

if [ "$USER." = "swanson." ]; then
    virtualenv $GADGETRON_ROOT/Python
    pip install $dependencies
fi

site_packages=`python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`

if [ -w "$site_packages" ] 
then
    pip install $dependencies
else
    sudo pip install $dependencies
fi



