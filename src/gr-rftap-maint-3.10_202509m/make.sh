#! /bin/sh
cd build/
sudo make uninstall << EOF
yinlab
EOF
cd ../
sudo rm -rf build/
mkdir build
cd build
sudo cmake ..
sudo make
sudo make install
sudo ldconfig
