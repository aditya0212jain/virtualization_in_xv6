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

#define REQUEST     0
#define LOCKED      1
#define INQUIRE		2
#define RELEASE		3
#define RELINQUISH	4
#define FAILED		5
#define COMPLETE	6

#define SIGMSGRECV 	1
#define PERMS 0666
#define MAXNODESMAEKAWA 25
#define MAXQSize    100


struct request{
	long pid;
	float timeStamp;
};

int rec_pids[MAXNODESMAEKAWA];
int msgqids[MAXNODESMAEKAWA];
//below arrays shows the status of a node along with wait_queue
int FailedBit[MAXNODESMAEKAWA];
int processStatus[MAXNODESMAEKAWA]; // 0 before acquiring , 1 after acquiring , 2 after releasing
int lockedCount[MAXNODESMAEKAWA];
struct request currentLockingRequest[MAXNODESMAEKAWA];
int inquireAlreadySent[MAXNODESMAEKAWA];
int K;
int completeAndStop=0;
int time_counter = 0;
int offset;
int P;
int inquiredBy[MAXNODESMAEKAWA];

/////////////////////////////////////////////////////////////// QUEUE ////////////////////////////////////////////////////////////////////////////


typedef struct tq
{
    int size;
    struct request data[MAXQSize];
    int head;
    int tail;
} queue;

queue wait_queue[MAXNODESMAEKAWA];
queue wait_inquire_queue[MAXNODESMAEKAWA];

// queue
// createqueue(void)
// {
//     queue q;
//     // q = &temp_queue[count_q]; 
//     q.size = 0;  
//     q.tail = 0;
//     q.head = 0;
//     // count_q++;
//     return q; 
// }

int
isEmpty(queue* q)
{
    if(q->size==0)
        return 1;
    return 0;
}
  
int 
enqueue(queue* q,struct request a) 
{ 
    if (q->size==MAXQSize){
      return -1;
	//   printf("Queue full\n");
    }
    q->data[q->tail] = a; 
    q->tail = (q->tail + 1)%MAXQSize;  
	// printf("updating size\n");
    q->size = q->size + 1;
	// printf("q.size")
    return 0; 
} 

int
getQueueSize(queue* q)
{
    return q->size;
}
  
struct request 
dequeue(queue* q) 
{ 
	
    if (isEmpty(q)) {
		struct request b;
		printf("empty q dequeued\n");
		return b; 
	}
        
    struct request a = q->data[q->head]; 
    q->head = (q->head + 1)%MAXQSize; 
    q->size = q->size - 1; 
    return a; 
}

int
isFull(queue* q)
{
    if(q->size==MAXQSize){
        return 1;
    }
    return 0;
}

void removeElementQueue(queue* q,int u){
	if(q->size==0){
		return;
	}
	if(q->size == 1 ){
		if(u == q->head){
			q->head = (q->head+1)%MAXQSize;
			q->size -= 1;
			return;
		}else{
			return;
		}
	}

	if(q->head< q->tail){

		for(int i=u;i<q->tail-1;i++){
			q->data[i] = q->data[i+1];
		}
		q->tail = (q->tail-1);
		if(q->tail==-1){
			q->tail = MAXQSize-1;
		}
		q->size -= 1;

		return;

	}else{
		printf("Implement this part of the removeElementQueue\n");
		return;
	}
	
}

//////////////////////////////////////////////////////////// QUEUE ////////////////////////////////////////////////////////////////////////////////

struct pidbuffer {
   	long mtype;
	long mint[MAXNODESMAEKAWA];
};


struct msgM{
	long mtype;
	float mfloat[4];
};


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

void sendRequest(int S[],int n){
	struct msgM buf;
	buf.mtype = 1;
	buf.mfloat[0] = REQUEST;
	buf.mfloat[1] = getpid();
	// buf.mfloat[2] = omp_get_wtime();
	// buf.mfloat[2] = time_counter;
	buf.mfloat[2] = time(NULL);
	for(int l=0;l<n;l++){
		// if(S[l]!=getpid()){
			// printf("%d sending request to %d\n",getpid(),S[l]);
			msgsnd(msgget(S[l],PERMS),&buf,sizeof(buf.mfloat),0);
		// }
	}
}

void recvHandler(float f[],int i);

