cmake_minimum_required(VERSION 2.8)

project(cgreen-submodule-test LANGUAGES C)

set(CMAKE_RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/lib")

# add_subdirectory(third_party)

find_package(cgreen REQUIRED)

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
