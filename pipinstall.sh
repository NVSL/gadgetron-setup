#!/usr/bin/env bash

dependencies="lxml pypng beautifulsoup4 requests svgwrite Mako clang bintrees numpy jinja2 Sphinx asciitree"

site_packages=`python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`
if [ -w "$site_packages" ] 
then
    pip install $dependencies
else
    sudo pip install $dependencies
fi



