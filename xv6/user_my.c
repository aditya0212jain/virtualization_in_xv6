#include "types.h"
#include "stat.h"
#include "user.h"



int main(void)
{
	int cid[3];
	int nchild = 16;
	cid[0] = create_container();
	cid[1] = create_container();
	cid[2] = create_container();
	printf(1,"%d\n",cid[0]);
	printf(1,"%d\n",cid[1]);
	printf(1,"%d\n",cid[2]);
	join_container(cid[0]);
	for(int i=0;i<nchild;i++){
		int x = fork();
		if(x==0){
			join_container(cid[i%3]);
			// ps();
			if(i%6==0){
				leave_container();
			}
			exit();
		}
	}
	sleep(5);
	ps();
	for(int i=0;i<nchild;i++){
		wait();
	}
	exit();
}
