#include <assert.h> // assert only
#include <iostream> // cerr & logic_error

using namespace std; // Feel free to use std, and remove it after

int main()
{
    // cerr is unbuffered by default, cout isn't!
    std::cerr << "\n$*$ test 1\n" // "Heavy" print/log
              << "FILE: " << __FILE__ << "; LINE: " << __LINE__ << "\n$*$\n\n";

    std::cerr << "test 2\n"; // Quick print/log

    // Assert is removed in prod builds. Use only for debug mode checks!
    // Assert kills the whole program! Try-Catch won't work.
    // https://cplusplus.com/reference/cassert/assert/
    assert(1 == 1);
    // assert(1 == 2);

    // std::logic_error is like Error() in Js, ValueError() in Python.
    // It's not the base error class, but it's close to it and not abstract!
    // https://en.cppreference.com/w/cpp/error/logic_error
    throw std::logic_error("$*$ Test 1 error thrown $*$\n");

    // "test 3" won't show up in the console, but "test 2" will!
    std::cerr << "test 3\n";
    // You only need to use std::endl for flushing with cout.
    // Cerr doesn't need endl:
    // std::cerr << "test 1" << std::endl;
}
