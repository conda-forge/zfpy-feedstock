setlocal EnableDelayedExpansion

:: Make a build folder and change to it.
mkdir build
cd build

set PYTHON_LIBRARY=%PREFIX%\libs\python%PY_VER:~0,1%%PY_VER:~2,1%.lib

:: Configure using the CMakeFiles
cmake -G "NMake Makefiles"                     ^
  -DBUILD_ZFPY=ON                              ^
  -DBUILD_UTILITIES=ON                         ^
  -DBUILD_CFP=ON                               ^
  -DZFP_WITH_OPENMP=OFF                        ^
  -DCMAKE_BUILD_TYPE:STRING=Release            ^
  -DPYTHON_EXECUTABLE:FILEPATH="%PYTHON%"      ^
  -DPYTHON_LIBRARY:FILEPATH="%PYTHON_LIBRARY%" ^
  -DPYTHON_INCLUDE_DIR:PATH="%PREFIX%\include" ^
  -DCMAKE_INSTALL_PREFIX="%PREFIX%"            ^
  ..

if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1

:: Custom installation step
copy "python\lib\zfpy.pyd" "%PREFIX%\Lib\site-packages"
if errorlevel 1 exit 1
REM copy "bin\zfp.dll" "%PREFIX%\Lib\site-packages"
REM if errorlevel 1 exit 1
copy "bin\zfp.exe" "%LIBRARY_BIN%\."
if errorlevel 1 exit 1

:: Run tests
ctest
bin\testzfp.exe
