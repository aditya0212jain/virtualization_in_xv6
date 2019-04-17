
_user_toggle:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "date.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
// If you follow the naming convetion, system call
// name will be sys_toggle and you
// call it by calling
// toggle();
    toggle();
  11:	e8 04 03 00 00       	call   31a <toggle>
    exit();
  16:	e8 57 02 00 00       	call   272 <exit>
  1b:	66 90                	xchg   %ax,%ax
  1d:	66 90                	xchg   %ax,%ax
  1f:	90                   	nop

00000020 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  20:	55                   	push   %ebp
  21:	89 e5                	mov    %esp,%ebp
  23:	53                   	push   %ebx
  24:	8b 45 08             	mov    0x8(%ebp),%eax
  27:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  2a:	89 c2                	mov    %eax,%edx
  2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  30:	83 c1 01             	add    $0x1,%ecx
  33:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  37:	83 c2 01             	add    $0x1,%edx
  3a:	84 db                	test   %bl,%bl
  3c:	88 5a ff             	mov    %bl,-0x1(%edx)
  3f:	75 ef                	jne    30 <strcpy+0x10>
    ;
  return os;
}
  41:	5b                   	pop    %ebx
  42:	5d                   	pop    %ebp
  43:	c3                   	ret    
  44:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  4a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000050 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	53                   	push   %ebx
  54:	8b 55 08             	mov    0x8(%ebp),%edx
  57:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  5a:	0f b6 02             	movzbl (%edx),%eax
  5d:	0f b6 19             	movzbl (%ecx),%ebx
  60:	84 c0                	test   %al,%al
  62:	75 1c                	jne    80 <strcmp+0x30>
  64:	eb 2a                	jmp    90 <strcmp+0x40>
  66:	8d 76 00             	lea    0x0(%esi),%esi
  69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  70:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  73:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  76:	83 c1 01             	add    $0x1,%ecx
  79:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
  7c:	84 c0                	test   %al,%al
  7e:	74 10                	je     90 <strcmp+0x40>
  80:	38 d8                	cmp    %bl,%al
  82:	74 ec                	je     70 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  84:	29 d8                	sub    %ebx,%eax
}
  86:	5b                   	pop    %ebx
  87:	5d                   	pop    %ebp
  88:	c3                   	ret    
  89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  90:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  92:	29 d8                	sub    %ebx,%eax
}
  94:	5b                   	pop    %ebx
  95:	5d                   	pop    %ebp
  96:	c3                   	ret    
  97:	89 f6                	mov    %esi,%esi
  99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000a0 <strlen>:

uint
strlen(const char *s)
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  a6:	80 39 00             	cmpb   $0x0,(%ecx)
  a9:	74 15                	je     c0 <strlen+0x20>
  ab:	31 d2                	xor    %edx,%edx
  ad:	8d 76 00             	lea    0x0(%esi),%esi
  b0:	83 c2 01             	add    $0x1,%edx
  b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  b7:	89 d0                	mov    %edx,%eax
  b9:	75 f5                	jne    b0 <strlen+0x10>
    ;
  return n;
}
  bb:	5d                   	pop    %ebp
  bc:	c3                   	ret    
  bd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
  c0:	31 c0                	xor    %eax,%eax
}
  c2:	5d                   	pop    %ebp
  c3:	c3                   	ret    
  c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	57                   	push   %edi
  d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  da:	8b 45 0c             	mov    0xc(%ebp),%eax
  dd:	89 d7                	mov    %edx,%edi
  df:	fc                   	cld    
  e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  e2:	89 d0                	mov    %edx,%eax
  e4:	5f                   	pop    %edi
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
  e7:	89 f6                	mov    %esi,%esi
  e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000f0 <strchr>:

