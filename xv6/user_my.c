#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"
#include "fcntl.h"

char*
fmtname(char *path)
{
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
    ;
  p++;

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
    return p;
  memmove(buf, p, strlen(p));
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  return buf;
}

void
ls(char *path)
{
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }

  switch(st.type){
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
    break;

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
      printf(1, "ls: path too long\n");
      break;
    }
    strcpy(buf, path);
    p = buf+strlen(buf);
    *p++ = '/';
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
      if(de.inum == 0)
        continue;
      memmove(p, de.name, DIRSIZ);
      p[DIRSIZ] = 0;
	  if(*(p+strlen(p)-2)=='$'){
		  if(*(p+strlen(p)-1) == get_container_id() +'0'){
			if(stat(buf, &st) < 0){
				printf(1, "ls: cannot stat %s\n", buf);
				continue;
			}
			printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
		  	printf(1,"it is in container : %s \n",p);
		  }
		  
	  }else{
		if(stat(buf, &st) < 0){
			printf(1, "ls: cannot stat %s\n", buf);
			continue;
		}
		printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
	  }
    }
    break;
  }
  close(fd);
}

int main(void)
{
	int cid[3];
	int nchild = 10;
	
	cid[0] = create_container();
	cid[1] = create_container();
	cid[2] = create_container();
	int fd ;
	// scheduler_log_on();
	for(int i=0;i<nchild;i++){
		int x = fork();
		if(x==0){
			join_container(cid[i%3]);
			if(i<2){
				fd = open("backup", O_CREATE | O_RDWR);
				if(fd >= 0){
					printf(1, "create small succeeded %d \n",fd);
				} else {
					printf(1, "error: creat small failed!\n");
				}
				memory_log_on();
				container_malloc(23);
				container_malloc(46);
				memory_log_off();
				
			}
			if(i==6){
				ls(".");
			}
			exit();
		}
	}

	// char* temp1[2];
	// temp1[1]= "yash";
	// temp1[0] = "";
	// char* t2 = "yash";
	// char* t3 = "yash";
	// for(int i=0;i<2;i++){
	// 	if(strcmp(temp1[i],t2)==0){
	// 		printf(1,"Compared : %d\n",i);
	// 	}else{
	// 		printf(1,"Not matches\n");
	// 	}
	// }

	
	// scheduler_log_off();
	// fd = open("backup", O_CREATE | O_RDWR);
	// if(fd >= 0){
	// 	printf(1, "create small succeeded %d \n",fd);
	// } else {
	// 	printf(1, "error: creat small failed!\n");
	// }
	// char* to = "aditya";
	// if(write(fd,to,6)!=6){
	// 	printf(1,"error while writing\n");
	// }
	// int fd2 = open("backup", O_CREATE | O_RDWR );
	// if(fd2 >= 0){
	// 	printf(1, "create small succeeded %d \n",fd);
	// } else {
	// 	printf(1, "error: creat small failed!\n");
	// }
	// char* to2 = "yash";
	// if(write(fd2,to2,6)!=6){
	// 	printf(1,"error while writing\n");
	// }

	// sleep(500);
	// scheduler_log_off();
	
	// ps();
	// ls(".");
	for(int i=0;i<nchild;i++){
		wait();
	}
	exit();
}
