# MCU-agnostic device drivers (sensors, displays, radios, ...) built only
# against hal/ interfaces, so the same driver works on every supported MCU
# family. Currently empty scaffold; once source files are added under src/,
# switch this to add_library(avedan_drivers STATIC <sources>).
add_library(avedan_drivers INTERFACE)
target_include_directories(avedan_drivers INTERFACE include)
target_link_libraries(avedan_drivers INTERFACE avedan_hal)
