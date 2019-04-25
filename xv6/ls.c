#include "types.h"
#include "stat.h"
#include "user.h"
#include "fs.h"

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

// void
// ls(char *path)
// {
//   char buf[512], *p;
//   int fd;
//   struct dirent de;
//   struct stat st;

//   if((fd = open(path, 0)) < 0){
//     printf(2, "ls: cannot open %s\n", path);
//     return;
//   }

//   if(fstat(fd, &st) < 0){
//     printf(2, "ls: cannot stat %s\n", path);
//     close(fd);
//     return;
//   }

//   switch(st.type){
//   case T_FILE:
//     printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
//     break;

//   case T_DIR:
//     if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
//       printf(1, "ls: path too long\n");
//       break;
//     }
//     strcpy(buf, path);
//     p = buf+strlen(buf);
//     *p++ = '/';
//     while(read(fd, &de, sizeof(de)) == sizeof(de)){
//       if(de.inum == 0)
//         continue;
//       memmove(p, de.name, DIRSIZ);
//       p[DIRSIZ] = 0;
//       if(stat(buf, &st) < 0){
//         printf(1, "ls: cannot stat %s\n", buf);
//         continue;
//       }
//       printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
//     }
//     break;
//   }
//   close(fd);
// }


//modified ls


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


int
main(int argc, char *argv[])
{
  int i;

  if(argc < 2){
    ls(".");
    exit();
  }
  for(i=1; i<argc; i++)
    ls(argv[i]);
  exit();
}
