#include <stdio.h>
#include "foo.h"

int main (void)
{
    printf("Testing call to shared lib\n");
    int ret = foo();
    if (ret == 0) {
        printf("Successfully called lib function\n");
        return 0;
    } else {
        return 10;
    }
}
