#include "types.h"
#include "stat.h"
#include "user.h"

void hello(void){
    char *tempM = (char *)malloc(MSGSIZE);
    recv_multi(tempM);
    printf(1,"message recieved is %s for CHILD %d\n",tempM,getpid());
}

int main(void)
{
	printf(1,"%s\n","IPC Mutlicast Test case");
	int n=5;
    int rec_pids[n];
    int ppid = getpid();

    for(int i=0;i<n;i++) // loop will run n times (n=5) 
    { 
        int tc = fork();
        if(tc == 0) 
        { 
            // printf(1,"[son] pid %d from [parent] pid %d\n",getpid(),ppid); 
            signal(SIGMSGSENT,hello);
            for(;;);
            exit();
        }
        rec_pids[i] = tc; 
    } 
    for(int i=0;i<n;i++){
        printf(1,"child %d : %d \n",i,rec_pids[i]); 
    }
    // sleep(50);
    char *msg;
    msg = "L";
    send_multi(ppid,rec_pids,(void *)msg,n);

    for(int i=0;i<n;i++) // loop will run n times (n=5) 
    wait(); 



	// int cid = fork();
	// if(cid==0){
	// 	// This is child
	// 	char *msg = (char *)malloc(MSGSIZE);
	// 	// int stat=-1;
	// 	// int i=0;
	// 	// while(i!=10000000){
	// 	// 	i++;
	// 	// }
	// 	// while(stat==-1){
	// 	recv(msg);
	// 	// }
	// 	printf(1,"2 CHILD: msg recv is: %s \n stat is : %d", msg , stat );

	// 	exit();
	// }else{
	// 	// This is parent
	// 	char *msg_child = (char *)malloc(MSGSIZE);
	// 	msg_child = "P";
	// 	send(getpid(),cid,msg_child);	
	// 	printf(1,"1 PARENT: msg sent is: %s \n", msg_child );
		
	// 	free(msg_child);
	// }
	
	exit();
}
