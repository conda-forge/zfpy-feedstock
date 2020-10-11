#!/usr/bin/env bash
set -e

#  hmaarrfk: 2020/06/20
#  Basically, this build is going to reinstall the C libraries
#  we already compiled before
#  but since the build is identical, conda will not find the newly compiled
#  libraries, and just keep using the old ons

rm -rf build
mkdir build
cd build

EXTRA_FLAGS=
if [ `${PYTHON} --version | grep PyPy` ]; then
    EXTRA_FLAGS="-DPYTHON_LIBRARY=${PREFIX}/lib/libpypy3-c.so"
fi
cmake                              \
  -DBUILD_CFP=ON                   \
  -DBUILD_UTILITIES=ON             \
  -DBUILD_ZFPY=ON                  \
  -DZFP_WITH_OPENMP=ON             \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DPython_ROOT_DIR=${PREFIX}      \
  -DPython_FIND_VIRTUALENV=ONLY    \
  -DCMAKE_INSTALL_LIBDIR=lib       \
  ${EXTRA_FLAGS}                   \
  ..

make
make install

