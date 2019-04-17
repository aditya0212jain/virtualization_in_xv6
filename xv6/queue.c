#include "types.h"
#include "defs.h"
#include "param.h"
#include "mmu.h"
#include "proc.h"
#include "fs.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "file.h"

typedef struct tq
{
    int size;
    int data[NUMOFMESSAGEBUFFERS];
    int head;
    int tail;
} queue;

queue temp_queue[NUMOFMESSAGEQUEUES];
int count_q = 0;

queue* 
createqueue(void)
{
    if(count_q>=NUMOFMESSAGEQUEUES){
        count_q=0;
    }
    queue* q;
    q = &temp_queue[count_q]; 
    q->size = 0;  
    q->tail = 0;
    q->head = 0;
    count_q++;
    return q; 
}

int
isEmpty(queue* q)
{
    if(q->size==0)
        return 1;
    return 0;
}
  
int 
enqueue(queue* q, int a) 
{ 
    if (q->size==NUMOFMESSAGEBUFFERS){
        return -1;
    }
    q->data[q->tail] = a; 
    q->tail = (q->tail + 1)%NUMOFMESSAGEBUFFERS;  
    q->size = q->size + 1;
    return 0; 
} 

int
getQueueSize(queue *q)
{
    return q->size;
}
  
int 
dequeue(queue* q) 
{ 
    if (isEmpty(q)) 
        return -1; 
    int a = q->data[q->head]; 
    q->head = (q->head + 1)%NUMOFMESSAGEBUFFERS; 
    q->size = q->size - 1; 
    return a; 
}

int
isFull(queue* q)
{
    if(q->size==NUMOFMESSAGEBUFFERS){
        return 1;
    }
    return 0;
}

