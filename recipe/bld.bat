setlocal EnableDelayedExpansion

git clone https://github.com/jameskbride/cmake-hello-world.git

cd cmake-hello-world

mkdir build
cd build
cmake -G "NMake Makefiles" ..
nmake

REM :: Remove -GL from CXXFLAGS as this causes a fatal error
REM :: See https://github.com/conda/conda-build/issues/2850
REM :: set "CXXFLAGS=%CXXFLAGS:-GL=%"
REM set "CXXFLAGS=%CXXFLAGS:-GL=%"
REM set VERBOSE=1

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