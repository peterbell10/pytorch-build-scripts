#!/bin/bash

cd ~/git

source torch-common.sh
pip uninstall -y torch functorch torchvision torchtext torchaudio torchdata

export BUILD_SOX=0
rm -rf ~/git/torch-vision/build

(cd pytorch && python setup.py develop)
(cd torch-data && python setup.py install)
(cd torch-text && python setup.py install)
(cd torch-vision && python setup.py install)
(cd torch-audio && python setup.py install)
#pip install -e ./huggingface_transformers --no-build-isolation
