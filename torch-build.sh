#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
bash $SCRIPT_DIR/pytorch-build.sh

source $SCRIPT_DIR/torch-common.sh

pip uninstall -y functorch torchvision torchtext torchaudio torchdata

export BUILD_SOX=0

cd ~/git/
rm -rf torch-vision/build

(cd torch-data && python setup.py install)
(cd torch-text && python setup.py install)
(cd torch-vision && python setup.py install)
(cd torch-audio && python setup.py install)
#pip install -e ./huggingface_transformers --no-build-isolation
