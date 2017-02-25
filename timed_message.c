#include <unistd.h>
#include <time.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

// void timed_delayed_message(int milliseconds, char * message);
// int main (int argc,char ** argv){
//   int msecond=atoi(argv[1]);
//   char * message=argv[2];
//   // printf("%d\n",msecond );
//   // printf("%s\n",message );
//   timed_delayed_message(msecond,message);
// }

void timed_delayed_message(int milliseconds, char * message){
  pid_t pid=fork();
  if(pid!=0) exit(0);
  struct timespec ts;
  ts.tv_sec=milliseconds/1000;
  ts.tv_nsec=(milliseconds%1000)*1000000;
  nanosleep(&ts,NULL);
  printf("%s\n", message);
}
