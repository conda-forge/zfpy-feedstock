#!/usr/bin/env bash
set -ex

#  hmaarrfk: 2020/06/20
#  Basically, this build is going to reinstall the C libraries
#  we already compiled before
#  but since the build is identical, conda will not find the newly compiled
#  libraries, and just keep using the old ons

rm -rf build
mkdir build
cd build

cmake ${CMAKE_ARGS}                \
  -DBUILD_CFP=ON                   \
  -DBUILD_UTILITIES=ON             \
  -DBUILD_ZFPY=ON                  \
  -DBUILD_TESTING=OFF              \
  -DZFP_WITH_OPENMP=ON             \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DCMAKE_INSTALL_LIBDIR=lib       \
  -DPython_ROOT_DIR=${PREFIX}      \
  -DPython_NumPy_INCLUDE_DIR=$(${PYTHON} -c "import numpy; print(numpy.get_include())") \
  ..


  # -DPython_EXECUTABLE=${PYTHON}    \
  # -DPython_FIND_STRATEGY=LOCATION  \
  # -DPython_ROOT_DIR=${PREFIX}      \
make -j${CPU_COUNT}
make install

cd "${SRC_DIR}"
"${PYTHON}" -m pip install . --no-deps --no-build-isolation --disable-pip-version-check