char*
strchr(const char *s, char c)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	53                   	push   %ebx
  f4:	8b 45 08             	mov    0x8(%ebp),%eax
  f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
  fa:	0f b6 10             	movzbl (%eax),%edx
  fd:	84 d2                	test   %dl,%dl
  ff:	74 1d                	je     11e <strchr+0x2e>
    if(*s == c)
 101:	38 d3                	cmp    %dl,%bl
 103:	89 d9                	mov    %ebx,%ecx
 105:	75 0d                	jne    114 <strchr+0x24>
 107:	eb 17                	jmp    120 <strchr+0x30>
 109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 110:	38 ca                	cmp    %cl,%dl
 112:	74 0c                	je     120 <strchr+0x30>
  for(; *s; s++)
 114:	83 c0 01             	add    $0x1,%eax
 117:	0f b6 10             	movzbl (%eax),%edx
 11a:	84 d2                	test   %dl,%dl
 11c:	75 f2                	jne    110 <strchr+0x20>
      return (char*)s;
  return 0;
 11e:	31 c0                	xor    %eax,%eax
}
 120:	5b                   	pop    %ebx
 121:	5d                   	pop    %ebp
 122:	c3                   	ret    
 123:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <gets>:

char*
gets(char *buf, int max)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	57                   	push   %edi
 134:	56                   	push   %esi
 135:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 136:	31 f6                	xor    %esi,%esi
 138:	89 f3                	mov    %esi,%ebx
{
 13a:	83 ec 1c             	sub    $0x1c,%esp
 13d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 140:	eb 2f                	jmp    171 <gets+0x41>
 142:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 148:	8d 45 e7             	lea    -0x19(%ebp),%eax
 14b:	83 ec 04             	sub    $0x4,%esp
 14e:	6a 01                	push   $0x1
 150:	50                   	push   %eax
 151:	6a 00                	push   $0x0
 153:	e8 32 01 00 00       	call   28a <read>
    if(cc < 1)
 158:	83 c4 10             	add    $0x10,%esp
 15b:	85 c0                	test   %eax,%eax
 15d:	7e 1c                	jle    17b <gets+0x4b>
      break;
    buf[i++] = c;
 15f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 163:	83 c7 01             	add    $0x1,%edi
 166:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 169:	3c 0a                	cmp    $0xa,%al
 16b:	74 23                	je     190 <gets+0x60>
 16d:	3c 0d                	cmp    $0xd,%al
 16f:	74 1f                	je     190 <gets+0x60>
  for(i=0; i+1 < max; ){
 171:	83 c3 01             	add    $0x1,%ebx
 174:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 177:	89 fe                	mov    %edi,%esi
 179:	7c cd                	jl     148 <gets+0x18>
 17b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 17d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 180:	c6 03 00             	movb   $0x0,(%ebx)
}
 183:	8d 65 f4             	lea    -0xc(%ebp),%esp
 186:	5b                   	pop    %ebx
 187:	5e                   	pop    %esi
 188:	5f                   	pop    %edi
 189:	5d                   	pop    %ebp
 18a:	c3                   	ret    
 18b:	90                   	nop
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 190:	8b 75 08             	mov    0x8(%ebp),%esi
 193:	8b 45 08             	mov    0x8(%ebp),%eax
 196:	01 de                	add    %ebx,%esi
 198:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 19a:	c6 03 00             	movb   $0x0,(%ebx)
}
 19d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1a0:	5b                   	pop    %ebx
 1a1:	5e                   	pop    %esi
 1a2:	5f                   	pop    %edi
 1a3:	5d                   	pop    %ebp
 1a4:	c3                   	ret    
 1a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001b0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	56                   	push   %esi
 1b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b5:	83 ec 08             	sub    $0x8,%esp
 1b8:	6a 00                	push   $0x0
 1ba:	ff 75 08             	pushl  0x8(%ebp)
 1bd:	e8 f0 00 00 00       	call   2b2 <open>
  if(fd < 0)
 1c2:	83 c4 10             	add    $0x10,%esp
 1c5:	85 c0                	test   %eax,%eax
 1c7:	78 27                	js     1f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1c9:	83 ec 08             	sub    $0x8,%esp
 1cc:	ff 75 0c             	pushl  0xc(%ebp)
 1cf:	89 c3                	mov    %eax,%ebx
 1d1:	50                   	push   %eax
 1d2:	e8 f3 00 00 00       	call   2ca <fstat>
  close(fd);
 1d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1da:	89 c6                	mov    %eax,%esi
  close(fd);
 1dc:	e8 b9 00 00 00       	call   29a <close>
  return r;
 1e1:	83 c4 10             	add    $0x10,%esp
}
 1e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1e7:	89 f0                	mov    %esi,%eax
 1e9:	5b                   	pop    %ebx
 1ea:	5e                   	pop    %esi
 1eb:	5d                   	pop    %ebp
 1ec:	c3                   	ret    
 1ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 1f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1f5:	eb ed                	jmp    1e4 <stat+0x34>
 1f7:	89 f6                	mov    %esi,%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <atoi>:

