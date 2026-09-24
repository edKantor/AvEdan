# AvEdan

Embedded platform layer: HAL/BSP/driver architecture supporting STM32 and nRF MCUs.

See [docs/architecture.md](docs/architecture.md) for the full layering and how to add a
new MCU family, board, or driver.

```
hal/      abstract peripheral interfaces (MCU-agnostic)
mcu/      concrete HAL implementations per MCU family (stm32, nrf), wrapping vendor SDKs
bsp/      board support packages (pin maps, clocks, board bring-up)
drivers/  MCU-agnostic device drivers built on hal/ interfaces
cmake/    toolchain files for cross-compiling to each MCU family
```
