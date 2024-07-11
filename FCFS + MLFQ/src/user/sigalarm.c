#include "kernel/types.h"
#include "kernel/stat.h"
#include "user.h"



void my_handler(void) {
    fprintf(1, "Alarm! This is my custom handler.\n");
    sigreturn();
}

int main(int argc, char *argv[]) {
    int interval = 10; // Set the alarm interval to 10 ticks
    int result = sigalarm(interval, my_handler);

    if (result < 0) {
        fprintf(1, "Error setting the alarm.\n");
        exit(0);
    }

    while (1) {
        // Your main program logic here
        // For demonstration purposes, we'll just sleep.
        fprintf(1, "Running...\n");
        sleep(100); // Sleep for a while (adjust as needed)
    }

    exit(0);
}
