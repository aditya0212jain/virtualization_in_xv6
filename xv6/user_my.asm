
_user_my:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"



int main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	83 ec 14             	sub    $0x14,%esp
	printf(1,"%s\n","IPC Test case");
  12:	68 08 08 00 00       	push   $0x808
  17:	68 16 08 00 00       	push   $0x816
  1c:	6a 01                	push   $0x1
  1e:	e8 8d 04 00 00       	call   4b0 <printf>
	
	int cid = fork();
  23:	e8 d2 02 00 00       	call   2fa <fork>
	if(cid==0){
  28:	83 c4 10             	add    $0x10,%esp
  2b:	85 c0                	test   %eax,%eax
  2d:	75 2b                	jne    5a <main+0x5a>
		// This is child
		char *msg = (char *)malloc(MessageSize);
  2f:	83 ec 0c             	sub    $0xc,%esp
  32:	6a 10                	push   $0x10
  34:	e8 d7 06 00 00       	call   710 <malloc>
  39:	89 c3                	mov    %eax,%ebx
		int stat = recv(msg);
  3b:	89 04 24             	mov    %eax,(%esp)
  3e:	e8 87 03 00 00       	call   3ca <recv>
		int *a;
		a =(int *)msg;
		printf(1,"2 CHILD: msg recv is: %d \n stat is : %d\n", *a , stat );
  43:	50                   	push   %eax
  44:	ff 33                	pushl  (%ebx)
  46:	68 38 08 00 00       	push   $0x838
  4b:	6a 01                	push   $0x1
  4d:	e8 5e 04 00 00       	call   4b0 <printf>
		exit();
  52:	83 c4 20             	add    $0x20,%esp
  55:	e8 a8 02 00 00       	call   302 <exit>
	}else{
		// This is parent
		char *msg_child = (char *)malloc(MessageSize);
  5a:	83 ec 0c             	sub    $0xc,%esp
  5d:	89 c3                	mov    %eax,%ebx
  5f:	6a 10                	push   $0x10
  61:	e8 aa 06 00 00       	call   710 <malloc>
		msg_child = "P";
		int a = 4545;
  66:	c7 45 f4 c1 11 00 00 	movl   $0x11c1,-0xc(%ebp)
		send(getpid(),cid,&a);	
  6d:	e8 10 03 00 00       	call   382 <getpid>
  72:	8d 55 f4             	lea    -0xc(%ebp),%edx
  75:	83 c4 0c             	add    $0xc,%esp
  78:	52                   	push   %edx
  79:	53                   	push   %ebx
  7a:	50                   	push   %eax
  7b:	e8 42 03 00 00       	call   3c2 <send>
		printf(1,"1 PARENT: msg sent is: %s \n", msg_child );
  80:	83 c4 0c             	add    $0xc,%esp
  83:	68 1a 08 00 00       	push   $0x81a
  88:	68 1c 08 00 00       	push   $0x81c
  8d:	6a 01                	push   $0x1
  8f:	e8 1c 04 00 00       	call   4b0 <printf>
		free(msg_child);
  94:	c7 04 24 1a 08 00 00 	movl   $0x81a,(%esp)
  9b:	e8 e0 05 00 00       	call   680 <free>
	}
	wait();
  a0:	e8 65 02 00 00       	call   30a <wait>
	exit();
  a5:	e8 58 02 00 00       	call   302 <exit>
  aa:	66 90                	xchg   %ax,%ax
  ac:	66 90                	xchg   %ax,%ax
  ae:	66 90                	xchg   %ax,%ax

