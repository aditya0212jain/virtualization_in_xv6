#include "types.h"
#include "stat.h"
#include "user.h"

const int nchild = 8;
static int computeSquares[64]={0};
// int meanAll[64] = {0};
int rec_pids[8];

static int meanA = 0;

//Helper function #1
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
int getOverHeadBlock(int n,int nt,int i){
	i +=1;
	if(i<=n%nt){
		return n/nt+1;
	}else{
		return n/nt;
	}
}

void hello(void){
    // printf(1,"signal received in pid %d\n",getpid());
    computeSquares[getpid()] = 1;
    // change_state(1);
    int *a ;
    int temp =1;
    a = &temp;
    // printf(1,"Receiving final partial sums now \n");
    recv_multi((void *)a);
    // meanAll[getpid()] = *a;
    meanA = *a;
}

int
main(int argc, char *argv[])
{
	if(argc< 2){
		printf(1,"Need type and input filename\n");
		exit();
	}
	char *filename;
	filename=argv[2];
	int type = atoi(argv[1]);
	// printf(1,"Type is %d and filename is %s\n",type, filename);

	int tot_sum = 0;	
	float variance = 0.0;
    int actual_sum =0;

	int size=1000;
	short arr[size];
	char c;
	int fd = open(filename, 0);
	for(int i=0; i<size; i++){
		read(fd, &c, 1);
		arr[i]=c-'0';
		read(fd, &c, 1);
        actual_sum += arr[i];
	}	
  	close(fd);
  	// this is to supress warning
  	// printf(1,"first elem %d\n", arr[0]);
    // printf(1,"Actual sum: %d\n",actual_sum);
    int mean = actual_sum/size;
    int sum1 = 0;
    for(int i=0;i<size;i++){
        sum1 += (arr[i] - mean)*(arr[i] - mean);
    }
    sum1 = sum1/size;
    // printf(1,"Actual variance is %d\n",sum1);
  
  	//----FILL THE CODE HERE for unicast sum and multicast variance

    
    int coordinator_id = getpid();
    

    int partial_sum =0;
    int squaredS = 0;

    for(int i=0;i<nchild;i++){
        int tc = fork();
        if(tc == 0) 
        { 
            signal(SIGMSGSENT,hello);
            
            void *msg1,*msg2;
            int *a,*b;
            int temp=1,temp2=1;
            a = &temp;
            b = &temp2;
            msg1 = (void *)a;
            msg2 = (void *)b;
            recv(msg1);
            int *start,*end;
            start = &temp;
            end = &temp;
            start = (int *)msg1;
            recv(msg2);
            end = (int *)msg2;
            for(int i = *start ;i < *end; i++){
                partial_sum +=arr[i];
            }
            // printf(1,"Exiting child %d with partial sum %d\n",getpid(),partial_sum);
            send(getpid(),coordinator_id,&partial_sum);
            
            
            if(type!=0){
                // printf(1,"r");
                while(computeSquares[getpid()]==0){}
                
                
                for(int i = *start ;i < *end; i++){
                    squaredS += (arr[i] - meanA)*(arr[i] - meanA);
                }
                send(getpid(),coordinator_id,&squaredS);

            }




            /***
             * 
             * 
             *  Code for the dynamic with chunk size 1 type schedule
            void *msg1;
            int *a;
            int temp=1;
            a = &temp;
            msg1 = (void *)a;
            int t=0;
            
            while(1){
                recv(msg1);
                a = (int *)msg1;
                int temp_n = *a;
                // printf(1,"Child %d : Received : %d\n",getpid(),temp_n);
                if(temp_n<0){
                    break;
                }else{
                    partial_sum = partial_sum + temp_n;
                    // printf(1,"Partial sum now %d for Child %d \n",partial_sum,getpid());
                }
                t++;
            }   
            printf(1,"Exiting child %d with partial sum %d\n",getpid(),partial_sum);
            // printf(1,"A sent : %d \n ",&partial_sum);
            send(getpid(),coordinator_id,&partial_sum);
            *
            * 
            */
            exit();
        }
        rec_pids[i] = tc;
    }
    for(int i=0;i<nchild;i++){
        // printf(1,"child %d : %d \n",i,rec_pids[i]); 
        int po = getStartingForI(size,nchild,i);
        int end = po+getOverHeadBlock(size,nchild,i);
        send(getpid(),rec_pids[i],&po);
        send(getpid(),rec_pids[i],&end);
    }
    /**
     * 
     * 
     * Code for dynamic parent
    ps();
    sleep(50);
    int l=0,k=0;
    while(l!=1000){
        int t = arr[l];
        send(getpid(),rec_pids[k],&t);
        k = (k+1)%nchild;
        l++;
    }
    int end=-1;
    for(int i=0;i<nchild;i++){
        // printf(1,"ith : %d\n",i);   
        send(getpid(),rec_pids[i],&end);
    }
    *
    * 
    */


    int sum =0;
    for(int i=0;i<nchild;i++){
        int *a ;
        int temp =1;
        a = &temp;
        recv((void *)a);
        sum += *a;
    }

    if(type != 0){
        int mean ;
        mean = sum/size;
        send_multi(coordinator_id,rec_pids,&mean,nchild);
        int square_difference_sum = 0;
        for(int i=0;i<nchild;i++){
            int *a ;
            int temp =1;
            a = &temp;
            recv((void *)a);
            square_difference_sum += *a;
        }
        // printf(1,"Square difference sum is %d \n",square_difference_sum);
        variance = square_difference_sum/size;
    }

    for(int i=0;i<nchild;i++){
        wait();
    }
    tot_sum = sum;
  	//------------------

  	if(type==0){ //unicast sum
		printf(1,"Sum of array for file %s is %d\n", filename,tot_sum);
	}
	else{ //mulicast variance
		printf(1,"Variance of array for file %s is %d\n", filename,(int)variance);
	}
	exit();
}
