
_maekawa:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
	}
	return N;
}

int main(int argc, char *argv[])
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	57                   	push   %edi
       e:	56                   	push   %esi
       f:	53                   	push   %ebx
      10:	51                   	push   %ecx
	int N=0;
      11:	31 ff                	xor    %edi,%edi
{
      13:	81 ec c0 00 00 00    	sub    $0xc0,%esp
	int P1,P2,P3;
	////////////////////////////////////////////
		//Taking Input from the file
  	char *filename;
	filename = "assig2b.inp";
	int fd = open(filename, 0);
      19:	6a 00                	push   $0x0
      1b:	68 da 17 00 00       	push   $0x17da
      20:	e8 dd 12 00 00       	call   1302 <open>
      25:	83 c4 10             	add    $0x10,%esp
      28:	89 c3                	mov    %eax,%ebx
      2a:	eb 0b                	jmp    37 <main+0x37>
      2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		N = 10*N + alpha;
      30:	8d 14 bf             	lea    (%edi,%edi,4),%edx
      33:	8d 7c 50 d0          	lea    -0x30(%eax,%edx,2),%edi
		read(fd, &c, 1);
      37:	8d 45 84             	lea    -0x7c(%ebp),%eax
      3a:	83 ec 04             	sub    $0x4,%esp
      3d:	6a 01                	push   $0x1
      3f:	50                   	push   %eax
      40:	53                   	push   %ebx
      41:	e8 94 12 00 00       	call   12da <read>
		if(c == '\n'){
      46:	0f be 45 84          	movsbl -0x7c(%ebp),%eax
      4a:	83 c4 10             	add    $0x10,%esp
      4d:	3c 0a                	cmp    $0xa,%al
      4f:	75 df                	jne    30 <main+0x30>
	int N=0;
      51:	31 f6                	xor    %esi,%esi
      53:	eb 0a                	jmp    5f <main+0x5f>
      55:	8d 76 00             	lea    0x0(%esi),%esi
		N = 10*N + alpha;
      58:	8d 14 b6             	lea    (%esi,%esi,4),%edx
      5b:	8d 74 50 d0          	lea    -0x30(%eax,%edx,2),%esi
		read(fd, &c, 1);
      5f:	8d 45 84             	lea    -0x7c(%ebp),%eax
      62:	83 ec 04             	sub    $0x4,%esp
      65:	6a 01                	push   $0x1
      67:	50                   	push   %eax
      68:	53                   	push   %ebx
      69:	e8 6c 12 00 00       	call   12da <read>
		if(c == '\n'){
      6e:	0f be 45 84          	movsbl -0x7c(%ebp),%eax
      72:	83 c4 10             	add    $0x10,%esp
      75:	3c 0a                	cmp    $0xa,%al
      77:	75 df                	jne    58 <main+0x58>
      79:	89 b5 44 ff ff ff    	mov    %esi,-0xbc(%ebp)
	int N=0;
      7f:	31 f6                	xor    %esi,%esi
      81:	eb 0c                	jmp    8f <main+0x8f>
      83:	90                   	nop
      84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		N = 10*N + alpha;
      88:	8d 14 b6             	lea    (%esi,%esi,4),%edx
      8b:	8d 74 50 d0          	lea    -0x30(%eax,%edx,2),%esi
		read(fd, &c, 1);
      8f:	8d 45 84             	lea    -0x7c(%ebp),%eax
      92:	83 ec 04             	sub    $0x4,%esp
      95:	6a 01                	push   $0x1
      97:	50                   	push   %eax
      98:	53                   	push   %ebx
      99:	e8 3c 12 00 00       	call   12da <read>
		if(c == '\n'){
      9e:	0f be 45 84          	movsbl -0x7c(%ebp),%eax
      a2:	83 c4 10             	add    $0x10,%esp
      a5:	3c 0a                	cmp    $0xa,%al
      a7:	75 df                	jne    88 <main+0x88>
      a9:	89 b5 40 ff ff ff    	mov    %esi,-0xc0(%ebp)
	int N=0;
      af:	31 f6                	xor    %esi,%esi
      b1:	eb 0c                	jmp    bf <main+0xbf>
      b3:	90                   	nop
      b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		N = 10*N + alpha;
      b8:	8d 14 b6             	lea    (%esi,%esi,4),%edx
      bb:	8d 74 50 d0          	lea    -0x30(%eax,%edx,2),%esi
		read(fd, &c, 1);
      bf:	8d 45 84             	lea    -0x7c(%ebp),%eax
      c2:	83 ec 04             	sub    $0x4,%esp
      c5:	6a 01                	push   $0x1
      c7:	50                   	push   %eax
      c8:	53                   	push   %ebx
      c9:	e8 0c 12 00 00       	call   12da <read>
		if(c == '\n'){
      ce:	0f be 45 84          	movsbl -0x7c(%ebp),%eax
      d2:	83 c4 10             	add    $0x10,%esp
      d5:	3c 0a                	cmp    $0xa,%al
      d7:	75 df                	jne    b8 <main+0xb8>
	P = readInt(fd);
	P1 = readInt(fd);
	P2 = readInt(fd);
	P3 = readInt(fd);
	
	close(fd);
      d9:	83 ec 0c             	sub    $0xc,%esp
      dc:	89 b5 3c ff ff ff    	mov    %esi,-0xc4(%ebp)
      e2:	53                   	push   %ebx
      e3:	e8 02 12 00 00       	call   12ea <close>

	/////////////////////////////////////////////

	pipe(masterPipe);
      e8:	c7 04 24 a4 70 00 00 	movl   $0x70a4,(%esp)
      ef:	e8 de 11 00 00       	call   12d2 <pipe>

	for(int i=0;i<P;i++){
      f4:	83 c4 10             	add    $0x10,%esp
      f7:	85 ff                	test   %edi,%edi
      f9:	0f 8e fa 02 00 00    	jle    3f9 <main+0x3f9>
      ff:	be e0 6e 00 00       	mov    $0x6ee0,%esi
     104:	8d 1c fd e0 6e 00 00 	lea    0x6ee0(,%edi,8),%ebx
     10b:	eb 0a                	jmp    117 <main+0x117>
     10d:	8d 76 00             	lea    0x0(%esi),%esi
     110:	83 c6 08             	add    $0x8,%esi
     113:	39 de                	cmp    %ebx,%esi
     115:	74 29                	je     140 <main+0x140>
		if(pipe(childPipe[i])<0){
     117:	83 ec 0c             	sub    $0xc,%esp
     11a:	56                   	push   %esi
     11b:	e8 b2 11 00 00       	call   12d2 <pipe>
     120:	83 c4 10             	add    $0x10,%esp
     123:	85 c0                	test   %eax,%eax
     125:	79 e9                	jns    110 <main+0x110>
			printf(1,"Pipe not created Successfully\n");
     127:	83 ec 08             	sub    $0x8,%esp
     12a:	83 c6 08             	add    $0x8,%esi
     12d:	68 9c 18 00 00       	push   $0x189c
     132:	6a 01                	push   $0x1
     134:	e8 37 13 00 00       	call   1470 <printf>
     139:	83 c4 10             	add    $0x10,%esp
	for(int i=0;i<P;i++){
     13c:	39 de                	cmp    %ebx,%esi
     13e:	75 d7                	jne    117 <main+0x117>
		};
	}

	switch (P)
     140:	83 ff 09             	cmp    $0x9,%edi
     143:	0f 84 62 03 00 00    	je     4ab <main+0x4ab>
     149:	0f 8e 9c 02 00 00    	jle    3eb <main+0x3eb>
     14f:	83 ff 10             	cmp    $0x10,%edi
     152:	0f 84 49 03 00 00    	je     4a1 <main+0x4a1>
     158:	83 ff 19             	cmp    $0x19,%edi
			break;
		case 16:
			N = 4;
			break;
		case 25:
			N = 5;
     15b:	be 05 00 00 00       	mov    $0x5,%esi
	switch (P)
     160:	0f 85 93 02 00 00    	jne    3f9 <main+0x3f9>
	 * 
	 *  0  1
	 *  2  3
	 * 
	***********************/
	K = (2*N)-1;
     166:	8d 04 36             	lea    (%esi,%esi,1),%eax
     169:	8d 48 ff             	lea    -0x1(%eax),%ecx
	int S[P][K];
     16c:	8d 04 8d 00 00 00 00 	lea    0x0(,%ecx,4),%eax
	K = (2*N)-1;
     173:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
     179:	89 0d 60 1e 00 00    	mov    %ecx,0x1e60
	int S[P][K];
     17f:	89 85 48 ff ff ff    	mov    %eax,-0xb8(%ebp)
     185:	8d 04 bd 00 00 00 00 	lea    0x0(,%edi,4),%eax
     18c:	0f af c1             	imul   %ecx,%eax
     18f:	83 c0 12             	add    $0x12,%eax
     192:	83 e0 f0             	and    $0xfffffff0,%eax
     195:	29 c4                	sub    %eax,%esp
     197:	89 a5 50 ff ff ff    	mov    %esp,-0xb0(%ebp)
		int it=0;
		int rem = x%N;
		int di = x/N;
		for(int y=0; (y < P) && (it != K ) ; y++ ){
			if(y/N == di || y%N == rem){
				S[x][it] = y;
     19d:	8b 85 48 ff ff ff    	mov    -0xb8(%ebp),%eax
     1a3:	c7 85 5c ff ff ff 00 	movl   $0x0,-0xa4(%ebp)
     1aa:	00 00 00 
     1ad:	c1 e8 02             	shr    $0x2,%eax
     1b0:	89 85 4c ff ff ff    	mov    %eax,-0xb4(%ebp)
     1b6:	89 f8                	mov    %edi,%eax
     1b8:	89 f7                	mov    %esi,%edi
     1ba:	89 c6                	mov    %eax,%esi
     1bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     1c0:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
		int it=0;
     1c6:	31 db                	xor    %ebx,%ebx
		for(int y=0; (y < P) && (it != K ) ; y++ ){
     1c8:	31 c9                	xor    %ecx,%ecx
     1ca:	99                   	cltd   
     1cb:	f7 ff                	idiv   %edi
     1cd:	89 95 58 ff ff ff    	mov    %edx,-0xa8(%ebp)
				S[x][it] = y;
     1d3:	8b 95 4c ff ff ff    	mov    -0xb4(%ebp),%edx
     1d9:	0f af 95 5c ff ff ff 	imul   -0xa4(%ebp),%edx
     1e0:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
     1e6:	89 95 54 ff ff ff    	mov    %edx,-0xac(%ebp)
     1ec:	eb 19                	jmp    207 <main+0x207>
     1ee:	66 90                	xchg   %ax,%ax
			if(y/N == di || y%N == rem){
     1f0:	3b 95 58 ff ff ff    	cmp    -0xa8(%ebp),%edx
     1f6:	74 1c                	je     214 <main+0x214>
		for(int y=0; (y < P) && (it != K ) ; y++ ){
     1f8:	83 c1 01             	add    $0x1,%ecx
     1fb:	39 f1                	cmp    %esi,%ecx
     1fd:	7d 30                	jge    22f <main+0x22f>
     1ff:	3b 9d 60 ff ff ff    	cmp    -0xa0(%ebp),%ebx
     205:	74 28                	je     22f <main+0x22f>
     207:	89 c8                	mov    %ecx,%eax
     209:	99                   	cltd   
     20a:	f7 ff                	idiv   %edi
			if(y/N == di || y%N == rem){
     20c:	3b 85 64 ff ff ff    	cmp    -0x9c(%ebp),%eax
     212:	75 dc                	jne    1f0 <main+0x1f0>
				S[x][it] = y;
     214:	8b 85 54 ff ff ff    	mov    -0xac(%ebp),%eax
     21a:	8b 95 50 ff ff ff    	mov    -0xb0(%ebp),%edx
     220:	01 d8                	add    %ebx,%eax
				it++;
     222:	83 c3 01             	add    $0x1,%ebx
				S[x][it] = y;
     225:	89 0c 82             	mov    %ecx,(%edx,%eax,4)
		for(int y=0; (y < P) && (it != K ) ; y++ ){
     228:	83 c1 01             	add    $0x1,%ecx
     22b:	39 f1                	cmp    %esi,%ecx
     22d:	7c d0                	jl     1ff <main+0x1ff>
	for(int x=0;x<P;x++){
     22f:	83 85 5c ff ff ff 01 	addl   $0x1,-0xa4(%ebp)
     236:	8b 85 5c ff ff ff    	mov    -0xa4(%ebp),%eax
     23c:	39 f0                	cmp    %esi,%eax
     23e:	7c 80                	jl     1c0 <main+0x1c0>
			}
		}
	}

	// printf(1,"Started\n");
	offset = getpid();
     240:	e8 fd 10 00 00       	call   1342 <getpid>
     245:	89 f7                	mov    %esi,%edi
     247:	a3 40 1e 00 00       	mov    %eax,0x1e40
	// }

	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////CHILD PROCESS /////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	for(int i=0;i<P;i++){
     24c:	31 db                	xor    %ebx,%ebx
     24e:	eb 12                	jmp    262 <main+0x262>
				// recv(buf);
				recvHandler(buf,i);
			} 
			exit();
		}
		rec_pids[i] = tc;
     250:	89 04 9d 40 70 00 00 	mov    %eax,0x7040(,%ebx,4)
	for(int i=0;i<P;i++){
     257:	83 c3 01             	add    $0x1,%ebx
     25a:	39 fb                	cmp    %edi,%ebx
     25c:	0f 8d d7 01 00 00    	jge    439 <main+0x439>
		int tc = fork();
     262:	e8 53 10 00 00       	call   12ba <fork>
		if(tc==0){
     267:	85 c0                	test   %eax,%eax
     269:	75 e5                	jne    250 <main+0x250>
     26b:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
			read(childPipe[i][0],pids,sizeof(pids));
     271:	8d 45 84             	lea    -0x7c(%ebp),%eax
			FailedBit[i]  = 0;// no failed message recieved in the beginning
     274:	c7 04 9d c0 6f 00 00 	movl   $0x0,0x6fc0(,%ebx,4)
     27b:	00 00 00 00 
			processStatus = 0;//unlocked
     27f:	c7 05 c4 6e 00 00 00 	movl   $0x0,0x6ec4
     286:	00 00 00 
			lockedCount = 0;//no members locked in the beginning
     289:	c7 05 ac 70 00 00 00 	movl   $0x0,0x70ac
     290:	00 00 00 
			read(childPipe[i][0],pids,sizeof(pids));
     293:	51                   	push   %ecx
     294:	6a 64                	push   $0x64
     296:	50                   	push   %eax
     297:	ff 34 dd e0 6e 00 00 	pushl  0x6ee0(,%ebx,8)
     29e:	e8 37 10 00 00       	call   12da <read>
			completeAndStop = P1;
     2a3:	8b b5 44 ff ff ff    	mov    -0xbc(%ebp),%esi
			if(i<P1){
     2a9:	83 c4 10             	add    $0x10,%esp
     2ac:	39 de                	cmp    %ebx,%esi
			completeAndStop = P1;
     2ae:	89 35 48 1e 00 00    	mov    %esi,0x1e48
			if(i<P1){
     2b4:	0f 8f f7 00 00 00    	jg     3b1 <main+0x3b1>
			}else if(i>=P1 && i<(P1+P2)){
     2ba:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
     2c0:	01 f0                	add    %esi,%eax
     2c2:	39 d8                	cmp    %ebx,%eax
     2c4:	0f 8e 15 02 00 00    	jle    4df <main+0x4df>
				int STemp[K];
     2ca:	8b 15 60 1e 00 00    	mov    0x1e60,%edx
			if(whichP>1){
     2d0:	89 a5 60 ff ff ff    	mov    %esp,-0xa0(%ebp)
				whichP = 2;
     2d6:	c7 85 5c ff ff ff 02 	movl   $0x2,-0xa4(%ebp)
     2dd:	00 00 00 
				int STemp[K];
     2e0:	8d 04 95 12 00 00 00 	lea    0x12(,%edx,4),%eax
     2e7:	83 e0 f0             	and    $0xfffffff0,%eax
     2ea:	29 c4                	sub    %eax,%esp
				for(int qw=0;qw<K;qw++){
     2ec:	85 d2                	test   %edx,%edx
				int STemp[K];
     2ee:	89 e6                	mov    %esp,%esi
				for(int qw=0;qw<K;qw++){
     2f0:	0f 8e 52 02 00 00    	jle    548 <main+0x548>
     2f6:	8b 8d 48 ff ff ff    	mov    -0xb8(%ebp),%ecx
     2fc:	31 c0                	xor    %eax,%eax
     2fe:	89 9d 58 ff ff ff    	mov    %ebx,-0xa8(%ebp)
     304:	0f af cb             	imul   %ebx,%ecx
     307:	03 8d 50 ff ff ff    	add    -0xb0(%ebp),%ecx
     30d:	8d 76 00             	lea    0x0(%esi),%esi
					STemp[qw] = pids[S[i][qw]];//pids.mint[S[i][qw]]
     310:	8b 1c 81             	mov    (%ecx,%eax,4),%ebx
     313:	8b 5c 9d 84          	mov    -0x7c(%ebp,%ebx,4),%ebx
     317:	89 1c 86             	mov    %ebx,(%esi,%eax,4)
				for(int qw=0;qw<K;qw++){
     31a:	83 c0 01             	add    $0x1,%eax
     31d:	39 d0                	cmp    %edx,%eax
     31f:	75 ef                	jne    310 <main+0x310>
     321:	8b 9d 58 ff ff ff    	mov    -0xa8(%ebp),%ebx
				acquireLockMaekawa(STemp,K,i);
     327:	52                   	push   %edx
     328:	53                   	push   %ebx
     329:	50                   	push   %eax
     32a:	56                   	push   %esi
     32b:	e8 d0 0b 00 00       	call   f00 <acquireLockMaekawa>
				if(whichP==2){
     330:	83 c4 10             	add    $0x10,%esp
     333:	83 bd 5c ff ff ff 02 	cmpl   $0x2,-0xa4(%ebp)
     33a:	0f 84 14 02 00 00    	je     554 <main+0x554>
				releaseLockMaekawa(STemp,K,i);
     340:	51                   	push   %ecx
     341:	53                   	push   %ebx
     342:	ff 35 60 1e 00 00    	pushl  0x1e60
     348:	56                   	push   %esi
     349:	8d b5 74 ff ff ff    	lea    -0x8c(%ebp),%esi
     34f:	e8 5c 0c 00 00       	call   fb0 <releaseLockMaekawa>
     354:	89 9d 5c ff ff ff    	mov    %ebx,-0xa4(%ebp)
     35a:	8b 9d 64 ff ff ff    	mov    -0x9c(%ebp),%ebx
     360:	83 c4 10             	add    $0x10,%esp
     363:	90                   	nop
     364:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
					buf[0] = COMPLETE;
     368:	c7 85 74 ff ff ff 00 	movl   $0x40c00000,-0x8c(%ebp)
     36f:	00 c0 40 
					buf[1] = getpid();
     372:	e8 cb 0f 00 00       	call   1342 <getpid>
     377:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
					write(childPipe[po][1],buf,sizeof(buf));
     37d:	83 ec 04             	sub    $0x4,%esp
					buf[1] = getpid();
     380:	db 85 64 ff ff ff    	fildl  -0x9c(%ebp)
     386:	d9 9d 78 ff ff ff    	fstps  -0x88(%ebp)
					write(childPipe[po][1],buf,sizeof(buf));
     38c:	6a 10                	push   $0x10
     38e:	56                   	push   %esi
     38f:	ff 34 dd e4 6e 00 00 	pushl  0x6ee4(,%ebx,8)
				for(int po=0;po<P;po++){
     396:	83 c3 01             	add    $0x1,%ebx
					write(childPipe[po][1],buf,sizeof(buf));
     399:	e8 44 0f 00 00       	call   12e2 <write>
				for(int po=0;po<P;po++){
     39e:	83 c4 10             	add    $0x10,%esp
     3a1:	39 fb                	cmp    %edi,%ebx
     3a3:	7c c3                	jl     368 <main+0x368>
     3a5:	8b 9d 5c ff ff ff    	mov    -0xa4(%ebp),%ebx
     3ab:	8b a5 60 ff ff ff    	mov    -0xa0(%ebp),%esp
			while(completeAndStop<P){
     3b1:	39 3d 48 1e 00 00    	cmp    %edi,0x1e48
     3b7:	7d 2d                	jge    3e6 <main+0x3e6>
     3b9:	8d b5 74 ff ff ff    	lea    -0x8c(%ebp),%esi
     3bf:	90                   	nop
				read(childPipe[i][0],buf,sizeof(buf));
     3c0:	83 ec 04             	sub    $0x4,%esp
     3c3:	6a 10                	push   $0x10
     3c5:	56                   	push   %esi
     3c6:	ff 34 dd e0 6e 00 00 	pushl  0x6ee0(,%ebx,8)
     3cd:	e8 08 0f 00 00       	call   12da <read>
				recvHandler(buf,i);
     3d2:	58                   	pop    %eax
     3d3:	5a                   	pop    %edx
     3d4:	53                   	push   %ebx
     3d5:	56                   	push   %esi
     3d6:	e8 a5 04 00 00       	call   880 <recvHandler>
			while(completeAndStop<P){
     3db:	83 c4 10             	add    $0x10,%esp
     3de:	39 3d 48 1e 00 00    	cmp    %edi,0x1e48
     3e4:	7c da                	jl     3c0 <main+0x3c0>
			exit();
     3e6:	e8 d7 0e 00 00       	call   12c2 <exit>
	switch (P)
     3eb:	83 ff 04             	cmp    $0x4,%edi
			N = 2;
     3ee:	be 02 00 00 00       	mov    $0x2,%esi
	switch (P)
     3f3:	0f 84 6d fd ff ff    	je     166 <main+0x166>
			printf(1,"Wrong Value of P given \n");
     3f9:	53                   	push   %ebx
     3fa:	53                   	push   %ebx
     3fb:	68 e6 17 00 00       	push   $0x17e6
     400:	6a 01                	push   $0x1
     402:	e8 69 10 00 00       	call   1470 <printf>
	int S[P][K];
     407:	6b c7 14             	imul   $0x14,%edi,%eax
     40a:	83 c4 10             	add    $0x10,%esp
	K = (2*N)-1;
     40d:	c7 05 60 1e 00 00 05 	movl   $0x5,0x1e60
     414:	00 00 00 
	int S[P][K];
     417:	83 c0 12             	add    $0x12,%eax
     41a:	83 e0 f0             	and    $0xfffffff0,%eax
     41d:	29 c4                	sub    %eax,%esp
	for(int x=0;x<P;x++){
     41f:	85 ff                	test   %edi,%edi
	int S[P][K];
     421:	89 a5 50 ff ff ff    	mov    %esp,-0xb0(%ebp)
	for(int x=0;x<P;x++){
     427:	0f 8f fd 00 00 00    	jg     52a <main+0x52a>
	offset = getpid();
     42d:	e8 10 0f 00 00       	call   1342 <getpid>
     432:	a3 40 1e 00 00       	mov    %eax,0x1e40
     437:	eb ad                	jmp    3e6 <main+0x3e6>
     439:	31 db                	xor    %ebx,%ebx
     43b:	90                   	nop
     43c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
	////Start the threads
	
	
	for(int j=0;j<P;j++){
		int buf[25];
		for(int i=0;i<P;i++){
     440:	31 c0                	xor    %eax,%eax
     442:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			buf[i] = rec_pids[i];
     448:	8b 14 85 40 70 00 00 	mov    0x7040(,%eax,4),%edx
     44f:	89 54 85 84          	mov    %edx,-0x7c(%ebp,%eax,4)
		for(int i=0;i<P;i++){
     453:	83 c0 01             	add    $0x1,%eax
     456:	39 f8                	cmp    %edi,%eax
     458:	7c ee                	jl     448 <main+0x448>
		}
		write(childPipe[rec_pids[j] - offset-1][1],buf,sizeof(buf));
     45a:	8d 45 84             	lea    -0x7c(%ebp),%eax
     45d:	83 ec 04             	sub    $0x4,%esp
     460:	6a 64                	push   $0x64
     462:	50                   	push   %eax
     463:	8b 04 9d 40 70 00 00 	mov    0x7040(,%ebx,4),%eax
	for(int j=0;j<P;j++){
     46a:	83 c3 01             	add    $0x1,%ebx
		write(childPipe[rec_pids[j] - offset-1][1],buf,sizeof(buf));
     46d:	2b 05 40 1e 00 00    	sub    0x1e40,%eax
     473:	ff 34 c5 dc 6e 00 00 	pushl  0x6edc(,%eax,8)
     47a:	e8 63 0e 00 00       	call   12e2 <write>
	for(int j=0;j<P;j++){
     47f:	83 c4 10             	add    $0x10,%esp
     482:	39 fb                	cmp    %edi,%ebx
     484:	7c ba                	jl     440 <main+0x440>
	}

	for(int i=0;i<P;i++){	
     486:	31 db                	xor    %ebx,%ebx
     488:	90                   	nop
     489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     490:	83 c3 01             	add    $0x1,%ebx
		wait();
     493:	e8 32 0e 00 00       	call   12ca <wait>
	for(int i=0;i<P;i++){	
     498:	39 fb                	cmp    %edi,%ebx
     49a:	7c f4                	jl     490 <main+0x490>
     49c:	e9 45 ff ff ff       	jmp    3e6 <main+0x3e6>
			N = 4;
     4a1:	be 04 00 00 00       	mov    $0x4,%esi
     4a6:	e9 bb fc ff ff       	jmp    166 <main+0x166>
	int S[P][K];
     4ab:	81 ec c0 00 00 00    	sub    $0xc0,%esp
	K = (2*N)-1;
     4b1:	c7 05 60 1e 00 00 05 	movl   $0x5,0x1e60
     4b8:	00 00 00 
	int S[P][K];
     4bb:	c7 85 48 ff ff ff 14 	movl   $0x14,-0xb8(%ebp)
     4c2:	00 00 00 
     4c5:	89 a5 50 ff ff ff    	mov    %esp,-0xb0(%ebp)
     4cb:	be 03 00 00 00       	mov    $0x3,%esi
	K = (2*N)-1;
     4d0:	c7 85 60 ff ff ff 05 	movl   $0x5,-0xa0(%ebp)
     4d7:	00 00 00 
     4da:	e9 be fc ff ff       	jmp    19d <main+0x19d>
			}else if(i<(P1+P2+P3)){
     4df:	03 85 3c ff ff ff    	add    -0xc4(%ebp),%eax
     4e5:	39 d8                	cmp    %ebx,%eax
     4e7:	0f 8e c4 fe ff ff    	jle    3b1 <main+0x3b1>
				int STemp[K];
     4ed:	8b 15 60 1e 00 00    	mov    0x1e60,%edx
			if(whichP>1){
     4f3:	89 a5 60 ff ff ff    	mov    %esp,-0xa0(%ebp)
				whichP = 3;
     4f9:	c7 85 5c ff ff ff 03 	movl   $0x3,-0xa4(%ebp)
     500:	00 00 00 
				int STemp[K];
     503:	8d 04 95 12 00 00 00 	lea    0x12(,%edx,4),%eax
     50a:	83 e0 f0             	and    $0xfffffff0,%eax
     50d:	29 c4                	sub    %eax,%esp
				for(int qw=0;qw<K;qw++){
     50f:	85 d2                	test   %edx,%edx
				int STemp[K];
     511:	89 e6                	mov    %esp,%esi
				for(int qw=0;qw<K;qw++){
     513:	0f 8f dd fd ff ff    	jg     2f6 <main+0x2f6>
				acquireLockMaekawa(STemp,K,i);
     519:	50                   	push   %eax
     51a:	53                   	push   %ebx
     51b:	52                   	push   %edx
     51c:	56                   	push   %esi
     51d:	e8 de 09 00 00       	call   f00 <acquireLockMaekawa>
     522:	83 c4 10             	add    $0x10,%esp
     525:	e9 16 fe ff ff       	jmp    340 <main+0x340>
	int S[P][K];
     52a:	c7 85 48 ff ff ff 14 	movl   $0x14,-0xb8(%ebp)
     531:	00 00 00 
	for(int x=0;x<P;x++){
     534:	be 03 00 00 00       	mov    $0x3,%esi
	K = (2*N)-1;
     539:	c7 85 60 ff ff ff 05 	movl   $0x5,-0xa0(%ebp)
     540:	00 00 00 
     543:	e9 55 fc ff ff       	jmp    19d <main+0x19d>
				acquireLockMaekawa(STemp,K,i);
     548:	51                   	push   %ecx
     549:	53                   	push   %ebx
     54a:	52                   	push   %edx
     54b:	56                   	push   %esi
     54c:	e8 af 09 00 00       	call   f00 <acquireLockMaekawa>
     551:	83 c4 10             	add    $0x10,%esp
					sleep(2000);
     554:	83 ec 0c             	sub    $0xc,%esp
     557:	68 d0 07 00 00       	push   $0x7d0
     55c:	e8 f1 0d 00 00       	call   1352 <sleep>
     561:	83 c4 10             	add    $0x10,%esp
     564:	e9 d7 fd ff ff       	jmp    340 <main+0x340>
     569:	66 90                	xchg   %ax,%ax
     56b:	66 90                	xchg   %ax,%ax
     56d:	66 90                	xchg   %ax,%ax
     56f:	90                   	nop

00000570 <isEmptyRequestQueue>:
{
     570:	55                   	push   %ebp
     571:	89 e5                	mov    %esp,%ebp
    if(q->size==0)
     573:	8b 45 08             	mov    0x8(%ebp),%eax
}
     576:	5d                   	pop    %ebp
    if(q->size==0)
     577:	8b 00                	mov    (%eax),%eax
     579:	85 c0                	test   %eax,%eax
     57b:	0f 94 c0             	sete   %al
     57e:	0f b6 c0             	movzbl %al,%eax
}
     581:	c3                   	ret    
     582:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000590 <enqueueRequestQueue>:
{ 
     590:	55                   	push   %ebp
     591:	89 e5                	mov    %esp,%ebp
     593:	56                   	push   %esi
     594:	53                   	push   %ebx
     595:	8b 4d 08             	mov    0x8(%ebp),%ecx
    if (q->size==MAXQSize){
     598:	8b 19                	mov    (%ecx),%ebx
     59a:	83 fb 64             	cmp    $0x64,%ebx
     59d:	74 41                	je     5e0 <enqueueRequestQueue+0x50>
    q->data[q->tail] = a; 
     59f:	8b b1 28 03 00 00    	mov    0x328(%ecx),%esi
     5a5:	8b 45 0c             	mov    0xc(%ebp),%eax
    q->size = q->size + 1;
     5a8:	83 c3 01             	add    $0x1,%ebx
    q->data[q->tail] = a; 
     5ab:	8b 55 10             	mov    0x10(%ebp),%edx
     5ae:	89 44 f1 04          	mov    %eax,0x4(%ecx,%esi,8)
     5b2:	89 54 f1 08          	mov    %edx,0x8(%ecx,%esi,8)
    q->tail = (q->tail + 1)%MAXQSize;  
     5b6:	83 c6 01             	add    $0x1,%esi
     5b9:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
     5be:	89 f0                	mov    %esi,%eax
    q->size = q->size + 1;
     5c0:	89 19                	mov    %ebx,(%ecx)
    q->tail = (q->tail + 1)%MAXQSize;  
     5c2:	f7 ea                	imul   %edx
     5c4:	89 f0                	mov    %esi,%eax
     5c6:	c1 f8 1f             	sar    $0x1f,%eax
     5c9:	c1 fa 05             	sar    $0x5,%edx
     5cc:	29 c2                	sub    %eax,%edx
    return 0; 
     5ce:	31 c0                	xor    %eax,%eax
    q->tail = (q->tail + 1)%MAXQSize;  
     5d0:	6b d2 64             	imul   $0x64,%edx,%edx
     5d3:	29 d6                	sub    %edx,%esi
     5d5:	89 b1 28 03 00 00    	mov    %esi,0x328(%ecx)
} 
     5db:	5b                   	pop    %ebx
     5dc:	5e                   	pop    %esi
     5dd:	5d                   	pop    %ebp
     5de:	c3                   	ret    
     5df:	90                   	nop
      return -1;
     5e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     5e5:	eb f4                	jmp    5db <enqueueRequestQueue+0x4b>
     5e7:	89 f6                	mov    %esi,%esi
     5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005f0 <getRequestQueueSize>:
{
     5f0:	55                   	push   %ebp
     5f1:	89 e5                	mov    %esp,%ebp
    return q->size;
     5f3:	8b 45 08             	mov    0x8(%ebp),%eax
}
     5f6:	5d                   	pop    %ebp
    return q->size;
     5f7:	8b 00                	mov    (%eax),%eax
}
     5f9:	c3                   	ret    
     5fa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000600 <dequeueRequestQueue>:
{ 
     600:	55                   	push   %ebp
     601:	89 e5                	mov    %esp,%ebp
     603:	57                   	push   %edi
     604:	56                   	push   %esi
     605:	53                   	push   %ebx
     606:	83 ec 0c             	sub    $0xc,%esp
     609:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     60c:	8b 7d 08             	mov    0x8(%ebp),%edi
    if(q->size==0)
     60f:	8b 33                	mov    (%ebx),%esi
     611:	85 f6                	test   %esi,%esi
     613:	74 4b                	je     660 <dequeueRequestQueue+0x60>
    struct request a = q->data[q->head]; 
     615:	8b 8b 24 03 00 00    	mov    0x324(%ebx),%ecx
    q->size = q->size - 1; 
     61b:	83 ee 01             	sub    $0x1,%esi
    struct request a = q->data[q->head]; 
     61e:	8d 44 cb 04          	lea    0x4(%ebx,%ecx,8),%eax
    q->head = (q->head + 1)%MAXQSize; 
     622:	83 c1 01             	add    $0x1,%ecx
    struct request a = q->data[q->head]; 
     625:	8b 10                	mov    (%eax),%edx
     627:	d9 40 04             	flds   0x4(%eax)
    q->head = (q->head + 1)%MAXQSize; 
     62a:	89 c8                	mov    %ecx,%eax
    q->size = q->size - 1; 
     62c:	89 33                	mov    %esi,(%ebx)
    return a; 
     62e:	d9 5f 04             	fstps  0x4(%edi)
    struct request a = q->data[q->head]; 
     631:	89 17                	mov    %edx,(%edi)
    q->head = (q->head + 1)%MAXQSize; 
     633:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
     638:	f7 ea                	imul   %edx
     63a:	89 c8                	mov    %ecx,%eax
     63c:	c1 f8 1f             	sar    $0x1f,%eax
     63f:	c1 fa 05             	sar    $0x5,%edx
     642:	29 c2                	sub    %eax,%edx
}
     644:	89 f8                	mov    %edi,%eax
    q->head = (q->head + 1)%MAXQSize; 
     646:	6b d2 64             	imul   $0x64,%edx,%edx
     649:	29 d1                	sub    %edx,%ecx
     64b:	89 8b 24 03 00 00    	mov    %ecx,0x324(%ebx)
}
     651:	8d 65 f4             	lea    -0xc(%ebp),%esp
     654:	5b                   	pop    %ebx
     655:	5e                   	pop    %esi
     656:	5f                   	pop    %edi
     657:	5d                   	pop    %ebp
     658:	c2 04 00             	ret    $0x4
     65b:	90                   	nop
     65c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		printf(1,"empty q dequeued\n");
     660:	83 ec 08             	sub    $0x8,%esp
     663:	68 c8 17 00 00       	push   $0x17c8
     668:	6a 01                	push   $0x1
     66a:	e8 01 0e 00 00       	call   1470 <printf>
		return b; 
     66f:	c7 07 00 00 00 00    	movl   $0x0,(%edi)
     675:	c7 47 04 00 00 00 00 	movl   $0x0,0x4(%edi)
     67c:	83 c4 10             	add    $0x10,%esp
}
     67f:	8d 65 f4             	lea    -0xc(%ebp),%esp
     682:	89 f8                	mov    %edi,%eax
     684:	5b                   	pop    %ebx
     685:	5e                   	pop    %esi
     686:	5f                   	pop    %edi
     687:	5d                   	pop    %ebp
     688:	c2 04 00             	ret    $0x4
     68b:	90                   	nop
     68c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000690 <isFullRequestQueue>:
{
     690:	55                   	push   %ebp
     691:	89 e5                	mov    %esp,%ebp
    if(q->size==MAXQSize){
     693:	8b 45 08             	mov    0x8(%ebp),%eax
}
     696:	5d                   	pop    %ebp
    if(q->size==MAXQSize){
     697:	83 38 64             	cmpl   $0x64,(%eax)
     69a:	0f 94 c0             	sete   %al
     69d:	0f b6 c0             	movzbl %al,%eax
}
     6a0:	c3                   	ret    
     6a1:	eb 0d                	jmp    6b0 <removeElementRequestQueue>
     6a3:	90                   	nop
     6a4:	90                   	nop
     6a5:	90                   	nop
     6a6:	90                   	nop
     6a7:	90                   	nop
     6a8:	90                   	nop
     6a9:	90                   	nop
     6aa:	90                   	nop
     6ab:	90                   	nop
     6ac:	90                   	nop
     6ad:	90                   	nop
     6ae:	90                   	nop
     6af:	90                   	nop

000006b0 <removeElementRequestQueue>:
void removeElementRequestQueue(queueRequest* q,int u){
     6b0:	55                   	push   %ebp
     6b1:	89 e5                	mov    %esp,%ebp
     6b3:	57                   	push   %edi
     6b4:	56                   	push   %esi
     6b5:	53                   	push   %ebx
     6b6:	83 ec 1c             	sub    $0x1c,%esp
     6b9:	8b 4d 08             	mov    0x8(%ebp),%ecx
     6bc:	8b 45 0c             	mov    0xc(%ebp),%eax
	if(q->size==0){
     6bf:	8b 11                	mov    (%ecx),%edx
     6c1:	85 d2                	test   %edx,%edx
     6c3:	74 61                	je     726 <removeElementRequestQueue+0x76>
	if(q->size == 1 ){
     6c5:	83 fa 01             	cmp    $0x1,%edx
     6c8:	8b b1 24 03 00 00    	mov    0x324(%ecx),%esi
     6ce:	74 60                	je     730 <removeElementRequestQueue+0x80>
	if(q->head< q->tail){
     6d0:	8b 99 28 03 00 00    	mov    0x328(%ecx),%ebx
     6d6:	39 f3                	cmp    %esi,%ebx
     6d8:	0f 8e 82 00 00 00    	jle    760 <removeElementRequestQueue+0xb0>
		for(int i=u;i<q->tail-1;i++){
     6de:	8d 73 ff             	lea    -0x1(%ebx),%esi
     6e1:	39 f0                	cmp    %esi,%eax
     6e3:	7d 2b                	jge    710 <removeElementRequestQueue+0x60>
     6e5:	8d 44 c1 04          	lea    0x4(%ecx,%eax,8),%eax
     6e9:	8d 5c d9 fc          	lea    -0x4(%ecx,%ebx,8),%ebx
     6ed:	89 d7                	mov    %edx,%edi
     6ef:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
     6f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			q->data[i] = q->data[i+1];
     6f8:	8b 50 08             	mov    0x8(%eax),%edx
     6fb:	8b 48 0c             	mov    0xc(%eax),%ecx
     6fe:	83 c0 08             	add    $0x8,%eax
     701:	89 50 f8             	mov    %edx,-0x8(%eax)
     704:	89 48 fc             	mov    %ecx,-0x4(%eax)
		for(int i=u;i<q->tail-1;i++){
     707:	39 d8                	cmp    %ebx,%eax
     709:	75 ed                	jne    6f8 <removeElementRequestQueue+0x48>
     70b:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
     70e:	89 fa                	mov    %edi,%edx
		q->tail = (q->tail-1);
     710:	83 fe ff             	cmp    $0xffffffff,%esi
     713:	b8 63 00 00 00       	mov    $0x63,%eax
     718:	0f 44 f0             	cmove  %eax,%esi
		q->size -= 1;
     71b:	83 ea 01             	sub    $0x1,%edx
		q->tail = (q->tail-1);
     71e:	89 b1 28 03 00 00    	mov    %esi,0x328(%ecx)
		q->size -= 1;
     724:	89 11                	mov    %edx,(%ecx)
}
     726:	83 c4 1c             	add    $0x1c,%esp
     729:	5b                   	pop    %ebx
     72a:	5e                   	pop    %esi
     72b:	5f                   	pop    %edi
     72c:	5d                   	pop    %ebp
     72d:	c3                   	ret    
     72e:	66 90                	xchg   %ax,%ax
		if(u == q->head){
     730:	39 c6                	cmp    %eax,%esi
     732:	75 f2                	jne    726 <removeElementRequestQueue+0x76>
			q->head = (q->head+1)%MAXQSize;
     734:	83 c6 01             	add    $0x1,%esi
     737:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
			q->size -= 1;
     73c:	c7 01 00 00 00 00    	movl   $0x0,(%ecx)
			q->head = (q->head+1)%MAXQSize;
     742:	89 f0                	mov    %esi,%eax
     744:	f7 ea                	imul   %edx
     746:	89 f0                	mov    %esi,%eax
     748:	c1 f8 1f             	sar    $0x1f,%eax
     74b:	c1 fa 05             	sar    $0x5,%edx
     74e:	29 c2                	sub    %eax,%edx
     750:	6b c2 64             	imul   $0x64,%edx,%eax
     753:	29 c6                	sub    %eax,%esi
     755:	89 b1 24 03 00 00    	mov    %esi,0x324(%ecx)
			return;
     75b:	eb c9                	jmp    726 <removeElementRequestQueue+0x76>
     75d:	8d 76 00             	lea    0x0(%esi),%esi
		printf(1,"Implement this part of the removeElementQueue\n");
     760:	c7 45 0c 00 18 00 00 	movl   $0x1800,0xc(%ebp)
     767:	c7 45 08 01 00 00 00 	movl   $0x1,0x8(%ebp)
}
     76e:	83 c4 1c             	add    $0x1c,%esp
     771:	5b                   	pop    %ebx
     772:	5e                   	pop    %esi
     773:	5f                   	pop    %edi
     774:	5d                   	pop    %ebp
		printf(1,"Implement this part of the removeElementQueue\n");
     775:	e9 f6 0c 00 00       	jmp    1470 <printf>
     77a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000780 <fabsm>:
float fabsm(float a){
     780:	55                   	push   %ebp
     781:	89 e5                	mov    %esp,%ebp
     783:	d9 45 08             	flds   0x8(%ebp)
	if(a<0){
     786:	d9 ee                	fldz   
     788:	df e9                	fucomip %st(1),%st
     78a:	77 04                	ja     790 <fabsm+0x10>
}
     78c:	5d                   	pop    %ebp
     78d:	c3                   	ret    
     78e:	66 90                	xchg   %ax,%ax
		return -1*a;
     790:	d9 e0                	fchs   
}
     792:	5d                   	pop    %ebp
     793:	c3                   	ret    
     794:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     79a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000007a0 <max>:
int max(int a,int b){
     7a0:	55                   	push   %ebp
     7a1:	89 e5                	mov    %esp,%ebp
     7a3:	8b 45 08             	mov    0x8(%ebp),%eax
     7a6:	8b 55 0c             	mov    0xc(%ebp),%edx
}
     7a9:	5d                   	pop    %ebp
     7aa:	39 d0                	cmp    %edx,%eax
     7ac:	0f 4c c2             	cmovl  %edx,%eax
     7af:	c3                   	ret    

000007b0 <min>:
int min(int a,int b){
     7b0:	55                   	push   %ebp
     7b1:	89 e5                	mov    %esp,%ebp
     7b3:	8b 45 08             	mov    0x8(%ebp),%eax
     7b6:	8b 55 0c             	mov    0xc(%ebp),%edx
}
     7b9:	5d                   	pop    %ebp
     7ba:	39 d0                	cmp    %edx,%eax
     7bc:	0f 4f c2             	cmovg  %edx,%eax
     7bf:	c3                   	ret    

000007c0 <sendRequest>:
void sendRequest(int S[],int n){
     7c0:	55                   	push   %ebp
     7c1:	89 e5                	mov    %esp,%ebp
     7c3:	57                   	push   %edi
     7c4:	56                   	push   %esi
     7c5:	53                   	push   %ebx
     7c6:	83 ec 2c             	sub    $0x2c,%esp
	buf[0] = REQUEST;
     7c9:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)
void sendRequest(int S[],int n){
     7d0:	8b 75 0c             	mov    0xc(%ebp),%esi
	buf[1] = getpid();
     7d3:	e8 6a 0b 00 00       	call   1342 <getpid>
     7d8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     7db:	db 45 d4             	fildl  -0x2c(%ebp)
     7de:	d9 5d dc             	fstps  -0x24(%ebp)
	buf[2] = uptime();
     7e1:	e8 74 0b 00 00       	call   135a <uptime>
     7e6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
	for(int l=0;l<n;l++){
     7e9:	85 f6                	test   %esi,%esi
	buf[2] = uptime();
     7eb:	db 45 d4             	fildl  -0x2c(%ebp)
     7ee:	d9 5d e0             	fstps  -0x20(%ebp)
	for(int l=0;l<n;l++){
     7f1:	7e 32                	jle    825 <sendRequest+0x65>
     7f3:	8b 5d 08             	mov    0x8(%ebp),%ebx
     7f6:	8d 3c b3             	lea    (%ebx,%esi,4),%edi
     7f9:	8d 75 d8             	lea    -0x28(%ebp),%esi
     7fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		write(childPipe[S[l]-offset-1][1],buf,sizeof(buf));
     800:	83 ec 04             	sub    $0x4,%esp
     803:	83 c3 04             	add    $0x4,%ebx
     806:	6a 10                	push   $0x10
     808:	56                   	push   %esi
     809:	8b 43 fc             	mov    -0x4(%ebx),%eax
     80c:	2b 05 40 1e 00 00    	sub    0x1e40,%eax
     812:	ff 34 c5 dc 6e 00 00 	pushl  0x6edc(,%eax,8)
     819:	e8 c4 0a 00 00       	call   12e2 <write>
	for(int l=0;l<n;l++){
     81e:	83 c4 10             	add    $0x10,%esp
     821:	39 df                	cmp    %ebx,%edi
     823:	75 db                	jne    800 <sendRequest+0x40>
}
     825:	8d 65 f4             	lea    -0xc(%ebp),%esp
     828:	5b                   	pop    %ebx
     829:	5e                   	pop    %esi
     82a:	5f                   	pop    %edi
     82b:	5d                   	pop    %ebp
     82c:	c3                   	ret    
     82d:	8d 76 00             	lea    0x0(%esi),%esi

00000830 <precedes>:
int precedes(struct request a, struct request b){
     830:	55                   	push   %ebp
		return 1;
     831:	b8 01 00 00 00       	mov    $0x1,%eax
int precedes(struct request a, struct request b){
     836:	89 e5                	mov    %esp,%ebp
     838:	d9 45 0c             	flds   0xc(%ebp)
     83b:	8b 4d 08             	mov    0x8(%ebp),%ecx
     83e:	8b 55 10             	mov    0x10(%ebp),%edx
     841:	d9 45 14             	flds   0x14(%ebp)
	if(a.timeStamp<b.timeStamp){
     844:	db e9                	fucomi %st(1),%st
     846:	77 18                	ja     860 <precedes+0x30>
     848:	d9 c9                	fxch   %st(1)
	if(a.timeStamp == b.timeStamp && a.pid< b.pid){
     84a:	df e9                	fucomip %st(1),%st
     84c:	dd d8                	fstp   %st(0)
     84e:	7a 20                	jp     870 <precedes+0x40>
     850:	75 1e                	jne    870 <precedes+0x40>
     852:	31 c0                	xor    %eax,%eax
     854:	39 d1                	cmp    %edx,%ecx
     856:	0f 9c c0             	setl   %al
     859:	eb 09                	jmp    864 <precedes+0x34>
     85b:	90                   	nop
     85c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     860:	dd d8                	fstp   %st(0)
     862:	dd d8                	fstp   %st(0)
}
     864:	5d                   	pop    %ebp
     865:	c3                   	ret    
     866:	8d 76 00             	lea    0x0(%esi),%esi
     869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
	return 0;
     870:	31 c0                	xor    %eax,%eax
}
     872:	5d                   	pop    %ebp
     873:	c3                   	ret    
     874:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     87a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000880 <recvHandler>:
void recvHandler(float f[],int i){
     880:	55                   	push   %ebp
     881:	89 e5                	mov    %esp,%ebp
     883:	57                   	push   %edi
     884:	56                   	push   %esi
     885:	53                   	push   %ebx
     886:	83 ec 3c             	sub    $0x3c,%esp
     889:	8b 5d 08             	mov    0x8(%ebp),%ebx
	switch ((int)f[0])
     88c:	d9 03                	flds   (%ebx)
     88e:	d9 7d d6             	fnstcw -0x2a(%ebp)
     891:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
     895:	80 cc 0c             	or     $0xc,%ah
     898:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
     89c:	d9 6d d4             	fldcw  -0x2c(%ebp)
     89f:	db 5d d0             	fistpl -0x30(%ebp)
     8a2:	d9 6d d6             	fldcw  -0x2a(%ebp)
     8a5:	8b 4d d0             	mov    -0x30(%ebp),%ecx
     8a8:	83 f9 06             	cmp    $0x6,%ecx
     8ab:	0f 87 f7 03 00 00    	ja     ca8 <recvHandler+0x428>
     8b1:	ff 24 8d bc 18 00 00 	jmp    *0x18bc(,%ecx,4)
     8b8:	90                   	nop
     8b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			FailedBit[i] = 1;
     8c0:	8b 45 0c             	mov    0xc(%ebp),%eax
     8c3:	c7 04 85 c0 6f 00 00 	movl   $0x1,0x6fc0(,%eax,4)
     8ca:	01 00 00 00 
}
     8ce:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8d1:	5b                   	pop    %ebx
     8d2:	5e                   	pop    %esi
     8d3:	5f                   	pop    %edi
     8d4:	5d                   	pop    %ebp
     8d5:	c3                   	ret    
     8d6:	8d 76 00             	lea    0x0(%esi),%esi
     8d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
			completeAndStop += 1;
     8e0:	83 05 48 1e 00 00 01 	addl   $0x1,0x1e48
}
     8e7:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8ea:	5b                   	pop    %ebx
     8eb:	5e                   	pop    %esi
     8ec:	5f                   	pop    %edi
     8ed:	5d                   	pop    %ebp
     8ee:	c3                   	ret    
     8ef:	90                   	nop
			if(processStatus!=1){
     8f0:	a1 c4 6e 00 00       	mov    0x6ec4,%eax
     8f5:	83 f8 01             	cmp    $0x1,%eax
     8f8:	89 45 c4             	mov    %eax,-0x3c(%ebp)
     8fb:	0f 85 2f 05 00 00    	jne    e30 <recvHandler+0x5b0>
    if (q->size==MAXQSize){
     901:	69 7d 0c 2c 03 00 00 	imul   $0x32c,0xc(%ebp),%edi
				req.pid = f[1];
     908:	d9 43 04             	flds   0x4(%ebx)
     90b:	d9 6d d4             	fldcw  -0x2c(%ebp)
     90e:	db 5d c8             	fistpl -0x38(%ebp)
     911:	d9 6d d6             	fldcw  -0x2a(%ebp)
    if (q->size==MAXQSize){
     914:	8b 87 80 1e 00 00    	mov    0x1e80(%edi),%eax
				req.timeStamp = f[2];
     91a:	d9 43 08             	flds   0x8(%ebx)
    if (q->size==MAXQSize){
     91d:	83 f8 64             	cmp    $0x64,%eax
     920:	89 45 cc             	mov    %eax,-0x34(%ebp)
     923:	0f 84 8f 05 00 00    	je     eb8 <recvHandler+0x638>
    q->data[q->tail] = a; 
     929:	8b b7 a8 21 00 00    	mov    0x21a8(%edi),%esi
     92f:	8d 57 04             	lea    0x4(%edi),%edx
    q->size = q->size + 1;
     932:	83 45 cc 01          	addl   $0x1,-0x34(%ebp)
    q->data[q->tail] = a; 
     936:	89 55 c0             	mov    %edx,-0x40(%ebp)
     939:	8d 04 f2             	lea    (%edx,%esi,8),%eax
     93c:	8b 55 c8             	mov    -0x38(%ebp),%edx
    q->tail = (q->tail + 1)%MAXQSize;  
     93f:	83 c6 01             	add    $0x1,%esi
    q->data[q->tail] = a; 
     942:	d9 90 84 1e 00 00    	fsts   0x1e84(%eax)
     948:	89 90 80 1e 00 00    	mov    %edx,0x1e80(%eax)
    q->tail = (q->tail + 1)%MAXQSize;  
     94e:	89 f0                	mov    %esi,%eax
     950:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
     955:	f7 ea                	imul   %edx
     957:	89 f0                	mov    %esi,%eax
     959:	c1 f8 1f             	sar    $0x1f,%eax
     95c:	c1 fa 05             	sar    $0x5,%edx
     95f:	29 c2                	sub    %eax,%edx
     961:	6b c2 64             	imul   $0x64,%edx,%eax
     964:	29 c6                	sub    %eax,%esi
    q->size = q->size + 1;
     966:	8b 45 cc             	mov    -0x34(%ebp),%eax
    q->tail = (q->tail + 1)%MAXQSize;  
     969:	89 b7 a8 21 00 00    	mov    %esi,0x21a8(%edi)
				for(int u=0;u<getRequestQueueSize(&wait_queue[i]);u++){
     96f:	85 c0                	test   %eax,%eax
    q->size = q->size + 1;
     971:	89 87 80 1e 00 00    	mov    %eax,0x1e80(%edi)
				for(int u=0;u<getRequestQueueSize(&wait_queue[i]);u++){
     977:	0f 8e 76 05 00 00    	jle    ef3 <recvHandler+0x673>
     97d:	8b 45 c0             	mov    -0x40(%ebp),%eax
     980:	d9 80 84 1e 00 00    	flds   0x1e84(%eax)
     986:	d9 c9                	fxch   %st(1)
     988:	8b b0 80 1e 00 00    	mov    0x1e80(%eax),%esi
	if(a.timeStamp<b.timeStamp){
     98e:	db e9                	fucomi %st(1),%st
     990:	dd d9                	fstp   %st(1)
     992:	77 5e                	ja     9f2 <recvHandler+0x172>
	if(a.timeStamp == b.timeStamp && a.pid< b.pid){
     994:	0f 9b c0             	setnp  %al
     997:	ba 00 00 00 00       	mov    $0x0,%edx
     99c:	0f 45 c2             	cmovne %edx,%eax
     99f:	84 c0                	test   %al,%al
     9a1:	74 05                	je     9a8 <recvHandler+0x128>
     9a3:	39 75 c8             	cmp    %esi,-0x38(%ebp)
     9a6:	7f 4a                	jg     9f2 <recvHandler+0x172>
     9a8:	8d 87 8c 1e 00 00    	lea    0x1e8c(%edi),%eax
     9ae:	89 ce                	mov    %ecx,%esi
     9b0:	89 4d c0             	mov    %ecx,-0x40(%ebp)
     9b3:	90                   	nop
     9b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
				for(int u=0;u<getRequestQueueSize(&wait_queue[i]);u++){
     9b8:	83 c6 01             	add    $0x1,%esi
     9bb:	39 75 cc             	cmp    %esi,-0x34(%ebp)
     9be:	0f 8e 2c 05 00 00    	jle    ef0 <recvHandler+0x670>
     9c4:	d9 40 04             	flds   0x4(%eax)
     9c7:	d9 c9                	fxch   %st(1)
     9c9:	8b 38                	mov    (%eax),%edi
	if(a.timeStamp<b.timeStamp){
     9cb:	db e9                	fucomi %st(1),%st
     9cd:	77 21                	ja     9f0 <recvHandler+0x170>
     9cf:	83 c0 08             	add    $0x8,%eax
	if(a.timeStamp == b.timeStamp && a.pid< b.pid){
     9d2:	b9 00 00 00 00       	mov    $0x0,%ecx
     9d7:	db e9                	fucomi %st(1),%st
     9d9:	dd d9                	fstp   %st(1)
     9db:	0f 9b c2             	setnp  %dl
     9de:	0f 45 d1             	cmovne %ecx,%edx
     9e1:	84 d2                	test   %dl,%dl
     9e3:	74 d3                	je     9b8 <recvHandler+0x138>
     9e5:	39 7d c8             	cmp    %edi,-0x38(%ebp)
     9e8:	7e ce                	jle    9b8 <recvHandler+0x138>
     9ea:	eb 06                	jmp    9f2 <recvHandler+0x172>
     9ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     9f0:	dd d9                	fstp   %st(1)
     9f2:	d9 05 b4 70 00 00    	flds   0x70b4
     9f8:	d9 c9                	fxch   %st(1)
	if(a.timeStamp<b.timeStamp){
     9fa:	db e9                	fucomi %st(1),%st
     9fc:	0f 87 c6 04 00 00    	ja     ec8 <recvHandler+0x648>
	if(a.timeStamp == b.timeStamp && a.pid< b.pid){
     a02:	8b 45 c8             	mov    -0x38(%ebp),%eax
     a05:	3b 05 b0 70 00 00    	cmp    0x70b0,%eax
     a0b:	7e 23                	jle    a30 <recvHandler+0x1b0>
     a0d:	df e9                	fucomip %st(1),%st
     a0f:	dd d8                	fstp   %st(0)
     a11:	ba 00 00 00 00       	mov    $0x0,%edx
     a16:	0f 9b c0             	setnp  %al
     a19:	0f 45 c2             	cmovne %edx,%eax
     a1c:	84 c0                	test   %al,%al
     a1e:	0f 85 a8 04 00 00    	jne    ecc <recvHandler+0x64c>
     a24:	eb 0e                	jmp    a34 <recvHandler+0x1b4>
     a26:	8d 76 00             	lea    0x0(%esi),%esi
     a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     a30:	dd d8                	fstp   %st(0)
     a32:	dd d8                	fstp   %st(0)
				if(failedflag == 1){
     a34:	83 7d c4 01          	cmpl   $0x1,-0x3c(%ebp)
     a38:	0f 84 8e 04 00 00    	je     ecc <recvHandler+0x64c>
					buf[0] = INQUIRE;
     a3e:	c7 45 d8 00 00 00 40 	movl   $0x40000000,-0x28(%ebp)
					buf[1] = getpid();
     a45:	e8 f8 08 00 00       	call   1342 <getpid>
     a4a:	89 45 cc             	mov    %eax,-0x34(%ebp)
					if(pendingInquire[i] == 0 ){
     a4d:	8b 45 0c             	mov    0xc(%ebp),%eax
					buf[1] = getpid();
     a50:	db 45 cc             	fildl  -0x34(%ebp)
					if(pendingInquire[i] == 0 ){
     a53:	8b 04 85 60 6e 00 00 	mov    0x6e60(,%eax,4),%eax
					buf[1] = getpid();
     a5a:	d9 5d dc             	fstps  -0x24(%ebp)
					if(pendingInquire[i] == 0 ){
     a5d:	85 c0                	test   %eax,%eax
     a5f:	0f 85 69 fe ff ff    	jne    8ce <recvHandler+0x4e>
						write(childPipe[(int)currentLockingRequest.pid - offset - 1][1],buf,sizeof(buf));
     a65:	8d 45 d8             	lea    -0x28(%ebp),%eax
     a68:	83 ec 04             	sub    $0x4,%esp
     a6b:	6a 10                	push   $0x10
     a6d:	50                   	push   %eax
     a6e:	a1 b0 70 00 00       	mov    0x70b0,%eax
     a73:	2b 05 40 1e 00 00    	sub    0x1e40,%eax
     a79:	ff 34 c5 dc 6e 00 00 	pushl  0x6edc(,%eax,8)
     a80:	e8 5d 08 00 00       	call   12e2 <write>
     a85:	83 c4 10             	add    $0x10,%esp
     a88:	e9 41 fe ff ff       	jmp    8ce <recvHandler+0x4e>
     a8d:	8d 76 00             	lea    0x0(%esi),%esi
			lockedCount += 1;
     a90:	83 05 ac 70 00 00 01 	addl   $0x1,0x70ac
}
     a97:	8d 65 f4             	lea    -0xc(%ebp),%esp
     a9a:	5b                   	pop    %ebx
     a9b:	5e                   	pop    %esi
     a9c:	5f                   	pop    %edi
     a9d:	5d                   	pop    %ebp
     a9e:	c3                   	ret    
     a9f:	90                   	nop
			if(wait_queue[i].size == 0){
     aa0:	69 4d 0c 2c 03 00 00 	imul   $0x32c,0xc(%ebp),%ecx
     aa7:	8d 81 80 1e 00 00    	lea    0x1e80(%ecx),%eax
     aad:	89 45 c0             	mov    %eax,-0x40(%ebp)
     ab0:	8b 81 80 1e 00 00    	mov    0x1e80(%ecx),%eax
     ab6:	85 c0                	test   %eax,%eax
     ab8:	89 45 c8             	mov    %eax,-0x38(%ebp)
     abb:	0f 84 47 03 00 00    	je     e08 <recvHandler+0x588>
				int newRindex = wait_queue[i].head;
     ac1:	8b 91 a4 21 00 00    	mov    0x21a4(%ecx),%edx
				while(count!=wait_queue[i].size){
     ac7:	83 7d c8 01          	cmpl   $0x1,-0x38(%ebp)
				newR = wait_queue[i].data[ptr];
     acb:	8d 44 d1 04          	lea    0x4(%ecx,%edx,8),%eax
				int newRindex = wait_queue[i].head;
     acf:	89 55 cc             	mov    %edx,-0x34(%ebp)
				newR = wait_queue[i].data[ptr];
     ad2:	8b b8 80 1e 00 00    	mov    0x1e80(%eax),%edi
     ad8:	d9 80 84 1e 00 00    	flds   0x1e84(%eax)
				while(count!=wait_queue[i].size){
     ade:	0f 84 bc 02 00 00    	je     da0 <recvHandler+0x520>
				int count =1;
     ae4:	be 01 00 00 00       	mov    $0x1,%esi
	if(a.timeStamp == b.timeStamp && a.pid< b.pid){
     ae9:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
     aec:	eb 46                	jmp    b34 <recvHandler+0x2b4>
     aee:	66 90                	xchg   %ax,%ax
     af0:	db e9                	fucomi %st(1),%st
     af2:	b9 00 00 00 00       	mov    $0x0,%ecx
     af7:	0f 9b c0             	setnp  %al
     afa:	0f 45 c1             	cmovne %ecx,%eax
     afd:	84 c0                	test   %al,%al
     aff:	74 1f                	je     b20 <recvHandler+0x2a0>
     b01:	39 fb                	cmp    %edi,%ebx
     b03:	0f 9c c0             	setl   %al
						newR = wait_queue[i].data[ptr];
     b06:	84 c0                	test   %al,%al
     b08:	8b 45 cc             	mov    -0x34(%ebp),%eax
     b0b:	db c9                	fcmovne %st(1),%st
     b0d:	dd d9                	fstp   %st(1)
     b0f:	0f 45 fb             	cmovne %ebx,%edi
     b12:	0f 45 c2             	cmovne %edx,%eax
     b15:	89 45 cc             	mov    %eax,-0x34(%ebp)
     b18:	eb 0e                	jmp    b28 <recvHandler+0x2a8>
     b1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b20:	dd d9                	fstp   %st(1)
     b22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
					count++;
     b28:	83 c6 01             	add    $0x1,%esi
				while(count!=wait_queue[i].size){
     b2b:	39 75 c8             	cmp    %esi,-0x38(%ebp)
     b2e:	0f 84 6c 02 00 00    	je     da0 <recvHandler+0x520>
					ptr = (ptr+1)%MAXQSize;
     b34:	8d 5a 01             	lea    0x1(%edx),%ebx
     b37:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
     b3c:	f7 eb                	imul   %ebx
     b3e:	89 d8                	mov    %ebx,%eax
     b40:	c1 f8 1f             	sar    $0x1f,%eax
     b43:	c1 fa 05             	sar    $0x5,%edx
     b46:	29 c2                	sub    %eax,%edx
     b48:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     b4b:	6b d2 64             	imul   $0x64,%edx,%edx
     b4e:	29 d3                	sub    %edx,%ebx
     b50:	8d 44 d8 04          	lea    0x4(%eax,%ebx,8),%eax
     b54:	89 da                	mov    %ebx,%edx
     b56:	d9 80 84 1e 00 00    	flds   0x1e84(%eax)
     b5c:	d9 c9                	fxch   %st(1)
     b5e:	8b 98 80 1e 00 00    	mov    0x1e80(%eax),%ebx
	if(a.timeStamp<b.timeStamp){
     b64:	db e9                	fucomi %st(1),%st
     b66:	76 88                	jbe    af0 <recvHandler+0x270>
     b68:	dd d8                	fstp   %st(0)
     b6a:	89 df                	mov    %ebx,%edi
						newRindex = ptr;
     b6c:	89 55 cc             	mov    %edx,-0x34(%ebp)
     b6f:	eb b7                	jmp    b28 <recvHandler+0x2a8>
     b71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			int ptr= wait_queue[i].head;
     b78:	69 45 0c 2c 03 00 00 	imul   $0x32c,0xc(%ebp),%eax
			newRequest = currentLockingRequest;
     b7f:	8b 3d b0 70 00 00    	mov    0x70b0,%edi
     b85:	d9 05 b4 70 00 00    	flds   0x70b4
			int ptr= wait_queue[i].head;
     b8b:	8d b0 80 1e 00 00    	lea    0x1e80(%eax),%esi
     b91:	89 45 bc             	mov    %eax,-0x44(%ebp)
     b94:	8b 90 a4 21 00 00    	mov    0x21a4(%eax),%edx
     b9a:	89 75 c0             	mov    %esi,-0x40(%ebp)
			while(count!=wait_queue[i].size){
     b9d:	8b b0 80 1e 00 00    	mov    0x1e80(%eax),%esi
     ba3:	85 f6                	test   %esi,%esi
     ba5:	89 75 c8             	mov    %esi,-0x38(%ebp)
     ba8:	0f 84 1a 01 00 00    	je     cc8 <recvHandler+0x448>
			int count =0;
     bae:	31 db                	xor    %ebx,%ebx
     bb0:	83 c0 04             	add    $0x4,%eax
			int newRindex = -1;
     bb3:	be ff ff ff ff       	mov    $0xffffffff,%esi
     bb8:	89 45 c4             	mov    %eax,-0x3c(%ebp)
				ptr = (ptr+1)%MAXQSize;
     bbb:	89 5d cc             	mov    %ebx,-0x34(%ebp)
     bbe:	eb 55                	jmp    c15 <recvHandler+0x395>
	if(a.timeStamp == b.timeStamp && a.pid< b.pid){
     bc0:	39 f9                	cmp    %edi,%ecx
     bc2:	7d 1c                	jge    be0 <recvHandler+0x360>
     bc4:	db e9                	fucomi %st(1),%st
     bc6:	bb 00 00 00 00       	mov    $0x0,%ebx
     bcb:	0f 9b c0             	setnp  %al
     bce:	0f 45 c3             	cmovne %ebx,%eax
					newRequest = wait_queue[i].data[ptr];
     bd1:	84 c0                	test   %al,%al
     bd3:	db c9                	fcmovne %st(1),%st
     bd5:	dd d9                	fstp   %st(1)
     bd7:	0f 45 f9             	cmovne %ecx,%edi
     bda:	0f 45 f2             	cmovne %edx,%esi
     bdd:	eb 09                	jmp    be8 <recvHandler+0x368>
     bdf:	90                   	nop
     be0:	dd d9                	fstp   %st(1)
     be2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				ptr = (ptr+1)%MAXQSize;
     be8:	8d 4a 01             	lea    0x1(%edx),%ecx
     beb:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
				count++;
     bf0:	83 45 cc 01          	addl   $0x1,-0x34(%ebp)
			while(count!=wait_queue[i].size){
     bf4:	8b 5d c8             	mov    -0x38(%ebp),%ebx
				ptr = (ptr+1)%MAXQSize;
     bf7:	f7 e9                	imul   %ecx
     bf9:	89 c8                	mov    %ecx,%eax
     bfb:	c1 f8 1f             	sar    $0x1f,%eax
     bfe:	c1 fa 05             	sar    $0x5,%edx
     c01:	29 c2                	sub    %eax,%edx
				count++;
     c03:	8b 45 cc             	mov    -0x34(%ebp),%eax
				ptr = (ptr+1)%MAXQSize;
     c06:	6b d2 64             	imul   $0x64,%edx,%edx
     c09:	29 d1                	sub    %edx,%ecx
			while(count!=wait_queue[i].size){
     c0b:	39 d8                	cmp    %ebx,%eax
				ptr = (ptr+1)%MAXQSize;
     c0d:	89 ca                	mov    %ecx,%edx
			while(count!=wait_queue[i].size){
     c0f:	0f 84 bb 00 00 00    	je     cd0 <recvHandler+0x450>
     c15:	8b 45 c4             	mov    -0x3c(%ebp),%eax
     c18:	8d 04 d0             	lea    (%eax,%edx,8),%eax
     c1b:	d9 80 84 1e 00 00    	flds   0x1e84(%eax)
     c21:	d9 c9                	fxch   %st(1)
     c23:	8b 88 80 1e 00 00    	mov    0x1e80(%eax),%ecx
	if(a.timeStamp<b.timeStamp){
     c29:	db e9                	fucomi %st(1),%st
     c2b:	76 93                	jbe    bc0 <recvHandler+0x340>
     c2d:	dd d8                	fstp   %st(0)
     c2f:	89 cf                	mov    %ecx,%edi
     c31:	89 d6                	mov    %edx,%esi
     c33:	eb b3                	jmp    be8 <recvHandler+0x368>
     c35:	8d 76 00             	lea    0x0(%esi),%esi
			if(FailedBit[i] == 1){
     c38:	8b 45 0c             	mov    0xc(%ebp),%eax
     c3b:	83 3c 85 c0 6f 00 00 	cmpl   $0x1,0x6fc0(,%eax,4)
     c42:	01 
     c43:	0f 85 85 fc ff ff    	jne    8ce <recvHandler+0x4e>
				buf[0] = RELINQUISH;
     c49:	c7 45 d8 00 00 80 40 	movl   $0x40800000,-0x28(%ebp)
				buf[1] = getpid();
     c50:	e8 ed 06 00 00       	call   1342 <getpid>
     c55:	89 45 cc             	mov    %eax,-0x34(%ebp)
				lockedCount -= 1;
     c58:	83 2d ac 70 00 00 01 	subl   $0x1,0x70ac
				buf[1] = getpid();
     c5f:	db 45 cc             	fildl  -0x34(%ebp)
     c62:	d9 5d dc             	fstps  -0x24(%ebp)
				write(childPipe[(int)f[1] - offset -1][1], buf, sizeof(buf));
     c65:	8d 45 d8             	lea    -0x28(%ebp),%eax
     c68:	83 ec 04             	sub    $0x4,%esp
     c6b:	6a 10                	push   $0x10
     c6d:	50                   	push   %eax
     c6e:	d9 43 04             	flds   0x4(%ebx)
     c71:	d9 7d d6             	fnstcw -0x2a(%ebp)
     c74:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
     c78:	80 cc 0c             	or     $0xc,%ah
     c7b:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
     c7f:	d9 6d d4             	fldcw  -0x2c(%ebp)
     c82:	db 5d d0             	fistpl -0x30(%ebp)
     c85:	d9 6d d6             	fldcw  -0x2a(%ebp)
     c88:	8b 45 d0             	mov    -0x30(%ebp),%eax
     c8b:	2b 05 40 1e 00 00    	sub    0x1e40,%eax
     c91:	ff 34 c5 dc 6e 00 00 	pushl  0x6edc(,%eax,8)
     c98:	e8 45 06 00 00       	call   12e2 <write>
     c9d:	83 c4 10             	add    $0x10,%esp
     ca0:	e9 29 fc ff ff       	jmp    8ce <recvHandler+0x4e>
     ca5:	8d 76 00             	lea    0x0(%esi),%esi
			printf(1,"Message Received is of type %d \n",(int)f[0]);
     ca8:	83 ec 04             	sub    $0x4,%esp
     cab:	51                   	push   %ecx
     cac:	68 30 18 00 00       	push   $0x1830
     cb1:	6a 01                	push   $0x1
     cb3:	e8 b8 07 00 00       	call   1470 <printf>
			break;
     cb8:	83 c4 10             	add    $0x10,%esp
}
     cbb:	8d 65 f4             	lea    -0xc(%ebp),%esp
     cbe:	5b                   	pop    %ebx
     cbf:	5e                   	pop    %esi
     cc0:	5f                   	pop    %edi
     cc1:	5d                   	pop    %ebp
     cc2:	c3                   	ret    
     cc3:	90                   	nop
     cc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			int newRindex = -1;
     cc8:	be ff ff ff ff       	mov    $0xffffffff,%esi
     ccd:	8d 76 00             	lea    0x0(%esi),%esi
			removeElementRequestQueue(&wait_queue[i],newRindex);//removes newRindex th element from queue
     cd0:	83 ec 08             	sub    $0x8,%esp
     cd3:	d9 5d cc             	fstps  -0x34(%ebp)
     cd6:	56                   	push   %esi
     cd7:	ff 75 c0             	pushl  -0x40(%ebp)
     cda:	e8 d1 f9 ff ff       	call   6b0 <removeElementRequestQueue>
    if (q->size==MAXQSize){
     cdf:	69 4d 0c 2c 03 00 00 	imul   $0x32c,0xc(%ebp),%ecx
     ce6:	83 c4 10             	add    $0x10,%esp
     ce9:	d9 45 cc             	flds   -0x34(%ebp)
     cec:	8b 81 80 1e 00 00    	mov    0x1e80(%ecx),%eax
     cf2:	83 f8 64             	cmp    $0x64,%eax
     cf5:	89 45 c8             	mov    %eax,-0x38(%ebp)
     cf8:	74 52                	je     d4c <recvHandler+0x4cc>
    q->data[q->tail] = a; 
     cfa:	8b 99 a8 21 00 00    	mov    0x21a8(%ecx),%ebx
     d00:	8b 55 bc             	mov    -0x44(%ebp),%edx
     d03:	d9 05 b4 70 00 00    	flds   0x70b4
    q->size = q->size + 1;
     d09:	8b 75 c8             	mov    -0x38(%ebp),%esi
    q->data[q->tail] = a; 
     d0c:	8d 44 da 04          	lea    0x4(%edx,%ebx,8),%eax
     d10:	8b 15 b0 70 00 00    	mov    0x70b0,%edx
    q->tail = (q->tail + 1)%MAXQSize;  
     d16:	83 c3 01             	add    $0x1,%ebx
    q->size = q->size + 1;
     d19:	83 c6 01             	add    $0x1,%esi
    q->data[q->tail] = a; 
     d1c:	d9 98 84 1e 00 00    	fstps  0x1e84(%eax)
     d22:	89 90 80 1e 00 00    	mov    %edx,0x1e80(%eax)
    q->tail = (q->tail + 1)%MAXQSize;  
     d28:	89 d8                	mov    %ebx,%eax
     d2a:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
     d2f:	f7 ea                	imul   %edx
     d31:	89 d8                	mov    %ebx,%eax
    q->size = q->size + 1;
     d33:	89 b1 80 1e 00 00    	mov    %esi,0x1e80(%ecx)
    q->tail = (q->tail + 1)%MAXQSize;  
     d39:	c1 f8 1f             	sar    $0x1f,%eax
     d3c:	c1 fa 05             	sar    $0x5,%edx
     d3f:	29 c2                	sub    %eax,%edx
     d41:	6b d2 64             	imul   $0x64,%edx,%edx
     d44:	29 d3                	sub    %edx,%ebx
     d46:	89 99 a8 21 00 00    	mov    %ebx,0x21a8(%ecx)
			currentLockingRequest = newRequest;//setting new locking request
     d4c:	d9 1d b4 70 00 00    	fstps  0x70b4
     d52:	89 3d b0 70 00 00    	mov    %edi,0x70b0
			buf[0] = LOCKED;
     d58:	c7 45 d8 00 00 80 3f 	movl   $0x3f800000,-0x28(%ebp)
			processStatus = 1;
     d5f:	c7 05 c4 6e 00 00 01 	movl   $0x1,0x6ec4
     d66:	00 00 00 
			buf[1] = getpid();
     d69:	e8 d4 05 00 00       	call   1342 <getpid>
     d6e:	89 45 cc             	mov    %eax,-0x34(%ebp)
			write(childPipe[(int)newRequest.pid - offset -1 ][1],buf,sizeof(buf));
     d71:	8d 45 d8             	lea    -0x28(%ebp),%eax
     d74:	83 ec 04             	sub    $0x4,%esp
     d77:	6a 10                	push   $0x10
			buf[1] = getpid();
     d79:	db 45 cc             	fildl  -0x34(%ebp)
			write(childPipe[(int)newRequest.pid - offset -1 ][1],buf,sizeof(buf));
     d7c:	50                   	push   %eax
     d7d:	89 f8                	mov    %edi,%eax
     d7f:	2b 05 40 1e 00 00    	sub    0x1e40,%eax
			buf[1] = getpid();
     d85:	d9 5d dc             	fstps  -0x24(%ebp)
			write(childPipe[(int)newRequest.pid - offset -1 ][1],buf,sizeof(buf));
     d88:	ff 34 c5 dc 6e 00 00 	pushl  0x6edc(,%eax,8)
     d8f:	e8 4e 05 00 00       	call   12e2 <write>
     d94:	83 c4 10             	add    $0x10,%esp
}
     d97:	8d 65 f4             	lea    -0xc(%ebp),%esp
     d9a:	5b                   	pop    %ebx
     d9b:	5e                   	pop    %esi
     d9c:	5f                   	pop    %edi
     d9d:	5d                   	pop    %ebp
     d9e:	c3                   	ret    
     d9f:	90                   	nop
				removeElementRequestQueue(&wait_queue[i],newRindex);
     da0:	83 ec 08             	sub    $0x8,%esp
     da3:	d9 5d c8             	fstps  -0x38(%ebp)
     da6:	ff 75 cc             	pushl  -0x34(%ebp)
     da9:	ff 75 c0             	pushl  -0x40(%ebp)
     dac:	e8 ff f8 ff ff       	call   6b0 <removeElementRequestQueue>
				currentLockingRequest = newR;
     db1:	d9 45 c8             	flds   -0x38(%ebp)
     db4:	89 3d b0 70 00 00    	mov    %edi,0x70b0
				buf[0] = LOCKED;
     dba:	c7 45 d8 00 00 80 3f 	movl   $0x3f800000,-0x28(%ebp)
				currentLockingRequest = newR;
     dc1:	d9 1d b4 70 00 00    	fstps  0x70b4
				buf[1] = getpid();
     dc7:	e8 76 05 00 00       	call   1342 <getpid>
				write(childPipe[(int)newR.pid - offset -1 ][1],buf,sizeof(buf));
     dcc:	2b 3d 40 1e 00 00    	sub    0x1e40,%edi
     dd2:	83 c4 0c             	add    $0xc,%esp
				buf[1] = getpid();
     dd5:	89 45 cc             	mov    %eax,-0x34(%ebp)
				write(childPipe[(int)newR.pid - offset -1 ][1],buf,sizeof(buf));
     dd8:	8d 45 d8             	lea    -0x28(%ebp),%eax
     ddb:	6a 10                	push   $0x10
				buf[1] = getpid();
     ddd:	db 45 cc             	fildl  -0x34(%ebp)
				write(childPipe[(int)newR.pid - offset -1 ][1],buf,sizeof(buf));
     de0:	50                   	push   %eax
     de1:	ff 34 fd dc 6e 00 00 	pushl  0x6edc(,%edi,8)
				buf[1] = getpid();
     de8:	d9 5d dc             	fstps  -0x24(%ebp)
				write(childPipe[(int)newR.pid - offset -1 ][1],buf,sizeof(buf));
     deb:	e8 f2 04 00 00       	call   12e2 <write>
				processStatus = 1;
     df0:	c7 05 c4 6e 00 00 01 	movl   $0x1,0x6ec4
     df7:	00 00 00 
     dfa:	83 c4 10             	add    $0x10,%esp
     dfd:	e9 cc fa ff ff       	jmp    8ce <recvHandler+0x4e>
     e02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				processStatus = 0;//unlocked
     e08:	c7 05 c4 6e 00 00 00 	movl   $0x0,0x6ec4
     e0f:	00 00 00 
				currentLockingRequest = temp;
     e12:	c7 05 b0 70 00 00 ff 	movl   $0xffffffff,0x70b0
     e19:	ff ff ff 
     e1c:	c7 05 b4 70 00 00 00 	movl   $0xbf800000,0x70b4
     e23:	00 80 bf 
     e26:	e9 a3 fa ff ff       	jmp    8ce <recvHandler+0x4e>
     e2b:	90                   	nop
     e2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
				processStatus = 1;
     e30:	c7 05 c4 6e 00 00 01 	movl   $0x1,0x6ec4
     e37:	00 00 00 
				buf[0] = LOCKED;
     e3a:	c7 45 d8 00 00 80 3f 	movl   $0x3f800000,-0x28(%ebp)
				buf[1] = getpid();
     e41:	e8 fc 04 00 00       	call   1342 <getpid>
     e46:	89 45 cc             	mov    %eax,-0x34(%ebp)
				write(childPipe[(int)f[1] - offset - 1][1],buf,sizeof(buf));
     e49:	8d 45 d8             	lea    -0x28(%ebp),%eax
     e4c:	83 ec 04             	sub    $0x4,%esp
				buf[1] = getpid();
     e4f:	db 45 cc             	fildl  -0x34(%ebp)
				write(childPipe[(int)f[1] - offset - 1][1],buf,sizeof(buf));
     e52:	6a 10                	push   $0x10
     e54:	50                   	push   %eax
				buf[1] = getpid();
     e55:	d9 5d dc             	fstps  -0x24(%ebp)
				write(childPipe[(int)f[1] - offset - 1][1],buf,sizeof(buf));
     e58:	d9 43 04             	flds   0x4(%ebx)
     e5b:	d9 7d d6             	fnstcw -0x2a(%ebp)
     e5e:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
     e62:	80 cc 0c             	or     $0xc,%ah
     e65:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
     e69:	d9 6d d4             	fldcw  -0x2c(%ebp)
     e6c:	db 5d d0             	fistpl -0x30(%ebp)
     e6f:	d9 6d d6             	fldcw  -0x2a(%ebp)
     e72:	8b 45 d0             	mov    -0x30(%ebp),%eax
     e75:	2b 05 40 1e 00 00    	sub    0x1e40,%eax
     e7b:	ff 34 c5 dc 6e 00 00 	pushl  0x6edc(,%eax,8)
     e82:	e8 5b 04 00 00       	call   12e2 <write>
				currentLockingRequest.pid = f[1];
     e87:	d9 43 04             	flds   0x4(%ebx)
     e8a:	d9 7d d6             	fnstcw -0x2a(%ebp)
     e8d:	0f b7 45 d6          	movzwl -0x2a(%ebp),%eax
     e91:	83 c4 10             	add    $0x10,%esp
     e94:	80 cc 0c             	or     $0xc,%ah
     e97:	66 89 45 d4          	mov    %ax,-0x2c(%ebp)
     e9b:	d9 6d d4             	fldcw  -0x2c(%ebp)
     e9e:	db 1d b0 70 00 00    	fistpl 0x70b0
     ea4:	d9 6d d6             	fldcw  -0x2a(%ebp)
				currentLockingRequest.timeStamp = f[2];
     ea7:	d9 43 08             	flds   0x8(%ebx)
     eaa:	d9 1d b4 70 00 00    	fstps  0x70b4
     eb0:	e9 19 fa ff ff       	jmp    8ce <recvHandler+0x4e>
     eb5:	8d 76 00             	lea    0x0(%esi),%esi
     eb8:	8d 47 04             	lea    0x4(%edi),%eax
     ebb:	89 45 c0             	mov    %eax,-0x40(%ebp)
     ebe:	e9 ba fa ff ff       	jmp    97d <recvHandler+0xfd>
     ec3:	90                   	nop
     ec4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ec8:	dd d8                	fstp   %st(0)
     eca:	dd d8                	fstp   %st(0)
					buf[0] = FAILED;
     ecc:	c7 45 d8 00 00 a0 40 	movl   $0x40a00000,-0x28(%ebp)
					buf[1] = getpid();
     ed3:	e8 6a 04 00 00       	call   1342 <getpid>
     ed8:	89 45 cc             	mov    %eax,-0x34(%ebp)
     edb:	db 45 cc             	fildl  -0x34(%ebp)
     ede:	d9 5d dc             	fstps  -0x24(%ebp)
     ee1:	e9 7f fd ff ff       	jmp    c65 <recvHandler+0x3e5>
     ee6:	8d 76 00             	lea    0x0(%esi),%esi
     ee9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     ef0:	8b 4d c0             	mov    -0x40(%ebp),%ecx
				int failedflag = 0;
     ef3:	89 4d c4             	mov    %ecx,-0x3c(%ebp)
     ef6:	e9 f7 fa ff ff       	jmp    9f2 <recvHandler+0x172>
     efb:	90                   	nop
     efc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000f00 <acquireLockMaekawa>:
void acquireLockMaekawa(int S[],int n,int i){
     f00:	55                   	push   %ebp
     f01:	89 e5                	mov    %esp,%ebp
     f03:	56                   	push   %esi
     f04:	53                   	push   %ebx
     f05:	83 ec 18             	sub    $0x18,%esp
	sendRequest(S,n);
     f08:	ff 75 0c             	pushl  0xc(%ebp)
     f0b:	ff 75 08             	pushl  0x8(%ebp)
void acquireLockMaekawa(int S[],int n,int i){
     f0e:	8b 75 10             	mov    0x10(%ebp),%esi
	lockedCount = 0;
     f11:	c7 05 ac 70 00 00 00 	movl   $0x0,0x70ac
     f18:	00 00 00 
	sendRequest(S,n);
     f1b:	e8 a0 f8 ff ff       	call   7c0 <sendRequest>
	while(lockedCount<K){
     f20:	a1 60 1e 00 00       	mov    0x1e60,%eax
     f25:	83 c4 10             	add    $0x10,%esp
     f28:	39 05 ac 70 00 00    	cmp    %eax,0x70ac
     f2e:	7d 3e                	jge    f6e <acquireLockMaekawa+0x6e>
     f30:	8d 5d e8             	lea    -0x18(%ebp),%ebx
     f33:	90                   	nop
     f34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		read(childPipe[getpid()-offset-1][0],buf,sizeof(buf));
     f38:	e8 05 04 00 00       	call   1342 <getpid>
     f3d:	2b 05 40 1e 00 00    	sub    0x1e40,%eax
     f43:	83 ec 04             	sub    $0x4,%esp
     f46:	6a 10                	push   $0x10
     f48:	53                   	push   %ebx
     f49:	ff 34 c5 d8 6e 00 00 	pushl  0x6ed8(,%eax,8)
     f50:	e8 85 03 00 00       	call   12da <read>
		recvHandler(buf,i);
     f55:	58                   	pop    %eax
     f56:	5a                   	pop    %edx
     f57:	56                   	push   %esi
     f58:	53                   	push   %ebx
     f59:	e8 22 f9 ff ff       	call   880 <recvHandler>
	while(lockedCount<K){
     f5e:	a1 60 1e 00 00       	mov    0x1e60,%eax
     f63:	83 c4 10             	add    $0x10,%esp
     f66:	39 05 ac 70 00 00    	cmp    %eax,0x70ac
     f6c:	7c ca                	jl     f38 <acquireLockMaekawa+0x38>
	lockedCount = K;
     f6e:	a3 ac 70 00 00       	mov    %eax,0x70ac
	processStatus = 1;//locked
     f73:	c7 05 c4 6e 00 00 01 	movl   $0x1,0x6ec4
     f7a:	00 00 00 
	printf(1,"%d acquired the lock at time %d\n",getpid(),uptime());
     f7d:	e8 d8 03 00 00       	call   135a <uptime>
     f82:	89 c3                	mov    %eax,%ebx
     f84:	e8 b9 03 00 00       	call   1342 <getpid>
     f89:	53                   	push   %ebx
     f8a:	50                   	push   %eax
     f8b:	68 54 18 00 00       	push   $0x1854
     f90:	6a 01                	push   $0x1
     f92:	e8 d9 04 00 00       	call   1470 <printf>
	return;
     f97:	83 c4 10             	add    $0x10,%esp
}
     f9a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     f9d:	5b                   	pop    %ebx
     f9e:	5e                   	pop    %esi
     f9f:	5d                   	pop    %ebp
     fa0:	c3                   	ret    
     fa1:	eb 0d                	jmp    fb0 <releaseLockMaekawa>
     fa3:	90                   	nop
     fa4:	90                   	nop
     fa5:	90                   	nop
     fa6:	90                   	nop
     fa7:	90                   	nop
     fa8:	90                   	nop
     fa9:	90                   	nop
     faa:	90                   	nop
     fab:	90                   	nop
     fac:	90                   	nop
     fad:	90                   	nop
     fae:	90                   	nop
     faf:	90                   	nop

00000fb0 <releaseLockMaekawa>:
void releaseLockMaekawa(int S[],int n,int i){
     fb0:	55                   	push   %ebp
     fb1:	89 e5                	mov    %esp,%ebp
     fb3:	57                   	push   %edi
     fb4:	56                   	push   %esi
     fb5:	53                   	push   %ebx
     fb6:	83 ec 2c             	sub    $0x2c,%esp
     fb9:	8b 45 0c             	mov    0xc(%ebp),%eax
	for(int x=0;x<n;x++){
     fbc:	85 c0                	test   %eax,%eax
     fbe:	7e 4a                	jle    100a <releaseLockMaekawa+0x5a>
     fc0:	8b 5d 08             	mov    0x8(%ebp),%ebx
     fc3:	8d 75 d8             	lea    -0x28(%ebp),%esi
     fc6:	8d 3c 83             	lea    (%ebx,%eax,4),%edi
     fc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		buf[0] = RELEASE;
     fd0:	c7 45 d8 00 00 40 40 	movl   $0x40400000,-0x28(%ebp)
     fd7:	83 c3 04             	add    $0x4,%ebx
		buf[1] = getpid();
     fda:	e8 63 03 00 00       	call   1342 <getpid>
		write(childPipe[S[x] - offset -1 ][1],buf,sizeof(buf));
     fdf:	83 ec 04             	sub    $0x4,%esp
		buf[1] = getpid();
     fe2:	89 45 d4             	mov    %eax,-0x2c(%ebp)
		write(childPipe[S[x] - offset -1 ][1],buf,sizeof(buf));
     fe5:	6a 10                	push   $0x10
     fe7:	56                   	push   %esi
     fe8:	8b 43 fc             	mov    -0x4(%ebx),%eax
     feb:	2b 05 40 1e 00 00    	sub    0x1e40,%eax
		buf[1] = getpid();
     ff1:	db 45 d4             	fildl  -0x2c(%ebp)
     ff4:	d9 5d dc             	fstps  -0x24(%ebp)
		write(childPipe[S[x] - offset -1 ][1],buf,sizeof(buf));
     ff7:	ff 34 c5 dc 6e 00 00 	pushl  0x6edc(,%eax,8)
     ffe:	e8 df 02 00 00       	call   12e2 <write>
	for(int x=0;x<n;x++){
    1003:	83 c4 10             	add    $0x10,%esp
    1006:	39 fb                	cmp    %edi,%ebx
    1008:	75 c6                	jne    fd0 <releaseLockMaekawa+0x20>
	printf(1,"%d released the lock at time %d\n",getpid(),uptime());
    100a:	e8 4b 03 00 00       	call   135a <uptime>
    100f:	89 c3                	mov    %eax,%ebx
    1011:	e8 2c 03 00 00       	call   1342 <getpid>
    1016:	53                   	push   %ebx
    1017:	50                   	push   %eax
    1018:	68 78 18 00 00       	push   $0x1878
    101d:	6a 01                	push   $0x1
    101f:	e8 4c 04 00 00       	call   1470 <printf>
	return;
    1024:	83 c4 10             	add    $0x10,%esp
}
    1027:	8d 65 f4             	lea    -0xc(%ebp),%esp
    102a:	5b                   	pop    %ebx
    102b:	5e                   	pop    %esi
    102c:	5f                   	pop    %edi
    102d:	5d                   	pop    %ebp
    102e:	c3                   	ret    
    102f:	90                   	nop

00001030 <readInt>:
int readInt(int fd){
    1030:	55                   	push   %ebp
    1031:	89 e5                	mov    %esp,%ebp
    1033:	57                   	push   %edi
    1034:	56                   	push   %esi
    1035:	53                   	push   %ebx
	int N=0;
    1036:	31 ff                	xor    %edi,%edi
    1038:	8d 5d e7             	lea    -0x19(%ebp),%ebx
int readInt(int fd){
    103b:	83 ec 1c             	sub    $0x1c,%esp
    103e:	8b 75 08             	mov    0x8(%ebp),%esi
    1041:	eb 0c                	jmp    104f <readInt+0x1f>
    1043:	90                   	nop
    1044:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		N = 10*N + alpha;
    1048:	8d 14 bf             	lea    (%edi,%edi,4),%edx
    104b:	8d 7c 50 d0          	lea    -0x30(%eax,%edx,2),%edi
		read(fd, &c, 1);
    104f:	83 ec 04             	sub    $0x4,%esp
    1052:	6a 01                	push   $0x1
    1054:	53                   	push   %ebx
    1055:	56                   	push   %esi
    1056:	e8 7f 02 00 00       	call   12da <read>
		if(c == '\n'){
    105b:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
    105f:	83 c4 10             	add    $0x10,%esp
    1062:	3c 0a                	cmp    $0xa,%al
    1064:	75 e2                	jne    1048 <readInt+0x18>
}
    1066:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1069:	89 f8                	mov    %edi,%eax
    106b:	5b                   	pop    %ebx
    106c:	5e                   	pop    %esi
    106d:	5f                   	pop    %edi
    106e:	5d                   	pop    %ebp
    106f:	c3                   	ret    

00001070 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1070:	55                   	push   %ebp
    1071:	89 e5                	mov    %esp,%ebp
    1073:	53                   	push   %ebx
    1074:	8b 45 08             	mov    0x8(%ebp),%eax
    1077:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    107a:	89 c2                	mov    %eax,%edx
    107c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1080:	83 c1 01             	add    $0x1,%ecx
    1083:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1087:	83 c2 01             	add    $0x1,%edx
    108a:	84 db                	test   %bl,%bl
    108c:	88 5a ff             	mov    %bl,-0x1(%edx)
    108f:	75 ef                	jne    1080 <strcpy+0x10>
    ;
  return os;
}
    1091:	5b                   	pop    %ebx
    1092:	5d                   	pop    %ebp
    1093:	c3                   	ret    
    1094:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    109a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000010a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    10a0:	55                   	push   %ebp
    10a1:	89 e5                	mov    %esp,%ebp
    10a3:	53                   	push   %ebx
    10a4:	8b 55 08             	mov    0x8(%ebp),%edx
    10a7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    10aa:	0f b6 02             	movzbl (%edx),%eax
    10ad:	0f b6 19             	movzbl (%ecx),%ebx
    10b0:	84 c0                	test   %al,%al
    10b2:	75 1c                	jne    10d0 <strcmp+0x30>
    10b4:	eb 2a                	jmp    10e0 <strcmp+0x40>
    10b6:	8d 76 00             	lea    0x0(%esi),%esi
    10b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    10c0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    10c3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    10c6:	83 c1 01             	add    $0x1,%ecx
    10c9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    10cc:	84 c0                	test   %al,%al
    10ce:	74 10                	je     10e0 <strcmp+0x40>
    10d0:	38 d8                	cmp    %bl,%al
    10d2:	74 ec                	je     10c0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    10d4:	29 d8                	sub    %ebx,%eax
}
    10d6:	5b                   	pop    %ebx
    10d7:	5d                   	pop    %ebp
    10d8:	c3                   	ret    
    10d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10e0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    10e2:	29 d8                	sub    %ebx,%eax
}
    10e4:	5b                   	pop    %ebx
    10e5:	5d                   	pop    %ebp
    10e6:	c3                   	ret    
    10e7:	89 f6                	mov    %esi,%esi
    10e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000010f0 <strlen>:

uint
strlen(const char *s)
{
    10f0:	55                   	push   %ebp
    10f1:	89 e5                	mov    %esp,%ebp
    10f3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    10f6:	80 39 00             	cmpb   $0x0,(%ecx)
    10f9:	74 15                	je     1110 <strlen+0x20>
    10fb:	31 d2                	xor    %edx,%edx
    10fd:	8d 76 00             	lea    0x0(%esi),%esi
    1100:	83 c2 01             	add    $0x1,%edx
    1103:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    1107:	89 d0                	mov    %edx,%eax
    1109:	75 f5                	jne    1100 <strlen+0x10>
    ;
  return n;
}
    110b:	5d                   	pop    %ebp
    110c:	c3                   	ret    
    110d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    1110:	31 c0                	xor    %eax,%eax
}
    1112:	5d                   	pop    %ebp
    1113:	c3                   	ret    
    1114:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    111a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001120 <memset>:

void*
memset(void *dst, int c, uint n)
{
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	57                   	push   %edi
    1124:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    1127:	8b 4d 10             	mov    0x10(%ebp),%ecx
    112a:	8b 45 0c             	mov    0xc(%ebp),%eax
    112d:	89 d7                	mov    %edx,%edi
    112f:	fc                   	cld    
    1130:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    1132:	89 d0                	mov    %edx,%eax
    1134:	5f                   	pop    %edi
    1135:	5d                   	pop    %ebp
    1136:	c3                   	ret    
    1137:	89 f6                	mov    %esi,%esi
    1139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001140 <strchr>:

char*
strchr(const char *s, char c)
{
    1140:	55                   	push   %ebp
    1141:	89 e5                	mov    %esp,%ebp
    1143:	53                   	push   %ebx
    1144:	8b 45 08             	mov    0x8(%ebp),%eax
    1147:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    114a:	0f b6 10             	movzbl (%eax),%edx
    114d:	84 d2                	test   %dl,%dl
    114f:	74 1d                	je     116e <strchr+0x2e>
    if(*s == c)
    1151:	38 d3                	cmp    %dl,%bl
    1153:	89 d9                	mov    %ebx,%ecx
    1155:	75 0d                	jne    1164 <strchr+0x24>
    1157:	eb 17                	jmp    1170 <strchr+0x30>
    1159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1160:	38 ca                	cmp    %cl,%dl
    1162:	74 0c                	je     1170 <strchr+0x30>
  for(; *s; s++)
    1164:	83 c0 01             	add    $0x1,%eax
    1167:	0f b6 10             	movzbl (%eax),%edx
    116a:	84 d2                	test   %dl,%dl
    116c:	75 f2                	jne    1160 <strchr+0x20>
      return (char*)s;
  return 0;
    116e:	31 c0                	xor    %eax,%eax
}
    1170:	5b                   	pop    %ebx
    1171:	5d                   	pop    %ebp
    1172:	c3                   	ret    
    1173:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1179:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001180 <gets>:

char*
gets(char *buf, int max)
{
    1180:	55                   	push   %ebp
    1181:	89 e5                	mov    %esp,%ebp
    1183:	57                   	push   %edi
    1184:	56                   	push   %esi
    1185:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1186:	31 f6                	xor    %esi,%esi
    1188:	89 f3                	mov    %esi,%ebx
{
    118a:	83 ec 1c             	sub    $0x1c,%esp
    118d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1190:	eb 2f                	jmp    11c1 <gets+0x41>
    1192:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1198:	8d 45 e7             	lea    -0x19(%ebp),%eax
    119b:	83 ec 04             	sub    $0x4,%esp
    119e:	6a 01                	push   $0x1
    11a0:	50                   	push   %eax
    11a1:	6a 00                	push   $0x0
    11a3:	e8 32 01 00 00       	call   12da <read>
    if(cc < 1)
    11a8:	83 c4 10             	add    $0x10,%esp
    11ab:	85 c0                	test   %eax,%eax
    11ad:	7e 1c                	jle    11cb <gets+0x4b>
      break;
    buf[i++] = c;
    11af:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    11b3:	83 c7 01             	add    $0x1,%edi
    11b6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    11b9:	3c 0a                	cmp    $0xa,%al
    11bb:	74 23                	je     11e0 <gets+0x60>
    11bd:	3c 0d                	cmp    $0xd,%al
    11bf:	74 1f                	je     11e0 <gets+0x60>
  for(i=0; i+1 < max; ){
    11c1:	83 c3 01             	add    $0x1,%ebx
    11c4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    11c7:	89 fe                	mov    %edi,%esi
    11c9:	7c cd                	jl     1198 <gets+0x18>
    11cb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    11cd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    11d0:	c6 03 00             	movb   $0x0,(%ebx)
}
    11d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11d6:	5b                   	pop    %ebx
    11d7:	5e                   	pop    %esi
    11d8:	5f                   	pop    %edi
    11d9:	5d                   	pop    %ebp
    11da:	c3                   	ret    
    11db:	90                   	nop
    11dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11e0:	8b 75 08             	mov    0x8(%ebp),%esi
    11e3:	8b 45 08             	mov    0x8(%ebp),%eax
    11e6:	01 de                	add    %ebx,%esi
    11e8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    11ea:	c6 03 00             	movb   $0x0,(%ebx)
}
    11ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
    11f0:	5b                   	pop    %ebx
    11f1:	5e                   	pop    %esi
    11f2:	5f                   	pop    %edi
    11f3:	5d                   	pop    %ebp
    11f4:	c3                   	ret    
    11f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    11f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001200 <stat>:

int
stat(const char *n, struct stat *st)
{
    1200:	55                   	push   %ebp
    1201:	89 e5                	mov    %esp,%ebp
    1203:	56                   	push   %esi
    1204:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    1205:	83 ec 08             	sub    $0x8,%esp
    1208:	6a 00                	push   $0x0
    120a:	ff 75 08             	pushl  0x8(%ebp)
    120d:	e8 f0 00 00 00       	call   1302 <open>
  if(fd < 0)
    1212:	83 c4 10             	add    $0x10,%esp
    1215:	85 c0                	test   %eax,%eax
    1217:	78 27                	js     1240 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    1219:	83 ec 08             	sub    $0x8,%esp
    121c:	ff 75 0c             	pushl  0xc(%ebp)
    121f:	89 c3                	mov    %eax,%ebx
    1221:	50                   	push   %eax
    1222:	e8 f3 00 00 00       	call   131a <fstat>
  close(fd);
    1227:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    122a:	89 c6                	mov    %eax,%esi
  close(fd);
    122c:	e8 b9 00 00 00       	call   12ea <close>
  return r;
    1231:	83 c4 10             	add    $0x10,%esp
}
    1234:	8d 65 f8             	lea    -0x8(%ebp),%esp
    1237:	89 f0                	mov    %esi,%eax
    1239:	5b                   	pop    %ebx
    123a:	5e                   	pop    %esi
    123b:	5d                   	pop    %ebp
    123c:	c3                   	ret    
    123d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    1240:	be ff ff ff ff       	mov    $0xffffffff,%esi
    1245:	eb ed                	jmp    1234 <stat+0x34>
    1247:	89 f6                	mov    %esi,%esi
    1249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001250 <atoi>:

int
atoi(const char *s)
{
    1250:	55                   	push   %ebp
    1251:	89 e5                	mov    %esp,%ebp
    1253:	53                   	push   %ebx
    1254:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1257:	0f be 11             	movsbl (%ecx),%edx
    125a:	8d 42 d0             	lea    -0x30(%edx),%eax
    125d:	3c 09                	cmp    $0x9,%al
  n = 0;
    125f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    1264:	77 1f                	ja     1285 <atoi+0x35>
    1266:	8d 76 00             	lea    0x0(%esi),%esi
    1269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1270:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1273:	83 c1 01             	add    $0x1,%ecx
    1276:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    127a:	0f be 11             	movsbl (%ecx),%edx
    127d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1280:	80 fb 09             	cmp    $0x9,%bl
    1283:	76 eb                	jbe    1270 <atoi+0x20>
  return n;
}
    1285:	5b                   	pop    %ebx
    1286:	5d                   	pop    %ebp
    1287:	c3                   	ret    
    1288:	90                   	nop
    1289:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001290 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1290:	55                   	push   %ebp
    1291:	89 e5                	mov    %esp,%ebp
    1293:	56                   	push   %esi
    1294:	53                   	push   %ebx
    1295:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1298:	8b 45 08             	mov    0x8(%ebp),%eax
    129b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    129e:	85 db                	test   %ebx,%ebx
    12a0:	7e 14                	jle    12b6 <memmove+0x26>
    12a2:	31 d2                	xor    %edx,%edx
    12a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    12a8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    12ac:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    12af:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    12b2:	39 d3                	cmp    %edx,%ebx
    12b4:	75 f2                	jne    12a8 <memmove+0x18>
  return vdst;
}
    12b6:	5b                   	pop    %ebx
    12b7:	5e                   	pop    %esi
    12b8:	5d                   	pop    %ebp
    12b9:	c3                   	ret    

000012ba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    12ba:	b8 01 00 00 00       	mov    $0x1,%eax
    12bf:	cd 40                	int    $0x40
    12c1:	c3                   	ret    

000012c2 <exit>:
SYSCALL(exit)
    12c2:	b8 02 00 00 00       	mov    $0x2,%eax
    12c7:	cd 40                	int    $0x40
    12c9:	c3                   	ret    

000012ca <wait>:
SYSCALL(wait)
    12ca:	b8 03 00 00 00       	mov    $0x3,%eax
    12cf:	cd 40                	int    $0x40
    12d1:	c3                   	ret    

000012d2 <pipe>:
SYSCALL(pipe)
    12d2:	b8 04 00 00 00       	mov    $0x4,%eax
    12d7:	cd 40                	int    $0x40
    12d9:	c3                   	ret    

000012da <read>:
SYSCALL(read)
    12da:	b8 05 00 00 00       	mov    $0x5,%eax
    12df:	cd 40                	int    $0x40
    12e1:	c3                   	ret    

000012e2 <write>:
SYSCALL(write)
    12e2:	b8 10 00 00 00       	mov    $0x10,%eax
    12e7:	cd 40                	int    $0x40
    12e9:	c3                   	ret    

000012ea <close>:
SYSCALL(close)
    12ea:	b8 15 00 00 00       	mov    $0x15,%eax
    12ef:	cd 40                	int    $0x40
    12f1:	c3                   	ret    

000012f2 <kill>:
SYSCALL(kill)
    12f2:	b8 06 00 00 00       	mov    $0x6,%eax
    12f7:	cd 40                	int    $0x40
    12f9:	c3                   	ret    

000012fa <exec>:
SYSCALL(exec)
    12fa:	b8 07 00 00 00       	mov    $0x7,%eax
    12ff:	cd 40                	int    $0x40
    1301:	c3                   	ret    

00001302 <open>:
SYSCALL(open)
    1302:	b8 0f 00 00 00       	mov    $0xf,%eax
    1307:	cd 40                	int    $0x40
    1309:	c3                   	ret    

0000130a <mknod>:
SYSCALL(mknod)
    130a:	b8 11 00 00 00       	mov    $0x11,%eax
    130f:	cd 40                	int    $0x40
    1311:	c3                   	ret    

00001312 <unlink>:
SYSCALL(unlink)
    1312:	b8 12 00 00 00       	mov    $0x12,%eax
    1317:	cd 40                	int    $0x40
    1319:	c3                   	ret    

0000131a <fstat>:
SYSCALL(fstat)
    131a:	b8 08 00 00 00       	mov    $0x8,%eax
    131f:	cd 40                	int    $0x40
    1321:	c3                   	ret    

00001322 <link>:
SYSCALL(link)
    1322:	b8 13 00 00 00       	mov    $0x13,%eax
    1327:	cd 40                	int    $0x40
    1329:	c3                   	ret    

0000132a <mkdir>:
SYSCALL(mkdir)
    132a:	b8 14 00 00 00       	mov    $0x14,%eax
    132f:	cd 40                	int    $0x40
    1331:	c3                   	ret    

00001332 <chdir>:
SYSCALL(chdir)
    1332:	b8 09 00 00 00       	mov    $0x9,%eax
    1337:	cd 40                	int    $0x40
    1339:	c3                   	ret    

0000133a <dup>:
SYSCALL(dup)
    133a:	b8 0a 00 00 00       	mov    $0xa,%eax
    133f:	cd 40                	int    $0x40
    1341:	c3                   	ret    

00001342 <getpid>:
SYSCALL(getpid)
    1342:	b8 0b 00 00 00       	mov    $0xb,%eax
    1347:	cd 40                	int    $0x40
    1349:	c3                   	ret    

0000134a <sbrk>:
SYSCALL(sbrk)
    134a:	b8 0c 00 00 00       	mov    $0xc,%eax
    134f:	cd 40                	int    $0x40
    1351:	c3                   	ret    

00001352 <sleep>:
SYSCALL(sleep)
    1352:	b8 0d 00 00 00       	mov    $0xd,%eax
    1357:	cd 40                	int    $0x40
    1359:	c3                   	ret    

0000135a <uptime>:
SYSCALL(uptime)
    135a:	b8 0e 00 00 00       	mov    $0xe,%eax
    135f:	cd 40                	int    $0x40
    1361:	c3                   	ret    

00001362 <halt>:
SYSCALL(halt)
    1362:	b8 1f 00 00 00       	mov    $0x1f,%eax
    1367:	cd 40                	int    $0x40
    1369:	c3                   	ret    

0000136a <toggle>:
SYSCALL(toggle)
    136a:	b8 16 00 00 00       	mov    $0x16,%eax
    136f:	cd 40                	int    $0x40
    1371:	c3                   	ret    

00001372 <add>:
SYSCALL(add)
    1372:	b8 17 00 00 00       	mov    $0x17,%eax
    1377:	cd 40                	int    $0x40
    1379:	c3                   	ret    

0000137a <ps>:
SYSCALL(ps)
    137a:	b8 18 00 00 00       	mov    $0x18,%eax
    137f:	cd 40                	int    $0x40
    1381:	c3                   	ret    

00001382 <send>:
SYSCALL(send)
    1382:	b8 19 00 00 00       	mov    $0x19,%eax
    1387:	cd 40                	int    $0x40
    1389:	c3                   	ret    

0000138a <recv>:
SYSCALL(recv)
    138a:	b8 1a 00 00 00       	mov    $0x1a,%eax
    138f:	cd 40                	int    $0x40
    1391:	c3                   	ret    

00001392 <print_count>:
SYSCALL(print_count)
    1392:	b8 1b 00 00 00       	mov    $0x1b,%eax
    1397:	cd 40                	int    $0x40
    1399:	c3                   	ret    

0000139a <send_multi>:
SYSCALL(send_multi)
    139a:	b8 1c 00 00 00       	mov    $0x1c,%eax
    139f:	cd 40                	int    $0x40
    13a1:	c3                   	ret    

000013a2 <signal>:
SYSCALL(signal)
    13a2:	b8 1d 00 00 00       	mov    $0x1d,%eax
    13a7:	cd 40                	int    $0x40
    13a9:	c3                   	ret    

000013aa <sigraise>:
SYSCALL(sigraise)
    13aa:	b8 1e 00 00 00       	mov    $0x1e,%eax
    13af:	cd 40                	int    $0x40
    13b1:	c3                   	ret    

000013b2 <recv_multi>:
SYSCALL(recv_multi)
    13b2:	b8 20 00 00 00       	mov    $0x20,%eax
    13b7:	cd 40                	int    $0x40
    13b9:	c3                   	ret    

000013ba <change_state>:
SYSCALL(change_state)
    13ba:	b8 21 00 00 00       	mov    $0x21,%eax
    13bf:	cd 40                	int    $0x40
    13c1:	c3                   	ret    
    13c2:	66 90                	xchg   %ax,%ax
    13c4:	66 90                	xchg   %ax,%ax
    13c6:	66 90                	xchg   %ax,%ax
    13c8:	66 90                	xchg   %ax,%ax
    13ca:	66 90                	xchg   %ax,%ax
    13cc:	66 90                	xchg   %ax,%ax
    13ce:	66 90                	xchg   %ax,%ax

000013d0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    13d0:	55                   	push   %ebp
    13d1:	89 e5                	mov    %esp,%ebp
    13d3:	57                   	push   %edi
    13d4:	56                   	push   %esi
    13d5:	53                   	push   %ebx
    13d6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    13d9:	85 d2                	test   %edx,%edx
{
    13db:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
    13de:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    13e0:	79 76                	jns    1458 <printint+0x88>
    13e2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    13e6:	74 70                	je     1458 <printint+0x88>
    x = -xx;
    13e8:	f7 d8                	neg    %eax
    neg = 1;
    13ea:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    13f1:	31 f6                	xor    %esi,%esi
    13f3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    13f6:	eb 0a                	jmp    1402 <printint+0x32>
    13f8:	90                   	nop
    13f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    1400:	89 fe                	mov    %edi,%esi
    1402:	31 d2                	xor    %edx,%edx
    1404:	8d 7e 01             	lea    0x1(%esi),%edi
    1407:	f7 f1                	div    %ecx
    1409:	0f b6 92 e0 18 00 00 	movzbl 0x18e0(%edx),%edx
  }while((x /= base) != 0);
    1410:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    1412:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    1415:	75 e9                	jne    1400 <printint+0x30>
  if(neg)
    1417:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    141a:	85 c0                	test   %eax,%eax
    141c:	74 08                	je     1426 <printint+0x56>
    buf[i++] = '-';
    141e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    1423:	8d 7e 02             	lea    0x2(%esi),%edi
    1426:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    142a:	8b 7d c0             	mov    -0x40(%ebp),%edi
    142d:	8d 76 00             	lea    0x0(%esi),%esi
    1430:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    1433:	83 ec 04             	sub    $0x4,%esp
    1436:	83 ee 01             	sub    $0x1,%esi
    1439:	6a 01                	push   $0x1
    143b:	53                   	push   %ebx
    143c:	57                   	push   %edi
    143d:	88 45 d7             	mov    %al,-0x29(%ebp)
    1440:	e8 9d fe ff ff       	call   12e2 <write>

  while(--i >= 0)
    1445:	83 c4 10             	add    $0x10,%esp
    1448:	39 de                	cmp    %ebx,%esi
    144a:	75 e4                	jne    1430 <printint+0x60>
    putc(fd, buf[i]);
}
    144c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    144f:	5b                   	pop    %ebx
    1450:	5e                   	pop    %esi
    1451:	5f                   	pop    %edi
    1452:	5d                   	pop    %ebp
    1453:	c3                   	ret    
    1454:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1458:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    145f:	eb 90                	jmp    13f1 <printint+0x21>
    1461:	eb 0d                	jmp    1470 <printf>
    1463:	90                   	nop
    1464:	90                   	nop
    1465:	90                   	nop
    1466:	90                   	nop
    1467:	90                   	nop
    1468:	90                   	nop
    1469:	90                   	nop
    146a:	90                   	nop
    146b:	90                   	nop
    146c:	90                   	nop
    146d:	90                   	nop
    146e:	90                   	nop
    146f:	90                   	nop

00001470 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1470:	55                   	push   %ebp
    1471:	89 e5                	mov    %esp,%ebp
    1473:	57                   	push   %edi
    1474:	56                   	push   %esi
    1475:	53                   	push   %ebx
    1476:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1479:	8b 75 0c             	mov    0xc(%ebp),%esi
    147c:	0f b6 1e             	movzbl (%esi),%ebx
    147f:	84 db                	test   %bl,%bl
    1481:	0f 84 b3 00 00 00    	je     153a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
    1487:	8d 45 10             	lea    0x10(%ebp),%eax
    148a:	83 c6 01             	add    $0x1,%esi
  state = 0;
    148d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
    148f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1492:	eb 2f                	jmp    14c3 <printf+0x53>
    1494:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1498:	83 f8 25             	cmp    $0x25,%eax
    149b:	0f 84 a7 00 00 00    	je     1548 <printf+0xd8>
  write(fd, &c, 1);
    14a1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    14a4:	83 ec 04             	sub    $0x4,%esp
    14a7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    14aa:	6a 01                	push   $0x1
    14ac:	50                   	push   %eax
    14ad:	ff 75 08             	pushl  0x8(%ebp)
    14b0:	e8 2d fe ff ff       	call   12e2 <write>
    14b5:	83 c4 10             	add    $0x10,%esp
    14b8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    14bb:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    14bf:	84 db                	test   %bl,%bl
    14c1:	74 77                	je     153a <printf+0xca>
    if(state == 0){
    14c3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    14c5:	0f be cb             	movsbl %bl,%ecx
    14c8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    14cb:	74 cb                	je     1498 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    14cd:	83 ff 25             	cmp    $0x25,%edi
    14d0:	75 e6                	jne    14b8 <printf+0x48>
      if(c == 'd'){
    14d2:	83 f8 64             	cmp    $0x64,%eax
    14d5:	0f 84 05 01 00 00    	je     15e0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    14db:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    14e1:	83 f9 70             	cmp    $0x70,%ecx
    14e4:	74 72                	je     1558 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    14e6:	83 f8 73             	cmp    $0x73,%eax
    14e9:	0f 84 99 00 00 00    	je     1588 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    14ef:	83 f8 63             	cmp    $0x63,%eax
    14f2:	0f 84 08 01 00 00    	je     1600 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    14f8:	83 f8 25             	cmp    $0x25,%eax
    14fb:	0f 84 ef 00 00 00    	je     15f0 <printf+0x180>
  write(fd, &c, 1);
    1501:	8d 45 e7             	lea    -0x19(%ebp),%eax
    1504:	83 ec 04             	sub    $0x4,%esp
    1507:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    150b:	6a 01                	push   $0x1
    150d:	50                   	push   %eax
    150e:	ff 75 08             	pushl  0x8(%ebp)
    1511:	e8 cc fd ff ff       	call   12e2 <write>
    1516:	83 c4 0c             	add    $0xc,%esp
    1519:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    151c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    151f:	6a 01                	push   $0x1
    1521:	50                   	push   %eax
    1522:	ff 75 08             	pushl  0x8(%ebp)
    1525:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1528:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    152a:	e8 b3 fd ff ff       	call   12e2 <write>
  for(i = 0; fmt[i]; i++){
    152f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
    1533:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1536:	84 db                	test   %bl,%bl
    1538:	75 89                	jne    14c3 <printf+0x53>
    }
  }
}
    153a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    153d:	5b                   	pop    %ebx
    153e:	5e                   	pop    %esi
    153f:	5f                   	pop    %edi
    1540:	5d                   	pop    %ebp
    1541:	c3                   	ret    
    1542:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
    1548:	bf 25 00 00 00       	mov    $0x25,%edi
    154d:	e9 66 ff ff ff       	jmp    14b8 <printf+0x48>
    1552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    1558:	83 ec 0c             	sub    $0xc,%esp
    155b:	b9 10 00 00 00       	mov    $0x10,%ecx
    1560:	6a 00                	push   $0x0
    1562:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    1565:	8b 45 08             	mov    0x8(%ebp),%eax
    1568:	8b 17                	mov    (%edi),%edx
    156a:	e8 61 fe ff ff       	call   13d0 <printint>
        ap++;
    156f:	89 f8                	mov    %edi,%eax
    1571:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1574:	31 ff                	xor    %edi,%edi
        ap++;
    1576:	83 c0 04             	add    $0x4,%eax
    1579:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    157c:	e9 37 ff ff ff       	jmp    14b8 <printf+0x48>
    1581:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    1588:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    158b:	8b 08                	mov    (%eax),%ecx
        ap++;
    158d:	83 c0 04             	add    $0x4,%eax
    1590:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    1593:	85 c9                	test   %ecx,%ecx
    1595:	0f 84 8e 00 00 00    	je     1629 <printf+0x1b9>
        while(*s != 0){
    159b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    159e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    15a0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    15a2:	84 c0                	test   %al,%al
    15a4:	0f 84 0e ff ff ff    	je     14b8 <printf+0x48>
    15aa:	89 75 d0             	mov    %esi,-0x30(%ebp)
    15ad:	89 de                	mov    %ebx,%esi
    15af:	8b 5d 08             	mov    0x8(%ebp),%ebx
    15b2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    15b5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    15b8:	83 ec 04             	sub    $0x4,%esp
          s++;
    15bb:	83 c6 01             	add    $0x1,%esi
    15be:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    15c1:	6a 01                	push   $0x1
    15c3:	57                   	push   %edi
    15c4:	53                   	push   %ebx
    15c5:	e8 18 fd ff ff       	call   12e2 <write>
        while(*s != 0){
    15ca:	0f b6 06             	movzbl (%esi),%eax
    15cd:	83 c4 10             	add    $0x10,%esp
    15d0:	84 c0                	test   %al,%al
    15d2:	75 e4                	jne    15b8 <printf+0x148>
    15d4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    15d7:	31 ff                	xor    %edi,%edi
    15d9:	e9 da fe ff ff       	jmp    14b8 <printf+0x48>
    15de:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    15e0:	83 ec 0c             	sub    $0xc,%esp
    15e3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    15e8:	6a 01                	push   $0x1
    15ea:	e9 73 ff ff ff       	jmp    1562 <printf+0xf2>
    15ef:	90                   	nop
  write(fd, &c, 1);
    15f0:	83 ec 04             	sub    $0x4,%esp
    15f3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    15f6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    15f9:	6a 01                	push   $0x1
    15fb:	e9 21 ff ff ff       	jmp    1521 <printf+0xb1>
        putc(fd, *ap);
    1600:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    1603:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    1606:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    1608:	6a 01                	push   $0x1
        ap++;
    160a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    160d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    1610:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1613:	50                   	push   %eax
    1614:	ff 75 08             	pushl  0x8(%ebp)
    1617:	e8 c6 fc ff ff       	call   12e2 <write>
        ap++;
    161c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    161f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1622:	31 ff                	xor    %edi,%edi
    1624:	e9 8f fe ff ff       	jmp    14b8 <printf+0x48>
          s = "(null)";
    1629:	bb d8 18 00 00       	mov    $0x18d8,%ebx
        while(*s != 0){
    162e:	b8 28 00 00 00       	mov    $0x28,%eax
    1633:	e9 72 ff ff ff       	jmp    15aa <printf+0x13a>
    1638:	66 90                	xchg   %ax,%ax
    163a:	66 90                	xchg   %ax,%ax
    163c:	66 90                	xchg   %ax,%ax
    163e:	66 90                	xchg   %ax,%ax

00001640 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1640:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1641:	a1 4c 1e 00 00       	mov    0x1e4c,%eax
{
    1646:	89 e5                	mov    %esp,%ebp
    1648:	57                   	push   %edi
    1649:	56                   	push   %esi
    164a:	53                   	push   %ebx
    164b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    164e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1651:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1658:	39 c8                	cmp    %ecx,%eax
    165a:	8b 10                	mov    (%eax),%edx
    165c:	73 32                	jae    1690 <free+0x50>
    165e:	39 d1                	cmp    %edx,%ecx
    1660:	72 04                	jb     1666 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1662:	39 d0                	cmp    %edx,%eax
    1664:	72 32                	jb     1698 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1666:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1669:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    166c:	39 fa                	cmp    %edi,%edx
    166e:	74 30                	je     16a0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1670:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1673:	8b 50 04             	mov    0x4(%eax),%edx
    1676:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1679:	39 f1                	cmp    %esi,%ecx
    167b:	74 3a                	je     16b7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    167d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    167f:	a3 4c 1e 00 00       	mov    %eax,0x1e4c
}
    1684:	5b                   	pop    %ebx
    1685:	5e                   	pop    %esi
    1686:	5f                   	pop    %edi
    1687:	5d                   	pop    %ebp
    1688:	c3                   	ret    
    1689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1690:	39 d0                	cmp    %edx,%eax
    1692:	72 04                	jb     1698 <free+0x58>
    1694:	39 d1                	cmp    %edx,%ecx
    1696:	72 ce                	jb     1666 <free+0x26>
{
    1698:	89 d0                	mov    %edx,%eax
    169a:	eb bc                	jmp    1658 <free+0x18>
    169c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    16a0:	03 72 04             	add    0x4(%edx),%esi
    16a3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    16a6:	8b 10                	mov    (%eax),%edx
    16a8:	8b 12                	mov    (%edx),%edx
    16aa:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    16ad:	8b 50 04             	mov    0x4(%eax),%edx
    16b0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    16b3:	39 f1                	cmp    %esi,%ecx
    16b5:	75 c6                	jne    167d <free+0x3d>
    p->s.size += bp->s.size;
    16b7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    16ba:	a3 4c 1e 00 00       	mov    %eax,0x1e4c
    p->s.size += bp->s.size;
    16bf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    16c2:	8b 53 f8             	mov    -0x8(%ebx),%edx
    16c5:	89 10                	mov    %edx,(%eax)
}
    16c7:	5b                   	pop    %ebx
    16c8:	5e                   	pop    %esi
    16c9:	5f                   	pop    %edi
    16ca:	5d                   	pop    %ebp
    16cb:	c3                   	ret    
    16cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000016d0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    16d0:	55                   	push   %ebp
    16d1:	89 e5                	mov    %esp,%ebp
    16d3:	57                   	push   %edi
    16d4:	56                   	push   %esi
    16d5:	53                   	push   %ebx
    16d6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    16d9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    16dc:	8b 15 4c 1e 00 00    	mov    0x1e4c,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    16e2:	8d 78 07             	lea    0x7(%eax),%edi
    16e5:	c1 ef 03             	shr    $0x3,%edi
    16e8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    16eb:	85 d2                	test   %edx,%edx
    16ed:	0f 84 9d 00 00 00    	je     1790 <malloc+0xc0>
    16f3:	8b 02                	mov    (%edx),%eax
    16f5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    16f8:	39 cf                	cmp    %ecx,%edi
    16fa:	76 6c                	jbe    1768 <malloc+0x98>
    16fc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    1702:	bb 00 10 00 00       	mov    $0x1000,%ebx
    1707:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    170a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1711:	eb 0e                	jmp    1721 <malloc+0x51>
    1713:	90                   	nop
    1714:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1718:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    171a:	8b 48 04             	mov    0x4(%eax),%ecx
    171d:	39 f9                	cmp    %edi,%ecx
    171f:	73 47                	jae    1768 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1721:	39 05 4c 1e 00 00    	cmp    %eax,0x1e4c
    1727:	89 c2                	mov    %eax,%edx
    1729:	75 ed                	jne    1718 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    172b:	83 ec 0c             	sub    $0xc,%esp
    172e:	56                   	push   %esi
    172f:	e8 16 fc ff ff       	call   134a <sbrk>
  if(p == (char*)-1)
    1734:	83 c4 10             	add    $0x10,%esp
    1737:	83 f8 ff             	cmp    $0xffffffff,%eax
    173a:	74 1c                	je     1758 <malloc+0x88>
  hp->s.size = nu;
    173c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    173f:	83 ec 0c             	sub    $0xc,%esp
    1742:	83 c0 08             	add    $0x8,%eax
    1745:	50                   	push   %eax
    1746:	e8 f5 fe ff ff       	call   1640 <free>
  return freep;
    174b:	8b 15 4c 1e 00 00    	mov    0x1e4c,%edx
      if((p = morecore(nunits)) == 0)
    1751:	83 c4 10             	add    $0x10,%esp
    1754:	85 d2                	test   %edx,%edx
    1756:	75 c0                	jne    1718 <malloc+0x48>
        return 0;
  }
}
    1758:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    175b:	31 c0                	xor    %eax,%eax
}
    175d:	5b                   	pop    %ebx
    175e:	5e                   	pop    %esi
    175f:	5f                   	pop    %edi
    1760:	5d                   	pop    %ebp
    1761:	c3                   	ret    
    1762:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1768:	39 cf                	cmp    %ecx,%edi
    176a:	74 54                	je     17c0 <malloc+0xf0>
        p->s.size -= nunits;
    176c:	29 f9                	sub    %edi,%ecx
    176e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1771:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1774:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1777:	89 15 4c 1e 00 00    	mov    %edx,0x1e4c
}
    177d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1780:	83 c0 08             	add    $0x8,%eax
}
    1783:	5b                   	pop    %ebx
    1784:	5e                   	pop    %esi
    1785:	5f                   	pop    %edi
    1786:	5d                   	pop    %ebp
    1787:	c3                   	ret    
    1788:	90                   	nop
    1789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1790:	c7 05 4c 1e 00 00 50 	movl   $0x1e50,0x1e4c
    1797:	1e 00 00 
    179a:	c7 05 50 1e 00 00 50 	movl   $0x1e50,0x1e50
    17a1:	1e 00 00 
    base.s.size = 0;
    17a4:	b8 50 1e 00 00       	mov    $0x1e50,%eax
    17a9:	c7 05 54 1e 00 00 00 	movl   $0x0,0x1e54
    17b0:	00 00 00 
    17b3:	e9 44 ff ff ff       	jmp    16fc <malloc+0x2c>
    17b8:	90                   	nop
    17b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    17c0:	8b 08                	mov    (%eax),%ecx
    17c2:	89 0a                	mov    %ecx,(%edx)
    17c4:	eb b1                	jmp    1777 <malloc+0xa7>
