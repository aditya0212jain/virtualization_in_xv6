#include<stdlib.h>
#include<stdio.h>
#include <sys/types.h> 
#include <unistd.h> 
#include<sys/wait.h>
#include <signal.h> 
#include <sys/ipc.h>
#include <sys/msg.h>
#include<string.h>
#include <math.h>
// #include <omp.h>
#include <pthread.h>
#include <sys/shm.h>
#include <sys/mman.h>


// #define N 11
// #define E 0.00001
// #define T 100.0
// #define P 6
// #define L 20000

#define STARTCHILD 0
#define CONTINUE_STOP_CHILD 1
#define GHOSTVALUE 2
#define DIFFERENCE 3
#define RETURNINGVALUES 4


#define SIGCUSTOM1 10
////////////////////////////////////////////////////
#define PERMS 0666
struct my_msgbuf {
   long mtype;
	float mfloat[4];
};
int rec_pids[8];
int msgqids[8];
////////////////////////////////////////////////////

float fabsm(float a){
	if(a<0){
		return -1*a;
	}
	return a;
}

int max(int a,int b){
	if(a>b){
		return a;
	}else{
		return b;
	}
}

int min(int a,int b){
	if(a<b){
		return a;
	}else{
		return b;
	}
}

//Helper function 

/*
	* returns the starting index of the ith process
	* n  = total elements
	* nt = number of threads
	* i = process number
*/
int getStartingForI(int n,int nt,int i){
	int divtemp = n/nt;
	int remtemp = n%nt;
	i +=1;
	if(i<=remtemp){
		return (divtemp+1)*(i-1);
	}else{
		return (divtemp)*(i-1) + remtemp;
	}
}

//Helper function #2
/*
	* Returns the number of elements alloted to 
	* the ith process
	* n  = total elements
	* nt = number of threads
	* i = process number
*/
int getNumberOfElements(int n,int nt,int i){
	i +=1;
	if(i<=n%nt){
		return n/nt+1;
	}else{
		return n/nt;
	}
}

void hello(){
	printf("SIGCUSTOM1 is raised\n");
	struct my_msgbuf buf;
	int msqid;
	int toend;
	key_t key;
	msqid = msgget(getpid(), PERMS);
	msgrcv(msqid, &buf, sizeof(buf.mfloat), 0, 0);
	// printf("recvd: \"%s\" for child %d\n", buf.mtext,getpid());
	printf("recv: \"%f\" for child %d from %f\n",buf.mfloat[0],getpid(),buf.mfloat[1]);
	_exit(0);
	return;
}

void sendToCoordinator(float diff){
	struct my_msgbuf buf;
	buf.mfloat[0] = 2;
	buf.mfloat[1] = diff;
	buf.mtype = 1;
	msgsnd(msgget(getppid(), PERMS),&buf,sizeof(buf.mfloat),0);
}

void sendMessage(int pid,int type,float* args,int n){
	struct my_msgbuf buf;
	buf.mtype = 1;
	switch (type)
	{

		case CONTINUE_STOP_CHILD:
			buf.mfloat[3] = 1;
			if(n>0){
				buf.mfloat[0] = args[0];
			}else{
				printf("sending incorrect message\n");
			}
			break;
		case STARTCHILD:
			buf.mfloat[3] = 0;
			buf.mfloat[0] = 1;
			break;
		case GHOSTVALUE:
			buf.mfloat[3] = 2;
			buf.mfloat[0] = args[0];
			buf.mfloat[1] = args[1];
			buf.mfloat[2] = args[2];
			break;
		case DIFFERENCE:
			buf.mfloat[3] = 3;
			buf.mfloat[0] = args[0];
			break;
		case RETURNINGVALUES:
			buf.mfloat[3] = 4;
			buf.mfloat[0] = args[0];
			buf.mfloat[1] = args[1];
			buf.mfloat[2] = args[2];
			break;
		default:
			printf("incorrect type %d passed by %d \n",type,getpid());
			break;
	}
	msgsnd(msgget(pid,PERMS),&buf,sizeof(buf.mfloat),0);
}


