#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Clone Upstream
wget http://deb.debian.org/debian/pool/non-free/i/intel-media-driver-non-free/intel-media-driver-non-free_23.3.5+ds1.orig.tar.xz
tar -xf ./intel-media-driver-non-free_23.3.5+ds1.orig.tar.xz
mv -v ./media-driver-intel-media-23.3.5 ./media-driver-intel-media
cp -rvf ./debian ./media-driver-intel-media/
cd ./media-driver-intel-media/
for i in $(cat ../patches/series) ; do echo "Applying Patch: $i" && patch -Np1 -i ../patches/$i || bash -c "echo "Applying Patch $i Failed!" && exit 2"; done

# Get build deps
apt-get build-dep ./ -y

# Build package
dpkg-buildpackage --no-sign

# Move the debs to output
cd ../
mkdir -p ./output
mv ./*.deb ./output/
