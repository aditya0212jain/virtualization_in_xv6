
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:

# Entering xv6 on boot processor, with paging off.
.globl entry
entry:
  # Turn on page size extension for 4Mbyte pages
  movl    %cr4, %eax
8010000c:	0f 20 e0             	mov    %cr4,%eax
  orl     $(CR4_PSE), %eax
8010000f:	83 c8 10             	or     $0x10,%eax
  movl    %eax, %cr4
80100012:	0f 22 e0             	mov    %eax,%cr4
  # Set page directory
  movl    $(V2P_WO(entrypgdir)), %eax
80100015:	b8 00 a0 10 00       	mov    $0x10a000,%eax
  movl    %eax, %cr3
8010001a:	0f 22 d8             	mov    %eax,%cr3
  # Turn on paging.
  movl    %cr0, %eax
8010001d:	0f 20 c0             	mov    %cr0,%eax
  orl     $(CR0_PG|CR0_WP), %eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
  movl    %eax, %cr0
80100025:	0f 22 c0             	mov    %eax,%cr0

  # Set up the stack pointer.
  movl $(stack + KSTACKSIZE), %esp
80100028:	bc 70 17 11 80       	mov    $0x80111770,%esp

  # Jump to main(), and switch to executing at
  # high addresses. The indirect call is needed because
  # the assembler produces a PC-relative instruction
  # for a direct jump.
  mov $main, %eax
8010002d:	b8 c0 2e 10 80       	mov    $0x80102ec0,%eax
  jmp *%eax
80100032:	ff e0                	jmp    *%eax
80100034:	66 90                	xchg   %ax,%ax
80100036:	66 90                	xchg   %ax,%ax
80100038:	66 90                	xchg   %ax,%ax
8010003a:	66 90                	xchg   %ax,%ax
8010003c:	66 90                	xchg   %ax,%ax
8010003e:	66 90                	xchg   %ax,%ax

80100040 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100040:	55                   	push   %ebp
80100041:	89 e5                	mov    %esp,%ebp
80100043:	53                   	push   %ebx

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
  bcache.head.next = &bcache.head;
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100044:	bb b4 17 11 80       	mov    $0x801117b4,%ebx
{
80100049:	83 ec 0c             	sub    $0xc,%esp
  initlock(&bcache.lock, "bcache");
8010004c:	68 00 7e 10 80       	push   $0x80107e00
80100051:	68 80 17 11 80       	push   $0x80111780
80100056:	e8 45 47 00 00       	call   801047a0 <initlock>
  bcache.head.prev = &bcache.head;
8010005b:	c7 05 cc 5e 11 80 7c 	movl   $0x80115e7c,0x80115ecc
80100062:	5e 11 80 
  bcache.head.next = &bcache.head;
80100065:	c7 05 d0 5e 11 80 7c 	movl   $0x80115e7c,0x80115ed0
8010006c:	5e 11 80 
8010006f:	83 c4 10             	add    $0x10,%esp
80100072:	ba 7c 5e 11 80       	mov    $0x80115e7c,%edx
80100077:	eb 09                	jmp    80100082 <binit+0x42>
80100079:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80100080:	89 c3                	mov    %eax,%ebx
    b->next = bcache.head.next;
    b->prev = &bcache.head;
    initsleeplock(&b->lock, "buffer");
80100082:	8d 43 0c             	lea    0xc(%ebx),%eax
80100085:	83 ec 08             	sub    $0x8,%esp
    b->next = bcache.head.next;
80100088:	89 53 54             	mov    %edx,0x54(%ebx)
    b->prev = &bcache.head;
8010008b:	c7 43 50 7c 5e 11 80 	movl   $0x80115e7c,0x50(%ebx)
    initsleeplock(&b->lock, "buffer");
80100092:	68 60 83 10 80       	push   $0x80108360
80100097:	50                   	push   %eax
80100098:	e8 d3 45 00 00       	call   80104670 <initsleeplock>
    bcache.head.next->prev = b;
8010009d:	a1 d0 5e 11 80       	mov    0x80115ed0,%eax
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000a2:	83 c4 10             	add    $0x10,%esp
801000a5:	89 da                	mov    %ebx,%edx
    bcache.head.next->prev = b;
801000a7:	89 58 50             	mov    %ebx,0x50(%eax)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000aa:	8d 83 5c 02 00 00    	lea    0x25c(%ebx),%eax
    bcache.head.next = b;
801000b0:	89 1d d0 5e 11 80    	mov    %ebx,0x80115ed0
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000b6:	3d 7c 5e 11 80       	cmp    $0x80115e7c,%eax
801000bb:	72 c3                	jb     80100080 <binit+0x40>
  }
}
801000bd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801000c0:	c9                   	leave  
801000c1:	c3                   	ret    
801000c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801000c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801000d0 <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801000d0:	55                   	push   %ebp
801000d1:	89 e5                	mov    %esp,%ebp
801000d3:	57                   	push   %edi
801000d4:	56                   	push   %esi
801000d5:	53                   	push   %ebx
801000d6:	83 ec 18             	sub    $0x18,%esp
801000d9:	8b 75 08             	mov    0x8(%ebp),%esi
801000dc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  acquire(&bcache.lock);
801000df:	68 80 17 11 80       	push   $0x80111780
801000e4:	e8 f7 47 00 00       	call   801048e0 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000e9:	8b 1d d0 5e 11 80    	mov    0x80115ed0,%ebx
801000ef:	83 c4 10             	add    $0x10,%esp
801000f2:	81 fb 7c 5e 11 80    	cmp    $0x80115e7c,%ebx
801000f8:	75 11                	jne    8010010b <bread+0x3b>
801000fa:	eb 24                	jmp    80100120 <bread+0x50>
801000fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100100:	8b 5b 54             	mov    0x54(%ebx),%ebx
80100103:	81 fb 7c 5e 11 80    	cmp    $0x80115e7c,%ebx
80100109:	74 15                	je     80100120 <bread+0x50>
    if(b->dev == dev && b->blockno == blockno){
8010010b:	3b 73 04             	cmp    0x4(%ebx),%esi
8010010e:	75 f0                	jne    80100100 <bread+0x30>
80100110:	3b 7b 08             	cmp    0x8(%ebx),%edi
80100113:	75 eb                	jne    80100100 <bread+0x30>
      b->refcnt++;
80100115:	83 43 4c 01          	addl   $0x1,0x4c(%ebx)
80100119:	eb 3f                	jmp    8010015a <bread+0x8a>
8010011b:	90                   	nop
8010011c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100120:	8b 1d cc 5e 11 80    	mov    0x80115ecc,%ebx
80100126:	81 fb 7c 5e 11 80    	cmp    $0x80115e7c,%ebx
8010012c:	75 0d                	jne    8010013b <bread+0x6b>
8010012e:	eb 60                	jmp    80100190 <bread+0xc0>
80100130:	8b 5b 50             	mov    0x50(%ebx),%ebx
80100133:	81 fb 7c 5e 11 80    	cmp    $0x80115e7c,%ebx
80100139:	74 55                	je     80100190 <bread+0xc0>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010013b:	8b 43 4c             	mov    0x4c(%ebx),%eax
8010013e:	85 c0                	test   %eax,%eax
80100140:	75 ee                	jne    80100130 <bread+0x60>
80100142:	f6 03 04             	testb  $0x4,(%ebx)
80100145:	75 e9                	jne    80100130 <bread+0x60>
      b->dev = dev;
80100147:	89 73 04             	mov    %esi,0x4(%ebx)
      b->blockno = blockno;
8010014a:	89 7b 08             	mov    %edi,0x8(%ebx)
      b->flags = 0;
8010014d:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
      b->refcnt = 1;
80100153:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
      release(&bcache.lock);
8010015a:	83 ec 0c             	sub    $0xc,%esp
8010015d:	68 80 17 11 80       	push   $0x80111780
80100162:	e8 39 48 00 00       	call   801049a0 <release>
      acquiresleep(&b->lock);
80100167:	8d 43 0c             	lea    0xc(%ebx),%eax
8010016a:	89 04 24             	mov    %eax,(%esp)
8010016d:	e8 3e 45 00 00       	call   801046b0 <acquiresleep>
80100172:	83 c4 10             	add    $0x10,%esp
  struct buf *b;

  b = bget(dev, blockno);
  if((b->flags & B_VALID) == 0) {
80100175:	f6 03 02             	testb  $0x2,(%ebx)
80100178:	75 0c                	jne    80100186 <bread+0xb6>
    iderw(b);
8010017a:	83 ec 0c             	sub    $0xc,%esp
8010017d:	53                   	push   %ebx
8010017e:	e8 bd 1f 00 00       	call   80102140 <iderw>
80100183:	83 c4 10             	add    $0x10,%esp
  }
  return b;
}
80100186:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100189:	89 d8                	mov    %ebx,%eax
8010018b:	5b                   	pop    %ebx
8010018c:	5e                   	pop    %esi
8010018d:	5f                   	pop    %edi
8010018e:	5d                   	pop    %ebp
8010018f:	c3                   	ret    
  panic("bget: no buffers");
80100190:	83 ec 0c             	sub    $0xc,%esp
80100193:	68 07 7e 10 80       	push   $0x80107e07
80100198:	e8 f3 01 00 00       	call   80100390 <panic>
8010019d:	8d 76 00             	lea    0x0(%esi),%esi

801001a0 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
801001a0:	55                   	push   %ebp
801001a1:	89 e5                	mov    %esp,%ebp
801001a3:	53                   	push   %ebx
801001a4:	83 ec 10             	sub    $0x10,%esp
801001a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001aa:	8d 43 0c             	lea    0xc(%ebx),%eax
801001ad:	50                   	push   %eax
801001ae:	e8 9d 45 00 00       	call   80104750 <holdingsleep>
801001b3:	83 c4 10             	add    $0x10,%esp
801001b6:	85 c0                	test   %eax,%eax
801001b8:	74 0f                	je     801001c9 <bwrite+0x29>
    panic("bwrite");
  b->flags |= B_DIRTY;
801001ba:	83 0b 04             	orl    $0x4,(%ebx)
  iderw(b);
801001bd:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801001c0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801001c3:	c9                   	leave  
  iderw(b);
801001c4:	e9 77 1f 00 00       	jmp    80102140 <iderw>
    panic("bwrite");
801001c9:	83 ec 0c             	sub    $0xc,%esp
801001cc:	68 18 7e 10 80       	push   $0x80107e18
801001d1:	e8 ba 01 00 00       	call   80100390 <panic>
801001d6:	8d 76 00             	lea    0x0(%esi),%esi
801001d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801001e0 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
801001e0:	55                   	push   %ebp
801001e1:	89 e5                	mov    %esp,%ebp
801001e3:	56                   	push   %esi
801001e4:	53                   	push   %ebx
801001e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holdingsleep(&b->lock))
801001e8:	83 ec 0c             	sub    $0xc,%esp
801001eb:	8d 73 0c             	lea    0xc(%ebx),%esi
801001ee:	56                   	push   %esi
801001ef:	e8 5c 45 00 00       	call   80104750 <holdingsleep>
801001f4:	83 c4 10             	add    $0x10,%esp
801001f7:	85 c0                	test   %eax,%eax
801001f9:	74 66                	je     80100261 <brelse+0x81>
    panic("brelse");

  releasesleep(&b->lock);
801001fb:	83 ec 0c             	sub    $0xc,%esp
801001fe:	56                   	push   %esi
801001ff:	e8 0c 45 00 00       	call   80104710 <releasesleep>

  acquire(&bcache.lock);
80100204:	c7 04 24 80 17 11 80 	movl   $0x80111780,(%esp)
8010020b:	e8 d0 46 00 00       	call   801048e0 <acquire>
  b->refcnt--;
80100210:	8b 43 4c             	mov    0x4c(%ebx),%eax
  if (b->refcnt == 0) {
80100213:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
80100216:	83 e8 01             	sub    $0x1,%eax
  if (b->refcnt == 0) {
80100219:	85 c0                	test   %eax,%eax
  b->refcnt--;
8010021b:	89 43 4c             	mov    %eax,0x4c(%ebx)
  if (b->refcnt == 0) {
8010021e:	75 2f                	jne    8010024f <brelse+0x6f>
    // no one is waiting for it.
    b->next->prev = b->prev;
80100220:	8b 43 54             	mov    0x54(%ebx),%eax
80100223:	8b 53 50             	mov    0x50(%ebx),%edx
80100226:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
80100229:	8b 43 50             	mov    0x50(%ebx),%eax
8010022c:	8b 53 54             	mov    0x54(%ebx),%edx
8010022f:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
80100232:	a1 d0 5e 11 80       	mov    0x80115ed0,%eax
    b->prev = &bcache.head;
80100237:	c7 43 50 7c 5e 11 80 	movl   $0x80115e7c,0x50(%ebx)
    b->next = bcache.head.next;
8010023e:	89 43 54             	mov    %eax,0x54(%ebx)
    bcache.head.next->prev = b;
80100241:	a1 d0 5e 11 80       	mov    0x80115ed0,%eax
80100246:	89 58 50             	mov    %ebx,0x50(%eax)
    bcache.head.next = b;
80100249:	89 1d d0 5e 11 80    	mov    %ebx,0x80115ed0
  }
  
  release(&bcache.lock);
8010024f:	c7 45 08 80 17 11 80 	movl   $0x80111780,0x8(%ebp)
}
80100256:	8d 65 f8             	lea    -0x8(%ebp),%esp
80100259:	5b                   	pop    %ebx
8010025a:	5e                   	pop    %esi
8010025b:	5d                   	pop    %ebp
  release(&bcache.lock);
8010025c:	e9 3f 47 00 00       	jmp    801049a0 <release>
    panic("brelse");
80100261:	83 ec 0c             	sub    $0xc,%esp
80100264:	68 1f 7e 10 80       	push   $0x80107e1f
80100269:	e8 22 01 00 00       	call   80100390 <panic>
8010026e:	66 90                	xchg   %ax,%ax

80100270 <consoleread>:
  }
}

int
consoleread(struct inode *ip, char *dst, int n)
{
80100270:	55                   	push   %ebp
80100271:	89 e5                	mov    %esp,%ebp
80100273:	57                   	push   %edi
80100274:	56                   	push   %esi
80100275:	53                   	push   %ebx
80100276:	83 ec 28             	sub    $0x28,%esp
80100279:	8b 7d 08             	mov    0x8(%ebp),%edi
8010027c:	8b 75 0c             	mov    0xc(%ebp),%esi
  uint target;
  int c;

  iunlock(ip);
8010027f:	57                   	push   %edi
80100280:	e8 eb 14 00 00       	call   80101770 <iunlock>
  target = n;
  acquire(&cons.lock);
80100285:	c7 04 24 e0 b7 10 80 	movl   $0x8010b7e0,(%esp)
8010028c:	e8 4f 46 00 00       	call   801048e0 <acquire>
  while(n > 0){
80100291:	8b 5d 10             	mov    0x10(%ebp),%ebx
80100294:	83 c4 10             	add    $0x10,%esp
80100297:	31 c0                	xor    %eax,%eax
80100299:	85 db                	test   %ebx,%ebx
8010029b:	0f 8e a1 00 00 00    	jle    80100342 <consoleread+0xd2>
    while(input.r == input.w){
801002a1:	8b 15 60 61 11 80    	mov    0x80116160,%edx
801002a7:	39 15 64 61 11 80    	cmp    %edx,0x80116164
801002ad:	74 2c                	je     801002db <consoleread+0x6b>
801002af:	eb 5f                	jmp    80100310 <consoleread+0xa0>
801002b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      if(myproc()->killed){
        release(&cons.lock);
        ilock(ip);
        return -1;
      }
      sleep(&input.r, &cons.lock);
801002b8:	83 ec 08             	sub    $0x8,%esp
801002bb:	68 e0 b7 10 80       	push   $0x8010b7e0
801002c0:	68 60 61 11 80       	push   $0x80116160
801002c5:	e8 26 3d 00 00       	call   80103ff0 <sleep>
    while(input.r == input.w){
801002ca:	8b 15 60 61 11 80    	mov    0x80116160,%edx
801002d0:	83 c4 10             	add    $0x10,%esp
801002d3:	3b 15 64 61 11 80    	cmp    0x80116164,%edx
801002d9:	75 35                	jne    80100310 <consoleread+0xa0>
      if(myproc()->killed){
801002db:	e8 b0 35 00 00       	call   80103890 <myproc>
801002e0:	8b 40 24             	mov    0x24(%eax),%eax
801002e3:	85 c0                	test   %eax,%eax
801002e5:	74 d1                	je     801002b8 <consoleread+0x48>
        release(&cons.lock);
801002e7:	83 ec 0c             	sub    $0xc,%esp
801002ea:	68 e0 b7 10 80       	push   $0x8010b7e0
801002ef:	e8 ac 46 00 00       	call   801049a0 <release>
        ilock(ip);
801002f4:	89 3c 24             	mov    %edi,(%esp)
801002f7:	e8 94 13 00 00       	call   80101690 <ilock>
        return -1;
801002fc:	83 c4 10             	add    $0x10,%esp
  }
  release(&cons.lock);
  ilock(ip);

  return target - n;
}
801002ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return -1;
80100302:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100307:	5b                   	pop    %ebx
80100308:	5e                   	pop    %esi
80100309:	5f                   	pop    %edi
8010030a:	5d                   	pop    %ebp
8010030b:	c3                   	ret    
8010030c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = input.buf[input.r++ % INPUT_BUF];
80100310:	8d 42 01             	lea    0x1(%edx),%eax
80100313:	a3 60 61 11 80       	mov    %eax,0x80116160
80100318:	89 d0                	mov    %edx,%eax
8010031a:	83 e0 7f             	and    $0x7f,%eax
8010031d:	0f be 80 e0 60 11 80 	movsbl -0x7fee9f20(%eax),%eax
    if(c == C('D')){  // EOF
80100324:	83 f8 04             	cmp    $0x4,%eax
80100327:	74 3f                	je     80100368 <consoleread+0xf8>
    *dst++ = c;
80100329:	83 c6 01             	add    $0x1,%esi
    --n;
8010032c:	83 eb 01             	sub    $0x1,%ebx
    if(c == '\n')
8010032f:	83 f8 0a             	cmp    $0xa,%eax
    *dst++ = c;
80100332:	88 46 ff             	mov    %al,-0x1(%esi)
    if(c == '\n')
80100335:	74 43                	je     8010037a <consoleread+0x10a>
  while(n > 0){
80100337:	85 db                	test   %ebx,%ebx
80100339:	0f 85 62 ff ff ff    	jne    801002a1 <consoleread+0x31>
8010033f:	8b 45 10             	mov    0x10(%ebp),%eax
  release(&cons.lock);
80100342:	83 ec 0c             	sub    $0xc,%esp
80100345:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80100348:	68 e0 b7 10 80       	push   $0x8010b7e0
8010034d:	e8 4e 46 00 00       	call   801049a0 <release>
  ilock(ip);
80100352:	89 3c 24             	mov    %edi,(%esp)
80100355:	e8 36 13 00 00       	call   80101690 <ilock>
  return target - n;
8010035a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010035d:	83 c4 10             	add    $0x10,%esp
}
80100360:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100363:	5b                   	pop    %ebx
80100364:	5e                   	pop    %esi
80100365:	5f                   	pop    %edi
80100366:	5d                   	pop    %ebp
80100367:	c3                   	ret    
80100368:	8b 45 10             	mov    0x10(%ebp),%eax
8010036b:	29 d8                	sub    %ebx,%eax
      if(n < target){
8010036d:	3b 5d 10             	cmp    0x10(%ebp),%ebx
80100370:	73 d0                	jae    80100342 <consoleread+0xd2>
        input.r--;
80100372:	89 15 60 61 11 80    	mov    %edx,0x80116160
80100378:	eb c8                	jmp    80100342 <consoleread+0xd2>
8010037a:	8b 45 10             	mov    0x10(%ebp),%eax
8010037d:	29 d8                	sub    %ebx,%eax
8010037f:	eb c1                	jmp    80100342 <consoleread+0xd2>
80100381:	eb 0d                	jmp    80100390 <panic>
80100383:	90                   	nop
80100384:	90                   	nop
80100385:	90                   	nop
80100386:	90                   	nop
80100387:	90                   	nop
80100388:	90                   	nop
80100389:	90                   	nop
8010038a:	90                   	nop
8010038b:	90                   	nop
8010038c:	90                   	nop
8010038d:	90                   	nop
8010038e:	90                   	nop
8010038f:	90                   	nop

80100390 <panic>:
{
80100390:	55                   	push   %ebp
80100391:	89 e5                	mov    %esp,%ebp
80100393:	56                   	push   %esi
80100394:	53                   	push   %ebx
80100395:	83 ec 30             	sub    $0x30,%esp
}

static inline void
cli(void)
{
  asm volatile("cli");
80100398:	fa                   	cli    
  cons.locking = 0;
80100399:	c7 05 14 b8 10 80 00 	movl   $0x0,0x8010b814
801003a0:	00 00 00 
  getcallerpcs(&s, pcs);
801003a3:	8d 5d d0             	lea    -0x30(%ebp),%ebx
801003a6:	8d 75 f8             	lea    -0x8(%ebp),%esi
  cprintf("lapicid %d: panic: ", lapicid());
801003a9:	e8 a2 23 00 00       	call   80102750 <lapicid>
801003ae:	83 ec 08             	sub    $0x8,%esp
801003b1:	50                   	push   %eax
801003b2:	68 26 7e 10 80       	push   $0x80107e26
801003b7:	e8 a4 02 00 00       	call   80100660 <cprintf>
  cprintf(s);
801003bc:	58                   	pop    %eax
801003bd:	ff 75 08             	pushl  0x8(%ebp)
801003c0:	e8 9b 02 00 00       	call   80100660 <cprintf>
  cprintf("\n");
801003c5:	c7 04 24 7b 88 10 80 	movl   $0x8010887b,(%esp)
801003cc:	e8 8f 02 00 00       	call   80100660 <cprintf>
  getcallerpcs(&s, pcs);
801003d1:	5a                   	pop    %edx
801003d2:	8d 45 08             	lea    0x8(%ebp),%eax
801003d5:	59                   	pop    %ecx
801003d6:	53                   	push   %ebx
801003d7:	50                   	push   %eax
801003d8:	e8 e3 43 00 00       	call   801047c0 <getcallerpcs>
801003dd:	83 c4 10             	add    $0x10,%esp
    cprintf(" %p", pcs[i]);
801003e0:	83 ec 08             	sub    $0x8,%esp
801003e3:	ff 33                	pushl  (%ebx)
801003e5:	83 c3 04             	add    $0x4,%ebx
801003e8:	68 3a 7e 10 80       	push   $0x80107e3a
801003ed:	e8 6e 02 00 00       	call   80100660 <cprintf>
  for(i=0; i<10; i++)
801003f2:	83 c4 10             	add    $0x10,%esp
801003f5:	39 f3                	cmp    %esi,%ebx
801003f7:	75 e7                	jne    801003e0 <panic+0x50>
  panicked = 1; // freeze other CPU
801003f9:	c7 05 18 b8 10 80 01 	movl   $0x1,0x8010b818
80100400:	00 00 00 
80100403:	eb fe                	jmp    80100403 <panic+0x73>
80100405:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100410 <consputc>:
  if(panicked){
80100410:	8b 0d 18 b8 10 80    	mov    0x8010b818,%ecx
80100416:	85 c9                	test   %ecx,%ecx
80100418:	74 06                	je     80100420 <consputc+0x10>
8010041a:	fa                   	cli    
8010041b:	eb fe                	jmp    8010041b <consputc+0xb>
8010041d:	8d 76 00             	lea    0x0(%esi),%esi
{
80100420:	55                   	push   %ebp
80100421:	89 e5                	mov    %esp,%ebp
80100423:	57                   	push   %edi
80100424:	56                   	push   %esi
80100425:	53                   	push   %ebx
80100426:	89 c6                	mov    %eax,%esi
80100428:	83 ec 0c             	sub    $0xc,%esp
  if(c == BACKSPACE){
8010042b:	3d 00 01 00 00       	cmp    $0x100,%eax
80100430:	0f 84 b1 00 00 00    	je     801004e7 <consputc+0xd7>
    uartputc(c);
80100436:	83 ec 0c             	sub    $0xc,%esp
80100439:	50                   	push   %eax
8010043a:	e8 01 60 00 00       	call   80106440 <uartputc>
8010043f:	83 c4 10             	add    $0x10,%esp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100442:	bb d4 03 00 00       	mov    $0x3d4,%ebx
80100447:	b8 0e 00 00 00       	mov    $0xe,%eax
8010044c:	89 da                	mov    %ebx,%edx
8010044e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010044f:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
80100454:	89 ca                	mov    %ecx,%edx
80100456:	ec                   	in     (%dx),%al
  pos = inb(CRTPORT+1) << 8;
80100457:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010045a:	89 da                	mov    %ebx,%edx
8010045c:	c1 e0 08             	shl    $0x8,%eax
8010045f:	89 c7                	mov    %eax,%edi
80100461:	b8 0f 00 00 00       	mov    $0xf,%eax
80100466:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80100467:	89 ca                	mov    %ecx,%edx
80100469:	ec                   	in     (%dx),%al
8010046a:	0f b6 d8             	movzbl %al,%ebx
  pos |= inb(CRTPORT+1);
8010046d:	09 fb                	or     %edi,%ebx
  if(c == '\n')
8010046f:	83 fe 0a             	cmp    $0xa,%esi
80100472:	0f 84 f3 00 00 00    	je     8010056b <consputc+0x15b>
  else if(c == BACKSPACE){
80100478:	81 fe 00 01 00 00    	cmp    $0x100,%esi
8010047e:	0f 84 d7 00 00 00    	je     8010055b <consputc+0x14b>
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
80100484:	89 f0                	mov    %esi,%eax
80100486:	0f b6 c0             	movzbl %al,%eax
80100489:	80 cc 07             	or     $0x7,%ah
8010048c:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
80100493:	80 
80100494:	83 c3 01             	add    $0x1,%ebx
  if(pos < 0 || pos > 25*80)
80100497:	81 fb d0 07 00 00    	cmp    $0x7d0,%ebx
8010049d:	0f 8f ab 00 00 00    	jg     8010054e <consputc+0x13e>
  if((pos/80) >= 24){  // Scroll up.
801004a3:	81 fb 7f 07 00 00    	cmp    $0x77f,%ebx
801004a9:	7f 66                	jg     80100511 <consputc+0x101>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801004ab:	be d4 03 00 00       	mov    $0x3d4,%esi
801004b0:	b8 0e 00 00 00       	mov    $0xe,%eax
801004b5:	89 f2                	mov    %esi,%edx
801004b7:	ee                   	out    %al,(%dx)
801004b8:	b9 d5 03 00 00       	mov    $0x3d5,%ecx
  outb(CRTPORT+1, pos>>8);
801004bd:	89 d8                	mov    %ebx,%eax
801004bf:	c1 f8 08             	sar    $0x8,%eax
801004c2:	89 ca                	mov    %ecx,%edx
801004c4:	ee                   	out    %al,(%dx)
801004c5:	b8 0f 00 00 00       	mov    $0xf,%eax
801004ca:	89 f2                	mov    %esi,%edx
801004cc:	ee                   	out    %al,(%dx)
801004cd:	89 d8                	mov    %ebx,%eax
801004cf:	89 ca                	mov    %ecx,%edx
801004d1:	ee                   	out    %al,(%dx)
  crt[pos] = ' ' | 0x0700;
801004d2:	b8 20 07 00 00       	mov    $0x720,%eax
801004d7:	66 89 84 1b 00 80 0b 	mov    %ax,-0x7ff48000(%ebx,%ebx,1)
801004de:	80 
}
801004df:	8d 65 f4             	lea    -0xc(%ebp),%esp
801004e2:	5b                   	pop    %ebx
801004e3:	5e                   	pop    %esi
801004e4:	5f                   	pop    %edi
801004e5:	5d                   	pop    %ebp
801004e6:	c3                   	ret    
    uartputc('\b'); uartputc(' '); uartputc('\b');
801004e7:	83 ec 0c             	sub    $0xc,%esp
801004ea:	6a 08                	push   $0x8
801004ec:	e8 4f 5f 00 00       	call   80106440 <uartputc>
801004f1:	c7 04 24 20 00 00 00 	movl   $0x20,(%esp)
801004f8:	e8 43 5f 00 00       	call   80106440 <uartputc>
801004fd:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
80100504:	e8 37 5f 00 00       	call   80106440 <uartputc>
80100509:	83 c4 10             	add    $0x10,%esp
8010050c:	e9 31 ff ff ff       	jmp    80100442 <consputc+0x32>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
80100511:	52                   	push   %edx
80100512:	68 60 0e 00 00       	push   $0xe60
    pos -= 80;
80100517:	83 eb 50             	sub    $0x50,%ebx
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010051a:	68 a0 80 0b 80       	push   $0x800b80a0
8010051f:	68 00 80 0b 80       	push   $0x800b8000
80100524:	e8 77 45 00 00       	call   80104aa0 <memmove>
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100529:	b8 80 07 00 00       	mov    $0x780,%eax
8010052e:	83 c4 0c             	add    $0xc,%esp
80100531:	29 d8                	sub    %ebx,%eax
80100533:	01 c0                	add    %eax,%eax
80100535:	50                   	push   %eax
80100536:	8d 04 1b             	lea    (%ebx,%ebx,1),%eax
80100539:	6a 00                	push   $0x0
8010053b:	2d 00 80 f4 7f       	sub    $0x7ff48000,%eax
80100540:	50                   	push   %eax
80100541:	e8 aa 44 00 00       	call   801049f0 <memset>
80100546:	83 c4 10             	add    $0x10,%esp
80100549:	e9 5d ff ff ff       	jmp    801004ab <consputc+0x9b>
    panic("pos under/overflow");
8010054e:	83 ec 0c             	sub    $0xc,%esp
80100551:	68 3e 7e 10 80       	push   $0x80107e3e
80100556:	e8 35 fe ff ff       	call   80100390 <panic>
    if(pos > 0) --pos;
8010055b:	85 db                	test   %ebx,%ebx
8010055d:	0f 84 48 ff ff ff    	je     801004ab <consputc+0x9b>
80100563:	83 eb 01             	sub    $0x1,%ebx
80100566:	e9 2c ff ff ff       	jmp    80100497 <consputc+0x87>
    pos += 80 - pos%80;
8010056b:	89 d8                	mov    %ebx,%eax
8010056d:	b9 50 00 00 00       	mov    $0x50,%ecx
80100572:	99                   	cltd   
80100573:	f7 f9                	idiv   %ecx
80100575:	29 d1                	sub    %edx,%ecx
80100577:	01 cb                	add    %ecx,%ebx
80100579:	e9 19 ff ff ff       	jmp    80100497 <consputc+0x87>
8010057e:	66 90                	xchg   %ax,%ax

80100580 <printint>:
{
80100580:	55                   	push   %ebp
80100581:	89 e5                	mov    %esp,%ebp
80100583:	57                   	push   %edi
80100584:	56                   	push   %esi
80100585:	53                   	push   %ebx
80100586:	89 d3                	mov    %edx,%ebx
80100588:	83 ec 2c             	sub    $0x2c,%esp
  if(sign && (sign = xx < 0))
8010058b:	85 c9                	test   %ecx,%ecx
{
8010058d:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
  if(sign && (sign = xx < 0))
80100590:	74 04                	je     80100596 <printint+0x16>
80100592:	85 c0                	test   %eax,%eax
80100594:	78 5a                	js     801005f0 <printint+0x70>
    x = xx;
80100596:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  i = 0;
8010059d:	31 c9                	xor    %ecx,%ecx
8010059f:	8d 75 d7             	lea    -0x29(%ebp),%esi
801005a2:	eb 06                	jmp    801005aa <printint+0x2a>
801005a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    buf[i++] = digits[x % base];
801005a8:	89 f9                	mov    %edi,%ecx
801005aa:	31 d2                	xor    %edx,%edx
801005ac:	8d 79 01             	lea    0x1(%ecx),%edi
801005af:	f7 f3                	div    %ebx
801005b1:	0f b6 92 6c 7e 10 80 	movzbl -0x7fef8194(%edx),%edx
  }while((x /= base) != 0);
801005b8:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
801005ba:	88 14 3e             	mov    %dl,(%esi,%edi,1)
  }while((x /= base) != 0);
801005bd:	75 e9                	jne    801005a8 <printint+0x28>
  if(sign)
801005bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
801005c2:	85 c0                	test   %eax,%eax
801005c4:	74 08                	je     801005ce <printint+0x4e>
    buf[i++] = '-';
801005c6:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
801005cb:	8d 79 02             	lea    0x2(%ecx),%edi
801005ce:	8d 5c 3d d7          	lea    -0x29(%ebp,%edi,1),%ebx
801005d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    consputc(buf[i]);
801005d8:	0f be 03             	movsbl (%ebx),%eax
801005db:	83 eb 01             	sub    $0x1,%ebx
801005de:	e8 2d fe ff ff       	call   80100410 <consputc>
  while(--i >= 0)
801005e3:	39 f3                	cmp    %esi,%ebx
801005e5:	75 f1                	jne    801005d8 <printint+0x58>
}
801005e7:	83 c4 2c             	add    $0x2c,%esp
801005ea:	5b                   	pop    %ebx
801005eb:	5e                   	pop    %esi
801005ec:	5f                   	pop    %edi
801005ed:	5d                   	pop    %ebp
801005ee:	c3                   	ret    
801005ef:	90                   	nop
    x = -xx;
801005f0:	f7 d8                	neg    %eax
801005f2:	eb a9                	jmp    8010059d <printint+0x1d>
801005f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801005fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80100600 <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100600:	55                   	push   %ebp
80100601:	89 e5                	mov    %esp,%ebp
80100603:	57                   	push   %edi
80100604:	56                   	push   %esi
80100605:	53                   	push   %ebx
80100606:	83 ec 18             	sub    $0x18,%esp
80100609:	8b 75 10             	mov    0x10(%ebp),%esi
  int i;

  iunlock(ip);
8010060c:	ff 75 08             	pushl  0x8(%ebp)
8010060f:	e8 5c 11 00 00       	call   80101770 <iunlock>
  acquire(&cons.lock);
80100614:	c7 04 24 e0 b7 10 80 	movl   $0x8010b7e0,(%esp)
8010061b:	e8 c0 42 00 00       	call   801048e0 <acquire>
  for(i = 0; i < n; i++)
80100620:	83 c4 10             	add    $0x10,%esp
80100623:	85 f6                	test   %esi,%esi
80100625:	7e 18                	jle    8010063f <consolewrite+0x3f>
80100627:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010062a:	8d 1c 37             	lea    (%edi,%esi,1),%ebx
8010062d:	8d 76 00             	lea    0x0(%esi),%esi
    consputc(buf[i] & 0xff);
80100630:	0f b6 07             	movzbl (%edi),%eax
80100633:	83 c7 01             	add    $0x1,%edi
80100636:	e8 d5 fd ff ff       	call   80100410 <consputc>
  for(i = 0; i < n; i++)
8010063b:	39 fb                	cmp    %edi,%ebx
8010063d:	75 f1                	jne    80100630 <consolewrite+0x30>
  release(&cons.lock);
8010063f:	83 ec 0c             	sub    $0xc,%esp
80100642:	68 e0 b7 10 80       	push   $0x8010b7e0
80100647:	e8 54 43 00 00       	call   801049a0 <release>
  ilock(ip);
8010064c:	58                   	pop    %eax
8010064d:	ff 75 08             	pushl  0x8(%ebp)
80100650:	e8 3b 10 00 00       	call   80101690 <ilock>

  return n;
}
80100655:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100658:	89 f0                	mov    %esi,%eax
8010065a:	5b                   	pop    %ebx
8010065b:	5e                   	pop    %esi
8010065c:	5f                   	pop    %edi
8010065d:	5d                   	pop    %ebp
8010065e:	c3                   	ret    
8010065f:	90                   	nop

80100660 <cprintf>:
{
80100660:	55                   	push   %ebp
80100661:	89 e5                	mov    %esp,%ebp
80100663:	57                   	push   %edi
80100664:	56                   	push   %esi
80100665:	53                   	push   %ebx
80100666:	83 ec 1c             	sub    $0x1c,%esp
  locking = cons.locking;
80100669:	a1 14 b8 10 80       	mov    0x8010b814,%eax
  if(locking)
8010066e:	85 c0                	test   %eax,%eax
  locking = cons.locking;
80100670:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if(locking)
80100673:	0f 85 6f 01 00 00    	jne    801007e8 <cprintf+0x188>
  if (fmt == 0)
80100679:	8b 45 08             	mov    0x8(%ebp),%eax
8010067c:	85 c0                	test   %eax,%eax
8010067e:	89 c7                	mov    %eax,%edi
80100680:	0f 84 77 01 00 00    	je     801007fd <cprintf+0x19d>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100686:	0f b6 00             	movzbl (%eax),%eax
  argp = (uint*)(void*)(&fmt + 1);
80100689:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010068c:	31 db                	xor    %ebx,%ebx
  argp = (uint*)(void*)(&fmt + 1);
8010068e:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100691:	85 c0                	test   %eax,%eax
80100693:	75 56                	jne    801006eb <cprintf+0x8b>
80100695:	eb 79                	jmp    80100710 <cprintf+0xb0>
80100697:	89 f6                	mov    %esi,%esi
80100699:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    c = fmt[++i] & 0xff;
801006a0:	0f b6 16             	movzbl (%esi),%edx
    if(c == 0)
801006a3:	85 d2                	test   %edx,%edx
801006a5:	74 69                	je     80100710 <cprintf+0xb0>
801006a7:	83 c3 02             	add    $0x2,%ebx
    switch(c){
801006aa:	83 fa 70             	cmp    $0x70,%edx
801006ad:	8d 34 1f             	lea    (%edi,%ebx,1),%esi
801006b0:	0f 84 84 00 00 00    	je     8010073a <cprintf+0xda>
801006b6:	7f 78                	jg     80100730 <cprintf+0xd0>
801006b8:	83 fa 25             	cmp    $0x25,%edx
801006bb:	0f 84 ff 00 00 00    	je     801007c0 <cprintf+0x160>
801006c1:	83 fa 64             	cmp    $0x64,%edx
801006c4:	0f 85 8e 00 00 00    	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 10, 1);
801006ca:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801006cd:	ba 0a 00 00 00       	mov    $0xa,%edx
801006d2:	8d 48 04             	lea    0x4(%eax),%ecx
801006d5:	8b 00                	mov    (%eax),%eax
801006d7:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801006da:	b9 01 00 00 00       	mov    $0x1,%ecx
801006df:	e8 9c fe ff ff       	call   80100580 <printint>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006e4:	0f b6 06             	movzbl (%esi),%eax
801006e7:	85 c0                	test   %eax,%eax
801006e9:	74 25                	je     80100710 <cprintf+0xb0>
801006eb:	8d 53 01             	lea    0x1(%ebx),%edx
    if(c != '%'){
801006ee:	83 f8 25             	cmp    $0x25,%eax
801006f1:	8d 34 17             	lea    (%edi,%edx,1),%esi
801006f4:	74 aa                	je     801006a0 <cprintf+0x40>
801006f6:	89 55 e0             	mov    %edx,-0x20(%ebp)
      consputc(c);
801006f9:	e8 12 fd ff ff       	call   80100410 <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
801006fe:	0f b6 06             	movzbl (%esi),%eax
      continue;
80100701:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100704:	89 d3                	mov    %edx,%ebx
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100706:	85 c0                	test   %eax,%eax
80100708:	75 e1                	jne    801006eb <cprintf+0x8b>
8010070a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  if(locking)
80100710:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100713:	85 c0                	test   %eax,%eax
80100715:	74 10                	je     80100727 <cprintf+0xc7>
    release(&cons.lock);
80100717:	83 ec 0c             	sub    $0xc,%esp
8010071a:	68 e0 b7 10 80       	push   $0x8010b7e0
8010071f:	e8 7c 42 00 00       	call   801049a0 <release>
80100724:	83 c4 10             	add    $0x10,%esp
}
80100727:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010072a:	5b                   	pop    %ebx
8010072b:	5e                   	pop    %esi
8010072c:	5f                   	pop    %edi
8010072d:	5d                   	pop    %ebp
8010072e:	c3                   	ret    
8010072f:	90                   	nop
    switch(c){
80100730:	83 fa 73             	cmp    $0x73,%edx
80100733:	74 43                	je     80100778 <cprintf+0x118>
80100735:	83 fa 78             	cmp    $0x78,%edx
80100738:	75 1e                	jne    80100758 <cprintf+0xf8>
      printint(*argp++, 16, 0);
8010073a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010073d:	ba 10 00 00 00       	mov    $0x10,%edx
80100742:	8d 48 04             	lea    0x4(%eax),%ecx
80100745:	8b 00                	mov    (%eax),%eax
80100747:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
8010074a:	31 c9                	xor    %ecx,%ecx
8010074c:	e8 2f fe ff ff       	call   80100580 <printint>
      break;
80100751:	eb 91                	jmp    801006e4 <cprintf+0x84>
80100753:	90                   	nop
80100754:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      consputc('%');
80100758:	b8 25 00 00 00       	mov    $0x25,%eax
8010075d:	89 55 e0             	mov    %edx,-0x20(%ebp)
80100760:	e8 ab fc ff ff       	call   80100410 <consputc>
      consputc(c);
80100765:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100768:	89 d0                	mov    %edx,%eax
8010076a:	e8 a1 fc ff ff       	call   80100410 <consputc>
      break;
8010076f:	e9 70 ff ff ff       	jmp    801006e4 <cprintf+0x84>
80100774:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if((s = (char*)*argp++) == 0)
80100778:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010077b:	8b 10                	mov    (%eax),%edx
8010077d:	8d 48 04             	lea    0x4(%eax),%ecx
80100780:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80100783:	85 d2                	test   %edx,%edx
80100785:	74 49                	je     801007d0 <cprintf+0x170>
      for(; *s; s++)
80100787:	0f be 02             	movsbl (%edx),%eax
      if((s = (char*)*argp++) == 0)
8010078a:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      for(; *s; s++)
8010078d:	84 c0                	test   %al,%al
8010078f:	0f 84 4f ff ff ff    	je     801006e4 <cprintf+0x84>
80100795:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
80100798:	89 d3                	mov    %edx,%ebx
8010079a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801007a0:	83 c3 01             	add    $0x1,%ebx
        consputc(*s);
801007a3:	e8 68 fc ff ff       	call   80100410 <consputc>
      for(; *s; s++)
801007a8:	0f be 03             	movsbl (%ebx),%eax
801007ab:	84 c0                	test   %al,%al
801007ad:	75 f1                	jne    801007a0 <cprintf+0x140>
      if((s = (char*)*argp++) == 0)
801007af:	8b 45 e0             	mov    -0x20(%ebp),%eax
801007b2:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
801007b5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801007b8:	e9 27 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007bd:	8d 76 00             	lea    0x0(%esi),%esi
      consputc('%');
801007c0:	b8 25 00 00 00       	mov    $0x25,%eax
801007c5:	e8 46 fc ff ff       	call   80100410 <consputc>
      break;
801007ca:	e9 15 ff ff ff       	jmp    801006e4 <cprintf+0x84>
801007cf:	90                   	nop
        s = "(null)";
801007d0:	ba 51 7e 10 80       	mov    $0x80107e51,%edx
      for(; *s; s++)
801007d5:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
801007d8:	b8 28 00 00 00       	mov    $0x28,%eax
801007dd:	89 d3                	mov    %edx,%ebx
801007df:	eb bf                	jmp    801007a0 <cprintf+0x140>
801007e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    acquire(&cons.lock);
801007e8:	83 ec 0c             	sub    $0xc,%esp
801007eb:	68 e0 b7 10 80       	push   $0x8010b7e0
801007f0:	e8 eb 40 00 00       	call   801048e0 <acquire>
801007f5:	83 c4 10             	add    $0x10,%esp
801007f8:	e9 7c fe ff ff       	jmp    80100679 <cprintf+0x19>
    panic("null fmt");
801007fd:	83 ec 0c             	sub    $0xc,%esp
80100800:	68 58 7e 10 80       	push   $0x80107e58
80100805:	e8 86 fb ff ff       	call   80100390 <panic>
8010080a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100810 <consoleintr>:
{
80100810:	55                   	push   %ebp
80100811:	89 e5                	mov    %esp,%ebp
80100813:	57                   	push   %edi
80100814:	56                   	push   %esi
80100815:	53                   	push   %ebx
  int c, doprocdump = 0;
80100816:	31 f6                	xor    %esi,%esi
{
80100818:	83 ec 18             	sub    $0x18,%esp
8010081b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&cons.lock);
8010081e:	68 e0 b7 10 80       	push   $0x8010b7e0
80100823:	e8 b8 40 00 00       	call   801048e0 <acquire>
  while((c = getc()) >= 0){
80100828:	83 c4 10             	add    $0x10,%esp
8010082b:	90                   	nop
8010082c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100830:	ff d3                	call   *%ebx
80100832:	85 c0                	test   %eax,%eax
80100834:	89 c7                	mov    %eax,%edi
80100836:	78 48                	js     80100880 <consoleintr+0x70>
    switch(c){
80100838:	83 ff 10             	cmp    $0x10,%edi
8010083b:	0f 84 e7 00 00 00    	je     80100928 <consoleintr+0x118>
80100841:	7e 5d                	jle    801008a0 <consoleintr+0x90>
80100843:	83 ff 15             	cmp    $0x15,%edi
80100846:	0f 84 ec 00 00 00    	je     80100938 <consoleintr+0x128>
8010084c:	83 ff 7f             	cmp    $0x7f,%edi
8010084f:	75 54                	jne    801008a5 <consoleintr+0x95>
      if(input.e != input.w){
80100851:	a1 68 61 11 80       	mov    0x80116168,%eax
80100856:	3b 05 64 61 11 80    	cmp    0x80116164,%eax
8010085c:	74 d2                	je     80100830 <consoleintr+0x20>
        input.e--;
8010085e:	83 e8 01             	sub    $0x1,%eax
80100861:	a3 68 61 11 80       	mov    %eax,0x80116168
        consputc(BACKSPACE);
80100866:	b8 00 01 00 00       	mov    $0x100,%eax
8010086b:	e8 a0 fb ff ff       	call   80100410 <consputc>
  while((c = getc()) >= 0){
80100870:	ff d3                	call   *%ebx
80100872:	85 c0                	test   %eax,%eax
80100874:	89 c7                	mov    %eax,%edi
80100876:	79 c0                	jns    80100838 <consoleintr+0x28>
80100878:	90                   	nop
80100879:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  release(&cons.lock);
80100880:	83 ec 0c             	sub    $0xc,%esp
80100883:	68 e0 b7 10 80       	push   $0x8010b7e0
80100888:	e8 13 41 00 00       	call   801049a0 <release>
  if(doprocdump) {
8010088d:	83 c4 10             	add    $0x10,%esp
80100890:	85 f6                	test   %esi,%esi
80100892:	0f 85 f8 00 00 00    	jne    80100990 <consoleintr+0x180>
}
80100898:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010089b:	5b                   	pop    %ebx
8010089c:	5e                   	pop    %esi
8010089d:	5f                   	pop    %edi
8010089e:	5d                   	pop    %ebp
8010089f:	c3                   	ret    
    switch(c){
801008a0:	83 ff 08             	cmp    $0x8,%edi
801008a3:	74 ac                	je     80100851 <consoleintr+0x41>
      if(c != 0 && input.e-input.r < INPUT_BUF){
801008a5:	85 ff                	test   %edi,%edi
801008a7:	74 87                	je     80100830 <consoleintr+0x20>
801008a9:	a1 68 61 11 80       	mov    0x80116168,%eax
801008ae:	89 c2                	mov    %eax,%edx
801008b0:	2b 15 60 61 11 80    	sub    0x80116160,%edx
801008b6:	83 fa 7f             	cmp    $0x7f,%edx
801008b9:	0f 87 71 ff ff ff    	ja     80100830 <consoleintr+0x20>
801008bf:	8d 50 01             	lea    0x1(%eax),%edx
801008c2:	83 e0 7f             	and    $0x7f,%eax
        c = (c == '\r') ? '\n' : c;
801008c5:	83 ff 0d             	cmp    $0xd,%edi
        input.buf[input.e++ % INPUT_BUF] = c;
801008c8:	89 15 68 61 11 80    	mov    %edx,0x80116168
        c = (c == '\r') ? '\n' : c;
801008ce:	0f 84 cc 00 00 00    	je     801009a0 <consoleintr+0x190>
        input.buf[input.e++ % INPUT_BUF] = c;
801008d4:	89 f9                	mov    %edi,%ecx
801008d6:	88 88 e0 60 11 80    	mov    %cl,-0x7fee9f20(%eax)
        consputc(c);
801008dc:	89 f8                	mov    %edi,%eax
801008de:	e8 2d fb ff ff       	call   80100410 <consputc>
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
801008e3:	83 ff 0a             	cmp    $0xa,%edi
801008e6:	0f 84 c5 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008ec:	83 ff 04             	cmp    $0x4,%edi
801008ef:	0f 84 bc 00 00 00    	je     801009b1 <consoleintr+0x1a1>
801008f5:	a1 60 61 11 80       	mov    0x80116160,%eax
801008fa:	83 e8 80             	sub    $0xffffff80,%eax
801008fd:	39 05 68 61 11 80    	cmp    %eax,0x80116168
80100903:	0f 85 27 ff ff ff    	jne    80100830 <consoleintr+0x20>
          wakeup(&input.r);
80100909:	83 ec 0c             	sub    $0xc,%esp
          input.w = input.e;
8010090c:	a3 64 61 11 80       	mov    %eax,0x80116164
          wakeup(&input.r);
80100911:	68 60 61 11 80       	push   $0x80116160
80100916:	e8 95 38 00 00       	call   801041b0 <wakeup>
8010091b:	83 c4 10             	add    $0x10,%esp
8010091e:	e9 0d ff ff ff       	jmp    80100830 <consoleintr+0x20>
80100923:	90                   	nop
80100924:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      doprocdump = 1;
80100928:	be 01 00 00 00       	mov    $0x1,%esi
8010092d:	e9 fe fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100932:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      while(input.e != input.w &&
80100938:	a1 68 61 11 80       	mov    0x80116168,%eax
8010093d:	39 05 64 61 11 80    	cmp    %eax,0x80116164
80100943:	75 2b                	jne    80100970 <consoleintr+0x160>
80100945:	e9 e6 fe ff ff       	jmp    80100830 <consoleintr+0x20>
8010094a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        input.e--;
80100950:	a3 68 61 11 80       	mov    %eax,0x80116168
        consputc(BACKSPACE);
80100955:	b8 00 01 00 00       	mov    $0x100,%eax
8010095a:	e8 b1 fa ff ff       	call   80100410 <consputc>
      while(input.e != input.w &&
8010095f:	a1 68 61 11 80       	mov    0x80116168,%eax
80100964:	3b 05 64 61 11 80    	cmp    0x80116164,%eax
8010096a:	0f 84 c0 fe ff ff    	je     80100830 <consoleintr+0x20>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
80100970:	83 e8 01             	sub    $0x1,%eax
80100973:	89 c2                	mov    %eax,%edx
80100975:	83 e2 7f             	and    $0x7f,%edx
      while(input.e != input.w &&
80100978:	80 ba e0 60 11 80 0a 	cmpb   $0xa,-0x7fee9f20(%edx)
8010097f:	75 cf                	jne    80100950 <consoleintr+0x140>
80100981:	e9 aa fe ff ff       	jmp    80100830 <consoleintr+0x20>
80100986:	8d 76 00             	lea    0x0(%esi),%esi
80100989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
}
80100990:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100993:	5b                   	pop    %ebx
80100994:	5e                   	pop    %esi
80100995:	5f                   	pop    %edi
80100996:	5d                   	pop    %ebp
    procdump();  // now call procdump() wo. cons.lock held
80100997:	e9 44 39 00 00       	jmp    801042e0 <procdump>
8010099c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        input.buf[input.e++ % INPUT_BUF] = c;
801009a0:	c6 80 e0 60 11 80 0a 	movb   $0xa,-0x7fee9f20(%eax)
        consputc(c);
801009a7:	b8 0a 00 00 00       	mov    $0xa,%eax
801009ac:	e8 5f fa ff ff       	call   80100410 <consputc>
801009b1:	a1 68 61 11 80       	mov    0x80116168,%eax
801009b6:	e9 4e ff ff ff       	jmp    80100909 <consoleintr+0xf9>
801009bb:	90                   	nop
801009bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801009c0 <consoleinit>:

void
consoleinit(void)
{
801009c0:	55                   	push   %ebp
801009c1:	89 e5                	mov    %esp,%ebp
801009c3:	83 ec 10             	sub    $0x10,%esp
  initlock(&cons.lock, "console");
801009c6:	68 61 7e 10 80       	push   $0x80107e61
801009cb:	68 e0 b7 10 80       	push   $0x8010b7e0
801009d0:	e8 cb 3d 00 00       	call   801047a0 <initlock>

  devsw[CONSOLE].write = consolewrite;
  devsw[CONSOLE].read = consoleread;
  cons.locking = 1;

  ioapicenable(IRQ_KBD, 0);
801009d5:	58                   	pop    %eax
801009d6:	5a                   	pop    %edx
801009d7:	6a 00                	push   $0x0
801009d9:	6a 01                	push   $0x1
  devsw[CONSOLE].write = consolewrite;
801009db:	c7 05 2c 6b 11 80 00 	movl   $0x80100600,0x80116b2c
801009e2:	06 10 80 
  devsw[CONSOLE].read = consoleread;
801009e5:	c7 05 28 6b 11 80 70 	movl   $0x80100270,0x80116b28
801009ec:	02 10 80 
  cons.locking = 1;
801009ef:	c7 05 14 b8 10 80 01 	movl   $0x1,0x8010b814
801009f6:	00 00 00 
  ioapicenable(IRQ_KBD, 0);
801009f9:	e8 f2 18 00 00       	call   801022f0 <ioapicenable>
}
801009fe:	83 c4 10             	add    $0x10,%esp
80100a01:	c9                   	leave  
80100a02:	c3                   	ret    
80100a03:	66 90                	xchg   %ax,%ax
80100a05:	66 90                	xchg   %ax,%ax
80100a07:	66 90                	xchg   %ax,%ax
80100a09:	66 90                	xchg   %ax,%ax
80100a0b:	66 90                	xchg   %ax,%ax
80100a0d:	66 90                	xchg   %ax,%ax
80100a0f:	90                   	nop

80100a10 <exec>:
#include "elf.h"
// #include <string.h>

int
exec(char *path, char **argv)
{
80100a10:	55                   	push   %ebp
80100a11:	89 e5                	mov    %esp,%ebp
80100a13:	57                   	push   %edi
80100a14:	56                   	push   %esi
80100a15:	53                   	push   %ebx
80100a16:	81 ec 0c 01 00 00    	sub    $0x10c,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100a1c:	e8 6f 2e 00 00       	call   80103890 <myproc>
80100a21:	89 85 f4 fe ff ff    	mov    %eax,-0x10c(%ebp)

  begin_op();
80100a27:	e8 94 21 00 00       	call   80102bc0 <begin_op>

  if((ip = namei(path)) == 0){
80100a2c:	83 ec 0c             	sub    $0xc,%esp
80100a2f:	ff 75 08             	pushl  0x8(%ebp)
80100a32:	e8 c9 14 00 00       	call   80101f00 <namei>
80100a37:	83 c4 10             	add    $0x10,%esp
80100a3a:	85 c0                	test   %eax,%eax
80100a3c:	0f 84 91 01 00 00    	je     80100bd3 <exec+0x1c3>
    end_op();
    cprintf("exec: fail\n");
    return -1;
  }
  ilock(ip);
80100a42:	83 ec 0c             	sub    $0xc,%esp
80100a45:	89 c3                	mov    %eax,%ebx
80100a47:	50                   	push   %eax
80100a48:	e8 43 0c 00 00       	call   80101690 <ilock>
  pgdir = 0;

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100a4d:	8d 85 24 ff ff ff    	lea    -0xdc(%ebp),%eax
80100a53:	6a 34                	push   $0x34
80100a55:	6a 00                	push   $0x0
80100a57:	50                   	push   %eax
80100a58:	53                   	push   %ebx
80100a59:	e8 12 0f 00 00       	call   80101970 <readi>
80100a5e:	83 c4 20             	add    $0x20,%esp
80100a61:	83 f8 34             	cmp    $0x34,%eax
80100a64:	74 22                	je     80100a88 <exec+0x78>

 bad:
  if(pgdir)
    freevm(pgdir);
  if(ip){
    iunlockput(ip);
80100a66:	83 ec 0c             	sub    $0xc,%esp
80100a69:	53                   	push   %ebx
80100a6a:	e8 b1 0e 00 00       	call   80101920 <iunlockput>
    end_op();
80100a6f:	e8 bc 21 00 00       	call   80102c30 <end_op>
80100a74:	83 c4 10             	add    $0x10,%esp
  }
  return -1;
80100a77:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80100a7c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100a7f:	5b                   	pop    %ebx
80100a80:	5e                   	pop    %esi
80100a81:	5f                   	pop    %edi
80100a82:	5d                   	pop    %ebp
80100a83:	c3                   	ret    
80100a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(elf.magic != ELF_MAGIC)
80100a88:	81 bd 24 ff ff ff 7f 	cmpl   $0x464c457f,-0xdc(%ebp)
80100a8f:	45 4c 46 
80100a92:	75 d2                	jne    80100a66 <exec+0x56>
  if((pgdir = setupkvm()) == 0)
80100a94:	e8 f7 6a 00 00       	call   80107590 <setupkvm>
80100a99:	85 c0                	test   %eax,%eax
80100a9b:	89 85 f0 fe ff ff    	mov    %eax,-0x110(%ebp)
80100aa1:	74 c3                	je     80100a66 <exec+0x56>
  sz = 0;
80100aa3:	31 ff                	xor    %edi,%edi
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100aa5:	66 83 bd 50 ff ff ff 	cmpw   $0x0,-0xb0(%ebp)
80100aac:	00 
80100aad:	8b 85 40 ff ff ff    	mov    -0xc0(%ebp),%eax
80100ab3:	89 85 ec fe ff ff    	mov    %eax,-0x114(%ebp)
80100ab9:	0f 84 8e 02 00 00    	je     80100d4d <exec+0x33d>
80100abf:	31 f6                	xor    %esi,%esi
80100ac1:	eb 7f                	jmp    80100b42 <exec+0x132>
80100ac3:	90                   	nop
80100ac4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ph.type != ELF_PROG_LOAD)
80100ac8:	83 bd 04 ff ff ff 01 	cmpl   $0x1,-0xfc(%ebp)
80100acf:	75 63                	jne    80100b34 <exec+0x124>
    if(ph.memsz < ph.filesz)
80100ad1:	8b 85 18 ff ff ff    	mov    -0xe8(%ebp),%eax
80100ad7:	3b 85 14 ff ff ff    	cmp    -0xec(%ebp),%eax
80100add:	0f 82 86 00 00 00    	jb     80100b69 <exec+0x159>
80100ae3:	03 85 0c ff ff ff    	add    -0xf4(%ebp),%eax
80100ae9:	72 7e                	jb     80100b69 <exec+0x159>
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100aeb:	83 ec 04             	sub    $0x4,%esp
80100aee:	50                   	push   %eax
80100aef:	57                   	push   %edi
80100af0:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100af6:	e8 b5 68 00 00       	call   801073b0 <allocuvm>
80100afb:	83 c4 10             	add    $0x10,%esp
80100afe:	85 c0                	test   %eax,%eax
80100b00:	89 c7                	mov    %eax,%edi
80100b02:	74 65                	je     80100b69 <exec+0x159>
    if(ph.vaddr % PGSIZE != 0)
80100b04:	8b 85 0c ff ff ff    	mov    -0xf4(%ebp),%eax
80100b0a:	a9 ff 0f 00 00       	test   $0xfff,%eax
80100b0f:	75 58                	jne    80100b69 <exec+0x159>
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100b11:	83 ec 0c             	sub    $0xc,%esp
80100b14:	ff b5 14 ff ff ff    	pushl  -0xec(%ebp)
80100b1a:	ff b5 08 ff ff ff    	pushl  -0xf8(%ebp)
80100b20:	53                   	push   %ebx
80100b21:	50                   	push   %eax
80100b22:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b28:	e8 c3 67 00 00       	call   801072f0 <loaduvm>
80100b2d:	83 c4 20             	add    $0x20,%esp
80100b30:	85 c0                	test   %eax,%eax
80100b32:	78 35                	js     80100b69 <exec+0x159>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100b34:	0f b7 85 50 ff ff ff 	movzwl -0xb0(%ebp),%eax
80100b3b:	83 c6 01             	add    $0x1,%esi
80100b3e:	39 f0                	cmp    %esi,%eax
80100b40:	7e 3d                	jle    80100b7f <exec+0x16f>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100b42:	89 f0                	mov    %esi,%eax
80100b44:	6a 20                	push   $0x20
80100b46:	c1 e0 05             	shl    $0x5,%eax
80100b49:	03 85 ec fe ff ff    	add    -0x114(%ebp),%eax
80100b4f:	50                   	push   %eax
80100b50:	8d 85 04 ff ff ff    	lea    -0xfc(%ebp),%eax
80100b56:	50                   	push   %eax
80100b57:	53                   	push   %ebx
80100b58:	e8 13 0e 00 00       	call   80101970 <readi>
80100b5d:	83 c4 10             	add    $0x10,%esp
80100b60:	83 f8 20             	cmp    $0x20,%eax
80100b63:	0f 84 5f ff ff ff    	je     80100ac8 <exec+0xb8>
    freevm(pgdir);
80100b69:	83 ec 0c             	sub    $0xc,%esp
80100b6c:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100b72:	e8 99 69 00 00       	call   80107510 <freevm>
80100b77:	83 c4 10             	add    $0x10,%esp
80100b7a:	e9 e7 fe ff ff       	jmp    80100a66 <exec+0x56>
80100b7f:	81 c7 ff 0f 00 00    	add    $0xfff,%edi
80100b85:	81 e7 00 f0 ff ff    	and    $0xfffff000,%edi
80100b8b:	8d b7 00 20 00 00    	lea    0x2000(%edi),%esi
  iunlockput(ip);
80100b91:	83 ec 0c             	sub    $0xc,%esp
80100b94:	53                   	push   %ebx
80100b95:	e8 86 0d 00 00       	call   80101920 <iunlockput>
  end_op();
80100b9a:	e8 91 20 00 00       	call   80102c30 <end_op>
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100b9f:	83 c4 0c             	add    $0xc,%esp
80100ba2:	56                   	push   %esi
80100ba3:	57                   	push   %edi
80100ba4:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100baa:	e8 01 68 00 00       	call   801073b0 <allocuvm>
80100baf:	83 c4 10             	add    $0x10,%esp
80100bb2:	85 c0                	test   %eax,%eax
80100bb4:	89 c6                	mov    %eax,%esi
80100bb6:	75 3a                	jne    80100bf2 <exec+0x1e2>
    freevm(pgdir);
80100bb8:	83 ec 0c             	sub    $0xc,%esp
80100bbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100bc1:	e8 4a 69 00 00       	call   80107510 <freevm>
80100bc6:	83 c4 10             	add    $0x10,%esp
  return -1;
80100bc9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bce:	e9 a9 fe ff ff       	jmp    80100a7c <exec+0x6c>
    end_op();
80100bd3:	e8 58 20 00 00       	call   80102c30 <end_op>
    cprintf("exec: fail\n");
80100bd8:	83 ec 0c             	sub    $0xc,%esp
80100bdb:	68 7d 7e 10 80       	push   $0x80107e7d
80100be0:	e8 7b fa ff ff       	call   80100660 <cprintf>
    return -1;
80100be5:	83 c4 10             	add    $0x10,%esp
80100be8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100bed:	e9 8a fe ff ff       	jmp    80100a7c <exec+0x6c>
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bf2:	8d 80 00 e0 ff ff    	lea    -0x2000(%eax),%eax
80100bf8:	83 ec 08             	sub    $0x8,%esp
  for(argc = 0; argv[argc]; argc++) {
80100bfb:	31 ff                	xor    %edi,%edi
80100bfd:	89 f3                	mov    %esi,%ebx
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100bff:	50                   	push   %eax
80100c00:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
80100c06:	e8 25 6a 00 00       	call   80107630 <clearpteu>
  for(argc = 0; argv[argc]; argc++) {
80100c0b:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c0e:	83 c4 10             	add    $0x10,%esp
80100c11:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
80100c17:	8b 00                	mov    (%eax),%eax
80100c19:	85 c0                	test   %eax,%eax
80100c1b:	74 70                	je     80100c8d <exec+0x27d>
80100c1d:	89 b5 ec fe ff ff    	mov    %esi,-0x114(%ebp)
80100c23:	8b b5 f0 fe ff ff    	mov    -0x110(%ebp),%esi
80100c29:	eb 0a                	jmp    80100c35 <exec+0x225>
80100c2b:	90                   	nop
80100c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(argc >= MAXARG)
80100c30:	83 ff 20             	cmp    $0x20,%edi
80100c33:	74 83                	je     80100bb8 <exec+0x1a8>
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c35:	83 ec 0c             	sub    $0xc,%esp
80100c38:	50                   	push   %eax
80100c39:	e8 d2 3f 00 00       	call   80104c10 <strlen>
80100c3e:	f7 d0                	not    %eax
80100c40:	01 c3                	add    %eax,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c42:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c45:	5a                   	pop    %edx
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100c46:	83 e3 fc             	and    $0xfffffffc,%ebx
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100c49:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c4c:	e8 bf 3f 00 00       	call   80104c10 <strlen>
80100c51:	83 c0 01             	add    $0x1,%eax
80100c54:	50                   	push   %eax
80100c55:	8b 45 0c             	mov    0xc(%ebp),%eax
80100c58:	ff 34 b8             	pushl  (%eax,%edi,4)
80100c5b:	53                   	push   %ebx
80100c5c:	56                   	push   %esi
80100c5d:	e8 2e 6b 00 00       	call   80107790 <copyout>
80100c62:	83 c4 20             	add    $0x20,%esp
80100c65:	85 c0                	test   %eax,%eax
80100c67:	0f 88 4b ff ff ff    	js     80100bb8 <exec+0x1a8>
  for(argc = 0; argv[argc]; argc++) {
80100c6d:	8b 45 0c             	mov    0xc(%ebp),%eax
    ustack[3+argc] = sp;
80100c70:	89 9c bd 64 ff ff ff 	mov    %ebx,-0x9c(%ebp,%edi,4)
  for(argc = 0; argv[argc]; argc++) {
80100c77:	83 c7 01             	add    $0x1,%edi
    ustack[3+argc] = sp;
80100c7a:	8d 95 58 ff ff ff    	lea    -0xa8(%ebp),%edx
  for(argc = 0; argv[argc]; argc++) {
80100c80:	8b 04 b8             	mov    (%eax,%edi,4),%eax
80100c83:	85 c0                	test   %eax,%eax
80100c85:	75 a9                	jne    80100c30 <exec+0x220>
80100c87:	8b b5 ec fe ff ff    	mov    -0x114(%ebp),%esi
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100c8d:	8d 04 bd 04 00 00 00 	lea    0x4(,%edi,4),%eax
80100c94:	89 d9                	mov    %ebx,%ecx
  ustack[3+argc] = 0;
80100c96:	c7 84 bd 64 ff ff ff 	movl   $0x0,-0x9c(%ebp,%edi,4)
80100c9d:	00 00 00 00 
  ustack[0] = 0xffffffff;  // fake return PC
80100ca1:	c7 85 58 ff ff ff ff 	movl   $0xffffffff,-0xa8(%ebp)
80100ca8:	ff ff ff 
  ustack[1] = argc;
80100cab:	89 bd 5c ff ff ff    	mov    %edi,-0xa4(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cb1:	29 c1                	sub    %eax,%ecx
  sp -= (3+argc+1) * 4;
80100cb3:	83 c0 0c             	add    $0xc,%eax
80100cb6:	29 c3                	sub    %eax,%ebx
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cb8:	50                   	push   %eax
80100cb9:	52                   	push   %edx
80100cba:	53                   	push   %ebx
80100cbb:	ff b5 f0 fe ff ff    	pushl  -0x110(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100cc1:	89 8d 60 ff ff ff    	mov    %ecx,-0xa0(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100cc7:	e8 c4 6a 00 00       	call   80107790 <copyout>
80100ccc:	83 c4 10             	add    $0x10,%esp
80100ccf:	85 c0                	test   %eax,%eax
80100cd1:	0f 88 e1 fe ff ff    	js     80100bb8 <exec+0x1a8>
  for(last=s=path; *s; s++)
80100cd7:	8b 45 08             	mov    0x8(%ebp),%eax
80100cda:	0f b6 00             	movzbl (%eax),%eax
80100cdd:	84 c0                	test   %al,%al
80100cdf:	74 17                	je     80100cf8 <exec+0x2e8>
80100ce1:	8b 55 08             	mov    0x8(%ebp),%edx
80100ce4:	89 d1                	mov    %edx,%ecx
80100ce6:	83 c1 01             	add    $0x1,%ecx
80100ce9:	3c 2f                	cmp    $0x2f,%al
80100ceb:	0f b6 01             	movzbl (%ecx),%eax
80100cee:	0f 44 d1             	cmove  %ecx,%edx
80100cf1:	84 c0                	test   %al,%al
80100cf3:	75 f1                	jne    80100ce6 <exec+0x2d6>
80100cf5:	89 55 08             	mov    %edx,0x8(%ebp)
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100cf8:	8b bd f4 fe ff ff    	mov    -0x10c(%ebp),%edi
80100cfe:	50                   	push   %eax
80100cff:	6a 10                	push   $0x10
80100d01:	ff 75 08             	pushl  0x8(%ebp)
80100d04:	89 f8                	mov    %edi,%eax
80100d06:	05 dc 04 00 00       	add    $0x4dc,%eax
80100d0b:	50                   	push   %eax
80100d0c:	e8 bf 3e 00 00       	call   80104bd0 <safestrcpy>
  curproc->pgdir = pgdir;
80100d11:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  oldpgdir = curproc->pgdir;
80100d17:	89 f9                	mov    %edi,%ecx
80100d19:	8b 7f 04             	mov    0x4(%edi),%edi
  curproc->tf->eip = elf.entry;  // main
80100d1c:	8b 41 18             	mov    0x18(%ecx),%eax
  curproc->sz = sz;
80100d1f:	89 31                	mov    %esi,(%ecx)
  curproc->pgdir = pgdir;
80100d21:	89 51 04             	mov    %edx,0x4(%ecx)
  curproc->tf->eip = elf.entry;  // main
80100d24:	8b 95 3c ff ff ff    	mov    -0xc4(%ebp),%edx
80100d2a:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100d2d:	8b 41 18             	mov    0x18(%ecx),%eax
80100d30:	89 58 44             	mov    %ebx,0x44(%eax)
  switchuvm(curproc);
80100d33:	89 0c 24             	mov    %ecx,(%esp)
80100d36:	e8 25 64 00 00       	call   80107160 <switchuvm>
  freevm(oldpgdir);
80100d3b:	89 3c 24             	mov    %edi,(%esp)
80100d3e:	e8 cd 67 00 00       	call   80107510 <freevm>
  return 0;
80100d43:	83 c4 10             	add    $0x10,%esp
80100d46:	31 c0                	xor    %eax,%eax
80100d48:	e9 2f fd ff ff       	jmp    80100a7c <exec+0x6c>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d4d:	be 00 20 00 00       	mov    $0x2000,%esi
80100d52:	e9 3a fe ff ff       	jmp    80100b91 <exec+0x181>
80100d57:	66 90                	xchg   %ax,%ax
80100d59:	66 90                	xchg   %ax,%ax
80100d5b:	66 90                	xchg   %ax,%ax
80100d5d:	66 90                	xchg   %ax,%ax
80100d5f:	90                   	nop

80100d60 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80100d60:	55                   	push   %ebp
80100d61:	89 e5                	mov    %esp,%ebp
80100d63:	83 ec 10             	sub    $0x10,%esp
  initlock(&ftable.lock, "ftable");
80100d66:	68 89 7e 10 80       	push   $0x80107e89
80100d6b:	68 80 61 11 80       	push   $0x80116180
80100d70:	e8 2b 3a 00 00       	call   801047a0 <initlock>
}
80100d75:	83 c4 10             	add    $0x10,%esp
80100d78:	c9                   	leave  
80100d79:	c3                   	ret    
80100d7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80100d80 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80100d80:	55                   	push   %ebp
80100d81:	89 e5                	mov    %esp,%ebp
80100d83:	53                   	push   %ebx
  struct file *f;

  acquire(&ftable.lock);
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100d84:	bb b4 61 11 80       	mov    $0x801161b4,%ebx
{
80100d89:	83 ec 10             	sub    $0x10,%esp
  acquire(&ftable.lock);
80100d8c:	68 80 61 11 80       	push   $0x80116180
80100d91:	e8 4a 3b 00 00       	call   801048e0 <acquire>
80100d96:	83 c4 10             	add    $0x10,%esp
80100d99:	eb 10                	jmp    80100dab <filealloc+0x2b>
80100d9b:	90                   	nop
80100d9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80100da0:	83 c3 18             	add    $0x18,%ebx
80100da3:	81 fb 14 6b 11 80    	cmp    $0x80116b14,%ebx
80100da9:	73 25                	jae    80100dd0 <filealloc+0x50>
    if(f->ref == 0){
80100dab:	8b 43 04             	mov    0x4(%ebx),%eax
80100dae:	85 c0                	test   %eax,%eax
80100db0:	75 ee                	jne    80100da0 <filealloc+0x20>
      f->ref = 1;
      release(&ftable.lock);
80100db2:	83 ec 0c             	sub    $0xc,%esp
      f->ref = 1;
80100db5:	c7 43 04 01 00 00 00 	movl   $0x1,0x4(%ebx)
      release(&ftable.lock);
80100dbc:	68 80 61 11 80       	push   $0x80116180
80100dc1:	e8 da 3b 00 00       	call   801049a0 <release>
      return f;
    }
  }
  release(&ftable.lock);
  return 0;
}
80100dc6:	89 d8                	mov    %ebx,%eax
      return f;
80100dc8:	83 c4 10             	add    $0x10,%esp
}
80100dcb:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100dce:	c9                   	leave  
80100dcf:	c3                   	ret    
  release(&ftable.lock);
80100dd0:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80100dd3:	31 db                	xor    %ebx,%ebx
  release(&ftable.lock);
80100dd5:	68 80 61 11 80       	push   $0x80116180
80100dda:	e8 c1 3b 00 00       	call   801049a0 <release>
}
80100ddf:	89 d8                	mov    %ebx,%eax
  return 0;
80100de1:	83 c4 10             	add    $0x10,%esp
}
80100de4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100de7:	c9                   	leave  
80100de8:	c3                   	ret    
80100de9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80100df0 <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
80100df0:	55                   	push   %ebp
80100df1:	89 e5                	mov    %esp,%ebp
80100df3:	53                   	push   %ebx
80100df4:	83 ec 10             	sub    $0x10,%esp
80100df7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ftable.lock);
80100dfa:	68 80 61 11 80       	push   $0x80116180
80100dff:	e8 dc 3a 00 00       	call   801048e0 <acquire>
  if(f->ref < 1)
80100e04:	8b 43 04             	mov    0x4(%ebx),%eax
80100e07:	83 c4 10             	add    $0x10,%esp
80100e0a:	85 c0                	test   %eax,%eax
80100e0c:	7e 1a                	jle    80100e28 <filedup+0x38>
    panic("filedup");
  f->ref++;
80100e0e:	83 c0 01             	add    $0x1,%eax
  release(&ftable.lock);
80100e11:	83 ec 0c             	sub    $0xc,%esp
  f->ref++;
80100e14:	89 43 04             	mov    %eax,0x4(%ebx)
  release(&ftable.lock);
80100e17:	68 80 61 11 80       	push   $0x80116180
80100e1c:	e8 7f 3b 00 00       	call   801049a0 <release>
  return f;
}
80100e21:	89 d8                	mov    %ebx,%eax
80100e23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100e26:	c9                   	leave  
80100e27:	c3                   	ret    
    panic("filedup");
80100e28:	83 ec 0c             	sub    $0xc,%esp
80100e2b:	68 90 7e 10 80       	push   $0x80107e90
80100e30:	e8 5b f5 ff ff       	call   80100390 <panic>
80100e35:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80100e39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100e40 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
80100e40:	55                   	push   %ebp
80100e41:	89 e5                	mov    %esp,%ebp
80100e43:	57                   	push   %edi
80100e44:	56                   	push   %esi
80100e45:	53                   	push   %ebx
80100e46:	83 ec 28             	sub    $0x28,%esp
80100e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct file ff;

  acquire(&ftable.lock);
80100e4c:	68 80 61 11 80       	push   $0x80116180
80100e51:	e8 8a 3a 00 00       	call   801048e0 <acquire>
  if(f->ref < 1)
80100e56:	8b 43 04             	mov    0x4(%ebx),%eax
80100e59:	83 c4 10             	add    $0x10,%esp
80100e5c:	85 c0                	test   %eax,%eax
80100e5e:	0f 8e 9b 00 00 00    	jle    80100eff <fileclose+0xbf>
    panic("fileclose");
  if(--f->ref > 0){
80100e64:	83 e8 01             	sub    $0x1,%eax
80100e67:	85 c0                	test   %eax,%eax
80100e69:	89 43 04             	mov    %eax,0x4(%ebx)
80100e6c:	74 1a                	je     80100e88 <fileclose+0x48>
    release(&ftable.lock);
80100e6e:	c7 45 08 80 61 11 80 	movl   $0x80116180,0x8(%ebp)
  else if(ff.type == FD_INODE){
    begin_op();
    iput(ff.ip);
    end_op();
  }
}
80100e75:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100e78:	5b                   	pop    %ebx
80100e79:	5e                   	pop    %esi
80100e7a:	5f                   	pop    %edi
80100e7b:	5d                   	pop    %ebp
    release(&ftable.lock);
80100e7c:	e9 1f 3b 00 00       	jmp    801049a0 <release>
80100e81:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  ff = *f;
80100e88:	0f b6 43 09          	movzbl 0x9(%ebx),%eax
80100e8c:	8b 3b                	mov    (%ebx),%edi
  release(&ftable.lock);
80100e8e:	83 ec 0c             	sub    $0xc,%esp
  ff = *f;
80100e91:	8b 73 0c             	mov    0xc(%ebx),%esi
  f->type = FD_NONE;
80100e94:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  ff = *f;
80100e9a:	88 45 e7             	mov    %al,-0x19(%ebp)
80100e9d:	8b 43 10             	mov    0x10(%ebx),%eax
  release(&ftable.lock);
80100ea0:	68 80 61 11 80       	push   $0x80116180
  ff = *f;
80100ea5:	89 45 e0             	mov    %eax,-0x20(%ebp)
  release(&ftable.lock);
80100ea8:	e8 f3 3a 00 00       	call   801049a0 <release>
  if(ff.type == FD_PIPE)
80100ead:	83 c4 10             	add    $0x10,%esp
80100eb0:	83 ff 01             	cmp    $0x1,%edi
80100eb3:	74 13                	je     80100ec8 <fileclose+0x88>
  else if(ff.type == FD_INODE){
80100eb5:	83 ff 02             	cmp    $0x2,%edi
80100eb8:	74 26                	je     80100ee0 <fileclose+0xa0>
}
80100eba:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ebd:	5b                   	pop    %ebx
80100ebe:	5e                   	pop    %esi
80100ebf:	5f                   	pop    %edi
80100ec0:	5d                   	pop    %ebp
80100ec1:	c3                   	ret    
80100ec2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pipeclose(ff.pipe, ff.writable);
80100ec8:	0f be 5d e7          	movsbl -0x19(%ebp),%ebx
80100ecc:	83 ec 08             	sub    $0x8,%esp
80100ecf:	53                   	push   %ebx
80100ed0:	56                   	push   %esi
80100ed1:	e8 9a 24 00 00       	call   80103370 <pipeclose>
80100ed6:	83 c4 10             	add    $0x10,%esp
80100ed9:	eb df                	jmp    80100eba <fileclose+0x7a>
80100edb:	90                   	nop
80100edc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    begin_op();
80100ee0:	e8 db 1c 00 00       	call   80102bc0 <begin_op>
    iput(ff.ip);
80100ee5:	83 ec 0c             	sub    $0xc,%esp
80100ee8:	ff 75 e0             	pushl  -0x20(%ebp)
80100eeb:	e8 d0 08 00 00       	call   801017c0 <iput>
    end_op();
80100ef0:	83 c4 10             	add    $0x10,%esp
}
80100ef3:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100ef6:	5b                   	pop    %ebx
80100ef7:	5e                   	pop    %esi
80100ef8:	5f                   	pop    %edi
80100ef9:	5d                   	pop    %ebp
    end_op();
80100efa:	e9 31 1d 00 00       	jmp    80102c30 <end_op>
    panic("fileclose");
80100eff:	83 ec 0c             	sub    $0xc,%esp
80100f02:	68 98 7e 10 80       	push   $0x80107e98
80100f07:	e8 84 f4 ff ff       	call   80100390 <panic>
80100f0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100f10 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
80100f10:	55                   	push   %ebp
80100f11:	89 e5                	mov    %esp,%ebp
80100f13:	53                   	push   %ebx
80100f14:	83 ec 04             	sub    $0x4,%esp
80100f17:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(f->type == FD_INODE){
80100f1a:	83 3b 02             	cmpl   $0x2,(%ebx)
80100f1d:	75 31                	jne    80100f50 <filestat+0x40>
    ilock(f->ip);
80100f1f:	83 ec 0c             	sub    $0xc,%esp
80100f22:	ff 73 10             	pushl  0x10(%ebx)
80100f25:	e8 66 07 00 00       	call   80101690 <ilock>
    stati(f->ip, st);
80100f2a:	58                   	pop    %eax
80100f2b:	5a                   	pop    %edx
80100f2c:	ff 75 0c             	pushl  0xc(%ebp)
80100f2f:	ff 73 10             	pushl  0x10(%ebx)
80100f32:	e8 09 0a 00 00       	call   80101940 <stati>
    iunlock(f->ip);
80100f37:	59                   	pop    %ecx
80100f38:	ff 73 10             	pushl  0x10(%ebx)
80100f3b:	e8 30 08 00 00       	call   80101770 <iunlock>
    return 0;
80100f40:	83 c4 10             	add    $0x10,%esp
80100f43:	31 c0                	xor    %eax,%eax
  }
  return -1;
}
80100f45:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80100f48:	c9                   	leave  
80100f49:	c3                   	ret    
80100f4a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return -1;
80100f50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100f55:	eb ee                	jmp    80100f45 <filestat+0x35>
80100f57:	89 f6                	mov    %esi,%esi
80100f59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80100f60 <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
80100f60:	55                   	push   %ebp
80100f61:	89 e5                	mov    %esp,%ebp
80100f63:	57                   	push   %edi
80100f64:	56                   	push   %esi
80100f65:	53                   	push   %ebx
80100f66:	83 ec 0c             	sub    $0xc,%esp
80100f69:	8b 5d 08             	mov    0x8(%ebp),%ebx
80100f6c:	8b 75 0c             	mov    0xc(%ebp),%esi
80100f6f:	8b 7d 10             	mov    0x10(%ebp),%edi
  int r;

  if(f->readable == 0)
80100f72:	80 7b 08 00          	cmpb   $0x0,0x8(%ebx)
80100f76:	74 60                	je     80100fd8 <fileread+0x78>
    return -1;
  if(f->type == FD_PIPE)
80100f78:	8b 03                	mov    (%ebx),%eax
80100f7a:	83 f8 01             	cmp    $0x1,%eax
80100f7d:	74 41                	je     80100fc0 <fileread+0x60>
    return piperead(f->pipe, addr, n);
  if(f->type == FD_INODE){
80100f7f:	83 f8 02             	cmp    $0x2,%eax
80100f82:	75 5b                	jne    80100fdf <fileread+0x7f>
    ilock(f->ip);
80100f84:	83 ec 0c             	sub    $0xc,%esp
80100f87:	ff 73 10             	pushl  0x10(%ebx)
80100f8a:	e8 01 07 00 00       	call   80101690 <ilock>
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80100f8f:	57                   	push   %edi
80100f90:	ff 73 14             	pushl  0x14(%ebx)
80100f93:	56                   	push   %esi
80100f94:	ff 73 10             	pushl  0x10(%ebx)
80100f97:	e8 d4 09 00 00       	call   80101970 <readi>
80100f9c:	83 c4 20             	add    $0x20,%esp
80100f9f:	85 c0                	test   %eax,%eax
80100fa1:	89 c6                	mov    %eax,%esi
80100fa3:	7e 03                	jle    80100fa8 <fileread+0x48>
      f->off += r;
80100fa5:	01 43 14             	add    %eax,0x14(%ebx)
    iunlock(f->ip);
80100fa8:	83 ec 0c             	sub    $0xc,%esp
80100fab:	ff 73 10             	pushl  0x10(%ebx)
80100fae:	e8 bd 07 00 00       	call   80101770 <iunlock>
    return r;
80100fb3:	83 c4 10             	add    $0x10,%esp
  }
  panic("fileread");
}
80100fb6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fb9:	89 f0                	mov    %esi,%eax
80100fbb:	5b                   	pop    %ebx
80100fbc:	5e                   	pop    %esi
80100fbd:	5f                   	pop    %edi
80100fbe:	5d                   	pop    %ebp
80100fbf:	c3                   	ret    
    return piperead(f->pipe, addr, n);
80100fc0:	8b 43 0c             	mov    0xc(%ebx),%eax
80100fc3:	89 45 08             	mov    %eax,0x8(%ebp)
}
80100fc6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80100fc9:	5b                   	pop    %ebx
80100fca:	5e                   	pop    %esi
80100fcb:	5f                   	pop    %edi
80100fcc:	5d                   	pop    %ebp
    return piperead(f->pipe, addr, n);
80100fcd:	e9 4e 25 00 00       	jmp    80103520 <piperead>
80100fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
80100fd8:	be ff ff ff ff       	mov    $0xffffffff,%esi
80100fdd:	eb d7                	jmp    80100fb6 <fileread+0x56>
  panic("fileread");
80100fdf:	83 ec 0c             	sub    $0xc,%esp
80100fe2:	68 a2 7e 10 80       	push   $0x80107ea2
80100fe7:	e8 a4 f3 ff ff       	call   80100390 <panic>
80100fec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80100ff0 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
80100ff0:	55                   	push   %ebp
80100ff1:	89 e5                	mov    %esp,%ebp
80100ff3:	57                   	push   %edi
80100ff4:	56                   	push   %esi
80100ff5:	53                   	push   %ebx
80100ff6:	83 ec 1c             	sub    $0x1c,%esp
80100ff9:	8b 75 08             	mov    0x8(%ebp),%esi
80100ffc:	8b 45 0c             	mov    0xc(%ebp),%eax
  int r;

  if(f->writable == 0)
80100fff:	80 7e 09 00          	cmpb   $0x0,0x9(%esi)
{
80101003:	89 45 dc             	mov    %eax,-0x24(%ebp)
80101006:	8b 45 10             	mov    0x10(%ebp),%eax
80101009:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(f->writable == 0)
8010100c:	0f 84 aa 00 00 00    	je     801010bc <filewrite+0xcc>
    return -1;
  if(f->type == FD_PIPE)
80101012:	8b 06                	mov    (%esi),%eax
80101014:	83 f8 01             	cmp    $0x1,%eax
80101017:	0f 84 c3 00 00 00    	je     801010e0 <filewrite+0xf0>
    return pipewrite(f->pipe, addr, n);
  if(f->type == FD_INODE){
8010101d:	83 f8 02             	cmp    $0x2,%eax
80101020:	0f 85 d9 00 00 00    	jne    801010ff <filewrite+0x10f>
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
    int i = 0;
    while(i < n){
80101026:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    int i = 0;
80101029:	31 ff                	xor    %edi,%edi
    while(i < n){
8010102b:	85 c0                	test   %eax,%eax
8010102d:	7f 34                	jg     80101063 <filewrite+0x73>
8010102f:	e9 9c 00 00 00       	jmp    801010d0 <filewrite+0xe0>
80101034:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        n1 = max;

      begin_op();
      ilock(f->ip);
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
        f->off += r;
80101038:	01 46 14             	add    %eax,0x14(%esi)
      iunlock(f->ip);
8010103b:	83 ec 0c             	sub    $0xc,%esp
8010103e:	ff 76 10             	pushl  0x10(%esi)
        f->off += r;
80101041:	89 45 e0             	mov    %eax,-0x20(%ebp)
      iunlock(f->ip);
80101044:	e8 27 07 00 00       	call   80101770 <iunlock>
      end_op();
80101049:	e8 e2 1b 00 00       	call   80102c30 <end_op>
8010104e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101051:	83 c4 10             	add    $0x10,%esp

      if(r < 0)
        break;
      if(r != n1)
80101054:	39 c3                	cmp    %eax,%ebx
80101056:	0f 85 96 00 00 00    	jne    801010f2 <filewrite+0x102>
        panic("short filewrite");
      i += r;
8010105c:	01 df                	add    %ebx,%edi
    while(i < n){
8010105e:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101061:	7e 6d                	jle    801010d0 <filewrite+0xe0>
      int n1 = n - i;
80101063:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
80101066:	b8 00 06 00 00       	mov    $0x600,%eax
8010106b:	29 fb                	sub    %edi,%ebx
8010106d:	81 fb 00 06 00 00    	cmp    $0x600,%ebx
80101073:	0f 4f d8             	cmovg  %eax,%ebx
      begin_op();
80101076:	e8 45 1b 00 00       	call   80102bc0 <begin_op>
      ilock(f->ip);
8010107b:	83 ec 0c             	sub    $0xc,%esp
8010107e:	ff 76 10             	pushl  0x10(%esi)
80101081:	e8 0a 06 00 00       	call   80101690 <ilock>
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101086:	8b 45 dc             	mov    -0x24(%ebp),%eax
80101089:	53                   	push   %ebx
8010108a:	ff 76 14             	pushl  0x14(%esi)
8010108d:	01 f8                	add    %edi,%eax
8010108f:	50                   	push   %eax
80101090:	ff 76 10             	pushl  0x10(%esi)
80101093:	e8 d8 09 00 00       	call   80101a70 <writei>
80101098:	83 c4 20             	add    $0x20,%esp
8010109b:	85 c0                	test   %eax,%eax
8010109d:	7f 99                	jg     80101038 <filewrite+0x48>
      iunlock(f->ip);
8010109f:	83 ec 0c             	sub    $0xc,%esp
801010a2:	ff 76 10             	pushl  0x10(%esi)
801010a5:	89 45 e0             	mov    %eax,-0x20(%ebp)
801010a8:	e8 c3 06 00 00       	call   80101770 <iunlock>
      end_op();
801010ad:	e8 7e 1b 00 00       	call   80102c30 <end_op>
      if(r < 0)
801010b2:	8b 45 e0             	mov    -0x20(%ebp),%eax
801010b5:	83 c4 10             	add    $0x10,%esp
801010b8:	85 c0                	test   %eax,%eax
801010ba:	74 98                	je     80101054 <filewrite+0x64>
    }
    return i == n ? n : -1;
  }
  panic("filewrite");
}
801010bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
801010bf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
}
801010c4:	89 f8                	mov    %edi,%eax
801010c6:	5b                   	pop    %ebx
801010c7:	5e                   	pop    %esi
801010c8:	5f                   	pop    %edi
801010c9:	5d                   	pop    %ebp
801010ca:	c3                   	ret    
801010cb:	90                   	nop
801010cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return i == n ? n : -1;
801010d0:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
801010d3:	75 e7                	jne    801010bc <filewrite+0xcc>
}
801010d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010d8:	89 f8                	mov    %edi,%eax
801010da:	5b                   	pop    %ebx
801010db:	5e                   	pop    %esi
801010dc:	5f                   	pop    %edi
801010dd:	5d                   	pop    %ebp
801010de:	c3                   	ret    
801010df:	90                   	nop
    return pipewrite(f->pipe, addr, n);
801010e0:	8b 46 0c             	mov    0xc(%esi),%eax
801010e3:	89 45 08             	mov    %eax,0x8(%ebp)
}
801010e6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801010e9:	5b                   	pop    %ebx
801010ea:	5e                   	pop    %esi
801010eb:	5f                   	pop    %edi
801010ec:	5d                   	pop    %ebp
    return pipewrite(f->pipe, addr, n);
801010ed:	e9 1e 23 00 00       	jmp    80103410 <pipewrite>
        panic("short filewrite");
801010f2:	83 ec 0c             	sub    $0xc,%esp
801010f5:	68 ab 7e 10 80       	push   $0x80107eab
801010fa:	e8 91 f2 ff ff       	call   80100390 <panic>
  panic("filewrite");
801010ff:	83 ec 0c             	sub    $0xc,%esp
80101102:	68 b1 7e 10 80       	push   $0x80107eb1
80101107:	e8 84 f2 ff ff       	call   80100390 <panic>
8010110c:	66 90                	xchg   %ax,%ax
8010110e:	66 90                	xchg   %ax,%ax

80101110 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
80101110:	55                   	push   %ebp
80101111:	89 e5                	mov    %esp,%ebp
80101113:	57                   	push   %edi
80101114:	56                   	push   %esi
80101115:	53                   	push   %ebx
80101116:	83 ec 1c             	sub    $0x1c,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
  for(b = 0; b < sb.size; b += BPB){
80101119:	8b 0d 80 6b 11 80    	mov    0x80116b80,%ecx
{
8010111f:	89 45 d8             	mov    %eax,-0x28(%ebp)
  for(b = 0; b < sb.size; b += BPB){
80101122:	85 c9                	test   %ecx,%ecx
80101124:	0f 84 87 00 00 00    	je     801011b1 <balloc+0xa1>
8010112a:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
    bp = bread(dev, BBLOCK(b, sb));
80101131:	8b 75 dc             	mov    -0x24(%ebp),%esi
80101134:	83 ec 08             	sub    $0x8,%esp
80101137:	89 f0                	mov    %esi,%eax
80101139:	c1 f8 0c             	sar    $0xc,%eax
8010113c:	03 05 98 6b 11 80    	add    0x80116b98,%eax
80101142:	50                   	push   %eax
80101143:	ff 75 d8             	pushl  -0x28(%ebp)
80101146:	e8 85 ef ff ff       	call   801000d0 <bread>
8010114b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010114e:	a1 80 6b 11 80       	mov    0x80116b80,%eax
80101153:	83 c4 10             	add    $0x10,%esp
80101156:	89 45 e0             	mov    %eax,-0x20(%ebp)
80101159:	31 c0                	xor    %eax,%eax
8010115b:	eb 2f                	jmp    8010118c <balloc+0x7c>
8010115d:	8d 76 00             	lea    0x0(%esi),%esi
      m = 1 << (bi % 8);
80101160:	89 c1                	mov    %eax,%ecx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
80101162:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      m = 1 << (bi % 8);
80101165:	bb 01 00 00 00       	mov    $0x1,%ebx
8010116a:	83 e1 07             	and    $0x7,%ecx
8010116d:	d3 e3                	shl    %cl,%ebx
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010116f:	89 c1                	mov    %eax,%ecx
80101171:	c1 f9 03             	sar    $0x3,%ecx
80101174:	0f b6 7c 0a 5c       	movzbl 0x5c(%edx,%ecx,1),%edi
80101179:	85 df                	test   %ebx,%edi
8010117b:	89 fa                	mov    %edi,%edx
8010117d:	74 41                	je     801011c0 <balloc+0xb0>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
8010117f:	83 c0 01             	add    $0x1,%eax
80101182:	83 c6 01             	add    $0x1,%esi
80101185:	3d 00 10 00 00       	cmp    $0x1000,%eax
8010118a:	74 05                	je     80101191 <balloc+0x81>
8010118c:	39 75 e0             	cmp    %esi,-0x20(%ebp)
8010118f:	77 cf                	ja     80101160 <balloc+0x50>
        brelse(bp);
        bzero(dev, b + bi);
        return b + bi;
      }
    }
    brelse(bp);
80101191:	83 ec 0c             	sub    $0xc,%esp
80101194:	ff 75 e4             	pushl  -0x1c(%ebp)
80101197:	e8 44 f0 ff ff       	call   801001e0 <brelse>
  for(b = 0; b < sb.size; b += BPB){
8010119c:	81 45 dc 00 10 00 00 	addl   $0x1000,-0x24(%ebp)
801011a3:	83 c4 10             	add    $0x10,%esp
801011a6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801011a9:	39 05 80 6b 11 80    	cmp    %eax,0x80116b80
801011af:	77 80                	ja     80101131 <balloc+0x21>
  }
  panic("balloc: out of blocks");
801011b1:	83 ec 0c             	sub    $0xc,%esp
801011b4:	68 bb 7e 10 80       	push   $0x80107ebb
801011b9:	e8 d2 f1 ff ff       	call   80100390 <panic>
801011be:	66 90                	xchg   %ax,%ax
        bp->data[bi/8] |= m;  // Mark block in use.
801011c0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
        log_write(bp);
801011c3:	83 ec 0c             	sub    $0xc,%esp
        bp->data[bi/8] |= m;  // Mark block in use.
801011c6:	09 da                	or     %ebx,%edx
801011c8:	88 54 0f 5c          	mov    %dl,0x5c(%edi,%ecx,1)
        log_write(bp);
801011cc:	57                   	push   %edi
801011cd:	e8 be 1b 00 00       	call   80102d90 <log_write>
        brelse(bp);
801011d2:	89 3c 24             	mov    %edi,(%esp)
801011d5:	e8 06 f0 ff ff       	call   801001e0 <brelse>
  bp = bread(dev, bno);
801011da:	58                   	pop    %eax
801011db:	5a                   	pop    %edx
801011dc:	56                   	push   %esi
801011dd:	ff 75 d8             	pushl  -0x28(%ebp)
801011e0:	e8 eb ee ff ff       	call   801000d0 <bread>
801011e5:	89 c3                	mov    %eax,%ebx
  memset(bp->data, 0, BSIZE);
801011e7:	8d 40 5c             	lea    0x5c(%eax),%eax
801011ea:	83 c4 0c             	add    $0xc,%esp
801011ed:	68 00 02 00 00       	push   $0x200
801011f2:	6a 00                	push   $0x0
801011f4:	50                   	push   %eax
801011f5:	e8 f6 37 00 00       	call   801049f0 <memset>
  log_write(bp);
801011fa:	89 1c 24             	mov    %ebx,(%esp)
801011fd:	e8 8e 1b 00 00       	call   80102d90 <log_write>
  brelse(bp);
80101202:	89 1c 24             	mov    %ebx,(%esp)
80101205:	e8 d6 ef ff ff       	call   801001e0 <brelse>
}
8010120a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010120d:	89 f0                	mov    %esi,%eax
8010120f:	5b                   	pop    %ebx
80101210:	5e                   	pop    %esi
80101211:	5f                   	pop    %edi
80101212:	5d                   	pop    %ebp
80101213:	c3                   	ret    
80101214:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010121a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101220 <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
80101220:	55                   	push   %ebp
80101221:	89 e5                	mov    %esp,%ebp
80101223:	57                   	push   %edi
80101224:	56                   	push   %esi
80101225:	53                   	push   %ebx
80101226:	89 c7                	mov    %eax,%edi
  struct inode *ip, *empty;

  acquire(&icache.lock);

  // Is the inode already cached?
  empty = 0;
80101228:	31 f6                	xor    %esi,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010122a:	bb d4 6b 11 80       	mov    $0x80116bd4,%ebx
{
8010122f:	83 ec 28             	sub    $0x28,%esp
80101232:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  acquire(&icache.lock);
80101235:	68 a0 6b 11 80       	push   $0x80116ba0
8010123a:	e8 a1 36 00 00       	call   801048e0 <acquire>
8010123f:	83 c4 10             	add    $0x10,%esp
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101242:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80101245:	eb 17                	jmp    8010125e <iget+0x3e>
80101247:	89 f6                	mov    %esi,%esi
80101249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101250:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101256:	81 fb f4 87 11 80    	cmp    $0x801187f4,%ebx
8010125c:	73 22                	jae    80101280 <iget+0x60>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
8010125e:	8b 4b 08             	mov    0x8(%ebx),%ecx
80101261:	85 c9                	test   %ecx,%ecx
80101263:	7e 04                	jle    80101269 <iget+0x49>
80101265:	39 3b                	cmp    %edi,(%ebx)
80101267:	74 4f                	je     801012b8 <iget+0x98>
      ip->ref++;
      release(&icache.lock);
      return ip;
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101269:	85 f6                	test   %esi,%esi
8010126b:	75 e3                	jne    80101250 <iget+0x30>
8010126d:	85 c9                	test   %ecx,%ecx
8010126f:	0f 44 f3             	cmove  %ebx,%esi
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
80101272:	81 c3 90 00 00 00    	add    $0x90,%ebx
80101278:	81 fb f4 87 11 80    	cmp    $0x801187f4,%ebx
8010127e:	72 de                	jb     8010125e <iget+0x3e>
      empty = ip;
  }

  // Recycle an inode cache entry.
  if(empty == 0)
80101280:	85 f6                	test   %esi,%esi
80101282:	74 5b                	je     801012df <iget+0xbf>
  ip = empty;
  ip->dev = dev;
  ip->inum = inum;
  ip->ref = 1;
  ip->valid = 0;
  release(&icache.lock);
80101284:	83 ec 0c             	sub    $0xc,%esp
  ip->dev = dev;
80101287:	89 3e                	mov    %edi,(%esi)
  ip->inum = inum;
80101289:	89 56 04             	mov    %edx,0x4(%esi)
  ip->ref = 1;
8010128c:	c7 46 08 01 00 00 00 	movl   $0x1,0x8(%esi)
  ip->valid = 0;
80101293:	c7 46 4c 00 00 00 00 	movl   $0x0,0x4c(%esi)
  release(&icache.lock);
8010129a:	68 a0 6b 11 80       	push   $0x80116ba0
8010129f:	e8 fc 36 00 00       	call   801049a0 <release>

  return ip;
801012a4:	83 c4 10             	add    $0x10,%esp
}
801012a7:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012aa:	89 f0                	mov    %esi,%eax
801012ac:	5b                   	pop    %ebx
801012ad:	5e                   	pop    %esi
801012ae:	5f                   	pop    %edi
801012af:	5d                   	pop    %ebp
801012b0:	c3                   	ret    
801012b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
801012b8:	39 53 04             	cmp    %edx,0x4(%ebx)
801012bb:	75 ac                	jne    80101269 <iget+0x49>
      release(&icache.lock);
801012bd:	83 ec 0c             	sub    $0xc,%esp
      ip->ref++;
801012c0:	83 c1 01             	add    $0x1,%ecx
      return ip;
801012c3:	89 de                	mov    %ebx,%esi
      release(&icache.lock);
801012c5:	68 a0 6b 11 80       	push   $0x80116ba0
      ip->ref++;
801012ca:	89 4b 08             	mov    %ecx,0x8(%ebx)
      release(&icache.lock);
801012cd:	e8 ce 36 00 00       	call   801049a0 <release>
      return ip;
801012d2:	83 c4 10             	add    $0x10,%esp
}
801012d5:	8d 65 f4             	lea    -0xc(%ebp),%esp
801012d8:	89 f0                	mov    %esi,%eax
801012da:	5b                   	pop    %ebx
801012db:	5e                   	pop    %esi
801012dc:	5f                   	pop    %edi
801012dd:	5d                   	pop    %ebp
801012de:	c3                   	ret    
    panic("iget: no inodes");
801012df:	83 ec 0c             	sub    $0xc,%esp
801012e2:	68 d1 7e 10 80       	push   $0x80107ed1
801012e7:	e8 a4 f0 ff ff       	call   80100390 <panic>
801012ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801012f0 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
801012f0:	55                   	push   %ebp
801012f1:	89 e5                	mov    %esp,%ebp
801012f3:	57                   	push   %edi
801012f4:	56                   	push   %esi
801012f5:	53                   	push   %ebx
801012f6:	89 c6                	mov    %eax,%esi
801012f8:	83 ec 1c             	sub    $0x1c,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
801012fb:	83 fa 0b             	cmp    $0xb,%edx
801012fe:	77 18                	ja     80101318 <bmap+0x28>
80101300:	8d 3c 90             	lea    (%eax,%edx,4),%edi
    if((addr = ip->addrs[bn]) == 0)
80101303:	8b 5f 5c             	mov    0x5c(%edi),%ebx
80101306:	85 db                	test   %ebx,%ebx
80101308:	74 76                	je     80101380 <bmap+0x90>
    brelse(bp);
    return addr;
  }

  panic("bmap: out of range");
}
8010130a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010130d:	89 d8                	mov    %ebx,%eax
8010130f:	5b                   	pop    %ebx
80101310:	5e                   	pop    %esi
80101311:	5f                   	pop    %edi
80101312:	5d                   	pop    %ebp
80101313:	c3                   	ret    
80101314:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  bn -= NDIRECT;
80101318:	8d 5a f4             	lea    -0xc(%edx),%ebx
  if(bn < NINDIRECT){
8010131b:	83 fb 7f             	cmp    $0x7f,%ebx
8010131e:	0f 87 90 00 00 00    	ja     801013b4 <bmap+0xc4>
    if((addr = ip->addrs[NDIRECT]) == 0)
80101324:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
8010132a:	8b 00                	mov    (%eax),%eax
8010132c:	85 d2                	test   %edx,%edx
8010132e:	74 70                	je     801013a0 <bmap+0xb0>
    bp = bread(ip->dev, addr);
80101330:	83 ec 08             	sub    $0x8,%esp
80101333:	52                   	push   %edx
80101334:	50                   	push   %eax
80101335:	e8 96 ed ff ff       	call   801000d0 <bread>
    if((addr = a[bn]) == 0){
8010133a:	8d 54 98 5c          	lea    0x5c(%eax,%ebx,4),%edx
8010133e:	83 c4 10             	add    $0x10,%esp
    bp = bread(ip->dev, addr);
80101341:	89 c7                	mov    %eax,%edi
    if((addr = a[bn]) == 0){
80101343:	8b 1a                	mov    (%edx),%ebx
80101345:	85 db                	test   %ebx,%ebx
80101347:	75 1d                	jne    80101366 <bmap+0x76>
      a[bn] = addr = balloc(ip->dev);
80101349:	8b 06                	mov    (%esi),%eax
8010134b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
8010134e:	e8 bd fd ff ff       	call   80101110 <balloc>
80101353:	8b 55 e4             	mov    -0x1c(%ebp),%edx
      log_write(bp);
80101356:	83 ec 0c             	sub    $0xc,%esp
      a[bn] = addr = balloc(ip->dev);
80101359:	89 c3                	mov    %eax,%ebx
8010135b:	89 02                	mov    %eax,(%edx)
      log_write(bp);
8010135d:	57                   	push   %edi
8010135e:	e8 2d 1a 00 00       	call   80102d90 <log_write>
80101363:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101366:	83 ec 0c             	sub    $0xc,%esp
80101369:	57                   	push   %edi
8010136a:	e8 71 ee ff ff       	call   801001e0 <brelse>
8010136f:	83 c4 10             	add    $0x10,%esp
}
80101372:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101375:	89 d8                	mov    %ebx,%eax
80101377:	5b                   	pop    %ebx
80101378:	5e                   	pop    %esi
80101379:	5f                   	pop    %edi
8010137a:	5d                   	pop    %ebp
8010137b:	c3                   	ret    
8010137c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ip->addrs[bn] = addr = balloc(ip->dev);
80101380:	8b 00                	mov    (%eax),%eax
80101382:	e8 89 fd ff ff       	call   80101110 <balloc>
80101387:	89 47 5c             	mov    %eax,0x5c(%edi)
}
8010138a:	8d 65 f4             	lea    -0xc(%ebp),%esp
      ip->addrs[bn] = addr = balloc(ip->dev);
8010138d:	89 c3                	mov    %eax,%ebx
}
8010138f:	89 d8                	mov    %ebx,%eax
80101391:	5b                   	pop    %ebx
80101392:	5e                   	pop    %esi
80101393:	5f                   	pop    %edi
80101394:	5d                   	pop    %ebp
80101395:	c3                   	ret    
80101396:	8d 76 00             	lea    0x0(%esi),%esi
80101399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
801013a0:	e8 6b fd ff ff       	call   80101110 <balloc>
801013a5:	89 c2                	mov    %eax,%edx
801013a7:	89 86 8c 00 00 00    	mov    %eax,0x8c(%esi)
801013ad:	8b 06                	mov    (%esi),%eax
801013af:	e9 7c ff ff ff       	jmp    80101330 <bmap+0x40>
  panic("bmap: out of range");
801013b4:	83 ec 0c             	sub    $0xc,%esp
801013b7:	68 e1 7e 10 80       	push   $0x80107ee1
801013bc:	e8 cf ef ff ff       	call   80100390 <panic>
801013c1:	eb 0d                	jmp    801013d0 <readsb>
801013c3:	90                   	nop
801013c4:	90                   	nop
801013c5:	90                   	nop
801013c6:	90                   	nop
801013c7:	90                   	nop
801013c8:	90                   	nop
801013c9:	90                   	nop
801013ca:	90                   	nop
801013cb:	90                   	nop
801013cc:	90                   	nop
801013cd:	90                   	nop
801013ce:	90                   	nop
801013cf:	90                   	nop

801013d0 <readsb>:
{
801013d0:	55                   	push   %ebp
801013d1:	89 e5                	mov    %esp,%ebp
801013d3:	56                   	push   %esi
801013d4:	53                   	push   %ebx
801013d5:	8b 75 0c             	mov    0xc(%ebp),%esi
  bp = bread(dev, 1);
801013d8:	83 ec 08             	sub    $0x8,%esp
801013db:	6a 01                	push   $0x1
801013dd:	ff 75 08             	pushl  0x8(%ebp)
801013e0:	e8 eb ec ff ff       	call   801000d0 <bread>
801013e5:	89 c3                	mov    %eax,%ebx
  memmove(sb, bp->data, sizeof(*sb));
801013e7:	8d 40 5c             	lea    0x5c(%eax),%eax
801013ea:	83 c4 0c             	add    $0xc,%esp
801013ed:	6a 1c                	push   $0x1c
801013ef:	50                   	push   %eax
801013f0:	56                   	push   %esi
801013f1:	e8 aa 36 00 00       	call   80104aa0 <memmove>
  brelse(bp);
801013f6:	89 5d 08             	mov    %ebx,0x8(%ebp)
801013f9:	83 c4 10             	add    $0x10,%esp
}
801013fc:	8d 65 f8             	lea    -0x8(%ebp),%esp
801013ff:	5b                   	pop    %ebx
80101400:	5e                   	pop    %esi
80101401:	5d                   	pop    %ebp
  brelse(bp);
80101402:	e9 d9 ed ff ff       	jmp    801001e0 <brelse>
80101407:	89 f6                	mov    %esi,%esi
80101409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101410 <bfree>:
{
80101410:	55                   	push   %ebp
80101411:	89 e5                	mov    %esp,%ebp
80101413:	56                   	push   %esi
80101414:	53                   	push   %ebx
80101415:	89 d3                	mov    %edx,%ebx
80101417:	89 c6                	mov    %eax,%esi
  readsb(dev, &sb);
80101419:	83 ec 08             	sub    $0x8,%esp
8010141c:	68 80 6b 11 80       	push   $0x80116b80
80101421:	50                   	push   %eax
80101422:	e8 a9 ff ff ff       	call   801013d0 <readsb>
  bp = bread(dev, BBLOCK(b, sb));
80101427:	58                   	pop    %eax
80101428:	5a                   	pop    %edx
80101429:	89 da                	mov    %ebx,%edx
8010142b:	c1 ea 0c             	shr    $0xc,%edx
8010142e:	03 15 98 6b 11 80    	add    0x80116b98,%edx
80101434:	52                   	push   %edx
80101435:	56                   	push   %esi
80101436:	e8 95 ec ff ff       	call   801000d0 <bread>
  m = 1 << (bi % 8);
8010143b:	89 d9                	mov    %ebx,%ecx
  if((bp->data[bi/8] & m) == 0)
8010143d:	c1 fb 03             	sar    $0x3,%ebx
  m = 1 << (bi % 8);
80101440:	ba 01 00 00 00       	mov    $0x1,%edx
80101445:	83 e1 07             	and    $0x7,%ecx
  if((bp->data[bi/8] & m) == 0)
80101448:	81 e3 ff 01 00 00    	and    $0x1ff,%ebx
8010144e:	83 c4 10             	add    $0x10,%esp
  m = 1 << (bi % 8);
80101451:	d3 e2                	shl    %cl,%edx
  if((bp->data[bi/8] & m) == 0)
80101453:	0f b6 4c 18 5c       	movzbl 0x5c(%eax,%ebx,1),%ecx
80101458:	85 d1                	test   %edx,%ecx
8010145a:	74 25                	je     80101481 <bfree+0x71>
  bp->data[bi/8] &= ~m;
8010145c:	f7 d2                	not    %edx
8010145e:	89 c6                	mov    %eax,%esi
  log_write(bp);
80101460:	83 ec 0c             	sub    $0xc,%esp
  bp->data[bi/8] &= ~m;
80101463:	21 ca                	and    %ecx,%edx
80101465:	88 54 1e 5c          	mov    %dl,0x5c(%esi,%ebx,1)
  log_write(bp);
80101469:	56                   	push   %esi
8010146a:	e8 21 19 00 00       	call   80102d90 <log_write>
  brelse(bp);
8010146f:	89 34 24             	mov    %esi,(%esp)
80101472:	e8 69 ed ff ff       	call   801001e0 <brelse>
}
80101477:	83 c4 10             	add    $0x10,%esp
8010147a:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010147d:	5b                   	pop    %ebx
8010147e:	5e                   	pop    %esi
8010147f:	5d                   	pop    %ebp
80101480:	c3                   	ret    
    panic("freeing free block");
80101481:	83 ec 0c             	sub    $0xc,%esp
80101484:	68 f4 7e 10 80       	push   $0x80107ef4
80101489:	e8 02 ef ff ff       	call   80100390 <panic>
8010148e:	66 90                	xchg   %ax,%ax

80101490 <iinit>:
{
80101490:	55                   	push   %ebp
80101491:	89 e5                	mov    %esp,%ebp
80101493:	53                   	push   %ebx
80101494:	bb e0 6b 11 80       	mov    $0x80116be0,%ebx
80101499:	83 ec 0c             	sub    $0xc,%esp
  initlock(&icache.lock, "icache");
8010149c:	68 07 7f 10 80       	push   $0x80107f07
801014a1:	68 a0 6b 11 80       	push   $0x80116ba0
801014a6:	e8 f5 32 00 00       	call   801047a0 <initlock>
801014ab:	83 c4 10             	add    $0x10,%esp
801014ae:	66 90                	xchg   %ax,%ax
    initsleeplock(&icache.inode[i].lock, "inode");
801014b0:	83 ec 08             	sub    $0x8,%esp
801014b3:	68 0e 7f 10 80       	push   $0x80107f0e
801014b8:	53                   	push   %ebx
801014b9:	81 c3 90 00 00 00    	add    $0x90,%ebx
801014bf:	e8 ac 31 00 00       	call   80104670 <initsleeplock>
  for(i = 0; i < NINODE; i++) {
801014c4:	83 c4 10             	add    $0x10,%esp
801014c7:	81 fb 00 88 11 80    	cmp    $0x80118800,%ebx
801014cd:	75 e1                	jne    801014b0 <iinit+0x20>
  readsb(dev, &sb);
801014cf:	83 ec 08             	sub    $0x8,%esp
801014d2:	68 80 6b 11 80       	push   $0x80116b80
801014d7:	ff 75 08             	pushl  0x8(%ebp)
801014da:	e8 f1 fe ff ff       	call   801013d0 <readsb>
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
801014df:	ff 35 98 6b 11 80    	pushl  0x80116b98
801014e5:	ff 35 94 6b 11 80    	pushl  0x80116b94
801014eb:	ff 35 90 6b 11 80    	pushl  0x80116b90
801014f1:	ff 35 8c 6b 11 80    	pushl  0x80116b8c
801014f7:	ff 35 88 6b 11 80    	pushl  0x80116b88
801014fd:	ff 35 84 6b 11 80    	pushl  0x80116b84
80101503:	ff 35 80 6b 11 80    	pushl  0x80116b80
80101509:	68 74 7f 10 80       	push   $0x80107f74
8010150e:	e8 4d f1 ff ff       	call   80100660 <cprintf>
}
80101513:	83 c4 30             	add    $0x30,%esp
80101516:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101519:	c9                   	leave  
8010151a:	c3                   	ret    
8010151b:	90                   	nop
8010151c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101520 <ialloc>:
{
80101520:	55                   	push   %ebp
80101521:	89 e5                	mov    %esp,%ebp
80101523:	57                   	push   %edi
80101524:	56                   	push   %esi
80101525:	53                   	push   %ebx
80101526:	83 ec 1c             	sub    $0x1c,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101529:	83 3d 88 6b 11 80 01 	cmpl   $0x1,0x80116b88
{
80101530:	8b 45 0c             	mov    0xc(%ebp),%eax
80101533:	8b 75 08             	mov    0x8(%ebp),%esi
80101536:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(inum = 1; inum < sb.ninodes; inum++){
80101539:	0f 86 91 00 00 00    	jbe    801015d0 <ialloc+0xb0>
8010153f:	bb 01 00 00 00       	mov    $0x1,%ebx
80101544:	eb 21                	jmp    80101567 <ialloc+0x47>
80101546:	8d 76 00             	lea    0x0(%esi),%esi
80101549:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    brelse(bp);
80101550:	83 ec 0c             	sub    $0xc,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101553:	83 c3 01             	add    $0x1,%ebx
    brelse(bp);
80101556:	57                   	push   %edi
80101557:	e8 84 ec ff ff       	call   801001e0 <brelse>
  for(inum = 1; inum < sb.ninodes; inum++){
8010155c:	83 c4 10             	add    $0x10,%esp
8010155f:	39 1d 88 6b 11 80    	cmp    %ebx,0x80116b88
80101565:	76 69                	jbe    801015d0 <ialloc+0xb0>
    bp = bread(dev, IBLOCK(inum, sb));
80101567:	89 d8                	mov    %ebx,%eax
80101569:	83 ec 08             	sub    $0x8,%esp
8010156c:	c1 e8 03             	shr    $0x3,%eax
8010156f:	03 05 94 6b 11 80    	add    0x80116b94,%eax
80101575:	50                   	push   %eax
80101576:	56                   	push   %esi
80101577:	e8 54 eb ff ff       	call   801000d0 <bread>
8010157c:	89 c7                	mov    %eax,%edi
    dip = (struct dinode*)bp->data + inum%IPB;
8010157e:	89 d8                	mov    %ebx,%eax
    if(dip->type == 0){  // a free inode
80101580:	83 c4 10             	add    $0x10,%esp
    dip = (struct dinode*)bp->data + inum%IPB;
80101583:	83 e0 07             	and    $0x7,%eax
80101586:	c1 e0 06             	shl    $0x6,%eax
80101589:	8d 4c 07 5c          	lea    0x5c(%edi,%eax,1),%ecx
    if(dip->type == 0){  // a free inode
8010158d:	66 83 39 00          	cmpw   $0x0,(%ecx)
80101591:	75 bd                	jne    80101550 <ialloc+0x30>
      memset(dip, 0, sizeof(*dip));
80101593:	83 ec 04             	sub    $0x4,%esp
80101596:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80101599:	6a 40                	push   $0x40
8010159b:	6a 00                	push   $0x0
8010159d:	51                   	push   %ecx
8010159e:	e8 4d 34 00 00       	call   801049f0 <memset>
      dip->type = type;
801015a3:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
801015a7:	8b 4d e0             	mov    -0x20(%ebp),%ecx
801015aa:	66 89 01             	mov    %ax,(%ecx)
      log_write(bp);   // mark it allocated on the disk
801015ad:	89 3c 24             	mov    %edi,(%esp)
801015b0:	e8 db 17 00 00       	call   80102d90 <log_write>
      brelse(bp);
801015b5:	89 3c 24             	mov    %edi,(%esp)
801015b8:	e8 23 ec ff ff       	call   801001e0 <brelse>
      return iget(dev, inum);
801015bd:	83 c4 10             	add    $0x10,%esp
}
801015c0:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return iget(dev, inum);
801015c3:	89 da                	mov    %ebx,%edx
801015c5:	89 f0                	mov    %esi,%eax
}
801015c7:	5b                   	pop    %ebx
801015c8:	5e                   	pop    %esi
801015c9:	5f                   	pop    %edi
801015ca:	5d                   	pop    %ebp
      return iget(dev, inum);
801015cb:	e9 50 fc ff ff       	jmp    80101220 <iget>
  panic("ialloc: no inodes");
801015d0:	83 ec 0c             	sub    $0xc,%esp
801015d3:	68 14 7f 10 80       	push   $0x80107f14
801015d8:	e8 b3 ed ff ff       	call   80100390 <panic>
801015dd:	8d 76 00             	lea    0x0(%esi),%esi

801015e0 <iupdate>:
{
801015e0:	55                   	push   %ebp
801015e1:	89 e5                	mov    %esp,%ebp
801015e3:	56                   	push   %esi
801015e4:	53                   	push   %ebx
801015e5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015e8:	83 ec 08             	sub    $0x8,%esp
801015eb:	8b 43 04             	mov    0x4(%ebx),%eax
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801015ee:	83 c3 5c             	add    $0x5c,%ebx
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801015f1:	c1 e8 03             	shr    $0x3,%eax
801015f4:	03 05 94 6b 11 80    	add    0x80116b94,%eax
801015fa:	50                   	push   %eax
801015fb:	ff 73 a4             	pushl  -0x5c(%ebx)
801015fe:	e8 cd ea ff ff       	call   801000d0 <bread>
80101603:	89 c6                	mov    %eax,%esi
  dip = (struct dinode*)bp->data + ip->inum%IPB;
80101605:	8b 43 a8             	mov    -0x58(%ebx),%eax
  dip->type = ip->type;
80101608:	0f b7 53 f4          	movzwl -0xc(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010160c:	83 c4 0c             	add    $0xc,%esp
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010160f:	83 e0 07             	and    $0x7,%eax
80101612:	c1 e0 06             	shl    $0x6,%eax
80101615:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
  dip->type = ip->type;
80101619:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010161c:	0f b7 53 f6          	movzwl -0xa(%ebx),%edx
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
80101620:	83 c0 0c             	add    $0xc,%eax
  dip->major = ip->major;
80101623:	66 89 50 f6          	mov    %dx,-0xa(%eax)
  dip->minor = ip->minor;
80101627:	0f b7 53 f8          	movzwl -0x8(%ebx),%edx
8010162b:	66 89 50 f8          	mov    %dx,-0x8(%eax)
  dip->nlink = ip->nlink;
8010162f:	0f b7 53 fa          	movzwl -0x6(%ebx),%edx
80101633:	66 89 50 fa          	mov    %dx,-0x6(%eax)
  dip->size = ip->size;
80101637:	8b 53 fc             	mov    -0x4(%ebx),%edx
8010163a:	89 50 fc             	mov    %edx,-0x4(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
8010163d:	6a 34                	push   $0x34
8010163f:	53                   	push   %ebx
80101640:	50                   	push   %eax
80101641:	e8 5a 34 00 00       	call   80104aa0 <memmove>
  log_write(bp);
80101646:	89 34 24             	mov    %esi,(%esp)
80101649:	e8 42 17 00 00       	call   80102d90 <log_write>
  brelse(bp);
8010164e:	89 75 08             	mov    %esi,0x8(%ebp)
80101651:	83 c4 10             	add    $0x10,%esp
}
80101654:	8d 65 f8             	lea    -0x8(%ebp),%esp
80101657:	5b                   	pop    %ebx
80101658:	5e                   	pop    %esi
80101659:	5d                   	pop    %ebp
  brelse(bp);
8010165a:	e9 81 eb ff ff       	jmp    801001e0 <brelse>
8010165f:	90                   	nop

80101660 <idup>:
{
80101660:	55                   	push   %ebp
80101661:	89 e5                	mov    %esp,%ebp
80101663:	53                   	push   %ebx
80101664:	83 ec 10             	sub    $0x10,%esp
80101667:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&icache.lock);
8010166a:	68 a0 6b 11 80       	push   $0x80116ba0
8010166f:	e8 6c 32 00 00       	call   801048e0 <acquire>
  ip->ref++;
80101674:	83 43 08 01          	addl   $0x1,0x8(%ebx)
  release(&icache.lock);
80101678:	c7 04 24 a0 6b 11 80 	movl   $0x80116ba0,(%esp)
8010167f:	e8 1c 33 00 00       	call   801049a0 <release>
}
80101684:	89 d8                	mov    %ebx,%eax
80101686:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101689:	c9                   	leave  
8010168a:	c3                   	ret    
8010168b:	90                   	nop
8010168c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101690 <ilock>:
{
80101690:	55                   	push   %ebp
80101691:	89 e5                	mov    %esp,%ebp
80101693:	56                   	push   %esi
80101694:	53                   	push   %ebx
80101695:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || ip->ref < 1)
80101698:	85 db                	test   %ebx,%ebx
8010169a:	0f 84 b7 00 00 00    	je     80101757 <ilock+0xc7>
801016a0:	8b 53 08             	mov    0x8(%ebx),%edx
801016a3:	85 d2                	test   %edx,%edx
801016a5:	0f 8e ac 00 00 00    	jle    80101757 <ilock+0xc7>
  acquiresleep(&ip->lock);
801016ab:	8d 43 0c             	lea    0xc(%ebx),%eax
801016ae:	83 ec 0c             	sub    $0xc,%esp
801016b1:	50                   	push   %eax
801016b2:	e8 f9 2f 00 00       	call   801046b0 <acquiresleep>
  if(ip->valid == 0){
801016b7:	8b 43 4c             	mov    0x4c(%ebx),%eax
801016ba:	83 c4 10             	add    $0x10,%esp
801016bd:	85 c0                	test   %eax,%eax
801016bf:	74 0f                	je     801016d0 <ilock+0x40>
}
801016c1:	8d 65 f8             	lea    -0x8(%ebp),%esp
801016c4:	5b                   	pop    %ebx
801016c5:	5e                   	pop    %esi
801016c6:	5d                   	pop    %ebp
801016c7:	c3                   	ret    
801016c8:	90                   	nop
801016c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
801016d0:	8b 43 04             	mov    0x4(%ebx),%eax
801016d3:	83 ec 08             	sub    $0x8,%esp
801016d6:	c1 e8 03             	shr    $0x3,%eax
801016d9:	03 05 94 6b 11 80    	add    0x80116b94,%eax
801016df:	50                   	push   %eax
801016e0:	ff 33                	pushl  (%ebx)
801016e2:	e8 e9 e9 ff ff       	call   801000d0 <bread>
801016e7:	89 c6                	mov    %eax,%esi
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016e9:	8b 43 04             	mov    0x4(%ebx),%eax
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016ec:	83 c4 0c             	add    $0xc,%esp
    dip = (struct dinode*)bp->data + ip->inum%IPB;
801016ef:	83 e0 07             	and    $0x7,%eax
801016f2:	c1 e0 06             	shl    $0x6,%eax
801016f5:	8d 44 06 5c          	lea    0x5c(%esi,%eax,1),%eax
    ip->type = dip->type;
801016f9:	0f b7 10             	movzwl (%eax),%edx
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
801016fc:	83 c0 0c             	add    $0xc,%eax
    ip->type = dip->type;
801016ff:	66 89 53 50          	mov    %dx,0x50(%ebx)
    ip->major = dip->major;
80101703:	0f b7 50 f6          	movzwl -0xa(%eax),%edx
80101707:	66 89 53 52          	mov    %dx,0x52(%ebx)
    ip->minor = dip->minor;
8010170b:	0f b7 50 f8          	movzwl -0x8(%eax),%edx
8010170f:	66 89 53 54          	mov    %dx,0x54(%ebx)
    ip->nlink = dip->nlink;
80101713:	0f b7 50 fa          	movzwl -0x6(%eax),%edx
80101717:	66 89 53 56          	mov    %dx,0x56(%ebx)
    ip->size = dip->size;
8010171b:	8b 50 fc             	mov    -0x4(%eax),%edx
8010171e:	89 53 58             	mov    %edx,0x58(%ebx)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101721:	6a 34                	push   $0x34
80101723:	50                   	push   %eax
80101724:	8d 43 5c             	lea    0x5c(%ebx),%eax
80101727:	50                   	push   %eax
80101728:	e8 73 33 00 00       	call   80104aa0 <memmove>
    brelse(bp);
8010172d:	89 34 24             	mov    %esi,(%esp)
80101730:	e8 ab ea ff ff       	call   801001e0 <brelse>
    if(ip->type == 0)
80101735:	83 c4 10             	add    $0x10,%esp
80101738:	66 83 7b 50 00       	cmpw   $0x0,0x50(%ebx)
    ip->valid = 1;
8010173d:	c7 43 4c 01 00 00 00 	movl   $0x1,0x4c(%ebx)
    if(ip->type == 0)
80101744:	0f 85 77 ff ff ff    	jne    801016c1 <ilock+0x31>
      panic("ilock: no type");
8010174a:	83 ec 0c             	sub    $0xc,%esp
8010174d:	68 2c 7f 10 80       	push   $0x80107f2c
80101752:	e8 39 ec ff ff       	call   80100390 <panic>
    panic("ilock");
80101757:	83 ec 0c             	sub    $0xc,%esp
8010175a:	68 26 7f 10 80       	push   $0x80107f26
8010175f:	e8 2c ec ff ff       	call   80100390 <panic>
80101764:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010176a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80101770 <iunlock>:
{
80101770:	55                   	push   %ebp
80101771:	89 e5                	mov    %esp,%ebp
80101773:	56                   	push   %esi
80101774:	53                   	push   %ebx
80101775:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101778:	85 db                	test   %ebx,%ebx
8010177a:	74 28                	je     801017a4 <iunlock+0x34>
8010177c:	8d 73 0c             	lea    0xc(%ebx),%esi
8010177f:	83 ec 0c             	sub    $0xc,%esp
80101782:	56                   	push   %esi
80101783:	e8 c8 2f 00 00       	call   80104750 <holdingsleep>
80101788:	83 c4 10             	add    $0x10,%esp
8010178b:	85 c0                	test   %eax,%eax
8010178d:	74 15                	je     801017a4 <iunlock+0x34>
8010178f:	8b 43 08             	mov    0x8(%ebx),%eax
80101792:	85 c0                	test   %eax,%eax
80101794:	7e 0e                	jle    801017a4 <iunlock+0x34>
  releasesleep(&ip->lock);
80101796:	89 75 08             	mov    %esi,0x8(%ebp)
}
80101799:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010179c:	5b                   	pop    %ebx
8010179d:	5e                   	pop    %esi
8010179e:	5d                   	pop    %ebp
  releasesleep(&ip->lock);
8010179f:	e9 6c 2f 00 00       	jmp    80104710 <releasesleep>
    panic("iunlock");
801017a4:	83 ec 0c             	sub    $0xc,%esp
801017a7:	68 3b 7f 10 80       	push   $0x80107f3b
801017ac:	e8 df eb ff ff       	call   80100390 <panic>
801017b1:	eb 0d                	jmp    801017c0 <iput>
801017b3:	90                   	nop
801017b4:	90                   	nop
801017b5:	90                   	nop
801017b6:	90                   	nop
801017b7:	90                   	nop
801017b8:	90                   	nop
801017b9:	90                   	nop
801017ba:	90                   	nop
801017bb:	90                   	nop
801017bc:	90                   	nop
801017bd:	90                   	nop
801017be:	90                   	nop
801017bf:	90                   	nop

801017c0 <iput>:
{
801017c0:	55                   	push   %ebp
801017c1:	89 e5                	mov    %esp,%ebp
801017c3:	57                   	push   %edi
801017c4:	56                   	push   %esi
801017c5:	53                   	push   %ebx
801017c6:	83 ec 28             	sub    $0x28,%esp
801017c9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquiresleep(&ip->lock);
801017cc:	8d 7b 0c             	lea    0xc(%ebx),%edi
801017cf:	57                   	push   %edi
801017d0:	e8 db 2e 00 00       	call   801046b0 <acquiresleep>
  if(ip->valid && ip->nlink == 0){
801017d5:	8b 53 4c             	mov    0x4c(%ebx),%edx
801017d8:	83 c4 10             	add    $0x10,%esp
801017db:	85 d2                	test   %edx,%edx
801017dd:	74 07                	je     801017e6 <iput+0x26>
801017df:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
801017e4:	74 32                	je     80101818 <iput+0x58>
  releasesleep(&ip->lock);
801017e6:	83 ec 0c             	sub    $0xc,%esp
801017e9:	57                   	push   %edi
801017ea:	e8 21 2f 00 00       	call   80104710 <releasesleep>
  acquire(&icache.lock);
801017ef:	c7 04 24 a0 6b 11 80 	movl   $0x80116ba0,(%esp)
801017f6:	e8 e5 30 00 00       	call   801048e0 <acquire>
  ip->ref--;
801017fb:	83 6b 08 01          	subl   $0x1,0x8(%ebx)
  release(&icache.lock);
801017ff:	83 c4 10             	add    $0x10,%esp
80101802:	c7 45 08 a0 6b 11 80 	movl   $0x80116ba0,0x8(%ebp)
}
80101809:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010180c:	5b                   	pop    %ebx
8010180d:	5e                   	pop    %esi
8010180e:	5f                   	pop    %edi
8010180f:	5d                   	pop    %ebp
  release(&icache.lock);
80101810:	e9 8b 31 00 00       	jmp    801049a0 <release>
80101815:	8d 76 00             	lea    0x0(%esi),%esi
    acquire(&icache.lock);
80101818:	83 ec 0c             	sub    $0xc,%esp
8010181b:	68 a0 6b 11 80       	push   $0x80116ba0
80101820:	e8 bb 30 00 00       	call   801048e0 <acquire>
    int r = ip->ref;
80101825:	8b 73 08             	mov    0x8(%ebx),%esi
    release(&icache.lock);
80101828:	c7 04 24 a0 6b 11 80 	movl   $0x80116ba0,(%esp)
8010182f:	e8 6c 31 00 00       	call   801049a0 <release>
    if(r == 1){
80101834:	83 c4 10             	add    $0x10,%esp
80101837:	83 fe 01             	cmp    $0x1,%esi
8010183a:	75 aa                	jne    801017e6 <iput+0x26>
8010183c:	8d 8b 8c 00 00 00    	lea    0x8c(%ebx),%ecx
80101842:	89 7d e4             	mov    %edi,-0x1c(%ebp)
80101845:	8d 73 5c             	lea    0x5c(%ebx),%esi
80101848:	89 cf                	mov    %ecx,%edi
8010184a:	eb 0b                	jmp    80101857 <iput+0x97>
8010184c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101850:	83 c6 04             	add    $0x4,%esi
{
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101853:	39 fe                	cmp    %edi,%esi
80101855:	74 19                	je     80101870 <iput+0xb0>
    if(ip->addrs[i]){
80101857:	8b 16                	mov    (%esi),%edx
80101859:	85 d2                	test   %edx,%edx
8010185b:	74 f3                	je     80101850 <iput+0x90>
      bfree(ip->dev, ip->addrs[i]);
8010185d:	8b 03                	mov    (%ebx),%eax
8010185f:	e8 ac fb ff ff       	call   80101410 <bfree>
      ip->addrs[i] = 0;
80101864:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
8010186a:	eb e4                	jmp    80101850 <iput+0x90>
8010186c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    }
  }

  if(ip->addrs[NDIRECT]){
80101870:	8b 83 8c 00 00 00    	mov    0x8c(%ebx),%eax
80101876:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80101879:	85 c0                	test   %eax,%eax
8010187b:	75 33                	jne    801018b0 <iput+0xf0>
    bfree(ip->dev, ip->addrs[NDIRECT]);
    ip->addrs[NDIRECT] = 0;
  }

  ip->size = 0;
  iupdate(ip);
8010187d:	83 ec 0c             	sub    $0xc,%esp
  ip->size = 0;
80101880:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  iupdate(ip);
80101887:	53                   	push   %ebx
80101888:	e8 53 fd ff ff       	call   801015e0 <iupdate>
      ip->type = 0;
8010188d:	31 c0                	xor    %eax,%eax
8010188f:	66 89 43 50          	mov    %ax,0x50(%ebx)
      iupdate(ip);
80101893:	89 1c 24             	mov    %ebx,(%esp)
80101896:	e8 45 fd ff ff       	call   801015e0 <iupdate>
      ip->valid = 0;
8010189b:	c7 43 4c 00 00 00 00 	movl   $0x0,0x4c(%ebx)
801018a2:	83 c4 10             	add    $0x10,%esp
801018a5:	e9 3c ff ff ff       	jmp    801017e6 <iput+0x26>
801018aa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
801018b0:	83 ec 08             	sub    $0x8,%esp
801018b3:	50                   	push   %eax
801018b4:	ff 33                	pushl  (%ebx)
801018b6:	e8 15 e8 ff ff       	call   801000d0 <bread>
801018bb:	8d 88 5c 02 00 00    	lea    0x25c(%eax),%ecx
801018c1:	89 7d e0             	mov    %edi,-0x20(%ebp)
801018c4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    a = (uint*)bp->data;
801018c7:	8d 70 5c             	lea    0x5c(%eax),%esi
801018ca:	83 c4 10             	add    $0x10,%esp
801018cd:	89 cf                	mov    %ecx,%edi
801018cf:	eb 0e                	jmp    801018df <iput+0x11f>
801018d1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801018d8:	83 c6 04             	add    $0x4,%esi
    for(j = 0; j < NINDIRECT; j++){
801018db:	39 fe                	cmp    %edi,%esi
801018dd:	74 0f                	je     801018ee <iput+0x12e>
      if(a[j])
801018df:	8b 16                	mov    (%esi),%edx
801018e1:	85 d2                	test   %edx,%edx
801018e3:	74 f3                	je     801018d8 <iput+0x118>
        bfree(ip->dev, a[j]);
801018e5:	8b 03                	mov    (%ebx),%eax
801018e7:	e8 24 fb ff ff       	call   80101410 <bfree>
801018ec:	eb ea                	jmp    801018d8 <iput+0x118>
    brelse(bp);
801018ee:	83 ec 0c             	sub    $0xc,%esp
801018f1:	ff 75 e4             	pushl  -0x1c(%ebp)
801018f4:	8b 7d e0             	mov    -0x20(%ebp),%edi
801018f7:	e8 e4 e8 ff ff       	call   801001e0 <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT]);
801018fc:	8b 93 8c 00 00 00    	mov    0x8c(%ebx),%edx
80101902:	8b 03                	mov    (%ebx),%eax
80101904:	e8 07 fb ff ff       	call   80101410 <bfree>
    ip->addrs[NDIRECT] = 0;
80101909:	c7 83 8c 00 00 00 00 	movl   $0x0,0x8c(%ebx)
80101910:	00 00 00 
80101913:	83 c4 10             	add    $0x10,%esp
80101916:	e9 62 ff ff ff       	jmp    8010187d <iput+0xbd>
8010191b:	90                   	nop
8010191c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101920 <iunlockput>:
{
80101920:	55                   	push   %ebp
80101921:	89 e5                	mov    %esp,%ebp
80101923:	53                   	push   %ebx
80101924:	83 ec 10             	sub    $0x10,%esp
80101927:	8b 5d 08             	mov    0x8(%ebp),%ebx
  iunlock(ip);
8010192a:	53                   	push   %ebx
8010192b:	e8 40 fe ff ff       	call   80101770 <iunlock>
  iput(ip);
80101930:	89 5d 08             	mov    %ebx,0x8(%ebp)
80101933:	83 c4 10             	add    $0x10,%esp
}
80101936:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80101939:	c9                   	leave  
  iput(ip);
8010193a:	e9 81 fe ff ff       	jmp    801017c0 <iput>
8010193f:	90                   	nop

80101940 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101940:	55                   	push   %ebp
80101941:	89 e5                	mov    %esp,%ebp
80101943:	8b 55 08             	mov    0x8(%ebp),%edx
80101946:	8b 45 0c             	mov    0xc(%ebp),%eax
  st->dev = ip->dev;
80101949:	8b 0a                	mov    (%edx),%ecx
8010194b:	89 48 04             	mov    %ecx,0x4(%eax)
  st->ino = ip->inum;
8010194e:	8b 4a 04             	mov    0x4(%edx),%ecx
80101951:	89 48 08             	mov    %ecx,0x8(%eax)
  st->type = ip->type;
80101954:	0f b7 4a 50          	movzwl 0x50(%edx),%ecx
80101958:	66 89 08             	mov    %cx,(%eax)
  st->nlink = ip->nlink;
8010195b:	0f b7 4a 56          	movzwl 0x56(%edx),%ecx
8010195f:	66 89 48 0c          	mov    %cx,0xc(%eax)
  st->size = ip->size;
80101963:	8b 52 58             	mov    0x58(%edx),%edx
80101966:	89 50 10             	mov    %edx,0x10(%eax)
}
80101969:	5d                   	pop    %ebp
8010196a:	c3                   	ret    
8010196b:	90                   	nop
8010196c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101970 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101970:	55                   	push   %ebp
80101971:	89 e5                	mov    %esp,%ebp
80101973:	57                   	push   %edi
80101974:	56                   	push   %esi
80101975:	53                   	push   %ebx
80101976:	83 ec 1c             	sub    $0x1c,%esp
80101979:	8b 45 08             	mov    0x8(%ebp),%eax
8010197c:	8b 75 0c             	mov    0xc(%ebp),%esi
8010197f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101982:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101987:	89 75 e0             	mov    %esi,-0x20(%ebp)
8010198a:	89 45 d8             	mov    %eax,-0x28(%ebp)
8010198d:	8b 75 10             	mov    0x10(%ebp),%esi
80101990:	89 7d e4             	mov    %edi,-0x1c(%ebp)
  if(ip->type == T_DEV){
80101993:	0f 84 a7 00 00 00    	je     80101a40 <readi+0xd0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
      return -1;
    return devsw[ip->major].read(ip, dst, n);
  }

  if(off > ip->size || off + n < off)
80101999:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010199c:	8b 40 58             	mov    0x58(%eax),%eax
8010199f:	39 c6                	cmp    %eax,%esi
801019a1:	0f 87 ba 00 00 00    	ja     80101a61 <readi+0xf1>
801019a7:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801019aa:	89 f9                	mov    %edi,%ecx
801019ac:	01 f1                	add    %esi,%ecx
801019ae:	0f 82 ad 00 00 00    	jb     80101a61 <readi+0xf1>
    return -1;
  if(off + n > ip->size)
    n = ip->size - off;
801019b4:	89 c2                	mov    %eax,%edx
801019b6:	29 f2                	sub    %esi,%edx
801019b8:	39 c8                	cmp    %ecx,%eax
801019ba:	0f 43 d7             	cmovae %edi,%edx

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019bd:	31 ff                	xor    %edi,%edi
801019bf:	85 d2                	test   %edx,%edx
    n = ip->size - off;
801019c1:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
801019c4:	74 6c                	je     80101a32 <readi+0xc2>
801019c6:	8d 76 00             	lea    0x0(%esi),%esi
801019c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019d0:	8b 5d d8             	mov    -0x28(%ebp),%ebx
801019d3:	89 f2                	mov    %esi,%edx
801019d5:	c1 ea 09             	shr    $0x9,%edx
801019d8:	89 d8                	mov    %ebx,%eax
801019da:	e8 11 f9 ff ff       	call   801012f0 <bmap>
801019df:	83 ec 08             	sub    $0x8,%esp
801019e2:	50                   	push   %eax
801019e3:	ff 33                	pushl  (%ebx)
801019e5:	e8 e6 e6 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
801019ea:	8b 5d e4             	mov    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
801019ed:	89 c2                	mov    %eax,%edx
    m = min(n - tot, BSIZE - off%BSIZE);
801019ef:	89 f0                	mov    %esi,%eax
801019f1:	25 ff 01 00 00       	and    $0x1ff,%eax
801019f6:	b9 00 02 00 00       	mov    $0x200,%ecx
801019fb:	83 c4 0c             	add    $0xc,%esp
801019fe:	29 c1                	sub    %eax,%ecx
    memmove(dst, bp->data + off%BSIZE, m);
80101a00:	8d 44 02 5c          	lea    0x5c(%edx,%eax,1),%eax
80101a04:	89 55 dc             	mov    %edx,-0x24(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101a07:	29 fb                	sub    %edi,%ebx
80101a09:	39 d9                	cmp    %ebx,%ecx
80101a0b:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(dst, bp->data + off%BSIZE, m);
80101a0e:	53                   	push   %ebx
80101a0f:	50                   	push   %eax
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a10:	01 df                	add    %ebx,%edi
    memmove(dst, bp->data + off%BSIZE, m);
80101a12:	ff 75 e0             	pushl  -0x20(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a15:	01 de                	add    %ebx,%esi
    memmove(dst, bp->data + off%BSIZE, m);
80101a17:	e8 84 30 00 00       	call   80104aa0 <memmove>
    brelse(bp);
80101a1c:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101a1f:	89 14 24             	mov    %edx,(%esp)
80101a22:	e8 b9 e7 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101a27:	01 5d e0             	add    %ebx,-0x20(%ebp)
80101a2a:	83 c4 10             	add    $0x10,%esp
80101a2d:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
80101a30:	77 9e                	ja     801019d0 <readi+0x60>
  }
  return n;
80101a32:	8b 45 e4             	mov    -0x1c(%ebp),%eax
}
80101a35:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a38:	5b                   	pop    %ebx
80101a39:	5e                   	pop    %esi
80101a3a:	5f                   	pop    %edi
80101a3b:	5d                   	pop    %ebp
80101a3c:	c3                   	ret    
80101a3d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101a40:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101a44:	66 83 f8 09          	cmp    $0x9,%ax
80101a48:	77 17                	ja     80101a61 <readi+0xf1>
80101a4a:	8b 04 c5 20 6b 11 80 	mov    -0x7fee94e0(,%eax,8),%eax
80101a51:	85 c0                	test   %eax,%eax
80101a53:	74 0c                	je     80101a61 <readi+0xf1>
    return devsw[ip->major].read(ip, dst, n);
80101a55:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101a58:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101a5b:	5b                   	pop    %ebx
80101a5c:	5e                   	pop    %esi
80101a5d:	5f                   	pop    %edi
80101a5e:	5d                   	pop    %ebp
    return devsw[ip->major].read(ip, dst, n);
80101a5f:	ff e0                	jmp    *%eax
      return -1;
80101a61:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101a66:	eb cd                	jmp    80101a35 <readi+0xc5>
80101a68:	90                   	nop
80101a69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101a70 <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
80101a70:	55                   	push   %ebp
80101a71:	89 e5                	mov    %esp,%ebp
80101a73:	57                   	push   %edi
80101a74:	56                   	push   %esi
80101a75:	53                   	push   %ebx
80101a76:	83 ec 1c             	sub    $0x1c,%esp
80101a79:	8b 45 08             	mov    0x8(%ebp),%eax
80101a7c:	8b 75 0c             	mov    0xc(%ebp),%esi
80101a7f:	8b 7d 14             	mov    0x14(%ebp),%edi
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101a82:	66 83 78 50 03       	cmpw   $0x3,0x50(%eax)
{
80101a87:	89 75 dc             	mov    %esi,-0x24(%ebp)
80101a8a:	89 45 d8             	mov    %eax,-0x28(%ebp)
80101a8d:	8b 75 10             	mov    0x10(%ebp),%esi
80101a90:	89 7d e0             	mov    %edi,-0x20(%ebp)
  if(ip->type == T_DEV){
80101a93:	0f 84 b7 00 00 00    	je     80101b50 <writei+0xe0>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
      return -1;
    return devsw[ip->major].write(ip, src, n);
  }

  if(off > ip->size || off + n < off)
80101a99:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101a9c:	39 70 58             	cmp    %esi,0x58(%eax)
80101a9f:	0f 82 eb 00 00 00    	jb     80101b90 <writei+0x120>
80101aa5:	8b 7d e0             	mov    -0x20(%ebp),%edi
80101aa8:	31 d2                	xor    %edx,%edx
80101aaa:	89 f8                	mov    %edi,%eax
80101aac:	01 f0                	add    %esi,%eax
80101aae:	0f 92 c2             	setb   %dl
    return -1;
  if(off + n > MAXFILE*BSIZE)
80101ab1:	3d 00 18 01 00       	cmp    $0x11800,%eax
80101ab6:	0f 87 d4 00 00 00    	ja     80101b90 <writei+0x120>
80101abc:	85 d2                	test   %edx,%edx
80101abe:	0f 85 cc 00 00 00    	jne    80101b90 <writei+0x120>
    return -1;

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101ac4:	85 ff                	test   %edi,%edi
80101ac6:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80101acd:	74 72                	je     80101b41 <writei+0xd1>
80101acf:	90                   	nop
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101ad0:	8b 7d d8             	mov    -0x28(%ebp),%edi
80101ad3:	89 f2                	mov    %esi,%edx
80101ad5:	c1 ea 09             	shr    $0x9,%edx
80101ad8:	89 f8                	mov    %edi,%eax
80101ada:	e8 11 f8 ff ff       	call   801012f0 <bmap>
80101adf:	83 ec 08             	sub    $0x8,%esp
80101ae2:	50                   	push   %eax
80101ae3:	ff 37                	pushl  (%edi)
80101ae5:	e8 e6 e5 ff ff       	call   801000d0 <bread>
    m = min(n - tot, BSIZE - off%BSIZE);
80101aea:	8b 5d e0             	mov    -0x20(%ebp),%ebx
80101aed:	2b 5d e4             	sub    -0x1c(%ebp),%ebx
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101af0:	89 c7                	mov    %eax,%edi
    m = min(n - tot, BSIZE - off%BSIZE);
80101af2:	89 f0                	mov    %esi,%eax
80101af4:	b9 00 02 00 00       	mov    $0x200,%ecx
80101af9:	83 c4 0c             	add    $0xc,%esp
80101afc:	25 ff 01 00 00       	and    $0x1ff,%eax
80101b01:	29 c1                	sub    %eax,%ecx
    memmove(bp->data + off%BSIZE, src, m);
80101b03:	8d 44 07 5c          	lea    0x5c(%edi,%eax,1),%eax
    m = min(n - tot, BSIZE - off%BSIZE);
80101b07:	39 d9                	cmp    %ebx,%ecx
80101b09:	0f 46 d9             	cmovbe %ecx,%ebx
    memmove(bp->data + off%BSIZE, src, m);
80101b0c:	53                   	push   %ebx
80101b0d:	ff 75 dc             	pushl  -0x24(%ebp)
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b10:	01 de                	add    %ebx,%esi
    memmove(bp->data + off%BSIZE, src, m);
80101b12:	50                   	push   %eax
80101b13:	e8 88 2f 00 00       	call   80104aa0 <memmove>
    log_write(bp);
80101b18:	89 3c 24             	mov    %edi,(%esp)
80101b1b:	e8 70 12 00 00       	call   80102d90 <log_write>
    brelse(bp);
80101b20:	89 3c 24             	mov    %edi,(%esp)
80101b23:	e8 b8 e6 ff ff       	call   801001e0 <brelse>
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80101b28:	01 5d e4             	add    %ebx,-0x1c(%ebp)
80101b2b:	01 5d dc             	add    %ebx,-0x24(%ebp)
80101b2e:	83 c4 10             	add    $0x10,%esp
80101b31:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101b34:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80101b37:	77 97                	ja     80101ad0 <writei+0x60>
  }

  if(n > 0 && off > ip->size){
80101b39:	8b 45 d8             	mov    -0x28(%ebp),%eax
80101b3c:	3b 70 58             	cmp    0x58(%eax),%esi
80101b3f:	77 37                	ja     80101b78 <writei+0x108>
    ip->size = off;
    iupdate(ip);
  }
  return n;
80101b41:	8b 45 e0             	mov    -0x20(%ebp),%eax
}
80101b44:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b47:	5b                   	pop    %ebx
80101b48:	5e                   	pop    %esi
80101b49:	5f                   	pop    %edi
80101b4a:	5d                   	pop    %ebp
80101b4b:	c3                   	ret    
80101b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
80101b50:	0f bf 40 52          	movswl 0x52(%eax),%eax
80101b54:	66 83 f8 09          	cmp    $0x9,%ax
80101b58:	77 36                	ja     80101b90 <writei+0x120>
80101b5a:	8b 04 c5 24 6b 11 80 	mov    -0x7fee94dc(,%eax,8),%eax
80101b61:	85 c0                	test   %eax,%eax
80101b63:	74 2b                	je     80101b90 <writei+0x120>
    return devsw[ip->major].write(ip, src, n);
80101b65:	89 7d 10             	mov    %edi,0x10(%ebp)
}
80101b68:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101b6b:	5b                   	pop    %ebx
80101b6c:	5e                   	pop    %esi
80101b6d:	5f                   	pop    %edi
80101b6e:	5d                   	pop    %ebp
    return devsw[ip->major].write(ip, src, n);
80101b6f:	ff e0                	jmp    *%eax
80101b71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    ip->size = off;
80101b78:	8b 45 d8             	mov    -0x28(%ebp),%eax
    iupdate(ip);
80101b7b:	83 ec 0c             	sub    $0xc,%esp
    ip->size = off;
80101b7e:	89 70 58             	mov    %esi,0x58(%eax)
    iupdate(ip);
80101b81:	50                   	push   %eax
80101b82:	e8 59 fa ff ff       	call   801015e0 <iupdate>
80101b87:	83 c4 10             	add    $0x10,%esp
80101b8a:	eb b5                	jmp    80101b41 <writei+0xd1>
80101b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return -1;
80101b90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101b95:	eb ad                	jmp    80101b44 <writei+0xd4>
80101b97:	89 f6                	mov    %esi,%esi
80101b99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101ba0 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
80101ba0:	55                   	push   %ebp
80101ba1:	89 e5                	mov    %esp,%ebp
80101ba3:	83 ec 0c             	sub    $0xc,%esp
  return strncmp(s, t, DIRSIZ);
80101ba6:	6a 0e                	push   $0xe
80101ba8:	ff 75 0c             	pushl  0xc(%ebp)
80101bab:	ff 75 08             	pushl  0x8(%ebp)
80101bae:	e8 5d 2f 00 00       	call   80104b10 <strncmp>
}
80101bb3:	c9                   	leave  
80101bb4:	c3                   	ret    
80101bb5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101bc0 <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
80101bc0:	55                   	push   %ebp
80101bc1:	89 e5                	mov    %esp,%ebp
80101bc3:	57                   	push   %edi
80101bc4:	56                   	push   %esi
80101bc5:	53                   	push   %ebx
80101bc6:	83 ec 1c             	sub    $0x1c,%esp
80101bc9:	8b 5d 08             	mov    0x8(%ebp),%ebx
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80101bcc:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80101bd1:	0f 85 85 00 00 00    	jne    80101c5c <dirlookup+0x9c>
    panic("dirlookup not DIR");

  for(off = 0; off < dp->size; off += sizeof(de)){
80101bd7:	8b 53 58             	mov    0x58(%ebx),%edx
80101bda:	31 ff                	xor    %edi,%edi
80101bdc:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101bdf:	85 d2                	test   %edx,%edx
80101be1:	74 3e                	je     80101c21 <dirlookup+0x61>
80101be3:	90                   	nop
80101be4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101be8:	6a 10                	push   $0x10
80101bea:	57                   	push   %edi
80101beb:	56                   	push   %esi
80101bec:	53                   	push   %ebx
80101bed:	e8 7e fd ff ff       	call   80101970 <readi>
80101bf2:	83 c4 10             	add    $0x10,%esp
80101bf5:	83 f8 10             	cmp    $0x10,%eax
80101bf8:	75 55                	jne    80101c4f <dirlookup+0x8f>
      panic("dirlookup read");
    if(de.inum == 0)
80101bfa:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101bff:	74 18                	je     80101c19 <dirlookup+0x59>
  return strncmp(s, t, DIRSIZ);
80101c01:	8d 45 da             	lea    -0x26(%ebp),%eax
80101c04:	83 ec 04             	sub    $0x4,%esp
80101c07:	6a 0e                	push   $0xe
80101c09:	50                   	push   %eax
80101c0a:	ff 75 0c             	pushl  0xc(%ebp)
80101c0d:	e8 fe 2e 00 00       	call   80104b10 <strncmp>
      continue;
    if(namecmp(name, de.name) == 0){
80101c12:	83 c4 10             	add    $0x10,%esp
80101c15:	85 c0                	test   %eax,%eax
80101c17:	74 17                	je     80101c30 <dirlookup+0x70>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101c19:	83 c7 10             	add    $0x10,%edi
80101c1c:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101c1f:	72 c7                	jb     80101be8 <dirlookup+0x28>
      return iget(dp->dev, inum);
    }
  }

  return 0;
}
80101c21:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80101c24:	31 c0                	xor    %eax,%eax
}
80101c26:	5b                   	pop    %ebx
80101c27:	5e                   	pop    %esi
80101c28:	5f                   	pop    %edi
80101c29:	5d                   	pop    %ebp
80101c2a:	c3                   	ret    
80101c2b:	90                   	nop
80101c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      if(poff)
80101c30:	8b 45 10             	mov    0x10(%ebp),%eax
80101c33:	85 c0                	test   %eax,%eax
80101c35:	74 05                	je     80101c3c <dirlookup+0x7c>
        *poff = off;
80101c37:	8b 45 10             	mov    0x10(%ebp),%eax
80101c3a:	89 38                	mov    %edi,(%eax)
      inum = de.inum;
80101c3c:	0f b7 55 d8          	movzwl -0x28(%ebp),%edx
      return iget(dp->dev, inum);
80101c40:	8b 03                	mov    (%ebx),%eax
80101c42:	e8 d9 f5 ff ff       	call   80101220 <iget>
}
80101c47:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101c4a:	5b                   	pop    %ebx
80101c4b:	5e                   	pop    %esi
80101c4c:	5f                   	pop    %edi
80101c4d:	5d                   	pop    %ebp
80101c4e:	c3                   	ret    
      panic("dirlookup read");
80101c4f:	83 ec 0c             	sub    $0xc,%esp
80101c52:	68 55 7f 10 80       	push   $0x80107f55
80101c57:	e8 34 e7 ff ff       	call   80100390 <panic>
    panic("dirlookup not DIR");
80101c5c:	83 ec 0c             	sub    $0xc,%esp
80101c5f:	68 43 7f 10 80       	push   $0x80107f43
80101c64:	e8 27 e7 ff ff       	call   80100390 <panic>
80101c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80101c70 <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
80101c70:	55                   	push   %ebp
80101c71:	89 e5                	mov    %esp,%ebp
80101c73:	57                   	push   %edi
80101c74:	56                   	push   %esi
80101c75:	53                   	push   %ebx
80101c76:	89 cf                	mov    %ecx,%edi
80101c78:	89 c3                	mov    %eax,%ebx
80101c7a:	83 ec 1c             	sub    $0x1c,%esp
  struct inode *ip, *next;

  if(*path == '/')
80101c7d:	80 38 2f             	cmpb   $0x2f,(%eax)
{
80101c80:	89 55 e0             	mov    %edx,-0x20(%ebp)
  if(*path == '/')
80101c83:	0f 84 77 01 00 00    	je     80101e00 <namex+0x190>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
80101c89:	e8 02 1c 00 00       	call   80103890 <myproc>
  acquire(&icache.lock);
80101c8e:	83 ec 0c             	sub    $0xc,%esp
    ip = idup(myproc()->cwd);
80101c91:	8b b0 d8 04 00 00    	mov    0x4d8(%eax),%esi
  acquire(&icache.lock);
80101c97:	68 a0 6b 11 80       	push   $0x80116ba0
80101c9c:	e8 3f 2c 00 00       	call   801048e0 <acquire>
  ip->ref++;
80101ca1:	83 46 08 01          	addl   $0x1,0x8(%esi)
  release(&icache.lock);
80101ca5:	c7 04 24 a0 6b 11 80 	movl   $0x80116ba0,(%esp)
80101cac:	e8 ef 2c 00 00       	call   801049a0 <release>
80101cb1:	83 c4 10             	add    $0x10,%esp
80101cb4:	eb 0d                	jmp    80101cc3 <namex+0x53>
80101cb6:	8d 76 00             	lea    0x0(%esi),%esi
80101cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101cc0:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101cc3:	0f b6 03             	movzbl (%ebx),%eax
80101cc6:	3c 2f                	cmp    $0x2f,%al
80101cc8:	74 f6                	je     80101cc0 <namex+0x50>
  if(*path == 0)
80101cca:	84 c0                	test   %al,%al
80101ccc:	0f 84 f6 00 00 00    	je     80101dc8 <namex+0x158>
  while(*path != '/' && *path != 0)
80101cd2:	0f b6 03             	movzbl (%ebx),%eax
80101cd5:	3c 2f                	cmp    $0x2f,%al
80101cd7:	0f 84 bb 00 00 00    	je     80101d98 <namex+0x128>
80101cdd:	84 c0                	test   %al,%al
80101cdf:	89 da                	mov    %ebx,%edx
80101ce1:	75 11                	jne    80101cf4 <namex+0x84>
80101ce3:	e9 b0 00 00 00       	jmp    80101d98 <namex+0x128>
80101ce8:	90                   	nop
80101ce9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101cf0:	84 c0                	test   %al,%al
80101cf2:	74 0a                	je     80101cfe <namex+0x8e>
    path++;
80101cf4:	83 c2 01             	add    $0x1,%edx
  while(*path != '/' && *path != 0)
80101cf7:	0f b6 02             	movzbl (%edx),%eax
80101cfa:	3c 2f                	cmp    $0x2f,%al
80101cfc:	75 f2                	jne    80101cf0 <namex+0x80>
80101cfe:	89 d1                	mov    %edx,%ecx
80101d00:	29 d9                	sub    %ebx,%ecx
  if(len >= DIRSIZ)
80101d02:	83 f9 0d             	cmp    $0xd,%ecx
80101d05:	0f 8e 91 00 00 00    	jle    80101d9c <namex+0x12c>
    memmove(name, s, DIRSIZ);
80101d0b:	83 ec 04             	sub    $0x4,%esp
80101d0e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101d11:	6a 0e                	push   $0xe
80101d13:	53                   	push   %ebx
80101d14:	57                   	push   %edi
80101d15:	e8 86 2d 00 00       	call   80104aa0 <memmove>
    path++;
80101d1a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    memmove(name, s, DIRSIZ);
80101d1d:	83 c4 10             	add    $0x10,%esp
    path++;
80101d20:	89 d3                	mov    %edx,%ebx
  while(*path == '/')
80101d22:	80 3a 2f             	cmpb   $0x2f,(%edx)
80101d25:	75 11                	jne    80101d38 <namex+0xc8>
80101d27:	89 f6                	mov    %esi,%esi
80101d29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    path++;
80101d30:	83 c3 01             	add    $0x1,%ebx
  while(*path == '/')
80101d33:	80 3b 2f             	cmpb   $0x2f,(%ebx)
80101d36:	74 f8                	je     80101d30 <namex+0xc0>

  while((path = skipelem(path, name)) != 0){
    ilock(ip);
80101d38:	83 ec 0c             	sub    $0xc,%esp
80101d3b:	56                   	push   %esi
80101d3c:	e8 4f f9 ff ff       	call   80101690 <ilock>
    if(ip->type != T_DIR){
80101d41:	83 c4 10             	add    $0x10,%esp
80101d44:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
80101d49:	0f 85 91 00 00 00    	jne    80101de0 <namex+0x170>
      iunlockput(ip);
      return 0;
    }
    if(nameiparent && *path == '\0'){
80101d4f:	8b 55 e0             	mov    -0x20(%ebp),%edx
80101d52:	85 d2                	test   %edx,%edx
80101d54:	74 09                	je     80101d5f <namex+0xef>
80101d56:	80 3b 00             	cmpb   $0x0,(%ebx)
80101d59:	0f 84 b7 00 00 00    	je     80101e16 <namex+0x1a6>
      // Stop one level early.
      iunlock(ip);
      return ip;
    }
    if((next = dirlookup(ip, name, 0)) == 0){
80101d5f:	83 ec 04             	sub    $0x4,%esp
80101d62:	6a 00                	push   $0x0
80101d64:	57                   	push   %edi
80101d65:	56                   	push   %esi
80101d66:	e8 55 fe ff ff       	call   80101bc0 <dirlookup>
80101d6b:	83 c4 10             	add    $0x10,%esp
80101d6e:	85 c0                	test   %eax,%eax
80101d70:	74 6e                	je     80101de0 <namex+0x170>
  iunlock(ip);
80101d72:	83 ec 0c             	sub    $0xc,%esp
80101d75:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80101d78:	56                   	push   %esi
80101d79:	e8 f2 f9 ff ff       	call   80101770 <iunlock>
  iput(ip);
80101d7e:	89 34 24             	mov    %esi,(%esp)
80101d81:	e8 3a fa ff ff       	call   801017c0 <iput>
80101d86:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80101d89:	83 c4 10             	add    $0x10,%esp
80101d8c:	89 c6                	mov    %eax,%esi
80101d8e:	e9 30 ff ff ff       	jmp    80101cc3 <namex+0x53>
80101d93:	90                   	nop
80101d94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  while(*path != '/' && *path != 0)
80101d98:	89 da                	mov    %ebx,%edx
80101d9a:	31 c9                	xor    %ecx,%ecx
    memmove(name, s, len);
80101d9c:	83 ec 04             	sub    $0x4,%esp
80101d9f:	89 55 dc             	mov    %edx,-0x24(%ebp)
80101da2:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80101da5:	51                   	push   %ecx
80101da6:	53                   	push   %ebx
80101da7:	57                   	push   %edi
80101da8:	e8 f3 2c 00 00       	call   80104aa0 <memmove>
    name[len] = 0;
80101dad:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80101db0:	8b 55 dc             	mov    -0x24(%ebp),%edx
80101db3:	83 c4 10             	add    $0x10,%esp
80101db6:	c6 04 0f 00          	movb   $0x0,(%edi,%ecx,1)
80101dba:	89 d3                	mov    %edx,%ebx
80101dbc:	e9 61 ff ff ff       	jmp    80101d22 <namex+0xb2>
80101dc1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      return 0;
    }
    iunlockput(ip);
    ip = next;
  }
  if(nameiparent){
80101dc8:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101dcb:	85 c0                	test   %eax,%eax
80101dcd:	75 5d                	jne    80101e2c <namex+0x1bc>
    iput(ip);
    return 0;
  }
  return ip;
}
80101dcf:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101dd2:	89 f0                	mov    %esi,%eax
80101dd4:	5b                   	pop    %ebx
80101dd5:	5e                   	pop    %esi
80101dd6:	5f                   	pop    %edi
80101dd7:	5d                   	pop    %ebp
80101dd8:	c3                   	ret    
80101dd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  iunlock(ip);
80101de0:	83 ec 0c             	sub    $0xc,%esp
80101de3:	56                   	push   %esi
80101de4:	e8 87 f9 ff ff       	call   80101770 <iunlock>
  iput(ip);
80101de9:	89 34 24             	mov    %esi,(%esp)
      return 0;
80101dec:	31 f6                	xor    %esi,%esi
  iput(ip);
80101dee:	e8 cd f9 ff ff       	call   801017c0 <iput>
      return 0;
80101df3:	83 c4 10             	add    $0x10,%esp
}
80101df6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101df9:	89 f0                	mov    %esi,%eax
80101dfb:	5b                   	pop    %ebx
80101dfc:	5e                   	pop    %esi
80101dfd:	5f                   	pop    %edi
80101dfe:	5d                   	pop    %ebp
80101dff:	c3                   	ret    
    ip = iget(ROOTDEV, ROOTINO);
80101e00:	ba 01 00 00 00       	mov    $0x1,%edx
80101e05:	b8 01 00 00 00       	mov    $0x1,%eax
80101e0a:	e8 11 f4 ff ff       	call   80101220 <iget>
80101e0f:	89 c6                	mov    %eax,%esi
80101e11:	e9 ad fe ff ff       	jmp    80101cc3 <namex+0x53>
      iunlock(ip);
80101e16:	83 ec 0c             	sub    $0xc,%esp
80101e19:	56                   	push   %esi
80101e1a:	e8 51 f9 ff ff       	call   80101770 <iunlock>
      return ip;
80101e1f:	83 c4 10             	add    $0x10,%esp
}
80101e22:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101e25:	89 f0                	mov    %esi,%eax
80101e27:	5b                   	pop    %ebx
80101e28:	5e                   	pop    %esi
80101e29:	5f                   	pop    %edi
80101e2a:	5d                   	pop    %ebp
80101e2b:	c3                   	ret    
    iput(ip);
80101e2c:	83 ec 0c             	sub    $0xc,%esp
80101e2f:	56                   	push   %esi
    return 0;
80101e30:	31 f6                	xor    %esi,%esi
    iput(ip);
80101e32:	e8 89 f9 ff ff       	call   801017c0 <iput>
    return 0;
80101e37:	83 c4 10             	add    $0x10,%esp
80101e3a:	eb 93                	jmp    80101dcf <namex+0x15f>
80101e3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80101e40 <dirlink>:
{
80101e40:	55                   	push   %ebp
80101e41:	89 e5                	mov    %esp,%ebp
80101e43:	57                   	push   %edi
80101e44:	56                   	push   %esi
80101e45:	53                   	push   %ebx
80101e46:	83 ec 20             	sub    $0x20,%esp
80101e49:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if((ip = dirlookup(dp, name, 0)) != 0){
80101e4c:	6a 00                	push   $0x0
80101e4e:	ff 75 0c             	pushl  0xc(%ebp)
80101e51:	53                   	push   %ebx
80101e52:	e8 69 fd ff ff       	call   80101bc0 <dirlookup>
80101e57:	83 c4 10             	add    $0x10,%esp
80101e5a:	85 c0                	test   %eax,%eax
80101e5c:	75 67                	jne    80101ec5 <dirlink+0x85>
  for(off = 0; off < dp->size; off += sizeof(de)){
80101e5e:	8b 7b 58             	mov    0x58(%ebx),%edi
80101e61:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e64:	85 ff                	test   %edi,%edi
80101e66:	74 29                	je     80101e91 <dirlink+0x51>
80101e68:	31 ff                	xor    %edi,%edi
80101e6a:	8d 75 d8             	lea    -0x28(%ebp),%esi
80101e6d:	eb 09                	jmp    80101e78 <dirlink+0x38>
80101e6f:	90                   	nop
80101e70:	83 c7 10             	add    $0x10,%edi
80101e73:	3b 7b 58             	cmp    0x58(%ebx),%edi
80101e76:	73 19                	jae    80101e91 <dirlink+0x51>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101e78:	6a 10                	push   $0x10
80101e7a:	57                   	push   %edi
80101e7b:	56                   	push   %esi
80101e7c:	53                   	push   %ebx
80101e7d:	e8 ee fa ff ff       	call   80101970 <readi>
80101e82:	83 c4 10             	add    $0x10,%esp
80101e85:	83 f8 10             	cmp    $0x10,%eax
80101e88:	75 4e                	jne    80101ed8 <dirlink+0x98>
    if(de.inum == 0)
80101e8a:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
80101e8f:	75 df                	jne    80101e70 <dirlink+0x30>
  strncpy(de.name, name, DIRSIZ);
80101e91:	8d 45 da             	lea    -0x26(%ebp),%eax
80101e94:	83 ec 04             	sub    $0x4,%esp
80101e97:	6a 0e                	push   $0xe
80101e99:	ff 75 0c             	pushl  0xc(%ebp)
80101e9c:	50                   	push   %eax
80101e9d:	e8 ce 2c 00 00       	call   80104b70 <strncpy>
  de.inum = inum;
80101ea2:	8b 45 10             	mov    0x10(%ebp),%eax
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101ea5:	6a 10                	push   $0x10
80101ea7:	57                   	push   %edi
80101ea8:	56                   	push   %esi
80101ea9:	53                   	push   %ebx
  de.inum = inum;
80101eaa:	66 89 45 d8          	mov    %ax,-0x28(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80101eae:	e8 bd fb ff ff       	call   80101a70 <writei>
80101eb3:	83 c4 20             	add    $0x20,%esp
80101eb6:	83 f8 10             	cmp    $0x10,%eax
80101eb9:	75 2a                	jne    80101ee5 <dirlink+0xa5>
  return 0;
80101ebb:	31 c0                	xor    %eax,%eax
}
80101ebd:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ec0:	5b                   	pop    %ebx
80101ec1:	5e                   	pop    %esi
80101ec2:	5f                   	pop    %edi
80101ec3:	5d                   	pop    %ebp
80101ec4:	c3                   	ret    
    iput(ip);
80101ec5:	83 ec 0c             	sub    $0xc,%esp
80101ec8:	50                   	push   %eax
80101ec9:	e8 f2 f8 ff ff       	call   801017c0 <iput>
    return -1;
80101ece:	83 c4 10             	add    $0x10,%esp
80101ed1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101ed6:	eb e5                	jmp    80101ebd <dirlink+0x7d>
      panic("dirlink read");
80101ed8:	83 ec 0c             	sub    $0xc,%esp
80101edb:	68 64 7f 10 80       	push   $0x80107f64
80101ee0:	e8 ab e4 ff ff       	call   80100390 <panic>
    panic("dirlink");
80101ee5:	83 ec 0c             	sub    $0xc,%esp
80101ee8:	68 2e 86 10 80       	push   $0x8010862e
80101eed:	e8 9e e4 ff ff       	call   80100390 <panic>
80101ef2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80101ef9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f00 <namei>:

struct inode*
namei(char *path)
{
80101f00:	55                   	push   %ebp
  char name[DIRSIZ];
  return namex(path, 0, name);
80101f01:	31 d2                	xor    %edx,%edx
{
80101f03:	89 e5                	mov    %esp,%ebp
80101f05:	83 ec 18             	sub    $0x18,%esp
  return namex(path, 0, name);
80101f08:	8b 45 08             	mov    0x8(%ebp),%eax
80101f0b:	8d 4d ea             	lea    -0x16(%ebp),%ecx
80101f0e:	e8 5d fd ff ff       	call   80101c70 <namex>
}
80101f13:	c9                   	leave  
80101f14:	c3                   	ret    
80101f15:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80101f19:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80101f20 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80101f20:	55                   	push   %ebp
  return namex(path, 1, name);
80101f21:	ba 01 00 00 00       	mov    $0x1,%edx
{
80101f26:	89 e5                	mov    %esp,%ebp
  return namex(path, 1, name);
80101f28:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80101f2b:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101f2e:	5d                   	pop    %ebp
  return namex(path, 1, name);
80101f2f:	e9 3c fd ff ff       	jmp    80101c70 <namex>
80101f34:	66 90                	xchg   %ax,%ax
80101f36:	66 90                	xchg   %ax,%ax
80101f38:	66 90                	xchg   %ax,%ax
80101f3a:	66 90                	xchg   %ax,%ax
80101f3c:	66 90                	xchg   %ax,%ax
80101f3e:	66 90                	xchg   %ax,%ax

80101f40 <idestart>:
}

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
80101f40:	55                   	push   %ebp
80101f41:	89 e5                	mov    %esp,%ebp
80101f43:	57                   	push   %edi
80101f44:	56                   	push   %esi
80101f45:	53                   	push   %ebx
80101f46:	83 ec 0c             	sub    $0xc,%esp
  if(b == 0)
80101f49:	85 c0                	test   %eax,%eax
80101f4b:	0f 84 b4 00 00 00    	je     80102005 <idestart+0xc5>
    panic("idestart");
  if(b->blockno >= FSSIZE)
80101f51:	8b 58 08             	mov    0x8(%eax),%ebx
80101f54:	89 c6                	mov    %eax,%esi
80101f56:	81 fb e7 03 00 00    	cmp    $0x3e7,%ebx
80101f5c:	0f 87 96 00 00 00    	ja     80101ff8 <idestart+0xb8>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80101f62:	b9 f7 01 00 00       	mov    $0x1f7,%ecx
80101f67:	89 f6                	mov    %esi,%esi
80101f69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80101f70:	89 ca                	mov    %ecx,%edx
80101f72:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80101f73:	83 e0 c0             	and    $0xffffffc0,%eax
80101f76:	3c 40                	cmp    $0x40,%al
80101f78:	75 f6                	jne    80101f70 <idestart+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80101f7a:	31 ff                	xor    %edi,%edi
80101f7c:	ba f6 03 00 00       	mov    $0x3f6,%edx
80101f81:	89 f8                	mov    %edi,%eax
80101f83:	ee                   	out    %al,(%dx)
80101f84:	b8 01 00 00 00       	mov    $0x1,%eax
80101f89:	ba f2 01 00 00       	mov    $0x1f2,%edx
80101f8e:	ee                   	out    %al,(%dx)
80101f8f:	ba f3 01 00 00       	mov    $0x1f3,%edx
80101f94:	89 d8                	mov    %ebx,%eax
80101f96:	ee                   	out    %al,(%dx)

  idewait(0);
  outb(0x3f6, 0);  // generate interrupt
  outb(0x1f2, sector_per_block);  // number of sectors
  outb(0x1f3, sector & 0xff);
  outb(0x1f4, (sector >> 8) & 0xff);
80101f97:	89 d8                	mov    %ebx,%eax
80101f99:	ba f4 01 00 00       	mov    $0x1f4,%edx
80101f9e:	c1 f8 08             	sar    $0x8,%eax
80101fa1:	ee                   	out    %al,(%dx)
80101fa2:	ba f5 01 00 00       	mov    $0x1f5,%edx
80101fa7:	89 f8                	mov    %edi,%eax
80101fa9:	ee                   	out    %al,(%dx)
  outb(0x1f5, (sector >> 16) & 0xff);
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
80101faa:	0f b6 46 04          	movzbl 0x4(%esi),%eax
80101fae:	ba f6 01 00 00       	mov    $0x1f6,%edx
80101fb3:	c1 e0 04             	shl    $0x4,%eax
80101fb6:	83 e0 10             	and    $0x10,%eax
80101fb9:	83 c8 e0             	or     $0xffffffe0,%eax
80101fbc:	ee                   	out    %al,(%dx)
  if(b->flags & B_DIRTY){
80101fbd:	f6 06 04             	testb  $0x4,(%esi)
80101fc0:	75 16                	jne    80101fd8 <idestart+0x98>
80101fc2:	b8 20 00 00 00       	mov    $0x20,%eax
80101fc7:	89 ca                	mov    %ecx,%edx
80101fc9:	ee                   	out    %al,(%dx)
    outb(0x1f7, write_cmd);
    outsl(0x1f0, b->data, BSIZE/4);
  } else {
    outb(0x1f7, read_cmd);
  }
}
80101fca:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101fcd:	5b                   	pop    %ebx
80101fce:	5e                   	pop    %esi
80101fcf:	5f                   	pop    %edi
80101fd0:	5d                   	pop    %ebp
80101fd1:	c3                   	ret    
80101fd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80101fd8:	b8 30 00 00 00       	mov    $0x30,%eax
80101fdd:	89 ca                	mov    %ecx,%edx
80101fdf:	ee                   	out    %al,(%dx)
  asm volatile("cld; rep outsl" :
80101fe0:	b9 80 00 00 00       	mov    $0x80,%ecx
    outsl(0x1f0, b->data, BSIZE/4);
80101fe5:	83 c6 5c             	add    $0x5c,%esi
80101fe8:	ba f0 01 00 00       	mov    $0x1f0,%edx
80101fed:	fc                   	cld    
80101fee:	f3 6f                	rep outsl %ds:(%esi),(%dx)
}
80101ff0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101ff3:	5b                   	pop    %ebx
80101ff4:	5e                   	pop    %esi
80101ff5:	5f                   	pop    %edi
80101ff6:	5d                   	pop    %ebp
80101ff7:	c3                   	ret    
    panic("incorrect blockno");
80101ff8:	83 ec 0c             	sub    $0xc,%esp
80101ffb:	68 d0 7f 10 80       	push   $0x80107fd0
80102000:	e8 8b e3 ff ff       	call   80100390 <panic>
    panic("idestart");
80102005:	83 ec 0c             	sub    $0xc,%esp
80102008:	68 c7 7f 10 80       	push   $0x80107fc7
8010200d:	e8 7e e3 ff ff       	call   80100390 <panic>
80102012:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102019:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102020 <ideinit>:
{
80102020:	55                   	push   %ebp
80102021:	89 e5                	mov    %esp,%ebp
80102023:	83 ec 10             	sub    $0x10,%esp
  initlock(&idelock, "ide");
80102026:	68 e2 7f 10 80       	push   $0x80107fe2
8010202b:	68 40 b8 10 80       	push   $0x8010b840
80102030:	e8 6b 27 00 00       	call   801047a0 <initlock>
  ioapicenable(IRQ_IDE, ncpu - 1);
80102035:	58                   	pop    %eax
80102036:	a1 c0 8e 11 80       	mov    0x80118ec0,%eax
8010203b:	5a                   	pop    %edx
8010203c:	83 e8 01             	sub    $0x1,%eax
8010203f:	50                   	push   %eax
80102040:	6a 0e                	push   $0xe
80102042:	e8 a9 02 00 00       	call   801022f0 <ioapicenable>
80102047:	83 c4 10             	add    $0x10,%esp
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010204a:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010204f:	90                   	nop
80102050:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102051:	83 e0 c0             	and    $0xffffffc0,%eax
80102054:	3c 40                	cmp    $0x40,%al
80102056:	75 f8                	jne    80102050 <ideinit+0x30>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102058:	b8 f0 ff ff ff       	mov    $0xfffffff0,%eax
8010205d:	ba f6 01 00 00       	mov    $0x1f6,%edx
80102062:	ee                   	out    %al,(%dx)
80102063:	b9 e8 03 00 00       	mov    $0x3e8,%ecx
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102068:	ba f7 01 00 00       	mov    $0x1f7,%edx
8010206d:	eb 06                	jmp    80102075 <ideinit+0x55>
8010206f:	90                   	nop
  for(i=0; i<1000; i++){
80102070:	83 e9 01             	sub    $0x1,%ecx
80102073:	74 0f                	je     80102084 <ideinit+0x64>
80102075:	ec                   	in     (%dx),%al
    if(inb(0x1f7) != 0){
80102076:	84 c0                	test   %al,%al
80102078:	74 f6                	je     80102070 <ideinit+0x50>
      havedisk1 = 1;
8010207a:	c7 05 20 b8 10 80 01 	movl   $0x1,0x8010b820
80102081:	00 00 00 
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102084:	b8 e0 ff ff ff       	mov    $0xffffffe0,%eax
80102089:	ba f6 01 00 00       	mov    $0x1f6,%edx
8010208e:	ee                   	out    %al,(%dx)
}
8010208f:	c9                   	leave  
80102090:	c3                   	ret    
80102091:	eb 0d                	jmp    801020a0 <ideintr>
80102093:	90                   	nop
80102094:	90                   	nop
80102095:	90                   	nop
80102096:	90                   	nop
80102097:	90                   	nop
80102098:	90                   	nop
80102099:	90                   	nop
8010209a:	90                   	nop
8010209b:	90                   	nop
8010209c:	90                   	nop
8010209d:	90                   	nop
8010209e:	90                   	nop
8010209f:	90                   	nop

801020a0 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
801020a0:	55                   	push   %ebp
801020a1:	89 e5                	mov    %esp,%ebp
801020a3:	57                   	push   %edi
801020a4:	56                   	push   %esi
801020a5:	53                   	push   %ebx
801020a6:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
801020a9:	68 40 b8 10 80       	push   $0x8010b840
801020ae:	e8 2d 28 00 00       	call   801048e0 <acquire>

  if((b = idequeue) == 0){
801020b3:	8b 1d 24 b8 10 80    	mov    0x8010b824,%ebx
801020b9:	83 c4 10             	add    $0x10,%esp
801020bc:	85 db                	test   %ebx,%ebx
801020be:	74 67                	je     80102127 <ideintr+0x87>
    release(&idelock);
    return;
  }
  idequeue = b->qnext;
801020c0:	8b 43 58             	mov    0x58(%ebx),%eax
801020c3:	a3 24 b8 10 80       	mov    %eax,0x8010b824

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801020c8:	8b 3b                	mov    (%ebx),%edi
801020ca:	f7 c7 04 00 00 00    	test   $0x4,%edi
801020d0:	75 31                	jne    80102103 <ideintr+0x63>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801020d2:	ba f7 01 00 00       	mov    $0x1f7,%edx
801020d7:	89 f6                	mov    %esi,%esi
801020d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801020e0:	ec                   	in     (%dx),%al
  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
801020e1:	89 c6                	mov    %eax,%esi
801020e3:	83 e6 c0             	and    $0xffffffc0,%esi
801020e6:	89 f1                	mov    %esi,%ecx
801020e8:	80 f9 40             	cmp    $0x40,%cl
801020eb:	75 f3                	jne    801020e0 <ideintr+0x40>
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
801020ed:	a8 21                	test   $0x21,%al
801020ef:	75 12                	jne    80102103 <ideintr+0x63>
    insl(0x1f0, b->data, BSIZE/4);
801020f1:	8d 7b 5c             	lea    0x5c(%ebx),%edi
  asm volatile("cld; rep insl" :
801020f4:	b9 80 00 00 00       	mov    $0x80,%ecx
801020f9:	ba f0 01 00 00       	mov    $0x1f0,%edx
801020fe:	fc                   	cld    
801020ff:	f3 6d                	rep insl (%dx),%es:(%edi)
80102101:	8b 3b                	mov    (%ebx),%edi

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
  b->flags &= ~B_DIRTY;
80102103:	83 e7 fb             	and    $0xfffffffb,%edi
  wakeup(b);
80102106:	83 ec 0c             	sub    $0xc,%esp
  b->flags &= ~B_DIRTY;
80102109:	89 f9                	mov    %edi,%ecx
8010210b:	83 c9 02             	or     $0x2,%ecx
8010210e:	89 0b                	mov    %ecx,(%ebx)
  wakeup(b);
80102110:	53                   	push   %ebx
80102111:	e8 9a 20 00 00       	call   801041b0 <wakeup>

  // Start disk on next buf in queue.
  if(idequeue != 0)
80102116:	a1 24 b8 10 80       	mov    0x8010b824,%eax
8010211b:	83 c4 10             	add    $0x10,%esp
8010211e:	85 c0                	test   %eax,%eax
80102120:	74 05                	je     80102127 <ideintr+0x87>
    idestart(idequeue);
80102122:	e8 19 fe ff ff       	call   80101f40 <idestart>
    release(&idelock);
80102127:	83 ec 0c             	sub    $0xc,%esp
8010212a:	68 40 b8 10 80       	push   $0x8010b840
8010212f:	e8 6c 28 00 00       	call   801049a0 <release>

  release(&idelock);
}
80102134:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102137:	5b                   	pop    %ebx
80102138:	5e                   	pop    %esi
80102139:	5f                   	pop    %edi
8010213a:	5d                   	pop    %ebp
8010213b:	c3                   	ret    
8010213c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102140 <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
80102140:	55                   	push   %ebp
80102141:	89 e5                	mov    %esp,%ebp
80102143:	53                   	push   %ebx
80102144:	83 ec 10             	sub    $0x10,%esp
80102147:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct buf **pp;

  if(!holdingsleep(&b->lock))
8010214a:	8d 43 0c             	lea    0xc(%ebx),%eax
8010214d:	50                   	push   %eax
8010214e:	e8 fd 25 00 00       	call   80104750 <holdingsleep>
80102153:	83 c4 10             	add    $0x10,%esp
80102156:	85 c0                	test   %eax,%eax
80102158:	0f 84 c6 00 00 00    	je     80102224 <iderw+0xe4>
    panic("iderw: buf not locked");
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
8010215e:	8b 03                	mov    (%ebx),%eax
80102160:	83 e0 06             	and    $0x6,%eax
80102163:	83 f8 02             	cmp    $0x2,%eax
80102166:	0f 84 ab 00 00 00    	je     80102217 <iderw+0xd7>
    panic("iderw: nothing to do");
  if(b->dev != 0 && !havedisk1)
8010216c:	8b 53 04             	mov    0x4(%ebx),%edx
8010216f:	85 d2                	test   %edx,%edx
80102171:	74 0d                	je     80102180 <iderw+0x40>
80102173:	a1 20 b8 10 80       	mov    0x8010b820,%eax
80102178:	85 c0                	test   %eax,%eax
8010217a:	0f 84 b1 00 00 00    	je     80102231 <iderw+0xf1>
    panic("iderw: ide disk 1 not present");

  acquire(&idelock);  //DOC:acquire-lock
80102180:	83 ec 0c             	sub    $0xc,%esp
80102183:	68 40 b8 10 80       	push   $0x8010b840
80102188:	e8 53 27 00 00       	call   801048e0 <acquire>

  // Append b to idequeue.
  b->qnext = 0;
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010218d:	8b 15 24 b8 10 80    	mov    0x8010b824,%edx
80102193:	83 c4 10             	add    $0x10,%esp
  b->qnext = 0;
80102196:	c7 43 58 00 00 00 00 	movl   $0x0,0x58(%ebx)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
8010219d:	85 d2                	test   %edx,%edx
8010219f:	75 09                	jne    801021aa <iderw+0x6a>
801021a1:	eb 6d                	jmp    80102210 <iderw+0xd0>
801021a3:	90                   	nop
801021a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801021a8:	89 c2                	mov    %eax,%edx
801021aa:	8b 42 58             	mov    0x58(%edx),%eax
801021ad:	85 c0                	test   %eax,%eax
801021af:	75 f7                	jne    801021a8 <iderw+0x68>
801021b1:	83 c2 58             	add    $0x58,%edx
    ;
  *pp = b;
801021b4:	89 1a                	mov    %ebx,(%edx)

  // Start disk if necessary.
  if(idequeue == b)
801021b6:	39 1d 24 b8 10 80    	cmp    %ebx,0x8010b824
801021bc:	74 42                	je     80102200 <iderw+0xc0>
    idestart(b);

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021be:	8b 03                	mov    (%ebx),%eax
801021c0:	83 e0 06             	and    $0x6,%eax
801021c3:	83 f8 02             	cmp    $0x2,%eax
801021c6:	74 23                	je     801021eb <iderw+0xab>
801021c8:	90                   	nop
801021c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    sleep(b, &idelock);
801021d0:	83 ec 08             	sub    $0x8,%esp
801021d3:	68 40 b8 10 80       	push   $0x8010b840
801021d8:	53                   	push   %ebx
801021d9:	e8 12 1e 00 00       	call   80103ff0 <sleep>
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
801021de:	8b 03                	mov    (%ebx),%eax
801021e0:	83 c4 10             	add    $0x10,%esp
801021e3:	83 e0 06             	and    $0x6,%eax
801021e6:	83 f8 02             	cmp    $0x2,%eax
801021e9:	75 e5                	jne    801021d0 <iderw+0x90>
  }


  release(&idelock);
801021eb:	c7 45 08 40 b8 10 80 	movl   $0x8010b840,0x8(%ebp)
}
801021f2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801021f5:	c9                   	leave  
  release(&idelock);
801021f6:	e9 a5 27 00 00       	jmp    801049a0 <release>
801021fb:	90                   	nop
801021fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    idestart(b);
80102200:	89 d8                	mov    %ebx,%eax
80102202:	e8 39 fd ff ff       	call   80101f40 <idestart>
80102207:	eb b5                	jmp    801021be <iderw+0x7e>
80102209:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
80102210:	ba 24 b8 10 80       	mov    $0x8010b824,%edx
80102215:	eb 9d                	jmp    801021b4 <iderw+0x74>
    panic("iderw: nothing to do");
80102217:	83 ec 0c             	sub    $0xc,%esp
8010221a:	68 fc 7f 10 80       	push   $0x80107ffc
8010221f:	e8 6c e1 ff ff       	call   80100390 <panic>
    panic("iderw: buf not locked");
80102224:	83 ec 0c             	sub    $0xc,%esp
80102227:	68 e6 7f 10 80       	push   $0x80107fe6
8010222c:	e8 5f e1 ff ff       	call   80100390 <panic>
    panic("iderw: ide disk 1 not present");
80102231:	83 ec 0c             	sub    $0xc,%esp
80102234:	68 11 80 10 80       	push   $0x80108011
80102239:	e8 52 e1 ff ff       	call   80100390 <panic>
8010223e:	66 90                	xchg   %ax,%ax

80102240 <ioapicinit>:
  ioapic->data = data;
}

void
ioapicinit(void)
{
80102240:	55                   	push   %ebp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102241:	c7 05 f4 87 11 80 00 	movl   $0xfec00000,0x801187f4
80102248:	00 c0 fe 
{
8010224b:	89 e5                	mov    %esp,%ebp
8010224d:	56                   	push   %esi
8010224e:	53                   	push   %ebx
  ioapic->reg = reg;
8010224f:	c7 05 00 00 c0 fe 01 	movl   $0x1,0xfec00000
80102256:	00 00 00 
  return ioapic->data;
80102259:	a1 f4 87 11 80       	mov    0x801187f4,%eax
8010225e:	8b 58 10             	mov    0x10(%eax),%ebx
  ioapic->reg = reg;
80102261:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  return ioapic->data;
80102267:	8b 0d f4 87 11 80    	mov    0x801187f4,%ecx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
  id = ioapicread(REG_ID) >> 24;
  if(id != ioapicid)
8010226d:	0f b6 15 20 89 11 80 	movzbl 0x80118920,%edx
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102274:	c1 eb 10             	shr    $0x10,%ebx
  return ioapic->data;
80102277:	8b 41 10             	mov    0x10(%ecx),%eax
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
8010227a:	0f b6 db             	movzbl %bl,%ebx
  id = ioapicread(REG_ID) >> 24;
8010227d:	c1 e8 18             	shr    $0x18,%eax
  if(id != ioapicid)
80102280:	39 c2                	cmp    %eax,%edx
80102282:	74 16                	je     8010229a <ioapicinit+0x5a>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102284:	83 ec 0c             	sub    $0xc,%esp
80102287:	68 30 80 10 80       	push   $0x80108030
8010228c:	e8 cf e3 ff ff       	call   80100660 <cprintf>
80102291:	8b 0d f4 87 11 80    	mov    0x801187f4,%ecx
80102297:	83 c4 10             	add    $0x10,%esp
8010229a:	83 c3 21             	add    $0x21,%ebx
{
8010229d:	ba 10 00 00 00       	mov    $0x10,%edx
801022a2:	b8 20 00 00 00       	mov    $0x20,%eax
801022a7:	89 f6                	mov    %esi,%esi
801022a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  ioapic->reg = reg;
801022b0:	89 11                	mov    %edx,(%ecx)
  ioapic->data = data;
801022b2:	8b 0d f4 87 11 80    	mov    0x801187f4,%ecx

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
801022b8:	89 c6                	mov    %eax,%esi
801022ba:	81 ce 00 00 01 00    	or     $0x10000,%esi
801022c0:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
801022c3:	89 71 10             	mov    %esi,0x10(%ecx)
801022c6:	8d 72 01             	lea    0x1(%edx),%esi
801022c9:	83 c2 02             	add    $0x2,%edx
  for(i = 0; i <= maxintr; i++){
801022cc:	39 d8                	cmp    %ebx,%eax
  ioapic->reg = reg;
801022ce:	89 31                	mov    %esi,(%ecx)
  ioapic->data = data;
801022d0:	8b 0d f4 87 11 80    	mov    0x801187f4,%ecx
801022d6:	c7 41 10 00 00 00 00 	movl   $0x0,0x10(%ecx)
  for(i = 0; i <= maxintr; i++){
801022dd:	75 d1                	jne    801022b0 <ioapicinit+0x70>
    ioapicwrite(REG_TABLE+2*i+1, 0);
  }
}
801022df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801022e2:	5b                   	pop    %ebx
801022e3:	5e                   	pop    %esi
801022e4:	5d                   	pop    %ebp
801022e5:	c3                   	ret    
801022e6:	8d 76 00             	lea    0x0(%esi),%esi
801022e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801022f0 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
801022f0:	55                   	push   %ebp
  ioapic->reg = reg;
801022f1:	8b 0d f4 87 11 80    	mov    0x801187f4,%ecx
{
801022f7:	89 e5                	mov    %esp,%ebp
801022f9:	8b 45 08             	mov    0x8(%ebp),%eax
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
801022fc:	8d 50 20             	lea    0x20(%eax),%edx
801022ff:	8d 44 00 10          	lea    0x10(%eax,%eax,1),%eax
  ioapic->reg = reg;
80102303:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102305:	8b 0d f4 87 11 80    	mov    0x801187f4,%ecx
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010230b:	83 c0 01             	add    $0x1,%eax
  ioapic->data = data;
8010230e:	89 51 10             	mov    %edx,0x10(%ecx)
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102311:	8b 55 0c             	mov    0xc(%ebp),%edx
  ioapic->reg = reg;
80102314:	89 01                	mov    %eax,(%ecx)
  ioapic->data = data;
80102316:	a1 f4 87 11 80       	mov    0x801187f4,%eax
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
8010231b:	c1 e2 18             	shl    $0x18,%edx
  ioapic->data = data;
8010231e:	89 50 10             	mov    %edx,0x10(%eax)
}
80102321:	5d                   	pop    %ebp
80102322:	c3                   	ret    
80102323:	66 90                	xchg   %ax,%ax
80102325:	66 90                	xchg   %ax,%ax
80102327:	66 90                	xchg   %ax,%ax
80102329:	66 90                	xchg   %ax,%ax
8010232b:	66 90                	xchg   %ax,%ax
8010232d:	66 90                	xchg   %ax,%ax
8010232f:	90                   	nop

80102330 <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102330:	55                   	push   %ebp
80102331:	89 e5                	mov    %esp,%ebp
80102333:	53                   	push   %ebx
80102334:	83 ec 04             	sub    $0x4,%esp
80102337:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
8010233a:	f7 c3 ff 0f 00 00    	test   $0xfff,%ebx
80102340:	75 70                	jne    801023b2 <kfree+0x82>
80102342:	81 fb 00 74 2f 80    	cmp    $0x802f7400,%ebx
80102348:	72 68                	jb     801023b2 <kfree+0x82>
8010234a:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80102350:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102355:	77 5b                	ja     801023b2 <kfree+0x82>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102357:	83 ec 04             	sub    $0x4,%esp
8010235a:	68 00 10 00 00       	push   $0x1000
8010235f:	6a 01                	push   $0x1
80102361:	53                   	push   %ebx
80102362:	e8 89 26 00 00       	call   801049f0 <memset>

  if(kmem.use_lock)
80102367:	8b 15 34 88 11 80    	mov    0x80118834,%edx
8010236d:	83 c4 10             	add    $0x10,%esp
80102370:	85 d2                	test   %edx,%edx
80102372:	75 2c                	jne    801023a0 <kfree+0x70>
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
80102374:	a1 38 88 11 80       	mov    0x80118838,%eax
80102379:	89 03                	mov    %eax,(%ebx)
  kmem.freelist = r;
  if(kmem.use_lock)
8010237b:	a1 34 88 11 80       	mov    0x80118834,%eax
  kmem.freelist = r;
80102380:	89 1d 38 88 11 80    	mov    %ebx,0x80118838
  if(kmem.use_lock)
80102386:	85 c0                	test   %eax,%eax
80102388:	75 06                	jne    80102390 <kfree+0x60>
    release(&kmem.lock);
}
8010238a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010238d:	c9                   	leave  
8010238e:	c3                   	ret    
8010238f:	90                   	nop
    release(&kmem.lock);
80102390:	c7 45 08 00 88 11 80 	movl   $0x80118800,0x8(%ebp)
}
80102397:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010239a:	c9                   	leave  
    release(&kmem.lock);
8010239b:	e9 00 26 00 00       	jmp    801049a0 <release>
    acquire(&kmem.lock);
801023a0:	83 ec 0c             	sub    $0xc,%esp
801023a3:	68 00 88 11 80       	push   $0x80118800
801023a8:	e8 33 25 00 00       	call   801048e0 <acquire>
801023ad:	83 c4 10             	add    $0x10,%esp
801023b0:	eb c2                	jmp    80102374 <kfree+0x44>
    panic("kfree");
801023b2:	83 ec 0c             	sub    $0xc,%esp
801023b5:	68 62 80 10 80       	push   $0x80108062
801023ba:	e8 d1 df ff ff       	call   80100390 <panic>
801023bf:	90                   	nop

801023c0 <freerange>:
{
801023c0:	55                   	push   %ebp
801023c1:	89 e5                	mov    %esp,%ebp
801023c3:	56                   	push   %esi
801023c4:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
801023c5:	8b 45 08             	mov    0x8(%ebp),%eax
{
801023c8:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
801023cb:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801023d1:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023d7:	81 c3 00 10 00 00    	add    $0x1000,%ebx
801023dd:	39 de                	cmp    %ebx,%esi
801023df:	72 23                	jb     80102404 <freerange+0x44>
801023e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801023e8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801023ee:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023f1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801023f7:	50                   	push   %eax
801023f8:	e8 33 ff ff ff       	call   80102330 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801023fd:	83 c4 10             	add    $0x10,%esp
80102400:	39 f3                	cmp    %esi,%ebx
80102402:	76 e4                	jbe    801023e8 <freerange+0x28>
}
80102404:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102407:	5b                   	pop    %ebx
80102408:	5e                   	pop    %esi
80102409:	5d                   	pop    %ebp
8010240a:	c3                   	ret    
8010240b:	90                   	nop
8010240c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102410 <kinit1>:
{
80102410:	55                   	push   %ebp
80102411:	89 e5                	mov    %esp,%ebp
80102413:	56                   	push   %esi
80102414:	53                   	push   %ebx
80102415:	8b 75 0c             	mov    0xc(%ebp),%esi
  initlock(&kmem.lock, "kmem");
80102418:	83 ec 08             	sub    $0x8,%esp
8010241b:	68 68 80 10 80       	push   $0x80108068
80102420:	68 00 88 11 80       	push   $0x80118800
80102425:	e8 76 23 00 00       	call   801047a0 <initlock>
  p = (char*)PGROUNDUP((uint)vstart);
8010242a:	8b 45 08             	mov    0x8(%ebp),%eax
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
8010242d:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102430:	c7 05 34 88 11 80 00 	movl   $0x0,0x80118834
80102437:	00 00 00 
  p = (char*)PGROUNDUP((uint)vstart);
8010243a:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102440:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102446:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010244c:	39 de                	cmp    %ebx,%esi
8010244e:	72 1c                	jb     8010246c <kinit1+0x5c>
    kfree(p);
80102450:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
80102456:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102459:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
8010245f:	50                   	push   %eax
80102460:	e8 cb fe ff ff       	call   80102330 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102465:	83 c4 10             	add    $0x10,%esp
80102468:	39 de                	cmp    %ebx,%esi
8010246a:	73 e4                	jae    80102450 <kinit1+0x40>
}
8010246c:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010246f:	5b                   	pop    %ebx
80102470:	5e                   	pop    %esi
80102471:	5d                   	pop    %ebp
80102472:	c3                   	ret    
80102473:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80102479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102480 <kinit2>:
{
80102480:	55                   	push   %ebp
80102481:	89 e5                	mov    %esp,%ebp
80102483:	56                   	push   %esi
80102484:	53                   	push   %ebx
  p = (char*)PGROUNDUP((uint)vstart);
80102485:	8b 45 08             	mov    0x8(%ebp),%eax
{
80102488:	8b 75 0c             	mov    0xc(%ebp),%esi
  p = (char*)PGROUNDUP((uint)vstart);
8010248b:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
80102491:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102497:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010249d:	39 de                	cmp    %ebx,%esi
8010249f:	72 23                	jb     801024c4 <kinit2+0x44>
801024a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    kfree(p);
801024a8:	8d 83 00 f0 ff ff    	lea    -0x1000(%ebx),%eax
801024ae:	83 ec 0c             	sub    $0xc,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024b1:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    kfree(p);
801024b7:	50                   	push   %eax
801024b8:	e8 73 fe ff ff       	call   80102330 <kfree>
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
801024bd:	83 c4 10             	add    $0x10,%esp
801024c0:	39 de                	cmp    %ebx,%esi
801024c2:	73 e4                	jae    801024a8 <kinit2+0x28>
  kmem.use_lock = 1;
801024c4:	c7 05 34 88 11 80 01 	movl   $0x1,0x80118834
801024cb:	00 00 00 
}
801024ce:	8d 65 f8             	lea    -0x8(%ebp),%esp
801024d1:	5b                   	pop    %ebx
801024d2:	5e                   	pop    %esi
801024d3:	5d                   	pop    %ebp
801024d4:	c3                   	ret    
801024d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801024d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801024e0 <kalloc>:
char*
kalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
801024e0:	a1 34 88 11 80       	mov    0x80118834,%eax
801024e5:	85 c0                	test   %eax,%eax
801024e7:	75 1f                	jne    80102508 <kalloc+0x28>
    acquire(&kmem.lock);
  r = kmem.freelist;
801024e9:	a1 38 88 11 80       	mov    0x80118838,%eax
  if(r)
801024ee:	85 c0                	test   %eax,%eax
801024f0:	74 0e                	je     80102500 <kalloc+0x20>
    kmem.freelist = r->next;
801024f2:	8b 10                	mov    (%eax),%edx
801024f4:	89 15 38 88 11 80    	mov    %edx,0x80118838
801024fa:	c3                   	ret    
801024fb:	90                   	nop
801024fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}
80102500:	f3 c3                	repz ret 
80102502:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
{
80102508:	55                   	push   %ebp
80102509:	89 e5                	mov    %esp,%ebp
8010250b:	83 ec 24             	sub    $0x24,%esp
    acquire(&kmem.lock);
8010250e:	68 00 88 11 80       	push   $0x80118800
80102513:	e8 c8 23 00 00       	call   801048e0 <acquire>
  r = kmem.freelist;
80102518:	a1 38 88 11 80       	mov    0x80118838,%eax
  if(r)
8010251d:	83 c4 10             	add    $0x10,%esp
80102520:	8b 15 34 88 11 80    	mov    0x80118834,%edx
80102526:	85 c0                	test   %eax,%eax
80102528:	74 08                	je     80102532 <kalloc+0x52>
    kmem.freelist = r->next;
8010252a:	8b 08                	mov    (%eax),%ecx
8010252c:	89 0d 38 88 11 80    	mov    %ecx,0x80118838
  if(kmem.use_lock)
80102532:	85 d2                	test   %edx,%edx
80102534:	74 16                	je     8010254c <kalloc+0x6c>
    release(&kmem.lock);
80102536:	83 ec 0c             	sub    $0xc,%esp
80102539:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010253c:	68 00 88 11 80       	push   $0x80118800
80102541:	e8 5a 24 00 00       	call   801049a0 <release>
  return (char*)r;
80102546:	8b 45 f4             	mov    -0xc(%ebp),%eax
    release(&kmem.lock);
80102549:	83 c4 10             	add    $0x10,%esp
}
8010254c:	c9                   	leave  
8010254d:	c3                   	ret    
8010254e:	66 90                	xchg   %ax,%ax

80102550 <kbdgetc>:
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102550:	ba 64 00 00 00       	mov    $0x64,%edx
80102555:	ec                   	in     (%dx),%al
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
  if((st & KBS_DIB) == 0)
80102556:	a8 01                	test   $0x1,%al
80102558:	0f 84 c2 00 00 00    	je     80102620 <kbdgetc+0xd0>
8010255e:	ba 60 00 00 00       	mov    $0x60,%edx
80102563:	ec                   	in     (%dx),%al
    return -1;
  data = inb(KBDATAP);
80102564:	0f b6 d0             	movzbl %al,%edx
80102567:	8b 0d 74 b8 10 80    	mov    0x8010b874,%ecx

  if(data == 0xE0){
8010256d:	81 fa e0 00 00 00    	cmp    $0xe0,%edx
80102573:	0f 84 7f 00 00 00    	je     801025f8 <kbdgetc+0xa8>
{
80102579:	55                   	push   %ebp
8010257a:	89 e5                	mov    %esp,%ebp
8010257c:	53                   	push   %ebx
8010257d:	89 cb                	mov    %ecx,%ebx
8010257f:	83 e3 40             	and    $0x40,%ebx
    shift |= E0ESC;
    return 0;
  } else if(data & 0x80){
80102582:	84 c0                	test   %al,%al
80102584:	78 4a                	js     801025d0 <kbdgetc+0x80>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
    shift &= ~(shiftcode[data] | E0ESC);
    return 0;
  } else if(shift & E0ESC){
80102586:	85 db                	test   %ebx,%ebx
80102588:	74 09                	je     80102593 <kbdgetc+0x43>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
8010258a:	83 c8 80             	or     $0xffffff80,%eax
    shift &= ~E0ESC;
8010258d:	83 e1 bf             	and    $0xffffffbf,%ecx
    data |= 0x80;
80102590:	0f b6 d0             	movzbl %al,%edx
  }

  shift |= shiftcode[data];
80102593:	0f b6 82 a0 81 10 80 	movzbl -0x7fef7e60(%edx),%eax
8010259a:	09 c1                	or     %eax,%ecx
  shift ^= togglecode[data];
8010259c:	0f b6 82 a0 80 10 80 	movzbl -0x7fef7f60(%edx),%eax
801025a3:	31 c1                	xor    %eax,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025a5:	89 c8                	mov    %ecx,%eax
  shift ^= togglecode[data];
801025a7:	89 0d 74 b8 10 80    	mov    %ecx,0x8010b874
  c = charcode[shift & (CTL | SHIFT)][data];
801025ad:	83 e0 03             	and    $0x3,%eax
  if(shift & CAPSLOCK){
801025b0:	83 e1 08             	and    $0x8,%ecx
  c = charcode[shift & (CTL | SHIFT)][data];
801025b3:	8b 04 85 80 80 10 80 	mov    -0x7fef7f80(,%eax,4),%eax
801025ba:	0f b6 04 10          	movzbl (%eax,%edx,1),%eax
  if(shift & CAPSLOCK){
801025be:	74 31                	je     801025f1 <kbdgetc+0xa1>
    if('a' <= c && c <= 'z')
801025c0:	8d 50 9f             	lea    -0x61(%eax),%edx
801025c3:	83 fa 19             	cmp    $0x19,%edx
801025c6:	77 40                	ja     80102608 <kbdgetc+0xb8>
      c += 'A' - 'a';
801025c8:	83 e8 20             	sub    $0x20,%eax
    else if('A' <= c && c <= 'Z')
      c += 'a' - 'A';
  }
  return c;
}
801025cb:	5b                   	pop    %ebx
801025cc:	5d                   	pop    %ebp
801025cd:	c3                   	ret    
801025ce:	66 90                	xchg   %ax,%ax
    data = (shift & E0ESC ? data : data & 0x7F);
801025d0:	83 e0 7f             	and    $0x7f,%eax
801025d3:	85 db                	test   %ebx,%ebx
801025d5:	0f 44 d0             	cmove  %eax,%edx
    shift &= ~(shiftcode[data] | E0ESC);
801025d8:	0f b6 82 a0 81 10 80 	movzbl -0x7fef7e60(%edx),%eax
801025df:	83 c8 40             	or     $0x40,%eax
801025e2:	0f b6 c0             	movzbl %al,%eax
801025e5:	f7 d0                	not    %eax
801025e7:	21 c1                	and    %eax,%ecx
    return 0;
801025e9:	31 c0                	xor    %eax,%eax
    shift &= ~(shiftcode[data] | E0ESC);
801025eb:	89 0d 74 b8 10 80    	mov    %ecx,0x8010b874
}
801025f1:	5b                   	pop    %ebx
801025f2:	5d                   	pop    %ebp
801025f3:	c3                   	ret    
801025f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    shift |= E0ESC;
801025f8:	83 c9 40             	or     $0x40,%ecx
    return 0;
801025fb:	31 c0                	xor    %eax,%eax
    shift |= E0ESC;
801025fd:	89 0d 74 b8 10 80    	mov    %ecx,0x8010b874
    return 0;
80102603:	c3                   	ret    
80102604:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    else if('A' <= c && c <= 'Z')
80102608:	8d 48 bf             	lea    -0x41(%eax),%ecx
      c += 'a' - 'A';
8010260b:	8d 50 20             	lea    0x20(%eax),%edx
}
8010260e:	5b                   	pop    %ebx
      c += 'a' - 'A';
8010260f:	83 f9 1a             	cmp    $0x1a,%ecx
80102612:	0f 42 c2             	cmovb  %edx,%eax
}
80102615:	5d                   	pop    %ebp
80102616:	c3                   	ret    
80102617:	89 f6                	mov    %esi,%esi
80102619:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80102620:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80102625:	c3                   	ret    
80102626:	8d 76 00             	lea    0x0(%esi),%esi
80102629:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102630 <kbdintr>:

void
kbdintr(void)
{
80102630:	55                   	push   %ebp
80102631:	89 e5                	mov    %esp,%ebp
80102633:	83 ec 14             	sub    $0x14,%esp
  consoleintr(kbdgetc);
80102636:	68 50 25 10 80       	push   $0x80102550
8010263b:	e8 d0 e1 ff ff       	call   80100810 <consoleintr>
}
80102640:	83 c4 10             	add    $0x10,%esp
80102643:	c9                   	leave  
80102644:	c3                   	ret    
80102645:	66 90                	xchg   %ax,%ax
80102647:	66 90                	xchg   %ax,%ax
80102649:	66 90                	xchg   %ax,%ax
8010264b:	66 90                	xchg   %ax,%ax
8010264d:	66 90                	xchg   %ax,%ax
8010264f:	90                   	nop

80102650 <lapicinit>:
}

void
lapicinit(void)
{
  if(!lapic)
80102650:	a1 3c 88 11 80       	mov    0x8011883c,%eax
{
80102655:	55                   	push   %ebp
80102656:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102658:	85 c0                	test   %eax,%eax
8010265a:	0f 84 c8 00 00 00    	je     80102728 <lapicinit+0xd8>
  lapic[index] = value;
80102660:	c7 80 f0 00 00 00 3f 	movl   $0x13f,0xf0(%eax)
80102667:	01 00 00 
  lapic[ID];  // wait for write to finish, by reading
8010266a:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010266d:	c7 80 e0 03 00 00 0b 	movl   $0xb,0x3e0(%eax)
80102674:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102677:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
8010267a:	c7 80 20 03 00 00 20 	movl   $0x20020,0x320(%eax)
80102681:	00 02 00 
  lapic[ID];  // wait for write to finish, by reading
80102684:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102687:	c7 80 80 03 00 00 80 	movl   $0x989680,0x380(%eax)
8010268e:	96 98 00 
  lapic[ID];  // wait for write to finish, by reading
80102691:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102694:	c7 80 50 03 00 00 00 	movl   $0x10000,0x350(%eax)
8010269b:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010269e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026a1:	c7 80 60 03 00 00 00 	movl   $0x10000,0x360(%eax)
801026a8:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
801026ab:	8b 50 20             	mov    0x20(%eax),%edx
  lapicw(LINT0, MASKED);
  lapicw(LINT1, MASKED);

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
801026ae:	8b 50 30             	mov    0x30(%eax),%edx
801026b1:	c1 ea 10             	shr    $0x10,%edx
801026b4:	80 fa 03             	cmp    $0x3,%dl
801026b7:	77 77                	ja     80102730 <lapicinit+0xe0>
  lapic[index] = value;
801026b9:	c7 80 70 03 00 00 33 	movl   $0x33,0x370(%eax)
801026c0:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026c3:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026c6:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026cd:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026d0:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026d3:	c7 80 80 02 00 00 00 	movl   $0x0,0x280(%eax)
801026da:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026dd:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026e0:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
801026e7:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026ea:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026ed:	c7 80 10 03 00 00 00 	movl   $0x0,0x310(%eax)
801026f4:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
801026f7:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
801026fa:	c7 80 00 03 00 00 00 	movl   $0x88500,0x300(%eax)
80102701:	85 08 00 
  lapic[ID];  // wait for write to finish, by reading
80102704:	8b 50 20             	mov    0x20(%eax),%edx
80102707:	89 f6                	mov    %esi,%esi
80102709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  lapicw(EOI, 0);

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
  lapicw(ICRLO, BCAST | INIT | LEVEL);
  while(lapic[ICRLO] & DELIVS)
80102710:	8b 90 00 03 00 00    	mov    0x300(%eax),%edx
80102716:	80 e6 10             	and    $0x10,%dh
80102719:	75 f5                	jne    80102710 <lapicinit+0xc0>
  lapic[index] = value;
8010271b:	c7 80 80 00 00 00 00 	movl   $0x0,0x80(%eax)
80102722:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102725:	8b 40 20             	mov    0x20(%eax),%eax
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
}
80102728:	5d                   	pop    %ebp
80102729:	c3                   	ret    
8010272a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  lapic[index] = value;
80102730:	c7 80 40 03 00 00 00 	movl   $0x10000,0x340(%eax)
80102737:	00 01 00 
  lapic[ID];  // wait for write to finish, by reading
8010273a:	8b 50 20             	mov    0x20(%eax),%edx
8010273d:	e9 77 ff ff ff       	jmp    801026b9 <lapicinit+0x69>
80102742:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102749:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102750 <lapicid>:

int
lapicid(void)
{
  if (!lapic)
80102750:	8b 15 3c 88 11 80    	mov    0x8011883c,%edx
{
80102756:	55                   	push   %ebp
80102757:	31 c0                	xor    %eax,%eax
80102759:	89 e5                	mov    %esp,%ebp
  if (!lapic)
8010275b:	85 d2                	test   %edx,%edx
8010275d:	74 06                	je     80102765 <lapicid+0x15>
    return 0;
  return lapic[ID] >> 24;
8010275f:	8b 42 20             	mov    0x20(%edx),%eax
80102762:	c1 e8 18             	shr    $0x18,%eax
}
80102765:	5d                   	pop    %ebp
80102766:	c3                   	ret    
80102767:	89 f6                	mov    %esi,%esi
80102769:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102770 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
  if(lapic)
80102770:	a1 3c 88 11 80       	mov    0x8011883c,%eax
{
80102775:	55                   	push   %ebp
80102776:	89 e5                	mov    %esp,%ebp
  if(lapic)
80102778:	85 c0                	test   %eax,%eax
8010277a:	74 0d                	je     80102789 <lapiceoi+0x19>
  lapic[index] = value;
8010277c:	c7 80 b0 00 00 00 00 	movl   $0x0,0xb0(%eax)
80102783:	00 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102786:	8b 40 20             	mov    0x20(%eax),%eax
    lapicw(EOI, 0);
}
80102789:	5d                   	pop    %ebp
8010278a:	c3                   	ret    
8010278b:	90                   	nop
8010278c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102790 <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
80102790:	55                   	push   %ebp
80102791:	89 e5                	mov    %esp,%ebp
}
80102793:	5d                   	pop    %ebp
80102794:	c3                   	ret    
80102795:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801027a0 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
801027a0:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801027a1:	b8 0f 00 00 00       	mov    $0xf,%eax
801027a6:	ba 70 00 00 00       	mov    $0x70,%edx
801027ab:	89 e5                	mov    %esp,%ebp
801027ad:	53                   	push   %ebx
801027ae:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801027b1:	8b 5d 08             	mov    0x8(%ebp),%ebx
801027b4:	ee                   	out    %al,(%dx)
801027b5:	b8 0a 00 00 00       	mov    $0xa,%eax
801027ba:	ba 71 00 00 00       	mov    $0x71,%edx
801027bf:	ee                   	out    %al,(%dx)
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
  outb(CMOS_PORT+1, 0x0A);
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
  wrv[0] = 0;
801027c0:	31 c0                	xor    %eax,%eax
  wrv[1] = addr >> 4;

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
801027c2:	c1 e3 18             	shl    $0x18,%ebx
  wrv[0] = 0;
801027c5:	66 a3 67 04 00 80    	mov    %ax,0x80000467
  wrv[1] = addr >> 4;
801027cb:	89 c8                	mov    %ecx,%eax
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
    lapicw(ICRHI, apicid<<24);
    lapicw(ICRLO, STARTUP | (addr>>12));
801027cd:	c1 e9 0c             	shr    $0xc,%ecx
  wrv[1] = addr >> 4;
801027d0:	c1 e8 04             	shr    $0x4,%eax
  lapicw(ICRHI, apicid<<24);
801027d3:	89 da                	mov    %ebx,%edx
    lapicw(ICRLO, STARTUP | (addr>>12));
801027d5:	80 cd 06             	or     $0x6,%ch
  wrv[1] = addr >> 4;
801027d8:	66 a3 69 04 00 80    	mov    %ax,0x80000469
  lapic[index] = value;
801027de:	a1 3c 88 11 80       	mov    0x8011883c,%eax
801027e3:	89 98 10 03 00 00    	mov    %ebx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
801027e9:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027ec:	c7 80 00 03 00 00 00 	movl   $0xc500,0x300(%eax)
801027f3:	c5 00 00 
  lapic[ID];  // wait for write to finish, by reading
801027f6:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
801027f9:	c7 80 00 03 00 00 00 	movl   $0x8500,0x300(%eax)
80102800:	85 00 00 
  lapic[ID];  // wait for write to finish, by reading
80102803:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102806:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010280c:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
8010280f:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102815:	8b 58 20             	mov    0x20(%eax),%ebx
  lapic[index] = value;
80102818:	89 90 10 03 00 00    	mov    %edx,0x310(%eax)
  lapic[ID];  // wait for write to finish, by reading
8010281e:	8b 50 20             	mov    0x20(%eax),%edx
  lapic[index] = value;
80102821:	89 88 00 03 00 00    	mov    %ecx,0x300(%eax)
  lapic[ID];  // wait for write to finish, by reading
80102827:	8b 40 20             	mov    0x20(%eax),%eax
    microdelay(200);
  }
}
8010282a:	5b                   	pop    %ebx
8010282b:	5d                   	pop    %ebp
8010282c:	c3                   	ret    
8010282d:	8d 76 00             	lea    0x0(%esi),%esi

80102830 <cmostime>:
}

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
80102830:	55                   	push   %ebp
80102831:	b8 0b 00 00 00       	mov    $0xb,%eax
80102836:	ba 70 00 00 00       	mov    $0x70,%edx
8010283b:	89 e5                	mov    %esp,%ebp
8010283d:	57                   	push   %edi
8010283e:	56                   	push   %esi
8010283f:	53                   	push   %ebx
80102840:	83 ec 4c             	sub    $0x4c,%esp
80102843:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102844:	ba 71 00 00 00       	mov    $0x71,%edx
80102849:	ec                   	in     (%dx),%al
8010284a:	83 e0 04             	and    $0x4,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010284d:	bb 70 00 00 00       	mov    $0x70,%ebx
80102852:	88 45 b3             	mov    %al,-0x4d(%ebp)
80102855:	8d 76 00             	lea    0x0(%esi),%esi
80102858:	31 c0                	xor    %eax,%eax
8010285a:	89 da                	mov    %ebx,%edx
8010285c:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010285d:	b9 71 00 00 00       	mov    $0x71,%ecx
80102862:	89 ca                	mov    %ecx,%edx
80102864:	ec                   	in     (%dx),%al
80102865:	88 45 b7             	mov    %al,-0x49(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102868:	89 da                	mov    %ebx,%edx
8010286a:	b8 02 00 00 00       	mov    $0x2,%eax
8010286f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102870:	89 ca                	mov    %ecx,%edx
80102872:	ec                   	in     (%dx),%al
80102873:	88 45 b6             	mov    %al,-0x4a(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102876:	89 da                	mov    %ebx,%edx
80102878:	b8 04 00 00 00       	mov    $0x4,%eax
8010287d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010287e:	89 ca                	mov    %ecx,%edx
80102880:	ec                   	in     (%dx),%al
80102881:	88 45 b5             	mov    %al,-0x4b(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102884:	89 da                	mov    %ebx,%edx
80102886:	b8 07 00 00 00       	mov    $0x7,%eax
8010288b:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010288c:	89 ca                	mov    %ecx,%edx
8010288e:	ec                   	in     (%dx),%al
8010288f:	88 45 b4             	mov    %al,-0x4c(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102892:	89 da                	mov    %ebx,%edx
80102894:	b8 08 00 00 00       	mov    $0x8,%eax
80102899:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010289a:	89 ca                	mov    %ecx,%edx
8010289c:	ec                   	in     (%dx),%al
8010289d:	89 c7                	mov    %eax,%edi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010289f:	89 da                	mov    %ebx,%edx
801028a1:	b8 09 00 00 00       	mov    $0x9,%eax
801028a6:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028a7:	89 ca                	mov    %ecx,%edx
801028a9:	ec                   	in     (%dx),%al
801028aa:	89 c6                	mov    %eax,%esi
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028ac:	89 da                	mov    %ebx,%edx
801028ae:	b8 0a 00 00 00       	mov    $0xa,%eax
801028b3:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028b4:	89 ca                	mov    %ecx,%edx
801028b6:	ec                   	in     (%dx),%al
  bcd = (sb & (1 << 2)) == 0;

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801028b7:	84 c0                	test   %al,%al
801028b9:	78 9d                	js     80102858 <cmostime+0x28>
  return inb(CMOS_RETURN);
801028bb:	0f b6 45 b7          	movzbl -0x49(%ebp),%eax
801028bf:	89 fa                	mov    %edi,%edx
801028c1:	0f b6 fa             	movzbl %dl,%edi
801028c4:	89 f2                	mov    %esi,%edx
801028c6:	0f b6 f2             	movzbl %dl,%esi
801028c9:	89 7d c8             	mov    %edi,-0x38(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028cc:	89 da                	mov    %ebx,%edx
801028ce:	89 75 cc             	mov    %esi,-0x34(%ebp)
801028d1:	89 45 b8             	mov    %eax,-0x48(%ebp)
801028d4:	0f b6 45 b6          	movzbl -0x4a(%ebp),%eax
801028d8:	89 45 bc             	mov    %eax,-0x44(%ebp)
801028db:	0f b6 45 b5          	movzbl -0x4b(%ebp),%eax
801028df:	89 45 c0             	mov    %eax,-0x40(%ebp)
801028e2:	0f b6 45 b4          	movzbl -0x4c(%ebp),%eax
801028e6:	89 45 c4             	mov    %eax,-0x3c(%ebp)
801028e9:	31 c0                	xor    %eax,%eax
801028eb:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028ec:	89 ca                	mov    %ecx,%edx
801028ee:	ec                   	in     (%dx),%al
801028ef:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801028f2:	89 da                	mov    %ebx,%edx
801028f4:	89 45 d0             	mov    %eax,-0x30(%ebp)
801028f7:	b8 02 00 00 00       	mov    $0x2,%eax
801028fc:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801028fd:	89 ca                	mov    %ecx,%edx
801028ff:	ec                   	in     (%dx),%al
80102900:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102903:	89 da                	mov    %ebx,%edx
80102905:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80102908:	b8 04 00 00 00       	mov    $0x4,%eax
8010290d:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010290e:	89 ca                	mov    %ecx,%edx
80102910:	ec                   	in     (%dx),%al
80102911:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102914:	89 da                	mov    %ebx,%edx
80102916:	89 45 d8             	mov    %eax,-0x28(%ebp)
80102919:	b8 07 00 00 00       	mov    $0x7,%eax
8010291e:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010291f:	89 ca                	mov    %ecx,%edx
80102921:	ec                   	in     (%dx),%al
80102922:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102925:	89 da                	mov    %ebx,%edx
80102927:	89 45 dc             	mov    %eax,-0x24(%ebp)
8010292a:	b8 08 00 00 00       	mov    $0x8,%eax
8010292f:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102930:	89 ca                	mov    %ecx,%edx
80102932:	ec                   	in     (%dx),%al
80102933:	0f b6 c0             	movzbl %al,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102936:	89 da                	mov    %ebx,%edx
80102938:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010293b:	b8 09 00 00 00       	mov    $0x9,%eax
80102940:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102941:	89 ca                	mov    %ecx,%edx
80102943:	ec                   	in     (%dx),%al
80102944:	0f b6 c0             	movzbl %al,%eax
        continue;
    fill_rtcdate(&t2);
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
80102947:	83 ec 04             	sub    $0x4,%esp
  return inb(CMOS_RETURN);
8010294a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
8010294d:	8d 45 d0             	lea    -0x30(%ebp),%eax
80102950:	6a 18                	push   $0x18
80102952:	50                   	push   %eax
80102953:	8d 45 b8             	lea    -0x48(%ebp),%eax
80102956:	50                   	push   %eax
80102957:	e8 e4 20 00 00       	call   80104a40 <memcmp>
8010295c:	83 c4 10             	add    $0x10,%esp
8010295f:	85 c0                	test   %eax,%eax
80102961:	0f 85 f1 fe ff ff    	jne    80102858 <cmostime+0x28>
      break;
  }

  // convert
  if(bcd) {
80102967:	80 7d b3 00          	cmpb   $0x0,-0x4d(%ebp)
8010296b:	75 78                	jne    801029e5 <cmostime+0x1b5>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
8010296d:	8b 45 b8             	mov    -0x48(%ebp),%eax
80102970:	89 c2                	mov    %eax,%edx
80102972:	83 e0 0f             	and    $0xf,%eax
80102975:	c1 ea 04             	shr    $0x4,%edx
80102978:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010297b:	8d 04 50             	lea    (%eax,%edx,2),%eax
8010297e:	89 45 b8             	mov    %eax,-0x48(%ebp)
    CONV(minute);
80102981:	8b 45 bc             	mov    -0x44(%ebp),%eax
80102984:	89 c2                	mov    %eax,%edx
80102986:	83 e0 0f             	and    $0xf,%eax
80102989:	c1 ea 04             	shr    $0x4,%edx
8010298c:	8d 14 92             	lea    (%edx,%edx,4),%edx
8010298f:	8d 04 50             	lea    (%eax,%edx,2),%eax
80102992:	89 45 bc             	mov    %eax,-0x44(%ebp)
    CONV(hour  );
80102995:	8b 45 c0             	mov    -0x40(%ebp),%eax
80102998:	89 c2                	mov    %eax,%edx
8010299a:	83 e0 0f             	and    $0xf,%eax
8010299d:	c1 ea 04             	shr    $0x4,%edx
801029a0:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029a3:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029a6:	89 45 c0             	mov    %eax,-0x40(%ebp)
    CONV(day   );
801029a9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029ac:	89 c2                	mov    %eax,%edx
801029ae:	83 e0 0f             	and    $0xf,%eax
801029b1:	c1 ea 04             	shr    $0x4,%edx
801029b4:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029b7:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029ba:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    CONV(month );
801029bd:	8b 45 c8             	mov    -0x38(%ebp),%eax
801029c0:	89 c2                	mov    %eax,%edx
801029c2:	83 e0 0f             	and    $0xf,%eax
801029c5:	c1 ea 04             	shr    $0x4,%edx
801029c8:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029cb:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029ce:	89 45 c8             	mov    %eax,-0x38(%ebp)
    CONV(year  );
801029d1:	8b 45 cc             	mov    -0x34(%ebp),%eax
801029d4:	89 c2                	mov    %eax,%edx
801029d6:	83 e0 0f             	and    $0xf,%eax
801029d9:	c1 ea 04             	shr    $0x4,%edx
801029dc:	8d 14 92             	lea    (%edx,%edx,4),%edx
801029df:	8d 04 50             	lea    (%eax,%edx,2),%eax
801029e2:	89 45 cc             	mov    %eax,-0x34(%ebp)
#undef     CONV
  }

  *r = t1;
801029e5:	8b 75 08             	mov    0x8(%ebp),%esi
801029e8:	8b 45 b8             	mov    -0x48(%ebp),%eax
801029eb:	89 06                	mov    %eax,(%esi)
801029ed:	8b 45 bc             	mov    -0x44(%ebp),%eax
801029f0:	89 46 04             	mov    %eax,0x4(%esi)
801029f3:	8b 45 c0             	mov    -0x40(%ebp),%eax
801029f6:	89 46 08             	mov    %eax,0x8(%esi)
801029f9:	8b 45 c4             	mov    -0x3c(%ebp),%eax
801029fc:	89 46 0c             	mov    %eax,0xc(%esi)
801029ff:	8b 45 c8             	mov    -0x38(%ebp),%eax
80102a02:	89 46 10             	mov    %eax,0x10(%esi)
80102a05:	8b 45 cc             	mov    -0x34(%ebp),%eax
80102a08:	89 46 14             	mov    %eax,0x14(%esi)
  r->year += 2000;
80102a0b:	81 46 14 d0 07 00 00 	addl   $0x7d0,0x14(%esi)
}
80102a12:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102a15:	5b                   	pop    %ebx
80102a16:	5e                   	pop    %esi
80102a17:	5f                   	pop    %edi
80102a18:	5d                   	pop    %ebp
80102a19:	c3                   	ret    
80102a1a:	66 90                	xchg   %ax,%ax
80102a1c:	66 90                	xchg   %ax,%ax
80102a1e:	66 90                	xchg   %ax,%ax

80102a20 <install_trans>:
static void
install_trans(void)
{
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80102a20:	8b 0d 88 88 11 80    	mov    0x80118888,%ecx
80102a26:	85 c9                	test   %ecx,%ecx
80102a28:	0f 8e 8a 00 00 00    	jle    80102ab8 <install_trans+0x98>
{
80102a2e:	55                   	push   %ebp
80102a2f:	89 e5                	mov    %esp,%ebp
80102a31:	57                   	push   %edi
80102a32:	56                   	push   %esi
80102a33:	53                   	push   %ebx
  for (tail = 0; tail < log.lh.n; tail++) {
80102a34:	31 db                	xor    %ebx,%ebx
{
80102a36:	83 ec 0c             	sub    $0xc,%esp
80102a39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80102a40:	a1 74 88 11 80       	mov    0x80118874,%eax
80102a45:	83 ec 08             	sub    $0x8,%esp
80102a48:	01 d8                	add    %ebx,%eax
80102a4a:	83 c0 01             	add    $0x1,%eax
80102a4d:	50                   	push   %eax
80102a4e:	ff 35 84 88 11 80    	pushl  0x80118884
80102a54:	e8 77 d6 ff ff       	call   801000d0 <bread>
80102a59:	89 c7                	mov    %eax,%edi
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a5b:	58                   	pop    %eax
80102a5c:	5a                   	pop    %edx
80102a5d:	ff 34 9d 8c 88 11 80 	pushl  -0x7fee7774(,%ebx,4)
80102a64:	ff 35 84 88 11 80    	pushl  0x80118884
  for (tail = 0; tail < log.lh.n; tail++) {
80102a6a:	83 c3 01             	add    $0x1,%ebx
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80102a6d:	e8 5e d6 ff ff       	call   801000d0 <bread>
80102a72:	89 c6                	mov    %eax,%esi
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
80102a74:	8d 47 5c             	lea    0x5c(%edi),%eax
80102a77:	83 c4 0c             	add    $0xc,%esp
80102a7a:	68 00 02 00 00       	push   $0x200
80102a7f:	50                   	push   %eax
80102a80:	8d 46 5c             	lea    0x5c(%esi),%eax
80102a83:	50                   	push   %eax
80102a84:	e8 17 20 00 00       	call   80104aa0 <memmove>
    bwrite(dbuf);  // write dst to disk
80102a89:	89 34 24             	mov    %esi,(%esp)
80102a8c:	e8 0f d7 ff ff       	call   801001a0 <bwrite>
    brelse(lbuf);
80102a91:	89 3c 24             	mov    %edi,(%esp)
80102a94:	e8 47 d7 ff ff       	call   801001e0 <brelse>
    brelse(dbuf);
80102a99:	89 34 24             	mov    %esi,(%esp)
80102a9c:	e8 3f d7 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102aa1:	83 c4 10             	add    $0x10,%esp
80102aa4:	39 1d 88 88 11 80    	cmp    %ebx,0x80118888
80102aaa:	7f 94                	jg     80102a40 <install_trans+0x20>
  }
}
80102aac:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102aaf:	5b                   	pop    %ebx
80102ab0:	5e                   	pop    %esi
80102ab1:	5f                   	pop    %edi
80102ab2:	5d                   	pop    %ebp
80102ab3:	c3                   	ret    
80102ab4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80102ab8:	f3 c3                	repz ret 
80102aba:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80102ac0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
80102ac0:	55                   	push   %ebp
80102ac1:	89 e5                	mov    %esp,%ebp
80102ac3:	56                   	push   %esi
80102ac4:	53                   	push   %ebx
  struct buf *buf = bread(log.dev, log.start);
80102ac5:	83 ec 08             	sub    $0x8,%esp
80102ac8:	ff 35 74 88 11 80    	pushl  0x80118874
80102ace:	ff 35 84 88 11 80    	pushl  0x80118884
80102ad4:	e8 f7 d5 ff ff       	call   801000d0 <bread>
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
80102ad9:	8b 1d 88 88 11 80    	mov    0x80118888,%ebx
  for (i = 0; i < log.lh.n; i++) {
80102adf:	83 c4 10             	add    $0x10,%esp
  struct buf *buf = bread(log.dev, log.start);
80102ae2:	89 c6                	mov    %eax,%esi
  for (i = 0; i < log.lh.n; i++) {
80102ae4:	85 db                	test   %ebx,%ebx
  hb->n = log.lh.n;
80102ae6:	89 58 5c             	mov    %ebx,0x5c(%eax)
  for (i = 0; i < log.lh.n; i++) {
80102ae9:	7e 16                	jle    80102b01 <write_head+0x41>
80102aeb:	c1 e3 02             	shl    $0x2,%ebx
80102aee:	31 d2                	xor    %edx,%edx
    hb->block[i] = log.lh.block[i];
80102af0:	8b 8a 8c 88 11 80    	mov    -0x7fee7774(%edx),%ecx
80102af6:	89 4c 16 60          	mov    %ecx,0x60(%esi,%edx,1)
80102afa:	83 c2 04             	add    $0x4,%edx
  for (i = 0; i < log.lh.n; i++) {
80102afd:	39 da                	cmp    %ebx,%edx
80102aff:	75 ef                	jne    80102af0 <write_head+0x30>
  }
  bwrite(buf);
80102b01:	83 ec 0c             	sub    $0xc,%esp
80102b04:	56                   	push   %esi
80102b05:	e8 96 d6 ff ff       	call   801001a0 <bwrite>
  brelse(buf);
80102b0a:	89 34 24             	mov    %esi,(%esp)
80102b0d:	e8 ce d6 ff ff       	call   801001e0 <brelse>
}
80102b12:	83 c4 10             	add    $0x10,%esp
80102b15:	8d 65 f8             	lea    -0x8(%ebp),%esp
80102b18:	5b                   	pop    %ebx
80102b19:	5e                   	pop    %esi
80102b1a:	5d                   	pop    %ebp
80102b1b:	c3                   	ret    
80102b1c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80102b20 <initlog>:
{
80102b20:	55                   	push   %ebp
80102b21:	89 e5                	mov    %esp,%ebp
80102b23:	53                   	push   %ebx
80102b24:	83 ec 2c             	sub    $0x2c,%esp
80102b27:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&log.lock, "log");
80102b2a:	68 a0 82 10 80       	push   $0x801082a0
80102b2f:	68 40 88 11 80       	push   $0x80118840
80102b34:	e8 67 1c 00 00       	call   801047a0 <initlock>
  readsb(dev, &sb);
80102b39:	58                   	pop    %eax
80102b3a:	8d 45 dc             	lea    -0x24(%ebp),%eax
80102b3d:	5a                   	pop    %edx
80102b3e:	50                   	push   %eax
80102b3f:	53                   	push   %ebx
80102b40:	e8 8b e8 ff ff       	call   801013d0 <readsb>
  log.size = sb.nlog;
80102b45:	8b 55 e8             	mov    -0x18(%ebp),%edx
  log.start = sb.logstart;
80102b48:	8b 45 ec             	mov    -0x14(%ebp),%eax
  struct buf *buf = bread(log.dev, log.start);
80102b4b:	59                   	pop    %ecx
  log.dev = dev;
80102b4c:	89 1d 84 88 11 80    	mov    %ebx,0x80118884
  log.size = sb.nlog;
80102b52:	89 15 78 88 11 80    	mov    %edx,0x80118878
  log.start = sb.logstart;
80102b58:	a3 74 88 11 80       	mov    %eax,0x80118874
  struct buf *buf = bread(log.dev, log.start);
80102b5d:	5a                   	pop    %edx
80102b5e:	50                   	push   %eax
80102b5f:	53                   	push   %ebx
80102b60:	e8 6b d5 ff ff       	call   801000d0 <bread>
  log.lh.n = lh->n;
80102b65:	8b 58 5c             	mov    0x5c(%eax),%ebx
  for (i = 0; i < log.lh.n; i++) {
80102b68:	83 c4 10             	add    $0x10,%esp
80102b6b:	85 db                	test   %ebx,%ebx
  log.lh.n = lh->n;
80102b6d:	89 1d 88 88 11 80    	mov    %ebx,0x80118888
  for (i = 0; i < log.lh.n; i++) {
80102b73:	7e 1c                	jle    80102b91 <initlog+0x71>
80102b75:	c1 e3 02             	shl    $0x2,%ebx
80102b78:	31 d2                	xor    %edx,%edx
80102b7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    log.lh.block[i] = lh->block[i];
80102b80:	8b 4c 10 60          	mov    0x60(%eax,%edx,1),%ecx
80102b84:	83 c2 04             	add    $0x4,%edx
80102b87:	89 8a 88 88 11 80    	mov    %ecx,-0x7fee7778(%edx)
  for (i = 0; i < log.lh.n; i++) {
80102b8d:	39 d3                	cmp    %edx,%ebx
80102b8f:	75 ef                	jne    80102b80 <initlog+0x60>
  brelse(buf);
80102b91:	83 ec 0c             	sub    $0xc,%esp
80102b94:	50                   	push   %eax
80102b95:	e8 46 d6 ff ff       	call   801001e0 <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(); // if committed, copy from log to disk
80102b9a:	e8 81 fe ff ff       	call   80102a20 <install_trans>
  log.lh.n = 0;
80102b9f:	c7 05 88 88 11 80 00 	movl   $0x0,0x80118888
80102ba6:	00 00 00 
  write_head(); // clear the log
80102ba9:	e8 12 ff ff ff       	call   80102ac0 <write_head>
}
80102bae:	83 c4 10             	add    $0x10,%esp
80102bb1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102bb4:	c9                   	leave  
80102bb5:	c3                   	ret    
80102bb6:	8d 76 00             	lea    0x0(%esi),%esi
80102bb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102bc0 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
80102bc0:	55                   	push   %ebp
80102bc1:	89 e5                	mov    %esp,%ebp
80102bc3:	83 ec 14             	sub    $0x14,%esp
  acquire(&log.lock);
80102bc6:	68 40 88 11 80       	push   $0x80118840
80102bcb:	e8 10 1d 00 00       	call   801048e0 <acquire>
80102bd0:	83 c4 10             	add    $0x10,%esp
80102bd3:	eb 18                	jmp    80102bed <begin_op+0x2d>
80102bd5:	8d 76 00             	lea    0x0(%esi),%esi
  while(1){
    if(log.committing){
      sleep(&log, &log.lock);
80102bd8:	83 ec 08             	sub    $0x8,%esp
80102bdb:	68 40 88 11 80       	push   $0x80118840
80102be0:	68 40 88 11 80       	push   $0x80118840
80102be5:	e8 06 14 00 00       	call   80103ff0 <sleep>
80102bea:	83 c4 10             	add    $0x10,%esp
    if(log.committing){
80102bed:	a1 80 88 11 80       	mov    0x80118880,%eax
80102bf2:	85 c0                	test   %eax,%eax
80102bf4:	75 e2                	jne    80102bd8 <begin_op+0x18>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80102bf6:	a1 7c 88 11 80       	mov    0x8011887c,%eax
80102bfb:	8b 15 88 88 11 80    	mov    0x80118888,%edx
80102c01:	83 c0 01             	add    $0x1,%eax
80102c04:	8d 0c 80             	lea    (%eax,%eax,4),%ecx
80102c07:	8d 14 4a             	lea    (%edx,%ecx,2),%edx
80102c0a:	83 fa 1e             	cmp    $0x1e,%edx
80102c0d:	7f c9                	jg     80102bd8 <begin_op+0x18>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    } else {
      log.outstanding += 1;
      release(&log.lock);
80102c0f:	83 ec 0c             	sub    $0xc,%esp
      log.outstanding += 1;
80102c12:	a3 7c 88 11 80       	mov    %eax,0x8011887c
      release(&log.lock);
80102c17:	68 40 88 11 80       	push   $0x80118840
80102c1c:	e8 7f 1d 00 00       	call   801049a0 <release>
      break;
    }
  }
}
80102c21:	83 c4 10             	add    $0x10,%esp
80102c24:	c9                   	leave  
80102c25:	c3                   	ret    
80102c26:	8d 76 00             	lea    0x0(%esi),%esi
80102c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80102c30 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
80102c30:	55                   	push   %ebp
80102c31:	89 e5                	mov    %esp,%ebp
80102c33:	57                   	push   %edi
80102c34:	56                   	push   %esi
80102c35:	53                   	push   %ebx
80102c36:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;

  acquire(&log.lock);
80102c39:	68 40 88 11 80       	push   $0x80118840
80102c3e:	e8 9d 1c 00 00       	call   801048e0 <acquire>
  log.outstanding -= 1;
80102c43:	a1 7c 88 11 80       	mov    0x8011887c,%eax
  if(log.committing)
80102c48:	8b 35 80 88 11 80    	mov    0x80118880,%esi
80102c4e:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
80102c51:	8d 58 ff             	lea    -0x1(%eax),%ebx
  if(log.committing)
80102c54:	85 f6                	test   %esi,%esi
  log.outstanding -= 1;
80102c56:	89 1d 7c 88 11 80    	mov    %ebx,0x8011887c
  if(log.committing)
80102c5c:	0f 85 1a 01 00 00    	jne    80102d7c <end_op+0x14c>
    panic("log.committing");
  if(log.outstanding == 0){
80102c62:	85 db                	test   %ebx,%ebx
80102c64:	0f 85 ee 00 00 00    	jne    80102d58 <end_op+0x128>
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
80102c6a:	83 ec 0c             	sub    $0xc,%esp
    log.committing = 1;
80102c6d:	c7 05 80 88 11 80 01 	movl   $0x1,0x80118880
80102c74:	00 00 00 
  release(&log.lock);
80102c77:	68 40 88 11 80       	push   $0x80118840
80102c7c:	e8 1f 1d 00 00       	call   801049a0 <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
80102c81:	8b 0d 88 88 11 80    	mov    0x80118888,%ecx
80102c87:	83 c4 10             	add    $0x10,%esp
80102c8a:	85 c9                	test   %ecx,%ecx
80102c8c:	0f 8e 85 00 00 00    	jle    80102d17 <end_op+0xe7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80102c92:	a1 74 88 11 80       	mov    0x80118874,%eax
80102c97:	83 ec 08             	sub    $0x8,%esp
80102c9a:	01 d8                	add    %ebx,%eax
80102c9c:	83 c0 01             	add    $0x1,%eax
80102c9f:	50                   	push   %eax
80102ca0:	ff 35 84 88 11 80    	pushl  0x80118884
80102ca6:	e8 25 d4 ff ff       	call   801000d0 <bread>
80102cab:	89 c6                	mov    %eax,%esi
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cad:	58                   	pop    %eax
80102cae:	5a                   	pop    %edx
80102caf:	ff 34 9d 8c 88 11 80 	pushl  -0x7fee7774(,%ebx,4)
80102cb6:	ff 35 84 88 11 80    	pushl  0x80118884
  for (tail = 0; tail < log.lh.n; tail++) {
80102cbc:	83 c3 01             	add    $0x1,%ebx
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
80102cbf:	e8 0c d4 ff ff       	call   801000d0 <bread>
80102cc4:	89 c7                	mov    %eax,%edi
    memmove(to->data, from->data, BSIZE);
80102cc6:	8d 40 5c             	lea    0x5c(%eax),%eax
80102cc9:	83 c4 0c             	add    $0xc,%esp
80102ccc:	68 00 02 00 00       	push   $0x200
80102cd1:	50                   	push   %eax
80102cd2:	8d 46 5c             	lea    0x5c(%esi),%eax
80102cd5:	50                   	push   %eax
80102cd6:	e8 c5 1d 00 00       	call   80104aa0 <memmove>
    bwrite(to);  // write the log
80102cdb:	89 34 24             	mov    %esi,(%esp)
80102cde:	e8 bd d4 ff ff       	call   801001a0 <bwrite>
    brelse(from);
80102ce3:	89 3c 24             	mov    %edi,(%esp)
80102ce6:	e8 f5 d4 ff ff       	call   801001e0 <brelse>
    brelse(to);
80102ceb:	89 34 24             	mov    %esi,(%esp)
80102cee:	e8 ed d4 ff ff       	call   801001e0 <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
80102cf3:	83 c4 10             	add    $0x10,%esp
80102cf6:	3b 1d 88 88 11 80    	cmp    0x80118888,%ebx
80102cfc:	7c 94                	jl     80102c92 <end_op+0x62>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
80102cfe:	e8 bd fd ff ff       	call   80102ac0 <write_head>
    install_trans(); // Now install writes to home locations
80102d03:	e8 18 fd ff ff       	call   80102a20 <install_trans>
    log.lh.n = 0;
80102d08:	c7 05 88 88 11 80 00 	movl   $0x0,0x80118888
80102d0f:	00 00 00 
    write_head();    // Erase the transaction from the log
80102d12:	e8 a9 fd ff ff       	call   80102ac0 <write_head>
    acquire(&log.lock);
80102d17:	83 ec 0c             	sub    $0xc,%esp
80102d1a:	68 40 88 11 80       	push   $0x80118840
80102d1f:	e8 bc 1b 00 00       	call   801048e0 <acquire>
    wakeup(&log);
80102d24:	c7 04 24 40 88 11 80 	movl   $0x80118840,(%esp)
    log.committing = 0;
80102d2b:	c7 05 80 88 11 80 00 	movl   $0x0,0x80118880
80102d32:	00 00 00 
    wakeup(&log);
80102d35:	e8 76 14 00 00       	call   801041b0 <wakeup>
    release(&log.lock);
80102d3a:	c7 04 24 40 88 11 80 	movl   $0x80118840,(%esp)
80102d41:	e8 5a 1c 00 00       	call   801049a0 <release>
80102d46:	83 c4 10             	add    $0x10,%esp
}
80102d49:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d4c:	5b                   	pop    %ebx
80102d4d:	5e                   	pop    %esi
80102d4e:	5f                   	pop    %edi
80102d4f:	5d                   	pop    %ebp
80102d50:	c3                   	ret    
80102d51:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&log);
80102d58:	83 ec 0c             	sub    $0xc,%esp
80102d5b:	68 40 88 11 80       	push   $0x80118840
80102d60:	e8 4b 14 00 00       	call   801041b0 <wakeup>
  release(&log.lock);
80102d65:	c7 04 24 40 88 11 80 	movl   $0x80118840,(%esp)
80102d6c:	e8 2f 1c 00 00       	call   801049a0 <release>
80102d71:	83 c4 10             	add    $0x10,%esp
}
80102d74:	8d 65 f4             	lea    -0xc(%ebp),%esp
80102d77:	5b                   	pop    %ebx
80102d78:	5e                   	pop    %esi
80102d79:	5f                   	pop    %edi
80102d7a:	5d                   	pop    %ebp
80102d7b:	c3                   	ret    
    panic("log.committing");
80102d7c:	83 ec 0c             	sub    $0xc,%esp
80102d7f:	68 a4 82 10 80       	push   $0x801082a4
80102d84:	e8 07 d6 ff ff       	call   80100390 <panic>
80102d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80102d90 <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
80102d90:	55                   	push   %ebp
80102d91:	89 e5                	mov    %esp,%ebp
80102d93:	53                   	push   %ebx
80102d94:	83 ec 04             	sub    $0x4,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102d97:	8b 15 88 88 11 80    	mov    0x80118888,%edx
{
80102d9d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80102da0:	83 fa 1d             	cmp    $0x1d,%edx
80102da3:	0f 8f 9d 00 00 00    	jg     80102e46 <log_write+0xb6>
80102da9:	a1 78 88 11 80       	mov    0x80118878,%eax
80102dae:	83 e8 01             	sub    $0x1,%eax
80102db1:	39 c2                	cmp    %eax,%edx
80102db3:	0f 8d 8d 00 00 00    	jge    80102e46 <log_write+0xb6>
    panic("too big a transaction");
  if (log.outstanding < 1)
80102db9:	a1 7c 88 11 80       	mov    0x8011887c,%eax
80102dbe:	85 c0                	test   %eax,%eax
80102dc0:	0f 8e 8d 00 00 00    	jle    80102e53 <log_write+0xc3>
    panic("log_write outside of trans");

  acquire(&log.lock);
80102dc6:	83 ec 0c             	sub    $0xc,%esp
80102dc9:	68 40 88 11 80       	push   $0x80118840
80102dce:	e8 0d 1b 00 00       	call   801048e0 <acquire>
  for (i = 0; i < log.lh.n; i++) {
80102dd3:	8b 0d 88 88 11 80    	mov    0x80118888,%ecx
80102dd9:	83 c4 10             	add    $0x10,%esp
80102ddc:	83 f9 00             	cmp    $0x0,%ecx
80102ddf:	7e 57                	jle    80102e38 <log_write+0xa8>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102de1:	8b 53 08             	mov    0x8(%ebx),%edx
  for (i = 0; i < log.lh.n; i++) {
80102de4:	31 c0                	xor    %eax,%eax
    if (log.lh.block[i] == b->blockno)   // log absorbtion
80102de6:	3b 15 8c 88 11 80    	cmp    0x8011888c,%edx
80102dec:	75 0b                	jne    80102df9 <log_write+0x69>
80102dee:	eb 38                	jmp    80102e28 <log_write+0x98>
80102df0:	39 14 85 8c 88 11 80 	cmp    %edx,-0x7fee7774(,%eax,4)
80102df7:	74 2f                	je     80102e28 <log_write+0x98>
  for (i = 0; i < log.lh.n; i++) {
80102df9:	83 c0 01             	add    $0x1,%eax
80102dfc:	39 c1                	cmp    %eax,%ecx
80102dfe:	75 f0                	jne    80102df0 <log_write+0x60>
      break;
  }
  log.lh.block[i] = b->blockno;
80102e00:	89 14 85 8c 88 11 80 	mov    %edx,-0x7fee7774(,%eax,4)
  if (i == log.lh.n)
    log.lh.n++;
80102e07:	83 c0 01             	add    $0x1,%eax
80102e0a:	a3 88 88 11 80       	mov    %eax,0x80118888
  b->flags |= B_DIRTY; // prevent eviction
80102e0f:	83 0b 04             	orl    $0x4,(%ebx)
  release(&log.lock);
80102e12:	c7 45 08 40 88 11 80 	movl   $0x80118840,0x8(%ebp)
}
80102e19:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80102e1c:	c9                   	leave  
  release(&log.lock);
80102e1d:	e9 7e 1b 00 00       	jmp    801049a0 <release>
80102e22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  log.lh.block[i] = b->blockno;
80102e28:	89 14 85 8c 88 11 80 	mov    %edx,-0x7fee7774(,%eax,4)
80102e2f:	eb de                	jmp    80102e0f <log_write+0x7f>
80102e31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80102e38:	8b 43 08             	mov    0x8(%ebx),%eax
80102e3b:	a3 8c 88 11 80       	mov    %eax,0x8011888c
  if (i == log.lh.n)
80102e40:	75 cd                	jne    80102e0f <log_write+0x7f>
80102e42:	31 c0                	xor    %eax,%eax
80102e44:	eb c1                	jmp    80102e07 <log_write+0x77>
    panic("too big a transaction");
80102e46:	83 ec 0c             	sub    $0xc,%esp
80102e49:	68 b3 82 10 80       	push   $0x801082b3
80102e4e:	e8 3d d5 ff ff       	call   80100390 <panic>
    panic("log_write outside of trans");
80102e53:	83 ec 0c             	sub    $0xc,%esp
80102e56:	68 c9 82 10 80       	push   $0x801082c9
80102e5b:	e8 30 d5 ff ff       	call   80100390 <panic>

80102e60 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80102e60:	55                   	push   %ebp
80102e61:	89 e5                	mov    %esp,%ebp
80102e63:	53                   	push   %ebx
80102e64:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80102e67:	e8 04 0a 00 00       	call   80103870 <cpuid>
80102e6c:	89 c3                	mov    %eax,%ebx
80102e6e:	e8 fd 09 00 00       	call   80103870 <cpuid>
80102e73:	83 ec 04             	sub    $0x4,%esp
80102e76:	53                   	push   %ebx
80102e77:	50                   	push   %eax
80102e78:	68 e4 82 10 80       	push   $0x801082e4
80102e7d:	e8 de d7 ff ff       	call   80100660 <cprintf>
  idtinit();       // load idt register
80102e82:	e8 c9 31 00 00       	call   80106050 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
80102e87:	e8 64 09 00 00       	call   801037f0 <mycpu>
80102e8c:	89 c2                	mov    %eax,%edx
xchg(volatile uint *addr, uint newval)
{
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80102e8e:	b8 01 00 00 00       	mov    $0x1,%eax
80102e93:	f0 87 82 a0 00 00 00 	lock xchg %eax,0xa0(%edx)
  scheduler();     // start running processes
80102e9a:	e8 91 0d 00 00       	call   80103c30 <scheduler>
80102e9f:	90                   	nop

80102ea0 <mpenter>:
{
80102ea0:	55                   	push   %ebp
80102ea1:	89 e5                	mov    %esp,%ebp
80102ea3:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
80102ea6:	e8 95 42 00 00       	call   80107140 <switchkvm>
  seginit();
80102eab:	e8 00 42 00 00       	call   801070b0 <seginit>
  lapicinit();
80102eb0:	e8 9b f7 ff ff       	call   80102650 <lapicinit>
  mpmain();
80102eb5:	e8 a6 ff ff ff       	call   80102e60 <mpmain>
80102eba:	66 90                	xchg   %ax,%ax
80102ebc:	66 90                	xchg   %ax,%ax
80102ebe:	66 90                	xchg   %ax,%ax

80102ec0 <main>:
{
80102ec0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
80102ec4:	83 e4 f0             	and    $0xfffffff0,%esp
80102ec7:	ff 71 fc             	pushl  -0x4(%ecx)
80102eca:	55                   	push   %ebp
80102ecb:	89 e5                	mov    %esp,%ebp
80102ecd:	53                   	push   %ebx
80102ece:	51                   	push   %ecx
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
80102ecf:	83 ec 08             	sub    $0x8,%esp
80102ed2:	68 00 00 40 80       	push   $0x80400000
80102ed7:	68 00 74 2f 80       	push   $0x802f7400
80102edc:	e8 2f f5 ff ff       	call   80102410 <kinit1>
  kvmalloc();      // kernel page table
80102ee1:	e8 2a 47 00 00       	call   80107610 <kvmalloc>
  mpinit();        // detect other processors
80102ee6:	e8 75 01 00 00       	call   80103060 <mpinit>
  lapicinit();     // interrupt controller
80102eeb:	e8 60 f7 ff ff       	call   80102650 <lapicinit>
  seginit();       // segment descriptors
80102ef0:	e8 bb 41 00 00       	call   801070b0 <seginit>
  picinit();       // disable pic
80102ef5:	e8 46 03 00 00       	call   80103240 <picinit>
  ioapicinit();    // another interrupt controller
80102efa:	e8 41 f3 ff ff       	call   80102240 <ioapicinit>
  consoleinit();   // console hardware
80102eff:	e8 bc da ff ff       	call   801009c0 <consoleinit>
  uartinit();      // serial port
80102f04:	e8 77 34 00 00       	call   80106380 <uartinit>
  pinit();         // process table
80102f09:	e8 92 08 00 00       	call   801037a0 <pinit>
  tvinit();        // trap vectors
80102f0e:	e8 bd 30 00 00       	call   80105fd0 <tvinit>
  binit();         // buffer cache
80102f13:	e8 28 d1 ff ff       	call   80100040 <binit>
  fileinit();      // file table
80102f18:	e8 43 de ff ff       	call   80100d60 <fileinit>
  messageinit();
80102f1d:	e8 ce 49 00 00       	call   801078f0 <messageinit>
  ideinit();       // disk 
80102f22:	e8 f9 f0 ff ff       	call   80102020 <ideinit>

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80102f27:	83 c4 0c             	add    $0xc,%esp
80102f2a:	68 8a 00 00 00       	push   $0x8a
80102f2f:	68 4c b7 10 80       	push   $0x8010b74c
80102f34:	68 00 70 00 80       	push   $0x80007000
80102f39:	e8 62 1b 00 00       	call   80104aa0 <memmove>

  for(c = cpus; c < cpus+ncpu; c++){
80102f3e:	69 05 c0 8e 11 80 b0 	imul   $0xb0,0x80118ec0,%eax
80102f45:	00 00 00 
80102f48:	83 c4 10             	add    $0x10,%esp
80102f4b:	05 40 89 11 80       	add    $0x80118940,%eax
80102f50:	3d 40 89 11 80       	cmp    $0x80118940,%eax
80102f55:	76 6c                	jbe    80102fc3 <main+0x103>
80102f57:	bb 40 89 11 80       	mov    $0x80118940,%ebx
80102f5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(c == mycpu())  // We've started already.
80102f60:	e8 8b 08 00 00       	call   801037f0 <mycpu>
80102f65:	39 d8                	cmp    %ebx,%eax
80102f67:	74 41                	je     80102faa <main+0xea>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80102f69:	e8 72 f5 ff ff       	call   801024e0 <kalloc>
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f6e:	05 00 10 00 00       	add    $0x1000,%eax
    *(void(**)(void))(code-8) = mpenter;
80102f73:	c7 05 f8 6f 00 80 a0 	movl   $0x80102ea0,0x80006ff8
80102f7a:	2e 10 80 
    *(int**)(code-12) = (void *) V2P(entrypgdir);
80102f7d:	c7 05 f4 6f 00 80 00 	movl   $0x10a000,0x80006ff4
80102f84:	a0 10 00 
    *(void**)(code-4) = stack + KSTACKSIZE;
80102f87:	a3 fc 6f 00 80       	mov    %eax,0x80006ffc

    lapicstartap(c->apicid, V2P(code));
80102f8c:	0f b6 03             	movzbl (%ebx),%eax
80102f8f:	83 ec 08             	sub    $0x8,%esp
80102f92:	68 00 70 00 00       	push   $0x7000
80102f97:	50                   	push   %eax
80102f98:	e8 03 f8 ff ff       	call   801027a0 <lapicstartap>
80102f9d:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
80102fa0:	8b 83 a0 00 00 00    	mov    0xa0(%ebx),%eax
80102fa6:	85 c0                	test   %eax,%eax
80102fa8:	74 f6                	je     80102fa0 <main+0xe0>
  for(c = cpus; c < cpus+ncpu; c++){
80102faa:	69 05 c0 8e 11 80 b0 	imul   $0xb0,0x80118ec0,%eax
80102fb1:	00 00 00 
80102fb4:	81 c3 b0 00 00 00    	add    $0xb0,%ebx
80102fba:	05 40 89 11 80       	add    $0x80118940,%eax
80102fbf:	39 c3                	cmp    %eax,%ebx
80102fc1:	72 9d                	jb     80102f60 <main+0xa0>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
80102fc3:	83 ec 08             	sub    $0x8,%esp
80102fc6:	68 00 00 00 8e       	push   $0x8e000000
80102fcb:	68 00 00 40 80       	push   $0x80400000
80102fd0:	e8 ab f4 ff ff       	call   80102480 <kinit2>
  userinit();      // first user process
80102fd5:	e8 b6 09 00 00       	call   80103990 <userinit>
  mpmain();        // finish this processor's setup
80102fda:	e8 81 fe ff ff       	call   80102e60 <mpmain>
80102fdf:	90                   	nop

80102fe0 <mpsearch1>:
}

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80102fe0:	55                   	push   %ebp
80102fe1:	89 e5                	mov    %esp,%ebp
80102fe3:	57                   	push   %edi
80102fe4:	56                   	push   %esi
  uchar *e, *p, *addr;

  addr = P2V(a);
80102fe5:	8d b0 00 00 00 80    	lea    -0x80000000(%eax),%esi
{
80102feb:	53                   	push   %ebx
  e = addr+len;
80102fec:	8d 1c 16             	lea    (%esi,%edx,1),%ebx
{
80102fef:	83 ec 0c             	sub    $0xc,%esp
  for(p = addr; p < e; p += sizeof(struct mp))
80102ff2:	39 de                	cmp    %ebx,%esi
80102ff4:	72 10                	jb     80103006 <mpsearch1+0x26>
80102ff6:	eb 50                	jmp    80103048 <mpsearch1+0x68>
80102ff8:	90                   	nop
80102ff9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103000:	39 fb                	cmp    %edi,%ebx
80103002:	89 fe                	mov    %edi,%esi
80103004:	76 42                	jbe    80103048 <mpsearch1+0x68>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103006:	83 ec 04             	sub    $0x4,%esp
80103009:	8d 7e 10             	lea    0x10(%esi),%edi
8010300c:	6a 04                	push   $0x4
8010300e:	68 f8 82 10 80       	push   $0x801082f8
80103013:	56                   	push   %esi
80103014:	e8 27 1a 00 00       	call   80104a40 <memcmp>
80103019:	83 c4 10             	add    $0x10,%esp
8010301c:	85 c0                	test   %eax,%eax
8010301e:	75 e0                	jne    80103000 <mpsearch1+0x20>
80103020:	89 f1                	mov    %esi,%ecx
80103022:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sum += addr[i];
80103028:	0f b6 11             	movzbl (%ecx),%edx
8010302b:	83 c1 01             	add    $0x1,%ecx
8010302e:	01 d0                	add    %edx,%eax
  for(i=0; i<len; i++)
80103030:	39 f9                	cmp    %edi,%ecx
80103032:	75 f4                	jne    80103028 <mpsearch1+0x48>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103034:	84 c0                	test   %al,%al
80103036:	75 c8                	jne    80103000 <mpsearch1+0x20>
      return (struct mp*)p;
  return 0;
}
80103038:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010303b:	89 f0                	mov    %esi,%eax
8010303d:	5b                   	pop    %ebx
8010303e:	5e                   	pop    %esi
8010303f:	5f                   	pop    %edi
80103040:	5d                   	pop    %ebp
80103041:	c3                   	ret    
80103042:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103048:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010304b:	31 f6                	xor    %esi,%esi
}
8010304d:	89 f0                	mov    %esi,%eax
8010304f:	5b                   	pop    %ebx
80103050:	5e                   	pop    %esi
80103051:	5f                   	pop    %edi
80103052:	5d                   	pop    %ebp
80103053:	c3                   	ret    
80103054:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010305a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103060 <mpinit>:
  return conf;
}

void
mpinit(void)
{
80103060:	55                   	push   %ebp
80103061:	89 e5                	mov    %esp,%ebp
80103063:	57                   	push   %edi
80103064:	56                   	push   %esi
80103065:	53                   	push   %ebx
80103066:	83 ec 1c             	sub    $0x1c,%esp
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103069:	0f b6 05 0f 04 00 80 	movzbl 0x8000040f,%eax
80103070:	0f b6 15 0e 04 00 80 	movzbl 0x8000040e,%edx
80103077:	c1 e0 08             	shl    $0x8,%eax
8010307a:	09 d0                	or     %edx,%eax
8010307c:	c1 e0 04             	shl    $0x4,%eax
8010307f:	85 c0                	test   %eax,%eax
80103081:	75 1b                	jne    8010309e <mpinit+0x3e>
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103083:	0f b6 05 14 04 00 80 	movzbl 0x80000414,%eax
8010308a:	0f b6 15 13 04 00 80 	movzbl 0x80000413,%edx
80103091:	c1 e0 08             	shl    $0x8,%eax
80103094:	09 d0                	or     %edx,%eax
80103096:	c1 e0 0a             	shl    $0xa,%eax
    if((mp = mpsearch1(p-1024, 1024)))
80103099:	2d 00 04 00 00       	sub    $0x400,%eax
    if((mp = mpsearch1(p, 1024)))
8010309e:	ba 00 04 00 00       	mov    $0x400,%edx
801030a3:	e8 38 ff ff ff       	call   80102fe0 <mpsearch1>
801030a8:	85 c0                	test   %eax,%eax
801030aa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801030ad:	0f 84 3d 01 00 00    	je     801031f0 <mpinit+0x190>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801030b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801030b6:	8b 58 04             	mov    0x4(%eax),%ebx
801030b9:	85 db                	test   %ebx,%ebx
801030bb:	0f 84 4f 01 00 00    	je     80103210 <mpinit+0x1b0>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
801030c1:	8d b3 00 00 00 80    	lea    -0x80000000(%ebx),%esi
  if(memcmp(conf, "PCMP", 4) != 0)
801030c7:	83 ec 04             	sub    $0x4,%esp
801030ca:	6a 04                	push   $0x4
801030cc:	68 15 83 10 80       	push   $0x80108315
801030d1:	56                   	push   %esi
801030d2:	e8 69 19 00 00       	call   80104a40 <memcmp>
801030d7:	83 c4 10             	add    $0x10,%esp
801030da:	85 c0                	test   %eax,%eax
801030dc:	0f 85 2e 01 00 00    	jne    80103210 <mpinit+0x1b0>
  if(conf->version != 1 && conf->version != 4)
801030e2:	0f b6 83 06 00 00 80 	movzbl -0x7ffffffa(%ebx),%eax
801030e9:	3c 01                	cmp    $0x1,%al
801030eb:	0f 95 c2             	setne  %dl
801030ee:	3c 04                	cmp    $0x4,%al
801030f0:	0f 95 c0             	setne  %al
801030f3:	20 c2                	and    %al,%dl
801030f5:	0f 85 15 01 00 00    	jne    80103210 <mpinit+0x1b0>
  if(sum((uchar*)conf, conf->length) != 0)
801030fb:	0f b7 bb 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edi
  for(i=0; i<len; i++)
80103102:	66 85 ff             	test   %di,%di
80103105:	74 1a                	je     80103121 <mpinit+0xc1>
80103107:	89 f0                	mov    %esi,%eax
80103109:	01 f7                	add    %esi,%edi
  sum = 0;
8010310b:	31 d2                	xor    %edx,%edx
8010310d:	8d 76 00             	lea    0x0(%esi),%esi
    sum += addr[i];
80103110:	0f b6 08             	movzbl (%eax),%ecx
80103113:	83 c0 01             	add    $0x1,%eax
80103116:	01 ca                	add    %ecx,%edx
  for(i=0; i<len; i++)
80103118:	39 c7                	cmp    %eax,%edi
8010311a:	75 f4                	jne    80103110 <mpinit+0xb0>
8010311c:	84 d2                	test   %dl,%dl
8010311e:	0f 95 c2             	setne  %dl
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103121:	85 f6                	test   %esi,%esi
80103123:	0f 84 e7 00 00 00    	je     80103210 <mpinit+0x1b0>
80103129:	84 d2                	test   %dl,%dl
8010312b:	0f 85 df 00 00 00    	jne    80103210 <mpinit+0x1b0>
    panic("Expect to run on an SMP");
  ismp = 1;
  lapic = (uint*)conf->lapicaddr;
80103131:	8b 83 24 00 00 80    	mov    -0x7fffffdc(%ebx),%eax
80103137:	a3 3c 88 11 80       	mov    %eax,0x8011883c
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010313c:	0f b7 93 04 00 00 80 	movzwl -0x7ffffffc(%ebx),%edx
80103143:	8d 83 2c 00 00 80    	lea    -0x7fffffd4(%ebx),%eax
  ismp = 1;
80103149:	bb 01 00 00 00       	mov    $0x1,%ebx
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
8010314e:	01 d6                	add    %edx,%esi
80103150:	39 c6                	cmp    %eax,%esi
80103152:	76 23                	jbe    80103177 <mpinit+0x117>
    switch(*p){
80103154:	0f b6 10             	movzbl (%eax),%edx
80103157:	80 fa 04             	cmp    $0x4,%dl
8010315a:	0f 87 ca 00 00 00    	ja     8010322a <mpinit+0x1ca>
80103160:	ff 24 95 3c 83 10 80 	jmp    *-0x7fef7cc4(,%edx,4)
80103167:	89 f6                	mov    %esi,%esi
80103169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      p += sizeof(struct mpioapic);
      continue;
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103170:	83 c0 08             	add    $0x8,%eax
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103173:	39 c6                	cmp    %eax,%esi
80103175:	77 dd                	ja     80103154 <mpinit+0xf4>
    default:
      ismp = 0;
      break;
    }
  }
  if(!ismp)
80103177:	85 db                	test   %ebx,%ebx
80103179:	0f 84 9e 00 00 00    	je     8010321d <mpinit+0x1bd>
    panic("Didn't find a suitable machine");

  if(mp->imcrp){
8010317f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103182:	80 78 0c 00          	cmpb   $0x0,0xc(%eax)
80103186:	74 15                	je     8010319d <mpinit+0x13d>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103188:	b8 70 00 00 00       	mov    $0x70,%eax
8010318d:	ba 22 00 00 00       	mov    $0x22,%edx
80103192:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103193:	ba 23 00 00 00       	mov    $0x23,%edx
80103198:	ec                   	in     (%dx),%al
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103199:	83 c8 01             	or     $0x1,%eax
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
8010319c:	ee                   	out    %al,(%dx)
  }
}
8010319d:	8d 65 f4             	lea    -0xc(%ebp),%esp
801031a0:	5b                   	pop    %ebx
801031a1:	5e                   	pop    %esi
801031a2:	5f                   	pop    %edi
801031a3:	5d                   	pop    %ebp
801031a4:	c3                   	ret    
801031a5:	8d 76 00             	lea    0x0(%esi),%esi
      if(ncpu < NCPU) {
801031a8:	8b 0d c0 8e 11 80    	mov    0x80118ec0,%ecx
801031ae:	83 f9 07             	cmp    $0x7,%ecx
801031b1:	7f 19                	jg     801031cc <mpinit+0x16c>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031b3:	0f b6 50 01          	movzbl 0x1(%eax),%edx
801031b7:	69 f9 b0 00 00 00    	imul   $0xb0,%ecx,%edi
        ncpu++;
801031bd:	83 c1 01             	add    $0x1,%ecx
801031c0:	89 0d c0 8e 11 80    	mov    %ecx,0x80118ec0
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
801031c6:	88 97 40 89 11 80    	mov    %dl,-0x7fee76c0(%edi)
      p += sizeof(struct mpproc);
801031cc:	83 c0 14             	add    $0x14,%eax
      continue;
801031cf:	e9 7c ff ff ff       	jmp    80103150 <mpinit+0xf0>
801031d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      ioapicid = ioapic->apicno;
801031d8:	0f b6 50 01          	movzbl 0x1(%eax),%edx
      p += sizeof(struct mpioapic);
801031dc:	83 c0 08             	add    $0x8,%eax
      ioapicid = ioapic->apicno;
801031df:	88 15 20 89 11 80    	mov    %dl,0x80118920
      continue;
801031e5:	e9 66 ff ff ff       	jmp    80103150 <mpinit+0xf0>
801031ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  return mpsearch1(0xF0000, 0x10000);
801031f0:	ba 00 00 01 00       	mov    $0x10000,%edx
801031f5:	b8 00 00 0f 00       	mov    $0xf0000,%eax
801031fa:	e8 e1 fd ff ff       	call   80102fe0 <mpsearch1>
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
801031ff:	85 c0                	test   %eax,%eax
  return mpsearch1(0xF0000, 0x10000);
80103201:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103204:	0f 85 a9 fe ff ff    	jne    801030b3 <mpinit+0x53>
8010320a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    panic("Expect to run on an SMP");
80103210:	83 ec 0c             	sub    $0xc,%esp
80103213:	68 fd 82 10 80       	push   $0x801082fd
80103218:	e8 73 d1 ff ff       	call   80100390 <panic>
    panic("Didn't find a suitable machine");
8010321d:	83 ec 0c             	sub    $0xc,%esp
80103220:	68 1c 83 10 80       	push   $0x8010831c
80103225:	e8 66 d1 ff ff       	call   80100390 <panic>
      ismp = 0;
8010322a:	31 db                	xor    %ebx,%ebx
8010322c:	e9 26 ff ff ff       	jmp    80103157 <mpinit+0xf7>
80103231:	66 90                	xchg   %ax,%ax
80103233:	66 90                	xchg   %ax,%ax
80103235:	66 90                	xchg   %ax,%ax
80103237:	66 90                	xchg   %ax,%ax
80103239:	66 90                	xchg   %ax,%ax
8010323b:	66 90                	xchg   %ax,%ax
8010323d:	66 90                	xchg   %ax,%ax
8010323f:	90                   	nop

80103240 <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103240:	55                   	push   %ebp
80103241:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103246:	ba 21 00 00 00       	mov    $0x21,%edx
8010324b:	89 e5                	mov    %esp,%ebp
8010324d:	ee                   	out    %al,(%dx)
8010324e:	ba a1 00 00 00       	mov    $0xa1,%edx
80103253:	ee                   	out    %al,(%dx)
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
  outb(IO_PIC2+1, 0xFF);
}
80103254:	5d                   	pop    %ebp
80103255:	c3                   	ret    
80103256:	66 90                	xchg   %ax,%ax
80103258:	66 90                	xchg   %ax,%ax
8010325a:	66 90                	xchg   %ax,%ax
8010325c:	66 90                	xchg   %ax,%ax
8010325e:	66 90                	xchg   %ax,%ax

80103260 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103260:	55                   	push   %ebp
80103261:	89 e5                	mov    %esp,%ebp
80103263:	57                   	push   %edi
80103264:	56                   	push   %esi
80103265:	53                   	push   %ebx
80103266:	83 ec 0c             	sub    $0xc,%esp
80103269:	8b 5d 08             	mov    0x8(%ebp),%ebx
8010326c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct pipe *p;

  p = 0;
  *f0 = *f1 = 0;
8010326f:	c7 06 00 00 00 00    	movl   $0x0,(%esi)
80103275:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
8010327b:	e8 00 db ff ff       	call   80100d80 <filealloc>
80103280:	85 c0                	test   %eax,%eax
80103282:	89 03                	mov    %eax,(%ebx)
80103284:	74 22                	je     801032a8 <pipealloc+0x48>
80103286:	e8 f5 da ff ff       	call   80100d80 <filealloc>
8010328b:	85 c0                	test   %eax,%eax
8010328d:	89 06                	mov    %eax,(%esi)
8010328f:	74 3f                	je     801032d0 <pipealloc+0x70>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103291:	e8 4a f2 ff ff       	call   801024e0 <kalloc>
80103296:	85 c0                	test   %eax,%eax
80103298:	89 c7                	mov    %eax,%edi
8010329a:	75 54                	jne    801032f0 <pipealloc+0x90>

//PAGEBREAK: 20
 bad:
  if(p)
    kfree((char*)p);
  if(*f0)
8010329c:	8b 03                	mov    (%ebx),%eax
8010329e:	85 c0                	test   %eax,%eax
801032a0:	75 34                	jne    801032d6 <pipealloc+0x76>
801032a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    fileclose(*f0);
  if(*f1)
801032a8:	8b 06                	mov    (%esi),%eax
801032aa:	85 c0                	test   %eax,%eax
801032ac:	74 0c                	je     801032ba <pipealloc+0x5a>
    fileclose(*f1);
801032ae:	83 ec 0c             	sub    $0xc,%esp
801032b1:	50                   	push   %eax
801032b2:	e8 89 db ff ff       	call   80100e40 <fileclose>
801032b7:	83 c4 10             	add    $0x10,%esp
  return -1;
}
801032ba:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
801032bd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801032c2:	5b                   	pop    %ebx
801032c3:	5e                   	pop    %esi
801032c4:	5f                   	pop    %edi
801032c5:	5d                   	pop    %ebp
801032c6:	c3                   	ret    
801032c7:	89 f6                	mov    %esi,%esi
801032c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(*f0)
801032d0:	8b 03                	mov    (%ebx),%eax
801032d2:	85 c0                	test   %eax,%eax
801032d4:	74 e4                	je     801032ba <pipealloc+0x5a>
    fileclose(*f0);
801032d6:	83 ec 0c             	sub    $0xc,%esp
801032d9:	50                   	push   %eax
801032da:	e8 61 db ff ff       	call   80100e40 <fileclose>
  if(*f1)
801032df:	8b 06                	mov    (%esi),%eax
    fileclose(*f0);
801032e1:	83 c4 10             	add    $0x10,%esp
  if(*f1)
801032e4:	85 c0                	test   %eax,%eax
801032e6:	75 c6                	jne    801032ae <pipealloc+0x4e>
801032e8:	eb d0                	jmp    801032ba <pipealloc+0x5a>
801032ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  initlock(&p->lock, "pipe");
801032f0:	83 ec 08             	sub    $0x8,%esp
  p->readopen = 1;
801032f3:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
801032fa:	00 00 00 
  p->writeopen = 1;
801032fd:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103304:	00 00 00 
  p->nwrite = 0;
80103307:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
8010330e:	00 00 00 
  p->nread = 0;
80103311:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103318:	00 00 00 
  initlock(&p->lock, "pipe");
8010331b:	68 50 83 10 80       	push   $0x80108350
80103320:	50                   	push   %eax
80103321:	e8 7a 14 00 00       	call   801047a0 <initlock>
  (*f0)->type = FD_PIPE;
80103326:	8b 03                	mov    (%ebx),%eax
  return 0;
80103328:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
8010332b:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103331:	8b 03                	mov    (%ebx),%eax
80103333:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103337:	8b 03                	mov    (%ebx),%eax
80103339:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
8010333d:	8b 03                	mov    (%ebx),%eax
8010333f:	89 78 0c             	mov    %edi,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103342:	8b 06                	mov    (%esi),%eax
80103344:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
8010334a:	8b 06                	mov    (%esi),%eax
8010334c:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103350:	8b 06                	mov    (%esi),%eax
80103352:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103356:	8b 06                	mov    (%esi),%eax
80103358:	89 78 0c             	mov    %edi,0xc(%eax)
}
8010335b:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010335e:	31 c0                	xor    %eax,%eax
}
80103360:	5b                   	pop    %ebx
80103361:	5e                   	pop    %esi
80103362:	5f                   	pop    %edi
80103363:	5d                   	pop    %ebp
80103364:	c3                   	ret    
80103365:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103369:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103370 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103370:	55                   	push   %ebp
80103371:	89 e5                	mov    %esp,%ebp
80103373:	56                   	push   %esi
80103374:	53                   	push   %ebx
80103375:	8b 5d 08             	mov    0x8(%ebp),%ebx
80103378:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&p->lock);
8010337b:	83 ec 0c             	sub    $0xc,%esp
8010337e:	53                   	push   %ebx
8010337f:	e8 5c 15 00 00       	call   801048e0 <acquire>
  if(writable){
80103384:	83 c4 10             	add    $0x10,%esp
80103387:	85 f6                	test   %esi,%esi
80103389:	74 45                	je     801033d0 <pipeclose+0x60>
    p->writeopen = 0;
    wakeup(&p->nread);
8010338b:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
80103391:	83 ec 0c             	sub    $0xc,%esp
    p->writeopen = 0;
80103394:	c7 83 40 02 00 00 00 	movl   $0x0,0x240(%ebx)
8010339b:	00 00 00 
    wakeup(&p->nread);
8010339e:	50                   	push   %eax
8010339f:	e8 0c 0e 00 00       	call   801041b0 <wakeup>
801033a4:	83 c4 10             	add    $0x10,%esp
  } else {
    p->readopen = 0;
    wakeup(&p->nwrite);
  }
  if(p->readopen == 0 && p->writeopen == 0){
801033a7:	8b 93 3c 02 00 00    	mov    0x23c(%ebx),%edx
801033ad:	85 d2                	test   %edx,%edx
801033af:	75 0a                	jne    801033bb <pipeclose+0x4b>
801033b1:	8b 83 40 02 00 00    	mov    0x240(%ebx),%eax
801033b7:	85 c0                	test   %eax,%eax
801033b9:	74 35                	je     801033f0 <pipeclose+0x80>
    release(&p->lock);
    kfree((char*)p);
  } else
    release(&p->lock);
801033bb:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801033be:	8d 65 f8             	lea    -0x8(%ebp),%esp
801033c1:	5b                   	pop    %ebx
801033c2:	5e                   	pop    %esi
801033c3:	5d                   	pop    %ebp
    release(&p->lock);
801033c4:	e9 d7 15 00 00       	jmp    801049a0 <release>
801033c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wakeup(&p->nwrite);
801033d0:	8d 83 38 02 00 00    	lea    0x238(%ebx),%eax
801033d6:	83 ec 0c             	sub    $0xc,%esp
    p->readopen = 0;
801033d9:	c7 83 3c 02 00 00 00 	movl   $0x0,0x23c(%ebx)
801033e0:	00 00 00 
    wakeup(&p->nwrite);
801033e3:	50                   	push   %eax
801033e4:	e8 c7 0d 00 00       	call   801041b0 <wakeup>
801033e9:	83 c4 10             	add    $0x10,%esp
801033ec:	eb b9                	jmp    801033a7 <pipeclose+0x37>
801033ee:	66 90                	xchg   %ax,%ax
    release(&p->lock);
801033f0:	83 ec 0c             	sub    $0xc,%esp
801033f3:	53                   	push   %ebx
801033f4:	e8 a7 15 00 00       	call   801049a0 <release>
    kfree((char*)p);
801033f9:	89 5d 08             	mov    %ebx,0x8(%ebp)
801033fc:	83 c4 10             	add    $0x10,%esp
}
801033ff:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103402:	5b                   	pop    %ebx
80103403:	5e                   	pop    %esi
80103404:	5d                   	pop    %ebp
    kfree((char*)p);
80103405:	e9 26 ef ff ff       	jmp    80102330 <kfree>
8010340a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80103410 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103410:	55                   	push   %ebp
80103411:	89 e5                	mov    %esp,%ebp
80103413:	57                   	push   %edi
80103414:	56                   	push   %esi
80103415:	53                   	push   %ebx
80103416:	83 ec 28             	sub    $0x28,%esp
80103419:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int i;

  acquire(&p->lock);
8010341c:	53                   	push   %ebx
8010341d:	e8 be 14 00 00       	call   801048e0 <acquire>
  for(i = 0; i < n; i++){
80103422:	8b 45 10             	mov    0x10(%ebp),%eax
80103425:	83 c4 10             	add    $0x10,%esp
80103428:	85 c0                	test   %eax,%eax
8010342a:	0f 8e c9 00 00 00    	jle    801034f9 <pipewrite+0xe9>
80103430:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80103433:	8b 83 38 02 00 00    	mov    0x238(%ebx),%eax
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
        release(&p->lock);
        return -1;
      }
      wakeup(&p->nread);
80103439:	8d bb 34 02 00 00    	lea    0x234(%ebx),%edi
8010343f:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
80103442:	03 4d 10             	add    0x10(%ebp),%ecx
80103445:	89 4d e0             	mov    %ecx,-0x20(%ebp)
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103448:	8b 8b 34 02 00 00    	mov    0x234(%ebx),%ecx
8010344e:	8d 91 00 02 00 00    	lea    0x200(%ecx),%edx
80103454:	39 d0                	cmp    %edx,%eax
80103456:	75 71                	jne    801034c9 <pipewrite+0xb9>
      if(p->readopen == 0 || myproc()->killed){
80103458:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
8010345e:	85 c0                	test   %eax,%eax
80103460:	74 4e                	je     801034b0 <pipewrite+0xa0>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103462:	8d b3 38 02 00 00    	lea    0x238(%ebx),%esi
80103468:	eb 3a                	jmp    801034a4 <pipewrite+0x94>
8010346a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      wakeup(&p->nread);
80103470:	83 ec 0c             	sub    $0xc,%esp
80103473:	57                   	push   %edi
80103474:	e8 37 0d 00 00       	call   801041b0 <wakeup>
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
80103479:	5a                   	pop    %edx
8010347a:	59                   	pop    %ecx
8010347b:	53                   	push   %ebx
8010347c:	56                   	push   %esi
8010347d:	e8 6e 0b 00 00       	call   80103ff0 <sleep>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80103482:	8b 83 34 02 00 00    	mov    0x234(%ebx),%eax
80103488:	8b 93 38 02 00 00    	mov    0x238(%ebx),%edx
8010348e:	83 c4 10             	add    $0x10,%esp
80103491:	05 00 02 00 00       	add    $0x200,%eax
80103496:	39 c2                	cmp    %eax,%edx
80103498:	75 36                	jne    801034d0 <pipewrite+0xc0>
      if(p->readopen == 0 || myproc()->killed){
8010349a:	8b 83 3c 02 00 00    	mov    0x23c(%ebx),%eax
801034a0:	85 c0                	test   %eax,%eax
801034a2:	74 0c                	je     801034b0 <pipewrite+0xa0>
801034a4:	e8 e7 03 00 00       	call   80103890 <myproc>
801034a9:	8b 40 24             	mov    0x24(%eax),%eax
801034ac:	85 c0                	test   %eax,%eax
801034ae:	74 c0                	je     80103470 <pipewrite+0x60>
        release(&p->lock);
801034b0:	83 ec 0c             	sub    $0xc,%esp
801034b3:	53                   	push   %ebx
801034b4:	e8 e7 14 00 00       	call   801049a0 <release>
        return -1;
801034b9:	83 c4 10             	add    $0x10,%esp
801034bc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
  release(&p->lock);
  return n;
}
801034c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801034c4:	5b                   	pop    %ebx
801034c5:	5e                   	pop    %esi
801034c6:	5f                   	pop    %edi
801034c7:	5d                   	pop    %ebp
801034c8:	c3                   	ret    
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
801034c9:	89 c2                	mov    %eax,%edx
801034cb:	90                   	nop
801034cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034d0:	8b 75 e4             	mov    -0x1c(%ebp),%esi
801034d3:	8d 42 01             	lea    0x1(%edx),%eax
801034d6:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
801034dc:	89 83 38 02 00 00    	mov    %eax,0x238(%ebx)
801034e2:	83 c6 01             	add    $0x1,%esi
801034e5:	0f b6 4e ff          	movzbl -0x1(%esi),%ecx
  for(i = 0; i < n; i++){
801034e9:	3b 75 e0             	cmp    -0x20(%ebp),%esi
801034ec:	89 75 e4             	mov    %esi,-0x1c(%ebp)
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
801034ef:	88 4c 13 34          	mov    %cl,0x34(%ebx,%edx,1)
  for(i = 0; i < n; i++){
801034f3:	0f 85 4f ff ff ff    	jne    80103448 <pipewrite+0x38>
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801034f9:	8d 83 34 02 00 00    	lea    0x234(%ebx),%eax
801034ff:	83 ec 0c             	sub    $0xc,%esp
80103502:	50                   	push   %eax
80103503:	e8 a8 0c 00 00       	call   801041b0 <wakeup>
  release(&p->lock);
80103508:	89 1c 24             	mov    %ebx,(%esp)
8010350b:	e8 90 14 00 00       	call   801049a0 <release>
  return n;
80103510:	83 c4 10             	add    $0x10,%esp
80103513:	8b 45 10             	mov    0x10(%ebp),%eax
80103516:	eb a9                	jmp    801034c1 <pipewrite+0xb1>
80103518:	90                   	nop
80103519:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103520 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
80103520:	55                   	push   %ebp
80103521:	89 e5                	mov    %esp,%ebp
80103523:	57                   	push   %edi
80103524:	56                   	push   %esi
80103525:	53                   	push   %ebx
80103526:	83 ec 18             	sub    $0x18,%esp
80103529:	8b 75 08             	mov    0x8(%ebp),%esi
8010352c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  acquire(&p->lock);
8010352f:	56                   	push   %esi
80103530:	e8 ab 13 00 00       	call   801048e0 <acquire>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
80103535:	83 c4 10             	add    $0x10,%esp
80103538:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
8010353e:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103544:	75 6a                	jne    801035b0 <piperead+0x90>
80103546:	8b 9e 40 02 00 00    	mov    0x240(%esi),%ebx
8010354c:	85 db                	test   %ebx,%ebx
8010354e:	0f 84 c4 00 00 00    	je     80103618 <piperead+0xf8>
    if(myproc()->killed){
      release(&p->lock);
      return -1;
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80103554:	8d 9e 34 02 00 00    	lea    0x234(%esi),%ebx
8010355a:	eb 2d                	jmp    80103589 <piperead+0x69>
8010355c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103560:	83 ec 08             	sub    $0x8,%esp
80103563:	56                   	push   %esi
80103564:	53                   	push   %ebx
80103565:	e8 86 0a 00 00       	call   80103ff0 <sleep>
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010356a:	83 c4 10             	add    $0x10,%esp
8010356d:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
80103573:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
80103579:	75 35                	jne    801035b0 <piperead+0x90>
8010357b:	8b 96 40 02 00 00    	mov    0x240(%esi),%edx
80103581:	85 d2                	test   %edx,%edx
80103583:	0f 84 8f 00 00 00    	je     80103618 <piperead+0xf8>
    if(myproc()->killed){
80103589:	e8 02 03 00 00       	call   80103890 <myproc>
8010358e:	8b 48 24             	mov    0x24(%eax),%ecx
80103591:	85 c9                	test   %ecx,%ecx
80103593:	74 cb                	je     80103560 <piperead+0x40>
      release(&p->lock);
80103595:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80103598:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
      release(&p->lock);
8010359d:	56                   	push   %esi
8010359e:	e8 fd 13 00 00       	call   801049a0 <release>
      return -1;
801035a3:	83 c4 10             	add    $0x10,%esp
    addr[i] = p->data[p->nread++ % PIPESIZE];
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
  release(&p->lock);
  return i;
}
801035a6:	8d 65 f4             	lea    -0xc(%ebp),%esp
801035a9:	89 d8                	mov    %ebx,%eax
801035ab:	5b                   	pop    %ebx
801035ac:	5e                   	pop    %esi
801035ad:	5f                   	pop    %edi
801035ae:	5d                   	pop    %ebp
801035af:	c3                   	ret    
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035b0:	8b 45 10             	mov    0x10(%ebp),%eax
801035b3:	85 c0                	test   %eax,%eax
801035b5:	7e 61                	jle    80103618 <piperead+0xf8>
    if(p->nread == p->nwrite)
801035b7:	31 db                	xor    %ebx,%ebx
801035b9:	eb 13                	jmp    801035ce <piperead+0xae>
801035bb:	90                   	nop
801035bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801035c0:	8b 8e 34 02 00 00    	mov    0x234(%esi),%ecx
801035c6:	3b 8e 38 02 00 00    	cmp    0x238(%esi),%ecx
801035cc:	74 1f                	je     801035ed <piperead+0xcd>
    addr[i] = p->data[p->nread++ % PIPESIZE];
801035ce:	8d 41 01             	lea    0x1(%ecx),%eax
801035d1:	81 e1 ff 01 00 00    	and    $0x1ff,%ecx
801035d7:	89 86 34 02 00 00    	mov    %eax,0x234(%esi)
801035dd:	0f b6 44 0e 34       	movzbl 0x34(%esi,%ecx,1),%eax
801035e2:	88 04 1f             	mov    %al,(%edi,%ebx,1)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
801035e5:	83 c3 01             	add    $0x1,%ebx
801035e8:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801035eb:	75 d3                	jne    801035c0 <piperead+0xa0>
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801035ed:	8d 86 38 02 00 00    	lea    0x238(%esi),%eax
801035f3:	83 ec 0c             	sub    $0xc,%esp
801035f6:	50                   	push   %eax
801035f7:	e8 b4 0b 00 00       	call   801041b0 <wakeup>
  release(&p->lock);
801035fc:	89 34 24             	mov    %esi,(%esp)
801035ff:	e8 9c 13 00 00       	call   801049a0 <release>
  return i;
80103604:	83 c4 10             	add    $0x10,%esp
}
80103607:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010360a:	89 d8                	mov    %ebx,%eax
8010360c:	5b                   	pop    %ebx
8010360d:	5e                   	pop    %esi
8010360e:	5f                   	pop    %edi
8010360f:	5d                   	pop    %ebp
80103610:	c3                   	ret    
80103611:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103618:	31 db                	xor    %ebx,%ebx
8010361a:	eb d1                	jmp    801035ed <piperead+0xcd>
8010361c:	66 90                	xchg   %ax,%ax
8010361e:	66 90                	xchg   %ax,%ax

80103620 <allocproc>:
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc*
allocproc(void)
{
80103620:	55                   	push   %ebp
80103621:	89 e5                	mov    %esp,%ebp
80103623:	53                   	push   %ebx
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103624:	bb 14 9c 11 80       	mov    $0x80119c14,%ebx
{
80103629:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
8010362c:	68 e0 9b 11 80       	push   $0x80119be0
80103631:	e8 aa 12 00 00       	call   801048e0 <acquire>
80103636:	83 c4 10             	add    $0x10,%esp
80103639:	eb 17                	jmp    80103652 <allocproc+0x32>
8010363b:	90                   	nop
8010363c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103640:	81 c3 6c 05 00 00    	add    $0x56c,%ebx
80103646:	81 fb 14 f7 12 80    	cmp    $0x8012f714,%ebx
8010364c:	0f 83 ce 00 00 00    	jae    80103720 <allocproc+0x100>
    if(p->state == UNUSED)
80103652:	8b 43 0c             	mov    0xc(%ebx),%eax
80103655:	85 c0                	test   %eax,%eax
80103657:	75 e7                	jne    80103640 <allocproc+0x20>
  release(&ptable.lock);
  return 0;

found:
  p->state = EMBRYO;
  p->pid = nextpid++;
80103659:	a1 04 b0 10 80       	mov    0x8010b004,%eax

  release(&ptable.lock);
8010365e:	83 ec 0c             	sub    $0xc,%esp
  p->state = EMBRYO;
80103661:	c7 43 0c 01 00 00 00 	movl   $0x1,0xc(%ebx)
  p->pid = nextpid++;
80103668:	8d 50 01             	lea    0x1(%eax),%edx
8010366b:	89 43 10             	mov    %eax,0x10(%ebx)
  release(&ptable.lock);
8010366e:	68 e0 9b 11 80       	push   $0x80119be0
  p->pid = nextpid++;
80103673:	89 15 04 b0 10 80    	mov    %edx,0x8010b004
  release(&ptable.lock);
80103679:	e8 22 13 00 00       	call   801049a0 <release>

  // Allocate kernel stack.
  if((p->kstack = kalloc()) == 0){
8010367e:	e8 5d ee ff ff       	call   801024e0 <kalloc>
80103683:	83 c4 10             	add    $0x10,%esp
80103686:	85 c0                	test   %eax,%eax
80103688:	89 43 08             	mov    %eax,0x8(%ebx)
8010368b:	0f 84 a8 00 00 00    	je     80103739 <allocproc+0x119>
    return 0;
  }
  sp = p->kstack + KSTACKSIZE;

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
80103691:	8d 90 b4 0f 00 00    	lea    0xfb4(%eax),%edx
  sp -= 4;
  *(uint*)sp = (uint)trapret;

  sp -= sizeof *p->context;
  p->context = (struct context*)sp;
  memset(p->context, 0, sizeof *p->context);
80103697:	83 ec 04             	sub    $0x4,%esp
  sp -= sizeof *p->context;
8010369a:	05 9c 0f 00 00       	add    $0xf9c,%eax
  sp -= sizeof *p->tf;
8010369f:	89 53 18             	mov    %edx,0x18(%ebx)
  *(uint*)sp = (uint)trapret;
801036a2:	c7 40 14 c5 5f 10 80 	movl   $0x80105fc5,0x14(%eax)
  p->context = (struct context*)sp;
801036a9:	89 43 1c             	mov    %eax,0x1c(%ebx)
  memset(p->context, 0, sizeof *p->context);
801036ac:	6a 14                	push   $0x14
801036ae:	6a 00                	push   $0x0
801036b0:	50                   	push   %eax
801036b1:	e8 3a 13 00 00       	call   801049f0 <memset>
  p->context->eip = (uint)forkret;
801036b6:	8b 43 1c             	mov    0x1c(%ebx),%eax
801036b9:	8d 93 0c 05 00 00    	lea    0x50c(%ebx),%edx
801036bf:	83 c4 10             	add    $0x10,%esp
801036c2:	c7 40 10 50 37 10 80 	movl   $0x80103750,0x10(%eax)
801036c9:	8d 83 ec 04 00 00    	lea    0x4ec(%ebx),%eax
801036cf:	90                   	nop

  for(int i=0;i<NSIG;i++){
    p->pendingSignals[i] = 0;
801036d0:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)
    p->signalHandlers[i] = (sighandler_t) SIGIGN;
801036d7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
801036dd:	83 c0 04             	add    $0x4,%eax
  for(int i=0;i<NSIG;i++){
801036e0:	39 d0                	cmp    %edx,%eax
801036e2:	75 ec                	jne    801036d0 <allocproc+0xb0>
801036e4:	8d 93 2c 05 00 00    	lea    0x52c(%ebx),%edx
  }
  p->signalHandlers[SIGMSGSENT] = (sighandler_t) SIGMSGSENT;
801036ea:	c7 83 fc 04 00 00 04 	movl   $0x4,0x4fc(%ebx)
801036f1:	00 00 00 
  MessageBuffer temp;
  for(int i=0;i<MessageSize;i++){
801036f4:	31 c0                	xor    %eax,%eax
801036f6:	8d 76 00             	lea    0x0(%esi),%esi
801036f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    temp[i] = 0;
    *(p->msg_from_multicast+i) = *(temp+i);
80103700:	c7 04 82 00 00 00 00 	movl   $0x0,(%edx,%eax,4)
  for(int i=0;i<MessageSize;i++){
80103707:	83 c0 01             	add    $0x1,%eax
8010370a:	83 f8 10             	cmp    $0x10,%eax
8010370d:	75 f1                	jne    80103700 <allocproc+0xe0>
  }
  // p->msg_from_multicast = temp;
  

  return p;
}
8010370f:	89 d8                	mov    %ebx,%eax
80103711:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103714:	c9                   	leave  
80103715:	c3                   	ret    
80103716:	8d 76 00             	lea    0x0(%esi),%esi
80103719:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&ptable.lock);
80103720:	83 ec 0c             	sub    $0xc,%esp
  return 0;
80103723:	31 db                	xor    %ebx,%ebx
  release(&ptable.lock);
80103725:	68 e0 9b 11 80       	push   $0x80119be0
8010372a:	e8 71 12 00 00       	call   801049a0 <release>
}
8010372f:	89 d8                	mov    %ebx,%eax
  return 0;
80103731:	83 c4 10             	add    $0x10,%esp
}
80103734:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103737:	c9                   	leave  
80103738:	c3                   	ret    
    p->state = UNUSED;
80103739:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
    return 0;
80103740:	31 db                	xor    %ebx,%ebx
80103742:	eb cb                	jmp    8010370f <allocproc+0xef>
80103744:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010374a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80103750 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void
forkret(void)
{
80103750:	55                   	push   %ebp
80103751:	89 e5                	mov    %esp,%ebp
80103753:	83 ec 14             	sub    $0x14,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
80103756:	68 e0 9b 11 80       	push   $0x80119be0
8010375b:	e8 40 12 00 00       	call   801049a0 <release>

  if (first) {
80103760:	a1 00 b0 10 80       	mov    0x8010b000,%eax
80103765:	83 c4 10             	add    $0x10,%esp
80103768:	85 c0                	test   %eax,%eax
8010376a:	75 04                	jne    80103770 <forkret+0x20>
    iinit(ROOTDEV);
    initlog(ROOTDEV);
  }

  // Return to "caller", actually trapret (see allocproc).
}
8010376c:	c9                   	leave  
8010376d:	c3                   	ret    
8010376e:	66 90                	xchg   %ax,%ax
    iinit(ROOTDEV);
80103770:	83 ec 0c             	sub    $0xc,%esp
    first = 0;
80103773:	c7 05 00 b0 10 80 00 	movl   $0x0,0x8010b000
8010377a:	00 00 00 
    iinit(ROOTDEV);
8010377d:	6a 01                	push   $0x1
8010377f:	e8 0c dd ff ff       	call   80101490 <iinit>
    initlog(ROOTDEV);
80103784:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
8010378b:	e8 90 f3 ff ff       	call   80102b20 <initlog>
80103790:	83 c4 10             	add    $0x10,%esp
}
80103793:	c9                   	leave  
80103794:	c3                   	ret    
80103795:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103799:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801037a0 <pinit>:
{
801037a0:	55                   	push   %ebp
801037a1:	89 e5                	mov    %esp,%ebp
801037a3:	53                   	push   %ebx
801037a4:	bb e0 8e 11 80       	mov    $0x80118ee0,%ebx
801037a9:	83 ec 0c             	sub    $0xc,%esp
  initlock(&ptable.lock, "ptable");
801037ac:	68 55 83 10 80       	push   $0x80108355
801037b1:	68 e0 9b 11 80       	push   $0x80119be0
801037b6:	e8 e5 0f 00 00       	call   801047a0 <initlock>
801037bb:	83 c4 10             	add    $0x10,%esp
801037be:	66 90                	xchg   %ax,%ax
    initlock(&procbuffer_lock[i],"procbuffer");
801037c0:	83 ec 08             	sub    $0x8,%esp
801037c3:	68 5c 83 10 80       	push   $0x8010835c
801037c8:	53                   	push   %ebx
801037c9:	83 c3 34             	add    $0x34,%ebx
801037cc:	e8 cf 0f 00 00       	call   801047a0 <initlock>
  for(int i=0;i<NPROC;i++){
801037d1:	83 c4 10             	add    $0x10,%esp
801037d4:	81 fb e0 9b 11 80    	cmp    $0x80119be0,%ebx
801037da:	75 e4                	jne    801037c0 <pinit+0x20>
}
801037dc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801037df:	c9                   	leave  
801037e0:	c3                   	ret    
801037e1:	eb 0d                	jmp    801037f0 <mycpu>
801037e3:	90                   	nop
801037e4:	90                   	nop
801037e5:	90                   	nop
801037e6:	90                   	nop
801037e7:	90                   	nop
801037e8:	90                   	nop
801037e9:	90                   	nop
801037ea:	90                   	nop
801037eb:	90                   	nop
801037ec:	90                   	nop
801037ed:	90                   	nop
801037ee:	90                   	nop
801037ef:	90                   	nop

801037f0 <mycpu>:
{
801037f0:	55                   	push   %ebp
801037f1:	89 e5                	mov    %esp,%ebp
801037f3:	56                   	push   %esi
801037f4:	53                   	push   %ebx
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801037f5:	9c                   	pushf  
801037f6:	58                   	pop    %eax
  if(readeflags()&FL_IF)
801037f7:	f6 c4 02             	test   $0x2,%ah
801037fa:	75 5e                	jne    8010385a <mycpu+0x6a>
  apicid = lapicid();
801037fc:	e8 4f ef ff ff       	call   80102750 <lapicid>
  for (i = 0; i < ncpu; ++i) {
80103801:	8b 35 c0 8e 11 80    	mov    0x80118ec0,%esi
80103807:	85 f6                	test   %esi,%esi
80103809:	7e 42                	jle    8010384d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
8010380b:	0f b6 15 40 89 11 80 	movzbl 0x80118940,%edx
80103812:	39 d0                	cmp    %edx,%eax
80103814:	74 30                	je     80103846 <mycpu+0x56>
80103816:	b9 f0 89 11 80       	mov    $0x801189f0,%ecx
  for (i = 0; i < ncpu; ++i) {
8010381b:	31 d2                	xor    %edx,%edx
8010381d:	8d 76 00             	lea    0x0(%esi),%esi
80103820:	83 c2 01             	add    $0x1,%edx
80103823:	39 f2                	cmp    %esi,%edx
80103825:	74 26                	je     8010384d <mycpu+0x5d>
    if (cpus[i].apicid == apicid)
80103827:	0f b6 19             	movzbl (%ecx),%ebx
8010382a:	81 c1 b0 00 00 00    	add    $0xb0,%ecx
80103830:	39 c3                	cmp    %eax,%ebx
80103832:	75 ec                	jne    80103820 <mycpu+0x30>
80103834:	69 c2 b0 00 00 00    	imul   $0xb0,%edx,%eax
8010383a:	05 40 89 11 80       	add    $0x80118940,%eax
}
8010383f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103842:	5b                   	pop    %ebx
80103843:	5e                   	pop    %esi
80103844:	5d                   	pop    %ebp
80103845:	c3                   	ret    
    if (cpus[i].apicid == apicid)
80103846:	b8 40 89 11 80       	mov    $0x80118940,%eax
      return &cpus[i];
8010384b:	eb f2                	jmp    8010383f <mycpu+0x4f>
  panic("unknown apicid\n");
8010384d:	83 ec 0c             	sub    $0xc,%esp
80103850:	68 67 83 10 80       	push   $0x80108367
80103855:	e8 36 cb ff ff       	call   80100390 <panic>
    panic("mycpu called with interrupts enabled\n");
8010385a:	83 ec 0c             	sub    $0xc,%esp
8010385d:	68 b0 84 10 80       	push   $0x801084b0
80103862:	e8 29 cb ff ff       	call   80100390 <panic>
80103867:	89 f6                	mov    %esi,%esi
80103869:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103870 <cpuid>:
cpuid() {
80103870:	55                   	push   %ebp
80103871:	89 e5                	mov    %esp,%ebp
80103873:	83 ec 08             	sub    $0x8,%esp
  return mycpu()-cpus;
80103876:	e8 75 ff ff ff       	call   801037f0 <mycpu>
8010387b:	2d 40 89 11 80       	sub    $0x80118940,%eax
}
80103880:	c9                   	leave  
  return mycpu()-cpus;
80103881:	c1 f8 04             	sar    $0x4,%eax
80103884:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010388a:	c3                   	ret    
8010388b:	90                   	nop
8010388c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80103890 <myproc>:
myproc(void) {
80103890:	55                   	push   %ebp
80103891:	89 e5                	mov    %esp,%ebp
80103893:	53                   	push   %ebx
80103894:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80103897:	e8 74 0f 00 00       	call   80104810 <pushcli>
  c = mycpu();
8010389c:	e8 4f ff ff ff       	call   801037f0 <mycpu>
  p = c->proc;
801038a1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801038a7:	e8 a4 0f 00 00       	call   80104850 <popcli>
}
801038ac:	83 c4 04             	add    $0x4,%esp
801038af:	89 d8                	mov    %ebx,%eax
801038b1:	5b                   	pop    %ebx
801038b2:	5d                   	pop    %ebp
801038b3:	c3                   	ret    
801038b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801038ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801038c0 <ignoreHandler>:
void ignoreHandler(void){
801038c0:	55                   	push   %ebp
801038c1:	89 e5                	mov    %esp,%ebp
801038c3:	83 ec 14             	sub    $0x14,%esp
	cprintf("this is ignore Handler\n");
801038c6:	68 77 83 10 80       	push   $0x80108377
801038cb:	e8 90 cd ff ff       	call   80100660 <cprintf>
}
801038d0:	83 c4 10             	add    $0x10,%esp
801038d3:	c9                   	leave  
801038d4:	c3                   	ret    
801038d5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801038e0 <dflHandler>:
void dflHandler(void){
801038e0:	55                   	push   %ebp
801038e1:	89 e5                	mov    %esp,%ebp
801038e3:	83 ec 14             	sub    $0x14,%esp
  cprintf("This is default handler\n");
801038e6:	68 8f 83 10 80       	push   $0x8010838f
801038eb:	e8 70 cd ff ff       	call   80100660 <cprintf>
}
801038f0:	83 c4 10             	add    $0x10,%esp
801038f3:	c9                   	leave  
801038f4:	c3                   	ret    
801038f5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801038f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103900 <receiverHandler>:
void receiverHandler(void){
80103900:	55                   	push   %ebp
80103901:	89 e5                	mov    %esp,%ebp
80103903:	56                   	push   %esi
80103904:	53                   	push   %ebx
  recvCode = receive_msg(myproc()->pid,(void *)p);
80103905:	8d 75 f7             	lea    -0x9(%ebp),%esi
void receiverHandler(void){
80103908:	83 ec 10             	sub    $0x10,%esp
  pushcli();
8010390b:	e8 00 0f 00 00       	call   80104810 <pushcli>
  c = mycpu();
80103910:	e8 db fe ff ff       	call   801037f0 <mycpu>
  p = c->proc;
80103915:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010391b:	e8 30 0f 00 00       	call   80104850 <popcli>
  recvCode = receive_msg(myproc()->pid,(void *)p);
80103920:	83 ec 08             	sub    $0x8,%esp
80103923:	56                   	push   %esi
80103924:	ff 73 10             	pushl  0x10(%ebx)
80103927:	e8 34 42 00 00       	call   80107b60 <receive_msg>
  cprintf("%d\n",recvCode);
8010392c:	5a                   	pop    %edx
8010392d:	59                   	pop    %ecx
8010392e:	50                   	push   %eax
8010392f:	68 f4 82 10 80       	push   $0x801082f4
  recvCode = receive_msg(myproc()->pid,(void *)p);
80103934:	89 c3                	mov    %eax,%ebx
  cprintf("%d\n",recvCode);
80103936:	e8 25 cd ff ff       	call   80100660 <cprintf>
  if(recvCode<0){
8010393b:	83 c4 10             	add    $0x10,%esp
8010393e:	85 db                	test   %ebx,%ebx
80103940:	78 2e                	js     80103970 <receiverHandler+0x70>
    cprintf("Message : %s\n",p);
80103942:	83 ec 08             	sub    $0x8,%esp
80103945:	56                   	push   %esi
80103946:	68 c4 83 10 80       	push   $0x801083c4
8010394b:	e8 10 cd ff ff       	call   80100660 <cprintf>
80103950:	83 c4 10             	add    $0x10,%esp
  cprintf("this is the default handler for receiving messages\n");
80103953:	83 ec 0c             	sub    $0xc,%esp
80103956:	68 d8 84 10 80       	push   $0x801084d8
8010395b:	e8 00 cd ff ff       	call   80100660 <cprintf>
  return;
80103960:	83 c4 10             	add    $0x10,%esp
}
80103963:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103966:	5b                   	pop    %ebx
80103967:	5e                   	pop    %esi
80103968:	5d                   	pop    %ebp
80103969:	c3                   	ret    
8010396a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cprintf("Error is receiving message\n");
80103970:	83 ec 0c             	sub    $0xc,%esp
80103973:	68 a8 83 10 80       	push   $0x801083a8
80103978:	e8 e3 cc ff ff       	call   80100660 <cprintf>
8010397d:	83 c4 10             	add    $0x10,%esp
80103980:	eb d1                	jmp    80103953 <receiverHandler+0x53>
80103982:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80103989:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103990 <userinit>:
{
80103990:	55                   	push   %ebp
80103991:	89 e5                	mov    %esp,%ebp
80103993:	53                   	push   %ebx
80103994:	83 ec 04             	sub    $0x4,%esp
  p = allocproc();
80103997:	e8 84 fc ff ff       	call   80103620 <allocproc>
8010399c:	89 c3                	mov    %eax,%ebx
  initproc = p;
8010399e:	a3 78 b8 10 80       	mov    %eax,0x8010b878
  if((p->pgdir = setupkvm()) == 0)
801039a3:	e8 e8 3b 00 00       	call   80107590 <setupkvm>
801039a8:	85 c0                	test   %eax,%eax
801039aa:	89 43 04             	mov    %eax,0x4(%ebx)
801039ad:	0f 84 c3 00 00 00    	je     80103a76 <userinit+0xe6>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801039b3:	83 ec 04             	sub    $0x4,%esp
801039b6:	68 2c 00 00 00       	push   $0x2c
801039bb:	68 20 b7 10 80       	push   $0x8010b720
801039c0:	50                   	push   %eax
801039c1:	e8 aa 38 00 00       	call   80107270 <inituvm>
  memset(p->tf, 0, sizeof(*p->tf));
801039c6:	83 c4 0c             	add    $0xc,%esp
  p->sz = PGSIZE;
801039c9:	c7 03 00 10 00 00    	movl   $0x1000,(%ebx)
  memset(p->tf, 0, sizeof(*p->tf));
801039cf:	6a 4c                	push   $0x4c
801039d1:	6a 00                	push   $0x0
801039d3:	ff 73 18             	pushl  0x18(%ebx)
801039d6:	e8 15 10 00 00       	call   801049f0 <memset>
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039db:	8b 43 18             	mov    0x18(%ebx),%eax
801039de:	ba 1b 00 00 00       	mov    $0x1b,%edx
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039e3:	b9 23 00 00 00       	mov    $0x23,%ecx
  safestrcpy(p->name, "initcode", sizeof(p->name));
801039e8:	83 c4 0c             	add    $0xc,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801039eb:	66 89 50 3c          	mov    %dx,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801039ef:	8b 43 18             	mov    0x18(%ebx),%eax
801039f2:	66 89 48 2c          	mov    %cx,0x2c(%eax)
  p->tf->es = p->tf->ds;
801039f6:	8b 43 18             	mov    0x18(%ebx),%eax
801039f9:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
801039fd:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80103a01:	8b 43 18             	mov    0x18(%ebx),%eax
80103a04:	0f b7 50 2c          	movzwl 0x2c(%eax),%edx
80103a08:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
80103a0c:	8b 43 18             	mov    0x18(%ebx),%eax
80103a0f:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80103a16:	8b 43 18             	mov    0x18(%ebx),%eax
80103a19:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0;  // beginning of initcode.S
80103a20:	8b 43 18             	mov    0x18(%ebx),%eax
80103a23:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)
  safestrcpy(p->name, "initcode", sizeof(p->name));
80103a2a:	8d 83 dc 04 00 00    	lea    0x4dc(%ebx),%eax
80103a30:	6a 10                	push   $0x10
80103a32:	68 eb 83 10 80       	push   $0x801083eb
80103a37:	50                   	push   %eax
80103a38:	e8 93 11 00 00       	call   80104bd0 <safestrcpy>
  p->cwd = namei("/");
80103a3d:	c7 04 24 f4 83 10 80 	movl   $0x801083f4,(%esp)
80103a44:	e8 b7 e4 ff ff       	call   80101f00 <namei>
80103a49:	89 83 d8 04 00 00    	mov    %eax,0x4d8(%ebx)
  acquire(&ptable.lock);
80103a4f:	c7 04 24 e0 9b 11 80 	movl   $0x80119be0,(%esp)
80103a56:	e8 85 0e 00 00       	call   801048e0 <acquire>
  p->state = RUNNABLE;
80103a5b:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  release(&ptable.lock);
80103a62:	c7 04 24 e0 9b 11 80 	movl   $0x80119be0,(%esp)
80103a69:	e8 32 0f 00 00       	call   801049a0 <release>
}
80103a6e:	83 c4 10             	add    $0x10,%esp
80103a71:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103a74:	c9                   	leave  
80103a75:	c3                   	ret    
    panic("userinit: out of memory?");
80103a76:	83 ec 0c             	sub    $0xc,%esp
80103a79:	68 d2 83 10 80       	push   $0x801083d2
80103a7e:	e8 0d c9 ff ff       	call   80100390 <panic>
80103a83:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103a89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103a90 <growproc>:
{
80103a90:	55                   	push   %ebp
80103a91:	89 e5                	mov    %esp,%ebp
80103a93:	56                   	push   %esi
80103a94:	53                   	push   %ebx
80103a95:	8b 75 08             	mov    0x8(%ebp),%esi
  pushcli();
80103a98:	e8 73 0d 00 00       	call   80104810 <pushcli>
  c = mycpu();
80103a9d:	e8 4e fd ff ff       	call   801037f0 <mycpu>
  p = c->proc;
80103aa2:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103aa8:	e8 a3 0d 00 00       	call   80104850 <popcli>
  if(n > 0){
80103aad:	83 fe 00             	cmp    $0x0,%esi
  sz = curproc->sz;
80103ab0:	8b 03                	mov    (%ebx),%eax
  if(n > 0){
80103ab2:	7f 1c                	jg     80103ad0 <growproc+0x40>
  } else if(n < 0){
80103ab4:	75 3a                	jne    80103af0 <growproc+0x60>
  switchuvm(curproc);
80103ab6:	83 ec 0c             	sub    $0xc,%esp
  curproc->sz = sz;
80103ab9:	89 03                	mov    %eax,(%ebx)
  switchuvm(curproc);
80103abb:	53                   	push   %ebx
80103abc:	e8 9f 36 00 00       	call   80107160 <switchuvm>
  return 0;
80103ac1:	83 c4 10             	add    $0x10,%esp
80103ac4:	31 c0                	xor    %eax,%eax
}
80103ac6:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103ac9:	5b                   	pop    %ebx
80103aca:	5e                   	pop    %esi
80103acb:	5d                   	pop    %ebp
80103acc:	c3                   	ret    
80103acd:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103ad0:	83 ec 04             	sub    $0x4,%esp
80103ad3:	01 c6                	add    %eax,%esi
80103ad5:	56                   	push   %esi
80103ad6:	50                   	push   %eax
80103ad7:	ff 73 04             	pushl  0x4(%ebx)
80103ada:	e8 d1 38 00 00       	call   801073b0 <allocuvm>
80103adf:	83 c4 10             	add    $0x10,%esp
80103ae2:	85 c0                	test   %eax,%eax
80103ae4:	75 d0                	jne    80103ab6 <growproc+0x26>
      return -1;
80103ae6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80103aeb:	eb d9                	jmp    80103ac6 <growproc+0x36>
80103aed:	8d 76 00             	lea    0x0(%esi),%esi
    if((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80103af0:	83 ec 04             	sub    $0x4,%esp
80103af3:	01 c6                	add    %eax,%esi
80103af5:	56                   	push   %esi
80103af6:	50                   	push   %eax
80103af7:	ff 73 04             	pushl  0x4(%ebx)
80103afa:	e8 e1 39 00 00       	call   801074e0 <deallocuvm>
80103aff:	83 c4 10             	add    $0x10,%esp
80103b02:	85 c0                	test   %eax,%eax
80103b04:	75 b0                	jne    80103ab6 <growproc+0x26>
80103b06:	eb de                	jmp    80103ae6 <growproc+0x56>
80103b08:	90                   	nop
80103b09:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80103b10 <fork>:
{
80103b10:	55                   	push   %ebp
80103b11:	89 e5                	mov    %esp,%ebp
80103b13:	57                   	push   %edi
80103b14:	56                   	push   %esi
80103b15:	53                   	push   %ebx
80103b16:	83 ec 1c             	sub    $0x1c,%esp
  pushcli();
80103b19:	e8 f2 0c 00 00       	call   80104810 <pushcli>
  c = mycpu();
80103b1e:	e8 cd fc ff ff       	call   801037f0 <mycpu>
  p = c->proc;
80103b23:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103b29:	e8 22 0d 00 00       	call   80104850 <popcli>
  if((np = allocproc()) == 0){
80103b2e:	e8 ed fa ff ff       	call   80103620 <allocproc>
80103b33:	85 c0                	test   %eax,%eax
80103b35:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103b38:	0f 84 c6 00 00 00    	je     80103c04 <fork+0xf4>
  if((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0){
80103b3e:	83 ec 08             	sub    $0x8,%esp
80103b41:	ff 33                	pushl  (%ebx)
80103b43:	ff 73 04             	pushl  0x4(%ebx)
80103b46:	89 c7                	mov    %eax,%edi
80103b48:	e8 13 3b 00 00       	call   80107660 <copyuvm>
80103b4d:	83 c4 10             	add    $0x10,%esp
80103b50:	85 c0                	test   %eax,%eax
80103b52:	89 47 04             	mov    %eax,0x4(%edi)
80103b55:	0f 84 b0 00 00 00    	je     80103c0b <fork+0xfb>
  np->sz = curproc->sz;
80103b5b:	8b 03                	mov    (%ebx),%eax
80103b5d:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80103b60:	89 01                	mov    %eax,(%ecx)
  np->parent = curproc;
80103b62:	89 59 14             	mov    %ebx,0x14(%ecx)
80103b65:	89 c8                	mov    %ecx,%eax
  *np->tf = *curproc->tf;
80103b67:	8b 79 18             	mov    0x18(%ecx),%edi
80103b6a:	8b 73 18             	mov    0x18(%ebx),%esi
80103b6d:	b9 13 00 00 00       	mov    $0x13,%ecx
80103b72:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  for(i = 0; i < NOFILE; i++)
80103b74:	31 f6                	xor    %esi,%esi
  np->tf->eax = 0;
80103b76:	8b 40 18             	mov    0x18(%eax),%eax
80103b79:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)
    if(curproc->ofile[i])
80103b80:	8b 44 b3 28          	mov    0x28(%ebx,%esi,4),%eax
80103b84:	85 c0                	test   %eax,%eax
80103b86:	74 13                	je     80103b9b <fork+0x8b>
      np->ofile[i] = filedup(curproc->ofile[i]);
80103b88:	83 ec 0c             	sub    $0xc,%esp
80103b8b:	50                   	push   %eax
80103b8c:	e8 5f d2 ff ff       	call   80100df0 <filedup>
80103b91:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80103b94:	83 c4 10             	add    $0x10,%esp
80103b97:	89 44 b2 28          	mov    %eax,0x28(%edx,%esi,4)
  for(i = 0; i < NOFILE; i++)
80103b9b:	83 c6 01             	add    $0x1,%esi
80103b9e:	81 fe 2c 01 00 00    	cmp    $0x12c,%esi
80103ba4:	75 da                	jne    80103b80 <fork+0x70>
  np->cwd = idup(curproc->cwd);
80103ba6:	83 ec 0c             	sub    $0xc,%esp
80103ba9:	ff b3 d8 04 00 00    	pushl  0x4d8(%ebx)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103baf:	81 c3 dc 04 00 00    	add    $0x4dc,%ebx
  np->cwd = idup(curproc->cwd);
80103bb5:	e8 a6 da ff ff       	call   80101660 <idup>
80103bba:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103bbd:	83 c4 0c             	add    $0xc,%esp
  np->cwd = idup(curproc->cwd);
80103bc0:	89 87 d8 04 00 00    	mov    %eax,0x4d8(%edi)
  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80103bc6:	8d 87 dc 04 00 00    	lea    0x4dc(%edi),%eax
80103bcc:	6a 10                	push   $0x10
80103bce:	53                   	push   %ebx
80103bcf:	50                   	push   %eax
80103bd0:	e8 fb 0f 00 00       	call   80104bd0 <safestrcpy>
  pid = np->pid;
80103bd5:	8b 5f 10             	mov    0x10(%edi),%ebx
  acquire(&ptable.lock);
80103bd8:	c7 04 24 e0 9b 11 80 	movl   $0x80119be0,(%esp)
80103bdf:	e8 fc 0c 00 00       	call   801048e0 <acquire>
  np->state = RUNNABLE;
80103be4:	c7 47 0c 03 00 00 00 	movl   $0x3,0xc(%edi)
  release(&ptable.lock);
80103beb:	c7 04 24 e0 9b 11 80 	movl   $0x80119be0,(%esp)
80103bf2:	e8 a9 0d 00 00       	call   801049a0 <release>
  return pid;
80103bf7:	83 c4 10             	add    $0x10,%esp
}
80103bfa:	8d 65 f4             	lea    -0xc(%ebp),%esp
80103bfd:	89 d8                	mov    %ebx,%eax
80103bff:	5b                   	pop    %ebx
80103c00:	5e                   	pop    %esi
80103c01:	5f                   	pop    %edi
80103c02:	5d                   	pop    %ebp
80103c03:	c3                   	ret    
    return -1;
80103c04:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80103c09:	eb ef                	jmp    80103bfa <fork+0xea>
    kfree(np->kstack);
80103c0b:	8b 7d e4             	mov    -0x1c(%ebp),%edi
80103c0e:	83 ec 0c             	sub    $0xc,%esp
    return -1;
80103c11:	83 cb ff             	or     $0xffffffff,%ebx
    kfree(np->kstack);
80103c14:	ff 77 08             	pushl  0x8(%edi)
80103c17:	e8 14 e7 ff ff       	call   80102330 <kfree>
    np->kstack = 0;
80103c1c:	c7 47 08 00 00 00 00 	movl   $0x0,0x8(%edi)
    np->state = UNUSED;
80103c23:	c7 47 0c 00 00 00 00 	movl   $0x0,0xc(%edi)
    return -1;
80103c2a:	83 c4 10             	add    $0x10,%esp
80103c2d:	eb cb                	jmp    80103bfa <fork+0xea>
80103c2f:	90                   	nop

80103c30 <scheduler>:
{
80103c30:	55                   	push   %ebp
80103c31:	89 e5                	mov    %esp,%ebp
80103c33:	57                   	push   %edi
80103c34:	56                   	push   %esi
80103c35:	53                   	push   %ebx
80103c36:	83 ec 1c             	sub    $0x1c,%esp
  struct cpu *c = mycpu();
80103c39:	e8 b2 fb ff ff       	call   801037f0 <mycpu>
  c->proc = 0;
80103c3e:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103c45:	00 00 00 
  struct cpu *c = mycpu();
80103c48:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80103c4b:	83 c0 04             	add    $0x4,%eax
80103c4e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  asm volatile("sti");
80103c51:	fb                   	sti    
    acquire(&ptable.lock);
80103c52:	83 ec 0c             	sub    $0xc,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c55:	be 14 9c 11 80       	mov    $0x80119c14,%esi
    acquire(&ptable.lock);
80103c5a:	68 e0 9b 11 80       	push   $0x80119be0
80103c5f:	e8 7c 0c 00 00       	call   801048e0 <acquire>
80103c64:	83 c4 10             	add    $0x10,%esp
80103c67:	eb 19                	jmp    80103c82 <scheduler+0x52>
80103c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103c70:	81 c6 6c 05 00 00    	add    $0x56c,%esi
80103c76:	81 fe 14 f7 12 80    	cmp    $0x8012f714,%esi
80103c7c:	0f 83 e8 00 00 00    	jae    80103d6a <scheduler+0x13a>
      if(p->state != RUNNABLE)
80103c82:	83 7e 0c 03          	cmpl   $0x3,0xc(%esi)
80103c86:	75 e8                	jne    80103c70 <scheduler+0x40>
      c->proc = p;
80103c88:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103c8b:	8d 9e 0c 05 00 00    	lea    0x50c(%esi),%ebx
80103c91:	8d be 2c 05 00 00    	lea    0x52c(%esi),%edi
80103c97:	89 b0 ac 00 00 00    	mov    %esi,0xac(%eax)
80103c9d:	eb 58                	jmp    80103cf7 <scheduler+0xc7>
80103c9f:	90                   	nop
          switch ((int)p->signalHandlers[i])
80103ca0:	83 f8 04             	cmp    $0x4,%eax
80103ca3:	0f 84 e7 00 00 00    	je     80103d90 <scheduler+0x160>
80103ca9:	85 c0                	test   %eax,%eax
80103cab:	0f 84 cf 00 00 00    	je     80103d80 <scheduler+0x150>
              virtual_address = uva2ka(p->pgdir, (char*)p->tf->esp);
80103cb1:	8b 46 18             	mov    0x18(%esi),%eax
80103cb4:	83 ec 08             	sub    $0x8,%esp
80103cb7:	ff 70 44             	pushl  0x44(%eax)
80103cba:	ff 76 04             	pushl  0x4(%esi)
80103cbd:	e8 8e 3a 00 00       	call   80107750 <uva2ka>
              a2 = (int *) (virtual_address + ((p->tf->esp -4) &0xFFF) );
80103cc2:	8b 4e 18             	mov    0x18(%esi),%ecx
              break;
80103cc5:	83 c4 10             	add    $0x10,%esp
              a2 = (int *) (virtual_address + ((p->tf->esp -4) &0xFFF) );
80103cc8:	8b 51 44             	mov    0x44(%ecx),%edx
              *a2 = p->tf->eip;
80103ccb:	8b 49 38             	mov    0x38(%ecx),%ecx
              a2 = (int *) (virtual_address + ((p->tf->esp -4) &0xFFF) );
80103cce:	83 ea 04             	sub    $0x4,%edx
80103cd1:	81 e2 ff 0f 00 00    	and    $0xfff,%edx
              *a2 = p->tf->eip;
80103cd7:	89 0c 10             	mov    %ecx,(%eax,%edx,1)
              p->tf->esp -= 4;
80103cda:	8b 46 18             	mov    0x18(%esi),%eax
80103cdd:	83 68 44 04          	subl   $0x4,0x44(%eax)
              p->tf->eip = (uint)p->signalHandlers[i];
80103ce1:	8b 46 18             	mov    0x18(%esi),%eax
80103ce4:	8b 53 e0             	mov    -0x20(%ebx),%edx
80103ce7:	89 50 38             	mov    %edx,0x38(%eax)
              p->pendingSignals[i] = 0;
80103cea:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103cf0:	83 c3 04             	add    $0x4,%ebx
      for(int i=0;i<NSIG;i++){
80103cf3:	39 fb                	cmp    %edi,%ebx
80103cf5:	74 29                	je     80103d20 <scheduler+0xf0>
        if(p->pendingSignals[i]>0){
80103cf7:	8b 0b                	mov    (%ebx),%ecx
80103cf9:	85 c9                	test   %ecx,%ecx
80103cfb:	7e f3                	jle    80103cf0 <scheduler+0xc0>
          switch ((int)p->signalHandlers[i])
80103cfd:	8b 43 e0             	mov    -0x20(%ebx),%eax
80103d00:	83 f8 01             	cmp    $0x1,%eax
80103d03:	75 9b                	jne    80103ca0 <scheduler+0x70>
              (*tempHandler)();
80103d05:	e8 d6 fb ff ff       	call   801038e0 <dflHandler>
80103d0a:	83 c3 04             	add    $0x4,%ebx
              p->pendingSignals[i] = 0;
80103d0d:	c7 43 fc 00 00 00 00 	movl   $0x0,-0x4(%ebx)
      for(int i=0;i<NSIG;i++){
80103d14:	39 fb                	cmp    %edi,%ebx
80103d16:	75 df                	jne    80103cf7 <scheduler+0xc7>
80103d18:	90                   	nop
80103d19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      switchuvm(p);
80103d20:	83 ec 0c             	sub    $0xc,%esp
80103d23:	56                   	push   %esi
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d24:	81 c6 6c 05 00 00    	add    $0x56c,%esi
      switchuvm(p);
80103d2a:	e8 31 34 00 00       	call   80107160 <switchuvm>
      swtch(&(c->scheduler), p->context);
80103d2f:	58                   	pop    %eax
80103d30:	5a                   	pop    %edx
80103d31:	ff b6 b0 fa ff ff    	pushl  -0x550(%esi)
80103d37:	ff 75 e0             	pushl  -0x20(%ebp)
      p->state = RUNNING;
80103d3a:	c7 86 a0 fa ff ff 04 	movl   $0x4,-0x560(%esi)
80103d41:	00 00 00 
      swtch(&(c->scheduler), p->context);
80103d44:	e8 e2 0e 00 00       	call   80104c2b <swtch>
      switchkvm();
80103d49:	e8 f2 33 00 00       	call   80107140 <switchkvm>
      c->proc = 0;
80103d4e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103d51:	83 c4 10             	add    $0x10,%esp
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d54:	81 fe 14 f7 12 80    	cmp    $0x8012f714,%esi
      c->proc = 0;
80103d5a:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80103d61:	00 00 00 
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103d64:	0f 82 18 ff ff ff    	jb     80103c82 <scheduler+0x52>
    release(&ptable.lock);
80103d6a:	83 ec 0c             	sub    $0xc,%esp
80103d6d:	68 e0 9b 11 80       	push   $0x80119be0
80103d72:	e8 29 0c 00 00       	call   801049a0 <release>
    sti();
80103d77:	83 c4 10             	add    $0x10,%esp
80103d7a:	e9 d2 fe ff ff       	jmp    80103c51 <scheduler+0x21>
80103d7f:	90                   	nop
              (*tempHandler)();
80103d80:	e8 3b fb ff ff       	call   801038c0 <ignoreHandler>
              p->pendingSignals[i] = 0;
80103d85:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
              break;
80103d8b:	e9 60 ff ff ff       	jmp    80103cf0 <scheduler+0xc0>
              (*tempHandler)();
80103d90:	e8 6b fb ff ff       	call   80103900 <receiverHandler>
              p->pendingSignals[i] = 0;
80103d95:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
              break;
80103d9b:	e9 50 ff ff ff       	jmp    80103cf0 <scheduler+0xc0>

80103da0 <sched>:
{
80103da0:	55                   	push   %ebp
80103da1:	89 e5                	mov    %esp,%ebp
80103da3:	56                   	push   %esi
80103da4:	53                   	push   %ebx
  pushcli();
80103da5:	e8 66 0a 00 00       	call   80104810 <pushcli>
  c = mycpu();
80103daa:	e8 41 fa ff ff       	call   801037f0 <mycpu>
  p = c->proc;
80103daf:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103db5:	e8 96 0a 00 00       	call   80104850 <popcli>
  if(!holding(&ptable.lock))
80103dba:	83 ec 0c             	sub    $0xc,%esp
80103dbd:	68 e0 9b 11 80       	push   $0x80119be0
80103dc2:	e8 e9 0a 00 00       	call   801048b0 <holding>
80103dc7:	83 c4 10             	add    $0x10,%esp
80103dca:	85 c0                	test   %eax,%eax
80103dcc:	74 4f                	je     80103e1d <sched+0x7d>
  if(mycpu()->ncli != 1)
80103dce:	e8 1d fa ff ff       	call   801037f0 <mycpu>
80103dd3:	83 b8 a4 00 00 00 01 	cmpl   $0x1,0xa4(%eax)
80103dda:	75 68                	jne    80103e44 <sched+0xa4>
  if(p->state == RUNNING)
80103ddc:	83 7b 0c 04          	cmpl   $0x4,0xc(%ebx)
80103de0:	74 55                	je     80103e37 <sched+0x97>
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80103de2:	9c                   	pushf  
80103de3:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80103de4:	f6 c4 02             	test   $0x2,%ah
80103de7:	75 41                	jne    80103e2a <sched+0x8a>
  intena = mycpu()->intena;
80103de9:	e8 02 fa ff ff       	call   801037f0 <mycpu>
  swtch(&p->context, mycpu()->scheduler);
80103dee:	83 c3 1c             	add    $0x1c,%ebx
  intena = mycpu()->intena;
80103df1:	8b b0 a8 00 00 00    	mov    0xa8(%eax),%esi
  swtch(&p->context, mycpu()->scheduler);
80103df7:	e8 f4 f9 ff ff       	call   801037f0 <mycpu>
80103dfc:	83 ec 08             	sub    $0x8,%esp
80103dff:	ff 70 04             	pushl  0x4(%eax)
80103e02:	53                   	push   %ebx
80103e03:	e8 23 0e 00 00       	call   80104c2b <swtch>
  mycpu()->intena = intena;
80103e08:	e8 e3 f9 ff ff       	call   801037f0 <mycpu>
}
80103e0d:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
80103e10:	89 b0 a8 00 00 00    	mov    %esi,0xa8(%eax)
}
80103e16:	8d 65 f8             	lea    -0x8(%ebp),%esp
80103e19:	5b                   	pop    %ebx
80103e1a:	5e                   	pop    %esi
80103e1b:	5d                   	pop    %ebp
80103e1c:	c3                   	ret    
    panic("sched ptable.lock");
80103e1d:	83 ec 0c             	sub    $0xc,%esp
80103e20:	68 f6 83 10 80       	push   $0x801083f6
80103e25:	e8 66 c5 ff ff       	call   80100390 <panic>
    panic("sched interruptible");
80103e2a:	83 ec 0c             	sub    $0xc,%esp
80103e2d:	68 22 84 10 80       	push   $0x80108422
80103e32:	e8 59 c5 ff ff       	call   80100390 <panic>
    panic("sched running");
80103e37:	83 ec 0c             	sub    $0xc,%esp
80103e3a:	68 14 84 10 80       	push   $0x80108414
80103e3f:	e8 4c c5 ff ff       	call   80100390 <panic>
    panic("sched locks");
80103e44:	83 ec 0c             	sub    $0xc,%esp
80103e47:	68 08 84 10 80       	push   $0x80108408
80103e4c:	e8 3f c5 ff ff       	call   80100390 <panic>
80103e51:	eb 0d                	jmp    80103e60 <exit>
80103e53:	90                   	nop
80103e54:	90                   	nop
80103e55:	90                   	nop
80103e56:	90                   	nop
80103e57:	90                   	nop
80103e58:	90                   	nop
80103e59:	90                   	nop
80103e5a:	90                   	nop
80103e5b:	90                   	nop
80103e5c:	90                   	nop
80103e5d:	90                   	nop
80103e5e:	90                   	nop
80103e5f:	90                   	nop

80103e60 <exit>:
{
80103e60:	55                   	push   %ebp
80103e61:	89 e5                	mov    %esp,%ebp
80103e63:	57                   	push   %edi
80103e64:	56                   	push   %esi
80103e65:	53                   	push   %ebx
80103e66:	83 ec 0c             	sub    $0xc,%esp
  pushcli();
80103e69:	e8 a2 09 00 00       	call   80104810 <pushcli>
  c = mycpu();
80103e6e:	e8 7d f9 ff ff       	call   801037f0 <mycpu>
  p = c->proc;
80103e73:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
80103e79:	e8 d2 09 00 00       	call   80104850 <popcli>
  if(curproc == initproc)
80103e7e:	39 35 78 b8 10 80    	cmp    %esi,0x8010b878
80103e84:	8d 5e 28             	lea    0x28(%esi),%ebx
80103e87:	8d be d8 04 00 00    	lea    0x4d8(%esi),%edi
80103e8d:	0f 84 fe 00 00 00    	je     80103f91 <exit+0x131>
80103e93:	90                   	nop
80103e94:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(curproc->ofile[fd]){
80103e98:	8b 03                	mov    (%ebx),%eax
80103e9a:	85 c0                	test   %eax,%eax
80103e9c:	74 12                	je     80103eb0 <exit+0x50>
      fileclose(curproc->ofile[fd]);
80103e9e:	83 ec 0c             	sub    $0xc,%esp
80103ea1:	50                   	push   %eax
80103ea2:	e8 99 cf ff ff       	call   80100e40 <fileclose>
      curproc->ofile[fd] = 0;
80103ea7:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
80103ead:	83 c4 10             	add    $0x10,%esp
80103eb0:	83 c3 04             	add    $0x4,%ebx
  for(fd = 0; fd < NOFILE; fd++){
80103eb3:	39 fb                	cmp    %edi,%ebx
80103eb5:	75 e1                	jne    80103e98 <exit+0x38>
  begin_op();
80103eb7:	e8 04 ed ff ff       	call   80102bc0 <begin_op>
  iput(curproc->cwd);
80103ebc:	83 ec 0c             	sub    $0xc,%esp
80103ebf:	ff b6 d8 04 00 00    	pushl  0x4d8(%esi)
80103ec5:	e8 f6 d8 ff ff       	call   801017c0 <iput>
  end_op();
80103eca:	e8 61 ed ff ff       	call   80102c30 <end_op>
  curproc->cwd = 0;
80103ecf:	c7 86 d8 04 00 00 00 	movl   $0x0,0x4d8(%esi)
80103ed6:	00 00 00 
  acquire(&ptable.lock);
80103ed9:	c7 04 24 e0 9b 11 80 	movl   $0x80119be0,(%esp)
80103ee0:	e8 fb 09 00 00       	call   801048e0 <acquire>
  wakeup1(curproc->parent);
80103ee5:	8b 56 14             	mov    0x14(%esi),%edx
80103ee8:	83 c4 10             	add    $0x10,%esp
static void
wakeup1(void *chan)
{
  struct proc *p;

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103eeb:	b8 14 9c 11 80       	mov    $0x80119c14,%eax
80103ef0:	eb 12                	jmp    80103f04 <exit+0xa4>
80103ef2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80103ef8:	05 6c 05 00 00       	add    $0x56c,%eax
80103efd:	3d 14 f7 12 80       	cmp    $0x8012f714,%eax
80103f02:	73 1e                	jae    80103f22 <exit+0xc2>
    if(p->state == SLEEPING && p->chan == chan)
80103f04:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f08:	75 ee                	jne    80103ef8 <exit+0x98>
80103f0a:	3b 50 20             	cmp    0x20(%eax),%edx
80103f0d:	75 e9                	jne    80103ef8 <exit+0x98>
      p->state = RUNNABLE;
80103f0f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f16:	05 6c 05 00 00       	add    $0x56c,%eax
80103f1b:	3d 14 f7 12 80       	cmp    $0x8012f714,%eax
80103f20:	72 e2                	jb     80103f04 <exit+0xa4>
      p->parent = initproc;
80103f22:	8b 0d 78 b8 10 80    	mov    0x8010b878,%ecx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80103f28:	ba 14 9c 11 80       	mov    $0x80119c14,%edx
80103f2d:	eb 0f                	jmp    80103f3e <exit+0xde>
80103f2f:	90                   	nop
80103f30:	81 c2 6c 05 00 00    	add    $0x56c,%edx
80103f36:	81 fa 14 f7 12 80    	cmp    $0x8012f714,%edx
80103f3c:	73 3a                	jae    80103f78 <exit+0x118>
    if(p->parent == curproc){
80103f3e:	39 72 14             	cmp    %esi,0x14(%edx)
80103f41:	75 ed                	jne    80103f30 <exit+0xd0>
      if(p->state == ZOMBIE)
80103f43:	83 7a 0c 05          	cmpl   $0x5,0xc(%edx)
      p->parent = initproc;
80103f47:	89 4a 14             	mov    %ecx,0x14(%edx)
      if(p->state == ZOMBIE)
80103f4a:	75 e4                	jne    80103f30 <exit+0xd0>
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80103f4c:	b8 14 9c 11 80       	mov    $0x80119c14,%eax
80103f51:	eb 11                	jmp    80103f64 <exit+0x104>
80103f53:	90                   	nop
80103f54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80103f58:	05 6c 05 00 00       	add    $0x56c,%eax
80103f5d:	3d 14 f7 12 80       	cmp    $0x8012f714,%eax
80103f62:	73 cc                	jae    80103f30 <exit+0xd0>
    if(p->state == SLEEPING && p->chan == chan)
80103f64:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
80103f68:	75 ee                	jne    80103f58 <exit+0xf8>
80103f6a:	3b 48 20             	cmp    0x20(%eax),%ecx
80103f6d:	75 e9                	jne    80103f58 <exit+0xf8>
      p->state = RUNNABLE;
80103f6f:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
80103f76:	eb e0                	jmp    80103f58 <exit+0xf8>
  curproc->state = ZOMBIE;
80103f78:	c7 46 0c 05 00 00 00 	movl   $0x5,0xc(%esi)
  sched();
80103f7f:	e8 1c fe ff ff       	call   80103da0 <sched>
  panic("zombie exit");
80103f84:	83 ec 0c             	sub    $0xc,%esp
80103f87:	68 43 84 10 80       	push   $0x80108443
80103f8c:	e8 ff c3 ff ff       	call   80100390 <panic>
    panic("init exiting");
80103f91:	83 ec 0c             	sub    $0xc,%esp
80103f94:	68 36 84 10 80       	push   $0x80108436
80103f99:	e8 f2 c3 ff ff       	call   80100390 <panic>
80103f9e:	66 90                	xchg   %ax,%ax

80103fa0 <yield>:
{
80103fa0:	55                   	push   %ebp
80103fa1:	89 e5                	mov    %esp,%ebp
80103fa3:	53                   	push   %ebx
80103fa4:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);  //DOC: yieldlock
80103fa7:	68 e0 9b 11 80       	push   $0x80119be0
80103fac:	e8 2f 09 00 00       	call   801048e0 <acquire>
  pushcli();
80103fb1:	e8 5a 08 00 00       	call   80104810 <pushcli>
  c = mycpu();
80103fb6:	e8 35 f8 ff ff       	call   801037f0 <mycpu>
  p = c->proc;
80103fbb:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80103fc1:	e8 8a 08 00 00       	call   80104850 <popcli>
  myproc()->state = RUNNABLE;
80103fc6:	c7 43 0c 03 00 00 00 	movl   $0x3,0xc(%ebx)
  sched();
80103fcd:	e8 ce fd ff ff       	call   80103da0 <sched>
  release(&ptable.lock);
80103fd2:	c7 04 24 e0 9b 11 80 	movl   $0x80119be0,(%esp)
80103fd9:	e8 c2 09 00 00       	call   801049a0 <release>
}
80103fde:	83 c4 10             	add    $0x10,%esp
80103fe1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80103fe4:	c9                   	leave  
80103fe5:	c3                   	ret    
80103fe6:	8d 76 00             	lea    0x0(%esi),%esi
80103fe9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80103ff0 <sleep>:
{
80103ff0:	55                   	push   %ebp
80103ff1:	89 e5                	mov    %esp,%ebp
80103ff3:	57                   	push   %edi
80103ff4:	56                   	push   %esi
80103ff5:	53                   	push   %ebx
80103ff6:	83 ec 0c             	sub    $0xc,%esp
80103ff9:	8b 7d 08             	mov    0x8(%ebp),%edi
80103ffc:	8b 75 0c             	mov    0xc(%ebp),%esi
  pushcli();
80103fff:	e8 0c 08 00 00       	call   80104810 <pushcli>
  c = mycpu();
80104004:	e8 e7 f7 ff ff       	call   801037f0 <mycpu>
  p = c->proc;
80104009:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
8010400f:	e8 3c 08 00 00       	call   80104850 <popcli>
  if(p == 0)
80104014:	85 db                	test   %ebx,%ebx
80104016:	0f 84 87 00 00 00    	je     801040a3 <sleep+0xb3>
  if(lk == 0)
8010401c:	85 f6                	test   %esi,%esi
8010401e:	74 76                	je     80104096 <sleep+0xa6>
  if(lk != &ptable.lock){  //DOC: sleeplock0
80104020:	81 fe e0 9b 11 80    	cmp    $0x80119be0,%esi
80104026:	74 50                	je     80104078 <sleep+0x88>
    acquire(&ptable.lock);  //DOC: sleeplock1
80104028:	83 ec 0c             	sub    $0xc,%esp
8010402b:	68 e0 9b 11 80       	push   $0x80119be0
80104030:	e8 ab 08 00 00       	call   801048e0 <acquire>
    release(lk);
80104035:	89 34 24             	mov    %esi,(%esp)
80104038:	e8 63 09 00 00       	call   801049a0 <release>
  p->chan = chan;
8010403d:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
80104040:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104047:	e8 54 fd ff ff       	call   80103da0 <sched>
  p->chan = 0;
8010404c:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
    release(&ptable.lock);
80104053:	c7 04 24 e0 9b 11 80 	movl   $0x80119be0,(%esp)
8010405a:	e8 41 09 00 00       	call   801049a0 <release>
    acquire(lk);
8010405f:	89 75 08             	mov    %esi,0x8(%ebp)
80104062:	83 c4 10             	add    $0x10,%esp
}
80104065:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104068:	5b                   	pop    %ebx
80104069:	5e                   	pop    %esi
8010406a:	5f                   	pop    %edi
8010406b:	5d                   	pop    %ebp
    acquire(lk);
8010406c:	e9 6f 08 00 00       	jmp    801048e0 <acquire>
80104071:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  p->chan = chan;
80104078:	89 7b 20             	mov    %edi,0x20(%ebx)
  p->state = SLEEPING;
8010407b:	c7 43 0c 02 00 00 00 	movl   $0x2,0xc(%ebx)
  sched();
80104082:	e8 19 fd ff ff       	call   80103da0 <sched>
  p->chan = 0;
80104087:	c7 43 20 00 00 00 00 	movl   $0x0,0x20(%ebx)
}
8010408e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104091:	5b                   	pop    %ebx
80104092:	5e                   	pop    %esi
80104093:	5f                   	pop    %edi
80104094:	5d                   	pop    %ebp
80104095:	c3                   	ret    
    panic("sleep without lk");
80104096:	83 ec 0c             	sub    $0xc,%esp
80104099:	68 55 84 10 80       	push   $0x80108455
8010409e:	e8 ed c2 ff ff       	call   80100390 <panic>
    panic("sleep");
801040a3:	83 ec 0c             	sub    $0xc,%esp
801040a6:	68 4f 84 10 80       	push   $0x8010844f
801040ab:	e8 e0 c2 ff ff       	call   80100390 <panic>

801040b0 <wait>:
{
801040b0:	55                   	push   %ebp
801040b1:	89 e5                	mov    %esp,%ebp
801040b3:	56                   	push   %esi
801040b4:	53                   	push   %ebx
  pushcli();
801040b5:	e8 56 07 00 00       	call   80104810 <pushcli>
  c = mycpu();
801040ba:	e8 31 f7 ff ff       	call   801037f0 <mycpu>
  p = c->proc;
801040bf:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801040c5:	e8 86 07 00 00       	call   80104850 <popcli>
  acquire(&ptable.lock);
801040ca:	83 ec 0c             	sub    $0xc,%esp
801040cd:	68 e0 9b 11 80       	push   $0x80119be0
801040d2:	e8 09 08 00 00       	call   801048e0 <acquire>
801040d7:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
801040da:	31 c0                	xor    %eax,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801040dc:	bb 14 9c 11 80       	mov    $0x80119c14,%ebx
801040e1:	eb 13                	jmp    801040f6 <wait+0x46>
801040e3:	90                   	nop
801040e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
801040e8:	81 c3 6c 05 00 00    	add    $0x56c,%ebx
801040ee:	81 fb 14 f7 12 80    	cmp    $0x8012f714,%ebx
801040f4:	73 1e                	jae    80104114 <wait+0x64>
      if(p->parent != curproc)
801040f6:	39 73 14             	cmp    %esi,0x14(%ebx)
801040f9:	75 ed                	jne    801040e8 <wait+0x38>
      if(p->state == ZOMBIE){
801040fb:	83 7b 0c 05          	cmpl   $0x5,0xc(%ebx)
801040ff:	74 37                	je     80104138 <wait+0x88>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104101:	81 c3 6c 05 00 00    	add    $0x56c,%ebx
      havekids = 1;
80104107:	b8 01 00 00 00       	mov    $0x1,%eax
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
8010410c:	81 fb 14 f7 12 80    	cmp    $0x8012f714,%ebx
80104112:	72 e2                	jb     801040f6 <wait+0x46>
    if(!havekids || curproc->killed){
80104114:	85 c0                	test   %eax,%eax
80104116:	74 79                	je     80104191 <wait+0xe1>
80104118:	8b 46 24             	mov    0x24(%esi),%eax
8010411b:	85 c0                	test   %eax,%eax
8010411d:	75 72                	jne    80104191 <wait+0xe1>
    sleep(curproc, &ptable.lock);  //DOC: wait-sleep
8010411f:	83 ec 08             	sub    $0x8,%esp
80104122:	68 e0 9b 11 80       	push   $0x80119be0
80104127:	56                   	push   %esi
80104128:	e8 c3 fe ff ff       	call   80103ff0 <sleep>
    havekids = 0;
8010412d:	83 c4 10             	add    $0x10,%esp
80104130:	eb a8                	jmp    801040da <wait+0x2a>
80104132:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        kfree(p->kstack);
80104138:	83 ec 0c             	sub    $0xc,%esp
8010413b:	ff 73 08             	pushl  0x8(%ebx)
        pid = p->pid;
8010413e:	8b 73 10             	mov    0x10(%ebx),%esi
        kfree(p->kstack);
80104141:	e8 ea e1 ff ff       	call   80102330 <kfree>
        freevm(p->pgdir);
80104146:	5a                   	pop    %edx
80104147:	ff 73 04             	pushl  0x4(%ebx)
        p->kstack = 0;
8010414a:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
        freevm(p->pgdir);
80104151:	e8 ba 33 00 00       	call   80107510 <freevm>
        release(&ptable.lock);
80104156:	c7 04 24 e0 9b 11 80 	movl   $0x80119be0,(%esp)
        p->pid = 0;
8010415d:	c7 43 10 00 00 00 00 	movl   $0x0,0x10(%ebx)
        p->parent = 0;
80104164:	c7 43 14 00 00 00 00 	movl   $0x0,0x14(%ebx)
        p->name[0] = 0;
8010416b:	c6 83 dc 04 00 00 00 	movb   $0x0,0x4dc(%ebx)
        p->killed = 0;
80104172:	c7 43 24 00 00 00 00 	movl   $0x0,0x24(%ebx)
        p->state = UNUSED;
80104179:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
        release(&ptable.lock);
80104180:	e8 1b 08 00 00       	call   801049a0 <release>
        return pid;
80104185:	83 c4 10             	add    $0x10,%esp
}
80104188:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010418b:	89 f0                	mov    %esi,%eax
8010418d:	5b                   	pop    %ebx
8010418e:	5e                   	pop    %esi
8010418f:	5d                   	pop    %ebp
80104190:	c3                   	ret    
      release(&ptable.lock);
80104191:	83 ec 0c             	sub    $0xc,%esp
      return -1;
80104194:	be ff ff ff ff       	mov    $0xffffffff,%esi
      release(&ptable.lock);
80104199:	68 e0 9b 11 80       	push   $0x80119be0
8010419e:	e8 fd 07 00 00       	call   801049a0 <release>
      return -1;
801041a3:	83 c4 10             	add    $0x10,%esp
801041a6:	eb e0                	jmp    80104188 <wait+0xd8>
801041a8:	90                   	nop
801041a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801041b0 <wakeup>:
}

// Wake up all processes sleeping on chan.
void
wakeup(void *chan)
{
801041b0:	55                   	push   %ebp
801041b1:	89 e5                	mov    %esp,%ebp
801041b3:	53                   	push   %ebx
801041b4:	83 ec 10             	sub    $0x10,%esp
801041b7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&ptable.lock);
801041ba:	68 e0 9b 11 80       	push   $0x80119be0
801041bf:	e8 1c 07 00 00       	call   801048e0 <acquire>
801041c4:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041c7:	b8 14 9c 11 80       	mov    $0x80119c14,%eax
801041cc:	eb 0e                	jmp    801041dc <wakeup+0x2c>
801041ce:	66 90                	xchg   %ax,%ax
801041d0:	05 6c 05 00 00       	add    $0x56c,%eax
801041d5:	3d 14 f7 12 80       	cmp    $0x8012f714,%eax
801041da:	73 1e                	jae    801041fa <wakeup+0x4a>
    if(p->state == SLEEPING && p->chan == chan)
801041dc:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
801041e0:	75 ee                	jne    801041d0 <wakeup+0x20>
801041e2:	3b 58 20             	cmp    0x20(%eax),%ebx
801041e5:	75 e9                	jne    801041d0 <wakeup+0x20>
      p->state = RUNNABLE;
801041e7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801041ee:	05 6c 05 00 00       	add    $0x56c,%eax
801041f3:	3d 14 f7 12 80       	cmp    $0x8012f714,%eax
801041f8:	72 e2                	jb     801041dc <wakeup+0x2c>
  wakeup1(chan);
  release(&ptable.lock);
801041fa:	c7 45 08 e0 9b 11 80 	movl   $0x80119be0,0x8(%ebp)
}
80104201:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104204:	c9                   	leave  
  release(&ptable.lock);
80104205:	e9 96 07 00 00       	jmp    801049a0 <release>
8010420a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104210 <kill>:
// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int
kill(int pid)
{
80104210:	55                   	push   %ebp
80104211:	89 e5                	mov    %esp,%ebp
80104213:	53                   	push   %ebx
80104214:	83 ec 10             	sub    $0x10,%esp
80104217:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *p;

  acquire(&ptable.lock);
8010421a:	68 e0 9b 11 80       	push   $0x80119be0
8010421f:	e8 bc 06 00 00       	call   801048e0 <acquire>
80104224:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104227:	b8 14 9c 11 80       	mov    $0x80119c14,%eax
8010422c:	eb 0e                	jmp    8010423c <kill+0x2c>
8010422e:	66 90                	xchg   %ax,%ax
80104230:	05 6c 05 00 00       	add    $0x56c,%eax
80104235:	3d 14 f7 12 80       	cmp    $0x8012f714,%eax
8010423a:	73 34                	jae    80104270 <kill+0x60>
    if(p->pid == pid){
8010423c:	39 58 10             	cmp    %ebx,0x10(%eax)
8010423f:	75 ef                	jne    80104230 <kill+0x20>
      p->killed = 1;
      // Wake process from sleep if necessary.
      if(p->state == SLEEPING)
80104241:	83 78 0c 02          	cmpl   $0x2,0xc(%eax)
      p->killed = 1;
80104245:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      if(p->state == SLEEPING)
8010424c:	75 07                	jne    80104255 <kill+0x45>
        p->state = RUNNABLE;
8010424e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      release(&ptable.lock);
80104255:	83 ec 0c             	sub    $0xc,%esp
80104258:	68 e0 9b 11 80       	push   $0x80119be0
8010425d:	e8 3e 07 00 00       	call   801049a0 <release>
      return 0;
80104262:	83 c4 10             	add    $0x10,%esp
80104265:	31 c0                	xor    %eax,%eax
    }
  }
  release(&ptable.lock);
  return -1;
}
80104267:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010426a:	c9                   	leave  
8010426b:	c3                   	ret    
8010426c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  release(&ptable.lock);
80104270:	83 ec 0c             	sub    $0xc,%esp
80104273:	68 e0 9b 11 80       	push   $0x80119be0
80104278:	e8 23 07 00 00       	call   801049a0 <release>
  return -1;
8010427d:	83 c4 10             	add    $0x10,%esp
80104280:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104285:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104288:	c9                   	leave  
80104289:	c3                   	ret    
8010428a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104290 <killHandler>:
void killHandler(void){
80104290:	55                   	push   %ebp
80104291:	89 e5                	mov    %esp,%ebp
80104293:	53                   	push   %ebx
80104294:	83 ec 04             	sub    $0x4,%esp
  pushcli();
80104297:	e8 74 05 00 00       	call   80104810 <pushcli>
  c = mycpu();
8010429c:	e8 4f f5 ff ff       	call   801037f0 <mycpu>
  p = c->proc;
801042a1:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
801042a7:	e8 a4 05 00 00       	call   80104850 <popcli>
  release(&ptable.lock);
801042ac:	83 ec 0c             	sub    $0xc,%esp
801042af:	68 e0 9b 11 80       	push   $0x80119be0
801042b4:	e8 e7 06 00 00       	call   801049a0 <release>
	kill(curproc->pid);
801042b9:	58                   	pop    %eax
801042ba:	ff 73 10             	pushl  0x10(%ebx)
801042bd:	e8 4e ff ff ff       	call   80104210 <kill>
	acquire(&ptable.lock);
801042c2:	c7 04 24 e0 9b 11 80 	movl   $0x80119be0,(%esp)
801042c9:	e8 12 06 00 00       	call   801048e0 <acquire>
}
801042ce:	83 c4 10             	add    $0x10,%esp
801042d1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801042d4:	c9                   	leave  
801042d5:	c3                   	ret    
801042d6:	8d 76 00             	lea    0x0(%esi),%esi
801042d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801042e0 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
801042e0:	55                   	push   %ebp
801042e1:	89 e5                	mov    %esp,%ebp
801042e3:	57                   	push   %edi
801042e4:	56                   	push   %esi
801042e5:	53                   	push   %ebx
801042e6:	8d 75 e8             	lea    -0x18(%ebp),%esi
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801042e9:	bb 14 9c 11 80       	mov    $0x80119c14,%ebx
{
801042ee:	83 ec 3c             	sub    $0x3c,%esp
801042f1:	eb 27                	jmp    8010431a <procdump+0x3a>
801042f3:	90                   	nop
801042f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(p->state == SLEEPING){
      getcallerpcs((uint*)p->context->ebp+2, pc);
      for(i=0; i<10 && pc[i] != 0; i++)
        cprintf(" %p", pc[i]);
    }
    cprintf("\n");
801042f8:	83 ec 0c             	sub    $0xc,%esp
801042fb:	68 7b 88 10 80       	push   $0x8010887b
80104300:	e8 5b c3 ff ff       	call   80100660 <cprintf>
80104305:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
80104308:	81 c3 6c 05 00 00    	add    $0x56c,%ebx
8010430e:	81 fb 14 f7 12 80    	cmp    $0x8012f714,%ebx
80104314:	0f 83 96 00 00 00    	jae    801043b0 <procdump+0xd0>
    if(p->state == UNUSED)
8010431a:	8b 43 0c             	mov    0xc(%ebx),%eax
8010431d:	85 c0                	test   %eax,%eax
8010431f:	74 e7                	je     80104308 <procdump+0x28>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104321:	83 f8 05             	cmp    $0x5,%eax
      state = "???";
80104324:	ba 66 84 10 80       	mov    $0x80108466,%edx
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
80104329:	77 11                	ja     8010433c <procdump+0x5c>
8010432b:	8b 14 85 0c 85 10 80 	mov    -0x7fef7af4(,%eax,4),%edx
      state = "???";
80104332:	b8 66 84 10 80       	mov    $0x80108466,%eax
80104337:	85 d2                	test   %edx,%edx
80104339:	0f 44 d0             	cmove  %eax,%edx
    cprintf("%d %s %s", p->pid, state, p->name);
8010433c:	8d 83 dc 04 00 00    	lea    0x4dc(%ebx),%eax
80104342:	50                   	push   %eax
80104343:	52                   	push   %edx
80104344:	ff 73 10             	pushl  0x10(%ebx)
80104347:	68 6a 84 10 80       	push   $0x8010846a
8010434c:	e8 0f c3 ff ff       	call   80100660 <cprintf>
    if(p->state == SLEEPING){
80104351:	83 c4 10             	add    $0x10,%esp
80104354:	83 7b 0c 02          	cmpl   $0x2,0xc(%ebx)
80104358:	75 9e                	jne    801042f8 <procdump+0x18>
      getcallerpcs((uint*)p->context->ebp+2, pc);
8010435a:	8d 45 c0             	lea    -0x40(%ebp),%eax
8010435d:	83 ec 08             	sub    $0x8,%esp
80104360:	8d 7d c0             	lea    -0x40(%ebp),%edi
80104363:	50                   	push   %eax
80104364:	8b 43 1c             	mov    0x1c(%ebx),%eax
80104367:	8b 40 0c             	mov    0xc(%eax),%eax
8010436a:	83 c0 08             	add    $0x8,%eax
8010436d:	50                   	push   %eax
8010436e:	e8 4d 04 00 00       	call   801047c0 <getcallerpcs>
80104373:	83 c4 10             	add    $0x10,%esp
80104376:	8d 76 00             	lea    0x0(%esi),%esi
80104379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      for(i=0; i<10 && pc[i] != 0; i++)
80104380:	8b 17                	mov    (%edi),%edx
80104382:	85 d2                	test   %edx,%edx
80104384:	0f 84 6e ff ff ff    	je     801042f8 <procdump+0x18>
        cprintf(" %p", pc[i]);
8010438a:	83 ec 08             	sub    $0x8,%esp
8010438d:	83 c7 04             	add    $0x4,%edi
80104390:	52                   	push   %edx
80104391:	68 3a 7e 10 80       	push   $0x80107e3a
80104396:	e8 c5 c2 ff ff       	call   80100660 <cprintf>
      for(i=0; i<10 && pc[i] != 0; i++)
8010439b:	83 c4 10             	add    $0x10,%esp
8010439e:	39 fe                	cmp    %edi,%esi
801043a0:	75 de                	jne    80104380 <procdump+0xa0>
801043a2:	e9 51 ff ff ff       	jmp    801042f8 <procdump+0x18>
801043a7:	89 f6                	mov    %esi,%esi
801043a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  }
}
801043b0:	8d 65 f4             	lea    -0xc(%ebp),%esp
801043b3:	5b                   	pop    %ebx
801043b4:	5e                   	pop    %esi
801043b5:	5f                   	pop    %edi
801043b6:	5d                   	pop    %ebp
801043b7:	c3                   	ret    
801043b8:	90                   	nop
801043b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

801043c0 <print_ps>:

//CUSTOM -------------------------------------------------------------------------------------------------------------------------------------------

void 
print_ps(void)
{
801043c0:	55                   	push   %ebp
801043c1:	89 e5                	mov    %esp,%ebp
801043c3:	53                   	push   %ebx
  struct proc *p;
  acquire(&ptable.lock);
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043c4:	bb 14 9c 11 80       	mov    $0x80119c14,%ebx
{
801043c9:	83 ec 10             	sub    $0x10,%esp
  acquire(&ptable.lock);
801043cc:	68 e0 9b 11 80       	push   $0x80119be0
801043d1:	e8 0a 05 00 00       	call   801048e0 <acquire>
801043d6:	83 c4 10             	add    $0x10,%esp
801043d9:	eb 13                	jmp    801043ee <print_ps+0x2e>
801043db:	90                   	nop
801043dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043e0:	81 c3 6c 05 00 00    	add    $0x56c,%ebx
801043e6:	81 fb 14 f7 12 80    	cmp    $0x8012f714,%ebx
801043ec:	73 32                	jae    80104420 <print_ps+0x60>
    if(p->state != UNUSED)
801043ee:	8b 43 0c             	mov    0xc(%ebx),%eax
801043f1:	85 c0                	test   %eax,%eax
801043f3:	74 eb                	je     801043e0 <print_ps+0x20>
      cprintf("pid:%d name:%s\n",p->pid,p->name);
801043f5:	8d 83 dc 04 00 00    	lea    0x4dc(%ebx),%eax
801043fb:	83 ec 04             	sub    $0x4,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801043fe:	81 c3 6c 05 00 00    	add    $0x56c,%ebx
      cprintf("pid:%d name:%s\n",p->pid,p->name);
80104404:	50                   	push   %eax
80104405:	ff b3 a4 fa ff ff    	pushl  -0x55c(%ebx)
8010440b:	68 73 84 10 80       	push   $0x80108473
80104410:	e8 4b c2 ff ff       	call   80100660 <cprintf>
80104415:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104418:	81 fb 14 f7 12 80    	cmp    $0x8012f714,%ebx
8010441e:	72 ce                	jb     801043ee <print_ps+0x2e>
  release(&ptable.lock);
80104420:	83 ec 0c             	sub    $0xc,%esp
80104423:	68 e0 9b 11 80       	push   $0x80119be0
80104428:	e8 73 05 00 00       	call   801049a0 <release>
}
8010442d:	83 c4 10             	add    $0x10,%esp
80104430:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104433:	c9                   	leave  
80104434:	c3                   	ret    
80104435:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104439:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104440 <sleep_receiver>:

int
sleep_receiver(void)
{
80104440:	55                   	push   %ebp
80104441:	89 e5                	mov    %esp,%ebp
80104443:	53                   	push   %ebx
80104444:	83 ec 10             	sub    $0x10,%esp
  // cprintf("calling sleep %d \n",myproc()->pid);
  acquire(&ptable.lock);
80104447:	68 e0 9b 11 80       	push   $0x80119be0
8010444c:	e8 8f 04 00 00       	call   801048e0 <acquire>
  pushcli();
80104451:	e8 ba 03 00 00       	call   80104810 <pushcli>
  c = mycpu();
80104456:	e8 95 f3 ff ff       	call   801037f0 <mycpu>
  p = c->proc;
8010445b:	8b 98 ac 00 00 00    	mov    0xac(%eax),%ebx
  popcli();
80104461:	e8 ea 03 00 00       	call   80104850 <popcli>
  sleep((void *)myproc()->pid,&ptable.lock);
80104466:	58                   	pop    %eax
80104467:	5a                   	pop    %edx
80104468:	68 e0 9b 11 80       	push   $0x80119be0
8010446d:	ff 73 10             	pushl  0x10(%ebx)
80104470:	e8 7b fb ff ff       	call   80103ff0 <sleep>
  release(&ptable.lock);
80104475:	c7 04 24 e0 9b 11 80 	movl   $0x80119be0,(%esp)
8010447c:	e8 1f 05 00 00       	call   801049a0 <release>
  return 0;
}
80104481:	31 c0                	xor    %eax,%eax
80104483:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104486:	c9                   	leave  
80104487:	c3                   	ret    
80104488:	90                   	nop
80104489:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80104490 <signal>:

int
signal(int signal_number, sighandler_t handler){
80104490:	55                   	push   %ebp
80104491:	89 e5                	mov    %esp,%ebp
80104493:	56                   	push   %esi
80104494:	53                   	push   %ebx
80104495:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(signal_number>=0 && signal_number<NSIG){
80104498:	83 fb 07             	cmp    $0x7,%ebx
8010449b:	77 2b                	ja     801044c8 <signal+0x38>
  pushcli();
8010449d:	e8 6e 03 00 00       	call   80104810 <pushcli>
  c = mycpu();
801044a2:	e8 49 f3 ff ff       	call   801037f0 <mycpu>
  p = c->proc;
801044a7:	8b b0 ac 00 00 00    	mov    0xac(%eax),%esi
  popcli();
801044ad:	e8 9e 03 00 00       	call   80104850 <popcli>
    // struct cpu *c = mycpu();
    // cprintf("inside signal call \n");
    // cprintf("signal : %d  , handler : %d  and pid : %d \n",signal_number,(int)handler,myproc()->pid);
    myproc()->signalHandlers[signal_number] = handler;
801044b2:	8b 45 0c             	mov    0xc(%ebp),%eax
801044b5:	89 84 9e ec 04 00 00 	mov    %eax,0x4ec(%esi,%ebx,4)
    // c->proc->signalHandlers[signal_number] = handler;
  }else{
    return -1;
  }
  return 0;
801044bc:	31 c0                	xor    %eax,%eax
}
801044be:	5b                   	pop    %ebx
801044bf:	5e                   	pop    %esi
801044c0:	5d                   	pop    %ebp
801044c1:	c3                   	ret    
801044c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return -1;
801044c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801044cd:	eb ef                	jmp    801044be <signal+0x2e>
801044cf:	90                   	nop

801044d0 <sigraise>:

int
sigraise(int pid, int signal_number){
801044d0:	55                   	push   %ebp
801044d1:	89 e5                	mov    %esp,%ebp
801044d3:	53                   	push   %ebx
801044d4:	83 ec 10             	sub    $0x10,%esp
801044d7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  // struct cpu *c = mycpu();
  struct proc *p;
	int flag = 0; //flaging if we broke the loop, if we didn't, pid does not exist
	acquire(&ptable.lock);
801044da:	68 e0 9b 11 80       	push   $0x80119be0
801044df:	e8 fc 03 00 00       	call   801048e0 <acquire>
801044e4:	83 c4 10             	add    $0x10,%esp
	for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
801044e7:	b8 14 9c 11 80       	mov    $0x80119c14,%eax
801044ec:	eb 0e                	jmp    801044fc <sigraise+0x2c>
801044ee:	66 90                	xchg   %ax,%ax
801044f0:	05 6c 05 00 00       	add    $0x56c,%eax
801044f5:	3d 14 f7 12 80       	cmp    $0x8012f714,%eax
801044fa:	73 34                	jae    80104530 <sigraise+0x60>
		if (p->pid == pid){
801044fc:	39 58 10             	cmp    %ebx,0x10(%eax)
801044ff:	75 ef                	jne    801044f0 <sigraise+0x20>
		release(&ptable.lock);
		return -1;
	}
  // cprintf("inside sigraise\n");
  // cprintf("signal : %d and pid : %d should be %d \n", signal_number , p->pid,pid);
	p->pendingSignals[signal_number] = 1;
80104501:	8b 55 0c             	mov    0xc(%ebp),%edx
	
	release(&ptable.lock);
80104504:	83 ec 0c             	sub    $0xc,%esp
	p->pendingSignals[signal_number] = 1;
80104507:	c7 84 90 0c 05 00 00 	movl   $0x1,0x50c(%eax,%edx,4)
8010450e:	01 00 00 00 
	release(&ptable.lock);
80104512:	68 e0 9b 11 80       	push   $0x80119be0
80104517:	e8 84 04 00 00       	call   801049a0 <release>
  return 0;
8010451c:	83 c4 10             	add    $0x10,%esp
8010451f:	31 c0                	xor    %eax,%eax
}
80104521:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104524:	c9                   	leave  
80104525:	c3                   	ret    
80104526:	8d 76 00             	lea    0x0(%esi),%esi
80104529:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
		release(&ptable.lock);
80104530:	83 ec 0c             	sub    $0xc,%esp
80104533:	68 e0 9b 11 80       	push   $0x80119be0
80104538:	e8 63 04 00 00       	call   801049a0 <release>
		return -1;
8010453d:	83 c4 10             	add    $0x10,%esp
80104540:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104545:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104548:	c9                   	leave  
80104549:	c3                   	ret    
8010454a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104550 <sent_to_proc_buffer>:

int
sent_to_proc_buffer(int s_pid,int r_pid,void *msg)
{
80104550:	55                   	push   %ebp
80104551:	89 e5                	mov    %esp,%ebp
80104553:	57                   	push   %edi
80104554:	56                   	push   %esi
80104555:	53                   	push   %ebx
80104556:	83 ec 18             	sub    $0x18,%esp
80104559:	8b 7d 0c             	mov    0xc(%ebp),%edi
8010455c:	8b 75 10             	mov    0x10(%ebp),%esi
    acquire(&procbuffer_lock[r_pid]);
8010455f:	6b df 34             	imul   $0x34,%edi,%ebx
80104562:	81 c3 e0 8e 11 80    	add    $0x80118ee0,%ebx
80104568:	53                   	push   %ebx
80104569:	e8 72 03 00 00       	call   801048e0 <acquire>
    struct proc *p;
    acquire(&ptable.lock);
8010456e:	c7 04 24 e0 9b 11 80 	movl   $0x80119be0,(%esp)
80104575:	e8 66 03 00 00       	call   801048e0 <acquire>
8010457a:	83 c4 10             	add    $0x10,%esp

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010457d:	b8 14 9c 11 80       	mov    $0x80119c14,%eax
80104582:	eb 10                	jmp    80104594 <sent_to_proc_buffer+0x44>
80104584:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104588:	05 6c 05 00 00       	add    $0x56c,%eax
8010458d:	3d 14 f7 12 80       	cmp    $0x8012f714,%eax
80104592:	73 05                	jae    80104599 <sent_to_proc_buffer+0x49>
      if(p->pid == r_pid)
80104594:	39 78 10             	cmp    %edi,0x10(%eax)
80104597:	75 ef                	jne    80104588 <sent_to_proc_buffer+0x38>
80104599:	8d 90 2c 05 00 00    	lea    0x52c(%eax),%edx
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010459f:	b8 01 00 00 00       	mov    $0x1,%eax
801045a4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    temp_msg = (int *)msg;
    // acquire(&message_buffer_lock[msg_no]);
    
    for(int i=1;i<MessageSize;i++){
        // cprintf("%d: %d\n",i,*(temp_msg+i));
        *(p->msg_from_multicast+i) = *(temp_msg+i-1);
801045a8:	8b 4c 86 fc          	mov    -0x4(%esi,%eax,4),%ecx
801045ac:	89 0c 82             	mov    %ecx,(%edx,%eax,4)
    for(int i=1;i<MessageSize;i++){
801045af:	83 c0 01             	add    $0x1,%eax
801045b2:	83 f8 10             	cmp    $0x10,%eax
801045b5:	75 f1                	jne    801045a8 <sent_to_proc_buffer+0x58>
    }
    release(&ptable.lock);
801045b7:	83 ec 0c             	sub    $0xc,%esp
801045ba:	68 e0 9b 11 80       	push   $0x80119be0
801045bf:	e8 dc 03 00 00       	call   801049a0 <release>
    release(&procbuffer_lock[r_pid]);
801045c4:	89 1c 24             	mov    %ebx,(%esp)
801045c7:	e8 d4 03 00 00       	call   801049a0 <release>
    return 0;
}
801045cc:	8d 65 f4             	lea    -0xc(%ebp),%esp
801045cf:	31 c0                	xor    %eax,%eax
801045d1:	5b                   	pop    %ebx
801045d2:	5e                   	pop    %esi
801045d3:	5f                   	pop    %edi
801045d4:	5d                   	pop    %ebp
801045d5:	c3                   	ret    
801045d6:	8d 76 00             	lea    0x0(%esi),%esi
801045d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801045e0 <receive_from_procbuffer>:

int
receive_from_procbuffer(int myid,void* msg)
{
801045e0:	55                   	push   %ebp
801045e1:	89 e5                	mov    %esp,%ebp
801045e3:	57                   	push   %edi
801045e4:	56                   	push   %esi
801045e5:	53                   	push   %ebx
801045e6:	83 ec 18             	sub    $0x18,%esp
801045e9:	8b 7d 08             	mov    0x8(%ebp),%edi
801045ec:	8b 75 0c             	mov    0xc(%ebp),%esi
  acquire(&procbuffer_lock[myid]);
801045ef:	6b df 34             	imul   $0x34,%edi,%ebx
801045f2:	81 c3 e0 8e 11 80    	add    $0x80118ee0,%ebx
801045f8:	53                   	push   %ebx
801045f9:	e8 e2 02 00 00       	call   801048e0 <acquire>
  struct proc *p;
  acquire(&ptable.lock);
801045fe:	c7 04 24 e0 9b 11 80 	movl   $0x80119be0,(%esp)
80104605:	e8 d6 02 00 00       	call   801048e0 <acquire>
8010460a:	83 c4 10             	add    $0x10,%esp
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010460d:	b8 14 9c 11 80       	mov    $0x80119c14,%eax
80104612:	eb 10                	jmp    80104624 <receive_from_procbuffer+0x44>
80104614:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104618:	05 6c 05 00 00       	add    $0x56c,%eax
8010461d:	3d 14 f7 12 80       	cmp    $0x8012f714,%eax
80104622:	73 05                	jae    80104629 <receive_from_procbuffer+0x49>
      if(p->pid == myid)
80104624:	39 78 10             	cmp    %edi,0x10(%eax)
80104627:	75 ef                	jne    80104618 <receive_from_procbuffer+0x38>
80104629:	8d 90 2c 05 00 00    	lea    0x52c(%eax),%edx
  for(p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010462f:	b8 01 00 00 00       	mov    $0x1,%eax
80104634:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    int *temp_msg;
    temp_msg = (int *)msg;
    
    for(int i=1;i<MessageSize;i++){
        // cprintf("receiving %d: %d\n",i,*(p->msg_from_multicast+i));
         *(temp_msg+i-1) = *(p->msg_from_multicast+i);
80104638:	8b 0c 82             	mov    (%edx,%eax,4),%ecx
8010463b:	89 4c 86 fc          	mov    %ecx,-0x4(%esi,%eax,4)
    for(int i=1;i<MessageSize;i++){
8010463f:	83 c0 01             	add    $0x1,%eax
80104642:	83 f8 10             	cmp    $0x10,%eax
80104645:	75 f1                	jne    80104638 <receive_from_procbuffer+0x58>
    }

  release(&ptable.lock);
80104647:	83 ec 0c             	sub    $0xc,%esp
8010464a:	68 e0 9b 11 80       	push   $0x80119be0
8010464f:	e8 4c 03 00 00       	call   801049a0 <release>
  release(&procbuffer_lock[myid]);    
80104654:	89 1c 24             	mov    %ebx,(%esp)
80104657:	e8 44 03 00 00       	call   801049a0 <release>
    return 0;
}
8010465c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010465f:	31 c0                	xor    %eax,%eax
80104661:	5b                   	pop    %ebx
80104662:	5e                   	pop    %esi
80104663:	5f                   	pop    %edi
80104664:	5d                   	pop    %ebp
80104665:	c3                   	ret    
80104666:	66 90                	xchg   %ax,%ax
80104668:	66 90                	xchg   %ax,%ax
8010466a:	66 90                	xchg   %ax,%ax
8010466c:	66 90                	xchg   %ax,%ax
8010466e:	66 90                	xchg   %ax,%ax

80104670 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80104670:	55                   	push   %ebp
80104671:	89 e5                	mov    %esp,%ebp
80104673:	53                   	push   %ebx
80104674:	83 ec 0c             	sub    $0xc,%esp
80104677:	8b 5d 08             	mov    0x8(%ebp),%ebx
  initlock(&lk->lk, "sleep lock");
8010467a:	68 24 85 10 80       	push   $0x80108524
8010467f:	8d 43 04             	lea    0x4(%ebx),%eax
80104682:	50                   	push   %eax
80104683:	e8 18 01 00 00       	call   801047a0 <initlock>
  lk->name = name;
80104688:	8b 45 0c             	mov    0xc(%ebp),%eax
  lk->locked = 0;
8010468b:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
}
80104691:	83 c4 10             	add    $0x10,%esp
  lk->pid = 0;
80104694:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  lk->name = name;
8010469b:	89 43 38             	mov    %eax,0x38(%ebx)
}
8010469e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801046a1:	c9                   	leave  
801046a2:	c3                   	ret    
801046a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801046a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801046b0 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
801046b0:	55                   	push   %ebp
801046b1:	89 e5                	mov    %esp,%ebp
801046b3:	56                   	push   %esi
801046b4:	53                   	push   %ebx
801046b5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
801046b8:	83 ec 0c             	sub    $0xc,%esp
801046bb:	8d 73 04             	lea    0x4(%ebx),%esi
801046be:	56                   	push   %esi
801046bf:	e8 1c 02 00 00       	call   801048e0 <acquire>
  while (lk->locked) {
801046c4:	8b 13                	mov    (%ebx),%edx
801046c6:	83 c4 10             	add    $0x10,%esp
801046c9:	85 d2                	test   %edx,%edx
801046cb:	74 16                	je     801046e3 <acquiresleep+0x33>
801046cd:	8d 76 00             	lea    0x0(%esi),%esi
    sleep(lk, &lk->lk);
801046d0:	83 ec 08             	sub    $0x8,%esp
801046d3:	56                   	push   %esi
801046d4:	53                   	push   %ebx
801046d5:	e8 16 f9 ff ff       	call   80103ff0 <sleep>
  while (lk->locked) {
801046da:	8b 03                	mov    (%ebx),%eax
801046dc:	83 c4 10             	add    $0x10,%esp
801046df:	85 c0                	test   %eax,%eax
801046e1:	75 ed                	jne    801046d0 <acquiresleep+0x20>
  }
  lk->locked = 1;
801046e3:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  lk->pid = myproc()->pid;
801046e9:	e8 a2 f1 ff ff       	call   80103890 <myproc>
801046ee:	8b 40 10             	mov    0x10(%eax),%eax
801046f1:	89 43 3c             	mov    %eax,0x3c(%ebx)
  release(&lk->lk);
801046f4:	89 75 08             	mov    %esi,0x8(%ebp)
}
801046f7:	8d 65 f8             	lea    -0x8(%ebp),%esp
801046fa:	5b                   	pop    %ebx
801046fb:	5e                   	pop    %esi
801046fc:	5d                   	pop    %ebp
  release(&lk->lk);
801046fd:	e9 9e 02 00 00       	jmp    801049a0 <release>
80104702:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104709:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104710 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80104710:	55                   	push   %ebp
80104711:	89 e5                	mov    %esp,%ebp
80104713:	56                   	push   %esi
80104714:	53                   	push   %ebx
80104715:	8b 5d 08             	mov    0x8(%ebp),%ebx
  acquire(&lk->lk);
80104718:	83 ec 0c             	sub    $0xc,%esp
8010471b:	8d 73 04             	lea    0x4(%ebx),%esi
8010471e:	56                   	push   %esi
8010471f:	e8 bc 01 00 00       	call   801048e0 <acquire>
  lk->locked = 0;
80104724:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
  lk->pid = 0;
8010472a:	c7 43 3c 00 00 00 00 	movl   $0x0,0x3c(%ebx)
  wakeup(lk);
80104731:	89 1c 24             	mov    %ebx,(%esp)
80104734:	e8 77 fa ff ff       	call   801041b0 <wakeup>
  release(&lk->lk);
80104739:	89 75 08             	mov    %esi,0x8(%ebp)
8010473c:	83 c4 10             	add    $0x10,%esp
}
8010473f:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104742:	5b                   	pop    %ebx
80104743:	5e                   	pop    %esi
80104744:	5d                   	pop    %ebp
  release(&lk->lk);
80104745:	e9 56 02 00 00       	jmp    801049a0 <release>
8010474a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80104750 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80104750:	55                   	push   %ebp
80104751:	89 e5                	mov    %esp,%ebp
80104753:	57                   	push   %edi
80104754:	56                   	push   %esi
80104755:	53                   	push   %ebx
80104756:	31 ff                	xor    %edi,%edi
80104758:	83 ec 18             	sub    $0x18,%esp
8010475b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  int r;
  
  acquire(&lk->lk);
8010475e:	8d 73 04             	lea    0x4(%ebx),%esi
80104761:	56                   	push   %esi
80104762:	e8 79 01 00 00       	call   801048e0 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
80104767:	8b 03                	mov    (%ebx),%eax
80104769:	83 c4 10             	add    $0x10,%esp
8010476c:	85 c0                	test   %eax,%eax
8010476e:	74 13                	je     80104783 <holdingsleep+0x33>
80104770:	8b 5b 3c             	mov    0x3c(%ebx),%ebx
80104773:	e8 18 f1 ff ff       	call   80103890 <myproc>
80104778:	39 58 10             	cmp    %ebx,0x10(%eax)
8010477b:	0f 94 c0             	sete   %al
8010477e:	0f b6 c0             	movzbl %al,%eax
80104781:	89 c7                	mov    %eax,%edi
  release(&lk->lk);
80104783:	83 ec 0c             	sub    $0xc,%esp
80104786:	56                   	push   %esi
80104787:	e8 14 02 00 00       	call   801049a0 <release>
  return r;
}
8010478c:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010478f:	89 f8                	mov    %edi,%eax
80104791:	5b                   	pop    %ebx
80104792:	5e                   	pop    %esi
80104793:	5f                   	pop    %edi
80104794:	5d                   	pop    %ebp
80104795:	c3                   	ret    
80104796:	66 90                	xchg   %ax,%ax
80104798:	66 90                	xchg   %ax,%ax
8010479a:	66 90                	xchg   %ax,%ax
8010479c:	66 90                	xchg   %ax,%ax
8010479e:	66 90                	xchg   %ax,%ax

801047a0 <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
801047a0:	55                   	push   %ebp
801047a1:	89 e5                	mov    %esp,%ebp
801047a3:	8b 45 08             	mov    0x8(%ebp),%eax
  lk->name = name;
801047a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  lk->locked = 0;
801047a9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->name = name;
801047af:	89 50 04             	mov    %edx,0x4(%eax)
  lk->cpu = 0;
801047b2:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
801047b9:	5d                   	pop    %ebp
801047ba:	c3                   	ret    
801047bb:	90                   	nop
801047bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801047c0 <getcallerpcs>:
}

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801047c0:	55                   	push   %ebp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
  for(i = 0; i < 10; i++){
801047c1:	31 d2                	xor    %edx,%edx
{
801047c3:	89 e5                	mov    %esp,%ebp
801047c5:	53                   	push   %ebx
  ebp = (uint*)v - 2;
801047c6:	8b 45 08             	mov    0x8(%ebp),%eax
{
801047c9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  ebp = (uint*)v - 2;
801047cc:	83 e8 08             	sub    $0x8,%eax
801047cf:	90                   	nop
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
801047d0:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
801047d6:	81 fb fe ff ff 7f    	cmp    $0x7ffffffe,%ebx
801047dc:	77 1a                	ja     801047f8 <getcallerpcs+0x38>
      break;
    pcs[i] = ebp[1];     // saved %eip
801047de:	8b 58 04             	mov    0x4(%eax),%ebx
801047e1:	89 1c 91             	mov    %ebx,(%ecx,%edx,4)
  for(i = 0; i < 10; i++){
801047e4:	83 c2 01             	add    $0x1,%edx
    ebp = (uint*)ebp[0]; // saved %ebp
801047e7:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
801047e9:	83 fa 0a             	cmp    $0xa,%edx
801047ec:	75 e2                	jne    801047d0 <getcallerpcs+0x10>
  }
  for(; i < 10; i++)
    pcs[i] = 0;
}
801047ee:	5b                   	pop    %ebx
801047ef:	5d                   	pop    %ebp
801047f0:	c3                   	ret    
801047f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801047f8:	8d 04 91             	lea    (%ecx,%edx,4),%eax
801047fb:	83 c1 28             	add    $0x28,%ecx
801047fe:	66 90                	xchg   %ax,%ax
    pcs[i] = 0;
80104800:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104806:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104809:	39 c1                	cmp    %eax,%ecx
8010480b:	75 f3                	jne    80104800 <getcallerpcs+0x40>
}
8010480d:	5b                   	pop    %ebx
8010480e:	5d                   	pop    %ebp
8010480f:	c3                   	ret    

80104810 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
80104810:	55                   	push   %ebp
80104811:	89 e5                	mov    %esp,%ebp
80104813:	53                   	push   %ebx
80104814:	83 ec 04             	sub    $0x4,%esp
80104817:	9c                   	pushf  
80104818:	5b                   	pop    %ebx
  asm volatile("cli");
80104819:	fa                   	cli    
  int eflags;

  eflags = readeflags();
  cli();
  if(mycpu()->ncli == 0)
8010481a:	e8 d1 ef ff ff       	call   801037f0 <mycpu>
8010481f:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80104825:	85 c0                	test   %eax,%eax
80104827:	75 11                	jne    8010483a <pushcli+0x2a>
    mycpu()->intena = eflags & FL_IF;
80104829:	81 e3 00 02 00 00    	and    $0x200,%ebx
8010482f:	e8 bc ef ff ff       	call   801037f0 <mycpu>
80104834:	89 98 a8 00 00 00    	mov    %ebx,0xa8(%eax)
  mycpu()->ncli += 1;
8010483a:	e8 b1 ef ff ff       	call   801037f0 <mycpu>
8010483f:	83 80 a4 00 00 00 01 	addl   $0x1,0xa4(%eax)
}
80104846:	83 c4 04             	add    $0x4,%esp
80104849:	5b                   	pop    %ebx
8010484a:	5d                   	pop    %ebp
8010484b:	c3                   	ret    
8010484c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104850 <popcli>:

void
popcli(void)
{
80104850:	55                   	push   %ebp
80104851:	89 e5                	mov    %esp,%ebp
80104853:	83 ec 08             	sub    $0x8,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80104856:	9c                   	pushf  
80104857:	58                   	pop    %eax
  if(readeflags()&FL_IF)
80104858:	f6 c4 02             	test   $0x2,%ah
8010485b:	75 35                	jne    80104892 <popcli+0x42>
    panic("popcli - interruptible");
  if(--mycpu()->ncli < 0)
8010485d:	e8 8e ef ff ff       	call   801037f0 <mycpu>
80104862:	83 a8 a4 00 00 00 01 	subl   $0x1,0xa4(%eax)
80104869:	78 34                	js     8010489f <popcli+0x4f>
    panic("popcli");
  if(mycpu()->ncli == 0 && mycpu()->intena)
8010486b:	e8 80 ef ff ff       	call   801037f0 <mycpu>
80104870:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80104876:	85 d2                	test   %edx,%edx
80104878:	74 06                	je     80104880 <popcli+0x30>
    sti();
}
8010487a:	c9                   	leave  
8010487b:	c3                   	ret    
8010487c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  if(mycpu()->ncli == 0 && mycpu()->intena)
80104880:	e8 6b ef ff ff       	call   801037f0 <mycpu>
80104885:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010488b:	85 c0                	test   %eax,%eax
8010488d:	74 eb                	je     8010487a <popcli+0x2a>
  asm volatile("sti");
8010488f:	fb                   	sti    
}
80104890:	c9                   	leave  
80104891:	c3                   	ret    
    panic("popcli - interruptible");
80104892:	83 ec 0c             	sub    $0xc,%esp
80104895:	68 2f 85 10 80       	push   $0x8010852f
8010489a:	e8 f1 ba ff ff       	call   80100390 <panic>
    panic("popcli");
8010489f:	83 ec 0c             	sub    $0xc,%esp
801048a2:	68 46 85 10 80       	push   $0x80108546
801048a7:	e8 e4 ba ff ff       	call   80100390 <panic>
801048ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801048b0 <holding>:
{
801048b0:	55                   	push   %ebp
801048b1:	89 e5                	mov    %esp,%ebp
801048b3:	56                   	push   %esi
801048b4:	53                   	push   %ebx
801048b5:	8b 75 08             	mov    0x8(%ebp),%esi
801048b8:	31 db                	xor    %ebx,%ebx
  pushcli();
801048ba:	e8 51 ff ff ff       	call   80104810 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801048bf:	8b 06                	mov    (%esi),%eax
801048c1:	85 c0                	test   %eax,%eax
801048c3:	74 10                	je     801048d5 <holding+0x25>
801048c5:	8b 5e 08             	mov    0x8(%esi),%ebx
801048c8:	e8 23 ef ff ff       	call   801037f0 <mycpu>
801048cd:	39 c3                	cmp    %eax,%ebx
801048cf:	0f 94 c3             	sete   %bl
801048d2:	0f b6 db             	movzbl %bl,%ebx
  popcli();
801048d5:	e8 76 ff ff ff       	call   80104850 <popcli>
}
801048da:	89 d8                	mov    %ebx,%eax
801048dc:	5b                   	pop    %ebx
801048dd:	5e                   	pop    %esi
801048de:	5d                   	pop    %ebp
801048df:	c3                   	ret    

801048e0 <acquire>:
{
801048e0:	55                   	push   %ebp
801048e1:	89 e5                	mov    %esp,%ebp
801048e3:	56                   	push   %esi
801048e4:	53                   	push   %ebx
  pushcli(); // disable interrupts to avoid deadlock.
801048e5:	e8 26 ff ff ff       	call   80104810 <pushcli>
  if(holding(lk))
801048ea:	8b 5d 08             	mov    0x8(%ebp),%ebx
801048ed:	83 ec 0c             	sub    $0xc,%esp
801048f0:	53                   	push   %ebx
801048f1:	e8 ba ff ff ff       	call   801048b0 <holding>
801048f6:	83 c4 10             	add    $0x10,%esp
801048f9:	85 c0                	test   %eax,%eax
801048fb:	0f 85 83 00 00 00    	jne    80104984 <acquire+0xa4>
80104901:	89 c6                	mov    %eax,%esi
  asm volatile("lock; xchgl %0, %1" :
80104903:	ba 01 00 00 00       	mov    $0x1,%edx
80104908:	eb 09                	jmp    80104913 <acquire+0x33>
8010490a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104910:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104913:	89 d0                	mov    %edx,%eax
80104915:	f0 87 03             	lock xchg %eax,(%ebx)
  while(xchg(&lk->locked, 1) != 0)
80104918:	85 c0                	test   %eax,%eax
8010491a:	75 f4                	jne    80104910 <acquire+0x30>
  __sync_synchronize();
8010491c:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  lk->cpu = mycpu();
80104921:	8b 5d 08             	mov    0x8(%ebp),%ebx
80104924:	e8 c7 ee ff ff       	call   801037f0 <mycpu>
  getcallerpcs(&lk, lk->pcs);
80104929:	8d 53 0c             	lea    0xc(%ebx),%edx
  lk->cpu = mycpu();
8010492c:	89 43 08             	mov    %eax,0x8(%ebx)
  ebp = (uint*)v - 2;
8010492f:	89 e8                	mov    %ebp,%eax
80104931:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80104938:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010493e:	81 f9 fe ff ff 7f    	cmp    $0x7ffffffe,%ecx
80104944:	77 1a                	ja     80104960 <acquire+0x80>
    pcs[i] = ebp[1];     // saved %eip
80104946:	8b 48 04             	mov    0x4(%eax),%ecx
80104949:	89 0c b2             	mov    %ecx,(%edx,%esi,4)
  for(i = 0; i < 10; i++){
8010494c:	83 c6 01             	add    $0x1,%esi
    ebp = (uint*)ebp[0]; // saved %ebp
8010494f:	8b 00                	mov    (%eax),%eax
  for(i = 0; i < 10; i++){
80104951:	83 fe 0a             	cmp    $0xa,%esi
80104954:	75 e2                	jne    80104938 <acquire+0x58>
}
80104956:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104959:	5b                   	pop    %ebx
8010495a:	5e                   	pop    %esi
8010495b:	5d                   	pop    %ebp
8010495c:	c3                   	ret    
8010495d:	8d 76 00             	lea    0x0(%esi),%esi
80104960:	8d 04 b2             	lea    (%edx,%esi,4),%eax
80104963:	83 c2 28             	add    $0x28,%edx
80104966:	8d 76 00             	lea    0x0(%esi),%esi
80104969:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    pcs[i] = 0;
80104970:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80104976:	83 c0 04             	add    $0x4,%eax
  for(; i < 10; i++)
80104979:	39 d0                	cmp    %edx,%eax
8010497b:	75 f3                	jne    80104970 <acquire+0x90>
}
8010497d:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104980:	5b                   	pop    %ebx
80104981:	5e                   	pop    %esi
80104982:	5d                   	pop    %ebp
80104983:	c3                   	ret    
    panic("acquire");
80104984:	83 ec 0c             	sub    $0xc,%esp
80104987:	68 4d 85 10 80       	push   $0x8010854d
8010498c:	e8 ff b9 ff ff       	call   80100390 <panic>
80104991:	eb 0d                	jmp    801049a0 <release>
80104993:	90                   	nop
80104994:	90                   	nop
80104995:	90                   	nop
80104996:	90                   	nop
80104997:	90                   	nop
80104998:	90                   	nop
80104999:	90                   	nop
8010499a:	90                   	nop
8010499b:	90                   	nop
8010499c:	90                   	nop
8010499d:	90                   	nop
8010499e:	90                   	nop
8010499f:	90                   	nop

801049a0 <release>:
{
801049a0:	55                   	push   %ebp
801049a1:	89 e5                	mov    %esp,%ebp
801049a3:	53                   	push   %ebx
801049a4:	83 ec 10             	sub    $0x10,%esp
801049a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(!holding(lk))
801049aa:	53                   	push   %ebx
801049ab:	e8 00 ff ff ff       	call   801048b0 <holding>
801049b0:	83 c4 10             	add    $0x10,%esp
801049b3:	85 c0                	test   %eax,%eax
801049b5:	74 22                	je     801049d9 <release+0x39>
  lk->pcs[0] = 0;
801049b7:	c7 43 0c 00 00 00 00 	movl   $0x0,0xc(%ebx)
  lk->cpu = 0;
801049be:	c7 43 08 00 00 00 00 	movl   $0x0,0x8(%ebx)
  __sync_synchronize();
801049c5:	f0 83 0c 24 00       	lock orl $0x0,(%esp)
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801049ca:	c7 03 00 00 00 00    	movl   $0x0,(%ebx)
}
801049d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801049d3:	c9                   	leave  
  popcli();
801049d4:	e9 77 fe ff ff       	jmp    80104850 <popcli>
    panic("release");
801049d9:	83 ec 0c             	sub    $0xc,%esp
801049dc:	68 55 85 10 80       	push   $0x80108555
801049e1:	e8 aa b9 ff ff       	call   80100390 <panic>
801049e6:	66 90                	xchg   %ax,%ax
801049e8:	66 90                	xchg   %ax,%ax
801049ea:	66 90                	xchg   %ax,%ax
801049ec:	66 90                	xchg   %ax,%ax
801049ee:	66 90                	xchg   %ax,%ax

801049f0 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801049f0:	55                   	push   %ebp
801049f1:	89 e5                	mov    %esp,%ebp
801049f3:	57                   	push   %edi
801049f4:	53                   	push   %ebx
801049f5:	8b 55 08             	mov    0x8(%ebp),%edx
801049f8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  if ((int)dst%4 == 0 && n%4 == 0){
801049fb:	f6 c2 03             	test   $0x3,%dl
801049fe:	75 05                	jne    80104a05 <memset+0x15>
80104a00:	f6 c1 03             	test   $0x3,%cl
80104a03:	74 13                	je     80104a18 <memset+0x28>
  asm volatile("cld; rep stosb" :
80104a05:	89 d7                	mov    %edx,%edi
80104a07:	8b 45 0c             	mov    0xc(%ebp),%eax
80104a0a:	fc                   	cld    
80104a0b:	f3 aa                	rep stos %al,%es:(%edi)
    c &= 0xFF;
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
  } else
    stosb(dst, c, n);
  return dst;
}
80104a0d:	5b                   	pop    %ebx
80104a0e:	89 d0                	mov    %edx,%eax
80104a10:	5f                   	pop    %edi
80104a11:	5d                   	pop    %ebp
80104a12:	c3                   	ret    
80104a13:	90                   	nop
80104a14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c &= 0xFF;
80104a18:	0f b6 7d 0c          	movzbl 0xc(%ebp),%edi
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80104a1c:	c1 e9 02             	shr    $0x2,%ecx
80104a1f:	89 f8                	mov    %edi,%eax
80104a21:	89 fb                	mov    %edi,%ebx
80104a23:	c1 e0 18             	shl    $0x18,%eax
80104a26:	c1 e3 10             	shl    $0x10,%ebx
80104a29:	09 d8                	or     %ebx,%eax
80104a2b:	09 f8                	or     %edi,%eax
80104a2d:	c1 e7 08             	shl    $0x8,%edi
80104a30:	09 f8                	or     %edi,%eax
  asm volatile("cld; rep stosl" :
80104a32:	89 d7                	mov    %edx,%edi
80104a34:	fc                   	cld    
80104a35:	f3 ab                	rep stos %eax,%es:(%edi)
}
80104a37:	5b                   	pop    %ebx
80104a38:	89 d0                	mov    %edx,%eax
80104a3a:	5f                   	pop    %edi
80104a3b:	5d                   	pop    %ebp
80104a3c:	c3                   	ret    
80104a3d:	8d 76 00             	lea    0x0(%esi),%esi

80104a40 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
80104a40:	55                   	push   %ebp
80104a41:	89 e5                	mov    %esp,%ebp
80104a43:	57                   	push   %edi
80104a44:	56                   	push   %esi
80104a45:	53                   	push   %ebx
80104a46:	8b 5d 10             	mov    0x10(%ebp),%ebx
80104a49:	8b 75 08             	mov    0x8(%ebp),%esi
80104a4c:	8b 7d 0c             	mov    0xc(%ebp),%edi
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
80104a4f:	85 db                	test   %ebx,%ebx
80104a51:	74 29                	je     80104a7c <memcmp+0x3c>
    if(*s1 != *s2)
80104a53:	0f b6 16             	movzbl (%esi),%edx
80104a56:	0f b6 0f             	movzbl (%edi),%ecx
80104a59:	38 d1                	cmp    %dl,%cl
80104a5b:	75 2b                	jne    80104a88 <memcmp+0x48>
80104a5d:	b8 01 00 00 00       	mov    $0x1,%eax
80104a62:	eb 14                	jmp    80104a78 <memcmp+0x38>
80104a64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80104a68:	0f b6 14 06          	movzbl (%esi,%eax,1),%edx
80104a6c:	83 c0 01             	add    $0x1,%eax
80104a6f:	0f b6 4c 07 ff       	movzbl -0x1(%edi,%eax,1),%ecx
80104a74:	38 ca                	cmp    %cl,%dl
80104a76:	75 10                	jne    80104a88 <memcmp+0x48>
  while(n-- > 0){
80104a78:	39 d8                	cmp    %ebx,%eax
80104a7a:	75 ec                	jne    80104a68 <memcmp+0x28>
      return *s1 - *s2;
    s1++, s2++;
  }

  return 0;
}
80104a7c:	5b                   	pop    %ebx
  return 0;
80104a7d:	31 c0                	xor    %eax,%eax
}
80104a7f:	5e                   	pop    %esi
80104a80:	5f                   	pop    %edi
80104a81:	5d                   	pop    %ebp
80104a82:	c3                   	ret    
80104a83:	90                   	nop
80104a84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      return *s1 - *s2;
80104a88:	0f b6 c2             	movzbl %dl,%eax
}
80104a8b:	5b                   	pop    %ebx
      return *s1 - *s2;
80104a8c:	29 c8                	sub    %ecx,%eax
}
80104a8e:	5e                   	pop    %esi
80104a8f:	5f                   	pop    %edi
80104a90:	5d                   	pop    %ebp
80104a91:	c3                   	ret    
80104a92:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104a99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104aa0 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80104aa0:	55                   	push   %ebp
80104aa1:	89 e5                	mov    %esp,%ebp
80104aa3:	56                   	push   %esi
80104aa4:	53                   	push   %ebx
80104aa5:	8b 45 08             	mov    0x8(%ebp),%eax
80104aa8:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104aab:	8b 75 10             	mov    0x10(%ebp),%esi
  const char *s;
  char *d;

  s = src;
  d = dst;
  if(s < d && s + n > d){
80104aae:	39 c3                	cmp    %eax,%ebx
80104ab0:	73 26                	jae    80104ad8 <memmove+0x38>
80104ab2:	8d 0c 33             	lea    (%ebx,%esi,1),%ecx
80104ab5:	39 c8                	cmp    %ecx,%eax
80104ab7:	73 1f                	jae    80104ad8 <memmove+0x38>
    s += n;
    d += n;
    while(n-- > 0)
80104ab9:	85 f6                	test   %esi,%esi
80104abb:	8d 56 ff             	lea    -0x1(%esi),%edx
80104abe:	74 0f                	je     80104acf <memmove+0x2f>
      *--d = *--s;
80104ac0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104ac4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    while(n-- > 0)
80104ac7:	83 ea 01             	sub    $0x1,%edx
80104aca:	83 fa ff             	cmp    $0xffffffff,%edx
80104acd:	75 f1                	jne    80104ac0 <memmove+0x20>
  } else
    while(n-- > 0)
      *d++ = *s++;

  return dst;
}
80104acf:	5b                   	pop    %ebx
80104ad0:	5e                   	pop    %esi
80104ad1:	5d                   	pop    %ebp
80104ad2:	c3                   	ret    
80104ad3:	90                   	nop
80104ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    while(n-- > 0)
80104ad8:	31 d2                	xor    %edx,%edx
80104ada:	85 f6                	test   %esi,%esi
80104adc:	74 f1                	je     80104acf <memmove+0x2f>
80104ade:	66 90                	xchg   %ax,%ax
      *d++ = *s++;
80104ae0:	0f b6 0c 13          	movzbl (%ebx,%edx,1),%ecx
80104ae4:	88 0c 10             	mov    %cl,(%eax,%edx,1)
80104ae7:	83 c2 01             	add    $0x1,%edx
    while(n-- > 0)
80104aea:	39 d6                	cmp    %edx,%esi
80104aec:	75 f2                	jne    80104ae0 <memmove+0x40>
}
80104aee:	5b                   	pop    %ebx
80104aef:	5e                   	pop    %esi
80104af0:	5d                   	pop    %ebp
80104af1:	c3                   	ret    
80104af2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b00 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80104b00:	55                   	push   %ebp
80104b01:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
}
80104b03:	5d                   	pop    %ebp
  return memmove(dst, src, n);
80104b04:	eb 9a                	jmp    80104aa0 <memmove>
80104b06:	8d 76 00             	lea    0x0(%esi),%esi
80104b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104b10 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80104b10:	55                   	push   %ebp
80104b11:	89 e5                	mov    %esp,%ebp
80104b13:	57                   	push   %edi
80104b14:	56                   	push   %esi
80104b15:	8b 7d 10             	mov    0x10(%ebp),%edi
80104b18:	53                   	push   %ebx
80104b19:	8b 4d 08             	mov    0x8(%ebp),%ecx
80104b1c:	8b 75 0c             	mov    0xc(%ebp),%esi
  while(n > 0 && *p && *p == *q)
80104b1f:	85 ff                	test   %edi,%edi
80104b21:	74 2f                	je     80104b52 <strncmp+0x42>
80104b23:	0f b6 01             	movzbl (%ecx),%eax
80104b26:	0f b6 1e             	movzbl (%esi),%ebx
80104b29:	84 c0                	test   %al,%al
80104b2b:	74 37                	je     80104b64 <strncmp+0x54>
80104b2d:	38 c3                	cmp    %al,%bl
80104b2f:	75 33                	jne    80104b64 <strncmp+0x54>
80104b31:	01 f7                	add    %esi,%edi
80104b33:	eb 13                	jmp    80104b48 <strncmp+0x38>
80104b35:	8d 76 00             	lea    0x0(%esi),%esi
80104b38:	0f b6 01             	movzbl (%ecx),%eax
80104b3b:	84 c0                	test   %al,%al
80104b3d:	74 21                	je     80104b60 <strncmp+0x50>
80104b3f:	0f b6 1a             	movzbl (%edx),%ebx
80104b42:	89 d6                	mov    %edx,%esi
80104b44:	38 d8                	cmp    %bl,%al
80104b46:	75 1c                	jne    80104b64 <strncmp+0x54>
    n--, p++, q++;
80104b48:	8d 56 01             	lea    0x1(%esi),%edx
80104b4b:	83 c1 01             	add    $0x1,%ecx
  while(n > 0 && *p && *p == *q)
80104b4e:	39 fa                	cmp    %edi,%edx
80104b50:	75 e6                	jne    80104b38 <strncmp+0x28>
  if(n == 0)
    return 0;
  return (uchar)*p - (uchar)*q;
}
80104b52:	5b                   	pop    %ebx
    return 0;
80104b53:	31 c0                	xor    %eax,%eax
}
80104b55:	5e                   	pop    %esi
80104b56:	5f                   	pop    %edi
80104b57:	5d                   	pop    %ebp
80104b58:	c3                   	ret    
80104b59:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80104b60:	0f b6 5e 01          	movzbl 0x1(%esi),%ebx
  return (uchar)*p - (uchar)*q;
80104b64:	29 d8                	sub    %ebx,%eax
}
80104b66:	5b                   	pop    %ebx
80104b67:	5e                   	pop    %esi
80104b68:	5f                   	pop    %edi
80104b69:	5d                   	pop    %ebp
80104b6a:	c3                   	ret    
80104b6b:	90                   	nop
80104b6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104b70 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
80104b70:	55                   	push   %ebp
80104b71:	89 e5                	mov    %esp,%ebp
80104b73:	56                   	push   %esi
80104b74:	53                   	push   %ebx
80104b75:	8b 45 08             	mov    0x8(%ebp),%eax
80104b78:	8b 5d 0c             	mov    0xc(%ebp),%ebx
80104b7b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
80104b7e:	89 c2                	mov    %eax,%edx
80104b80:	eb 19                	jmp    80104b9b <strncpy+0x2b>
80104b82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104b88:	83 c3 01             	add    $0x1,%ebx
80104b8b:	0f b6 4b ff          	movzbl -0x1(%ebx),%ecx
80104b8f:	83 c2 01             	add    $0x1,%edx
80104b92:	84 c9                	test   %cl,%cl
80104b94:	88 4a ff             	mov    %cl,-0x1(%edx)
80104b97:	74 09                	je     80104ba2 <strncpy+0x32>
80104b99:	89 f1                	mov    %esi,%ecx
80104b9b:	85 c9                	test   %ecx,%ecx
80104b9d:	8d 71 ff             	lea    -0x1(%ecx),%esi
80104ba0:	7f e6                	jg     80104b88 <strncpy+0x18>
    ;
  while(n-- > 0)
80104ba2:	31 c9                	xor    %ecx,%ecx
80104ba4:	85 f6                	test   %esi,%esi
80104ba6:	7e 17                	jle    80104bbf <strncpy+0x4f>
80104ba8:	90                   	nop
80104ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    *s++ = 0;
80104bb0:	c6 04 0a 00          	movb   $0x0,(%edx,%ecx,1)
80104bb4:	89 f3                	mov    %esi,%ebx
80104bb6:	83 c1 01             	add    $0x1,%ecx
80104bb9:	29 cb                	sub    %ecx,%ebx
  while(n-- > 0)
80104bbb:	85 db                	test   %ebx,%ebx
80104bbd:	7f f1                	jg     80104bb0 <strncpy+0x40>
  return os;
}
80104bbf:	5b                   	pop    %ebx
80104bc0:	5e                   	pop    %esi
80104bc1:	5d                   	pop    %ebp
80104bc2:	c3                   	ret    
80104bc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104bd0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80104bd0:	55                   	push   %ebp
80104bd1:	89 e5                	mov    %esp,%ebp
80104bd3:	56                   	push   %esi
80104bd4:	53                   	push   %ebx
80104bd5:	8b 4d 10             	mov    0x10(%ebp),%ecx
80104bd8:	8b 45 08             	mov    0x8(%ebp),%eax
80104bdb:	8b 55 0c             	mov    0xc(%ebp),%edx
  char *os;

  os = s;
  if(n <= 0)
80104bde:	85 c9                	test   %ecx,%ecx
80104be0:	7e 26                	jle    80104c08 <safestrcpy+0x38>
80104be2:	8d 74 0a ff          	lea    -0x1(%edx,%ecx,1),%esi
80104be6:	89 c1                	mov    %eax,%ecx
80104be8:	eb 17                	jmp    80104c01 <safestrcpy+0x31>
80104bea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
80104bf0:	83 c2 01             	add    $0x1,%edx
80104bf3:	0f b6 5a ff          	movzbl -0x1(%edx),%ebx
80104bf7:	83 c1 01             	add    $0x1,%ecx
80104bfa:	84 db                	test   %bl,%bl
80104bfc:	88 59 ff             	mov    %bl,-0x1(%ecx)
80104bff:	74 04                	je     80104c05 <safestrcpy+0x35>
80104c01:	39 f2                	cmp    %esi,%edx
80104c03:	75 eb                	jne    80104bf0 <safestrcpy+0x20>
    ;
  *s = 0;
80104c05:	c6 01 00             	movb   $0x0,(%ecx)
  return os;
}
80104c08:	5b                   	pop    %ebx
80104c09:	5e                   	pop    %esi
80104c0a:	5d                   	pop    %ebp
80104c0b:	c3                   	ret    
80104c0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80104c10 <strlen>:

int
strlen(const char *s)
{
80104c10:	55                   	push   %ebp
  int n;

  for(n = 0; s[n]; n++)
80104c11:	31 c0                	xor    %eax,%eax
{
80104c13:	89 e5                	mov    %esp,%ebp
80104c15:	8b 55 08             	mov    0x8(%ebp),%edx
  for(n = 0; s[n]; n++)
80104c18:	80 3a 00             	cmpb   $0x0,(%edx)
80104c1b:	74 0c                	je     80104c29 <strlen+0x19>
80104c1d:	8d 76 00             	lea    0x0(%esi),%esi
80104c20:	83 c0 01             	add    $0x1,%eax
80104c23:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
80104c27:	75 f7                	jne    80104c20 <strlen+0x10>
    ;
  return n;
}
80104c29:	5d                   	pop    %ebp
80104c2a:	c3                   	ret    

80104c2b <swtch>:
# a struct context, and save its address in *old.
# Switch stacks to new and pop previously-saved registers.

.globl swtch
swtch:
  movl 4(%esp), %eax
80104c2b:	8b 44 24 04          	mov    0x4(%esp),%eax
  movl 8(%esp), %edx
80104c2f:	8b 54 24 08          	mov    0x8(%esp),%edx

  # Save old callee-saved registers
  pushl %ebp
80104c33:	55                   	push   %ebp
  pushl %ebx
80104c34:	53                   	push   %ebx
  pushl %esi
80104c35:	56                   	push   %esi
  pushl %edi
80104c36:	57                   	push   %edi

  # Switch stacks
  movl %esp, (%eax)
80104c37:	89 20                	mov    %esp,(%eax)
  movl %edx, %esp
80104c39:	89 d4                	mov    %edx,%esp

  # Load new callee-saved registers
  popl %edi
80104c3b:	5f                   	pop    %edi
  popl %esi
80104c3c:	5e                   	pop    %esi
  popl %ebx
80104c3d:	5b                   	pop    %ebx
  popl %ebp
80104c3e:	5d                   	pop    %ebp
  ret
80104c3f:	c3                   	ret    

80104c40 <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
80104c40:	55                   	push   %ebp
80104c41:	89 e5                	mov    %esp,%ebp
80104c43:	53                   	push   %ebx
80104c44:	83 ec 04             	sub    $0x4,%esp
80104c47:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct proc *curproc = myproc();
80104c4a:	e8 41 ec ff ff       	call   80103890 <myproc>

  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104c4f:	8b 00                	mov    (%eax),%eax
80104c51:	39 d8                	cmp    %ebx,%eax
80104c53:	76 1b                	jbe    80104c70 <fetchint+0x30>
80104c55:	8d 53 04             	lea    0x4(%ebx),%edx
80104c58:	39 d0                	cmp    %edx,%eax
80104c5a:	72 14                	jb     80104c70 <fetchint+0x30>
    return -1;
  *ip = *(int*)(addr);
80104c5c:	8b 45 0c             	mov    0xc(%ebp),%eax
80104c5f:	8b 13                	mov    (%ebx),%edx
80104c61:	89 10                	mov    %edx,(%eax)
  return 0;
80104c63:	31 c0                	xor    %eax,%eax
}
80104c65:	83 c4 04             	add    $0x4,%esp
80104c68:	5b                   	pop    %ebx
80104c69:	5d                   	pop    %ebp
80104c6a:	c3                   	ret    
80104c6b:	90                   	nop
80104c6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104c70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c75:	eb ee                	jmp    80104c65 <fetchint+0x25>
80104c77:	89 f6                	mov    %esi,%esi
80104c79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104c80 <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
80104c80:	55                   	push   %ebp
80104c81:	89 e5                	mov    %esp,%ebp
80104c83:	53                   	push   %ebx
80104c84:	83 ec 04             	sub    $0x4,%esp
80104c87:	8b 5d 08             	mov    0x8(%ebp),%ebx
  char *s, *ep;
  struct proc *curproc = myproc();
80104c8a:	e8 01 ec ff ff       	call   80103890 <myproc>

  if(addr >= curproc->sz)
80104c8f:	39 18                	cmp    %ebx,(%eax)
80104c91:	76 29                	jbe    80104cbc <fetchstr+0x3c>
    return -1;
  *pp = (char*)addr;
80104c93:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80104c96:	89 da                	mov    %ebx,%edx
80104c98:	89 19                	mov    %ebx,(%ecx)
  ep = (char*)curproc->sz;
80104c9a:	8b 00                	mov    (%eax),%eax
  for(s = *pp; s < ep; s++){
80104c9c:	39 c3                	cmp    %eax,%ebx
80104c9e:	73 1c                	jae    80104cbc <fetchstr+0x3c>
    if(*s == 0)
80104ca0:	80 3b 00             	cmpb   $0x0,(%ebx)
80104ca3:	75 10                	jne    80104cb5 <fetchstr+0x35>
80104ca5:	eb 39                	jmp    80104ce0 <fetchstr+0x60>
80104ca7:	89 f6                	mov    %esi,%esi
80104ca9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104cb0:	80 3a 00             	cmpb   $0x0,(%edx)
80104cb3:	74 1b                	je     80104cd0 <fetchstr+0x50>
  for(s = *pp; s < ep; s++){
80104cb5:	83 c2 01             	add    $0x1,%edx
80104cb8:	39 d0                	cmp    %edx,%eax
80104cba:	77 f4                	ja     80104cb0 <fetchstr+0x30>
    return -1;
80104cbc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
      return s - *pp;
  }
  return -1;
}
80104cc1:	83 c4 04             	add    $0x4,%esp
80104cc4:	5b                   	pop    %ebx
80104cc5:	5d                   	pop    %ebp
80104cc6:	c3                   	ret    
80104cc7:	89 f6                	mov    %esi,%esi
80104cc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80104cd0:	83 c4 04             	add    $0x4,%esp
80104cd3:	89 d0                	mov    %edx,%eax
80104cd5:	29 d8                	sub    %ebx,%eax
80104cd7:	5b                   	pop    %ebx
80104cd8:	5d                   	pop    %ebp
80104cd9:	c3                   	ret    
80104cda:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(*s == 0)
80104ce0:	31 c0                	xor    %eax,%eax
      return s - *pp;
80104ce2:	eb dd                	jmp    80104cc1 <fetchstr+0x41>
80104ce4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80104cea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80104cf0 <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
80104cf0:	55                   	push   %ebp
80104cf1:	89 e5                	mov    %esp,%ebp
80104cf3:	56                   	push   %esi
80104cf4:	53                   	push   %ebx
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104cf5:	e8 96 eb ff ff       	call   80103890 <myproc>
80104cfa:	8b 40 18             	mov    0x18(%eax),%eax
80104cfd:	8b 55 08             	mov    0x8(%ebp),%edx
80104d00:	8b 40 44             	mov    0x44(%eax),%eax
80104d03:	8d 1c 90             	lea    (%eax,%edx,4),%ebx
  struct proc *curproc = myproc();
80104d06:	e8 85 eb ff ff       	call   80103890 <myproc>
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d0b:	8b 00                	mov    (%eax),%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d0d:	8d 73 04             	lea    0x4(%ebx),%esi
  if(addr >= curproc->sz || addr+4 > curproc->sz)
80104d10:	39 c6                	cmp    %eax,%esi
80104d12:	73 1c                	jae    80104d30 <argint+0x40>
80104d14:	8d 53 08             	lea    0x8(%ebx),%edx
80104d17:	39 d0                	cmp    %edx,%eax
80104d19:	72 15                	jb     80104d30 <argint+0x40>
  *ip = *(int*)(addr);
80104d1b:	8b 45 0c             	mov    0xc(%ebp),%eax
80104d1e:	8b 53 04             	mov    0x4(%ebx),%edx
80104d21:	89 10                	mov    %edx,(%eax)
  return 0;
80104d23:	31 c0                	xor    %eax,%eax
}
80104d25:	5b                   	pop    %ebx
80104d26:	5e                   	pop    %esi
80104d27:	5d                   	pop    %ebp
80104d28:	c3                   	ret    
80104d29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104d30:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
80104d35:	eb ee                	jmp    80104d25 <argint+0x35>
80104d37:	89 f6                	mov    %esi,%esi
80104d39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104d40 <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
80104d40:	55                   	push   %ebp
80104d41:	89 e5                	mov    %esp,%ebp
80104d43:	56                   	push   %esi
80104d44:	53                   	push   %ebx
80104d45:	83 ec 10             	sub    $0x10,%esp
80104d48:	8b 5d 10             	mov    0x10(%ebp),%ebx
  int i;
  struct proc *curproc = myproc();
80104d4b:	e8 40 eb ff ff       	call   80103890 <myproc>
80104d50:	89 c6                	mov    %eax,%esi
 
  if(argint(n, &i) < 0)
80104d52:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104d55:	83 ec 08             	sub    $0x8,%esp
80104d58:	50                   	push   %eax
80104d59:	ff 75 08             	pushl  0x8(%ebp)
80104d5c:	e8 8f ff ff ff       	call   80104cf0 <argint>
    return -1;
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80104d61:	83 c4 10             	add    $0x10,%esp
80104d64:	85 c0                	test   %eax,%eax
80104d66:	78 28                	js     80104d90 <argptr+0x50>
80104d68:	85 db                	test   %ebx,%ebx
80104d6a:	78 24                	js     80104d90 <argptr+0x50>
80104d6c:	8b 16                	mov    (%esi),%edx
80104d6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d71:	39 c2                	cmp    %eax,%edx
80104d73:	76 1b                	jbe    80104d90 <argptr+0x50>
80104d75:	01 c3                	add    %eax,%ebx
80104d77:	39 da                	cmp    %ebx,%edx
80104d79:	72 15                	jb     80104d90 <argptr+0x50>
    return -1;
  *pp = (char*)i;
80104d7b:	8b 55 0c             	mov    0xc(%ebp),%edx
80104d7e:	89 02                	mov    %eax,(%edx)
  return 0;
80104d80:	31 c0                	xor    %eax,%eax
}
80104d82:	8d 65 f8             	lea    -0x8(%ebp),%esp
80104d85:	5b                   	pop    %ebx
80104d86:	5e                   	pop    %esi
80104d87:	5d                   	pop    %ebp
80104d88:	c3                   	ret    
80104d89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104d90:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104d95:	eb eb                	jmp    80104d82 <argptr+0x42>
80104d97:	89 f6                	mov    %esi,%esi
80104d99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104da0 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80104da0:	55                   	push   %ebp
80104da1:	89 e5                	mov    %esp,%ebp
80104da3:	83 ec 20             	sub    $0x20,%esp
  int addr;
  if(argint(n, &addr) < 0)
80104da6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80104da9:	50                   	push   %eax
80104daa:	ff 75 08             	pushl  0x8(%ebp)
80104dad:	e8 3e ff ff ff       	call   80104cf0 <argint>
80104db2:	83 c4 10             	add    $0x10,%esp
80104db5:	85 c0                	test   %eax,%eax
80104db7:	78 17                	js     80104dd0 <argstr+0x30>
    return -1;
  return fetchstr(addr, pp);
80104db9:	83 ec 08             	sub    $0x8,%esp
80104dbc:	ff 75 0c             	pushl  0xc(%ebp)
80104dbf:	ff 75 f4             	pushl  -0xc(%ebp)
80104dc2:	e8 b9 fe ff ff       	call   80104c80 <fetchstr>
80104dc7:	83 c4 10             	add    $0x10,%esp
}
80104dca:	c9                   	leave  
80104dcb:	c3                   	ret    
80104dcc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80104dd0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80104dd5:	c9                   	leave  
80104dd6:	c3                   	ret    
80104dd7:	89 f6                	mov    %esi,%esi
80104dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80104de0 <syscall>:



void
syscall(void)
{
80104de0:	55                   	push   %ebp
80104de1:	89 e5                	mov    %esp,%ebp
80104de3:	53                   	push   %ebx
80104de4:	83 ec 04             	sub    $0x4,%esp
  int num;
  struct proc *curproc = myproc();
80104de7:	e8 a4 ea ff ff       	call   80103890 <myproc>
  

  //tf is the trapframe for the syscall
  //eax is a register value
  num = curproc->tf->eax;
  if(sys_trace==1){
80104dec:	83 3d 80 b8 10 80 01 	cmpl   $0x1,0x8010b880
  struct proc *curproc = myproc();
80104df3:	89 c3                	mov    %eax,%ebx
  num = curproc->tf->eax;
80104df5:	8b 40 18             	mov    0x18(%eax),%eax
80104df8:	8b 40 1c             	mov    0x1c(%eax),%eax
  if(sys_trace==1){
80104dfb:	75 08                	jne    80104e05 <syscall+0x25>
    syscall_trace[num]+=1;
80104dfd:	83 04 85 a0 b8 10 80 	addl   $0x1,-0x7fef4760(,%eax,4)
80104e04:	01 
  }
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
80104e05:	8d 50 ff             	lea    -0x1(%eax),%edx
80104e08:	83 fa 20             	cmp    $0x20,%edx
80104e0b:	77 1b                	ja     80104e28 <syscall+0x48>
80104e0d:	8b 14 85 80 85 10 80 	mov    -0x7fef7a80(,%eax,4),%edx
80104e14:	85 d2                	test   %edx,%edx
80104e16:	74 10                	je     80104e28 <syscall+0x48>
    curproc->tf->eax = syscalls[num]();
80104e18:	ff d2                	call   *%edx
80104e1a:	8b 53 18             	mov    0x18(%ebx),%edx
80104e1d:	89 42 1c             	mov    %eax,0x1c(%edx)
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
    curproc->tf->eax = -1;
  }
}
80104e20:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e23:	c9                   	leave  
80104e24:	c3                   	ret    
80104e25:	8d 76 00             	lea    0x0(%esi),%esi
    cprintf("%d %s: unknown sys call %d\n",
80104e28:	50                   	push   %eax
            curproc->pid, curproc->name, num);
80104e29:	8d 83 dc 04 00 00    	lea    0x4dc(%ebx),%eax
    cprintf("%d %s: unknown sys call %d\n",
80104e2f:	50                   	push   %eax
80104e30:	ff 73 10             	pushl  0x10(%ebx)
80104e33:	68 5d 85 10 80       	push   $0x8010855d
80104e38:	e8 23 b8 ff ff       	call   80100660 <cprintf>
    curproc->tf->eax = -1;
80104e3d:	8b 43 18             	mov    0x18(%ebx),%eax
80104e40:	83 c4 10             	add    $0x10,%esp
80104e43:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
}
80104e4a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80104e4d:	c9                   	leave  
80104e4e:	c3                   	ret    
80104e4f:	90                   	nop

80104e50 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
80104e50:	55                   	push   %ebp
80104e51:	89 e5                	mov    %esp,%ebp
80104e53:	57                   	push   %edi
80104e54:	56                   	push   %esi
80104e55:	53                   	push   %ebx
  uint off;
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80104e56:	8d 75 da             	lea    -0x26(%ebp),%esi
{
80104e59:	83 ec 44             	sub    $0x44,%esp
80104e5c:	89 4d c0             	mov    %ecx,-0x40(%ebp)
80104e5f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  if((dp = nameiparent(path, name)) == 0)
80104e62:	56                   	push   %esi
80104e63:	50                   	push   %eax
{
80104e64:	89 55 c4             	mov    %edx,-0x3c(%ebp)
80104e67:	89 4d bc             	mov    %ecx,-0x44(%ebp)
  if((dp = nameiparent(path, name)) == 0)
80104e6a:	e8 b1 d0 ff ff       	call   80101f20 <nameiparent>
80104e6f:	83 c4 10             	add    $0x10,%esp
80104e72:	85 c0                	test   %eax,%eax
80104e74:	0f 84 46 01 00 00    	je     80104fc0 <create+0x170>
    return 0;
  ilock(dp);
80104e7a:	83 ec 0c             	sub    $0xc,%esp
80104e7d:	89 c3                	mov    %eax,%ebx
80104e7f:	50                   	push   %eax
80104e80:	e8 0b c8 ff ff       	call   80101690 <ilock>

  if((ip = dirlookup(dp, name, &off)) != 0){
80104e85:	8d 45 d4             	lea    -0x2c(%ebp),%eax
80104e88:	83 c4 0c             	add    $0xc,%esp
80104e8b:	50                   	push   %eax
80104e8c:	56                   	push   %esi
80104e8d:	53                   	push   %ebx
80104e8e:	e8 2d cd ff ff       	call   80101bc0 <dirlookup>
80104e93:	83 c4 10             	add    $0x10,%esp
80104e96:	85 c0                	test   %eax,%eax
80104e98:	89 c7                	mov    %eax,%edi
80104e9a:	74 34                	je     80104ed0 <create+0x80>
    iunlockput(dp);
80104e9c:	83 ec 0c             	sub    $0xc,%esp
80104e9f:	53                   	push   %ebx
80104ea0:	e8 7b ca ff ff       	call   80101920 <iunlockput>
    ilock(ip);
80104ea5:	89 3c 24             	mov    %edi,(%esp)
80104ea8:	e8 e3 c7 ff ff       	call   80101690 <ilock>
    if(type == T_FILE && ip->type == T_FILE)
80104ead:	83 c4 10             	add    $0x10,%esp
80104eb0:	66 83 7d c4 02       	cmpw   $0x2,-0x3c(%ebp)
80104eb5:	0f 85 95 00 00 00    	jne    80104f50 <create+0x100>
80104ebb:	66 83 7f 50 02       	cmpw   $0x2,0x50(%edi)
80104ec0:	0f 85 8a 00 00 00    	jne    80104f50 <create+0x100>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
80104ec6:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104ec9:	89 f8                	mov    %edi,%eax
80104ecb:	5b                   	pop    %ebx
80104ecc:	5e                   	pop    %esi
80104ecd:	5f                   	pop    %edi
80104ece:	5d                   	pop    %ebp
80104ecf:	c3                   	ret    
  if((ip = ialloc(dp->dev, type)) == 0)
80104ed0:	0f bf 45 c4          	movswl -0x3c(%ebp),%eax
80104ed4:	83 ec 08             	sub    $0x8,%esp
80104ed7:	50                   	push   %eax
80104ed8:	ff 33                	pushl  (%ebx)
80104eda:	e8 41 c6 ff ff       	call   80101520 <ialloc>
80104edf:	83 c4 10             	add    $0x10,%esp
80104ee2:	85 c0                	test   %eax,%eax
80104ee4:	89 c7                	mov    %eax,%edi
80104ee6:	0f 84 e8 00 00 00    	je     80104fd4 <create+0x184>
  ilock(ip);
80104eec:	83 ec 0c             	sub    $0xc,%esp
80104eef:	50                   	push   %eax
80104ef0:	e8 9b c7 ff ff       	call   80101690 <ilock>
  ip->major = major;
80104ef5:	0f b7 45 c0          	movzwl -0x40(%ebp),%eax
80104ef9:	66 89 47 52          	mov    %ax,0x52(%edi)
  ip->minor = minor;
80104efd:	0f b7 45 bc          	movzwl -0x44(%ebp),%eax
80104f01:	66 89 47 54          	mov    %ax,0x54(%edi)
  ip->nlink = 1;
80104f05:	b8 01 00 00 00       	mov    $0x1,%eax
80104f0a:	66 89 47 56          	mov    %ax,0x56(%edi)
  iupdate(ip);
80104f0e:	89 3c 24             	mov    %edi,(%esp)
80104f11:	e8 ca c6 ff ff       	call   801015e0 <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
80104f16:	83 c4 10             	add    $0x10,%esp
80104f19:	66 83 7d c4 01       	cmpw   $0x1,-0x3c(%ebp)
80104f1e:	74 50                	je     80104f70 <create+0x120>
  if(dirlink(dp, name, ip->inum) < 0)
80104f20:	83 ec 04             	sub    $0x4,%esp
80104f23:	ff 77 04             	pushl  0x4(%edi)
80104f26:	56                   	push   %esi
80104f27:	53                   	push   %ebx
80104f28:	e8 13 cf ff ff       	call   80101e40 <dirlink>
80104f2d:	83 c4 10             	add    $0x10,%esp
80104f30:	85 c0                	test   %eax,%eax
80104f32:	0f 88 8f 00 00 00    	js     80104fc7 <create+0x177>
  iunlockput(dp);
80104f38:	83 ec 0c             	sub    $0xc,%esp
80104f3b:	53                   	push   %ebx
80104f3c:	e8 df c9 ff ff       	call   80101920 <iunlockput>
  return ip;
80104f41:	83 c4 10             	add    $0x10,%esp
}
80104f44:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f47:	89 f8                	mov    %edi,%eax
80104f49:	5b                   	pop    %ebx
80104f4a:	5e                   	pop    %esi
80104f4b:	5f                   	pop    %edi
80104f4c:	5d                   	pop    %ebp
80104f4d:	c3                   	ret    
80104f4e:	66 90                	xchg   %ax,%ax
    iunlockput(ip);
80104f50:	83 ec 0c             	sub    $0xc,%esp
80104f53:	57                   	push   %edi
    return 0;
80104f54:	31 ff                	xor    %edi,%edi
    iunlockput(ip);
80104f56:	e8 c5 c9 ff ff       	call   80101920 <iunlockput>
    return 0;
80104f5b:	83 c4 10             	add    $0x10,%esp
}
80104f5e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80104f61:	89 f8                	mov    %edi,%eax
80104f63:	5b                   	pop    %ebx
80104f64:	5e                   	pop    %esi
80104f65:	5f                   	pop    %edi
80104f66:	5d                   	pop    %ebp
80104f67:	c3                   	ret    
80104f68:	90                   	nop
80104f69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink++;  // for ".."
80104f70:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
    iupdate(dp);
80104f75:	83 ec 0c             	sub    $0xc,%esp
80104f78:	53                   	push   %ebx
80104f79:	e8 62 c6 ff ff       	call   801015e0 <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80104f7e:	83 c4 0c             	add    $0xc,%esp
80104f81:	ff 77 04             	pushl  0x4(%edi)
80104f84:	68 24 86 10 80       	push   $0x80108624
80104f89:	57                   	push   %edi
80104f8a:	e8 b1 ce ff ff       	call   80101e40 <dirlink>
80104f8f:	83 c4 10             	add    $0x10,%esp
80104f92:	85 c0                	test   %eax,%eax
80104f94:	78 1c                	js     80104fb2 <create+0x162>
80104f96:	83 ec 04             	sub    $0x4,%esp
80104f99:	ff 73 04             	pushl  0x4(%ebx)
80104f9c:	68 23 86 10 80       	push   $0x80108623
80104fa1:	57                   	push   %edi
80104fa2:	e8 99 ce ff ff       	call   80101e40 <dirlink>
80104fa7:	83 c4 10             	add    $0x10,%esp
80104faa:	85 c0                	test   %eax,%eax
80104fac:	0f 89 6e ff ff ff    	jns    80104f20 <create+0xd0>
      panic("create dots");
80104fb2:	83 ec 0c             	sub    $0xc,%esp
80104fb5:	68 17 86 10 80       	push   $0x80108617
80104fba:	e8 d1 b3 ff ff       	call   80100390 <panic>
80104fbf:	90                   	nop
    return 0;
80104fc0:	31 ff                	xor    %edi,%edi
80104fc2:	e9 ff fe ff ff       	jmp    80104ec6 <create+0x76>
    panic("create: dirlink");
80104fc7:	83 ec 0c             	sub    $0xc,%esp
80104fca:	68 26 86 10 80       	push   $0x80108626
80104fcf:	e8 bc b3 ff ff       	call   80100390 <panic>
    panic("create: ialloc");
80104fd4:	83 ec 0c             	sub    $0xc,%esp
80104fd7:	68 08 86 10 80       	push   $0x80108608
80104fdc:	e8 af b3 ff ff       	call   80100390 <panic>
80104fe1:	eb 0d                	jmp    80104ff0 <argfd.constprop.0>
80104fe3:	90                   	nop
80104fe4:	90                   	nop
80104fe5:	90                   	nop
80104fe6:	90                   	nop
80104fe7:	90                   	nop
80104fe8:	90                   	nop
80104fe9:	90                   	nop
80104fea:	90                   	nop
80104feb:	90                   	nop
80104fec:	90                   	nop
80104fed:	90                   	nop
80104fee:	90                   	nop
80104fef:	90                   	nop

80104ff0 <argfd.constprop.0>:
argfd(int n, int *pfd, struct file **pf)
80104ff0:	55                   	push   %ebp
80104ff1:	89 e5                	mov    %esp,%ebp
80104ff3:	56                   	push   %esi
80104ff4:	53                   	push   %ebx
80104ff5:	89 c3                	mov    %eax,%ebx
  if(argint(n, &fd) < 0)
80104ff7:	8d 45 f4             	lea    -0xc(%ebp),%eax
argfd(int n, int *pfd, struct file **pf)
80104ffa:	89 d6                	mov    %edx,%esi
80104ffc:	83 ec 18             	sub    $0x18,%esp
  if(argint(n, &fd) < 0)
80104fff:	50                   	push   %eax
80105000:	6a 00                	push   $0x0
80105002:	e8 e9 fc ff ff       	call   80104cf0 <argint>
80105007:	83 c4 10             	add    $0x10,%esp
8010500a:	85 c0                	test   %eax,%eax
8010500c:	78 32                	js     80105040 <argfd.constprop.0+0x50>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010500e:	81 7d f4 2b 01 00 00 	cmpl   $0x12b,-0xc(%ebp)
80105015:	77 29                	ja     80105040 <argfd.constprop.0+0x50>
80105017:	e8 74 e8 ff ff       	call   80103890 <myproc>
8010501c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010501f:	8b 44 90 28          	mov    0x28(%eax,%edx,4),%eax
80105023:	85 c0                	test   %eax,%eax
80105025:	74 19                	je     80105040 <argfd.constprop.0+0x50>
  if(pfd)
80105027:	85 db                	test   %ebx,%ebx
80105029:	74 02                	je     8010502d <argfd.constprop.0+0x3d>
    *pfd = fd;
8010502b:	89 13                	mov    %edx,(%ebx)
    *pf = f;
8010502d:	89 06                	mov    %eax,(%esi)
  return 0;
8010502f:	31 c0                	xor    %eax,%eax
}
80105031:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105034:	5b                   	pop    %ebx
80105035:	5e                   	pop    %esi
80105036:	5d                   	pop    %ebp
80105037:	c3                   	ret    
80105038:	90                   	nop
80105039:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105040:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105045:	eb ea                	jmp    80105031 <argfd.constprop.0+0x41>
80105047:	89 f6                	mov    %esi,%esi
80105049:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105050 <sys_dup>:
{
80105050:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0)
80105051:	31 c0                	xor    %eax,%eax
{
80105053:	89 e5                	mov    %esp,%ebp
80105055:	56                   	push   %esi
80105056:	53                   	push   %ebx
  if(argfd(0, 0, &f) < 0)
80105057:	8d 55 f4             	lea    -0xc(%ebp),%edx
{
8010505a:	83 ec 10             	sub    $0x10,%esp
  if(argfd(0, 0, &f) < 0)
8010505d:	e8 8e ff ff ff       	call   80104ff0 <argfd.constprop.0>
80105062:	85 c0                	test   %eax,%eax
80105064:	78 4a                	js     801050b0 <sys_dup+0x60>
  if((fd=fdalloc(f)) < 0)
80105066:	8b 75 f4             	mov    -0xc(%ebp),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105069:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
8010506b:	e8 20 e8 ff ff       	call   80103890 <myproc>
80105070:	eb 11                	jmp    80105083 <sys_dup+0x33>
80105072:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  for(fd = 0; fd < NOFILE; fd++){
80105078:	83 c3 01             	add    $0x1,%ebx
8010507b:	81 fb 2c 01 00 00    	cmp    $0x12c,%ebx
80105081:	74 2d                	je     801050b0 <sys_dup+0x60>
    if(curproc->ofile[fd] == 0){
80105083:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105087:	85 d2                	test   %edx,%edx
80105089:	75 ed                	jne    80105078 <sys_dup+0x28>
      curproc->ofile[fd] = f;
8010508b:	89 74 98 28          	mov    %esi,0x28(%eax,%ebx,4)
  filedup(f);
8010508f:	83 ec 0c             	sub    $0xc,%esp
80105092:	ff 75 f4             	pushl  -0xc(%ebp)
80105095:	e8 56 bd ff ff       	call   80100df0 <filedup>
  return fd;
8010509a:	83 c4 10             	add    $0x10,%esp
}
8010509d:	8d 65 f8             	lea    -0x8(%ebp),%esp
801050a0:	89 d8                	mov    %ebx,%eax
801050a2:	5b                   	pop    %ebx
801050a3:	5e                   	pop    %esi
801050a4:	5d                   	pop    %ebp
801050a5:	c3                   	ret    
801050a6:	8d 76 00             	lea    0x0(%esi),%esi
801050a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801050b0:	8d 65 f8             	lea    -0x8(%ebp),%esp
    return -1;
801050b3:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
}
801050b8:	89 d8                	mov    %ebx,%eax
801050ba:	5b                   	pop    %ebx
801050bb:	5e                   	pop    %esi
801050bc:	5d                   	pop    %ebp
801050bd:	c3                   	ret    
801050be:	66 90                	xchg   %ax,%ax

801050c0 <sys_read>:
{
801050c0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801050c1:	31 c0                	xor    %eax,%eax
{
801050c3:	89 e5                	mov    %esp,%ebp
801050c5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801050c8:	8d 55 ec             	lea    -0x14(%ebp),%edx
801050cb:	e8 20 ff ff ff       	call   80104ff0 <argfd.constprop.0>
801050d0:	85 c0                	test   %eax,%eax
801050d2:	78 4c                	js     80105120 <sys_read+0x60>
801050d4:	8d 45 f0             	lea    -0x10(%ebp),%eax
801050d7:	83 ec 08             	sub    $0x8,%esp
801050da:	50                   	push   %eax
801050db:	6a 02                	push   $0x2
801050dd:	e8 0e fc ff ff       	call   80104cf0 <argint>
801050e2:	83 c4 10             	add    $0x10,%esp
801050e5:	85 c0                	test   %eax,%eax
801050e7:	78 37                	js     80105120 <sys_read+0x60>
801050e9:	8d 45 f4             	lea    -0xc(%ebp),%eax
801050ec:	83 ec 04             	sub    $0x4,%esp
801050ef:	ff 75 f0             	pushl  -0x10(%ebp)
801050f2:	50                   	push   %eax
801050f3:	6a 01                	push   $0x1
801050f5:	e8 46 fc ff ff       	call   80104d40 <argptr>
801050fa:	83 c4 10             	add    $0x10,%esp
801050fd:	85 c0                	test   %eax,%eax
801050ff:	78 1f                	js     80105120 <sys_read+0x60>
  return fileread(f, p, n);
80105101:	83 ec 04             	sub    $0x4,%esp
80105104:	ff 75 f0             	pushl  -0x10(%ebp)
80105107:	ff 75 f4             	pushl  -0xc(%ebp)
8010510a:	ff 75 ec             	pushl  -0x14(%ebp)
8010510d:	e8 4e be ff ff       	call   80100f60 <fileread>
80105112:	83 c4 10             	add    $0x10,%esp
}
80105115:	c9                   	leave  
80105116:	c3                   	ret    
80105117:	89 f6                	mov    %esi,%esi
80105119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105120:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105125:	c9                   	leave  
80105126:	c3                   	ret    
80105127:	89 f6                	mov    %esi,%esi
80105129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105130 <sys_write>:
{
80105130:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105131:	31 c0                	xor    %eax,%eax
{
80105133:	89 e5                	mov    %esp,%ebp
80105135:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80105138:	8d 55 ec             	lea    -0x14(%ebp),%edx
8010513b:	e8 b0 fe ff ff       	call   80104ff0 <argfd.constprop.0>
80105140:	85 c0                	test   %eax,%eax
80105142:	78 4c                	js     80105190 <sys_write+0x60>
80105144:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105147:	83 ec 08             	sub    $0x8,%esp
8010514a:	50                   	push   %eax
8010514b:	6a 02                	push   $0x2
8010514d:	e8 9e fb ff ff       	call   80104cf0 <argint>
80105152:	83 c4 10             	add    $0x10,%esp
80105155:	85 c0                	test   %eax,%eax
80105157:	78 37                	js     80105190 <sys_write+0x60>
80105159:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010515c:	83 ec 04             	sub    $0x4,%esp
8010515f:	ff 75 f0             	pushl  -0x10(%ebp)
80105162:	50                   	push   %eax
80105163:	6a 01                	push   $0x1
80105165:	e8 d6 fb ff ff       	call   80104d40 <argptr>
8010516a:	83 c4 10             	add    $0x10,%esp
8010516d:	85 c0                	test   %eax,%eax
8010516f:	78 1f                	js     80105190 <sys_write+0x60>
  return filewrite(f, p, n);
80105171:	83 ec 04             	sub    $0x4,%esp
80105174:	ff 75 f0             	pushl  -0x10(%ebp)
80105177:	ff 75 f4             	pushl  -0xc(%ebp)
8010517a:	ff 75 ec             	pushl  -0x14(%ebp)
8010517d:	e8 6e be ff ff       	call   80100ff0 <filewrite>
80105182:	83 c4 10             	add    $0x10,%esp
}
80105185:	c9                   	leave  
80105186:	c3                   	ret    
80105187:	89 f6                	mov    %esi,%esi
80105189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
80105190:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105195:	c9                   	leave  
80105196:	c3                   	ret    
80105197:	89 f6                	mov    %esi,%esi
80105199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051a0 <sys_close>:
{
801051a0:	55                   	push   %ebp
801051a1:	89 e5                	mov    %esp,%ebp
801051a3:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, &fd, &f) < 0)
801051a6:	8d 55 f4             	lea    -0xc(%ebp),%edx
801051a9:	8d 45 f0             	lea    -0x10(%ebp),%eax
801051ac:	e8 3f fe ff ff       	call   80104ff0 <argfd.constprop.0>
801051b1:	85 c0                	test   %eax,%eax
801051b3:	78 2b                	js     801051e0 <sys_close+0x40>
  myproc()->ofile[fd] = 0;
801051b5:	e8 d6 e6 ff ff       	call   80103890 <myproc>
801051ba:	8b 55 f0             	mov    -0x10(%ebp),%edx
  fileclose(f);
801051bd:	83 ec 0c             	sub    $0xc,%esp
  myproc()->ofile[fd] = 0;
801051c0:	c7 44 90 28 00 00 00 	movl   $0x0,0x28(%eax,%edx,4)
801051c7:	00 
  fileclose(f);
801051c8:	ff 75 f4             	pushl  -0xc(%ebp)
801051cb:	e8 70 bc ff ff       	call   80100e40 <fileclose>
  return 0;
801051d0:	83 c4 10             	add    $0x10,%esp
801051d3:	31 c0                	xor    %eax,%eax
}
801051d5:	c9                   	leave  
801051d6:	c3                   	ret    
801051d7:	89 f6                	mov    %esi,%esi
801051d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    return -1;
801051e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801051e5:	c9                   	leave  
801051e6:	c3                   	ret    
801051e7:	89 f6                	mov    %esi,%esi
801051e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801051f0 <sys_fstat>:
{
801051f0:	55                   	push   %ebp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801051f1:	31 c0                	xor    %eax,%eax
{
801051f3:	89 e5                	mov    %esp,%ebp
801051f5:	83 ec 18             	sub    $0x18,%esp
  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
801051f8:	8d 55 f0             	lea    -0x10(%ebp),%edx
801051fb:	e8 f0 fd ff ff       	call   80104ff0 <argfd.constprop.0>
80105200:	85 c0                	test   %eax,%eax
80105202:	78 2c                	js     80105230 <sys_fstat+0x40>
80105204:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105207:	83 ec 04             	sub    $0x4,%esp
8010520a:	6a 14                	push   $0x14
8010520c:	50                   	push   %eax
8010520d:	6a 01                	push   $0x1
8010520f:	e8 2c fb ff ff       	call   80104d40 <argptr>
80105214:	83 c4 10             	add    $0x10,%esp
80105217:	85 c0                	test   %eax,%eax
80105219:	78 15                	js     80105230 <sys_fstat+0x40>
  return filestat(f, st);
8010521b:	83 ec 08             	sub    $0x8,%esp
8010521e:	ff 75 f4             	pushl  -0xc(%ebp)
80105221:	ff 75 f0             	pushl  -0x10(%ebp)
80105224:	e8 e7 bc ff ff       	call   80100f10 <filestat>
80105229:	83 c4 10             	add    $0x10,%esp
}
8010522c:	c9                   	leave  
8010522d:	c3                   	ret    
8010522e:	66 90                	xchg   %ax,%ax
    return -1;
80105230:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105235:	c9                   	leave  
80105236:	c3                   	ret    
80105237:	89 f6                	mov    %esi,%esi
80105239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105240 <sys_link>:
{
80105240:	55                   	push   %ebp
80105241:	89 e5                	mov    %esp,%ebp
80105243:	57                   	push   %edi
80105244:	56                   	push   %esi
80105245:	53                   	push   %ebx
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
80105246:	8d 45 d4             	lea    -0x2c(%ebp),%eax
{
80105249:	83 ec 34             	sub    $0x34,%esp
  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
8010524c:	50                   	push   %eax
8010524d:	6a 00                	push   $0x0
8010524f:	e8 4c fb ff ff       	call   80104da0 <argstr>
80105254:	83 c4 10             	add    $0x10,%esp
80105257:	85 c0                	test   %eax,%eax
80105259:	0f 88 fb 00 00 00    	js     8010535a <sys_link+0x11a>
8010525f:	8d 45 d0             	lea    -0x30(%ebp),%eax
80105262:	83 ec 08             	sub    $0x8,%esp
80105265:	50                   	push   %eax
80105266:	6a 01                	push   $0x1
80105268:	e8 33 fb ff ff       	call   80104da0 <argstr>
8010526d:	83 c4 10             	add    $0x10,%esp
80105270:	85 c0                	test   %eax,%eax
80105272:	0f 88 e2 00 00 00    	js     8010535a <sys_link+0x11a>
  begin_op();
80105278:	e8 43 d9 ff ff       	call   80102bc0 <begin_op>
  if((ip = namei(old)) == 0){
8010527d:	83 ec 0c             	sub    $0xc,%esp
80105280:	ff 75 d4             	pushl  -0x2c(%ebp)
80105283:	e8 78 cc ff ff       	call   80101f00 <namei>
80105288:	83 c4 10             	add    $0x10,%esp
8010528b:	85 c0                	test   %eax,%eax
8010528d:	89 c3                	mov    %eax,%ebx
8010528f:	0f 84 ea 00 00 00    	je     8010537f <sys_link+0x13f>
  ilock(ip);
80105295:	83 ec 0c             	sub    $0xc,%esp
80105298:	50                   	push   %eax
80105299:	e8 f2 c3 ff ff       	call   80101690 <ilock>
  if(ip->type == T_DIR){
8010529e:	83 c4 10             	add    $0x10,%esp
801052a1:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
801052a6:	0f 84 bb 00 00 00    	je     80105367 <sys_link+0x127>
  ip->nlink++;
801052ac:	66 83 43 56 01       	addw   $0x1,0x56(%ebx)
  iupdate(ip);
801052b1:	83 ec 0c             	sub    $0xc,%esp
  if((dp = nameiparent(new, name)) == 0)
801052b4:	8d 7d da             	lea    -0x26(%ebp),%edi
  iupdate(ip);
801052b7:	53                   	push   %ebx
801052b8:	e8 23 c3 ff ff       	call   801015e0 <iupdate>
  iunlock(ip);
801052bd:	89 1c 24             	mov    %ebx,(%esp)
801052c0:	e8 ab c4 ff ff       	call   80101770 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
801052c5:	58                   	pop    %eax
801052c6:	5a                   	pop    %edx
801052c7:	57                   	push   %edi
801052c8:	ff 75 d0             	pushl  -0x30(%ebp)
801052cb:	e8 50 cc ff ff       	call   80101f20 <nameiparent>
801052d0:	83 c4 10             	add    $0x10,%esp
801052d3:	85 c0                	test   %eax,%eax
801052d5:	89 c6                	mov    %eax,%esi
801052d7:	74 5b                	je     80105334 <sys_link+0xf4>
  ilock(dp);
801052d9:	83 ec 0c             	sub    $0xc,%esp
801052dc:	50                   	push   %eax
801052dd:	e8 ae c3 ff ff       	call   80101690 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
801052e2:	83 c4 10             	add    $0x10,%esp
801052e5:	8b 03                	mov    (%ebx),%eax
801052e7:	39 06                	cmp    %eax,(%esi)
801052e9:	75 3d                	jne    80105328 <sys_link+0xe8>
801052eb:	83 ec 04             	sub    $0x4,%esp
801052ee:	ff 73 04             	pushl  0x4(%ebx)
801052f1:	57                   	push   %edi
801052f2:	56                   	push   %esi
801052f3:	e8 48 cb ff ff       	call   80101e40 <dirlink>
801052f8:	83 c4 10             	add    $0x10,%esp
801052fb:	85 c0                	test   %eax,%eax
801052fd:	78 29                	js     80105328 <sys_link+0xe8>
  iunlockput(dp);
801052ff:	83 ec 0c             	sub    $0xc,%esp
80105302:	56                   	push   %esi
80105303:	e8 18 c6 ff ff       	call   80101920 <iunlockput>
  iput(ip);
80105308:	89 1c 24             	mov    %ebx,(%esp)
8010530b:	e8 b0 c4 ff ff       	call   801017c0 <iput>
  end_op();
80105310:	e8 1b d9 ff ff       	call   80102c30 <end_op>
  return 0;
80105315:	83 c4 10             	add    $0x10,%esp
80105318:	31 c0                	xor    %eax,%eax
}
8010531a:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010531d:	5b                   	pop    %ebx
8010531e:	5e                   	pop    %esi
8010531f:	5f                   	pop    %edi
80105320:	5d                   	pop    %ebp
80105321:	c3                   	ret    
80105322:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    iunlockput(dp);
80105328:	83 ec 0c             	sub    $0xc,%esp
8010532b:	56                   	push   %esi
8010532c:	e8 ef c5 ff ff       	call   80101920 <iunlockput>
    goto bad;
80105331:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80105334:	83 ec 0c             	sub    $0xc,%esp
80105337:	53                   	push   %ebx
80105338:	e8 53 c3 ff ff       	call   80101690 <ilock>
  ip->nlink--;
8010533d:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105342:	89 1c 24             	mov    %ebx,(%esp)
80105345:	e8 96 c2 ff ff       	call   801015e0 <iupdate>
  iunlockput(ip);
8010534a:	89 1c 24             	mov    %ebx,(%esp)
8010534d:	e8 ce c5 ff ff       	call   80101920 <iunlockput>
  end_op();
80105352:	e8 d9 d8 ff ff       	call   80102c30 <end_op>
  return -1;
80105357:	83 c4 10             	add    $0x10,%esp
}
8010535a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return -1;
8010535d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105362:	5b                   	pop    %ebx
80105363:	5e                   	pop    %esi
80105364:	5f                   	pop    %edi
80105365:	5d                   	pop    %ebp
80105366:	c3                   	ret    
    iunlockput(ip);
80105367:	83 ec 0c             	sub    $0xc,%esp
8010536a:	53                   	push   %ebx
8010536b:	e8 b0 c5 ff ff       	call   80101920 <iunlockput>
    end_op();
80105370:	e8 bb d8 ff ff       	call   80102c30 <end_op>
    return -1;
80105375:	83 c4 10             	add    $0x10,%esp
80105378:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010537d:	eb 9b                	jmp    8010531a <sys_link+0xda>
    end_op();
8010537f:	e8 ac d8 ff ff       	call   80102c30 <end_op>
    return -1;
80105384:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105389:	eb 8f                	jmp    8010531a <sys_link+0xda>
8010538b:	90                   	nop
8010538c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105390 <sys_unlink>:
{
80105390:	55                   	push   %ebp
80105391:	89 e5                	mov    %esp,%ebp
80105393:	57                   	push   %edi
80105394:	56                   	push   %esi
80105395:	53                   	push   %ebx
  if(argstr(0, &path) < 0)
80105396:	8d 45 c0             	lea    -0x40(%ebp),%eax
{
80105399:	83 ec 44             	sub    $0x44,%esp
  if(argstr(0, &path) < 0)
8010539c:	50                   	push   %eax
8010539d:	6a 00                	push   $0x0
8010539f:	e8 fc f9 ff ff       	call   80104da0 <argstr>
801053a4:	83 c4 10             	add    $0x10,%esp
801053a7:	85 c0                	test   %eax,%eax
801053a9:	0f 88 77 01 00 00    	js     80105526 <sys_unlink+0x196>
  if((dp = nameiparent(path, name)) == 0){
801053af:	8d 5d ca             	lea    -0x36(%ebp),%ebx
  begin_op();
801053b2:	e8 09 d8 ff ff       	call   80102bc0 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
801053b7:	83 ec 08             	sub    $0x8,%esp
801053ba:	53                   	push   %ebx
801053bb:	ff 75 c0             	pushl  -0x40(%ebp)
801053be:	e8 5d cb ff ff       	call   80101f20 <nameiparent>
801053c3:	83 c4 10             	add    $0x10,%esp
801053c6:	85 c0                	test   %eax,%eax
801053c8:	89 c6                	mov    %eax,%esi
801053ca:	0f 84 60 01 00 00    	je     80105530 <sys_unlink+0x1a0>
  ilock(dp);
801053d0:	83 ec 0c             	sub    $0xc,%esp
801053d3:	50                   	push   %eax
801053d4:	e8 b7 c2 ff ff       	call   80101690 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
801053d9:	58                   	pop    %eax
801053da:	5a                   	pop    %edx
801053db:	68 24 86 10 80       	push   $0x80108624
801053e0:	53                   	push   %ebx
801053e1:	e8 ba c7 ff ff       	call   80101ba0 <namecmp>
801053e6:	83 c4 10             	add    $0x10,%esp
801053e9:	85 c0                	test   %eax,%eax
801053eb:	0f 84 03 01 00 00    	je     801054f4 <sys_unlink+0x164>
801053f1:	83 ec 08             	sub    $0x8,%esp
801053f4:	68 23 86 10 80       	push   $0x80108623
801053f9:	53                   	push   %ebx
801053fa:	e8 a1 c7 ff ff       	call   80101ba0 <namecmp>
801053ff:	83 c4 10             	add    $0x10,%esp
80105402:	85 c0                	test   %eax,%eax
80105404:	0f 84 ea 00 00 00    	je     801054f4 <sys_unlink+0x164>
  if((ip = dirlookup(dp, name, &off)) == 0)
8010540a:	8d 45 c4             	lea    -0x3c(%ebp),%eax
8010540d:	83 ec 04             	sub    $0x4,%esp
80105410:	50                   	push   %eax
80105411:	53                   	push   %ebx
80105412:	56                   	push   %esi
80105413:	e8 a8 c7 ff ff       	call   80101bc0 <dirlookup>
80105418:	83 c4 10             	add    $0x10,%esp
8010541b:	85 c0                	test   %eax,%eax
8010541d:	89 c3                	mov    %eax,%ebx
8010541f:	0f 84 cf 00 00 00    	je     801054f4 <sys_unlink+0x164>
  ilock(ip);
80105425:	83 ec 0c             	sub    $0xc,%esp
80105428:	50                   	push   %eax
80105429:	e8 62 c2 ff ff       	call   80101690 <ilock>
  if(ip->nlink < 1)
8010542e:	83 c4 10             	add    $0x10,%esp
80105431:	66 83 7b 56 00       	cmpw   $0x0,0x56(%ebx)
80105436:	0f 8e 10 01 00 00    	jle    8010554c <sys_unlink+0x1bc>
  if(ip->type == T_DIR && !isdirempty(ip)){
8010543c:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105441:	74 6d                	je     801054b0 <sys_unlink+0x120>
  memset(&de, 0, sizeof(de));
80105443:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105446:	83 ec 04             	sub    $0x4,%esp
80105449:	6a 10                	push   $0x10
8010544b:	6a 00                	push   $0x0
8010544d:	50                   	push   %eax
8010544e:	e8 9d f5 ff ff       	call   801049f0 <memset>
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80105453:	8d 45 d8             	lea    -0x28(%ebp),%eax
80105456:	6a 10                	push   $0x10
80105458:	ff 75 c4             	pushl  -0x3c(%ebp)
8010545b:	50                   	push   %eax
8010545c:	56                   	push   %esi
8010545d:	e8 0e c6 ff ff       	call   80101a70 <writei>
80105462:	83 c4 20             	add    $0x20,%esp
80105465:	83 f8 10             	cmp    $0x10,%eax
80105468:	0f 85 eb 00 00 00    	jne    80105559 <sys_unlink+0x1c9>
  if(ip->type == T_DIR){
8010546e:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
80105473:	0f 84 97 00 00 00    	je     80105510 <sys_unlink+0x180>
  iunlockput(dp);
80105479:	83 ec 0c             	sub    $0xc,%esp
8010547c:	56                   	push   %esi
8010547d:	e8 9e c4 ff ff       	call   80101920 <iunlockput>
  ip->nlink--;
80105482:	66 83 6b 56 01       	subw   $0x1,0x56(%ebx)
  iupdate(ip);
80105487:	89 1c 24             	mov    %ebx,(%esp)
8010548a:	e8 51 c1 ff ff       	call   801015e0 <iupdate>
  iunlockput(ip);
8010548f:	89 1c 24             	mov    %ebx,(%esp)
80105492:	e8 89 c4 ff ff       	call   80101920 <iunlockput>
  end_op();
80105497:	e8 94 d7 ff ff       	call   80102c30 <end_op>
  return 0;
8010549c:	83 c4 10             	add    $0x10,%esp
8010549f:	31 c0                	xor    %eax,%eax
}
801054a1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801054a4:	5b                   	pop    %ebx
801054a5:	5e                   	pop    %esi
801054a6:	5f                   	pop    %edi
801054a7:	5d                   	pop    %ebp
801054a8:	c3                   	ret    
801054a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
801054b0:	83 7b 58 20          	cmpl   $0x20,0x58(%ebx)
801054b4:	76 8d                	jbe    80105443 <sys_unlink+0xb3>
801054b6:	bf 20 00 00 00       	mov    $0x20,%edi
801054bb:	eb 0f                	jmp    801054cc <sys_unlink+0x13c>
801054bd:	8d 76 00             	lea    0x0(%esi),%esi
801054c0:	83 c7 10             	add    $0x10,%edi
801054c3:	3b 7b 58             	cmp    0x58(%ebx),%edi
801054c6:	0f 83 77 ff ff ff    	jae    80105443 <sys_unlink+0xb3>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801054cc:	8d 45 d8             	lea    -0x28(%ebp),%eax
801054cf:	6a 10                	push   $0x10
801054d1:	57                   	push   %edi
801054d2:	50                   	push   %eax
801054d3:	53                   	push   %ebx
801054d4:	e8 97 c4 ff ff       	call   80101970 <readi>
801054d9:	83 c4 10             	add    $0x10,%esp
801054dc:	83 f8 10             	cmp    $0x10,%eax
801054df:	75 5e                	jne    8010553f <sys_unlink+0x1af>
    if(de.inum != 0)
801054e1:	66 83 7d d8 00       	cmpw   $0x0,-0x28(%ebp)
801054e6:	74 d8                	je     801054c0 <sys_unlink+0x130>
    iunlockput(ip);
801054e8:	83 ec 0c             	sub    $0xc,%esp
801054eb:	53                   	push   %ebx
801054ec:	e8 2f c4 ff ff       	call   80101920 <iunlockput>
    goto bad;
801054f1:	83 c4 10             	add    $0x10,%esp
  iunlockput(dp);
801054f4:	83 ec 0c             	sub    $0xc,%esp
801054f7:	56                   	push   %esi
801054f8:	e8 23 c4 ff ff       	call   80101920 <iunlockput>
  end_op();
801054fd:	e8 2e d7 ff ff       	call   80102c30 <end_op>
  return -1;
80105502:	83 c4 10             	add    $0x10,%esp
80105505:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010550a:	eb 95                	jmp    801054a1 <sys_unlink+0x111>
8010550c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    dp->nlink--;
80105510:	66 83 6e 56 01       	subw   $0x1,0x56(%esi)
    iupdate(dp);
80105515:	83 ec 0c             	sub    $0xc,%esp
80105518:	56                   	push   %esi
80105519:	e8 c2 c0 ff ff       	call   801015e0 <iupdate>
8010551e:	83 c4 10             	add    $0x10,%esp
80105521:	e9 53 ff ff ff       	jmp    80105479 <sys_unlink+0xe9>
    return -1;
80105526:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010552b:	e9 71 ff ff ff       	jmp    801054a1 <sys_unlink+0x111>
    end_op();
80105530:	e8 fb d6 ff ff       	call   80102c30 <end_op>
    return -1;
80105535:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010553a:	e9 62 ff ff ff       	jmp    801054a1 <sys_unlink+0x111>
      panic("isdirempty: readi");
8010553f:	83 ec 0c             	sub    $0xc,%esp
80105542:	68 48 86 10 80       	push   $0x80108648
80105547:	e8 44 ae ff ff       	call   80100390 <panic>
    panic("unlink: nlink < 1");
8010554c:	83 ec 0c             	sub    $0xc,%esp
8010554f:	68 36 86 10 80       	push   $0x80108636
80105554:	e8 37 ae ff ff       	call   80100390 <panic>
    panic("unlink: writei");
80105559:	83 ec 0c             	sub    $0xc,%esp
8010555c:	68 5a 86 10 80       	push   $0x8010865a
80105561:	e8 2a ae ff ff       	call   80100390 <panic>
80105566:	8d 76 00             	lea    0x0(%esi),%esi
80105569:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105570 <sys_open>:

int
sys_open(void)
{
80105570:	55                   	push   %ebp
80105571:	89 e5                	mov    %esp,%ebp
80105573:	57                   	push   %edi
80105574:	56                   	push   %esi
80105575:	53                   	push   %ebx
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80105576:	8d 45 e0             	lea    -0x20(%ebp),%eax
{
80105579:	83 ec 24             	sub    $0x24,%esp
  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
8010557c:	50                   	push   %eax
8010557d:	6a 00                	push   $0x0
8010557f:	e8 1c f8 ff ff       	call   80104da0 <argstr>
80105584:	83 c4 10             	add    $0x10,%esp
80105587:	85 c0                	test   %eax,%eax
80105589:	0f 88 1d 01 00 00    	js     801056ac <sys_open+0x13c>
8010558f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105592:	83 ec 08             	sub    $0x8,%esp
80105595:	50                   	push   %eax
80105596:	6a 01                	push   $0x1
80105598:	e8 53 f7 ff ff       	call   80104cf0 <argint>
8010559d:	83 c4 10             	add    $0x10,%esp
801055a0:	85 c0                	test   %eax,%eax
801055a2:	0f 88 04 01 00 00    	js     801056ac <sys_open+0x13c>
    return -1;

  begin_op();
801055a8:	e8 13 d6 ff ff       	call   80102bc0 <begin_op>

  if(omode & O_CREATE){
801055ad:	f6 45 e5 02          	testb  $0x2,-0x1b(%ebp)
801055b1:	0f 85 a9 00 00 00    	jne    80105660 <sys_open+0xf0>
    if(ip == 0){
      end_op();
      return -1;
    }
  } else {
    if((ip = namei(path)) == 0){
801055b7:	83 ec 0c             	sub    $0xc,%esp
801055ba:	ff 75 e0             	pushl  -0x20(%ebp)
801055bd:	e8 3e c9 ff ff       	call   80101f00 <namei>
801055c2:	83 c4 10             	add    $0x10,%esp
801055c5:	85 c0                	test   %eax,%eax
801055c7:	89 c6                	mov    %eax,%esi
801055c9:	0f 84 b2 00 00 00    	je     80105681 <sys_open+0x111>
      end_op();
      return -1;
    }
    ilock(ip);
801055cf:	83 ec 0c             	sub    $0xc,%esp
801055d2:	50                   	push   %eax
801055d3:	e8 b8 c0 ff ff       	call   80101690 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
801055d8:	83 c4 10             	add    $0x10,%esp
801055db:	66 83 7e 50 01       	cmpw   $0x1,0x50(%esi)
801055e0:	0f 84 aa 00 00 00    	je     80105690 <sys_open+0x120>
      end_op();
      return -1;
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
801055e6:	e8 95 b7 ff ff       	call   80100d80 <filealloc>
801055eb:	85 c0                	test   %eax,%eax
801055ed:	89 c7                	mov    %eax,%edi
801055ef:	0f 84 a6 00 00 00    	je     8010569b <sys_open+0x12b>
  struct proc *curproc = myproc();
801055f5:	e8 96 e2 ff ff       	call   80103890 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801055fa:	31 db                	xor    %ebx,%ebx
801055fc:	eb 11                	jmp    8010560f <sys_open+0x9f>
801055fe:	66 90                	xchg   %ax,%ax
80105600:	83 c3 01             	add    $0x1,%ebx
80105603:	81 fb 2c 01 00 00    	cmp    $0x12c,%ebx
80105609:	0f 84 a9 00 00 00    	je     801056b8 <sys_open+0x148>
    if(curproc->ofile[fd] == 0){
8010560f:	8b 54 98 28          	mov    0x28(%eax,%ebx,4),%edx
80105613:	85 d2                	test   %edx,%edx
80105615:	75 e9                	jne    80105600 <sys_open+0x90>
      fileclose(f);
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105617:	83 ec 0c             	sub    $0xc,%esp
      curproc->ofile[fd] = f;
8010561a:	89 7c 98 28          	mov    %edi,0x28(%eax,%ebx,4)
  iunlock(ip);
8010561e:	56                   	push   %esi
8010561f:	e8 4c c1 ff ff       	call   80101770 <iunlock>
  end_op();
80105624:	e8 07 d6 ff ff       	call   80102c30 <end_op>

  f->type = FD_INODE;
80105629:	c7 07 02 00 00 00    	movl   $0x2,(%edi)
  f->ip = ip;
  f->off = 0;
  f->readable = !(omode & O_WRONLY);
8010562f:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105632:	83 c4 10             	add    $0x10,%esp
  f->ip = ip;
80105635:	89 77 10             	mov    %esi,0x10(%edi)
  f->off = 0;
80105638:	c7 47 14 00 00 00 00 	movl   $0x0,0x14(%edi)
  f->readable = !(omode & O_WRONLY);
8010563f:	89 d0                	mov    %edx,%eax
80105641:	f7 d0                	not    %eax
80105643:	83 e0 01             	and    $0x1,%eax
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
80105646:	83 e2 03             	and    $0x3,%edx
  f->readable = !(omode & O_WRONLY);
80105649:	88 47 08             	mov    %al,0x8(%edi)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
8010564c:	0f 95 47 09          	setne  0x9(%edi)
  return fd;
}
80105650:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105653:	89 d8                	mov    %ebx,%eax
80105655:	5b                   	pop    %ebx
80105656:	5e                   	pop    %esi
80105657:	5f                   	pop    %edi
80105658:	5d                   	pop    %ebp
80105659:	c3                   	ret    
8010565a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    ip = create(path, T_FILE, 0, 0);
80105660:	83 ec 0c             	sub    $0xc,%esp
80105663:	8b 45 e0             	mov    -0x20(%ebp),%eax
80105666:	31 c9                	xor    %ecx,%ecx
80105668:	6a 00                	push   $0x0
8010566a:	ba 02 00 00 00       	mov    $0x2,%edx
8010566f:	e8 dc f7 ff ff       	call   80104e50 <create>
    if(ip == 0){
80105674:	83 c4 10             	add    $0x10,%esp
80105677:	85 c0                	test   %eax,%eax
    ip = create(path, T_FILE, 0, 0);
80105679:	89 c6                	mov    %eax,%esi
    if(ip == 0){
8010567b:	0f 85 65 ff ff ff    	jne    801055e6 <sys_open+0x76>
      end_op();
80105681:	e8 aa d5 ff ff       	call   80102c30 <end_op>
      return -1;
80105686:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
8010568b:	eb c3                	jmp    80105650 <sys_open+0xe0>
8010568d:	8d 76 00             	lea    0x0(%esi),%esi
    if(ip->type == T_DIR && omode != O_RDONLY){
80105690:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80105693:	85 c9                	test   %ecx,%ecx
80105695:	0f 84 4b ff ff ff    	je     801055e6 <sys_open+0x76>
    iunlockput(ip);
8010569b:	83 ec 0c             	sub    $0xc,%esp
8010569e:	56                   	push   %esi
8010569f:	e8 7c c2 ff ff       	call   80101920 <iunlockput>
    end_op();
801056a4:	e8 87 d5 ff ff       	call   80102c30 <end_op>
    return -1;
801056a9:	83 c4 10             	add    $0x10,%esp
801056ac:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
801056b1:	eb 9d                	jmp    80105650 <sys_open+0xe0>
801056b3:	90                   	nop
801056b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      fileclose(f);
801056b8:	83 ec 0c             	sub    $0xc,%esp
801056bb:	57                   	push   %edi
801056bc:	e8 7f b7 ff ff       	call   80100e40 <fileclose>
801056c1:	83 c4 10             	add    $0x10,%esp
801056c4:	eb d5                	jmp    8010569b <sys_open+0x12b>
801056c6:	8d 76 00             	lea    0x0(%esi),%esi
801056c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801056d0 <sys_mkdir>:

int
sys_mkdir(void)
{
801056d0:	55                   	push   %ebp
801056d1:	89 e5                	mov    %esp,%ebp
801056d3:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
801056d6:	e8 e5 d4 ff ff       	call   80102bc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
801056db:	8d 45 f4             	lea    -0xc(%ebp),%eax
801056de:	83 ec 08             	sub    $0x8,%esp
801056e1:	50                   	push   %eax
801056e2:	6a 00                	push   $0x0
801056e4:	e8 b7 f6 ff ff       	call   80104da0 <argstr>
801056e9:	83 c4 10             	add    $0x10,%esp
801056ec:	85 c0                	test   %eax,%eax
801056ee:	78 30                	js     80105720 <sys_mkdir+0x50>
801056f0:	83 ec 0c             	sub    $0xc,%esp
801056f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056f6:	31 c9                	xor    %ecx,%ecx
801056f8:	6a 00                	push   $0x0
801056fa:	ba 01 00 00 00       	mov    $0x1,%edx
801056ff:	e8 4c f7 ff ff       	call   80104e50 <create>
80105704:	83 c4 10             	add    $0x10,%esp
80105707:	85 c0                	test   %eax,%eax
80105709:	74 15                	je     80105720 <sys_mkdir+0x50>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010570b:	83 ec 0c             	sub    $0xc,%esp
8010570e:	50                   	push   %eax
8010570f:	e8 0c c2 ff ff       	call   80101920 <iunlockput>
  end_op();
80105714:	e8 17 d5 ff ff       	call   80102c30 <end_op>
  return 0;
80105719:	83 c4 10             	add    $0x10,%esp
8010571c:	31 c0                	xor    %eax,%eax
}
8010571e:	c9                   	leave  
8010571f:	c3                   	ret    
    end_op();
80105720:	e8 0b d5 ff ff       	call   80102c30 <end_op>
    return -1;
80105725:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010572a:	c9                   	leave  
8010572b:	c3                   	ret    
8010572c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105730 <sys_mknod>:

int
sys_mknod(void)
{
80105730:	55                   	push   %ebp
80105731:	89 e5                	mov    %esp,%ebp
80105733:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80105736:	e8 85 d4 ff ff       	call   80102bc0 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010573b:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010573e:	83 ec 08             	sub    $0x8,%esp
80105741:	50                   	push   %eax
80105742:	6a 00                	push   $0x0
80105744:	e8 57 f6 ff ff       	call   80104da0 <argstr>
80105749:	83 c4 10             	add    $0x10,%esp
8010574c:	85 c0                	test   %eax,%eax
8010574e:	78 60                	js     801057b0 <sys_mknod+0x80>
     argint(1, &major) < 0 ||
80105750:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105753:	83 ec 08             	sub    $0x8,%esp
80105756:	50                   	push   %eax
80105757:	6a 01                	push   $0x1
80105759:	e8 92 f5 ff ff       	call   80104cf0 <argint>
  if((argstr(0, &path)) < 0 ||
8010575e:	83 c4 10             	add    $0x10,%esp
80105761:	85 c0                	test   %eax,%eax
80105763:	78 4b                	js     801057b0 <sys_mknod+0x80>
     argint(2, &minor) < 0 ||
80105765:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105768:	83 ec 08             	sub    $0x8,%esp
8010576b:	50                   	push   %eax
8010576c:	6a 02                	push   $0x2
8010576e:	e8 7d f5 ff ff       	call   80104cf0 <argint>
     argint(1, &major) < 0 ||
80105773:	83 c4 10             	add    $0x10,%esp
80105776:	85 c0                	test   %eax,%eax
80105778:	78 36                	js     801057b0 <sys_mknod+0x80>
     (ip = create(path, T_DEV, major, minor)) == 0){
8010577a:	0f bf 45 f4          	movswl -0xc(%ebp),%eax
     argint(2, &minor) < 0 ||
8010577e:	83 ec 0c             	sub    $0xc,%esp
     (ip = create(path, T_DEV, major, minor)) == 0){
80105781:	0f bf 4d f0          	movswl -0x10(%ebp),%ecx
     argint(2, &minor) < 0 ||
80105785:	ba 03 00 00 00       	mov    $0x3,%edx
8010578a:	50                   	push   %eax
8010578b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010578e:	e8 bd f6 ff ff       	call   80104e50 <create>
80105793:	83 c4 10             	add    $0x10,%esp
80105796:	85 c0                	test   %eax,%eax
80105798:	74 16                	je     801057b0 <sys_mknod+0x80>
    end_op();
    return -1;
  }
  iunlockput(ip);
8010579a:	83 ec 0c             	sub    $0xc,%esp
8010579d:	50                   	push   %eax
8010579e:	e8 7d c1 ff ff       	call   80101920 <iunlockput>
  end_op();
801057a3:	e8 88 d4 ff ff       	call   80102c30 <end_op>
  return 0;
801057a8:	83 c4 10             	add    $0x10,%esp
801057ab:	31 c0                	xor    %eax,%eax
}
801057ad:	c9                   	leave  
801057ae:	c3                   	ret    
801057af:	90                   	nop
    end_op();
801057b0:	e8 7b d4 ff ff       	call   80102c30 <end_op>
    return -1;
801057b5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801057ba:	c9                   	leave  
801057bb:	c3                   	ret    
801057bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801057c0 <sys_chdir>:

int
sys_chdir(void)
{
801057c0:	55                   	push   %ebp
801057c1:	89 e5                	mov    %esp,%ebp
801057c3:	56                   	push   %esi
801057c4:	53                   	push   %ebx
801057c5:	83 ec 10             	sub    $0x10,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
801057c8:	e8 c3 e0 ff ff       	call   80103890 <myproc>
801057cd:	89 c6                	mov    %eax,%esi
  
  begin_op();
801057cf:	e8 ec d3 ff ff       	call   80102bc0 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
801057d4:	8d 45 f4             	lea    -0xc(%ebp),%eax
801057d7:	83 ec 08             	sub    $0x8,%esp
801057da:	50                   	push   %eax
801057db:	6a 00                	push   $0x0
801057dd:	e8 be f5 ff ff       	call   80104da0 <argstr>
801057e2:	83 c4 10             	add    $0x10,%esp
801057e5:	85 c0                	test   %eax,%eax
801057e7:	78 77                	js     80105860 <sys_chdir+0xa0>
801057e9:	83 ec 0c             	sub    $0xc,%esp
801057ec:	ff 75 f4             	pushl  -0xc(%ebp)
801057ef:	e8 0c c7 ff ff       	call   80101f00 <namei>
801057f4:	83 c4 10             	add    $0x10,%esp
801057f7:	85 c0                	test   %eax,%eax
801057f9:	89 c3                	mov    %eax,%ebx
801057fb:	74 63                	je     80105860 <sys_chdir+0xa0>
    end_op();
    return -1;
  }
  ilock(ip);
801057fd:	83 ec 0c             	sub    $0xc,%esp
80105800:	50                   	push   %eax
80105801:	e8 8a be ff ff       	call   80101690 <ilock>
  if(ip->type != T_DIR){
80105806:	83 c4 10             	add    $0x10,%esp
80105809:	66 83 7b 50 01       	cmpw   $0x1,0x50(%ebx)
8010580e:	75 30                	jne    80105840 <sys_chdir+0x80>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
80105810:	83 ec 0c             	sub    $0xc,%esp
80105813:	53                   	push   %ebx
80105814:	e8 57 bf ff ff       	call   80101770 <iunlock>
  iput(curproc->cwd);
80105819:	58                   	pop    %eax
8010581a:	ff b6 d8 04 00 00    	pushl  0x4d8(%esi)
80105820:	e8 9b bf ff ff       	call   801017c0 <iput>
  end_op();
80105825:	e8 06 d4 ff ff       	call   80102c30 <end_op>
  curproc->cwd = ip;
8010582a:	89 9e d8 04 00 00    	mov    %ebx,0x4d8(%esi)
  return 0;
80105830:	83 c4 10             	add    $0x10,%esp
80105833:	31 c0                	xor    %eax,%eax
}
80105835:	8d 65 f8             	lea    -0x8(%ebp),%esp
80105838:	5b                   	pop    %ebx
80105839:	5e                   	pop    %esi
8010583a:	5d                   	pop    %ebp
8010583b:	c3                   	ret    
8010583c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    iunlockput(ip);
80105840:	83 ec 0c             	sub    $0xc,%esp
80105843:	53                   	push   %ebx
80105844:	e8 d7 c0 ff ff       	call   80101920 <iunlockput>
    end_op();
80105849:	e8 e2 d3 ff ff       	call   80102c30 <end_op>
    return -1;
8010584e:	83 c4 10             	add    $0x10,%esp
80105851:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105856:	eb dd                	jmp    80105835 <sys_chdir+0x75>
80105858:	90                   	nop
80105859:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    end_op();
80105860:	e8 cb d3 ff ff       	call   80102c30 <end_op>
    return -1;
80105865:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010586a:	eb c9                	jmp    80105835 <sys_chdir+0x75>
8010586c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105870 <sys_exec>:

int
sys_exec(void)
{
80105870:	55                   	push   %ebp
80105871:	89 e5                	mov    %esp,%ebp
80105873:	57                   	push   %edi
80105874:	56                   	push   %esi
80105875:	53                   	push   %ebx
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105876:	8d 85 5c ff ff ff    	lea    -0xa4(%ebp),%eax
{
8010587c:	81 ec a4 00 00 00    	sub    $0xa4,%esp
  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
80105882:	50                   	push   %eax
80105883:	6a 00                	push   $0x0
80105885:	e8 16 f5 ff ff       	call   80104da0 <argstr>
8010588a:	83 c4 10             	add    $0x10,%esp
8010588d:	85 c0                	test   %eax,%eax
8010588f:	0f 88 87 00 00 00    	js     8010591c <sys_exec+0xac>
80105895:	8d 85 60 ff ff ff    	lea    -0xa0(%ebp),%eax
8010589b:	83 ec 08             	sub    $0x8,%esp
8010589e:	50                   	push   %eax
8010589f:	6a 01                	push   $0x1
801058a1:	e8 4a f4 ff ff       	call   80104cf0 <argint>
801058a6:	83 c4 10             	add    $0x10,%esp
801058a9:	85 c0                	test   %eax,%eax
801058ab:	78 6f                	js     8010591c <sys_exec+0xac>
    return -1;
  }
  memset(argv, 0, sizeof(argv));
801058ad:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801058b3:	83 ec 04             	sub    $0x4,%esp
  for(i=0;; i++){
801058b6:	31 db                	xor    %ebx,%ebx
  memset(argv, 0, sizeof(argv));
801058b8:	68 80 00 00 00       	push   $0x80
801058bd:	6a 00                	push   $0x0
801058bf:	8d bd 64 ff ff ff    	lea    -0x9c(%ebp),%edi
801058c5:	50                   	push   %eax
801058c6:	e8 25 f1 ff ff       	call   801049f0 <memset>
801058cb:	83 c4 10             	add    $0x10,%esp
801058ce:	eb 2c                	jmp    801058fc <sys_exec+0x8c>
    if(i >= NELEM(argv))
      return -1;
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
      return -1;
    if(uarg == 0){
801058d0:	8b 85 64 ff ff ff    	mov    -0x9c(%ebp),%eax
801058d6:	85 c0                	test   %eax,%eax
801058d8:	74 56                	je     80105930 <sys_exec+0xc0>
      argv[i] = 0;
      break;
    }
    if(fetchstr(uarg, &argv[i]) < 0)
801058da:	8d 8d 68 ff ff ff    	lea    -0x98(%ebp),%ecx
801058e0:	83 ec 08             	sub    $0x8,%esp
801058e3:	8d 14 31             	lea    (%ecx,%esi,1),%edx
801058e6:	52                   	push   %edx
801058e7:	50                   	push   %eax
801058e8:	e8 93 f3 ff ff       	call   80104c80 <fetchstr>
801058ed:	83 c4 10             	add    $0x10,%esp
801058f0:	85 c0                	test   %eax,%eax
801058f2:	78 28                	js     8010591c <sys_exec+0xac>
  for(i=0;; i++){
801058f4:	83 c3 01             	add    $0x1,%ebx
    if(i >= NELEM(argv))
801058f7:	83 fb 20             	cmp    $0x20,%ebx
801058fa:	74 20                	je     8010591c <sys_exec+0xac>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
801058fc:	8b 85 60 ff ff ff    	mov    -0xa0(%ebp),%eax
80105902:	8d 34 9d 00 00 00 00 	lea    0x0(,%ebx,4),%esi
80105909:	83 ec 08             	sub    $0x8,%esp
8010590c:	57                   	push   %edi
8010590d:	01 f0                	add    %esi,%eax
8010590f:	50                   	push   %eax
80105910:	e8 2b f3 ff ff       	call   80104c40 <fetchint>
80105915:	83 c4 10             	add    $0x10,%esp
80105918:	85 c0                	test   %eax,%eax
8010591a:	79 b4                	jns    801058d0 <sys_exec+0x60>
      return -1;
  }
  return exec(path, argv);
}
8010591c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return -1;
8010591f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105924:	5b                   	pop    %ebx
80105925:	5e                   	pop    %esi
80105926:	5f                   	pop    %edi
80105927:	5d                   	pop    %ebp
80105928:	c3                   	ret    
80105929:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  return exec(path, argv);
80105930:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80105936:	83 ec 08             	sub    $0x8,%esp
      argv[i] = 0;
80105939:	c7 84 9d 68 ff ff ff 	movl   $0x0,-0x98(%ebp,%ebx,4)
80105940:	00 00 00 00 
  return exec(path, argv);
80105944:	50                   	push   %eax
80105945:	ff b5 5c ff ff ff    	pushl  -0xa4(%ebp)
8010594b:	e8 c0 b0 ff ff       	call   80100a10 <exec>
80105950:	83 c4 10             	add    $0x10,%esp
}
80105953:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105956:	5b                   	pop    %ebx
80105957:	5e                   	pop    %esi
80105958:	5f                   	pop    %edi
80105959:	5d                   	pop    %ebp
8010595a:	c3                   	ret    
8010595b:	90                   	nop
8010595c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105960 <sys_pipe>:

int
sys_pipe(void)
{
80105960:	55                   	push   %ebp
80105961:	89 e5                	mov    %esp,%ebp
80105963:	57                   	push   %edi
80105964:	56                   	push   %esi
80105965:	53                   	push   %ebx
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0){
80105966:	8d 45 dc             	lea    -0x24(%ebp),%eax
{
80105969:	83 ec 20             	sub    $0x20,%esp
  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0){
8010596c:	6a 08                	push   $0x8
8010596e:	50                   	push   %eax
8010596f:	6a 00                	push   $0x0
80105971:	e8 ca f3 ff ff       	call   80104d40 <argptr>
80105976:	83 c4 10             	add    $0x10,%esp
80105979:	85 c0                	test   %eax,%eax
8010597b:	0f 88 e0 00 00 00    	js     80105a61 <sys_pipe+0x101>
    cprintf("inside pipe 1\n");
    return -1;
  }
  if(pipealloc(&rf, &wf) < 0){
80105981:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105984:	83 ec 08             	sub    $0x8,%esp
80105987:	50                   	push   %eax
80105988:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010598b:	50                   	push   %eax
8010598c:	e8 cf d8 ff ff       	call   80103260 <pipealloc>
80105991:	83 c4 10             	add    $0x10,%esp
80105994:	85 c0                	test   %eax,%eax
80105996:	0f 88 ae 00 00 00    	js     80105a4a <sys_pipe+0xea>
    cprintf("inside pipe 2\n");
    return -1;
  }
  fd0 = -1;
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
8010599c:	8b 7d e0             	mov    -0x20(%ebp),%edi
  for(fd = 0; fd < NOFILE; fd++){
8010599f:	31 db                	xor    %ebx,%ebx
  struct proc *curproc = myproc();
801059a1:	e8 ea de ff ff       	call   80103890 <myproc>
801059a6:	eb 13                	jmp    801059bb <sys_pipe+0x5b>
801059a8:	90                   	nop
801059a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(fd = 0; fd < NOFILE; fd++){
801059b0:	83 c3 01             	add    $0x1,%ebx
801059b3:	81 fb 2c 01 00 00    	cmp    $0x12c,%ebx
801059b9:	74 65                	je     80105a20 <sys_pipe+0xc0>
    if(curproc->ofile[fd] == 0){
801059bb:	8b 74 98 28          	mov    0x28(%eax,%ebx,4),%esi
801059bf:	85 f6                	test   %esi,%esi
801059c1:	75 ed                	jne    801059b0 <sys_pipe+0x50>
      curproc->ofile[fd] = f;
801059c3:	8d 73 08             	lea    0x8(%ebx),%esi
801059c6:	89 7c b0 08          	mov    %edi,0x8(%eax,%esi,4)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
801059ca:	8b 7d e4             	mov    -0x1c(%ebp),%edi
  struct proc *curproc = myproc();
801059cd:	e8 be de ff ff       	call   80103890 <myproc>
  for(fd = 0; fd < NOFILE; fd++){
801059d2:	31 d2                	xor    %edx,%edx
801059d4:	eb 15                	jmp    801059eb <sys_pipe+0x8b>
801059d6:	8d 76 00             	lea    0x0(%esi),%esi
801059d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
801059e0:	83 c2 01             	add    $0x1,%edx
801059e3:	81 fa 2c 01 00 00    	cmp    $0x12c,%edx
801059e9:	74 21                	je     80105a0c <sys_pipe+0xac>
    if(curproc->ofile[fd] == 0){
801059eb:	8b 4c 90 28          	mov    0x28(%eax,%edx,4),%ecx
801059ef:	85 c9                	test   %ecx,%ecx
801059f1:	75 ed                	jne    801059e0 <sys_pipe+0x80>
      curproc->ofile[fd] = f;
801059f3:	89 7c 90 28          	mov    %edi,0x28(%eax,%edx,4)
    fileclose(rf);
    fileclose(wf);
    cprintf("inside pipe 3\n");
    return -1;
  }
  fd[0] = fd0;
801059f7:	8b 45 dc             	mov    -0x24(%ebp),%eax
801059fa:	89 18                	mov    %ebx,(%eax)
  fd[1] = fd1;
801059fc:	8b 45 dc             	mov    -0x24(%ebp),%eax
801059ff:	89 50 04             	mov    %edx,0x4(%eax)
  return 0;
80105a02:	31 c0                	xor    %eax,%eax
}
80105a04:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105a07:	5b                   	pop    %ebx
80105a08:	5e                   	pop    %esi
80105a09:	5f                   	pop    %edi
80105a0a:	5d                   	pop    %ebp
80105a0b:	c3                   	ret    
      myproc()->ofile[fd0] = 0;
80105a0c:	e8 7f de ff ff       	call   80103890 <myproc>
80105a11:	c7 44 b0 08 00 00 00 	movl   $0x0,0x8(%eax,%esi,4)
80105a18:	00 
80105a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    fileclose(rf);
80105a20:	83 ec 0c             	sub    $0xc,%esp
80105a23:	ff 75 e0             	pushl  -0x20(%ebp)
80105a26:	e8 15 b4 ff ff       	call   80100e40 <fileclose>
    fileclose(wf);
80105a2b:	58                   	pop    %eax
80105a2c:	ff 75 e4             	pushl  -0x1c(%ebp)
80105a2f:	e8 0c b4 ff ff       	call   80100e40 <fileclose>
    cprintf("inside pipe 3\n");
80105a34:	c7 04 24 87 86 10 80 	movl   $0x80108687,(%esp)
80105a3b:	e8 20 ac ff ff       	call   80100660 <cprintf>
    return -1;
80105a40:	83 c4 10             	add    $0x10,%esp
80105a43:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a48:	eb ba                	jmp    80105a04 <sys_pipe+0xa4>
    cprintf("inside pipe 2\n");
80105a4a:	83 ec 0c             	sub    $0xc,%esp
80105a4d:	68 78 86 10 80       	push   $0x80108678
80105a52:	e8 09 ac ff ff       	call   80100660 <cprintf>
    return -1;
80105a57:	83 c4 10             	add    $0x10,%esp
80105a5a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a5f:	eb a3                	jmp    80105a04 <sys_pipe+0xa4>
    cprintf("inside pipe 1\n");
80105a61:	83 ec 0c             	sub    $0xc,%esp
80105a64:	68 69 86 10 80       	push   $0x80108669
80105a69:	e8 f2 ab ff ff       	call   80100660 <cprintf>
    return -1;
80105a6e:	83 c4 10             	add    $0x10,%esp
80105a71:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105a76:	eb 8c                	jmp    80105a04 <sys_pipe+0xa4>
80105a78:	66 90                	xchg   %ax,%ax
80105a7a:	66 90                	xchg   %ax,%ax
80105a7c:	66 90                	xchg   %ax,%ax
80105a7e:	66 90                	xchg   %ax,%ax

80105a80 <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
80105a80:	55                   	push   %ebp
80105a81:	89 e5                	mov    %esp,%ebp
  return fork();
}
80105a83:	5d                   	pop    %ebp
  return fork();
80105a84:	e9 87 e0 ff ff       	jmp    80103b10 <fork>
80105a89:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105a90 <sys_exit>:

int
sys_exit(void)
{
80105a90:	55                   	push   %ebp
80105a91:	89 e5                	mov    %esp,%ebp
80105a93:	83 ec 08             	sub    $0x8,%esp
  exit();
80105a96:	e8 c5 e3 ff ff       	call   80103e60 <exit>
  return 0;  // not reached
}
80105a9b:	31 c0                	xor    %eax,%eax
80105a9d:	c9                   	leave  
80105a9e:	c3                   	ret    
80105a9f:	90                   	nop

80105aa0 <sys_wait>:

int
sys_wait(void)
{
80105aa0:	55                   	push   %ebp
80105aa1:	89 e5                	mov    %esp,%ebp
  return wait();
}
80105aa3:	5d                   	pop    %ebp
  return wait();
80105aa4:	e9 07 e6 ff ff       	jmp    801040b0 <wait>
80105aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105ab0 <sys_kill>:

int
sys_kill(void)
{
80105ab0:	55                   	push   %ebp
80105ab1:	89 e5                	mov    %esp,%ebp
80105ab3:	83 ec 20             	sub    $0x20,%esp
  int pid;

  if(argint(0, &pid) < 0)
80105ab6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ab9:	50                   	push   %eax
80105aba:	6a 00                	push   $0x0
80105abc:	e8 2f f2 ff ff       	call   80104cf0 <argint>
80105ac1:	83 c4 10             	add    $0x10,%esp
80105ac4:	85 c0                	test   %eax,%eax
80105ac6:	78 18                	js     80105ae0 <sys_kill+0x30>
    return -1;
  return kill(pid);
80105ac8:	83 ec 0c             	sub    $0xc,%esp
80105acb:	ff 75 f4             	pushl  -0xc(%ebp)
80105ace:	e8 3d e7 ff ff       	call   80104210 <kill>
80105ad3:	83 c4 10             	add    $0x10,%esp
}
80105ad6:	c9                   	leave  
80105ad7:	c3                   	ret    
80105ad8:	90                   	nop
80105ad9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105ae0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105ae5:	c9                   	leave  
80105ae6:	c3                   	ret    
80105ae7:	89 f6                	mov    %esi,%esi
80105ae9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105af0 <sys_getpid>:

int
sys_getpid(void)
{
80105af0:	55                   	push   %ebp
80105af1:	89 e5                	mov    %esp,%ebp
80105af3:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80105af6:	e8 95 dd ff ff       	call   80103890 <myproc>
80105afb:	8b 40 10             	mov    0x10(%eax),%eax
}
80105afe:	c9                   	leave  
80105aff:	c3                   	ret    

80105b00 <sys_sbrk>:

int
sys_sbrk(void)
{
80105b00:	55                   	push   %ebp
80105b01:	89 e5                	mov    %esp,%ebp
80105b03:	53                   	push   %ebx
  int addr;
  int n;

  if(argint(0, &n) < 0)
80105b04:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105b07:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105b0a:	50                   	push   %eax
80105b0b:	6a 00                	push   $0x0
80105b0d:	e8 de f1 ff ff       	call   80104cf0 <argint>
80105b12:	83 c4 10             	add    $0x10,%esp
80105b15:	85 c0                	test   %eax,%eax
80105b17:	78 27                	js     80105b40 <sys_sbrk+0x40>
    return -1;
  addr = myproc()->sz;
80105b19:	e8 72 dd ff ff       	call   80103890 <myproc>
  if(growproc(n) < 0)
80105b1e:	83 ec 0c             	sub    $0xc,%esp
  addr = myproc()->sz;
80105b21:	8b 18                	mov    (%eax),%ebx
  if(growproc(n) < 0)
80105b23:	ff 75 f4             	pushl  -0xc(%ebp)
80105b26:	e8 65 df ff ff       	call   80103a90 <growproc>
80105b2b:	83 c4 10             	add    $0x10,%esp
80105b2e:	85 c0                	test   %eax,%eax
80105b30:	78 0e                	js     80105b40 <sys_sbrk+0x40>
    return -1;
  return addr;
}
80105b32:	89 d8                	mov    %ebx,%eax
80105b34:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105b37:	c9                   	leave  
80105b38:	c3                   	ret    
80105b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80105b40:	bb ff ff ff ff       	mov    $0xffffffff,%ebx
80105b45:	eb eb                	jmp    80105b32 <sys_sbrk+0x32>
80105b47:	89 f6                	mov    %esi,%esi
80105b49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105b50 <sys_sleep>:

int
sys_sleep(void)
{
80105b50:	55                   	push   %ebp
80105b51:	89 e5                	mov    %esp,%ebp
80105b53:	53                   	push   %ebx
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
80105b54:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105b57:	83 ec 1c             	sub    $0x1c,%esp
  if(argint(0, &n) < 0)
80105b5a:	50                   	push   %eax
80105b5b:	6a 00                	push   $0x0
80105b5d:	e8 8e f1 ff ff       	call   80104cf0 <argint>
80105b62:	83 c4 10             	add    $0x10,%esp
80105b65:	85 c0                	test   %eax,%eax
80105b67:	0f 88 8a 00 00 00    	js     80105bf7 <sys_sleep+0xa7>
    return -1;
  acquire(&tickslock);
80105b6d:	83 ec 0c             	sub    $0xc,%esp
80105b70:	68 20 f7 12 80       	push   $0x8012f720
80105b75:	e8 66 ed ff ff       	call   801048e0 <acquire>
  ticks0 = ticks;
  while(ticks - ticks0 < n){
80105b7a:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105b7d:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80105b80:	8b 1d 60 ff 12 80    	mov    0x8012ff60,%ebx
  while(ticks - ticks0 < n){
80105b86:	85 d2                	test   %edx,%edx
80105b88:	75 27                	jne    80105bb1 <sys_sleep+0x61>
80105b8a:	eb 54                	jmp    80105be0 <sys_sleep+0x90>
80105b8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
80105b90:	83 ec 08             	sub    $0x8,%esp
80105b93:	68 20 f7 12 80       	push   $0x8012f720
80105b98:	68 60 ff 12 80       	push   $0x8012ff60
80105b9d:	e8 4e e4 ff ff       	call   80103ff0 <sleep>
  while(ticks - ticks0 < n){
80105ba2:	a1 60 ff 12 80       	mov    0x8012ff60,%eax
80105ba7:	83 c4 10             	add    $0x10,%esp
80105baa:	29 d8                	sub    %ebx,%eax
80105bac:	3b 45 f4             	cmp    -0xc(%ebp),%eax
80105baf:	73 2f                	jae    80105be0 <sys_sleep+0x90>
    if(myproc()->killed){
80105bb1:	e8 da dc ff ff       	call   80103890 <myproc>
80105bb6:	8b 40 24             	mov    0x24(%eax),%eax
80105bb9:	85 c0                	test   %eax,%eax
80105bbb:	74 d3                	je     80105b90 <sys_sleep+0x40>
      release(&tickslock);
80105bbd:	83 ec 0c             	sub    $0xc,%esp
80105bc0:	68 20 f7 12 80       	push   $0x8012f720
80105bc5:	e8 d6 ed ff ff       	call   801049a0 <release>
      return -1;
80105bca:	83 c4 10             	add    $0x10,%esp
80105bcd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  }
  release(&tickslock);
  return 0;
}
80105bd2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105bd5:	c9                   	leave  
80105bd6:	c3                   	ret    
80105bd7:	89 f6                	mov    %esi,%esi
80105bd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  release(&tickslock);
80105be0:	83 ec 0c             	sub    $0xc,%esp
80105be3:	68 20 f7 12 80       	push   $0x8012f720
80105be8:	e8 b3 ed ff ff       	call   801049a0 <release>
  return 0;
80105bed:	83 c4 10             	add    $0x10,%esp
80105bf0:	31 c0                	xor    %eax,%eax
}
80105bf2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105bf5:	c9                   	leave  
80105bf6:	c3                   	ret    
    return -1;
80105bf7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105bfc:	eb f4                	jmp    80105bf2 <sys_sleep+0xa2>
80105bfe:	66 90                	xchg   %ax,%ax

80105c00 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
80105c00:	55                   	push   %ebp
80105c01:	89 e5                	mov    %esp,%ebp
80105c03:	53                   	push   %ebx
80105c04:	83 ec 10             	sub    $0x10,%esp
  uint xticks;

  acquire(&tickslock);
80105c07:	68 20 f7 12 80       	push   $0x8012f720
80105c0c:	e8 cf ec ff ff       	call   801048e0 <acquire>
  xticks = ticks;
80105c11:	8b 1d 60 ff 12 80    	mov    0x8012ff60,%ebx
  release(&tickslock);
80105c17:	c7 04 24 20 f7 12 80 	movl   $0x8012f720,(%esp)
80105c1e:	e8 7d ed ff ff       	call   801049a0 <release>
  return xticks;
}
80105c23:	89 d8                	mov    %ebx,%eax
80105c25:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105c28:	c9                   	leave  
80105c29:	c3                   	ret    
80105c2a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80105c30 <sys_toggle>:
//printing of sys_trace on sys_calls
//done on 11 February 2019
void 
sys_toggle(void)
{
  if(sys_trace==0){
80105c30:	a1 80 b8 10 80       	mov    0x8010b880,%eax
{
80105c35:	55                   	push   %ebp
80105c36:	89 e5                	mov    %esp,%ebp
  if(sys_trace==0){
80105c38:	85 c0                	test   %eax,%eax
80105c3a:	75 2c                	jne    80105c68 <sys_toggle+0x38>
80105c3c:	b8 a0 b8 10 80       	mov    $0x8010b8a0,%eax
80105c41:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    for(int i =0;i<34;i++){
      syscall_trace[i] = 0;
80105c48:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80105c4e:	83 c0 04             	add    $0x4,%eax
    for(int i =0;i<34;i++){
80105c51:	3d 28 b9 10 80       	cmp    $0x8010b928,%eax
80105c56:	75 f0                	jne    80105c48 <sys_toggle+0x18>
    }
    sys_trace = 1;
80105c58:	c7 05 80 b8 10 80 01 	movl   $0x1,0x8010b880
80105c5f:	00 00 00 
  }else{
    sys_trace = 0;
  }
}
80105c62:	5d                   	pop    %ebp
80105c63:	c3                   	ret    
80105c64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    sys_trace = 0;
80105c68:	c7 05 80 b8 10 80 00 	movl   $0x0,0x8010b880
80105c6f:	00 00 00 
}
80105c72:	5d                   	pop    %ebp
80105c73:	c3                   	ret    
80105c74:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80105c7a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80105c80 <sys_print_count>:

void
sys_print_count(void)
{
80105c80:	55                   	push   %ebp
80105c81:	89 e5                	mov    %esp,%ebp
80105c83:	53                   	push   %ebx
80105c84:	31 db                	xor    %ebx,%ebx
80105c86:	83 ec 04             	sub    $0x4,%esp
80105c89:	eb 10                	jmp    80105c9b <sys_print_count+0x1b>
80105c8b:	90                   	nop
80105c8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
80105c90:	83 c3 04             	add    $0x4,%ebx
    for(int i=1;i<34;i++){
80105c93:	81 fb 84 00 00 00    	cmp    $0x84,%ebx
80105c99:	74 2e                	je     80105cc9 <sys_print_count+0x49>
      if(syscall_trace[i]!=0){
80105c9b:	8b 83 a4 b8 10 80    	mov    -0x7fef475c(%ebx),%eax
80105ca1:	85 c0                	test   %eax,%eax
80105ca3:	74 eb                	je     80105c90 <sys_print_count+0x10>
        cprintf("%s %d\n",numToCall[i],syscall_trace[i]);
80105ca5:	83 ec 04             	sub    $0x4,%esp
80105ca8:	50                   	push   %eax
80105ca9:	8d 84 9b 34 b0 10 80 	lea    -0x7fef4fcc(%ebx,%ebx,4),%eax
80105cb0:	83 c3 04             	add    $0x4,%ebx
80105cb3:	50                   	push   %eax
80105cb4:	68 96 86 10 80       	push   $0x80108696
80105cb9:	e8 a2 a9 ff ff       	call   80100660 <cprintf>
80105cbe:	83 c4 10             	add    $0x10,%esp
    for(int i=1;i<34;i++){
80105cc1:	81 fb 84 00 00 00    	cmp    $0x84,%ebx
80105cc7:	75 d2                	jne    80105c9b <sys_print_count+0x1b>
      }
    }
}
80105cc9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105ccc:	c9                   	leave  
80105ccd:	c3                   	ret    
80105cce:	66 90                	xchg   %ax,%ax

80105cd0 <sys_add>:

int
sys_add(void)
{
80105cd0:	55                   	push   %ebp
80105cd1:	89 e5                	mov    %esp,%ebp
80105cd3:	83 ec 20             	sub    $0x20,%esp
  int a,b;
  argint(0, &a);
80105cd6:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105cd9:	50                   	push   %eax
80105cda:	6a 00                	push   $0x0
80105cdc:	e8 0f f0 ff ff       	call   80104cf0 <argint>
  argint(1,&b);
80105ce1:	58                   	pop    %eax
80105ce2:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105ce5:	5a                   	pop    %edx
80105ce6:	50                   	push   %eax
80105ce7:	6a 01                	push   $0x1
80105ce9:	e8 02 f0 ff ff       	call   80104cf0 <argint>
  int t;
  t = a+b;
80105cee:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cf1:	03 45 f0             	add    -0x10(%ebp),%eax
  return t;
}
80105cf4:	c9                   	leave  
80105cf5:	c3                   	ret    
80105cf6:	8d 76 00             	lea    0x0(%esi),%esi
80105cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d00 <sys_ps>:

int 
sys_ps(void)
{
80105d00:	55                   	push   %ebp
80105d01:	89 e5                	mov    %esp,%ebp
80105d03:	83 ec 08             	sub    $0x8,%esp
  print_ps();
80105d06:	e8 b5 e6 ff ff       	call   801043c0 <print_ps>
  return 0;
}
80105d0b:	31 c0                	xor    %eax,%eax
80105d0d:	c9                   	leave  
80105d0e:	c3                   	ret    
80105d0f:	90                   	nop

80105d10 <sys_halt>:

int 
sys_halt(void)
{
80105d10:	55                   	push   %ebp
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80105d11:	31 c0                	xor    %eax,%eax
80105d13:	ba f4 00 00 00       	mov    $0xf4,%edx
80105d18:	89 e5                	mov    %esp,%ebp
80105d1a:	ee                   	out    %al,(%dx)
  outb(0xf4, 0x00);
  return 0;
}
80105d1b:	31 c0                	xor    %eax,%eax
80105d1d:	5d                   	pop    %ebp
80105d1e:	c3                   	ret    
80105d1f:	90                   	nop

80105d20 <sys_send>:

int
sys_send(void)
{
80105d20:	55                   	push   %ebp
80105d21:	89 e5                	mov    %esp,%ebp
80105d23:	53                   	push   %ebx
  int sender_pid,rec_pid;
  char* p;
  argint(0,&sender_pid);
80105d24:	8d 45 ec             	lea    -0x14(%ebp),%eax
{
80105d27:	83 ec 1c             	sub    $0x1c,%esp
  argint(0,&sender_pid);
80105d2a:	50                   	push   %eax
80105d2b:	6a 00                	push   $0x0
80105d2d:	e8 be ef ff ff       	call   80104cf0 <argint>
  argint(1,&rec_pid);
80105d32:	58                   	pop    %eax
80105d33:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105d36:	5a                   	pop    %edx
80105d37:	50                   	push   %eax
80105d38:	6a 01                	push   $0x1
80105d3a:	e8 b1 ef ff ff       	call   80104cf0 <argint>
  argptr(2,&p,8);
80105d3f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105d42:	83 c4 0c             	add    $0xc,%esp
80105d45:	6a 08                	push   $0x8
80105d47:	50                   	push   %eax
80105d48:	6a 02                	push   $0x2
80105d4a:	e8 f1 ef ff ff       	call   80104d40 <argptr>
  int sendCode = send_message(sender_pid,rec_pid,(void *)p);
80105d4f:	83 c4 0c             	add    $0xc,%esp
80105d52:	ff 75 f4             	pushl  -0xc(%ebp)
80105d55:	ff 75 f0             	pushl  -0x10(%ebp)
80105d58:	ff 75 ec             	pushl  -0x14(%ebp)
80105d5b:	e8 50 1c 00 00       	call   801079b0 <send_message>
  // cprintf("Waking up %d \n",rec_pid);
  wakeup((void *)rec_pid);//waking up the receiver
80105d60:	59                   	pop    %ecx
80105d61:	ff 75 f0             	pushl  -0x10(%ebp)
  int sendCode = send_message(sender_pid,rec_pid,(void *)p);
80105d64:	89 c3                	mov    %eax,%ebx
  wakeup((void *)rec_pid);//waking up the receiver
80105d66:	e8 45 e4 ff ff       	call   801041b0 <wakeup>
  return sendCode;
}
80105d6b:	89 d8                	mov    %ebx,%eax
80105d6d:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105d70:	c9                   	leave  
80105d71:	c3                   	ret    
80105d72:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80105d79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105d80 <sys_recv>:

int sys_recv(void)
{
80105d80:	55                   	push   %ebp
80105d81:	89 e5                	mov    %esp,%ebp
80105d83:	53                   	push   %ebx
  char* p;
  argptr(0,&p,8);
80105d84:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105d87:	83 ec 18             	sub    $0x18,%esp
  argptr(0,&p,8);
80105d8a:	6a 08                	push   $0x8
80105d8c:	50                   	push   %eax
80105d8d:	6a 00                	push   $0x0
80105d8f:	e8 ac ef ff ff       	call   80104d40 <argptr>
  int recvCode = -1;
  if(isReceiverQueueEmpty(myproc()->pid)==1){
80105d94:	e8 f7 da ff ff       	call   80103890 <myproc>
80105d99:	5a                   	pop    %edx
80105d9a:	ff 70 10             	pushl  0x10(%eax)
80105d9d:	e8 8e 1e 00 00       	call   80107c30 <isReceiverQueueEmpty>
80105da2:	83 c4 10             	add    $0x10,%esp
80105da5:	83 f8 01             	cmp    $0x1,%eax
80105da8:	74 26                	je     80105dd0 <sys_recv+0x50>
    // cprintf("Sleeping %d\n",myproc()->pid);
    sleep_receiver();//put reciever in sleeping position
    recvCode = receive_msg(myproc()->pid,(void *)p);
    // cprintf("receiving code is %d for pid %d\n ",recvCode,myproc()->pid);
  }else{
    recvCode = receive_msg(myproc()->pid,(void *)p);
80105daa:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105dad:	e8 de da ff ff       	call   80103890 <myproc>
80105db2:	83 ec 08             	sub    $0x8,%esp
80105db5:	53                   	push   %ebx
80105db6:	ff 70 10             	pushl  0x10(%eax)
80105db9:	e8 a2 1d 00 00       	call   80107b60 <receive_msg>
80105dbe:	83 c4 10             	add    $0x10,%esp
  }
  return recvCode;
}
80105dc1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105dc4:	c9                   	leave  
80105dc5:	c3                   	ret    
80105dc6:	8d 76 00             	lea    0x0(%esi),%esi
80105dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    sleep_receiver();//put reciever in sleeping position
80105dd0:	e8 6b e6 ff ff       	call   80104440 <sleep_receiver>
80105dd5:	eb d3                	jmp    80105daa <sys_recv+0x2a>
80105dd7:	89 f6                	mov    %esi,%esi
80105dd9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105de0 <sys_change_state>:

int
sys_change_state(void)
{
80105de0:	55                   	push   %ebp
80105de1:	89 e5                	mov    %esp,%ebp
80105de3:	83 ec 20             	sub    $0x20,%esp
  int a;
  argint(0,&a);
80105de6:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105de9:	50                   	push   %eax
80105dea:	6a 00                	push   $0x0
80105dec:	e8 ff ee ff ff       	call   80104cf0 <argint>
  if(a==0){
80105df1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105df4:	83 c4 10             	add    $0x10,%esp
80105df7:	85 c0                	test   %eax,%eax
80105df9:	74 1d                	je     80105e18 <sys_change_state+0x38>
    //block
    sleep_receiver();
  }else{
    //unblock
    wakeup((void *)myproc()->pid);
80105dfb:	e8 90 da ff ff       	call   80103890 <myproc>
80105e00:	83 ec 0c             	sub    $0xc,%esp
80105e03:	ff 70 10             	pushl  0x10(%eax)
80105e06:	e8 a5 e3 ff ff       	call   801041b0 <wakeup>
80105e0b:	83 c4 10             	add    $0x10,%esp
  }
  return 0;
}
80105e0e:	31 c0                	xor    %eax,%eax
80105e10:	c9                   	leave  
80105e11:	c3                   	ret    
80105e12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    sleep_receiver();
80105e18:	e8 23 e6 ff ff       	call   80104440 <sleep_receiver>
}
80105e1d:	31 c0                	xor    %eax,%eax
80105e1f:	c9                   	leave  
80105e20:	c3                   	ret    
80105e21:	eb 0d                	jmp    80105e30 <sys_send_multi>
80105e23:	90                   	nop
80105e24:	90                   	nop
80105e25:	90                   	nop
80105e26:	90                   	nop
80105e27:	90                   	nop
80105e28:	90                   	nop
80105e29:	90                   	nop
80105e2a:	90                   	nop
80105e2b:	90                   	nop
80105e2c:	90                   	nop
80105e2d:	90                   	nop
80105e2e:	90                   	nop
80105e2f:	90                   	nop

80105e30 <sys_send_multi>:

int
sys_send_multi(void)
{
80105e30:	55                   	push   %ebp
80105e31:	89 e5                	mov    %esp,%ebp
80105e33:	57                   	push   %edi
80105e34:	56                   	push   %esi
80105e35:	53                   	push   %ebx
  int sender_pid;
  int *rec_pid;
  char *msg_temp,*rec_temp;
  int len;
  argint(0,&sender_pid);
80105e36:	8d 45 d8             	lea    -0x28(%ebp),%eax
{
80105e39:	83 ec 34             	sub    $0x34,%esp
  argint(0,&sender_pid);
80105e3c:	50                   	push   %eax
80105e3d:	6a 00                	push   $0x0
80105e3f:	e8 ac ee ff ff       	call   80104cf0 <argint>
  argint(3,&len);
80105e44:	59                   	pop    %ecx
80105e45:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80105e48:	5b                   	pop    %ebx
80105e49:	50                   	push   %eax
80105e4a:	6a 03                	push   $0x3
80105e4c:	e8 9f ee ff ff       	call   80104cf0 <argint>
  argptr(1,&rec_temp,len);
80105e51:	8d 45 e0             	lea    -0x20(%ebp),%eax
80105e54:	83 c4 0c             	add    $0xc,%esp
80105e57:	ff 75 e4             	pushl  -0x1c(%ebp)
80105e5a:	50                   	push   %eax
80105e5b:	6a 01                	push   $0x1
80105e5d:	e8 de ee ff ff       	call   80104d40 <argptr>
  argptr(2,&msg_temp,MessageSize);
80105e62:	8d 45 dc             	lea    -0x24(%ebp),%eax
80105e65:	83 c4 0c             	add    $0xc,%esp
80105e68:	6a 10                	push   $0x10
80105e6a:	50                   	push   %eax
80105e6b:	6a 02                	push   $0x2
80105e6d:	e8 ce ee ff ff       	call   80104d40 <argptr>
  rec_pid = (int *)rec_temp;
  int sendCode[len];
80105e72:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80105e75:	83 c4 10             	add    $0x10,%esp
  rec_pid = (int *)rec_temp;
80105e78:	8b 5d e0             	mov    -0x20(%ebp),%ebx
  int interruptCode[len];
  int flag = 0;
80105e7b:	c7 45 cc 00 00 00 00 	movl   $0x0,-0x34(%ebp)
  int sendCode[len];
80105e82:	8d 04 95 12 00 00 00 	lea    0x12(,%edx,4),%eax
80105e89:	83 e0 f0             	and    $0xfffffff0,%eax
80105e8c:	29 c4                	sub    %eax,%esp
80105e8e:	89 65 d4             	mov    %esp,-0x2c(%ebp)
  int interruptCode[len];
80105e91:	29 c4                	sub    %eax,%esp
  // cprintf("Inside multi len : %d \n",len);
  for(int i=0;i<len;i++){
80105e93:	85 d2                	test   %edx,%edx
  int interruptCode[len];
80105e95:	89 65 d0             	mov    %esp,-0x30(%ebp)
  for(int i=0;i<len;i++){
80105e98:	7e 53                	jle    80105eed <sys_send_multi+0xbd>
80105e9a:	31 f6                	xor    %esi,%esi
80105e9c:	eb 0e                	jmp    80105eac <sys_send_multi+0x7c>
80105e9e:	66 90                	xchg   %ax,%ax
    // cprintf("rec[%d] : %d",i,rec_pid[i]);
    sendCode[i] = sent_to_proc_buffer(sender_pid,rec_pid[i],(void *)msg_temp);
    // sendCode[i] = send_message(sender_pid,rec_pid[i],(void *)msg_temp);
    interruptCode[i] = sigraise(rec_pid[i],SIGMSGSENT);
    if( sendCode[i]<0 || interruptCode[i]<0 ){
80105ea0:	85 ff                	test   %edi,%edi
80105ea2:	78 3a                	js     80105ede <sys_send_multi+0xae>
  for(int i=0;i<len;i++){
80105ea4:	83 c6 01             	add    $0x1,%esi
80105ea7:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
80105eaa:	7e 41                	jle    80105eed <sys_send_multi+0xbd>
    sendCode[i] = sent_to_proc_buffer(sender_pid,rec_pid[i],(void *)msg_temp);
80105eac:	83 ec 04             	sub    $0x4,%esp
80105eaf:	ff 75 dc             	pushl  -0x24(%ebp)
80105eb2:	ff 34 b3             	pushl  (%ebx,%esi,4)
80105eb5:	ff 75 d8             	pushl  -0x28(%ebp)
80105eb8:	e8 93 e6 ff ff       	call   80104550 <sent_to_proc_buffer>
80105ebd:	89 c7                	mov    %eax,%edi
80105ebf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
80105ec2:	89 3c b0             	mov    %edi,(%eax,%esi,4)
    interruptCode[i] = sigraise(rec_pid[i],SIGMSGSENT);
80105ec5:	58                   	pop    %eax
80105ec6:	5a                   	pop    %edx
80105ec7:	6a 04                	push   $0x4
80105ec9:	ff 34 b3             	pushl  (%ebx,%esi,4)
80105ecc:	e8 ff e5 ff ff       	call   801044d0 <sigraise>
80105ed1:	8b 4d d0             	mov    -0x30(%ebp),%ecx
    if( sendCode[i]<0 || interruptCode[i]<0 ){
80105ed4:	83 c4 10             	add    $0x10,%esp
80105ed7:	85 c0                	test   %eax,%eax
    interruptCode[i] = sigraise(rec_pid[i],SIGMSGSENT);
80105ed9:	89 04 b1             	mov    %eax,(%ecx,%esi,4)
    if( sendCode[i]<0 || interruptCode[i]<0 ){
80105edc:	79 c2                	jns    80105ea0 <sys_send_multi+0x70>
  for(int i=0;i<len;i++){
80105ede:	83 c6 01             	add    $0x1,%esi
80105ee1:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
      flag = -1;
80105ee4:	c7 45 cc ff ff ff ff 	movl   $0xffffffff,-0x34(%ebp)
  for(int i=0;i<len;i++){
80105eeb:	7f bf                	jg     80105eac <sys_send_multi+0x7c>
    }
  }
  return flag;
}
80105eed:	8b 45 cc             	mov    -0x34(%ebp),%eax
80105ef0:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ef3:	5b                   	pop    %ebx
80105ef4:	5e                   	pop    %esi
80105ef5:	5f                   	pop    %edi
80105ef6:	5d                   	pop    %ebp
80105ef7:	c3                   	ret    
80105ef8:	90                   	nop
80105ef9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80105f00 <sys_recv_multi>:

int sys_recv_multi(void)
{
80105f00:	55                   	push   %ebp
80105f01:	89 e5                	mov    %esp,%ebp
80105f03:	53                   	push   %ebx
  char* p;
  argptr(0,&p,8);
80105f04:	8d 45 f4             	lea    -0xc(%ebp),%eax
{
80105f07:	83 ec 18             	sub    $0x18,%esp
  argptr(0,&p,8);
80105f0a:	6a 08                	push   $0x8
80105f0c:	50                   	push   %eax
80105f0d:	6a 00                	push   $0x0
80105f0f:	e8 2c ee ff ff       	call   80104d40 <argptr>
  //   recvCode = receive_msg(myproc()->pid,(void *)p);
  //   // cprintf("receiving code is %d for pid %d\n ",recvCode,myproc()->pid);
  // }else{
  //   recvCode = receive_msg(myproc()->pid,(void *)p);
  // }
  recvCode = receive_from_procbuffer(myproc()->pid,(void *)p);
80105f14:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80105f17:	e8 74 d9 ff ff       	call   80103890 <myproc>
80105f1c:	5a                   	pop    %edx
80105f1d:	59                   	pop    %ecx
80105f1e:	53                   	push   %ebx
80105f1f:	ff 70 10             	pushl  0x10(%eax)
80105f22:	e8 b9 e6 ff ff       	call   801045e0 <receive_from_procbuffer>
  return recvCode;
}
80105f27:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f2a:	c9                   	leave  
80105f2b:	c3                   	ret    
80105f2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80105f30 <sys_signal>:


//assigning handler to process  with pid
int
sys_signal(void)
{
80105f30:	55                   	push   %ebp
80105f31:	89 e5                	mov    %esp,%ebp
80105f33:	83 ec 20             	sub    $0x20,%esp
  int signummer;
	int handler;
	if (argint(0, &signummer) < 0)
80105f36:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f39:	50                   	push   %eax
80105f3a:	6a 00                	push   $0x0
80105f3c:	e8 af ed ff ff       	call   80104cf0 <argint>
80105f41:	83 c4 10             	add    $0x10,%esp
80105f44:	85 c0                	test   %eax,%eax
80105f46:	78 28                	js     80105f70 <sys_signal+0x40>
		return -1;
	if (argint(1, &handler) <0)
80105f48:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f4b:	83 ec 08             	sub    $0x8,%esp
80105f4e:	50                   	push   %eax
80105f4f:	6a 01                	push   $0x1
80105f51:	e8 9a ed ff ff       	call   80104cf0 <argint>
80105f56:	83 c4 10             	add    $0x10,%esp
80105f59:	85 c0                	test   %eax,%eax
80105f5b:	78 13                	js     80105f70 <sys_signal+0x40>
		return -1;
	// cprintf("sign is : %d and handler is : %d \n",signummer , handler);
	int ans = signal(signummer, (sighandler_t) handler);
80105f5d:	83 ec 08             	sub    $0x8,%esp
80105f60:	ff 75 f4             	pushl  -0xc(%ebp)
80105f63:	ff 75 f0             	pushl  -0x10(%ebp)
80105f66:	e8 25 e5 ff ff       	call   80104490 <signal>
  return ans;
80105f6b:	83 c4 10             	add    $0x10,%esp
}
80105f6e:	c9                   	leave  
80105f6f:	c3                   	ret    
		return -1;
80105f70:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80105f75:	c9                   	leave  
80105f76:	c3                   	ret    
80105f77:	89 f6                	mov    %esi,%esi
80105f79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80105f80 <sys_sigraise>:

int sys_sigraise(void)
{
80105f80:	55                   	push   %ebp
80105f81:	89 e5                	mov    %esp,%ebp
80105f83:	83 ec 20             	sub    $0x20,%esp
  int to,signummer;
  argint(0,&to);
80105f86:	8d 45 f0             	lea    -0x10(%ebp),%eax
80105f89:	50                   	push   %eax
80105f8a:	6a 00                	push   $0x0
80105f8c:	e8 5f ed ff ff       	call   80104cf0 <argint>
  argint(1,&signummer);
80105f91:	58                   	pop    %eax
80105f92:	8d 45 f4             	lea    -0xc(%ebp),%eax
80105f95:	5a                   	pop    %edx
80105f96:	50                   	push   %eax
80105f97:	6a 01                	push   $0x1
80105f99:	e8 52 ed ff ff       	call   80104cf0 <argint>
  int ans = sigraise(to,signummer);
80105f9e:	59                   	pop    %ecx
80105f9f:	58                   	pop    %eax
80105fa0:	ff 75 f4             	pushl  -0xc(%ebp)
80105fa3:	ff 75 f0             	pushl  -0x10(%ebp)
80105fa6:	e8 25 e5 ff ff       	call   801044d0 <sigraise>
  return ans;
}
80105fab:	c9                   	leave  
80105fac:	c3                   	ret    

80105fad <alltraps>:

  # vectors.S sends all traps here.
.globl alltraps
alltraps:
  # Build trap frame.
  pushl %ds
80105fad:	1e                   	push   %ds
  pushl %es
80105fae:	06                   	push   %es
  pushl %fs
80105faf:	0f a0                	push   %fs
  pushl %gs
80105fb1:	0f a8                	push   %gs
  pushal
80105fb3:	60                   	pusha  
  
  # Set up data segments.
  movw $(SEG_KDATA<<3), %ax
80105fb4:	66 b8 10 00          	mov    $0x10,%ax
  movw %ax, %ds
80105fb8:	8e d8                	mov    %eax,%ds
  movw %ax, %es
80105fba:	8e c0                	mov    %eax,%es

  # Call trap(tf), where tf=%esp
  pushl %esp
80105fbc:	54                   	push   %esp
  call trap
80105fbd:	e8 be 00 00 00       	call   80106080 <trap>
  addl $4, %esp
80105fc2:	83 c4 04             	add    $0x4,%esp

80105fc5 <trapret>:

  # Return falls through to trapret...
.globl trapret
trapret:
  popal
80105fc5:	61                   	popa   
  popl %gs
80105fc6:	0f a9                	pop    %gs
  popl %fs
80105fc8:	0f a1                	pop    %fs
  popl %es
80105fca:	07                   	pop    %es
  popl %ds
80105fcb:	1f                   	pop    %ds
  addl $0x8, %esp  # trapno and errcode
80105fcc:	83 c4 08             	add    $0x8,%esp
  iret
80105fcf:	cf                   	iret   

80105fd0 <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
80105fd0:	55                   	push   %ebp
  int i;

  for(i = 0; i < 256; i++)
80105fd1:	31 c0                	xor    %eax,%eax
{
80105fd3:	89 e5                	mov    %esp,%ebp
80105fd5:	83 ec 08             	sub    $0x8,%esp
80105fd8:	90                   	nop
80105fd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
80105fe0:	8b 14 85 c8 b2 10 80 	mov    -0x7fef4d38(,%eax,4),%edx
80105fe7:	c7 04 c5 62 f7 12 80 	movl   $0x8e000008,-0x7fed089e(,%eax,8)
80105fee:	08 00 00 8e 
80105ff2:	66 89 14 c5 60 f7 12 	mov    %dx,-0x7fed08a0(,%eax,8)
80105ff9:	80 
80105ffa:	c1 ea 10             	shr    $0x10,%edx
80105ffd:	66 89 14 c5 66 f7 12 	mov    %dx,-0x7fed089a(,%eax,8)
80106004:	80 
  for(i = 0; i < 256; i++)
80106005:	83 c0 01             	add    $0x1,%eax
80106008:	3d 00 01 00 00       	cmp    $0x100,%eax
8010600d:	75 d1                	jne    80105fe0 <tvinit+0x10>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010600f:	a1 c8 b3 10 80       	mov    0x8010b3c8,%eax

  initlock(&tickslock, "time");
80106014:	83 ec 08             	sub    $0x8,%esp
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
80106017:	c7 05 62 f9 12 80 08 	movl   $0xef000008,0x8012f962
8010601e:	00 00 ef 
  initlock(&tickslock, "time");
80106021:	68 9d 86 10 80       	push   $0x8010869d
80106026:	68 20 f7 12 80       	push   $0x8012f720
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
8010602b:	66 a3 60 f9 12 80    	mov    %ax,0x8012f960
80106031:	c1 e8 10             	shr    $0x10,%eax
80106034:	66 a3 66 f9 12 80    	mov    %ax,0x8012f966
  initlock(&tickslock, "time");
8010603a:	e8 61 e7 ff ff       	call   801047a0 <initlock>
}
8010603f:	83 c4 10             	add    $0x10,%esp
80106042:	c9                   	leave  
80106043:	c3                   	ret    
80106044:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010604a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80106050 <idtinit>:

void
idtinit(void)
{
80106050:	55                   	push   %ebp
  pd[0] = size-1;
80106051:	b8 ff 07 00 00       	mov    $0x7ff,%eax
80106056:	89 e5                	mov    %esp,%ebp
80106058:	83 ec 10             	sub    $0x10,%esp
8010605b:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
8010605f:	b8 60 f7 12 80       	mov    $0x8012f760,%eax
80106064:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
80106068:	c1 e8 10             	shr    $0x10,%eax
8010606b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
8010606f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80106072:	0f 01 18             	lidtl  (%eax)
  lidt(idt, sizeof(idt));
}
80106075:	c9                   	leave  
80106076:	c3                   	ret    
80106077:	89 f6                	mov    %esi,%esi
80106079:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106080 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
80106080:	55                   	push   %ebp
80106081:	89 e5                	mov    %esp,%ebp
80106083:	57                   	push   %edi
80106084:	56                   	push   %esi
80106085:	53                   	push   %ebx
80106086:	83 ec 1c             	sub    $0x1c,%esp
80106089:	8b 7d 08             	mov    0x8(%ebp),%edi
  if(tf->trapno == T_SYSCALL){
8010608c:	8b 47 30             	mov    0x30(%edi),%eax
8010608f:	83 f8 40             	cmp    $0x40,%eax
80106092:	0f 84 f0 00 00 00    	je     80106188 <trap+0x108>
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
80106098:	83 e8 20             	sub    $0x20,%eax
8010609b:	83 f8 1f             	cmp    $0x1f,%eax
8010609e:	77 10                	ja     801060b0 <trap+0x30>
801060a0:	ff 24 85 44 87 10 80 	jmp    *-0x7fef78bc(,%eax,4)
801060a7:	89 f6                	mov    %esi,%esi
801060a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
801060b0:	e8 db d7 ff ff       	call   80103890 <myproc>
801060b5:	85 c0                	test   %eax,%eax
801060b7:	8b 5f 38             	mov    0x38(%edi),%ebx
801060ba:	0f 84 14 02 00 00    	je     801062d4 <trap+0x254>
801060c0:	f6 47 3c 03          	testb  $0x3,0x3c(%edi)
801060c4:	0f 84 0a 02 00 00    	je     801062d4 <trap+0x254>

static inline uint
rcr2(void)
{
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
801060ca:	0f 20 d1             	mov    %cr2,%ecx
801060cd:	89 4d d8             	mov    %ecx,-0x28(%ebp)
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801060d0:	e8 9b d7 ff ff       	call   80103870 <cpuid>
801060d5:	89 45 dc             	mov    %eax,-0x24(%ebp)
801060d8:	8b 47 34             	mov    0x34(%edi),%eax
801060db:	8b 77 30             	mov    0x30(%edi),%esi
801060de:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
801060e1:	e8 aa d7 ff ff       	call   80103890 <myproc>
801060e6:	89 45 e0             	mov    %eax,-0x20(%ebp)
801060e9:	e8 a2 d7 ff ff       	call   80103890 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801060ee:	8b 4d d8             	mov    -0x28(%ebp),%ecx
801060f1:	8b 55 dc             	mov    -0x24(%ebp),%edx
801060f4:	51                   	push   %ecx
801060f5:	53                   	push   %ebx
801060f6:	52                   	push   %edx
            myproc()->pid, myproc()->name, tf->trapno,
801060f7:	8b 55 e0             	mov    -0x20(%ebp),%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
801060fa:	ff 75 e4             	pushl  -0x1c(%ebp)
801060fd:	56                   	push   %esi
            myproc()->pid, myproc()->name, tf->trapno,
801060fe:	81 c2 dc 04 00 00    	add    $0x4dc,%edx
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80106104:	52                   	push   %edx
80106105:	ff 70 10             	pushl  0x10(%eax)
80106108:	68 00 87 10 80       	push   $0x80108700
8010610d:	e8 4e a5 ff ff       	call   80100660 <cprintf>
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80106112:	83 c4 20             	add    $0x20,%esp
80106115:	e8 76 d7 ff ff       	call   80103890 <myproc>
8010611a:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106121:	e8 6a d7 ff ff       	call   80103890 <myproc>
80106126:	85 c0                	test   %eax,%eax
80106128:	74 1d                	je     80106147 <trap+0xc7>
8010612a:	e8 61 d7 ff ff       	call   80103890 <myproc>
8010612f:	8b 50 24             	mov    0x24(%eax),%edx
80106132:	85 d2                	test   %edx,%edx
80106134:	74 11                	je     80106147 <trap+0xc7>
80106136:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
8010613a:	83 e0 03             	and    $0x3,%eax
8010613d:	66 83 f8 03          	cmp    $0x3,%ax
80106141:	0f 84 49 01 00 00    	je     80106290 <trap+0x210>
    exit();

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80106147:	e8 44 d7 ff ff       	call   80103890 <myproc>
8010614c:	85 c0                	test   %eax,%eax
8010614e:	74 0b                	je     8010615b <trap+0xdb>
80106150:	e8 3b d7 ff ff       	call   80103890 <myproc>
80106155:	83 78 0c 04          	cmpl   $0x4,0xc(%eax)
80106159:	74 65                	je     801061c0 <trap+0x140>
     tf->trapno == T_IRQ0+IRQ_TIMER)
    yield();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
8010615b:	e8 30 d7 ff ff       	call   80103890 <myproc>
80106160:	85 c0                	test   %eax,%eax
80106162:	74 19                	je     8010617d <trap+0xfd>
80106164:	e8 27 d7 ff ff       	call   80103890 <myproc>
80106169:	8b 40 24             	mov    0x24(%eax),%eax
8010616c:	85 c0                	test   %eax,%eax
8010616e:	74 0d                	je     8010617d <trap+0xfd>
80106170:	0f b7 47 3c          	movzwl 0x3c(%edi),%eax
80106174:	83 e0 03             	and    $0x3,%eax
80106177:	66 83 f8 03          	cmp    $0x3,%ax
8010617b:	74 34                	je     801061b1 <trap+0x131>
    exit();
}
8010617d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106180:	5b                   	pop    %ebx
80106181:	5e                   	pop    %esi
80106182:	5f                   	pop    %edi
80106183:	5d                   	pop    %ebp
80106184:	c3                   	ret    
80106185:	8d 76 00             	lea    0x0(%esi),%esi
    if(myproc()->killed)
80106188:	e8 03 d7 ff ff       	call   80103890 <myproc>
8010618d:	8b 58 24             	mov    0x24(%eax),%ebx
80106190:	85 db                	test   %ebx,%ebx
80106192:	0f 85 e8 00 00 00    	jne    80106280 <trap+0x200>
    myproc()->tf = tf;
80106198:	e8 f3 d6 ff ff       	call   80103890 <myproc>
8010619d:	89 78 18             	mov    %edi,0x18(%eax)
    syscall();
801061a0:	e8 3b ec ff ff       	call   80104de0 <syscall>
    if(myproc()->killed)
801061a5:	e8 e6 d6 ff ff       	call   80103890 <myproc>
801061aa:	8b 48 24             	mov    0x24(%eax),%ecx
801061ad:	85 c9                	test   %ecx,%ecx
801061af:	74 cc                	je     8010617d <trap+0xfd>
}
801061b1:	8d 65 f4             	lea    -0xc(%ebp),%esp
801061b4:	5b                   	pop    %ebx
801061b5:	5e                   	pop    %esi
801061b6:	5f                   	pop    %edi
801061b7:	5d                   	pop    %ebp
      exit();
801061b8:	e9 a3 dc ff ff       	jmp    80103e60 <exit>
801061bd:	8d 76 00             	lea    0x0(%esi),%esi
  if(myproc() && myproc()->state == RUNNING &&
801061c0:	83 7f 30 20          	cmpl   $0x20,0x30(%edi)
801061c4:	75 95                	jne    8010615b <trap+0xdb>
    yield();
801061c6:	e8 d5 dd ff ff       	call   80103fa0 <yield>
801061cb:	eb 8e                	jmp    8010615b <trap+0xdb>
801061cd:	8d 76 00             	lea    0x0(%esi),%esi
    if(cpuid() == 0){
801061d0:	e8 9b d6 ff ff       	call   80103870 <cpuid>
801061d5:	85 c0                	test   %eax,%eax
801061d7:	0f 84 c3 00 00 00    	je     801062a0 <trap+0x220>
    lapiceoi();
801061dd:	e8 8e c5 ff ff       	call   80102770 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
801061e2:	e8 a9 d6 ff ff       	call   80103890 <myproc>
801061e7:	85 c0                	test   %eax,%eax
801061e9:	0f 85 3b ff ff ff    	jne    8010612a <trap+0xaa>
801061ef:	e9 53 ff ff ff       	jmp    80106147 <trap+0xc7>
801061f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    kbdintr();
801061f8:	e8 33 c4 ff ff       	call   80102630 <kbdintr>
    lapiceoi();
801061fd:	e8 6e c5 ff ff       	call   80102770 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106202:	e8 89 d6 ff ff       	call   80103890 <myproc>
80106207:	85 c0                	test   %eax,%eax
80106209:	0f 85 1b ff ff ff    	jne    8010612a <trap+0xaa>
8010620f:	e9 33 ff ff ff       	jmp    80106147 <trap+0xc7>
80106214:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    uartintr();
80106218:	e8 53 02 00 00       	call   80106470 <uartintr>
    lapiceoi();
8010621d:	e8 4e c5 ff ff       	call   80102770 <lapiceoi>
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106222:	e8 69 d6 ff ff       	call   80103890 <myproc>
80106227:	85 c0                	test   %eax,%eax
80106229:	0f 85 fb fe ff ff    	jne    8010612a <trap+0xaa>
8010622f:	e9 13 ff ff ff       	jmp    80106147 <trap+0xc7>
80106234:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80106238:	0f b7 5f 3c          	movzwl 0x3c(%edi),%ebx
8010623c:	8b 77 38             	mov    0x38(%edi),%esi
8010623f:	e8 2c d6 ff ff       	call   80103870 <cpuid>
80106244:	56                   	push   %esi
80106245:	53                   	push   %ebx
80106246:	50                   	push   %eax
80106247:	68 a8 86 10 80       	push   $0x801086a8
8010624c:	e8 0f a4 ff ff       	call   80100660 <cprintf>
    lapiceoi();
80106251:	e8 1a c5 ff ff       	call   80102770 <lapiceoi>
    break;
80106256:	83 c4 10             	add    $0x10,%esp
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80106259:	e8 32 d6 ff ff       	call   80103890 <myproc>
8010625e:	85 c0                	test   %eax,%eax
80106260:	0f 85 c4 fe ff ff    	jne    8010612a <trap+0xaa>
80106266:	e9 dc fe ff ff       	jmp    80106147 <trap+0xc7>
8010626b:	90                   	nop
8010626c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    ideintr();
80106270:	e8 2b be ff ff       	call   801020a0 <ideintr>
80106275:	e9 63 ff ff ff       	jmp    801061dd <trap+0x15d>
8010627a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      exit();
80106280:	e8 db db ff ff       	call   80103e60 <exit>
80106285:	e9 0e ff ff ff       	jmp    80106198 <trap+0x118>
8010628a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    exit();
80106290:	e8 cb db ff ff       	call   80103e60 <exit>
80106295:	e9 ad fe ff ff       	jmp    80106147 <trap+0xc7>
8010629a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      acquire(&tickslock);
801062a0:	83 ec 0c             	sub    $0xc,%esp
801062a3:	68 20 f7 12 80       	push   $0x8012f720
801062a8:	e8 33 e6 ff ff       	call   801048e0 <acquire>
      wakeup(&ticks);
801062ad:	c7 04 24 60 ff 12 80 	movl   $0x8012ff60,(%esp)
      ticks++;
801062b4:	83 05 60 ff 12 80 01 	addl   $0x1,0x8012ff60
      wakeup(&ticks);
801062bb:	e8 f0 de ff ff       	call   801041b0 <wakeup>
      release(&tickslock);
801062c0:	c7 04 24 20 f7 12 80 	movl   $0x8012f720,(%esp)
801062c7:	e8 d4 e6 ff ff       	call   801049a0 <release>
801062cc:	83 c4 10             	add    $0x10,%esp
801062cf:	e9 09 ff ff ff       	jmp    801061dd <trap+0x15d>
801062d4:	0f 20 d6             	mov    %cr2,%esi
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
801062d7:	e8 94 d5 ff ff       	call   80103870 <cpuid>
801062dc:	83 ec 0c             	sub    $0xc,%esp
801062df:	56                   	push   %esi
801062e0:	53                   	push   %ebx
801062e1:	50                   	push   %eax
801062e2:	ff 77 30             	pushl  0x30(%edi)
801062e5:	68 cc 86 10 80       	push   $0x801086cc
801062ea:	e8 71 a3 ff ff       	call   80100660 <cprintf>
      panic("trap");
801062ef:	83 c4 14             	add    $0x14,%esp
801062f2:	68 a2 86 10 80       	push   $0x801086a2
801062f7:	e8 94 a0 ff ff       	call   80100390 <panic>
801062fc:	66 90                	xchg   %ax,%ax
801062fe:	66 90                	xchg   %ax,%ax

80106300 <uartgetc>:
}

static int
uartgetc(void)
{
  if(!uart)
80106300:	a1 28 b9 10 80       	mov    0x8010b928,%eax
{
80106305:	55                   	push   %ebp
80106306:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106308:	85 c0                	test   %eax,%eax
8010630a:	74 1c                	je     80106328 <uartgetc+0x28>
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010630c:	ba fd 03 00 00       	mov    $0x3fd,%edx
80106311:	ec                   	in     (%dx),%al
    return -1;
  if(!(inb(COM1+5) & 0x01))
80106312:	a8 01                	test   $0x1,%al
80106314:	74 12                	je     80106328 <uartgetc+0x28>
80106316:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010631b:	ec                   	in     (%dx),%al
    return -1;
  return inb(COM1+0);
8010631c:	0f b6 c0             	movzbl %al,%eax
}
8010631f:	5d                   	pop    %ebp
80106320:	c3                   	ret    
80106321:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    return -1;
80106328:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010632d:	5d                   	pop    %ebp
8010632e:	c3                   	ret    
8010632f:	90                   	nop

80106330 <uartputc.part.0>:
uartputc(int c)
80106330:	55                   	push   %ebp
80106331:	89 e5                	mov    %esp,%ebp
80106333:	57                   	push   %edi
80106334:	56                   	push   %esi
80106335:	53                   	push   %ebx
80106336:	89 c7                	mov    %eax,%edi
80106338:	bb 80 00 00 00       	mov    $0x80,%ebx
8010633d:	be fd 03 00 00       	mov    $0x3fd,%esi
80106342:	83 ec 0c             	sub    $0xc,%esp
80106345:	eb 1b                	jmp    80106362 <uartputc.part.0+0x32>
80106347:	89 f6                	mov    %esi,%esi
80106349:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    microdelay(10);
80106350:	83 ec 0c             	sub    $0xc,%esp
80106353:	6a 0a                	push   $0xa
80106355:	e8 36 c4 ff ff       	call   80102790 <microdelay>
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
8010635a:	83 c4 10             	add    $0x10,%esp
8010635d:	83 eb 01             	sub    $0x1,%ebx
80106360:	74 07                	je     80106369 <uartputc.part.0+0x39>
80106362:	89 f2                	mov    %esi,%edx
80106364:	ec                   	in     (%dx),%al
80106365:	a8 20                	test   $0x20,%al
80106367:	74 e7                	je     80106350 <uartputc.part.0+0x20>
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80106369:	ba f8 03 00 00       	mov    $0x3f8,%edx
8010636e:	89 f8                	mov    %edi,%eax
80106370:	ee                   	out    %al,(%dx)
}
80106371:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106374:	5b                   	pop    %ebx
80106375:	5e                   	pop    %esi
80106376:	5f                   	pop    %edi
80106377:	5d                   	pop    %ebp
80106378:	c3                   	ret    
80106379:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80106380 <uartinit>:
{
80106380:	55                   	push   %ebp
80106381:	31 c9                	xor    %ecx,%ecx
80106383:	89 c8                	mov    %ecx,%eax
80106385:	89 e5                	mov    %esp,%ebp
80106387:	57                   	push   %edi
80106388:	56                   	push   %esi
80106389:	53                   	push   %ebx
8010638a:	bb fa 03 00 00       	mov    $0x3fa,%ebx
8010638f:	89 da                	mov    %ebx,%edx
80106391:	83 ec 0c             	sub    $0xc,%esp
80106394:	ee                   	out    %al,(%dx)
80106395:	bf fb 03 00 00       	mov    $0x3fb,%edi
8010639a:	b8 80 ff ff ff       	mov    $0xffffff80,%eax
8010639f:	89 fa                	mov    %edi,%edx
801063a1:	ee                   	out    %al,(%dx)
801063a2:	b8 0c 00 00 00       	mov    $0xc,%eax
801063a7:	ba f8 03 00 00       	mov    $0x3f8,%edx
801063ac:	ee                   	out    %al,(%dx)
801063ad:	be f9 03 00 00       	mov    $0x3f9,%esi
801063b2:	89 c8                	mov    %ecx,%eax
801063b4:	89 f2                	mov    %esi,%edx
801063b6:	ee                   	out    %al,(%dx)
801063b7:	b8 03 00 00 00       	mov    $0x3,%eax
801063bc:	89 fa                	mov    %edi,%edx
801063be:	ee                   	out    %al,(%dx)
801063bf:	ba fc 03 00 00       	mov    $0x3fc,%edx
801063c4:	89 c8                	mov    %ecx,%eax
801063c6:	ee                   	out    %al,(%dx)
801063c7:	b8 01 00 00 00       	mov    $0x1,%eax
801063cc:	89 f2                	mov    %esi,%edx
801063ce:	ee                   	out    %al,(%dx)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
801063cf:	ba fd 03 00 00       	mov    $0x3fd,%edx
801063d4:	ec                   	in     (%dx),%al
  if(inb(COM1+5) == 0xFF)
801063d5:	3c ff                	cmp    $0xff,%al
801063d7:	74 5a                	je     80106433 <uartinit+0xb3>
  uart = 1;
801063d9:	c7 05 28 b9 10 80 01 	movl   $0x1,0x8010b928
801063e0:	00 00 00 
801063e3:	89 da                	mov    %ebx,%edx
801063e5:	ec                   	in     (%dx),%al
801063e6:	ba f8 03 00 00       	mov    $0x3f8,%edx
801063eb:	ec                   	in     (%dx),%al
  ioapicenable(IRQ_COM1, 0);
801063ec:	83 ec 08             	sub    $0x8,%esp
  for(p="xv6...\n"; *p; p++)
801063ef:	bb c4 87 10 80       	mov    $0x801087c4,%ebx
  ioapicenable(IRQ_COM1, 0);
801063f4:	6a 00                	push   $0x0
801063f6:	6a 04                	push   $0x4
801063f8:	e8 f3 be ff ff       	call   801022f0 <ioapicenable>
801063fd:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80106400:	b8 78 00 00 00       	mov    $0x78,%eax
80106405:	eb 13                	jmp    8010641a <uartinit+0x9a>
80106407:	89 f6                	mov    %esi,%esi
80106409:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106410:	83 c3 01             	add    $0x1,%ebx
80106413:	0f be 03             	movsbl (%ebx),%eax
80106416:	84 c0                	test   %al,%al
80106418:	74 19                	je     80106433 <uartinit+0xb3>
  if(!uart)
8010641a:	8b 15 28 b9 10 80    	mov    0x8010b928,%edx
80106420:	85 d2                	test   %edx,%edx
80106422:	74 ec                	je     80106410 <uartinit+0x90>
  for(p="xv6...\n"; *p; p++)
80106424:	83 c3 01             	add    $0x1,%ebx
80106427:	e8 04 ff ff ff       	call   80106330 <uartputc.part.0>
8010642c:	0f be 03             	movsbl (%ebx),%eax
8010642f:	84 c0                	test   %al,%al
80106431:	75 e7                	jne    8010641a <uartinit+0x9a>
}
80106433:	8d 65 f4             	lea    -0xc(%ebp),%esp
80106436:	5b                   	pop    %ebx
80106437:	5e                   	pop    %esi
80106438:	5f                   	pop    %edi
80106439:	5d                   	pop    %ebp
8010643a:	c3                   	ret    
8010643b:	90                   	nop
8010643c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

80106440 <uartputc>:
  if(!uart)
80106440:	8b 15 28 b9 10 80    	mov    0x8010b928,%edx
{
80106446:	55                   	push   %ebp
80106447:	89 e5                	mov    %esp,%ebp
  if(!uart)
80106449:	85 d2                	test   %edx,%edx
{
8010644b:	8b 45 08             	mov    0x8(%ebp),%eax
  if(!uart)
8010644e:	74 10                	je     80106460 <uartputc+0x20>
}
80106450:	5d                   	pop    %ebp
80106451:	e9 da fe ff ff       	jmp    80106330 <uartputc.part.0>
80106456:	8d 76 00             	lea    0x0(%esi),%esi
80106459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80106460:	5d                   	pop    %ebp
80106461:	c3                   	ret    
80106462:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106469:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80106470 <uartintr>:

void
uartintr(void)
{
80106470:	55                   	push   %ebp
80106471:	89 e5                	mov    %esp,%ebp
80106473:	83 ec 14             	sub    $0x14,%esp
  consoleintr(uartgetc);
80106476:	68 00 63 10 80       	push   $0x80106300
8010647b:	e8 90 a3 ff ff       	call   80100810 <consoleintr>
}
80106480:	83 c4 10             	add    $0x10,%esp
80106483:	c9                   	leave  
80106484:	c3                   	ret    

80106485 <vector0>:
# generated by vectors.pl - do not edit
# handlers
.globl alltraps
.globl vector0
vector0:
  pushl $0
80106485:	6a 00                	push   $0x0
  pushl $0
80106487:	6a 00                	push   $0x0
  jmp alltraps
80106489:	e9 1f fb ff ff       	jmp    80105fad <alltraps>

8010648e <vector1>:
.globl vector1
vector1:
  pushl $0
8010648e:	6a 00                	push   $0x0
  pushl $1
80106490:	6a 01                	push   $0x1
  jmp alltraps
80106492:	e9 16 fb ff ff       	jmp    80105fad <alltraps>

80106497 <vector2>:
.globl vector2
vector2:
  pushl $0
80106497:	6a 00                	push   $0x0
  pushl $2
80106499:	6a 02                	push   $0x2
  jmp alltraps
8010649b:	e9 0d fb ff ff       	jmp    80105fad <alltraps>

801064a0 <vector3>:
.globl vector3
vector3:
  pushl $0
801064a0:	6a 00                	push   $0x0
  pushl $3
801064a2:	6a 03                	push   $0x3
  jmp alltraps
801064a4:	e9 04 fb ff ff       	jmp    80105fad <alltraps>

801064a9 <vector4>:
.globl vector4
vector4:
  pushl $0
801064a9:	6a 00                	push   $0x0
  pushl $4
801064ab:	6a 04                	push   $0x4
  jmp alltraps
801064ad:	e9 fb fa ff ff       	jmp    80105fad <alltraps>

801064b2 <vector5>:
.globl vector5
vector5:
  pushl $0
801064b2:	6a 00                	push   $0x0
  pushl $5
801064b4:	6a 05                	push   $0x5
  jmp alltraps
801064b6:	e9 f2 fa ff ff       	jmp    80105fad <alltraps>

801064bb <vector6>:
.globl vector6
vector6:
  pushl $0
801064bb:	6a 00                	push   $0x0
  pushl $6
801064bd:	6a 06                	push   $0x6
  jmp alltraps
801064bf:	e9 e9 fa ff ff       	jmp    80105fad <alltraps>

801064c4 <vector7>:
.globl vector7
vector7:
  pushl $0
801064c4:	6a 00                	push   $0x0
  pushl $7
801064c6:	6a 07                	push   $0x7
  jmp alltraps
801064c8:	e9 e0 fa ff ff       	jmp    80105fad <alltraps>

801064cd <vector8>:
.globl vector8
vector8:
  pushl $8
801064cd:	6a 08                	push   $0x8
  jmp alltraps
801064cf:	e9 d9 fa ff ff       	jmp    80105fad <alltraps>

801064d4 <vector9>:
.globl vector9
vector9:
  pushl $0
801064d4:	6a 00                	push   $0x0
  pushl $9
801064d6:	6a 09                	push   $0x9
  jmp alltraps
801064d8:	e9 d0 fa ff ff       	jmp    80105fad <alltraps>

801064dd <vector10>:
.globl vector10
vector10:
  pushl $10
801064dd:	6a 0a                	push   $0xa
  jmp alltraps
801064df:	e9 c9 fa ff ff       	jmp    80105fad <alltraps>

801064e4 <vector11>:
.globl vector11
vector11:
  pushl $11
801064e4:	6a 0b                	push   $0xb
  jmp alltraps
801064e6:	e9 c2 fa ff ff       	jmp    80105fad <alltraps>

801064eb <vector12>:
.globl vector12
vector12:
  pushl $12
801064eb:	6a 0c                	push   $0xc
  jmp alltraps
801064ed:	e9 bb fa ff ff       	jmp    80105fad <alltraps>

801064f2 <vector13>:
.globl vector13
vector13:
  pushl $13
801064f2:	6a 0d                	push   $0xd
  jmp alltraps
801064f4:	e9 b4 fa ff ff       	jmp    80105fad <alltraps>

801064f9 <vector14>:
.globl vector14
vector14:
  pushl $14
801064f9:	6a 0e                	push   $0xe
  jmp alltraps
801064fb:	e9 ad fa ff ff       	jmp    80105fad <alltraps>

80106500 <vector15>:
.globl vector15
vector15:
  pushl $0
80106500:	6a 00                	push   $0x0
  pushl $15
80106502:	6a 0f                	push   $0xf
  jmp alltraps
80106504:	e9 a4 fa ff ff       	jmp    80105fad <alltraps>

80106509 <vector16>:
.globl vector16
vector16:
  pushl $0
80106509:	6a 00                	push   $0x0
  pushl $16
8010650b:	6a 10                	push   $0x10
  jmp alltraps
8010650d:	e9 9b fa ff ff       	jmp    80105fad <alltraps>

80106512 <vector17>:
.globl vector17
vector17:
  pushl $17
80106512:	6a 11                	push   $0x11
  jmp alltraps
80106514:	e9 94 fa ff ff       	jmp    80105fad <alltraps>

80106519 <vector18>:
.globl vector18
vector18:
  pushl $0
80106519:	6a 00                	push   $0x0
  pushl $18
8010651b:	6a 12                	push   $0x12
  jmp alltraps
8010651d:	e9 8b fa ff ff       	jmp    80105fad <alltraps>

80106522 <vector19>:
.globl vector19
vector19:
  pushl $0
80106522:	6a 00                	push   $0x0
  pushl $19
80106524:	6a 13                	push   $0x13
  jmp alltraps
80106526:	e9 82 fa ff ff       	jmp    80105fad <alltraps>

8010652b <vector20>:
.globl vector20
vector20:
  pushl $0
8010652b:	6a 00                	push   $0x0
  pushl $20
8010652d:	6a 14                	push   $0x14
  jmp alltraps
8010652f:	e9 79 fa ff ff       	jmp    80105fad <alltraps>

80106534 <vector21>:
.globl vector21
vector21:
  pushl $0
80106534:	6a 00                	push   $0x0
  pushl $21
80106536:	6a 15                	push   $0x15
  jmp alltraps
80106538:	e9 70 fa ff ff       	jmp    80105fad <alltraps>

8010653d <vector22>:
.globl vector22
vector22:
  pushl $0
8010653d:	6a 00                	push   $0x0
  pushl $22
8010653f:	6a 16                	push   $0x16
  jmp alltraps
80106541:	e9 67 fa ff ff       	jmp    80105fad <alltraps>

80106546 <vector23>:
.globl vector23
vector23:
  pushl $0
80106546:	6a 00                	push   $0x0
  pushl $23
80106548:	6a 17                	push   $0x17
  jmp alltraps
8010654a:	e9 5e fa ff ff       	jmp    80105fad <alltraps>

8010654f <vector24>:
.globl vector24
vector24:
  pushl $0
8010654f:	6a 00                	push   $0x0
  pushl $24
80106551:	6a 18                	push   $0x18
  jmp alltraps
80106553:	e9 55 fa ff ff       	jmp    80105fad <alltraps>

80106558 <vector25>:
.globl vector25
vector25:
  pushl $0
80106558:	6a 00                	push   $0x0
  pushl $25
8010655a:	6a 19                	push   $0x19
  jmp alltraps
8010655c:	e9 4c fa ff ff       	jmp    80105fad <alltraps>

80106561 <vector26>:
.globl vector26
vector26:
  pushl $0
80106561:	6a 00                	push   $0x0
  pushl $26
80106563:	6a 1a                	push   $0x1a
  jmp alltraps
80106565:	e9 43 fa ff ff       	jmp    80105fad <alltraps>

8010656a <vector27>:
.globl vector27
vector27:
  pushl $0
8010656a:	6a 00                	push   $0x0
  pushl $27
8010656c:	6a 1b                	push   $0x1b
  jmp alltraps
8010656e:	e9 3a fa ff ff       	jmp    80105fad <alltraps>

80106573 <vector28>:
.globl vector28
vector28:
  pushl $0
80106573:	6a 00                	push   $0x0
  pushl $28
80106575:	6a 1c                	push   $0x1c
  jmp alltraps
80106577:	e9 31 fa ff ff       	jmp    80105fad <alltraps>

8010657c <vector29>:
.globl vector29
vector29:
  pushl $0
8010657c:	6a 00                	push   $0x0
  pushl $29
8010657e:	6a 1d                	push   $0x1d
  jmp alltraps
80106580:	e9 28 fa ff ff       	jmp    80105fad <alltraps>

80106585 <vector30>:
.globl vector30
vector30:
  pushl $0
80106585:	6a 00                	push   $0x0
  pushl $30
80106587:	6a 1e                	push   $0x1e
  jmp alltraps
80106589:	e9 1f fa ff ff       	jmp    80105fad <alltraps>

8010658e <vector31>:
.globl vector31
vector31:
  pushl $0
8010658e:	6a 00                	push   $0x0
  pushl $31
80106590:	6a 1f                	push   $0x1f
  jmp alltraps
80106592:	e9 16 fa ff ff       	jmp    80105fad <alltraps>

80106597 <vector32>:
.globl vector32
vector32:
  pushl $0
80106597:	6a 00                	push   $0x0
  pushl $32
80106599:	6a 20                	push   $0x20
  jmp alltraps
8010659b:	e9 0d fa ff ff       	jmp    80105fad <alltraps>

801065a0 <vector33>:
.globl vector33
vector33:
  pushl $0
801065a0:	6a 00                	push   $0x0
  pushl $33
801065a2:	6a 21                	push   $0x21
  jmp alltraps
801065a4:	e9 04 fa ff ff       	jmp    80105fad <alltraps>

801065a9 <vector34>:
.globl vector34
vector34:
  pushl $0
801065a9:	6a 00                	push   $0x0
  pushl $34
801065ab:	6a 22                	push   $0x22
  jmp alltraps
801065ad:	e9 fb f9 ff ff       	jmp    80105fad <alltraps>

801065b2 <vector35>:
.globl vector35
vector35:
  pushl $0
801065b2:	6a 00                	push   $0x0
  pushl $35
801065b4:	6a 23                	push   $0x23
  jmp alltraps
801065b6:	e9 f2 f9 ff ff       	jmp    80105fad <alltraps>

801065bb <vector36>:
.globl vector36
vector36:
  pushl $0
801065bb:	6a 00                	push   $0x0
  pushl $36
801065bd:	6a 24                	push   $0x24
  jmp alltraps
801065bf:	e9 e9 f9 ff ff       	jmp    80105fad <alltraps>

801065c4 <vector37>:
.globl vector37
vector37:
  pushl $0
801065c4:	6a 00                	push   $0x0
  pushl $37
801065c6:	6a 25                	push   $0x25
  jmp alltraps
801065c8:	e9 e0 f9 ff ff       	jmp    80105fad <alltraps>

801065cd <vector38>:
.globl vector38
vector38:
  pushl $0
801065cd:	6a 00                	push   $0x0
  pushl $38
801065cf:	6a 26                	push   $0x26
  jmp alltraps
801065d1:	e9 d7 f9 ff ff       	jmp    80105fad <alltraps>

801065d6 <vector39>:
.globl vector39
vector39:
  pushl $0
801065d6:	6a 00                	push   $0x0
  pushl $39
801065d8:	6a 27                	push   $0x27
  jmp alltraps
801065da:	e9 ce f9 ff ff       	jmp    80105fad <alltraps>

801065df <vector40>:
.globl vector40
vector40:
  pushl $0
801065df:	6a 00                	push   $0x0
  pushl $40
801065e1:	6a 28                	push   $0x28
  jmp alltraps
801065e3:	e9 c5 f9 ff ff       	jmp    80105fad <alltraps>

801065e8 <vector41>:
.globl vector41
vector41:
  pushl $0
801065e8:	6a 00                	push   $0x0
  pushl $41
801065ea:	6a 29                	push   $0x29
  jmp alltraps
801065ec:	e9 bc f9 ff ff       	jmp    80105fad <alltraps>

801065f1 <vector42>:
.globl vector42
vector42:
  pushl $0
801065f1:	6a 00                	push   $0x0
  pushl $42
801065f3:	6a 2a                	push   $0x2a
  jmp alltraps
801065f5:	e9 b3 f9 ff ff       	jmp    80105fad <alltraps>

801065fa <vector43>:
.globl vector43
vector43:
  pushl $0
801065fa:	6a 00                	push   $0x0
  pushl $43
801065fc:	6a 2b                	push   $0x2b
  jmp alltraps
801065fe:	e9 aa f9 ff ff       	jmp    80105fad <alltraps>

80106603 <vector44>:
.globl vector44
vector44:
  pushl $0
80106603:	6a 00                	push   $0x0
  pushl $44
80106605:	6a 2c                	push   $0x2c
  jmp alltraps
80106607:	e9 a1 f9 ff ff       	jmp    80105fad <alltraps>

8010660c <vector45>:
.globl vector45
vector45:
  pushl $0
8010660c:	6a 00                	push   $0x0
  pushl $45
8010660e:	6a 2d                	push   $0x2d
  jmp alltraps
80106610:	e9 98 f9 ff ff       	jmp    80105fad <alltraps>

80106615 <vector46>:
.globl vector46
vector46:
  pushl $0
80106615:	6a 00                	push   $0x0
  pushl $46
80106617:	6a 2e                	push   $0x2e
  jmp alltraps
80106619:	e9 8f f9 ff ff       	jmp    80105fad <alltraps>

8010661e <vector47>:
.globl vector47
vector47:
  pushl $0
8010661e:	6a 00                	push   $0x0
  pushl $47
80106620:	6a 2f                	push   $0x2f
  jmp alltraps
80106622:	e9 86 f9 ff ff       	jmp    80105fad <alltraps>

80106627 <vector48>:
.globl vector48
vector48:
  pushl $0
80106627:	6a 00                	push   $0x0
  pushl $48
80106629:	6a 30                	push   $0x30
  jmp alltraps
8010662b:	e9 7d f9 ff ff       	jmp    80105fad <alltraps>

80106630 <vector49>:
.globl vector49
vector49:
  pushl $0
80106630:	6a 00                	push   $0x0
  pushl $49
80106632:	6a 31                	push   $0x31
  jmp alltraps
80106634:	e9 74 f9 ff ff       	jmp    80105fad <alltraps>

80106639 <vector50>:
.globl vector50
vector50:
  pushl $0
80106639:	6a 00                	push   $0x0
  pushl $50
8010663b:	6a 32                	push   $0x32
  jmp alltraps
8010663d:	e9 6b f9 ff ff       	jmp    80105fad <alltraps>

80106642 <vector51>:
.globl vector51
vector51:
  pushl $0
80106642:	6a 00                	push   $0x0
  pushl $51
80106644:	6a 33                	push   $0x33
  jmp alltraps
80106646:	e9 62 f9 ff ff       	jmp    80105fad <alltraps>

8010664b <vector52>:
.globl vector52
vector52:
  pushl $0
8010664b:	6a 00                	push   $0x0
  pushl $52
8010664d:	6a 34                	push   $0x34
  jmp alltraps
8010664f:	e9 59 f9 ff ff       	jmp    80105fad <alltraps>

80106654 <vector53>:
.globl vector53
vector53:
  pushl $0
80106654:	6a 00                	push   $0x0
  pushl $53
80106656:	6a 35                	push   $0x35
  jmp alltraps
80106658:	e9 50 f9 ff ff       	jmp    80105fad <alltraps>

8010665d <vector54>:
.globl vector54
vector54:
  pushl $0
8010665d:	6a 00                	push   $0x0
  pushl $54
8010665f:	6a 36                	push   $0x36
  jmp alltraps
80106661:	e9 47 f9 ff ff       	jmp    80105fad <alltraps>

80106666 <vector55>:
.globl vector55
vector55:
  pushl $0
80106666:	6a 00                	push   $0x0
  pushl $55
80106668:	6a 37                	push   $0x37
  jmp alltraps
8010666a:	e9 3e f9 ff ff       	jmp    80105fad <alltraps>

8010666f <vector56>:
.globl vector56
vector56:
  pushl $0
8010666f:	6a 00                	push   $0x0
  pushl $56
80106671:	6a 38                	push   $0x38
  jmp alltraps
80106673:	e9 35 f9 ff ff       	jmp    80105fad <alltraps>

80106678 <vector57>:
.globl vector57
vector57:
  pushl $0
80106678:	6a 00                	push   $0x0
  pushl $57
8010667a:	6a 39                	push   $0x39
  jmp alltraps
8010667c:	e9 2c f9 ff ff       	jmp    80105fad <alltraps>

80106681 <vector58>:
.globl vector58
vector58:
  pushl $0
80106681:	6a 00                	push   $0x0
  pushl $58
80106683:	6a 3a                	push   $0x3a
  jmp alltraps
80106685:	e9 23 f9 ff ff       	jmp    80105fad <alltraps>

8010668a <vector59>:
.globl vector59
vector59:
  pushl $0
8010668a:	6a 00                	push   $0x0
  pushl $59
8010668c:	6a 3b                	push   $0x3b
  jmp alltraps
8010668e:	e9 1a f9 ff ff       	jmp    80105fad <alltraps>

80106693 <vector60>:
.globl vector60
vector60:
  pushl $0
80106693:	6a 00                	push   $0x0
  pushl $60
80106695:	6a 3c                	push   $0x3c
  jmp alltraps
80106697:	e9 11 f9 ff ff       	jmp    80105fad <alltraps>

8010669c <vector61>:
.globl vector61
vector61:
  pushl $0
8010669c:	6a 00                	push   $0x0
  pushl $61
8010669e:	6a 3d                	push   $0x3d
  jmp alltraps
801066a0:	e9 08 f9 ff ff       	jmp    80105fad <alltraps>

801066a5 <vector62>:
.globl vector62
vector62:
  pushl $0
801066a5:	6a 00                	push   $0x0
  pushl $62
801066a7:	6a 3e                	push   $0x3e
  jmp alltraps
801066a9:	e9 ff f8 ff ff       	jmp    80105fad <alltraps>

801066ae <vector63>:
.globl vector63
vector63:
  pushl $0
801066ae:	6a 00                	push   $0x0
  pushl $63
801066b0:	6a 3f                	push   $0x3f
  jmp alltraps
801066b2:	e9 f6 f8 ff ff       	jmp    80105fad <alltraps>

801066b7 <vector64>:
.globl vector64
vector64:
  pushl $0
801066b7:	6a 00                	push   $0x0
  pushl $64
801066b9:	6a 40                	push   $0x40
  jmp alltraps
801066bb:	e9 ed f8 ff ff       	jmp    80105fad <alltraps>

801066c0 <vector65>:
.globl vector65
vector65:
  pushl $0
801066c0:	6a 00                	push   $0x0
  pushl $65
801066c2:	6a 41                	push   $0x41
  jmp alltraps
801066c4:	e9 e4 f8 ff ff       	jmp    80105fad <alltraps>

801066c9 <vector66>:
.globl vector66
vector66:
  pushl $0
801066c9:	6a 00                	push   $0x0
  pushl $66
801066cb:	6a 42                	push   $0x42
  jmp alltraps
801066cd:	e9 db f8 ff ff       	jmp    80105fad <alltraps>

801066d2 <vector67>:
.globl vector67
vector67:
  pushl $0
801066d2:	6a 00                	push   $0x0
  pushl $67
801066d4:	6a 43                	push   $0x43
  jmp alltraps
801066d6:	e9 d2 f8 ff ff       	jmp    80105fad <alltraps>

801066db <vector68>:
.globl vector68
vector68:
  pushl $0
801066db:	6a 00                	push   $0x0
  pushl $68
801066dd:	6a 44                	push   $0x44
  jmp alltraps
801066df:	e9 c9 f8 ff ff       	jmp    80105fad <alltraps>

801066e4 <vector69>:
.globl vector69
vector69:
  pushl $0
801066e4:	6a 00                	push   $0x0
  pushl $69
801066e6:	6a 45                	push   $0x45
  jmp alltraps
801066e8:	e9 c0 f8 ff ff       	jmp    80105fad <alltraps>

801066ed <vector70>:
.globl vector70
vector70:
  pushl $0
801066ed:	6a 00                	push   $0x0
  pushl $70
801066ef:	6a 46                	push   $0x46
  jmp alltraps
801066f1:	e9 b7 f8 ff ff       	jmp    80105fad <alltraps>

801066f6 <vector71>:
.globl vector71
vector71:
  pushl $0
801066f6:	6a 00                	push   $0x0
  pushl $71
801066f8:	6a 47                	push   $0x47
  jmp alltraps
801066fa:	e9 ae f8 ff ff       	jmp    80105fad <alltraps>

801066ff <vector72>:
.globl vector72
vector72:
  pushl $0
801066ff:	6a 00                	push   $0x0
  pushl $72
80106701:	6a 48                	push   $0x48
  jmp alltraps
80106703:	e9 a5 f8 ff ff       	jmp    80105fad <alltraps>

80106708 <vector73>:
.globl vector73
vector73:
  pushl $0
80106708:	6a 00                	push   $0x0
  pushl $73
8010670a:	6a 49                	push   $0x49
  jmp alltraps
8010670c:	e9 9c f8 ff ff       	jmp    80105fad <alltraps>

80106711 <vector74>:
.globl vector74
vector74:
  pushl $0
80106711:	6a 00                	push   $0x0
  pushl $74
80106713:	6a 4a                	push   $0x4a
  jmp alltraps
80106715:	e9 93 f8 ff ff       	jmp    80105fad <alltraps>

8010671a <vector75>:
.globl vector75
vector75:
  pushl $0
8010671a:	6a 00                	push   $0x0
  pushl $75
8010671c:	6a 4b                	push   $0x4b
  jmp alltraps
8010671e:	e9 8a f8 ff ff       	jmp    80105fad <alltraps>

80106723 <vector76>:
.globl vector76
vector76:
  pushl $0
80106723:	6a 00                	push   $0x0
  pushl $76
80106725:	6a 4c                	push   $0x4c
  jmp alltraps
80106727:	e9 81 f8 ff ff       	jmp    80105fad <alltraps>

8010672c <vector77>:
.globl vector77
vector77:
  pushl $0
8010672c:	6a 00                	push   $0x0
  pushl $77
8010672e:	6a 4d                	push   $0x4d
  jmp alltraps
80106730:	e9 78 f8 ff ff       	jmp    80105fad <alltraps>

80106735 <vector78>:
.globl vector78
vector78:
  pushl $0
80106735:	6a 00                	push   $0x0
  pushl $78
80106737:	6a 4e                	push   $0x4e
  jmp alltraps
80106739:	e9 6f f8 ff ff       	jmp    80105fad <alltraps>

8010673e <vector79>:
.globl vector79
vector79:
  pushl $0
8010673e:	6a 00                	push   $0x0
  pushl $79
80106740:	6a 4f                	push   $0x4f
  jmp alltraps
80106742:	e9 66 f8 ff ff       	jmp    80105fad <alltraps>

80106747 <vector80>:
.globl vector80
vector80:
  pushl $0
80106747:	6a 00                	push   $0x0
  pushl $80
80106749:	6a 50                	push   $0x50
  jmp alltraps
8010674b:	e9 5d f8 ff ff       	jmp    80105fad <alltraps>

80106750 <vector81>:
.globl vector81
vector81:
  pushl $0
80106750:	6a 00                	push   $0x0
  pushl $81
80106752:	6a 51                	push   $0x51
  jmp alltraps
80106754:	e9 54 f8 ff ff       	jmp    80105fad <alltraps>

80106759 <vector82>:
.globl vector82
vector82:
  pushl $0
80106759:	6a 00                	push   $0x0
  pushl $82
8010675b:	6a 52                	push   $0x52
  jmp alltraps
8010675d:	e9 4b f8 ff ff       	jmp    80105fad <alltraps>

80106762 <vector83>:
.globl vector83
vector83:
  pushl $0
80106762:	6a 00                	push   $0x0
  pushl $83
80106764:	6a 53                	push   $0x53
  jmp alltraps
80106766:	e9 42 f8 ff ff       	jmp    80105fad <alltraps>

8010676b <vector84>:
.globl vector84
vector84:
  pushl $0
8010676b:	6a 00                	push   $0x0
  pushl $84
8010676d:	6a 54                	push   $0x54
  jmp alltraps
8010676f:	e9 39 f8 ff ff       	jmp    80105fad <alltraps>

80106774 <vector85>:
.globl vector85
vector85:
  pushl $0
80106774:	6a 00                	push   $0x0
  pushl $85
80106776:	6a 55                	push   $0x55
  jmp alltraps
80106778:	e9 30 f8 ff ff       	jmp    80105fad <alltraps>

8010677d <vector86>:
.globl vector86
vector86:
  pushl $0
8010677d:	6a 00                	push   $0x0
  pushl $86
8010677f:	6a 56                	push   $0x56
  jmp alltraps
80106781:	e9 27 f8 ff ff       	jmp    80105fad <alltraps>

80106786 <vector87>:
.globl vector87
vector87:
  pushl $0
80106786:	6a 00                	push   $0x0
  pushl $87
80106788:	6a 57                	push   $0x57
  jmp alltraps
8010678a:	e9 1e f8 ff ff       	jmp    80105fad <alltraps>

8010678f <vector88>:
.globl vector88
vector88:
  pushl $0
8010678f:	6a 00                	push   $0x0
  pushl $88
80106791:	6a 58                	push   $0x58
  jmp alltraps
80106793:	e9 15 f8 ff ff       	jmp    80105fad <alltraps>

80106798 <vector89>:
.globl vector89
vector89:
  pushl $0
80106798:	6a 00                	push   $0x0
  pushl $89
8010679a:	6a 59                	push   $0x59
  jmp alltraps
8010679c:	e9 0c f8 ff ff       	jmp    80105fad <alltraps>

801067a1 <vector90>:
.globl vector90
vector90:
  pushl $0
801067a1:	6a 00                	push   $0x0
  pushl $90
801067a3:	6a 5a                	push   $0x5a
  jmp alltraps
801067a5:	e9 03 f8 ff ff       	jmp    80105fad <alltraps>

801067aa <vector91>:
.globl vector91
vector91:
  pushl $0
801067aa:	6a 00                	push   $0x0
  pushl $91
801067ac:	6a 5b                	push   $0x5b
  jmp alltraps
801067ae:	e9 fa f7 ff ff       	jmp    80105fad <alltraps>

801067b3 <vector92>:
.globl vector92
vector92:
  pushl $0
801067b3:	6a 00                	push   $0x0
  pushl $92
801067b5:	6a 5c                	push   $0x5c
  jmp alltraps
801067b7:	e9 f1 f7 ff ff       	jmp    80105fad <alltraps>

801067bc <vector93>:
.globl vector93
vector93:
  pushl $0
801067bc:	6a 00                	push   $0x0
  pushl $93
801067be:	6a 5d                	push   $0x5d
  jmp alltraps
801067c0:	e9 e8 f7 ff ff       	jmp    80105fad <alltraps>

801067c5 <vector94>:
.globl vector94
vector94:
  pushl $0
801067c5:	6a 00                	push   $0x0
  pushl $94
801067c7:	6a 5e                	push   $0x5e
  jmp alltraps
801067c9:	e9 df f7 ff ff       	jmp    80105fad <alltraps>

801067ce <vector95>:
.globl vector95
vector95:
  pushl $0
801067ce:	6a 00                	push   $0x0
  pushl $95
801067d0:	6a 5f                	push   $0x5f
  jmp alltraps
801067d2:	e9 d6 f7 ff ff       	jmp    80105fad <alltraps>

801067d7 <vector96>:
.globl vector96
vector96:
  pushl $0
801067d7:	6a 00                	push   $0x0
  pushl $96
801067d9:	6a 60                	push   $0x60
  jmp alltraps
801067db:	e9 cd f7 ff ff       	jmp    80105fad <alltraps>

801067e0 <vector97>:
.globl vector97
vector97:
  pushl $0
801067e0:	6a 00                	push   $0x0
  pushl $97
801067e2:	6a 61                	push   $0x61
  jmp alltraps
801067e4:	e9 c4 f7 ff ff       	jmp    80105fad <alltraps>

801067e9 <vector98>:
.globl vector98
vector98:
  pushl $0
801067e9:	6a 00                	push   $0x0
  pushl $98
801067eb:	6a 62                	push   $0x62
  jmp alltraps
801067ed:	e9 bb f7 ff ff       	jmp    80105fad <alltraps>

801067f2 <vector99>:
.globl vector99
vector99:
  pushl $0
801067f2:	6a 00                	push   $0x0
  pushl $99
801067f4:	6a 63                	push   $0x63
  jmp alltraps
801067f6:	e9 b2 f7 ff ff       	jmp    80105fad <alltraps>

801067fb <vector100>:
.globl vector100
vector100:
  pushl $0
801067fb:	6a 00                	push   $0x0
  pushl $100
801067fd:	6a 64                	push   $0x64
  jmp alltraps
801067ff:	e9 a9 f7 ff ff       	jmp    80105fad <alltraps>

80106804 <vector101>:
.globl vector101
vector101:
  pushl $0
80106804:	6a 00                	push   $0x0
  pushl $101
80106806:	6a 65                	push   $0x65
  jmp alltraps
80106808:	e9 a0 f7 ff ff       	jmp    80105fad <alltraps>

8010680d <vector102>:
.globl vector102
vector102:
  pushl $0
8010680d:	6a 00                	push   $0x0
  pushl $102
8010680f:	6a 66                	push   $0x66
  jmp alltraps
80106811:	e9 97 f7 ff ff       	jmp    80105fad <alltraps>

80106816 <vector103>:
.globl vector103
vector103:
  pushl $0
80106816:	6a 00                	push   $0x0
  pushl $103
80106818:	6a 67                	push   $0x67
  jmp alltraps
8010681a:	e9 8e f7 ff ff       	jmp    80105fad <alltraps>

8010681f <vector104>:
.globl vector104
vector104:
  pushl $0
8010681f:	6a 00                	push   $0x0
  pushl $104
80106821:	6a 68                	push   $0x68
  jmp alltraps
80106823:	e9 85 f7 ff ff       	jmp    80105fad <alltraps>

80106828 <vector105>:
.globl vector105
vector105:
  pushl $0
80106828:	6a 00                	push   $0x0
  pushl $105
8010682a:	6a 69                	push   $0x69
  jmp alltraps
8010682c:	e9 7c f7 ff ff       	jmp    80105fad <alltraps>

80106831 <vector106>:
.globl vector106
vector106:
  pushl $0
80106831:	6a 00                	push   $0x0
  pushl $106
80106833:	6a 6a                	push   $0x6a
  jmp alltraps
80106835:	e9 73 f7 ff ff       	jmp    80105fad <alltraps>

8010683a <vector107>:
.globl vector107
vector107:
  pushl $0
8010683a:	6a 00                	push   $0x0
  pushl $107
8010683c:	6a 6b                	push   $0x6b
  jmp alltraps
8010683e:	e9 6a f7 ff ff       	jmp    80105fad <alltraps>

80106843 <vector108>:
.globl vector108
vector108:
  pushl $0
80106843:	6a 00                	push   $0x0
  pushl $108
80106845:	6a 6c                	push   $0x6c
  jmp alltraps
80106847:	e9 61 f7 ff ff       	jmp    80105fad <alltraps>

8010684c <vector109>:
.globl vector109
vector109:
  pushl $0
8010684c:	6a 00                	push   $0x0
  pushl $109
8010684e:	6a 6d                	push   $0x6d
  jmp alltraps
80106850:	e9 58 f7 ff ff       	jmp    80105fad <alltraps>

80106855 <vector110>:
.globl vector110
vector110:
  pushl $0
80106855:	6a 00                	push   $0x0
  pushl $110
80106857:	6a 6e                	push   $0x6e
  jmp alltraps
80106859:	e9 4f f7 ff ff       	jmp    80105fad <alltraps>

8010685e <vector111>:
.globl vector111
vector111:
  pushl $0
8010685e:	6a 00                	push   $0x0
  pushl $111
80106860:	6a 6f                	push   $0x6f
  jmp alltraps
80106862:	e9 46 f7 ff ff       	jmp    80105fad <alltraps>

80106867 <vector112>:
.globl vector112
vector112:
  pushl $0
80106867:	6a 00                	push   $0x0
  pushl $112
80106869:	6a 70                	push   $0x70
  jmp alltraps
8010686b:	e9 3d f7 ff ff       	jmp    80105fad <alltraps>

80106870 <vector113>:
.globl vector113
vector113:
  pushl $0
80106870:	6a 00                	push   $0x0
  pushl $113
80106872:	6a 71                	push   $0x71
  jmp alltraps
80106874:	e9 34 f7 ff ff       	jmp    80105fad <alltraps>

80106879 <vector114>:
.globl vector114
vector114:
  pushl $0
80106879:	6a 00                	push   $0x0
  pushl $114
8010687b:	6a 72                	push   $0x72
  jmp alltraps
8010687d:	e9 2b f7 ff ff       	jmp    80105fad <alltraps>

80106882 <vector115>:
.globl vector115
vector115:
  pushl $0
80106882:	6a 00                	push   $0x0
  pushl $115
80106884:	6a 73                	push   $0x73
  jmp alltraps
80106886:	e9 22 f7 ff ff       	jmp    80105fad <alltraps>

8010688b <vector116>:
.globl vector116
vector116:
  pushl $0
8010688b:	6a 00                	push   $0x0
  pushl $116
8010688d:	6a 74                	push   $0x74
  jmp alltraps
8010688f:	e9 19 f7 ff ff       	jmp    80105fad <alltraps>

80106894 <vector117>:
.globl vector117
vector117:
  pushl $0
80106894:	6a 00                	push   $0x0
  pushl $117
80106896:	6a 75                	push   $0x75
  jmp alltraps
80106898:	e9 10 f7 ff ff       	jmp    80105fad <alltraps>

8010689d <vector118>:
.globl vector118
vector118:
  pushl $0
8010689d:	6a 00                	push   $0x0
  pushl $118
8010689f:	6a 76                	push   $0x76
  jmp alltraps
801068a1:	e9 07 f7 ff ff       	jmp    80105fad <alltraps>

801068a6 <vector119>:
.globl vector119
vector119:
  pushl $0
801068a6:	6a 00                	push   $0x0
  pushl $119
801068a8:	6a 77                	push   $0x77
  jmp alltraps
801068aa:	e9 fe f6 ff ff       	jmp    80105fad <alltraps>

801068af <vector120>:
.globl vector120
vector120:
  pushl $0
801068af:	6a 00                	push   $0x0
  pushl $120
801068b1:	6a 78                	push   $0x78
  jmp alltraps
801068b3:	e9 f5 f6 ff ff       	jmp    80105fad <alltraps>

801068b8 <vector121>:
.globl vector121
vector121:
  pushl $0
801068b8:	6a 00                	push   $0x0
  pushl $121
801068ba:	6a 79                	push   $0x79
  jmp alltraps
801068bc:	e9 ec f6 ff ff       	jmp    80105fad <alltraps>

801068c1 <vector122>:
.globl vector122
vector122:
  pushl $0
801068c1:	6a 00                	push   $0x0
  pushl $122
801068c3:	6a 7a                	push   $0x7a
  jmp alltraps
801068c5:	e9 e3 f6 ff ff       	jmp    80105fad <alltraps>

801068ca <vector123>:
.globl vector123
vector123:
  pushl $0
801068ca:	6a 00                	push   $0x0
  pushl $123
801068cc:	6a 7b                	push   $0x7b
  jmp alltraps
801068ce:	e9 da f6 ff ff       	jmp    80105fad <alltraps>

801068d3 <vector124>:
.globl vector124
vector124:
  pushl $0
801068d3:	6a 00                	push   $0x0
  pushl $124
801068d5:	6a 7c                	push   $0x7c
  jmp alltraps
801068d7:	e9 d1 f6 ff ff       	jmp    80105fad <alltraps>

801068dc <vector125>:
.globl vector125
vector125:
  pushl $0
801068dc:	6a 00                	push   $0x0
  pushl $125
801068de:	6a 7d                	push   $0x7d
  jmp alltraps
801068e0:	e9 c8 f6 ff ff       	jmp    80105fad <alltraps>

801068e5 <vector126>:
.globl vector126
vector126:
  pushl $0
801068e5:	6a 00                	push   $0x0
  pushl $126
801068e7:	6a 7e                	push   $0x7e
  jmp alltraps
801068e9:	e9 bf f6 ff ff       	jmp    80105fad <alltraps>

801068ee <vector127>:
.globl vector127
vector127:
  pushl $0
801068ee:	6a 00                	push   $0x0
  pushl $127
801068f0:	6a 7f                	push   $0x7f
  jmp alltraps
801068f2:	e9 b6 f6 ff ff       	jmp    80105fad <alltraps>

801068f7 <vector128>:
.globl vector128
vector128:
  pushl $0
801068f7:	6a 00                	push   $0x0
  pushl $128
801068f9:	68 80 00 00 00       	push   $0x80
  jmp alltraps
801068fe:	e9 aa f6 ff ff       	jmp    80105fad <alltraps>

80106903 <vector129>:
.globl vector129
vector129:
  pushl $0
80106903:	6a 00                	push   $0x0
  pushl $129
80106905:	68 81 00 00 00       	push   $0x81
  jmp alltraps
8010690a:	e9 9e f6 ff ff       	jmp    80105fad <alltraps>

8010690f <vector130>:
.globl vector130
vector130:
  pushl $0
8010690f:	6a 00                	push   $0x0
  pushl $130
80106911:	68 82 00 00 00       	push   $0x82
  jmp alltraps
80106916:	e9 92 f6 ff ff       	jmp    80105fad <alltraps>

8010691b <vector131>:
.globl vector131
vector131:
  pushl $0
8010691b:	6a 00                	push   $0x0
  pushl $131
8010691d:	68 83 00 00 00       	push   $0x83
  jmp alltraps
80106922:	e9 86 f6 ff ff       	jmp    80105fad <alltraps>

80106927 <vector132>:
.globl vector132
vector132:
  pushl $0
80106927:	6a 00                	push   $0x0
  pushl $132
80106929:	68 84 00 00 00       	push   $0x84
  jmp alltraps
8010692e:	e9 7a f6 ff ff       	jmp    80105fad <alltraps>

80106933 <vector133>:
.globl vector133
vector133:
  pushl $0
80106933:	6a 00                	push   $0x0
  pushl $133
80106935:	68 85 00 00 00       	push   $0x85
  jmp alltraps
8010693a:	e9 6e f6 ff ff       	jmp    80105fad <alltraps>

8010693f <vector134>:
.globl vector134
vector134:
  pushl $0
8010693f:	6a 00                	push   $0x0
  pushl $134
80106941:	68 86 00 00 00       	push   $0x86
  jmp alltraps
80106946:	e9 62 f6 ff ff       	jmp    80105fad <alltraps>

8010694b <vector135>:
.globl vector135
vector135:
  pushl $0
8010694b:	6a 00                	push   $0x0
  pushl $135
8010694d:	68 87 00 00 00       	push   $0x87
  jmp alltraps
80106952:	e9 56 f6 ff ff       	jmp    80105fad <alltraps>

80106957 <vector136>:
.globl vector136
vector136:
  pushl $0
80106957:	6a 00                	push   $0x0
  pushl $136
80106959:	68 88 00 00 00       	push   $0x88
  jmp alltraps
8010695e:	e9 4a f6 ff ff       	jmp    80105fad <alltraps>

80106963 <vector137>:
.globl vector137
vector137:
  pushl $0
80106963:	6a 00                	push   $0x0
  pushl $137
80106965:	68 89 00 00 00       	push   $0x89
  jmp alltraps
8010696a:	e9 3e f6 ff ff       	jmp    80105fad <alltraps>

8010696f <vector138>:
.globl vector138
vector138:
  pushl $0
8010696f:	6a 00                	push   $0x0
  pushl $138
80106971:	68 8a 00 00 00       	push   $0x8a
  jmp alltraps
80106976:	e9 32 f6 ff ff       	jmp    80105fad <alltraps>

8010697b <vector139>:
.globl vector139
vector139:
  pushl $0
8010697b:	6a 00                	push   $0x0
  pushl $139
8010697d:	68 8b 00 00 00       	push   $0x8b
  jmp alltraps
80106982:	e9 26 f6 ff ff       	jmp    80105fad <alltraps>

80106987 <vector140>:
.globl vector140
vector140:
  pushl $0
80106987:	6a 00                	push   $0x0
  pushl $140
80106989:	68 8c 00 00 00       	push   $0x8c
  jmp alltraps
8010698e:	e9 1a f6 ff ff       	jmp    80105fad <alltraps>

80106993 <vector141>:
.globl vector141
vector141:
  pushl $0
80106993:	6a 00                	push   $0x0
  pushl $141
80106995:	68 8d 00 00 00       	push   $0x8d
  jmp alltraps
8010699a:	e9 0e f6 ff ff       	jmp    80105fad <alltraps>

8010699f <vector142>:
.globl vector142
vector142:
  pushl $0
8010699f:	6a 00                	push   $0x0
  pushl $142
801069a1:	68 8e 00 00 00       	push   $0x8e
  jmp alltraps
801069a6:	e9 02 f6 ff ff       	jmp    80105fad <alltraps>

801069ab <vector143>:
.globl vector143
vector143:
  pushl $0
801069ab:	6a 00                	push   $0x0
  pushl $143
801069ad:	68 8f 00 00 00       	push   $0x8f
  jmp alltraps
801069b2:	e9 f6 f5 ff ff       	jmp    80105fad <alltraps>

801069b7 <vector144>:
.globl vector144
vector144:
  pushl $0
801069b7:	6a 00                	push   $0x0
  pushl $144
801069b9:	68 90 00 00 00       	push   $0x90
  jmp alltraps
801069be:	e9 ea f5 ff ff       	jmp    80105fad <alltraps>

801069c3 <vector145>:
.globl vector145
vector145:
  pushl $0
801069c3:	6a 00                	push   $0x0
  pushl $145
801069c5:	68 91 00 00 00       	push   $0x91
  jmp alltraps
801069ca:	e9 de f5 ff ff       	jmp    80105fad <alltraps>

801069cf <vector146>:
.globl vector146
vector146:
  pushl $0
801069cf:	6a 00                	push   $0x0
  pushl $146
801069d1:	68 92 00 00 00       	push   $0x92
  jmp alltraps
801069d6:	e9 d2 f5 ff ff       	jmp    80105fad <alltraps>

801069db <vector147>:
.globl vector147
vector147:
  pushl $0
801069db:	6a 00                	push   $0x0
  pushl $147
801069dd:	68 93 00 00 00       	push   $0x93
  jmp alltraps
801069e2:	e9 c6 f5 ff ff       	jmp    80105fad <alltraps>

801069e7 <vector148>:
.globl vector148
vector148:
  pushl $0
801069e7:	6a 00                	push   $0x0
  pushl $148
801069e9:	68 94 00 00 00       	push   $0x94
  jmp alltraps
801069ee:	e9 ba f5 ff ff       	jmp    80105fad <alltraps>

801069f3 <vector149>:
.globl vector149
vector149:
  pushl $0
801069f3:	6a 00                	push   $0x0
  pushl $149
801069f5:	68 95 00 00 00       	push   $0x95
  jmp alltraps
801069fa:	e9 ae f5 ff ff       	jmp    80105fad <alltraps>

801069ff <vector150>:
.globl vector150
vector150:
  pushl $0
801069ff:	6a 00                	push   $0x0
  pushl $150
80106a01:	68 96 00 00 00       	push   $0x96
  jmp alltraps
80106a06:	e9 a2 f5 ff ff       	jmp    80105fad <alltraps>

80106a0b <vector151>:
.globl vector151
vector151:
  pushl $0
80106a0b:	6a 00                	push   $0x0
  pushl $151
80106a0d:	68 97 00 00 00       	push   $0x97
  jmp alltraps
80106a12:	e9 96 f5 ff ff       	jmp    80105fad <alltraps>

80106a17 <vector152>:
.globl vector152
vector152:
  pushl $0
80106a17:	6a 00                	push   $0x0
  pushl $152
80106a19:	68 98 00 00 00       	push   $0x98
  jmp alltraps
80106a1e:	e9 8a f5 ff ff       	jmp    80105fad <alltraps>

80106a23 <vector153>:
.globl vector153
vector153:
  pushl $0
80106a23:	6a 00                	push   $0x0
  pushl $153
80106a25:	68 99 00 00 00       	push   $0x99
  jmp alltraps
80106a2a:	e9 7e f5 ff ff       	jmp    80105fad <alltraps>

80106a2f <vector154>:
.globl vector154
vector154:
  pushl $0
80106a2f:	6a 00                	push   $0x0
  pushl $154
80106a31:	68 9a 00 00 00       	push   $0x9a
  jmp alltraps
80106a36:	e9 72 f5 ff ff       	jmp    80105fad <alltraps>

80106a3b <vector155>:
.globl vector155
vector155:
  pushl $0
80106a3b:	6a 00                	push   $0x0
  pushl $155
80106a3d:	68 9b 00 00 00       	push   $0x9b
  jmp alltraps
80106a42:	e9 66 f5 ff ff       	jmp    80105fad <alltraps>

80106a47 <vector156>:
.globl vector156
vector156:
  pushl $0
80106a47:	6a 00                	push   $0x0
  pushl $156
80106a49:	68 9c 00 00 00       	push   $0x9c
  jmp alltraps
80106a4e:	e9 5a f5 ff ff       	jmp    80105fad <alltraps>

80106a53 <vector157>:
.globl vector157
vector157:
  pushl $0
80106a53:	6a 00                	push   $0x0
  pushl $157
80106a55:	68 9d 00 00 00       	push   $0x9d
  jmp alltraps
80106a5a:	e9 4e f5 ff ff       	jmp    80105fad <alltraps>

80106a5f <vector158>:
.globl vector158
vector158:
  pushl $0
80106a5f:	6a 00                	push   $0x0
  pushl $158
80106a61:	68 9e 00 00 00       	push   $0x9e
  jmp alltraps
80106a66:	e9 42 f5 ff ff       	jmp    80105fad <alltraps>

80106a6b <vector159>:
.globl vector159
vector159:
  pushl $0
80106a6b:	6a 00                	push   $0x0
  pushl $159
80106a6d:	68 9f 00 00 00       	push   $0x9f
  jmp alltraps
80106a72:	e9 36 f5 ff ff       	jmp    80105fad <alltraps>

80106a77 <vector160>:
.globl vector160
vector160:
  pushl $0
80106a77:	6a 00                	push   $0x0
  pushl $160
80106a79:	68 a0 00 00 00       	push   $0xa0
  jmp alltraps
80106a7e:	e9 2a f5 ff ff       	jmp    80105fad <alltraps>

80106a83 <vector161>:
.globl vector161
vector161:
  pushl $0
80106a83:	6a 00                	push   $0x0
  pushl $161
80106a85:	68 a1 00 00 00       	push   $0xa1
  jmp alltraps
80106a8a:	e9 1e f5 ff ff       	jmp    80105fad <alltraps>

80106a8f <vector162>:
.globl vector162
vector162:
  pushl $0
80106a8f:	6a 00                	push   $0x0
  pushl $162
80106a91:	68 a2 00 00 00       	push   $0xa2
  jmp alltraps
80106a96:	e9 12 f5 ff ff       	jmp    80105fad <alltraps>

80106a9b <vector163>:
.globl vector163
vector163:
  pushl $0
80106a9b:	6a 00                	push   $0x0
  pushl $163
80106a9d:	68 a3 00 00 00       	push   $0xa3
  jmp alltraps
80106aa2:	e9 06 f5 ff ff       	jmp    80105fad <alltraps>

80106aa7 <vector164>:
.globl vector164
vector164:
  pushl $0
80106aa7:	6a 00                	push   $0x0
  pushl $164
80106aa9:	68 a4 00 00 00       	push   $0xa4
  jmp alltraps
80106aae:	e9 fa f4 ff ff       	jmp    80105fad <alltraps>

80106ab3 <vector165>:
.globl vector165
vector165:
  pushl $0
80106ab3:	6a 00                	push   $0x0
  pushl $165
80106ab5:	68 a5 00 00 00       	push   $0xa5
  jmp alltraps
80106aba:	e9 ee f4 ff ff       	jmp    80105fad <alltraps>

80106abf <vector166>:
.globl vector166
vector166:
  pushl $0
80106abf:	6a 00                	push   $0x0
  pushl $166
80106ac1:	68 a6 00 00 00       	push   $0xa6
  jmp alltraps
80106ac6:	e9 e2 f4 ff ff       	jmp    80105fad <alltraps>

80106acb <vector167>:
.globl vector167
vector167:
  pushl $0
80106acb:	6a 00                	push   $0x0
  pushl $167
80106acd:	68 a7 00 00 00       	push   $0xa7
  jmp alltraps
80106ad2:	e9 d6 f4 ff ff       	jmp    80105fad <alltraps>

80106ad7 <vector168>:
.globl vector168
vector168:
  pushl $0
80106ad7:	6a 00                	push   $0x0
  pushl $168
80106ad9:	68 a8 00 00 00       	push   $0xa8
  jmp alltraps
80106ade:	e9 ca f4 ff ff       	jmp    80105fad <alltraps>

80106ae3 <vector169>:
.globl vector169
vector169:
  pushl $0
80106ae3:	6a 00                	push   $0x0
  pushl $169
80106ae5:	68 a9 00 00 00       	push   $0xa9
  jmp alltraps
80106aea:	e9 be f4 ff ff       	jmp    80105fad <alltraps>

80106aef <vector170>:
.globl vector170
vector170:
  pushl $0
80106aef:	6a 00                	push   $0x0
  pushl $170
80106af1:	68 aa 00 00 00       	push   $0xaa
  jmp alltraps
80106af6:	e9 b2 f4 ff ff       	jmp    80105fad <alltraps>

80106afb <vector171>:
.globl vector171
vector171:
  pushl $0
80106afb:	6a 00                	push   $0x0
  pushl $171
80106afd:	68 ab 00 00 00       	push   $0xab
  jmp alltraps
80106b02:	e9 a6 f4 ff ff       	jmp    80105fad <alltraps>

80106b07 <vector172>:
.globl vector172
vector172:
  pushl $0
80106b07:	6a 00                	push   $0x0
  pushl $172
80106b09:	68 ac 00 00 00       	push   $0xac
  jmp alltraps
80106b0e:	e9 9a f4 ff ff       	jmp    80105fad <alltraps>

80106b13 <vector173>:
.globl vector173
vector173:
  pushl $0
80106b13:	6a 00                	push   $0x0
  pushl $173
80106b15:	68 ad 00 00 00       	push   $0xad
  jmp alltraps
80106b1a:	e9 8e f4 ff ff       	jmp    80105fad <alltraps>

80106b1f <vector174>:
.globl vector174
vector174:
  pushl $0
80106b1f:	6a 00                	push   $0x0
  pushl $174
80106b21:	68 ae 00 00 00       	push   $0xae
  jmp alltraps
80106b26:	e9 82 f4 ff ff       	jmp    80105fad <alltraps>

80106b2b <vector175>:
.globl vector175
vector175:
  pushl $0
80106b2b:	6a 00                	push   $0x0
  pushl $175
80106b2d:	68 af 00 00 00       	push   $0xaf
  jmp alltraps
80106b32:	e9 76 f4 ff ff       	jmp    80105fad <alltraps>

80106b37 <vector176>:
.globl vector176
vector176:
  pushl $0
80106b37:	6a 00                	push   $0x0
  pushl $176
80106b39:	68 b0 00 00 00       	push   $0xb0
  jmp alltraps
80106b3e:	e9 6a f4 ff ff       	jmp    80105fad <alltraps>

80106b43 <vector177>:
.globl vector177
vector177:
  pushl $0
80106b43:	6a 00                	push   $0x0
  pushl $177
80106b45:	68 b1 00 00 00       	push   $0xb1
  jmp alltraps
80106b4a:	e9 5e f4 ff ff       	jmp    80105fad <alltraps>

80106b4f <vector178>:
.globl vector178
vector178:
  pushl $0
80106b4f:	6a 00                	push   $0x0
  pushl $178
80106b51:	68 b2 00 00 00       	push   $0xb2
  jmp alltraps
80106b56:	e9 52 f4 ff ff       	jmp    80105fad <alltraps>

80106b5b <vector179>:
.globl vector179
vector179:
  pushl $0
80106b5b:	6a 00                	push   $0x0
  pushl $179
80106b5d:	68 b3 00 00 00       	push   $0xb3
  jmp alltraps
80106b62:	e9 46 f4 ff ff       	jmp    80105fad <alltraps>

80106b67 <vector180>:
.globl vector180
vector180:
  pushl $0
80106b67:	6a 00                	push   $0x0
  pushl $180
80106b69:	68 b4 00 00 00       	push   $0xb4
  jmp alltraps
80106b6e:	e9 3a f4 ff ff       	jmp    80105fad <alltraps>

80106b73 <vector181>:
.globl vector181
vector181:
  pushl $0
80106b73:	6a 00                	push   $0x0
  pushl $181
80106b75:	68 b5 00 00 00       	push   $0xb5
  jmp alltraps
80106b7a:	e9 2e f4 ff ff       	jmp    80105fad <alltraps>

80106b7f <vector182>:
.globl vector182
vector182:
  pushl $0
80106b7f:	6a 00                	push   $0x0
  pushl $182
80106b81:	68 b6 00 00 00       	push   $0xb6
  jmp alltraps
80106b86:	e9 22 f4 ff ff       	jmp    80105fad <alltraps>

80106b8b <vector183>:
.globl vector183
vector183:
  pushl $0
80106b8b:	6a 00                	push   $0x0
  pushl $183
80106b8d:	68 b7 00 00 00       	push   $0xb7
  jmp alltraps
80106b92:	e9 16 f4 ff ff       	jmp    80105fad <alltraps>

80106b97 <vector184>:
.globl vector184
vector184:
  pushl $0
80106b97:	6a 00                	push   $0x0
  pushl $184
80106b99:	68 b8 00 00 00       	push   $0xb8
  jmp alltraps
80106b9e:	e9 0a f4 ff ff       	jmp    80105fad <alltraps>

80106ba3 <vector185>:
.globl vector185
vector185:
  pushl $0
80106ba3:	6a 00                	push   $0x0
  pushl $185
80106ba5:	68 b9 00 00 00       	push   $0xb9
  jmp alltraps
80106baa:	e9 fe f3 ff ff       	jmp    80105fad <alltraps>

80106baf <vector186>:
.globl vector186
vector186:
  pushl $0
80106baf:	6a 00                	push   $0x0
  pushl $186
80106bb1:	68 ba 00 00 00       	push   $0xba
  jmp alltraps
80106bb6:	e9 f2 f3 ff ff       	jmp    80105fad <alltraps>

80106bbb <vector187>:
.globl vector187
vector187:
  pushl $0
80106bbb:	6a 00                	push   $0x0
  pushl $187
80106bbd:	68 bb 00 00 00       	push   $0xbb
  jmp alltraps
80106bc2:	e9 e6 f3 ff ff       	jmp    80105fad <alltraps>

80106bc7 <vector188>:
.globl vector188
vector188:
  pushl $0
80106bc7:	6a 00                	push   $0x0
  pushl $188
80106bc9:	68 bc 00 00 00       	push   $0xbc
  jmp alltraps
80106bce:	e9 da f3 ff ff       	jmp    80105fad <alltraps>

80106bd3 <vector189>:
.globl vector189
vector189:
  pushl $0
80106bd3:	6a 00                	push   $0x0
  pushl $189
80106bd5:	68 bd 00 00 00       	push   $0xbd
  jmp alltraps
80106bda:	e9 ce f3 ff ff       	jmp    80105fad <alltraps>

80106bdf <vector190>:
.globl vector190
vector190:
  pushl $0
80106bdf:	6a 00                	push   $0x0
  pushl $190
80106be1:	68 be 00 00 00       	push   $0xbe
  jmp alltraps
80106be6:	e9 c2 f3 ff ff       	jmp    80105fad <alltraps>

80106beb <vector191>:
.globl vector191
vector191:
  pushl $0
80106beb:	6a 00                	push   $0x0
  pushl $191
80106bed:	68 bf 00 00 00       	push   $0xbf
  jmp alltraps
80106bf2:	e9 b6 f3 ff ff       	jmp    80105fad <alltraps>

80106bf7 <vector192>:
.globl vector192
vector192:
  pushl $0
80106bf7:	6a 00                	push   $0x0
  pushl $192
80106bf9:	68 c0 00 00 00       	push   $0xc0
  jmp alltraps
80106bfe:	e9 aa f3 ff ff       	jmp    80105fad <alltraps>

80106c03 <vector193>:
.globl vector193
vector193:
  pushl $0
80106c03:	6a 00                	push   $0x0
  pushl $193
80106c05:	68 c1 00 00 00       	push   $0xc1
  jmp alltraps
80106c0a:	e9 9e f3 ff ff       	jmp    80105fad <alltraps>

80106c0f <vector194>:
.globl vector194
vector194:
  pushl $0
80106c0f:	6a 00                	push   $0x0
  pushl $194
80106c11:	68 c2 00 00 00       	push   $0xc2
  jmp alltraps
80106c16:	e9 92 f3 ff ff       	jmp    80105fad <alltraps>

80106c1b <vector195>:
.globl vector195
vector195:
  pushl $0
80106c1b:	6a 00                	push   $0x0
  pushl $195
80106c1d:	68 c3 00 00 00       	push   $0xc3
  jmp alltraps
80106c22:	e9 86 f3 ff ff       	jmp    80105fad <alltraps>

80106c27 <vector196>:
.globl vector196
vector196:
  pushl $0
80106c27:	6a 00                	push   $0x0
  pushl $196
80106c29:	68 c4 00 00 00       	push   $0xc4
  jmp alltraps
80106c2e:	e9 7a f3 ff ff       	jmp    80105fad <alltraps>

80106c33 <vector197>:
.globl vector197
vector197:
  pushl $0
80106c33:	6a 00                	push   $0x0
  pushl $197
80106c35:	68 c5 00 00 00       	push   $0xc5
  jmp alltraps
80106c3a:	e9 6e f3 ff ff       	jmp    80105fad <alltraps>

80106c3f <vector198>:
.globl vector198
vector198:
  pushl $0
80106c3f:	6a 00                	push   $0x0
  pushl $198
80106c41:	68 c6 00 00 00       	push   $0xc6
  jmp alltraps
80106c46:	e9 62 f3 ff ff       	jmp    80105fad <alltraps>

80106c4b <vector199>:
.globl vector199
vector199:
  pushl $0
80106c4b:	6a 00                	push   $0x0
  pushl $199
80106c4d:	68 c7 00 00 00       	push   $0xc7
  jmp alltraps
80106c52:	e9 56 f3 ff ff       	jmp    80105fad <alltraps>

80106c57 <vector200>:
.globl vector200
vector200:
  pushl $0
80106c57:	6a 00                	push   $0x0
  pushl $200
80106c59:	68 c8 00 00 00       	push   $0xc8
  jmp alltraps
80106c5e:	e9 4a f3 ff ff       	jmp    80105fad <alltraps>

80106c63 <vector201>:
.globl vector201
vector201:
  pushl $0
80106c63:	6a 00                	push   $0x0
  pushl $201
80106c65:	68 c9 00 00 00       	push   $0xc9
  jmp alltraps
80106c6a:	e9 3e f3 ff ff       	jmp    80105fad <alltraps>

80106c6f <vector202>:
.globl vector202
vector202:
  pushl $0
80106c6f:	6a 00                	push   $0x0
  pushl $202
80106c71:	68 ca 00 00 00       	push   $0xca
  jmp alltraps
80106c76:	e9 32 f3 ff ff       	jmp    80105fad <alltraps>

80106c7b <vector203>:
.globl vector203
vector203:
  pushl $0
80106c7b:	6a 00                	push   $0x0
  pushl $203
80106c7d:	68 cb 00 00 00       	push   $0xcb
  jmp alltraps
80106c82:	e9 26 f3 ff ff       	jmp    80105fad <alltraps>

80106c87 <vector204>:
.globl vector204
vector204:
  pushl $0
80106c87:	6a 00                	push   $0x0
  pushl $204
80106c89:	68 cc 00 00 00       	push   $0xcc
  jmp alltraps
80106c8e:	e9 1a f3 ff ff       	jmp    80105fad <alltraps>

80106c93 <vector205>:
.globl vector205
vector205:
  pushl $0
80106c93:	6a 00                	push   $0x0
  pushl $205
80106c95:	68 cd 00 00 00       	push   $0xcd
  jmp alltraps
80106c9a:	e9 0e f3 ff ff       	jmp    80105fad <alltraps>

80106c9f <vector206>:
.globl vector206
vector206:
  pushl $0
80106c9f:	6a 00                	push   $0x0
  pushl $206
80106ca1:	68 ce 00 00 00       	push   $0xce
  jmp alltraps
80106ca6:	e9 02 f3 ff ff       	jmp    80105fad <alltraps>

80106cab <vector207>:
.globl vector207
vector207:
  pushl $0
80106cab:	6a 00                	push   $0x0
  pushl $207
80106cad:	68 cf 00 00 00       	push   $0xcf
  jmp alltraps
80106cb2:	e9 f6 f2 ff ff       	jmp    80105fad <alltraps>

80106cb7 <vector208>:
.globl vector208
vector208:
  pushl $0
80106cb7:	6a 00                	push   $0x0
  pushl $208
80106cb9:	68 d0 00 00 00       	push   $0xd0
  jmp alltraps
80106cbe:	e9 ea f2 ff ff       	jmp    80105fad <alltraps>

80106cc3 <vector209>:
.globl vector209
vector209:
  pushl $0
80106cc3:	6a 00                	push   $0x0
  pushl $209
80106cc5:	68 d1 00 00 00       	push   $0xd1
  jmp alltraps
80106cca:	e9 de f2 ff ff       	jmp    80105fad <alltraps>

80106ccf <vector210>:
.globl vector210
vector210:
  pushl $0
80106ccf:	6a 00                	push   $0x0
  pushl $210
80106cd1:	68 d2 00 00 00       	push   $0xd2
  jmp alltraps
80106cd6:	e9 d2 f2 ff ff       	jmp    80105fad <alltraps>

80106cdb <vector211>:
.globl vector211
vector211:
  pushl $0
80106cdb:	6a 00                	push   $0x0
  pushl $211
80106cdd:	68 d3 00 00 00       	push   $0xd3
  jmp alltraps
80106ce2:	e9 c6 f2 ff ff       	jmp    80105fad <alltraps>

80106ce7 <vector212>:
.globl vector212
vector212:
  pushl $0
80106ce7:	6a 00                	push   $0x0
  pushl $212
80106ce9:	68 d4 00 00 00       	push   $0xd4
  jmp alltraps
80106cee:	e9 ba f2 ff ff       	jmp    80105fad <alltraps>

80106cf3 <vector213>:
.globl vector213
vector213:
  pushl $0
80106cf3:	6a 00                	push   $0x0
  pushl $213
80106cf5:	68 d5 00 00 00       	push   $0xd5
  jmp alltraps
80106cfa:	e9 ae f2 ff ff       	jmp    80105fad <alltraps>

80106cff <vector214>:
.globl vector214
vector214:
  pushl $0
80106cff:	6a 00                	push   $0x0
  pushl $214
80106d01:	68 d6 00 00 00       	push   $0xd6
  jmp alltraps
80106d06:	e9 a2 f2 ff ff       	jmp    80105fad <alltraps>

80106d0b <vector215>:
.globl vector215
vector215:
  pushl $0
80106d0b:	6a 00                	push   $0x0
  pushl $215
80106d0d:	68 d7 00 00 00       	push   $0xd7
  jmp alltraps
80106d12:	e9 96 f2 ff ff       	jmp    80105fad <alltraps>

80106d17 <vector216>:
.globl vector216
vector216:
  pushl $0
80106d17:	6a 00                	push   $0x0
  pushl $216
80106d19:	68 d8 00 00 00       	push   $0xd8
  jmp alltraps
80106d1e:	e9 8a f2 ff ff       	jmp    80105fad <alltraps>

80106d23 <vector217>:
.globl vector217
vector217:
  pushl $0
80106d23:	6a 00                	push   $0x0
  pushl $217
80106d25:	68 d9 00 00 00       	push   $0xd9
  jmp alltraps
80106d2a:	e9 7e f2 ff ff       	jmp    80105fad <alltraps>

80106d2f <vector218>:
.globl vector218
vector218:
  pushl $0
80106d2f:	6a 00                	push   $0x0
  pushl $218
80106d31:	68 da 00 00 00       	push   $0xda
  jmp alltraps
80106d36:	e9 72 f2 ff ff       	jmp    80105fad <alltraps>

80106d3b <vector219>:
.globl vector219
vector219:
  pushl $0
80106d3b:	6a 00                	push   $0x0
  pushl $219
80106d3d:	68 db 00 00 00       	push   $0xdb
  jmp alltraps
80106d42:	e9 66 f2 ff ff       	jmp    80105fad <alltraps>

80106d47 <vector220>:
.globl vector220
vector220:
  pushl $0
80106d47:	6a 00                	push   $0x0
  pushl $220
80106d49:	68 dc 00 00 00       	push   $0xdc
  jmp alltraps
80106d4e:	e9 5a f2 ff ff       	jmp    80105fad <alltraps>

80106d53 <vector221>:
.globl vector221
vector221:
  pushl $0
80106d53:	6a 00                	push   $0x0
  pushl $221
80106d55:	68 dd 00 00 00       	push   $0xdd
  jmp alltraps
80106d5a:	e9 4e f2 ff ff       	jmp    80105fad <alltraps>

80106d5f <vector222>:
.globl vector222
vector222:
  pushl $0
80106d5f:	6a 00                	push   $0x0
  pushl $222
80106d61:	68 de 00 00 00       	push   $0xde
  jmp alltraps
80106d66:	e9 42 f2 ff ff       	jmp    80105fad <alltraps>

80106d6b <vector223>:
.globl vector223
vector223:
  pushl $0
80106d6b:	6a 00                	push   $0x0
  pushl $223
80106d6d:	68 df 00 00 00       	push   $0xdf
  jmp alltraps
80106d72:	e9 36 f2 ff ff       	jmp    80105fad <alltraps>

80106d77 <vector224>:
.globl vector224
vector224:
  pushl $0
80106d77:	6a 00                	push   $0x0
  pushl $224
80106d79:	68 e0 00 00 00       	push   $0xe0
  jmp alltraps
80106d7e:	e9 2a f2 ff ff       	jmp    80105fad <alltraps>

80106d83 <vector225>:
.globl vector225
vector225:
  pushl $0
80106d83:	6a 00                	push   $0x0
  pushl $225
80106d85:	68 e1 00 00 00       	push   $0xe1
  jmp alltraps
80106d8a:	e9 1e f2 ff ff       	jmp    80105fad <alltraps>

80106d8f <vector226>:
.globl vector226
vector226:
  pushl $0
80106d8f:	6a 00                	push   $0x0
  pushl $226
80106d91:	68 e2 00 00 00       	push   $0xe2
  jmp alltraps
80106d96:	e9 12 f2 ff ff       	jmp    80105fad <alltraps>

80106d9b <vector227>:
.globl vector227
vector227:
  pushl $0
80106d9b:	6a 00                	push   $0x0
  pushl $227
80106d9d:	68 e3 00 00 00       	push   $0xe3
  jmp alltraps
80106da2:	e9 06 f2 ff ff       	jmp    80105fad <alltraps>

80106da7 <vector228>:
.globl vector228
vector228:
  pushl $0
80106da7:	6a 00                	push   $0x0
  pushl $228
80106da9:	68 e4 00 00 00       	push   $0xe4
  jmp alltraps
80106dae:	e9 fa f1 ff ff       	jmp    80105fad <alltraps>

80106db3 <vector229>:
.globl vector229
vector229:
  pushl $0
80106db3:	6a 00                	push   $0x0
  pushl $229
80106db5:	68 e5 00 00 00       	push   $0xe5
  jmp alltraps
80106dba:	e9 ee f1 ff ff       	jmp    80105fad <alltraps>

80106dbf <vector230>:
.globl vector230
vector230:
  pushl $0
80106dbf:	6a 00                	push   $0x0
  pushl $230
80106dc1:	68 e6 00 00 00       	push   $0xe6
  jmp alltraps
80106dc6:	e9 e2 f1 ff ff       	jmp    80105fad <alltraps>

80106dcb <vector231>:
.globl vector231
vector231:
  pushl $0
80106dcb:	6a 00                	push   $0x0
  pushl $231
80106dcd:	68 e7 00 00 00       	push   $0xe7
  jmp alltraps
80106dd2:	e9 d6 f1 ff ff       	jmp    80105fad <alltraps>

80106dd7 <vector232>:
.globl vector232
vector232:
  pushl $0
80106dd7:	6a 00                	push   $0x0
  pushl $232
80106dd9:	68 e8 00 00 00       	push   $0xe8
  jmp alltraps
80106dde:	e9 ca f1 ff ff       	jmp    80105fad <alltraps>

80106de3 <vector233>:
.globl vector233
vector233:
  pushl $0
80106de3:	6a 00                	push   $0x0
  pushl $233
80106de5:	68 e9 00 00 00       	push   $0xe9
  jmp alltraps
80106dea:	e9 be f1 ff ff       	jmp    80105fad <alltraps>

80106def <vector234>:
.globl vector234
vector234:
  pushl $0
80106def:	6a 00                	push   $0x0
  pushl $234
80106df1:	68 ea 00 00 00       	push   $0xea
  jmp alltraps
80106df6:	e9 b2 f1 ff ff       	jmp    80105fad <alltraps>

80106dfb <vector235>:
.globl vector235
vector235:
  pushl $0
80106dfb:	6a 00                	push   $0x0
  pushl $235
80106dfd:	68 eb 00 00 00       	push   $0xeb
  jmp alltraps
80106e02:	e9 a6 f1 ff ff       	jmp    80105fad <alltraps>

80106e07 <vector236>:
.globl vector236
vector236:
  pushl $0
80106e07:	6a 00                	push   $0x0
  pushl $236
80106e09:	68 ec 00 00 00       	push   $0xec
  jmp alltraps
80106e0e:	e9 9a f1 ff ff       	jmp    80105fad <alltraps>

80106e13 <vector237>:
.globl vector237
vector237:
  pushl $0
80106e13:	6a 00                	push   $0x0
  pushl $237
80106e15:	68 ed 00 00 00       	push   $0xed
  jmp alltraps
80106e1a:	e9 8e f1 ff ff       	jmp    80105fad <alltraps>

80106e1f <vector238>:
.globl vector238
vector238:
  pushl $0
80106e1f:	6a 00                	push   $0x0
  pushl $238
80106e21:	68 ee 00 00 00       	push   $0xee
  jmp alltraps
80106e26:	e9 82 f1 ff ff       	jmp    80105fad <alltraps>

80106e2b <vector239>:
.globl vector239
vector239:
  pushl $0
80106e2b:	6a 00                	push   $0x0
  pushl $239
80106e2d:	68 ef 00 00 00       	push   $0xef
  jmp alltraps
80106e32:	e9 76 f1 ff ff       	jmp    80105fad <alltraps>

80106e37 <vector240>:
.globl vector240
vector240:
  pushl $0
80106e37:	6a 00                	push   $0x0
  pushl $240
80106e39:	68 f0 00 00 00       	push   $0xf0
  jmp alltraps
80106e3e:	e9 6a f1 ff ff       	jmp    80105fad <alltraps>

80106e43 <vector241>:
.globl vector241
vector241:
  pushl $0
80106e43:	6a 00                	push   $0x0
  pushl $241
80106e45:	68 f1 00 00 00       	push   $0xf1
  jmp alltraps
80106e4a:	e9 5e f1 ff ff       	jmp    80105fad <alltraps>

80106e4f <vector242>:
.globl vector242
vector242:
  pushl $0
80106e4f:	6a 00                	push   $0x0
  pushl $242
80106e51:	68 f2 00 00 00       	push   $0xf2
  jmp alltraps
80106e56:	e9 52 f1 ff ff       	jmp    80105fad <alltraps>

80106e5b <vector243>:
.globl vector243
vector243:
  pushl $0
80106e5b:	6a 00                	push   $0x0
  pushl $243
80106e5d:	68 f3 00 00 00       	push   $0xf3
  jmp alltraps
80106e62:	e9 46 f1 ff ff       	jmp    80105fad <alltraps>

80106e67 <vector244>:
.globl vector244
vector244:
  pushl $0
80106e67:	6a 00                	push   $0x0
  pushl $244
80106e69:	68 f4 00 00 00       	push   $0xf4
  jmp alltraps
80106e6e:	e9 3a f1 ff ff       	jmp    80105fad <alltraps>

80106e73 <vector245>:
.globl vector245
vector245:
  pushl $0
80106e73:	6a 00                	push   $0x0
  pushl $245
80106e75:	68 f5 00 00 00       	push   $0xf5
  jmp alltraps
80106e7a:	e9 2e f1 ff ff       	jmp    80105fad <alltraps>

80106e7f <vector246>:
.globl vector246
vector246:
  pushl $0
80106e7f:	6a 00                	push   $0x0
  pushl $246
80106e81:	68 f6 00 00 00       	push   $0xf6
  jmp alltraps
80106e86:	e9 22 f1 ff ff       	jmp    80105fad <alltraps>

80106e8b <vector247>:
.globl vector247
vector247:
  pushl $0
80106e8b:	6a 00                	push   $0x0
  pushl $247
80106e8d:	68 f7 00 00 00       	push   $0xf7
  jmp alltraps
80106e92:	e9 16 f1 ff ff       	jmp    80105fad <alltraps>

80106e97 <vector248>:
.globl vector248
vector248:
  pushl $0
80106e97:	6a 00                	push   $0x0
  pushl $248
80106e99:	68 f8 00 00 00       	push   $0xf8
  jmp alltraps
80106e9e:	e9 0a f1 ff ff       	jmp    80105fad <alltraps>

80106ea3 <vector249>:
.globl vector249
vector249:
  pushl $0
80106ea3:	6a 00                	push   $0x0
  pushl $249
80106ea5:	68 f9 00 00 00       	push   $0xf9
  jmp alltraps
80106eaa:	e9 fe f0 ff ff       	jmp    80105fad <alltraps>

80106eaf <vector250>:
.globl vector250
vector250:
  pushl $0
80106eaf:	6a 00                	push   $0x0
  pushl $250
80106eb1:	68 fa 00 00 00       	push   $0xfa
  jmp alltraps
80106eb6:	e9 f2 f0 ff ff       	jmp    80105fad <alltraps>

80106ebb <vector251>:
.globl vector251
vector251:
  pushl $0
80106ebb:	6a 00                	push   $0x0
  pushl $251
80106ebd:	68 fb 00 00 00       	push   $0xfb
  jmp alltraps
80106ec2:	e9 e6 f0 ff ff       	jmp    80105fad <alltraps>

80106ec7 <vector252>:
.globl vector252
vector252:
  pushl $0
80106ec7:	6a 00                	push   $0x0
  pushl $252
80106ec9:	68 fc 00 00 00       	push   $0xfc
  jmp alltraps
80106ece:	e9 da f0 ff ff       	jmp    80105fad <alltraps>

80106ed3 <vector253>:
.globl vector253
vector253:
  pushl $0
80106ed3:	6a 00                	push   $0x0
  pushl $253
80106ed5:	68 fd 00 00 00       	push   $0xfd
  jmp alltraps
80106eda:	e9 ce f0 ff ff       	jmp    80105fad <alltraps>

80106edf <vector254>:
.globl vector254
vector254:
  pushl $0
80106edf:	6a 00                	push   $0x0
  pushl $254
80106ee1:	68 fe 00 00 00       	push   $0xfe
  jmp alltraps
80106ee6:	e9 c2 f0 ff ff       	jmp    80105fad <alltraps>

80106eeb <vector255>:
.globl vector255
vector255:
  pushl $0
80106eeb:	6a 00                	push   $0x0
  pushl $255
80106eed:	68 ff 00 00 00       	push   $0xff
  jmp alltraps
80106ef2:	e9 b6 f0 ff ff       	jmp    80105fad <alltraps>
80106ef7:	66 90                	xchg   %ax,%ax
80106ef9:	66 90                	xchg   %ax,%ax
80106efb:	66 90                	xchg   %ax,%ax
80106efd:	66 90                	xchg   %ax,%ax
80106eff:	90                   	nop

80106f00 <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80106f00:	55                   	push   %ebp
80106f01:	89 e5                	mov    %esp,%ebp
80106f03:	57                   	push   %edi
80106f04:	56                   	push   %esi
80106f05:	53                   	push   %ebx
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80106f06:	89 d3                	mov    %edx,%ebx
{
80106f08:	89 d7                	mov    %edx,%edi
  pde = &pgdir[PDX(va)];
80106f0a:	c1 eb 16             	shr    $0x16,%ebx
80106f0d:	8d 34 98             	lea    (%eax,%ebx,4),%esi
{
80106f10:	83 ec 0c             	sub    $0xc,%esp
  if(*pde & PTE_P){
80106f13:	8b 06                	mov    (%esi),%eax
80106f15:	a8 01                	test   $0x1,%al
80106f17:	74 27                	je     80106f40 <walkpgdir+0x40>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80106f19:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106f1e:	8d 98 00 00 00 80    	lea    -0x80000000(%eax),%ebx
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
  }
  return &pgtab[PTX(va)];
80106f24:	c1 ef 0a             	shr    $0xa,%edi
}
80106f27:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return &pgtab[PTX(va)];
80106f2a:	89 fa                	mov    %edi,%edx
80106f2c:	81 e2 fc 0f 00 00    	and    $0xffc,%edx
80106f32:	8d 04 13             	lea    (%ebx,%edx,1),%eax
}
80106f35:	5b                   	pop    %ebx
80106f36:	5e                   	pop    %esi
80106f37:	5f                   	pop    %edi
80106f38:	5d                   	pop    %ebp
80106f39:	c3                   	ret    
80106f3a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80106f40:	85 c9                	test   %ecx,%ecx
80106f42:	74 2c                	je     80106f70 <walkpgdir+0x70>
80106f44:	e8 97 b5 ff ff       	call   801024e0 <kalloc>
80106f49:	85 c0                	test   %eax,%eax
80106f4b:	89 c3                	mov    %eax,%ebx
80106f4d:	74 21                	je     80106f70 <walkpgdir+0x70>
    memset(pgtab, 0, PGSIZE);
80106f4f:	83 ec 04             	sub    $0x4,%esp
80106f52:	68 00 10 00 00       	push   $0x1000
80106f57:	6a 00                	push   $0x0
80106f59:	50                   	push   %eax
80106f5a:	e8 91 da ff ff       	call   801049f0 <memset>
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80106f5f:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
80106f65:	83 c4 10             	add    $0x10,%esp
80106f68:	83 c8 07             	or     $0x7,%eax
80106f6b:	89 06                	mov    %eax,(%esi)
80106f6d:	eb b5                	jmp    80106f24 <walkpgdir+0x24>
80106f6f:	90                   	nop
}
80106f70:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return 0;
80106f73:	31 c0                	xor    %eax,%eax
}
80106f75:	5b                   	pop    %ebx
80106f76:	5e                   	pop    %esi
80106f77:	5f                   	pop    %edi
80106f78:	5d                   	pop    %ebp
80106f79:	c3                   	ret    
80106f7a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80106f80 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80106f80:	55                   	push   %ebp
80106f81:	89 e5                	mov    %esp,%ebp
80106f83:	57                   	push   %edi
80106f84:	56                   	push   %esi
80106f85:	53                   	push   %ebx
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80106f86:	89 d3                	mov    %edx,%ebx
80106f88:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
{
80106f8e:	83 ec 1c             	sub    $0x1c,%esp
80106f91:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80106f94:	8d 44 0a ff          	lea    -0x1(%edx,%ecx,1),%eax
80106f98:	8b 7d 08             	mov    0x8(%ebp),%edi
80106f9b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80106fa0:	89 45 e0             	mov    %eax,-0x20(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
      return -1;
    if(*pte & PTE_P)
      panic("remap");
    *pte = pa | perm | PTE_P;
80106fa3:	8b 45 0c             	mov    0xc(%ebp),%eax
80106fa6:	29 df                	sub    %ebx,%edi
80106fa8:	83 c8 01             	or     $0x1,%eax
80106fab:	89 45 dc             	mov    %eax,-0x24(%ebp)
80106fae:	eb 15                	jmp    80106fc5 <mappages+0x45>
    if(*pte & PTE_P)
80106fb0:	f6 00 01             	testb  $0x1,(%eax)
80106fb3:	75 45                	jne    80106ffa <mappages+0x7a>
    *pte = pa | perm | PTE_P;
80106fb5:	0b 75 dc             	or     -0x24(%ebp),%esi
    if(a == last)
80106fb8:	3b 5d e0             	cmp    -0x20(%ebp),%ebx
    *pte = pa | perm | PTE_P;
80106fbb:	89 30                	mov    %esi,(%eax)
    if(a == last)
80106fbd:	74 31                	je     80106ff0 <mappages+0x70>
      break;
    a += PGSIZE;
80106fbf:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80106fc5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106fc8:	b9 01 00 00 00       	mov    $0x1,%ecx
80106fcd:	89 da                	mov    %ebx,%edx
80106fcf:	8d 34 3b             	lea    (%ebx,%edi,1),%esi
80106fd2:	e8 29 ff ff ff       	call   80106f00 <walkpgdir>
80106fd7:	85 c0                	test   %eax,%eax
80106fd9:	75 d5                	jne    80106fb0 <mappages+0x30>
    pa += PGSIZE;
  }
  return 0;
}
80106fdb:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80106fde:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106fe3:	5b                   	pop    %ebx
80106fe4:	5e                   	pop    %esi
80106fe5:	5f                   	pop    %edi
80106fe6:	5d                   	pop    %ebp
80106fe7:	c3                   	ret    
80106fe8:	90                   	nop
80106fe9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80106ff0:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80106ff3:	31 c0                	xor    %eax,%eax
}
80106ff5:	5b                   	pop    %ebx
80106ff6:	5e                   	pop    %esi
80106ff7:	5f                   	pop    %edi
80106ff8:	5d                   	pop    %ebp
80106ff9:	c3                   	ret    
      panic("remap");
80106ffa:	83 ec 0c             	sub    $0xc,%esp
80106ffd:	68 cc 87 10 80       	push   $0x801087cc
80107002:	e8 89 93 ff ff       	call   80100390 <panic>
80107007:	89 f6                	mov    %esi,%esi
80107009:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107010 <deallocuvm.part.0>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107010:	55                   	push   %ebp
80107011:	89 e5                	mov    %esp,%ebp
80107013:	57                   	push   %edi
80107014:	56                   	push   %esi
80107015:	53                   	push   %ebx
  uint a, pa;

  if(newsz >= oldsz)
    return oldsz;

  a = PGROUNDUP(newsz);
80107016:	8d 99 ff 0f 00 00    	lea    0xfff(%ecx),%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
8010701c:	89 c7                	mov    %eax,%edi
  a = PGROUNDUP(newsz);
8010701e:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
80107024:	83 ec 1c             	sub    $0x1c,%esp
80107027:	89 4d e0             	mov    %ecx,-0x20(%ebp)
  for(; a  < oldsz; a += PGSIZE){
8010702a:	39 d3                	cmp    %edx,%ebx
8010702c:	73 66                	jae    80107094 <deallocuvm.part.0+0x84>
8010702e:	89 d6                	mov    %edx,%esi
80107030:	eb 3d                	jmp    8010706f <deallocuvm.part.0+0x5f>
80107032:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    pte = walkpgdir(pgdir, (char*)a, 0);
    if(!pte)
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
    else if((*pte & PTE_P) != 0){
80107038:	8b 10                	mov    (%eax),%edx
8010703a:	f6 c2 01             	test   $0x1,%dl
8010703d:	74 26                	je     80107065 <deallocuvm.part.0+0x55>
      pa = PTE_ADDR(*pte);
      if(pa == 0)
8010703f:	81 e2 00 f0 ff ff    	and    $0xfffff000,%edx
80107045:	74 58                	je     8010709f <deallocuvm.part.0+0x8f>
        panic("kfree");
      char *v = P2V(pa);
      kfree(v);
80107047:	83 ec 0c             	sub    $0xc,%esp
      char *v = P2V(pa);
8010704a:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80107050:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      kfree(v);
80107053:	52                   	push   %edx
80107054:	e8 d7 b2 ff ff       	call   80102330 <kfree>
      *pte = 0;
80107059:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010705c:	83 c4 10             	add    $0x10,%esp
8010705f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
80107065:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010706b:	39 f3                	cmp    %esi,%ebx
8010706d:	73 25                	jae    80107094 <deallocuvm.part.0+0x84>
    pte = walkpgdir(pgdir, (char*)a, 0);
8010706f:	31 c9                	xor    %ecx,%ecx
80107071:	89 da                	mov    %ebx,%edx
80107073:	89 f8                	mov    %edi,%eax
80107075:	e8 86 fe ff ff       	call   80106f00 <walkpgdir>
    if(!pte)
8010707a:	85 c0                	test   %eax,%eax
8010707c:	75 ba                	jne    80107038 <deallocuvm.part.0+0x28>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
8010707e:	81 e3 00 00 c0 ff    	and    $0xffc00000,%ebx
80107084:	81 c3 00 f0 3f 00    	add    $0x3ff000,%ebx
  for(; a  < oldsz; a += PGSIZE){
8010708a:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107090:	39 f3                	cmp    %esi,%ebx
80107092:	72 db                	jb     8010706f <deallocuvm.part.0+0x5f>
    }
  }
  return newsz;
}
80107094:	8b 45 e0             	mov    -0x20(%ebp),%eax
80107097:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010709a:	5b                   	pop    %ebx
8010709b:	5e                   	pop    %esi
8010709c:	5f                   	pop    %edi
8010709d:	5d                   	pop    %ebp
8010709e:	c3                   	ret    
        panic("kfree");
8010709f:	83 ec 0c             	sub    $0xc,%esp
801070a2:	68 62 80 10 80       	push   $0x80108062
801070a7:	e8 e4 92 ff ff       	call   80100390 <panic>
801070ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

801070b0 <seginit>:
{
801070b0:	55                   	push   %ebp
801070b1:	89 e5                	mov    %esp,%ebp
801070b3:	83 ec 18             	sub    $0x18,%esp
  c = &cpus[cpuid()];
801070b6:	e8 b5 c7 ff ff       	call   80103870 <cpuid>
801070bb:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
  pd[0] = size-1;
801070c1:	ba 2f 00 00 00       	mov    $0x2f,%edx
801070c6:	66 89 55 f2          	mov    %dx,-0xe(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
801070ca:	c7 80 b8 89 11 80 ff 	movl   $0xffff,-0x7fee7648(%eax)
801070d1:	ff 00 00 
801070d4:	c7 80 bc 89 11 80 00 	movl   $0xcf9a00,-0x7fee7644(%eax)
801070db:	9a cf 00 
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801070de:	c7 80 c0 89 11 80 ff 	movl   $0xffff,-0x7fee7640(%eax)
801070e5:	ff 00 00 
801070e8:	c7 80 c4 89 11 80 00 	movl   $0xcf9200,-0x7fee763c(%eax)
801070ef:	92 cf 00 
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
801070f2:	c7 80 c8 89 11 80 ff 	movl   $0xffff,-0x7fee7638(%eax)
801070f9:	ff 00 00 
801070fc:	c7 80 cc 89 11 80 00 	movl   $0xcffa00,-0x7fee7634(%eax)
80107103:	fa cf 00 
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80107106:	c7 80 d0 89 11 80 ff 	movl   $0xffff,-0x7fee7630(%eax)
8010710d:	ff 00 00 
80107110:	c7 80 d4 89 11 80 00 	movl   $0xcff200,-0x7fee762c(%eax)
80107117:	f2 cf 00 
  lgdt(c->gdt, sizeof(c->gdt));
8010711a:	05 b0 89 11 80       	add    $0x801189b0,%eax
  pd[1] = (uint)p;
8010711f:	66 89 45 f4          	mov    %ax,-0xc(%ebp)
  pd[2] = (uint)p >> 16;
80107123:	c1 e8 10             	shr    $0x10,%eax
80107126:	66 89 45 f6          	mov    %ax,-0xa(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
8010712a:	8d 45 f2             	lea    -0xe(%ebp),%eax
8010712d:	0f 01 10             	lgdtl  (%eax)
}
80107130:	c9                   	leave  
80107131:	c3                   	ret    
80107132:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107140 <switchkvm>:
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107140:	a1 64 ff 12 80       	mov    0x8012ff64,%eax
{
80107145:	55                   	push   %ebp
80107146:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107148:	05 00 00 00 80       	add    $0x80000000,%eax
}

static inline void
lcr3(uint val)
{
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010714d:	0f 22 d8             	mov    %eax,%cr3
}
80107150:	5d                   	pop    %ebp
80107151:	c3                   	ret    
80107152:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107160 <switchuvm>:
{
80107160:	55                   	push   %ebp
80107161:	89 e5                	mov    %esp,%ebp
80107163:	57                   	push   %edi
80107164:	56                   	push   %esi
80107165:	53                   	push   %ebx
80107166:	83 ec 1c             	sub    $0x1c,%esp
80107169:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(p == 0)
8010716c:	85 db                	test   %ebx,%ebx
8010716e:	0f 84 cb 00 00 00    	je     8010723f <switchuvm+0xdf>
  if(p->kstack == 0)
80107174:	8b 43 08             	mov    0x8(%ebx),%eax
80107177:	85 c0                	test   %eax,%eax
80107179:	0f 84 da 00 00 00    	je     80107259 <switchuvm+0xf9>
  if(p->pgdir == 0)
8010717f:	8b 43 04             	mov    0x4(%ebx),%eax
80107182:	85 c0                	test   %eax,%eax
80107184:	0f 84 c2 00 00 00    	je     8010724c <switchuvm+0xec>
  pushcli();
8010718a:	e8 81 d6 ff ff       	call   80104810 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
8010718f:	e8 5c c6 ff ff       	call   801037f0 <mycpu>
80107194:	89 c6                	mov    %eax,%esi
80107196:	e8 55 c6 ff ff       	call   801037f0 <mycpu>
8010719b:	89 c7                	mov    %eax,%edi
8010719d:	e8 4e c6 ff ff       	call   801037f0 <mycpu>
801071a2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801071a5:	83 c7 08             	add    $0x8,%edi
801071a8:	e8 43 c6 ff ff       	call   801037f0 <mycpu>
801071ad:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
801071b0:	83 c0 08             	add    $0x8,%eax
801071b3:	ba 67 00 00 00       	mov    $0x67,%edx
801071b8:	c1 e8 18             	shr    $0x18,%eax
801071bb:	66 89 96 98 00 00 00 	mov    %dx,0x98(%esi)
801071c2:	66 89 be 9a 00 00 00 	mov    %di,0x9a(%esi)
801071c9:	88 86 9f 00 00 00    	mov    %al,0x9f(%esi)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
801071cf:	bf ff ff ff ff       	mov    $0xffffffff,%edi
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
801071d4:	83 c1 08             	add    $0x8,%ecx
801071d7:	c1 e9 10             	shr    $0x10,%ecx
801071da:	88 8e 9c 00 00 00    	mov    %cl,0x9c(%esi)
801071e0:	b9 99 40 00 00       	mov    $0x4099,%ecx
801071e5:	66 89 8e 9d 00 00 00 	mov    %cx,0x9d(%esi)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801071ec:	be 10 00 00 00       	mov    $0x10,%esi
  mycpu()->gdt[SEG_TSS].s = 0;
801071f1:	e8 fa c5 ff ff       	call   801037f0 <mycpu>
801071f6:	80 a0 9d 00 00 00 ef 	andb   $0xef,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
801071fd:	e8 ee c5 ff ff       	call   801037f0 <mycpu>
80107202:	66 89 70 10          	mov    %si,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80107206:	8b 73 08             	mov    0x8(%ebx),%esi
80107209:	e8 e2 c5 ff ff       	call   801037f0 <mycpu>
8010720e:	81 c6 00 10 00 00    	add    $0x1000,%esi
80107214:	89 70 0c             	mov    %esi,0xc(%eax)
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80107217:	e8 d4 c5 ff ff       	call   801037f0 <mycpu>
8010721c:	66 89 78 6e          	mov    %di,0x6e(%eax)
  asm volatile("ltr %0" : : "r" (sel));
80107220:	b8 28 00 00 00       	mov    $0x28,%eax
80107225:	0f 00 d8             	ltr    %ax
  lcr3(V2P(p->pgdir));  // switch to process's address space
80107228:	8b 43 04             	mov    0x4(%ebx),%eax
8010722b:	05 00 00 00 80       	add    $0x80000000,%eax
  asm volatile("movl %0,%%cr3" : : "r" (val));
80107230:	0f 22 d8             	mov    %eax,%cr3
}
80107233:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107236:	5b                   	pop    %ebx
80107237:	5e                   	pop    %esi
80107238:	5f                   	pop    %edi
80107239:	5d                   	pop    %ebp
  popcli();
8010723a:	e9 11 d6 ff ff       	jmp    80104850 <popcli>
    panic("switchuvm: no process");
8010723f:	83 ec 0c             	sub    $0xc,%esp
80107242:	68 d2 87 10 80       	push   $0x801087d2
80107247:	e8 44 91 ff ff       	call   80100390 <panic>
    panic("switchuvm: no pgdir");
8010724c:	83 ec 0c             	sub    $0xc,%esp
8010724f:	68 fd 87 10 80       	push   $0x801087fd
80107254:	e8 37 91 ff ff       	call   80100390 <panic>
    panic("switchuvm: no kstack");
80107259:	83 ec 0c             	sub    $0xc,%esp
8010725c:	68 e8 87 10 80       	push   $0x801087e8
80107261:	e8 2a 91 ff ff       	call   80100390 <panic>
80107266:	8d 76 00             	lea    0x0(%esi),%esi
80107269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107270 <inituvm>:
{
80107270:	55                   	push   %ebp
80107271:	89 e5                	mov    %esp,%ebp
80107273:	57                   	push   %edi
80107274:	56                   	push   %esi
80107275:	53                   	push   %ebx
80107276:	83 ec 1c             	sub    $0x1c,%esp
80107279:	8b 75 10             	mov    0x10(%ebp),%esi
8010727c:	8b 45 08             	mov    0x8(%ebp),%eax
8010727f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  if(sz >= PGSIZE)
80107282:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
{
80107288:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(sz >= PGSIZE)
8010728b:	77 49                	ja     801072d6 <inituvm+0x66>
  mem = kalloc();
8010728d:	e8 4e b2 ff ff       	call   801024e0 <kalloc>
  memset(mem, 0, PGSIZE);
80107292:	83 ec 04             	sub    $0x4,%esp
  mem = kalloc();
80107295:	89 c3                	mov    %eax,%ebx
  memset(mem, 0, PGSIZE);
80107297:	68 00 10 00 00       	push   $0x1000
8010729c:	6a 00                	push   $0x0
8010729e:	50                   	push   %eax
8010729f:	e8 4c d7 ff ff       	call   801049f0 <memset>
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
801072a4:	58                   	pop    %eax
801072a5:	8d 83 00 00 00 80    	lea    -0x80000000(%ebx),%eax
801072ab:	b9 00 10 00 00       	mov    $0x1000,%ecx
801072b0:	5a                   	pop    %edx
801072b1:	6a 06                	push   $0x6
801072b3:	50                   	push   %eax
801072b4:	31 d2                	xor    %edx,%edx
801072b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801072b9:	e8 c2 fc ff ff       	call   80106f80 <mappages>
  memmove(mem, init, sz);
801072be:	89 75 10             	mov    %esi,0x10(%ebp)
801072c1:	89 7d 0c             	mov    %edi,0xc(%ebp)
801072c4:	83 c4 10             	add    $0x10,%esp
801072c7:	89 5d 08             	mov    %ebx,0x8(%ebp)
}
801072ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
801072cd:	5b                   	pop    %ebx
801072ce:	5e                   	pop    %esi
801072cf:	5f                   	pop    %edi
801072d0:	5d                   	pop    %ebp
  memmove(mem, init, sz);
801072d1:	e9 ca d7 ff ff       	jmp    80104aa0 <memmove>
    panic("inituvm: more than a page");
801072d6:	83 ec 0c             	sub    $0xc,%esp
801072d9:	68 11 88 10 80       	push   $0x80108811
801072de:	e8 ad 90 ff ff       	call   80100390 <panic>
801072e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801072e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801072f0 <loaduvm>:
{
801072f0:	55                   	push   %ebp
801072f1:	89 e5                	mov    %esp,%ebp
801072f3:	57                   	push   %edi
801072f4:	56                   	push   %esi
801072f5:	53                   	push   %ebx
801072f6:	83 ec 0c             	sub    $0xc,%esp
  if((uint) addr % PGSIZE != 0)
801072f9:	f7 45 0c ff 0f 00 00 	testl  $0xfff,0xc(%ebp)
80107300:	0f 85 91 00 00 00    	jne    80107397 <loaduvm+0xa7>
  for(i = 0; i < sz; i += PGSIZE){
80107306:	8b 75 18             	mov    0x18(%ebp),%esi
80107309:	31 db                	xor    %ebx,%ebx
8010730b:	85 f6                	test   %esi,%esi
8010730d:	75 1a                	jne    80107329 <loaduvm+0x39>
8010730f:	eb 6f                	jmp    80107380 <loaduvm+0x90>
80107311:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107318:	81 c3 00 10 00 00    	add    $0x1000,%ebx
8010731e:	81 ee 00 10 00 00    	sub    $0x1000,%esi
80107324:	39 5d 18             	cmp    %ebx,0x18(%ebp)
80107327:	76 57                	jbe    80107380 <loaduvm+0x90>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
80107329:	8b 55 0c             	mov    0xc(%ebp),%edx
8010732c:	8b 45 08             	mov    0x8(%ebp),%eax
8010732f:	31 c9                	xor    %ecx,%ecx
80107331:	01 da                	add    %ebx,%edx
80107333:	e8 c8 fb ff ff       	call   80106f00 <walkpgdir>
80107338:	85 c0                	test   %eax,%eax
8010733a:	74 4e                	je     8010738a <loaduvm+0x9a>
    pa = PTE_ADDR(*pte);
8010733c:	8b 00                	mov    (%eax),%eax
    if(readi(ip, P2V(pa), offset+i, n) != n)
8010733e:	8b 4d 14             	mov    0x14(%ebp),%ecx
    if(sz - i < PGSIZE)
80107341:	bf 00 10 00 00       	mov    $0x1000,%edi
    pa = PTE_ADDR(*pte);
80107346:	25 00 f0 ff ff       	and    $0xfffff000,%eax
    if(sz - i < PGSIZE)
8010734b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
80107351:	0f 46 fe             	cmovbe %esi,%edi
    if(readi(ip, P2V(pa), offset+i, n) != n)
80107354:	01 d9                	add    %ebx,%ecx
80107356:	05 00 00 00 80       	add    $0x80000000,%eax
8010735b:	57                   	push   %edi
8010735c:	51                   	push   %ecx
8010735d:	50                   	push   %eax
8010735e:	ff 75 10             	pushl  0x10(%ebp)
80107361:	e8 0a a6 ff ff       	call   80101970 <readi>
80107366:	83 c4 10             	add    $0x10,%esp
80107369:	39 f8                	cmp    %edi,%eax
8010736b:	74 ab                	je     80107318 <loaduvm+0x28>
}
8010736d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107370:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80107375:	5b                   	pop    %ebx
80107376:	5e                   	pop    %esi
80107377:	5f                   	pop    %edi
80107378:	5d                   	pop    %ebp
80107379:	c3                   	ret    
8010737a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107380:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
80107383:	31 c0                	xor    %eax,%eax
}
80107385:	5b                   	pop    %ebx
80107386:	5e                   	pop    %esi
80107387:	5f                   	pop    %edi
80107388:	5d                   	pop    %ebp
80107389:	c3                   	ret    
      panic("loaduvm: address should exist");
8010738a:	83 ec 0c             	sub    $0xc,%esp
8010738d:	68 2b 88 10 80       	push   $0x8010882b
80107392:	e8 f9 8f ff ff       	call   80100390 <panic>
    panic("loaduvm: addr must be page aligned");
80107397:	83 ec 0c             	sub    $0xc,%esp
8010739a:	68 cc 88 10 80       	push   $0x801088cc
8010739f:	e8 ec 8f ff ff       	call   80100390 <panic>
801073a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
801073aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

801073b0 <allocuvm>:
{
801073b0:	55                   	push   %ebp
801073b1:	89 e5                	mov    %esp,%ebp
801073b3:	57                   	push   %edi
801073b4:	56                   	push   %esi
801073b5:	53                   	push   %ebx
801073b6:	83 ec 1c             	sub    $0x1c,%esp
  if(newsz >= KERNBASE)
801073b9:	8b 7d 10             	mov    0x10(%ebp),%edi
801073bc:	85 ff                	test   %edi,%edi
801073be:	0f 88 8e 00 00 00    	js     80107452 <allocuvm+0xa2>
  if(newsz < oldsz)
801073c4:	3b 7d 0c             	cmp    0xc(%ebp),%edi
801073c7:	0f 82 93 00 00 00    	jb     80107460 <allocuvm+0xb0>
  a = PGROUNDUP(oldsz);
801073cd:	8b 45 0c             	mov    0xc(%ebp),%eax
801073d0:	8d 98 ff 0f 00 00    	lea    0xfff(%eax),%ebx
801073d6:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
  for(; a < newsz; a += PGSIZE){
801073dc:	39 5d 10             	cmp    %ebx,0x10(%ebp)
801073df:	0f 86 7e 00 00 00    	jbe    80107463 <allocuvm+0xb3>
801073e5:	89 7d e4             	mov    %edi,-0x1c(%ebp)
801073e8:	8b 7d 08             	mov    0x8(%ebp),%edi
801073eb:	eb 42                	jmp    8010742f <allocuvm+0x7f>
801073ed:	8d 76 00             	lea    0x0(%esi),%esi
    memset(mem, 0, PGSIZE);
801073f0:	83 ec 04             	sub    $0x4,%esp
801073f3:	68 00 10 00 00       	push   $0x1000
801073f8:	6a 00                	push   $0x0
801073fa:	50                   	push   %eax
801073fb:	e8 f0 d5 ff ff       	call   801049f0 <memset>
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
80107400:	58                   	pop    %eax
80107401:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
80107407:	b9 00 10 00 00       	mov    $0x1000,%ecx
8010740c:	5a                   	pop    %edx
8010740d:	6a 06                	push   $0x6
8010740f:	50                   	push   %eax
80107410:	89 da                	mov    %ebx,%edx
80107412:	89 f8                	mov    %edi,%eax
80107414:	e8 67 fb ff ff       	call   80106f80 <mappages>
80107419:	83 c4 10             	add    $0x10,%esp
8010741c:	85 c0                	test   %eax,%eax
8010741e:	78 50                	js     80107470 <allocuvm+0xc0>
  for(; a < newsz; a += PGSIZE){
80107420:	81 c3 00 10 00 00    	add    $0x1000,%ebx
80107426:	39 5d 10             	cmp    %ebx,0x10(%ebp)
80107429:	0f 86 81 00 00 00    	jbe    801074b0 <allocuvm+0x100>
    mem = kalloc();
8010742f:	e8 ac b0 ff ff       	call   801024e0 <kalloc>
    if(mem == 0){
80107434:	85 c0                	test   %eax,%eax
    mem = kalloc();
80107436:	89 c6                	mov    %eax,%esi
    if(mem == 0){
80107438:	75 b6                	jne    801073f0 <allocuvm+0x40>
      cprintf("allocuvm out of memory\n");
8010743a:	83 ec 0c             	sub    $0xc,%esp
8010743d:	68 49 88 10 80       	push   $0x80108849
80107442:	e8 19 92 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
80107447:	83 c4 10             	add    $0x10,%esp
8010744a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010744d:	39 45 10             	cmp    %eax,0x10(%ebp)
80107450:	77 6e                	ja     801074c0 <allocuvm+0x110>
}
80107452:	8d 65 f4             	lea    -0xc(%ebp),%esp
    return 0;
80107455:	31 ff                	xor    %edi,%edi
}
80107457:	89 f8                	mov    %edi,%eax
80107459:	5b                   	pop    %ebx
8010745a:	5e                   	pop    %esi
8010745b:	5f                   	pop    %edi
8010745c:	5d                   	pop    %ebp
8010745d:	c3                   	ret    
8010745e:	66 90                	xchg   %ax,%ax
    return oldsz;
80107460:	8b 7d 0c             	mov    0xc(%ebp),%edi
}
80107463:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107466:	89 f8                	mov    %edi,%eax
80107468:	5b                   	pop    %ebx
80107469:	5e                   	pop    %esi
8010746a:	5f                   	pop    %edi
8010746b:	5d                   	pop    %ebp
8010746c:	c3                   	ret    
8010746d:	8d 76 00             	lea    0x0(%esi),%esi
      cprintf("allocuvm out of memory (2)\n");
80107470:	83 ec 0c             	sub    $0xc,%esp
80107473:	68 61 88 10 80       	push   $0x80108861
80107478:	e8 e3 91 ff ff       	call   80100660 <cprintf>
  if(newsz >= oldsz)
8010747d:	83 c4 10             	add    $0x10,%esp
80107480:	8b 45 0c             	mov    0xc(%ebp),%eax
80107483:	39 45 10             	cmp    %eax,0x10(%ebp)
80107486:	76 0d                	jbe    80107495 <allocuvm+0xe5>
80107488:	89 c1                	mov    %eax,%ecx
8010748a:	8b 55 10             	mov    0x10(%ebp),%edx
8010748d:	8b 45 08             	mov    0x8(%ebp),%eax
80107490:	e8 7b fb ff ff       	call   80107010 <deallocuvm.part.0>
      kfree(mem);
80107495:	83 ec 0c             	sub    $0xc,%esp
      return 0;
80107498:	31 ff                	xor    %edi,%edi
      kfree(mem);
8010749a:	56                   	push   %esi
8010749b:	e8 90 ae ff ff       	call   80102330 <kfree>
      return 0;
801074a0:	83 c4 10             	add    $0x10,%esp
}
801074a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074a6:	89 f8                	mov    %edi,%eax
801074a8:	5b                   	pop    %ebx
801074a9:	5e                   	pop    %esi
801074aa:	5f                   	pop    %edi
801074ab:	5d                   	pop    %ebp
801074ac:	c3                   	ret    
801074ad:	8d 76 00             	lea    0x0(%esi),%esi
801074b0:	8b 7d e4             	mov    -0x1c(%ebp),%edi
801074b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
801074b6:	5b                   	pop    %ebx
801074b7:	89 f8                	mov    %edi,%eax
801074b9:	5e                   	pop    %esi
801074ba:	5f                   	pop    %edi
801074bb:	5d                   	pop    %ebp
801074bc:	c3                   	ret    
801074bd:	8d 76 00             	lea    0x0(%esi),%esi
801074c0:	89 c1                	mov    %eax,%ecx
801074c2:	8b 55 10             	mov    0x10(%ebp),%edx
801074c5:	8b 45 08             	mov    0x8(%ebp),%eax
      return 0;
801074c8:	31 ff                	xor    %edi,%edi
801074ca:	e8 41 fb ff ff       	call   80107010 <deallocuvm.part.0>
801074cf:	eb 92                	jmp    80107463 <allocuvm+0xb3>
801074d1:	eb 0d                	jmp    801074e0 <deallocuvm>
801074d3:	90                   	nop
801074d4:	90                   	nop
801074d5:	90                   	nop
801074d6:	90                   	nop
801074d7:	90                   	nop
801074d8:	90                   	nop
801074d9:	90                   	nop
801074da:	90                   	nop
801074db:	90                   	nop
801074dc:	90                   	nop
801074dd:	90                   	nop
801074de:	90                   	nop
801074df:	90                   	nop

801074e0 <deallocuvm>:
{
801074e0:	55                   	push   %ebp
801074e1:	89 e5                	mov    %esp,%ebp
801074e3:	8b 55 0c             	mov    0xc(%ebp),%edx
801074e6:	8b 4d 10             	mov    0x10(%ebp),%ecx
801074e9:	8b 45 08             	mov    0x8(%ebp),%eax
  if(newsz >= oldsz)
801074ec:	39 d1                	cmp    %edx,%ecx
801074ee:	73 10                	jae    80107500 <deallocuvm+0x20>
}
801074f0:	5d                   	pop    %ebp
801074f1:	e9 1a fb ff ff       	jmp    80107010 <deallocuvm.part.0>
801074f6:	8d 76 00             	lea    0x0(%esi),%esi
801074f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107500:	89 d0                	mov    %edx,%eax
80107502:	5d                   	pop    %ebp
80107503:	c3                   	ret    
80107504:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
8010750a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

80107510 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80107510:	55                   	push   %ebp
80107511:	89 e5                	mov    %esp,%ebp
80107513:	57                   	push   %edi
80107514:	56                   	push   %esi
80107515:	53                   	push   %ebx
80107516:	83 ec 0c             	sub    $0xc,%esp
80107519:	8b 75 08             	mov    0x8(%ebp),%esi
  uint i;

  if(pgdir == 0)
8010751c:	85 f6                	test   %esi,%esi
8010751e:	74 59                	je     80107579 <freevm+0x69>
80107520:	31 c9                	xor    %ecx,%ecx
80107522:	ba 00 00 00 80       	mov    $0x80000000,%edx
80107527:	89 f0                	mov    %esi,%eax
80107529:	e8 e2 fa ff ff       	call   80107010 <deallocuvm.part.0>
8010752e:	89 f3                	mov    %esi,%ebx
80107530:	8d be 00 10 00 00    	lea    0x1000(%esi),%edi
80107536:	eb 0f                	jmp    80107547 <freevm+0x37>
80107538:	90                   	nop
80107539:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107540:	83 c3 04             	add    $0x4,%ebx
    panic("freevm: no pgdir");
  deallocuvm(pgdir, KERNBASE, 0);
  for(i = 0; i < NPDENTRIES; i++){
80107543:	39 fb                	cmp    %edi,%ebx
80107545:	74 23                	je     8010756a <freevm+0x5a>
    if(pgdir[i] & PTE_P){
80107547:	8b 03                	mov    (%ebx),%eax
80107549:	a8 01                	test   $0x1,%al
8010754b:	74 f3                	je     80107540 <freevm+0x30>
      char * v = P2V(PTE_ADDR(pgdir[i]));
8010754d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
      kfree(v);
80107552:	83 ec 0c             	sub    $0xc,%esp
80107555:	83 c3 04             	add    $0x4,%ebx
      char * v = P2V(PTE_ADDR(pgdir[i]));
80107558:	05 00 00 00 80       	add    $0x80000000,%eax
      kfree(v);
8010755d:	50                   	push   %eax
8010755e:	e8 cd ad ff ff       	call   80102330 <kfree>
80107563:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
80107566:	39 fb                	cmp    %edi,%ebx
80107568:	75 dd                	jne    80107547 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
8010756a:	89 75 08             	mov    %esi,0x8(%ebp)
}
8010756d:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107570:	5b                   	pop    %ebx
80107571:	5e                   	pop    %esi
80107572:	5f                   	pop    %edi
80107573:	5d                   	pop    %ebp
  kfree((char*)pgdir);
80107574:	e9 b7 ad ff ff       	jmp    80102330 <kfree>
    panic("freevm: no pgdir");
80107579:	83 ec 0c             	sub    $0xc,%esp
8010757c:	68 7d 88 10 80       	push   $0x8010887d
80107581:	e8 0a 8e ff ff       	call   80100390 <panic>
80107586:	8d 76 00             	lea    0x0(%esi),%esi
80107589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107590 <setupkvm>:
{
80107590:	55                   	push   %ebp
80107591:	89 e5                	mov    %esp,%ebp
80107593:	56                   	push   %esi
80107594:	53                   	push   %ebx
  if((pgdir = (pde_t*)kalloc()) == 0)
80107595:	e8 46 af ff ff       	call   801024e0 <kalloc>
8010759a:	85 c0                	test   %eax,%eax
8010759c:	89 c6                	mov    %eax,%esi
8010759e:	74 42                	je     801075e2 <setupkvm+0x52>
  memset(pgdir, 0, PGSIZE);
801075a0:	83 ec 04             	sub    $0x4,%esp
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801075a3:	bb e0 b6 10 80       	mov    $0x8010b6e0,%ebx
  memset(pgdir, 0, PGSIZE);
801075a8:	68 00 10 00 00       	push   $0x1000
801075ad:	6a 00                	push   $0x0
801075af:	50                   	push   %eax
801075b0:	e8 3b d4 ff ff       	call   801049f0 <memset>
801075b5:	83 c4 10             	add    $0x10,%esp
                (uint)k->phys_start, k->perm) < 0) {
801075b8:	8b 43 04             	mov    0x4(%ebx),%eax
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
801075bb:	8b 4b 08             	mov    0x8(%ebx),%ecx
801075be:	83 ec 08             	sub    $0x8,%esp
801075c1:	8b 13                	mov    (%ebx),%edx
801075c3:	ff 73 0c             	pushl  0xc(%ebx)
801075c6:	50                   	push   %eax
801075c7:	29 c1                	sub    %eax,%ecx
801075c9:	89 f0                	mov    %esi,%eax
801075cb:	e8 b0 f9 ff ff       	call   80106f80 <mappages>
801075d0:	83 c4 10             	add    $0x10,%esp
801075d3:	85 c0                	test   %eax,%eax
801075d5:	78 19                	js     801075f0 <setupkvm+0x60>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
801075d7:	83 c3 10             	add    $0x10,%ebx
801075da:	81 fb 20 b7 10 80    	cmp    $0x8010b720,%ebx
801075e0:	75 d6                	jne    801075b8 <setupkvm+0x28>
}
801075e2:	8d 65 f8             	lea    -0x8(%ebp),%esp
801075e5:	89 f0                	mov    %esi,%eax
801075e7:	5b                   	pop    %ebx
801075e8:	5e                   	pop    %esi
801075e9:	5d                   	pop    %ebp
801075ea:	c3                   	ret    
801075eb:	90                   	nop
801075ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      freevm(pgdir);
801075f0:	83 ec 0c             	sub    $0xc,%esp
801075f3:	56                   	push   %esi
      return 0;
801075f4:	31 f6                	xor    %esi,%esi
      freevm(pgdir);
801075f6:	e8 15 ff ff ff       	call   80107510 <freevm>
      return 0;
801075fb:	83 c4 10             	add    $0x10,%esp
}
801075fe:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107601:	89 f0                	mov    %esi,%eax
80107603:	5b                   	pop    %ebx
80107604:	5e                   	pop    %esi
80107605:	5d                   	pop    %ebp
80107606:	c3                   	ret    
80107607:	89 f6                	mov    %esi,%esi
80107609:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107610 <kvmalloc>:
{
80107610:	55                   	push   %ebp
80107611:	89 e5                	mov    %esp,%ebp
80107613:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80107616:	e8 75 ff ff ff       	call   80107590 <setupkvm>
8010761b:	a3 64 ff 12 80       	mov    %eax,0x8012ff64
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80107620:	05 00 00 00 80       	add    $0x80000000,%eax
80107625:	0f 22 d8             	mov    %eax,%cr3
}
80107628:	c9                   	leave  
80107629:	c3                   	ret    
8010762a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107630 <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
80107630:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107631:	31 c9                	xor    %ecx,%ecx
{
80107633:	89 e5                	mov    %esp,%ebp
80107635:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107638:	8b 55 0c             	mov    0xc(%ebp),%edx
8010763b:	8b 45 08             	mov    0x8(%ebp),%eax
8010763e:	e8 bd f8 ff ff       	call   80106f00 <walkpgdir>
  if(pte == 0)
80107643:	85 c0                	test   %eax,%eax
80107645:	74 05                	je     8010764c <clearpteu+0x1c>
    panic("clearpteu");
  *pte &= ~PTE_U;
80107647:	83 20 fb             	andl   $0xfffffffb,(%eax)
}
8010764a:	c9                   	leave  
8010764b:	c3                   	ret    
    panic("clearpteu");
8010764c:	83 ec 0c             	sub    $0xc,%esp
8010764f:	68 8e 88 10 80       	push   $0x8010888e
80107654:	e8 37 8d ff ff       	call   80100390 <panic>
80107659:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

80107660 <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
80107660:	55                   	push   %ebp
80107661:	89 e5                	mov    %esp,%ebp
80107663:	57                   	push   %edi
80107664:	56                   	push   %esi
80107665:	53                   	push   %ebx
80107666:	83 ec 1c             	sub    $0x1c,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
80107669:	e8 22 ff ff ff       	call   80107590 <setupkvm>
8010766e:	85 c0                	test   %eax,%eax
80107670:	89 45 e0             	mov    %eax,-0x20(%ebp)
80107673:	0f 84 9f 00 00 00    	je     80107718 <copyuvm+0xb8>
    return 0;
  for(i = 0; i < sz; i += PGSIZE){
80107679:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010767c:	85 c9                	test   %ecx,%ecx
8010767e:	0f 84 94 00 00 00    	je     80107718 <copyuvm+0xb8>
80107684:	31 ff                	xor    %edi,%edi
80107686:	eb 4a                	jmp    801076d2 <copyuvm+0x72>
80107688:	90                   	nop
80107689:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      panic("copyuvm: page not present");
    pa = PTE_ADDR(*pte);
    flags = PTE_FLAGS(*pte);
    if((mem = kalloc()) == 0)
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80107690:	83 ec 04             	sub    $0x4,%esp
80107693:	81 c3 00 00 00 80    	add    $0x80000000,%ebx
80107699:	68 00 10 00 00       	push   $0x1000
8010769e:	53                   	push   %ebx
8010769f:	50                   	push   %eax
801076a0:	e8 fb d3 ff ff       	call   80104aa0 <memmove>
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
801076a5:	58                   	pop    %eax
801076a6:	8d 86 00 00 00 80    	lea    -0x80000000(%esi),%eax
801076ac:	b9 00 10 00 00       	mov    $0x1000,%ecx
801076b1:	5a                   	pop    %edx
801076b2:	ff 75 e4             	pushl  -0x1c(%ebp)
801076b5:	50                   	push   %eax
801076b6:	89 fa                	mov    %edi,%edx
801076b8:	8b 45 e0             	mov    -0x20(%ebp),%eax
801076bb:	e8 c0 f8 ff ff       	call   80106f80 <mappages>
801076c0:	83 c4 10             	add    $0x10,%esp
801076c3:	85 c0                	test   %eax,%eax
801076c5:	78 61                	js     80107728 <copyuvm+0xc8>
  for(i = 0; i < sz; i += PGSIZE){
801076c7:	81 c7 00 10 00 00    	add    $0x1000,%edi
801076cd:	39 7d 0c             	cmp    %edi,0xc(%ebp)
801076d0:	76 46                	jbe    80107718 <copyuvm+0xb8>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
801076d2:	8b 45 08             	mov    0x8(%ebp),%eax
801076d5:	31 c9                	xor    %ecx,%ecx
801076d7:	89 fa                	mov    %edi,%edx
801076d9:	e8 22 f8 ff ff       	call   80106f00 <walkpgdir>
801076de:	85 c0                	test   %eax,%eax
801076e0:	74 61                	je     80107743 <copyuvm+0xe3>
    if(!(*pte & PTE_P))
801076e2:	8b 00                	mov    (%eax),%eax
801076e4:	a8 01                	test   $0x1,%al
801076e6:	74 4e                	je     80107736 <copyuvm+0xd6>
    pa = PTE_ADDR(*pte);
801076e8:	89 c3                	mov    %eax,%ebx
    flags = PTE_FLAGS(*pte);
801076ea:	25 ff 0f 00 00       	and    $0xfff,%eax
    pa = PTE_ADDR(*pte);
801076ef:	81 e3 00 f0 ff ff    	and    $0xfffff000,%ebx
    flags = PTE_FLAGS(*pte);
801076f5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
801076f8:	e8 e3 ad ff ff       	call   801024e0 <kalloc>
801076fd:	85 c0                	test   %eax,%eax
801076ff:	89 c6                	mov    %eax,%esi
80107701:	75 8d                	jne    80107690 <copyuvm+0x30>
    }
  }
  return d;

bad:
  freevm(d);
80107703:	83 ec 0c             	sub    $0xc,%esp
80107706:	ff 75 e0             	pushl  -0x20(%ebp)
80107709:	e8 02 fe ff ff       	call   80107510 <freevm>
  return 0;
8010770e:	83 c4 10             	add    $0x10,%esp
80107711:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
}
80107718:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010771b:	8d 65 f4             	lea    -0xc(%ebp),%esp
8010771e:	5b                   	pop    %ebx
8010771f:	5e                   	pop    %esi
80107720:	5f                   	pop    %edi
80107721:	5d                   	pop    %ebp
80107722:	c3                   	ret    
80107723:	90                   	nop
80107724:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
      kfree(mem);
80107728:	83 ec 0c             	sub    $0xc,%esp
8010772b:	56                   	push   %esi
8010772c:	e8 ff ab ff ff       	call   80102330 <kfree>
      goto bad;
80107731:	83 c4 10             	add    $0x10,%esp
80107734:	eb cd                	jmp    80107703 <copyuvm+0xa3>
      panic("copyuvm: page not present");
80107736:	83 ec 0c             	sub    $0xc,%esp
80107739:	68 b2 88 10 80       	push   $0x801088b2
8010773e:	e8 4d 8c ff ff       	call   80100390 <panic>
      panic("copyuvm: pte should exist");
80107743:	83 ec 0c             	sub    $0xc,%esp
80107746:	68 98 88 10 80       	push   $0x80108898
8010774b:	e8 40 8c ff ff       	call   80100390 <panic>

80107750 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80107750:	55                   	push   %ebp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80107751:	31 c9                	xor    %ecx,%ecx
{
80107753:	89 e5                	mov    %esp,%ebp
80107755:	83 ec 08             	sub    $0x8,%esp
  pte = walkpgdir(pgdir, uva, 0);
80107758:	8b 55 0c             	mov    0xc(%ebp),%edx
8010775b:	8b 45 08             	mov    0x8(%ebp),%eax
8010775e:	e8 9d f7 ff ff       	call   80106f00 <walkpgdir>
  if((*pte & PTE_P) == 0)
80107763:	8b 00                	mov    (%eax),%eax
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  return (char*)P2V(PTE_ADDR(*pte));
}
80107765:	c9                   	leave  
  if((*pte & PTE_U) == 0)
80107766:	89 c2                	mov    %eax,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107768:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  if((*pte & PTE_U) == 0)
8010776d:	83 e2 05             	and    $0x5,%edx
  return (char*)P2V(PTE_ADDR(*pte));
80107770:	05 00 00 00 80       	add    $0x80000000,%eax
80107775:	83 fa 05             	cmp    $0x5,%edx
80107778:	ba 00 00 00 00       	mov    $0x0,%edx
8010777d:	0f 45 c2             	cmovne %edx,%eax
}
80107780:	c3                   	ret    
80107781:	eb 0d                	jmp    80107790 <copyout>
80107783:	90                   	nop
80107784:	90                   	nop
80107785:	90                   	nop
80107786:	90                   	nop
80107787:	90                   	nop
80107788:	90                   	nop
80107789:	90                   	nop
8010778a:	90                   	nop
8010778b:	90                   	nop
8010778c:	90                   	nop
8010778d:	90                   	nop
8010778e:	90                   	nop
8010778f:	90                   	nop

80107790 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80107790:	55                   	push   %ebp
80107791:	89 e5                	mov    %esp,%ebp
80107793:	57                   	push   %edi
80107794:	56                   	push   %esi
80107795:	53                   	push   %ebx
80107796:	83 ec 1c             	sub    $0x1c,%esp
80107799:	8b 5d 14             	mov    0x14(%ebp),%ebx
8010779c:	8b 55 0c             	mov    0xc(%ebp),%edx
8010779f:	8b 7d 10             	mov    0x10(%ebp),%edi
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
  while(len > 0){
801077a2:	85 db                	test   %ebx,%ebx
801077a4:	75 40                	jne    801077e6 <copyout+0x56>
801077a6:	eb 70                	jmp    80107818 <copyout+0x88>
801077a8:	90                   	nop
801077a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    va0 = (uint)PGROUNDDOWN(va);
    pa0 = uva2ka(pgdir, (char*)va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (va - va0);
801077b0:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801077b3:	89 f1                	mov    %esi,%ecx
801077b5:	29 d1                	sub    %edx,%ecx
801077b7:	81 c1 00 10 00 00    	add    $0x1000,%ecx
801077bd:	39 d9                	cmp    %ebx,%ecx
801077bf:	0f 47 cb             	cmova  %ebx,%ecx
    if(n > len)
      n = len;
    memmove(pa0 + (va - va0), buf, n);
801077c2:	29 f2                	sub    %esi,%edx
801077c4:	83 ec 04             	sub    $0x4,%esp
801077c7:	01 d0                	add    %edx,%eax
801077c9:	51                   	push   %ecx
801077ca:	57                   	push   %edi
801077cb:	50                   	push   %eax
801077cc:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
801077cf:	e8 cc d2 ff ff       	call   80104aa0 <memmove>
    len -= n;
    buf += n;
801077d4:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
  while(len > 0){
801077d7:	83 c4 10             	add    $0x10,%esp
    va = va0 + PGSIZE;
801077da:	8d 96 00 10 00 00    	lea    0x1000(%esi),%edx
    buf += n;
801077e0:	01 cf                	add    %ecx,%edi
  while(len > 0){
801077e2:	29 cb                	sub    %ecx,%ebx
801077e4:	74 32                	je     80107818 <copyout+0x88>
    va0 = (uint)PGROUNDDOWN(va);
801077e6:	89 d6                	mov    %edx,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801077e8:	83 ec 08             	sub    $0x8,%esp
    va0 = (uint)PGROUNDDOWN(va);
801077eb:	89 55 e4             	mov    %edx,-0x1c(%ebp)
801077ee:	81 e6 00 f0 ff ff    	and    $0xfffff000,%esi
    pa0 = uva2ka(pgdir, (char*)va0);
801077f4:	56                   	push   %esi
801077f5:	ff 75 08             	pushl  0x8(%ebp)
801077f8:	e8 53 ff ff ff       	call   80107750 <uva2ka>
    if(pa0 == 0)
801077fd:	83 c4 10             	add    $0x10,%esp
80107800:	85 c0                	test   %eax,%eax
80107802:	75 ac                	jne    801077b0 <copyout+0x20>
  }
  return 0;
}
80107804:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return -1;
80107807:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010780c:	5b                   	pop    %ebx
8010780d:	5e                   	pop    %esi
8010780e:	5f                   	pop    %edi
8010780f:	5d                   	pop    %ebp
80107810:	c3                   	ret    
80107811:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107818:	8d 65 f4             	lea    -0xc(%ebp),%esp
  return 0;
8010781b:	31 c0                	xor    %eax,%eax
}
8010781d:	5b                   	pop    %ebx
8010781e:	5e                   	pop    %esi
8010781f:	5f                   	pop    %edi
80107820:	5d                   	pop    %ebp
80107821:	c3                   	ret    
80107822:	66 90                	xchg   %ax,%ax
80107824:	66 90                	xchg   %ax,%ax
80107826:	66 90                	xchg   %ax,%ax
80107828:	66 90                	xchg   %ax,%ax
8010782a:	66 90                	xchg   %ax,%ax
8010782c:	66 90                	xchg   %ax,%ax
8010782e:	66 90                	xchg   %ax,%ax

80107830 <GetMessageBuffer>:
//   char * buffer;
// };

// Queue<WaitQueueItem *> *wait_queue[NUMOFMESSAGEQUEUES];

int GetMessageBuffer( void ) { 
80107830:	55                   	push   %ebp
80107831:	89 e5                	mov    %esp,%ebp
80107833:	56                   	push   %esi
80107834:	53                   	push   %ebx
  // get the head of the free list
  acquire(&free_message_buffer_lock);
80107835:	83 ec 0c             	sub    $0xc,%esp
80107838:	68 80 ff 12 80       	push   $0x8012ff80
8010783d:	e8 9e d0 ff ff       	call   801048e0 <acquire>
  int msg_no = free_message_buffer;
80107842:	8b 35 a0 05 17 80    	mov    0x801705a0,%esi
  acquire(&message_buffer_lock[msg_no]);
80107848:	6b de 34             	imul   $0x34,%esi,%ebx
8010784b:	81 c3 c0 0c 13 80    	add    $0x80130cc0,%ebx
80107851:	89 1c 24             	mov    %ebx,(%esp)
80107854:	e8 87 d0 ff ff       	call   801048e0 <acquire>
  if( msg_no != -1 ) {
80107859:	83 c4 10             	add    $0x10,%esp
8010785c:	83 fe ff             	cmp    $0xffffffff,%esi
8010785f:	74 10                	je     80107871 <GetMessageBuffer+0x41>
    // follow the link to the next buffer
    free_message_buffer = message_buffer[msg_no][0];
80107861:	89 f0                	mov    %esi,%eax
80107863:	c1 e0 06             	shl    $0x6,%eax
80107866:	8b 80 c0 05 17 80    	mov    -0x7fe8fa40(%eax),%eax
8010786c:	a3 a0 05 17 80       	mov    %eax,0x801705a0
  }
  release(&message_buffer_lock[msg_no]);
80107871:	83 ec 0c             	sub    $0xc,%esp
80107874:	53                   	push   %ebx
80107875:	e8 26 d1 ff ff       	call   801049a0 <release>
  release(&free_message_buffer_lock);
8010787a:	c7 04 24 80 ff 12 80 	movl   $0x8012ff80,(%esp)
80107881:	e8 1a d1 ff ff       	call   801049a0 <release>
  return msg_no;
}
80107886:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107889:	89 f0                	mov    %esi,%eax
8010788b:	5b                   	pop    %ebx
8010788c:	5e                   	pop    %esi
8010788d:	5d                   	pop    %ebp
8010788e:	c3                   	ret    
8010788f:	90                   	nop

80107890 <FreeMessageBuffer>:

void FreeMessageBuffer( int msg_no ) {
80107890:	55                   	push   %ebp
80107891:	89 e5                	mov    %esp,%ebp
80107893:	56                   	push   %esi
80107894:	53                   	push   %ebx
80107895:	8b 75 08             	mov    0x8(%ebp),%esi
  acquire(&free_message_buffer_lock);
80107898:	83 ec 0c             	sub    $0xc,%esp
8010789b:	68 80 ff 12 80       	push   $0x8012ff80
  acquire(&message_buffer_lock[msg_no]);
801078a0:	6b de 34             	imul   $0x34,%esi,%ebx
  acquire(&free_message_buffer_lock);
801078a3:	e8 38 d0 ff ff       	call   801048e0 <acquire>
  acquire(&message_buffer_lock[msg_no]);
801078a8:	81 c3 c0 0c 13 80    	add    $0x80130cc0,%ebx
801078ae:	89 1c 24             	mov    %ebx,(%esp)
801078b1:	e8 2a d0 ff ff       	call   801048e0 <acquire>
  message_buffer[msg_no][0] = free_message_buffer;
801078b6:	8b 15 a0 05 17 80    	mov    0x801705a0,%edx
801078bc:	89 f0                	mov    %esi,%eax
  free_message_buffer = msg_no;
  release(&message_buffer_lock[msg_no]);
801078be:	89 1c 24             	mov    %ebx,(%esp)
  message_buffer[msg_no][0] = free_message_buffer;
801078c1:	c1 e0 06             	shl    $0x6,%eax
  free_message_buffer = msg_no;
801078c4:	89 35 a0 05 17 80    	mov    %esi,0x801705a0
  message_buffer[msg_no][0] = free_message_buffer;
801078ca:	89 90 c0 05 17 80    	mov    %edx,-0x7fe8fa40(%eax)
  release(&message_buffer_lock[msg_no]);
801078d0:	e8 cb d0 ff ff       	call   801049a0 <release>
  release(&free_message_buffer_lock);
801078d5:	c7 45 08 80 ff 12 80 	movl   $0x8012ff80,0x8(%ebp)
801078dc:	83 c4 10             	add    $0x10,%esp
}
801078df:	8d 65 f8             	lea    -0x8(%ebp),%esp
801078e2:	5b                   	pop    %ebx
801078e3:	5e                   	pop    %esi
801078e4:	5d                   	pop    %ebp
  release(&free_message_buffer_lock);
801078e5:	e9 b6 d0 ff ff       	jmp    801049a0 <release>
801078ea:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

801078f0 <messageinit>:

void
messageinit(void)
{
801078f0:	55                   	push   %ebp
801078f1:	89 e5                	mov    %esp,%ebp
801078f3:	56                   	push   %esi
801078f4:	be c0 0c 13 80       	mov    $0x80130cc0,%esi
801078f9:	53                   	push   %ebx
    char *a;
    a = "msg";
    for(int i = 0; i < (NUMOFMESSAGEBUFFERS-1); ++i ){
801078fa:	31 db                	xor    %ebx,%ebx
801078fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        message_buffer[i][0] = i + 1;    
        initlock(&message_buffer_lock[i],a);
80107900:	83 ec 08             	sub    $0x8,%esp
        message_buffer[i][0] = i + 1;    
80107903:	83 c3 01             	add    $0x1,%ebx
        initlock(&message_buffer_lock[i],a);
80107906:	68 ef 88 10 80       	push   $0x801088ef
        message_buffer[i][0] = i + 1;    
8010790b:	89 d8                	mov    %ebx,%eax
        initlock(&message_buffer_lock[i],a);
8010790d:	56                   	push   %esi
        message_buffer[i][0] = i + 1;    
8010790e:	c1 e0 06             	shl    $0x6,%eax
80107911:	83 c6 34             	add    $0x34,%esi
80107914:	89 98 80 05 17 80    	mov    %ebx,-0x7fe8fa80(%eax)
        initlock(&message_buffer_lock[i],a);
8010791a:	e8 81 ce ff ff       	call   801047a0 <initlock>
    for(int i = 0; i < (NUMOFMESSAGEBUFFERS-1); ++i ){
8010791f:	83 c4 10             	add    $0x10,%esp
80107922:	81 fb 88 13 00 00    	cmp    $0x1388,%ebx
80107928:	75 d6                	jne    80107900 <messageinit+0x10>
    }
    initlock(&message_buffer_lock[NUMOFMESSAGEBUFFERS-1],a);
8010792a:	83 ec 08             	sub    $0x8,%esp
8010792d:	be a0 04 17 80       	mov    $0x801704a0,%esi
80107932:	bb c0 ff 12 80       	mov    $0x8012ffc0,%ebx
80107937:	68 ef 88 10 80       	push   $0x801088ef
8010793c:	68 60 04 17 80       	push   $0x80170460
80107941:	e8 5a ce ff ff       	call   801047a0 <initlock>
    message_buffer[NUMOFMESSAGEBUFFERS-1][0] = -1;//END of free list
80107946:	c7 05 c0 e7 1b 80 ff 	movl   $0xffffffff,0x801be7c0
8010794d:	ff ff ff 
    free_message_buffer = 0;
80107950:	c7 05 a0 05 17 80 00 	movl   $0x0,0x801705a0
80107957:	00 00 00 
8010795a:	83 c4 10             	add    $0x10,%esp
8010795d:	8d 76 00             	lea    0x0(%esi),%esi
    for(int i = 0; i < NUMOFMESSAGEQUEUES; ++i ){
        message_queue[i] = createqueue();
80107960:	e8 1b 03 00 00       	call   80107c80 <createqueue>
        char *a;
        a = "queue";
        initlock(&queue_lock[i],a);
80107965:	83 ec 08             	sub    $0x8,%esp
        message_queue[i] = createqueue();
80107968:	89 06                	mov    %eax,(%esi)
8010796a:	83 c6 04             	add    $0x4,%esi
        initlock(&queue_lock[i],a);
8010796d:	68 f3 88 10 80       	push   $0x801088f3
80107972:	53                   	push   %ebx
80107973:	83 c3 34             	add    $0x34,%ebx
80107976:	e8 25 ce ff ff       	call   801047a0 <initlock>
    for(int i = 0; i < NUMOFMESSAGEQUEUES; ++i ){
8010797b:	83 c4 10             	add    $0x10,%esp
8010797e:	81 fb c0 0c 13 80    	cmp    $0x80130cc0,%ebx
80107984:	75 da                	jne    80107960 <messageinit+0x70>
    }
    a = "proc";
    initlock(&free_message_buffer_lock,"free_message_buff_lock");
80107986:	83 ec 08             	sub    $0x8,%esp
80107989:	68 f9 88 10 80       	push   $0x801088f9
8010798e:	68 80 ff 12 80       	push   $0x8012ff80
80107993:	e8 08 ce ff ff       	call   801047a0 <initlock>
}
80107998:	83 c4 10             	add    $0x10,%esp
8010799b:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010799e:	5b                   	pop    %ebx
8010799f:	5e                   	pop    %esi
801079a0:	5d                   	pop    %ebp
801079a1:	c3                   	ret    
801079a2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
801079a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

801079b0 <send_message>:

int
send_message(int s_pid,int r_pid,void *msg)
{
801079b0:	55                   	push   %ebp
801079b1:	89 e5                	mov    %esp,%ebp
801079b3:	57                   	push   %edi
801079b4:	56                   	push   %esi
801079b5:	53                   	push   %ebx
801079b6:	83 ec 28             	sub    $0x28,%esp
801079b9:	8b 7d 0c             	mov    0xc(%ebp),%edi
801079bc:	8b 75 10             	mov    0x10(%ebp),%esi
    acquire(&queue_lock[r_pid]);
801079bf:	6b df 34             	imul   $0x34,%edi,%ebx
801079c2:	8d 83 c0 ff 12 80    	lea    -0x7fed0040(%ebx),%eax
801079c8:	50                   	push   %eax
801079c9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801079cc:	e8 0f cf ff ff       	call   801048e0 <acquire>
    if(isFull(message_queue[r_pid])==1){
801079d1:	5a                   	pop    %edx
801079d2:	ff 34 bd a0 04 17 80 	pushl  -0x7fe8fb60(,%edi,4)
801079d9:	e8 f2 03 00 00       	call   80107dd0 <isFull>
801079de:	83 c4 10             	add    $0x10,%esp
801079e1:	83 f8 01             	cmp    $0x1,%eax
801079e4:	74 78                	je     80107a5e <send_message+0xae>
        release(&queue_lock[r_pid]);
        return -1;
    }
    int msg_no = GetMessageBuffer();
801079e6:	e8 45 fe ff ff       	call   80107830 <GetMessageBuffer>
    
    enqueue(message_queue[r_pid],msg_no);
801079eb:	83 ec 08             	sub    $0x8,%esp
    int msg_no = GetMessageBuffer();
801079ee:	89 c3                	mov    %eax,%ebx
    enqueue(message_queue[r_pid],msg_no);
801079f0:	50                   	push   %eax
801079f1:	ff 34 bd a0 04 17 80 	pushl  -0x7fe8fb60(,%edi,4)
    
    from_array[msg_no] = s_pid;
    int *temp_msg;
    temp_msg = (int *)msg;
    acquire(&message_buffer_lock[msg_no]);
801079f8:	6b fb 34             	imul   $0x34,%ebx,%edi
    enqueue(message_queue[r_pid],msg_no);
801079fb:	e8 00 03 00 00       	call   80107d00 <enqueue>
    from_array[msg_no] = s_pid;
80107a00:	8b 45 08             	mov    0x8(%ebp),%eax
    acquire(&message_buffer_lock[msg_no]);
80107a03:	81 c7 c0 0c 13 80    	add    $0x80130cc0,%edi
80107a09:	89 3c 24             	mov    %edi,(%esp)
    from_array[msg_no] = s_pid;
80107a0c:	89 04 9d 40 b9 10 80 	mov    %eax,-0x7fef46c0(,%ebx,4)
    for(int i=1;i<MessageSize;i++){
        *(message_buffer[msg_no]+i) = *(temp_msg+i-1);
80107a13:	c1 e3 06             	shl    $0x6,%ebx
    acquire(&message_buffer_lock[msg_no]);
80107a16:	e8 c5 ce ff ff       	call   801048e0 <acquire>
        *(message_buffer[msg_no]+i) = *(temp_msg+i-1);
80107a1b:	8d 83 c0 05 17 80    	lea    -0x7fe8fa40(%ebx),%eax
80107a21:	83 c4 10             	add    $0x10,%esp
    for(int i=1;i<MessageSize;i++){
80107a24:	ba 01 00 00 00       	mov    $0x1,%edx
80107a29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        *(message_buffer[msg_no]+i) = *(temp_msg+i-1);
80107a30:	8b 4c 96 fc          	mov    -0x4(%esi,%edx,4),%ecx
80107a34:	89 0c 90             	mov    %ecx,(%eax,%edx,4)
    for(int i=1;i<MessageSize;i++){
80107a37:	83 c2 01             	add    $0x1,%edx
80107a3a:	83 fa 10             	cmp    $0x10,%edx
80107a3d:	75 f1                	jne    80107a30 <send_message+0x80>
    }
    release(&message_buffer_lock[msg_no]);
80107a3f:	83 ec 0c             	sub    $0xc,%esp
80107a42:	57                   	push   %edi
80107a43:	e8 58 cf ff ff       	call   801049a0 <release>
    // getQueueSize(message_queue[r_pid]);
    release(&queue_lock[r_pid]);
80107a48:	58                   	pop    %eax
80107a49:	ff 75 e4             	pushl  -0x1c(%ebp)
80107a4c:	e8 4f cf ff ff       	call   801049a0 <release>
    return 0;
80107a51:	83 c4 10             	add    $0x10,%esp
80107a54:	31 c0                	xor    %eax,%eax
}
80107a56:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107a59:	5b                   	pop    %ebx
80107a5a:	5e                   	pop    %esi
80107a5b:	5f                   	pop    %edi
80107a5c:	5d                   	pop    %ebp
80107a5d:	c3                   	ret    
        release(&queue_lock[r_pid]);
80107a5e:	83 ec 0c             	sub    $0xc,%esp
80107a61:	ff 75 e4             	pushl  -0x1c(%ebp)
80107a64:	e8 37 cf ff ff       	call   801049a0 <release>
        return -1;
80107a69:	83 c4 10             	add    $0x10,%esp
80107a6c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107a71:	eb e3                	jmp    80107a56 <send_message+0xa6>
80107a73:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107a79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107a80 <receive_message_temp>:

int 
receive_message_temp(int myid,void* msg)
{
80107a80:	55                   	push   %ebp
80107a81:	89 e5                	mov    %esp,%ebp
80107a83:	57                   	push   %edi
80107a84:	56                   	push   %esi
80107a85:	53                   	push   %ebx
80107a86:	83 ec 28             	sub    $0x28,%esp
80107a89:	8b 7d 08             	mov    0x8(%ebp),%edi
80107a8c:	8b 75 0c             	mov    0xc(%ebp),%esi
    acquire(&queue_lock[myid]);
80107a8f:	6b df 34             	imul   $0x34,%edi,%ebx
80107a92:	81 c3 c0 ff 12 80    	add    $0x8012ffc0,%ebx
80107a98:	53                   	push   %ebx
80107a99:	e8 42 ce ff ff       	call   801048e0 <acquire>
    if(isEmpty(message_queue[myid])==1){
80107a9e:	58                   	pop    %eax
80107a9f:	ff 34 bd a0 04 17 80 	pushl  -0x7fe8fb60(,%edi,4)
80107aa6:	e8 35 02 00 00       	call   80107ce0 <isEmpty>
80107aab:	83 c4 10             	add    $0x10,%esp
80107aae:	83 f8 01             	cmp    $0x1,%eax
80107ab1:	0f 84 8d 00 00 00    	je     80107b44 <receive_message_temp+0xc4>
        release(&queue_lock[myid]);
        return -1;
    }
    int msg_no = dequeue(message_queue[myid]);
80107ab7:	83 ec 0c             	sub    $0xc,%esp
80107aba:	ff 34 bd a0 04 17 80 	pushl  -0x7fe8fb60(,%edi,4)
80107ac1:	e8 aa 02 00 00       	call   80107d70 <dequeue>
    if(msg_no<0){
80107ac6:	83 c4 10             	add    $0x10,%esp
80107ac9:	85 c0                	test   %eax,%eax
    int msg_no = dequeue(message_queue[myid]);
80107acb:	89 c7                	mov    %eax,%edi
    if(msg_no<0){
80107acd:	78 75                	js     80107b44 <receive_message_temp+0xc4>
        release(&queue_lock[myid]);
        return -1;
    }
    int *temp_msg;
    temp_msg = (int *)msg;
    acquire(&message_buffer_lock[msg_no]);
80107acf:	6b c0 34             	imul   $0x34,%eax,%eax
80107ad2:	83 ec 0c             	sub    $0xc,%esp
80107ad5:	05 c0 0c 13 80       	add    $0x80130cc0,%eax
80107ada:	50                   	push   %eax
80107adb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107ade:	e8 fd cd ff ff       	call   801048e0 <acquire>
    for(int i=1;i<MessageSize;i++){
         *(temp_msg+i-1) = *(message_buffer[msg_no]+i);
80107ae3:	89 f9                	mov    %edi,%ecx
80107ae5:	83 c4 10             	add    $0x10,%esp
    for(int i=1;i<MessageSize;i++){
80107ae8:	ba 01 00 00 00       	mov    $0x1,%edx
         *(temp_msg+i-1) = *(message_buffer[msg_no]+i);
80107aed:	c1 e1 06             	shl    $0x6,%ecx
80107af0:	81 c1 c0 05 17 80    	add    $0x801705c0,%ecx
80107af6:	8d 76 00             	lea    0x0(%esi),%esi
80107af9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
80107b00:	8b 04 91             	mov    (%ecx,%edx,4),%eax
80107b03:	89 44 96 fc          	mov    %eax,-0x4(%esi,%edx,4)
    for(int i=1;i<MessageSize;i++){
80107b07:	83 c2 01             	add    $0x1,%edx
80107b0a:	83 fa 10             	cmp    $0x10,%edx
80107b0d:	75 f1                	jne    80107b00 <receive_message_temp+0x80>
80107b0f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    }
    release(&message_buffer_lock[msg_no]);
80107b12:	83 ec 0c             	sub    $0xc,%esp
80107b15:	50                   	push   %eax
80107b16:	e8 85 ce ff ff       	call   801049a0 <release>
    FreeMessageBuffer(msg_no);
80107b1b:	89 3c 24             	mov    %edi,(%esp)
80107b1e:	e8 6d fd ff ff       	call   80107890 <FreeMessageBuffer>
    cprintf("after receiving size of queue[] is\n ");// %d \n",getQueueSize(message_queue[myid])
80107b23:	c7 04 24 10 89 10 80 	movl   $0x80108910,(%esp)
80107b2a:	e8 31 8b ff ff       	call   80100660 <cprintf>
    release(&queue_lock[myid]);
80107b2f:	89 1c 24             	mov    %ebx,(%esp)
80107b32:	e8 69 ce ff ff       	call   801049a0 <release>
    return 0;
80107b37:	83 c4 10             	add    $0x10,%esp
80107b3a:	31 c0                	xor    %eax,%eax
}
80107b3c:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107b3f:	5b                   	pop    %ebx
80107b40:	5e                   	pop    %esi
80107b41:	5f                   	pop    %edi
80107b42:	5d                   	pop    %ebp
80107b43:	c3                   	ret    
        release(&queue_lock[myid]);
80107b44:	83 ec 0c             	sub    $0xc,%esp
80107b47:	53                   	push   %ebx
80107b48:	e8 53 ce ff ff       	call   801049a0 <release>
        return -1;
80107b4d:	83 c4 10             	add    $0x10,%esp
80107b50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107b55:	eb e5                	jmp    80107b3c <receive_message_temp+0xbc>
80107b57:	89 f6                	mov    %esi,%esi
80107b59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107b60 <receive_msg>:

int
receive_msg(int myid,void* msg)
{
80107b60:	55                   	push   %ebp
80107b61:	89 e5                	mov    %esp,%ebp
80107b63:	57                   	push   %edi
80107b64:	56                   	push   %esi
80107b65:	53                   	push   %ebx
80107b66:	83 ec 28             	sub    $0x28,%esp
80107b69:	8b 7d 08             	mov    0x8(%ebp),%edi
80107b6c:	8b 75 0c             	mov    0xc(%ebp),%esi
    acquire(&queue_lock[myid]);
80107b6f:	6b df 34             	imul   $0x34,%edi,%ebx
80107b72:	81 c3 c0 ff 12 80    	add    $0x8012ffc0,%ebx
80107b78:	53                   	push   %ebx
80107b79:	e8 62 cd ff ff       	call   801048e0 <acquire>
    if(isEmpty(message_queue[myid])==1){
80107b7e:	58                   	pop    %eax
80107b7f:	ff 34 bd a0 04 17 80 	pushl  -0x7fe8fb60(,%edi,4)
80107b86:	e8 55 01 00 00       	call   80107ce0 <isEmpty>
80107b8b:	83 c4 10             	add    $0x10,%esp
80107b8e:	83 f8 01             	cmp    $0x1,%eax
80107b91:	74 7d                	je     80107c10 <receive_msg+0xb0>
        release(&queue_lock[myid]);
        return -1;
    }
    
    int msg_no = dequeue(message_queue[myid]);
80107b93:	83 ec 0c             	sub    $0xc,%esp
80107b96:	ff 34 bd a0 04 17 80 	pushl  -0x7fe8fb60(,%edi,4)
80107b9d:	e8 ce 01 00 00       	call   80107d70 <dequeue>
    // cprintf("msg_no is : %d for pid %d \n",msg_no,myproc()->pid);
    if(msg_no<0){
80107ba2:	83 c4 10             	add    $0x10,%esp
80107ba5:	85 c0                	test   %eax,%eax
    int msg_no = dequeue(message_queue[myid]);
80107ba7:	89 c7                	mov    %eax,%edi
    if(msg_no<0){
80107ba9:	78 65                	js     80107c10 <receive_msg+0xb0>
    }
    // int f = from_array[msg_no];
    // *from = f;
    int *temp_msg;
    temp_msg = (int *)msg;
    acquire(&message_buffer_lock[msg_no]);
80107bab:	6b c0 34             	imul   $0x34,%eax,%eax
80107bae:	83 ec 0c             	sub    $0xc,%esp
80107bb1:	05 c0 0c 13 80       	add    $0x80130cc0,%eax
80107bb6:	50                   	push   %eax
80107bb7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107bba:	e8 21 cd ff ff       	call   801048e0 <acquire>
    for(int i=1;i<MessageSize;i++){
         *(temp_msg+i-1) = *(message_buffer[msg_no]+i);
80107bbf:	89 f9                	mov    %edi,%ecx
80107bc1:	83 c4 10             	add    $0x10,%esp
    for(int i=1;i<MessageSize;i++){
80107bc4:	ba 01 00 00 00       	mov    $0x1,%edx
         *(temp_msg+i-1) = *(message_buffer[msg_no]+i);
80107bc9:	c1 e1 06             	shl    $0x6,%ecx
80107bcc:	81 c1 c0 05 17 80    	add    $0x801705c0,%ecx
80107bd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107bd8:	8b 04 91             	mov    (%ecx,%edx,4),%eax
80107bdb:	89 44 96 fc          	mov    %eax,-0x4(%esi,%edx,4)
    for(int i=1;i<MessageSize;i++){
80107bdf:	83 c2 01             	add    $0x1,%edx
80107be2:	83 fa 10             	cmp    $0x10,%edx
80107be5:	75 f1                	jne    80107bd8 <receive_msg+0x78>
80107be7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    }
    release(&message_buffer_lock[msg_no]);
80107bea:	83 ec 0c             	sub    $0xc,%esp
80107bed:	50                   	push   %eax
80107bee:	e8 ad cd ff ff       	call   801049a0 <release>
    FreeMessageBuffer(msg_no);
80107bf3:	89 3c 24             	mov    %edi,(%esp)
80107bf6:	e8 95 fc ff ff       	call   80107890 <FreeMessageBuffer>
    release(&queue_lock[myid]);
80107bfb:	89 1c 24             	mov    %ebx,(%esp)
80107bfe:	e8 9d cd ff ff       	call   801049a0 <release>
    
    return 0;
80107c03:	83 c4 10             	add    $0x10,%esp
80107c06:	31 c0                	xor    %eax,%eax
}
80107c08:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107c0b:	5b                   	pop    %ebx
80107c0c:	5e                   	pop    %esi
80107c0d:	5f                   	pop    %edi
80107c0e:	5d                   	pop    %ebp
80107c0f:	c3                   	ret    
        release(&queue_lock[myid]);
80107c10:	83 ec 0c             	sub    $0xc,%esp
80107c13:	53                   	push   %ebx
80107c14:	e8 87 cd ff ff       	call   801049a0 <release>
        return -1;
80107c19:	83 c4 10             	add    $0x10,%esp
80107c1c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107c21:	eb e5                	jmp    80107c08 <receive_msg+0xa8>
80107c23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
80107c29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107c30 <isReceiverQueueEmpty>:

int 
isReceiverQueueEmpty(int myid)
{
80107c30:	55                   	push   %ebp
80107c31:	89 e5                	mov    %esp,%ebp
80107c33:	56                   	push   %esi
80107c34:	53                   	push   %ebx
80107c35:	8b 75 08             	mov    0x8(%ebp),%esi
    int flag = 0;
    acquire(&queue_lock[myid]);
80107c38:	83 ec 0c             	sub    $0xc,%esp
80107c3b:	6b de 34             	imul   $0x34,%esi,%ebx
80107c3e:	81 c3 c0 ff 12 80    	add    $0x8012ffc0,%ebx
80107c44:	53                   	push   %ebx
80107c45:	e8 96 cc ff ff       	call   801048e0 <acquire>
    if(isEmpty(message_queue[myid])==1){
80107c4a:	58                   	pop    %eax
80107c4b:	ff 34 b5 a0 04 17 80 	pushl  -0x7fe8fb60(,%esi,4)
80107c52:	e8 89 00 00 00       	call   80107ce0 <isEmpty>
80107c57:	89 c6                	mov    %eax,%esi
        flag = 1;
    }
    release(&queue_lock[myid]);
80107c59:	89 1c 24             	mov    %ebx,(%esp)
80107c5c:	e8 3f cd ff ff       	call   801049a0 <release>
    if(isEmpty(message_queue[myid])==1){
80107c61:	83 c4 10             	add    $0x10,%esp
80107c64:	31 c0                	xor    %eax,%eax
80107c66:	83 fe 01             	cmp    $0x1,%esi
80107c69:	0f 94 c0             	sete   %al
    return flag;
}
80107c6c:	8d 65 f8             	lea    -0x8(%ebp),%esp
80107c6f:	5b                   	pop    %ebx
80107c70:	5e                   	pop    %esi
80107c71:	5d                   	pop    %ebp
80107c72:	c3                   	ret    
80107c73:	66 90                	xchg   %ax,%ax
80107c75:	66 90                	xchg   %ax,%ax
80107c77:	66 90                	xchg   %ax,%ax
80107c79:	66 90                	xchg   %ax,%ax
80107c7b:	66 90                	xchg   %ax,%ax
80107c7d:	66 90                	xchg   %ax,%ax
80107c7f:	90                   	nop

80107c80 <createqueue>:
int count_q = 0;

queue* 
createqueue(void)
{
    if(count_q>=NUMOFMESSAGEQUEUES){
80107c80:	8b 15 64 07 11 80    	mov    0x80110764,%edx
{
80107c86:	55                   	push   %ebp
80107c87:	89 e5                	mov    %esp,%ebp
80107c89:	53                   	push   %ebx
    if(count_q>=NUMOFMESSAGEQUEUES){
80107c8a:	83 fa 3f             	cmp    $0x3f,%edx
80107c8d:	7e 41                	jle    80107cd0 <createqueue+0x50>
80107c8f:	b8 00 e8 1b 80       	mov    $0x801be800,%eax
80107c94:	bb 01 00 00 00       	mov    $0x1,%ebx
80107c99:	31 d2                	xor    %edx,%edx
        count_q=0;
    }
    queue* q;
    q = &temp_queue[count_q]; 
    q->size = 0;  
80107c9b:	69 d2 30 4e 00 00    	imul   $0x4e30,%edx,%edx
    q->tail = 0;
    q->head = 0;
    count_q++;
80107ca1:	89 1d 64 07 11 80    	mov    %ebx,0x80110764
    return q; 
}
80107ca7:	5b                   	pop    %ebx
80107ca8:	5d                   	pop    %ebp
    q->size = 0;  
80107ca9:	c7 82 00 e8 1b 80 00 	movl   $0x0,-0x7fe41800(%edx)
80107cb0:	00 00 00 
    q->tail = 0;
80107cb3:	c7 82 2c 36 1c 80 00 	movl   $0x0,-0x7fe3c9d4(%edx)
80107cba:	00 00 00 
    q->head = 0;
80107cbd:	c7 82 28 36 1c 80 00 	movl   $0x0,-0x7fe3c9d8(%edx)
80107cc4:	00 00 00 
}
80107cc7:	c3                   	ret    
80107cc8:	90                   	nop
80107cc9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107cd0:	69 c2 30 4e 00 00    	imul   $0x4e30,%edx,%eax
80107cd6:	8d 5a 01             	lea    0x1(%edx),%ebx
80107cd9:	05 00 e8 1b 80       	add    $0x801be800,%eax
80107cde:	eb bb                	jmp    80107c9b <createqueue+0x1b>

80107ce0 <isEmpty>:

int
isEmpty(queue* q)
{
80107ce0:	55                   	push   %ebp
80107ce1:	89 e5                	mov    %esp,%ebp
    if(q->size==0)
80107ce3:	8b 45 08             	mov    0x8(%ebp),%eax
        return 1;
    return 0;
}
80107ce6:	5d                   	pop    %ebp
    if(q->size==0)
80107ce7:	8b 00                	mov    (%eax),%eax
80107ce9:	85 c0                	test   %eax,%eax
80107ceb:	0f 94 c0             	sete   %al
80107cee:	0f b6 c0             	movzbl %al,%eax
}
80107cf1:	c3                   	ret    
80107cf2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
80107cf9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107d00 <enqueue>:
  
int 
enqueue(queue* q, int a) 
{ 
80107d00:	55                   	push   %ebp
80107d01:	89 e5                	mov    %esp,%ebp
80107d03:	56                   	push   %esi
80107d04:	53                   	push   %ebx
80107d05:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if (q->size==NUMOFMESSAGEBUFFERS){
80107d08:	8b 33                	mov    (%ebx),%esi
80107d0a:	81 fe 89 13 00 00    	cmp    $0x1389,%esi
80107d10:	74 3e                	je     80107d50 <enqueue+0x50>
        return -1;
    }
    q->data[q->tail] = a; 
80107d12:	8b 8b 2c 4e 00 00    	mov    0x4e2c(%ebx),%ecx
80107d18:	8b 45 0c             	mov    0xc(%ebp),%eax
    q->tail = (q->tail + 1)%NUMOFMESSAGEBUFFERS;  
80107d1b:	ba 1f 5b ac d1       	mov    $0xd1ac5b1f,%edx
    q->size = q->size + 1;
80107d20:	83 c6 01             	add    $0x1,%esi
    q->data[q->tail] = a; 
80107d23:	89 44 8b 04          	mov    %eax,0x4(%ebx,%ecx,4)
    q->tail = (q->tail + 1)%NUMOFMESSAGEBUFFERS;  
80107d27:	83 c1 01             	add    $0x1,%ecx
    q->size = q->size + 1;
80107d2a:	89 33                	mov    %esi,(%ebx)
    q->tail = (q->tail + 1)%NUMOFMESSAGEBUFFERS;  
80107d2c:	89 c8                	mov    %ecx,%eax
80107d2e:	f7 ea                	imul   %edx
80107d30:	89 c8                	mov    %ecx,%eax
80107d32:	c1 f8 1f             	sar    $0x1f,%eax
80107d35:	01 ca                	add    %ecx,%edx
80107d37:	c1 fa 0c             	sar    $0xc,%edx
80107d3a:	29 c2                	sub    %eax,%edx
    return 0; 
80107d3c:	31 c0                	xor    %eax,%eax
    q->tail = (q->tail + 1)%NUMOFMESSAGEBUFFERS;  
80107d3e:	69 d2 89 13 00 00    	imul   $0x1389,%edx,%edx
80107d44:	29 d1                	sub    %edx,%ecx
80107d46:	89 8b 2c 4e 00 00    	mov    %ecx,0x4e2c(%ebx)
} 
80107d4c:	5b                   	pop    %ebx
80107d4d:	5e                   	pop    %esi
80107d4e:	5d                   	pop    %ebp
80107d4f:	c3                   	ret    
        return -1;
80107d50:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107d55:	eb f5                	jmp    80107d4c <enqueue+0x4c>
80107d57:	89 f6                	mov    %esi,%esi
80107d59:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107d60 <getQueueSize>:

int
getQueueSize(queue *q)
{
80107d60:	55                   	push   %ebp
80107d61:	89 e5                	mov    %esp,%ebp
    return q->size;
80107d63:	8b 45 08             	mov    0x8(%ebp),%eax
}
80107d66:	5d                   	pop    %ebp
    return q->size;
80107d67:	8b 00                	mov    (%eax),%eax
}
80107d69:	c3                   	ret    
80107d6a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

80107d70 <dequeue>:
  
int 
dequeue(queue* q) 
{ 
80107d70:	55                   	push   %ebp
80107d71:	89 e5                	mov    %esp,%ebp
80107d73:	57                   	push   %edi
80107d74:	56                   	push   %esi
80107d75:	53                   	push   %ebx
80107d76:	8b 5d 08             	mov    0x8(%ebp),%ebx
    if(q->size==0)
80107d79:	8b 33                	mov    (%ebx),%esi
80107d7b:	85 f6                	test   %esi,%esi
80107d7d:	74 41                	je     80107dc0 <dequeue+0x50>
    if (isEmpty(q)) 
        return -1; 
    int a = q->data[q->head]; 
80107d7f:	8b 8b 28 4e 00 00    	mov    0x4e28(%ebx),%ecx
    q->head = (q->head + 1)%NUMOFMESSAGEBUFFERS; 
80107d85:	ba 1f 5b ac d1       	mov    $0xd1ac5b1f,%edx
    q->size = q->size - 1; 
80107d8a:	83 ee 01             	sub    $0x1,%esi
    int a = q->data[q->head]; 
80107d8d:	8b 7c 8b 04          	mov    0x4(%ebx,%ecx,4),%edi
    q->head = (q->head + 1)%NUMOFMESSAGEBUFFERS; 
80107d91:	83 c1 01             	add    $0x1,%ecx
    q->size = q->size - 1; 
80107d94:	89 33                	mov    %esi,(%ebx)
    q->head = (q->head + 1)%NUMOFMESSAGEBUFFERS; 
80107d96:	89 c8                	mov    %ecx,%eax
80107d98:	f7 ea                	imul   %edx
80107d9a:	89 c8                	mov    %ecx,%eax
80107d9c:	c1 f8 1f             	sar    $0x1f,%eax
80107d9f:	01 ca                	add    %ecx,%edx
80107da1:	c1 fa 0c             	sar    $0xc,%edx
80107da4:	29 c2                	sub    %eax,%edx
80107da6:	69 d2 89 13 00 00    	imul   $0x1389,%edx,%edx
80107dac:	29 d1                	sub    %edx,%ecx
80107dae:	89 8b 28 4e 00 00    	mov    %ecx,0x4e28(%ebx)
    return a; 
}
80107db4:	5b                   	pop    %ebx
80107db5:	89 f8                	mov    %edi,%eax
80107db7:	5e                   	pop    %esi
80107db8:	5f                   	pop    %edi
80107db9:	5d                   	pop    %ebp
80107dba:	c3                   	ret    
80107dbb:	90                   	nop
80107dbc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        return -1; 
80107dc0:	bf ff ff ff ff       	mov    $0xffffffff,%edi
80107dc5:	eb ed                	jmp    80107db4 <dequeue+0x44>
80107dc7:	89 f6                	mov    %esi,%esi
80107dc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

80107dd0 <isFull>:

int
isFull(queue* q)
{
80107dd0:	55                   	push   %ebp
80107dd1:	89 e5                	mov    %esp,%ebp
    if(q->size==NUMOFMESSAGEBUFFERS){
80107dd3:	8b 45 08             	mov    0x8(%ebp),%eax
        return 1;
    }
    return 0;
}
80107dd6:	5d                   	pop    %ebp
    if(q->size==NUMOFMESSAGEBUFFERS){
80107dd7:	81 38 89 13 00 00    	cmpl   $0x1389,(%eax)
80107ddd:	0f 94 c0             	sete   %al
80107de0:	0f b6 c0             	movzbl %al,%eax
}
80107de3:	c3                   	ret    
