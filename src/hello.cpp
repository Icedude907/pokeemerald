#include "hello.hpp"
EXTERNC{
    #include "random.h"
}
#include <tuple>

std::tuple<u16, u16> twoRands(){
    return {Random(), Random()};
}

void helloCpp(){
    auto [a, b] = twoRands();
    DebugPrintf("C++ BOIS %d %d", (u32)a, (u32)b);
    return;
}
