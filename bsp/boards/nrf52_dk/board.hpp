#pragma once

#include "bsp/board.hpp"

namespace bsp::nrf52_dk {

// Board support for the Nordic nRF52-DK. Pin assignments and clock
// configuration for this specific board live in board.cpp.
class Board : public bsp::IBoard {
public:
    void init() override;
};

} // namespace bsp::nrf52_dk
