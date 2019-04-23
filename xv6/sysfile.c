//
// File-system system calls.
// Mostly argument checking, since we don't trust
// user code, and calls into file.c and fs.c.
//

#include "types.h"
#include "defs.h"
#include "param.h"
#include "stat.h"
#include "mmu.h"
#include "proc.h"
#include "fs.h"
#include "spinlock.h"
#include "sleeplock.h"
#include "file.h"
#include "fcntl.h"

char* initial_files[29] = {".","..","init","console","shutdown","arr","cat","README","assig2a.inp","assig2b.inp","echo","forktest","grep","kill","ln","ls","mkdir","rm","sh","stressfs","usertests","wc","zombie","user_toggle","user_add","user_my","print_count","jacob","maekawa"};
char* initial_files_with_dot[29] = {"./.","./..","./init","./console","./shutdown","./arr","./cat","./README","./assig2a.inp","./assig2b.inp","./echo","./forktest","./grep","./kill","./ln","./ls","./mkdir","./rm","./sh","./stressfs","./usertests","./wc","./zombie","./user_toggle","./user_add","./user_my","./print_count","./jacob","./maekawa"};

int 
in_initial_files(char* path)
{
  for(int i=0;i<29;i++){
    if(strncmp(path,initial_files[i],strlen(path))==0){
      return 1;
    }
  }
  for(int i=0;i<29;i++){
    if(strncmp(path,initial_files_with_dot[i],strlen(path))==0){
      return 1;
    }
  }
  
  return 0;
}

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    return -1;
  if(pfd)
    *pfd = fd;
  if(pf)
    *pf = f;
  return 0;
}

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
  int fd;
  struct proc *curproc = myproc();

  for(fd = 0; fd < NOFILE; fd++){
    if(curproc->ofile[fd] == 0){
      curproc->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
}

int
sys_dup(void)
{
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
    return -1;
  if((fd=fdalloc(f)) < 0)
    return -1;
  filedup(f);
  return fd;
}

int
sys_read(void)
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;
  if(f->ip->container_id==myproc()->container_id || f->ip->container_id ==0 ){
    return fileread(f, p, n);
  }else{
    // cprintf("wrong acces in read\n");
    return -1;
  }
}

int
sys_write(void)
{
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
    return -1;


  if(f->ip->container_id==0){
    return filewrite(f,p,n);
  }

  if(f->ip->container_id==myproc()->container_id){
    return filewrite(f, p, n);
  }else{
    return -1;
  }
}

int
sys_close(void)
{
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
    return -1;
  myproc()->ofile[fd] = 0;
  
  if(f->ip->container_id==myproc()->container_id){
    fileclose(f);
    return 0;
  }else{
    return -1;
  }
}

int
sys_fstat(void)
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
  return filestat(f, st);
}

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
    return -1;

  begin_op();
  if((ip = namei(old)) == 0){
    end_op();
    return -1;
  }

  ilock(ip);
  if(ip->type == T_DIR){
    iunlockput(ip);
    end_op();
    return -1;
  }

  ip->nlink++;
  iupdate(ip);
  iunlock(ip);

  if((dp = nameiparent(new, name)) == 0)
    goto bad;
  ilock(dp);
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    iunlockput(dp);
    goto bad;
  }
  iunlockput(dp);
  iput(ip);

  end_op();

  return 0;

bad:
  ilock(ip);
  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);
  end_op();
  return -1;
}

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
      panic("isdirempty: readi");
    if(de.inum != 0)
      return 0;
  }
  return 1;
}

//PAGEBREAK!
int
sys_unlink(void)
{
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
    return -1;

  begin_op();
  if((dp = nameiparent(path, name)) == 0){
    end_op();
    return -1;
  }

  ilock(dp);

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
    goto bad;
  ilock(ip);

  if(ip->nlink < 1)
    panic("unlink: nlink < 1");
  if(ip->type == T_DIR && !isdirempty(ip)){
    iunlockput(ip);
    goto bad;
  }

  memset(&de, 0, sizeof(de));
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
    panic("unlink: writei");
  if(ip->type == T_DIR){
    dp->nlink--;
    iupdate(dp);
  }
  iunlockput(dp);

  ip->nlink--;
  iupdate(ip);
  iunlockput(ip);

  end_op();

  return 0;

bad:
  iunlockput(dp);
  end_op();
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    return 0;
  ilock(dp);

  if((ip = dirlookup(dp, name, &off)) != 0){
    iunlockput(dp);
    ilock(ip);
    if(type == T_FILE && ip->type == T_FILE)
      return ip;
    iunlockput(ip);
    return 0;
  }

  if((ip = ialloc(dp->dev, type)) == 0)
    panic("create: ialloc");

  ilock(ip);
  ip->major = major;
  ip->minor = minor;
  ip->nlink = 1;
  iupdate(ip);

  if(type == T_DIR){  // Create . and .. entries.
    dp->nlink++;  // for ".."
    iupdate(dp);
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
      panic("create dots");
  }

  if(dirlink(dp, name, ip->inum) < 0)
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}

