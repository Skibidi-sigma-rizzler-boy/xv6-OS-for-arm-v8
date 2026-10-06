
_wc:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
       0:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
       4:	910003fd 	mov	x29, sp
       8:	b9001fe0 	str	w0, [sp, #28]
       c:	f9000be1 	str	x1, [sp, #16]
    int i, n;
    int l, w, c, inword;
    
    l = w = c = 0;
      10:	b90033ff 	str	wzr, [sp, #48]
      14:	b94033e0 	ldr	w0, [sp, #48]
      18:	b90037e0 	str	w0, [sp, #52]
      1c:	b94037e0 	ldr	w0, [sp, #52]
      20:	b9003be0 	str	w0, [sp, #56]
    inword = 0;
      24:	b9002fff 	str	wzr, [sp, #44]
    while((n = read(fd, buf, sizeof(buf))) > 0){
      28:	1400002a 	b	d0 <wc+0xd0>
        for(i=0; i<n; i++){
      2c:	b9003fff 	str	wzr, [sp, #60]
      30:	14000024 	b	c0 <wc+0xc0>
            c++;
      34:	b94033e0 	ldr	w0, [sp, #48]
      38:	11000400 	add	w0, w0, #0x1
      3c:	b90033e0 	str	w0, [sp, #48]
            if(buf[i] == '\n')
      40:	b0000000 	adrp	x0, 1000 <malloc+0x110>
      44:	91034001 	add	x1, x0, #0xd0
      48:	b9803fe0 	ldrsw	x0, [sp, #60]
      4c:	38606820 	ldrb	w0, [x1, x0]
      50:	7100281f 	cmp	w0, #0xa
      54:	54000081 	b.ne	64 <wc+0x64>  // b.any
                l++;
      58:	b9403be0 	ldr	w0, [sp, #56]
      5c:	11000400 	add	w0, w0, #0x1
      60:	b9003be0 	str	w0, [sp, #56]
            if(strchr(" \r\t\n\v", buf[i]))
      64:	b0000000 	adrp	x0, 1000 <malloc+0x110>
      68:	91034001 	add	x1, x0, #0xd0
      6c:	b9803fe0 	ldrsw	x0, [sp, #60]
      70:	38606820 	ldrb	w0, [x1, x0]
      74:	2a0003e1 	mov	w1, w0
      78:	b0000000 	adrp	x0, 1000 <malloc+0x110>
      7c:	9101a000 	add	x0, x0, #0x68
      80:	940000ed 	bl	434 <strchr>
      84:	f100001f 	cmp	x0, #0x0
      88:	54000060 	b.eq	94 <wc+0x94>  // b.none
                inword = 0;
      8c:	b9002fff 	str	wzr, [sp, #44]
      90:	14000009 	b	b4 <wc+0xb4>
            else if(!inword){
      94:	b9402fe0 	ldr	w0, [sp, #44]
      98:	7100001f 	cmp	w0, #0x0
      9c:	540000c1 	b.ne	b4 <wc+0xb4>  // b.any
                w++;
      a0:	b94037e0 	ldr	w0, [sp, #52]
      a4:	11000400 	add	w0, w0, #0x1
      a8:	b90037e0 	str	w0, [sp, #52]
                inword = 1;
      ac:	52800020 	mov	w0, #0x1                   	// #1
      b0:	b9002fe0 	str	w0, [sp, #44]
        for(i=0; i<n; i++){
      b4:	b9403fe0 	ldr	w0, [sp, #60]
      b8:	11000400 	add	w0, w0, #0x1
      bc:	b9003fe0 	str	w0, [sp, #60]
      c0:	b9403fe1 	ldr	w1, [sp, #60]
      c4:	b9402be0 	ldr	w0, [sp, #40]
      c8:	6b00003f 	cmp	w1, w0
      cc:	54fffb4b 	b.lt	34 <wc+0x34>  // b.tstop
    while((n = read(fd, buf, sizeof(buf))) > 0){
      d0:	52804002 	mov	w2, #0x200                 	// #512
      d4:	b0000000 	adrp	x0, 1000 <malloc+0x110>
      d8:	91034001 	add	x1, x0, #0xd0
      dc:	b9401fe0 	ldr	w0, [sp, #28]
      e0:	94000184 	bl	6f0 <read>
      e4:	b9002be0 	str	w0, [sp, #40]
      e8:	b9402be0 	ldr	w0, [sp, #40]
      ec:	7100001f 	cmp	w0, #0x0
      f0:	54fff9ec 	b.gt	2c <wc+0x2c>
            }
        }
    }
    if(n < 0){
      f4:	b9402be0 	ldr	w0, [sp, #40]
      f8:	7100001f 	cmp	w0, #0x0
      fc:	540000ca 	b.ge	114 <wc+0x114>  // b.tcont
        printf(1, "wc: read error\n");
     100:	b0000000 	adrp	x0, 1000 <malloc+0x110>
     104:	9101c001 	add	x1, x0, #0x70
     108:	52800020 	mov	w0, #0x1                   	// #1
     10c:	94000265 	bl	aa0 <printf>
        exit();
     110:	9400015d 	bl	684 <exit>
    }
    printf(1, "%d %d %d %s\n", l, w, c, name);
     114:	f9400be5 	ldr	x5, [sp, #16]
     118:	b94033e4 	ldr	w4, [sp, #48]
     11c:	b94037e3 	ldr	w3, [sp, #52]
     120:	b9403be2 	ldr	w2, [sp, #56]
     124:	b0000000 	adrp	x0, 1000 <malloc+0x110>
     128:	91020001 	add	x1, x0, #0x80
     12c:	52800020 	mov	w0, #0x1                   	// #1
     130:	9400025c 	bl	aa0 <printf>
}
     134:	d503201f 	nop
     138:	a8c47bfd 	ldp	x29, x30, [sp], #64
     13c:	d65f03c0 	ret

0000000000000140 <main>:

int
main(int argc, char *argv[])
{
     140:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     144:	910003fd 	mov	x29, sp
     148:	b9001fe0 	str	w0, [sp, #28]
     14c:	f9000be1 	str	x1, [sp, #16]
    int fd, i;
    
    if(argc <= 1){
     150:	b9401fe0 	ldr	w0, [sp, #28]
     154:	7100041f 	cmp	w0, #0x1
     158:	540000cc 	b.gt	170 <main+0x30>
        wc(0, "");
     15c:	b0000000 	adrp	x0, 1000 <malloc+0x110>
     160:	91024001 	add	x1, x0, #0x90
     164:	52800000 	mov	w0, #0x0                   	// #0
     168:	97ffffa6 	bl	0 <wc>
        exit();
     16c:	94000146 	bl	684 <exit>
    }
    
    for(i = 1; i < argc; i++){
     170:	52800020 	mov	w0, #0x1                   	// #1
     174:	b9002fe0 	str	w0, [sp, #44]
     178:	14000024 	b	208 <main+0xc8>
        if((fd = open(argv[i], 0)) < 0){
     17c:	b9802fe0 	ldrsw	x0, [sp, #44]
     180:	d37df000 	lsl	x0, x0, #3
     184:	f9400be1 	ldr	x1, [sp, #16]
     188:	8b000020 	add	x0, x1, x0
     18c:	f9400000 	ldr	x0, [x0]
     190:	52800001 	mov	w1, #0x0                   	// #0
     194:	94000184 	bl	7a4 <open>
     198:	b9002be0 	str	w0, [sp, #40]
     19c:	b9402be0 	ldr	w0, [sp, #40]
     1a0:	7100001f 	cmp	w0, #0x0
     1a4:	5400018a 	b.ge	1d4 <main+0x94>  // b.tcont
            printf(1, "wc: cannot open %s\n", argv[i]);
     1a8:	b9802fe0 	ldrsw	x0, [sp, #44]
     1ac:	d37df000 	lsl	x0, x0, #3
     1b0:	f9400be1 	ldr	x1, [sp, #16]
     1b4:	8b000020 	add	x0, x1, x0
     1b8:	f9400000 	ldr	x0, [x0]
     1bc:	aa0003e2 	mov	x2, x0
     1c0:	b0000000 	adrp	x0, 1000 <malloc+0x110>
     1c4:	91026001 	add	x1, x0, #0x98
     1c8:	52800020 	mov	w0, #0x1                   	// #1
     1cc:	94000235 	bl	aa0 <printf>
            exit();
     1d0:	9400012d 	bl	684 <exit>
        }
        wc(fd, argv[i]);
     1d4:	b9802fe0 	ldrsw	x0, [sp, #44]
     1d8:	d37df000 	lsl	x0, x0, #3
     1dc:	f9400be1 	ldr	x1, [sp, #16]
     1e0:	8b000020 	add	x0, x1, x0
     1e4:	f9400000 	ldr	x0, [x0]
     1e8:	aa0003e1 	mov	x1, x0
     1ec:	b9402be0 	ldr	w0, [sp, #40]
     1f0:	97ffff84 	bl	0 <wc>
        close(fd);
     1f4:	b9402be0 	ldr	w0, [sp, #40]
     1f8:	94000150 	bl	738 <close>
    for(i = 1; i < argc; i++){
     1fc:	b9402fe0 	ldr	w0, [sp, #44]
     200:	11000400 	add	w0, w0, #0x1
     204:	b9002fe0 	str	w0, [sp, #44]
     208:	b9402fe1 	ldr	w1, [sp, #44]
     20c:	b9401fe0 	ldr	w0, [sp, #28]
     210:	6b00003f 	cmp	w1, w0
     214:	54fffb4b 	b.lt	17c <main+0x3c>  // b.tstop
    }
    exit();
     218:	9400011b 	bl	684 <exit>

000000000000021c <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
     21c:	d10083ff 	sub	sp, sp, #0x20
     220:	f90007e0 	str	x0, [sp, #8]
     224:	f90003e1 	str	x1, [sp]
    char *os;
    
    os = s;
     228:	f94007e0 	ldr	x0, [sp, #8]
     22c:	f9000fe0 	str	x0, [sp, #24]
    while((*s++ = *t++) != 0)
     230:	d503201f 	nop
     234:	f94003e1 	ldr	x1, [sp]
     238:	91000420 	add	x0, x1, #0x1
     23c:	f90003e0 	str	x0, [sp]
     240:	f94007e0 	ldr	x0, [sp, #8]
     244:	91000402 	add	x2, x0, #0x1
     248:	f90007e2 	str	x2, [sp, #8]
     24c:	39400021 	ldrb	w1, [x1]
     250:	39000001 	strb	w1, [x0]
     254:	39400000 	ldrb	w0, [x0]
     258:	7100001f 	cmp	w0, #0x0
     25c:	54fffec1 	b.ne	234 <strcpy+0x18>  // b.any
        ;
    return os;
     260:	f9400fe0 	ldr	x0, [sp, #24]
}
     264:	910083ff 	add	sp, sp, #0x20
     268:	d65f03c0 	ret

000000000000026c <strcmp>:

int
strcmp(const char *p, const char *q)
{
     26c:	d10043ff 	sub	sp, sp, #0x10
     270:	f90007e0 	str	x0, [sp, #8]
     274:	f90003e1 	str	x1, [sp]
    while(*p && *p == *q)
     278:	14000007 	b	294 <strcmp+0x28>
        p++, q++;
     27c:	f94007e0 	ldr	x0, [sp, #8]
     280:	91000400 	add	x0, x0, #0x1
     284:	f90007e0 	str	x0, [sp, #8]
     288:	f94003e0 	ldr	x0, [sp]
     28c:	91000400 	add	x0, x0, #0x1
     290:	f90003e0 	str	x0, [sp]
    while(*p && *p == *q)
     294:	f94007e0 	ldr	x0, [sp, #8]
     298:	39400000 	ldrb	w0, [x0]
     29c:	7100001f 	cmp	w0, #0x0
     2a0:	540000e0 	b.eq	2bc <strcmp+0x50>  // b.none
     2a4:	f94007e0 	ldr	x0, [sp, #8]
     2a8:	39400001 	ldrb	w1, [x0]
     2ac:	f94003e0 	ldr	x0, [sp]
     2b0:	39400000 	ldrb	w0, [x0]
     2b4:	6b00003f 	cmp	w1, w0
     2b8:	54fffe20 	b.eq	27c <strcmp+0x10>  // b.none
    return (uchar)*p - (uchar)*q;
     2bc:	f94007e0 	ldr	x0, [sp, #8]
     2c0:	39400000 	ldrb	w0, [x0]
     2c4:	2a0003e1 	mov	w1, w0
     2c8:	f94003e0 	ldr	x0, [sp]
     2cc:	39400000 	ldrb	w0, [x0]
     2d0:	4b000020 	sub	w0, w1, w0
}
     2d4:	910043ff 	add	sp, sp, #0x10
     2d8:	d65f03c0 	ret

00000000000002dc <strlen>:

uint
strlen(char *s)
{
     2dc:	d10083ff 	sub	sp, sp, #0x20
     2e0:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    for(n = 0; s[n]; n++)
     2e4:	b9001fff 	str	wzr, [sp, #28]
     2e8:	14000004 	b	2f8 <strlen+0x1c>
     2ec:	b9401fe0 	ldr	w0, [sp, #28]
     2f0:	11000400 	add	w0, w0, #0x1
     2f4:	b9001fe0 	str	w0, [sp, #28]
     2f8:	b9801fe0 	ldrsw	x0, [sp, #28]
     2fc:	f94007e1 	ldr	x1, [sp, #8]
     300:	8b000020 	add	x0, x1, x0
     304:	39400000 	ldrb	w0, [x0]
     308:	7100001f 	cmp	w0, #0x0
     30c:	54ffff01 	b.ne	2ec <strlen+0x10>  // b.any
        ;
    return n;
     310:	b9401fe0 	ldr	w0, [sp, #28]
}
     314:	910083ff 	add	sp, sp, #0x20
     318:	d65f03c0 	ret

000000000000031c <memset>:

void*
memset(void *dst, int v, uint n)
{
     31c:	d100c3ff 	sub	sp, sp, #0x30
     320:	f90007e0 	str	x0, [sp, #8]
     324:	b90007e1 	str	w1, [sp, #4]
     328:	b90003e2 	str	w2, [sp]
	uint8	*p;
	uint8	c;
	uint32	val;
	uint32	*p4;

	p   = dst;
     32c:	f94007e0 	ldr	x0, [sp, #8]
     330:	f90017e0 	str	x0, [sp, #40]
	c   = v & 0xff;
     334:	b94007e0 	ldr	w0, [sp, #4]
     338:	39007fe0 	strb	w0, [sp, #31]
	val = (c << 24) | (c << 16) | (c << 8) | c;
     33c:	39407fe1 	ldrb	w1, [sp, #31]
     340:	2a0103e0 	mov	w0, w1
     344:	53185c00 	lsl	w0, w0, #8
     348:	0b010000 	add	w0, w0, w1
     34c:	53103c00 	lsl	w0, w0, #16
     350:	2a0003e1 	mov	w1, w0
     354:	39407fe0 	ldrb	w0, [sp, #31]
     358:	53185c00 	lsl	w0, w0, #8
     35c:	2a000021 	orr	w1, w1, w0
     360:	39407fe0 	ldrb	w0, [sp, #31]
     364:	2a000020 	orr	w0, w1, w0
     368:	b9001be0 	str	w0, [sp, #24]

	// set bytes before whole uint32
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
     36c:	1400000a 	b	394 <memset+0x78>
		*p = c;
     370:	f94017e0 	ldr	x0, [sp, #40]
     374:	39407fe1 	ldrb	w1, [sp, #31]
     378:	39000001 	strb	w1, [x0]
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
     37c:	b94003e0 	ldr	w0, [sp]
     380:	51000400 	sub	w0, w0, #0x1
     384:	b90003e0 	str	w0, [sp]
     388:	f94017e0 	ldr	x0, [sp, #40]
     38c:	91000400 	add	x0, x0, #0x1
     390:	f90017e0 	str	x0, [sp, #40]
     394:	b94003e0 	ldr	w0, [sp]
     398:	7100001f 	cmp	w0, #0x0
     39c:	540000a0 	b.eq	3b0 <memset+0x94>  // b.none
     3a0:	f94017e0 	ldr	x0, [sp, #40]
     3a4:	92400400 	and	x0, x0, #0x3
     3a8:	f100001f 	cmp	x0, #0x0
     3ac:	54fffe21 	b.ne	370 <memset+0x54>  // b.any
	}

	// set memory 4 bytes a time
	p4 = (uint*)p;
     3b0:	f94017e0 	ldr	x0, [sp, #40]
     3b4:	f90013e0 	str	x0, [sp, #32]

	for (; n >= 4; n -= 4, p4++) {
     3b8:	1400000a 	b	3e0 <memset+0xc4>
		*p4 = val;
     3bc:	f94013e0 	ldr	x0, [sp, #32]
     3c0:	b9401be1 	ldr	w1, [sp, #24]
     3c4:	b9000001 	str	w1, [x0]
	for (; n >= 4; n -= 4, p4++) {
     3c8:	b94003e0 	ldr	w0, [sp]
     3cc:	51001000 	sub	w0, w0, #0x4
     3d0:	b90003e0 	str	w0, [sp]
     3d4:	f94013e0 	ldr	x0, [sp, #32]
     3d8:	91001000 	add	x0, x0, #0x4
     3dc:	f90013e0 	str	x0, [sp, #32]
     3e0:	b94003e0 	ldr	w0, [sp]
     3e4:	71000c1f 	cmp	w0, #0x3
     3e8:	54fffea8 	b.hi	3bc <memset+0xa0>  // b.pmore
	}

	// set leftover one byte a time
	p = (uint8*)p4;
     3ec:	f94013e0 	ldr	x0, [sp, #32]
     3f0:	f90017e0 	str	x0, [sp, #40]

	for (; n > 0; n--, p++) {
     3f4:	1400000a 	b	41c <memset+0x100>
		*p = c;
     3f8:	f94017e0 	ldr	x0, [sp, #40]
     3fc:	39407fe1 	ldrb	w1, [sp, #31]
     400:	39000001 	strb	w1, [x0]
	for (; n > 0; n--, p++) {
     404:	b94003e0 	ldr	w0, [sp]
     408:	51000400 	sub	w0, w0, #0x1
     40c:	b90003e0 	str	w0, [sp]
     410:	f94017e0 	ldr	x0, [sp, #40]
     414:	91000400 	add	x0, x0, #0x1
     418:	f90017e0 	str	x0, [sp, #40]
     41c:	b94003e0 	ldr	w0, [sp]
     420:	7100001f 	cmp	w0, #0x0
     424:	54fffea1 	b.ne	3f8 <memset+0xdc>  // b.any
	}

	return dst;
     428:	f94007e0 	ldr	x0, [sp, #8]
}
     42c:	9100c3ff 	add	sp, sp, #0x30
     430:	d65f03c0 	ret

0000000000000434 <strchr>:

char*
strchr(const char *s, char c)
{
     434:	d10043ff 	sub	sp, sp, #0x10
     438:	f90007e0 	str	x0, [sp, #8]
     43c:	39001fe1 	strb	w1, [sp, #7]
    for(; *s; s++)
     440:	1400000b 	b	46c <strchr+0x38>
        if(*s == c)
     444:	f94007e0 	ldr	x0, [sp, #8]
     448:	39400000 	ldrb	w0, [x0]
     44c:	39401fe1 	ldrb	w1, [sp, #7]
     450:	6b00003f 	cmp	w1, w0
     454:	54000061 	b.ne	460 <strchr+0x2c>  // b.any
            return (char*)s;
     458:	f94007e0 	ldr	x0, [sp, #8]
     45c:	14000009 	b	480 <strchr+0x4c>
    for(; *s; s++)
     460:	f94007e0 	ldr	x0, [sp, #8]
     464:	91000400 	add	x0, x0, #0x1
     468:	f90007e0 	str	x0, [sp, #8]
     46c:	f94007e0 	ldr	x0, [sp, #8]
     470:	39400000 	ldrb	w0, [x0]
     474:	7100001f 	cmp	w0, #0x0
     478:	54fffe61 	b.ne	444 <strchr+0x10>  // b.any
    return 0;
     47c:	d2800000 	mov	x0, #0x0                   	// #0
}
     480:	910043ff 	add	sp, sp, #0x10
     484:	d65f03c0 	ret

0000000000000488 <gets>:

char*
gets(char *buf, int max)
{
     488:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     48c:	910003fd 	mov	x29, sp
     490:	f9000fe0 	str	x0, [sp, #24]
     494:	b90017e1 	str	w1, [sp, #20]
    int i, cc;
    char c;
    
    for(i=0; i+1 < max; ){
     498:	b9002fff 	str	wzr, [sp, #44]
     49c:	14000018 	b	4fc <gets+0x74>
        cc = read(0, &c, 1);
     4a0:	91009fe0 	add	x0, sp, #0x27
     4a4:	52800022 	mov	w2, #0x1                   	// #1
     4a8:	aa0003e1 	mov	x1, x0
     4ac:	52800000 	mov	w0, #0x0                   	// #0
     4b0:	94000090 	bl	6f0 <read>
     4b4:	b9002be0 	str	w0, [sp, #40]
        if(cc < 1)
     4b8:	b9402be0 	ldr	w0, [sp, #40]
     4bc:	7100001f 	cmp	w0, #0x0
     4c0:	540002ad 	b.le	514 <gets+0x8c>
            break;
        buf[i++] = c;
     4c4:	b9402fe0 	ldr	w0, [sp, #44]
     4c8:	11000401 	add	w1, w0, #0x1
     4cc:	b9002fe1 	str	w1, [sp, #44]
     4d0:	93407c00 	sxtw	x0, w0
     4d4:	f9400fe1 	ldr	x1, [sp, #24]
     4d8:	8b000020 	add	x0, x1, x0
     4dc:	39409fe1 	ldrb	w1, [sp, #39]
     4e0:	39000001 	strb	w1, [x0]
        if(c == '\n' || c == '\r')
     4e4:	39409fe0 	ldrb	w0, [sp, #39]
     4e8:	7100281f 	cmp	w0, #0xa
     4ec:	54000160 	b.eq	518 <gets+0x90>  // b.none
     4f0:	39409fe0 	ldrb	w0, [sp, #39]
     4f4:	7100341f 	cmp	w0, #0xd
     4f8:	54000100 	b.eq	518 <gets+0x90>  // b.none
    for(i=0; i+1 < max; ){
     4fc:	b9402fe0 	ldr	w0, [sp, #44]
     500:	11000400 	add	w0, w0, #0x1
     504:	b94017e1 	ldr	w1, [sp, #20]
     508:	6b00003f 	cmp	w1, w0
     50c:	54fffcac 	b.gt	4a0 <gets+0x18>
     510:	14000002 	b	518 <gets+0x90>
            break;
     514:	d503201f 	nop
            break;
    }
    buf[i] = '\0';
     518:	b9802fe0 	ldrsw	x0, [sp, #44]
     51c:	f9400fe1 	ldr	x1, [sp, #24]
     520:	8b000020 	add	x0, x1, x0
     524:	3900001f 	strb	wzr, [x0]
    return buf;
     528:	f9400fe0 	ldr	x0, [sp, #24]
}
     52c:	a8c37bfd 	ldp	x29, x30, [sp], #48
     530:	d65f03c0 	ret

0000000000000534 <stat>:

int
stat(char *n, struct stat *st)
{
     534:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     538:	910003fd 	mov	x29, sp
     53c:	f9000fe0 	str	x0, [sp, #24]
     540:	f9000be1 	str	x1, [sp, #16]
    int fd;
    int r;
    
    fd = open(n, O_RDONLY);
     544:	52800001 	mov	w1, #0x0                   	// #0
     548:	f9400fe0 	ldr	x0, [sp, #24]
     54c:	94000096 	bl	7a4 <open>
     550:	b9002fe0 	str	w0, [sp, #44]
    if(fd < 0)
     554:	b9402fe0 	ldr	w0, [sp, #44]
     558:	7100001f 	cmp	w0, #0x0
     55c:	5400006a 	b.ge	568 <stat+0x34>  // b.tcont
        return -1;
     560:	12800000 	mov	w0, #0xffffffff            	// #-1
     564:	14000008 	b	584 <stat+0x50>
    r = fstat(fd, st);
     568:	f9400be1 	ldr	x1, [sp, #16]
     56c:	b9402fe0 	ldr	w0, [sp, #44]
     570:	940000a8 	bl	810 <fstat>
     574:	b9002be0 	str	w0, [sp, #40]
    close(fd);
     578:	b9402fe0 	ldr	w0, [sp, #44]
     57c:	9400006f 	bl	738 <close>
    return r;
     580:	b9402be0 	ldr	w0, [sp, #40]
}
     584:	a8c37bfd 	ldp	x29, x30, [sp], #48
     588:	d65f03c0 	ret

000000000000058c <atoi>:

int
atoi(const char *s)
{
     58c:	d10083ff 	sub	sp, sp, #0x20
     590:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    n = 0;
     594:	b9001fff 	str	wzr, [sp, #28]
    while('0' <= *s && *s <= '9')
     598:	1400000e 	b	5d0 <atoi+0x44>
        n = n*10 + *s++ - '0';
     59c:	b9401fe1 	ldr	w1, [sp, #28]
     5a0:	2a0103e0 	mov	w0, w1
     5a4:	531e7400 	lsl	w0, w0, #2
     5a8:	0b010000 	add	w0, w0, w1
     5ac:	531f7800 	lsl	w0, w0, #1
     5b0:	2a0003e2 	mov	w2, w0
     5b4:	f94007e0 	ldr	x0, [sp, #8]
     5b8:	91000401 	add	x1, x0, #0x1
     5bc:	f90007e1 	str	x1, [sp, #8]
     5c0:	39400000 	ldrb	w0, [x0]
     5c4:	0b000040 	add	w0, w2, w0
     5c8:	5100c000 	sub	w0, w0, #0x30
     5cc:	b9001fe0 	str	w0, [sp, #28]
    while('0' <= *s && *s <= '9')
     5d0:	f94007e0 	ldr	x0, [sp, #8]
     5d4:	39400000 	ldrb	w0, [x0]
     5d8:	7100bc1f 	cmp	w0, #0x2f
     5dc:	540000a9 	b.ls	5f0 <atoi+0x64>  // b.plast
     5e0:	f94007e0 	ldr	x0, [sp, #8]
     5e4:	39400000 	ldrb	w0, [x0]
     5e8:	7100e41f 	cmp	w0, #0x39
     5ec:	54fffd89 	b.ls	59c <atoi+0x10>  // b.plast
    return n;
     5f0:	b9401fe0 	ldr	w0, [sp, #28]
}
     5f4:	910083ff 	add	sp, sp, #0x20
     5f8:	d65f03c0 	ret

00000000000005fc <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     5fc:	d100c3ff 	sub	sp, sp, #0x30
     600:	f9000fe0 	str	x0, [sp, #24]
     604:	f9000be1 	str	x1, [sp, #16]
     608:	b9000fe2 	str	w2, [sp, #12]
    char *dst, *src;
    
    dst = vdst;
     60c:	f9400fe0 	ldr	x0, [sp, #24]
     610:	f90017e0 	str	x0, [sp, #40]
    src = vsrc;
     614:	f9400be0 	ldr	x0, [sp, #16]
     618:	f90013e0 	str	x0, [sp, #32]
    while(n-- > 0)
     61c:	14000009 	b	640 <memmove+0x44>
        *dst++ = *src++;
     620:	f94013e1 	ldr	x1, [sp, #32]
     624:	91000420 	add	x0, x1, #0x1
     628:	f90013e0 	str	x0, [sp, #32]
     62c:	f94017e0 	ldr	x0, [sp, #40]
     630:	91000402 	add	x2, x0, #0x1
     634:	f90017e2 	str	x2, [sp, #40]
     638:	39400021 	ldrb	w1, [x1]
     63c:	39000001 	strb	w1, [x0]
    while(n-- > 0)
     640:	b9400fe0 	ldr	w0, [sp, #12]
     644:	51000401 	sub	w1, w0, #0x1
     648:	b9000fe1 	str	w1, [sp, #12]
     64c:	7100001f 	cmp	w0, #0x0
     650:	54fffe8c 	b.gt	620 <memmove+0x24>
    return vdst;
     654:	f9400fe0 	ldr	x0, [sp, #24]
}
     658:	9100c3ff 	add	sp, sp, #0x30
     65c:	d65f03c0 	ret

0000000000000660 <fork>:
     660:	f81f8fe4 	str	x4, [sp, #-8]!
     664:	aa0303e4 	mov	x4, x3
     668:	aa0203e3 	mov	x3, x2
     66c:	aa0103e2 	mov	x2, x1
     670:	aa0003e1 	mov	x1, x0
     674:	d2800020 	mov	x0, #0x1                   	// #1
     678:	d4000001 	svc	#0x0
     67c:	f84087e4 	ldr	x4, [sp], #8
     680:	d61f03c0 	br	x30

0000000000000684 <exit>:
     684:	f81f8fe4 	str	x4, [sp, #-8]!
     688:	aa0303e4 	mov	x4, x3
     68c:	aa0203e3 	mov	x3, x2
     690:	aa0103e2 	mov	x2, x1
     694:	aa0003e1 	mov	x1, x0
     698:	d2800040 	mov	x0, #0x2                   	// #2
     69c:	d4000001 	svc	#0x0
     6a0:	f84087e4 	ldr	x4, [sp], #8
     6a4:	d61f03c0 	br	x30

00000000000006a8 <wait>:
     6a8:	f81f8fe4 	str	x4, [sp, #-8]!
     6ac:	aa0303e4 	mov	x4, x3
     6b0:	aa0203e3 	mov	x3, x2
     6b4:	aa0103e2 	mov	x2, x1
     6b8:	aa0003e1 	mov	x1, x0
     6bc:	d2800060 	mov	x0, #0x3                   	// #3
     6c0:	d4000001 	svc	#0x0
     6c4:	f84087e4 	ldr	x4, [sp], #8
     6c8:	d61f03c0 	br	x30

00000000000006cc <pipe>:
     6cc:	f81f8fe4 	str	x4, [sp, #-8]!
     6d0:	aa0303e4 	mov	x4, x3
     6d4:	aa0203e3 	mov	x3, x2
     6d8:	aa0103e2 	mov	x2, x1
     6dc:	aa0003e1 	mov	x1, x0
     6e0:	d2800080 	mov	x0, #0x4                   	// #4
     6e4:	d4000001 	svc	#0x0
     6e8:	f84087e4 	ldr	x4, [sp], #8
     6ec:	d61f03c0 	br	x30

00000000000006f0 <read>:
     6f0:	f81f8fe4 	str	x4, [sp, #-8]!
     6f4:	aa0303e4 	mov	x4, x3
     6f8:	aa0203e3 	mov	x3, x2
     6fc:	aa0103e2 	mov	x2, x1
     700:	aa0003e1 	mov	x1, x0
     704:	d28000a0 	mov	x0, #0x5                   	// #5
     708:	d4000001 	svc	#0x0
     70c:	f84087e4 	ldr	x4, [sp], #8
     710:	d61f03c0 	br	x30

0000000000000714 <write>:
     714:	f81f8fe4 	str	x4, [sp, #-8]!
     718:	aa0303e4 	mov	x4, x3
     71c:	aa0203e3 	mov	x3, x2
     720:	aa0103e2 	mov	x2, x1
     724:	aa0003e1 	mov	x1, x0
     728:	d2800200 	mov	x0, #0x10                  	// #16
     72c:	d4000001 	svc	#0x0
     730:	f84087e4 	ldr	x4, [sp], #8
     734:	d61f03c0 	br	x30

0000000000000738 <close>:
     738:	f81f8fe4 	str	x4, [sp, #-8]!
     73c:	aa0303e4 	mov	x4, x3
     740:	aa0203e3 	mov	x3, x2
     744:	aa0103e2 	mov	x2, x1
     748:	aa0003e1 	mov	x1, x0
     74c:	d28002a0 	mov	x0, #0x15                  	// #21
     750:	d4000001 	svc	#0x0
     754:	f84087e4 	ldr	x4, [sp], #8
     758:	d61f03c0 	br	x30

000000000000075c <kill>:
     75c:	f81f8fe4 	str	x4, [sp, #-8]!
     760:	aa0303e4 	mov	x4, x3
     764:	aa0203e3 	mov	x3, x2
     768:	aa0103e2 	mov	x2, x1
     76c:	aa0003e1 	mov	x1, x0
     770:	d28000c0 	mov	x0, #0x6                   	// #6
     774:	d4000001 	svc	#0x0
     778:	f84087e4 	ldr	x4, [sp], #8
     77c:	d61f03c0 	br	x30

0000000000000780 <exec>:
     780:	f81f8fe4 	str	x4, [sp, #-8]!
     784:	aa0303e4 	mov	x4, x3
     788:	aa0203e3 	mov	x3, x2
     78c:	aa0103e2 	mov	x2, x1
     790:	aa0003e1 	mov	x1, x0
     794:	d28000e0 	mov	x0, #0x7                   	// #7
     798:	d4000001 	svc	#0x0
     79c:	f84087e4 	ldr	x4, [sp], #8
     7a0:	d61f03c0 	br	x30

00000000000007a4 <open>:
     7a4:	f81f8fe4 	str	x4, [sp, #-8]!
     7a8:	aa0303e4 	mov	x4, x3
     7ac:	aa0203e3 	mov	x3, x2
     7b0:	aa0103e2 	mov	x2, x1
     7b4:	aa0003e1 	mov	x1, x0
     7b8:	d28001e0 	mov	x0, #0xf                   	// #15
     7bc:	d4000001 	svc	#0x0
     7c0:	f84087e4 	ldr	x4, [sp], #8
     7c4:	d61f03c0 	br	x30

00000000000007c8 <mknod>:
     7c8:	f81f8fe4 	str	x4, [sp, #-8]!
     7cc:	aa0303e4 	mov	x4, x3
     7d0:	aa0203e3 	mov	x3, x2
     7d4:	aa0103e2 	mov	x2, x1
     7d8:	aa0003e1 	mov	x1, x0
     7dc:	d2800220 	mov	x0, #0x11                  	// #17
     7e0:	d4000001 	svc	#0x0
     7e4:	f84087e4 	ldr	x4, [sp], #8
     7e8:	d61f03c0 	br	x30

00000000000007ec <unlink>:
     7ec:	f81f8fe4 	str	x4, [sp, #-8]!
     7f0:	aa0303e4 	mov	x4, x3
     7f4:	aa0203e3 	mov	x3, x2
     7f8:	aa0103e2 	mov	x2, x1
     7fc:	aa0003e1 	mov	x1, x0
     800:	d2800240 	mov	x0, #0x12                  	// #18
     804:	d4000001 	svc	#0x0
     808:	f84087e4 	ldr	x4, [sp], #8
     80c:	d61f03c0 	br	x30

0000000000000810 <fstat>:
     810:	f81f8fe4 	str	x4, [sp, #-8]!
     814:	aa0303e4 	mov	x4, x3
     818:	aa0203e3 	mov	x3, x2
     81c:	aa0103e2 	mov	x2, x1
     820:	aa0003e1 	mov	x1, x0
     824:	d2800100 	mov	x0, #0x8                   	// #8
     828:	d4000001 	svc	#0x0
     82c:	f84087e4 	ldr	x4, [sp], #8
     830:	d61f03c0 	br	x30

0000000000000834 <link>:
     834:	f81f8fe4 	str	x4, [sp, #-8]!
     838:	aa0303e4 	mov	x4, x3
     83c:	aa0203e3 	mov	x3, x2
     840:	aa0103e2 	mov	x2, x1
     844:	aa0003e1 	mov	x1, x0
     848:	d2800260 	mov	x0, #0x13                  	// #19
     84c:	d4000001 	svc	#0x0
     850:	f84087e4 	ldr	x4, [sp], #8
     854:	d61f03c0 	br	x30

0000000000000858 <mkdir>:
     858:	f81f8fe4 	str	x4, [sp, #-8]!
     85c:	aa0303e4 	mov	x4, x3
     860:	aa0203e3 	mov	x3, x2
     864:	aa0103e2 	mov	x2, x1
     868:	aa0003e1 	mov	x1, x0
     86c:	d2800280 	mov	x0, #0x14                  	// #20
     870:	d4000001 	svc	#0x0
     874:	f84087e4 	ldr	x4, [sp], #8
     878:	d61f03c0 	br	x30

000000000000087c <chdir>:
     87c:	f81f8fe4 	str	x4, [sp, #-8]!
     880:	aa0303e4 	mov	x4, x3
     884:	aa0203e3 	mov	x3, x2
     888:	aa0103e2 	mov	x2, x1
     88c:	aa0003e1 	mov	x1, x0
     890:	d2800120 	mov	x0, #0x9                   	// #9
     894:	d4000001 	svc	#0x0
     898:	f84087e4 	ldr	x4, [sp], #8
     89c:	d61f03c0 	br	x30

00000000000008a0 <dup>:
     8a0:	f81f8fe4 	str	x4, [sp, #-8]!
     8a4:	aa0303e4 	mov	x4, x3
     8a8:	aa0203e3 	mov	x3, x2
     8ac:	aa0103e2 	mov	x2, x1
     8b0:	aa0003e1 	mov	x1, x0
     8b4:	d2800140 	mov	x0, #0xa                   	// #10
     8b8:	d4000001 	svc	#0x0
     8bc:	f84087e4 	ldr	x4, [sp], #8
     8c0:	d61f03c0 	br	x30

00000000000008c4 <getpid>:
     8c4:	f81f8fe4 	str	x4, [sp, #-8]!
     8c8:	aa0303e4 	mov	x4, x3
     8cc:	aa0203e3 	mov	x3, x2
     8d0:	aa0103e2 	mov	x2, x1
     8d4:	aa0003e1 	mov	x1, x0
     8d8:	d2800160 	mov	x0, #0xb                   	// #11
     8dc:	d4000001 	svc	#0x0
     8e0:	f84087e4 	ldr	x4, [sp], #8
     8e4:	d61f03c0 	br	x30

00000000000008e8 <sbrk>:
     8e8:	f81f8fe4 	str	x4, [sp, #-8]!
     8ec:	aa0303e4 	mov	x4, x3
     8f0:	aa0203e3 	mov	x3, x2
     8f4:	aa0103e2 	mov	x2, x1
     8f8:	aa0003e1 	mov	x1, x0
     8fc:	d2800180 	mov	x0, #0xc                   	// #12
     900:	d4000001 	svc	#0x0
     904:	f84087e4 	ldr	x4, [sp], #8
     908:	d61f03c0 	br	x30

000000000000090c <sleep>:
     90c:	f81f8fe4 	str	x4, [sp, #-8]!
     910:	aa0303e4 	mov	x4, x3
     914:	aa0203e3 	mov	x3, x2
     918:	aa0103e2 	mov	x2, x1
     91c:	aa0003e1 	mov	x1, x0
     920:	d28001a0 	mov	x0, #0xd                   	// #13
     924:	d4000001 	svc	#0x0
     928:	f84087e4 	ldr	x4, [sp], #8
     92c:	d61f03c0 	br	x30

0000000000000930 <uptime>:
     930:	f81f8fe4 	str	x4, [sp, #-8]!
     934:	aa0303e4 	mov	x4, x3
     938:	aa0203e3 	mov	x3, x2
     93c:	aa0103e2 	mov	x2, x1
     940:	aa0003e1 	mov	x1, x0
     944:	d28001c0 	mov	x0, #0xe                   	// #14
     948:	d4000001 	svc	#0x0
     94c:	f84087e4 	ldr	x4, [sp], #8
     950:	d61f03c0 	br	x30

0000000000000954 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     954:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
     958:	910003fd 	mov	x29, sp
     95c:	b9001fe0 	str	w0, [sp, #28]
     960:	39006fe1 	strb	w1, [sp, #27]
    write(fd, &c, 1);
     964:	91006fe0 	add	x0, sp, #0x1b
     968:	52800022 	mov	w2, #0x1                   	// #1
     96c:	aa0003e1 	mov	x1, x0
     970:	b9401fe0 	ldr	w0, [sp, #28]
     974:	97ffff68 	bl	714 <write>
}
     978:	d503201f 	nop
     97c:	a8c27bfd 	ldp	x29, x30, [sp], #32
     980:	d65f03c0 	ret

0000000000000984 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     984:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
     988:	910003fd 	mov	x29, sp
     98c:	b9001fe0 	str	w0, [sp, #28]
     990:	b9001be1 	str	w1, [sp, #24]
     994:	b90017e2 	str	w2, [sp, #20]
     998:	b90013e3 	str	w3, [sp, #16]
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
     99c:	b9003bff 	str	wzr, [sp, #56]
    if(sgn && xx < 0){
     9a0:	b94013e0 	ldr	w0, [sp, #16]
     9a4:	7100001f 	cmp	w0, #0x0
     9a8:	54000140 	b.eq	9d0 <printint+0x4c>  // b.none
     9ac:	b9401be0 	ldr	w0, [sp, #24]
     9b0:	7100001f 	cmp	w0, #0x0
     9b4:	540000ea 	b.ge	9d0 <printint+0x4c>  // b.tcont
        neg = 1;
     9b8:	52800020 	mov	w0, #0x1                   	// #1
     9bc:	b9003be0 	str	w0, [sp, #56]
        x = -xx;
     9c0:	b9401be0 	ldr	w0, [sp, #24]
     9c4:	4b0003e0 	neg	w0, w0
     9c8:	b90037e0 	str	w0, [sp, #52]
     9cc:	14000003 	b	9d8 <printint+0x54>
    } else {
        x = xx;
     9d0:	b9401be0 	ldr	w0, [sp, #24]
     9d4:	b90037e0 	str	w0, [sp, #52]
    }
    
    i = 0;
     9d8:	b9003fff 	str	wzr, [sp, #60]
    do{
        buf[i++] = digits[x % base];
     9dc:	b94017e1 	ldr	w1, [sp, #20]
     9e0:	b94037e0 	ldr	w0, [sp, #52]
     9e4:	1ac10802 	udiv	w2, w0, w1
     9e8:	1b017c41 	mul	w1, w2, w1
     9ec:	4b010003 	sub	w3, w0, w1
     9f0:	b9403fe0 	ldr	w0, [sp, #60]
     9f4:	11000401 	add	w1, w0, #0x1
     9f8:	b9003fe1 	str	w1, [sp, #60]
     9fc:	b0000001 	adrp	x1, 1000 <malloc+0x110>
     a00:	9102e022 	add	x2, x1, #0xb8
     a04:	2a0303e1 	mov	w1, w3
     a08:	38616842 	ldrb	w2, [x2, x1]
     a0c:	93407c00 	sxtw	x0, w0
     a10:	910083e1 	add	x1, sp, #0x20
     a14:	38206822 	strb	w2, [x1, x0]
    }while((x /= base) != 0);
     a18:	b94017e0 	ldr	w0, [sp, #20]
     a1c:	b94037e1 	ldr	w1, [sp, #52]
     a20:	1ac00820 	udiv	w0, w1, w0
     a24:	b90037e0 	str	w0, [sp, #52]
     a28:	b94037e0 	ldr	w0, [sp, #52]
     a2c:	7100001f 	cmp	w0, #0x0
     a30:	54fffd61 	b.ne	9dc <printint+0x58>  // b.any
    if(neg)
     a34:	b9403be0 	ldr	w0, [sp, #56]
     a38:	7100001f 	cmp	w0, #0x0
     a3c:	540001e0 	b.eq	a78 <printint+0xf4>  // b.none
        buf[i++] = '-';
     a40:	b9403fe0 	ldr	w0, [sp, #60]
     a44:	11000401 	add	w1, w0, #0x1
     a48:	b9003fe1 	str	w1, [sp, #60]
     a4c:	93407c00 	sxtw	x0, w0
     a50:	910083e1 	add	x1, sp, #0x20
     a54:	528005a2 	mov	w2, #0x2d                  	// #45
     a58:	38206822 	strb	w2, [x1, x0]
    
    while(--i >= 0)
     a5c:	14000007 	b	a78 <printint+0xf4>
        putc(fd, buf[i]);
     a60:	b9803fe0 	ldrsw	x0, [sp, #60]
     a64:	910083e1 	add	x1, sp, #0x20
     a68:	38606820 	ldrb	w0, [x1, x0]
     a6c:	2a0003e1 	mov	w1, w0
     a70:	b9401fe0 	ldr	w0, [sp, #28]
     a74:	97ffffb8 	bl	954 <putc>
    while(--i >= 0)
     a78:	b9403fe0 	ldr	w0, [sp, #60]
     a7c:	51000400 	sub	w0, w0, #0x1
     a80:	b9003fe0 	str	w0, [sp, #60]
     a84:	b9403fe0 	ldr	w0, [sp, #60]
     a88:	7100001f 	cmp	w0, #0x0
     a8c:	54fffeaa 	b.ge	a60 <printint+0xdc>  // b.tcont
}
     a90:	d503201f 	nop
     a94:	d503201f 	nop
     a98:	a8c47bfd 	ldp	x29, x30, [sp], #64
     a9c:	d65f03c0 	ret

0000000000000aa0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     aa0:	a9b17bfd 	stp	x29, x30, [sp, #-240]!
     aa4:	910003fd 	mov	x29, sp
     aa8:	b9001fe0 	str	w0, [sp, #28]
     aac:	f9000be1 	str	x1, [sp, #16]
     ab0:	f90063e2 	str	x2, [sp, #192]
     ab4:	f90067e3 	str	x3, [sp, #200]
     ab8:	f9006be4 	str	x4, [sp, #208]
     abc:	f9006fe5 	str	x5, [sp, #216]
     ac0:	f90073e6 	str	x6, [sp, #224]
     ac4:	f90077e7 	str	x7, [sp, #232]
     ac8:	3d8013e0 	str	q0, [sp, #64]
     acc:	3d8017e1 	str	q1, [sp, #80]
     ad0:	3d801be2 	str	q2, [sp, #96]
     ad4:	3d801fe3 	str	q3, [sp, #112]
     ad8:	3d8023e4 	str	q4, [sp, #128]
     adc:	3d8027e5 	str	q5, [sp, #144]
     ae0:	3d802be6 	str	q6, [sp, #160]
     ae4:	3d802fe7 	str	q7, [sp, #176]
    char *s;
    int c, i, state;
    uint64 *ap;
    
    state = 0;
     ae8:	b90033ff 	str	wzr, [sp, #48]
    ap = (uint64*)(void*)&fmt + 22;
     aec:	910043e0 	add	x0, sp, #0x10
     af0:	9102c000 	add	x0, x0, #0xb0
     af4:	f90017e0 	str	x0, [sp, #40]
    for(i = 0; fmt[i]; i++){
     af8:	b90037ff 	str	wzr, [sp, #52]
     afc:	14000076 	b	cd4 <printf+0x234>
        c = fmt[i] & 0xff;
     b00:	f9400be1 	ldr	x1, [sp, #16]
     b04:	b98037e0 	ldrsw	x0, [sp, #52]
     b08:	8b000020 	add	x0, x1, x0
     b0c:	39400000 	ldrb	w0, [x0]
     b10:	b90027e0 	str	w0, [sp, #36]
        if(state == 0){
     b14:	b94033e0 	ldr	w0, [sp, #48]
     b18:	7100001f 	cmp	w0, #0x0
     b1c:	540001a1 	b.ne	b50 <printf+0xb0>  // b.any
            if(c == '%'){
     b20:	b94027e0 	ldr	w0, [sp, #36]
     b24:	7100941f 	cmp	w0, #0x25
     b28:	54000081 	b.ne	b38 <printf+0x98>  // b.any
                state = '%';
     b2c:	528004a0 	mov	w0, #0x25                  	// #37
     b30:	b90033e0 	str	w0, [sp, #48]
     b34:	14000065 	b	cc8 <printf+0x228>
            } else {
                putc(fd, c);
     b38:	b94027e0 	ldr	w0, [sp, #36]
     b3c:	12001c00 	and	w0, w0, #0xff
     b40:	2a0003e1 	mov	w1, w0
     b44:	b9401fe0 	ldr	w0, [sp, #28]
     b48:	97ffff83 	bl	954 <putc>
     b4c:	1400005f 	b	cc8 <printf+0x228>
            }
        } else if(state == '%'){
     b50:	b94033e0 	ldr	w0, [sp, #48]
     b54:	7100941f 	cmp	w0, #0x25
     b58:	54000b81 	b.ne	cc8 <printf+0x228>  // b.any
            if(c == 'd'){
     b5c:	b94027e0 	ldr	w0, [sp, #36]
     b60:	7101901f 	cmp	w0, #0x64
     b64:	54000181 	b.ne	b94 <printf+0xf4>  // b.any
                printint(fd, *ap, 10, 1);
     b68:	f94017e0 	ldr	x0, [sp, #40]
     b6c:	f9400000 	ldr	x0, [x0]
     b70:	52800023 	mov	w3, #0x1                   	// #1
     b74:	52800142 	mov	w2, #0xa                   	// #10
     b78:	2a0003e1 	mov	w1, w0
     b7c:	b9401fe0 	ldr	w0, [sp, #28]
     b80:	97ffff81 	bl	984 <printint>
                ap++;
     b84:	f94017e0 	ldr	x0, [sp, #40]
     b88:	91002000 	add	x0, x0, #0x8
     b8c:	f90017e0 	str	x0, [sp, #40]
     b90:	1400004d 	b	cc4 <printf+0x224>
            } else if(c == 'x' || c == 'p'){
     b94:	b94027e0 	ldr	w0, [sp, #36]
     b98:	7101e01f 	cmp	w0, #0x78
     b9c:	54000080 	b.eq	bac <printf+0x10c>  // b.none
     ba0:	b94027e0 	ldr	w0, [sp, #36]
     ba4:	7101c01f 	cmp	w0, #0x70
     ba8:	54000181 	b.ne	bd8 <printf+0x138>  // b.any
                printint(fd, *ap, 16, 0);
     bac:	f94017e0 	ldr	x0, [sp, #40]
     bb0:	f9400000 	ldr	x0, [x0]
     bb4:	52800003 	mov	w3, #0x0                   	// #0
     bb8:	52800202 	mov	w2, #0x10                  	// #16
     bbc:	2a0003e1 	mov	w1, w0
     bc0:	b9401fe0 	ldr	w0, [sp, #28]
     bc4:	97ffff70 	bl	984 <printint>
                ap++;
     bc8:	f94017e0 	ldr	x0, [sp, #40]
     bcc:	91002000 	add	x0, x0, #0x8
     bd0:	f90017e0 	str	x0, [sp, #40]
     bd4:	1400003c 	b	cc4 <printf+0x224>
            } else if(c == 's'){
     bd8:	b94027e0 	ldr	w0, [sp, #36]
     bdc:	7101cc1f 	cmp	w0, #0x73
     be0:	54000361 	b.ne	c4c <printf+0x1ac>  // b.any
                s = (char*)*ap;
     be4:	f94017e0 	ldr	x0, [sp, #40]
     be8:	f9400000 	ldr	x0, [x0]
     bec:	f9001fe0 	str	x0, [sp, #56]
                ap++;
     bf0:	f94017e0 	ldr	x0, [sp, #40]
     bf4:	91002000 	add	x0, x0, #0x8
     bf8:	f90017e0 	str	x0, [sp, #40]
                if(s == 0)
     bfc:	f9401fe0 	ldr	x0, [sp, #56]
     c00:	f100001f 	cmp	x0, #0x0
     c04:	540001a1 	b.ne	c38 <printf+0x198>  // b.any
                    s = "(null)";
     c08:	b0000000 	adrp	x0, 1000 <malloc+0x110>
     c0c:	9102c000 	add	x0, x0, #0xb0
     c10:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
     c14:	14000009 	b	c38 <printf+0x198>
                    putc(fd, *s);
     c18:	f9401fe0 	ldr	x0, [sp, #56]
     c1c:	39400000 	ldrb	w0, [x0]
     c20:	2a0003e1 	mov	w1, w0
     c24:	b9401fe0 	ldr	w0, [sp, #28]
     c28:	97ffff4b 	bl	954 <putc>
                    s++;
     c2c:	f9401fe0 	ldr	x0, [sp, #56]
     c30:	91000400 	add	x0, x0, #0x1
     c34:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
     c38:	f9401fe0 	ldr	x0, [sp, #56]
     c3c:	39400000 	ldrb	w0, [x0]
     c40:	7100001f 	cmp	w0, #0x0
     c44:	54fffea1 	b.ne	c18 <printf+0x178>  // b.any
     c48:	1400001f 	b	cc4 <printf+0x224>
                }
            } else if(c == 'c'){
     c4c:	b94027e0 	ldr	w0, [sp, #36]
     c50:	71018c1f 	cmp	w0, #0x63
     c54:	54000161 	b.ne	c80 <printf+0x1e0>  // b.any
                putc(fd, *ap);
     c58:	f94017e0 	ldr	x0, [sp, #40]
     c5c:	f9400000 	ldr	x0, [x0]
     c60:	12001c00 	and	w0, w0, #0xff
     c64:	2a0003e1 	mov	w1, w0
     c68:	b9401fe0 	ldr	w0, [sp, #28]
     c6c:	97ffff3a 	bl	954 <putc>
                ap++;
     c70:	f94017e0 	ldr	x0, [sp, #40]
     c74:	91002000 	add	x0, x0, #0x8
     c78:	f90017e0 	str	x0, [sp, #40]
     c7c:	14000012 	b	cc4 <printf+0x224>
            } else if(c == '%'){
     c80:	b94027e0 	ldr	w0, [sp, #36]
     c84:	7100941f 	cmp	w0, #0x25
     c88:	540000e1 	b.ne	ca4 <printf+0x204>  // b.any
                putc(fd, c);
     c8c:	b94027e0 	ldr	w0, [sp, #36]
     c90:	12001c00 	and	w0, w0, #0xff
     c94:	2a0003e1 	mov	w1, w0
     c98:	b9401fe0 	ldr	w0, [sp, #28]
     c9c:	97ffff2e 	bl	954 <putc>
     ca0:	14000009 	b	cc4 <printf+0x224>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
     ca4:	528004a1 	mov	w1, #0x25                  	// #37
     ca8:	b9401fe0 	ldr	w0, [sp, #28]
     cac:	97ffff2a 	bl	954 <putc>
                putc(fd, c);
     cb0:	b94027e0 	ldr	w0, [sp, #36]
     cb4:	12001c00 	and	w0, w0, #0xff
     cb8:	2a0003e1 	mov	w1, w0
     cbc:	b9401fe0 	ldr	w0, [sp, #28]
     cc0:	97ffff25 	bl	954 <putc>
            }
            state = 0;
     cc4:	b90033ff 	str	wzr, [sp, #48]
    for(i = 0; fmt[i]; i++){
     cc8:	b94037e0 	ldr	w0, [sp, #52]
     ccc:	11000400 	add	w0, w0, #0x1
     cd0:	b90037e0 	str	w0, [sp, #52]
     cd4:	f9400be1 	ldr	x1, [sp, #16]
     cd8:	b98037e0 	ldrsw	x0, [sp, #52]
     cdc:	8b000020 	add	x0, x1, x0
     ce0:	39400000 	ldrb	w0, [x0]
     ce4:	7100001f 	cmp	w0, #0x0
     ce8:	54fff0c1 	b.ne	b00 <printf+0x60>  // b.any
        }
    }
}
     cec:	d503201f 	nop
     cf0:	d503201f 	nop
     cf4:	a8cf7bfd 	ldp	x29, x30, [sp], #240
     cf8:	d65f03c0 	ret

0000000000000cfc <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     cfc:	d10083ff 	sub	sp, sp, #0x20
     d00:	f90007e0 	str	x0, [sp, #8]
    Header *bp, *p;
    
    bp = (Header*)ap - 1;
     d04:	f94007e0 	ldr	x0, [sp, #8]
     d08:	d1004000 	sub	x0, x0, #0x10
     d0c:	f9000be0 	str	x0, [sp, #16]
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     d10:	b0000000 	adrp	x0, 1000 <malloc+0x110>
     d14:	910b8000 	add	x0, x0, #0x2e0
     d18:	f9400000 	ldr	x0, [x0]
     d1c:	f9000fe0 	str	x0, [sp, #24]
     d20:	14000012 	b	d68 <free+0x6c>
        if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     d24:	f9400fe0 	ldr	x0, [sp, #24]
     d28:	f9400000 	ldr	x0, [x0]
     d2c:	f9400fe1 	ldr	x1, [sp, #24]
     d30:	eb00003f 	cmp	x1, x0
     d34:	54000143 	b.cc	d5c <free+0x60>  // b.lo, b.ul, b.last
     d38:	f9400be1 	ldr	x1, [sp, #16]
     d3c:	f9400fe0 	ldr	x0, [sp, #24]
     d40:	eb00003f 	cmp	x1, x0
     d44:	54000248 	b.hi	d8c <free+0x90>  // b.pmore
     d48:	f9400fe0 	ldr	x0, [sp, #24]
     d4c:	f9400000 	ldr	x0, [x0]
     d50:	f9400be1 	ldr	x1, [sp, #16]
     d54:	eb00003f 	cmp	x1, x0
     d58:	540001a3 	b.cc	d8c <free+0x90>  // b.lo, b.ul, b.last
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     d5c:	f9400fe0 	ldr	x0, [sp, #24]
     d60:	f9400000 	ldr	x0, [x0]
     d64:	f9000fe0 	str	x0, [sp, #24]
     d68:	f9400be1 	ldr	x1, [sp, #16]
     d6c:	f9400fe0 	ldr	x0, [sp, #24]
     d70:	eb00003f 	cmp	x1, x0
     d74:	54fffd89 	b.ls	d24 <free+0x28>  // b.plast
     d78:	f9400fe0 	ldr	x0, [sp, #24]
     d7c:	f9400000 	ldr	x0, [x0]
     d80:	f9400be1 	ldr	x1, [sp, #16]
     d84:	eb00003f 	cmp	x1, x0
     d88:	54fffce2 	b.cs	d24 <free+0x28>  // b.hs, b.nlast
            break;
    if(bp + bp->s.size == p->s.ptr){
     d8c:	f9400be0 	ldr	x0, [sp, #16]
     d90:	b9400800 	ldr	w0, [x0, #8]
     d94:	2a0003e0 	mov	w0, w0
     d98:	d37cec00 	lsl	x0, x0, #4
     d9c:	f9400be1 	ldr	x1, [sp, #16]
     da0:	8b000021 	add	x1, x1, x0
     da4:	f9400fe0 	ldr	x0, [sp, #24]
     da8:	f9400000 	ldr	x0, [x0]
     dac:	eb00003f 	cmp	x1, x0
     db0:	540001e1 	b.ne	dec <free+0xf0>  // b.any
        bp->s.size += p->s.ptr->s.size;
     db4:	f9400be0 	ldr	x0, [sp, #16]
     db8:	b9400801 	ldr	w1, [x0, #8]
     dbc:	f9400fe0 	ldr	x0, [sp, #24]
     dc0:	f9400000 	ldr	x0, [x0]
     dc4:	b9400800 	ldr	w0, [x0, #8]
     dc8:	0b000021 	add	w1, w1, w0
     dcc:	f9400be0 	ldr	x0, [sp, #16]
     dd0:	b9000801 	str	w1, [x0, #8]
        bp->s.ptr = p->s.ptr->s.ptr;
     dd4:	f9400fe0 	ldr	x0, [sp, #24]
     dd8:	f9400000 	ldr	x0, [x0]
     ddc:	f9400001 	ldr	x1, [x0]
     de0:	f9400be0 	ldr	x0, [sp, #16]
     de4:	f9000001 	str	x1, [x0]
     de8:	14000005 	b	dfc <free+0x100>
    } else
        bp->s.ptr = p->s.ptr;
     dec:	f9400fe0 	ldr	x0, [sp, #24]
     df0:	f9400001 	ldr	x1, [x0]
     df4:	f9400be0 	ldr	x0, [sp, #16]
     df8:	f9000001 	str	x1, [x0]
    if(p + p->s.size == bp){
     dfc:	f9400fe0 	ldr	x0, [sp, #24]
     e00:	b9400800 	ldr	w0, [x0, #8]
     e04:	2a0003e0 	mov	w0, w0
     e08:	d37cec00 	lsl	x0, x0, #4
     e0c:	f9400fe1 	ldr	x1, [sp, #24]
     e10:	8b000020 	add	x0, x1, x0
     e14:	f9400be1 	ldr	x1, [sp, #16]
     e18:	eb00003f 	cmp	x1, x0
     e1c:	540001a1 	b.ne	e50 <free+0x154>  // b.any
        p->s.size += bp->s.size;
     e20:	f9400fe0 	ldr	x0, [sp, #24]
     e24:	b9400801 	ldr	w1, [x0, #8]
     e28:	f9400be0 	ldr	x0, [sp, #16]
     e2c:	b9400800 	ldr	w0, [x0, #8]
     e30:	0b000021 	add	w1, w1, w0
     e34:	f9400fe0 	ldr	x0, [sp, #24]
     e38:	b9000801 	str	w1, [x0, #8]
        p->s.ptr = bp->s.ptr;
     e3c:	f9400be0 	ldr	x0, [sp, #16]
     e40:	f9400001 	ldr	x1, [x0]
     e44:	f9400fe0 	ldr	x0, [sp, #24]
     e48:	f9000001 	str	x1, [x0]
     e4c:	14000004 	b	e5c <free+0x160>
    } else
        p->s.ptr = bp;
     e50:	f9400fe0 	ldr	x0, [sp, #24]
     e54:	f9400be1 	ldr	x1, [sp, #16]
     e58:	f9000001 	str	x1, [x0]
    freep = p;
     e5c:	b0000000 	adrp	x0, 1000 <malloc+0x110>
     e60:	910b8000 	add	x0, x0, #0x2e0
     e64:	f9400fe1 	ldr	x1, [sp, #24]
     e68:	f9000001 	str	x1, [x0]
}
     e6c:	d503201f 	nop
     e70:	910083ff 	add	sp, sp, #0x20
     e74:	d65f03c0 	ret

0000000000000e78 <morecore>:

static Header*
morecore(uint nu)
{
     e78:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     e7c:	910003fd 	mov	x29, sp
     e80:	b9001fe0 	str	w0, [sp, #28]
    char *p;
    Header *hp;
    
    if(nu < 4096)
     e84:	b9401fe0 	ldr	w0, [sp, #28]
     e88:	713ffc1f 	cmp	w0, #0xfff
     e8c:	54000068 	b.hi	e98 <morecore+0x20>  // b.pmore
        nu = 4096;
     e90:	52820000 	mov	w0, #0x1000                	// #4096
     e94:	b9001fe0 	str	w0, [sp, #28]
    p = sbrk(nu * sizeof(Header));
     e98:	b9401fe0 	ldr	w0, [sp, #28]
     e9c:	531c6c00 	lsl	w0, w0, #4
     ea0:	97fffe92 	bl	8e8 <sbrk>
     ea4:	f90017e0 	str	x0, [sp, #40]
    if(p == (char*)-1)
     ea8:	f94017e0 	ldr	x0, [sp, #40]
     eac:	b100041f 	cmn	x0, #0x1
     eb0:	54000061 	b.ne	ebc <morecore+0x44>  // b.any
        return 0;
     eb4:	d2800000 	mov	x0, #0x0                   	// #0
     eb8:	1400000c 	b	ee8 <morecore+0x70>
    hp = (Header*)p;
     ebc:	f94017e0 	ldr	x0, [sp, #40]
     ec0:	f90013e0 	str	x0, [sp, #32]
    hp->s.size = nu;
     ec4:	f94013e0 	ldr	x0, [sp, #32]
     ec8:	b9401fe1 	ldr	w1, [sp, #28]
     ecc:	b9000801 	str	w1, [x0, #8]
    free((void*)(hp + 1));
     ed0:	f94013e0 	ldr	x0, [sp, #32]
     ed4:	91004000 	add	x0, x0, #0x10
     ed8:	97ffff89 	bl	cfc <free>
    return freep;
     edc:	b0000000 	adrp	x0, 1000 <malloc+0x110>
     ee0:	910b8000 	add	x0, x0, #0x2e0
     ee4:	f9400000 	ldr	x0, [x0]
}
     ee8:	a8c37bfd 	ldp	x29, x30, [sp], #48
     eec:	d65f03c0 	ret

0000000000000ef0 <malloc>:

void*
malloc(uint nbytes)
{
     ef0:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
     ef4:	910003fd 	mov	x29, sp
     ef8:	b9001fe0 	str	w0, [sp, #28]
    Header *p, *prevp;
    uint nunits;
    
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     efc:	b9401fe0 	ldr	w0, [sp, #28]
     f00:	91003c00 	add	x0, x0, #0xf
     f04:	d344fc00 	lsr	x0, x0, #4
     f08:	11000400 	add	w0, w0, #0x1
     f0c:	b9002fe0 	str	w0, [sp, #44]
    if((prevp = freep) == 0){
     f10:	b0000000 	adrp	x0, 1000 <malloc+0x110>
     f14:	910b8000 	add	x0, x0, #0x2e0
     f18:	f9400000 	ldr	x0, [x0]
     f1c:	f9001be0 	str	x0, [sp, #48]
     f20:	f9401be0 	ldr	x0, [sp, #48]
     f24:	f100001f 	cmp	x0, #0x0
     f28:	54000221 	b.ne	f6c <malloc+0x7c>  // b.any
        base.s.ptr = freep = prevp = &base;
     f2c:	b0000000 	adrp	x0, 1000 <malloc+0x110>
     f30:	910b4000 	add	x0, x0, #0x2d0
     f34:	f9001be0 	str	x0, [sp, #48]
     f38:	b0000000 	adrp	x0, 1000 <malloc+0x110>
     f3c:	910b8000 	add	x0, x0, #0x2e0
     f40:	f9401be1 	ldr	x1, [sp, #48]
     f44:	f9000001 	str	x1, [x0]
     f48:	b0000000 	adrp	x0, 1000 <malloc+0x110>
     f4c:	910b8000 	add	x0, x0, #0x2e0
     f50:	f9400001 	ldr	x1, [x0]
     f54:	b0000000 	adrp	x0, 1000 <malloc+0x110>
     f58:	910b4000 	add	x0, x0, #0x2d0
     f5c:	f9000001 	str	x1, [x0]
        base.s.size = 0;
     f60:	b0000000 	adrp	x0, 1000 <malloc+0x110>
     f64:	910b4000 	add	x0, x0, #0x2d0
     f68:	b900081f 	str	wzr, [x0, #8]
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     f6c:	f9401be0 	ldr	x0, [sp, #48]
     f70:	f9400000 	ldr	x0, [x0]
     f74:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
     f78:	f9401fe0 	ldr	x0, [sp, #56]
     f7c:	b9400800 	ldr	w0, [x0, #8]
     f80:	b9402fe1 	ldr	w1, [sp, #44]
     f84:	6b00003f 	cmp	w1, w0
     f88:	54000448 	b.hi	1010 <malloc+0x120>  // b.pmore
            if(p->s.size == nunits)
     f8c:	f9401fe0 	ldr	x0, [sp, #56]
     f90:	b9400800 	ldr	w0, [x0, #8]
     f94:	b9402fe1 	ldr	w1, [sp, #44]
     f98:	6b00003f 	cmp	w1, w0
     f9c:	540000c1 	b.ne	fb4 <malloc+0xc4>  // b.any
                prevp->s.ptr = p->s.ptr;
     fa0:	f9401fe0 	ldr	x0, [sp, #56]
     fa4:	f9400001 	ldr	x1, [x0]
     fa8:	f9401be0 	ldr	x0, [sp, #48]
     fac:	f9000001 	str	x1, [x0]
     fb0:	14000011 	b	ff4 <malloc+0x104>
            else {
                p->s.size -= nunits;
     fb4:	f9401fe0 	ldr	x0, [sp, #56]
     fb8:	b9400801 	ldr	w1, [x0, #8]
     fbc:	b9402fe0 	ldr	w0, [sp, #44]
     fc0:	4b000021 	sub	w1, w1, w0
     fc4:	f9401fe0 	ldr	x0, [sp, #56]
     fc8:	b9000801 	str	w1, [x0, #8]
                p += p->s.size;
     fcc:	f9401fe0 	ldr	x0, [sp, #56]
     fd0:	b9400800 	ldr	w0, [x0, #8]
     fd4:	2a0003e0 	mov	w0, w0
     fd8:	d37cec00 	lsl	x0, x0, #4
     fdc:	f9401fe1 	ldr	x1, [sp, #56]
     fe0:	8b000020 	add	x0, x1, x0
     fe4:	f9001fe0 	str	x0, [sp, #56]
                p->s.size = nunits;
     fe8:	f9401fe0 	ldr	x0, [sp, #56]
     fec:	b9402fe1 	ldr	w1, [sp, #44]
     ff0:	b9000801 	str	w1, [x0, #8]
            }
            freep = prevp;
     ff4:	b0000000 	adrp	x0, 1000 <malloc+0x110>
     ff8:	910b8000 	add	x0, x0, #0x2e0
     ffc:	f9401be1 	ldr	x1, [sp, #48]
    1000:	f9000001 	str	x1, [x0]
            return (void*)(p + 1);
    1004:	f9401fe0 	ldr	x0, [sp, #56]
    1008:	91004000 	add	x0, x0, #0x10
    100c:	14000015 	b	1060 <malloc+0x170>
        }
        if(p == freep)
    1010:	90000000 	adrp	x0, 1000 <malloc+0x110>
    1014:	910b8000 	add	x0, x0, #0x2e0
    1018:	f9400000 	ldr	x0, [x0]
    101c:	f9401fe1 	ldr	x1, [sp, #56]
    1020:	eb00003f 	cmp	x1, x0
    1024:	54000121 	b.ne	1048 <malloc+0x158>  // b.any
            if((p = morecore(nunits)) == 0)
    1028:	b9402fe0 	ldr	w0, [sp, #44]
    102c:	97ffff93 	bl	e78 <morecore>
    1030:	f9001fe0 	str	x0, [sp, #56]
    1034:	f9401fe0 	ldr	x0, [sp, #56]
    1038:	f100001f 	cmp	x0, #0x0
    103c:	54000061 	b.ne	1048 <malloc+0x158>  // b.any
                return 0;
    1040:	d2800000 	mov	x0, #0x0                   	// #0
    1044:	14000007 	b	1060 <malloc+0x170>
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1048:	f9401fe0 	ldr	x0, [sp, #56]
    104c:	f9001be0 	str	x0, [sp, #48]
    1050:	f9401fe0 	ldr	x0, [sp, #56]
    1054:	f9400000 	ldr	x0, [x0]
    1058:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
    105c:	17ffffc7 	b	f78 <malloc+0x88>
    }
}
    1060:	a8c47bfd 	ldp	x29, x30, [sp], #64
    1064:	d65f03c0 	ret
