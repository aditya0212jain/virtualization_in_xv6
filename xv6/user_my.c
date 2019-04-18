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
      if(stat(buf, &st) < 0){
        printf(1, "ls: cannot stat %s\n", buf);
        continue;
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
    }
    break;
  }
  close(fd);
}


int main(void)
{
	int cid[3];
	int nchild = 16;
	
	cid[0] = create_container();
	cid[1] = create_container();
	cid[2] = create_container();
	printf(1,"%d\n",cid[0]);
	printf(1,"%d\n",cid[1]);
	printf(1,"%d\n",cid[2]);
	int fd ;
	// fd = open("backup", O_CREATE | O_RDWR);

	
	
	for(int i=0;i<nchild;i++){
		int x = fork();
		if(x==0){
			join_container(cid[i%3]);
			if(i==0){
				fd = open("backup", O_CREATE | O_RDWR);
							if(fd >= 0){
					printf(1, "creat small succeeded; ok\n");
				} else {
					printf(1, "error: creat small failed!\n");
					
				}
			}
			if(i==3){
				ls(".");
			}
			exit();
		}
	}
	sleep(5);
	ps();
	for(int i=0;i<nchild;i++){
		wait();
	}
	exit();
}
