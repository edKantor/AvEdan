# AvEdan

Reusable-across-products platform layer, built as a [Zephyr module](https://docs.zephyrproject.org/latest/develop/modules.html)
on top of Zephyr RTOS. Zephyr itself already provides the HAL/BSP/driver stack (including
STM32 and nRF support); AvEdan holds only what's specific to us — custom boards and
custom device drivers written against Zephyr's driver model.

```
zephyr/module.yml   declares this repo as a Zephyr module (build.cmake/kconfig, board_root, dts_root)
boards/              our own board ports (devicetree + Kconfig), on top of Zephyr's stock boards
drivers/             our own Zephyr device drivers, one subsystem per subdirectory
dts/bindings/        devicetree YAML bindings for our custom drivers
```

Consumed by the `SafeSeat` application via `ZEPHYR_EXTRA_MODULES` — see the top-level
`SafeSeat/CMakeLists.txt`.

Currently an empty scaffold: no custom board or driver exists yet, so builds target
Zephyr's stock boards directly (e.g. `nrf52dk/nrf52832`, `nucleo_f429zi`).
