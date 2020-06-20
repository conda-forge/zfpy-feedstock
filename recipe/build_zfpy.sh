cd python

mkdir build
cd build
cmake                              \
  -DBUILD_CFP=OFF                  \
  -DBUILD_UTILITIES=OFF            \
  -DBUILD_ZFPY=ON                  \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DPython_ROOT_DIR=${PREFIX}      \
  -DPython_FIND_VIRTUALENV=ONLY    \
  ..

make
make install

