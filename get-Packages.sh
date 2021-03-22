#!/bin/bash
# TODO: Add base directory to functions (so we can cd into directories correctly
# TODO: Add directories as variables (if this shit ends up working)

UBUNTU_URL="http://ubuntu-master.mirror.tudos.de/ubuntu/pool/main/c/cross-toolchain-base/"
CENTOS_URL="http://mirror.centos.org/centos/filelist.gz"

# get powerpc
#cat index.html | grep -o ">linux.*.powerpc.*.deb" | while read line; do  wget -c "$UBUNTU_URL${line:1}"; done
powerpc() {
	if [[ ! -f filelist ]]; then
		wget $UBUNTU_URL -O filelist
	fi
	mkdir -p powerpc-debs
	cd powerpc-debs
	cat ../filelist | grep -o ">linux.*.powerpc.*.deb" | while read line; do
		wget -c "$UBUNTU_URL${line:1}"
	done
}

# get ppc
# cat index.html | grep -o ">linux.*.ppc.*.deb" | while read line; do  wget -c "$UBUNTU_URL${line:1}"; done
ppc() {
	if [[ ! -d ppc64-debs ]]: then
		mkdir -p ppc64-debs
		cd ppc64-debs
	else
		cd ppc64-debs
	fi

	if [[ ! -f filelist ]]; then
		wget $UBUNTU_URL -O filelist
	fi
	mkdir -p ppc64-debs
	cd ppc64-debs
	cat ../filelist | grep -o ">linux.*.ppc.*.deb" | while read line; do
		wget -c "$UBUNTU_URL${line:1}"
	done
}

# Get centos ppc files mirror files
## NOTE: CentOS handles this better. They have a file list that doesn't need fancy footwork to parse.
ppc_centos() {
	if [ ! -f filelist ]; then
		wget $CENTOS_URL -O filelist
		gzip -d filelist.gz
	fi

	mkdir -p rpms
	cd rpms
	cat ../filelist | grep "\-static\-.*\.ppc" | while read rpm; do
		wget -c "http://mirror.centos.org/centos/${rpm}"
	done
}

# Call functions
ppc
