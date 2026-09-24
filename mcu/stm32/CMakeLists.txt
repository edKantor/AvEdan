# Concrete HAL implementations for the STM32 family, wrapping the STM32Cube vendor SDK
# (see vendor/README.md). Currently header-only/empty scaffold; once source files are
# added under src/, switch this to add_library(avedan_mcu_stm32 STATIC <sources>) and
# link the vendor SDK target(s) here.
add_library(avedan_mcu_stm32 INTERFACE)
target_include_directories(avedan_mcu_stm32 INTERFACE include)
target_link_libraries(avedan_mcu_stm32 INTERFACE avedan_hal)
