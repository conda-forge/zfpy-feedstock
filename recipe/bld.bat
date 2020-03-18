setlocal EnableDelayedExpansion

:: Remove -GL from CXXFLAGS as this causes a fatal error
:: See https://github.com/conda/conda-build/issues/2850
:: set "CXXFLAGS=%CXXFLAGS:-GL=%"
pushd .
set VERBOSE=1

:: Make a build folder and change to it.
mkdir build
cd build

:: Configure using the CMakeFiles
cmake -GNinja ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DBUILD_ZFPY=ON ^
    -DZFP_WITH_OPENMP=OFF ^
    REM -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=OFF ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    ..
if errorlevel 1 exit 1

cmake --build . --config Release --target install
if errorlevel 1 exit 1

ctest
if errorlevel 1 exit 1
popd