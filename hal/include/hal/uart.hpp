#pragma once

#include <cstddef>
#include <cstdint>

namespace hal {

class IUart {
public:
    virtual ~IUart() = default;

    virtual void configure(uint32_t baudRate) = 0;
    virtual size_t write(const uint8_t* data, size_t length) = 0;
    virtual size_t read(uint8_t* buffer, size_t maxLength) = 0;
    virtual bool isDataAvailable() const = 0;
};

} // namespace hal
