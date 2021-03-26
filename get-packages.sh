#!/bin/bash

UBUNTU_URL="http://ubuntu-master.mirror.tudos.de/ubuntu/pool/main/c/cross-toolchain-base/"
CENTOS_URL="http://mirror.centos.org/centos/filelist.gz"

# Directories to download binaries to
PPC_BASE_DIR="ppc64-debs"
POWERPC_BASE_DIR="powerpc-debs"
CENTOS_BASE_DIR="rpms"

# get powerpc static binaries from ubuntu mirror
powerpc() {
	if [[ ! -d $POWERPC_BASE_DIR ]]; then
		mkdir -p $POWERPC_BASE_DIR
	fi

	cd $POWERPC_BASE_DIR
	
	if [[ ! -f filelist ]]; then
		wget $UBUNTU_URL -O filelist
	fi
	
	cat ../filelist | grep -o ">linux.*.powerpc.*.deb" | while read line; do
		wget -c "$UBUNTU_URL${line:1}"
	done
}

# get powerpc 64 bit binaries from ubuntu mirror
ppc() {
	if [[ ! -d $PPC_BASE_DIR ]]; then
		mkdir -p $PPC_BASE_DIR
	fi

	cd $PPC_BASE_DIR
	
	if [[ ! -f filelist ]]; then
		wget $UBUNTU_URL -O filelist
	fi
	
	cat filelist | grep -o ">linux.*.ppc.*.deb" | while read line; do
		wget -c "$UBUNTU_URL${line:1}"
	done
}

# Get centos ppc files mirror files
## NOTE: CentOS handles this better. They have a file list that doesn't need to parse an html page.
ppc_centos() {
	if [[ ! -d $CENTOS_BASE_DIR ]]; then
		mkdir -p $CENTOS_BASE_DIR
	fi

	cd $CENTOS_BASE_DIR
	
	if [[ ! -f filelist ]]; then
		wget $CENTOS_URL -O filelist.gz
		gzip -d filelist.gz
	fi
	
	cat filelist | grep "\-static\-.*\.ppc" | while read rpm; do
		wget -c "http://mirror.centos.org/centos/${rpm}"
	done
}

# Call functions
powerpc
ppc
ppc_centos
