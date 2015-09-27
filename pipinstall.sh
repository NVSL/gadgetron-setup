#!/usr/bin/env bash

# Install the non-python dependencies
if command -v apt-get; then
    echo Updating system packages
    sudo apt-get -y install python-pip libspatialindex-dev python-pygame libcgal-dev swig inkscape arduino curl nodejs npm subversion emacs git cython python-lxml libspatialindex-dev python-pygame npm swig libpython-dev libcgal-dev libxml2
elif command -v brew; then
    brew install cgal swig
elif command -v port; then
    sudo port install cgal swig swig-python
fi

dependencies="cython lxml pypng beautifulsoup4 requests svgwrite Mako clang bintrees numpy jinja2 Sphinx asciitree cgal-bindings rtree pyparsing"

sudo pip install virtualenv

# this is necessary on unbuntu, it seems.
export CPATH=/usr/include/libxml2

if [ "$USE_VENV." = "yes." ]; then
    echo Using a virtual environment
    virtualenv $GADGETRON_ROOT/Python
    pip install $dependencies
    pip install -r $GADGETRON_ROOT/Tools/CbC/requirements.txt
else

    site_packages=`python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())"`

    if [ -w "$site_packages" ] 
    then
	pip install $dependencies
	pip install -r $GADGETRON_ROOT/Tools/CbC/requirements.txt
    else
	sudo pip install $dependencies
	sudo pip install -r $GADGETRON_ROOT/Tools/CbC/requirements.txt
    fi
fi

cd ..
if [ -e gadgetron-setup ]; then
    (cd gadgetron-setup; git pull)
else
    git clone git@github.com:NVSL/gadgetron-setup.git
fi

gadgetron-setup/gitinstall.sh $GADGETRON_ROOT
