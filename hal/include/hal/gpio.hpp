#pragma once

#include <cstdint>

namespace hal {

enum class PinState : uint8_t {
    Low = 0,
    High = 1,
};

enum class PinMode : uint8_t {
    Input,
    Output,
    InputPullUp,
    InputPullDown,
    OpenDrain,
};

class IGpio {
public:
    virtual ~IGpio() = default;

    virtual void configure(PinMode mode) = 0;
    virtual void write(PinState state) = 0;
    virtual PinState read() const = 0;
    virtual void toggle() = 0;
};

} // namespace hal
