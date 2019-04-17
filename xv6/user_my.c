#include "types.h"
#include "stat.h"
#include "user.h"



int main(void)
{
	printf(1,"%s\n","IPC Test case");
	
	int cid = fork();
	if(cid==0){
		// This is child
		char *msg = (char *)malloc(MessageSize);
		int stat = recv(msg);
		int *a;
		a =(int *)msg;
		printf(1,"2 CHILD: msg recv is: %d \n stat is : %d\n", *a , stat );
		exit();
	}else{
		// This is parent
		char *msg_child = (char *)malloc(MessageSize);
		msg_child = "P";
		int a = 4545;
		send(getpid(),cid,&a);	
		printf(1,"1 PARENT: msg sent is: %s \n", msg_child );
		free(msg_child);
	}
	wait();
	exit();
}
