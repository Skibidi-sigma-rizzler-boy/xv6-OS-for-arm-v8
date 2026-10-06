
_ls:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
       0:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
       4:	910003fd 	mov	x29, sp
       8:	f9000bf3 	str	x19, [sp, #16]
       c:	f90017e0 	str	x0, [sp, #40]
    static char buf[DIRSIZ+1];
    char *p;
    
    // Find first character after last slash.
    for(p=path+strlen(path); p >= path && *p != '/'; p--)
      10:	f94017e0 	ldr	x0, [sp, #40]
      14:	94000100 	bl	414 <strlen>
      18:	2a0003e0 	mov	w0, w0
      1c:	f94017e1 	ldr	x1, [sp, #40]
      20:	8b000020 	add	x0, x1, x0
      24:	f9001fe0 	str	x0, [sp, #56]
      28:	14000004 	b	38 <fmtname+0x38>
      2c:	f9401fe0 	ldr	x0, [sp, #56]
      30:	d1000400 	sub	x0, x0, #0x1
      34:	f9001fe0 	str	x0, [sp, #56]
      38:	f9401fe1 	ldr	x1, [sp, #56]
      3c:	f94017e0 	ldr	x0, [sp, #40]
      40:	eb00003f 	cmp	x1, x0
      44:	540000a3 	b.cc	58 <fmtname+0x58>  // b.lo, b.ul, b.last
      48:	f9401fe0 	ldr	x0, [sp, #56]
      4c:	39400000 	ldrb	w0, [x0]
      50:	7100bc1f 	cmp	w0, #0x2f
      54:	54fffec1 	b.ne	2c <fmtname+0x2c>  // b.any
        ;
    p++;
      58:	f9401fe0 	ldr	x0, [sp, #56]
      5c:	91000400 	add	x0, x0, #0x1
      60:	f9001fe0 	str	x0, [sp, #56]
    
    // Return blank-padded name.
    if(strlen(p) >= DIRSIZ)
      64:	f9401fe0 	ldr	x0, [sp, #56]
      68:	940000eb 	bl	414 <strlen>
      6c:	7100341f 	cmp	w0, #0xd
      70:	54000069 	b.ls	7c <fmtname+0x7c>  // b.plast
        return p;
      74:	f9401fe0 	ldr	x0, [sp, #56]
      78:	14000019 	b	dc <fmtname+0xdc>
    memmove(buf, p, strlen(p));
      7c:	f9401fe0 	ldr	x0, [sp, #56]
      80:	940000e5 	bl	414 <strlen>
      84:	2a0003e2 	mov	w2, w0
      88:	f9401fe1 	ldr	x1, [sp, #56]
      8c:	b0000000 	adrp	x0, 1000 <morecore+0x50>
      90:	91088000 	add	x0, x0, #0x220
      94:	940001a8 	bl	734 <memmove>
    memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
      98:	f9401fe0 	ldr	x0, [sp, #56]
      9c:	940000de 	bl	414 <strlen>
      a0:	2a0003e1 	mov	w1, w0
      a4:	b0000000 	adrp	x0, 1000 <morecore+0x50>
      a8:	91088000 	add	x0, x0, #0x220
      ac:	8b000033 	add	x19, x1, x0
      b0:	f9401fe0 	ldr	x0, [sp, #56]
      b4:	940000d8 	bl	414 <strlen>
      b8:	2a0003e1 	mov	w1, w0
      bc:	528001c0 	mov	w0, #0xe                   	// #14
      c0:	4b010000 	sub	w0, w0, w1
      c4:	2a0003e2 	mov	w2, w0
      c8:	52800401 	mov	w1, #0x20                  	// #32
      cc:	aa1303e0 	mov	x0, x19
      d0:	940000e1 	bl	454 <memset>
    return buf;
      d4:	b0000000 	adrp	x0, 1000 <morecore+0x50>
      d8:	91088000 	add	x0, x0, #0x220
}
      dc:	f9400bf3 	ldr	x19, [sp, #16]
      e0:	a8c47bfd 	ldp	x29, x30, [sp], #64
      e4:	d65f03c0 	ret

00000000000000e8 <ls>:

void
ls(char *path)
{
      e8:	d10983ff 	sub	sp, sp, #0x260
      ec:	a9007bfd 	stp	x29, x30, [sp]
      f0:	910003fd 	mov	x29, sp
      f4:	f9000fe0 	str	x0, [sp, #24]
    char buf[512], *p;
    int fd;
    struct dirent de;
    struct stat st;
    
    if((fd = open(path, 0)) < 0){
      f8:	52800001 	mov	w1, #0x0                   	// #0
      fc:	f9400fe0 	ldr	x0, [sp, #24]
     100:	940001f7 	bl	8dc <open>
     104:	b9025fe0 	str	w0, [sp, #604]
     108:	b9425fe0 	ldr	w0, [sp, #604]
     10c:	7100001f 	cmp	w0, #0x0
     110:	540000ea 	b.ge	12c <ls+0x44>  // b.tcont
        printf(2, "ls: cannot open %s\n", path);
     114:	f9400fe2 	ldr	x2, [sp, #24]
     118:	b0000000 	adrp	x0, 1000 <morecore+0x50>
     11c:	91068001 	add	x1, x0, #0x1a0
     120:	52800040 	mov	w0, #0x2                   	// #2
     124:	940002ad 	bl	bd8 <printf>
        return;
     128:	1400006c 	b	2d8 <ls+0x1f0>
    }
    
    if(fstat(fd, &st) < 0){
     12c:	9100a3e0 	add	x0, sp, #0x28
     130:	aa0003e1 	mov	x1, x0
     134:	b9425fe0 	ldr	w0, [sp, #604]
     138:	94000204 	bl	948 <fstat>
     13c:	7100001f 	cmp	w0, #0x0
     140:	5400012a 	b.ge	164 <ls+0x7c>  // b.tcont
        printf(2, "ls: cannot stat %s\n", path);
     144:	f9400fe2 	ldr	x2, [sp, #24]
     148:	b0000000 	adrp	x0, 1000 <morecore+0x50>
     14c:	9106e001 	add	x1, x0, #0x1b8
     150:	52800040 	mov	w0, #0x2                   	// #2
     154:	940002a1 	bl	bd8 <printf>
        close(fd);
     158:	b9425fe0 	ldr	w0, [sp, #604]
     15c:	940001c5 	bl	870 <close>
        return;
     160:	1400005e 	b	2d8 <ls+0x1f0>
    }
    
    switch(st.type){
     164:	79c053e0 	ldrsh	w0, [sp, #40]
     168:	7100041f 	cmp	w0, #0x1
     16c:	54000220 	b.eq	1b0 <ls+0xc8>  // b.none
     170:	7100081f 	cmp	w0, #0x2
     174:	54000ae1 	b.ne	2d0 <ls+0x1e8>  // b.any
        case T_FILE:
            printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
     178:	f9400fe0 	ldr	x0, [sp, #24]
     17c:	97ffffa1 	bl	0 <fmtname>
     180:	aa0003e2 	mov	x2, x0
     184:	79c053e0 	ldrsh	w0, [sp, #40]
     188:	2a0003e3 	mov	w3, w0
     18c:	b94033e0 	ldr	w0, [sp, #48]
     190:	b9403be1 	ldr	w1, [sp, #56]
     194:	2a0103e5 	mov	w5, w1
     198:	2a0003e4 	mov	w4, w0
     19c:	b0000000 	adrp	x0, 1000 <morecore+0x50>
     1a0:	91074001 	add	x1, x0, #0x1d0
     1a4:	52800020 	mov	w0, #0x1                   	// #1
     1a8:	9400028c 	bl	bd8 <printf>
            break;
     1ac:	14000049 	b	2d0 <ls+0x1e8>
            
        case T_DIR:
            if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
     1b0:	f9400fe0 	ldr	x0, [sp, #24]
     1b4:	94000098 	bl	414 <strlen>
     1b8:	11004000 	add	w0, w0, #0x10
     1bc:	7108001f 	cmp	w0, #0x200
     1c0:	540000c9 	b.ls	1d8 <ls+0xf0>  // b.plast
                printf(1, "ls: path too long\n");
     1c4:	b0000000 	adrp	x0, 1000 <morecore+0x50>
     1c8:	91078001 	add	x1, x0, #0x1e0
     1cc:	52800020 	mov	w0, #0x1                   	// #1
     1d0:	94000282 	bl	bd8 <printf>
                break;
     1d4:	1400003f 	b	2d0 <ls+0x1e8>
            }
            strcpy(buf, path);
     1d8:	910143e0 	add	x0, sp, #0x50
     1dc:	f9400fe1 	ldr	x1, [sp, #24]
     1e0:	9400005d 	bl	354 <strcpy>
            p = buf+strlen(buf);
     1e4:	910143e0 	add	x0, sp, #0x50
     1e8:	9400008b 	bl	414 <strlen>
     1ec:	2a0003e0 	mov	w0, w0
     1f0:	910143e1 	add	x1, sp, #0x50
     1f4:	8b000020 	add	x0, x1, x0
     1f8:	f9012be0 	str	x0, [sp, #592]
            *p++ = '/';
     1fc:	f9412be0 	ldr	x0, [sp, #592]
     200:	91000401 	add	x1, x0, #0x1
     204:	f9012be1 	str	x1, [sp, #592]
     208:	528005e1 	mov	w1, #0x2f                  	// #47
     20c:	39000001 	strb	w1, [x0]
            while(read(fd, &de, sizeof(de)) == sizeof(de)){
     210:	14000028 	b	2b0 <ls+0x1c8>
                if(de.inum == 0)
     214:	794083e0 	ldrh	w0, [sp, #64]
     218:	7100001f 	cmp	w0, #0x0
     21c:	54000480 	b.eq	2ac <ls+0x1c4>  // b.none
                    continue;
                memmove(p, de.name, DIRSIZ);
     220:	910103e0 	add	x0, sp, #0x40
     224:	91000800 	add	x0, x0, #0x2
     228:	528001c2 	mov	w2, #0xe                   	// #14
     22c:	aa0003e1 	mov	x1, x0
     230:	f9412be0 	ldr	x0, [sp, #592]
     234:	94000140 	bl	734 <memmove>
                p[DIRSIZ] = 0;
     238:	f9412be0 	ldr	x0, [sp, #592]
     23c:	91003800 	add	x0, x0, #0xe
     240:	3900001f 	strb	wzr, [x0]
                if(stat(buf, &st) < 0){
     244:	9100a3e1 	add	x1, sp, #0x28
     248:	910143e0 	add	x0, sp, #0x50
     24c:	94000108 	bl	66c <stat>
     250:	7100001f 	cmp	w0, #0x0
     254:	5400010a 	b.ge	274 <ls+0x18c>  // b.tcont
                    printf(1, "ls: cannot stat %s\n", buf);
     258:	910143e0 	add	x0, sp, #0x50
     25c:	aa0003e2 	mov	x2, x0
     260:	b0000000 	adrp	x0, 1000 <morecore+0x50>
     264:	9106e001 	add	x1, x0, #0x1b8
     268:	52800020 	mov	w0, #0x1                   	// #1
     26c:	9400025b 	bl	bd8 <printf>
                    continue;
     270:	14000010 	b	2b0 <ls+0x1c8>
                }
                printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
     274:	910143e0 	add	x0, sp, #0x50
     278:	97ffff62 	bl	0 <fmtname>
     27c:	aa0003e2 	mov	x2, x0
     280:	79c053e0 	ldrsh	w0, [sp, #40]
     284:	2a0003e3 	mov	w3, w0
     288:	b94033e0 	ldr	w0, [sp, #48]
     28c:	b9403be1 	ldr	w1, [sp, #56]
     290:	2a0103e5 	mov	w5, w1
     294:	2a0003e4 	mov	w4, w0
     298:	b0000000 	adrp	x0, 1000 <morecore+0x50>
     29c:	91074001 	add	x1, x0, #0x1d0
     2a0:	52800020 	mov	w0, #0x1                   	// #1
     2a4:	9400024d 	bl	bd8 <printf>
     2a8:	14000002 	b	2b0 <ls+0x1c8>
                    continue;
     2ac:	d503201f 	nop
            while(read(fd, &de, sizeof(de)) == sizeof(de)){
     2b0:	910103e0 	add	x0, sp, #0x40
     2b4:	52800202 	mov	w2, #0x10                  	// #16
     2b8:	aa0003e1 	mov	x1, x0
     2bc:	b9425fe0 	ldr	w0, [sp, #604]
     2c0:	9400015a 	bl	828 <read>
     2c4:	7100401f 	cmp	w0, #0x10
     2c8:	54fffa60 	b.eq	214 <ls+0x12c>  // b.none
            }
            break;
     2cc:	d503201f 	nop
    }
    close(fd);
     2d0:	b9425fe0 	ldr	w0, [sp, #604]
     2d4:	94000167 	bl	870 <close>
}
     2d8:	a9407bfd 	ldp	x29, x30, [sp]
     2dc:	910983ff 	add	sp, sp, #0x260
     2e0:	d65f03c0 	ret

00000000000002e4 <main>:

int
main(int argc, char *argv[])
{
     2e4:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     2e8:	910003fd 	mov	x29, sp
     2ec:	b9001fe0 	str	w0, [sp, #28]
     2f0:	f9000be1 	str	x1, [sp, #16]
    int i;
    
    if(argc < 2){
     2f4:	b9401fe0 	ldr	w0, [sp, #28]
     2f8:	7100041f 	cmp	w0, #0x1
     2fc:	540000ac 	b.gt	310 <main+0x2c>
        ls(".");
     300:	b0000000 	adrp	x0, 1000 <morecore+0x50>
     304:	9107e000 	add	x0, x0, #0x1f8
     308:	97ffff78 	bl	e8 <ls>
        exit();
     30c:	9400012c 	bl	7bc <exit>
    }
    for(i=1; i<argc; i++)
     310:	52800020 	mov	w0, #0x1                   	// #1
     314:	b9002fe0 	str	w0, [sp, #44]
     318:	1400000a 	b	340 <main+0x5c>
        ls(argv[i]);
     31c:	b9802fe0 	ldrsw	x0, [sp, #44]
     320:	d37df000 	lsl	x0, x0, #3
     324:	f9400be1 	ldr	x1, [sp, #16]
     328:	8b000020 	add	x0, x1, x0
     32c:	f9400000 	ldr	x0, [x0]
     330:	97ffff6e 	bl	e8 <ls>
    for(i=1; i<argc; i++)
     334:	b9402fe0 	ldr	w0, [sp, #44]
     338:	11000400 	add	w0, w0, #0x1
     33c:	b9002fe0 	str	w0, [sp, #44]
     340:	b9402fe1 	ldr	w1, [sp, #44]
     344:	b9401fe0 	ldr	w0, [sp, #28]
     348:	6b00003f 	cmp	w1, w0
     34c:	54fffe8b 	b.lt	31c <main+0x38>  // b.tstop
    exit();
     350:	9400011b 	bl	7bc <exit>

0000000000000354 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
     354:	d10083ff 	sub	sp, sp, #0x20
     358:	f90007e0 	str	x0, [sp, #8]
     35c:	f90003e1 	str	x1, [sp]
    char *os;
    
    os = s;
     360:	f94007e0 	ldr	x0, [sp, #8]
     364:	f9000fe0 	str	x0, [sp, #24]
    while((*s++ = *t++) != 0)
     368:	d503201f 	nop
     36c:	f94003e1 	ldr	x1, [sp]
     370:	91000420 	add	x0, x1, #0x1
     374:	f90003e0 	str	x0, [sp]
     378:	f94007e0 	ldr	x0, [sp, #8]
     37c:	91000402 	add	x2, x0, #0x1
     380:	f90007e2 	str	x2, [sp, #8]
     384:	39400021 	ldrb	w1, [x1]
     388:	39000001 	strb	w1, [x0]
     38c:	39400000 	ldrb	w0, [x0]
     390:	7100001f 	cmp	w0, #0x0
     394:	54fffec1 	b.ne	36c <strcpy+0x18>  // b.any
        ;
    return os;
     398:	f9400fe0 	ldr	x0, [sp, #24]
}
     39c:	910083ff 	add	sp, sp, #0x20
     3a0:	d65f03c0 	ret

00000000000003a4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     3a4:	d10043ff 	sub	sp, sp, #0x10
     3a8:	f90007e0 	str	x0, [sp, #8]
     3ac:	f90003e1 	str	x1, [sp]
    while(*p && *p == *q)
     3b0:	14000007 	b	3cc <strcmp+0x28>
        p++, q++;
     3b4:	f94007e0 	ldr	x0, [sp, #8]
     3b8:	91000400 	add	x0, x0, #0x1
     3bc:	f90007e0 	str	x0, [sp, #8]
     3c0:	f94003e0 	ldr	x0, [sp]
     3c4:	91000400 	add	x0, x0, #0x1
     3c8:	f90003e0 	str	x0, [sp]
    while(*p && *p == *q)
     3cc:	f94007e0 	ldr	x0, [sp, #8]
     3d0:	39400000 	ldrb	w0, [x0]
     3d4:	7100001f 	cmp	w0, #0x0
     3d8:	540000e0 	b.eq	3f4 <strcmp+0x50>  // b.none
     3dc:	f94007e0 	ldr	x0, [sp, #8]
     3e0:	39400001 	ldrb	w1, [x0]
     3e4:	f94003e0 	ldr	x0, [sp]
     3e8:	39400000 	ldrb	w0, [x0]
     3ec:	6b00003f 	cmp	w1, w0
     3f0:	54fffe20 	b.eq	3b4 <strcmp+0x10>  // b.none
    return (uchar)*p - (uchar)*q;
     3f4:	f94007e0 	ldr	x0, [sp, #8]
     3f8:	39400000 	ldrb	w0, [x0]
     3fc:	2a0003e1 	mov	w1, w0
     400:	f94003e0 	ldr	x0, [sp]
     404:	39400000 	ldrb	w0, [x0]
     408:	4b000020 	sub	w0, w1, w0
}
     40c:	910043ff 	add	sp, sp, #0x10
     410:	d65f03c0 	ret

0000000000000414 <strlen>:

uint
strlen(char *s)
{
     414:	d10083ff 	sub	sp, sp, #0x20
     418:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    for(n = 0; s[n]; n++)
     41c:	b9001fff 	str	wzr, [sp, #28]
     420:	14000004 	b	430 <strlen+0x1c>
     424:	b9401fe0 	ldr	w0, [sp, #28]
     428:	11000400 	add	w0, w0, #0x1
     42c:	b9001fe0 	str	w0, [sp, #28]
     430:	b9801fe0 	ldrsw	x0, [sp, #28]
     434:	f94007e1 	ldr	x1, [sp, #8]
     438:	8b000020 	add	x0, x1, x0
     43c:	39400000 	ldrb	w0, [x0]
     440:	7100001f 	cmp	w0, #0x0
     444:	54ffff01 	b.ne	424 <strlen+0x10>  // b.any
        ;
    return n;
     448:	b9401fe0 	ldr	w0, [sp, #28]
}
     44c:	910083ff 	add	sp, sp, #0x20
     450:	d65f03c0 	ret

0000000000000454 <memset>:

void*
memset(void *dst, int v, uint n)
{
     454:	d100c3ff 	sub	sp, sp, #0x30
     458:	f90007e0 	str	x0, [sp, #8]
     45c:	b90007e1 	str	w1, [sp, #4]
     460:	b90003e2 	str	w2, [sp]
	uint8	*p;
	uint8	c;
	uint32	val;
	uint32	*p4;

	p   = dst;
     464:	f94007e0 	ldr	x0, [sp, #8]
     468:	f90017e0 	str	x0, [sp, #40]
	c   = v & 0xff;
     46c:	b94007e0 	ldr	w0, [sp, #4]
     470:	39007fe0 	strb	w0, [sp, #31]
	val = (c << 24) | (c << 16) | (c << 8) | c;
     474:	39407fe1 	ldrb	w1, [sp, #31]
     478:	2a0103e0 	mov	w0, w1
     47c:	53185c00 	lsl	w0, w0, #8
     480:	0b010000 	add	w0, w0, w1
     484:	53103c00 	lsl	w0, w0, #16
     488:	2a0003e1 	mov	w1, w0
     48c:	39407fe0 	ldrb	w0, [sp, #31]
     490:	53185c00 	lsl	w0, w0, #8
     494:	2a000021 	orr	w1, w1, w0
     498:	39407fe0 	ldrb	w0, [sp, #31]
     49c:	2a000020 	orr	w0, w1, w0
     4a0:	b9001be0 	str	w0, [sp, #24]

	// set bytes before whole uint32
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
     4a4:	1400000a 	b	4cc <memset+0x78>
		*p = c;
     4a8:	f94017e0 	ldr	x0, [sp, #40]
     4ac:	39407fe1 	ldrb	w1, [sp, #31]
     4b0:	39000001 	strb	w1, [x0]
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
     4b4:	b94003e0 	ldr	w0, [sp]
     4b8:	51000400 	sub	w0, w0, #0x1
     4bc:	b90003e0 	str	w0, [sp]
     4c0:	f94017e0 	ldr	x0, [sp, #40]
     4c4:	91000400 	add	x0, x0, #0x1
     4c8:	f90017e0 	str	x0, [sp, #40]
     4cc:	b94003e0 	ldr	w0, [sp]
     4d0:	7100001f 	cmp	w0, #0x0
     4d4:	540000a0 	b.eq	4e8 <memset+0x94>  // b.none
     4d8:	f94017e0 	ldr	x0, [sp, #40]
     4dc:	92400400 	and	x0, x0, #0x3
     4e0:	f100001f 	cmp	x0, #0x0
     4e4:	54fffe21 	b.ne	4a8 <memset+0x54>  // b.any
	}

	// set memory 4 bytes a time
	p4 = (uint*)p;
     4e8:	f94017e0 	ldr	x0, [sp, #40]
     4ec:	f90013e0 	str	x0, [sp, #32]

	for (; n >= 4; n -= 4, p4++) {
     4f0:	1400000a 	b	518 <memset+0xc4>
		*p4 = val;
     4f4:	f94013e0 	ldr	x0, [sp, #32]
     4f8:	b9401be1 	ldr	w1, [sp, #24]
     4fc:	b9000001 	str	w1, [x0]
	for (; n >= 4; n -= 4, p4++) {
     500:	b94003e0 	ldr	w0, [sp]
     504:	51001000 	sub	w0, w0, #0x4
     508:	b90003e0 	str	w0, [sp]
     50c:	f94013e0 	ldr	x0, [sp, #32]
     510:	91001000 	add	x0, x0, #0x4
     514:	f90013e0 	str	x0, [sp, #32]
     518:	b94003e0 	ldr	w0, [sp]
     51c:	71000c1f 	cmp	w0, #0x3
     520:	54fffea8 	b.hi	4f4 <memset+0xa0>  // b.pmore
	}

	// set leftover one byte a time
	p = (uint8*)p4;
     524:	f94013e0 	ldr	x0, [sp, #32]
     528:	f90017e0 	str	x0, [sp, #40]

	for (; n > 0; n--, p++) {
     52c:	1400000a 	b	554 <memset+0x100>
		*p = c;
     530:	f94017e0 	ldr	x0, [sp, #40]
     534:	39407fe1 	ldrb	w1, [sp, #31]
     538:	39000001 	strb	w1, [x0]
	for (; n > 0; n--, p++) {
     53c:	b94003e0 	ldr	w0, [sp]
     540:	51000400 	sub	w0, w0, #0x1
     544:	b90003e0 	str	w0, [sp]
     548:	f94017e0 	ldr	x0, [sp, #40]
     54c:	91000400 	add	x0, x0, #0x1
     550:	f90017e0 	str	x0, [sp, #40]
     554:	b94003e0 	ldr	w0, [sp]
     558:	7100001f 	cmp	w0, #0x0
     55c:	54fffea1 	b.ne	530 <memset+0xdc>  // b.any
	}

	return dst;
     560:	f94007e0 	ldr	x0, [sp, #8]
}
     564:	9100c3ff 	add	sp, sp, #0x30
     568:	d65f03c0 	ret

000000000000056c <strchr>:

char*
strchr(const char *s, char c)
{
     56c:	d10043ff 	sub	sp, sp, #0x10
     570:	f90007e0 	str	x0, [sp, #8]
     574:	39001fe1 	strb	w1, [sp, #7]
    for(; *s; s++)
     578:	1400000b 	b	5a4 <strchr+0x38>
        if(*s == c)
     57c:	f94007e0 	ldr	x0, [sp, #8]
     580:	39400000 	ldrb	w0, [x0]
     584:	39401fe1 	ldrb	w1, [sp, #7]
     588:	6b00003f 	cmp	w1, w0
     58c:	54000061 	b.ne	598 <strchr+0x2c>  // b.any
            return (char*)s;
     590:	f94007e0 	ldr	x0, [sp, #8]
     594:	14000009 	b	5b8 <strchr+0x4c>
    for(; *s; s++)
     598:	f94007e0 	ldr	x0, [sp, #8]
     59c:	91000400 	add	x0, x0, #0x1
     5a0:	f90007e0 	str	x0, [sp, #8]
     5a4:	f94007e0 	ldr	x0, [sp, #8]
     5a8:	39400000 	ldrb	w0, [x0]
     5ac:	7100001f 	cmp	w0, #0x0
     5b0:	54fffe61 	b.ne	57c <strchr+0x10>  // b.any
    return 0;
     5b4:	d2800000 	mov	x0, #0x0                   	// #0
}
     5b8:	910043ff 	add	sp, sp, #0x10
     5bc:	d65f03c0 	ret

00000000000005c0 <gets>:

char*
gets(char *buf, int max)
{
     5c0:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     5c4:	910003fd 	mov	x29, sp
     5c8:	f9000fe0 	str	x0, [sp, #24]
     5cc:	b90017e1 	str	w1, [sp, #20]
    int i, cc;
    char c;
    
    for(i=0; i+1 < max; ){
     5d0:	b9002fff 	str	wzr, [sp, #44]
     5d4:	14000018 	b	634 <gets+0x74>
        cc = read(0, &c, 1);
     5d8:	91009fe0 	add	x0, sp, #0x27
     5dc:	52800022 	mov	w2, #0x1                   	// #1
     5e0:	aa0003e1 	mov	x1, x0
     5e4:	52800000 	mov	w0, #0x0                   	// #0
     5e8:	94000090 	bl	828 <read>
     5ec:	b9002be0 	str	w0, [sp, #40]
        if(cc < 1)
     5f0:	b9402be0 	ldr	w0, [sp, #40]
     5f4:	7100001f 	cmp	w0, #0x0
     5f8:	540002ad 	b.le	64c <gets+0x8c>
            break;
        buf[i++] = c;
     5fc:	b9402fe0 	ldr	w0, [sp, #44]
     600:	11000401 	add	w1, w0, #0x1
     604:	b9002fe1 	str	w1, [sp, #44]
     608:	93407c00 	sxtw	x0, w0
     60c:	f9400fe1 	ldr	x1, [sp, #24]
     610:	8b000020 	add	x0, x1, x0
     614:	39409fe1 	ldrb	w1, [sp, #39]
     618:	39000001 	strb	w1, [x0]
        if(c == '\n' || c == '\r')
     61c:	39409fe0 	ldrb	w0, [sp, #39]
     620:	7100281f 	cmp	w0, #0xa
     624:	54000160 	b.eq	650 <gets+0x90>  // b.none
     628:	39409fe0 	ldrb	w0, [sp, #39]
     62c:	7100341f 	cmp	w0, #0xd
     630:	54000100 	b.eq	650 <gets+0x90>  // b.none
    for(i=0; i+1 < max; ){
     634:	b9402fe0 	ldr	w0, [sp, #44]
     638:	11000400 	add	w0, w0, #0x1
     63c:	b94017e1 	ldr	w1, [sp, #20]
     640:	6b00003f 	cmp	w1, w0
     644:	54fffcac 	b.gt	5d8 <gets+0x18>
     648:	14000002 	b	650 <gets+0x90>
            break;
     64c:	d503201f 	nop
            break;
    }
    buf[i] = '\0';
     650:	b9802fe0 	ldrsw	x0, [sp, #44]
     654:	f9400fe1 	ldr	x1, [sp, #24]
     658:	8b000020 	add	x0, x1, x0
     65c:	3900001f 	strb	wzr, [x0]
    return buf;
     660:	f9400fe0 	ldr	x0, [sp, #24]
}
     664:	a8c37bfd 	ldp	x29, x30, [sp], #48
     668:	d65f03c0 	ret

000000000000066c <stat>:

int
stat(char *n, struct stat *st)
{
     66c:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     670:	910003fd 	mov	x29, sp
     674:	f9000fe0 	str	x0, [sp, #24]
     678:	f9000be1 	str	x1, [sp, #16]
    int fd;
    int r;
    
    fd = open(n, O_RDONLY);
     67c:	52800001 	mov	w1, #0x0                   	// #0
     680:	f9400fe0 	ldr	x0, [sp, #24]
     684:	94000096 	bl	8dc <open>
     688:	b9002fe0 	str	w0, [sp, #44]
    if(fd < 0)
     68c:	b9402fe0 	ldr	w0, [sp, #44]
     690:	7100001f 	cmp	w0, #0x0
     694:	5400006a 	b.ge	6a0 <stat+0x34>  // b.tcont
        return -1;
     698:	12800000 	mov	w0, #0xffffffff            	// #-1
     69c:	14000008 	b	6bc <stat+0x50>
    r = fstat(fd, st);
     6a0:	f9400be1 	ldr	x1, [sp, #16]
     6a4:	b9402fe0 	ldr	w0, [sp, #44]
     6a8:	940000a8 	bl	948 <fstat>
     6ac:	b9002be0 	str	w0, [sp, #40]
    close(fd);
     6b0:	b9402fe0 	ldr	w0, [sp, #44]
     6b4:	9400006f 	bl	870 <close>
    return r;
     6b8:	b9402be0 	ldr	w0, [sp, #40]
}
     6bc:	a8c37bfd 	ldp	x29, x30, [sp], #48
     6c0:	d65f03c0 	ret

00000000000006c4 <atoi>:

int
atoi(const char *s)
{
     6c4:	d10083ff 	sub	sp, sp, #0x20
     6c8:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    n = 0;
     6cc:	b9001fff 	str	wzr, [sp, #28]
    while('0' <= *s && *s <= '9')
     6d0:	1400000e 	b	708 <atoi+0x44>
        n = n*10 + *s++ - '0';
     6d4:	b9401fe1 	ldr	w1, [sp, #28]
     6d8:	2a0103e0 	mov	w0, w1
     6dc:	531e7400 	lsl	w0, w0, #2
     6e0:	0b010000 	add	w0, w0, w1
     6e4:	531f7800 	lsl	w0, w0, #1
     6e8:	2a0003e2 	mov	w2, w0
     6ec:	f94007e0 	ldr	x0, [sp, #8]
     6f0:	91000401 	add	x1, x0, #0x1
     6f4:	f90007e1 	str	x1, [sp, #8]
     6f8:	39400000 	ldrb	w0, [x0]
     6fc:	0b000040 	add	w0, w2, w0
     700:	5100c000 	sub	w0, w0, #0x30
     704:	b9001fe0 	str	w0, [sp, #28]
    while('0' <= *s && *s <= '9')
     708:	f94007e0 	ldr	x0, [sp, #8]
     70c:	39400000 	ldrb	w0, [x0]
     710:	7100bc1f 	cmp	w0, #0x2f
     714:	540000a9 	b.ls	728 <atoi+0x64>  // b.plast
     718:	f94007e0 	ldr	x0, [sp, #8]
     71c:	39400000 	ldrb	w0, [x0]
     720:	7100e41f 	cmp	w0, #0x39
     724:	54fffd89 	b.ls	6d4 <atoi+0x10>  // b.plast
    return n;
     728:	b9401fe0 	ldr	w0, [sp, #28]
}
     72c:	910083ff 	add	sp, sp, #0x20
     730:	d65f03c0 	ret

0000000000000734 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     734:	d100c3ff 	sub	sp, sp, #0x30
     738:	f9000fe0 	str	x0, [sp, #24]
     73c:	f9000be1 	str	x1, [sp, #16]
     740:	b9000fe2 	str	w2, [sp, #12]
    char *dst, *src;
    
    dst = vdst;
     744:	f9400fe0 	ldr	x0, [sp, #24]
     748:	f90017e0 	str	x0, [sp, #40]
    src = vsrc;
     74c:	f9400be0 	ldr	x0, [sp, #16]
     750:	f90013e0 	str	x0, [sp, #32]
    while(n-- > 0)
     754:	14000009 	b	778 <memmove+0x44>
        *dst++ = *src++;
     758:	f94013e1 	ldr	x1, [sp, #32]
     75c:	91000420 	add	x0, x1, #0x1
     760:	f90013e0 	str	x0, [sp, #32]
     764:	f94017e0 	ldr	x0, [sp, #40]
     768:	91000402 	add	x2, x0, #0x1
     76c:	f90017e2 	str	x2, [sp, #40]
     770:	39400021 	ldrb	w1, [x1]
     774:	39000001 	strb	w1, [x0]
    while(n-- > 0)
     778:	b9400fe0 	ldr	w0, [sp, #12]
     77c:	51000401 	sub	w1, w0, #0x1
     780:	b9000fe1 	str	w1, [sp, #12]
     784:	7100001f 	cmp	w0, #0x0
     788:	54fffe8c 	b.gt	758 <memmove+0x24>
    return vdst;
     78c:	f9400fe0 	ldr	x0, [sp, #24]
}
     790:	9100c3ff 	add	sp, sp, #0x30
     794:	d65f03c0 	ret

0000000000000798 <fork>:
     798:	f81f8fe4 	str	x4, [sp, #-8]!
     79c:	aa0303e4 	mov	x4, x3
     7a0:	aa0203e3 	mov	x3, x2
     7a4:	aa0103e2 	mov	x2, x1
     7a8:	aa0003e1 	mov	x1, x0
     7ac:	d2800020 	mov	x0, #0x1                   	// #1
     7b0:	d4000001 	svc	#0x0
     7b4:	f84087e4 	ldr	x4, [sp], #8
     7b8:	d61f03c0 	br	x30

00000000000007bc <exit>:
     7bc:	f81f8fe4 	str	x4, [sp, #-8]!
     7c0:	aa0303e4 	mov	x4, x3
     7c4:	aa0203e3 	mov	x3, x2
     7c8:	aa0103e2 	mov	x2, x1
     7cc:	aa0003e1 	mov	x1, x0
     7d0:	d2800040 	mov	x0, #0x2                   	// #2
     7d4:	d4000001 	svc	#0x0
     7d8:	f84087e4 	ldr	x4, [sp], #8
     7dc:	d61f03c0 	br	x30

00000000000007e0 <wait>:
     7e0:	f81f8fe4 	str	x4, [sp, #-8]!
     7e4:	aa0303e4 	mov	x4, x3
     7e8:	aa0203e3 	mov	x3, x2
     7ec:	aa0103e2 	mov	x2, x1
     7f0:	aa0003e1 	mov	x1, x0
     7f4:	d2800060 	mov	x0, #0x3                   	// #3
     7f8:	d4000001 	svc	#0x0
     7fc:	f84087e4 	ldr	x4, [sp], #8
     800:	d61f03c0 	br	x30

0000000000000804 <pipe>:
     804:	f81f8fe4 	str	x4, [sp, #-8]!
     808:	aa0303e4 	mov	x4, x3
     80c:	aa0203e3 	mov	x3, x2
     810:	aa0103e2 	mov	x2, x1
     814:	aa0003e1 	mov	x1, x0
     818:	d2800080 	mov	x0, #0x4                   	// #4
     81c:	d4000001 	svc	#0x0
     820:	f84087e4 	ldr	x4, [sp], #8
     824:	d61f03c0 	br	x30

0000000000000828 <read>:
     828:	f81f8fe4 	str	x4, [sp, #-8]!
     82c:	aa0303e4 	mov	x4, x3
     830:	aa0203e3 	mov	x3, x2
     834:	aa0103e2 	mov	x2, x1
     838:	aa0003e1 	mov	x1, x0
     83c:	d28000a0 	mov	x0, #0x5                   	// #5
     840:	d4000001 	svc	#0x0
     844:	f84087e4 	ldr	x4, [sp], #8
     848:	d61f03c0 	br	x30

000000000000084c <write>:
     84c:	f81f8fe4 	str	x4, [sp, #-8]!
     850:	aa0303e4 	mov	x4, x3
     854:	aa0203e3 	mov	x3, x2
     858:	aa0103e2 	mov	x2, x1
     85c:	aa0003e1 	mov	x1, x0
     860:	d2800200 	mov	x0, #0x10                  	// #16
     864:	d4000001 	svc	#0x0
     868:	f84087e4 	ldr	x4, [sp], #8
     86c:	d61f03c0 	br	x30

0000000000000870 <close>:
     870:	f81f8fe4 	str	x4, [sp, #-8]!
     874:	aa0303e4 	mov	x4, x3
     878:	aa0203e3 	mov	x3, x2
     87c:	aa0103e2 	mov	x2, x1
     880:	aa0003e1 	mov	x1, x0
     884:	d28002a0 	mov	x0, #0x15                  	// #21
     888:	d4000001 	svc	#0x0
     88c:	f84087e4 	ldr	x4, [sp], #8
     890:	d61f03c0 	br	x30

0000000000000894 <kill>:
     894:	f81f8fe4 	str	x4, [sp, #-8]!
     898:	aa0303e4 	mov	x4, x3
     89c:	aa0203e3 	mov	x3, x2
     8a0:	aa0103e2 	mov	x2, x1
     8a4:	aa0003e1 	mov	x1, x0
     8a8:	d28000c0 	mov	x0, #0x6                   	// #6
     8ac:	d4000001 	svc	#0x0
     8b0:	f84087e4 	ldr	x4, [sp], #8
     8b4:	d61f03c0 	br	x30

00000000000008b8 <exec>:
     8b8:	f81f8fe4 	str	x4, [sp, #-8]!
     8bc:	aa0303e4 	mov	x4, x3
     8c0:	aa0203e3 	mov	x3, x2
     8c4:	aa0103e2 	mov	x2, x1
     8c8:	aa0003e1 	mov	x1, x0
     8cc:	d28000e0 	mov	x0, #0x7                   	// #7
     8d0:	d4000001 	svc	#0x0
     8d4:	f84087e4 	ldr	x4, [sp], #8
     8d8:	d61f03c0 	br	x30

00000000000008dc <open>:
     8dc:	f81f8fe4 	str	x4, [sp, #-8]!
     8e0:	aa0303e4 	mov	x4, x3
     8e4:	aa0203e3 	mov	x3, x2
     8e8:	aa0103e2 	mov	x2, x1
     8ec:	aa0003e1 	mov	x1, x0
     8f0:	d28001e0 	mov	x0, #0xf                   	// #15
     8f4:	d4000001 	svc	#0x0
     8f8:	f84087e4 	ldr	x4, [sp], #8
     8fc:	d61f03c0 	br	x30

0000000000000900 <mknod>:
     900:	f81f8fe4 	str	x4, [sp, #-8]!
     904:	aa0303e4 	mov	x4, x3
     908:	aa0203e3 	mov	x3, x2
     90c:	aa0103e2 	mov	x2, x1
     910:	aa0003e1 	mov	x1, x0
     914:	d2800220 	mov	x0, #0x11                  	// #17
     918:	d4000001 	svc	#0x0
     91c:	f84087e4 	ldr	x4, [sp], #8
     920:	d61f03c0 	br	x30

0000000000000924 <unlink>:
     924:	f81f8fe4 	str	x4, [sp, #-8]!
     928:	aa0303e4 	mov	x4, x3
     92c:	aa0203e3 	mov	x3, x2
     930:	aa0103e2 	mov	x2, x1
     934:	aa0003e1 	mov	x1, x0
     938:	d2800240 	mov	x0, #0x12                  	// #18
     93c:	d4000001 	svc	#0x0
     940:	f84087e4 	ldr	x4, [sp], #8
     944:	d61f03c0 	br	x30

0000000000000948 <fstat>:
     948:	f81f8fe4 	str	x4, [sp, #-8]!
     94c:	aa0303e4 	mov	x4, x3
     950:	aa0203e3 	mov	x3, x2
     954:	aa0103e2 	mov	x2, x1
     958:	aa0003e1 	mov	x1, x0
     95c:	d2800100 	mov	x0, #0x8                   	// #8
     960:	d4000001 	svc	#0x0
     964:	f84087e4 	ldr	x4, [sp], #8
     968:	d61f03c0 	br	x30

000000000000096c <link>:
     96c:	f81f8fe4 	str	x4, [sp, #-8]!
     970:	aa0303e4 	mov	x4, x3
     974:	aa0203e3 	mov	x3, x2
     978:	aa0103e2 	mov	x2, x1
     97c:	aa0003e1 	mov	x1, x0
     980:	d2800260 	mov	x0, #0x13                  	// #19
     984:	d4000001 	svc	#0x0
     988:	f84087e4 	ldr	x4, [sp], #8
     98c:	d61f03c0 	br	x30

0000000000000990 <mkdir>:
     990:	f81f8fe4 	str	x4, [sp, #-8]!
     994:	aa0303e4 	mov	x4, x3
     998:	aa0203e3 	mov	x3, x2
     99c:	aa0103e2 	mov	x2, x1
     9a0:	aa0003e1 	mov	x1, x0
     9a4:	d2800280 	mov	x0, #0x14                  	// #20
     9a8:	d4000001 	svc	#0x0
     9ac:	f84087e4 	ldr	x4, [sp], #8
     9b0:	d61f03c0 	br	x30

00000000000009b4 <chdir>:
     9b4:	f81f8fe4 	str	x4, [sp, #-8]!
     9b8:	aa0303e4 	mov	x4, x3
     9bc:	aa0203e3 	mov	x3, x2
     9c0:	aa0103e2 	mov	x2, x1
     9c4:	aa0003e1 	mov	x1, x0
     9c8:	d2800120 	mov	x0, #0x9                   	// #9
     9cc:	d4000001 	svc	#0x0
     9d0:	f84087e4 	ldr	x4, [sp], #8
     9d4:	d61f03c0 	br	x30

00000000000009d8 <dup>:
     9d8:	f81f8fe4 	str	x4, [sp, #-8]!
     9dc:	aa0303e4 	mov	x4, x3
     9e0:	aa0203e3 	mov	x3, x2
     9e4:	aa0103e2 	mov	x2, x1
     9e8:	aa0003e1 	mov	x1, x0
     9ec:	d2800140 	mov	x0, #0xa                   	// #10
     9f0:	d4000001 	svc	#0x0
     9f4:	f84087e4 	ldr	x4, [sp], #8
     9f8:	d61f03c0 	br	x30

00000000000009fc <getpid>:
     9fc:	f81f8fe4 	str	x4, [sp, #-8]!
     a00:	aa0303e4 	mov	x4, x3
     a04:	aa0203e3 	mov	x3, x2
     a08:	aa0103e2 	mov	x2, x1
     a0c:	aa0003e1 	mov	x1, x0
     a10:	d2800160 	mov	x0, #0xb                   	// #11
     a14:	d4000001 	svc	#0x0
     a18:	f84087e4 	ldr	x4, [sp], #8
     a1c:	d61f03c0 	br	x30

0000000000000a20 <sbrk>:
     a20:	f81f8fe4 	str	x4, [sp, #-8]!
     a24:	aa0303e4 	mov	x4, x3
     a28:	aa0203e3 	mov	x3, x2
     a2c:	aa0103e2 	mov	x2, x1
     a30:	aa0003e1 	mov	x1, x0
     a34:	d2800180 	mov	x0, #0xc                   	// #12
     a38:	d4000001 	svc	#0x0
     a3c:	f84087e4 	ldr	x4, [sp], #8
     a40:	d61f03c0 	br	x30

0000000000000a44 <sleep>:
     a44:	f81f8fe4 	str	x4, [sp, #-8]!
     a48:	aa0303e4 	mov	x4, x3
     a4c:	aa0203e3 	mov	x3, x2
     a50:	aa0103e2 	mov	x2, x1
     a54:	aa0003e1 	mov	x1, x0
     a58:	d28001a0 	mov	x0, #0xd                   	// #13
     a5c:	d4000001 	svc	#0x0
     a60:	f84087e4 	ldr	x4, [sp], #8
     a64:	d61f03c0 	br	x30

0000000000000a68 <uptime>:
     a68:	f81f8fe4 	str	x4, [sp, #-8]!
     a6c:	aa0303e4 	mov	x4, x3
     a70:	aa0203e3 	mov	x3, x2
     a74:	aa0103e2 	mov	x2, x1
     a78:	aa0003e1 	mov	x1, x0
     a7c:	d28001c0 	mov	x0, #0xe                   	// #14
     a80:	d4000001 	svc	#0x0
     a84:	f84087e4 	ldr	x4, [sp], #8
     a88:	d61f03c0 	br	x30

0000000000000a8c <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     a8c:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
     a90:	910003fd 	mov	x29, sp
     a94:	b9001fe0 	str	w0, [sp, #28]
     a98:	39006fe1 	strb	w1, [sp, #27]
    write(fd, &c, 1);
     a9c:	91006fe0 	add	x0, sp, #0x1b
     aa0:	52800022 	mov	w2, #0x1                   	// #1
     aa4:	aa0003e1 	mov	x1, x0
     aa8:	b9401fe0 	ldr	w0, [sp, #28]
     aac:	97ffff68 	bl	84c <write>
}
     ab0:	d503201f 	nop
     ab4:	a8c27bfd 	ldp	x29, x30, [sp], #32
     ab8:	d65f03c0 	ret

0000000000000abc <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     abc:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
     ac0:	910003fd 	mov	x29, sp
     ac4:	b9001fe0 	str	w0, [sp, #28]
     ac8:	b9001be1 	str	w1, [sp, #24]
     acc:	b90017e2 	str	w2, [sp, #20]
     ad0:	b90013e3 	str	w3, [sp, #16]
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
     ad4:	b9003bff 	str	wzr, [sp, #56]
    if(sgn && xx < 0){
     ad8:	b94013e0 	ldr	w0, [sp, #16]
     adc:	7100001f 	cmp	w0, #0x0
     ae0:	54000140 	b.eq	b08 <printint+0x4c>  // b.none
     ae4:	b9401be0 	ldr	w0, [sp, #24]
     ae8:	7100001f 	cmp	w0, #0x0
     aec:	540000ea 	b.ge	b08 <printint+0x4c>  // b.tcont
        neg = 1;
     af0:	52800020 	mov	w0, #0x1                   	// #1
     af4:	b9003be0 	str	w0, [sp, #56]
        x = -xx;
     af8:	b9401be0 	ldr	w0, [sp, #24]
     afc:	4b0003e0 	neg	w0, w0
     b00:	b90037e0 	str	w0, [sp, #52]
     b04:	14000003 	b	b10 <printint+0x54>
    } else {
        x = xx;
     b08:	b9401be0 	ldr	w0, [sp, #24]
     b0c:	b90037e0 	str	w0, [sp, #52]
    }
    
    i = 0;
     b10:	b9003fff 	str	wzr, [sp, #60]
    do{
        buf[i++] = digits[x % base];
     b14:	b94017e1 	ldr	w1, [sp, #20]
     b18:	b94037e0 	ldr	w0, [sp, #52]
     b1c:	1ac10802 	udiv	w2, w0, w1
     b20:	1b017c41 	mul	w1, w2, w1
     b24:	4b010003 	sub	w3, w0, w1
     b28:	b9403fe0 	ldr	w0, [sp, #60]
     b2c:	11000401 	add	w1, w0, #0x1
     b30:	b9003fe1 	str	w1, [sp, #60]
     b34:	b0000001 	adrp	x1, 1000 <morecore+0x50>
     b38:	91082022 	add	x2, x1, #0x208
     b3c:	2a0303e1 	mov	w1, w3
     b40:	38616842 	ldrb	w2, [x2, x1]
     b44:	93407c00 	sxtw	x0, w0
     b48:	910083e1 	add	x1, sp, #0x20
     b4c:	38206822 	strb	w2, [x1, x0]
    }while((x /= base) != 0);
     b50:	b94017e0 	ldr	w0, [sp, #20]
     b54:	b94037e1 	ldr	w1, [sp, #52]
     b58:	1ac00820 	udiv	w0, w1, w0
     b5c:	b90037e0 	str	w0, [sp, #52]
     b60:	b94037e0 	ldr	w0, [sp, #52]
     b64:	7100001f 	cmp	w0, #0x0
     b68:	54fffd61 	b.ne	b14 <printint+0x58>  // b.any
    if(neg)
     b6c:	b9403be0 	ldr	w0, [sp, #56]
     b70:	7100001f 	cmp	w0, #0x0
     b74:	540001e0 	b.eq	bb0 <printint+0xf4>  // b.none
        buf[i++] = '-';
     b78:	b9403fe0 	ldr	w0, [sp, #60]
     b7c:	11000401 	add	w1, w0, #0x1
     b80:	b9003fe1 	str	w1, [sp, #60]
     b84:	93407c00 	sxtw	x0, w0
     b88:	910083e1 	add	x1, sp, #0x20
     b8c:	528005a2 	mov	w2, #0x2d                  	// #45
     b90:	38206822 	strb	w2, [x1, x0]
    
    while(--i >= 0)
     b94:	14000007 	b	bb0 <printint+0xf4>
        putc(fd, buf[i]);
     b98:	b9803fe0 	ldrsw	x0, [sp, #60]
     b9c:	910083e1 	add	x1, sp, #0x20
     ba0:	38606820 	ldrb	w0, [x1, x0]
     ba4:	2a0003e1 	mov	w1, w0
     ba8:	b9401fe0 	ldr	w0, [sp, #28]
     bac:	97ffffb8 	bl	a8c <putc>
    while(--i >= 0)
     bb0:	b9403fe0 	ldr	w0, [sp, #60]
     bb4:	51000400 	sub	w0, w0, #0x1
     bb8:	b9003fe0 	str	w0, [sp, #60]
     bbc:	b9403fe0 	ldr	w0, [sp, #60]
     bc0:	7100001f 	cmp	w0, #0x0
     bc4:	54fffeaa 	b.ge	b98 <printint+0xdc>  // b.tcont
}
     bc8:	d503201f 	nop
     bcc:	d503201f 	nop
     bd0:	a8c47bfd 	ldp	x29, x30, [sp], #64
     bd4:	d65f03c0 	ret

0000000000000bd8 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     bd8:	a9b17bfd 	stp	x29, x30, [sp, #-240]!
     bdc:	910003fd 	mov	x29, sp
     be0:	b9001fe0 	str	w0, [sp, #28]
     be4:	f9000be1 	str	x1, [sp, #16]
     be8:	f90063e2 	str	x2, [sp, #192]
     bec:	f90067e3 	str	x3, [sp, #200]
     bf0:	f9006be4 	str	x4, [sp, #208]
     bf4:	f9006fe5 	str	x5, [sp, #216]
     bf8:	f90073e6 	str	x6, [sp, #224]
     bfc:	f90077e7 	str	x7, [sp, #232]
     c00:	3d8013e0 	str	q0, [sp, #64]
     c04:	3d8017e1 	str	q1, [sp, #80]
     c08:	3d801be2 	str	q2, [sp, #96]
     c0c:	3d801fe3 	str	q3, [sp, #112]
     c10:	3d8023e4 	str	q4, [sp, #128]
     c14:	3d8027e5 	str	q5, [sp, #144]
     c18:	3d802be6 	str	q6, [sp, #160]
     c1c:	3d802fe7 	str	q7, [sp, #176]
    char *s;
    int c, i, state;
    uint64 *ap;
    
    state = 0;
     c20:	b90033ff 	str	wzr, [sp, #48]
    ap = (uint64*)(void*)&fmt + 22;
     c24:	910043e0 	add	x0, sp, #0x10
     c28:	9102c000 	add	x0, x0, #0xb0
     c2c:	f90017e0 	str	x0, [sp, #40]
    for(i = 0; fmt[i]; i++){
     c30:	b90037ff 	str	wzr, [sp, #52]
     c34:	14000076 	b	e0c <printf+0x234>
        c = fmt[i] & 0xff;
     c38:	f9400be1 	ldr	x1, [sp, #16]
     c3c:	b98037e0 	ldrsw	x0, [sp, #52]
     c40:	8b000020 	add	x0, x1, x0
     c44:	39400000 	ldrb	w0, [x0]
     c48:	b90027e0 	str	w0, [sp, #36]
        if(state == 0){
     c4c:	b94033e0 	ldr	w0, [sp, #48]
     c50:	7100001f 	cmp	w0, #0x0
     c54:	540001a1 	b.ne	c88 <printf+0xb0>  // b.any
            if(c == '%'){
     c58:	b94027e0 	ldr	w0, [sp, #36]
     c5c:	7100941f 	cmp	w0, #0x25
     c60:	54000081 	b.ne	c70 <printf+0x98>  // b.any
                state = '%';
     c64:	528004a0 	mov	w0, #0x25                  	// #37
     c68:	b90033e0 	str	w0, [sp, #48]
     c6c:	14000065 	b	e00 <printf+0x228>
            } else {
                putc(fd, c);
     c70:	b94027e0 	ldr	w0, [sp, #36]
     c74:	12001c00 	and	w0, w0, #0xff
     c78:	2a0003e1 	mov	w1, w0
     c7c:	b9401fe0 	ldr	w0, [sp, #28]
     c80:	97ffff83 	bl	a8c <putc>
     c84:	1400005f 	b	e00 <printf+0x228>
            }
        } else if(state == '%'){
     c88:	b94033e0 	ldr	w0, [sp, #48]
     c8c:	7100941f 	cmp	w0, #0x25
     c90:	54000b81 	b.ne	e00 <printf+0x228>  // b.any
            if(c == 'd'){
     c94:	b94027e0 	ldr	w0, [sp, #36]
     c98:	7101901f 	cmp	w0, #0x64
     c9c:	54000181 	b.ne	ccc <printf+0xf4>  // b.any
                printint(fd, *ap, 10, 1);
     ca0:	f94017e0 	ldr	x0, [sp, #40]
     ca4:	f9400000 	ldr	x0, [x0]
     ca8:	52800023 	mov	w3, #0x1                   	// #1
     cac:	52800142 	mov	w2, #0xa                   	// #10
     cb0:	2a0003e1 	mov	w1, w0
     cb4:	b9401fe0 	ldr	w0, [sp, #28]
     cb8:	97ffff81 	bl	abc <printint>
                ap++;
     cbc:	f94017e0 	ldr	x0, [sp, #40]
     cc0:	91002000 	add	x0, x0, #0x8
     cc4:	f90017e0 	str	x0, [sp, #40]
     cc8:	1400004d 	b	dfc <printf+0x224>
            } else if(c == 'x' || c == 'p'){
     ccc:	b94027e0 	ldr	w0, [sp, #36]
     cd0:	7101e01f 	cmp	w0, #0x78
     cd4:	54000080 	b.eq	ce4 <printf+0x10c>  // b.none
     cd8:	b94027e0 	ldr	w0, [sp, #36]
     cdc:	7101c01f 	cmp	w0, #0x70
     ce0:	54000181 	b.ne	d10 <printf+0x138>  // b.any
                printint(fd, *ap, 16, 0);
     ce4:	f94017e0 	ldr	x0, [sp, #40]
     ce8:	f9400000 	ldr	x0, [x0]
     cec:	52800003 	mov	w3, #0x0                   	// #0
     cf0:	52800202 	mov	w2, #0x10                  	// #16
     cf4:	2a0003e1 	mov	w1, w0
     cf8:	b9401fe0 	ldr	w0, [sp, #28]
     cfc:	97ffff70 	bl	abc <printint>
                ap++;
     d00:	f94017e0 	ldr	x0, [sp, #40]
     d04:	91002000 	add	x0, x0, #0x8
     d08:	f90017e0 	str	x0, [sp, #40]
     d0c:	1400003c 	b	dfc <printf+0x224>
            } else if(c == 's'){
     d10:	b94027e0 	ldr	w0, [sp, #36]
     d14:	7101cc1f 	cmp	w0, #0x73
     d18:	54000361 	b.ne	d84 <printf+0x1ac>  // b.any
                s = (char*)*ap;
     d1c:	f94017e0 	ldr	x0, [sp, #40]
     d20:	f9400000 	ldr	x0, [x0]
     d24:	f9001fe0 	str	x0, [sp, #56]
                ap++;
     d28:	f94017e0 	ldr	x0, [sp, #40]
     d2c:	91002000 	add	x0, x0, #0x8
     d30:	f90017e0 	str	x0, [sp, #40]
                if(s == 0)
     d34:	f9401fe0 	ldr	x0, [sp, #56]
     d38:	f100001f 	cmp	x0, #0x0
     d3c:	540001a1 	b.ne	d70 <printf+0x198>  // b.any
                    s = "(null)";
     d40:	b0000000 	adrp	x0, 1000 <morecore+0x50>
     d44:	91080000 	add	x0, x0, #0x200
     d48:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
     d4c:	14000009 	b	d70 <printf+0x198>
                    putc(fd, *s);
     d50:	f9401fe0 	ldr	x0, [sp, #56]
     d54:	39400000 	ldrb	w0, [x0]
     d58:	2a0003e1 	mov	w1, w0
     d5c:	b9401fe0 	ldr	w0, [sp, #28]
     d60:	97ffff4b 	bl	a8c <putc>
                    s++;
     d64:	f9401fe0 	ldr	x0, [sp, #56]
     d68:	91000400 	add	x0, x0, #0x1
     d6c:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
     d70:	f9401fe0 	ldr	x0, [sp, #56]
     d74:	39400000 	ldrb	w0, [x0]
     d78:	7100001f 	cmp	w0, #0x0
     d7c:	54fffea1 	b.ne	d50 <printf+0x178>  // b.any
     d80:	1400001f 	b	dfc <printf+0x224>
                }
            } else if(c == 'c'){
     d84:	b94027e0 	ldr	w0, [sp, #36]
     d88:	71018c1f 	cmp	w0, #0x63
     d8c:	54000161 	b.ne	db8 <printf+0x1e0>  // b.any
                putc(fd, *ap);
     d90:	f94017e0 	ldr	x0, [sp, #40]
     d94:	f9400000 	ldr	x0, [x0]
     d98:	12001c00 	and	w0, w0, #0xff
     d9c:	2a0003e1 	mov	w1, w0
     da0:	b9401fe0 	ldr	w0, [sp, #28]
     da4:	97ffff3a 	bl	a8c <putc>
                ap++;
     da8:	f94017e0 	ldr	x0, [sp, #40]
     dac:	91002000 	add	x0, x0, #0x8
     db0:	f90017e0 	str	x0, [sp, #40]
     db4:	14000012 	b	dfc <printf+0x224>
            } else if(c == '%'){
     db8:	b94027e0 	ldr	w0, [sp, #36]
     dbc:	7100941f 	cmp	w0, #0x25
     dc0:	540000e1 	b.ne	ddc <printf+0x204>  // b.any
                putc(fd, c);
     dc4:	b94027e0 	ldr	w0, [sp, #36]
     dc8:	12001c00 	and	w0, w0, #0xff
     dcc:	2a0003e1 	mov	w1, w0
     dd0:	b9401fe0 	ldr	w0, [sp, #28]
     dd4:	97ffff2e 	bl	a8c <putc>
     dd8:	14000009 	b	dfc <printf+0x224>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
     ddc:	528004a1 	mov	w1, #0x25                  	// #37
     de0:	b9401fe0 	ldr	w0, [sp, #28]
     de4:	97ffff2a 	bl	a8c <putc>
                putc(fd, c);
     de8:	b94027e0 	ldr	w0, [sp, #36]
     dec:	12001c00 	and	w0, w0, #0xff
     df0:	2a0003e1 	mov	w1, w0
     df4:	b9401fe0 	ldr	w0, [sp, #28]
     df8:	97ffff25 	bl	a8c <putc>
            }
            state = 0;
     dfc:	b90033ff 	str	wzr, [sp, #48]
    for(i = 0; fmt[i]; i++){
     e00:	b94037e0 	ldr	w0, [sp, #52]
     e04:	11000400 	add	w0, w0, #0x1
     e08:	b90037e0 	str	w0, [sp, #52]
     e0c:	f9400be1 	ldr	x1, [sp, #16]
     e10:	b98037e0 	ldrsw	x0, [sp, #52]
     e14:	8b000020 	add	x0, x1, x0
     e18:	39400000 	ldrb	w0, [x0]
     e1c:	7100001f 	cmp	w0, #0x0
     e20:	54fff0c1 	b.ne	c38 <printf+0x60>  // b.any
        }
    }
}
     e24:	d503201f 	nop
     e28:	d503201f 	nop
     e2c:	a8cf7bfd 	ldp	x29, x30, [sp], #240
     e30:	d65f03c0 	ret

0000000000000e34 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     e34:	d10083ff 	sub	sp, sp, #0x20
     e38:	f90007e0 	str	x0, [sp, #8]
    Header *bp, *p;
    
    bp = (Header*)ap - 1;
     e3c:	f94007e0 	ldr	x0, [sp, #8]
     e40:	d1004000 	sub	x0, x0, #0x10
     e44:	f9000be0 	str	x0, [sp, #16]
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e48:	b0000000 	adrp	x0, 1000 <morecore+0x50>
     e4c:	91090000 	add	x0, x0, #0x240
     e50:	f9400000 	ldr	x0, [x0]
     e54:	f9000fe0 	str	x0, [sp, #24]
     e58:	14000012 	b	ea0 <free+0x6c>
        if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     e5c:	f9400fe0 	ldr	x0, [sp, #24]
     e60:	f9400000 	ldr	x0, [x0]
     e64:	f9400fe1 	ldr	x1, [sp, #24]
     e68:	eb00003f 	cmp	x1, x0
     e6c:	54000143 	b.cc	e94 <free+0x60>  // b.lo, b.ul, b.last
     e70:	f9400be1 	ldr	x1, [sp, #16]
     e74:	f9400fe0 	ldr	x0, [sp, #24]
     e78:	eb00003f 	cmp	x1, x0
     e7c:	54000248 	b.hi	ec4 <free+0x90>  // b.pmore
     e80:	f9400fe0 	ldr	x0, [sp, #24]
     e84:	f9400000 	ldr	x0, [x0]
     e88:	f9400be1 	ldr	x1, [sp, #16]
     e8c:	eb00003f 	cmp	x1, x0
     e90:	540001a3 	b.cc	ec4 <free+0x90>  // b.lo, b.ul, b.last
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     e94:	f9400fe0 	ldr	x0, [sp, #24]
     e98:	f9400000 	ldr	x0, [x0]
     e9c:	f9000fe0 	str	x0, [sp, #24]
     ea0:	f9400be1 	ldr	x1, [sp, #16]
     ea4:	f9400fe0 	ldr	x0, [sp, #24]
     ea8:	eb00003f 	cmp	x1, x0
     eac:	54fffd89 	b.ls	e5c <free+0x28>  // b.plast
     eb0:	f9400fe0 	ldr	x0, [sp, #24]
     eb4:	f9400000 	ldr	x0, [x0]
     eb8:	f9400be1 	ldr	x1, [sp, #16]
     ebc:	eb00003f 	cmp	x1, x0
     ec0:	54fffce2 	b.cs	e5c <free+0x28>  // b.hs, b.nlast
            break;
    if(bp + bp->s.size == p->s.ptr){
     ec4:	f9400be0 	ldr	x0, [sp, #16]
     ec8:	b9400800 	ldr	w0, [x0, #8]
     ecc:	2a0003e0 	mov	w0, w0
     ed0:	d37cec00 	lsl	x0, x0, #4
     ed4:	f9400be1 	ldr	x1, [sp, #16]
     ed8:	8b000021 	add	x1, x1, x0
     edc:	f9400fe0 	ldr	x0, [sp, #24]
     ee0:	f9400000 	ldr	x0, [x0]
     ee4:	eb00003f 	cmp	x1, x0
     ee8:	540001e1 	b.ne	f24 <free+0xf0>  // b.any
        bp->s.size += p->s.ptr->s.size;
     eec:	f9400be0 	ldr	x0, [sp, #16]
     ef0:	b9400801 	ldr	w1, [x0, #8]
     ef4:	f9400fe0 	ldr	x0, [sp, #24]
     ef8:	f9400000 	ldr	x0, [x0]
     efc:	b9400800 	ldr	w0, [x0, #8]
     f00:	0b000021 	add	w1, w1, w0
     f04:	f9400be0 	ldr	x0, [sp, #16]
     f08:	b9000801 	str	w1, [x0, #8]
        bp->s.ptr = p->s.ptr->s.ptr;
     f0c:	f9400fe0 	ldr	x0, [sp, #24]
     f10:	f9400000 	ldr	x0, [x0]
     f14:	f9400001 	ldr	x1, [x0]
     f18:	f9400be0 	ldr	x0, [sp, #16]
     f1c:	f9000001 	str	x1, [x0]
     f20:	14000005 	b	f34 <free+0x100>
    } else
        bp->s.ptr = p->s.ptr;
     f24:	f9400fe0 	ldr	x0, [sp, #24]
     f28:	f9400001 	ldr	x1, [x0]
     f2c:	f9400be0 	ldr	x0, [sp, #16]
     f30:	f9000001 	str	x1, [x0]
    if(p + p->s.size == bp){
     f34:	f9400fe0 	ldr	x0, [sp, #24]
     f38:	b9400800 	ldr	w0, [x0, #8]
     f3c:	2a0003e0 	mov	w0, w0
     f40:	d37cec00 	lsl	x0, x0, #4
     f44:	f9400fe1 	ldr	x1, [sp, #24]
     f48:	8b000020 	add	x0, x1, x0
     f4c:	f9400be1 	ldr	x1, [sp, #16]
     f50:	eb00003f 	cmp	x1, x0
     f54:	540001a1 	b.ne	f88 <free+0x154>  // b.any
        p->s.size += bp->s.size;
     f58:	f9400fe0 	ldr	x0, [sp, #24]
     f5c:	b9400801 	ldr	w1, [x0, #8]
     f60:	f9400be0 	ldr	x0, [sp, #16]
     f64:	b9400800 	ldr	w0, [x0, #8]
     f68:	0b000021 	add	w1, w1, w0
     f6c:	f9400fe0 	ldr	x0, [sp, #24]
     f70:	b9000801 	str	w1, [x0, #8]
        p->s.ptr = bp->s.ptr;
     f74:	f9400be0 	ldr	x0, [sp, #16]
     f78:	f9400001 	ldr	x1, [x0]
     f7c:	f9400fe0 	ldr	x0, [sp, #24]
     f80:	f9000001 	str	x1, [x0]
     f84:	14000004 	b	f94 <free+0x160>
    } else
        p->s.ptr = bp;
     f88:	f9400fe0 	ldr	x0, [sp, #24]
     f8c:	f9400be1 	ldr	x1, [sp, #16]
     f90:	f9000001 	str	x1, [x0]
    freep = p;
     f94:	b0000000 	adrp	x0, 1000 <morecore+0x50>
     f98:	91090000 	add	x0, x0, #0x240
     f9c:	f9400fe1 	ldr	x1, [sp, #24]
     fa0:	f9000001 	str	x1, [x0]
}
     fa4:	d503201f 	nop
     fa8:	910083ff 	add	sp, sp, #0x20
     fac:	d65f03c0 	ret

0000000000000fb0 <morecore>:

static Header*
morecore(uint nu)
{
     fb0:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     fb4:	910003fd 	mov	x29, sp
     fb8:	b9001fe0 	str	w0, [sp, #28]
    char *p;
    Header *hp;
    
    if(nu < 4096)
     fbc:	b9401fe0 	ldr	w0, [sp, #28]
     fc0:	713ffc1f 	cmp	w0, #0xfff
     fc4:	54000068 	b.hi	fd0 <morecore+0x20>  // b.pmore
        nu = 4096;
     fc8:	52820000 	mov	w0, #0x1000                	// #4096
     fcc:	b9001fe0 	str	w0, [sp, #28]
    p = sbrk(nu * sizeof(Header));
     fd0:	b9401fe0 	ldr	w0, [sp, #28]
     fd4:	531c6c00 	lsl	w0, w0, #4
     fd8:	97fffe92 	bl	a20 <sbrk>
     fdc:	f90017e0 	str	x0, [sp, #40]
    if(p == (char*)-1)
     fe0:	f94017e0 	ldr	x0, [sp, #40]
     fe4:	b100041f 	cmn	x0, #0x1
     fe8:	54000061 	b.ne	ff4 <morecore+0x44>  // b.any
        return 0;
     fec:	d2800000 	mov	x0, #0x0                   	// #0
     ff0:	1400000c 	b	1020 <morecore+0x70>
    hp = (Header*)p;
     ff4:	f94017e0 	ldr	x0, [sp, #40]
     ff8:	f90013e0 	str	x0, [sp, #32]
    hp->s.size = nu;
     ffc:	f94013e0 	ldr	x0, [sp, #32]
    1000:	b9401fe1 	ldr	w1, [sp, #28]
    1004:	b9000801 	str	w1, [x0, #8]
    free((void*)(hp + 1));
    1008:	f94013e0 	ldr	x0, [sp, #32]
    100c:	91004000 	add	x0, x0, #0x10
    1010:	97ffff89 	bl	e34 <free>
    return freep;
    1014:	90000000 	adrp	x0, 1000 <morecore+0x50>
    1018:	91090000 	add	x0, x0, #0x240
    101c:	f9400000 	ldr	x0, [x0]
}
    1020:	a8c37bfd 	ldp	x29, x30, [sp], #48
    1024:	d65f03c0 	ret

0000000000001028 <malloc>:

void*
malloc(uint nbytes)
{
    1028:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
    102c:	910003fd 	mov	x29, sp
    1030:	b9001fe0 	str	w0, [sp, #28]
    Header *p, *prevp;
    uint nunits;
    
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1034:	b9401fe0 	ldr	w0, [sp, #28]
    1038:	91003c00 	add	x0, x0, #0xf
    103c:	d344fc00 	lsr	x0, x0, #4
    1040:	11000400 	add	w0, w0, #0x1
    1044:	b9002fe0 	str	w0, [sp, #44]
    if((prevp = freep) == 0){
    1048:	90000000 	adrp	x0, 1000 <morecore+0x50>
    104c:	91090000 	add	x0, x0, #0x240
    1050:	f9400000 	ldr	x0, [x0]
    1054:	f9001be0 	str	x0, [sp, #48]
    1058:	f9401be0 	ldr	x0, [sp, #48]
    105c:	f100001f 	cmp	x0, #0x0
    1060:	54000221 	b.ne	10a4 <malloc+0x7c>  // b.any
        base.s.ptr = freep = prevp = &base;
    1064:	90000000 	adrp	x0, 1000 <morecore+0x50>
    1068:	9108c000 	add	x0, x0, #0x230
    106c:	f9001be0 	str	x0, [sp, #48]
    1070:	90000000 	adrp	x0, 1000 <morecore+0x50>
    1074:	91090000 	add	x0, x0, #0x240
    1078:	f9401be1 	ldr	x1, [sp, #48]
    107c:	f9000001 	str	x1, [x0]
    1080:	90000000 	adrp	x0, 1000 <morecore+0x50>
    1084:	91090000 	add	x0, x0, #0x240
    1088:	f9400001 	ldr	x1, [x0]
    108c:	90000000 	adrp	x0, 1000 <morecore+0x50>
    1090:	9108c000 	add	x0, x0, #0x230
    1094:	f9000001 	str	x1, [x0]
        base.s.size = 0;
    1098:	90000000 	adrp	x0, 1000 <morecore+0x50>
    109c:	9108c000 	add	x0, x0, #0x230
    10a0:	b900081f 	str	wzr, [x0, #8]
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    10a4:	f9401be0 	ldr	x0, [sp, #48]
    10a8:	f9400000 	ldr	x0, [x0]
    10ac:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
    10b0:	f9401fe0 	ldr	x0, [sp, #56]
    10b4:	b9400800 	ldr	w0, [x0, #8]
    10b8:	b9402fe1 	ldr	w1, [sp, #44]
    10bc:	6b00003f 	cmp	w1, w0
    10c0:	54000448 	b.hi	1148 <malloc+0x120>  // b.pmore
            if(p->s.size == nunits)
    10c4:	f9401fe0 	ldr	x0, [sp, #56]
    10c8:	b9400800 	ldr	w0, [x0, #8]
    10cc:	b9402fe1 	ldr	w1, [sp, #44]
    10d0:	6b00003f 	cmp	w1, w0
    10d4:	540000c1 	b.ne	10ec <malloc+0xc4>  // b.any
                prevp->s.ptr = p->s.ptr;
    10d8:	f9401fe0 	ldr	x0, [sp, #56]
    10dc:	f9400001 	ldr	x1, [x0]
    10e0:	f9401be0 	ldr	x0, [sp, #48]
    10e4:	f9000001 	str	x1, [x0]
    10e8:	14000011 	b	112c <malloc+0x104>
            else {
                p->s.size -= nunits;
    10ec:	f9401fe0 	ldr	x0, [sp, #56]
    10f0:	b9400801 	ldr	w1, [x0, #8]
    10f4:	b9402fe0 	ldr	w0, [sp, #44]
    10f8:	4b000021 	sub	w1, w1, w0
    10fc:	f9401fe0 	ldr	x0, [sp, #56]
    1100:	b9000801 	str	w1, [x0, #8]
                p += p->s.size;
    1104:	f9401fe0 	ldr	x0, [sp, #56]
    1108:	b9400800 	ldr	w0, [x0, #8]
    110c:	2a0003e0 	mov	w0, w0
    1110:	d37cec00 	lsl	x0, x0, #4
    1114:	f9401fe1 	ldr	x1, [sp, #56]
    1118:	8b000020 	add	x0, x1, x0
    111c:	f9001fe0 	str	x0, [sp, #56]
                p->s.size = nunits;
    1120:	f9401fe0 	ldr	x0, [sp, #56]
    1124:	b9402fe1 	ldr	w1, [sp, #44]
    1128:	b9000801 	str	w1, [x0, #8]
            }
            freep = prevp;
    112c:	90000000 	adrp	x0, 1000 <morecore+0x50>
    1130:	91090000 	add	x0, x0, #0x240
    1134:	f9401be1 	ldr	x1, [sp, #48]
    1138:	f9000001 	str	x1, [x0]
            return (void*)(p + 1);
    113c:	f9401fe0 	ldr	x0, [sp, #56]
    1140:	91004000 	add	x0, x0, #0x10
    1144:	14000015 	b	1198 <malloc+0x170>
        }
        if(p == freep)
    1148:	90000000 	adrp	x0, 1000 <morecore+0x50>
    114c:	91090000 	add	x0, x0, #0x240
    1150:	f9400000 	ldr	x0, [x0]
    1154:	f9401fe1 	ldr	x1, [sp, #56]
    1158:	eb00003f 	cmp	x1, x0
    115c:	54000121 	b.ne	1180 <malloc+0x158>  // b.any
            if((p = morecore(nunits)) == 0)
    1160:	b9402fe0 	ldr	w0, [sp, #44]
    1164:	97ffff93 	bl	fb0 <morecore>
    1168:	f9001fe0 	str	x0, [sp, #56]
    116c:	f9401fe0 	ldr	x0, [sp, #56]
    1170:	f100001f 	cmp	x0, #0x0
    1174:	54000061 	b.ne	1180 <malloc+0x158>  // b.any
                return 0;
    1178:	d2800000 	mov	x0, #0x0                   	// #0
    117c:	14000007 	b	1198 <malloc+0x170>
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1180:	f9401fe0 	ldr	x0, [sp, #56]
    1184:	f9001be0 	str	x0, [sp, #48]
    1188:	f9401fe0 	ldr	x0, [sp, #56]
    118c:	f9400000 	ldr	x0, [x0]
    1190:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
    1194:	17ffffc7 	b	10b0 <malloc+0x88>
    }
}
    1198:	a8c47bfd 	ldp	x29, x30, [sp], #64
    119c:	d65f03c0 	ret