000000b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	53                   	push   %ebx
  b4:	8b 45 08             	mov    0x8(%ebp),%eax
  b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ba:	89 c2                	mov    %eax,%edx
  bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  c0:	83 c1 01             	add    $0x1,%ecx
  c3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  c7:	83 c2 01             	add    $0x1,%edx
  ca:	84 db                	test   %bl,%bl
  cc:	88 5a ff             	mov    %bl,-0x1(%edx)
  cf:	75 ef                	jne    c0 <strcpy+0x10>
    ;
  return os;
}
  d1:	5b                   	pop    %ebx
  d2:	5d                   	pop    %ebp
  d3:	c3                   	ret    
  d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	53                   	push   %ebx
  e4:	8b 55 08             	mov    0x8(%ebp),%edx
  e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  ea:	0f b6 02             	movzbl (%edx),%eax
  ed:	0f b6 19             	movzbl (%ecx),%ebx
  f0:	84 c0                	test   %al,%al
  f2:	75 1c                	jne    110 <strcmp+0x30>
  f4:	eb 2a                	jmp    120 <strcmp+0x40>
  f6:	8d 76 00             	lea    0x0(%esi),%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 100:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 103:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 106:	83 c1 01             	add    $0x1,%ecx
 109:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 10c:	84 c0                	test   %al,%al
 10e:	74 10                	je     120 <strcmp+0x40>
 110:	38 d8                	cmp    %bl,%al
 112:	74 ec                	je     100 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 114:	29 d8                	sub    %ebx,%eax
}
 116:	5b                   	pop    %ebx
 117:	5d                   	pop    %ebp
 118:	c3                   	ret    
 119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 120:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 122:	29 d8                	sub    %ebx,%eax
}
 124:	5b                   	pop    %ebx
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    
 127:	89 f6                	mov    %esi,%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <strlen>:

uint
strlen(const char *s)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 136:	80 39 00             	cmpb   $0x0,(%ecx)
 139:	74 15                	je     150 <strlen+0x20>
 13b:	31 d2                	xor    %edx,%edx
 13d:	8d 76 00             	lea    0x0(%esi),%esi
 140:	83 c2 01             	add    $0x1,%edx
 143:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 147:	89 d0                	mov    %edx,%eax
 149:	75 f5                	jne    140 <strlen+0x10>
    ;
  return n;
}
 14b:	5d                   	pop    %ebp
 14c:	c3                   	ret    
 14d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 150:	31 c0                	xor    %eax,%eax
}
 152:	5d                   	pop    %ebp
 153:	c3                   	ret    
 154:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 15a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000160 <memset>:

void*
memset(void *dst, int c, uint n)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	57                   	push   %edi
 164:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 167:	8b 4d 10             	mov    0x10(%ebp),%ecx
 16a:	8b 45 0c             	mov    0xc(%ebp),%eax
 16d:	89 d7                	mov    %edx,%edi
 16f:	fc                   	cld    
 170:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 172:	89 d0                	mov    %edx,%eax
 174:	5f                   	pop    %edi
 175:	5d                   	pop    %ebp
 176:	c3                   	ret    
 177:	89 f6                	mov    %esi,%esi
 179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000180 <strchr>:

char*
strchr(const char *s, char c)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	53                   	push   %ebx
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 18a:	0f b6 10             	movzbl (%eax),%edx
 18d:	84 d2                	test   %dl,%dl
 18f:	74 1d                	je     1ae <strchr+0x2e>
    if(*s == c)
 191:	38 d3                	cmp    %dl,%bl
 193:	89 d9                	mov    %ebx,%ecx
 195:	75 0d                	jne    1a4 <strchr+0x24>
 197:	eb 17                	jmp    1b0 <strchr+0x30>
 199:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1a0:	38 ca                	cmp    %cl,%dl
 1a2:	74 0c                	je     1b0 <strchr+0x30>
  for(; *s; s++)
 1a4:	83 c0 01             	add    $0x1,%eax
 1a7:	0f b6 10             	movzbl (%eax),%edx
 1aa:	84 d2                	test   %dl,%dl
 1ac:	75 f2                	jne    1a0 <strchr+0x20>
      return (char*)s;
  return 0;
 1ae:	31 c0                	xor    %eax,%eax
}
 1b0:	5b                   	pop    %ebx
 1b1:	5d                   	pop    %ebp
 1b2:	c3                   	ret    
 1b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <gets>:

