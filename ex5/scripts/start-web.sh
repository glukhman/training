#!/bin/bash

set -e          # stop the script if a command has an error

TEMP_DIR="/tmp"
port=$(ctx node properties port)
PYTHON_FILE_SERVER_ROOT=${TEMP_DIR}/test.$port
PID_FILE="server.pid"

# retrieve runtime ip from flask server
app_ip_address=$(ctx instance runtime_properties app_ip_address)
ctx logger info "[start-web] Flask server IP: $app_ip_address on $app_port"


ctx logger info "Starting HTTP server from ${PYTHON_FILE_SERVER_ROOT}"

# start a simple HTTP server python app, from the server root folder, listening on the requested port
cd ${PYTHON_FILE_SERVER_ROOT}
ctx logger info "Starting SimpleHTTPServer, listening on port $port"    
nohup python -m SimpleHTTPServer ${port} > /dev/null 2>&1 &     # nohup = ignore hangup signal
echo $! > ${PID_FILE}                                           # save the process ID in a file, for killing it later

ctx logger info "Waiting for server to launch on port ${port}"
url="http://localhost:${port}"

# define: check whether server machine is up by trying to find wget and curl on it 
server_is_up() {
	if which wget >/dev/null; then
		if wget $url >/dev/null; then
			return 0
		fi
	elif which curl >/dev/null; then
		if curl $url >/dev/null; then
			return 0
		fi
	else
		ctx logger error "Both curl, wget were not found in path"
		exit 1
	fi
	return 1
}

# each second for 15 sec. check whether server is up. if not - exit with error (1)
STARTED=false
for i in $(seq 1 15)
do
	if server_is_up; then
		ctx logger info "Server is up at http://$ip:${port}."
		STARTED=true
    	break
	else
		ctx logger info "Server not up. waiting 1 second."
		sleep 1
	fi
done
if [ ${STARTED} = false ]; then
	ctx logger error "Failed starting web server in 15 seconds."
	exit 1
# else
# 	#server has successfully started
# 	# ( &) = fork to background
	# (${PYTHON_FILE_SERVER_ROOT}/annoy_appserver.sh $app_ip_address $app_port &)
fi
