add_library(avedan_bsp STATIC
    board.cpp
)
target_include_directories(avedan_bsp PUBLIC .)
target_link_libraries(avedan_bsp PUBLIC avedan_bsp_api avedan_mcu_nrf avedan_hal)
