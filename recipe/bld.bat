setlocal EnableDelayedExpansion

:: Remove -GL from CXXFLAGS as this causes a fatal error
:: See https://github.com/conda/conda-build/issues/2850
:: set "CXXFLAGS=%CXXFLAGS:-GL=%"
set CXXFLAGS=
set
set VERBOSE=1

:: Make a build folder and change to it.
mkdir build
cd build

:: Configure using the CMakeFiles
cmake -G "NMake Makefiles" ^
    -DBUILD_ZFPY=ON ^
    -DZFP_WITH_OPENMP=OFF ^
    -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
    ..
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 1