char*
gets(char *buf, int max)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	57                   	push   %edi
 1c4:	56                   	push   %esi
 1c5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1c6:	31 f6                	xor    %esi,%esi
 1c8:	89 f3                	mov    %esi,%ebx
{
 1ca:	83 ec 1c             	sub    $0x1c,%esp
 1cd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 1d0:	eb 2f                	jmp    201 <gets+0x41>
 1d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 1d8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1db:	83 ec 04             	sub    $0x4,%esp
 1de:	6a 01                	push   $0x1
 1e0:	50                   	push   %eax
 1e1:	6a 00                	push   $0x0
 1e3:	e8 32 01 00 00       	call   31a <read>
    if(cc < 1)
 1e8:	83 c4 10             	add    $0x10,%esp
 1eb:	85 c0                	test   %eax,%eax
 1ed:	7e 1c                	jle    20b <gets+0x4b>
      break;
    buf[i++] = c;
 1ef:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1f3:	83 c7 01             	add    $0x1,%edi
 1f6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1f9:	3c 0a                	cmp    $0xa,%al
 1fb:	74 23                	je     220 <gets+0x60>
 1fd:	3c 0d                	cmp    $0xd,%al
 1ff:	74 1f                	je     220 <gets+0x60>
  for(i=0; i+1 < max; ){
 201:	83 c3 01             	add    $0x1,%ebx
 204:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 207:	89 fe                	mov    %edi,%esi
 209:	7c cd                	jl     1d8 <gets+0x18>
 20b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 20d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 210:	c6 03 00             	movb   $0x0,(%ebx)
}
 213:	8d 65 f4             	lea    -0xc(%ebp),%esp
 216:	5b                   	pop    %ebx
 217:	5e                   	pop    %esi
 218:	5f                   	pop    %edi
 219:	5d                   	pop    %ebp
 21a:	c3                   	ret    
 21b:	90                   	nop
 21c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 220:	8b 75 08             	mov    0x8(%ebp),%esi
 223:	8b 45 08             	mov    0x8(%ebp),%eax
 226:	01 de                	add    %ebx,%esi
 228:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 22a:	c6 03 00             	movb   $0x0,(%ebx)
}
 22d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 230:	5b                   	pop    %ebx
 231:	5e                   	pop    %esi
 232:	5f                   	pop    %edi
 233:	5d                   	pop    %ebp
 234:	c3                   	ret    
 235:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <stat>:

int
stat(const char *n, struct stat *st)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	56                   	push   %esi
 244:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 245:	83 ec 08             	sub    $0x8,%esp
 248:	6a 00                	push   $0x0
 24a:	ff 75 08             	pushl  0x8(%ebp)
 24d:	e8 f0 00 00 00       	call   342 <open>
  if(fd < 0)
 252:	83 c4 10             	add    $0x10,%esp
 255:	85 c0                	test   %eax,%eax
 257:	78 27                	js     280 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 259:	83 ec 08             	sub    $0x8,%esp
 25c:	ff 75 0c             	pushl  0xc(%ebp)
 25f:	89 c3                	mov    %eax,%ebx
 261:	50                   	push   %eax
 262:	e8 f3 00 00 00       	call   35a <fstat>
  close(fd);
 267:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 26a:	89 c6                	mov    %eax,%esi
  close(fd);
 26c:	e8 b9 00 00 00       	call   32a <close>
  return r;
 271:	83 c4 10             	add    $0x10,%esp
}
 274:	8d 65 f8             	lea    -0x8(%ebp),%esp
 277:	89 f0                	mov    %esi,%eax
 279:	5b                   	pop    %ebx
 27a:	5e                   	pop    %esi
 27b:	5d                   	pop    %ebp
 27c:	c3                   	ret    
 27d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 280:	be ff ff ff ff       	mov    $0xffffffff,%esi
 285:	eb ed                	jmp    274 <stat+0x34>
 287:	89 f6                	mov    %esi,%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <atoi>:

int
atoi(const char *s)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	53                   	push   %ebx
 294:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 297:	0f be 11             	movsbl (%ecx),%edx
 29a:	8d 42 d0             	lea    -0x30(%edx),%eax
 29d:	3c 09                	cmp    $0x9,%al
  n = 0;
 29f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 2a4:	77 1f                	ja     2c5 <atoi+0x35>
 2a6:	8d 76 00             	lea    0x0(%esi),%esi
 2a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 2b0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2b3:	83 c1 01             	add    $0x1,%ecx
 2b6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 2ba:	0f be 11             	movsbl (%ecx),%edx
 2bd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 2c0:	80 fb 09             	cmp    $0x9,%bl
 2c3:	76 eb                	jbe    2b0 <atoi+0x20>
  return n;
}
 2c5:	5b                   	pop    %ebx
 2c6:	5d                   	pop    %ebp
 2c7:	c3                   	ret    
 2c8:	90                   	nop
 2c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	56                   	push   %esi
 2d4:	53                   	push   %ebx
 2d5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 2d8:	8b 45 08             	mov    0x8(%ebp),%eax
 2db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2de:	85 db                	test   %ebx,%ebx
 2e0:	7e 14                	jle    2f6 <memmove+0x26>
 2e2:	31 d2                	xor    %edx,%edx
 2e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 2e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2ef:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2f2:	39 d3                	cmp    %edx,%ebx
 2f4:	75 f2                	jne    2e8 <memmove+0x18>
  return vdst;
}
 2f6:	5b                   	pop    %ebx
 2f7:	5e                   	pop    %esi
 2f8:	5d                   	pop    %ebp
 2f9:	c3                   	ret    

