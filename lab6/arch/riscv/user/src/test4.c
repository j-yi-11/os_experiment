#include "stdio.h"
#include "getpid.h"
#include "mm.h"
#include "proc.h"

int main() {
  printf("[process print start]\n");
  int ret = fork();
  if (ret == 0) {
    printf("[child process] mypid: %d\n", getpid());
  } else {
    printf("[father process] mypid: %d, child pid: %d\n", getpid(), ret);
  }
  return 0;
}