cmake_minimum_required(VERSION 3.14)

project(HelloWorld VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

find_package(Threads REQUIRED)

include(FetchContent)

# Try to find installed GoogleTest first
find_package(GTest QUIET)
if (NOT GTest_FOUND)
    message(STATUS "GoogleTest not found. Fetching googletest v1.14.0...")
    FetchContent_Declare(
        googletest
        URL https://github.com/google/googletest/archive/refs/tags/v1.14.0.zip
    )
    # Prevent overriding compiler options when googletest is built
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
    FetchContent_MakeAvailable(googletest)
endif()

# Add static library for math_operations
add_library(math_operations STATIC math_operations.cpp)
target_include_directories(math_operations PUBLIC ${CMAKE_SOURCE_DIR})

# Executable from main.cpp
add_executable(test_app main.cpp)
target_link_libraries(test_app PRIVATE math_operations Threads::Threads)

# Unit tests
enable_testing()

add_executable(unit_tests tests/unit_tests.cpp)
target_include_directories(unit_tests PRIVATE ${CMAKE_SOURCE_DIR})
target_link_libraries(unit_tests PRIVATE math_operations Threads::Threads)

# Ensure GTest targets are available (will be provided by FetchContent if not found)
if (NOT TARGET GTest::gtest)
    find_package(GTest REQUIRED)
endif()

target_link_libraries(unit_tests PRIVATE
    math_operations
    Threads::Threads
    GTest::gtest
    GTest::gtest_main
)

add_test(NAME unit_tests COMMAND unit_tests)

include(CTest)

# Convenience target to run all tests with output on failure
add_custom_target(run_tests
    COMMAND ${CMAKE_COMMAND} --build ${CMAKE_BINARY_DIR} --config $<CONFIG> --target unit_tests
    COMMAND ${CMAKE_CTEST_COMMAND} -C $<CONFIG> --output-on-failure
    DEPENDS unit_tests
)