int main(int argc, char *argv[])
{
	// float start_time = omp_get_wtime();
	////////////////////////////////////////////
	int N=11;
	float E = 0.00001;
	float T = 100.0;
	int P = 2;
	int L = 20000;
	int status;
	////////////////////////////////////////////

	FILE *fd;
	fd = fopen("assig2a.inp","r");

	//Reading N
	fscanf(fd,"%d", &N);
	// printf("N = %d\n", N);

	// Getting Epsilon
	fscanf(fd,"%f", &E);
	// printf("E = %f\n", E);

	//Getting T
	fscanf(fd,"%f", &T);
	// printf("T = %f\n",T);

	//Getting P
	fscanf(fd,"%d", &P);
	// printf("P = %d\n", P);

	//Getting Limit
	fscanf(fd,"%d", &L);
	// printf("L = %d\n", L);

	fclose(fd);

	//////////////////////////

	float diff;  /* Change in Value */
	int i,j;
	float mean;
	float u[N][N];
	float w[N][N];
	float u_serial[N][N];
	float w_serial[N][N];

	int fd_cor_child[P][2];
	int fd_child_cor[P][2];

	for(int i=0;i<P;i++){
		
		if ( pipe(fd_cor_child[i]) < 0 ){
			printf("pipe 1 not created successfully");
		}
		if(pipe(fd_child_cor[i])<0){
			printf("pipe not created succesfully");
		}
	}

	int count=0;
	mean = 0.0;

	/* Set boundary values and compute mean boundary values */
	for (i = 0; i < N; i++){
		u[i][0] = u[i][N-1] = u[0][i] = T;
		u[N-1][i] = 0.0;
		mean += u[i][0] + u[i][N-1] + u[0][i] + u[N-1][i];
	}
	mean /= (4.0 * N);

	/* Initialize Interior Values */
	for (i = 1; i < N-1; i++ )
		for ( j= 1; j < N-1; j++) u[i][j] = mean;
	
	for (i = 0; i < N; i++ )
		for ( j= 0; j < N; j++) u_serial[i][j] = u[i][j];

	if(P==1){

	/* Compute Steady State Values */	
	for(;;){
		diff = 0.0;
		for(i =1 ; i < N-1; i++){
			for(j =1 ; j < N-1; j++){
				w_serial[i][j] = ( u_serial[i-1][j] + u_serial[i+1][j]+
					    u_serial[i][j-1] + u_serial[i][j+1])/4.0;
				if( fabsm(w_serial[i][j] - u_serial[i][j]) > diff )
					diff = fabsm(w_serial[i][j]- u_serial[i][j]);	
			}
		}
	    count++;
		if(diff<= E || count > L){ 
			// printf("count : %d\n",count);
			break;
		}
		for (i =1; i< N-1; i++)	
			for (j =1; j< N-1; j++) u_serial[i][j] = w_serial[i][j];
	}
	
	
		// printf("serial values :\n");
		for(i =0; i <N; i++){
			for(j = 0; j<N; j++)
				printf("%d ",((int)u_serial[i][j]));
			printf("\n");
		}
	// 	float end_time = omp_get_wtime();
	// double computation_time = ((double) (end_time - start_time));
	// printf("Computation Time %lf for %d processes \n",computation_time,P);
		return 0;
	}
	count =0;
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////CHILD PROCESS /////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	int coordinator_msg_id = msgget(getpid(), PERMS | IPC_CREAT);
	for(int i=0;i<P;i++){
		int tc = fork();
		if(tc==0){
			float buf[4];
			read(fd_cor_child[i][0],buf,sizeof(buf));
			// printf("CHILD %d : message recieved succefully %f \n",getpid(),buf[0]);
			close(fd_child_cor[i][0]);
			close(fd_cor_child[i][1]);
			// if((int)buf[0] != STARTCHILD ){
			// 	printf("received %d instead of startchild \n",buf[0]);
			// }
			int start = getStartingForI(N,P,i);
			int numA = getNumberOfElements(N,P,i);
			// printf("start : %d numA : %d for child %d \n",start,numA,getpid());
			while(1){
				////////////Send current values to neighbours//////////////////
				if(start!=0){
					///To upper neighbour 
					for(int t=1;t<N-1;t++){
						float a[3];// = new float[3];
						a[0] = 1;
						a[1] = t;
						a[2] = (float)u[start][t];
						sendMessage(getpid()-1,GHOSTVALUE,a,3);
					}
				}
				if((start+numA)!=N){
					//////To lower neighbours
					int tosend = start+numA-1;
					for(int t=1;t<N-1;t++){
						float a[3];// = new float[3];
						a[0] = -1;
						a[1] = t;
						a[2] = (float)u[tosend][t];
						sendMessage(getpid()+1,GHOSTVALUE,a,3);
					}
				}
				///////////////////Values sent////////////////////////////////////////
				/////////////////Receiving values from neighbours/////////////////////
				int msqid;
				int toend;
				msqid = msgget(getpid(), PERMS);
				if(start==0 || (start+numA)==N){
					//receive from only one neighbour
					for(int t=1;t<N-1;t++){
						struct my_msgbuf buf;
						msgrcv(msqid, &buf, sizeof(buf.mfloat), 0, 0);
						if((int)buf.mfloat[3] ==GHOSTVALUE){
							if((int)buf.mfloat[0]==1){
								//coming from lower neighbour (start==1)
								u[start+numA][(int)buf.mfloat[1]] = buf.mfloat[2];
							}else{
								//coming from upper neighbour
								u[start-1][(int)buf.mfloat[1]] = buf.mfloat[2];
							}
						}else{
							printf("Received wrong message instead of ghostvalue\n");
						}
					}
				}else{
					for(int t=1;t<=2*(N-2);t++){
						struct my_msgbuf buf;
						msgrcv(msqid, &buf, sizeof(buf.mfloat), 0, 0);
						if((int)buf.mfloat[3] == GHOSTVALUE){
							if((int)buf.mfloat[0]==1){
								//coming from lower neighbour (start==1)
								u[start+numA][(int)buf.mfloat[1]] = buf.mfloat[2];
							}else{
								//coming from upper neighbour
								u[start-1][(int)buf.mfloat[1]] = buf.mfloat[2];
							}
						}else{
							printf("Received wrong message instead of ghostvalue\n");
						}
					}
				}
				
				///////////////////////Received values///////////////////////////////////
				///////////////////////Updating values //////////////////////////////////

				float diff1 = 0.0;
				
				for(int j=max(start,1);j<min(start+numA,N-1);j++){
					for(int k=1;k<N-1;k++){
						w[j][k] = ( u[j-1][k] + u[j+1][k]+ u[j][k-1] + u[j][k+1])/4.0;
						// printf("w[%d][%d] : %f  , u[%d][%d] : %f  ,diff : %f ,child :  %d count : %d\n",j,k,w[j][k],j,k,u[j][k],diff1,getpid(),count);
						if( fabsm(w[j][k] - u[j][k]) > diff1 ){
							diff1 = fabsm(w[j][k]- u[j][k]);
						}
								
					}
				}

				////////////////////////Sending values to Coordinator////////////////////
				count++;
				float buf[4];
				float statusB = 1;
				buf[3] = DIFFERENCE;
				buf[1] = 0;
				buf[2] = 1;
				buf[0] = diff1;
				write(fd_child_cor[i][1],buf,sizeof(buf));
				// printf("CHILD %d : Sent diff %f \n",getpid(),buf[0]);
				float readbuf2[4];
				read(fd_cor_child[i][0],readbuf2,sizeof(readbuf2));
				// printf("CHILD %d : REad from parent %f %f %f %f \n",getpid(),readbuf2[0],readbuf2[1],readbuf2[2],readbuf2[3]);
				if((int)readbuf2[3]!= CONTINUE_STOP_CHILD){
					printf("received %f instead of continue or stop \n",readbuf2[3]);
				}
				if((int)readbuf2[0] == -1){
					statusB = -1;
					// printf("Break count : %d \n",count);
					break;
				}
				// if(count > L){ //diff<= E || 
				// 	break;
				// }
				for (int r =max(start,1); r< min(start+numA,N-1); r++)	
					for (int po =1; po< N-1; po++)u[r][po] = w[r][po];
				// if(count == 2) break;
			}
			
			for(int x=max(start,1);x<min(start+numA,N-1);x++){
				for(int y=1;y<N-1;y++){
					float a[4];// = new float[3];
					a[0] = x;
					a[1] = y;
					a[2] = u[x][y];
					a[3] = RETURNINGVALUES;
					// write(fd[i][1],a,sizeof(a));
					sendMessage(getppid(),RETURNINGVALUES,a,3);
				}
			}
			_exit(0);
		}
		msgqids[i] =  msgget(tc, PERMS | IPC_CREAT);
		rec_pids[i] = tc;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////COORDINATOR PROCESS/////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	////Start the threads
	for(int i=0;i<P;i++){
			close(fd_child_cor[i][1]);
			close(fd_cor_child[i][0]);
			float msg[4];
			msg[0] = 0;
			msg[1] = 0;
			msg[2] = 0;
			msg[3] = 0;
			write(fd_cor_child[i][1],msg,sizeof(msg));
	}

	int loop = 1;
	int it = 1;
	while(loop){
		float diffglobal = 0;
		float statusB=1;
		// printf("PARENT: receiving messages from childs %d \n",it);
		for(int i=0;i<P;i++){
			float buf[4];
			read(fd_child_cor[i][0],buf,sizeof(buf));
			if((int)buf[3] == DIFFERENCE){
				// printf("difference received is %f from %d in it : %d\n",buf[0],rec_pids[i],it);
				if(buf[0] >diffglobal){
					diffglobal = buf[0];
				}
			}else{
				printf("received wrong message of type %d \n",(int)buf[3]);
			}		
		}
		if(diffglobal<=E || it > L){
			statusB = -1;
			loop = 0;
		}
		// printf("Parent : Sending signal to continue or stop %d \n",it);
		for(int i=0;i<P;i++){
			float a[4];// = new float[1];
			a[0] = statusB;
			a[1] = 0;
			a[2] = 0;
			a[3] = CONTINUE_STOP_CHILD;
			// printf("PARENT : Sending %f %f %f %f to %d in %d\n",a[0],a[1],a[2],a[3],rec_pids[i],it);
			write(fd_cor_child[i][1],a,sizeof(a));
		}
		it++;
		// printf("loop done \n");
	}
	// printf("break from coordinator now waiting for values\n");
	for(int i=1;i<N-1;i++){
		for(int j=1;j<N-1;j++){
			struct my_msgbuf buf;
			// float buf[4];
			msgrcv(coordinator_msg_id, &buf, sizeof(buf.mfloat), 0, 0);
			if((int)buf.mfloat[3] == RETURNINGVALUES ){
				u[(int)buf.mfloat[0]][(int)buf.mfloat[1]] = buf.mfloat[2];
			}else{
				printf("received wrong message of type %f instead of returning values \n",buf.mfloat[3]);
			}
		}
	}
	for(int i=0;i<P;i++){
		int st;
		wait(&st);
	}
	for(i =0; i <N; i++){
		for(j = 0; j<N; j++)
			printf("%d ",((int)u[i][j]));
		printf("\n");
	}
	// printf("serial values :\n");
	// for(i =0; i <N; i++){
	// 	for(j = 0; j<N; j++)
	// 		printf("%d ",((int)u_serial[i][j]));
	// 	printf("\n");
	// }
	// int correct = 0;
	// for(int r=1;r<N-1;r++){
	// 	for(int c = 1;c<N-1;c++){
	// 		if(u[r][c] == u_serial[r][c]){
	// 			correct++;
	// 		}
	// 	}
	// }
	// printf("Correct values : %d\n",correct);
	// float end_time = omp_get_wtime();
	// double computation_time = ((double) (end_time - start_time));
	// printf("Computation Time %lf for %d processes \n",computation_time,P);
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
}