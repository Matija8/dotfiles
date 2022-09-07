#include <assert.h> // for assert()
#include <stdio.h>
#include <stdlib.h> // for exit()

// https://stackoverflow.com/questions/39002052/how-i-can-print-to-stderr-in-c
int main()
{
    // Printing to stdout is buffered! Don't use it!
    // https://stackoverflow.com/questions/1716296/why-does-printf-not-flush-after-the-call-unless-a-newline-is-in-the-format-strin
    // Printing to stderr flushes right away!
    // No risk of missing printfs!

    // Heavy printf (fprintf)
    fprintf(stderr, "\n$*$ test 1\nFILE: %s\nLINE: %d\n$*$\n\n", __FILE__, __LINE__);

    // Quick printf
    fprintf(stderr, "$*$ test 2\n");

    assert(1 == 1);
    // assert(1 == 2);

    exit(1);

    // "test 3" won't be shown, but "test 2" will!
    fprintf(stderr, "$*$ test 3\n");
    return 0;
}
