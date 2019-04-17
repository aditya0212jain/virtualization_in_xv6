#include "types.h"
#include "stat.h"
#include "user.h"
/*
#ifndef sighandler_t
typedef void (*sighandler_t)(void);
#endif
*/

void hello(void){
    printf(1,"Hello World\n");
}

int main (void){
	// sighandler_t ignHandler = (sighandler_t) 0;
	//int pid;
    ps();
	// signal(0, ignHandler);
	signal(SIGUSR , hello);
	sleep(50);
	printf(2, "getpid is: %d\n", getpid());
    sigraise(getpid(),SIGUSR);
    // signal(SIGDFL,(sighandler_t)SIGDFL);
	//sigsend(getpid(), SIGINT);
	//kill(getpid());
	//exit();
	for(;;);    
	//kill(getpid());
	//sigsend(2, 0);
	//sigsend(2, 3);
	//sigsend(2, 1);
	
	//sigsend(2, 2);
	
	
	exit();
}