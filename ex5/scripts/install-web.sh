#!/bin/bash

set -e          # stop the script if a command has an error

TEMP_DIR="/tmp"
port=$(ctx node properties port)
PYTHON_FILE_SERVER_ROOT=${TEMP_DIR}/test.$port

# delete server root folder if already exists
if [ -d ${PYTHON_FILE_SERVER_ROOT} ]; then
	echo "Removing file server root folder ${PYTHON_FILE_SERVER_ROOT}"
	rm -rf ${PYTHON_FILE_SERVER_ROOT}
fi

# create server root folder, iand enter it
ctx logger info "Creating HTTP server root directory at ${PYTHON_FILE_SERVER_ROOT}"
mkdir -p ${PYTHON_FILE_SERVER_ROOT}
cd ${PYTHON_FILE_SERVER_ROOT}

index_path="includes/index.html"
image_path="includes/cloudify-logo.png"

# download web assets from CLI workstation to server
ctx logger info "Downloading blueprint resources..."
ctx download-resource-and-render ${index_path} ${PYTHON_FILE_SERVER_ROOT}/index.html
ctx download-resource ${image_path} ${PYTHON_FILE_SERVER_ROOT}/cloudify-logo.png
ctx download-resource "scripts/annoy_appserver.sh" ${PYTHON_FILE_SERVER_ROOT}/annoy_appserver.sh
sudo chmod 700 ${PYTHON_FILE_SERVER_ROOT}/annoy_appserver.sh