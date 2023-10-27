#! /bin/bash

DEBIAN_FRONTEND=noninteractive

# Clone Upstream
git clone ./media-driver-intel-media https://github.com/intel/media-driver.git -b intel-media-23.3.4
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
