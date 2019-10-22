#!/usr/bin/bash

# Will exit the Bash script the moment any command will itself exit with a non-zero status, thus an error.
set -e

EXTRACT_PATH=$1
BUILD_PATH=$2
INSTALL_PATH=${REZ_BUILD_INSTALL_PATH}
OSL_VERSION=${REZ_BUILD_PROJECT_VERSION}

# We print the arguments passed to the Bash script.
echo -e "\n"
echo -e "================="
echo -e "=== CONFIGURE ==="
echo -e "================="
echo -e "\n"

echo -e "[CONFIGURE][ARGS] EXTRACT PATH: ${EXTRACT_PATH}"
echo -e "[CONFIGURE][ARGS] BUILD PATH: ${BUILD_PATH}"
echo -e "[CONFIGURE][ARGS] INSTALL PATH: ${INSTALL_PATH}"
echo -e "[CONFIGURE][ARGS] OSL VERSION: ${OSL_VERSION}"

# We check if the arguments variables we need are correctly set.
# If not, we abort the process.
if [[ -z ${EXTRACT_PATH} || -z ${BUILD_PATH} || -z ${INSTALL_PATH} || -z ${OSL_VERSION} ]]; then
    echo -e "\n"
    echo -e "[CONFIGURE][ARGS] One or more of the argument variables are empty. Aborting..."
    echo -e "\n"

    exit 1
fi

# We run the configuration script of OSL.
echo -e "\n"
echo -e "[CONFIGURE] Running the configuration script from OSL-${OSL_VERSION}..."
echo -e "\n"

mkdir -p ${BUILD_PATH}
cd ${BUILD_PATH}

cmake \
    ${BUILD_PATH}/.. \
    -DCMAKE_INSTALL_PREFIX=${INSTALL_PATH} \
    -DCMAKE_C_FLAGS="-fPIC" \
    -DCMAKE_CXX_FLAGS="-fPIC" \
    -DOSL_BUILD_MATERIALX=OFF \
    -DOSL_BUILD_PLUGINS=ON \
    -DOSL_BUILD_SHADERS=ON \
    -DOSL_BUILD_TESTS=ON \
    -DUSE_BOOST_WAVE=OFF \
    -DUSE_FAST_MATH=ON \
    -DUSE_LLVM_BITCODE=ON \
    -DUSE_OPTIX=OFF \
    -DUSE_PARTIO=ON \
    -DUSE_QT=OFF \
    -DBOOST_ROOT=${REZ_BOOST_ROOT} \
    -DILMBASE_ROOT_DIR=${REZ_ILMBASE_ROOT} \
    -DLLVM_DIRECTORY=${REZ_LLVM_ROOT} \
    -DOPENEXR_ROOT_DIR=${REZ_OPENEXR_ROOT} \
    -DOPENIMAGEIO_ROOT_DIR=${REZ_OIIO_ROOT} \
    -DPARTIO_HOME=${REZ_PARTIO_ROOT} \
    -DPUGIXML_HOME=${REZ_PUGIXML_ROOT} \
    -DZLIB_ROOT=${REZ_ZLIB_ROOT}

echo -e "\n"
echo -e "[CONFIGURE] Finished configuring OSL-${OSL_VERSION}!"
echo -e "\n"
