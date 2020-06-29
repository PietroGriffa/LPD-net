#!/usr/bin/env bash

# The first and only argument should be the python version.
PYTHON_VERSION=$1

# Check compatible python version.
if [ 1 -eq "$(echo "${PYTHON_VERSION} < 3.6" | bc)" ]; then
  echo "Warning: Python version >= 3.6 reccomended"
fi

# Find correct python location
if [ -e "/usr/bin/python$PYTHON_VERSION" ];
then
  python_path=/usr/bin/python$PYTHON_VERSION
  echo $python_path
elif [ -e "/usr/local/bin/python$PYTHON_VERSION" ]
then
  python_path=/usr/local/bin/python$PYTHON_VERSION
  echo $python_path
else
  echo "ERROR: specified version of Python is not available."
fi

if [ -z "$python_path" ]
then
  echo "ERROR: Impossible to setup virtual environment."
else
  echo "--> Python OK"

  # Create virtual environment
  echo " "
  if [ ! -e "./pt_venv" ]; then
    echo "Creating virtual environment"
    echo "-------------------------------------"
    virtualenv -p $python_path ./th_venv
    echo "-------------------------------------"
  fi
  source ./th_venv/bin/activate
  echo " "
  echo "Installing dependecies"
  pip install -r ../requirements.txt
  echo "-------------------------------------"
  echo "ALL DONE"
  echo "Type 'deactivate' to deactivate"
fi
