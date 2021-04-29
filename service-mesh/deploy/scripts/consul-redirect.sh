#!/usr/bin/env bash

APP_NAME=${1}

until curl -s -k http://localhost:8500/v1/status/leader | grep 8300; do
  echo "Waiting for Consul to start"
  sleep 1
done

consul connect redirect-traffic -proxy-id=${APP_NAME}-sidecar-proxy -proxy-uid=0