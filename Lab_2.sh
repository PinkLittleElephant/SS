#!/bin/bash
# install lib
sudo apt update
#sudo apt install python3-pip
pip install --user future
sudo apt-get install python-tk

cd /home/keks101
#mkdir mavlink

# clone from git
#git clone https://github.com/mavlink/mavlink.git --recursive

PYTHONPATH='/home/keks101/mavlink'
cd mavlink

git submodule update --init --recursive

# set directory

# build and generation

python -m pymavlink.tools.mavgen --lang=C --wire-protocol=2.0 --output=generated/include/mavlink/v2.0 message_definitions/v1.0/icarous.xml


