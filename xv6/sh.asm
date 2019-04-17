
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 04             	sub    $0x4,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      11:	eb 0e                	jmp    21 <main+0x21>
      13:	90                   	nop
      14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	0f 8f b9 00 00 00    	jg     da <main+0xda>
  while((fd = open("console", O_RDWR)) >= 0){
      21:	83 ec 08             	sub    $0x8,%esp
      24:	6a 02                	push   $0x2
      26:	68 d9 12 00 00       	push   $0x12d9
      2b:	e8 42 0d 00 00       	call   d72 <open>
      30:	83 c4 10             	add    $0x10,%esp
      33:	85 c0                	test   %eax,%eax
      35:	79 e1                	jns    18 <main+0x18>
  // for(int i=0;i<21;i++){
    // if(syscall_trace[i]!=0){
      // printf(1,"%s %d\n",numToCall[i],syscall_trace[i]);
    // }
  // }
  printf(1,"shell it is\n");
      37:	83 ec 08             	sub    $0x8,%esp
      3a:	68 e1 12 00 00       	push   $0x12e1
      3f:	6a 01                	push   $0x1
      41:	e8 9a 0e 00 00       	call   ee0 <printf>
  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
      46:	83 c4 10             	add    $0x10,%esp
      49:	eb 20                	jmp    6b <main+0x6b>
      4b:	90                   	nop
      4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
int
fork1(void)
{
  int pid;

  pid = fork();
      50:	e8 d5 0c 00 00       	call   d2a <fork>
  if(pid == -1)
      55:	83 f8 ff             	cmp    $0xffffffff,%eax
      58:	0f 84 92 00 00 00    	je     f0 <main+0xf0>
    if(fork1() == 0)
      5e:	85 c0                	test   %eax,%eax
      60:	0f 84 97 00 00 00    	je     fd <main+0xfd>
    wait();
      66:	e8 cf 0c 00 00       	call   d3a <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
      6b:	83 ec 08             	sub    $0x8,%esp
      6e:	6a 64                	push   $0x64
      70:	68 00 19 00 00       	push   $0x1900
      75:	e8 a6 00 00 00       	call   120 <getcmd>
      7a:	83 c4 10             	add    $0x10,%esp
      7d:	85 c0                	test   %eax,%eax
      7f:	78 6a                	js     eb <main+0xeb>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      81:	80 3d 00 19 00 00 63 	cmpb   $0x63,0x1900
      88:	75 c6                	jne    50 <main+0x50>
      8a:	80 3d 01 19 00 00 64 	cmpb   $0x64,0x1901
      91:	75 bd                	jne    50 <main+0x50>
      93:	80 3d 02 19 00 00 20 	cmpb   $0x20,0x1902
      9a:	75 b4                	jne    50 <main+0x50>
      buf[strlen(buf)-1] = 0;  // chop \n
      9c:	83 ec 0c             	sub    $0xc,%esp
      9f:	68 00 19 00 00       	push   $0x1900
      a4:	e8 b7 0a 00 00       	call   b60 <strlen>
      if(chdir(buf+3) < 0)
      a9:	c7 04 24 03 19 00 00 	movl   $0x1903,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      b0:	c6 80 ff 18 00 00 00 	movb   $0x0,0x18ff(%eax)
      if(chdir(buf+3) < 0)
      b7:	e8 e6 0c 00 00       	call   da2 <chdir>
      bc:	83 c4 10             	add    $0x10,%esp
      bf:	85 c0                	test   %eax,%eax
      c1:	79 a8                	jns    6b <main+0x6b>
        printf(2, "cannot cd %s\n", buf+3);
      c3:	50                   	push   %eax
      c4:	68 03 19 00 00       	push   $0x1903
      c9:	68 ee 12 00 00       	push   $0x12ee
      ce:	6a 02                	push   $0x2
      d0:	e8 0b 0e 00 00       	call   ee0 <printf>
      d5:	83 c4 10             	add    $0x10,%esp
      d8:	eb 91                	jmp    6b <main+0x6b>
      close(fd);
      da:	83 ec 0c             	sub    $0xc,%esp
      dd:	50                   	push   %eax
      de:	e8 77 0c 00 00       	call   d5a <close>
      break;
      e3:	83 c4 10             	add    $0x10,%esp
      e6:	e9 4c ff ff ff       	jmp    37 <main+0x37>
  exit();
      eb:	e8 42 0c 00 00       	call   d32 <exit>
    panic("fork");
      f0:	83 ec 0c             	sub    $0xc,%esp
      f3:	68 62 12 00 00       	push   $0x1262
      f8:	e8 73 00 00 00       	call   170 <panic>
      runcmd(parsecmd(buf));
      fd:	83 ec 0c             	sub    $0xc,%esp
     100:	68 00 19 00 00       	push   $0x1900
     105:	e8 66 09 00 00       	call   a70 <parsecmd>
     10a:	89 04 24             	mov    %eax,(%esp)
     10d:	e8 7e 00 00 00       	call   190 <runcmd>
     112:	66 90                	xchg   %ax,%ax
     114:	66 90                	xchg   %ax,%ax
     116:	66 90                	xchg   %ax,%ax
     118:	66 90                	xchg   %ax,%ax
     11a:	66 90                	xchg   %ax,%ax
     11c:	66 90                	xchg   %ax,%ax
     11e:	66 90                	xchg   %ax,%ax

00000120 <getcmd>:
{
     120:	55                   	push   %ebp
     121:	89 e5                	mov    %esp,%ebp
     123:	56                   	push   %esi
     124:	53                   	push   %ebx
     125:	8b 75 0c             	mov    0xc(%ebp),%esi
     128:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printf(2, "$ ");
     12b:	83 ec 08             	sub    $0x8,%esp
     12e:	68 38 12 00 00       	push   $0x1238
     133:	6a 02                	push   $0x2
     135:	e8 a6 0d 00 00       	call   ee0 <printf>
  memset(buf, 0, nbuf);
     13a:	83 c4 0c             	add    $0xc,%esp
     13d:	56                   	push   %esi
     13e:	6a 00                	push   $0x0
     140:	53                   	push   %ebx
     141:	e8 4a 0a 00 00       	call   b90 <memset>
  gets(buf, nbuf);
     146:	58                   	pop    %eax
     147:	5a                   	pop    %edx
     148:	56                   	push   %esi
     149:	53                   	push   %ebx
     14a:	e8 a1 0a 00 00       	call   bf0 <gets>
  if(buf[0] == 0) // EOF
     14f:	83 c4 10             	add    $0x10,%esp
     152:	31 c0                	xor    %eax,%eax
     154:	80 3b 00             	cmpb   $0x0,(%ebx)
     157:	0f 94 c0             	sete   %al
}
     15a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(buf[0] == 0) // EOF
     15d:	f7 d8                	neg    %eax
}
     15f:	5b                   	pop    %ebx
     160:	5e                   	pop    %esi
     161:	5d                   	pop    %ebp
     162:	c3                   	ret    
     163:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <panic>:
{
     170:	55                   	push   %ebp
     171:	89 e5                	mov    %esp,%ebp
     173:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     176:	ff 75 08             	pushl  0x8(%ebp)
     179:	68 d5 12 00 00       	push   $0x12d5
     17e:	6a 02                	push   $0x2
     180:	e8 5b 0d 00 00       	call   ee0 <printf>
  exit();
     185:	e8 a8 0b 00 00       	call   d32 <exit>
     18a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000190 <runcmd>:
{
     190:	55                   	push   %ebp
     191:	89 e5                	mov    %esp,%ebp
     193:	53                   	push   %ebx
     194:	83 ec 14             	sub    $0x14,%esp
     197:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     19a:	85 db                	test   %ebx,%ebx
     19c:	74 3a                	je     1d8 <runcmd+0x48>
  switch(cmd->type){
     19e:	83 3b 05             	cmpl   $0x5,(%ebx)
     1a1:	0f 87 06 01 00 00    	ja     2ad <runcmd+0x11d>
     1a7:	8b 03                	mov    (%ebx),%eax
     1a9:	ff 24 85 fc 12 00 00 	jmp    *0x12fc(,%eax,4)
    if(ecmd->argv[0] == 0)
     1b0:	8b 43 04             	mov    0x4(%ebx),%eax
     1b3:	85 c0                	test   %eax,%eax
     1b5:	74 21                	je     1d8 <runcmd+0x48>
    exec(ecmd->argv[0], ecmd->argv);
     1b7:	52                   	push   %edx
     1b8:	52                   	push   %edx
     1b9:	8d 53 04             	lea    0x4(%ebx),%edx
     1bc:	52                   	push   %edx
     1bd:	50                   	push   %eax
     1be:	e8 a7 0b 00 00       	call   d6a <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     1c3:	83 c4 0c             	add    $0xc,%esp
     1c6:	ff 73 04             	pushl  0x4(%ebx)
     1c9:	68 42 12 00 00       	push   $0x1242
     1ce:	6a 02                	push   $0x2
     1d0:	e8 0b 0d 00 00       	call   ee0 <printf>
    break;
     1d5:	83 c4 10             	add    $0x10,%esp
    exit();
     1d8:	e8 55 0b 00 00       	call   d32 <exit>
  pid = fork();
     1dd:	e8 48 0b 00 00       	call   d2a <fork>
  if(pid == -1)
     1e2:	83 f8 ff             	cmp    $0xffffffff,%eax
     1e5:	0f 84 cf 00 00 00    	je     2ba <runcmd+0x12a>
    if(fork1() == 0)
     1eb:	85 c0                	test   %eax,%eax
     1ed:	75 e9                	jne    1d8 <runcmd+0x48>
      runcmd(bcmd->cmd);
     1ef:	83 ec 0c             	sub    $0xc,%esp
     1f2:	ff 73 04             	pushl  0x4(%ebx)
     1f5:	e8 96 ff ff ff       	call   190 <runcmd>
    close(rcmd->fd);
     1fa:	83 ec 0c             	sub    $0xc,%esp
     1fd:	ff 73 14             	pushl  0x14(%ebx)
     200:	e8 55 0b 00 00       	call   d5a <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     205:	59                   	pop    %ecx
     206:	58                   	pop    %eax
     207:	ff 73 10             	pushl  0x10(%ebx)
     20a:	ff 73 08             	pushl  0x8(%ebx)
     20d:	e8 60 0b 00 00       	call   d72 <open>
     212:	83 c4 10             	add    $0x10,%esp
     215:	85 c0                	test   %eax,%eax
     217:	79 d6                	jns    1ef <runcmd+0x5f>
      printf(2, "open %s failed\n", rcmd->file);
     219:	52                   	push   %edx
     21a:	ff 73 08             	pushl  0x8(%ebx)
     21d:	68 52 12 00 00       	push   $0x1252
     222:	6a 02                	push   $0x2
     224:	e8 b7 0c 00 00       	call   ee0 <printf>
      exit();
     229:	e8 04 0b 00 00       	call   d32 <exit>
    if(pipe(p) < 0)
     22e:	8d 45 f0             	lea    -0x10(%ebp),%eax
     231:	83 ec 0c             	sub    $0xc,%esp
     234:	50                   	push   %eax
     235:	e8 08 0b 00 00       	call   d42 <pipe>
     23a:	83 c4 10             	add    $0x10,%esp
     23d:	85 c0                	test   %eax,%eax
     23f:	0f 88 b0 00 00 00    	js     2f5 <runcmd+0x165>
  pid = fork();
     245:	e8 e0 0a 00 00       	call   d2a <fork>
  if(pid == -1)
     24a:	83 f8 ff             	cmp    $0xffffffff,%eax
     24d:	74 6b                	je     2ba <runcmd+0x12a>
    if(fork1() == 0){
     24f:	85 c0                	test   %eax,%eax
     251:	0f 84 ab 00 00 00    	je     302 <runcmd+0x172>
  pid = fork();
     257:	e8 ce 0a 00 00       	call   d2a <fork>
  if(pid == -1)
     25c:	83 f8 ff             	cmp    $0xffffffff,%eax
     25f:	74 59                	je     2ba <runcmd+0x12a>
    if(fork1() == 0){
     261:	85 c0                	test   %eax,%eax
     263:	74 62                	je     2c7 <runcmd+0x137>
    close(p[0]);
     265:	83 ec 0c             	sub    $0xc,%esp
     268:	ff 75 f0             	pushl  -0x10(%ebp)
     26b:	e8 ea 0a 00 00       	call   d5a <close>
    close(p[1]);
     270:	58                   	pop    %eax
     271:	ff 75 f4             	pushl  -0xc(%ebp)
     274:	e8 e1 0a 00 00       	call   d5a <close>
    wait();
     279:	e8 bc 0a 00 00       	call   d3a <wait>
    wait();
     27e:	e8 b7 0a 00 00       	call   d3a <wait>
    break;
     283:	83 c4 10             	add    $0x10,%esp
     286:	e9 4d ff ff ff       	jmp    1d8 <runcmd+0x48>
  pid = fork();
     28b:	e8 9a 0a 00 00       	call   d2a <fork>
  if(pid == -1)
     290:	83 f8 ff             	cmp    $0xffffffff,%eax
     293:	74 25                	je     2ba <runcmd+0x12a>
    if(fork1() == 0)
     295:	85 c0                	test   %eax,%eax
     297:	0f 84 52 ff ff ff    	je     1ef <runcmd+0x5f>
    wait();
     29d:	e8 98 0a 00 00       	call   d3a <wait>
    runcmd(lcmd->right);
     2a2:	83 ec 0c             	sub    $0xc,%esp
     2a5:	ff 73 08             	pushl  0x8(%ebx)
     2a8:	e8 e3 fe ff ff       	call   190 <runcmd>
    panic("runcmd");
     2ad:	83 ec 0c             	sub    $0xc,%esp
     2b0:	68 3b 12 00 00       	push   $0x123b
     2b5:	e8 b6 fe ff ff       	call   170 <panic>
    panic("fork");
     2ba:	83 ec 0c             	sub    $0xc,%esp
     2bd:	68 62 12 00 00       	push   $0x1262
     2c2:	e8 a9 fe ff ff       	call   170 <panic>
      close(0);
     2c7:	83 ec 0c             	sub    $0xc,%esp
     2ca:	6a 00                	push   $0x0
     2cc:	e8 89 0a 00 00       	call   d5a <close>
      dup(p[0]);
     2d1:	5a                   	pop    %edx
     2d2:	ff 75 f0             	pushl  -0x10(%ebp)
     2d5:	e8 d0 0a 00 00       	call   daa <dup>
      close(p[0]);
     2da:	59                   	pop    %ecx
     2db:	ff 75 f0             	pushl  -0x10(%ebp)
     2de:	e8 77 0a 00 00       	call   d5a <close>
      close(p[1]);
     2e3:	58                   	pop    %eax
     2e4:	ff 75 f4             	pushl  -0xc(%ebp)
     2e7:	e8 6e 0a 00 00       	call   d5a <close>
      runcmd(pcmd->right);
     2ec:	58                   	pop    %eax
     2ed:	ff 73 08             	pushl  0x8(%ebx)
     2f0:	e8 9b fe ff ff       	call   190 <runcmd>
      panic("pipe");
     2f5:	83 ec 0c             	sub    $0xc,%esp
     2f8:	68 67 12 00 00       	push   $0x1267
     2fd:	e8 6e fe ff ff       	call   170 <panic>
      close(1);
     302:	83 ec 0c             	sub    $0xc,%esp
     305:	6a 01                	push   $0x1
     307:	e8 4e 0a 00 00       	call   d5a <close>
      dup(p[1]);
     30c:	58                   	pop    %eax
     30d:	ff 75 f4             	pushl  -0xc(%ebp)
     310:	e8 95 0a 00 00       	call   daa <dup>
      close(p[0]);
     315:	58                   	pop    %eax
     316:	ff 75 f0             	pushl  -0x10(%ebp)
     319:	e8 3c 0a 00 00       	call   d5a <close>
      close(p[1]);
     31e:	58                   	pop    %eax
     31f:	ff 75 f4             	pushl  -0xc(%ebp)
     322:	e8 33 0a 00 00       	call   d5a <close>
      runcmd(pcmd->left);
     327:	58                   	pop    %eax
     328:	ff 73 04             	pushl  0x4(%ebx)
     32b:	e8 60 fe ff ff       	call   190 <runcmd>

00000330 <fork1>:
{
     330:	55                   	push   %ebp
     331:	89 e5                	mov    %esp,%ebp
     333:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     336:	e8 ef 09 00 00       	call   d2a <fork>
  if(pid == -1)
     33b:	83 f8 ff             	cmp    $0xffffffff,%eax
     33e:	74 02                	je     342 <fork1+0x12>
  return pid;
}
     340:	c9                   	leave  
     341:	c3                   	ret    
    panic("fork");
     342:	83 ec 0c             	sub    $0xc,%esp
     345:	68 62 12 00 00       	push   $0x1262
     34a:	e8 21 fe ff ff       	call   170 <panic>
     34f:	90                   	nop

00000350 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     350:	55                   	push   %ebp
     351:	89 e5                	mov    %esp,%ebp
     353:	53                   	push   %ebx
     354:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     357:	6a 54                	push   $0x54
     359:	e8 e2 0d 00 00       	call   1140 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     35e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     361:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     363:	6a 54                	push   $0x54
     365:	6a 00                	push   $0x0
     367:	50                   	push   %eax
     368:	e8 23 08 00 00       	call   b90 <memset>
  cmd->type = EXEC;
     36d:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     373:	89 d8                	mov    %ebx,%eax
     375:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     378:	c9                   	leave  
     379:	c3                   	ret    
     37a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000380 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     380:	55                   	push   %ebp
     381:	89 e5                	mov    %esp,%ebp
     383:	53                   	push   %ebx
     384:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     387:	6a 18                	push   $0x18
     389:	e8 b2 0d 00 00       	call   1140 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     38e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     391:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     393:	6a 18                	push   $0x18
     395:	6a 00                	push   $0x0
     397:	50                   	push   %eax
     398:	e8 f3 07 00 00       	call   b90 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     39d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     3a0:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     3a6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     3a9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3ac:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     3af:	8b 45 10             	mov    0x10(%ebp),%eax
     3b2:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     3b5:	8b 45 14             	mov    0x14(%ebp),%eax
     3b8:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     3bb:	8b 45 18             	mov    0x18(%ebp),%eax
     3be:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     3c1:	89 d8                	mov    %ebx,%eax
     3c3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3c6:	c9                   	leave  
     3c7:	c3                   	ret    
     3c8:	90                   	nop
     3c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003d0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     3d0:	55                   	push   %ebp
     3d1:	89 e5                	mov    %esp,%ebp
     3d3:	53                   	push   %ebx
     3d4:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3d7:	6a 0c                	push   $0xc
     3d9:	e8 62 0d 00 00       	call   1140 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3de:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     3e1:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3e3:	6a 0c                	push   $0xc
     3e5:	6a 00                	push   $0x0
     3e7:	50                   	push   %eax
     3e8:	e8 a3 07 00 00       	call   b90 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     3ed:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     3f0:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     3f6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     3f9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3fc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     3ff:	89 d8                	mov    %ebx,%eax
     401:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     404:	c9                   	leave  
     405:	c3                   	ret    
     406:	8d 76 00             	lea    0x0(%esi),%esi
     409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000410 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     410:	55                   	push   %ebp
     411:	89 e5                	mov    %esp,%ebp
     413:	53                   	push   %ebx
     414:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     417:	6a 0c                	push   $0xc
     419:	e8 22 0d 00 00       	call   1140 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     41e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     421:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     423:	6a 0c                	push   $0xc
     425:	6a 00                	push   $0x0
     427:	50                   	push   %eax
     428:	e8 63 07 00 00       	call   b90 <memset>
  cmd->type = LIST;
  cmd->left = left;
     42d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     430:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     436:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     439:	8b 45 0c             	mov    0xc(%ebp),%eax
     43c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     43f:	89 d8                	mov    %ebx,%eax
     441:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     444:	c9                   	leave  
     445:	c3                   	ret    
     446:	8d 76 00             	lea    0x0(%esi),%esi
     449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000450 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     450:	55                   	push   %ebp
     451:	89 e5                	mov    %esp,%ebp
     453:	53                   	push   %ebx
     454:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     457:	6a 08                	push   $0x8
     459:	e8 e2 0c 00 00       	call   1140 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     45e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     461:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     463:	6a 08                	push   $0x8
     465:	6a 00                	push   $0x0
     467:	50                   	push   %eax
     468:	e8 23 07 00 00       	call   b90 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     46d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     470:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     476:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     479:	89 d8                	mov    %ebx,%eax
     47b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     47e:	c9                   	leave  
     47f:	c3                   	ret    

00000480 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     480:	55                   	push   %ebp
     481:	89 e5                	mov    %esp,%ebp
     483:	57                   	push   %edi
     484:	56                   	push   %esi
     485:	53                   	push   %ebx
     486:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     489:	8b 45 08             	mov    0x8(%ebp),%eax
{
     48c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     48f:	8b 7d 10             	mov    0x10(%ebp),%edi
  s = *ps;
     492:	8b 30                	mov    (%eax),%esi
  while(s < es && strchr(whitespace, *s))
     494:	39 de                	cmp    %ebx,%esi
     496:	72 0f                	jb     4a7 <gettoken+0x27>
     498:	eb 25                	jmp    4bf <gettoken+0x3f>
     49a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     4a0:	83 c6 01             	add    $0x1,%esi
  while(s < es && strchr(whitespace, *s))
     4a3:	39 f3                	cmp    %esi,%ebx
     4a5:	74 18                	je     4bf <gettoken+0x3f>
     4a7:	0f be 06             	movsbl (%esi),%eax
     4aa:	83 ec 08             	sub    $0x8,%esp
     4ad:	50                   	push   %eax
     4ae:	68 f8 18 00 00       	push   $0x18f8
     4b3:	e8 f8 06 00 00       	call   bb0 <strchr>
     4b8:	83 c4 10             	add    $0x10,%esp
     4bb:	85 c0                	test   %eax,%eax
     4bd:	75 e1                	jne    4a0 <gettoken+0x20>
  if(q)
     4bf:	85 ff                	test   %edi,%edi
     4c1:	74 02                	je     4c5 <gettoken+0x45>
    *q = s;
     4c3:	89 37                	mov    %esi,(%edi)
  ret = *s;
     4c5:	0f be 06             	movsbl (%esi),%eax
  switch(*s){
     4c8:	3c 29                	cmp    $0x29,%al
     4ca:	7f 54                	jg     520 <gettoken+0xa0>
     4cc:	3c 28                	cmp    $0x28,%al
     4ce:	0f 8d c8 00 00 00    	jge    59c <gettoken+0x11c>
     4d4:	31 ff                	xor    %edi,%edi
     4d6:	84 c0                	test   %al,%al
     4d8:	0f 85 d2 00 00 00    	jne    5b0 <gettoken+0x130>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     4de:	8b 55 14             	mov    0x14(%ebp),%edx
     4e1:	85 d2                	test   %edx,%edx
     4e3:	74 05                	je     4ea <gettoken+0x6a>
    *eq = s;
     4e5:	8b 45 14             	mov    0x14(%ebp),%eax
     4e8:	89 30                	mov    %esi,(%eax)

  while(s < es && strchr(whitespace, *s))
     4ea:	39 de                	cmp    %ebx,%esi
     4ec:	72 09                	jb     4f7 <gettoken+0x77>
     4ee:	eb 1f                	jmp    50f <gettoken+0x8f>
    s++;
     4f0:	83 c6 01             	add    $0x1,%esi
  while(s < es && strchr(whitespace, *s))
     4f3:	39 f3                	cmp    %esi,%ebx
     4f5:	74 18                	je     50f <gettoken+0x8f>
     4f7:	0f be 06             	movsbl (%esi),%eax
     4fa:	83 ec 08             	sub    $0x8,%esp
     4fd:	50                   	push   %eax
     4fe:	68 f8 18 00 00       	push   $0x18f8
     503:	e8 a8 06 00 00       	call   bb0 <strchr>
     508:	83 c4 10             	add    $0x10,%esp
     50b:	85 c0                	test   %eax,%eax
     50d:	75 e1                	jne    4f0 <gettoken+0x70>
  *ps = s;
     50f:	8b 45 08             	mov    0x8(%ebp),%eax
     512:	89 30                	mov    %esi,(%eax)
  return ret;
}
     514:	8d 65 f4             	lea    -0xc(%ebp),%esp
     517:	89 f8                	mov    %edi,%eax
     519:	5b                   	pop    %ebx
     51a:	5e                   	pop    %esi
     51b:	5f                   	pop    %edi
     51c:	5d                   	pop    %ebp
     51d:	c3                   	ret    
     51e:	66 90                	xchg   %ax,%ax
  switch(*s){
     520:	3c 3e                	cmp    $0x3e,%al
     522:	75 1c                	jne    540 <gettoken+0xc0>
    if(*s == '>'){
     524:	80 7e 01 3e          	cmpb   $0x3e,0x1(%esi)
    s++;
     528:	8d 46 01             	lea    0x1(%esi),%eax
    if(*s == '>'){
     52b:	0f 84 a4 00 00 00    	je     5d5 <gettoken+0x155>
    s++;
     531:	89 c6                	mov    %eax,%esi
     533:	bf 3e 00 00 00       	mov    $0x3e,%edi
     538:	eb a4                	jmp    4de <gettoken+0x5e>
     53a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  switch(*s){
     540:	7f 56                	jg     598 <gettoken+0x118>
     542:	8d 48 c5             	lea    -0x3b(%eax),%ecx
     545:	80 f9 01             	cmp    $0x1,%cl
     548:	76 52                	jbe    59c <gettoken+0x11c>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     54a:	39 f3                	cmp    %esi,%ebx
     54c:	77 24                	ja     572 <gettoken+0xf2>
     54e:	eb 70                	jmp    5c0 <gettoken+0x140>
     550:	0f be 06             	movsbl (%esi),%eax
     553:	83 ec 08             	sub    $0x8,%esp
     556:	50                   	push   %eax
     557:	68 f0 18 00 00       	push   $0x18f0
     55c:	e8 4f 06 00 00       	call   bb0 <strchr>
     561:	83 c4 10             	add    $0x10,%esp
     564:	85 c0                	test   %eax,%eax
     566:	75 1f                	jne    587 <gettoken+0x107>
      s++;
     568:	83 c6 01             	add    $0x1,%esi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     56b:	39 f3                	cmp    %esi,%ebx
     56d:	74 51                	je     5c0 <gettoken+0x140>
     56f:	0f be 06             	movsbl (%esi),%eax
     572:	83 ec 08             	sub    $0x8,%esp
     575:	50                   	push   %eax
     576:	68 f8 18 00 00       	push   $0x18f8
     57b:	e8 30 06 00 00       	call   bb0 <strchr>
     580:	83 c4 10             	add    $0x10,%esp
     583:	85 c0                	test   %eax,%eax
     585:	74 c9                	je     550 <gettoken+0xd0>
    ret = 'a';
     587:	bf 61 00 00 00       	mov    $0x61,%edi
     58c:	e9 4d ff ff ff       	jmp    4de <gettoken+0x5e>
     591:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     598:	3c 7c                	cmp    $0x7c,%al
     59a:	75 ae                	jne    54a <gettoken+0xca>
  ret = *s;
     59c:	0f be f8             	movsbl %al,%edi
    s++;
     59f:	83 c6 01             	add    $0x1,%esi
    break;
     5a2:	e9 37 ff ff ff       	jmp    4de <gettoken+0x5e>
     5a7:	89 f6                	mov    %esi,%esi
     5a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  switch(*s){
     5b0:	3c 26                	cmp    $0x26,%al
     5b2:	75 96                	jne    54a <gettoken+0xca>
     5b4:	eb e6                	jmp    59c <gettoken+0x11c>
     5b6:	8d 76 00             	lea    0x0(%esi),%esi
     5b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(eq)
     5c0:	8b 45 14             	mov    0x14(%ebp),%eax
     5c3:	bf 61 00 00 00       	mov    $0x61,%edi
     5c8:	85 c0                	test   %eax,%eax
     5ca:	0f 85 15 ff ff ff    	jne    4e5 <gettoken+0x65>
     5d0:	e9 3a ff ff ff       	jmp    50f <gettoken+0x8f>
      s++;
     5d5:	83 c6 02             	add    $0x2,%esi
      ret = '+';
     5d8:	bf 2b 00 00 00       	mov    $0x2b,%edi
     5dd:	e9 fc fe ff ff       	jmp    4de <gettoken+0x5e>
     5e2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005f0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     5f0:	55                   	push   %ebp
     5f1:	89 e5                	mov    %esp,%ebp
     5f3:	57                   	push   %edi
     5f4:	56                   	push   %esi
     5f5:	53                   	push   %ebx
     5f6:	83 ec 0c             	sub    $0xc,%esp
     5f9:	8b 7d 08             	mov    0x8(%ebp),%edi
     5fc:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     5ff:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     601:	39 f3                	cmp    %esi,%ebx
     603:	72 12                	jb     617 <peek+0x27>
     605:	eb 28                	jmp    62f <peek+0x3f>
     607:	89 f6                	mov    %esi,%esi
     609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    s++;
     610:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     613:	39 de                	cmp    %ebx,%esi
     615:	74 18                	je     62f <peek+0x3f>
     617:	0f be 03             	movsbl (%ebx),%eax
     61a:	83 ec 08             	sub    $0x8,%esp
     61d:	50                   	push   %eax
     61e:	68 f8 18 00 00       	push   $0x18f8
     623:	e8 88 05 00 00       	call   bb0 <strchr>
     628:	83 c4 10             	add    $0x10,%esp
     62b:	85 c0                	test   %eax,%eax
     62d:	75 e1                	jne    610 <peek+0x20>
  *ps = s;
     62f:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     631:	0f be 13             	movsbl (%ebx),%edx
     634:	31 c0                	xor    %eax,%eax
     636:	84 d2                	test   %dl,%dl
     638:	74 17                	je     651 <peek+0x61>
     63a:	83 ec 08             	sub    $0x8,%esp
     63d:	52                   	push   %edx
     63e:	ff 75 10             	pushl  0x10(%ebp)
     641:	e8 6a 05 00 00       	call   bb0 <strchr>
     646:	83 c4 10             	add    $0x10,%esp
     649:	85 c0                	test   %eax,%eax
     64b:	0f 95 c0             	setne  %al
     64e:	0f b6 c0             	movzbl %al,%eax
}
     651:	8d 65 f4             	lea    -0xc(%ebp),%esp
     654:	5b                   	pop    %ebx
     655:	5e                   	pop    %esi
     656:	5f                   	pop    %edi
     657:	5d                   	pop    %ebp
     658:	c3                   	ret    
     659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000660 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     660:	55                   	push   %ebp
     661:	89 e5                	mov    %esp,%ebp
     663:	57                   	push   %edi
     664:	56                   	push   %esi
     665:	53                   	push   %ebx
     666:	83 ec 1c             	sub    $0x1c,%esp
     669:	8b 75 0c             	mov    0xc(%ebp),%esi
     66c:	8b 5d 10             	mov    0x10(%ebp),%ebx
     66f:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     670:	83 ec 04             	sub    $0x4,%esp
     673:	68 89 12 00 00       	push   $0x1289
     678:	53                   	push   %ebx
     679:	56                   	push   %esi
     67a:	e8 71 ff ff ff       	call   5f0 <peek>
     67f:	83 c4 10             	add    $0x10,%esp
     682:	85 c0                	test   %eax,%eax
     684:	74 6a                	je     6f0 <parseredirs+0x90>
    tok = gettoken(ps, es, 0, 0);
     686:	6a 00                	push   $0x0
     688:	6a 00                	push   $0x0
     68a:	53                   	push   %ebx
     68b:	56                   	push   %esi
     68c:	e8 ef fd ff ff       	call   480 <gettoken>
     691:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     693:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     696:	50                   	push   %eax
     697:	8d 45 e0             	lea    -0x20(%ebp),%eax
     69a:	50                   	push   %eax
     69b:	53                   	push   %ebx
     69c:	56                   	push   %esi
     69d:	e8 de fd ff ff       	call   480 <gettoken>
     6a2:	83 c4 20             	add    $0x20,%esp
     6a5:	83 f8 61             	cmp    $0x61,%eax
     6a8:	75 51                	jne    6fb <parseredirs+0x9b>
      panic("missing file for redirection");
    switch(tok){
     6aa:	83 ff 3c             	cmp    $0x3c,%edi
     6ad:	74 31                	je     6e0 <parseredirs+0x80>
     6af:	83 ff 3e             	cmp    $0x3e,%edi
     6b2:	74 05                	je     6b9 <parseredirs+0x59>
     6b4:	83 ff 2b             	cmp    $0x2b,%edi
     6b7:	75 b7                	jne    670 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     6b9:	83 ec 0c             	sub    $0xc,%esp
     6bc:	6a 01                	push   $0x1
     6be:	68 01 02 00 00       	push   $0x201
     6c3:	ff 75 e4             	pushl  -0x1c(%ebp)
     6c6:	ff 75 e0             	pushl  -0x20(%ebp)
     6c9:	ff 75 08             	pushl  0x8(%ebp)
     6cc:	e8 af fc ff ff       	call   380 <redircmd>
      break;
     6d1:	83 c4 20             	add    $0x20,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     6d4:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     6d7:	eb 97                	jmp    670 <parseredirs+0x10>
     6d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     6e0:	83 ec 0c             	sub    $0xc,%esp
     6e3:	6a 00                	push   $0x0
     6e5:	6a 00                	push   $0x0
     6e7:	eb da                	jmp    6c3 <parseredirs+0x63>
     6e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  return cmd;
}
     6f0:	8b 45 08             	mov    0x8(%ebp),%eax
     6f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6f6:	5b                   	pop    %ebx
     6f7:	5e                   	pop    %esi
     6f8:	5f                   	pop    %edi
     6f9:	5d                   	pop    %ebp
     6fa:	c3                   	ret    
      panic("missing file for redirection");
     6fb:	83 ec 0c             	sub    $0xc,%esp
     6fe:	68 6c 12 00 00       	push   $0x126c
     703:	e8 68 fa ff ff       	call   170 <panic>
     708:	90                   	nop
     709:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000710 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     710:	55                   	push   %ebp
     711:	89 e5                	mov    %esp,%ebp
     713:	57                   	push   %edi
     714:	56                   	push   %esi
     715:	53                   	push   %ebx
     716:	83 ec 30             	sub    $0x30,%esp
     719:	8b 75 08             	mov    0x8(%ebp),%esi
     71c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     71f:	68 8c 12 00 00       	push   $0x128c
     724:	57                   	push   %edi
     725:	56                   	push   %esi
     726:	e8 c5 fe ff ff       	call   5f0 <peek>
     72b:	83 c4 10             	add    $0x10,%esp
     72e:	85 c0                	test   %eax,%eax
     730:	0f 85 92 00 00 00    	jne    7c8 <parseexec+0xb8>
     736:	89 c3                	mov    %eax,%ebx
    return parseblock(ps, es);

  ret = execcmd();
     738:	e8 13 fc ff ff       	call   350 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     73d:	83 ec 04             	sub    $0x4,%esp
  ret = execcmd();
     740:	89 45 d0             	mov    %eax,-0x30(%ebp)
  ret = parseredirs(ret, ps, es);
     743:	57                   	push   %edi
     744:	56                   	push   %esi
     745:	50                   	push   %eax
     746:	e8 15 ff ff ff       	call   660 <parseredirs>
     74b:	83 c4 10             	add    $0x10,%esp
     74e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     751:	eb 18                	jmp    76b <parseexec+0x5b>
     753:	90                   	nop
     754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     758:	83 ec 04             	sub    $0x4,%esp
     75b:	57                   	push   %edi
     75c:	56                   	push   %esi
     75d:	ff 75 d4             	pushl  -0x2c(%ebp)
     760:	e8 fb fe ff ff       	call   660 <parseredirs>
     765:	83 c4 10             	add    $0x10,%esp
     768:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     76b:	83 ec 04             	sub    $0x4,%esp
     76e:	68 a3 12 00 00       	push   $0x12a3
     773:	57                   	push   %edi
     774:	56                   	push   %esi
     775:	e8 76 fe ff ff       	call   5f0 <peek>
     77a:	83 c4 10             	add    $0x10,%esp
     77d:	85 c0                	test   %eax,%eax
     77f:	75 67                	jne    7e8 <parseexec+0xd8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     781:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     784:	50                   	push   %eax
     785:	8d 45 e0             	lea    -0x20(%ebp),%eax
     788:	50                   	push   %eax
     789:	57                   	push   %edi
     78a:	56                   	push   %esi
     78b:	e8 f0 fc ff ff       	call   480 <gettoken>
     790:	83 c4 10             	add    $0x10,%esp
     793:	85 c0                	test   %eax,%eax
     795:	74 51                	je     7e8 <parseexec+0xd8>
    if(tok != 'a')
     797:	83 f8 61             	cmp    $0x61,%eax
     79a:	75 6b                	jne    807 <parseexec+0xf7>
    cmd->argv[argc] = q;
     79c:	8b 45 e0             	mov    -0x20(%ebp),%eax
     79f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     7a2:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
     7a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     7a9:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
    argc++;
     7ad:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
     7b0:	83 fb 0a             	cmp    $0xa,%ebx
     7b3:	75 a3                	jne    758 <parseexec+0x48>
      panic("too many args");
     7b5:	83 ec 0c             	sub    $0xc,%esp
     7b8:	68 95 12 00 00       	push   $0x1295
     7bd:	e8 ae f9 ff ff       	call   170 <panic>
     7c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     7c8:	83 ec 08             	sub    $0x8,%esp
     7cb:	57                   	push   %edi
     7cc:	56                   	push   %esi
     7cd:	e8 5e 01 00 00       	call   930 <parseblock>
     7d2:	83 c4 10             	add    $0x10,%esp
     7d5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     7d8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     7db:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7de:	5b                   	pop    %ebx
     7df:	5e                   	pop    %esi
     7e0:	5f                   	pop    %edi
     7e1:	5d                   	pop    %ebp
     7e2:	c3                   	ret    
     7e3:	90                   	nop
     7e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     7e8:	8b 45 d0             	mov    -0x30(%ebp),%eax
     7eb:	8d 04 98             	lea    (%eax,%ebx,4),%eax
  cmd->argv[argc] = 0;
     7ee:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
     7f5:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
}
     7fc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     7ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
     802:	5b                   	pop    %ebx
     803:	5e                   	pop    %esi
     804:	5f                   	pop    %edi
     805:	5d                   	pop    %ebp
     806:	c3                   	ret    
      panic("syntax");
     807:	83 ec 0c             	sub    $0xc,%esp
     80a:	68 8e 12 00 00       	push   $0x128e
     80f:	e8 5c f9 ff ff       	call   170 <panic>
     814:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     81a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000820 <parsepipe>:
{
     820:	55                   	push   %ebp
     821:	89 e5                	mov    %esp,%ebp
     823:	57                   	push   %edi
     824:	56                   	push   %esi
     825:	53                   	push   %ebx
     826:	83 ec 14             	sub    $0x14,%esp
     829:	8b 5d 08             	mov    0x8(%ebp),%ebx
     82c:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parseexec(ps, es);
     82f:	56                   	push   %esi
     830:	53                   	push   %ebx
     831:	e8 da fe ff ff       	call   710 <parseexec>
  if(peek(ps, es, "|")){
     836:	83 c4 0c             	add    $0xc,%esp
  cmd = parseexec(ps, es);
     839:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     83b:	68 a8 12 00 00       	push   $0x12a8
     840:	56                   	push   %esi
     841:	53                   	push   %ebx
     842:	e8 a9 fd ff ff       	call   5f0 <peek>
     847:	83 c4 10             	add    $0x10,%esp
     84a:	85 c0                	test   %eax,%eax
     84c:	75 12                	jne    860 <parsepipe+0x40>
}
     84e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     851:	89 f8                	mov    %edi,%eax
     853:	5b                   	pop    %ebx
     854:	5e                   	pop    %esi
     855:	5f                   	pop    %edi
     856:	5d                   	pop    %ebp
     857:	c3                   	ret    
     858:	90                   	nop
     859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    gettoken(ps, es, 0, 0);
     860:	6a 00                	push   $0x0
     862:	6a 00                	push   $0x0
     864:	56                   	push   %esi
     865:	53                   	push   %ebx
     866:	e8 15 fc ff ff       	call   480 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     86b:	58                   	pop    %eax
     86c:	5a                   	pop    %edx
     86d:	56                   	push   %esi
     86e:	53                   	push   %ebx
     86f:	e8 ac ff ff ff       	call   820 <parsepipe>
     874:	89 7d 08             	mov    %edi,0x8(%ebp)
     877:	89 45 0c             	mov    %eax,0xc(%ebp)
     87a:	83 c4 10             	add    $0x10,%esp
}
     87d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     880:	5b                   	pop    %ebx
     881:	5e                   	pop    %esi
     882:	5f                   	pop    %edi
     883:	5d                   	pop    %ebp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     884:	e9 47 fb ff ff       	jmp    3d0 <pipecmd>
     889:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000890 <parseline>:
{
     890:	55                   	push   %ebp
     891:	89 e5                	mov    %esp,%ebp
     893:	57                   	push   %edi
     894:	56                   	push   %esi
     895:	53                   	push   %ebx
     896:	83 ec 14             	sub    $0x14,%esp
     899:	8b 5d 08             	mov    0x8(%ebp),%ebx
     89c:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parsepipe(ps, es);
     89f:	56                   	push   %esi
     8a0:	53                   	push   %ebx
     8a1:	e8 7a ff ff ff       	call   820 <parsepipe>
  while(peek(ps, es, "&")){
     8a6:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     8a9:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     8ab:	eb 1b                	jmp    8c8 <parseline+0x38>
     8ad:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     8b0:	6a 00                	push   $0x0
     8b2:	6a 00                	push   $0x0
     8b4:	56                   	push   %esi
     8b5:	53                   	push   %ebx
     8b6:	e8 c5 fb ff ff       	call   480 <gettoken>
    cmd = backcmd(cmd);
     8bb:	89 3c 24             	mov    %edi,(%esp)
     8be:	e8 8d fb ff ff       	call   450 <backcmd>
     8c3:	83 c4 10             	add    $0x10,%esp
     8c6:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     8c8:	83 ec 04             	sub    $0x4,%esp
     8cb:	68 aa 12 00 00       	push   $0x12aa
     8d0:	56                   	push   %esi
     8d1:	53                   	push   %ebx
     8d2:	e8 19 fd ff ff       	call   5f0 <peek>
     8d7:	83 c4 10             	add    $0x10,%esp
     8da:	85 c0                	test   %eax,%eax
     8dc:	75 d2                	jne    8b0 <parseline+0x20>
  if(peek(ps, es, ";")){
     8de:	83 ec 04             	sub    $0x4,%esp
     8e1:	68 a6 12 00 00       	push   $0x12a6
     8e6:	56                   	push   %esi
     8e7:	53                   	push   %ebx
     8e8:	e8 03 fd ff ff       	call   5f0 <peek>
     8ed:	83 c4 10             	add    $0x10,%esp
     8f0:	85 c0                	test   %eax,%eax
     8f2:	75 0c                	jne    900 <parseline+0x70>
}
     8f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8f7:	89 f8                	mov    %edi,%eax
     8f9:	5b                   	pop    %ebx
     8fa:	5e                   	pop    %esi
     8fb:	5f                   	pop    %edi
     8fc:	5d                   	pop    %ebp
     8fd:	c3                   	ret    
     8fe:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     900:	6a 00                	push   $0x0
     902:	6a 00                	push   $0x0
     904:	56                   	push   %esi
     905:	53                   	push   %ebx
     906:	e8 75 fb ff ff       	call   480 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     90b:	58                   	pop    %eax
     90c:	5a                   	pop    %edx
     90d:	56                   	push   %esi
     90e:	53                   	push   %ebx
     90f:	e8 7c ff ff ff       	call   890 <parseline>
     914:	89 7d 08             	mov    %edi,0x8(%ebp)
     917:	89 45 0c             	mov    %eax,0xc(%ebp)
     91a:	83 c4 10             	add    $0x10,%esp
}
     91d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     920:	5b                   	pop    %ebx
     921:	5e                   	pop    %esi
     922:	5f                   	pop    %edi
     923:	5d                   	pop    %ebp
    cmd = listcmd(cmd, parseline(ps, es));
     924:	e9 e7 fa ff ff       	jmp    410 <listcmd>
     929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000930 <parseblock>:
{
     930:	55                   	push   %ebp
     931:	89 e5                	mov    %esp,%ebp
     933:	57                   	push   %edi
     934:	56                   	push   %esi
     935:	53                   	push   %ebx
     936:	83 ec 10             	sub    $0x10,%esp
     939:	8b 5d 08             	mov    0x8(%ebp),%ebx
     93c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     93f:	68 8c 12 00 00       	push   $0x128c
     944:	56                   	push   %esi
     945:	53                   	push   %ebx
     946:	e8 a5 fc ff ff       	call   5f0 <peek>
     94b:	83 c4 10             	add    $0x10,%esp
     94e:	85 c0                	test   %eax,%eax
     950:	74 4a                	je     99c <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     952:	6a 00                	push   $0x0
     954:	6a 00                	push   $0x0
     956:	56                   	push   %esi
     957:	53                   	push   %ebx
     958:	e8 23 fb ff ff       	call   480 <gettoken>
  cmd = parseline(ps, es);
     95d:	58                   	pop    %eax
     95e:	5a                   	pop    %edx
     95f:	56                   	push   %esi
     960:	53                   	push   %ebx
     961:	e8 2a ff ff ff       	call   890 <parseline>
  if(!peek(ps, es, ")"))
     966:	83 c4 0c             	add    $0xc,%esp
  cmd = parseline(ps, es);
     969:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     96b:	68 c8 12 00 00       	push   $0x12c8
     970:	56                   	push   %esi
     971:	53                   	push   %ebx
     972:	e8 79 fc ff ff       	call   5f0 <peek>
     977:	83 c4 10             	add    $0x10,%esp
     97a:	85 c0                	test   %eax,%eax
     97c:	74 2b                	je     9a9 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     97e:	6a 00                	push   $0x0
     980:	6a 00                	push   $0x0
     982:	56                   	push   %esi
     983:	53                   	push   %ebx
     984:	e8 f7 fa ff ff       	call   480 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     989:	83 c4 0c             	add    $0xc,%esp
     98c:	56                   	push   %esi
     98d:	53                   	push   %ebx
     98e:	57                   	push   %edi
     98f:	e8 cc fc ff ff       	call   660 <parseredirs>
}
     994:	8d 65 f4             	lea    -0xc(%ebp),%esp
     997:	5b                   	pop    %ebx
     998:	5e                   	pop    %esi
     999:	5f                   	pop    %edi
     99a:	5d                   	pop    %ebp
     99b:	c3                   	ret    
    panic("parseblock");
     99c:	83 ec 0c             	sub    $0xc,%esp
     99f:	68 ac 12 00 00       	push   $0x12ac
     9a4:	e8 c7 f7 ff ff       	call   170 <panic>
    panic("syntax - missing )");
     9a9:	83 ec 0c             	sub    $0xc,%esp
     9ac:	68 b7 12 00 00       	push   $0x12b7
     9b1:	e8 ba f7 ff ff       	call   170 <panic>
     9b6:	8d 76 00             	lea    0x0(%esi),%esi
     9b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009c0 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     9c0:	55                   	push   %ebp
     9c1:	89 e5                	mov    %esp,%ebp
     9c3:	53                   	push   %ebx
     9c4:	83 ec 04             	sub    $0x4,%esp
     9c7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     9ca:	85 db                	test   %ebx,%ebx
     9cc:	74 20                	je     9ee <nulterminate+0x2e>
    return 0;

  switch(cmd->type){
     9ce:	83 3b 05             	cmpl   $0x5,(%ebx)
     9d1:	77 1b                	ja     9ee <nulterminate+0x2e>
     9d3:	8b 03                	mov    (%ebx),%eax
     9d5:	ff 24 85 14 13 00 00 	jmp    *0x1314(,%eax,4)
     9dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
     9e0:	83 ec 0c             	sub    $0xc,%esp
     9e3:	ff 73 04             	pushl  0x4(%ebx)
     9e6:	e8 d5 ff ff ff       	call   9c0 <nulterminate>
    break;
     9eb:	83 c4 10             	add    $0x10,%esp
  }
  return cmd;
}
     9ee:	89 d8                	mov    %ebx,%eax
     9f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     9f3:	c9                   	leave  
     9f4:	c3                   	ret    
     9f5:	8d 76 00             	lea    0x0(%esi),%esi
    nulterminate(lcmd->left);
     9f8:	83 ec 0c             	sub    $0xc,%esp
     9fb:	ff 73 04             	pushl  0x4(%ebx)
     9fe:	e8 bd ff ff ff       	call   9c0 <nulterminate>
    nulterminate(lcmd->right);
     a03:	58                   	pop    %eax
     a04:	ff 73 08             	pushl  0x8(%ebx)
     a07:	e8 b4 ff ff ff       	call   9c0 <nulterminate>
}
     a0c:	89 d8                	mov    %ebx,%eax
    break;
     a0e:	83 c4 10             	add    $0x10,%esp
}
     a11:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a14:	c9                   	leave  
     a15:	c3                   	ret    
     a16:	8d 76 00             	lea    0x0(%esi),%esi
     a19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for(i=0; ecmd->argv[i]; i++)
     a20:	8b 4b 04             	mov    0x4(%ebx),%ecx
     a23:	8d 43 08             	lea    0x8(%ebx),%eax
     a26:	85 c9                	test   %ecx,%ecx
     a28:	74 c4                	je     9ee <nulterminate+0x2e>
     a2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     a30:	8b 50 24             	mov    0x24(%eax),%edx
     a33:	83 c0 04             	add    $0x4,%eax
     a36:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     a39:	8b 50 fc             	mov    -0x4(%eax),%edx
     a3c:	85 d2                	test   %edx,%edx
     a3e:	75 f0                	jne    a30 <nulterminate+0x70>
}
     a40:	89 d8                	mov    %ebx,%eax
     a42:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a45:	c9                   	leave  
     a46:	c3                   	ret    
     a47:	89 f6                	mov    %esi,%esi
     a49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    nulterminate(rcmd->cmd);
     a50:	83 ec 0c             	sub    $0xc,%esp
     a53:	ff 73 04             	pushl  0x4(%ebx)
     a56:	e8 65 ff ff ff       	call   9c0 <nulterminate>
    *rcmd->efile = 0;
     a5b:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     a5e:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     a61:	c6 00 00             	movb   $0x0,(%eax)
}
     a64:	89 d8                	mov    %ebx,%eax
     a66:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a69:	c9                   	leave  
     a6a:	c3                   	ret    
     a6b:	90                   	nop
     a6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a70 <parsecmd>:
{
     a70:	55                   	push   %ebp
     a71:	89 e5                	mov    %esp,%ebp
     a73:	56                   	push   %esi
     a74:	53                   	push   %ebx
  es = s + strlen(s);
     a75:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a78:	83 ec 0c             	sub    $0xc,%esp
     a7b:	53                   	push   %ebx
     a7c:	e8 df 00 00 00       	call   b60 <strlen>
  cmd = parseline(&s, es);
     a81:	59                   	pop    %ecx
  es = s + strlen(s);
     a82:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     a84:	8d 45 08             	lea    0x8(%ebp),%eax
     a87:	5e                   	pop    %esi
     a88:	53                   	push   %ebx
     a89:	50                   	push   %eax
     a8a:	e8 01 fe ff ff       	call   890 <parseline>
     a8f:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     a91:	8d 45 08             	lea    0x8(%ebp),%eax
     a94:	83 c4 0c             	add    $0xc,%esp
     a97:	68 51 12 00 00       	push   $0x1251
     a9c:	53                   	push   %ebx
     a9d:	50                   	push   %eax
     a9e:	e8 4d fb ff ff       	call   5f0 <peek>
  if(s != es){
     aa3:	8b 45 08             	mov    0x8(%ebp),%eax
     aa6:	83 c4 10             	add    $0x10,%esp
     aa9:	39 d8                	cmp    %ebx,%eax
     aab:	75 12                	jne    abf <parsecmd+0x4f>
  nulterminate(cmd);
     aad:	83 ec 0c             	sub    $0xc,%esp
     ab0:	56                   	push   %esi
     ab1:	e8 0a ff ff ff       	call   9c0 <nulterminate>
}
     ab6:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ab9:	89 f0                	mov    %esi,%eax
     abb:	5b                   	pop    %ebx
     abc:	5e                   	pop    %esi
     abd:	5d                   	pop    %ebp
     abe:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     abf:	52                   	push   %edx
     ac0:	50                   	push   %eax
     ac1:	68 ca 12 00 00       	push   $0x12ca
     ac6:	6a 02                	push   $0x2
     ac8:	e8 13 04 00 00       	call   ee0 <printf>
    panic("syntax");
     acd:	c7 04 24 8e 12 00 00 	movl   $0x128e,(%esp)
     ad4:	e8 97 f6 ff ff       	call   170 <panic>
     ad9:	66 90                	xchg   %ax,%ax
     adb:	66 90                	xchg   %ax,%ax
     add:	66 90                	xchg   %ax,%ax
     adf:	90                   	nop

00000ae0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     ae0:	55                   	push   %ebp
     ae1:	89 e5                	mov    %esp,%ebp
     ae3:	53                   	push   %ebx
     ae4:	8b 45 08             	mov    0x8(%ebp),%eax
     ae7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     aea:	89 c2                	mov    %eax,%edx
     aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     af0:	83 c1 01             	add    $0x1,%ecx
     af3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     af7:	83 c2 01             	add    $0x1,%edx
     afa:	84 db                	test   %bl,%bl
     afc:	88 5a ff             	mov    %bl,-0x1(%edx)
     aff:	75 ef                	jne    af0 <strcpy+0x10>
    ;
  return os;
}
     b01:	5b                   	pop    %ebx
     b02:	5d                   	pop    %ebp
     b03:	c3                   	ret    
     b04:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b0a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b10 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b10:	55                   	push   %ebp
     b11:	89 e5                	mov    %esp,%ebp
     b13:	53                   	push   %ebx
     b14:	8b 55 08             	mov    0x8(%ebp),%edx
     b17:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     b1a:	0f b6 02             	movzbl (%edx),%eax
     b1d:	0f b6 19             	movzbl (%ecx),%ebx
     b20:	84 c0                	test   %al,%al
     b22:	75 1c                	jne    b40 <strcmp+0x30>
     b24:	eb 2a                	jmp    b50 <strcmp+0x40>
     b26:	8d 76 00             	lea    0x0(%esi),%esi
     b29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     b30:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     b33:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     b36:	83 c1 01             	add    $0x1,%ecx
     b39:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
     b3c:	84 c0                	test   %al,%al
     b3e:	74 10                	je     b50 <strcmp+0x40>
     b40:	38 d8                	cmp    %bl,%al
     b42:	74 ec                	je     b30 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
     b44:	29 d8                	sub    %ebx,%eax
}
     b46:	5b                   	pop    %ebx
     b47:	5d                   	pop    %ebp
     b48:	c3                   	ret    
     b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b50:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     b52:	29 d8                	sub    %ebx,%eax
}
     b54:	5b                   	pop    %ebx
     b55:	5d                   	pop    %ebp
     b56:	c3                   	ret    
     b57:	89 f6                	mov    %esi,%esi
     b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b60 <strlen>:

uint
strlen(const char *s)
{
     b60:	55                   	push   %ebp
     b61:	89 e5                	mov    %esp,%ebp
     b63:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     b66:	80 39 00             	cmpb   $0x0,(%ecx)
     b69:	74 15                	je     b80 <strlen+0x20>
     b6b:	31 d2                	xor    %edx,%edx
     b6d:	8d 76 00             	lea    0x0(%esi),%esi
     b70:	83 c2 01             	add    $0x1,%edx
     b73:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     b77:	89 d0                	mov    %edx,%eax
     b79:	75 f5                	jne    b70 <strlen+0x10>
    ;
  return n;
}
     b7b:	5d                   	pop    %ebp
     b7c:	c3                   	ret    
     b7d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
     b80:	31 c0                	xor    %eax,%eax
}
     b82:	5d                   	pop    %ebp
     b83:	c3                   	ret    
     b84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b90 <memset>:

void*
memset(void *dst, int c, uint n)
{
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	57                   	push   %edi
     b94:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     b97:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b9a:	8b 45 0c             	mov    0xc(%ebp),%eax
     b9d:	89 d7                	mov    %edx,%edi
     b9f:	fc                   	cld    
     ba0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     ba2:	89 d0                	mov    %edx,%eax
     ba4:	5f                   	pop    %edi
     ba5:	5d                   	pop    %ebp
     ba6:	c3                   	ret    
     ba7:	89 f6                	mov    %esi,%esi
     ba9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bb0 <strchr>:

char*
strchr(const char *s, char c)
{
     bb0:	55                   	push   %ebp
     bb1:	89 e5                	mov    %esp,%ebp
     bb3:	53                   	push   %ebx
     bb4:	8b 45 08             	mov    0x8(%ebp),%eax
     bb7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
     bba:	0f b6 10             	movzbl (%eax),%edx
     bbd:	84 d2                	test   %dl,%dl
     bbf:	74 1d                	je     bde <strchr+0x2e>
    if(*s == c)
     bc1:	38 d3                	cmp    %dl,%bl
     bc3:	89 d9                	mov    %ebx,%ecx
     bc5:	75 0d                	jne    bd4 <strchr+0x24>
     bc7:	eb 17                	jmp    be0 <strchr+0x30>
     bc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bd0:	38 ca                	cmp    %cl,%dl
     bd2:	74 0c                	je     be0 <strchr+0x30>
  for(; *s; s++)
     bd4:	83 c0 01             	add    $0x1,%eax
     bd7:	0f b6 10             	movzbl (%eax),%edx
     bda:	84 d2                	test   %dl,%dl
     bdc:	75 f2                	jne    bd0 <strchr+0x20>
      return (char*)s;
  return 0;
     bde:	31 c0                	xor    %eax,%eax
}
     be0:	5b                   	pop    %ebx
     be1:	5d                   	pop    %ebp
     be2:	c3                   	ret    
     be3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     be9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bf0 <gets>:

char*
gets(char *buf, int max)
{
     bf0:	55                   	push   %ebp
     bf1:	89 e5                	mov    %esp,%ebp
     bf3:	57                   	push   %edi
     bf4:	56                   	push   %esi
     bf5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     bf6:	31 f6                	xor    %esi,%esi
     bf8:	89 f3                	mov    %esi,%ebx
{
     bfa:	83 ec 1c             	sub    $0x1c,%esp
     bfd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
     c00:	eb 2f                	jmp    c31 <gets+0x41>
     c02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
     c08:	8d 45 e7             	lea    -0x19(%ebp),%eax
     c0b:	83 ec 04             	sub    $0x4,%esp
     c0e:	6a 01                	push   $0x1
     c10:	50                   	push   %eax
     c11:	6a 00                	push   $0x0
     c13:	e8 32 01 00 00       	call   d4a <read>
    if(cc < 1)
     c18:	83 c4 10             	add    $0x10,%esp
     c1b:	85 c0                	test   %eax,%eax
     c1d:	7e 1c                	jle    c3b <gets+0x4b>
      break;
    buf[i++] = c;
     c1f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     c23:	83 c7 01             	add    $0x1,%edi
     c26:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
     c29:	3c 0a                	cmp    $0xa,%al
     c2b:	74 23                	je     c50 <gets+0x60>
     c2d:	3c 0d                	cmp    $0xd,%al
     c2f:	74 1f                	je     c50 <gets+0x60>
  for(i=0; i+1 < max; ){
     c31:	83 c3 01             	add    $0x1,%ebx
     c34:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     c37:	89 fe                	mov    %edi,%esi
     c39:	7c cd                	jl     c08 <gets+0x18>
     c3b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
     c3d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
     c40:	c6 03 00             	movb   $0x0,(%ebx)
}
     c43:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c46:	5b                   	pop    %ebx
     c47:	5e                   	pop    %esi
     c48:	5f                   	pop    %edi
     c49:	5d                   	pop    %ebp
     c4a:	c3                   	ret    
     c4b:	90                   	nop
     c4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c50:	8b 75 08             	mov    0x8(%ebp),%esi
     c53:	8b 45 08             	mov    0x8(%ebp),%eax
     c56:	01 de                	add    %ebx,%esi
     c58:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
     c5a:	c6 03 00             	movb   $0x0,(%ebx)
}
     c5d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c60:	5b                   	pop    %ebx
     c61:	5e                   	pop    %esi
     c62:	5f                   	pop    %edi
     c63:	5d                   	pop    %ebp
     c64:	c3                   	ret    
     c65:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c70 <stat>:

int
stat(const char *n, struct stat *st)
{
     c70:	55                   	push   %ebp
     c71:	89 e5                	mov    %esp,%ebp
     c73:	56                   	push   %esi
     c74:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     c75:	83 ec 08             	sub    $0x8,%esp
     c78:	6a 00                	push   $0x0
     c7a:	ff 75 08             	pushl  0x8(%ebp)
     c7d:	e8 f0 00 00 00       	call   d72 <open>
  if(fd < 0)
     c82:	83 c4 10             	add    $0x10,%esp
     c85:	85 c0                	test   %eax,%eax
     c87:	78 27                	js     cb0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     c89:	83 ec 08             	sub    $0x8,%esp
     c8c:	ff 75 0c             	pushl  0xc(%ebp)
     c8f:	89 c3                	mov    %eax,%ebx
     c91:	50                   	push   %eax
     c92:	e8 f3 00 00 00       	call   d8a <fstat>
  close(fd);
     c97:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     c9a:	89 c6                	mov    %eax,%esi
  close(fd);
     c9c:	e8 b9 00 00 00       	call   d5a <close>
  return r;
     ca1:	83 c4 10             	add    $0x10,%esp
}
     ca4:	8d 65 f8             	lea    -0x8(%ebp),%esp
     ca7:	89 f0                	mov    %esi,%eax
     ca9:	5b                   	pop    %ebx
     caa:	5e                   	pop    %esi
     cab:	5d                   	pop    %ebp
     cac:	c3                   	ret    
     cad:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     cb0:	be ff ff ff ff       	mov    $0xffffffff,%esi
     cb5:	eb ed                	jmp    ca4 <stat+0x34>
     cb7:	89 f6                	mov    %esi,%esi
     cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000cc0 <atoi>:

int
atoi(const char *s)
{
     cc0:	55                   	push   %ebp
     cc1:	89 e5                	mov    %esp,%ebp
     cc3:	53                   	push   %ebx
     cc4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     cc7:	0f be 11             	movsbl (%ecx),%edx
     cca:	8d 42 d0             	lea    -0x30(%edx),%eax
     ccd:	3c 09                	cmp    $0x9,%al
  n = 0;
     ccf:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     cd4:	77 1f                	ja     cf5 <atoi+0x35>
     cd6:	8d 76 00             	lea    0x0(%esi),%esi
     cd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     ce0:	8d 04 80             	lea    (%eax,%eax,4),%eax
     ce3:	83 c1 01             	add    $0x1,%ecx
     ce6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     cea:	0f be 11             	movsbl (%ecx),%edx
     ced:	8d 5a d0             	lea    -0x30(%edx),%ebx
     cf0:	80 fb 09             	cmp    $0x9,%bl
     cf3:	76 eb                	jbe    ce0 <atoi+0x20>
  return n;
}
     cf5:	5b                   	pop    %ebx
     cf6:	5d                   	pop    %ebp
     cf7:	c3                   	ret    
     cf8:	90                   	nop
     cf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000d00 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     d00:	55                   	push   %ebp
     d01:	89 e5                	mov    %esp,%ebp
     d03:	56                   	push   %esi
     d04:	53                   	push   %ebx
     d05:	8b 5d 10             	mov    0x10(%ebp),%ebx
     d08:	8b 45 08             	mov    0x8(%ebp),%eax
     d0b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     d0e:	85 db                	test   %ebx,%ebx
     d10:	7e 14                	jle    d26 <memmove+0x26>
     d12:	31 d2                	xor    %edx,%edx
     d14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     d18:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     d1c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     d1f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
     d22:	39 d3                	cmp    %edx,%ebx
     d24:	75 f2                	jne    d18 <memmove+0x18>
  return vdst;
}
     d26:	5b                   	pop    %ebx
     d27:	5e                   	pop    %esi
     d28:	5d                   	pop    %ebp
     d29:	c3                   	ret    

00000d2a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     d2a:	b8 01 00 00 00       	mov    $0x1,%eax
     d2f:	cd 40                	int    $0x40
     d31:	c3                   	ret    

00000d32 <exit>:
SYSCALL(exit)
     d32:	b8 02 00 00 00       	mov    $0x2,%eax
     d37:	cd 40                	int    $0x40
     d39:	c3                   	ret    

00000d3a <wait>:
SYSCALL(wait)
     d3a:	b8 03 00 00 00       	mov    $0x3,%eax
     d3f:	cd 40                	int    $0x40
     d41:	c3                   	ret    

00000d42 <pipe>:
SYSCALL(pipe)
     d42:	b8 04 00 00 00       	mov    $0x4,%eax
     d47:	cd 40                	int    $0x40
     d49:	c3                   	ret    

00000d4a <read>:
SYSCALL(read)
     d4a:	b8 05 00 00 00       	mov    $0x5,%eax
     d4f:	cd 40                	int    $0x40
     d51:	c3                   	ret    

00000d52 <write>:
SYSCALL(write)
     d52:	b8 10 00 00 00       	mov    $0x10,%eax
     d57:	cd 40                	int    $0x40
     d59:	c3                   	ret    

00000d5a <close>:
SYSCALL(close)
     d5a:	b8 15 00 00 00       	mov    $0x15,%eax
     d5f:	cd 40                	int    $0x40
     d61:	c3                   	ret    

00000d62 <kill>:
SYSCALL(kill)
     d62:	b8 06 00 00 00       	mov    $0x6,%eax
     d67:	cd 40                	int    $0x40
     d69:	c3                   	ret    

00000d6a <exec>:
SYSCALL(exec)
     d6a:	b8 07 00 00 00       	mov    $0x7,%eax
     d6f:	cd 40                	int    $0x40
     d71:	c3                   	ret    

00000d72 <open>:
SYSCALL(open)
     d72:	b8 0f 00 00 00       	mov    $0xf,%eax
     d77:	cd 40                	int    $0x40
     d79:	c3                   	ret    

00000d7a <mknod>:
SYSCALL(mknod)
     d7a:	b8 11 00 00 00       	mov    $0x11,%eax
     d7f:	cd 40                	int    $0x40
     d81:	c3                   	ret    

00000d82 <unlink>:
SYSCALL(unlink)
     d82:	b8 12 00 00 00       	mov    $0x12,%eax
     d87:	cd 40                	int    $0x40
     d89:	c3                   	ret    

00000d8a <fstat>:
SYSCALL(fstat)
     d8a:	b8 08 00 00 00       	mov    $0x8,%eax
     d8f:	cd 40                	int    $0x40
     d91:	c3                   	ret    

00000d92 <link>:
SYSCALL(link)
     d92:	b8 13 00 00 00       	mov    $0x13,%eax
     d97:	cd 40                	int    $0x40
     d99:	c3                   	ret    

00000d9a <mkdir>:
SYSCALL(mkdir)
     d9a:	b8 14 00 00 00       	mov    $0x14,%eax
     d9f:	cd 40                	int    $0x40
     da1:	c3                   	ret    

00000da2 <chdir>:
SYSCALL(chdir)
     da2:	b8 09 00 00 00       	mov    $0x9,%eax
     da7:	cd 40                	int    $0x40
     da9:	c3                   	ret    

00000daa <dup>:
SYSCALL(dup)
     daa:	b8 0a 00 00 00       	mov    $0xa,%eax
     daf:	cd 40                	int    $0x40
     db1:	c3                   	ret    

00000db2 <getpid>:
SYSCALL(getpid)
     db2:	b8 0b 00 00 00       	mov    $0xb,%eax
     db7:	cd 40                	int    $0x40
     db9:	c3                   	ret    

00000dba <sbrk>:
SYSCALL(sbrk)
     dba:	b8 0c 00 00 00       	mov    $0xc,%eax
     dbf:	cd 40                	int    $0x40
     dc1:	c3                   	ret    

00000dc2 <sleep>:
SYSCALL(sleep)
     dc2:	b8 0d 00 00 00       	mov    $0xd,%eax
     dc7:	cd 40                	int    $0x40
     dc9:	c3                   	ret    

00000dca <uptime>:
SYSCALL(uptime)
     dca:	b8 0e 00 00 00       	mov    $0xe,%eax
     dcf:	cd 40                	int    $0x40
     dd1:	c3                   	ret    

00000dd2 <halt>:
SYSCALL(halt)
     dd2:	b8 1f 00 00 00       	mov    $0x1f,%eax
     dd7:	cd 40                	int    $0x40
     dd9:	c3                   	ret    

00000dda <toggle>:
SYSCALL(toggle)
     dda:	b8 16 00 00 00       	mov    $0x16,%eax
     ddf:	cd 40                	int    $0x40
     de1:	c3                   	ret    

00000de2 <add>:
SYSCALL(add)
     de2:	b8 17 00 00 00       	mov    $0x17,%eax
     de7:	cd 40                	int    $0x40
     de9:	c3                   	ret    

00000dea <ps>:
SYSCALL(ps)
     dea:	b8 18 00 00 00       	mov    $0x18,%eax
     def:	cd 40                	int    $0x40
     df1:	c3                   	ret    

00000df2 <send>:
SYSCALL(send)
     df2:	b8 19 00 00 00       	mov    $0x19,%eax
     df7:	cd 40                	int    $0x40
     df9:	c3                   	ret    

00000dfa <recv>:
SYSCALL(recv)
     dfa:	b8 1a 00 00 00       	mov    $0x1a,%eax
     dff:	cd 40                	int    $0x40
     e01:	c3                   	ret    

00000e02 <print_count>:
SYSCALL(print_count)
     e02:	b8 1b 00 00 00       	mov    $0x1b,%eax
     e07:	cd 40                	int    $0x40
     e09:	c3                   	ret    

00000e0a <send_multi>:
SYSCALL(send_multi)
     e0a:	b8 1c 00 00 00       	mov    $0x1c,%eax
     e0f:	cd 40                	int    $0x40
     e11:	c3                   	ret    

00000e12 <signal>:
SYSCALL(signal)
     e12:	b8 1d 00 00 00       	mov    $0x1d,%eax
     e17:	cd 40                	int    $0x40
     e19:	c3                   	ret    

00000e1a <sigraise>:
SYSCALL(sigraise)
     e1a:	b8 1e 00 00 00       	mov    $0x1e,%eax
     e1f:	cd 40                	int    $0x40
     e21:	c3                   	ret    

00000e22 <recv_multi>:
SYSCALL(recv_multi)
     e22:	b8 20 00 00 00       	mov    $0x20,%eax
     e27:	cd 40                	int    $0x40
     e29:	c3                   	ret    

00000e2a <change_state>:
SYSCALL(change_state)
     e2a:	b8 21 00 00 00       	mov    $0x21,%eax
     e2f:	cd 40                	int    $0x40
     e31:	c3                   	ret    
     e32:	66 90                	xchg   %ax,%ax
     e34:	66 90                	xchg   %ax,%ax
     e36:	66 90                	xchg   %ax,%ax
     e38:	66 90                	xchg   %ax,%ax
     e3a:	66 90                	xchg   %ax,%ax
     e3c:	66 90                	xchg   %ax,%ax
     e3e:	66 90                	xchg   %ax,%ax

00000e40 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     e40:	55                   	push   %ebp
     e41:	89 e5                	mov    %esp,%ebp
     e43:	57                   	push   %edi
     e44:	56                   	push   %esi
     e45:	53                   	push   %ebx
     e46:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     e49:	85 d2                	test   %edx,%edx
{
     e4b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
     e4e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
     e50:	79 76                	jns    ec8 <printint+0x88>
     e52:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
     e56:	74 70                	je     ec8 <printint+0x88>
    x = -xx;
     e58:	f7 d8                	neg    %eax
    neg = 1;
     e5a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
     e61:	31 f6                	xor    %esi,%esi
     e63:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     e66:	eb 0a                	jmp    e72 <printint+0x32>
     e68:	90                   	nop
     e69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
     e70:	89 fe                	mov    %edi,%esi
     e72:	31 d2                	xor    %edx,%edx
     e74:	8d 7e 01             	lea    0x1(%esi),%edi
     e77:	f7 f1                	div    %ecx
     e79:	0f b6 92 34 13 00 00 	movzbl 0x1334(%edx),%edx
  }while((x /= base) != 0);
     e80:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
     e82:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
     e85:	75 e9                	jne    e70 <printint+0x30>
  if(neg)
     e87:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     e8a:	85 c0                	test   %eax,%eax
     e8c:	74 08                	je     e96 <printint+0x56>
    buf[i++] = '-';
     e8e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
     e93:	8d 7e 02             	lea    0x2(%esi),%edi
     e96:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
     e9a:	8b 7d c0             	mov    -0x40(%ebp),%edi
     e9d:	8d 76 00             	lea    0x0(%esi),%esi
     ea0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
     ea3:	83 ec 04             	sub    $0x4,%esp
     ea6:	83 ee 01             	sub    $0x1,%esi
     ea9:	6a 01                	push   $0x1
     eab:	53                   	push   %ebx
     eac:	57                   	push   %edi
     ead:	88 45 d7             	mov    %al,-0x29(%ebp)
     eb0:	e8 9d fe ff ff       	call   d52 <write>

  while(--i >= 0)
     eb5:	83 c4 10             	add    $0x10,%esp
     eb8:	39 de                	cmp    %ebx,%esi
     eba:	75 e4                	jne    ea0 <printint+0x60>
    putc(fd, buf[i]);
}
     ebc:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ebf:	5b                   	pop    %ebx
     ec0:	5e                   	pop    %esi
     ec1:	5f                   	pop    %edi
     ec2:	5d                   	pop    %ebp
     ec3:	c3                   	ret    
     ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
     ec8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
     ecf:	eb 90                	jmp    e61 <printint+0x21>
     ed1:	eb 0d                	jmp    ee0 <printf>
     ed3:	90                   	nop
     ed4:	90                   	nop
     ed5:	90                   	nop
     ed6:	90                   	nop
     ed7:	90                   	nop
     ed8:	90                   	nop
     ed9:	90                   	nop
     eda:	90                   	nop
     edb:	90                   	nop
     edc:	90                   	nop
     edd:	90                   	nop
     ede:	90                   	nop
     edf:	90                   	nop

00000ee0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
     ee0:	55                   	push   %ebp
     ee1:	89 e5                	mov    %esp,%ebp
     ee3:	57                   	push   %edi
     ee4:	56                   	push   %esi
     ee5:	53                   	push   %ebx
     ee6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     ee9:	8b 75 0c             	mov    0xc(%ebp),%esi
     eec:	0f b6 1e             	movzbl (%esi),%ebx
     eef:	84 db                	test   %bl,%bl
     ef1:	0f 84 b3 00 00 00    	je     faa <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
     ef7:	8d 45 10             	lea    0x10(%ebp),%eax
     efa:	83 c6 01             	add    $0x1,%esi
  state = 0;
     efd:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
     eff:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     f02:	eb 2f                	jmp    f33 <printf+0x53>
     f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     f08:	83 f8 25             	cmp    $0x25,%eax
     f0b:	0f 84 a7 00 00 00    	je     fb8 <printf+0xd8>
  write(fd, &c, 1);
     f11:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     f14:	83 ec 04             	sub    $0x4,%esp
     f17:	88 5d e2             	mov    %bl,-0x1e(%ebp)
     f1a:	6a 01                	push   $0x1
     f1c:	50                   	push   %eax
     f1d:	ff 75 08             	pushl  0x8(%ebp)
     f20:	e8 2d fe ff ff       	call   d52 <write>
     f25:	83 c4 10             	add    $0x10,%esp
     f28:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
     f2b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
     f2f:	84 db                	test   %bl,%bl
     f31:	74 77                	je     faa <printf+0xca>
    if(state == 0){
     f33:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
     f35:	0f be cb             	movsbl %bl,%ecx
     f38:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
     f3b:	74 cb                	je     f08 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     f3d:	83 ff 25             	cmp    $0x25,%edi
     f40:	75 e6                	jne    f28 <printf+0x48>
      if(c == 'd'){
     f42:	83 f8 64             	cmp    $0x64,%eax
     f45:	0f 84 05 01 00 00    	je     1050 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     f4b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
     f51:	83 f9 70             	cmp    $0x70,%ecx
     f54:	74 72                	je     fc8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     f56:	83 f8 73             	cmp    $0x73,%eax
     f59:	0f 84 99 00 00 00    	je     ff8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     f5f:	83 f8 63             	cmp    $0x63,%eax
     f62:	0f 84 08 01 00 00    	je     1070 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     f68:	83 f8 25             	cmp    $0x25,%eax
     f6b:	0f 84 ef 00 00 00    	je     1060 <printf+0x180>
  write(fd, &c, 1);
     f71:	8d 45 e7             	lea    -0x19(%ebp),%eax
     f74:	83 ec 04             	sub    $0x4,%esp
     f77:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
     f7b:	6a 01                	push   $0x1
     f7d:	50                   	push   %eax
     f7e:	ff 75 08             	pushl  0x8(%ebp)
     f81:	e8 cc fd ff ff       	call   d52 <write>
     f86:	83 c4 0c             	add    $0xc,%esp
     f89:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     f8c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
     f8f:	6a 01                	push   $0x1
     f91:	50                   	push   %eax
     f92:	ff 75 08             	pushl  0x8(%ebp)
     f95:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     f98:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
     f9a:	e8 b3 fd ff ff       	call   d52 <write>
  for(i = 0; fmt[i]; i++){
     f9f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
     fa3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
     fa6:	84 db                	test   %bl,%bl
     fa8:	75 89                	jne    f33 <printf+0x53>
    }
  }
}
     faa:	8d 65 f4             	lea    -0xc(%ebp),%esp
     fad:	5b                   	pop    %ebx
     fae:	5e                   	pop    %esi
     faf:	5f                   	pop    %edi
     fb0:	5d                   	pop    %ebp
     fb1:	c3                   	ret    
     fb2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
     fb8:	bf 25 00 00 00       	mov    $0x25,%edi
     fbd:	e9 66 ff ff ff       	jmp    f28 <printf+0x48>
     fc2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
     fc8:	83 ec 0c             	sub    $0xc,%esp
     fcb:	b9 10 00 00 00       	mov    $0x10,%ecx
     fd0:	6a 00                	push   $0x0
     fd2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
     fd5:	8b 45 08             	mov    0x8(%ebp),%eax
     fd8:	8b 17                	mov    (%edi),%edx
     fda:	e8 61 fe ff ff       	call   e40 <printint>
        ap++;
     fdf:	89 f8                	mov    %edi,%eax
     fe1:	83 c4 10             	add    $0x10,%esp
      state = 0;
     fe4:	31 ff                	xor    %edi,%edi
        ap++;
     fe6:	83 c0 04             	add    $0x4,%eax
     fe9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     fec:	e9 37 ff ff ff       	jmp    f28 <printf+0x48>
     ff1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
     ff8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     ffb:	8b 08                	mov    (%eax),%ecx
        ap++;
     ffd:	83 c0 04             	add    $0x4,%eax
    1000:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    1003:	85 c9                	test   %ecx,%ecx
    1005:	0f 84 8e 00 00 00    	je     1099 <printf+0x1b9>
        while(*s != 0){
    100b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    100e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    1010:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    1012:	84 c0                	test   %al,%al
    1014:	0f 84 0e ff ff ff    	je     f28 <printf+0x48>
    101a:	89 75 d0             	mov    %esi,-0x30(%ebp)
    101d:	89 de                	mov    %ebx,%esi
    101f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1022:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    1025:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    1028:	83 ec 04             	sub    $0x4,%esp
          s++;
    102b:	83 c6 01             	add    $0x1,%esi
    102e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1031:	6a 01                	push   $0x1
    1033:	57                   	push   %edi
    1034:	53                   	push   %ebx
    1035:	e8 18 fd ff ff       	call   d52 <write>
        while(*s != 0){
    103a:	0f b6 06             	movzbl (%esi),%eax
    103d:	83 c4 10             	add    $0x10,%esp
    1040:	84 c0                	test   %al,%al
    1042:	75 e4                	jne    1028 <printf+0x148>
    1044:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    1047:	31 ff                	xor    %edi,%edi
    1049:	e9 da fe ff ff       	jmp    f28 <printf+0x48>
    104e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    1050:	83 ec 0c             	sub    $0xc,%esp
    1053:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1058:	6a 01                	push   $0x1
    105a:	e9 73 ff ff ff       	jmp    fd2 <printf+0xf2>
    105f:	90                   	nop
  write(fd, &c, 1);
    1060:	83 ec 04             	sub    $0x4,%esp
    1063:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    1066:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1069:	6a 01                	push   $0x1
    106b:	e9 21 ff ff ff       	jmp    f91 <printf+0xb1>
        putc(fd, *ap);
    1070:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    1073:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1076:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    1078:	6a 01                	push   $0x1
        ap++;
    107a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    107d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    1080:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1083:	50                   	push   %eax
    1084:	ff 75 08             	pushl  0x8(%ebp)
    1087:	e8 c6 fc ff ff       	call   d52 <write>
        ap++;
    108c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    108f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1092:	31 ff                	xor    %edi,%edi
    1094:	e9 8f fe ff ff       	jmp    f28 <printf+0x48>
          s = "(null)";
    1099:	bb 2c 13 00 00       	mov    $0x132c,%ebx
        while(*s != 0){
    109e:	b8 28 00 00 00       	mov    $0x28,%eax
    10a3:	e9 72 ff ff ff       	jmp    101a <printf+0x13a>
    10a8:	66 90                	xchg   %ax,%ax
    10aa:	66 90                	xchg   %ax,%ax
    10ac:	66 90                	xchg   %ax,%ax
    10ae:	66 90                	xchg   %ax,%ax

000010b0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    10b0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10b1:	a1 64 19 00 00       	mov    0x1964,%eax
{
    10b6:	89 e5                	mov    %esp,%ebp
    10b8:	57                   	push   %edi
    10b9:	56                   	push   %esi
    10ba:	53                   	push   %ebx
    10bb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    10be:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    10c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    10c8:	39 c8                	cmp    %ecx,%eax
    10ca:	8b 10                	mov    (%eax),%edx
    10cc:	73 32                	jae    1100 <free+0x50>
    10ce:	39 d1                	cmp    %edx,%ecx
    10d0:	72 04                	jb     10d6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    10d2:	39 d0                	cmp    %edx,%eax
    10d4:	72 32                	jb     1108 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    10d6:	8b 73 fc             	mov    -0x4(%ebx),%esi
    10d9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    10dc:	39 fa                	cmp    %edi,%edx
    10de:	74 30                	je     1110 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    10e0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    10e3:	8b 50 04             	mov    0x4(%eax),%edx
    10e6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    10e9:	39 f1                	cmp    %esi,%ecx
    10eb:	74 3a                	je     1127 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    10ed:	89 08                	mov    %ecx,(%eax)
  freep = p;
    10ef:	a3 64 19 00 00       	mov    %eax,0x1964
}
    10f4:	5b                   	pop    %ebx
    10f5:	5e                   	pop    %esi
    10f6:	5f                   	pop    %edi
    10f7:	5d                   	pop    %ebp
    10f8:	c3                   	ret    
    10f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1100:	39 d0                	cmp    %edx,%eax
    1102:	72 04                	jb     1108 <free+0x58>
    1104:	39 d1                	cmp    %edx,%ecx
    1106:	72 ce                	jb     10d6 <free+0x26>
{
    1108:	89 d0                	mov    %edx,%eax
    110a:	eb bc                	jmp    10c8 <free+0x18>
    110c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1110:	03 72 04             	add    0x4(%edx),%esi
    1113:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1116:	8b 10                	mov    (%eax),%edx
    1118:	8b 12                	mov    (%edx),%edx
    111a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    111d:	8b 50 04             	mov    0x4(%eax),%edx
    1120:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1123:	39 f1                	cmp    %esi,%ecx
    1125:	75 c6                	jne    10ed <free+0x3d>
    p->s.size += bp->s.size;
    1127:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    112a:	a3 64 19 00 00       	mov    %eax,0x1964
    p->s.size += bp->s.size;
    112f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1132:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1135:	89 10                	mov    %edx,(%eax)
}
    1137:	5b                   	pop    %ebx
    1138:	5e                   	pop    %esi
    1139:	5f                   	pop    %edi
    113a:	5d                   	pop    %ebp
    113b:	c3                   	ret    
    113c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001140 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1140:	55                   	push   %ebp
    1141:	89 e5                	mov    %esp,%ebp
    1143:	57                   	push   %edi
    1144:	56                   	push   %esi
    1145:	53                   	push   %ebx
    1146:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1149:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    114c:	8b 15 64 19 00 00    	mov    0x1964,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1152:	8d 78 07             	lea    0x7(%eax),%edi
    1155:	c1 ef 03             	shr    $0x3,%edi
    1158:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    115b:	85 d2                	test   %edx,%edx
    115d:	0f 84 9d 00 00 00    	je     1200 <malloc+0xc0>
    1163:	8b 02                	mov    (%edx),%eax
    1165:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    1168:	39 cf                	cmp    %ecx,%edi
    116a:	76 6c                	jbe    11d8 <malloc+0x98>
    116c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1172:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1177:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    117a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1181:	eb 0e                	jmp    1191 <malloc+0x51>
    1183:	90                   	nop
    1184:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1188:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    118a:	8b 48 04             	mov    0x4(%eax),%ecx
    118d:	39 f9                	cmp    %edi,%ecx
    118f:	73 47                	jae    11d8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1191:	39 05 64 19 00 00    	cmp    %eax,0x1964
    1197:	89 c2                	mov    %eax,%edx
    1199:	75 ed                	jne    1188 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    119b:	83 ec 0c             	sub    $0xc,%esp
    119e:	56                   	push   %esi
    119f:	e8 16 fc ff ff       	call   dba <sbrk>
  if(p == (char*)-1)
    11a4:	83 c4 10             	add    $0x10,%esp
    11a7:	83 f8 ff             	cmp    $0xffffffff,%eax
    11aa:	74 1c                	je     11c8 <malloc+0x88>
  hp->s.size = nu;
    11ac:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    11af:	83 ec 0c             	sub    $0xc,%esp
    11b2:	83 c0 08             	add    $0x8,%eax
    11b5:	50                   	push   %eax
    11b6:	e8 f5 fe ff ff       	call   10b0 <free>
  return freep;
    11bb:	8b 15 64 19 00 00    	mov    0x1964,%edx
      if((p = morecore(nunits)) == 0)
    11c1:	83 c4 10             	add    $0x10,%esp
    11c4:	85 d2                	test   %edx,%edx
    11c6:	75 c0                	jne    1188 <malloc+0x48>
        return 0;
  }
}
    11c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    11cb:	31 c0                	xor    %eax,%eax
}
    11cd:	5b                   	pop    %ebx
    11ce:	5e                   	pop    %esi
    11cf:	5f                   	pop    %edi
    11d0:	5d                   	pop    %ebp
    11d1:	c3                   	ret    
    11d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    11d8:	39 cf                	cmp    %ecx,%edi
    11da:	74 54                	je     1230 <malloc+0xf0>
        p->s.size -= nunits;
    11dc:	29 f9                	sub    %edi,%ecx
    11de:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    11e1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    11e4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    11e7:	89 15 64 19 00 00    	mov    %edx,0x1964
}
    11ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    11f0:	83 c0 08             	add    $0x8,%eax
}
    11f3:	5b                   	pop    %ebx
    11f4:	5e                   	pop    %esi
    11f5:	5f                   	pop    %edi
    11f6:	5d                   	pop    %ebp
    11f7:	c3                   	ret    
    11f8:	90                   	nop
    11f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1200:	c7 05 64 19 00 00 68 	movl   $0x1968,0x1964
    1207:	19 00 00 
    120a:	c7 05 68 19 00 00 68 	movl   $0x1968,0x1968
    1211:	19 00 00 
    base.s.size = 0;
    1214:	b8 68 19 00 00       	mov    $0x1968,%eax
    1219:	c7 05 6c 19 00 00 00 	movl   $0x0,0x196c
    1220:	00 00 00 
    1223:	e9 44 ff ff ff       	jmp    116c <malloc+0x2c>
    1228:	90                   	nop
    1229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1230:	8b 08                	mov    (%eax),%ecx
    1232:	89 0a                	mov    %ecx,(%edx)
    1234:	eb b1                	jmp    11e7 <malloc+0xa7>
