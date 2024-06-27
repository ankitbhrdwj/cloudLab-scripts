#!/bin/bash

CONDA_BIN="~/miniconda3/bin/"
$CONDA_BIN/conda init
source ~/.bashrc

cat /usr/local/cuda/version.json | grep version -B 2 | grep SDK -B 3 -A 2
sudo apt install cmake pkg-config libfreeimage-dev
sudo apt install nvidia-cudnn
sudo apt install libnccl-dev libnccl2

# Deps
conda install -c intel intelpython3_full python=3.10 mkl-dpcpp mkl-include intel-openmp intel-fortran-rt dpcpp-cpp-rt numpy
conda install -c pkgs/main cmake ninja astunparse expecttest hypothesis psutil pyyaml requests setuptools typing-extensions sympy filelock networkx jinja2 fsspec
pip install types-dataclasses

# Pytorch deps
git clone git@github.com:ankitbhrdwj/pytorch.git
cd pytorch
git submodule sync
git submodule update --init --recursive
pip install -r requirements.txt
# Check the cuda version (["124", "121", "118"])
conda install -c pytorch magma-cuda124

export LD_LIBRARY_PATH="${CONDA_PREFIX}/lib:/usr/local/cuda/targets/x86_64-linux/lib${LD_LIBRARY_PATH:+${LD_LIBRARY_PATH}:}"
export _GLIBCXX_USE_CXX11_ABI=1
export CMAKE_PREFIX_PATH=${CONDA_PREFIX:-"$(dirname $(which conda))/../"}export LD_PRELOAD="${CONDA_PREFIX}/lib/libiomp5.so"
export MKL_OPENMP_LIBRARY="${CONDA_PREFIX}/lib/libiomp5.so"
export OpenMP_GNU_FLAG_CANDIDATES="-fopenmp=libiomp5"
export CMAKE_INCLUDE_PATH="${CONDA_PREFIX}/include"
export MKL_OPENMP_TYPE="Intel"
export MKL_THREADING="OMP"
export USE_SYSTEM_NCCL=ON
export TORCH_CUDA_ARCH_LIST="8.6"
export CUDA_HOME="/usr/local/cuda"

ln -sf /usr/lib/x86_64-linux-gnu/libstdc++.so.6 ${CONDA_PREFIX}/lib

python setup.py develop

# Check the version
python -c "import torch;print(torch.__version__)"
python -c "import torch;print(torch.version.cuda)"
python -c "import torch;print(torch.cuda.nccl.version())"

