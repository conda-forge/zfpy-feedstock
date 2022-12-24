#!/usr/bin/env bash
set -ex

#  hmaarrfk: 2020/06/20
#  Basically, this build is going to reinstall the C libraries
#  we already compiled before
#  but since the build is identical, conda will not find the newly compiled
#  libraries, and just keep using the old ons

EXTRA_ARGS=
if [[ "${target_platform}" == "osx-arm64" ]]; then
  EXTRA_ARGS="${EXTRA_ARGS} -DCMAKE_OSX_ARCHITECTURES=arm64"
elif [[ "${target_platform}" == "osx-64" ]]; then
  EXTRA_ARGS="${EXTRA_ARGS} -DCMAKE_OSX_ARCHITECTURES=x86_64"
fi


if [[ "$CONDA_BUILD_CROSS_COMPILATION" == "1" ]]; then
  EXTRA_ARGS="${EXTRA_ARGS} -DCYTHON_EXECUTABLE=${BUILD_PREFIX}/bin/cython"
fi
rm -rf build
mkdir build
cd build

cmake ${CMAKE_ARGS}                \
  ${EXTRA_ARGS}             \
  -DBUILD_CFP=ON                   \
  -DBUILD_UTILITIES=ON             \
  -DBUILD_ZFPY=ON                  \
  -DBUILD_TESTING=OFF              \
  -DZFP_WITH_OPENMP=ON             \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DPython_ROOT_DIR=${PREFIX}      \
  -DPython_FIND_VIRTUALENV=ONLY    \
  -DPython_FIND_IMPLEMENTATIONS="PyPy;CPython" \
  -DCMAKE_INSTALL_LIBDIR=lib       \
  ..

make -j${CPU_COUNT}
make install
