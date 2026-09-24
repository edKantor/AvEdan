# Custom devicetree bindings

YAML bindings for devicetree nodes used by our own drivers under `drivers/`. Empty until
a custom driver needs one — a driver that only reuses existing Zephyr peripheral bindings
(GPIO, I2C, SPI, ...) doesn't need anything here.
