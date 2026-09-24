#pragma once

namespace bsp {

// Common lifecycle every concrete board implements. Boards expose their own
// additional accessors (e.g. getLed(), getDebugUart()) for the peripherals
// they actually wire up — this base only captures the shared bring-up hook.
class IBoard {
public:
    virtual ~IBoard() = default;

    virtual void init() = 0;
};

} // namespace bsp
