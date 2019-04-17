#include "types.h"
#include "stat.h"
#include "user.h"

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
int processStatus; // 0 before acquiring , 1 after acquiring , 2 after releasing
int lockedCount;
struct request currentLockingRequest;
int pendingInquire[MAXNODESMAEKAWA];
int K;
int completeAndStop=0;
int time_counter = 0;

int childPipe[25][2];
int masterPipe[2];

int offset=0;

/////////////////////////////////////////////////////////////// QUEUE ////////////////////////////////////////////////////////////////////////////


typedef struct tqrequest
{
    int size;
    struct request data[MAXQSize];
    int head;
    int tail;
} queueRequest;

queueRequest wait_queue[MAXNODESMAEKAWA];

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
isEmptyRequestQueue(queueRequest* q)
{
    if(q->size==0)
        return 1;
    return 0;
}
  
int 
enqueueRequestQueue(queueRequest* q,struct request a) 
{ 
    if (q->size==MAXQSize){
      return -1;
	//   printf(1,"Queue full\n");
    }
    q->data[q->tail] = a; 
    q->tail = (q->tail + 1)%MAXQSize;  
	// printf(1,"updating size\n");
    q->size = q->size + 1;
	// printf(1,"q.size")
    return 0; 
} 

int
getRequestQueueSize(queueRequest* q)
{
    return q->size;
}
  
struct request 
dequeueRequestQueue(queueRequest* q) 
{ 
	
    if (isEmptyRequestQueue(q)) {
		struct request b;
		printf(1,"empty q dequeued\n");
		return b; 
	}
        
    struct request a = q->data[q->head]; 
    q->head = (q->head + 1)%MAXQSize; 
    q->size = q->size - 1; 
    return a; 
}

int
isFullRequestQueue(queueRequest* q)
{
    if(q->size==MAXQSize){
        return 1;
    }
    return 0;
}