void acquireLockMaekawa(int S[],int n,int i){
	// printf("%d in acquireLock\n",getpid());
	
	lockedCount[i] = 0;
	sendRequest(S,n);
	time_counter++;
	// if(isEmpty(wait_queue[i])){
	// 	lockedCount[i] += 1;
	// }
	while(lockedCount[i]<K){
		struct msgM buf;
		msgrcv(msgget(getpid(),PERMS), &buf, sizeof(buf.mfloat), 0, 0);//getting all pids
		recvHandler(buf.mfloat,i);
	}
	lockedCount[i] = K;
	processStatus[i] = 1;//locked
	// printf("%d acquired the lock at time %lf\n",getpid(),omp_get_wtime());
	// printf("%d acquired the lock at time %d\n",getpid(),time_counter);
	printf("%d acquired the lock at time %ld\n",getpid(),time(NULL));
	return;
}

int precedes(struct request a, struct request b){
	if(a.timeStamp<b.timeStamp){
		return 1;
	}
	if(a.timeStamp == b.timeStamp && a.pid< b.pid){
		return 1;
	}
	return 0;
}

void recvHandler(float f[],int i){
	time_counter++;
	switch ((int)f[0])
	{
		case REQUEST:
			// printf("Recevied Request from %d in %d \n",(int)f[1],getpid());
			if(processStatus[i]!=1){
				processStatus[i] = 1;
				struct msgM buf;
				buf.mtype = 1;
				buf.mfloat[0] = LOCKED;
				buf.mfloat[1] = getpid();
				msgsnd(msgget((int)f[1],PERMS),&buf,sizeof(buf.mfloat),0);
				currentLockingRequest[i].pid = f[1];
				// time_counter = max(time_counter,(int)f[2])+1;
				// currentLockingRequest[i].timeStamp = max(time_counter,(int)f[2])+1;
				currentLockingRequest[i].timeStamp = f[2];
			}else{
				struct request req;
				req.pid = f[1];
				// time_counter = max(time_counter,(int)f[2])+1;
				// req.timeStamp = max(time_counter,(int)f[2])+1;
				req.timeStamp = f[2];
				enqueue(&wait_queue[i],req);
				// printf("%d after enqueueing %d size %d \n",getpid(),(int)f[1],wait_queue[i].size);
				int failedflag = 0;
				for(int u=0;u<getQueueSize(&wait_queue[i]);u++){
					if( precedes(wait_queue[i].data[u],req) == 1 ){
						failedflag = 1;
						break;
					}
				}
				if(precedes(currentLockingRequest[i],req) == 1 ){
					failedflag = 1;
				}
				if(failedflag == 1){
					///Send failed message 
					struct msgM buf;
					buf.mtype = 1;
					buf.mfloat[0] = FAILED;
					buf.mfloat[1] = getpid();
					msgsnd(msgget((int)f[1],PERMS),&buf,sizeof(buf.mfloat),0);
				}else{
					/// send inquire message
					struct msgM buf;
					buf.mtype =  1;
					buf.mfloat[0] = INQUIRE;
					buf.mfloat[1] = getpid();
					if(inquireAlreadySent[i] == 0 ){
						msgsnd(msgget((int)currentLockingRequest[i].pid,PERMS),&buf,sizeof(buf.mfloat),0);
					}
					inquireAlreadySent[i] = 1;
				}
			}
			break;
		case LOCKED:
			// printf("Recevied Locked from %d in %d \n",(int)f[1],getpid());
			lockedCount[i] += 1;
			FailedBit[(int)f[1]-offset - 1] = 0;
			break;

		case FAILED:
			// printf("Recevied Failed from %d in %d \n",(int)f[1],getpid());
			FailedBit[(int)f[1] - offset - 1] = 1;
			// for(int t=0;t<P;t++){
			// 	if(inquiredBy[t]==1){
			// 		struct msgM buf;
			// 		buf.mtype = 1;
			// 		buf.mfloat[0] = RELINQUISH;
			// 		buf.mfloat[1] = getpid();
			// 		lockedCount[i] -= 1;
			// 		int id = t+offset+1;;
			// 		msgsnd(msgget(id,PERMS),&buf,sizeof(buf.mfloat),0);
			// 		inquiredBy[t] = 0;
			// 	}
			// }
			break;

		case INQUIRE:
			{
			// printf("Recevied Inquire from %d in %d \n",(int)f[1],getpid());
			int flag =0;
			for(int x=0;x<P;x++){
				if(FailedBit[x]==1){
					flag = 1;
					break;
				}
			}
			if(flag == 1){
				struct msgM buf;
				buf.mtype = 1;
				buf.mfloat[0] = RELINQUISH;
				buf.mfloat[1] = getpid();
				lockedCount[i] -= 1;
				msgsnd(msgget((int)f[1],PERMS),&buf,sizeof(buf.mfloat),0);
			}
			// struct request a;
			// a.pid = f[1];
			// a.timeStamp = 0;
			// enqueue(&wait_inquire_queue[i],a);
			// inquiredBy[(int)f[1]- offset - 1] = 1;
			// else{
			// 	// if(processStatus[i] == 1){
			// 	// 	//send RELEASE after using CS
			// 	// 	// so do nothing special
			// 	// }else if(processStatus[i] == 2)
			// 	// 	//if received after sending RELEASE ignore
			// 	// }
			// }
			break;
			}

		case RELINQUISH:
			{
			// printf("Recevied Relinquish from %d in %d \n",(int)f[1],getpid());
			struct request newRequest;
			int newRindex = -1;
			newRequest = currentLockingRequest[i];
			int count =0;
			int ptr= wait_queue[i].head;

			while(count!=wait_queue[i].size){
				if(precedes(wait_queue[i].data[ptr],newRequest)){
					newRequest = wait_queue[i].data[ptr];
					newRindex = ptr;
				}
				ptr = (ptr+1)%MAXQSize;
				count++;
			}
			//newRIndex 0 for head and increases thereafter
			removeElementQueue(&wait_queue[i],newRindex);//removes newRindex th element from queue
			enqueue(&wait_queue[i],currentLockingRequest[i]);//enqueuing old request
			currentLockingRequest[i] = newRequest;//setting new locking request
			processStatus[i] = 1;
			struct msgM buf;
			buf.mtype = 1;
			buf.mfloat[0] = LOCKED;
			buf.mfloat[1] = getpid();
			msgsnd(msgget((int)newRequest.pid,PERMS),&buf,sizeof(buf.mfloat),0);
			break;
			}
		
		case RELEASE:
			// printf("Recevied Release from %d in %d \n",(int)f[1],getpid());
			if(wait_queue[i].size == 0){
				// printf("%d unlocking in release\n",getpid());
				processStatus[i] = 0;//unlocked
				struct request temp;
				temp.pid = -1;
				temp.timeStamp = INFINITY;
				currentLockingRequest[i] = temp;
			}else{
				int count =1;
				struct request newR;
				int newRindex = wait_queue[i].head;
				int ptr= wait_queue[i].head;
				newR = wait_queue[i].data[ptr];
				while(count!=wait_queue[i].size){
					ptr = (ptr+1)%MAXQSize;
					if(precedes(wait_queue[i].data[ptr],newR)){
						newR = wait_queue[i].data[ptr];
						newRindex = ptr;
					}
					count++;
				}
				removeElementQueue(&wait_queue[i],newRindex);
				currentLockingRequest[i] = newR;
				struct msgM buf;
				buf.mtype = 1;
				buf.mfloat[0] = LOCKED;
				buf.mfloat[1] = getpid();
				msgsnd(msgget((int)newR.pid,PERMS),&buf,sizeof(buf.mfloat),0);
				processStatus[i] = 1;
			}
			break;
		case COMPLETE:
			completeAndStop += 1;
			break;
	
		default:
			printf("Message Received is of type %d \n",(int)f[0]);
			break;
	}
}

