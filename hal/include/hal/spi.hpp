#pragma once

#include <cstddef>
#include <cstdint>

namespace hal {

enum class SpiMode : uint8_t {
    Mode0,
    Mode1,
    Mode2,
    Mode3,
};

class ISpi {
public:
    virtual ~ISpi() = default;

    virtual void configure(uint32_t clockHz, SpiMode mode) = 0;
    virtual void transfer(const uint8_t* txData, uint8_t* rxData, size_t length) = 0;
};

} // namespace hal
