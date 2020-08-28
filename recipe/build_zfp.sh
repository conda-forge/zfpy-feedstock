#!/bin/bash
set -e
SHORT_OS_STR=$(uname -s)
if [ "${SHORT_OS_STR:0:5}" == "Linux" ]; then
    OPENMP="-DZFP_WITH_OPENMP=1"
fi
if [ "${SHORT_OS_STR}" == "Darwin" ]; then
    OPENMP="-DZFP_WITH_OPENMP=0"
fi

mkdir build
cd build
cmake                              \
  -DBUILD_CFP=ON                   \
  -DBUILD_UTILITIES=ON             \
  ${OPENMP}                        \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_PREFIX_PATH=${PREFIX}    \
  -DCMAKE_INSTALL_LIBDIR=lib.      \
  ..

make -j${CPU_COUNT}
make test
make install

mkdir -p ${PREFIX}/bin
# Binary not install correctly by cmake
install bin/zfp ${PREFIX}/bin/.

./bin/testzfp

