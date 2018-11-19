#!/bin/bash

install_cuda() {
    local URL=$1
    mkdir -p cuda
    pushd cuda
    local DIR=$(pwd)/$2
    if [[ ! -d ${DIR} ]]; then
      rm -rf /tmp/cuda
      mkdir /tmp/cuda
      wget ${URL} > /tmp/cuda/combined.sh
      sh /tmp/cuda/combined.sh --extract=/tmp/cuda
      local LINUX=$(ls -1 /tmp/cuda/cuda-linux.$2*.run)
      ${LINUX} --prefix=${DIR} -noprompt -nosymlink -no-man-page
      rm -rf /tmp/cuda
    fi
    popd
}

install_cuda https://developer.nvidia.com/compute/cuda/9.2/Prod/local_installers/cuda_9.2.88_396.26_linux 9.2.88