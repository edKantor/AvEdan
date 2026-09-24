# AvEdan platform architecture

Layered HAL/BSP/driver architecture, currently targeting STM32 and nRF MCU families.

## Layers

```
        application code
              |
     +--------+--------+
     |                 |
  drivers/           bsp/            <- board-specific wiring, depends on mcu/ + hal/
     |                 |
     +--------+--------+
              |
            hal/                     <- abstract C++ interfaces (IGpio, IUart, ISpi, ...)
              ^
              |
           mcu/<family>/             <- concrete HAL implementations, wrap vendor SDK
              |
        mcu/<family>/vendor/         <- vendor SDK as a git submodule (STM32Cube, nrfx)
```

- **hal/** — MCU-agnostic abstract interfaces for peripherals (GPIO, UART, SPI, I2C,
  timer, ADC, PWM). Pure virtual C++ classes, no implementation, no vendor dependency.
  Everything above this layer (drivers, application code) programs only against these
  interfaces.

- **mcu/\<family\>/** — one subtree per supported MCU family (`stm32`, `nrf`). Each
  provides concrete classes implementing the `hal::I*` interfaces on top of that
  family's vendor SDK, which lives under `mcu/<family>/vendor/` as a pinned git
  submodule (STM32Cube HAL/LL for STM32, nrfx for nRF). This is the only layer allowed
  to include vendor SDK headers.

- **bsp/** — Board Support Packages. `bsp/include/bsp/board.hpp` defines the minimal
  `bsp::IBoard` lifecycle (`init()`); each board under `bsp/boards/<board>/` implements
  it, wiring up the specific `mcu/<family>` peripheral instances, pin assignments, and
  clock configuration for that physical board. A board depends on exactly one
  `mcu/<family>`.

- **drivers/** — MCU-agnostic device drivers (sensors, displays, radios, etc.), written
  only against `hal/` interfaces. Because they never touch `mcu/` or vendor code
  directly, the same driver works unmodified on any board/MCU family.

Application code depends on `bsp/` (for board bring-up) and `drivers/` (for devices),
never directly on `mcu/` or vendor SDK headers.

## Adding a new MCU family

1. Create `mcu/<family>/` with `vendor/` (submodule), `include/`, `src/`.
2. Implement the `hal::I*` interfaces on top of the vendor SDK.
3. Add a toolchain file under `cmake/toolchains/<family>.cmake`.
4. Add at least one board under `bsp/boards/` that links against
   `avedan_mcu_<family>`.

## Adding a new board (existing MCU family)

1. Create `bsp/boards/<board>/` with `board.hpp`/`board.cpp` implementing
   `bsp::IBoard`, plus a `CMakeLists.txt` producing the `avedan_bsp` target linked
   against the family's `avedan_mcu_<family>` library.
2. Build with `-DAVEDAN_MCU_FAMILY=<family> -DAVEDAN_BOARD=<board>`.

## Build configuration

CMake, selected via two cache variables set at configure time:

- `AVEDAN_MCU_FAMILY` — `stm32` or `nrf`
- `AVEDAN_BOARD` — a directory name under `bsp/boards/` (currently `nucleo_f4` or
  `nrf52_dk`, both placeholders pending a chosen chip variant)

`CMakePresets.json` wires these up per OS/family, and is the recommended way to build:

```
cmake --preset nrf-macos      # or nrf-linux, nrf-windows, stm32-macos, stm32-linux, stm32-windows
cmake --build --preset nrf-macos
```

Both `cmake/toolchains/*.cmake` files locate their compiler with `find_program`
(PATH search, aware of `.exe` on Windows), so the same toolchain files and presets work
unmodified across macOS, Linux, and Windows — no OS-specific branches needed in the
CMake logic itself, only in which path (if any) a preset supplies as a hint.

- `cmake/toolchains/nrf.cmake` looks for `arm-zephyr-eabi-*` — the Zephyr SDK GCC bundled
  by Nordic's nRF Connect SDK toolchain manager, not a plain `arm-none-eabi-gcc`. If it
  isn't on PATH, point it at the toolchain root (the directory containing
  `bin/arm-zephyr-eabi-gcc`) via `-DNRF_TOOLCHAIN_ROOT=<path>` or the
  `NRF_TOOLCHAIN_ROOT` environment variable.
- `cmake/toolchains/stm32.cmake` looks for `arm-none-eabi-*` (the ARM GNU Toolchain).
  Same override mechanism via `STM32_TOOLCHAIN_ROOT`.
- The `nrf-macos`/`stm32-macos` presets already supply the paths verified on the
  reference Mac. The Linux/Windows presets exist but have no verified default path yet —
  set the `*_TOOLCHAIN_ROOT` env var (or put the compiler on PATH) before configuring
  with them.

## Status

This is an initial scaffold: HAL interfaces are defined, but `mcu/`, `bsp/`, and
`drivers/` are placeholders with no real implementations yet, and vendor SDKs are not
yet added as submodules (chip variants haven't been chosen).
