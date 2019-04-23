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
			char* printname = fmtname(buf);
			*(printname + strlen(p)-2) = '\0';
			printf(1, "%s %d %d %d\n", printname, st.type, st.ino, st.size);
		  	// printf(1,"it is in container : %s \n",p);
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

void
cat(char* name)
{

  int fd = open(name,0);
  int n;
  char buf[512];
//   printf(1,"inside cat fd : %d\n",fd);
  while((n = read(fd, buf, sizeof(buf))) > 0) {
    if (write(1, buf, n) != n) {
      printf(1, "cat: write error\n");
      exit();
    }
  }
  if(n < 0){
    printf(1, "cat: read error\n");
    exit();
  }
//   close(fd);
}

int main(void)
{
	int cid[3];
	int nchild = 10;
	// int status = 0;
	// char* argv[] = {"."};
	// status = exec("ls",argv);
	cid[0] = create_container();
	cid[1] = create_container();
	cid[2] = create_container();
	int fd ;
	// scheduler_log_on();
	for(int i=0;i<nchild;i++){
		int x = fork();
		if(x==0){
			join_container(cid[i%3]);
			if(i<3){
				fd = open("backup", O_CREATE | O_RDWR);
				if(fd >= 0){
					printf(1, "create small succeeded %d \n",fd);
				} else {
					printf(1, "error: creat small failed!\n");
				}
				// memory_log_on();
				// container_malloc(23);
				// container_malloc(46);
				// memory_log_off();
				// char* to = "Modified by:  ";
				// *(to+strlen(to)-1) = getpid() +'0';
				// if(write(fd,to,14)!=14){
				// 	printf(1,"error while writing\n");
				// }
				// // close(fd);
				// cat("backup");
				// close(fd);
			}
			// if(i==0){
			// 	ls(".");
			// }
			exit();
		}
	}

	
	// scheduler_log_off();
	// int fd = open("backup1", O_CREATE | O_RDWR);
	// if(fd >= 0){
	// 	printf(1, "create small succeeded %d \n",fd);
	// } else {
	// 	printf(1, "error: creat small failed!\n");
	// }
	
	// char* to = "aditya";
	// if(write(fd,to,6)!=6){
	// 	printf(1,"error while writing\n");
	// }
	// close(fd);
	// int fd2 = open("backup2", O_CREATE | O_RDWR );
	// if(fd2 >= 0){
	// 	printf(1, "create small succeeded %d \n",fd);
	// } else {
	// 	printf(1, "error: creat small failed!\n");
	// }
	// char* to2 = "yash";
	// if(write(fd2,to2,6)!=6){
	// 	printf(1,"error while writing\n");
	// }
	// close(fd2);
	// int fd3 = open("backup1",0);

	// sleep(500);
	// scheduler_log_off();
	// cat(fd3);
	// ps();
	ls(".");
	
	// printf(1,"satus : %d\n",status);

	for(int i=0;i<nchild;i++){
		wait();
	}
	exit();
}
