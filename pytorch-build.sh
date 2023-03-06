#!/bin/bash
set -e

eval "$(conda shell.bash hook)"
conda activate pytorch-dev
cd ~/git/pytorch

source ~/git/torch-common.sh

pip uninstall torch -y
python setup.py develop $@
