set -e
SHORT_OS_STR=$(uname -s)
if [ "${SHORT_OS_STR:0:5}" == "Linux" ]; then
    OPENMP="-DZFP_WITH_OPENMP=1"
fi
if [ "${SHORT_OS_STR}" == "Darwin" ]; then
    OPENMP="-DZFP_WITH_OPENMP=0"
fi

rm -rf build
mkdir build
cd build
cmake                              \
  -DBUILD_CFP=ON                   \
  -DBUILD_UTILITIES=ON            \
  -DBUILD_ZFPY=ON                  \
  ${OPENMP}                        \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DPython_ROOT_DIR=${PREFIX}      \
  -DPython_FIND_VIRTUALENV=ONLY    \
  -DCMAKE_INSTALL_LIBDIR=lib       \
  ..

make
make install

