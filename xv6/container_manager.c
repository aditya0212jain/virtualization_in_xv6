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
    int runstate; // 0 for waiting , 1 for ready
    int last_process;
    char* space_mapping[100];
    int last_space;
    char* files_of_container[100];
    int last_file_index;
    // need to implement page table 
    // and file descriptor table
    // scheduling operation
};

struct {
    struct spinlock lock;
    struct container container[NCONTAINER];
} container_table;

int current_container = 0;


void 
container_init()
{
    initlock(&container_table.lock, "container_table");
    
    for(int i=0;i<NCONTAINER;i++){
        for(int j=0;j<NPROC;j++){
            container_table.container[i].proc[j] = 0;
        }
        container_table.container[i].status = 0;
        container_table.container[i].last_process = 0;
        container_table.container[i].last_space = 0;
        container_table.container[i].last_file_index = 0;
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

int
get_container_to_run(){
    int count =0;
    int cid = (current_container+1)%NCONTAINER;
    acquire(&container_table.lock);
    while(count<NCONTAINER){
        if(container_table.container[cid].status==1){
            current_container = cid;
            break;
        }
        cid = (cid+1)%NCONTAINER;
        count++;
    }
    release(&container_table.lock);
    return current_container;
}

int*
get_container_processes_to_run(int cid)
{
    return container_table.container[cid].proc;
}

int 
get_container_last_process(int cid)
{
    return container_table.container[cid].last_process;
}

void
set_last_process_of_container(int last_process,int cid)
{
    acquire(&container_table.lock);
    container_table.container[cid].last_process = last_process;
    release(&container_table.lock);
}

char*
get_space_in_container(int cid,int units,int* t)
{
    acquire(&container_table.lock);
    int index = container_table.container[cid].last_space;
    char* result = kalloc();
    container_table.container[cid].space_mapping[index] = result;
    container_table.container[cid].last_space += 1;// use cycle
    release(&container_table.lock);
    *t = index;
    return result;
}

void 
set_file_in_container(char* s,int cid)
{
    acquire(&container_table.lock);
    int fd = container_table.container[cid].last_file_index;
    container_table.container[cid].files_of_container[fd] = s;
    container_table.container[cid].last_file_index += 1;
    release(&container_table.lock);
}

int 
file_in_container(char* s, int cid)
{
    int ans = 0;
    int stln = strlen(s);
    // char buf[14];
    // char* a = strncpy(buf,s,strlen(s));
    char* a = kalloc();
    a = strncpy(a,s,strlen(s)+1);
    if(cid!=0){
        *(a+stln) = '$';
        *(a+stln+1) = cid + '0';
        *(a+stln+2) = '\0';
    }
    // cprintf("fic for %s in cid %d \n",a,cid);
    // cprintf("a is : %s\n",a);
    acquire(&container_table.lock);
    for(int i=0;i<100 && i < container_table.container[cid].last_file_index;i++){
        int status = strncmp(container_table.container[cid].files_of_container[i],a,strlen(a));
        if(status==0){
            ans = 1;
            break;
        }
    }
    // cprintf("fic return ans : %d\n",ans);
    release(&container_table.lock);
    return ans;
}