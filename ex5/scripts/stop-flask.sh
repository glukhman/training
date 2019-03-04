#!/bin/bash

set -e          # stop the script if a command has an error

TEMP_DIR="/tmp"
PID_FILE="server.pid"

# retrieve the server process ID from a file, and kill the server
PID=`cat ${TEMP_DIR}/${PID_FILE}`
ctx logger info "Shutting down flask server. pid = ${PID}"
kill -9 ${PID} || true