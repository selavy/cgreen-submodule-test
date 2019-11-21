cmake_minimum_required(VERSION 2.8)

project(cgreen-submodule-test LANGUAGES C)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/")

option(USE_SYSTEM_CGREEN "Use system install version of CGreen" ON)
message("Use system cgreen? ${USE_SYSTEM_CGREEN}")

if (USE_SYSTEM_CGREEN)
	# To use system version of CGreen:
	find_package(cgreen REQUIRED)
else ()
	add_subdirectory(third_party)
	set( CGREEN_LIBRARIES cgreen )
	# find_path(CGREEN_INCLUDE_DIRS NAMES cgreen/cgreen.h)
	set( CGREEN_INCLUDE_DIRS third_party/cgreen/include )
endif (USE_SYSTEM_CGREEN)

message("CGreen INCLUDE_DIRS = ${CGREEN_INCLUDE_DIRS}")
message("CGreen LIBRARIES    = ${CGREEN_LIBRARIES}")

add_library(MyLib
    src/mylib.c
    )
target_include_directories(MyLib
    PUBLIC
        $<INSTALL_INTERFACE:include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
    # PRIVATE
    #     ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# install(MyLib)

add_executable(simple1 simple1.c)
target_link_libraries(simple1 MyLib)

add_executable(test-mylib
    tests/test_mylib.c
    tests/all_tests.c
    )
target_link_libraries(test-mylib
    PUBLIC
        MyLib
        ${CGREEN_LIBRARIES}
)
target_include_directories(test-mylib
    PRIVATE
        ${CGREEN_INCLUDE_DIRS}
)
