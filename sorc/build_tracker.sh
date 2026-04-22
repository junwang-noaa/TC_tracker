#!/bin/sh
set -xeu
if [[ ! -d ../exec ]] ; then mkdir ../exec ; fi

source ./machine-setup.sh > /dev/null 2>&1
source ../versions/build.ver

module use ../modulefiles
module load $target.lua
module list

cd ..

if [ -d "build" ]; then
   rm -rf build
fi
mkdir build
cd build

cmake .. -DCMAKE_Fortran_COMPILER=${CMAKE_Fortran_COMPILER} -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER} -DCMAKE_BUILD_TYPE=${BUILD_TYPE}

make -j ${BUILD_JOBS:-8} VERBOSE=2
make install

cd ..

exit
