if(NOT DEFINED AVEDAN_BOARD)
    message(FATAL_ERROR "AVEDAN_BOARD must be set, e.g. -DAVEDAN_BOARD=nucleo_f4 or -DAVEDAN_BOARD=nrf52_dk")
endif()

add_subdirectory(boards/${AVEDAN_BOARD})
