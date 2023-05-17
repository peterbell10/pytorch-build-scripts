#!/bin/bash

bash ./pytorch-build.sh

source ./torch-common.sh

pip uninstall -y functorch torchvision torchtext torchaudio torchdata

export BUILD_SOX=0

cd ~/git/
rm -rf torch-vision/build

(cd torch-data && python setup.py install)
(cd torch-text && python setup.py install)
(cd torch-vision && python setup.py install)
(cd torch-audio && python setup.py install)
#pip install -e ./huggingface_transformers --no-build-isolation
