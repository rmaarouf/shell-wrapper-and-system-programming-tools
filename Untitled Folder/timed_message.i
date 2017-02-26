%module TimedMessage
%{
#include <unistd.h>
#include <time.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>
extern void timed_delayed_message(int milliseconds, char * message);

%}
extern void timed_delayed_message(int milliseconds, char * message);
