#!/bin/bash

set -e          # stop the script if a command has an error

TEMP_DIR="/tmp"
port=$(ctx node properties port)
PYTHON_FILE_SERVER_ROOT=${TEMP_DIR}/test.$port
PID_FILE="server.pid"

# retrieve the server process ID from a file, and kill the server
PID=`cat ${PYTHON_FILE_SERVER_ROOT}/${PID_FILE}`
ctx logger info "Shutting down file server. pid = ${PID}"
kill -9 ${PID} || true

# delete the server root folder
ctx logger info "Deleting file server root directory (${PYTHON_FILE_SERVER_ROOT})"
rm -rf ${PYTHON_FILE_SERVER_ROOT}