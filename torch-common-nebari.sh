#!/bin/bash

# CUDA
export USE_CUDA=1
export TORCH_CUDA_ARCH_LIST="8.0"                 # A100. Set to 7.5 for qgpu
# Faster recompilation
export USE_PRECOMPILED_HEADERS=1
export USE_PER_OPERATOR_HEADERS=1
export CCACHE_COMPRESS=true
export CCACHE_SLOPPINESS=pch_defines,time_macros  # Necessary for precompiled headers
# General utils
export USE_KINETO=1                               # profiler
export USE_CUDNN=1                                # CNNs
export USE_FBGEMM=1                               # GEMMs
# Don't build what we don't need
export BUILD_TEST=0                               # C++ tests
export BUILD_CAFFE2=0                             # caffe2
export BUILD_CAFFE2_OPS=0                         # caffe2
export USE_DISTRIBUTED=0                          # distributed
export USE_NCCL=0                                 # distributed
export USE_GLOO=0                                 # distributed
export USE_XNNPACK=0                              # quantized


# Specific to installing nvidia-toolkit and gcc via conda
export CMAKE_PREFIX_PATH=$CONDA_PREFIX
export CMAKE_C_COMPILER_LAUNCHER=ccache
export CMAKE_CXX_COMPILER_LAUNCHER=ccache
export CMAKE_CUDA_COMPILER_LAUNCHER=ccache
export CMAKE_CXX_COMPILER=$CONDA_PREFIX/bin/g++
export CMAKE_C_COMPILER=$CONDA_PREFIX/bin/gcc
export CMAKE_AR=$CONDA_PREFIX/bin/gcc-ar
export CUDA_PATH=$CONDA_PREFIX
export CUDA_HOME=$CUDA_PATH
export CMAKE_CUDA_COMPILER=$CUDA_PATH/bin/nvcc

export MAX_JOBS=${MAX_JOBS:-95}
export CMAKE_BUILD_TYPE=Release
# RelWithDebInfo gives you line numbers on gdb, but makes the symbol loading phase slower.
# It also makes the linking phase noticeably slower
# export CMAKE_BUILD_TYPE=RelWithDebInfo
