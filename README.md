# Instructions

If you don't have gcc, g++, install them from apt-get.
If you want to go the extra mile, you can install gcc-9, g++-9, as these are the ones that are the versions used in CI (as of this writing). For example, I did
```bash
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt update
sudo apt install gcc-9 g++-9
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 60 --slave /usr/bin/g++ g++ /usr/bin/g++-9 --slave /usr/bin/cc cc /usr/bin/gcc-9
```

Install the nvidia drivers from https://www.nvidia.com/download/index.aspx

Then create the conda env
```bash
conda env create -f pytorch-dev.yaml
```

Have a read through `torch-build.sh` and `pytorch-build.sh` and change them as desired.
Finally, running `torch-clone.sh` and `torch-build.sh` should give you a working torchbench installation.
If you are just working on PyTorch, probably `pytorch-build.sh` is what you want.
