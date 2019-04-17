#include "types.h"
#include "stat.h"
#include "user.h"

int main(int argc,char *argv[]){
//   printf(1,"The size of my address space is %d bytes\n", getmysize());
    int a = atoi(argv[1]);
    int b = atoi(argv[2]);
    printf(1,"Sum: %d\n",add(a,b));
  exit();
}