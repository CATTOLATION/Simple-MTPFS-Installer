#!/bin/bash

set -euo pipefail

directory="simple-mtpfs"
stage=1

echo "RUNNING SUDO"
sudo -v

echo "Stage 1 : RETRIEVING SIMPLE-MTPFS FROM GIT"

if [ -d "$directory" ]; then
  echo "SIMPLE-MTPFS DIRECTORY ALREADY EXISTS"
  echo "HEADING INTO SIMPLE-MTPFS DIRECTORY"
  cd "$directory"
  ((stage = stage + 1))
else
  echo "CLONING SIMPLE-MTPFS REPOSITORY"
  git clone https://github.com/phatina/simple-mtpfs.git "$directory"
  echo "HEADING INTO DIRECTORY"
  cd "$directory"
  ((stage = stage + 1))
fi

if [ $stage -eq 2 ]; then
  echo "Stage 2 : INSTALLING PACKAGES"
  sudo apt update
  sudo apt install -y gcc libmtp-dev libfuse-dev autoconf autoconf-archive make cmake pkg-config build-essential
  ((stage = stage + 1))
fi

if [ $stage -eq 3 ]; then
  echo "Stage 3 : INSTALLING SIMPLE-MTPFS"
  echo "CREATING BUILD DIRECTORY"
  mkdir -p build
  echo "HEADING INTO BUILD DIRECTORY"
  cd build
  echo "RUNNING ../autogen.sh FILE"
  ../autogen.sh
  echo "RUNNING ../configure FILE"
  ../configure
  echo "RUNNING make"
  make
  echo "RUNNING make install"
  sudo make install
fi
