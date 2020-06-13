#!/bin/bash
set -e
SHORT_OS_STR=$(uname -s)
if [ "${SHORT_OS_STR:0:5}" == "Linux" ]; then
    OPENMP="-DZFP_WITH_OPENMP=1"
fi
if [ "${SHORT_OS_STR}" == "Darwin" ]; then
    OPENMP=""
fi

mkdir build
cd build
cmake                              \
  -DBUILD_CFP=ON                   \
  -DBUILD_ZFPY=ON                  \
  -DBUILD_UTILITIES=ON             \
  ${OPENMP}                        \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_PREFIX_PATH=${PREFIX}    \
  -DCMAKE_INSTALL_LIBDIR=lib       \
  -DPython_ROOT=${PREFIX}          \
  -DPython_ROOT_DIR=${PREFIX}      \
  ..

make -j${CPU_COUNT}
make test
make install
# Binary not install correctly by cmake
install bin/zfp ${PREFIX}/bin/.

./bin/testzfp

