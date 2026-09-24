#pragma once

#include <cstdint>

namespace hal {

class IPwm {
public:
    virtual ~IPwm() = default;

    virtual void configure(uint32_t frequencyHz) = 0;
    virtual void setDutyCycle(uint8_t channel, float dutyPercent) = 0;
    virtual void start(uint8_t channel) = 0;
    virtual void stop(uint8_t channel) = 0;
};

} // namespace hal
