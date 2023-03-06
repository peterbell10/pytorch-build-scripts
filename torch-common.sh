#!/bin/bash
set -e

eval "$(conda shell.bash hook)"
conda activate pytorch-dev

export CCACHE_COMPRESS=true
export CCACHE_SLOPPINESS=pch_defines,time_macros

#export CMAKE_EXE_LINKER_FLAGS="-B $HOME/git/mold -Wl,--threads=1"
#export CMAKE_SHARED_LINKER_FLAGS="-B $HOME/git/mold -Wl,--threads=1"
export USE_GOLD_LINKER=0

export BUILD_TEST=0
export BUILD_CAFFE2=0
export BUILD_CAFFE2_OPS=0
export USE_CUDA=1
export USE_XNNPACK=1
export USE_KINETO=0
export USE_DISTRIBUTED=1
export USE_NCCL=0
export USE_GLOO=0
export USE_CUDNN=0
export USE_PRECOMPILED_HEADERS=1
export USE_PER_OPERATOR_HEADERS=1
export USE_CUPTI_SO=1
export USE_FBGEMM=1
export TORCH_CUDA_ARCH_LIST="8.0"
export WERROR=0

#export ATEN_STATIC_CUDA=1
#export USE_CUDA_STATIC_LINK=1

#export GCCVERSION=9
#export CMAKE_CXX_FLAGS="-isystem=/usr/include/c++/$GCCVERSION;-isystem=/usr/lib/gcc/$HOST/$GCCVERSION/include"

export CMAKE_PREFIX_PATH=$CONDA_PREFIX
export MAX_JOBS=${MAX_JOBS:-8}
export CMAKE_C_COMPILER_LAUNCHER=ccache
export CMAKE_CXX_COMPILER_LAUNCHER=ccache
export CMAKE_CUDA_COMPILER_LAUNCHER=ccache
export CMAKE_CXX_COMPILER=$CONDA_PREFIX/bin/g++
export CMAKE_C_COMPILER=$CONDA_PREFIX/bin/gcc
export CUDA_PATH=/usr/local/cuda-11.7
export CUDA_HOME=$CUDA_PATH
export CMAKE_CUDA_COMPILER=$CUDA_PATH/bin/nvcc

export USE_TSAN=0
export CMAKE_BUILD_TYPE=RelWithDebInfo
#export CMAKE_CXX_FLAGS="-fno-omit-frame-pointer"

export DEBUG=0

