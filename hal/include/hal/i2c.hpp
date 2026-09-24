#pragma once

#include <cstddef>
#include <cstdint>

namespace hal {

class II2c {
public:
    virtual ~II2c() = default;

    virtual void configure(uint32_t clockHz) = 0;
    virtual bool write(uint8_t address, const uint8_t* data, size_t length) = 0;
    virtual bool read(uint8_t address, uint8_t* buffer, size_t length) = 0;
};

} // namespace hal