void removeElementRequestQueue(queueRequest* q,int u){
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
		printf(1,"Implement this part of the removeElementQueue\n");
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

void sendRequest(int S[],int n){
	float buf[4];
	buf[0] = REQUEST;
	buf[1] = getpid();
	// buf.mfloat[2] = omp_get_wtime();
	buf[2] = uptime();
	for(int l=0;l<n;l++){
		write(childPipe[S[l]-offset-1][1],buf,sizeof(buf));
		
	}
}

void recvHandler(float f[],int i);

void acquireLockMaekawa(int S[],int n,int i){
	// printf(1,"%d in acquireLock\n",getpid());
	
	lockedCount = 0;
	sendRequest(S,n);
	while(lockedCount<K){
		float buf[4];
		read(childPipe[getpid()-offset-1][0],buf,sizeof(buf));
		recvHandler(buf,i);
	}
	lockedCount = K;
	processStatus = 1;//locked
	// printf(1,"%d acquired the lock at time %lf\n",getpid(),omp_get_wtime());
	printf(1,"%d acquired the lock at time %d\n",getpid(),uptime());
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
	switch ((int)f[0])
	{
		case REQUEST:
			// printf(1,"Recevied Request from %d in %d \n",(int)f[1],getpid());
			if(processStatus!=1){
				processStatus = 1;
				float buf[4];
				buf[0] = LOCKED;
				buf[1] = getpid();
				write(childPipe[(int)f[1] - offset - 1][1],buf,sizeof(buf));
				currentLockingRequest.pid = f[1];
				// currentLockingRequest.timeStamp = max(time_counter,(int)f[2])+1;
				currentLockingRequest.timeStamp = f[2];
			}else{
				struct request req;
				req.pid = f[1];
				// time_counter = max(time_counter,(int)f[2])+1;
				// req.timeStamp = max(time_counter,(int)f[2])+1;
				req.timeStamp = f[2];
				enqueueRequestQueue(&wait_queue[i],req);
				int failedflag = 0;
				for(int u=0;u<getRequestQueueSize(&wait_queue[i]);u++){
					if( precedes(wait_queue[i].data[u],req) == 1 ){
						failedflag = 1;
						break;
					}
				}
				if(precedes(currentLockingRequest,req) == 1 ){
					failedflag = 1;
				}
				if(failedflag == 1){
					///Send failed message 
					float buf[4];
					buf[0] = FAILED;
					buf[1] = getpid();
					write(childPipe[(int)f[1] - offset -1][1],buf,sizeof(buf));
				}else{
					/// send inquire message
					float buf[4];
					buf[0] = INQUIRE;
					buf[1] = getpid();
					if(pendingInquire[i] == 0 ){
						write(childPipe[(int)currentLockingRequest.pid - offset - 1][1],buf,sizeof(buf));
						// send(getpid(),(int)currentLockingRequest.pid,buf.mfloat);
					}
				}
			}
			break;
		case LOCKED:
			// printf(1,"Recevied Locked from %d in %d \n",(int)f[1],getpid());
			lockedCount += 1;
			break;

		case FAILED:
			// printf(1,"Recevied Failed from %d in %d \n",(int)f[1],getpid());
			// if(pendingInquire[i]>0){
			// 	float buf[4];
			// 	buf[0] = RELINQUISH;
			// 	buf[1] = getpid();
			// 	lockedCount -= 1;
			// 	write(childPipe[(int)pendingInquire[i] - offset -1][1], buf, sizeof(buf));
			// }
			FailedBit[i] = 1;
			break;

		case INQUIRE:
			// printf(1,"Recevied Inquire from %d in %d \n",(int)f[1],getpid());
			if(FailedBit[i] == 1){
				float buf[4];
				buf[0] = RELINQUISH;
				buf[1] = getpid();
				lockedCount -= 1;
				write(childPipe[(int)f[1] - offset -1][1], buf, sizeof(buf));
				// pendingInquire[i] = 0;
			}
			// else{
			// 	pendingInquire[i] = f[1];
			// }

			// else{
			// 	// if(processStatus == 1){
			// 	// 	//send RELEASE after using CS
			// 	// 	// so do nothing special
			// 	// }else if(processStatus == 2)
			// 	// 	//if received after sending RELEASE ignore
			// 	// }
			// }
			break;

		case RELINQUISH:
			{
			// printf(1,"Recevied Relinquish from %d in %d \n",(int)f[1],getpid());
			struct request newRequest;
			int newRindex = -1;
			newRequest = currentLockingRequest;
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
			removeElementRequestQueue(&wait_queue[i],newRindex);//removes newRindex th element from queue
			enqueueRequestQueue(&wait_queue[i],currentLockingRequest);//enqueuing old request
			currentLockingRequest = newRequest;//setting new locking request
			processStatus = 1;
			float buf[4];
			buf[0] = LOCKED;
			buf[1] = getpid();
			write(childPipe[(int)newRequest.pid - offset -1 ][1],buf,sizeof(buf));
			break;
			}
		
		case RELEASE:
			// printf(1,"Recevied Release from %d in %d \n",(int)f[1],getpid());
			if(wait_queue[i].size == 0){
				processStatus = 0;//unlocked
				struct request temp;
				temp.pid = -1;
				temp.timeStamp = -1;
				currentLockingRequest = temp;
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
				removeElementRequestQueue(&wait_queue[i],newRindex);
				currentLockingRequest = newR;
				float buf[4];
				buf[0] = LOCKED;
				buf[1] = getpid();
				write(childPipe[(int)newR.pid - offset -1 ][1],buf,sizeof(buf));
				processStatus = 1;
			}
			break;
		case COMPLETE:
			completeAndStop += 1;
			break;
	
		default:
			printf(1,"Message Received is of type %d \n",(int)f[0]);
			break;
	}
}

void releaseLockMaekawa(int S[],int n,int i){
	for(int x=0;x<n;x++){
		float buf[4];
		buf[0] = RELEASE;
		buf[1] = getpid();
		write(childPipe[S[x] - offset -1 ][1],buf,sizeof(buf));
	}
	// completeAndStop = 0;
	// FailedBit[i] = 0;
	// processStatus = 0;
	// lockedCount = 0;
	// pendingInquire[i] = 0;
	printf(1,"%d released the lock at time %d\n",getpid(),uptime());
	return;
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

int main(int argc, char *argv[])
{
	// float start_time = omp_get_wtime();
	////////////////////////////////////////////
	int N;
	int P = 16;//{4,9,16,25}
	int P1,P2,P3;
	////////////////////////////////////////////
		//Taking Input from the file
  	char *filename;
	filename = "assig2b.inp";
	int fd = open(filename, 0);

	P = readInt(fd);
	P1 = readInt(fd);
	P2 = readInt(fd);
	P3 = readInt(fd);
	
	close(fd);

	/////////////////////////////////////////////

	pipe(masterPipe);

	for(int i=0;i<P;i++){
		if(pipe(childPipe[i])<0){
			printf(1,"Pipe not created Successfully\n");
		};
	}

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
			printf(1,"Wrong Value of P given \n");
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

	// printf(1,"Started\n");
	offset = getpid();
	// int P1_list[P1];
	// int P2_list[P2];
	// int P3_list[P3];
	// for(int we=0;we<P;we++){
	// 	if(we<P1){
	// 		P1_list[we] = we;
	// 	}else if (we>=P1 && we <(P2+P1)){
	// 		P2_list[we-P1] = we;
	// 	}else{
	// 		P3_list[we-P1-P2] = we;
	// 	}
	// }
	// for(int i=0;i<P2;i++){
	// 	printf(1,"P2 %d\n",P2_list[i]);
	// }

	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////CHILD PROCESS /////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	for(int i=0;i<P;i++){
		int tc = fork();
		if(tc==0){
			FailedBit[i]  = 0;// no failed message recieved in the beginning
			processStatus = 0;//unlocked
			lockedCount = 0;//no members locked in the beginning
			// struct pidbuffer pids;
			int pids[25];
			read(childPipe[i][0],pids,sizeof(pids));
			// recv(pids);
			// msgrcv(msgget(getpid(),PERMS), &pids, sizeof(pids.mint), 0, 0);//getting all pids
			completeAndStop = P1;
			int whichP=0;
			if(i<P1){
				whichP = 1;
			}else if(i>=P1 && i<(P1+P2)){
				whichP = 2;
			}else if(i<(P1+P2+P3)){
				whichP = 3;
			}
			if(whichP>1){
				int STemp[K];
				for(int qw=0;qw<K;qw++){
					STemp[qw] = pids[S[i][qw]];//pids.mint[S[i][qw]]
					// printf(1,"%d\n",STemp[qw]);
				}
				acquireLockMaekawa(STemp,K,i);
				if(whichP==2){
					sleep(2000);
				}
				releaseLockMaekawa(STemp,K,i);
				for(int po=0;po<P;po++){
					float buf[4];
					buf[0] = COMPLETE;
					buf[1] = getpid();
					write(childPipe[po][1],buf,sizeof(buf));
				}
			}
			while(completeAndStop<P){
				float buf[4];
				read(childPipe[i][0],buf,sizeof(buf));
				// recv(buf);
				recvHandler(buf,i);
			} 
			exit();
		}
		rec_pids[i] = tc;
	}

	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////COORDINATOR PROCESS/////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	////Start the threads
	
	
	for(int j=0;j<P;j++){
		int buf[25];
		for(int i=0;i<P;i++){
			buf[i] = rec_pids[i];
		}
		write(childPipe[rec_pids[j] - offset-1][1],buf,sizeof(buf));
	}

	for(int i=0;i<P;i++){	
		wait();
	}
	exit();

	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
}