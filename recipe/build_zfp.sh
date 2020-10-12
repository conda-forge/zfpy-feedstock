#!/usr/bin/env bash
set -e

mkdir build
cd build
cmake                              \
  -DBUILD_CFP=ON                   \
  -DBUILD_UTILITIES=ON             \
  -DZFP_WITH_OPENMP=ON             \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_PREFIX_PATH=${PREFIX}    \
  -DCMAKE_INSTALL_LIBDIR=lib       \
  ..

make -j${CPU_COUNT}
make test
make install

mkdir -p ${PREFIX}/bin
# Binary not install correctly by cmake
install bin/zfp ${PREFIX}/bin/.

./bin/testzfp

