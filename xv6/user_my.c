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
	//   printf(1,"%s\n",p);
	  
	  if(*(p+strlen(p)-2)=='$'){
		  if(*(p+strlen(p)-1) == get_container_id() +'0'){
			  if(get_file_container_id(p)!=0){
				  *(p+strlen(p)-2) = '\0';
				  printf(1,"%s\n",p);
			  }
			// if(stat(buf, &st) < 0){
			// 	printf(1, "ls: cannot stat %s\n", buf);
			// 	continue;
			// }
			// char* printname = fmtname(buf);
			// *(printname + strlen(p)-2) = '\0';
			// printf(1, "%s %d %d %d %s\n", printname, st.type, st.ino, st.size,p);
		  	// printf(1,"it is in container : %s \n",p);
		  }
	  }else{
		  printf(1,"%s\n",p);
	  }	  
	//   }else{
	// 	if(stat(buf, &st) < 0){
	// 		printf(1, "ls: cannot stat %s\n", buf);
	// 		continue;
	// 	}
	// 	printf(1, "%s %d %d %d %s\n", fmtname(buf), st.type, st.ino, st.size,p);
	//   }
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
    //   exit();
    }
  }
  if(n < 0){
    printf(1, "cat: read error\n");
    // exit();
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
	
	int fd = open("backup", O_CREATE | O_RDWR);
	// if(fd >= 0){
	// 	printf(1, "create small succeeded %d \n",fd);
	// } else {
	// 	printf(1, "error: creat small failed!\n");
	// }
	
	char* to = "aditya\n";
	if(write(fd,to,7)!=7){
		printf(1,"error while writing\n");
	}
	// cat("backup");
	close(fd);
	
	// scheduler_log_on();
	for(int i=0;i<nchild;i++){
		int x = fork();
		if(x==0){
			join_container(cid[i%3]);
			if(i<1){
				int fd_c =0 ;
				fd_c = open("backup",O_CREATE | O_RDWR);
				// if(fd_c >= 0){
				// 	printf(1, "create small succeeded %d \n",fd_c);
				// } else {
				// 	printf(1, "error: creat small failed!\n");
				// }
				// printf(1,"fd_c :%d\n",fd_c);
				// memory_log_on();
				// container_malloc(23);
				// container_malloc(46);
				// memory_log_off();
				char* to = "Modified by:  \n";
				*(to+strlen(to)-2) = getpid() +'0';
				if(write(fd_c,to,15)!=15){
					printf(1,"error while writing\n");
				}
				// cat("backup");
				close(fd_c);
				// ls(".");
			}
			if(i==1){
				int fd2 = open("backup",O_RDONLY);
				// cat("backup");
				close(fd2);
				// ls(".");
				
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
