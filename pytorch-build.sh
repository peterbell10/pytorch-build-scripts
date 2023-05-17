#!/bin/bash
set -e

eval "$(conda shell.bash hook)"
conda activate pytorch-dev
cd ~/git/pytorch


source ./torch-common.sh

pip uninstall torch -y
python setup.py develop $@

# comment out if you're developing triton as well
make triton
