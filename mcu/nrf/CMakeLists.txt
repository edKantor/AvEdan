# Concrete HAL implementations for the nRF family, wrapping the nrfx vendor SDK
# (see vendor/README.md). Currently header-only/empty scaffold; once source files are
# added under src/, switch this to add_library(avedan_mcu_nrf STATIC <sources>) and
# link the vendor SDK target(s) here.
add_library(avedan_mcu_nrf INTERFACE)
target_include_directories(avedan_mcu_nrf INTERFACE include)
target_link_libraries(avedan_mcu_nrf INTERFACE avedan_hal)

# The Zephyr SDK's arm-zephyr-eabi libc (newlib) needs syscall stubs
# (_exit, _sbrk, ...) that only exist standalone, not baked into a Zephyr
# kernel here. libnosys.a provides no-op stubs; ships in the toolchain but
# without a nosys.specs wrapper, so it must be linked manually, and as a
# target_link_libraries entry (not target_link_options) so CMake places it
# after the object files instead of before them — it must come after
# libc/libgcc in the final link line for archive resolution to pick it up.
target_link_libraries(avedan_mcu_nrf INTERFACE
    "-Wl,--start-group" "-lgcc" "-lc" "-lnosys" "-Wl,--end-group")
