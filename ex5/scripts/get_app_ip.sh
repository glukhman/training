#!/bin/bash

set -e

if [ "$app_ip_address" = "" ];then
    app_ip_address=$(ctx target instance host_ip)
fi

ctx source instance runtime_properties app_ip_address "$app_ip_address"