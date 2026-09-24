set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

# The ARM GNU Toolchain (arm-none-eabi-*) install location differs per OS
# and per machine, so this discovers it via find_program (which searches
# PATH and knows about platform executable extensions, e.g. .exe on
# Windows) rather than a hardcoded path.
#
# If it isn't on PATH, point STM32_TOOLCHAIN_ROOT (CMake cache var or
# environment variable) at the toolchain root directory — the one
# containing bin/arm-none-eabi-gcc. See CMakePresets.json for per-OS
# examples.
if(NOT DEFINED STM32_TOOLCHAIN_ROOT AND DEFINED ENV{STM32_TOOLCHAIN_ROOT})
    set(STM32_TOOLCHAIN_ROOT "$ENV{STM32_TOOLCHAIN_ROOT}")
endif()

# Without this, CMake's internal try_compile() calls (e.g. compiler ABI
# detection) run in a fresh process that never sees this variable, so
# find_program() below would fall back to a bare PATH search there.
list(APPEND CMAKE_TRY_COMPILE_PLATFORM_VARIABLES STM32_TOOLCHAIN_ROOT)

set(_avedan_stm32_hints)
if(STM32_TOOLCHAIN_ROOT)
    set(_avedan_stm32_hints HINTS "${STM32_TOOLCHAIN_ROOT}/bin")
endif()

find_program(STM32_GCC NAMES arm-none-eabi-gcc ${_avedan_stm32_hints}
    DOC "arm-none-eabi GCC (ARM GNU Toolchain)" REQUIRED)
find_program(STM32_GXX NAMES arm-none-eabi-g++ ${_avedan_stm32_hints}
    DOC "arm-none-eabi G++ (ARM GNU Toolchain)" REQUIRED)
find_program(STM32_OBJCOPY NAMES arm-none-eabi-objcopy ${_avedan_stm32_hints} REQUIRED)
find_program(STM32_OBJDUMP NAMES arm-none-eabi-objdump ${_avedan_stm32_hints} REQUIRED)
find_program(STM32_SIZE NAMES arm-none-eabi-size ${_avedan_stm32_hints} REQUIRED)

set(CMAKE_C_COMPILER "${STM32_GCC}")
set(CMAKE_CXX_COMPILER "${STM32_GXX}")
set(CMAKE_ASM_COMPILER "${STM32_GCC}")
set(CMAKE_OBJCOPY "${STM32_OBJCOPY}" CACHE FILEPATH "")
set(CMAKE_OBJDUMP "${STM32_OBJDUMP}" CACHE FILEPATH "")
set(CMAKE_SIZE "${STM32_SIZE}" CACHE FILEPATH "")

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_EXECUTABLE_SUFFIX ".elf")

# Core/FPU flags depend on the specific STM32 chip (e.g. -mcpu=cortex-m4
# -mfpu=fpv4-sp-d16 -mfloat-abi=hard for F4). Add them once a chip is chosen,
# either here or in mcu/stm32/CMakeLists.txt.