int
atoi(const char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	53                   	push   %ebx
 204:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 207:	0f be 11             	movsbl (%ecx),%edx
 20a:	8d 42 d0             	lea    -0x30(%edx),%eax
 20d:	3c 09                	cmp    $0x9,%al
  n = 0;
 20f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 214:	77 1f                	ja     235 <atoi+0x35>
 216:	8d 76 00             	lea    0x0(%esi),%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 220:	8d 04 80             	lea    (%eax,%eax,4),%eax
 223:	83 c1 01             	add    $0x1,%ecx
 226:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 22a:	0f be 11             	movsbl (%ecx),%edx
 22d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 230:	80 fb 09             	cmp    $0x9,%bl
 233:	76 eb                	jbe    220 <atoi+0x20>
  return n;
}
 235:	5b                   	pop    %ebx
 236:	5d                   	pop    %ebp
 237:	c3                   	ret    
 238:	90                   	nop
 239:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000240 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	56                   	push   %esi
 244:	53                   	push   %ebx
 245:	8b 5d 10             	mov    0x10(%ebp),%ebx
 248:	8b 45 08             	mov    0x8(%ebp),%eax
 24b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 24e:	85 db                	test   %ebx,%ebx
 250:	7e 14                	jle    266 <memmove+0x26>
 252:	31 d2                	xor    %edx,%edx
 254:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 258:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 25c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 25f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 262:	39 d3                	cmp    %edx,%ebx
 264:	75 f2                	jne    258 <memmove+0x18>
  return vdst;
}
 266:	5b                   	pop    %ebx
 267:	5e                   	pop    %esi
 268:	5d                   	pop    %ebp
 269:	c3                   	ret    

0000026a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 26a:	b8 01 00 00 00       	mov    $0x1,%eax
 26f:	cd 40                	int    $0x40
 271:	c3                   	ret    

00000272 <exit>:
SYSCALL(exit)
 272:	b8 02 00 00 00       	mov    $0x2,%eax
 277:	cd 40                	int    $0x40
 279:	c3                   	ret    

0000027a <wait>:
SYSCALL(wait)
 27a:	b8 03 00 00 00       	mov    $0x3,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <pipe>:
SYSCALL(pipe)
 282:	b8 04 00 00 00       	mov    $0x4,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <read>:
SYSCALL(read)
 28a:	b8 05 00 00 00       	mov    $0x5,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <write>:
SYSCALL(write)
 292:	b8 10 00 00 00       	mov    $0x10,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <close>:
SYSCALL(close)
 29a:	b8 15 00 00 00       	mov    $0x15,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <kill>:
SYSCALL(kill)
 2a2:	b8 06 00 00 00       	mov    $0x6,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <exec>:
SYSCALL(exec)
 2aa:	b8 07 00 00 00       	mov    $0x7,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <open>:
SYSCALL(open)
 2b2:	b8 0f 00 00 00       	mov    $0xf,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <mknod>:
SYSCALL(mknod)
 2ba:	b8 11 00 00 00       	mov    $0x11,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <unlink>:
