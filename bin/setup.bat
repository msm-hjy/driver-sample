@echo off
setlocal

:: Set the path to EWDK
set EWDK_ROOT=C:\EWDK

:: Add EWDK tools to the PATH
set PATH=%EWDK_ROOT%\BuildEnv;%PATH%

:: Load the build environment
call "%EWDK_ROOT%\LaunchBuildEnv\BuildEnv.cmd"

:: Navigate to the directory with your Makefile
cd ..

:: Run your build command
make

endlocal
