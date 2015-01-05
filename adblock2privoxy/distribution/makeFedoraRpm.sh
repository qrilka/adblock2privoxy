#!/bin/bash
set -e
echo   This script compiles adblock2privoxy to binary RPM and DEB on Fedora Core.

echo "create build folders"
mkdir -p rpmbuild/BUILD
ln -nsf ../../.. rpmbuild/BUILD/root
mkdir -p rpmbuild/BUILDROOT
mkdir -p rpmbuild/RPMS

echo "install build tools and dependencies"
sudo yum -y install @development-tools
sudo yum -y install fedora-packager
#sudo yum -y install alien
#sudo yum -y install dpkg-dev
sudo yum-builddep -y rpmbuild/SPECS/adblock2privoxy.spec

echo "build RPM"
rpmbuild --define "_topdir `pwd`/rpmbuild" -bb rpmbuild/SPECS/adblock2privoxy.spec

mkdir -p binary
mv rpmbuild/RPMS/*/* binary/
cd binary

#echo "convert to DEB"
#sudo alien *

echo Build is done. The result is in current folder