SYSCALL(unlink)
 2c2:	b8 12 00 00 00       	mov    $0x12,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <fstat>:
SYSCALL(fstat)
 2ca:	b8 08 00 00 00       	mov    $0x8,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <link>:
SYSCALL(link)
 2d2:	b8 13 00 00 00       	mov    $0x13,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <mkdir>:
SYSCALL(mkdir)
 2da:	b8 14 00 00 00       	mov    $0x14,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <chdir>:
SYSCALL(chdir)
 2e2:	b8 09 00 00 00       	mov    $0x9,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <dup>:
SYSCALL(dup)
 2ea:	b8 0a 00 00 00       	mov    $0xa,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <getpid>:
SYSCALL(getpid)
 2f2:	b8 0b 00 00 00       	mov    $0xb,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <sbrk>:
SYSCALL(sbrk)
 2fa:	b8 0c 00 00 00       	mov    $0xc,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <sleep>:
SYSCALL(sleep)
 302:	b8 0d 00 00 00       	mov    $0xd,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <uptime>:
SYSCALL(uptime)
 30a:	b8 0e 00 00 00       	mov    $0xe,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <halt>:
SYSCALL(halt)
 312:	b8 1f 00 00 00       	mov    $0x1f,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <toggle>:
SYSCALL(toggle)
 31a:	b8 16 00 00 00       	mov    $0x16,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <add>:
SYSCALL(add)
 322:	b8 17 00 00 00       	mov    $0x17,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <ps>:
SYSCALL(ps)
 32a:	b8 18 00 00 00       	mov    $0x18,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <send>:
SYSCALL(send)
 332:	b8 19 00 00 00       	mov    $0x19,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <recv>:
SYSCALL(recv)
 33a:	b8 1a 00 00 00       	mov    $0x1a,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <print_count>:
SYSCALL(print_count)
 342:	b8 1b 00 00 00       	mov    $0x1b,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <send_multi>:
SYSCALL(send_multi)
 34a:	b8 1c 00 00 00       	mov    $0x1c,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <signal>:
SYSCALL(signal)
 352:	b8 1d 00 00 00       	mov    $0x1d,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <sigraise>:
SYSCALL(sigraise)
 35a:	b8 1e 00 00 00       	mov    $0x1e,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <recv_multi>:
SYSCALL(recv_multi)
 362:	b8 20 00 00 00       	mov    $0x20,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <change_state>:
SYSCALL(change_state)
 36a:	b8 21 00 00 00       	mov    $0x21,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    
 372:	66 90                	xchg   %ax,%ax
 374:	66 90                	xchg   %ax,%ax
 376:	66 90                	xchg   %ax,%ax
 378:	66 90                	xchg   %ax,%ax
 37a:	66 90                	xchg   %ax,%ax
 37c:	66 90                	xchg   %ax,%ax
 37e:	66 90                	xchg   %ax,%ax

