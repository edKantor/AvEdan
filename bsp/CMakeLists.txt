if(NOT DEFINED AVEDAN_BOARD)
    message(FATAL_ERROR "AVEDAN_BOARD must be set, e.g. -DAVEDAN_BOARD=nucleo_f4 or -DAVEDAN_BOARD=nrf52_dk")
endif()

add_library(avedan_bsp_api INTERFACE)
target_include_directories(avedan_bsp_api INTERFACE include)

add_subdirectory(boards/${AVEDAN_BOARD})
