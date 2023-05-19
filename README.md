# Compiling PyTorch

If you don't have gcc, g++, install them from apt-get.
If you want to go the extra mile, you can install gcc-9, g++-9, as these are the ones that are the versions used in CI (as of this writing). For example, I did
```bash
sudo add-apt-repository ppa:ubuntu-toolchain-r/test
sudo apt update
sudo apt install gcc-9 g++-9
sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 60 --slave /usr/bin/g++ g++ /usr/bin/g++-9 --slave /usr/bin/cc cc /usr/bin/gcc-9 --slave /usr/bin/c++ c++ /usr/bin/g++-9
```

Install the Nvidia drivers from https://www.nvidia.com/download/index.aspx

Then create the conda environment
```bash
conda env create -f pytorch-dev.yaml
```

Have a read through `torch-build.sh` and `pytorch-build.sh` and change them as desired.
Finally, running `torch-clone.sh` and `torch-build.sh` should give you a working torchbench installation.
If you are just working on PyTorch, probably `pytorch-build.sh` is what you want.


# Running torchbench

Without making some of the following changes, benchmarks you run can be highly unstable, varying as much as 10% from run to run, even if you are running each benchmark multiple times. Note that you require root to be able to enact most of them.

In the `torchbench` repo there is a script to do the configuration for a specific AWS instance that the Meta team uses for the benchmarks (g4dn.metal). You can run it with the command

```
sudo $(which python) torchbenchmark/util/machine_config.py --configure
```

Unfortunately, this is unlikely to work if you use other machines and you'll have to do the steps manually.

## GPU benchmarks

Here the main thing is to set the GPU clock frequency to a fixed value. Without this it might be scaling in response to workload. You need `nvidia-smi` installed. For A100 GPU the correct command is:

`sudo nvidia-smi -ac 1215,1410`

For other GPUs, the numbers in last argument will vary. You can check
[this AWS page](https://docs.amazonaws.cn/en_us/AWSEC2/latest/UserGuide/optimize_gpu.html) for combinations for a few different GPU models.

Note that you may need to rerun this command every time the machine is rebooted, unless you enable option persistance with

`sudo nvidia-smi --persistence-mode=1`

## CPU benchmarks

You need to:

1. Disable hyperthreading. Look at what the `set_hyper_threading` function in the `torchbenchmark/util/machine_config.py` does.
2. Disable Turbo Boost. The CPU might not have it, if the directory `/sys/devices/system/cpu/intel_pstate` does not exist, no need to do anything. If it does exist, look at `set_intel_no_turbo_state` and `set_pstate_frequency` in `machine_config.py`.
3. Set Intel c-state to 1. You need to edit `/etc/default/grub` and add `intel_idle.max_cstate=1` to the `GRUB_CMDLINE_LINUX_DEFAULT` variable. Then run `sudo update-grub` and reboot.
3. CPU core isolation. This might not be strictly necessary if you can make sure there are no other processes running in the machine when running the benchmarks. The idea is to tell the OS not use some CPU cores at all unless they are specifically requested by `taskset`. Note that if you do this it will make all other workflows (such as compilation) slower since they will have less cores they can use.  To do this follow the same steps as in previous point but instead of `intel_idle.max_cstate=1` add `isolcpus=6-11` where `6-11` is the range of cores you want to isolate.
