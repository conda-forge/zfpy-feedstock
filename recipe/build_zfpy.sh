#!/usr/bin/env bash
set -ex

# Patching is just not working with obscure line ending errors
# sed in-place isn't portable. Just create a temporary file
sed '/from cpython/d' python/zfpy.pyx > python/zfpy.pyx_fixed
mv python/zfpy.pyx_fixed python/zfpy.pyx
sed '/import array/d' python/zfpy.pyx > python/zfpy.pyx_fixed
mv python/zfpy.pyx_fixed python/zfpy.pyx

#  hmaarrfk: 2020/06/20
#  Basically, this build is going to reinstall the C libraries
#  we already compiled before
#  but since the build is identical, conda will not find the newly compiled
#  libraries, and just keep using the old ons

rm -rf build
mkdir build
cd build

cmake                              \
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

