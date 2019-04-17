#include "types.h"
#include "defs.h"
#include "param.h"
#include "mmu.h"
#include "proc.h"
#include "fs.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "file.h"


MessageBuffer message_buffer[NUMOFMESSAGEBUFFERS];

int from_array[NUMOFMESSAGEBUFFERS]={0};

int free_message_buffer;

// int message_queue_allocated[NUMOFMESSAGEQUEUES];

queue* message_queue[NUMOFMESSAGEQUEUES];

struct spinlock queue_lock[NUMOFMESSAGEQUEUES];
struct spinlock free_message_buffer_lock;
struct spinlock message_buffer_lock[NUMOFMESSAGEBUFFERS];


// struct WaitQueueItem {
//   Pid pid;     
//   char * buffer;
// };

// Queue<WaitQueueItem *> *wait_queue[NUMOFMESSAGEQUEUES];

int GetMessageBuffer( void ) { 
  // get the head of the free list
  acquire(&free_message_buffer_lock);
  int msg_no = free_message_buffer;
  acquire(&message_buffer_lock[msg_no]);
  if( msg_no != -1 ) {
    // follow the link to the next buffer
    free_message_buffer = message_buffer[msg_no][0];
  }
  release(&message_buffer_lock[msg_no]);
  release(&free_message_buffer_lock);
  return msg_no;
}

void FreeMessageBuffer( int msg_no ) {
  acquire(&free_message_buffer_lock);
  acquire(&message_buffer_lock[msg_no]);
  message_buffer[msg_no][0] = free_message_buffer;
  free_message_buffer = msg_no;
  release(&message_buffer_lock[msg_no]);
  release(&free_message_buffer_lock);
}

void
messageinit(void)
{
    char *a;
    a = "msg";
    for(int i = 0; i < (NUMOFMESSAGEBUFFERS-1); ++i ){
        message_buffer[i][0] = i + 1;    
        initlock(&message_buffer_lock[i],a);
    }
    initlock(&message_buffer_lock[NUMOFMESSAGEBUFFERS-1],a);
    message_buffer[NUMOFMESSAGEBUFFERS-1][0] = -1;//END of free list
    free_message_buffer = 0;
    for(int i = 0; i < NUMOFMESSAGEQUEUES; ++i ){
        message_queue[i] = createqueue();
        char *a;
        a = "queue";
        initlock(&queue_lock[i],a);
    }
    a = "proc";
    initlock(&free_message_buffer_lock,"free_message_buff_lock");
}

int
send_message(int s_pid,int r_pid,void *msg)
{
    acquire(&queue_lock[r_pid]);
    if(isFull(message_queue[r_pid])==1){
        release(&queue_lock[r_pid]);
        return -1;
    }
    int msg_no = GetMessageBuffer();
    
    enqueue(message_queue[r_pid],msg_no);
    
    from_array[msg_no] = s_pid;
    int *temp_msg;
    temp_msg = (int *)msg;
    acquire(&message_buffer_lock[msg_no]);
    for(int i=1;i<MessageSize;i++){
        *(message_buffer[msg_no]+i) = *(temp_msg+i-1);
    }
    release(&message_buffer_lock[msg_no]);
    // getQueueSize(message_queue[r_pid]);
    release(&queue_lock[r_pid]);
    return 0;
}

int 
receive_message_temp(int myid,void* msg)
{
    acquire(&queue_lock[myid]);
    if(isEmpty(message_queue[myid])==1){
        release(&queue_lock[myid]);
        return -1;
    }
    int msg_no = dequeue(message_queue[myid]);
    if(msg_no<0){
        release(&queue_lock[myid]);
        return -1;
    }
    int *temp_msg;
    temp_msg = (int *)msg;
    acquire(&message_buffer_lock[msg_no]);
    for(int i=1;i<MessageSize;i++){
         *(temp_msg+i-1) = *(message_buffer[msg_no]+i);
    }
    release(&message_buffer_lock[msg_no]);
    FreeMessageBuffer(msg_no);
    cprintf("after receiving size of queue[] is\n ");// %d \n",getQueueSize(message_queue[myid])
    release(&queue_lock[myid]);
    return 0;
}

int
receive_msg(int myid,void* msg)
{
    acquire(&queue_lock[myid]);
    if(isEmpty(message_queue[myid])==1){
        release(&queue_lock[myid]);
        return -1;
    }
    
    int msg_no = dequeue(message_queue[myid]);
    // cprintf("msg_no is : %d for pid %d \n",msg_no,myproc()->pid);
    if(msg_no<0){
        release(&queue_lock[myid]);
        return -1;
    }
    // int f = from_array[msg_no];
    // *from = f;
    int *temp_msg;
    temp_msg = (int *)msg;
    acquire(&message_buffer_lock[msg_no]);
    for(int i=1;i<MessageSize;i++){
         *(temp_msg+i-1) = *(message_buffer[msg_no]+i);
    }
    release(&message_buffer_lock[msg_no]);
    FreeMessageBuffer(msg_no);
    release(&queue_lock[myid]);
    
    return 0;
}

int 
isReceiverQueueEmpty(int myid)
{
    int flag = 0;
    acquire(&queue_lock[myid]);
    if(isEmpty(message_queue[myid])==1){
        flag = 1;
    }
    release(&queue_lock[myid]);
    return flag;
}