000002fa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2fa:	b8 01 00 00 00       	mov    $0x1,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <exit>:
SYSCALL(exit)
 302:	b8 02 00 00 00       	mov    $0x2,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <wait>:
SYSCALL(wait)
 30a:	b8 03 00 00 00       	mov    $0x3,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <pipe>:
SYSCALL(pipe)
 312:	b8 04 00 00 00       	mov    $0x4,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <read>:
SYSCALL(read)
 31a:	b8 05 00 00 00       	mov    $0x5,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <write>:
SYSCALL(write)
 322:	b8 10 00 00 00       	mov    $0x10,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <close>:
SYSCALL(close)
 32a:	b8 15 00 00 00       	mov    $0x15,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <kill>:
SYSCALL(kill)
 332:	b8 06 00 00 00       	mov    $0x6,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <exec>:
SYSCALL(exec)
 33a:	b8 07 00 00 00       	mov    $0x7,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <open>:
SYSCALL(open)
 342:	b8 0f 00 00 00       	mov    $0xf,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <mknod>:
SYSCALL(mknod)
 34a:	b8 11 00 00 00       	mov    $0x11,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <unlink>:
SYSCALL(unlink)
 352:	b8 12 00 00 00       	mov    $0x12,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <fstat>:
SYSCALL(fstat)
 35a:	b8 08 00 00 00       	mov    $0x8,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <link>:
SYSCALL(link)
 362:	b8 13 00 00 00       	mov    $0x13,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <mkdir>:
SYSCALL(mkdir)
 36a:	b8 14 00 00 00       	mov    $0x14,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <chdir>:
SYSCALL(chdir)
 372:	b8 09 00 00 00       	mov    $0x9,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <dup>:
SYSCALL(dup)
 37a:	b8 0a 00 00 00       	mov    $0xa,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <getpid>:
SYSCALL(getpid)
 382:	b8 0b 00 00 00       	mov    $0xb,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <sbrk>:
SYSCALL(sbrk)
 38a:	b8 0c 00 00 00       	mov    $0xc,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <sleep>:
SYSCALL(sleep)
 392:	b8 0d 00 00 00       	mov    $0xd,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <uptime>:
SYSCALL(uptime)
 39a:	b8 0e 00 00 00       	mov    $0xe,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <halt>:
SYSCALL(halt)
 3a2:	b8 1f 00 00 00       	mov    $0x1f,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <toggle>:
SYSCALL(toggle)
 3aa:	b8 16 00 00 00       	mov    $0x16,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <add>:
SYSCALL(add)
 3b2:	b8 17 00 00 00       	mov    $0x17,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <ps>:
SYSCALL(ps)
 3ba:	b8 18 00 00 00       	mov    $0x18,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <send>:
SYSCALL(send)
 3c2:	b8 19 00 00 00       	mov    $0x19,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <recv>:
SYSCALL(recv)
 3ca:	b8 1a 00 00 00       	mov    $0x1a,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <print_count>:
SYSCALL(print_count)
 3d2:	b8 1b 00 00 00       	mov    $0x1b,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <send_multi>:
SYSCALL(send_multi)
 3da:	b8 1c 00 00 00       	mov    $0x1c,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <signal>:
SYSCALL(signal)
 3e2:	b8 1d 00 00 00       	mov    $0x1d,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <sigraise>:
SYSCALL(sigraise)
 3ea:	b8 1e 00 00 00       	mov    $0x1e,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <recv_multi>:
SYSCALL(recv_multi)
 3f2:	b8 20 00 00 00       	mov    $0x20,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <change_state>:
