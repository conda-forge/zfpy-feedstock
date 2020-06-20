mkdir build
cd build
cmake                              \
  -DBUILD_CFP=ON                   \
  -DBUILD_UTILITIES=ON            \
  -DBUILD_ZFPY=ON                  \
  -DCMAKE_INSTALL_PREFIX=${PREFIX} \
  -DPython_ROOT_DIR=${PREFIX}      \
  -DPython_FIND_VIRTUALENV=ONLY    \
  ..

make
make install

