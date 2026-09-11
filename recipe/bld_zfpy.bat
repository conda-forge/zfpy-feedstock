setlocal EnableDelayedExpansion

del /F/Q/S build

:: Make a build folder and change to it.
mkdir build
cd build

:: hmaarrfk: 2020/06/20
:: Basically, this build is going to reinstall the C libraries
:: we already compiled before
:: but since the build is identical, conda will not find the newly compiled
:: libraries, and just keep using the old ons
:: Configure using the CMakeFiles
cmake -G "Ninja"                               ^
  -DBUILD_ZFPY=ON                              ^
  -DBUILD_UTILITIES=ON                         ^
  -DBUILD_CFP=ON                               ^
  -DZFP_WITH_OPENMP=ON                         ^
  -DCMAKE_BUILD_TYPE:STRING=Release            ^
  -DCMAKE_INSTALL_PREFIX="%LIBRARY_PREFIX%"    ^
  -DPython_EXECUTABLE="%PYTHON%"               ^
  ..

if errorlevel 1 exit 1

ninja install
if errorlevel 1 exit 1

cd "%SRC_DIR%"
"%PYTHON%" -m pip install . --no-deps --no-build-isolation --disable-pip-version-check
if errorlevel 1 exit 1
