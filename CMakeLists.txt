cmake_minimum_required(VERSION 3.20)

# Select target MCU family and board before the first project() call, e.g.:
#   cmake -B build -DAVEDAN_MCU_FAMILY=stm32 -DAVEDAN_BOARD=nucleo_f4 \
#         -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/stm32.cmake
#   cmake -B build -DAVEDAN_MCU_FAMILY=nrf -DAVEDAN_BOARD=nrf52_dk \
#         -DCMAKE_TOOLCHAIN_FILE=cmake/toolchains/nrf.cmake
if(NOT DEFINED AVEDAN_MCU_FAMILY)
    message(FATAL_ERROR "AVEDAN_MCU_FAMILY must be set to 'stm32' or 'nrf'")
endif()

project(AvEdan CXX C ASM)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

add_subdirectory(hal)
add_subdirectory(mcu/${AVEDAN_MCU_FAMILY})
add_subdirectory(bsp)
add_subdirectory(drivers)