char*
fmtname2(char *path)
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

int
sys_open(void)
{
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;


  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
    return -1;

  begin_op();

  // char* buf =kalloc();

  if(in_initial_files(path)==1){
    // IF an existing file is opened
    // cprintf("initila file %s\n",path);
    if(myproc()->container_id!=0){
      if(omode == 0){
        //read only then
        int in_container = file_in_container(path,myproc()->container_id);
        if(in_container==0){
          //do not change if it has never been written
        }else{
          // file has been opened before for writing so 
          //change the name so that correct copy of the file is opened
          int stln = strlen(path);
          *(path+stln) = '$';
          *(path+stln+1) = myproc()->container_id + '0';
          *(path+stln+2) = '\0';
        }
      }
      if((omode & O_WRONLY) || (omode & O_RDWR)){
        //init file is opened for reading and writing so 
        //make a copy of the file for writing
        int stln = strlen(path);
        // path sent below is the original file name
        int in_container = file_in_container(path,myproc()->container_id);
        *(path+stln) = '$';
        *(path+stln+1) = myproc()->container_id + '0';
        *(path+stln+2) = '\0';
        cprintf(" path changed for %s\n",path);
        if(in_container==0){
          // file is opened first time for writing so 
          //make a copy of the file

          set_file_in_container(path,myproc()->container_id);
        }else{
          //a copy has already been created before so do nothing
          
        }
      }
    }
  }else{
    // NOT INITIAL FILE 
    int stln = strlen(path);
    // buf = safestrcpy(buf,path,stln+1);
    if(omode & O_CREATE){
      *(path+stln) = '$';
      *(path+stln+1) = myproc()->container_id + '0';
      *(path+stln+2) = '\0';
    }else{
      if(*(path+stln-2)!='$'){ // so that when ls is called it does not append extra $
        *(path+stln) = '$';
        *(path+stln+1) = myproc()->container_id + '0';
        *(path+stln+2) = '\0'; 
      }
    }
  }



  if(omode & O_CREATE){
    //CREATE PATH
    ip = create(path, T_FILE, 0, 0);
    if(ip == 0){
      end_op();
      return -1;
    }
    ip->container_id = myproc()->container_id;
    // cprintf("OPEN: fd %s %d\n",path,ip->container_id);
  } else {

    if((ip = namei(path)) == 0){
      end_op();
      cprintf("5\n");
      return -1;
    }
    ilock(ip);
    if(ip->type == T_DIR && omode != O_RDONLY){
      iunlockput(ip);
      end_op();
      cprintf("6\n");
      return -1;
    }
  }
  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    if(f)
      fileclose(f);
    iunlockput(ip);
    end_op();
    cprintf("8\n");
    return -1;
  }
  iunlock(ip);
  end_op();
  // cprintf("2\n");
  
  // cprintf("Before returning ip->cid : %d mp->cid : %d \n",ip->container_id,myproc()->container_id);
  if (ip->container_id==myproc()->container_id || ip->container_id==0 ){
    f->type = FD_INODE;
    f->ip = ip;
    f->off = 0;
    f->readable = !(omode & O_WRONLY);
    f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    return fd;
  }
  // cprintf("this is new fd : %d \n",fd);
  return -1;
}

int
sys_mkdir(void)
{
  char *path;
  struct inode *ip;

  begin_op();
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
  end_op();
  return 0;
}

int
sys_mknod(void)
{
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
  if((argstr(0, &path)) < 0 ||
     argint(1, &major) < 0 ||
     argint(2, &minor) < 0 ||
     (ip = create(path, T_DEV, major, minor)) == 0){
    end_op();
    return -1;
  }
  iunlockput(ip);
  end_op();
  return 0;
}

int
sys_chdir(void)
{
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
  
  begin_op();
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
    end_op();
    return -1;
  }
  ilock(ip);
  if(ip->type != T_DIR){
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
  iput(curproc->cwd);
  end_op();
  curproc->cwd = ip;
  return 0;
}

int
sys_exec(void)
{
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
    return -1;
  }
  memset(argv, 0, sizeof(argv));
  for(i=0;; i++){
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
}

int
sys_pipe(void)
{
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0){
    cprintf("inside pipe 1\n");
    return -1;
  }
  if(pipealloc(&rf, &wf) < 0){
    cprintf("inside pipe 2\n");
    return -1;
  }
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    if(fd0 >= 0)
      myproc()->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    cprintf("inside pipe 3\n");
    return -1;
  }
  fd[0] = fd0;
  fd[1] = fd1;
  return 0;
}


int
sys_get_file_container_id(void)
{
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
    return -1;
  return f->ip->container_id;
}