#!/usr/bin/env bash

# Install the non-python dependencies
if command -v apt-get; then
    sudo apt-get install cython python-lxml libspatialindex-dev python-pygame npm swig libpython-dev libcgal-dev
elif command -v brew; then
    brew install cgal swig
elif command -v port; then
    sudo port install cgal swig swig-python
fi

dependencies="cython lxml pypng beautifulsoup4 requests svgwrite Mako clang bintrees numpy jinja2 Sphinx asciitree cgal-bindings"

if [ "$USE_VENV." = "yes." ]; then
    echo Using a virtual environment
    virtualenv $GADGETRON_ROOT/Python
    pip install $dependencies
    pip install -r $GADGETRON_ROOT/Tools/CbC/requirements.txt
    exit;
fi

site_packages=`python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`

if [ -w "$site_packages" ] 
then
    pip install $dependencies
    pip install -r $GADGETRON_ROOT/Tools/CbC/requirements.txt
else
    sudo pip install $dependencies
    sudo pip install -r $GADGETRON_ROOT/Tools/CbC/requirements.txt
fi

