cmake_minimum_required(VERSION 3.18)

project (bla)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_BUILD_TYPE RELEASE)

if (${CMAKE_CXX_COMPILER_ID} STREQUAL MSVC)
    MESSAGE("building for MSVC")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} -O2")
else()
    if (${CMAKE_CXX_COMPILER_ID} STREQUAL GNU)
        message("using gcc")
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=native -stdlib=libstdc++")
    endif ()
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wall -Wextra -Wpedantic -Wshadow -Wconversion")# -Werror")
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS} -O3")
    set(CMAKE_CXX_FLAGS_DEBUG  "${CMAKE_CXX_FLAGS} -O1 -g")
endif ()


add_executable(${PROJECT_NAME} main.cpp)

