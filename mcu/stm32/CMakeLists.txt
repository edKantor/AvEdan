# Concrete HAL implementations for the STM32 family, wrapping the STM32Cube vendor SDK
# (see vendor/README.md). Currently header-only/empty scaffold; once source files are
# added under src/, switch this to add_library(avedan_mcu_stm32 STATIC <sources>) and
# link the vendor SDK target(s) here.
add_library(avedan_mcu_stm32 INTERFACE)
target_include_directories(avedan_mcu_stm32 INTERFACE include)
target_link_libraries(avedan_mcu_stm32 INTERFACE avedan_hal)

# The ARM GNU Toolchain's libc (newlib) needs syscall stubs (_exit, _sbrk,
# _write, ...) that only exist once a real runtime provides them. nosys.specs
# supplies no-op stubs, sufficient until STM32Cube's HAL/syscalls are wired in.
target_link_options(avedan_mcu_stm32 INTERFACE "--specs=nosys.specs")