SYSCALL(change_state)
 3fa:	b8 21 00 00 00       	mov    $0x21,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    
 402:	66 90                	xchg   %ax,%ax
 404:	66 90                	xchg   %ax,%ax
 406:	66 90                	xchg   %ax,%ax
 408:	66 90                	xchg   %ax,%ax
 40a:	66 90                	xchg   %ax,%ax
 40c:	66 90                	xchg   %ax,%ax
 40e:	66 90                	xchg   %ax,%ax

00000410 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	57                   	push   %edi
 414:	56                   	push   %esi
 415:	53                   	push   %ebx
 416:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 419:	85 d2                	test   %edx,%edx
{
 41b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 41e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 420:	79 76                	jns    498 <printint+0x88>
 422:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 426:	74 70                	je     498 <printint+0x88>
    x = -xx;
 428:	f7 d8                	neg    %eax
    neg = 1;
 42a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 431:	31 f6                	xor    %esi,%esi
 433:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 436:	eb 0a                	jmp    442 <printint+0x32>
 438:	90                   	nop
 439:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 440:	89 fe                	mov    %edi,%esi
 442:	31 d2                	xor    %edx,%edx
 444:	8d 7e 01             	lea    0x1(%esi),%edi
 447:	f7 f1                	div    %ecx
 449:	0f b6 92 6c 08 00 00 	movzbl 0x86c(%edx),%edx
  }while((x /= base) != 0);
 450:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 452:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 455:	75 e9                	jne    440 <printint+0x30>
  if(neg)
 457:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 45a:	85 c0                	test   %eax,%eax
 45c:	74 08                	je     466 <printint+0x56>
    buf[i++] = '-';
 45e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 463:	8d 7e 02             	lea    0x2(%esi),%edi
 466:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 46a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 46d:	8d 76 00             	lea    0x0(%esi),%esi
 470:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 473:	83 ec 04             	sub    $0x4,%esp
 476:	83 ee 01             	sub    $0x1,%esi
 479:	6a 01                	push   $0x1
 47b:	53                   	push   %ebx
 47c:	57                   	push   %edi
 47d:	88 45 d7             	mov    %al,-0x29(%ebp)
 480:	e8 9d fe ff ff       	call   322 <write>

  while(--i >= 0)
 485:	83 c4 10             	add    $0x10,%esp
 488:	39 de                	cmp    %ebx,%esi
 48a:	75 e4                	jne    470 <printint+0x60>
    putc(fd, buf[i]);
}
 48c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 48f:	5b                   	pop    %ebx
 490:	5e                   	pop    %esi
 491:	5f                   	pop    %edi
 492:	5d                   	pop    %ebp
 493:	c3                   	ret    
 494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 498:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 49f:	eb 90                	jmp    431 <printint+0x21>
 4a1:	eb 0d                	jmp    4b0 <printf>
 4a3:	90                   	nop
 4a4:	90                   	nop
 4a5:	90                   	nop
 4a6:	90                   	nop
 4a7:	90                   	nop
 4a8:	90                   	nop
 4a9:	90                   	nop
 4aa:	90                   	nop
 4ab:	90                   	nop
 4ac:	90                   	nop
 4ad:	90                   	nop
 4ae:	90                   	nop
 4af:	90                   	nop

