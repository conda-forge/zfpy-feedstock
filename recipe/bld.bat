setlocal EnableDelayedExpansion

:: Make a build folder and change to it.
mkdir build
cd build

set PYTHON_LIBRARY=%PREFIX%\libs\python%PY_VER:~0,1%%PY_VER:~2,1%.lib 

:: Configure using the CMakeFiles
cmake -G "Ninja"                               ^
  -DBUILD_ZFPY=ON                              ^
  -DBUILD_UTILITIES=ON                         ^
  -DBUILD_CFP=ON                               ^
  -DZFP_WITH_OPENMP=OFF                        ^
  -DCMAKE_BUILD_TYPE:STRING=Release            ^
  -DPYTHON_EXECUTABLE:FILEPATH="%PYTHON%"      ^
  -DPYTHON_LIBRARY:FILEPATH="%PYTHON_LIBRARY%" ^
  -DPYTHON_INCLUDE_DIR:PATH="%PREFIX%\include" ^
  -DCMAKE_INSTALL_PREFIX="%LIBRARY%"           ^
  -DPython_ROOT_DIR=%PREFIX%                   ^
  -DPython_FIND_VIRTUALENV=ONLY                ^
  ..

if errorlevel 1 exit 1

ninja install
if errorlevel 1 exit 1

REM command line utility not installed for some reason
copy "bin\zfp.exe" "%LIBRARY_BIN%\."
if errorlevel 1 exit 1

:: Run tests
ctest
if errorlevel 1 exit 1
bin\testzfp.exe
if errorlevel 1 exit 1
