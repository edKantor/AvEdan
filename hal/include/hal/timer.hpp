#pragma once

#include <cstdint>

namespace hal {

class ITimer {
public:
    using Callback = void (*)(void* context);

    virtual ~ITimer() = default;

    virtual void start(uint32_t periodUs) = 0;
    virtual void stop() = 0;
    virtual void setCallback(Callback callback, void* context) = 0;
};

} // namespace hal