000004b0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	56                   	push   %esi
 4b5:	53                   	push   %ebx
 4b6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 4b9:	8b 75 0c             	mov    0xc(%ebp),%esi
 4bc:	0f b6 1e             	movzbl (%esi),%ebx
 4bf:	84 db                	test   %bl,%bl
 4c1:	0f 84 b3 00 00 00    	je     57a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 4c7:	8d 45 10             	lea    0x10(%ebp),%eax
 4ca:	83 c6 01             	add    $0x1,%esi
  state = 0;
 4cd:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 4cf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4d2:	eb 2f                	jmp    503 <printf+0x53>
 4d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 4d8:	83 f8 25             	cmp    $0x25,%eax
 4db:	0f 84 a7 00 00 00    	je     588 <printf+0xd8>
  write(fd, &c, 1);
 4e1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 4e4:	83 ec 04             	sub    $0x4,%esp
 4e7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 4ea:	6a 01                	push   $0x1
 4ec:	50                   	push   %eax
 4ed:	ff 75 08             	pushl  0x8(%ebp)
 4f0:	e8 2d fe ff ff       	call   322 <write>
 4f5:	83 c4 10             	add    $0x10,%esp
 4f8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 4fb:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 4ff:	84 db                	test   %bl,%bl
 501:	74 77                	je     57a <printf+0xca>
    if(state == 0){
 503:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 505:	0f be cb             	movsbl %bl,%ecx
 508:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 50b:	74 cb                	je     4d8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 50d:	83 ff 25             	cmp    $0x25,%edi
 510:	75 e6                	jne    4f8 <printf+0x48>
      if(c == 'd'){
 512:	83 f8 64             	cmp    $0x64,%eax
 515:	0f 84 05 01 00 00    	je     620 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 51b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 521:	83 f9 70             	cmp    $0x70,%ecx
 524:	74 72                	je     598 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 526:	83 f8 73             	cmp    $0x73,%eax
 529:	0f 84 99 00 00 00    	je     5c8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 52f:	83 f8 63             	cmp    $0x63,%eax
 532:	0f 84 08 01 00 00    	je     640 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 538:	83 f8 25             	cmp    $0x25,%eax
 53b:	0f 84 ef 00 00 00    	je     630 <printf+0x180>
  write(fd, &c, 1);
 541:	8d 45 e7             	lea    -0x19(%ebp),%eax
 544:	83 ec 04             	sub    $0x4,%esp
 547:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 54b:	6a 01                	push   $0x1
 54d:	50                   	push   %eax
 54e:	ff 75 08             	pushl  0x8(%ebp)
 551:	e8 cc fd ff ff       	call   322 <write>
 556:	83 c4 0c             	add    $0xc,%esp
 559:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 55c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 55f:	6a 01                	push   $0x1
 561:	50                   	push   %eax
 562:	ff 75 08             	pushl  0x8(%ebp)
 565:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 568:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 56a:	e8 b3 fd ff ff       	call   322 <write>
  for(i = 0; fmt[i]; i++){
 56f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 573:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 576:	84 db                	test   %bl,%bl
 578:	75 89                	jne    503 <printf+0x53>
    }
  }
}
 57a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 57d:	5b                   	pop    %ebx
 57e:	5e                   	pop    %esi
 57f:	5f                   	pop    %edi
 580:	5d                   	pop    %ebp
 581:	c3                   	ret    
 582:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 588:	bf 25 00 00 00       	mov    $0x25,%edi
 58d:	e9 66 ff ff ff       	jmp    4f8 <printf+0x48>
 592:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 598:	83 ec 0c             	sub    $0xc,%esp
 59b:	b9 10 00 00 00       	mov    $0x10,%ecx
 5a0:	6a 00                	push   $0x0
 5a2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 5a5:	8b 45 08             	mov    0x8(%ebp),%eax
 5a8:	8b 17                	mov    (%edi),%edx
 5aa:	e8 61 fe ff ff       	call   410 <printint>
        ap++;
 5af:	89 f8                	mov    %edi,%eax
 5b1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5b4:	31 ff                	xor    %edi,%edi
        ap++;
 5b6:	83 c0 04             	add    $0x4,%eax
 5b9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 5bc:	e9 37 ff ff ff       	jmp    4f8 <printf+0x48>
 5c1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 5c8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 5cb:	8b 08                	mov    (%eax),%ecx
        ap++;
 5cd:	83 c0 04             	add    $0x4,%eax
 5d0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 5d3:	85 c9                	test   %ecx,%ecx
 5d5:	0f 84 8e 00 00 00    	je     669 <printf+0x1b9>
        while(*s != 0){
 5db:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 5de:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 5e0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 5e2:	84 c0                	test   %al,%al
 5e4:	0f 84 0e ff ff ff    	je     4f8 <printf+0x48>
 5ea:	89 75 d0             	mov    %esi,-0x30(%ebp)
 5ed:	89 de                	mov    %ebx,%esi
 5ef:	8b 5d 08             	mov    0x8(%ebp),%ebx
 5f2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 5f5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 5f8:	83 ec 04             	sub    $0x4,%esp
          s++;
 5fb:	83 c6 01             	add    $0x1,%esi
 5fe:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 601:	6a 01                	push   $0x1
 603:	57                   	push   %edi
 604:	53                   	push   %ebx
 605:	e8 18 fd ff ff       	call   322 <write>
        while(*s != 0){
 60a:	0f b6 06             	movzbl (%esi),%eax
 60d:	83 c4 10             	add    $0x10,%esp
 610:	84 c0                	test   %al,%al
 612:	75 e4                	jne    5f8 <printf+0x148>
 614:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 617:	31 ff                	xor    %edi,%edi
 619:	e9 da fe ff ff       	jmp    4f8 <printf+0x48>
 61e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 620:	83 ec 0c             	sub    $0xc,%esp
 623:	b9 0a 00 00 00       	mov    $0xa,%ecx
 628:	6a 01                	push   $0x1
 62a:	e9 73 ff ff ff       	jmp    5a2 <printf+0xf2>
 62f:	90                   	nop
  write(fd, &c, 1);
 630:	83 ec 04             	sub    $0x4,%esp
 633:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 636:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 639:	6a 01                	push   $0x1
 63b:	e9 21 ff ff ff       	jmp    561 <printf+0xb1>
        putc(fd, *ap);
 640:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 643:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 646:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 648:	6a 01                	push   $0x1
        ap++;
 64a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 64d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 650:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 653:	50                   	push   %eax
 654:	ff 75 08             	pushl  0x8(%ebp)
 657:	e8 c6 fc ff ff       	call   322 <write>
        ap++;
 65c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 65f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 662:	31 ff                	xor    %edi,%edi
 664:	e9 8f fe ff ff       	jmp    4f8 <printf+0x48>
          s = "(null)";
 669:	bb 64 08 00 00       	mov    $0x864,%ebx
        while(*s != 0){
 66e:	b8 28 00 00 00       	mov    $0x28,%eax
 673:	e9 72 ff ff ff       	jmp    5ea <printf+0x13a>
 678:	66 90                	xchg   %ax,%ax
 67a:	66 90                	xchg   %ax,%ax
 67c:	66 90                	xchg   %ax,%ax
 67e:	66 90                	xchg   %ax,%ax

00000680 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 680:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 681:	a1 14 0b 00 00       	mov    0xb14,%eax
{
 686:	89 e5                	mov    %esp,%ebp
 688:	57                   	push   %edi
 689:	56                   	push   %esi
 68a:	53                   	push   %ebx
 68b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 68e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 691:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 698:	39 c8                	cmp    %ecx,%eax
 69a:	8b 10                	mov    (%eax),%edx
 69c:	73 32                	jae    6d0 <free+0x50>
 69e:	39 d1                	cmp    %edx,%ecx
 6a0:	72 04                	jb     6a6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6a2:	39 d0                	cmp    %edx,%eax
 6a4:	72 32                	jb     6d8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6a6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 6a9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 6ac:	39 fa                	cmp    %edi,%edx
 6ae:	74 30                	je     6e0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 6b0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6b3:	8b 50 04             	mov    0x4(%eax),%edx
 6b6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6b9:	39 f1                	cmp    %esi,%ecx
 6bb:	74 3a                	je     6f7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 6bd:	89 08                	mov    %ecx,(%eax)
  freep = p;
 6bf:	a3 14 0b 00 00       	mov    %eax,0xb14
}
 6c4:	5b                   	pop    %ebx
 6c5:	5e                   	pop    %esi
 6c6:	5f                   	pop    %edi
 6c7:	5d                   	pop    %ebp
 6c8:	c3                   	ret    
 6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6d0:	39 d0                	cmp    %edx,%eax
 6d2:	72 04                	jb     6d8 <free+0x58>
 6d4:	39 d1                	cmp    %edx,%ecx
 6d6:	72 ce                	jb     6a6 <free+0x26>
{
 6d8:	89 d0                	mov    %edx,%eax
 6da:	eb bc                	jmp    698 <free+0x18>
 6dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 6e0:	03 72 04             	add    0x4(%edx),%esi
 6e3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e6:	8b 10                	mov    (%eax),%edx
 6e8:	8b 12                	mov    (%edx),%edx
 6ea:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 6ed:	8b 50 04             	mov    0x4(%eax),%edx
 6f0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 6f3:	39 f1                	cmp    %esi,%ecx
 6f5:	75 c6                	jne    6bd <free+0x3d>
    p->s.size += bp->s.size;
 6f7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 6fa:	a3 14 0b 00 00       	mov    %eax,0xb14
    p->s.size += bp->s.size;
 6ff:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 702:	8b 53 f8             	mov    -0x8(%ebx),%edx
 705:	89 10                	mov    %edx,(%eax)
}
 707:	5b                   	pop    %ebx
 708:	5e                   	pop    %esi
 709:	5f                   	pop    %edi
 70a:	5d                   	pop    %ebp
 70b:	c3                   	ret    
 70c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000710 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 710:	55                   	push   %ebp
 711:	89 e5                	mov    %esp,%ebp
 713:	57                   	push   %edi
 714:	56                   	push   %esi
 715:	53                   	push   %ebx
 716:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 719:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 71c:	8b 15 14 0b 00 00    	mov    0xb14,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 722:	8d 78 07             	lea    0x7(%eax),%edi
 725:	c1 ef 03             	shr    $0x3,%edi
 728:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 72b:	85 d2                	test   %edx,%edx
 72d:	0f 84 9d 00 00 00    	je     7d0 <malloc+0xc0>
 733:	8b 02                	mov    (%edx),%eax
 735:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 738:	39 cf                	cmp    %ecx,%edi
 73a:	76 6c                	jbe    7a8 <malloc+0x98>
 73c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 742:	bb 00 10 00 00       	mov    $0x1000,%ebx
 747:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 74a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 751:	eb 0e                	jmp    761 <malloc+0x51>
 753:	90                   	nop
 754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 758:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 75a:	8b 48 04             	mov    0x4(%eax),%ecx
 75d:	39 f9                	cmp    %edi,%ecx
 75f:	73 47                	jae    7a8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 761:	39 05 14 0b 00 00    	cmp    %eax,0xb14
 767:	89 c2                	mov    %eax,%edx
 769:	75 ed                	jne    758 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 76b:	83 ec 0c             	sub    $0xc,%esp
 76e:	56                   	push   %esi
 76f:	e8 16 fc ff ff       	call   38a <sbrk>
  if(p == (char*)-1)
 774:	83 c4 10             	add    $0x10,%esp
 777:	83 f8 ff             	cmp    $0xffffffff,%eax
 77a:	74 1c                	je     798 <malloc+0x88>
  hp->s.size = nu;
 77c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 77f:	83 ec 0c             	sub    $0xc,%esp
 782:	83 c0 08             	add    $0x8,%eax
 785:	50                   	push   %eax
 786:	e8 f5 fe ff ff       	call   680 <free>
  return freep;
 78b:	8b 15 14 0b 00 00    	mov    0xb14,%edx
      if((p = morecore(nunits)) == 0)
 791:	83 c4 10             	add    $0x10,%esp
 794:	85 d2                	test   %edx,%edx
 796:	75 c0                	jne    758 <malloc+0x48>
        return 0;
  }
}
 798:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 79b:	31 c0                	xor    %eax,%eax
}
 79d:	5b                   	pop    %ebx
 79e:	5e                   	pop    %esi
 79f:	5f                   	pop    %edi
 7a0:	5d                   	pop    %ebp
 7a1:	c3                   	ret    
 7a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 7a8:	39 cf                	cmp    %ecx,%edi
 7aa:	74 54                	je     800 <malloc+0xf0>
        p->s.size -= nunits;
 7ac:	29 f9                	sub    %edi,%ecx
 7ae:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 7b1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 7b4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 7b7:	89 15 14 0b 00 00    	mov    %edx,0xb14
}
 7bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 7c0:	83 c0 08             	add    $0x8,%eax
}
 7c3:	5b                   	pop    %ebx
 7c4:	5e                   	pop    %esi
 7c5:	5f                   	pop    %edi
 7c6:	5d                   	pop    %ebp
 7c7:	c3                   	ret    
 7c8:	90                   	nop
 7c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 7d0:	c7 05 14 0b 00 00 18 	movl   $0xb18,0xb14
 7d7:	0b 00 00 
 7da:	c7 05 18 0b 00 00 18 	movl   $0xb18,0xb18
 7e1:	0b 00 00 
    base.s.size = 0;
 7e4:	b8 18 0b 00 00       	mov    $0xb18,%eax
 7e9:	c7 05 1c 0b 00 00 00 	movl   $0x0,0xb1c
 7f0:	00 00 00 
 7f3:	e9 44 ff ff ff       	jmp    73c <malloc+0x2c>
 7f8:	90                   	nop
 7f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 800:	8b 08                	mov    (%eax),%ecx
 802:	89 0a                	mov    %ecx,(%edx)
 804:	eb b1                	jmp    7b7 <malloc+0xa7>
