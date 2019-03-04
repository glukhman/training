#!/bin/bash

set -e          # stop the script if a command has an error

TEMP_DIR="/tmp"
port=$(ctx node properties port)
PID_FILE="server.pid"

ctx logger info "Starting Flask server from ${TEMP_DIR}"

# start a simple Flask server python app, from the server root folder, listening on the requested port
cd ${TEMP_DIR}
ctx logger info "Starting simple_server, listening on port $port" 
nohup flask run -h 0.0.0.0 -p ${port} > /dev/null 2>&1 &     # nohup = ignore hangup signal
echo $! > ${PID_FILE}                                        # save the process ID in a file, for killing it later

ctx logger info "Waiting for server to launch on port ${port}"
url="http://0.0.0.0:${port}"