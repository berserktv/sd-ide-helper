#!/usr/bin/env bash

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
    sudo apt -y install ${NVIDIA_DRIVER_DEF}
}

gpu_install() {
    nvidia_driver_install
    cuda_driver_install

    echo
    echo "After installing the video driver and cuda, you need to reboot the system (yes/no)?"
    read env_answer
    if [[ $env_answer == "yes" || $env_answer == "YES" ]]; then
        reboot
    fi
}

# install Anaconda (Pyhon 3.6 enviroment for SD WebUi)
anaconda_install() {
    cd ~
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    chmod +x Miniconda3-latest-Linux-x86_64.sh
    bash Miniconda3-latest-Linux-x86_64.sh
}

# fix ERROR: Cannot activate python venv
additional_python_package() {
    sudo apt install -y python3.10-venv
}


CMD_ARGS_WITHOUT_GPU="export COMMANDLINE_ARGS=\"--skip-torch-cuda-test --no-half\""

stable_diffusion_install() {
    local cur_dir=$(pwd)
    local env_without=$1
    anaconda_install
    additional_python_package

    cd ~
    git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git
    cd stable-diffusion-webui

    if [ "$env_without" == "no-GPU" ]; then
        sed -i "s|#export COMMANDLINE_ARGS=.*|&\n${CMD_ARGS_WITHOUT_GPU}|" webui-user.sh
    else
        if cat webui-user.sh | grep -q "skip-torch-cuda-test" ; then
            #turn off --skip-torch-cuda-test, if left in COMMANDLINE_ARGS
            sed -i "s|^export COMMANDLINE_ARGS=.*|#&|" webui-user.sh
        fi
    fi

    ./webui.sh
    cd $cur_dir
}

stable_diffusion_install_without_gpu() {
    stable_diffusion_install "no-GPU"
}

stable_diffusion_run() {
    local cur_dir=$(pwd)
    cd ~/stable-diffusion-webui
    ./webui.sh
    cd $cur_dir
}

