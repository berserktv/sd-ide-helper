#!/bin/bash

NVIDIA_DRIVER_DEF=nvidia-driver-525

# software and hardware architecture of parallel computing
cuda_driver_install() {
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-ubuntu2204.pin
    sudo mv cuda-ubuntu2204.pin /etc/apt/preferences.d/cuda-repository-pin-600
    wget https://developer.download.nvidia.com/compute/cuda/12.1.0/local_installers/cuda-repo-ubuntu2204-12-1-local_12.1.0-530.30.02-1_amd64.deb
    sudo dpkg -i cuda-repo-ubuntu2204-12-1-local_12.1.0-530.30.02-1_amd64.deb
    sudo cp /var/cuda-repo-ubuntu2204-12-1-local/cuda-*-keyring.gpg /usr/share/keyrings/
    sudo apt-get update
    sudo apt-get -y install cuda
}

nvidia_driver_install() {
    sudo apt update
    sudo apt purge *nvidia*
    # List drivers for your GPU
    ubuntu-drivers list
    sudo apt install ${NVIDIA_DRIVER_DEF}
}

