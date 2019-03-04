#!/bin/bash

set -e          # stop the script if a command has an error

TEMP_DIR="/tmp"
port=$(ctx node properties port)
cd ${TEMP_DIR}

pyserver="includes/simple_server.py"

# download web assets from CLI workstation to server
ctx logger info "Downloading blueprint resources..."
ctx download-resource-and-render ${pyserver} ${TEMP_DIR}/app.py     #has to be named app.py on VM

# install flask
curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"     # get pip
sudo python get-pip.py
ctx logger info "Got PIP!"
sudo pip install Flask
ctx logger info "Installed Flask!"