#include "param.h"

typedef unsigned int   uint;
typedef unsigned short ushort;
typedef unsigned char  uchar;
typedef uint pde_t;
//custom 
typedef void (* sighandler_t)(void);
typedef int MessageBuffer[MessageSize];


//custom added for assignment
extern int syscall_trace[38];
extern char numToCall[38][30];
extern int sys_trace;

#define MSGSIZE 16

#define NSIG    8
#define SIGIGN  0
#define SIGDFL  1
#define SIGCHLD 2
#define SIGUSR  3
#define SIGMSGSENT 4