void releaseLockMaekawa(int S[],int n,int i){
	for(int x=0;x<n;x++){
		struct msgM buf;
		buf.mtype = 1;
		buf.mfloat[0] = RELEASE;
		buf.mfloat[1] = getpid();
		// if(S[x] != getpid()){
			msgsnd(msgget(S[x],PERMS),&buf,sizeof(buf.mfloat),0);
		// }
	}
	// printf("%d released the lock at time %lf\n",getpid(),omp_get_wtime());
	// printf("%d released the lock at time %d\n",getpid(),time_counter);
	printf("%d released the lock at time %ld\n",getpid(),time(NULL));
	return;
}

int main(int argc, char *argv[])
{
	// float start_time = omp_get_wtime();
	////////////////////////////////////////////
	int N;
	// int P = 4;//{4,9,16,25}
	P = 4;
	int P1,P2,P3;
	////////////////////////////////////////////

	FILE *fd;
	fd = fopen("assig2b.inp","r");

	//Reading N
	fscanf(fd,"%d", &P);

	fscanf(fd,"%d", &P1);

	fscanf(fd,"%d", &P2);

	fscanf(fd,"%d", &P3);
	// printf("P = %d\n", P);
	// printf("P1 = %d\n",P1);
	// printf("P2 = %d\n",P2);
	// printf("P3 = %d\n",P3);

	fclose(fd);

	//////////////////////////
	switch (P)
	{
		case 4:	
			N = 2;
			break;
		case 9:
			N = 3;
			break;
		case 16:
			N = 4;
			break;
		case 25:
			N = 5;
			break;
		default:
			printf("Wrong Value of P given \n");
			break;
	}
	/**********************
	 * 
	 *  0  1
	 *  2  3
	 * 
	***********************/
	K = (2*N)-1;
	int S[P][K];

	for(int x=0;x<P;x++){
		int it=0;
		int rem = x%N;
		int di = x/N;
		for(int y=0; (y < P) && (it != K ) ; y++ ){
			if(y/N == di || y%N == rem){
				S[x][it] = y;
				it++;
			}
		}
	}

	int P1_list[P1];
	int P2_list[P2];
	int P3_list[P3];
	int countP=0;
	for(int we=0;we<P;we++){
		if(we<P1){
			P1_list[we] = we;
		}else if (we>=P1 && we <(P2+P1)){
			P2_list[we-P1] = we;
		}else{
			P3_list[we-P1-P2] = we;
		}
	}

	for(int u=0;u<MAXNODESMAEKAWA;u++){
		FailedBit[u] = 0;
		inquiredBy[u] = 0;
	}
	// for(int i=0;i<P2;i++){
	// 	printf("P2 %d\n",P2_list[i]);
	// }
	
	// S[0][0] = 0;
	// S[0][1] = 1;
	// S[0][2] = 2;
	// S[1][0] = 0;
	// S[1][1] = 1;
	// S[1][2] = 3;
	// S[2][0] = 0;
	// S[2][1] = 2;
	// S[2][2] = 3;
	// S[3][0] = 1;
	// S[3][1] = 2;
	// S[3][2] = 3;
	// for(int x=0;x<P;x++){
	// 	for(int y=0;y<K;y++){
	// 		printf("S[%d][%d] : %d\n",x,y,S[x][y]);
	// 	}
	// }


	/*	
		Assuming only 1 and 2 are trying to get the lock i.e. P1 = 0,3 and P2 = 1,2
	*/
	offset = getpid();
	int count =0;
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////CHILD PROCESS /////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	int coordinator_msg_id = msgget(getpid(), PERMS | IPC_CREAT);
	for(int i=0;i<P;i++){
		int tc = fork();
		if(tc==0){
			FailedBit[i]  = 0;// no failed message recieved in the beginning
			// printf("%d is %d \n",getpid(),getpid()-offset-1);
			processStatus[i] = 0;//unlocked
			lockedCount[i] = 0;//no members locked in the beginning
			struct pidbuffer pids;
			msgrcv(msgget(getpid(),PERMS), &pids, sizeof(pids.mint), 0, 0);//getting all pids
			completeAndStop = P1;
			int whichP=0;
			if(i<P1){
				whichP = 1;
			}else if(i>=P1 && i<(P1+P2)){
				whichP = 2;
			}else{
				whichP = 3;
			}
			if(whichP>1){
				int STemp[K];
				for(int qw=0;qw<K;qw++){
					STemp[qw] = pids.mint[S[i][qw]];
					// printf("%d\n",STemp[qw]);
				}
				acquireLockMaekawa(STemp,K,i);
				if(whichP==2){
					sleep(2);
				}
				releaseLockMaekawa(STemp,K,i);
				for(int po=0;po<P;po++){
					struct msgM buf;
					buf.mtype = 1;
					buf.mfloat[0] = COMPLETE;
					buf.mfloat[1] = getpid();
					msgsnd(msgget(pids.mint[po],PERMS),&buf,sizeof(buf.mfloat),0);
				}
			}
			while(completeAndStop<P){
				struct msgM buf;
				msgrcv(msgget(getpid(),PERMS), &buf, sizeof(buf.mfloat), 0, 0);//getting all pids
				recvHandler(buf.mfloat,i);
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
	
	
	for(int j=0;j<P;j++){
		struct pidbuffer buf;
		buf.mtype = 1;
		for(int i=0;i<P;i++){
			buf.mint[i] = rec_pids[i];
		}
		msgsnd(msgget(rec_pids[j],PERMS),&buf,sizeof(buf.mint),0);
	}

	for(int i=0;i<P;i++){
		int st;
		wait(&st);
	}
	// float end_time = omp_get_wtime();
	// double computation_time = ((double) (end_time - start_time));
	// printf("Computation Time %lf for %d processes \n",computation_time,P);
}