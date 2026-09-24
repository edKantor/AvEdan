#pragma once

#include <cstdint>

namespace hal {

class IAdc {
public:
    virtual ~IAdc() = default;

    virtual void configure() = 0;
    virtual uint16_t read(uint8_t channel) = 0;
};

} // namespace hal
