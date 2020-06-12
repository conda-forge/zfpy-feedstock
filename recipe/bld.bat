setlocal EnableDelayedExpansion

:: Make a build folder and change to it.
mkdir build
cd build

:: Configure using the CMakeFiles
cmake -G "Ninja"                               ^
  -DBUILD_ZFPY=ON                              ^
  -DBUILD_UTILITIES=ON                         ^
  -DBUILD_CFP=ON                               ^
  -DZFP_WITH_OPENMP=OFF                        ^
  -DCMAKE_BUILD_TYPE:STRING=Release            ^
  ..

if errorlevel 1 exit 1

ninja install
if errorlevel 1 exit 1

:: Custom installation step
REM copy "python\lib\zfpy.pyd" "%PREFIX%\Lib\site-packages"
REM if errorlevel 1 exit 1
REM copy "bin\zfp.dll" "%PREFIX%\Lib\site-packages"
REM if errorlevel 1 exit 1

REM command line utility not installed for some reason
copy "bin\zfp.exe" "%LIBRARY_BIN%\."
if errorlevel 1 exit 1

:: Run tests
ctest
bin\testzfp.exe
