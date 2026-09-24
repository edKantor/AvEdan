set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

# Nordic's nRF Connect SDK toolchain manager installs a Zephyr SDK GCC
# (arm-zephyr-eabi-*), not a plain arm-none-eabi one. Its install location
# differs per OS and per machine, so this discovers it via find_program
# (which searches PATH and knows about platform executable extensions,
# e.g. .exe on Windows) rather than a hardcoded path.
#
# If it isn't on PATH, point NRF_TOOLCHAIN_ROOT (CMake cache var or
# environment variable) at the arm-zephyr-eabi root directory — the one
# containing bin/arm-zephyr-eabi-gcc. See CMakePresets.json for per-OS
# examples.
if(NOT DEFINED NRF_TOOLCHAIN_ROOT AND DEFINED ENV{NRF_TOOLCHAIN_ROOT})
    set(NRF_TOOLCHAIN_ROOT "$ENV{NRF_TOOLCHAIN_ROOT}")
endif()

# Without this, CMake's internal try_compile() calls (e.g. compiler ABI
# detection) run in a fresh process that never sees this variable, so
# find_program() below would fall back to a bare PATH search there.
list(APPEND CMAKE_TRY_COMPILE_PLATFORM_VARIABLES NRF_TOOLCHAIN_ROOT)

set(_avedan_nrf_hints)
if(NRF_TOOLCHAIN_ROOT)
    set(_avedan_nrf_hints HINTS "${NRF_TOOLCHAIN_ROOT}/bin")
endif()

find_program(NRF_GCC NAMES arm-zephyr-eabi-gcc ${_avedan_nrf_hints}
    DOC "arm-zephyr-eabi GCC from the nRF Connect SDK toolchain" REQUIRED)
find_program(NRF_GXX NAMES arm-zephyr-eabi-g++ ${_avedan_nrf_hints}
    DOC "arm-zephyr-eabi G++ from the nRF Connect SDK toolchain" REQUIRED)
find_program(NRF_OBJCOPY NAMES arm-zephyr-eabi-objcopy ${_avedan_nrf_hints} REQUIRED)
find_program(NRF_OBJDUMP NAMES arm-zephyr-eabi-objdump ${_avedan_nrf_hints} REQUIRED)
find_program(NRF_SIZE NAMES arm-zephyr-eabi-size ${_avedan_nrf_hints} REQUIRED)

set(CMAKE_C_COMPILER "${NRF_GCC}")
set(CMAKE_CXX_COMPILER "${NRF_GXX}")
set(CMAKE_ASM_COMPILER "${NRF_GCC}")
set(CMAKE_OBJCOPY "${NRF_OBJCOPY}" CACHE FILEPATH "")
set(CMAKE_OBJDUMP "${NRF_OBJDUMP}" CACHE FILEPATH "")
set(CMAKE_SIZE "${NRF_SIZE}" CACHE FILEPATH "")

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_EXECUTABLE_SUFFIX ".elf")

# Core/FPU flags depend on the specific nRF chip (e.g. -mcpu=cortex-m4
# -mfpu=fpv4-sp-d16 -mfloat-abi=hard for nRF52). Add them once a chip is
# chosen, either here or in mcu/nrf/CMakeLists.txt.
