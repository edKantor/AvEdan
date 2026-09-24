# Concrete HAL implementations for the nRF family, wrapping the nrfx vendor SDK
# (see vendor/README.md). Currently header-only/empty scaffold; once source files are
# added under src/, switch this to add_library(avedan_mcu_nrf STATIC <sources>) and
# link the vendor SDK target(s) here.
add_library(avedan_mcu_nrf INTERFACE)
target_include_directories(avedan_mcu_nrf INTERFACE include)
target_link_libraries(avedan_mcu_nrf INTERFACE avedan_hal)
