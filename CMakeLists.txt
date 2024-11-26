CMAKE_MINIMUM_REQUIRED(VERSION 3.0)

cmake_policy(SET CMP0144 NEW)

include(RezBuild)
include(RezRepository)
include(ExternalProject)

# OSL
rez_set_archive(
    OSL_URL osl/OpenShadingLanguage-1.13.11.0.tar.gz
    # https://github.com/imageworks/OpenShadingLanguage/archive/Release-${REZ_BUILD_PROJECT_VERSION}.tar.gz
    https://github.com/AcademySoftwareFoundation/OpenShadingLanguage/archive/refs/tags/v1.13.11.0.tar.gz
)

# The environment variable REZ_TMP_PATH is meant to point to a location such as "/tmp/rez".

set(EXTRACT_DIR $ENV{REZ_TMP_PATH}/osl/${REZ_BUILD_PROJECT_VERSION})
set(BUILD_DIR ${EXTRACT_DIR}/build)
# OpenEXR 경로를 수동으로 지정
set(CMAKE_PREFIX_PATH /cocoa/inhouse/tool/rez-packages/openexr/3.1.9/platform-linux/arch-x86_64 ${CMAKE_PREFIX_PATH})
set(OpenEXR_DIR /cocoa/inhouse/tool/rez-packages/openexr/3.1.9/platform-linux/arch-x86_64)
set(ILMBASE_INCLUDE_PATH /cocoa/inhouse/tool/rez-packages/ilmbase/2.2.0/platform-linux/arch-x86_64/include)
set(OPENEXR_ILMIMF_LIBRARY /cocoa/inhouse/tool/rez-packages/openexr/3.1.9/platform-linux/arch-x86_64/lib/libIlmImf.so)

# OpenEXR 패키지 찾기
find_package(OpenEXR REQUIRED)

# We configure/build/install OSL through the ExternalProject_Add macro,
# using three different shell scripts for each of these steps.
# If necessary, it is possible to skip one of these steps by replacing the command
# by "", an empty string.
ExternalProject_Add(
    REZ_OSL
    URL ${OSL_URL}
    PREFIX osl
    SOURCE_DIR ${EXTRACT_DIR}
    PATCH_COMMAND ""
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND bash ${CMAKE_SOURCE_DIR}/configure.sh ${EXTRACT_DIR} ${BUILD_DIR}
    BUILD_COMMAND bash ${CMAKE_SOURCE_DIR}/build.sh ${BUILD_DIR}
    INSTALL_COMMAND bash ${CMAKE_SOURCE_DIR}/install.sh ${BUILD_DIR}
)

# We use a bogus CMake "install" step in order to be able to properly finish
# and get out of the CMake script.
install(
    CODE
    "execute_process(
        COMMAND echo \"\n[CMAKE] OSL-${REZ_BUILD_PROJECT_VERSION} PACKAGE SETUP FINISHED!\n\"
    )"
)
