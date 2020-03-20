setlocal EnableDelayedExpansion

:: Remove -GL from CXXFLAGS as this causes a fatal error
:: See https://github.com/conda/conda-build/issues/2850
:: set "CXXFLAGS=%CXXFLAGS:-GL=%"
set "CXXFLAGS=%CXXFLAGS:-GL=%"
set VERBOSE=1

pushd .
git clone https://github.com/LLNL/zfp.git

cd zfp

mkdir build
cd build

:: Configure using the CMakeFiles
cmake -G "NMake Makefiles" ^
  -DBUILD_TESTING=OFF ^
  -DBUILD_ZFPY=ON ^
  -DZFP_WITH_OPENMP=OFF ^
  -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON ^
  ..
if errorlevel 1 exit 1

cmake --build .
if errorlevel 1 exit 1

popd



REM :: Make a build folder and change to it.
REM mkdir build
REM cd build

REM set PYTHON_LIBRARY=%PREFIX%\libs\python%PY_VER:~0,1%%PY_VER:~2,1%.lib

REM :: Configure using the CMakeFiles
REM cmake -G "Ninja" ^
REM   -DCMAKE_BUILD_TYPE=Release ^
REM   -DPYTHON_EXECUTABLE:FILEPATH="%PYTHON%" ^
REM   -DPYTHON_INCLUDE_DIR:PATH="%PREFIX%\include" ^
REM   -DPYTHON_LIBRARY:FILEPATH="%PYTHON_LIBRARY%" ^
REM   -DBUILD_TESTING=OFF ^
REM   -DBUILD_ZFPY=ON ^
REM   -DZFP_WITH_OPENMP=OFF ^
REM   -DBUILD_SHARED_LIBS=ON ^
REM   -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON ^
REM   -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
REM   ..
REM if errorlevel 1 exit 1

REM cmake --build . --target install --config Release
REM if errorlevel 1 exit 1