00000380 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 380:	55                   	push   %ebp
 381:	89 e5                	mov    %esp,%ebp
 383:	57                   	push   %edi
 384:	56                   	push   %esi
 385:	53                   	push   %ebx
 386:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 389:	85 d2                	test   %edx,%edx
{
 38b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 38e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 390:	79 76                	jns    408 <printint+0x88>
 392:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 396:	74 70                	je     408 <printint+0x88>
    x = -xx;
 398:	f7 d8                	neg    %eax
    neg = 1;
 39a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 3a1:	31 f6                	xor    %esi,%esi
 3a3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 3a6:	eb 0a                	jmp    3b2 <printint+0x32>
 3a8:	90                   	nop
 3a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 3b0:	89 fe                	mov    %edi,%esi
 3b2:	31 d2                	xor    %edx,%edx
 3b4:	8d 7e 01             	lea    0x1(%esi),%edi
 3b7:	f7 f1                	div    %ecx
 3b9:	0f b6 92 80 07 00 00 	movzbl 0x780(%edx),%edx
  }while((x /= base) != 0);
 3c0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 3c2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 3c5:	75 e9                	jne    3b0 <printint+0x30>
  if(neg)
 3c7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 3ca:	85 c0                	test   %eax,%eax
 3cc:	74 08                	je     3d6 <printint+0x56>
    buf[i++] = '-';
 3ce:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 3d3:	8d 7e 02             	lea    0x2(%esi),%edi
 3d6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 3da:	8b 7d c0             	mov    -0x40(%ebp),%edi
 3dd:	8d 76 00             	lea    0x0(%esi),%esi
 3e0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 3e3:	83 ec 04             	sub    $0x4,%esp
 3e6:	83 ee 01             	sub    $0x1,%esi
 3e9:	6a 01                	push   $0x1
 3eb:	53                   	push   %ebx
 3ec:	57                   	push   %edi
 3ed:	88 45 d7             	mov    %al,-0x29(%ebp)
 3f0:	e8 9d fe ff ff       	call   292 <write>

  while(--i >= 0)
 3f5:	83 c4 10             	add    $0x10,%esp
 3f8:	39 de                	cmp    %ebx,%esi
 3fa:	75 e4                	jne    3e0 <printint+0x60>
    putc(fd, buf[i]);
}
 3fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ff:	5b                   	pop    %ebx
 400:	5e                   	pop    %esi
 401:	5f                   	pop    %edi
 402:	5d                   	pop    %ebp
 403:	c3                   	ret    
 404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 408:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 40f:	eb 90                	jmp    3a1 <printint+0x21>
 411:	eb 0d                	jmp    420 <printf>
 413:	90                   	nop
 414:	90                   	nop
 415:	90                   	nop
 416:	90                   	nop
 417:	90                   	nop
 418:	90                   	nop
 419:	90                   	nop
 41a:	90                   	nop
 41b:	90                   	nop
 41c:	90                   	nop
 41d:	90                   	nop
 41e:	90                   	nop
 41f:	90                   	nop

