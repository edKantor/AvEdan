# Custom boards

Zephyr board definitions (devicetree + Kconfig + board.cmake) for our own custom
hardware, following Zephyr's board porting layout. Empty until a custom board exists —
until then, builds target Zephyr's stock boards directly (e.g. `nrf52dk/nrf52832`,
`nucleo_f429zi`).

Because `board_root: .` is set in `zephyr/module.yml`, any board added here is picked up
automatically by SafeSeat's build (via `-DBOARD=<name>` or `west build -b <name>`) with
no further wiring needed.
