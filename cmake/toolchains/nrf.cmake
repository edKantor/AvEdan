# Nordic's nRF Connect SDK toolchain manager installs a Zephyr SDK GCC
# (arm-zephyr-eabi-*), not a plain arm-none-eabi one. Point this at the
# arm-zephyr-eabi root directory (the one containing bin/arm-zephyr-eabi-gcc).
#
# Override with -DNRF_TOOLCHAIN_ROOT=<path> or the NRF_TOOLCHAIN_ROOT
# environment variable. Defaults to the NCS v3.4.1 toolchain bundle found on
# this machine.
if(NOT DEFINED NRF_TOOLCHAIN_ROOT)
    if(DEFINED ENV{NRF_TOOLCHAIN_ROOT})
        set(NRF_TOOLCHAIN_ROOT "$ENV{NRF_TOOLCHAIN_ROOT}")
    else()
        set(NRF_TOOLCHAIN_ROOT "/opt/nordic/ncs/toolchains/97226bad62/opt/zephyr-sdk/gnu/arm-zephyr-eabi")
    endif()
endif()
set(NRF_TOOLCHAIN_ROOT "${NRF_TOOLCHAIN_ROOT}" CACHE PATH "Root of the arm-zephyr-eabi toolchain used for nRF builds")

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(NRF_TOOLCHAIN_PREFIX "${NRF_TOOLCHAIN_ROOT}/bin/arm-zephyr-eabi-")

set(CMAKE_C_COMPILER "${NRF_TOOLCHAIN_PREFIX}gcc")
set(CMAKE_CXX_COMPILER "${NRF_TOOLCHAIN_PREFIX}g++")
set(CMAKE_ASM_COMPILER "${NRF_TOOLCHAIN_PREFIX}gcc")
set(CMAKE_OBJCOPY "${NRF_TOOLCHAIN_PREFIX}objcopy" CACHE FILEPATH "")
set(CMAKE_OBJDUMP "${NRF_TOOLCHAIN_PREFIX}objdump" CACHE FILEPATH "")
set(CMAKE_SIZE "${NRF_TOOLCHAIN_PREFIX}size" CACHE FILEPATH "")

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_EXECUTABLE_SUFFIX ".elf")

# Core/FPU flags depend on the specific nRF chip (e.g. -mcpu=cortex-m4
# -mfpu=fpv4-sp-d16 -mfloat-abi=hard for nRF52). Add them once a chip is
# chosen, either here or in mcu/nrf/CMakeLists.txt.
