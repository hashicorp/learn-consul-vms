#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# Update and ensure we have apt-add-repository
apt-get update
#apt-get install -y software-properties-common

# Add i386 architecture (for libraries)
#dpkg --add-architecture i386

# Update with i386, Go and Docker
#apt-get update

# Install Core build utilities for Linux
apt-get install -y \
	zip \
	curl \
	jq \
	tree \
	unzip \
	wget

# apt-get install -y \
# 	qemu \
# 	openjdk

# Ensure everything is up to date
# apt-get upgrade -y

# Set hostname -> IP to make advertisement work as expected
ip=$(ip route get 1 | awk '{print $NF; exit}')
hostname=$(hostname)
sed -i -e "s/.*nomad.*/${ip} ${hostname}/" /etc/hosts
