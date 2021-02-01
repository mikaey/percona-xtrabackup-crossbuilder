#!/bin/sh
echo "Installing prerequisites..."
apt-get update && apt-get install -y curl xz-utils dpkg-dev automake \
        bison cmake debhelper libaio-dev libncurses-dev libssl-dev libtool \
        libz-dev libgcrypt-dev libev-dev libcurl4-openssl-dev lsb-release \
        python3-sphinx python3-docutils fakeroot libsasl2-dev vim-common \
        libldap2-dev git wget2 || exit 1
echo "Fetching source archive..."

# If anyone is wondering, I'm using wget2 because wget segfaults for some reason

wget2 https://downloads.percona.com/downloads/Percona-XtraBackup-LATEST/Percona-XtraBackup-8.0.22-15/source/debian/percona-xtrabackup-80_8.0.22-15.orig.tar.gz || exit 1
echo "Fetching Debian rules archive..."
wget2 https://downloads.percona.com/downloads/Percona-XtraBackup-LATEST/Percona-XtraBackup-8.0.22-15/source/debian/percona-xtrabackup-80_8.0.22-15-1.debian.tar.xz || exit 1
echo "Extracting source files..."
tar xvf percona-xtrabackup-80_8.0.22-15.orig.tar.gz || exit 1
cd percona-xtrabackup-8.0.22-15
tar xvf ../percona-xtrabackup-80_8.0.22-15-1.debian.tar.xz || exit 1
echo "Starting build"
dpkg-buildpackage || exit 1
echo "Copying files to output folder..."
cp ../*.deb /output || exit 1
echo "Done!"

