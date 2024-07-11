#include "kernel/types.h"
#include "user/user.h"

int main(int argc, char *argv[])
{
    if (argc < 3)
    {
        exit(0);
    }
    int old = set_priority(atoi(argv[1]), atoi(argv[2]));
    if (old < 0)
        printf("Error\n");
    else
        printf("Priority changed\n");
    exit(0);
}