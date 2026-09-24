#pragma once

#include "bsp/board.hpp"

namespace bsp::nucleo_f4 {

// Board support for the ST NUCLEO-F4 family. Pin assignments and clock
// configuration for this specific board live in board.cpp.
class Board : public bsp::IBoard {
public:
    void init() override;
};

} // namespace bsp::nucleo_f4
