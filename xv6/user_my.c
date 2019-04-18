#include "types.h"
#include "stat.h"
#include "user.h"



int main(void)
{
	int cid[3];
	cid[0] = create_container();
	cid[1] = create_container();
	cid[2] = create_container();
	printf(1,"%d\n",cid[0]);
	printf(1,"%d\n",cid[1]);
	printf(1,"%d\n",cid[2]);
	int stat1 = join_container(cid[0]);
	int stat2 = destroy_container(cid[1]);
	// int stat3 = leave_container();
	printf(1,"Stat1 : %d\n",stat1);
	printf(1,"Stat2 : %d\n",stat2);
	// int stat3 = leave_container();
	// int stat4 = join_container(cid[1]);
	// printf(1,"Stat3 : %d\n",stat3);
	// printf(1,"Stat4 : %d\n",stat4);
	int stat5 = destroy_container(cid[0]);
	printf(1,"Stat5 : %d\n",stat5);
	// printf(1,"%d\n",destroy_container(1));
	// printf(1,"%d\n",join_container(2));
	// printf(1,"%d\n",leave_container());
	exit();
}
