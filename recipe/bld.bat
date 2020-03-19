setlocal EnableDelayedExpansion

:: Remove -GL from CXXFLAGS as this causes a fatal error
:: See https://github.com/conda/conda-build/issues/2850
:: set "CXXFLAGS=%CXXFLAGS:-GL=%"
pushd .
set CXXFLAGS=-MD
set VERBOSE=1

:: Make a build folder and change to it.
mkdir build
cd build

set PYTHON_LIBRARY=%PREFIX%\libs\python%PY_VER:~0,1%%PY_VER:~2,1%.lib

echo "Cmake is located at: "
where cmake
echo "Nmake thinks that Cmake is located at: "
echo %BUILD_PREFIX%\Library\bin\cmake.exe 

:: Configure using the CMakeFiles

cmake -G "Ninja" ^
  -DCMAKE_BUILD_TYPE=Release ^
  -DPYTHON_EXECUTABLE:FILEPATH="%PYTHON%" ^
  -DPYTHON_INCLUDE_DIR:PATH="%PREFIX%\include" ^
  -DPYTHON_LIBRARY:FILEPATH="%PYTHON_LIBRARY%" ^
  -DBUILD_TESTING=OFF ^
  -DZFP_WITH_OPENMP=OFF ^
  -DBUILD_SHARED_LIBS=ON ^
  -DCMAKE_VERBOSE_MAKEFILE:BOOL=ON ^
  -DCMAKE_INSTALL_PREFIX:PATH="%LIBRARY_PREFIX%" ^
  ..
if errorlevel 1 exit 1

cmake --build . --target INSTALL --config Release
if errorlevel 1 exit 1

popd