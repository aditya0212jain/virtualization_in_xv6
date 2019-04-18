#include "types.h"
#include "defs.h"
#include "param.h"
#include "mmu.h"
#include "proc.h"
#include "fs.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "file.h"

//Containers are numbered from 1 to NCONTAINER

struct container
{
    int status;//alive or dead
    int proc[NPROC];
    // need to implement page table 
    // and file descriptor table
    // scheduling operation
};

struct {
    struct spinlock lock;
    struct container container[NCONTAINER];
} container_table;

// int freeslot = 0;

void 
container_init()
{
    initlock(&container_table.lock, "container_table");
    
    for(int i=0;i<NCONTAINER;i++){
        for(int j=0;j<NPROC;j++){
            container_table.container[i].proc[j] = 0;
        }
        container_table.container[i].status = 0;
    }
    
}

int 
get_container(void)
{
    acquire(&container_table.lock);
    for(int i=1;i<NCONTAINER;i++){
        if(container_table.container[i].status == 0){
            container_table.container[i].status = 1;
            release(&container_table.lock);
            return i;
        }
    }
    release(&container_table.lock);
    return -1;
}

int
destroy_container_kernel(int a)
{
    acquire(&container_table.lock);
    container_table.container[a].status = 0;
    for(int i=0;i<NPROC;i++){
        container_table.container[a].proc[i] = 0;
    }
    release(&container_table.lock);
    return -1;
}

int 
set_process_to_container(int pid,int cid)
{
    acquire(&container_table.lock);
    if(container_table.container[cid].status==0){
        release(&container_table.lock);
        return -1;
    }else{
        container_table.container[cid].proc[pid] = 1;
    }
    release(&container_table.lock);   
    return 0;
}

int 
remove_process_from_container(int pid,int cid)
{
    acquire(&container_table.lock);
    if(container_table.container[cid].status==0){
        release(&container_table.lock);
        return -1;
    }else{
        container_table.container[cid].proc[pid] = 0;
    }
    release(&container_table.lock);   
    return 0;
}