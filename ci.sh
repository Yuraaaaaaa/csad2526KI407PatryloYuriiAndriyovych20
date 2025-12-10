#!/usr/bin/env bash

# ci.sh - local CMake build + test runner
# Usage: ./ci.sh

set -uo pipefail

BUILD_DIR="build"

echo "[ci] Cleaning existing build directory (if any): $BUILD_DIR"
# Remove any existing build directory to ensure a clean build (avoids leftover absolute paths)
if [ -d "$BUILD_DIR" ]; then
    rm -rf "$BUILD_DIR" || { echo "[ci] Failed to remove directory $BUILD_DIR"; exit 1; }
fi

echo "[ci] Creating build directory: $BUILD_DIR"
mkdir -p "$BUILD_DIR" || { echo "[ci] Failed to create directory $BUILD_DIR"; exit 1; }

echo "[ci] Entering $BUILD_DIR"
cd "$BUILD_DIR" || { echo "[ci] Failed to enter $BUILD_DIR"; exit 1; }

echo "[ci] Configuring project with CMake..."
cmake ..
RC=$?
if [ $RC -ne 0 ]; then
    echo "[ci] CMake configuration failed (exit code $RC)"
    exit $RC
fi

echo "[ci] Building project..."
cmake --build .
RC=$?
if [ $RC -ne 0 ]; then
    echo "[ci] Build failed (exit code $RC)"
    exit $RC
fi

echo "[ci] Running tests (ctest)..."
ctest --output-on-failure
RC=$?
if [ $RC -ne 0 ]; then
    echo "[ci] Some tests failed (ctest exit code $RC)"
    exit $RC
fi

echo "[ci] Build and tests succeeded"
exit 0
