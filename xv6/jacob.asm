
_jacob:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:




int main(void)
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
      11:	31 f6                	xor    %esi,%esi
{
      13:	81 ec b0 00 00 00    	sub    $0xb0,%esp
	////////////////////////////////////////////

	//Taking Input from the file
  	char *filename;
	filename = "assig2a.inp";
	int fd = open(filename, 0);
      19:	6a 00                	push   $0x0
      1b:	68 78 18 00 00       	push   $0x1878
      20:	e8 8d 13 00 00       	call   13b2 <open>
      25:	83 c4 10             	add    $0x10,%esp
      28:	89 c3                	mov    %eax,%ebx
      2a:	eb 0b                	jmp    37 <main+0x37>
      2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
		N = 10*N + alpha;
      30:	8d 14 b6             	lea    (%esi,%esi,4),%edx
      33:	8d 74 50 d0          	lea    -0x30(%eax,%edx,2),%esi
		read(fd, &c, 1);
      37:	8d 45 d8             	lea    -0x28(%ebp),%eax
      3a:	83 ec 04             	sub    $0x4,%esp
      3d:	6a 01                	push   $0x1
      3f:	50                   	push   %eax
      40:	53                   	push   %ebx
      41:	e8 44 13 00 00       	call   138a <read>
		if(c == '\n'){
      46:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
      4a:	83 c4 10             	add    $0x10,%esp
      4d:	3c 0a                	cmp    $0xa,%al
      4f:	75 df                	jne    30 <main+0x30>
	// 	}
	// 	alpha = c-'0';
	// 	N = 10*N + alpha;
	// }
	N = readInt(fd);
	E = readFloat(fd);
      51:	83 ec 0c             	sub    $0xc,%esp
      54:	89 75 8c             	mov    %esi,-0x74(%ebp)
	int N=0;
      57:	31 f6                	xor    %esi,%esi
	E = readFloat(fd);
      59:	53                   	push   %ebx
      5a:	e8 11 10 00 00       	call   1070 <readFloat>
      5f:	d9 9d 7c ff ff ff    	fstps  -0x84(%ebp)
	T = readFloat(fd);
      65:	89 1c 24             	mov    %ebx,(%esp)
      68:	e8 03 10 00 00       	call   1070 <readFloat>
      6d:	83 c4 10             	add    $0x10,%esp
      70:	d9 5d a4             	fstps  -0x5c(%ebp)
      73:	eb 0a                	jmp    7f <main+0x7f>
      75:	8d 76 00             	lea    0x0(%esi),%esi
		N = 10*N + alpha;
      78:	8d 14 b6             	lea    (%esi,%esi,4),%edx
      7b:	8d 74 50 d0          	lea    -0x30(%eax,%edx,2),%esi
		read(fd, &c, 1);
      7f:	8d 45 d8             	lea    -0x28(%ebp),%eax
      82:	83 ec 04             	sub    $0x4,%esp
      85:	6a 01                	push   $0x1
      87:	50                   	push   %eax
      88:	53                   	push   %ebx
      89:	e8 fc 12 00 00       	call   138a <read>
		if(c == '\n'){
      8e:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
      92:	83 c4 10             	add    $0x10,%esp
      95:	3c 0a                	cmp    $0xa,%al
      97:	75 df                	jne    78 <main+0x78>
      99:	89 75 90             	mov    %esi,-0x70(%ebp)
	int N=0;
      9c:	31 f6                	xor    %esi,%esi
      9e:	eb 07                	jmp    a7 <main+0xa7>
		N = 10*N + alpha;
      a0:	8d 14 b6             	lea    (%esi,%esi,4),%edx
      a3:	8d 74 50 d0          	lea    -0x30(%eax,%edx,2),%esi
		read(fd, &c, 1);
      a7:	8d 45 d8             	lea    -0x28(%ebp),%eax
      aa:	83 ec 04             	sub    $0x4,%esp
      ad:	6a 01                	push   $0x1
      af:	50                   	push   %eax
      b0:	53                   	push   %ebx
      b1:	e8 d4 12 00 00       	call   138a <read>
		if(c == '\n'){
      b6:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
      ba:	83 c4 10             	add    $0x10,%esp
      bd:	3c 0a                	cmp    $0xa,%al
      bf:	75 df                	jne    a0 <main+0xa0>
	P = readInt(fd);
	L = readInt(fd);

	close(fd);
      c1:	83 ec 0c             	sub    $0xc,%esp
      c4:	89 b5 78 ff ff ff    	mov    %esi,-0x88(%ebp)
      ca:	53                   	push   %ebx
      cb:	e8 ca 12 00 00       	call   139a <close>


	float diff;  /* Change in Value */
	int i,j;
	float mean;
	float u[N][N];
      d0:	8b 75 8c             	mov    -0x74(%ebp),%esi
      d3:	83 c4 10             	add    $0x10,%esp
      d6:	89 f0                	mov    %esi,%eax
      d8:	8d 0c b5 00 00 00 00 	lea    0x0(,%esi,4),%ecx
      df:	8d 7e ff             	lea    -0x1(%esi),%edi
      e2:	0f af c6             	imul   %esi,%eax
      e5:	89 4d 9c             	mov    %ecx,-0x64(%ebp)
	float w[N][N];
	float u_serial[N][N];
	float w_serial[N][N];

	int fd_cor_child[P][2];
      e8:	8b 4d 90             	mov    -0x70(%ebp),%ecx
	float u[N][N];
      eb:	8d 04 85 12 00 00 00 	lea    0x12(,%eax,4),%eax
      f2:	83 e0 f0             	and    $0xfffffff0,%eax
      f5:	29 c4                	sub    %eax,%esp
      f7:	89 65 a0             	mov    %esp,-0x60(%ebp)
	float w[N][N];
      fa:	29 c4                	sub    %eax,%esp
      fc:	89 a5 6c ff ff ff    	mov    %esp,-0x94(%ebp)
	float u_serial[N][N];
     102:	29 c4                	sub    %eax,%esp
     104:	89 65 94             	mov    %esp,-0x6c(%ebp)
	float w_serial[N][N];
     107:	29 c4                	sub    %eax,%esp
	int fd_cor_child[P][2];
     109:	8d 04 cd 00 00 00 00 	lea    0x0(,%ecx,8),%eax
	float w_serial[N][N];
     110:	89 a5 64 ff ff ff    	mov    %esp,-0x9c(%ebp)
	int fd_cor_child[P][2];
     116:	89 45 80             	mov    %eax,-0x80(%ebp)
     119:	83 c0 12             	add    $0x12,%eax
     11c:	83 e0 f0             	and    $0xfffffff0,%eax
     11f:	29 c4                	sub    %eax,%esp
     121:	89 a5 74 ff ff ff    	mov    %esp,-0x8c(%ebp)
	int fd_child_cor[P][2];
     127:	29 c4                	sub    %eax,%esp
     129:	89 a5 70 ff ff ff    	mov    %esp,-0x90(%ebp)
	int child_sends_lower[P][2];
     12f:	29 c4                	sub    %eax,%esp
     131:	89 65 88             	mov    %esp,-0x78(%ebp)
	int child_sends_upper[P][2];
     134:	29 c4                	sub    %eax,%esp

	for(int i=0;i<P;i++){
     136:	85 c9                	test   %ecx,%ecx
	int child_sends_upper[P][2];
     138:	89 65 84             	mov    %esp,-0x7c(%ebp)
	for(int i=0;i<P;i++){
     13b:	0f 8e f4 00 00 00    	jle    235 <main+0x235>
     141:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
     147:	8b 4d 88             	mov    -0x78(%ebp),%ecx
     14a:	89 bd 68 ff ff ff    	mov    %edi,-0x98(%ebp)
     150:	8b 75 84             	mov    -0x7c(%ebp),%esi
     153:	89 c3                	mov    %eax,%ebx
     155:	03 45 80             	add    -0x80(%ebp),%eax
     158:	89 4d a8             	mov    %ecx,-0x58(%ebp)
     15b:	8b 8d 70 ff ff ff    	mov    -0x90(%ebp),%ecx
     161:	89 45 98             	mov    %eax,-0x68(%ebp)
     164:	89 cf                	mov    %ecx,%edi
     166:	eb 50                	jmp    1b8 <main+0x1b8>
     168:	90                   	nop
     169:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		
		if ( pipe(fd_cor_child[i]) < 0 ){
			printf(1,"pipe 1 not created successfully");
		}
		if(pipe(fd_child_cor[i])<0){
     170:	83 ec 0c             	sub    $0xc,%esp
     173:	57                   	push   %edi
     174:	e8 09 12 00 00       	call   1382 <pipe>
     179:	83 c4 10             	add    $0x10,%esp
     17c:	85 c0                	test   %eax,%eax
     17e:	78 6a                	js     1ea <main+0x1ea>
			printf(1,"pipe not created succesfully");
		}
		if(pipe(child_sends_lower[i]) < 0 ){
     180:	83 ec 0c             	sub    $0xc,%esp
     183:	ff 75 a8             	pushl  -0x58(%ebp)
     186:	e8 f7 11 00 00       	call   1382 <pipe>
     18b:	83 c4 10             	add    $0x10,%esp
     18e:	85 c0                	test   %eax,%eax
     190:	0f 88 82 00 00 00    	js     218 <main+0x218>
			printf(1,"pipe 3 not created successfully");
		}
		if(pipe(child_sends_upper[i]) < 0 ){
     196:	83 ec 0c             	sub    $0xc,%esp
     199:	56                   	push   %esi
     19a:	e8 e3 11 00 00       	call   1382 <pipe>
     19f:	83 c4 10             	add    $0x10,%esp
     1a2:	85 c0                	test   %eax,%eax
     1a4:	78 5a                	js     200 <main+0x200>
     1a6:	83 c3 08             	add    $0x8,%ebx
     1a9:	83 c6 08             	add    $0x8,%esi
     1ac:	83 45 a8 08          	addl   $0x8,-0x58(%ebp)
     1b0:	83 c7 08             	add    $0x8,%edi
	for(int i=0;i<P;i++){
     1b3:	3b 5d 98             	cmp    -0x68(%ebp),%ebx
     1b6:	74 77                	je     22f <main+0x22f>
		if ( pipe(fd_cor_child[i]) < 0 ){
     1b8:	83 ec 0c             	sub    $0xc,%esp
     1bb:	53                   	push   %ebx
     1bc:	e8 c1 11 00 00       	call   1382 <pipe>
     1c1:	83 c4 10             	add    $0x10,%esp
     1c4:	85 c0                	test   %eax,%eax
     1c6:	79 a8                	jns    170 <main+0x170>
			printf(1,"pipe 1 not created successfully");
     1c8:	83 ec 08             	sub    $0x8,%esp
     1cb:	68 a8 18 00 00       	push   $0x18a8
     1d0:	6a 01                	push   $0x1
     1d2:	e8 49 13 00 00       	call   1520 <printf>
     1d7:	83 c4 10             	add    $0x10,%esp
		if(pipe(fd_child_cor[i])<0){
     1da:	83 ec 0c             	sub    $0xc,%esp
     1dd:	57                   	push   %edi
     1de:	e8 9f 11 00 00       	call   1382 <pipe>
     1e3:	83 c4 10             	add    $0x10,%esp
     1e6:	85 c0                	test   %eax,%eax
     1e8:	79 96                	jns    180 <main+0x180>
			printf(1,"pipe not created succesfully");
     1ea:	83 ec 08             	sub    $0x8,%esp
     1ed:	68 84 18 00 00       	push   $0x1884
     1f2:	6a 01                	push   $0x1
     1f4:	e8 27 13 00 00       	call   1520 <printf>
     1f9:	83 c4 10             	add    $0x10,%esp
     1fc:	eb 82                	jmp    180 <main+0x180>
     1fe:	66 90                	xchg   %ax,%ax
			printf(1,"pipe 4 not created successfully");
     200:	83 ec 08             	sub    $0x8,%esp
     203:	68 e8 18 00 00       	push   $0x18e8
     208:	6a 01                	push   $0x1
     20a:	e8 11 13 00 00       	call   1520 <printf>
     20f:	83 c4 10             	add    $0x10,%esp
     212:	eb 92                	jmp    1a6 <main+0x1a6>
     214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
			printf(1,"pipe 3 not created successfully");
     218:	83 ec 08             	sub    $0x8,%esp
     21b:	68 c8 18 00 00       	push   $0x18c8
     220:	6a 01                	push   $0x1
     222:	e8 f9 12 00 00       	call   1520 <printf>
     227:	83 c4 10             	add    $0x10,%esp
     22a:	e9 67 ff ff ff       	jmp    196 <main+0x196>
     22f:	8b bd 68 ff ff ff    	mov    -0x98(%ebp),%edi
     235:	8b 45 8c             	mov    -0x74(%ebp),%eax
     238:	89 45 a8             	mov    %eax,-0x58(%ebp)

	int count=0;
	mean = 0.0;

	/* Set boundary values and compute mean boundary values */
	for (i = 0; i < N; i++){
     23b:	85 c0                	test   %eax,%eax
     23d:	db 45 a8             	fildl  -0x58(%ebp)
     240:	d8 0d d0 19 00 00    	fmuls  0x19d0
     246:	0f 8e 17 0d 00 00    	jle    f63 <main+0xf63>
		u[i][0] = u[i][N-1] = u[0][i] = T;
     24c:	8b 45 9c             	mov    -0x64(%ebp),%eax
     24f:	8b 55 a0             	mov    -0x60(%ebp),%edx
	mean = 0.0;
     252:	d9 ee                	fldz   
		u[i][0] = u[i][N-1] = u[0][i] = T;
     254:	89 c1                	mov    %eax,%ecx
     256:	8d 70 fc             	lea    -0x4(%eax),%esi
	for (i = 0; i < N; i++){
     259:	31 c0                	xor    %eax,%eax
		u[i][0] = u[i][N-1] = u[0][i] = T;
     25b:	c1 e9 02             	shr    $0x2,%ecx
     25e:	0f af f1             	imul   %ecx,%esi
	mean = 0.0;
     261:	89 4d a8             	mov    %ecx,-0x58(%ebp)
     264:	01 d6                	add    %edx,%esi
     266:	8d 76 00             	lea    0x0(%esi),%esi
     269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		u[i][0] = u[i][N-1] = u[0][i] = T;
     270:	8b 5d a8             	mov    -0x58(%ebp),%ebx
     273:	d9 45 a4             	flds   -0x5c(%ebp)
     276:	d9 14 82             	fsts   (%edx,%eax,4)
     279:	0f af d8             	imul   %eax,%ebx
     27c:	8d 0c 3b             	lea    (%ebx,%edi,1),%ecx
     27f:	8d 1c 9a             	lea    (%edx,%ebx,4),%ebx
     282:	d9 14 8a             	fsts   (%edx,%ecx,4)
     285:	d9 1b                	fstps  (%ebx)
		u[N-1][i] = 0.0;
     287:	d9 ee                	fldz   
     289:	d9 14 86             	fsts   (%esi,%eax,4)
		mean += u[i][0] + u[i][N-1] + u[0][i] + u[N-1][i];
     28c:	d9 03                	flds   (%ebx)
     28e:	d8 04 8a             	fadds  (%edx,%ecx,4)
     291:	d8 04 82             	fadds  (%edx,%eax,4)
	for (i = 0; i < N; i++){
     294:	83 c0 01             	add    $0x1,%eax
     297:	3b 45 8c             	cmp    -0x74(%ebp),%eax
		mean += u[i][0] + u[i][N-1] + u[0][i] + u[N-1][i];
     29a:	de c1                	faddp  %st,%st(1)
     29c:	de c1                	faddp  %st,%st(1)
	for (i = 0; i < N; i++){
     29e:	75 d0                	jne    270 <main+0x270>
	}
	mean /= (4.0 * N);
     2a0:	de f1                	fdivp  %st,%st(1)

	/* Initialize Interior Values */
	for (i = 1; i < N-1; i++ )
     2a2:	83 ff 01             	cmp    $0x1,%edi
     2a5:	8b 4d a8             	mov    -0x58(%ebp),%ecx
	mean /= (4.0 * N);
     2a8:	d9 5d b4             	fstps  -0x4c(%ebp)
     2ab:	d9 45 b4             	flds   -0x4c(%ebp)
	for (i = 1; i < N-1; i++ )
     2ae:	7e 3e                	jle    2ee <main+0x2ee>
     2b0:	8b 45 a0             	mov    -0x60(%ebp),%eax
     2b3:	8d 34 8d 00 00 00 00 	lea    0x0(,%ecx,4),%esi
	mean = 0.0;
     2ba:	bb 01 00 00 00       	mov    $0x1,%ebx
     2bf:	8d 14 30             	lea    (%eax,%esi,1),%edx
     2c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
		for ( j= 1; j < N-1; j++) u[i][j] = mean;
     2c8:	b8 01 00 00 00       	mov    $0x1,%eax
     2cd:	8d 76 00             	lea    0x0(%esi),%esi
     2d0:	d9 14 82             	fsts   (%edx,%eax,4)
     2d3:	83 c0 01             	add    $0x1,%eax
     2d6:	39 c7                	cmp    %eax,%edi
     2d8:	7f f6                	jg     2d0 <main+0x2d0>
	for (i = 1; i < N-1; i++ )
     2da:	83 c3 01             	add    $0x1,%ebx
     2dd:	01 f2                	add    %esi,%edx
     2df:	39 df                	cmp    %ebx,%edi
     2e1:	7f e5                	jg     2c8 <main+0x2c8>
     2e3:	dd d8                	fstp   %st(0)
	
	for (i = 0; i < N; i++ )
     2e5:	8b 75 8c             	mov    -0x74(%ebp),%esi
     2e8:	85 f6                	test   %esi,%esi
     2ea:	7e 43                	jle    32f <main+0x32f>
     2ec:	eb 02                	jmp    2f0 <main+0x2f0>
     2ee:	dd d8                	fstp   %st(0)
     2f0:	8d 34 8d 00 00 00 00 	lea    0x0(,%ecx,4),%esi
		for ( j= 1; j < N-1; j++) u[i][j] = mean;
     2f7:	89 7d a8             	mov    %edi,-0x58(%ebp)
     2fa:	8b 4d a0             	mov    -0x60(%ebp),%ecx
     2fd:	8b 55 94             	mov    -0x6c(%ebp),%edx
     300:	8b 7d 8c             	mov    -0x74(%ebp),%edi
     303:	31 db                	xor    %ebx,%ebx
     305:	8d 76 00             	lea    0x0(%esi),%esi
		for ( j= 0; j < N; j++) u_serial[i][j] = u[i][j];
     308:	31 c0                	xor    %eax,%eax
     30a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     310:	d9 04 81             	flds   (%ecx,%eax,4)
     313:	d9 1c 82             	fstps  (%edx,%eax,4)
     316:	83 c0 01             	add    $0x1,%eax
     319:	39 f8                	cmp    %edi,%eax
     31b:	7c f3                	jl     310 <main+0x310>
	for (i = 0; i < N; i++ )
     31d:	83 c3 01             	add    $0x1,%ebx
     320:	01 f1                	add    %esi,%ecx
     322:	01 f2                	add    %esi,%edx
     324:	39 fb                	cmp    %edi,%ebx
     326:	7c e0                	jl     308 <main+0x308>
     328:	8b 7d a8             	mov    -0x58(%ebp),%edi
     32b:	eb 02                	jmp    32f <main+0x32f>
     32d:	dd d8                	fstp   %st(0)

	if(P==1){
     32f:	83 7d 90 01          	cmpl   $0x1,-0x70(%ebp)
     333:	0f 85 bb 01 00 00    	jne    4f4 <main+0x4f4>
		/* Compute Steady State Values */	
		for(;;){
			diff = 0.0;
			for(i =1 ; i < N-1; i++){
				for(j =1 ; j < N-1; j++){
					w_serial[i][j] = ( u_serial[i-1][j] + u_serial[i+1][j]+
     339:	8b 45 9c             	mov    -0x64(%ebp),%eax
     33c:	8b 75 94             	mov    -0x6c(%ebp),%esi
	int count=0;
     33f:	c7 45 88 00 00 00 00 	movl   $0x0,-0x78(%ebp)
     346:	01 c6                	add    %eax,%esi
					w_serial[i][j] = ( u_serial[i-1][j] + u_serial[i+1][j]+
     348:	89 c1                	mov    %eax,%ecx
     34a:	89 75 80             	mov    %esi,-0x80(%ebp)
     34d:	8b b5 64 ff ff ff    	mov    -0x9c(%ebp),%esi
     353:	c1 e9 02             	shr    $0x2,%ecx
     356:	89 4d 90             	mov    %ecx,-0x70(%ebp)
     359:	01 c6                	add    %eax,%esi
     35b:	89 75 84             	mov    %esi,-0x7c(%ebp)
			for(i =1 ; i < N-1; i++){
     35e:	83 ff 01             	cmp    $0x1,%edi
     361:	0f 8e 12 01 00 00    	jle    479 <main+0x479>
     367:	8b 45 80             	mov    -0x80(%ebp),%eax
     36a:	8b 75 84             	mov    -0x7c(%ebp),%esi
			diff = 0.0;
     36d:	d9 ee                	fldz   
			for(i =1 ; i < N-1; i++){
     36f:	c7 45 a8 01 00 00 00 	movl   $0x1,-0x58(%ebp)
     376:	c7 45 a0 00 00 00 00 	movl   $0x0,-0x60(%ebp)
     37d:	89 45 a4             	mov    %eax,-0x5c(%ebp)
     380:	b8 01 00 00 00       	mov    $0x1,%eax
     385:	8d 76 00             	lea    0x0(%esi),%esi
     388:	8b 55 90             	mov    -0x70(%ebp),%edx
     38b:	8d 48 01             	lea    0x1(%eax),%ecx
     38e:	8b 5d 94             	mov    -0x6c(%ebp),%ebx
     391:	89 4d 98             	mov    %ecx,-0x68(%ebp)
     394:	2b 4d a8             	sub    -0x58(%ebp),%ecx
     397:	0f af c2             	imul   %edx,%eax
     39a:	d9 44 83 04          	flds   0x4(%ebx,%eax,4)
     39e:	8b 5d a0             	mov    -0x60(%ebp),%ebx
     3a1:	2b 5d a8             	sub    -0x58(%ebp),%ebx
			diff = 0.0;
     3a4:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     3a7:	0f af ca             	imul   %edx,%ecx
     3aa:	0f af da             	imul   %edx,%ebx
				for(j =1 ; j < N-1; j++){
     3ad:	ba 01 00 00 00       	mov    $0x1,%edx
     3b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
							u_serial[i][j-1] + u_serial[i][j+1])/4.0;
     3b8:	d9 40 08             	flds   0x8(%eax)
     3bb:	83 c2 01             	add    $0x1,%edx
					w_serial[i][j] = ( u_serial[i-1][j] + u_serial[i+1][j]+
     3be:	d9 44 98 04          	flds   0x4(%eax,%ebx,4)
     3c2:	d8 44 88 04          	fadds  0x4(%eax,%ecx,4)
     3c6:	d8 00                	fadds  (%eax)
							u_serial[i][j-1] + u_serial[i][j+1])/4.0;
     3c8:	d8 c1                	fadd   %st(1),%st
					w_serial[i][j] = ( u_serial[i-1][j] + u_serial[i+1][j]+
     3ca:	d8 0d d4 19 00 00    	fmuls  0x19d4
     3d0:	d9 54 96 fc          	fsts   -0x4(%esi,%edx,4)
					if( fabsm(w_serial[i][j] - u_serial[i][j]) > diff )
     3d4:	de e2                	fsubp  %st,%st(2)
	if(a<0){
     3d6:	d9 ee                	fldz   
     3d8:	df ea                	fucomip %st(2),%st
     3da:	76 0c                	jbe    3e8 <main+0x3e8>
     3dc:	d9 c9                	fxch   %st(1)
		return -1*a;
     3de:	d9 e0                	fchs   
     3e0:	eb 08                	jmp    3ea <main+0x3ea>
     3e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     3e8:	d9 c9                	fxch   %st(1)
						diff = fabsm(w_serial[i][j]- u_serial[i][j]);	
     3ea:	db ea                	fucomi %st(2),%st
     3ec:	da d2                	fcmovbe %st(2),%st
     3ee:	dd da                	fstp   %st(2)
     3f0:	83 c0 04             	add    $0x4,%eax
				for(j =1 ; j < N-1; j++){
     3f3:	39 d7                	cmp    %edx,%edi
     3f5:	75 c1                	jne    3b8 <main+0x3b8>
     3f7:	dd d8                	fstp   %st(0)
     3f9:	8b 5d 9c             	mov    -0x64(%ebp),%ebx
     3fc:	8b 45 98             	mov    -0x68(%ebp),%eax
     3ff:	83 45 a0 01          	addl   $0x1,-0x60(%ebp)
     403:	83 45 a8 01          	addl   $0x1,-0x58(%ebp)
     407:	01 5d a4             	add    %ebx,-0x5c(%ebp)
     40a:	01 de                	add    %ebx,%esi
			for(i =1 ; i < N-1; i++){
     40c:	39 c7                	cmp    %eax,%edi
     40e:	0f 85 74 ff ff ff    	jne    388 <main+0x388>
				}
			}
			count++;
			if(diff<= E || count > L){ 
     414:	d9 85 7c ff ff ff    	flds   -0x84(%ebp)
			count++;
     41a:	83 45 88 01          	addl   $0x1,-0x78(%ebp)
			if(diff<= E || count > L){ 
     41e:	df e9                	fucomip %st(1),%st
     420:	dd d8                	fstp   %st(0)
			count++;
     422:	8b 45 88             	mov    -0x78(%ebp),%eax
			if(diff<= E || count > L){ 
     425:	73 56                	jae    47d <main+0x47d>
     427:	39 85 78 ff ff ff    	cmp    %eax,-0x88(%ebp)
     42d:	7c 4e                	jl     47d <main+0x47d>
				// printf("count : %d\n",count);
				break;
			}
			for (i =1; i< N-1; i++)	
     42f:	83 ff 01             	cmp    $0x1,%edi
     432:	0f 8e 26 ff ff ff    	jle    35e <main+0x35e>
     438:	8b 4d 80             	mov    -0x80(%ebp),%ecx
     43b:	8b 55 84             	mov    -0x7c(%ebp),%edx
     43e:	bb 01 00 00 00       	mov    $0x1,%ebx
     443:	8b 75 9c             	mov    -0x64(%ebp),%esi
     446:	8d 76 00             	lea    0x0(%esi),%esi
     449:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
				for (j =1; j< N-1; j++) u_serial[i][j] = w_serial[i][j];
     450:	b8 01 00 00 00       	mov    $0x1,%eax
     455:	8d 76 00             	lea    0x0(%esi),%esi
     458:	d9 04 82             	flds   (%edx,%eax,4)
     45b:	d9 1c 81             	fstps  (%ecx,%eax,4)
     45e:	83 c0 01             	add    $0x1,%eax
     461:	39 c7                	cmp    %eax,%edi
     463:	75 f3                	jne    458 <main+0x458>
			for (i =1; i< N-1; i++)	
     465:	83 c3 01             	add    $0x1,%ebx
     468:	01 f2                	add    %esi,%edx
     46a:	01 f1                	add    %esi,%ecx
     46c:	39 fb                	cmp    %edi,%ebx
     46e:	75 e0                	jne    450 <main+0x450>
			for(i =1 ; i < N-1; i++){
     470:	83 ff 01             	cmp    $0x1,%edi
     473:	0f 8f ee fe ff ff    	jg     367 <main+0x367>
			diff = 0.0;
     479:	d9 ee                	fldz   
     47b:	eb 97                	jmp    414 <main+0x414>
		}

		// printf(1,"serial values :\n");
		for(i =0; i <N; i++){
     47d:	83 7d 8c 00          	cmpl   $0x0,-0x74(%ebp)
     481:	7e 6c                	jle    4ef <main+0x4ef>
     483:	8b 5d 94             	mov    -0x6c(%ebp),%ebx
     486:	8b 7d 8c             	mov    -0x74(%ebp),%edi
     489:	31 f6                	xor    %esi,%esi
     48b:	89 75 a8             	mov    %esi,-0x58(%ebp)
     48e:	66 90                	xchg   %ax,%ax
			for(j = 0; j<N; j++)
     490:	31 f6                	xor    %esi,%esi
     492:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
				printf(1,"%d ",((int)u_serial[i][j]));
     498:	d9 04 b3             	flds   (%ebx,%esi,4)
     49b:	d9 7d b2             	fnstcw -0x4e(%ebp)
     49e:	0f b7 55 b2          	movzwl -0x4e(%ebp),%edx
     4a2:	83 ec 04             	sub    $0x4,%esp
			for(j = 0; j<N; j++)
     4a5:	83 c6 01             	add    $0x1,%esi
				printf(1,"%d ",((int)u_serial[i][j]));
     4a8:	80 ce 0c             	or     $0xc,%dh
     4ab:	66 89 55 b0          	mov    %dx,-0x50(%ebp)
     4af:	d9 6d b0             	fldcw  -0x50(%ebp)
     4b2:	db 5d ac             	fistpl -0x54(%ebp)
     4b5:	d9 6d b2             	fldcw  -0x4e(%ebp)
     4b8:	8b 55 ac             	mov    -0x54(%ebp),%edx
     4bb:	52                   	push   %edx
     4bc:	68 a1 18 00 00       	push   $0x18a1
     4c1:	6a 01                	push   $0x1
     4c3:	e8 58 10 00 00       	call   1520 <printf>
			for(j = 0; j<N; j++)
     4c8:	83 c4 10             	add    $0x10,%esp
     4cb:	39 fe                	cmp    %edi,%esi
     4cd:	75 c9                	jne    498 <main+0x498>
			printf(1,"\n");
     4cf:	83 ec 08             	sub    $0x8,%esp
     4d2:	68 a5 18 00 00       	push   $0x18a5
     4d7:	6a 01                	push   $0x1
     4d9:	e8 42 10 00 00       	call   1520 <printf>
		for(i =0; i <N; i++){
     4de:	83 45 a8 01          	addl   $0x1,-0x58(%ebp)
     4e2:	03 5d 9c             	add    -0x64(%ebp),%ebx
     4e5:	83 c4 10             	add    $0x10,%esp
     4e8:	8b 45 a8             	mov    -0x58(%ebp),%eax
     4eb:	39 f8                	cmp    %edi,%eax
     4ed:	75 a1                	jne    490 <main+0x490>
		}

		exit();
     4ef:	e8 7e 0e 00 00       	call   1372 <exit>
	// printf("Sh : %ld \n",(long int)shmpointer);
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	///////////////////////////////////CHILD PROCESS /////////////////////////////////////////////////////////
	//////////////////////////////////////////////////////////////////////////////////////////////////////////
	// int coordinator_msg_id = msgget(getpid(), PERMS | IPC_CREAT);
    int coordinator_id  = getpid();
     4f4:	e8 f9 0e 00 00       	call   13f2 <getpid>
	for(int i=0;i<P;i++){
     4f9:	8b 75 90             	mov    -0x70(%ebp),%esi
    int coordinator_id  = getpid();
     4fc:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
	for(int i=0;i<P;i++){
     502:	85 f6                	test   %esi,%esi
     504:	0f 8e ff 05 00 00    	jle    b09 <main+0xb09>
     50a:	31 db                	xor    %ebx,%ebx
     50c:	eb 14                	jmp    522 <main+0x522>
     50e:	66 90                	xchg   %ax,%ax
				}
			}
			exit();
		}
		// msgqids[i] =  msgget(tc, PERMS | IPC_CREAT);
		rec_pids[i] = tc;
     510:	89 04 9d e0 1d 00 00 	mov    %eax,0x1de0(,%ebx,4)
	for(int i=0;i<P;i++){
     517:	83 c3 01             	add    $0x1,%ebx
     51a:	39 f3                	cmp    %esi,%ebx
     51c:	0f 84 a7 05 00 00    	je     ac9 <main+0xac9>
		int tc = fork();
     522:	e8 43 0e 00 00       	call   136a <fork>
		if(tc==0){
     527:	85 c0                	test   %eax,%eax
     529:	75 e5                	jne    510 <main+0x510>
     52b:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
     531:	89 de                	mov    %ebx,%esi
     533:	89 5d 80             	mov    %ebx,-0x80(%ebp)
     536:	8d 04 d8             	lea    (%eax,%ebx,8),%eax
			read(fd_cor_child[i][0],buf,sizeof(buf));
     539:	53                   	push   %ebx
     53a:	6a 10                	push   $0x10
     53c:	89 c1                	mov    %eax,%ecx
     53e:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
     544:	8d 45 b8             	lea    -0x48(%ebp),%eax
     547:	50                   	push   %eax
     548:	ff 31                	pushl  (%ecx)
     54a:	e8 3b 0e 00 00       	call   138a <read>
	int divtemp = n/nt;
     54f:	8b 45 8c             	mov    -0x74(%ebp),%eax
	if(i<=remtemp){
     552:	83 c4 10             	add    $0x10,%esp
	int divtemp = n/nt;
     555:	99                   	cltd   
     556:	f7 7d 90             	idivl  -0x70(%ebp)
	if(i<=remtemp){
     559:	39 f2                	cmp    %esi,%edx
	int divtemp = n/nt;
     55b:	89 d1                	mov    %edx,%ecx
	if(i<=remtemp){
     55d:	0f 8f 49 08 00 00    	jg     dac <main+0xdac>
		return (divtemp)*(i-1) + remtemp;
     563:	8b 55 80             	mov    -0x80(%ebp),%edx
     566:	0f af d0             	imul   %eax,%edx
     569:	8d 34 0a             	lea    (%edx,%ecx,1),%esi
     56c:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%ebp)
				if((start+numA)!=N){
     572:	8b 95 74 ff ff ff    	mov    -0x8c(%ebp),%edx
     578:	89 c6                	mov    %eax,%esi
						a[2] = (float)u[start][t];
     57a:	8b 5d 9c             	mov    -0x64(%ebp),%ebx
				if((start+numA)!=N){
     57d:	01 d6                	add    %edx,%esi
						a[2] = (float)u[start][t];
     57f:	89 d9                	mov    %ebx,%ecx
					int tosend = start+numA-1;
     581:	8d 46 ff             	lea    -0x1(%esi),%eax
						a[2] = (float)u[start][t];
     584:	c1 e9 02             	shr    $0x2,%ecx
     587:	39 f7                	cmp    %esi,%edi
				if((start+numA)!=N){
     589:	89 b5 60 ff ff ff    	mov    %esi,-0xa0(%ebp)
						a[2] = (float)u[start][t];
     58f:	89 8d 7c ff ff ff    	mov    %ecx,-0x84(%ebp)
					int tosend = start+numA-1;
     595:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
     59b:	89 f0                	mov    %esi,%eax
     59d:	0f 4e c7             	cmovle %edi,%eax
     5a0:	89 45 a4             	mov    %eax,-0x5c(%ebp)
     5a3:	89 d0                	mov    %edx,%eax
     5a5:	0f af c3             	imul   %ebx,%eax
     5a8:	03 45 a0             	add    -0x60(%ebp),%eax
								u[start+numA][(int)buf[1]] = buf[2];
     5ab:	0f af f1             	imul   %ecx,%esi
     5ae:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
     5b4:	89 b5 68 ff ff ff    	mov    %esi,-0x98(%ebp)
				if(start!=0){
     5ba:	8b 8d 74 ff ff ff    	mov    -0x8c(%ebp),%ecx
     5c0:	85 c9                	test   %ecx,%ecx
     5c2:	0f 85 ef 03 00 00    	jne    9b7 <main+0x9b7>
				if((start+numA)!=N){
     5c8:	8b 75 8c             	mov    -0x74(%ebp),%esi
     5cb:	39 b5 60 ff ff ff    	cmp    %esi,-0xa0(%ebp)
     5d1:	0f 84 23 08 00 00    	je     dfa <main+0xdfa>
					for(int t=1;t<N-1;t++){
     5d7:	83 ff 01             	cmp    $0x1,%edi
     5da:	0f 8e 1f 08 00 00    	jle    dff <main+0xdff>
     5e0:	8b b5 5c ff ff ff    	mov    -0xa4(%ebp),%esi
					int tosend = start+numA-1;
     5e6:	bb 01 00 00 00       	mov    $0x1,%ebx
     5eb:	0f af 75 9c          	imul   -0x64(%ebp),%esi
     5ef:	89 d8                	mov    %ebx,%eax
     5f1:	03 75 a0             	add    -0x60(%ebp),%esi
     5f4:	89 f3                	mov    %esi,%ebx
     5f6:	89 c6                	mov    %eax,%esi
     5f8:	90                   	nop
     5f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
						a[1] = t;
     600:	89 75 a8             	mov    %esi,-0x58(%ebp)
						write(child_sends_lower[i][1],a,sizeof(a));
     603:	8d 45 d8             	lea    -0x28(%ebp),%eax
     606:	83 ec 04             	sub    $0x4,%esp
						a[1] = t;
     609:	db 45 a8             	fildl  -0x58(%ebp)
						write(child_sends_lower[i][1],a,sizeof(a));
     60c:	8b 4d 80             	mov    -0x80(%ebp),%ecx
						a[0] = -1;
     60f:	c7 45 d8 00 00 80 bf 	movl   $0xbf800000,-0x28(%ebp)
                        a[3] = GHOSTVALUE;
     616:	c7 45 e4 00 00 00 40 	movl   $0x40000000,-0x1c(%ebp)
						a[1] = t;
     61d:	d9 5d dc             	fstps  -0x24(%ebp)
						a[2] = (float)u[tosend][t];
     620:	d9 04 b3             	flds   (%ebx,%esi,4)
					for(int t=1;t<N-1;t++){
     623:	83 c6 01             	add    $0x1,%esi
						write(child_sends_lower[i][1],a,sizeof(a));
     626:	6a 10                	push   $0x10
     628:	50                   	push   %eax
     629:	8b 45 88             	mov    -0x78(%ebp),%eax
						a[2] = (float)u[tosend][t];
     62c:	d9 5d e0             	fstps  -0x20(%ebp)
						write(child_sends_lower[i][1],a,sizeof(a));
     62f:	ff 74 c8 04          	pushl  0x4(%eax,%ecx,8)
     633:	e8 5a 0d 00 00       	call   1392 <write>
					for(int t=1;t<N-1;t++){
     638:	83 c4 10             	add    $0x10,%esp
     63b:	39 f7                	cmp    %esi,%edi
     63d:	7f c1                	jg     600 <main+0x600>
				if(start==0){
     63f:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
     645:	85 c0                	test   %eax,%eax
     647:	0f 84 c1 07 00 00    	je     e0e <main+0xe0e>
					for(int t=1;t<N-1;t++){
     64d:	83 ff 01             	cmp    $0x1,%edi
     650:	0f 8e 71 01 00 00    	jle    7c7 <main+0x7c7>
     656:	8b 45 80             	mov    -0x80(%ebp),%eax
     659:	bb 01 00 00 00       	mov    $0x1,%ebx
     65e:	8d 70 01             	lea    0x1(%eax),%esi
								u[start-1][(int)buf[1]] = buf[2];
     661:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
     667:	83 e8 01             	sub    $0x1,%eax
     66a:	0f af 85 7c ff ff ff 	imul   -0x84(%ebp),%eax
     671:	89 45 a8             	mov    %eax,-0x58(%ebp)
     674:	eb 44                	jmp    6ba <main+0x6ba>
     676:	8d 76 00             	lea    0x0(%esi),%esi
     679:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     680:	d9 45 dc             	flds   -0x24(%ebp)
     683:	d9 6d b0             	fldcw  -0x50(%ebp)
     686:	db 5d ac             	fistpl -0x54(%ebp)
     689:	d9 6d b2             	fldcw  -0x4e(%ebp)
     68c:	8b 45 ac             	mov    -0x54(%ebp),%eax
     68f:	d9 45 e0             	flds   -0x20(%ebp)
							if((int)buf[0]==1){
     692:	d9 45 d8             	flds   -0x28(%ebp)
     695:	d9 6d b0             	fldcw  -0x50(%ebp)
     698:	db 5d ac             	fistpl -0x54(%ebp)
     69b:	d9 6d b2             	fldcw  -0x4e(%ebp)
     69e:	8b 55 ac             	mov    -0x54(%ebp),%edx
     6a1:	83 fa 01             	cmp    $0x1,%edx
     6a4:	0f 84 2e 07 00 00    	je     dd8 <main+0xdd8>
								u[start-1][(int)buf[1]] = buf[2];
     6aa:	03 45 a8             	add    -0x58(%ebp),%eax
     6ad:	8b 4d a0             	mov    -0x60(%ebp),%ecx
     6b0:	d9 1c 81             	fstps  (%ecx,%eax,4)
					for(int t=1;t<N-1;t++){
     6b3:	83 c3 01             	add    $0x1,%ebx
     6b6:	39 df                	cmp    %ebx,%edi
     6b8:	74 52                	je     70c <main+0x70c>
						read(child_sends_upper[i+1][0],buf,sizeof(buf));
     6ba:	8d 45 d8             	lea    -0x28(%ebp),%eax
     6bd:	83 ec 04             	sub    $0x4,%esp
     6c0:	6a 10                	push   $0x10
     6c2:	50                   	push   %eax
     6c3:	8b 45 84             	mov    -0x7c(%ebp),%eax
     6c6:	ff 34 f0             	pushl  (%eax,%esi,8)
     6c9:	e8 bc 0c 00 00       	call   138a <read>
						if((int)buf[3] ==GHOSTVALUE){
     6ce:	d9 7d b2             	fnstcw -0x4e(%ebp)
     6d1:	0f b7 45 b2          	movzwl -0x4e(%ebp),%eax
     6d5:	d9 45 e4             	flds   -0x1c(%ebp)
     6d8:	83 c4 10             	add    $0x10,%esp
     6db:	80 cc 0c             	or     $0xc,%ah
     6de:	66 89 45 b0          	mov    %ax,-0x50(%ebp)
     6e2:	d9 6d b0             	fldcw  -0x50(%ebp)
     6e5:	db 5d ac             	fistpl -0x54(%ebp)
     6e8:	d9 6d b2             	fldcw  -0x4e(%ebp)
     6eb:	8b 45 ac             	mov    -0x54(%ebp),%eax
     6ee:	83 f8 02             	cmp    $0x2,%eax
     6f1:	74 8d                	je     680 <main+0x680>
							printf(1,"Received wrong message instead of ghostvalue\n");
     6f3:	83 ec 08             	sub    $0x8,%esp
					for(int t=1;t<N-1;t++){
     6f6:	83 c3 01             	add    $0x1,%ebx
							printf(1,"Received wrong message instead of ghostvalue\n");
     6f9:	68 08 19 00 00       	push   $0x1908
     6fe:	6a 01                	push   $0x1
     700:	e8 1b 0e 00 00       	call   1520 <printf>
     705:	83 c4 10             	add    $0x10,%esp
					for(int t=1;t<N-1;t++){
     708:	39 df                	cmp    %ebx,%edi
     70a:	75 ae                	jne    6ba <main+0x6ba>
     70c:	8b 45 80             	mov    -0x80(%ebp),%eax
								u[start-1][(int)buf[1]] = buf[2];
     70f:	89 7d 98             	mov    %edi,-0x68(%ebp)
					for(int t=1;t<N-1;t++){
     712:	be 01 00 00 00       	mov    $0x1,%esi
     717:	8d 48 ff             	lea    -0x1(%eax),%ecx
								u[start-1][(int)buf[1]] = buf[2];
     71a:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
     720:	89 cf                	mov    %ecx,%edi
     722:	83 e8 01             	sub    $0x1,%eax
     725:	0f af 85 7c ff ff ff 	imul   -0x84(%ebp),%eax
     72c:	89 45 a8             	mov    %eax,-0x58(%ebp)
     72f:	eb 41                	jmp    772 <main+0x772>
     731:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     738:	d9 45 dc             	flds   -0x24(%ebp)
     73b:	d9 6d b0             	fldcw  -0x50(%ebp)
     73e:	db 5d ac             	fistpl -0x54(%ebp)
     741:	d9 6d b2             	fldcw  -0x4e(%ebp)
     744:	8b 45 ac             	mov    -0x54(%ebp),%eax
     747:	d9 45 e0             	flds   -0x20(%ebp)
							if((int)buf[0]==1){
     74a:	d9 45 d8             	flds   -0x28(%ebp)
     74d:	d9 6d b0             	fldcw  -0x50(%ebp)
     750:	db 5d ac             	fistpl -0x54(%ebp)
     753:	d9 6d b2             	fldcw  -0x4e(%ebp)
     756:	8b 55 ac             	mov    -0x54(%ebp),%edx
     759:	83 fa 01             	cmp    $0x1,%edx
     75c:	0f 84 87 06 00 00    	je     de9 <main+0xde9>
								u[start-1][(int)buf[1]] = buf[2];
     762:	03 45 a8             	add    -0x58(%ebp),%eax
     765:	8b 4d a0             	mov    -0x60(%ebp),%ecx
     768:	d9 1c 81             	fstps  (%ecx,%eax,4)
					for(int t=1;t<N-1;t++){
     76b:	83 c6 01             	add    $0x1,%esi
     76e:	39 de                	cmp    %ebx,%esi
     770:	74 52                	je     7c4 <main+0x7c4>
						read(child_sends_lower[i-1][0],buf,sizeof(buf));
     772:	8d 45 d8             	lea    -0x28(%ebp),%eax
     775:	83 ec 04             	sub    $0x4,%esp
     778:	6a 10                	push   $0x10
     77a:	50                   	push   %eax
     77b:	8b 45 88             	mov    -0x78(%ebp),%eax
     77e:	ff 34 f8             	pushl  (%eax,%edi,8)
     781:	e8 04 0c 00 00       	call   138a <read>
						if((int)buf[3] ==GHOSTVALUE){
     786:	d9 7d b2             	fnstcw -0x4e(%ebp)
     789:	0f b7 45 b2          	movzwl -0x4e(%ebp),%eax
     78d:	d9 45 e4             	flds   -0x1c(%ebp)
     790:	83 c4 10             	add    $0x10,%esp
     793:	80 cc 0c             	or     $0xc,%ah
     796:	66 89 45 b0          	mov    %ax,-0x50(%ebp)
     79a:	d9 6d b0             	fldcw  -0x50(%ebp)
     79d:	db 5d ac             	fistpl -0x54(%ebp)
     7a0:	d9 6d b2             	fldcw  -0x4e(%ebp)
     7a3:	8b 45 ac             	mov    -0x54(%ebp),%eax
     7a6:	83 f8 02             	cmp    $0x2,%eax
     7a9:	74 8d                	je     738 <main+0x738>
							printf(1,"Received wrong message instead of ghostvalue\n");
     7ab:	83 ec 08             	sub    $0x8,%esp
					for(int t=1;t<N-1;t++){
     7ae:	83 c6 01             	add    $0x1,%esi
							printf(1,"Received wrong message instead of ghostvalue\n");
     7b1:	68 08 19 00 00       	push   $0x1908
     7b6:	6a 01                	push   $0x1
     7b8:	e8 63 0d 00 00       	call   1520 <printf>
     7bd:	83 c4 10             	add    $0x10,%esp
					for(int t=1;t<N-1;t++){
     7c0:	39 de                	cmp    %ebx,%esi
     7c2:	75 ae                	jne    772 <main+0x772>
     7c4:	8b 7d 98             	mov    -0x68(%ebp),%edi
     7c7:	8b b5 74 ff ff ff    	mov    -0x8c(%ebp),%esi
     7cd:	b8 01 00 00 00       	mov    $0x1,%eax
     7d2:	85 f6                	test   %esi,%esi
     7d4:	0f 4f c6             	cmovg  %esi,%eax
     7d7:	89 85 78 ff ff ff    	mov    %eax,-0x88(%ebp)
				for(int j=max(start,1);j<min(start+numA,N-1);j++){
     7dd:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
     7e3:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
     7e6:	39 c8                	cmp    %ecx,%eax
     7e8:	0f 8d 6e 07 00 00    	jge    f5c <main+0xf5c>
     7ee:	8b 4d 9c             	mov    -0x64(%ebp),%ecx
     7f1:	8b 75 a0             	mov    -0x60(%ebp),%esi
				float diff1 = 0.0;
     7f4:	d9 ee                	fldz   
     7f6:	89 45 a8             	mov    %eax,-0x58(%ebp)
     7f9:	0f af c8             	imul   %eax,%ecx
     7fc:	01 ce                	add    %ecx,%esi
     7fe:	03 8d 6c ff ff ff    	add    -0x94(%ebp),%ecx
     804:	89 75 90             	mov    %esi,-0x70(%ebp)
     807:	8d 70 ff             	lea    -0x1(%eax),%esi
     80a:	89 75 94             	mov    %esi,-0x6c(%ebp)
     80d:	8d 76 00             	lea    0x0(%esi),%esi
     810:	8d 58 01             	lea    0x1(%eax),%ebx
					for(int k=1;k<N-1;k++){
     813:	83 ff 01             	cmp    $0x1,%edi
     816:	89 5d 98             	mov    %ebx,-0x68(%ebp)
     819:	7e 6e                	jle    889 <main+0x889>
     81b:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
     821:	8b 75 a0             	mov    -0x60(%ebp),%esi
     824:	2b 5d a8             	sub    -0x58(%ebp),%ebx
     827:	0f af c2             	imul   %edx,%eax
     82a:	d9 44 86 04          	flds   0x4(%esi,%eax,4)
     82e:	8b 75 94             	mov    -0x6c(%ebp),%esi
     831:	2b 75 a8             	sub    -0x58(%ebp),%esi
     834:	8b 45 90             	mov    -0x70(%ebp),%eax
     837:	0f af da             	imul   %edx,%ebx
     83a:	0f af f2             	imul   %edx,%esi
     83d:	ba 01 00 00 00       	mov    $0x1,%edx
     842:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
						w[j][k] = ( u[j-1][k] + u[j+1][k]+ u[j][k-1] + u[j][k+1])/4.0;
     848:	d9 40 08             	flds   0x8(%eax)
     84b:	83 c2 01             	add    $0x1,%edx
     84e:	d9 44 b0 04          	flds   0x4(%eax,%esi,4)
     852:	d8 44 98 04          	fadds  0x4(%eax,%ebx,4)
     856:	d8 00                	fadds  (%eax)
     858:	d8 c1                	fadd   %st(1),%st
     85a:	d8 0d d4 19 00 00    	fmuls  0x19d4
     860:	d9 54 91 fc          	fsts   -0x4(%ecx,%edx,4)
						if( fabsm(w[j][k] - u[j][k]) > diff1 ){
     864:	de e2                	fsubp  %st,%st(2)
	if(a<0){
     866:	d9 ee                	fldz   
     868:	df ea                	fucomip %st(2),%st
     86a:	76 0c                	jbe    878 <main+0x878>
     86c:	d9 c9                	fxch   %st(1)
		return -1*a;
     86e:	d9 e0                	fchs   
     870:	eb 08                	jmp    87a <main+0x87a>
     872:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     878:	d9 c9                	fxch   %st(1)
							diff1 = fabsm(w[j][k]- u[j][k]);
     87a:	db ea                	fucomi %st(2),%st
     87c:	da d2                	fcmovbe %st(2),%st
     87e:	dd da                	fstp   %st(2)
     880:	83 c0 04             	add    $0x4,%eax
					for(int k=1;k<N-1;k++){
     883:	39 d7                	cmp    %edx,%edi
     885:	75 c1                	jne    848 <main+0x848>
     887:	dd d8                	fstp   %st(0)
     889:	8b 75 9c             	mov    -0x64(%ebp),%esi
     88c:	83 45 a8 01          	addl   $0x1,-0x58(%ebp)
     890:	01 75 90             	add    %esi,-0x70(%ebp)
     893:	8b 45 98             	mov    -0x68(%ebp),%eax
     896:	83 45 94 01          	addl   $0x1,-0x6c(%ebp)
     89a:	01 f1                	add    %esi,%ecx
				for(int j=max(start,1);j<min(start+numA,N-1);j++){
     89c:	39 45 a4             	cmp    %eax,-0x5c(%ebp)
     89f:	0f 85 6b ff ff ff    	jne    810 <main+0x810>
				write(fd_child_cor[i][1],buf,sizeof(buf));
     8a5:	8d 45 c8             	lea    -0x38(%ebp),%eax
     8a8:	83 ec 04             	sub    $0x4,%esp
     8ab:	8b 4d 80             	mov    -0x80(%ebp),%ecx
     8ae:	6a 10                	push   $0x10
				buf[0] = diff1;
     8b0:	d9 5d c8             	fstps  -0x38(%ebp)
				buf[3] = DIFFERENCE;
     8b3:	c7 45 d4 00 00 40 40 	movl   $0x40400000,-0x2c(%ebp)
				write(fd_child_cor[i][1],buf,sizeof(buf));
     8ba:	50                   	push   %eax
     8bb:	8b 85 70 ff ff ff    	mov    -0x90(%ebp),%eax
				buf[1] = 0;
     8c1:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
				buf[2] = 1;
     8c8:	c7 45 d0 00 00 80 3f 	movl   $0x3f800000,-0x30(%ebp)
				write(fd_child_cor[i][1],buf,sizeof(buf));
     8cf:	ff 74 c8 04          	pushl  0x4(%eax,%ecx,8)
     8d3:	e8 ba 0a 00 00       	call   1392 <write>
				read(fd_cor_child[i][0],readbuf2,sizeof(readbuf2));
     8d8:	8d 45 d8             	lea    -0x28(%ebp),%eax
     8db:	83 c4 0c             	add    $0xc,%esp
     8de:	6a 10                	push   $0x10
     8e0:	50                   	push   %eax
     8e1:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
     8e7:	ff 30                	pushl  (%eax)
     8e9:	e8 9c 0a 00 00       	call   138a <read>
				if((int)readbuf2[3]!= CONTINUE_STOP_CHILD){
     8ee:	d9 7d b2             	fnstcw -0x4e(%ebp)
     8f1:	0f b7 45 b2          	movzwl -0x4e(%ebp),%eax
     8f5:	d9 45 e4             	flds   -0x1c(%ebp)
     8f8:	83 c4 10             	add    $0x10,%esp
     8fb:	80 cc 0c             	or     $0xc,%ah
     8fe:	66 89 45 b0          	mov    %ax,-0x50(%ebp)
     902:	d9 6d b0             	fldcw  -0x50(%ebp)
     905:	db 55 ac             	fistl  -0x54(%ebp)
     908:	d9 6d b2             	fldcw  -0x4e(%ebp)
     90b:	8b 45 ac             	mov    -0x54(%ebp),%eax
     90e:	83 f8 01             	cmp    $0x1,%eax
     911:	74 25                	je     938 <main+0x938>
					printf(1,"received %f instead of continue or stop \n",readbuf2[3]);
     913:	83 ec 08             	sub    $0x8,%esp
     916:	dd 1c 24             	fstpl  (%esp)
     919:	68 38 19 00 00       	push   $0x1938
     91e:	6a 01                	push   $0x1
     920:	e8 fb 0b 00 00       	call   1520 <printf>
     925:	d9 7d b2             	fnstcw -0x4e(%ebp)
     928:	0f b7 45 b2          	movzwl -0x4e(%ebp),%eax
     92c:	83 c4 10             	add    $0x10,%esp
     92f:	80 cc 0c             	or     $0xc,%ah
     932:	66 89 45 b0          	mov    %ax,-0x50(%ebp)
     936:	eb 02                	jmp    93a <main+0x93a>
     938:	dd d8                	fstp   %st(0)
				if((int)readbuf2[0] == -1){
     93a:	d9 45 d8             	flds   -0x28(%ebp)
     93d:	d9 6d b0             	fldcw  -0x50(%ebp)
     940:	db 5d ac             	fistpl -0x54(%ebp)
     943:	d9 6d b2             	fldcw  -0x4e(%ebp)
     946:	8b 45 ac             	mov    -0x54(%ebp),%eax
     949:	83 f8 ff             	cmp    $0xffffffff,%eax
     94c:	0f 84 79 05 00 00    	je     ecb <main+0xecb>
				for (int r =max(start,1); r< min(start+numA,N-1); r++)	
     952:	8b 9d 78 ff ff ff    	mov    -0x88(%ebp),%ebx
     958:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     95b:	39 c3                	cmp    %eax,%ebx
     95d:	0f 8d 57 fc ff ff    	jge    5ba <main+0x5ba>
     963:	8b 75 9c             	mov    -0x64(%ebp),%esi
     966:	89 da                	mov    %ebx,%edx
     968:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
     96e:	0f af d6             	imul   %esi,%edx
     971:	8d 0c 10             	lea    (%eax,%edx,1),%ecx
     974:	03 55 a0             	add    -0x60(%ebp),%edx
     977:	89 f6                	mov    %esi,%esi
     979:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
					for (int po =1; po< N-1; po++)u[r][po] = w[r][po];
     980:	83 ff 01             	cmp    $0x1,%edi
     983:	b8 01 00 00 00       	mov    $0x1,%eax
     988:	7e 13                	jle    99d <main+0x99d>
     98a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     990:	d9 04 81             	flds   (%ecx,%eax,4)
     993:	d9 1c 82             	fstps  (%edx,%eax,4)
     996:	83 c0 01             	add    $0x1,%eax
     999:	39 f8                	cmp    %edi,%eax
     99b:	75 f3                	jne    990 <main+0x990>
				for (int r =max(start,1); r< min(start+numA,N-1); r++)	
     99d:	83 c3 01             	add    $0x1,%ebx
     9a0:	01 f1                	add    %esi,%ecx
     9a2:	01 f2                	add    %esi,%edx
     9a4:	3b 5d a4             	cmp    -0x5c(%ebp),%ebx
     9a7:	75 d7                	jne    980 <main+0x980>
				if(start!=0){
     9a9:	8b 8d 74 ff ff ff    	mov    -0x8c(%ebp),%ecx
     9af:	85 c9                	test   %ecx,%ecx
     9b1:	0f 84 11 fc ff ff    	je     5c8 <main+0x5c8>
					for(int t=1;t<N-1;t++){
     9b7:	83 ff 01             	cmp    $0x1,%edi
     9ba:	0f 8e 07 fe ff ff    	jle    7c7 <main+0x7c7>
     9c0:	8b b5 58 ff ff ff    	mov    -0xa8(%ebp),%esi
     9c6:	bb 01 00 00 00       	mov    $0x1,%ebx
     9cb:	90                   	nop
     9cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
						a[1] = t;
     9d0:	89 5d a8             	mov    %ebx,-0x58(%ebp)
						write(child_sends_upper[i][1],a,sizeof(a));
     9d3:	8d 45 d8             	lea    -0x28(%ebp),%eax
     9d6:	83 ec 04             	sub    $0x4,%esp
						a[1] = t;
     9d9:	db 45 a8             	fildl  -0x58(%ebp)
						write(child_sends_upper[i][1],a,sizeof(a));
     9dc:	8b 4d 80             	mov    -0x80(%ebp),%ecx
						a[0] = 1;
     9df:	c7 45 d8 00 00 80 3f 	movl   $0x3f800000,-0x28(%ebp)
                        a[3] = GHOSTVALUE;
     9e6:	c7 45 e4 00 00 00 40 	movl   $0x40000000,-0x1c(%ebp)
						a[1] = t;
     9ed:	d9 5d dc             	fstps  -0x24(%ebp)
						a[2] = (float)u[start][t];
     9f0:	d9 04 9e             	flds   (%esi,%ebx,4)
					for(int t=1;t<N-1;t++){
     9f3:	83 c3 01             	add    $0x1,%ebx
						write(child_sends_upper[i][1],a,sizeof(a));
     9f6:	6a 10                	push   $0x10
     9f8:	50                   	push   %eax
     9f9:	8b 45 84             	mov    -0x7c(%ebp),%eax
						a[2] = (float)u[start][t];
     9fc:	d9 5d e0             	fstps  -0x20(%ebp)
						write(child_sends_upper[i][1],a,sizeof(a));
     9ff:	ff 74 c8 04          	pushl  0x4(%eax,%ecx,8)
     a03:	e8 8a 09 00 00       	call   1392 <write>
					for(int t=1;t<N-1;t++){
     a08:	83 c4 10             	add    $0x10,%esp
     a0b:	39 df                	cmp    %ebx,%edi
     a0d:	75 c1                	jne    9d0 <main+0x9d0>
				if((start+numA)!=N){
     a0f:	8b 75 8c             	mov    -0x74(%ebp),%esi
     a12:	39 b5 60 ff ff ff    	cmp    %esi,-0xa0(%ebp)
     a18:	0f 85 c2 fb ff ff    	jne    5e0 <main+0x5e0>
     a1e:	8b 45 80             	mov    -0x80(%ebp),%eax
					for(int t=1;t<N-1;t++){
     a21:	bb 01 00 00 00       	mov    $0x1,%ebx
     a26:	8d 70 ff             	lea    -0x1(%eax),%esi
								u[start-1][(int)buf[1]] = buf[2];
     a29:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
     a2f:	83 e8 01             	sub    $0x1,%eax
     a32:	0f af 85 7c ff ff ff 	imul   -0x84(%ebp),%eax
     a39:	89 45 a8             	mov    %eax,-0x58(%ebp)
     a3c:	eb 3e                	jmp    a7c <main+0xa7c>
     a3e:	d9 45 dc             	flds   -0x24(%ebp)
     a41:	d9 6d b0             	fldcw  -0x50(%ebp)
     a44:	db 5d ac             	fistpl -0x54(%ebp)
     a47:	d9 6d b2             	fldcw  -0x4e(%ebp)
     a4a:	8b 45 ac             	mov    -0x54(%ebp),%eax
     a4d:	d9 45 e0             	flds   -0x20(%ebp)
							if((int)buf[0]==1){
     a50:	d9 45 d8             	flds   -0x28(%ebp)
     a53:	d9 6d b0             	fldcw  -0x50(%ebp)
     a56:	db 5d ac             	fistpl -0x54(%ebp)
     a59:	d9 6d b2             	fldcw  -0x4e(%ebp)
     a5c:	8b 55 ac             	mov    -0x54(%ebp),%edx
     a5f:	83 fa 01             	cmp    $0x1,%edx
     a62:	0f 84 4c 04 00 00    	je     eb4 <main+0xeb4>
								u[start-1][(int)buf[1]] = buf[2];
     a68:	03 45 a8             	add    -0x58(%ebp),%eax
     a6b:	8b 4d a0             	mov    -0x60(%ebp),%ecx
     a6e:	d9 1c 81             	fstps  (%ecx,%eax,4)
					for(int t=1;t<N-1;t++){
     a71:	83 c3 01             	add    $0x1,%ebx
     a74:	39 df                	cmp    %ebx,%edi
     a76:	0f 84 4b fd ff ff    	je     7c7 <main+0x7c7>
						read(child_sends_lower[i-1][0],buf,sizeof(buf));
     a7c:	8d 45 d8             	lea    -0x28(%ebp),%eax
     a7f:	83 ec 04             	sub    $0x4,%esp
     a82:	6a 10                	push   $0x10
     a84:	50                   	push   %eax
     a85:	8b 45 88             	mov    -0x78(%ebp),%eax
     a88:	ff 34 f0             	pushl  (%eax,%esi,8)
     a8b:	e8 fa 08 00 00       	call   138a <read>
						if((int)buf[3] ==GHOSTVALUE){
     a90:	d9 7d b2             	fnstcw -0x4e(%ebp)
     a93:	0f b7 45 b2          	movzwl -0x4e(%ebp),%eax
     a97:	d9 45 e4             	flds   -0x1c(%ebp)
     a9a:	83 c4 10             	add    $0x10,%esp
     a9d:	80 cc 0c             	or     $0xc,%ah
     aa0:	66 89 45 b0          	mov    %ax,-0x50(%ebp)
     aa4:	d9 6d b0             	fldcw  -0x50(%ebp)
     aa7:	db 5d ac             	fistpl -0x54(%ebp)
     aaa:	d9 6d b2             	fldcw  -0x4e(%ebp)
     aad:	8b 45 ac             	mov    -0x54(%ebp),%eax
     ab0:	83 f8 02             	cmp    $0x2,%eax
     ab3:	74 89                	je     a3e <main+0xa3e>
							printf(1,"Received wrong message instead of ghostvalue\n");
     ab5:	83 ec 08             	sub    $0x8,%esp
     ab8:	68 08 19 00 00       	push   $0x1908
     abd:	6a 01                	push   $0x1
     abf:	e8 5c 0a 00 00       	call   1520 <printf>
     ac4:	83 c4 10             	add    $0x10,%esp
     ac7:	eb a8                	jmp    a71 <main+0xa71>
     ac9:	8b 85 74 ff ff ff    	mov    -0x8c(%ebp),%eax
     acf:	8b 4d 80             	mov    -0x80(%ebp),%ecx
     ad2:	8d 70 04             	lea    0x4(%eax),%esi
     ad5:	8d 5c 08 04          	lea    0x4(%eax,%ecx,1),%ebx
     ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
	// ////Start the threads
	for(int i=0;i<P;i++){
			// close(fd_child_cor[i][1]);
			// close(fd_cor_child[i][0]);
			float msg[4];
			msg[0] = 0;
     ae0:	d9 ee                	fldz   
			msg[1] = 0;
			msg[2] = 0;
			msg[3] = 0;
			write(fd_cor_child[i][1],msg,sizeof(msg));
     ae2:	8d 45 d8             	lea    -0x28(%ebp),%eax
     ae5:	83 ec 04             	sub    $0x4,%esp
     ae8:	6a 10                	push   $0x10
     aea:	83 c6 08             	add    $0x8,%esi
			msg[0] = 0;
     aed:	d9 55 d8             	fsts   -0x28(%ebp)
			write(fd_cor_child[i][1],msg,sizeof(msg));
     af0:	50                   	push   %eax
     af1:	ff 76 f8             	pushl  -0x8(%esi)
			msg[1] = 0;
     af4:	d9 55 dc             	fsts   -0x24(%ebp)
			msg[2] = 0;
     af7:	d9 55 e0             	fsts   -0x20(%ebp)
			msg[3] = 0;
     afa:	d9 5d e4             	fstps  -0x1c(%ebp)
			write(fd_cor_child[i][1],msg,sizeof(msg));
     afd:	e8 90 08 00 00       	call   1392 <write>
	for(int i=0;i<P;i++){
     b02:	83 c4 10             	add    $0x10,%esp
     b05:	39 de                	cmp    %ebx,%esi
     b07:	75 d7                	jne    ae0 <main+0xae0>
     b09:	8b 5d 90             	mov    -0x70(%ebp),%ebx
			}else{
				printf(1,"received wrong message of type %d \n",(int)buf[3]);
			}		
		}
		if(diffglobal<=E || it > L ){
			statusB = -1;
     b0c:	be 02 00 00 00       	mov    $0x2,%esi
     b11:	89 7d 94             	mov    %edi,-0x6c(%ebp)
     b14:	89 75 98             	mov    %esi,-0x68(%ebp)
     b17:	89 f6                	mov    %esi,%esi
     b19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		float diffglobal = 0;
     b20:	d9 ee                	fldz   
		for(int i=0;i<P;i++){
     b22:	31 f6                	xor    %esi,%esi
     b24:	85 db                	test   %ebx,%ebx
     b26:	8b bd 70 ff ff ff    	mov    -0x90(%ebp),%edi
		float diffglobal = 0;
     b2c:	d9 5d a8             	fstps  -0x58(%ebp)
		for(int i=0;i<P;i++){
     b2f:	7f 25                	jg     b56 <main+0xb56>
     b31:	e9 ff 00 00 00       	jmp    c35 <main+0xc35>
     b36:	8d 76 00             	lea    0x0(%esi),%esi
     b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
					diffglobal = buf[0];
     b40:	d9 45 a8             	flds   -0x58(%ebp)
				if(buf[0] >diffglobal){
     b43:	d9 45 d8             	flds   -0x28(%ebp)
					diffglobal = buf[0];
     b46:	db e9                	fucomi %st(1),%st
     b48:	da d1                	fcmovbe %st(1),%st
     b4a:	dd d9                	fstp   %st(1)
		for(int i=0;i<P;i++){
     b4c:	83 c6 01             	add    $0x1,%esi
     b4f:	39 de                	cmp    %ebx,%esi
					diffglobal = buf[0];
     b51:	d9 5d a8             	fstps  -0x58(%ebp)
		for(int i=0;i<P;i++){
     b54:	74 50                	je     ba6 <main+0xba6>
			read(fd_child_cor[i][0],buf,sizeof(buf));
     b56:	8d 45 d8             	lea    -0x28(%ebp),%eax
     b59:	83 ec 04             	sub    $0x4,%esp
     b5c:	6a 10                	push   $0x10
     b5e:	50                   	push   %eax
     b5f:	ff 34 f7             	pushl  (%edi,%esi,8)
     b62:	e8 23 08 00 00       	call   138a <read>
			if((int)buf[3] == DIFFERENCE){
     b67:	d9 7d b2             	fnstcw -0x4e(%ebp)
     b6a:	0f b7 45 b2          	movzwl -0x4e(%ebp),%eax
     b6e:	d9 45 e4             	flds   -0x1c(%ebp)
     b71:	83 c4 10             	add    $0x10,%esp
     b74:	80 cc 0c             	or     $0xc,%ah
     b77:	66 89 45 b0          	mov    %ax,-0x50(%ebp)
     b7b:	d9 6d b0             	fldcw  -0x50(%ebp)
     b7e:	db 5d ac             	fistpl -0x54(%ebp)
     b81:	d9 6d b2             	fldcw  -0x4e(%ebp)
     b84:	8b 45 ac             	mov    -0x54(%ebp),%eax
     b87:	83 f8 03             	cmp    $0x3,%eax
     b8a:	74 b4                	je     b40 <main+0xb40>
				printf(1,"received wrong message of type %d \n",(int)buf[3]);
     b8c:	83 ec 04             	sub    $0x4,%esp
		for(int i=0;i<P;i++){
     b8f:	83 c6 01             	add    $0x1,%esi
				printf(1,"received wrong message of type %d \n",(int)buf[3]);
     b92:	50                   	push   %eax
     b93:	68 64 19 00 00       	push   $0x1964
     b98:	6a 01                	push   $0x1
     b9a:	e8 81 09 00 00       	call   1520 <printf>
     b9f:	83 c4 10             	add    $0x10,%esp
		for(int i=0;i<P;i++){
     ba2:	39 de                	cmp    %ebx,%esi
     ba4:	75 b0                	jne    b56 <main+0xb56>
		if(diffglobal<=E || it > L ){
     ba6:	d9 45 a8             	flds   -0x58(%ebp)
     ba9:	d9 85 7c ff ff ff    	flds   -0x84(%ebp)
     baf:	df e9                	fucomip %st(1),%st
     bb1:	dd d8                	fstp   %st(0)
     bb3:	73 70                	jae    c25 <main+0xc25>
     bb5:	8b 45 98             	mov    -0x68(%ebp),%eax
     bb8:	83 e8 01             	sub    $0x1,%eax
     bbb:	39 85 78 ff ff ff    	cmp    %eax,-0x88(%ebp)
     bc1:	7c 62                	jl     c25 <main+0xc25>
		float statusB=1;
     bc3:	d9 e8                	fld1   
		if(diffglobal<=E || it > L ){
     bc5:	c7 45 a4 01 00 00 00 	movl   $0x1,-0x5c(%ebp)
		float statusB=1;
     bcc:	d9 5d a8             	fstps  -0x58(%ebp)
			statusB = -1;
     bcf:	31 f6                	xor    %esi,%esi
     bd1:	89 f7                	mov    %esi,%edi
     bd3:	8b b5 74 ff ff ff    	mov    -0x8c(%ebp),%esi
     bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
			loop = 0;
		}
		// printf(1,"Parent : Ss %d \n",it);
		for(int i=0;i<P;i++){
			float a[4];// = new float[1];
			a[0] = statusB;
     be0:	d9 45 a8             	flds   -0x58(%ebp)
			a[1] = 0;
			a[2] = 0;
			a[3] = CONTINUE_STOP_CHILD;
			// printf(1,"PARENT : Sending %d %d %d %d to %d in %d\n",(int)a[0],(int)a[1],(int)a[2],(int)a[3],rec_pids[i],it);
			write(fd_cor_child[i][1],a,sizeof(a));
     be3:	8d 45 d8             	lea    -0x28(%ebp),%eax
     be6:	83 ec 04             	sub    $0x4,%esp
     be9:	6a 10                	push   $0x10
			a[3] = CONTINUE_STOP_CHILD;
     beb:	c7 45 e4 00 00 80 3f 	movl   $0x3f800000,-0x1c(%ebp)
			a[0] = statusB;
     bf2:	d9 5d d8             	fstps  -0x28(%ebp)
			write(fd_cor_child[i][1],a,sizeof(a));
     bf5:	50                   	push   %eax
     bf6:	ff 74 fe 04          	pushl  0x4(%esi,%edi,8)
		for(int i=0;i<P;i++){
     bfa:	83 c7 01             	add    $0x1,%edi
			a[1] = 0;
     bfd:	d9 ee                	fldz   
     bff:	d9 55 dc             	fsts   -0x24(%ebp)
			a[2] = 0;
     c02:	d9 5d e0             	fstps  -0x20(%ebp)
			write(fd_cor_child[i][1],a,sizeof(a));
     c05:	e8 88 07 00 00       	call   1392 <write>
		for(int i=0;i<P;i++){
     c0a:	83 c4 10             	add    $0x10,%esp
     c0d:	39 df                	cmp    %ebx,%edi
     c0f:	7c cf                	jl     be0 <main+0xbe0>
	while(loop){
     c11:	8b 55 a4             	mov    -0x5c(%ebp),%edx
     c14:	85 d2                	test   %edx,%edx
     c16:	0f 84 67 03 00 00    	je     f83 <main+0xf83>
     c1c:	83 45 98 01          	addl   $0x1,-0x68(%ebp)
     c20:	e9 fb fe ff ff       	jmp    b20 <main+0xb20>
			statusB = -1;
     c25:	d9 e8                	fld1   
			loop = 0;
     c27:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
			statusB = -1;
     c2e:	d9 e0                	fchs   
     c30:	d9 5d a8             	fstps  -0x58(%ebp)
     c33:	eb 9a                	jmp    bcf <main+0xbcf>
		if(diffglobal<=E || it > L ){
     c35:	d9 45 a8             	flds   -0x58(%ebp)
     c38:	d9 85 7c ff ff ff    	flds   -0x84(%ebp)
     c3e:	df e9                	fucomip %st(1),%st
     c40:	dd d8                	fstp   %st(0)
     c42:	0f 82 75 01 00 00    	jb     dbd <main+0xdbd>
     c48:	8b 7d 94             	mov    -0x6c(%ebp),%edi
		}
		it++;
		// printf("loop done \n");
	}
	// printf(1,"PARENT : break from coordinator now waiting for values\n");
	for(int i=1;i<N-1;i++){
     c4b:	83 ff 01             	cmp    $0x1,%edi
     c4e:	0f 8e d8 00 00 00    	jle    d2c <main+0xd2c>
			// struct my_msgbuf buf;
			float buf[4];
            recv(buf);
			// msgrcv(coordinator_msg_id, &buf, sizeof(buf.mfloat), 0, 0);
			if((int)buf[3] == RETURNINGVALUES ){
				u[(int)buf[0]][(int)buf[1]] = buf[2];
     c54:	8b 75 9c             	mov    -0x64(%ebp),%esi
     c57:	c7 45 a4 01 00 00 00 	movl   $0x1,-0x5c(%ebp)
     c5e:	c1 ee 02             	shr    $0x2,%esi
     c61:	89 75 a8             	mov    %esi,-0x58(%ebp)
     c64:	8b 75 a0             	mov    -0x60(%ebp),%esi
     c67:	89 f6                	mov    %esi,%esi
     c69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		for(int j=1;j<N-1;j++){
     c70:	bb 01 00 00 00       	mov    $0x1,%ebx
     c75:	eb 3c                	jmp    cb3 <main+0xcb3>
     c77:	89 f6                	mov    %esi,%esi
     c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
     c80:	dd d8                	fstp   %st(0)
				u[(int)buf[0]][(int)buf[1]] = buf[2];
     c82:	d9 45 d8             	flds   -0x28(%ebp)
		for(int j=1;j<N-1;j++){
     c85:	83 c3 01             	add    $0x1,%ebx
				u[(int)buf[0]][(int)buf[1]] = buf[2];
     c88:	d9 6d b0             	fldcw  -0x50(%ebp)
     c8b:	db 5d ac             	fistpl -0x54(%ebp)
     c8e:	d9 6d b2             	fldcw  -0x4e(%ebp)
     c91:	8b 45 ac             	mov    -0x54(%ebp),%eax
     c94:	0f af 45 a8          	imul   -0x58(%ebp),%eax
     c98:	d9 45 dc             	flds   -0x24(%ebp)
     c9b:	d9 6d b0             	fldcw  -0x50(%ebp)
     c9e:	db 5d ac             	fistpl -0x54(%ebp)
     ca1:	d9 6d b2             	fldcw  -0x4e(%ebp)
     ca4:	8b 55 ac             	mov    -0x54(%ebp),%edx
     ca7:	d9 45 e0             	flds   -0x20(%ebp)
     caa:	01 d0                	add    %edx,%eax
		for(int j=1;j<N-1;j++){
     cac:	39 df                	cmp    %ebx,%edi
				u[(int)buf[0]][(int)buf[1]] = buf[2];
     cae:	d9 1c 86             	fstps  (%esi,%eax,4)
		for(int j=1;j<N-1;j++){
     cb1:	7e 4d                	jle    d00 <main+0xd00>
            recv(buf);
     cb3:	8d 45 d8             	lea    -0x28(%ebp),%eax
     cb6:	83 ec 0c             	sub    $0xc,%esp
     cb9:	50                   	push   %eax
     cba:	e8 7b 07 00 00       	call   143a <recv>
			if((int)buf[3] == RETURNINGVALUES ){
     cbf:	d9 7d b2             	fnstcw -0x4e(%ebp)
     cc2:	0f b7 45 b2          	movzwl -0x4e(%ebp),%eax
     cc6:	d9 45 e4             	flds   -0x1c(%ebp)
     cc9:	83 c4 10             	add    $0x10,%esp
     ccc:	80 cc 0c             	or     $0xc,%ah
     ccf:	66 89 45 b0          	mov    %ax,-0x50(%ebp)
     cd3:	d9 6d b0             	fldcw  -0x50(%ebp)
     cd6:	db 55 ac             	fistl  -0x54(%ebp)
     cd9:	d9 6d b2             	fldcw  -0x4e(%ebp)
     cdc:	8b 45 ac             	mov    -0x54(%ebp),%eax
     cdf:	83 f8 04             	cmp    $0x4,%eax
     ce2:	74 9c                	je     c80 <main+0xc80>
			}else{
				printf(1,"received wrong message of type %f instead of returning values \n",buf[3]);
     ce4:	83 ec 08             	sub    $0x8,%esp
		for(int j=1;j<N-1;j++){
     ce7:	83 c3 01             	add    $0x1,%ebx
				printf(1,"received wrong message of type %f instead of returning values \n",buf[3]);
     cea:	dd 1c 24             	fstpl  (%esp)
     ced:	68 88 19 00 00       	push   $0x1988
     cf2:	6a 01                	push   $0x1
     cf4:	e8 27 08 00 00       	call   1520 <printf>
     cf9:	83 c4 10             	add    $0x10,%esp
		for(int j=1;j<N-1;j++){
     cfc:	39 df                	cmp    %ebx,%edi
     cfe:	7f b3                	jg     cb3 <main+0xcb3>
	for(int i=1;i<N-1;i++){
     d00:	83 45 a4 01          	addl   $0x1,-0x5c(%ebp)
     d04:	8b 45 a4             	mov    -0x5c(%ebp),%eax
     d07:	39 c7                	cmp    %eax,%edi
     d09:	0f 8f 61 ff ff ff    	jg     c70 <main+0xc70>
			}
		}
	}
	for(int i=0;i<P;i++){
     d0f:	31 db                	xor    %ebx,%ebx
     d11:	83 7d 90 00          	cmpl   $0x0,-0x70(%ebp)
     d15:	8b 75 90             	mov    -0x70(%ebp),%esi
     d18:	7e 12                	jle    d2c <main+0xd2c>
     d1a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     d20:	83 c3 01             	add    $0x1,%ebx
		// int st;
		wait();
     d23:	e8 52 06 00 00       	call   137a <wait>
	for(int i=0;i<P;i++){
     d28:	39 f3                	cmp    %esi,%ebx
     d2a:	75 f4                	jne    d20 <main+0xd20>
	}
	for(i =0; i <N; i++){
     d2c:	83 7d 8c 00          	cmpl   $0x0,-0x74(%ebp)
     d30:	0f 8e b9 f7 ff ff    	jle    4ef <main+0x4ef>
     d36:	8b 5d a0             	mov    -0x60(%ebp),%ebx
     d39:	8b 7d 8c             	mov    -0x74(%ebp),%edi
     d3c:	31 f6                	xor    %esi,%esi
     d3e:	89 75 a8             	mov    %esi,-0x58(%ebp)
     d41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		for(j = 0; j<N; j++)
     d48:	31 f6                	xor    %esi,%esi
     d4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
			printf(1,"%d ",((int)u[i][j]));
     d50:	d9 04 b3             	flds   (%ebx,%esi,4)
     d53:	d9 7d b2             	fnstcw -0x4e(%ebp)
     d56:	0f b7 55 b2          	movzwl -0x4e(%ebp),%edx
     d5a:	83 ec 04             	sub    $0x4,%esp
		for(j = 0; j<N; j++)
     d5d:	83 c6 01             	add    $0x1,%esi
			printf(1,"%d ",((int)u[i][j]));
     d60:	80 ce 0c             	or     $0xc,%dh
     d63:	66 89 55 b0          	mov    %dx,-0x50(%ebp)
     d67:	d9 6d b0             	fldcw  -0x50(%ebp)
     d6a:	db 5d ac             	fistpl -0x54(%ebp)
     d6d:	d9 6d b2             	fldcw  -0x4e(%ebp)
     d70:	8b 55 ac             	mov    -0x54(%ebp),%edx
     d73:	52                   	push   %edx
     d74:	68 a1 18 00 00       	push   $0x18a1
     d79:	6a 01                	push   $0x1
     d7b:	e8 a0 07 00 00       	call   1520 <printf>
		for(j = 0; j<N; j++)
     d80:	83 c4 10             	add    $0x10,%esp
     d83:	39 fe                	cmp    %edi,%esi
     d85:	75 c9                	jne    d50 <main+0xd50>
		printf(1,"\n");
     d87:	83 ec 08             	sub    $0x8,%esp
     d8a:	68 a5 18 00 00       	push   $0x18a5
     d8f:	6a 01                	push   $0x1
     d91:	e8 8a 07 00 00       	call   1520 <printf>
	for(i =0; i <N; i++){
     d96:	83 45 a8 01          	addl   $0x1,-0x58(%ebp)
     d9a:	03 5d 9c             	add    -0x64(%ebp),%ebx
     d9d:	83 c4 10             	add    $0x10,%esp
     da0:	8b 45 a8             	mov    -0x58(%ebp),%eax
     da3:	39 f8                	cmp    %edi,%eax
     da5:	75 a1                	jne    d48 <main+0xd48>
     da7:	e9 43 f7 ff ff       	jmp    4ef <main+0x4ef>
		return (divtemp+1)*(i-1);
     dac:	83 c0 01             	add    $0x1,%eax
     daf:	0f af f0             	imul   %eax,%esi
     db2:	89 b5 74 ff ff ff    	mov    %esi,-0x8c(%ebp)
     db8:	e9 b5 f7 ff ff       	jmp    572 <main+0x572>
		if(diffglobal<=E || it > L ){
     dbd:	8b 45 98             	mov    -0x68(%ebp),%eax
     dc0:	83 e8 01             	sub    $0x1,%eax
     dc3:	3b 85 78 ff ff ff    	cmp    -0x88(%ebp),%eax
     dc9:	0f 8e 4d fe ff ff    	jle    c1c <main+0xc1c>
     dcf:	e9 74 fe ff ff       	jmp    c48 <main+0xc48>
     dd4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
								u[start+numA][(int)buf[1]] = buf[2];
     dd8:	03 85 68 ff ff ff    	add    -0x98(%ebp),%eax
     dde:	8b 4d a0             	mov    -0x60(%ebp),%ecx
     de1:	d9 1c 81             	fstps  (%ecx,%eax,4)
     de4:	e9 ca f8 ff ff       	jmp    6b3 <main+0x6b3>
								u[start+numA][(int)buf[1]] = buf[2];
     de9:	03 85 68 ff ff ff    	add    -0x98(%ebp),%eax
     def:	8b 4d a0             	mov    -0x60(%ebp),%ecx
     df2:	d9 1c 81             	fstps  (%ecx,%eax,4)
     df5:	e9 71 f9 ff ff       	jmp    76b <main+0x76b>
					for(int t=1;t<N-1;t++){
     dfa:	83 ff 01             	cmp    $0x1,%edi
     dfd:	7f 0f                	jg     e0e <main+0xe0e>
		return b;
     dff:	c7 85 78 ff ff ff 01 	movl   $0x1,-0x88(%ebp)
     e06:	00 00 00 
     e09:	e9 cf f9 ff ff       	jmp    7dd <main+0x7dd>
     e0e:	8b 45 80             	mov    -0x80(%ebp),%eax
					int tosend = start+numA-1;
     e11:	bb 01 00 00 00       	mov    $0x1,%ebx
     e16:	8d 70 01             	lea    0x1(%eax),%esi
     e19:	eb 3e                	jmp    e59 <main+0xe59>
     e1b:	90                   	nop
     e1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     e20:	d9 45 dc             	flds   -0x24(%ebp)
     e23:	d9 6d b0             	fldcw  -0x50(%ebp)
     e26:	db 5d ac             	fistpl -0x54(%ebp)
     e29:	d9 6d b2             	fldcw  -0x4e(%ebp)
     e2c:	8b 45 ac             	mov    -0x54(%ebp),%eax
     e2f:	d9 45 e0             	flds   -0x20(%ebp)
							if((int)buf[0]==1){
     e32:	d9 45 d8             	flds   -0x28(%ebp)
     e35:	d9 6d b0             	fldcw  -0x50(%ebp)
     e38:	db 5d ac             	fistpl -0x54(%ebp)
     e3b:	d9 6d b2             	fldcw  -0x4e(%ebp)
     e3e:	8b 55 ac             	mov    -0x54(%ebp),%edx
     e41:	83 fa 01             	cmp    $0x1,%edx
     e44:	74 60                	je     ea6 <main+0xea6>
								u[start-1][(int)buf[1]] = buf[2];
     e46:	2b 85 7c ff ff ff    	sub    -0x84(%ebp),%eax
     e4c:	8b 4d a0             	mov    -0x60(%ebp),%ecx
     e4f:	d9 1c 81             	fstps  (%ecx,%eax,4)
					for(int t=1;t<N-1;t++){
     e52:	83 c3 01             	add    $0x1,%ebx
     e55:	39 df                	cmp    %ebx,%edi
     e57:	7e a6                	jle    dff <main+0xdff>
						read(child_sends_upper[i+1][0],buf,sizeof(buf));
     e59:	8d 45 d8             	lea    -0x28(%ebp),%eax
     e5c:	83 ec 04             	sub    $0x4,%esp
     e5f:	6a 10                	push   $0x10
     e61:	50                   	push   %eax
     e62:	8b 45 84             	mov    -0x7c(%ebp),%eax
     e65:	ff 34 f0             	pushl  (%eax,%esi,8)
     e68:	e8 1d 05 00 00       	call   138a <read>
						if((int)buf[3] ==GHOSTVALUE){
     e6d:	d9 7d b2             	fnstcw -0x4e(%ebp)
     e70:	0f b7 45 b2          	movzwl -0x4e(%ebp),%eax
     e74:	d9 45 e4             	flds   -0x1c(%ebp)
     e77:	83 c4 10             	add    $0x10,%esp
     e7a:	80 cc 0c             	or     $0xc,%ah
     e7d:	66 89 45 b0          	mov    %ax,-0x50(%ebp)
     e81:	d9 6d b0             	fldcw  -0x50(%ebp)
     e84:	db 5d ac             	fistpl -0x54(%ebp)
     e87:	d9 6d b2             	fldcw  -0x4e(%ebp)
     e8a:	8b 45 ac             	mov    -0x54(%ebp),%eax
     e8d:	83 f8 02             	cmp    $0x2,%eax
     e90:	74 8e                	je     e20 <main+0xe20>
							printf(1,"Received wrong message instead of ghostvalue\n");
     e92:	83 ec 08             	sub    $0x8,%esp
     e95:	68 08 19 00 00       	push   $0x1908
     e9a:	6a 01                	push   $0x1
     e9c:	e8 7f 06 00 00       	call   1520 <printf>
     ea1:	83 c4 10             	add    $0x10,%esp
     ea4:	eb ac                	jmp    e52 <main+0xe52>
								u[start+numA][(int)buf[1]] = buf[2];
     ea6:	03 85 68 ff ff ff    	add    -0x98(%ebp),%eax
     eac:	8b 4d a0             	mov    -0x60(%ebp),%ecx
     eaf:	d9 1c 81             	fstps  (%ecx,%eax,4)
     eb2:	eb 9e                	jmp    e52 <main+0xe52>
								u[start+numA][(int)buf[1]] = buf[2];
     eb4:	8b 95 7c ff ff ff    	mov    -0x84(%ebp),%edx
     eba:	8b 4d a0             	mov    -0x60(%ebp),%ecx
     ebd:	0f af 55 8c          	imul   -0x74(%ebp),%edx
     ec1:	01 d0                	add    %edx,%eax
     ec3:	d9 1c 81             	fstps  (%ecx,%eax,4)
     ec6:	e9 a6 fb ff ff       	jmp    a71 <main+0xa71>
			for(int x=max(start,1);x<min(start+numA,N-1);x++){
     ecb:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
     ed1:	8b 75 a4             	mov    -0x5c(%ebp),%esi
     ed4:	39 f0                	cmp    %esi,%eax
     ed6:	0f 8d 13 f6 ff ff    	jge    4ef <main+0x4ef>
     edc:	0f af 45 9c          	imul   -0x64(%ebp),%eax
     ee0:	8b 75 a0             	mov    -0x60(%ebp),%esi
     ee3:	8b 9d 54 ff ff ff    	mov    -0xac(%ebp),%ebx
     ee9:	89 7d a0             	mov    %edi,-0x60(%ebp)
     eec:	01 c6                	add    %eax,%esi
     eee:	66 90                	xchg   %ax,%ax
				for(int y=1;y<N-1;y++){
     ef0:	83 7d a0 01          	cmpl   $0x1,-0x60(%ebp)
     ef4:	7e 4c                	jle    f42 <main+0xf42>
     ef6:	db 85 78 ff ff ff    	fildl  -0x88(%ebp)
     efc:	bf 01 00 00 00       	mov    $0x1,%edi
     f01:	d9 5d 98             	fstps  -0x68(%ebp)
     f04:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
					a[0] = x;
     f08:	d9 45 98             	flds   -0x68(%ebp)
					a[1] = y;
     f0b:	89 7d a8             	mov    %edi,-0x58(%ebp)
					a[3] = RETURNINGVALUES;
     f0e:	c7 45 e4 00 00 80 40 	movl   $0x40800000,-0x1c(%ebp)
					a[0] = x;
     f15:	d9 5d d8             	fstps  -0x28(%ebp)
					a[1] = y;
     f18:	db 45 a8             	fildl  -0x58(%ebp)
     f1b:	d9 5d dc             	fstps  -0x24(%ebp)
					a[2] = u[x][y];
     f1e:	d9 04 be             	flds   (%esi,%edi,4)
				for(int y=1;y<N-1;y++){
     f21:	83 c7 01             	add    $0x1,%edi
					a[2] = u[x][y];
     f24:	d9 5d e0             	fstps  -0x20(%ebp)
                    send(getpid(),coordinator_id,a);
     f27:	e8 c6 04 00 00       	call   13f2 <getpid>
     f2c:	8d 4d d8             	lea    -0x28(%ebp),%ecx
     f2f:	83 ec 04             	sub    $0x4,%esp
     f32:	51                   	push   %ecx
     f33:	53                   	push   %ebx
     f34:	50                   	push   %eax
     f35:	e8 f8 04 00 00       	call   1432 <send>
				for(int y=1;y<N-1;y++){
     f3a:	83 c4 10             	add    $0x10,%esp
     f3d:	39 7d a0             	cmp    %edi,-0x60(%ebp)
     f40:	75 c6                	jne    f08 <main+0xf08>
			for(int x=max(start,1);x<min(start+numA,N-1);x++){
     f42:	83 85 78 ff ff ff 01 	addl   $0x1,-0x88(%ebp)
     f49:	03 75 9c             	add    -0x64(%ebp),%esi
     f4c:	8b 85 78 ff ff ff    	mov    -0x88(%ebp),%eax
     f52:	3b 45 a4             	cmp    -0x5c(%ebp),%eax
     f55:	75 99                	jne    ef0 <main+0xef0>
     f57:	e9 93 f5 ff ff       	jmp    4ef <main+0x4ef>
				float diff1 = 0.0;
     f5c:	d9 ee                	fldz   
     f5e:	e9 42 f9 ff ff       	jmp    8a5 <main+0x8a5>
	for (i = 1; i < N-1; i++ )
     f63:	83 ff 01             	cmp    $0x1,%edi
     f66:	0f 8e c1 f3 ff ff    	jle    32d <main+0x32d>
	mean /= (4.0 * N);
     f6c:	d8 3d c8 19 00 00    	fdivrs 0x19c8
     f72:	8b 4d 9c             	mov    -0x64(%ebp),%ecx
     f75:	c1 e9 02             	shr    $0x2,%ecx
     f78:	d9 5d b4             	fstps  -0x4c(%ebp)
     f7b:	d9 45 b4             	flds   -0x4c(%ebp)
     f7e:	e9 2d f3 ff ff       	jmp    2b0 <main+0x2b0>
     f83:	8b 7d 94             	mov    -0x6c(%ebp),%edi
	for(int i=1;i<N-1;i++){
     f86:	83 ff 01             	cmp    $0x1,%edi
     f89:	0f 8f c5 fc ff ff    	jg     c54 <main+0xc54>
     f8f:	e9 7b fd ff ff       	jmp    d0f <main+0xd0f>
     f94:	66 90                	xchg   %ax,%ax
     f96:	66 90                	xchg   %ax,%ax
     f98:	66 90                	xchg   %ax,%ax
     f9a:	66 90                	xchg   %ax,%ax
     f9c:	66 90                	xchg   %ax,%ax
     f9e:	66 90                	xchg   %ax,%ax

00000fa0 <fabsm>:
float fabsm(float a){
     fa0:	55                   	push   %ebp
     fa1:	89 e5                	mov    %esp,%ebp
     fa3:	d9 45 08             	flds   0x8(%ebp)
	if(a<0){
     fa6:	d9 ee                	fldz   
     fa8:	df e9                	fucomip %st(1),%st
     faa:	77 04                	ja     fb0 <fabsm+0x10>
}
     fac:	5d                   	pop    %ebp
     fad:	c3                   	ret    
     fae:	66 90                	xchg   %ax,%ax
		return -1*a;
     fb0:	d9 e0                	fchs   
}
     fb2:	5d                   	pop    %ebp
     fb3:	c3                   	ret    
     fb4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     fba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000fc0 <max>:
int max(int a,int b){
     fc0:	55                   	push   %ebp
     fc1:	89 e5                	mov    %esp,%ebp
     fc3:	8b 45 08             	mov    0x8(%ebp),%eax
     fc6:	8b 55 0c             	mov    0xc(%ebp),%edx
}
     fc9:	5d                   	pop    %ebp
     fca:	39 d0                	cmp    %edx,%eax
     fcc:	0f 4c c2             	cmovl  %edx,%eax
     fcf:	c3                   	ret    

00000fd0 <min>:
int min(int a,int b){
     fd0:	55                   	push   %ebp
     fd1:	89 e5                	mov    %esp,%ebp
     fd3:	8b 45 08             	mov    0x8(%ebp),%eax
     fd6:	8b 55 0c             	mov    0xc(%ebp),%edx
}
     fd9:	5d                   	pop    %ebp
     fda:	39 d0                	cmp    %edx,%eax
     fdc:	0f 4f c2             	cmovg  %edx,%eax
     fdf:	c3                   	ret    

00000fe0 <getStartingForI>:
int getStartingForI(int n,int nt,int i){
     fe0:	55                   	push   %ebp
     fe1:	89 e5                	mov    %esp,%ebp
     fe3:	8b 45 08             	mov    0x8(%ebp),%eax
     fe6:	8b 4d 10             	mov    0x10(%ebp),%ecx
     fe9:	99                   	cltd   
     fea:	f7 7d 0c             	idivl  0xc(%ebp)
	if(i<=remtemp){
     fed:	39 ca                	cmp    %ecx,%edx
     fef:	7f 0f                	jg     1000 <getStartingForI+0x20>
		return (divtemp)*(i-1) + remtemp;
     ff1:	0f af c1             	imul   %ecx,%eax
}
     ff4:	5d                   	pop    %ebp
		return (divtemp)*(i-1) + remtemp;
     ff5:	01 d0                	add    %edx,%eax
}
     ff7:	c3                   	ret    
     ff8:	90                   	nop
     ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
		return (divtemp+1)*(i-1);
    1000:	83 c0 01             	add    $0x1,%eax
    1003:	0f af c1             	imul   %ecx,%eax
}
    1006:	5d                   	pop    %ebp
    1007:	c3                   	ret    
    1008:	90                   	nop
    1009:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001010 <getNumberOfElements>:
int getNumberOfElements(int n,int nt,int i){
    1010:	55                   	push   %ebp
    1011:	89 e5                	mov    %esp,%ebp
    1013:	8b 45 08             	mov    0x8(%ebp),%eax
    1016:	99                   	cltd   
    1017:	f7 7d 0c             	idivl  0xc(%ebp)
		return n/nt+1;
    101a:	3b 55 10             	cmp    0x10(%ebp),%edx
}
    101d:	5d                   	pop    %ebp
		return n/nt+1;
    101e:	0f 9f c2             	setg   %dl
    1021:	0f b6 d2             	movzbl %dl,%edx
    1024:	01 d0                	add    %edx,%eax
}
    1026:	c3                   	ret    
    1027:	89 f6                	mov    %esi,%esi
    1029:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

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
    1056:	e8 2f 03 00 00       	call   138a <read>
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

00001070 <readFloat>:
float readFloat(int fd){
    1070:	55                   	push   %ebp
	float E=0.0;
    1071:	d9 ee                	fldz   
float readFloat(int fd){
    1073:	89 e5                	mov    %esp,%ebp
    1075:	57                   	push   %edi
    1076:	56                   	push   %esi
    1077:	53                   	push   %ebx
    1078:	8d 75 e7             	lea    -0x19(%ebp),%esi
	int decimal = 0;
    107b:	31 db                	xor    %ebx,%ebx
float readFloat(int fd){
    107d:	83 ec 2c             	sub    $0x2c,%esp
    1080:	8b 7d 08             	mov    0x8(%ebp),%edi
	float E=0.0;
    1083:	d9 5d d0             	fstps  -0x30(%ebp)
    1086:	8d 76 00             	lea    0x0(%esi),%esi
    1089:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		read(fd, &c, 1);
    1090:	83 ec 04             	sub    $0x4,%esp
    1093:	6a 01                	push   $0x1
    1095:	56                   	push   %esi
    1096:	57                   	push   %edi
    1097:	e8 ee 02 00 00       	call   138a <read>
		if(c == '\n')
    109c:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
    10a0:	83 c4 10             	add    $0x10,%esp
    10a3:	3c 0a                	cmp    $0xa,%al
    10a5:	74 69                	je     1110 <readFloat+0xa0>
		if(c == '.'){
    10a7:	3c 2e                	cmp    $0x2e,%al
    10a9:	74 25                	je     10d0 <readFloat+0x60>
    10ab:	83 e8 30             	sub    $0x30,%eax
		if(decimal == 0){
    10ae:	85 db                	test   %ebx,%ebx
    10b0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    10b3:	db 45 d4             	fildl  -0x2c(%ebp)
    10b6:	75 28                	jne    10e0 <readFloat+0x70>
			E = 10*E+temp;
    10b8:	d9 45 d0             	flds   -0x30(%ebp)
    10bb:	d8 0d cc 19 00 00    	fmuls  0x19cc
    10c1:	de c1                	faddp  %st,%st(1)
    10c3:	d9 5d d0             	fstps  -0x30(%ebp)
    10c6:	eb c8                	jmp    1090 <readFloat+0x20>
    10c8:	90                   	nop
    10c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    10d0:	bb 01 00 00 00       	mov    $0x1,%ebx
			count11 = 0;
    10d5:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
    10dc:	eb b2                	jmp    1090 <readFloat+0x20>
    10de:	66 90                	xchg   %ax,%ax
			count11++;
    10e0:	8b 4d cc             	mov    -0x34(%ebp),%ecx
			int divisor=1;
    10e3:	89 d8                	mov    %ebx,%eax
			for(int i=0; i<count11; i++){
    10e5:	31 d2                	xor    %edx,%edx
			count11++;
    10e7:	83 c1 01             	add    $0x1,%ecx
				divisor *= 10;
    10ea:	8d 04 80             	lea    (%eax,%eax,4),%eax
			for(int i=0; i<count11; i++){
    10ed:	83 c2 01             	add    $0x1,%edx
				divisor *= 10;
    10f0:	01 c0                	add    %eax,%eax
			for(int i=0; i<count11; i++){
    10f2:	39 ca                	cmp    %ecx,%edx
    10f4:	75 f4                	jne    10ea <readFloat+0x7a>
			float tt = (float)temp/divisor;
    10f6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
			E = E + tt;
    10f9:	89 55 cc             	mov    %edx,-0x34(%ebp)
			float tt = (float)temp/divisor;
    10fc:	db 45 d4             	fildl  -0x2c(%ebp)
    10ff:	de f9                	fdivrp %st,%st(1)
			E = E + tt;
    1101:	d8 45 d0             	fadds  -0x30(%ebp)
    1104:	d9 5d d0             	fstps  -0x30(%ebp)
    1107:	eb 87                	jmp    1090 <readFloat+0x20>
    1109:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
}
    1110:	d9 45 d0             	flds   -0x30(%ebp)
    1113:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1116:	5b                   	pop    %ebx
    1117:	5e                   	pop    %esi
    1118:	5f                   	pop    %edi
    1119:	5d                   	pop    %ebp
    111a:	c3                   	ret    
    111b:	66 90                	xchg   %ax,%ax
    111d:	66 90                	xchg   %ax,%ax
    111f:	90                   	nop

00001120 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    1120:	55                   	push   %ebp
    1121:	89 e5                	mov    %esp,%ebp
    1123:	53                   	push   %ebx
    1124:	8b 45 08             	mov    0x8(%ebp),%eax
    1127:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    112a:	89 c2                	mov    %eax,%edx
    112c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1130:	83 c1 01             	add    $0x1,%ecx
    1133:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
    1137:	83 c2 01             	add    $0x1,%edx
    113a:	84 db                	test   %bl,%bl
    113c:	88 5a ff             	mov    %bl,-0x1(%edx)
    113f:	75 ef                	jne    1130 <strcpy+0x10>
    ;
  return os;
}
    1141:	5b                   	pop    %ebx
    1142:	5d                   	pop    %ebp
    1143:	c3                   	ret    
    1144:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    114a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00001150 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    1150:	55                   	push   %ebp
    1151:	89 e5                	mov    %esp,%ebp
    1153:	53                   	push   %ebx
    1154:	8b 55 08             	mov    0x8(%ebp),%edx
    1157:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    115a:	0f b6 02             	movzbl (%edx),%eax
    115d:	0f b6 19             	movzbl (%ecx),%ebx
    1160:	84 c0                	test   %al,%al
    1162:	75 1c                	jne    1180 <strcmp+0x30>
    1164:	eb 2a                	jmp    1190 <strcmp+0x40>
    1166:	8d 76 00             	lea    0x0(%esi),%esi
    1169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
    1170:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
    1173:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
    1176:	83 c1 01             	add    $0x1,%ecx
    1179:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
    117c:	84 c0                	test   %al,%al
    117e:	74 10                	je     1190 <strcmp+0x40>
    1180:	38 d8                	cmp    %bl,%al
    1182:	74 ec                	je     1170 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
    1184:	29 d8                	sub    %ebx,%eax
}
    1186:	5b                   	pop    %ebx
    1187:	5d                   	pop    %ebp
    1188:	c3                   	ret    
    1189:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1190:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
    1192:	29 d8                	sub    %ebx,%eax
}
    1194:	5b                   	pop    %ebx
    1195:	5d                   	pop    %ebp
    1196:	c3                   	ret    
    1197:	89 f6                	mov    %esi,%esi
    1199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011a0 <strlen>:

uint
strlen(const char *s)
{
    11a0:	55                   	push   %ebp
    11a1:	89 e5                	mov    %esp,%ebp
    11a3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    11a6:	80 39 00             	cmpb   $0x0,(%ecx)
    11a9:	74 15                	je     11c0 <strlen+0x20>
    11ab:	31 d2                	xor    %edx,%edx
    11ad:	8d 76 00             	lea    0x0(%esi),%esi
    11b0:	83 c2 01             	add    $0x1,%edx
    11b3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    11b7:	89 d0                	mov    %edx,%eax
    11b9:	75 f5                	jne    11b0 <strlen+0x10>
    ;
  return n;
}
    11bb:	5d                   	pop    %ebp
    11bc:	c3                   	ret    
    11bd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
    11c0:	31 c0                	xor    %eax,%eax
}
    11c2:	5d                   	pop    %ebp
    11c3:	c3                   	ret    
    11c4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    11ca:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000011d0 <memset>:

void*
memset(void *dst, int c, uint n)
{
    11d0:	55                   	push   %ebp
    11d1:	89 e5                	mov    %esp,%ebp
    11d3:	57                   	push   %edi
    11d4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    11d7:	8b 4d 10             	mov    0x10(%ebp),%ecx
    11da:	8b 45 0c             	mov    0xc(%ebp),%eax
    11dd:	89 d7                	mov    %edx,%edi
    11df:	fc                   	cld    
    11e0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    11e2:	89 d0                	mov    %edx,%eax
    11e4:	5f                   	pop    %edi
    11e5:	5d                   	pop    %ebp
    11e6:	c3                   	ret    
    11e7:	89 f6                	mov    %esi,%esi
    11e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000011f0 <strchr>:

char*
strchr(const char *s, char c)
{
    11f0:	55                   	push   %ebp
    11f1:	89 e5                	mov    %esp,%ebp
    11f3:	53                   	push   %ebx
    11f4:	8b 45 08             	mov    0x8(%ebp),%eax
    11f7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    11fa:	0f b6 10             	movzbl (%eax),%edx
    11fd:	84 d2                	test   %dl,%dl
    11ff:	74 1d                	je     121e <strchr+0x2e>
    if(*s == c)
    1201:	38 d3                	cmp    %dl,%bl
    1203:	89 d9                	mov    %ebx,%ecx
    1205:	75 0d                	jne    1214 <strchr+0x24>
    1207:	eb 17                	jmp    1220 <strchr+0x30>
    1209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    1210:	38 ca                	cmp    %cl,%dl
    1212:	74 0c                	je     1220 <strchr+0x30>
  for(; *s; s++)
    1214:	83 c0 01             	add    $0x1,%eax
    1217:	0f b6 10             	movzbl (%eax),%edx
    121a:	84 d2                	test   %dl,%dl
    121c:	75 f2                	jne    1210 <strchr+0x20>
      return (char*)s;
  return 0;
    121e:	31 c0                	xor    %eax,%eax
}
    1220:	5b                   	pop    %ebx
    1221:	5d                   	pop    %ebp
    1222:	c3                   	ret    
    1223:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    1229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001230 <gets>:

char*
gets(char *buf, int max)
{
    1230:	55                   	push   %ebp
    1231:	89 e5                	mov    %esp,%ebp
    1233:	57                   	push   %edi
    1234:	56                   	push   %esi
    1235:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    1236:	31 f6                	xor    %esi,%esi
    1238:	89 f3                	mov    %esi,%ebx
{
    123a:	83 ec 1c             	sub    $0x1c,%esp
    123d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
    1240:	eb 2f                	jmp    1271 <gets+0x41>
    1242:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
    1248:	8d 45 e7             	lea    -0x19(%ebp),%eax
    124b:	83 ec 04             	sub    $0x4,%esp
    124e:	6a 01                	push   $0x1
    1250:	50                   	push   %eax
    1251:	6a 00                	push   $0x0
    1253:	e8 32 01 00 00       	call   138a <read>
    if(cc < 1)
    1258:	83 c4 10             	add    $0x10,%esp
    125b:	85 c0                	test   %eax,%eax
    125d:	7e 1c                	jle    127b <gets+0x4b>
      break;
    buf[i++] = c;
    125f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
    1263:	83 c7 01             	add    $0x1,%edi
    1266:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
    1269:	3c 0a                	cmp    $0xa,%al
    126b:	74 23                	je     1290 <gets+0x60>
    126d:	3c 0d                	cmp    $0xd,%al
    126f:	74 1f                	je     1290 <gets+0x60>
  for(i=0; i+1 < max; ){
    1271:	83 c3 01             	add    $0x1,%ebx
    1274:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    1277:	89 fe                	mov    %edi,%esi
    1279:	7c cd                	jl     1248 <gets+0x18>
    127b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
    127d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
    1280:	c6 03 00             	movb   $0x0,(%ebx)
}
    1283:	8d 65 f4             	lea    -0xc(%ebp),%esp
    1286:	5b                   	pop    %ebx
    1287:	5e                   	pop    %esi
    1288:	5f                   	pop    %edi
    1289:	5d                   	pop    %ebp
    128a:	c3                   	ret    
    128b:	90                   	nop
    128c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    1290:	8b 75 08             	mov    0x8(%ebp),%esi
    1293:	8b 45 08             	mov    0x8(%ebp),%eax
    1296:	01 de                	add    %ebx,%esi
    1298:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
    129a:	c6 03 00             	movb   $0x0,(%ebx)
}
    129d:	8d 65 f4             	lea    -0xc(%ebp),%esp
    12a0:	5b                   	pop    %ebx
    12a1:	5e                   	pop    %esi
    12a2:	5f                   	pop    %edi
    12a3:	5d                   	pop    %ebp
    12a4:	c3                   	ret    
    12a5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    12a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000012b0 <stat>:

int
stat(const char *n, struct stat *st)
{
    12b0:	55                   	push   %ebp
    12b1:	89 e5                	mov    %esp,%ebp
    12b3:	56                   	push   %esi
    12b4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    12b5:	83 ec 08             	sub    $0x8,%esp
    12b8:	6a 00                	push   $0x0
    12ba:	ff 75 08             	pushl  0x8(%ebp)
    12bd:	e8 f0 00 00 00       	call   13b2 <open>
  if(fd < 0)
    12c2:	83 c4 10             	add    $0x10,%esp
    12c5:	85 c0                	test   %eax,%eax
    12c7:	78 27                	js     12f0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
    12c9:	83 ec 08             	sub    $0x8,%esp
    12cc:	ff 75 0c             	pushl  0xc(%ebp)
    12cf:	89 c3                	mov    %eax,%ebx
    12d1:	50                   	push   %eax
    12d2:	e8 f3 00 00 00       	call   13ca <fstat>
  close(fd);
    12d7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
    12da:	89 c6                	mov    %eax,%esi
  close(fd);
    12dc:	e8 b9 00 00 00       	call   139a <close>
  return r;
    12e1:	83 c4 10             	add    $0x10,%esp
}
    12e4:	8d 65 f8             	lea    -0x8(%ebp),%esp
    12e7:	89 f0                	mov    %esi,%eax
    12e9:	5b                   	pop    %ebx
    12ea:	5e                   	pop    %esi
    12eb:	5d                   	pop    %ebp
    12ec:	c3                   	ret    
    12ed:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
    12f0:	be ff ff ff ff       	mov    $0xffffffff,%esi
    12f5:	eb ed                	jmp    12e4 <stat+0x34>
    12f7:	89 f6                	mov    %esi,%esi
    12f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00001300 <atoi>:

int
atoi(const char *s)
{
    1300:	55                   	push   %ebp
    1301:	89 e5                	mov    %esp,%ebp
    1303:	53                   	push   %ebx
    1304:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    1307:	0f be 11             	movsbl (%ecx),%edx
    130a:	8d 42 d0             	lea    -0x30(%edx),%eax
    130d:	3c 09                	cmp    $0x9,%al
  n = 0;
    130f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    1314:	77 1f                	ja     1335 <atoi+0x35>
    1316:	8d 76 00             	lea    0x0(%esi),%esi
    1319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
    1320:	8d 04 80             	lea    (%eax,%eax,4),%eax
    1323:	83 c1 01             	add    $0x1,%ecx
    1326:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
    132a:	0f be 11             	movsbl (%ecx),%edx
    132d:	8d 5a d0             	lea    -0x30(%edx),%ebx
    1330:	80 fb 09             	cmp    $0x9,%bl
    1333:	76 eb                	jbe    1320 <atoi+0x20>
  return n;
}
    1335:	5b                   	pop    %ebx
    1336:	5d                   	pop    %ebp
    1337:	c3                   	ret    
    1338:	90                   	nop
    1339:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00001340 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    1340:	55                   	push   %ebp
    1341:	89 e5                	mov    %esp,%ebp
    1343:	56                   	push   %esi
    1344:	53                   	push   %ebx
    1345:	8b 5d 10             	mov    0x10(%ebp),%ebx
    1348:	8b 45 08             	mov    0x8(%ebp),%eax
    134b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    134e:	85 db                	test   %ebx,%ebx
    1350:	7e 14                	jle    1366 <memmove+0x26>
    1352:	31 d2                	xor    %edx,%edx
    1354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
    1358:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
    135c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    135f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
    1362:	39 d3                	cmp    %edx,%ebx
    1364:	75 f2                	jne    1358 <memmove+0x18>
  return vdst;
}
    1366:	5b                   	pop    %ebx
    1367:	5e                   	pop    %esi
    1368:	5d                   	pop    %ebp
    1369:	c3                   	ret    

0000136a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    136a:	b8 01 00 00 00       	mov    $0x1,%eax
    136f:	cd 40                	int    $0x40
    1371:	c3                   	ret    

00001372 <exit>:
SYSCALL(exit)
    1372:	b8 02 00 00 00       	mov    $0x2,%eax
    1377:	cd 40                	int    $0x40
    1379:	c3                   	ret    

0000137a <wait>:
SYSCALL(wait)
    137a:	b8 03 00 00 00       	mov    $0x3,%eax
    137f:	cd 40                	int    $0x40
    1381:	c3                   	ret    

00001382 <pipe>:
SYSCALL(pipe)
    1382:	b8 04 00 00 00       	mov    $0x4,%eax
    1387:	cd 40                	int    $0x40
    1389:	c3                   	ret    

0000138a <read>:
SYSCALL(read)
    138a:	b8 05 00 00 00       	mov    $0x5,%eax
    138f:	cd 40                	int    $0x40
    1391:	c3                   	ret    

00001392 <write>:
SYSCALL(write)
    1392:	b8 10 00 00 00       	mov    $0x10,%eax
    1397:	cd 40                	int    $0x40
    1399:	c3                   	ret    

0000139a <close>:
SYSCALL(close)
    139a:	b8 15 00 00 00       	mov    $0x15,%eax
    139f:	cd 40                	int    $0x40
    13a1:	c3                   	ret    

000013a2 <kill>:
SYSCALL(kill)
    13a2:	b8 06 00 00 00       	mov    $0x6,%eax
    13a7:	cd 40                	int    $0x40
    13a9:	c3                   	ret    

000013aa <exec>:
SYSCALL(exec)
    13aa:	b8 07 00 00 00       	mov    $0x7,%eax
    13af:	cd 40                	int    $0x40
    13b1:	c3                   	ret    

000013b2 <open>:
SYSCALL(open)
    13b2:	b8 0f 00 00 00       	mov    $0xf,%eax
    13b7:	cd 40                	int    $0x40
    13b9:	c3                   	ret    

000013ba <mknod>:
SYSCALL(mknod)
    13ba:	b8 11 00 00 00       	mov    $0x11,%eax
    13bf:	cd 40                	int    $0x40
    13c1:	c3                   	ret    

000013c2 <unlink>:
SYSCALL(unlink)
    13c2:	b8 12 00 00 00       	mov    $0x12,%eax
    13c7:	cd 40                	int    $0x40
    13c9:	c3                   	ret    

000013ca <fstat>:
SYSCALL(fstat)
    13ca:	b8 08 00 00 00       	mov    $0x8,%eax
    13cf:	cd 40                	int    $0x40
    13d1:	c3                   	ret    

000013d2 <link>:
SYSCALL(link)
    13d2:	b8 13 00 00 00       	mov    $0x13,%eax
    13d7:	cd 40                	int    $0x40
    13d9:	c3                   	ret    

000013da <mkdir>:
SYSCALL(mkdir)
    13da:	b8 14 00 00 00       	mov    $0x14,%eax
    13df:	cd 40                	int    $0x40
    13e1:	c3                   	ret    

000013e2 <chdir>:
SYSCALL(chdir)
    13e2:	b8 09 00 00 00       	mov    $0x9,%eax
    13e7:	cd 40                	int    $0x40
    13e9:	c3                   	ret    

000013ea <dup>:
SYSCALL(dup)
    13ea:	b8 0a 00 00 00       	mov    $0xa,%eax
    13ef:	cd 40                	int    $0x40
    13f1:	c3                   	ret    

000013f2 <getpid>:
SYSCALL(getpid)
    13f2:	b8 0b 00 00 00       	mov    $0xb,%eax
    13f7:	cd 40                	int    $0x40
    13f9:	c3                   	ret    

000013fa <sbrk>:
SYSCALL(sbrk)
    13fa:	b8 0c 00 00 00       	mov    $0xc,%eax
    13ff:	cd 40                	int    $0x40
    1401:	c3                   	ret    

00001402 <sleep>:
SYSCALL(sleep)
    1402:	b8 0d 00 00 00       	mov    $0xd,%eax
    1407:	cd 40                	int    $0x40
    1409:	c3                   	ret    

0000140a <uptime>:
SYSCALL(uptime)
    140a:	b8 0e 00 00 00       	mov    $0xe,%eax
    140f:	cd 40                	int    $0x40
    1411:	c3                   	ret    

00001412 <halt>:
SYSCALL(halt)
    1412:	b8 1f 00 00 00       	mov    $0x1f,%eax
    1417:	cd 40                	int    $0x40
    1419:	c3                   	ret    

0000141a <toggle>:
SYSCALL(toggle)
    141a:	b8 16 00 00 00       	mov    $0x16,%eax
    141f:	cd 40                	int    $0x40
    1421:	c3                   	ret    

00001422 <add>:
SYSCALL(add)
    1422:	b8 17 00 00 00       	mov    $0x17,%eax
    1427:	cd 40                	int    $0x40
    1429:	c3                   	ret    

0000142a <ps>:
SYSCALL(ps)
    142a:	b8 18 00 00 00       	mov    $0x18,%eax
    142f:	cd 40                	int    $0x40
    1431:	c3                   	ret    

00001432 <send>:
SYSCALL(send)
    1432:	b8 19 00 00 00       	mov    $0x19,%eax
    1437:	cd 40                	int    $0x40
    1439:	c3                   	ret    

0000143a <recv>:
SYSCALL(recv)
    143a:	b8 1a 00 00 00       	mov    $0x1a,%eax
    143f:	cd 40                	int    $0x40
    1441:	c3                   	ret    

00001442 <print_count>:
SYSCALL(print_count)
    1442:	b8 1b 00 00 00       	mov    $0x1b,%eax
    1447:	cd 40                	int    $0x40
    1449:	c3                   	ret    

0000144a <send_multi>:
SYSCALL(send_multi)
    144a:	b8 1c 00 00 00       	mov    $0x1c,%eax
    144f:	cd 40                	int    $0x40
    1451:	c3                   	ret    

00001452 <signal>:
SYSCALL(signal)
    1452:	b8 1d 00 00 00       	mov    $0x1d,%eax
    1457:	cd 40                	int    $0x40
    1459:	c3                   	ret    

0000145a <sigraise>:
SYSCALL(sigraise)
    145a:	b8 1e 00 00 00       	mov    $0x1e,%eax
    145f:	cd 40                	int    $0x40
    1461:	c3                   	ret    

00001462 <recv_multi>:
SYSCALL(recv_multi)
    1462:	b8 20 00 00 00       	mov    $0x20,%eax
    1467:	cd 40                	int    $0x40
    1469:	c3                   	ret    

0000146a <change_state>:
SYSCALL(change_state)
    146a:	b8 21 00 00 00       	mov    $0x21,%eax
    146f:	cd 40                	int    $0x40
    1471:	c3                   	ret    
    1472:	66 90                	xchg   %ax,%ax
    1474:	66 90                	xchg   %ax,%ax
    1476:	66 90                	xchg   %ax,%ax
    1478:	66 90                	xchg   %ax,%ax
    147a:	66 90                	xchg   %ax,%ax
    147c:	66 90                	xchg   %ax,%ax
    147e:	66 90                	xchg   %ax,%ax

00001480 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    1480:	55                   	push   %ebp
    1481:	89 e5                	mov    %esp,%ebp
    1483:	57                   	push   %edi
    1484:	56                   	push   %esi
    1485:	53                   	push   %ebx
    1486:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    1489:	85 d2                	test   %edx,%edx
{
    148b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
    148e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    1490:	79 76                	jns    1508 <printint+0x88>
    1492:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    1496:	74 70                	je     1508 <printint+0x88>
    x = -xx;
    1498:	f7 d8                	neg    %eax
    neg = 1;
    149a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    14a1:	31 f6                	xor    %esi,%esi
    14a3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    14a6:	eb 0a                	jmp    14b2 <printint+0x32>
    14a8:	90                   	nop
    14a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    14b0:	89 fe                	mov    %edi,%esi
    14b2:	31 d2                	xor    %edx,%edx
    14b4:	8d 7e 01             	lea    0x1(%esi),%edi
    14b7:	f7 f1                	div    %ecx
    14b9:	0f b6 92 e0 19 00 00 	movzbl 0x19e0(%edx),%edx
  }while((x /= base) != 0);
    14c0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    14c2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    14c5:	75 e9                	jne    14b0 <printint+0x30>
  if(neg)
    14c7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    14ca:	85 c0                	test   %eax,%eax
    14cc:	74 08                	je     14d6 <printint+0x56>
    buf[i++] = '-';
    14ce:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    14d3:	8d 7e 02             	lea    0x2(%esi),%edi
    14d6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    14da:	8b 7d c0             	mov    -0x40(%ebp),%edi
    14dd:	8d 76 00             	lea    0x0(%esi),%esi
    14e0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    14e3:	83 ec 04             	sub    $0x4,%esp
    14e6:	83 ee 01             	sub    $0x1,%esi
    14e9:	6a 01                	push   $0x1
    14eb:	53                   	push   %ebx
    14ec:	57                   	push   %edi
    14ed:	88 45 d7             	mov    %al,-0x29(%ebp)
    14f0:	e8 9d fe ff ff       	call   1392 <write>

  while(--i >= 0)
    14f5:	83 c4 10             	add    $0x10,%esp
    14f8:	39 de                	cmp    %ebx,%esi
    14fa:	75 e4                	jne    14e0 <printint+0x60>
    putc(fd, buf[i]);
}
    14fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    14ff:	5b                   	pop    %ebx
    1500:	5e                   	pop    %esi
    1501:	5f                   	pop    %edi
    1502:	5d                   	pop    %ebp
    1503:	c3                   	ret    
    1504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1508:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    150f:	eb 90                	jmp    14a1 <printint+0x21>
    1511:	eb 0d                	jmp    1520 <printf>
    1513:	90                   	nop
    1514:	90                   	nop
    1515:	90                   	nop
    1516:	90                   	nop
    1517:	90                   	nop
    1518:	90                   	nop
    1519:	90                   	nop
    151a:	90                   	nop
    151b:	90                   	nop
    151c:	90                   	nop
    151d:	90                   	nop
    151e:	90                   	nop
    151f:	90                   	nop

00001520 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1520:	55                   	push   %ebp
    1521:	89 e5                	mov    %esp,%ebp
    1523:	57                   	push   %edi
    1524:	56                   	push   %esi
    1525:	53                   	push   %ebx
    1526:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1529:	8b 75 0c             	mov    0xc(%ebp),%esi
    152c:	0f b6 1e             	movzbl (%esi),%ebx
    152f:	84 db                	test   %bl,%bl
    1531:	0f 84 b3 00 00 00    	je     15ea <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
    1537:	8d 45 10             	lea    0x10(%ebp),%eax
    153a:	83 c6 01             	add    $0x1,%esi
  state = 0;
    153d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
    153f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1542:	eb 2f                	jmp    1573 <printf+0x53>
    1544:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1548:	83 f8 25             	cmp    $0x25,%eax
    154b:	0f 84 a7 00 00 00    	je     15f8 <printf+0xd8>
  write(fd, &c, 1);
    1551:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1554:	83 ec 04             	sub    $0x4,%esp
    1557:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    155a:	6a 01                	push   $0x1
    155c:	50                   	push   %eax
    155d:	ff 75 08             	pushl  0x8(%ebp)
    1560:	e8 2d fe ff ff       	call   1392 <write>
    1565:	83 c4 10             	add    $0x10,%esp
    1568:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    156b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    156f:	84 db                	test   %bl,%bl
    1571:	74 77                	je     15ea <printf+0xca>
    if(state == 0){
    1573:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    1575:	0f be cb             	movsbl %bl,%ecx
    1578:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    157b:	74 cb                	je     1548 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    157d:	83 ff 25             	cmp    $0x25,%edi
    1580:	75 e6                	jne    1568 <printf+0x48>
      if(c == 'd'){
    1582:	83 f8 64             	cmp    $0x64,%eax
    1585:	0f 84 05 01 00 00    	je     1690 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    158b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    1591:	83 f9 70             	cmp    $0x70,%ecx
    1594:	74 72                	je     1608 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    1596:	83 f8 73             	cmp    $0x73,%eax
    1599:	0f 84 99 00 00 00    	je     1638 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    159f:	83 f8 63             	cmp    $0x63,%eax
    15a2:	0f 84 08 01 00 00    	je     16b0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    15a8:	83 f8 25             	cmp    $0x25,%eax
    15ab:	0f 84 ef 00 00 00    	je     16a0 <printf+0x180>
  write(fd, &c, 1);
    15b1:	8d 45 e7             	lea    -0x19(%ebp),%eax
    15b4:	83 ec 04             	sub    $0x4,%esp
    15b7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    15bb:	6a 01                	push   $0x1
    15bd:	50                   	push   %eax
    15be:	ff 75 08             	pushl  0x8(%ebp)
    15c1:	e8 cc fd ff ff       	call   1392 <write>
    15c6:	83 c4 0c             	add    $0xc,%esp
    15c9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    15cc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    15cf:	6a 01                	push   $0x1
    15d1:	50                   	push   %eax
    15d2:	ff 75 08             	pushl  0x8(%ebp)
    15d5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    15d8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    15da:	e8 b3 fd ff ff       	call   1392 <write>
  for(i = 0; fmt[i]; i++){
    15df:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
    15e3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    15e6:	84 db                	test   %bl,%bl
    15e8:	75 89                	jne    1573 <printf+0x53>
    }
  }
}
    15ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
    15ed:	5b                   	pop    %ebx
    15ee:	5e                   	pop    %esi
    15ef:	5f                   	pop    %edi
    15f0:	5d                   	pop    %ebp
    15f1:	c3                   	ret    
    15f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
    15f8:	bf 25 00 00 00       	mov    $0x25,%edi
    15fd:	e9 66 ff ff ff       	jmp    1568 <printf+0x48>
    1602:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    1608:	83 ec 0c             	sub    $0xc,%esp
    160b:	b9 10 00 00 00       	mov    $0x10,%ecx
    1610:	6a 00                	push   $0x0
    1612:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    1615:	8b 45 08             	mov    0x8(%ebp),%eax
    1618:	8b 17                	mov    (%edi),%edx
    161a:	e8 61 fe ff ff       	call   1480 <printint>
        ap++;
    161f:	89 f8                	mov    %edi,%eax
    1621:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1624:	31 ff                	xor    %edi,%edi
        ap++;
    1626:	83 c0 04             	add    $0x4,%eax
    1629:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    162c:	e9 37 ff ff ff       	jmp    1568 <printf+0x48>
    1631:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    1638:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    163b:	8b 08                	mov    (%eax),%ecx
        ap++;
    163d:	83 c0 04             	add    $0x4,%eax
    1640:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    1643:	85 c9                	test   %ecx,%ecx
    1645:	0f 84 8e 00 00 00    	je     16d9 <printf+0x1b9>
        while(*s != 0){
    164b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    164e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    1650:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    1652:	84 c0                	test   %al,%al
    1654:	0f 84 0e ff ff ff    	je     1568 <printf+0x48>
    165a:	89 75 d0             	mov    %esi,-0x30(%ebp)
    165d:	89 de                	mov    %ebx,%esi
    165f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    1662:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    1665:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    1668:	83 ec 04             	sub    $0x4,%esp
          s++;
    166b:	83 c6 01             	add    $0x1,%esi
    166e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    1671:	6a 01                	push   $0x1
    1673:	57                   	push   %edi
    1674:	53                   	push   %ebx
    1675:	e8 18 fd ff ff       	call   1392 <write>
        while(*s != 0){
    167a:	0f b6 06             	movzbl (%esi),%eax
    167d:	83 c4 10             	add    $0x10,%esp
    1680:	84 c0                	test   %al,%al
    1682:	75 e4                	jne    1668 <printf+0x148>
    1684:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    1687:	31 ff                	xor    %edi,%edi
    1689:	e9 da fe ff ff       	jmp    1568 <printf+0x48>
    168e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    1690:	83 ec 0c             	sub    $0xc,%esp
    1693:	b9 0a 00 00 00       	mov    $0xa,%ecx
    1698:	6a 01                	push   $0x1
    169a:	e9 73 ff ff ff       	jmp    1612 <printf+0xf2>
    169f:	90                   	nop
  write(fd, &c, 1);
    16a0:	83 ec 04             	sub    $0x4,%esp
    16a3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    16a6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    16a9:	6a 01                	push   $0x1
    16ab:	e9 21 ff ff ff       	jmp    15d1 <printf+0xb1>
        putc(fd, *ap);
    16b0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    16b3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    16b6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    16b8:	6a 01                	push   $0x1
        ap++;
    16ba:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    16bd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    16c0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    16c3:	50                   	push   %eax
    16c4:	ff 75 08             	pushl  0x8(%ebp)
    16c7:	e8 c6 fc ff ff       	call   1392 <write>
        ap++;
    16cc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    16cf:	83 c4 10             	add    $0x10,%esp
      state = 0;
    16d2:	31 ff                	xor    %edi,%edi
    16d4:	e9 8f fe ff ff       	jmp    1568 <printf+0x48>
          s = "(null)";
    16d9:	bb d8 19 00 00       	mov    $0x19d8,%ebx
        while(*s != 0){
    16de:	b8 28 00 00 00       	mov    $0x28,%eax
    16e3:	e9 72 ff ff ff       	jmp    165a <printf+0x13a>
    16e8:	66 90                	xchg   %ax,%ax
    16ea:	66 90                	xchg   %ax,%ax
    16ec:	66 90                	xchg   %ax,%ax
    16ee:	66 90                	xchg   %ax,%ax

000016f0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    16f0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    16f1:	a1 a0 1d 00 00       	mov    0x1da0,%eax
{
    16f6:	89 e5                	mov    %esp,%ebp
    16f8:	57                   	push   %edi
    16f9:	56                   	push   %esi
    16fa:	53                   	push   %ebx
    16fb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    16fe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1701:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1708:	39 c8                	cmp    %ecx,%eax
    170a:	8b 10                	mov    (%eax),%edx
    170c:	73 32                	jae    1740 <free+0x50>
    170e:	39 d1                	cmp    %edx,%ecx
    1710:	72 04                	jb     1716 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1712:	39 d0                	cmp    %edx,%eax
    1714:	72 32                	jb     1748 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1716:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1719:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    171c:	39 fa                	cmp    %edi,%edx
    171e:	74 30                	je     1750 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1720:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1723:	8b 50 04             	mov    0x4(%eax),%edx
    1726:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1729:	39 f1                	cmp    %esi,%ecx
    172b:	74 3a                	je     1767 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    172d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    172f:	a3 a0 1d 00 00       	mov    %eax,0x1da0
}
    1734:	5b                   	pop    %ebx
    1735:	5e                   	pop    %esi
    1736:	5f                   	pop    %edi
    1737:	5d                   	pop    %ebp
    1738:	c3                   	ret    
    1739:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1740:	39 d0                	cmp    %edx,%eax
    1742:	72 04                	jb     1748 <free+0x58>
    1744:	39 d1                	cmp    %edx,%ecx
    1746:	72 ce                	jb     1716 <free+0x26>
{
    1748:	89 d0                	mov    %edx,%eax
    174a:	eb bc                	jmp    1708 <free+0x18>
    174c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1750:	03 72 04             	add    0x4(%edx),%esi
    1753:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1756:	8b 10                	mov    (%eax),%edx
    1758:	8b 12                	mov    (%edx),%edx
    175a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    175d:	8b 50 04             	mov    0x4(%eax),%edx
    1760:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1763:	39 f1                	cmp    %esi,%ecx
    1765:	75 c6                	jne    172d <free+0x3d>
    p->s.size += bp->s.size;
    1767:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    176a:	a3 a0 1d 00 00       	mov    %eax,0x1da0
    p->s.size += bp->s.size;
    176f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1772:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1775:	89 10                	mov    %edx,(%eax)
}
    1777:	5b                   	pop    %ebx
    1778:	5e                   	pop    %esi
    1779:	5f                   	pop    %edi
    177a:	5d                   	pop    %ebp
    177b:	c3                   	ret    
    177c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00001780 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1780:	55                   	push   %ebp
    1781:	89 e5                	mov    %esp,%ebp
    1783:	57                   	push   %edi
    1784:	56                   	push   %esi
    1785:	53                   	push   %ebx
    1786:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1789:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    178c:	8b 15 a0 1d 00 00    	mov    0x1da0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1792:	8d 78 07             	lea    0x7(%eax),%edi
    1795:	c1 ef 03             	shr    $0x3,%edi
    1798:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    179b:	85 d2                	test   %edx,%edx
    179d:	0f 84 9d 00 00 00    	je     1840 <malloc+0xc0>
    17a3:	8b 02                	mov    (%edx),%eax
    17a5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    17a8:	39 cf                	cmp    %ecx,%edi
    17aa:	76 6c                	jbe    1818 <malloc+0x98>
    17ac:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    17b2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    17b7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    17ba:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    17c1:	eb 0e                	jmp    17d1 <malloc+0x51>
    17c3:	90                   	nop
    17c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    17c8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    17ca:	8b 48 04             	mov    0x4(%eax),%ecx
    17cd:	39 f9                	cmp    %edi,%ecx
    17cf:	73 47                	jae    1818 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    17d1:	39 05 a0 1d 00 00    	cmp    %eax,0x1da0
    17d7:	89 c2                	mov    %eax,%edx
    17d9:	75 ed                	jne    17c8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    17db:	83 ec 0c             	sub    $0xc,%esp
    17de:	56                   	push   %esi
    17df:	e8 16 fc ff ff       	call   13fa <sbrk>
  if(p == (char*)-1)
    17e4:	83 c4 10             	add    $0x10,%esp
    17e7:	83 f8 ff             	cmp    $0xffffffff,%eax
    17ea:	74 1c                	je     1808 <malloc+0x88>
  hp->s.size = nu;
    17ec:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    17ef:	83 ec 0c             	sub    $0xc,%esp
    17f2:	83 c0 08             	add    $0x8,%eax
    17f5:	50                   	push   %eax
    17f6:	e8 f5 fe ff ff       	call   16f0 <free>
  return freep;
    17fb:	8b 15 a0 1d 00 00    	mov    0x1da0,%edx
      if((p = morecore(nunits)) == 0)
    1801:	83 c4 10             	add    $0x10,%esp
    1804:	85 d2                	test   %edx,%edx
    1806:	75 c0                	jne    17c8 <malloc+0x48>
        return 0;
  }
}
    1808:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    180b:	31 c0                	xor    %eax,%eax
}
    180d:	5b                   	pop    %ebx
    180e:	5e                   	pop    %esi
    180f:	5f                   	pop    %edi
    1810:	5d                   	pop    %ebp
    1811:	c3                   	ret    
    1812:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1818:	39 cf                	cmp    %ecx,%edi
    181a:	74 54                	je     1870 <malloc+0xf0>
        p->s.size -= nunits;
    181c:	29 f9                	sub    %edi,%ecx
    181e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1821:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1824:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1827:	89 15 a0 1d 00 00    	mov    %edx,0x1da0
}
    182d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1830:	83 c0 08             	add    $0x8,%eax
}
    1833:	5b                   	pop    %ebx
    1834:	5e                   	pop    %esi
    1835:	5f                   	pop    %edi
    1836:	5d                   	pop    %ebp
    1837:	c3                   	ret    
    1838:	90                   	nop
    1839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1840:	c7 05 a0 1d 00 00 a4 	movl   $0x1da4,0x1da0
    1847:	1d 00 00 
    184a:	c7 05 a4 1d 00 00 a4 	movl   $0x1da4,0x1da4
    1851:	1d 00 00 
    base.s.size = 0;
    1854:	b8 a4 1d 00 00       	mov    $0x1da4,%eax
    1859:	c7 05 a8 1d 00 00 00 	movl   $0x0,0x1da8
    1860:	00 00 00 
    1863:	e9 44 ff ff ff       	jmp    17ac <malloc+0x2c>
    1868:	90                   	nop
    1869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    1870:	8b 08                	mov    (%eax),%ecx
    1872:	89 0a                	mov    %ecx,(%edx)
    1874:	eb b1                	jmp    1827 <malloc+0xa7>
