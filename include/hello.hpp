#ifndef HELLO_HPP_GUARD
#define HELLO_HPP_GUARD

// #include "cppinterop"
#ifdef __cplusplus
#define EXTERNC extern "C"
#define CBODY EXTERNC {
#define CBODYEND }
#else
#define EXTERNC
#define CBODY
#define CBODYEND
#endif

CBODY // Exported & Imported to C & C++.
#include "global.h"
void helloCpp();
CBODYEND

#ifdef __cplusplus
// C++ only imports and exports

#endif // C++

#endif // HELLO_HPP_GUARD