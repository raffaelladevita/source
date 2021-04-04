#
#  CCDB does not have a decent CMakeLists.txt -- this ought to be fixed.
#  None of the versions that are on GIT actually build correctly either if you use scons and Python 3
#  This means it needs a custom build script here
#
# TODO: get CCDB to use a proper CMakeLists.txt :-(
#
message(STATUS "Checking for ccdb")
find_package(CCDB QUIET)
if(NOT CCDB_FOUND)
    message(STATUS "********************* CCDB was not found ***************************")
    message(STATUS "* We will get CCDB from GitHub and install it.                     *")
    message(STATUS "* If this is not what you want, make sure CCDB can be found        *")
    message(STATUS "* set CMAKE_PREFIX_PATH to include the ccdbConfig.cmake file       *")
    message(STATUS "********************* CCDB was not found ***************************")
    set(ccdb_VERSION v1.07 CACHE STRING "ccdb version" FORCE)
    set(ccdb_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/ccdb)
    add_dependencies(dependencies ccdb)
    externalproject_add(
            ccdb
            GIT_REPOSITORY   "https://github.com/JeffersonLab/ccdb"
            GIT_TAG          cmake_v1.07 # ${ccdb_VERSION}
            GIT_SHALLOW      ON
            SOURCE_DIR       ${CMAKE_BINARY_DIR}/ccdb
            CMAKE_ARGS
            BUILD_COMMAND    ${CMAKE_MAKE_PROGRAM} -j4
            UPDATE_COMMAND   ""
    )
endif()
