#include "types.h"
#include "stat.h"
#include "user.h"

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
//    char mtext[200];
	float mfloat[4];
};
int rec_pids[8];
int msgqids[8];

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

int readInt(int fd){
	int N=0;
	char c;
	int alpha;
	while(1){
		read(fd, &c, 1);
		if(c == '\n'){
		break;
		}
		alpha = c-'0';
		N = 10*N + alpha;
	}
	return N;
}

float readFloat(int fd){
	float E=0.0;
	int count11;
	int decimal = 0;
	int temp;
	char c;
	while(1){
		read(fd, &c, 1);
		if(c == '\n')
			break;
		if(c == '.'){
			decimal = 1;
			count11 = 0;
		}
		if(decimal == 0){
			temp = c-'0';
			E = 10*E+temp;
		}
		else if(decimal == 1 && c!='.'){
			count11++;
			temp = c-'0';
			int divisor=1;
			for(int i=0; i<count11; i++){
				divisor *= 10;
			}
			float tt = (float)temp/divisor;
			E = E + tt;
		}
	}
	return E;
}




int main(void)
{
	////////////////////////////////////////////
	int N=0;
	float E = 0.0;
	float T = 0.0;
	int P = 0;
	int L = 0;
	// int status;
	////////////////////////////////////////////

	//Taking Input from the file
  	char *filename;
	filename = "assig2a.inp";
	int fd = open(filename, 0);
	//Reading N
	// int alpha;
	// while(1){
	// 	read(fd, &c, 1);
	// 	if(c == '\n'){
	// 	break;
	// 	}
	// 	alpha = c-'0';
	// 	N = 10*N + alpha;
	// }
	N = readInt(fd);
	E = readFloat(fd);
	T = readFloat(fd);
	P = readInt(fd);
	L = readInt(fd);

	close(fd);

	////////////////////////////////////Input above


	float diff;  /* Change in Value */
	int i,j;
	float mean;
	float u[N][N];
	float w[N][N];
	float u_serial[N][N];
	float w_serial[N][N];

	int fd_cor_child[P][2];
	int fd_child_cor[P][2];
	int child_sends_lower[P][2];
	int child_sends_upper[P][2];

	for(int i=0;i<P;i++){
		
		if ( pipe(fd_cor_child[i]) < 0 ){
			printf(1,"pipe 1 not created successfully");
		}
		if(pipe(fd_child_cor[i])<0){
			printf(1,"pipe not created succesfully");
		}
		if(pipe(child_sends_lower[i]) < 0 ){
			printf(1,"pipe 3 not created successfully");
		}
		if(pipe(child_sends_upper[i]) < 0 ){
			printf(1,"pipe 4 not created successfully");
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

		// printf(1,"serial values :\n");
		for(i =0; i <N; i++){
			for(j = 0; j<N; j++)
				printf(1,"%d ",((int)u_serial[i][j]));
			printf(1,"\n");
		}

		exit();

	}
	count =0;
	// printf("Starting the process\n");
	// printf("Sh : %ld \n",(long int)shmpointer);
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////CHILD PROCESS /////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	// int coordinator_msg_id = msgget(getpid(), PERMS | IPC_CREAT);
    int coordinator_id  = getpid();
	for(int i=0;i<P;i++){
		int tc = fork();
		if(tc==0){
			float buf[4];
			read(fd_cor_child[i][0],buf,sizeof(buf));
			// printf(1,"CHILD %d : message recieved succefully %d \n",getpid(),(int)buf[0]);
			// close(fd_child_cor[i][0]);
			// close(fd_cor_child[i][1]);
			// if((int)buf[0] != STARTCHILD ){
			// 	printf("received %d instead of startchild \n",buf[0]);
			// }
			int start = getStartingForI(N,P,i);
			int numA = getNumberOfElements(N,P,i);
			// printf("start : %d numA : %d for child %d \n",start,numA,getpid());
			while(1){
				////////////Send current values to neighbours//////////////////
				count++;
				// printf(1,"CHILD %d, ghost %d\n",getpid(),count);
				if(start!=0){
					///To upper neighbour 
					for(int t=1;t<N-1;t++){
						float a[4];// = new float[3];
						a[0] = 1;
						a[1] = t;
						a[2] = (float)u[start][t];
                        a[3] = GHOSTVALUE;
						// sendMessage(getpid()-1,GHOSTVALUE,a,3);
                        // send(getpid(),getpid()-1,a);
						write(child_sends_upper[i][1],a,sizeof(a));
					}
				}
				if((start+numA)!=N){
					//////To lower neighbours
					int tosend = start+numA-1;
					for(int t=1;t<N-1;t++){
						float a[4];// = new float[3];
						a[0] = -1;
						a[1] = t;
						a[2] = (float)u[tosend][t];
                        a[3] = GHOSTVALUE;
						// sendMessage(getpid()+1,GHOSTVALUE,a,3);
                        // send(getpid(),getpid()+1,a);
						write(child_sends_lower[i][1],a,sizeof(a));
					}
				}
				///////////////////Values sent////////////////////////////////////////
				/////////////////Receiving values from neighbours/////////////////////
				// printf(1,"CHILD %d : receiving current values\n",getpid());
				if(start==0){
					//receive only from lower child
					for(int t=1;t<N-1;t++){
						float buf[4];
						// msgrcv(msqid, &buf, sizeof(buf.mfloat), 0, 0);
						read(child_sends_upper[i+1][0],buf,sizeof(buf));
                        // recv(buf);
						if((int)buf[3] ==GHOSTVALUE){
							if((int)buf[0]==1){
								//coming from lower neighbour (start==1)
								u[start+numA][(int)buf[1]] = buf[2];
							}else{
								//coming from upper neighbour
								u[start-1][(int)buf[1]] = buf[2];
							}
						}else{
							printf(1,"Received wrong message instead of ghostvalue\n");
						}
					}
				}
				else if(start+numA == N){
					for(int t=1;t<N-1;t++){
						float buf[4];
						// msgrcv(msqid, &buf, sizeof(buf.mfloat), 0, 0);
						read(child_sends_lower[i-1][0],buf,sizeof(buf));
                        // recv(buf);
						if((int)buf[3] ==GHOSTVALUE){
							if((int)buf[0]==1){
								//coming from lower neighbour (start==1)
								u[start+numA][(int)buf[1]] = buf[2];
							}else{
								//coming from upper neighbour
								u[start-1][(int)buf[1]] = buf[2];
							}
						}else{
							printf(1,"Received wrong message instead of ghostvalue\n");
						}
					}
				}else{
					//receive from both sides
					for(int t=1;t<N-1;t++){
						float buf[4];
						// msgrcv(msqid, &buf, sizeof(buf.mfloat), 0, 0);
						read(child_sends_upper[i+1][0],buf,sizeof(buf));
                        // recv(buf);
						if((int)buf[3] ==GHOSTVALUE){
							if((int)buf[0]==1){
								//coming from lower neighbour (start==1)
								u[start+numA][(int)buf[1]] = buf[2];
							}else{
								//coming from upper neighbour
								u[start-1][(int)buf[1]] = buf[2];
							}
						}else{
							printf(1,"Received wrong message instead of ghostvalue\n");
						}
					}
					for(int t=1;t<N-1;t++){
						float buf[4];
						// msgrcv(msqid, &buf, sizeof(buf.mfloat), 0, 0);
						read(child_sends_lower[i-1][0],buf,sizeof(buf));
                        // recv(buf);
						if((int)buf[3] ==GHOSTVALUE){
							if((int)buf[0]==1){
								//coming from lower neighbour (start==1)
								u[start+numA][(int)buf[1]] = buf[2];
							}else{
								//coming from upper neighbour
								u[start-1][(int)buf[1]] = buf[2];
							}
						}else{
							printf(1,"Received wrong message instead of ghostvalue\n");
						}
					}
				}
				
				///////////////////////Received values///////////////////////////////////
				///////////////////////Updating values //////////////////////////////////
				// printf(1,"CHILD %d : Updated %d \n",getpid(),count);
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
				
				float buf[4];
				// float statusB = 1;
				buf[3] = DIFFERENCE;
				buf[1] = 0;
				buf[2] = 1;
				buf[0] = diff1;
				// printf(1,"CHILD %d : sending to coordi\n",getpid());
				// printf(1,"CHILD %d : sending %d\n",getpid(),count);
				write(fd_child_cor[i][1],buf,sizeof(buf));
				// send(getpid(),coordinator_id,buf);
				// printf("CHILD %d : Sent diff %f \n",getpid(),buf[0]);
				float readbuf2[4];
				// printf(1,"CHILD %d : rfc %d \n",getpid(),count);
				read(fd_cor_child[i][0],readbuf2,sizeof(readbuf2));
				// printf(1,"CHILD %d : received %d\n",getpid(),count);
				// printf("CHILD %d : REad from parent %f %f %f %f \n",getpid(),readbuf2[0],readbuf2[1],readbuf2[2],readbuf2[3]);
				if((int)readbuf2[3]!= CONTINUE_STOP_CHILD){
					printf(1,"received %f instead of continue or stop \n",readbuf2[3]);
				}
				if((int)readbuf2[0] == -1){
					// statusB = -1;
					// printf("Break count : %d \n",count);
					break;
				}
				for (int r =max(start,1); r< min(start+numA,N-1); r++)	
					for (int po =1; po< N-1; po++)u[r][po] = w[r][po];
				// if(count == 2) break;
			}
			// printf(1,"CHILD %d, break\n",getpid());
			for(int x=max(start,1);x<min(start+numA,N-1);x++){
				for(int y=1;y<N-1;y++){
					float a[4];// = new float[3];
					a[0] = x;
					a[1] = y;
					a[2] = u[x][y];
					a[3] = RETURNINGVALUES;
					// write(fd[i][1],a,sizeof(a));
					// sendMessage(getppid(),RETURNINGVALUES,a,3);
                    send(getpid(),coordinator_id,a);
				}
			}
			exit();
		}
		// msgqids[i] =  msgget(tc, PERMS | IPC_CREAT);
		rec_pids[i] = tc;
	}

	// //////////////////////////////////////////////////////////////////////////////////////////////////////////
	// //////////////////////////////////COORDINATOR PROCESS/////////////////////////////////////////////////////
	// //////////////////////////////////////////////////////////////////////////////////////////////////////////
	// ////Start the threads
	for(int i=0;i<P;i++){
			// close(fd_child_cor[i][1]);
			// close(fd_cor_child[i][0]);
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
		// printf(1,"PARENT: rfc %d \n",it);
		for(int i=0;i<P;i++){
			float buf[4];
			read(fd_child_cor[i][0],buf,sizeof(buf));
			// recv(buf);
			if((int)buf[3] == DIFFERENCE){
				// printf(1,"PARENT: from %d in it : %d\n",rec_pids[i],it);
				if(buf[0] >diffglobal){
					diffglobal = buf[0];
				}
			}else{
				printf(1,"received wrong message of type %d \n",(int)buf[3]);
			}		
		}
		if(diffglobal<=E || it > L ){
			statusB = -1;
			loop = 0;
		}
		// printf(1,"Parent : Ss %d \n",it);
		for(int i=0;i<P;i++){
			float a[4];// = new float[1];
			a[0] = statusB;
			a[1] = 0;
			a[2] = 0;
			a[3] = CONTINUE_STOP_CHILD;
			// printf(1,"PARENT : Sending %d %d %d %d to %d in %d\n",(int)a[0],(int)a[1],(int)a[2],(int)a[3],rec_pids[i],it);
			write(fd_cor_child[i][1],a,sizeof(a));
		}
		it++;
		// printf("loop done \n");
	}
	// printf(1,"PARENT : break from coordinator now waiting for values\n");
	for(int i=1;i<N-1;i++){
		for(int j=1;j<N-1;j++){
			// struct my_msgbuf buf;
			float buf[4];
            recv(buf);
			// msgrcv(coordinator_msg_id, &buf, sizeof(buf.mfloat), 0, 0);
			if((int)buf[3] == RETURNINGVALUES ){
				u[(int)buf[0]][(int)buf[1]] = buf[2];
			}else{
				printf(1,"received wrong message of type %f instead of returning values \n",buf[3]);
			}
		}
	}
	for(int i=0;i<P;i++){
		// int st;
		wait();
	}
	for(i =0; i <N; i++){
		for(j = 0; j<N; j++)
			printf(1,"%d ",((int)u[i][j]));
		printf(1,"\n");
	}
	// printf(1,"serial values :\n");
	// for(i =0; i <N; i++){
	// 	for(j = 0; j<N; j++)
	// 		printf(1,"%d ",((int)u_serial[i][j]));
	// 	printf(1,"\n");
	// }
	// int correct = 0;
	// for(int r=1;r<N-1;r++){
	// 	for(int c = 1;c<N-1;c++){
	// 		if((int)u[r][c] == (int)u_serial[r][c]){
	// 			correct++;
	// 		}
	// 	}
	// }
	// printf(1,"Correct values : %d\n",correct);
    exit();
}