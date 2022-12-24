#!/usr/bin/env bash
set -e
OSX_ARCHITECTURES=""
if [[ "${target_platform}" == "osx-arm64" ]]; then
  OSX_ARCHITECTURES="-DCMAKE_OSX_ARCHITECTURES=arm64"
elif [[ "${target_platform}" == "osx-64" ]]; then
  OSX_ARCHITECTURES="-DCMAKE_OSX_ARCHITECTURES=x86_64"
fi

mkdir build
cd build
cmake ${CMAKE_ARGS}                \
  ${OSX_ARCHITECTURES}             \
  -DBUILD_CFP=ON                   \
  -DBUILD_UTILITIES=ON             \
  -DZFP_WITH_OPENMP=ON             \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_PREFIX_PATH=${PREFIX}    \
  -DCMAKE_INSTALL_LIBDIR=lib       \
  ..

make -j${CPU_COUNT}
if [[ "$CONDA_BUILD_CROSS_COMPILATION" != "1" ]]; then
  make test
fi
make install

mkdir -p ${PREFIX}/bin
# Binary not install correctly by cmake
install bin/zfp ${PREFIX}/bin/.

if [[ "$CONDA_BUILD_CROSS_COMPILATION" != "1" ]]; then
  ./bin/testzfp
fi
