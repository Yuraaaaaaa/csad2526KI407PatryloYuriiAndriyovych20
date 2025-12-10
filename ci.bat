@echo off
REM ci.bat - local CMake build + test runner for Windows

setlocal enabledelayedexpansion
set "BUILD_DIR=build"






































exit /b 0echo SUCCESS
npopd)    exit /b %errorlevel%    echo FAILED    popd    echo [ci] Some tests failed (ctest exit code %errorlevel%)if errorlevel 1 (ctest --output-on-failure
necho [ci] Running tests (ctest)...)    exit /b %errorlevel%    echo FAILED    popd    echo [ci] Build failed (exit code %errorlevel%)cmake --build .
if errorlevel 1 (
necho [ci] Building project...)    exit /b %errorlevel%    echo FAILED    popd    echo [ci] CMake configuration failed (exit code %errorlevel%)cmake ..
if errorlevel 1 (
necho [ci] Configuring project with CMake...)    exit /b 1    echo [ci] Failed to enter %BUILD_DIR%pushd "%BUILD_DIR%" || (
necho [ci] Entering %BUILD_DIR%)    )        exit /b 1        echo [ci] Failed to create directory %BUILD_DIR%    mkdir "%BUILD_DIR%" || (if not exist "%BUILD_DIR%" (necho [ci] Ensuring build directory exists: %BUILD_DIR%