00000420 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 420:	55                   	push   %ebp
 421:	89 e5                	mov    %esp,%ebp
 423:	57                   	push   %edi
 424:	56                   	push   %esi
 425:	53                   	push   %ebx
 426:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 429:	8b 75 0c             	mov    0xc(%ebp),%esi
 42c:	0f b6 1e             	movzbl (%esi),%ebx
 42f:	84 db                	test   %bl,%bl
 431:	0f 84 b3 00 00 00    	je     4ea <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 437:	8d 45 10             	lea    0x10(%ebp),%eax
 43a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 43d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 43f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 442:	eb 2f                	jmp    473 <printf+0x53>
 444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 448:	83 f8 25             	cmp    $0x25,%eax
 44b:	0f 84 a7 00 00 00    	je     4f8 <printf+0xd8>
  write(fd, &c, 1);
 451:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 454:	83 ec 04             	sub    $0x4,%esp
 457:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 45a:	6a 01                	push   $0x1
 45c:	50                   	push   %eax
 45d:	ff 75 08             	pushl  0x8(%ebp)
 460:	e8 2d fe ff ff       	call   292 <write>
 465:	83 c4 10             	add    $0x10,%esp
 468:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 46b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 46f:	84 db                	test   %bl,%bl
 471:	74 77                	je     4ea <printf+0xca>
    if(state == 0){
 473:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 475:	0f be cb             	movsbl %bl,%ecx
 478:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 47b:	74 cb                	je     448 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 47d:	83 ff 25             	cmp    $0x25,%edi
 480:	75 e6                	jne    468 <printf+0x48>
      if(c == 'd'){
 482:	83 f8 64             	cmp    $0x64,%eax
 485:	0f 84 05 01 00 00    	je     590 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 48b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 491:	83 f9 70             	cmp    $0x70,%ecx
 494:	74 72                	je     508 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 496:	83 f8 73             	cmp    $0x73,%eax
 499:	0f 84 99 00 00 00    	je     538 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 49f:	83 f8 63             	cmp    $0x63,%eax
 4a2:	0f 84 08 01 00 00    	je     5b0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4a8:	83 f8 25             	cmp    $0x25,%eax
 4ab:	0f 84 ef 00 00 00    	je     5a0 <printf+0x180>
  write(fd, &c, 1);
 4b1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4b4:	83 ec 04             	sub    $0x4,%esp
 4b7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 4bb:	6a 01                	push   $0x1
 4bd:	50                   	push   %eax
 4be:	ff 75 08             	pushl  0x8(%ebp)
 4c1:	e8 cc fd ff ff       	call   292 <write>
 4c6:	83 c4 0c             	add    $0xc,%esp
 4c9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 4cc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 4cf:	6a 01                	push   $0x1
 4d1:	50                   	push   %eax
 4d2:	ff 75 08             	pushl  0x8(%ebp)
 4d5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4d8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 4da:	e8 b3 fd ff ff       	call   292 <write>
  for(i = 0; fmt[i]; i++){
 4df:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 4e3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 4e6:	84 db                	test   %bl,%bl
 4e8:	75 89                	jne    473 <printf+0x53>
    }
  }
}
 4ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4ed:	5b                   	pop    %ebx
 4ee:	5e                   	pop    %esi
 4ef:	5f                   	pop    %edi
 4f0:	5d                   	pop    %ebp
 4f1:	c3                   	ret    
 4f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 4f8:	bf 25 00 00 00       	mov    $0x25,%edi
 4fd:	e9 66 ff ff ff       	jmp    468 <printf+0x48>
 502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 508:	83 ec 0c             	sub    $0xc,%esp
 50b:	b9 10 00 00 00       	mov    $0x10,%ecx
 510:	6a 00                	push   $0x0
 512:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 515:	8b 45 08             	mov    0x8(%ebp),%eax
 518:	8b 17                	mov    (%edi),%edx
 51a:	e8 61 fe ff ff       	call   380 <printint>
        ap++;
 51f:	89 f8                	mov    %edi,%eax
 521:	83 c4 10             	add    $0x10,%esp
      state = 0;
 524:	31 ff                	xor    %edi,%edi
        ap++;
 526:	83 c0 04             	add    $0x4,%eax
 529:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 52c:	e9 37 ff ff ff       	jmp    468 <printf+0x48>
 531:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 538:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 53b:	8b 08                	mov    (%eax),%ecx
        ap++;
 53d:	83 c0 04             	add    $0x4,%eax
 540:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 543:	85 c9                	test   %ecx,%ecx
 545:	0f 84 8e 00 00 00    	je     5d9 <printf+0x1b9>
        while(*s != 0){
 54b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 54e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 550:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 552:	84 c0                	test   %al,%al
 554:	0f 84 0e ff ff ff    	je     468 <printf+0x48>
 55a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 55d:	89 de                	mov    %ebx,%esi
 55f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 562:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 565:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 568:	83 ec 04             	sub    $0x4,%esp
          s++;
 56b:	83 c6 01             	add    $0x1,%esi
 56e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 571:	6a 01                	push   $0x1
 573:	57                   	push   %edi
 574:	53                   	push   %ebx
 575:	e8 18 fd ff ff       	call   292 <write>
        while(*s != 0){
 57a:	0f b6 06             	movzbl (%esi),%eax
 57d:	83 c4 10             	add    $0x10,%esp
 580:	84 c0                	test   %al,%al
 582:	75 e4                	jne    568 <printf+0x148>
 584:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 587:	31 ff                	xor    %edi,%edi
 589:	e9 da fe ff ff       	jmp    468 <printf+0x48>
 58e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 590:	83 ec 0c             	sub    $0xc,%esp
 593:	b9 0a 00 00 00       	mov    $0xa,%ecx
 598:	6a 01                	push   $0x1
 59a:	e9 73 ff ff ff       	jmp    512 <printf+0xf2>
 59f:	90                   	nop
  write(fd, &c, 1);
 5a0:	83 ec 04             	sub    $0x4,%esp
 5a3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 5a6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 5a9:	6a 01                	push   $0x1
 5ab:	e9 21 ff ff ff       	jmp    4d1 <printf+0xb1>
        putc(fd, *ap);
 5b0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 5b3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 5b6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 5b8:	6a 01                	push   $0x1
        ap++;
 5ba:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 5bd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 5c0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 5c3:	50                   	push   %eax
 5c4:	ff 75 08             	pushl  0x8(%ebp)
 5c7:	e8 c6 fc ff ff       	call   292 <write>
        ap++;
 5cc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 5cf:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5d2:	31 ff                	xor    %edi,%edi
 5d4:	e9 8f fe ff ff       	jmp    468 <printf+0x48>
          s = "(null)";
 5d9:	bb 78 07 00 00       	mov    $0x778,%ebx
        while(*s != 0){
 5de:	b8 28 00 00 00       	mov    $0x28,%eax
 5e3:	e9 72 ff ff ff       	jmp    55a <printf+0x13a>
 5e8:	66 90                	xchg   %ax,%ax
 5ea:	66 90                	xchg   %ax,%ax
 5ec:	66 90                	xchg   %ax,%ax
 5ee:	66 90                	xchg   %ax,%ax

000005f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f1:	a1 24 0a 00 00       	mov    0xa24,%eax
{
 5f6:	89 e5                	mov    %esp,%ebp
 5f8:	57                   	push   %edi
 5f9:	56                   	push   %esi
 5fa:	53                   	push   %ebx
 5fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 5fe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 601:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 608:	39 c8                	cmp    %ecx,%eax
 60a:	8b 10                	mov    (%eax),%edx
 60c:	73 32                	jae    640 <free+0x50>
 60e:	39 d1                	cmp    %edx,%ecx
 610:	72 04                	jb     616 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 612:	39 d0                	cmp    %edx,%eax
 614:	72 32                	jb     648 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 616:	8b 73 fc             	mov    -0x4(%ebx),%esi
 619:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 61c:	39 fa                	cmp    %edi,%edx
 61e:	74 30                	je     650 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 620:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 623:	8b 50 04             	mov    0x4(%eax),%edx
 626:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 629:	39 f1                	cmp    %esi,%ecx
 62b:	74 3a                	je     667 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 62d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 62f:	a3 24 0a 00 00       	mov    %eax,0xa24
}
 634:	5b                   	pop    %ebx
 635:	5e                   	pop    %esi
 636:	5f                   	pop    %edi
 637:	5d                   	pop    %ebp
 638:	c3                   	ret    
 639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 640:	39 d0                	cmp    %edx,%eax
 642:	72 04                	jb     648 <free+0x58>
 644:	39 d1                	cmp    %edx,%ecx
 646:	72 ce                	jb     616 <free+0x26>
{
 648:	89 d0                	mov    %edx,%eax
 64a:	eb bc                	jmp    608 <free+0x18>
 64c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 650:	03 72 04             	add    0x4(%edx),%esi
 653:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 656:	8b 10                	mov    (%eax),%edx
 658:	8b 12                	mov    (%edx),%edx
 65a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 65d:	8b 50 04             	mov    0x4(%eax),%edx
 660:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 663:	39 f1                	cmp    %esi,%ecx
 665:	75 c6                	jne    62d <free+0x3d>
    p->s.size += bp->s.size;
 667:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 66a:	a3 24 0a 00 00       	mov    %eax,0xa24
    p->s.size += bp->s.size;
 66f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 672:	8b 53 f8             	mov    -0x8(%ebx),%edx
 675:	89 10                	mov    %edx,(%eax)
}
 677:	5b                   	pop    %ebx
 678:	5e                   	pop    %esi
 679:	5f                   	pop    %edi
 67a:	5d                   	pop    %ebp
 67b:	c3                   	ret    
 67c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000680 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 680:	55                   	push   %ebp
 681:	89 e5                	mov    %esp,%ebp
 683:	57                   	push   %edi
 684:	56                   	push   %esi
 685:	53                   	push   %ebx
 686:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 689:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 68c:	8b 15 24 0a 00 00    	mov    0xa24,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 692:	8d 78 07             	lea    0x7(%eax),%edi
 695:	c1 ef 03             	shr    $0x3,%edi
 698:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 69b:	85 d2                	test   %edx,%edx
 69d:	0f 84 9d 00 00 00    	je     740 <malloc+0xc0>
 6a3:	8b 02                	mov    (%edx),%eax
 6a5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 6a8:	39 cf                	cmp    %ecx,%edi
 6aa:	76 6c                	jbe    718 <malloc+0x98>
 6ac:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 6b2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 6b7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 6ba:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 6c1:	eb 0e                	jmp    6d1 <malloc+0x51>
 6c3:	90                   	nop
 6c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6c8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6ca:	8b 48 04             	mov    0x4(%eax),%ecx
 6cd:	39 f9                	cmp    %edi,%ecx
 6cf:	73 47                	jae    718 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 6d1:	39 05 24 0a 00 00    	cmp    %eax,0xa24
 6d7:	89 c2                	mov    %eax,%edx
 6d9:	75 ed                	jne    6c8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 6db:	83 ec 0c             	sub    $0xc,%esp
 6de:	56                   	push   %esi
 6df:	e8 16 fc ff ff       	call   2fa <sbrk>
  if(p == (char*)-1)
 6e4:	83 c4 10             	add    $0x10,%esp
 6e7:	83 f8 ff             	cmp    $0xffffffff,%eax
 6ea:	74 1c                	je     708 <malloc+0x88>
  hp->s.size = nu;
 6ec:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 6ef:	83 ec 0c             	sub    $0xc,%esp
 6f2:	83 c0 08             	add    $0x8,%eax
 6f5:	50                   	push   %eax
 6f6:	e8 f5 fe ff ff       	call   5f0 <free>
  return freep;
 6fb:	8b 15 24 0a 00 00    	mov    0xa24,%edx
      if((p = morecore(nunits)) == 0)
 701:	83 c4 10             	add    $0x10,%esp
 704:	85 d2                	test   %edx,%edx
 706:	75 c0                	jne    6c8 <malloc+0x48>
        return 0;
  }
}
 708:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 70b:	31 c0                	xor    %eax,%eax
}
 70d:	5b                   	pop    %ebx
 70e:	5e                   	pop    %esi
 70f:	5f                   	pop    %edi
 710:	5d                   	pop    %ebp
 711:	c3                   	ret    
 712:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 718:	39 cf                	cmp    %ecx,%edi
 71a:	74 54                	je     770 <malloc+0xf0>
        p->s.size -= nunits;
 71c:	29 f9                	sub    %edi,%ecx
 71e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 721:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 724:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 727:	89 15 24 0a 00 00    	mov    %edx,0xa24
}
 72d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 730:	83 c0 08             	add    $0x8,%eax
}
 733:	5b                   	pop    %ebx
 734:	5e                   	pop    %esi
 735:	5f                   	pop    %edi
 736:	5d                   	pop    %ebp
 737:	c3                   	ret    
 738:	90                   	nop
 739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 740:	c7 05 24 0a 00 00 28 	movl   $0xa28,0xa24
 747:	0a 00 00 
 74a:	c7 05 28 0a 00 00 28 	movl   $0xa28,0xa28
 751:	0a 00 00 
    base.s.size = 0;
 754:	b8 28 0a 00 00       	mov    $0xa28,%eax
 759:	c7 05 2c 0a 00 00 00 	movl   $0x0,0xa2c
 760:	00 00 00 
 763:	e9 44 ff ff ff       	jmp    6ac <malloc+0x2c>
 768:	90                   	nop
 769:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 770:	8b 08                	mov    (%eax),%ecx
 772:	89 0a                	mov    %ecx,(%edx)
 774:	eb b1                	jmp    727 <malloc+0xa7>
