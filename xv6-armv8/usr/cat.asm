
_cat:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
   4:	910003fd 	mov	x29, sp
   8:	b9001fe0 	str	w0, [sp, #28]
    int n;
    
    while((n = read(fd, buf, sizeof(buf))) > 0)
   c:	14000006 	b	24 <cat+0x24>
        write(1, buf, n);
  10:	b9402fe2 	ldr	w2, [sp, #44]
  14:	90000000 	adrp	x0, 0 <cat>
  18:	913f4001 	add	x1, x0, #0xfd0
  1c:	52800020 	mov	w0, #0x1                   	// #1
  20:	94000182 	bl	628 <write>
    while((n = read(fd, buf, sizeof(buf))) > 0)
  24:	52804002 	mov	w2, #0x200                 	// #512
  28:	90000000 	adrp	x0, 0 <cat>
  2c:	913f4001 	add	x1, x0, #0xfd0
  30:	b9401fe0 	ldr	w0, [sp, #28]
  34:	94000174 	bl	604 <read>
  38:	b9002fe0 	str	w0, [sp, #44]
  3c:	b9402fe0 	ldr	w0, [sp, #44]
  40:	7100001f 	cmp	w0, #0x0
  44:	54fffe6c 	b.gt	10 <cat+0x10>
    if(n < 0){
  48:	b9402fe0 	ldr	w0, [sp, #44]
  4c:	7100001f 	cmp	w0, #0x0
  50:	540000ca 	b.ge	68 <cat+0x68>  // b.tcont
        printf(1, "cat: read error\n");
  54:	90000000 	adrp	x0, 0 <cat>
  58:	913e0001 	add	x1, x0, #0xf80
  5c:	52800020 	mov	w0, #0x1                   	// #1
  60:	94000255 	bl	9b4 <printf>
        exit();
  64:	9400014d 	bl	598 <exit>
    }
}
  68:	d503201f 	nop
  6c:	a8c37bfd 	ldp	x29, x30, [sp], #48
  70:	d65f03c0 	ret

0000000000000074 <main>:

int
main(int argc, char *argv[])
{
  74:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
  78:	910003fd 	mov	x29, sp
  7c:	b9001fe0 	str	w0, [sp, #28]
  80:	f9000be1 	str	x1, [sp, #16]
    int fd, i;
    
    if(argc <= 1){
  84:	b9401fe0 	ldr	w0, [sp, #28]
  88:	7100041f 	cmp	w0, #0x1
  8c:	5400008c 	b.gt	9c <main+0x28>
        cat(0);
  90:	52800000 	mov	w0, #0x0                   	// #0
  94:	97ffffdb 	bl	0 <cat>
        exit();
  98:	94000140 	bl	598 <exit>
    }
    
    for(i = 1; i < argc; i++){
  9c:	52800020 	mov	w0, #0x1                   	// #1
  a0:	b9002fe0 	str	w0, [sp, #44]
  a4:	1400001e 	b	11c <main+0xa8>
        if((fd = open(argv[i], 0)) < 0){
  a8:	b9802fe0 	ldrsw	x0, [sp, #44]
  ac:	d37df000 	lsl	x0, x0, #3
  b0:	f9400be1 	ldr	x1, [sp, #16]
  b4:	8b000020 	add	x0, x1, x0
  b8:	f9400000 	ldr	x0, [x0]
  bc:	52800001 	mov	w1, #0x0                   	// #0
  c0:	9400017e 	bl	6b8 <open>
  c4:	b9002be0 	str	w0, [sp, #40]
  c8:	b9402be0 	ldr	w0, [sp, #40]
  cc:	7100001f 	cmp	w0, #0x0
  d0:	5400018a 	b.ge	100 <main+0x8c>  // b.tcont
            printf(1, "cat: cannot open %s\n", argv[i]);
  d4:	b9802fe0 	ldrsw	x0, [sp, #44]
  d8:	d37df000 	lsl	x0, x0, #3
  dc:	f9400be1 	ldr	x1, [sp, #16]
  e0:	8b000020 	add	x0, x1, x0
  e4:	f9400000 	ldr	x0, [x0]
  e8:	aa0003e2 	mov	x2, x0
  ec:	90000000 	adrp	x0, 0 <cat>
  f0:	913e6001 	add	x1, x0, #0xf98
  f4:	52800020 	mov	w0, #0x1                   	// #1
  f8:	9400022f 	bl	9b4 <printf>
            exit();
  fc:	94000127 	bl	598 <exit>
        }
        cat(fd);
 100:	b9402be0 	ldr	w0, [sp, #40]
 104:	97ffffbf 	bl	0 <cat>
        close(fd);
 108:	b9402be0 	ldr	w0, [sp, #40]
 10c:	94000150 	bl	64c <close>
    for(i = 1; i < argc; i++){
 110:	b9402fe0 	ldr	w0, [sp, #44]
 114:	11000400 	add	w0, w0, #0x1
 118:	b9002fe0 	str	w0, [sp, #44]
 11c:	b9402fe1 	ldr	w1, [sp, #44]
 120:	b9401fe0 	ldr	w0, [sp, #28]
 124:	6b00003f 	cmp	w1, w0
 128:	54fffc0b 	b.lt	a8 <main+0x34>  // b.tstop
    }
    exit();
 12c:	9400011b 	bl	598 <exit>

0000000000000130 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 130:	d10083ff 	sub	sp, sp, #0x20
 134:	f90007e0 	str	x0, [sp, #8]
 138:	f90003e1 	str	x1, [sp]
    char *os;
    
    os = s;
 13c:	f94007e0 	ldr	x0, [sp, #8]
 140:	f9000fe0 	str	x0, [sp, #24]
    while((*s++ = *t++) != 0)
 144:	d503201f 	nop
 148:	f94003e1 	ldr	x1, [sp]
 14c:	91000420 	add	x0, x1, #0x1
 150:	f90003e0 	str	x0, [sp]
 154:	f94007e0 	ldr	x0, [sp, #8]
 158:	91000402 	add	x2, x0, #0x1
 15c:	f90007e2 	str	x2, [sp, #8]
 160:	39400021 	ldrb	w1, [x1]
 164:	39000001 	strb	w1, [x0]
 168:	39400000 	ldrb	w0, [x0]
 16c:	7100001f 	cmp	w0, #0x0
 170:	54fffec1 	b.ne	148 <strcpy+0x18>  // b.any
        ;
    return os;
 174:	f9400fe0 	ldr	x0, [sp, #24]
}
 178:	910083ff 	add	sp, sp, #0x20
 17c:	d65f03c0 	ret

0000000000000180 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 180:	d10043ff 	sub	sp, sp, #0x10
 184:	f90007e0 	str	x0, [sp, #8]
 188:	f90003e1 	str	x1, [sp]
    while(*p && *p == *q)
 18c:	14000007 	b	1a8 <strcmp+0x28>
        p++, q++;
 190:	f94007e0 	ldr	x0, [sp, #8]
 194:	91000400 	add	x0, x0, #0x1
 198:	f90007e0 	str	x0, [sp, #8]
 19c:	f94003e0 	ldr	x0, [sp]
 1a0:	91000400 	add	x0, x0, #0x1
 1a4:	f90003e0 	str	x0, [sp]
    while(*p && *p == *q)
 1a8:	f94007e0 	ldr	x0, [sp, #8]
 1ac:	39400000 	ldrb	w0, [x0]
 1b0:	7100001f 	cmp	w0, #0x0
 1b4:	540000e0 	b.eq	1d0 <strcmp+0x50>  // b.none
 1b8:	f94007e0 	ldr	x0, [sp, #8]
 1bc:	39400001 	ldrb	w1, [x0]
 1c0:	f94003e0 	ldr	x0, [sp]
 1c4:	39400000 	ldrb	w0, [x0]
 1c8:	6b00003f 	cmp	w1, w0
 1cc:	54fffe20 	b.eq	190 <strcmp+0x10>  // b.none
    return (uchar)*p - (uchar)*q;
 1d0:	f94007e0 	ldr	x0, [sp, #8]
 1d4:	39400000 	ldrb	w0, [x0]
 1d8:	2a0003e1 	mov	w1, w0
 1dc:	f94003e0 	ldr	x0, [sp]
 1e0:	39400000 	ldrb	w0, [x0]
 1e4:	4b000020 	sub	w0, w1, w0
}
 1e8:	910043ff 	add	sp, sp, #0x10
 1ec:	d65f03c0 	ret

00000000000001f0 <strlen>:

uint
strlen(char *s)
{
 1f0:	d10083ff 	sub	sp, sp, #0x20
 1f4:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    for(n = 0; s[n]; n++)
 1f8:	b9001fff 	str	wzr, [sp, #28]
 1fc:	14000004 	b	20c <strlen+0x1c>
 200:	b9401fe0 	ldr	w0, [sp, #28]
 204:	11000400 	add	w0, w0, #0x1
 208:	b9001fe0 	str	w0, [sp, #28]
 20c:	b9801fe0 	ldrsw	x0, [sp, #28]
 210:	f94007e1 	ldr	x1, [sp, #8]
 214:	8b000020 	add	x0, x1, x0
 218:	39400000 	ldrb	w0, [x0]
 21c:	7100001f 	cmp	w0, #0x0
 220:	54ffff01 	b.ne	200 <strlen+0x10>  // b.any
        ;
    return n;
 224:	b9401fe0 	ldr	w0, [sp, #28]
}
 228:	910083ff 	add	sp, sp, #0x20
 22c:	d65f03c0 	ret

0000000000000230 <memset>:

void*
memset(void *dst, int v, uint n)
{
 230:	d100c3ff 	sub	sp, sp, #0x30
 234:	f90007e0 	str	x0, [sp, #8]
 238:	b90007e1 	str	w1, [sp, #4]
 23c:	b90003e2 	str	w2, [sp]
	uint8	*p;
	uint8	c;
	uint32	val;
	uint32	*p4;

	p   = dst;
 240:	f94007e0 	ldr	x0, [sp, #8]
 244:	f90017e0 	str	x0, [sp, #40]
	c   = v & 0xff;
 248:	b94007e0 	ldr	w0, [sp, #4]
 24c:	39007fe0 	strb	w0, [sp, #31]
	val = (c << 24) | (c << 16) | (c << 8) | c;
 250:	39407fe1 	ldrb	w1, [sp, #31]
 254:	2a0103e0 	mov	w0, w1
 258:	53185c00 	lsl	w0, w0, #8
 25c:	0b010000 	add	w0, w0, w1
 260:	53103c00 	lsl	w0, w0, #16
 264:	2a0003e1 	mov	w1, w0
 268:	39407fe0 	ldrb	w0, [sp, #31]
 26c:	53185c00 	lsl	w0, w0, #8
 270:	2a000021 	orr	w1, w1, w0
 274:	39407fe0 	ldrb	w0, [sp, #31]
 278:	2a000020 	orr	w0, w1, w0
 27c:	b9001be0 	str	w0, [sp, #24]

	// set bytes before whole uint32
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
 280:	1400000a 	b	2a8 <memset+0x78>
		*p = c;
 284:	f94017e0 	ldr	x0, [sp, #40]
 288:	39407fe1 	ldrb	w1, [sp, #31]
 28c:	39000001 	strb	w1, [x0]
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
 290:	b94003e0 	ldr	w0, [sp]
 294:	51000400 	sub	w0, w0, #0x1
 298:	b90003e0 	str	w0, [sp]
 29c:	f94017e0 	ldr	x0, [sp, #40]
 2a0:	91000400 	add	x0, x0, #0x1
 2a4:	f90017e0 	str	x0, [sp, #40]
 2a8:	b94003e0 	ldr	w0, [sp]
 2ac:	7100001f 	cmp	w0, #0x0
 2b0:	540000a0 	b.eq	2c4 <memset+0x94>  // b.none
 2b4:	f94017e0 	ldr	x0, [sp, #40]
 2b8:	92400400 	and	x0, x0, #0x3
 2bc:	f100001f 	cmp	x0, #0x0
 2c0:	54fffe21 	b.ne	284 <memset+0x54>  // b.any
	}

	// set memory 4 bytes a time
	p4 = (uint*)p;
 2c4:	f94017e0 	ldr	x0, [sp, #40]
 2c8:	f90013e0 	str	x0, [sp, #32]

	for (; n >= 4; n -= 4, p4++) {
 2cc:	1400000a 	b	2f4 <memset+0xc4>
		*p4 = val;
 2d0:	f94013e0 	ldr	x0, [sp, #32]
 2d4:	b9401be1 	ldr	w1, [sp, #24]
 2d8:	b9000001 	str	w1, [x0]
	for (; n >= 4; n -= 4, p4++) {
 2dc:	b94003e0 	ldr	w0, [sp]
 2e0:	51001000 	sub	w0, w0, #0x4
 2e4:	b90003e0 	str	w0, [sp]
 2e8:	f94013e0 	ldr	x0, [sp, #32]
 2ec:	91001000 	add	x0, x0, #0x4
 2f0:	f90013e0 	str	x0, [sp, #32]
 2f4:	b94003e0 	ldr	w0, [sp]
 2f8:	71000c1f 	cmp	w0, #0x3
 2fc:	54fffea8 	b.hi	2d0 <memset+0xa0>  // b.pmore
	}

	// set leftover one byte a time
	p = (uint8*)p4;
 300:	f94013e0 	ldr	x0, [sp, #32]
 304:	f90017e0 	str	x0, [sp, #40]

	for (; n > 0; n--, p++) {
 308:	1400000a 	b	330 <memset+0x100>
		*p = c;
 30c:	f94017e0 	ldr	x0, [sp, #40]
 310:	39407fe1 	ldrb	w1, [sp, #31]
 314:	39000001 	strb	w1, [x0]
	for (; n > 0; n--, p++) {
 318:	b94003e0 	ldr	w0, [sp]
 31c:	51000400 	sub	w0, w0, #0x1
 320:	b90003e0 	str	w0, [sp]
 324:	f94017e0 	ldr	x0, [sp, #40]
 328:	91000400 	add	x0, x0, #0x1
 32c:	f90017e0 	str	x0, [sp, #40]
 330:	b94003e0 	ldr	w0, [sp]
 334:	7100001f 	cmp	w0, #0x0
 338:	54fffea1 	b.ne	30c <memset+0xdc>  // b.any
	}

	return dst;
 33c:	f94007e0 	ldr	x0, [sp, #8]
}
 340:	9100c3ff 	add	sp, sp, #0x30
 344:	d65f03c0 	ret

0000000000000348 <strchr>:

char*
strchr(const char *s, char c)
{
 348:	d10043ff 	sub	sp, sp, #0x10
 34c:	f90007e0 	str	x0, [sp, #8]
 350:	39001fe1 	strb	w1, [sp, #7]
    for(; *s; s++)
 354:	1400000b 	b	380 <strchr+0x38>
        if(*s == c)
 358:	f94007e0 	ldr	x0, [sp, #8]
 35c:	39400000 	ldrb	w0, [x0]
 360:	39401fe1 	ldrb	w1, [sp, #7]
 364:	6b00003f 	cmp	w1, w0
 368:	54000061 	b.ne	374 <strchr+0x2c>  // b.any
            return (char*)s;
 36c:	f94007e0 	ldr	x0, [sp, #8]
 370:	14000009 	b	394 <strchr+0x4c>
    for(; *s; s++)
 374:	f94007e0 	ldr	x0, [sp, #8]
 378:	91000400 	add	x0, x0, #0x1
 37c:	f90007e0 	str	x0, [sp, #8]
 380:	f94007e0 	ldr	x0, [sp, #8]
 384:	39400000 	ldrb	w0, [x0]
 388:	7100001f 	cmp	w0, #0x0
 38c:	54fffe61 	b.ne	358 <strchr+0x10>  // b.any
    return 0;
 390:	d2800000 	mov	x0, #0x0                   	// #0
}
 394:	910043ff 	add	sp, sp, #0x10
 398:	d65f03c0 	ret

000000000000039c <gets>:

char*
gets(char *buf, int max)
{
 39c:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 3a0:	910003fd 	mov	x29, sp
 3a4:	f9000fe0 	str	x0, [sp, #24]
 3a8:	b90017e1 	str	w1, [sp, #20]
    int i, cc;
    char c;
    
    for(i=0; i+1 < max; ){
 3ac:	b9002fff 	str	wzr, [sp, #44]
 3b0:	14000018 	b	410 <gets+0x74>
        cc = read(0, &c, 1);
 3b4:	91009fe0 	add	x0, sp, #0x27
 3b8:	52800022 	mov	w2, #0x1                   	// #1
 3bc:	aa0003e1 	mov	x1, x0
 3c0:	52800000 	mov	w0, #0x0                   	// #0
 3c4:	94000090 	bl	604 <read>
 3c8:	b9002be0 	str	w0, [sp, #40]
        if(cc < 1)
 3cc:	b9402be0 	ldr	w0, [sp, #40]
 3d0:	7100001f 	cmp	w0, #0x0
 3d4:	540002ad 	b.le	428 <gets+0x8c>
            break;
        buf[i++] = c;
 3d8:	b9402fe0 	ldr	w0, [sp, #44]
 3dc:	11000401 	add	w1, w0, #0x1
 3e0:	b9002fe1 	str	w1, [sp, #44]
 3e4:	93407c00 	sxtw	x0, w0
 3e8:	f9400fe1 	ldr	x1, [sp, #24]
 3ec:	8b000020 	add	x0, x1, x0
 3f0:	39409fe1 	ldrb	w1, [sp, #39]
 3f4:	39000001 	strb	w1, [x0]
        if(c == '\n' || c == '\r')
 3f8:	39409fe0 	ldrb	w0, [sp, #39]
 3fc:	7100281f 	cmp	w0, #0xa
 400:	54000160 	b.eq	42c <gets+0x90>  // b.none
 404:	39409fe0 	ldrb	w0, [sp, #39]
 408:	7100341f 	cmp	w0, #0xd
 40c:	54000100 	b.eq	42c <gets+0x90>  // b.none
    for(i=0; i+1 < max; ){
 410:	b9402fe0 	ldr	w0, [sp, #44]
 414:	11000400 	add	w0, w0, #0x1
 418:	b94017e1 	ldr	w1, [sp, #20]
 41c:	6b00003f 	cmp	w1, w0
 420:	54fffcac 	b.gt	3b4 <gets+0x18>
 424:	14000002 	b	42c <gets+0x90>
            break;
 428:	d503201f 	nop
            break;
    }
    buf[i] = '\0';
 42c:	b9802fe0 	ldrsw	x0, [sp, #44]
 430:	f9400fe1 	ldr	x1, [sp, #24]
 434:	8b000020 	add	x0, x1, x0
 438:	3900001f 	strb	wzr, [x0]
    return buf;
 43c:	f9400fe0 	ldr	x0, [sp, #24]
}
 440:	a8c37bfd 	ldp	x29, x30, [sp], #48
 444:	d65f03c0 	ret

0000000000000448 <stat>:

int
stat(char *n, struct stat *st)
{
 448:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 44c:	910003fd 	mov	x29, sp
 450:	f9000fe0 	str	x0, [sp, #24]
 454:	f9000be1 	str	x1, [sp, #16]
    int fd;
    int r;
    
    fd = open(n, O_RDONLY);
 458:	52800001 	mov	w1, #0x0                   	// #0
 45c:	f9400fe0 	ldr	x0, [sp, #24]
 460:	94000096 	bl	6b8 <open>
 464:	b9002fe0 	str	w0, [sp, #44]
    if(fd < 0)
 468:	b9402fe0 	ldr	w0, [sp, #44]
 46c:	7100001f 	cmp	w0, #0x0
 470:	5400006a 	b.ge	47c <stat+0x34>  // b.tcont
        return -1;
 474:	12800000 	mov	w0, #0xffffffff            	// #-1
 478:	14000008 	b	498 <stat+0x50>
    r = fstat(fd, st);
 47c:	f9400be1 	ldr	x1, [sp, #16]
 480:	b9402fe0 	ldr	w0, [sp, #44]
 484:	940000a8 	bl	724 <fstat>
 488:	b9002be0 	str	w0, [sp, #40]
    close(fd);
 48c:	b9402fe0 	ldr	w0, [sp, #44]
 490:	9400006f 	bl	64c <close>
    return r;
 494:	b9402be0 	ldr	w0, [sp, #40]
}
 498:	a8c37bfd 	ldp	x29, x30, [sp], #48
 49c:	d65f03c0 	ret

00000000000004a0 <atoi>:

int
atoi(const char *s)
{
 4a0:	d10083ff 	sub	sp, sp, #0x20
 4a4:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    n = 0;
 4a8:	b9001fff 	str	wzr, [sp, #28]
    while('0' <= *s && *s <= '9')
 4ac:	1400000e 	b	4e4 <atoi+0x44>
        n = n*10 + *s++ - '0';
 4b0:	b9401fe1 	ldr	w1, [sp, #28]
 4b4:	2a0103e0 	mov	w0, w1
 4b8:	531e7400 	lsl	w0, w0, #2
 4bc:	0b010000 	add	w0, w0, w1
 4c0:	531f7800 	lsl	w0, w0, #1
 4c4:	2a0003e2 	mov	w2, w0
 4c8:	f94007e0 	ldr	x0, [sp, #8]
 4cc:	91000401 	add	x1, x0, #0x1
 4d0:	f90007e1 	str	x1, [sp, #8]
 4d4:	39400000 	ldrb	w0, [x0]
 4d8:	0b000040 	add	w0, w2, w0
 4dc:	5100c000 	sub	w0, w0, #0x30
 4e0:	b9001fe0 	str	w0, [sp, #28]
    while('0' <= *s && *s <= '9')
 4e4:	f94007e0 	ldr	x0, [sp, #8]
 4e8:	39400000 	ldrb	w0, [x0]
 4ec:	7100bc1f 	cmp	w0, #0x2f
 4f0:	540000a9 	b.ls	504 <atoi+0x64>  // b.plast
 4f4:	f94007e0 	ldr	x0, [sp, #8]
 4f8:	39400000 	ldrb	w0, [x0]
 4fc:	7100e41f 	cmp	w0, #0x39
 500:	54fffd89 	b.ls	4b0 <atoi+0x10>  // b.plast
    return n;
 504:	b9401fe0 	ldr	w0, [sp, #28]
}
 508:	910083ff 	add	sp, sp, #0x20
 50c:	d65f03c0 	ret

0000000000000510 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 510:	d100c3ff 	sub	sp, sp, #0x30
 514:	f9000fe0 	str	x0, [sp, #24]
 518:	f9000be1 	str	x1, [sp, #16]
 51c:	b9000fe2 	str	w2, [sp, #12]
    char *dst, *src;
    
    dst = vdst;
 520:	f9400fe0 	ldr	x0, [sp, #24]
 524:	f90017e0 	str	x0, [sp, #40]
    src = vsrc;
 528:	f9400be0 	ldr	x0, [sp, #16]
 52c:	f90013e0 	str	x0, [sp, #32]
    while(n-- > 0)
 530:	14000009 	b	554 <memmove+0x44>
        *dst++ = *src++;
 534:	f94013e1 	ldr	x1, [sp, #32]
 538:	91000420 	add	x0, x1, #0x1
 53c:	f90013e0 	str	x0, [sp, #32]
 540:	f94017e0 	ldr	x0, [sp, #40]
 544:	91000402 	add	x2, x0, #0x1
 548:	f90017e2 	str	x2, [sp, #40]
 54c:	39400021 	ldrb	w1, [x1]
 550:	39000001 	strb	w1, [x0]
    while(n-- > 0)
 554:	b9400fe0 	ldr	w0, [sp, #12]
 558:	51000401 	sub	w1, w0, #0x1
 55c:	b9000fe1 	str	w1, [sp, #12]
 560:	7100001f 	cmp	w0, #0x0
 564:	54fffe8c 	b.gt	534 <memmove+0x24>
    return vdst;
 568:	f9400fe0 	ldr	x0, [sp, #24]
}
 56c:	9100c3ff 	add	sp, sp, #0x30
 570:	d65f03c0 	ret

0000000000000574 <fork>:
 574:	f81f8fe4 	str	x4, [sp, #-8]!
 578:	aa0303e4 	mov	x4, x3
 57c:	aa0203e3 	mov	x3, x2
 580:	aa0103e2 	mov	x2, x1
 584:	aa0003e1 	mov	x1, x0
 588:	d2800020 	mov	x0, #0x1                   	// #1
 58c:	d4000001 	svc	#0x0
 590:	f84087e4 	ldr	x4, [sp], #8
 594:	d61f03c0 	br	x30

0000000000000598 <exit>:
 598:	f81f8fe4 	str	x4, [sp, #-8]!
 59c:	aa0303e4 	mov	x4, x3
 5a0:	aa0203e3 	mov	x3, x2
 5a4:	aa0103e2 	mov	x2, x1
 5a8:	aa0003e1 	mov	x1, x0
 5ac:	d2800040 	mov	x0, #0x2                   	// #2
 5b0:	d4000001 	svc	#0x0
 5b4:	f84087e4 	ldr	x4, [sp], #8
 5b8:	d61f03c0 	br	x30

00000000000005bc <wait>:
 5bc:	f81f8fe4 	str	x4, [sp, #-8]!
 5c0:	aa0303e4 	mov	x4, x3
 5c4:	aa0203e3 	mov	x3, x2
 5c8:	aa0103e2 	mov	x2, x1
 5cc:	aa0003e1 	mov	x1, x0
 5d0:	d2800060 	mov	x0, #0x3                   	// #3
 5d4:	d4000001 	svc	#0x0
 5d8:	f84087e4 	ldr	x4, [sp], #8
 5dc:	d61f03c0 	br	x30

00000000000005e0 <pipe>:
 5e0:	f81f8fe4 	str	x4, [sp, #-8]!
 5e4:	aa0303e4 	mov	x4, x3
 5e8:	aa0203e3 	mov	x3, x2
 5ec:	aa0103e2 	mov	x2, x1
 5f0:	aa0003e1 	mov	x1, x0
 5f4:	d2800080 	mov	x0, #0x4                   	// #4
 5f8:	d4000001 	svc	#0x0
 5fc:	f84087e4 	ldr	x4, [sp], #8
 600:	d61f03c0 	br	x30

0000000000000604 <read>:
 604:	f81f8fe4 	str	x4, [sp, #-8]!
 608:	aa0303e4 	mov	x4, x3
 60c:	aa0203e3 	mov	x3, x2
 610:	aa0103e2 	mov	x2, x1
 614:	aa0003e1 	mov	x1, x0
 618:	d28000a0 	mov	x0, #0x5                   	// #5
 61c:	d4000001 	svc	#0x0
 620:	f84087e4 	ldr	x4, [sp], #8
 624:	d61f03c0 	br	x30

0000000000000628 <write>:
 628:	f81f8fe4 	str	x4, [sp, #-8]!
 62c:	aa0303e4 	mov	x4, x3
 630:	aa0203e3 	mov	x3, x2
 634:	aa0103e2 	mov	x2, x1
 638:	aa0003e1 	mov	x1, x0
 63c:	d2800200 	mov	x0, #0x10                  	// #16
 640:	d4000001 	svc	#0x0
 644:	f84087e4 	ldr	x4, [sp], #8
 648:	d61f03c0 	br	x30

000000000000064c <close>:
 64c:	f81f8fe4 	str	x4, [sp, #-8]!
 650:	aa0303e4 	mov	x4, x3
 654:	aa0203e3 	mov	x3, x2
 658:	aa0103e2 	mov	x2, x1
 65c:	aa0003e1 	mov	x1, x0
 660:	d28002a0 	mov	x0, #0x15                  	// #21
 664:	d4000001 	svc	#0x0
 668:	f84087e4 	ldr	x4, [sp], #8
 66c:	d61f03c0 	br	x30

0000000000000670 <kill>:
 670:	f81f8fe4 	str	x4, [sp, #-8]!
 674:	aa0303e4 	mov	x4, x3
 678:	aa0203e3 	mov	x3, x2
 67c:	aa0103e2 	mov	x2, x1
 680:	aa0003e1 	mov	x1, x0
 684:	d28000c0 	mov	x0, #0x6                   	// #6
 688:	d4000001 	svc	#0x0
 68c:	f84087e4 	ldr	x4, [sp], #8
 690:	d61f03c0 	br	x30

0000000000000694 <exec>:
 694:	f81f8fe4 	str	x4, [sp, #-8]!
 698:	aa0303e4 	mov	x4, x3
 69c:	aa0203e3 	mov	x3, x2
 6a0:	aa0103e2 	mov	x2, x1
 6a4:	aa0003e1 	mov	x1, x0
 6a8:	d28000e0 	mov	x0, #0x7                   	// #7
 6ac:	d4000001 	svc	#0x0
 6b0:	f84087e4 	ldr	x4, [sp], #8
 6b4:	d61f03c0 	br	x30

00000000000006b8 <open>:
 6b8:	f81f8fe4 	str	x4, [sp, #-8]!
 6bc:	aa0303e4 	mov	x4, x3
 6c0:	aa0203e3 	mov	x3, x2
 6c4:	aa0103e2 	mov	x2, x1
 6c8:	aa0003e1 	mov	x1, x0
 6cc:	d28001e0 	mov	x0, #0xf                   	// #15
 6d0:	d4000001 	svc	#0x0
 6d4:	f84087e4 	ldr	x4, [sp], #8
 6d8:	d61f03c0 	br	x30

00000000000006dc <mknod>:
 6dc:	f81f8fe4 	str	x4, [sp, #-8]!
 6e0:	aa0303e4 	mov	x4, x3
 6e4:	aa0203e3 	mov	x3, x2
 6e8:	aa0103e2 	mov	x2, x1
 6ec:	aa0003e1 	mov	x1, x0
 6f0:	d2800220 	mov	x0, #0x11                  	// #17
 6f4:	d4000001 	svc	#0x0
 6f8:	f84087e4 	ldr	x4, [sp], #8
 6fc:	d61f03c0 	br	x30

0000000000000700 <unlink>:
 700:	f81f8fe4 	str	x4, [sp, #-8]!
 704:	aa0303e4 	mov	x4, x3
 708:	aa0203e3 	mov	x3, x2
 70c:	aa0103e2 	mov	x2, x1
 710:	aa0003e1 	mov	x1, x0
 714:	d2800240 	mov	x0, #0x12                  	// #18
 718:	d4000001 	svc	#0x0
 71c:	f84087e4 	ldr	x4, [sp], #8
 720:	d61f03c0 	br	x30

0000000000000724 <fstat>:
 724:	f81f8fe4 	str	x4, [sp, #-8]!
 728:	aa0303e4 	mov	x4, x3
 72c:	aa0203e3 	mov	x3, x2
 730:	aa0103e2 	mov	x2, x1
 734:	aa0003e1 	mov	x1, x0
 738:	d2800100 	mov	x0, #0x8                   	// #8
 73c:	d4000001 	svc	#0x0
 740:	f84087e4 	ldr	x4, [sp], #8
 744:	d61f03c0 	br	x30

0000000000000748 <link>:
 748:	f81f8fe4 	str	x4, [sp, #-8]!
 74c:	aa0303e4 	mov	x4, x3
 750:	aa0203e3 	mov	x3, x2
 754:	aa0103e2 	mov	x2, x1
 758:	aa0003e1 	mov	x1, x0
 75c:	d2800260 	mov	x0, #0x13                  	// #19
 760:	d4000001 	svc	#0x0
 764:	f84087e4 	ldr	x4, [sp], #8
 768:	d61f03c0 	br	x30

000000000000076c <mkdir>:
 76c:	f81f8fe4 	str	x4, [sp, #-8]!
 770:	aa0303e4 	mov	x4, x3
 774:	aa0203e3 	mov	x3, x2
 778:	aa0103e2 	mov	x2, x1
 77c:	aa0003e1 	mov	x1, x0
 780:	d2800280 	mov	x0, #0x14                  	// #20
 784:	d4000001 	svc	#0x0
 788:	f84087e4 	ldr	x4, [sp], #8
 78c:	d61f03c0 	br	x30

0000000000000790 <chdir>:
 790:	f81f8fe4 	str	x4, [sp, #-8]!
 794:	aa0303e4 	mov	x4, x3
 798:	aa0203e3 	mov	x3, x2
 79c:	aa0103e2 	mov	x2, x1
 7a0:	aa0003e1 	mov	x1, x0
 7a4:	d2800120 	mov	x0, #0x9                   	// #9
 7a8:	d4000001 	svc	#0x0
 7ac:	f84087e4 	ldr	x4, [sp], #8
 7b0:	d61f03c0 	br	x30

00000000000007b4 <dup>:
 7b4:	f81f8fe4 	str	x4, [sp, #-8]!
 7b8:	aa0303e4 	mov	x4, x3
 7bc:	aa0203e3 	mov	x3, x2
 7c0:	aa0103e2 	mov	x2, x1
 7c4:	aa0003e1 	mov	x1, x0
 7c8:	d2800140 	mov	x0, #0xa                   	// #10
 7cc:	d4000001 	svc	#0x0
 7d0:	f84087e4 	ldr	x4, [sp], #8
 7d4:	d61f03c0 	br	x30

00000000000007d8 <getpid>:
 7d8:	f81f8fe4 	str	x4, [sp, #-8]!
 7dc:	aa0303e4 	mov	x4, x3
 7e0:	aa0203e3 	mov	x3, x2
 7e4:	aa0103e2 	mov	x2, x1
 7e8:	aa0003e1 	mov	x1, x0
 7ec:	d2800160 	mov	x0, #0xb                   	// #11
 7f0:	d4000001 	svc	#0x0
 7f4:	f84087e4 	ldr	x4, [sp], #8
 7f8:	d61f03c0 	br	x30

00000000000007fc <sbrk>:
 7fc:	f81f8fe4 	str	x4, [sp, #-8]!
 800:	aa0303e4 	mov	x4, x3
 804:	aa0203e3 	mov	x3, x2
 808:	aa0103e2 	mov	x2, x1
 80c:	aa0003e1 	mov	x1, x0
 810:	d2800180 	mov	x0, #0xc                   	// #12
 814:	d4000001 	svc	#0x0
 818:	f84087e4 	ldr	x4, [sp], #8
 81c:	d61f03c0 	br	x30

0000000000000820 <sleep>:
 820:	f81f8fe4 	str	x4, [sp, #-8]!
 824:	aa0303e4 	mov	x4, x3
 828:	aa0203e3 	mov	x3, x2
 82c:	aa0103e2 	mov	x2, x1
 830:	aa0003e1 	mov	x1, x0
 834:	d28001a0 	mov	x0, #0xd                   	// #13
 838:	d4000001 	svc	#0x0
 83c:	f84087e4 	ldr	x4, [sp], #8
 840:	d61f03c0 	br	x30

0000000000000844 <uptime>:
 844:	f81f8fe4 	str	x4, [sp, #-8]!
 848:	aa0303e4 	mov	x4, x3
 84c:	aa0203e3 	mov	x3, x2
 850:	aa0103e2 	mov	x2, x1
 854:	aa0003e1 	mov	x1, x0
 858:	d28001c0 	mov	x0, #0xe                   	// #14
 85c:	d4000001 	svc	#0x0
 860:	f84087e4 	ldr	x4, [sp], #8
 864:	d61f03c0 	br	x30

0000000000000868 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 868:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
 86c:	910003fd 	mov	x29, sp
 870:	b9001fe0 	str	w0, [sp, #28]
 874:	39006fe1 	strb	w1, [sp, #27]
    write(fd, &c, 1);
 878:	91006fe0 	add	x0, sp, #0x1b
 87c:	52800022 	mov	w2, #0x1                   	// #1
 880:	aa0003e1 	mov	x1, x0
 884:	b9401fe0 	ldr	w0, [sp, #28]
 888:	97ffff68 	bl	628 <write>
}
 88c:	d503201f 	nop
 890:	a8c27bfd 	ldp	x29, x30, [sp], #32
 894:	d65f03c0 	ret

0000000000000898 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 898:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 89c:	910003fd 	mov	x29, sp
 8a0:	b9001fe0 	str	w0, [sp, #28]
 8a4:	b9001be1 	str	w1, [sp, #24]
 8a8:	b90017e2 	str	w2, [sp, #20]
 8ac:	b90013e3 	str	w3, [sp, #16]
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
 8b0:	b9003bff 	str	wzr, [sp, #56]
    if(sgn && xx < 0){
 8b4:	b94013e0 	ldr	w0, [sp, #16]
 8b8:	7100001f 	cmp	w0, #0x0
 8bc:	54000140 	b.eq	8e4 <printint+0x4c>  // b.none
 8c0:	b9401be0 	ldr	w0, [sp, #24]
 8c4:	7100001f 	cmp	w0, #0x0
 8c8:	540000ea 	b.ge	8e4 <printint+0x4c>  // b.tcont
        neg = 1;
 8cc:	52800020 	mov	w0, #0x1                   	// #1
 8d0:	b9003be0 	str	w0, [sp, #56]
        x = -xx;
 8d4:	b9401be0 	ldr	w0, [sp, #24]
 8d8:	4b0003e0 	neg	w0, w0
 8dc:	b90037e0 	str	w0, [sp, #52]
 8e0:	14000003 	b	8ec <printint+0x54>
    } else {
        x = xx;
 8e4:	b9401be0 	ldr	w0, [sp, #24]
 8e8:	b90037e0 	str	w0, [sp, #52]
    }
    
    i = 0;
 8ec:	b9003fff 	str	wzr, [sp, #60]
    do{
        buf[i++] = digits[x % base];
 8f0:	b94017e1 	ldr	w1, [sp, #20]
 8f4:	b94037e0 	ldr	w0, [sp, #52]
 8f8:	1ac10802 	udiv	w2, w0, w1
 8fc:	1b017c41 	mul	w1, w2, w1
 900:	4b010003 	sub	w3, w0, w1
 904:	b9403fe0 	ldr	w0, [sp, #60]
 908:	11000401 	add	w1, w0, #0x1
 90c:	b9003fe1 	str	w1, [sp, #60]
 910:	90000001 	adrp	x1, 0 <cat>
 914:	913ee022 	add	x2, x1, #0xfb8
 918:	2a0303e1 	mov	w1, w3
 91c:	38616842 	ldrb	w2, [x2, x1]
 920:	93407c00 	sxtw	x0, w0
 924:	910083e1 	add	x1, sp, #0x20
 928:	38206822 	strb	w2, [x1, x0]
    }while((x /= base) != 0);
 92c:	b94017e0 	ldr	w0, [sp, #20]
 930:	b94037e1 	ldr	w1, [sp, #52]
 934:	1ac00820 	udiv	w0, w1, w0
 938:	b90037e0 	str	w0, [sp, #52]
 93c:	b94037e0 	ldr	w0, [sp, #52]
 940:	7100001f 	cmp	w0, #0x0
 944:	54fffd61 	b.ne	8f0 <printint+0x58>  // b.any
    if(neg)
 948:	b9403be0 	ldr	w0, [sp, #56]
 94c:	7100001f 	cmp	w0, #0x0
 950:	540001e0 	b.eq	98c <printint+0xf4>  // b.none
        buf[i++] = '-';
 954:	b9403fe0 	ldr	w0, [sp, #60]
 958:	11000401 	add	w1, w0, #0x1
 95c:	b9003fe1 	str	w1, [sp, #60]
 960:	93407c00 	sxtw	x0, w0
 964:	910083e1 	add	x1, sp, #0x20
 968:	528005a2 	mov	w2, #0x2d                  	// #45
 96c:	38206822 	strb	w2, [x1, x0]
    
    while(--i >= 0)
 970:	14000007 	b	98c <printint+0xf4>
        putc(fd, buf[i]);
 974:	b9803fe0 	ldrsw	x0, [sp, #60]
 978:	910083e1 	add	x1, sp, #0x20
 97c:	38606820 	ldrb	w0, [x1, x0]
 980:	2a0003e1 	mov	w1, w0
 984:	b9401fe0 	ldr	w0, [sp, #28]
 988:	97ffffb8 	bl	868 <putc>
    while(--i >= 0)
 98c:	b9403fe0 	ldr	w0, [sp, #60]
 990:	51000400 	sub	w0, w0, #0x1
 994:	b9003fe0 	str	w0, [sp, #60]
 998:	b9403fe0 	ldr	w0, [sp, #60]
 99c:	7100001f 	cmp	w0, #0x0
 9a0:	54fffeaa 	b.ge	974 <printint+0xdc>  // b.tcont
}
 9a4:	d503201f 	nop
 9a8:	d503201f 	nop
 9ac:	a8c47bfd 	ldp	x29, x30, [sp], #64
 9b0:	d65f03c0 	ret

00000000000009b4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 9b4:	a9b17bfd 	stp	x29, x30, [sp, #-240]!
 9b8:	910003fd 	mov	x29, sp
 9bc:	b9001fe0 	str	w0, [sp, #28]
 9c0:	f9000be1 	str	x1, [sp, #16]
 9c4:	f90063e2 	str	x2, [sp, #192]
 9c8:	f90067e3 	str	x3, [sp, #200]
 9cc:	f9006be4 	str	x4, [sp, #208]
 9d0:	f9006fe5 	str	x5, [sp, #216]
 9d4:	f90073e6 	str	x6, [sp, #224]
 9d8:	f90077e7 	str	x7, [sp, #232]
 9dc:	3d8013e0 	str	q0, [sp, #64]
 9e0:	3d8017e1 	str	q1, [sp, #80]
 9e4:	3d801be2 	str	q2, [sp, #96]
 9e8:	3d801fe3 	str	q3, [sp, #112]
 9ec:	3d8023e4 	str	q4, [sp, #128]
 9f0:	3d8027e5 	str	q5, [sp, #144]
 9f4:	3d802be6 	str	q6, [sp, #160]
 9f8:	3d802fe7 	str	q7, [sp, #176]
    char *s;
    int c, i, state;
    uint64 *ap;
    
    state = 0;
 9fc:	b90033ff 	str	wzr, [sp, #48]
    ap = (uint64*)(void*)&fmt + 22;
 a00:	910043e0 	add	x0, sp, #0x10
 a04:	9102c000 	add	x0, x0, #0xb0
 a08:	f90017e0 	str	x0, [sp, #40]
    for(i = 0; fmt[i]; i++){
 a0c:	b90037ff 	str	wzr, [sp, #52]
 a10:	14000076 	b	be8 <printf+0x234>
        c = fmt[i] & 0xff;
 a14:	f9400be1 	ldr	x1, [sp, #16]
 a18:	b98037e0 	ldrsw	x0, [sp, #52]
 a1c:	8b000020 	add	x0, x1, x0
 a20:	39400000 	ldrb	w0, [x0]
 a24:	b90027e0 	str	w0, [sp, #36]
        if(state == 0){
 a28:	b94033e0 	ldr	w0, [sp, #48]
 a2c:	7100001f 	cmp	w0, #0x0
 a30:	540001a1 	b.ne	a64 <printf+0xb0>  // b.any
            if(c == '%'){
 a34:	b94027e0 	ldr	w0, [sp, #36]
 a38:	7100941f 	cmp	w0, #0x25
 a3c:	54000081 	b.ne	a4c <printf+0x98>  // b.any
                state = '%';
 a40:	528004a0 	mov	w0, #0x25                  	// #37
 a44:	b90033e0 	str	w0, [sp, #48]
 a48:	14000065 	b	bdc <printf+0x228>
            } else {
                putc(fd, c);
 a4c:	b94027e0 	ldr	w0, [sp, #36]
 a50:	12001c00 	and	w0, w0, #0xff
 a54:	2a0003e1 	mov	w1, w0
 a58:	b9401fe0 	ldr	w0, [sp, #28]
 a5c:	97ffff83 	bl	868 <putc>
 a60:	1400005f 	b	bdc <printf+0x228>
            }
        } else if(state == '%'){
 a64:	b94033e0 	ldr	w0, [sp, #48]
 a68:	7100941f 	cmp	w0, #0x25
 a6c:	54000b81 	b.ne	bdc <printf+0x228>  // b.any
            if(c == 'd'){
 a70:	b94027e0 	ldr	w0, [sp, #36]
 a74:	7101901f 	cmp	w0, #0x64
 a78:	54000181 	b.ne	aa8 <printf+0xf4>  // b.any
                printint(fd, *ap, 10, 1);
 a7c:	f94017e0 	ldr	x0, [sp, #40]
 a80:	f9400000 	ldr	x0, [x0]
 a84:	52800023 	mov	w3, #0x1                   	// #1
 a88:	52800142 	mov	w2, #0xa                   	// #10
 a8c:	2a0003e1 	mov	w1, w0
 a90:	b9401fe0 	ldr	w0, [sp, #28]
 a94:	97ffff81 	bl	898 <printint>
                ap++;
 a98:	f94017e0 	ldr	x0, [sp, #40]
 a9c:	91002000 	add	x0, x0, #0x8
 aa0:	f90017e0 	str	x0, [sp, #40]
 aa4:	1400004d 	b	bd8 <printf+0x224>
            } else if(c == 'x' || c == 'p'){
 aa8:	b94027e0 	ldr	w0, [sp, #36]
 aac:	7101e01f 	cmp	w0, #0x78
 ab0:	54000080 	b.eq	ac0 <printf+0x10c>  // b.none
 ab4:	b94027e0 	ldr	w0, [sp, #36]
 ab8:	7101c01f 	cmp	w0, #0x70
 abc:	54000181 	b.ne	aec <printf+0x138>  // b.any
                printint(fd, *ap, 16, 0);
 ac0:	f94017e0 	ldr	x0, [sp, #40]
 ac4:	f9400000 	ldr	x0, [x0]
 ac8:	52800003 	mov	w3, #0x0                   	// #0
 acc:	52800202 	mov	w2, #0x10                  	// #16
 ad0:	2a0003e1 	mov	w1, w0
 ad4:	b9401fe0 	ldr	w0, [sp, #28]
 ad8:	97ffff70 	bl	898 <printint>
                ap++;
 adc:	f94017e0 	ldr	x0, [sp, #40]
 ae0:	91002000 	add	x0, x0, #0x8
 ae4:	f90017e0 	str	x0, [sp, #40]
 ae8:	1400003c 	b	bd8 <printf+0x224>
            } else if(c == 's'){
 aec:	b94027e0 	ldr	w0, [sp, #36]
 af0:	7101cc1f 	cmp	w0, #0x73
 af4:	54000361 	b.ne	b60 <printf+0x1ac>  // b.any
                s = (char*)*ap;
 af8:	f94017e0 	ldr	x0, [sp, #40]
 afc:	f9400000 	ldr	x0, [x0]
 b00:	f9001fe0 	str	x0, [sp, #56]
                ap++;
 b04:	f94017e0 	ldr	x0, [sp, #40]
 b08:	91002000 	add	x0, x0, #0x8
 b0c:	f90017e0 	str	x0, [sp, #40]
                if(s == 0)
 b10:	f9401fe0 	ldr	x0, [sp, #56]
 b14:	f100001f 	cmp	x0, #0x0
 b18:	540001a1 	b.ne	b4c <printf+0x198>  // b.any
                    s = "(null)";
 b1c:	90000000 	adrp	x0, 0 <cat>
 b20:	913ec000 	add	x0, x0, #0xfb0
 b24:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
 b28:	14000009 	b	b4c <printf+0x198>
                    putc(fd, *s);
 b2c:	f9401fe0 	ldr	x0, [sp, #56]
 b30:	39400000 	ldrb	w0, [x0]
 b34:	2a0003e1 	mov	w1, w0
 b38:	b9401fe0 	ldr	w0, [sp, #28]
 b3c:	97ffff4b 	bl	868 <putc>
                    s++;
 b40:	f9401fe0 	ldr	x0, [sp, #56]
 b44:	91000400 	add	x0, x0, #0x1
 b48:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
 b4c:	f9401fe0 	ldr	x0, [sp, #56]
 b50:	39400000 	ldrb	w0, [x0]
 b54:	7100001f 	cmp	w0, #0x0
 b58:	54fffea1 	b.ne	b2c <printf+0x178>  // b.any
 b5c:	1400001f 	b	bd8 <printf+0x224>
                }
            } else if(c == 'c'){
 b60:	b94027e0 	ldr	w0, [sp, #36]
 b64:	71018c1f 	cmp	w0, #0x63
 b68:	54000161 	b.ne	b94 <printf+0x1e0>  // b.any
                putc(fd, *ap);
 b6c:	f94017e0 	ldr	x0, [sp, #40]
 b70:	f9400000 	ldr	x0, [x0]
 b74:	12001c00 	and	w0, w0, #0xff
 b78:	2a0003e1 	mov	w1, w0
 b7c:	b9401fe0 	ldr	w0, [sp, #28]
 b80:	97ffff3a 	bl	868 <putc>
                ap++;
 b84:	f94017e0 	ldr	x0, [sp, #40]
 b88:	91002000 	add	x0, x0, #0x8
 b8c:	f90017e0 	str	x0, [sp, #40]
 b90:	14000012 	b	bd8 <printf+0x224>
            } else if(c == '%'){
 b94:	b94027e0 	ldr	w0, [sp, #36]
 b98:	7100941f 	cmp	w0, #0x25
 b9c:	540000e1 	b.ne	bb8 <printf+0x204>  // b.any
                putc(fd, c);
 ba0:	b94027e0 	ldr	w0, [sp, #36]
 ba4:	12001c00 	and	w0, w0, #0xff
 ba8:	2a0003e1 	mov	w1, w0
 bac:	b9401fe0 	ldr	w0, [sp, #28]
 bb0:	97ffff2e 	bl	868 <putc>
 bb4:	14000009 	b	bd8 <printf+0x224>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
 bb8:	528004a1 	mov	w1, #0x25                  	// #37
 bbc:	b9401fe0 	ldr	w0, [sp, #28]
 bc0:	97ffff2a 	bl	868 <putc>
                putc(fd, c);
 bc4:	b94027e0 	ldr	w0, [sp, #36]
 bc8:	12001c00 	and	w0, w0, #0xff
 bcc:	2a0003e1 	mov	w1, w0
 bd0:	b9401fe0 	ldr	w0, [sp, #28]
 bd4:	97ffff25 	bl	868 <putc>
            }
            state = 0;
 bd8:	b90033ff 	str	wzr, [sp, #48]
    for(i = 0; fmt[i]; i++){
 bdc:	b94037e0 	ldr	w0, [sp, #52]
 be0:	11000400 	add	w0, w0, #0x1
 be4:	b90037e0 	str	w0, [sp, #52]
 be8:	f9400be1 	ldr	x1, [sp, #16]
 bec:	b98037e0 	ldrsw	x0, [sp, #52]
 bf0:	8b000020 	add	x0, x1, x0
 bf4:	39400000 	ldrb	w0, [x0]
 bf8:	7100001f 	cmp	w0, #0x0
 bfc:	54fff0c1 	b.ne	a14 <printf+0x60>  // b.any
        }
    }
}
 c00:	d503201f 	nop
 c04:	d503201f 	nop
 c08:	a8cf7bfd 	ldp	x29, x30, [sp], #240
 c0c:	d65f03c0 	ret

0000000000000c10 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 c10:	d10083ff 	sub	sp, sp, #0x20
 c14:	f90007e0 	str	x0, [sp, #8]
    Header *bp, *p;
    
    bp = (Header*)ap - 1;
 c18:	f94007e0 	ldr	x0, [sp, #8]
 c1c:	d1004000 	sub	x0, x0, #0x10
 c20:	f9000be0 	str	x0, [sp, #16]
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c24:	b0000000 	adrp	x0, 1000 <buf+0x30>
 c28:	91078000 	add	x0, x0, #0x1e0
 c2c:	f9400000 	ldr	x0, [x0]
 c30:	f9000fe0 	str	x0, [sp, #24]
 c34:	14000012 	b	c7c <free+0x6c>
        if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c38:	f9400fe0 	ldr	x0, [sp, #24]
 c3c:	f9400000 	ldr	x0, [x0]
 c40:	f9400fe1 	ldr	x1, [sp, #24]
 c44:	eb00003f 	cmp	x1, x0
 c48:	54000143 	b.cc	c70 <free+0x60>  // b.lo, b.ul, b.last
 c4c:	f9400be1 	ldr	x1, [sp, #16]
 c50:	f9400fe0 	ldr	x0, [sp, #24]
 c54:	eb00003f 	cmp	x1, x0
 c58:	54000248 	b.hi	ca0 <free+0x90>  // b.pmore
 c5c:	f9400fe0 	ldr	x0, [sp, #24]
 c60:	f9400000 	ldr	x0, [x0]
 c64:	f9400be1 	ldr	x1, [sp, #16]
 c68:	eb00003f 	cmp	x1, x0
 c6c:	540001a3 	b.cc	ca0 <free+0x90>  // b.lo, b.ul, b.last
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c70:	f9400fe0 	ldr	x0, [sp, #24]
 c74:	f9400000 	ldr	x0, [x0]
 c78:	f9000fe0 	str	x0, [sp, #24]
 c7c:	f9400be1 	ldr	x1, [sp, #16]
 c80:	f9400fe0 	ldr	x0, [sp, #24]
 c84:	eb00003f 	cmp	x1, x0
 c88:	54fffd89 	b.ls	c38 <free+0x28>  // b.plast
 c8c:	f9400fe0 	ldr	x0, [sp, #24]
 c90:	f9400000 	ldr	x0, [x0]
 c94:	f9400be1 	ldr	x1, [sp, #16]
 c98:	eb00003f 	cmp	x1, x0
 c9c:	54fffce2 	b.cs	c38 <free+0x28>  // b.hs, b.nlast
            break;
    if(bp + bp->s.size == p->s.ptr){
 ca0:	f9400be0 	ldr	x0, [sp, #16]
 ca4:	b9400800 	ldr	w0, [x0, #8]
 ca8:	2a0003e0 	mov	w0, w0
 cac:	d37cec00 	lsl	x0, x0, #4
 cb0:	f9400be1 	ldr	x1, [sp, #16]
 cb4:	8b000021 	add	x1, x1, x0
 cb8:	f9400fe0 	ldr	x0, [sp, #24]
 cbc:	f9400000 	ldr	x0, [x0]
 cc0:	eb00003f 	cmp	x1, x0
 cc4:	540001e1 	b.ne	d00 <free+0xf0>  // b.any
        bp->s.size += p->s.ptr->s.size;
 cc8:	f9400be0 	ldr	x0, [sp, #16]
 ccc:	b9400801 	ldr	w1, [x0, #8]
 cd0:	f9400fe0 	ldr	x0, [sp, #24]
 cd4:	f9400000 	ldr	x0, [x0]
 cd8:	b9400800 	ldr	w0, [x0, #8]
 cdc:	0b000021 	add	w1, w1, w0
 ce0:	f9400be0 	ldr	x0, [sp, #16]
 ce4:	b9000801 	str	w1, [x0, #8]
        bp->s.ptr = p->s.ptr->s.ptr;
 ce8:	f9400fe0 	ldr	x0, [sp, #24]
 cec:	f9400000 	ldr	x0, [x0]
 cf0:	f9400001 	ldr	x1, [x0]
 cf4:	f9400be0 	ldr	x0, [sp, #16]
 cf8:	f9000001 	str	x1, [x0]
 cfc:	14000005 	b	d10 <free+0x100>
    } else
        bp->s.ptr = p->s.ptr;
 d00:	f9400fe0 	ldr	x0, [sp, #24]
 d04:	f9400001 	ldr	x1, [x0]
 d08:	f9400be0 	ldr	x0, [sp, #16]
 d0c:	f9000001 	str	x1, [x0]
    if(p + p->s.size == bp){
 d10:	f9400fe0 	ldr	x0, [sp, #24]
 d14:	b9400800 	ldr	w0, [x0, #8]
 d18:	2a0003e0 	mov	w0, w0
 d1c:	d37cec00 	lsl	x0, x0, #4
 d20:	f9400fe1 	ldr	x1, [sp, #24]
 d24:	8b000020 	add	x0, x1, x0
 d28:	f9400be1 	ldr	x1, [sp, #16]
 d2c:	eb00003f 	cmp	x1, x0
 d30:	540001a1 	b.ne	d64 <free+0x154>  // b.any
        p->s.size += bp->s.size;
 d34:	f9400fe0 	ldr	x0, [sp, #24]
 d38:	b9400801 	ldr	w1, [x0, #8]
 d3c:	f9400be0 	ldr	x0, [sp, #16]
 d40:	b9400800 	ldr	w0, [x0, #8]
 d44:	0b000021 	add	w1, w1, w0
 d48:	f9400fe0 	ldr	x0, [sp, #24]
 d4c:	b9000801 	str	w1, [x0, #8]
        p->s.ptr = bp->s.ptr;
 d50:	f9400be0 	ldr	x0, [sp, #16]
 d54:	f9400001 	ldr	x1, [x0]
 d58:	f9400fe0 	ldr	x0, [sp, #24]
 d5c:	f9000001 	str	x1, [x0]
 d60:	14000004 	b	d70 <free+0x160>
    } else
        p->s.ptr = bp;
 d64:	f9400fe0 	ldr	x0, [sp, #24]
 d68:	f9400be1 	ldr	x1, [sp, #16]
 d6c:	f9000001 	str	x1, [x0]
    freep = p;
 d70:	b0000000 	adrp	x0, 1000 <buf+0x30>
 d74:	91078000 	add	x0, x0, #0x1e0
 d78:	f9400fe1 	ldr	x1, [sp, #24]
 d7c:	f9000001 	str	x1, [x0]
}
 d80:	d503201f 	nop
 d84:	910083ff 	add	sp, sp, #0x20
 d88:	d65f03c0 	ret

0000000000000d8c <morecore>:

static Header*
morecore(uint nu)
{
 d8c:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 d90:	910003fd 	mov	x29, sp
 d94:	b9001fe0 	str	w0, [sp, #28]
    char *p;
    Header *hp;
    
    if(nu < 4096)
 d98:	b9401fe0 	ldr	w0, [sp, #28]
 d9c:	713ffc1f 	cmp	w0, #0xfff
 da0:	54000068 	b.hi	dac <morecore+0x20>  // b.pmore
        nu = 4096;
 da4:	52820000 	mov	w0, #0x1000                	// #4096
 da8:	b9001fe0 	str	w0, [sp, #28]
    p = sbrk(nu * sizeof(Header));
 dac:	b9401fe0 	ldr	w0, [sp, #28]
 db0:	531c6c00 	lsl	w0, w0, #4
 db4:	97fffe92 	bl	7fc <sbrk>
 db8:	f90017e0 	str	x0, [sp, #40]
    if(p == (char*)-1)
 dbc:	f94017e0 	ldr	x0, [sp, #40]
 dc0:	b100041f 	cmn	x0, #0x1
 dc4:	54000061 	b.ne	dd0 <morecore+0x44>  // b.any
        return 0;
 dc8:	d2800000 	mov	x0, #0x0                   	// #0
 dcc:	1400000c 	b	dfc <morecore+0x70>
    hp = (Header*)p;
 dd0:	f94017e0 	ldr	x0, [sp, #40]
 dd4:	f90013e0 	str	x0, [sp, #32]
    hp->s.size = nu;
 dd8:	f94013e0 	ldr	x0, [sp, #32]
 ddc:	b9401fe1 	ldr	w1, [sp, #28]
 de0:	b9000801 	str	w1, [x0, #8]
    free((void*)(hp + 1));
 de4:	f94013e0 	ldr	x0, [sp, #32]
 de8:	91004000 	add	x0, x0, #0x10
 dec:	97ffff89 	bl	c10 <free>
    return freep;
 df0:	b0000000 	adrp	x0, 1000 <buf+0x30>
 df4:	91078000 	add	x0, x0, #0x1e0
 df8:	f9400000 	ldr	x0, [x0]
}
 dfc:	a8c37bfd 	ldp	x29, x30, [sp], #48
 e00:	d65f03c0 	ret

0000000000000e04 <malloc>:

void*
malloc(uint nbytes)
{
 e04:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 e08:	910003fd 	mov	x29, sp
 e0c:	b9001fe0 	str	w0, [sp, #28]
    Header *p, *prevp;
    uint nunits;
    
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e10:	b9401fe0 	ldr	w0, [sp, #28]
 e14:	91003c00 	add	x0, x0, #0xf
 e18:	d344fc00 	lsr	x0, x0, #4
 e1c:	11000400 	add	w0, w0, #0x1
 e20:	b9002fe0 	str	w0, [sp, #44]
    if((prevp = freep) == 0){
 e24:	b0000000 	adrp	x0, 1000 <buf+0x30>
 e28:	91078000 	add	x0, x0, #0x1e0
 e2c:	f9400000 	ldr	x0, [x0]
 e30:	f9001be0 	str	x0, [sp, #48]
 e34:	f9401be0 	ldr	x0, [sp, #48]
 e38:	f100001f 	cmp	x0, #0x0
 e3c:	54000221 	b.ne	e80 <malloc+0x7c>  // b.any
        base.s.ptr = freep = prevp = &base;
 e40:	b0000000 	adrp	x0, 1000 <buf+0x30>
 e44:	91074000 	add	x0, x0, #0x1d0
 e48:	f9001be0 	str	x0, [sp, #48]
 e4c:	b0000000 	adrp	x0, 1000 <buf+0x30>
 e50:	91078000 	add	x0, x0, #0x1e0
 e54:	f9401be1 	ldr	x1, [sp, #48]
 e58:	f9000001 	str	x1, [x0]
 e5c:	b0000000 	adrp	x0, 1000 <buf+0x30>
 e60:	91078000 	add	x0, x0, #0x1e0
 e64:	f9400001 	ldr	x1, [x0]
 e68:	b0000000 	adrp	x0, 1000 <buf+0x30>
 e6c:	91074000 	add	x0, x0, #0x1d0
 e70:	f9000001 	str	x1, [x0]
        base.s.size = 0;
 e74:	b0000000 	adrp	x0, 1000 <buf+0x30>
 e78:	91074000 	add	x0, x0, #0x1d0
 e7c:	b900081f 	str	wzr, [x0, #8]
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e80:	f9401be0 	ldr	x0, [sp, #48]
 e84:	f9400000 	ldr	x0, [x0]
 e88:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
 e8c:	f9401fe0 	ldr	x0, [sp, #56]
 e90:	b9400800 	ldr	w0, [x0, #8]
 e94:	b9402fe1 	ldr	w1, [sp, #44]
 e98:	6b00003f 	cmp	w1, w0
 e9c:	54000448 	b.hi	f24 <malloc+0x120>  // b.pmore
            if(p->s.size == nunits)
 ea0:	f9401fe0 	ldr	x0, [sp, #56]
 ea4:	b9400800 	ldr	w0, [x0, #8]
 ea8:	b9402fe1 	ldr	w1, [sp, #44]
 eac:	6b00003f 	cmp	w1, w0
 eb0:	540000c1 	b.ne	ec8 <malloc+0xc4>  // b.any
                prevp->s.ptr = p->s.ptr;
 eb4:	f9401fe0 	ldr	x0, [sp, #56]
 eb8:	f9400001 	ldr	x1, [x0]
 ebc:	f9401be0 	ldr	x0, [sp, #48]
 ec0:	f9000001 	str	x1, [x0]
 ec4:	14000011 	b	f08 <malloc+0x104>
            else {
                p->s.size -= nunits;
 ec8:	f9401fe0 	ldr	x0, [sp, #56]
 ecc:	b9400801 	ldr	w1, [x0, #8]
 ed0:	b9402fe0 	ldr	w0, [sp, #44]
 ed4:	4b000021 	sub	w1, w1, w0
 ed8:	f9401fe0 	ldr	x0, [sp, #56]
 edc:	b9000801 	str	w1, [x0, #8]
                p += p->s.size;
 ee0:	f9401fe0 	ldr	x0, [sp, #56]
 ee4:	b9400800 	ldr	w0, [x0, #8]
 ee8:	2a0003e0 	mov	w0, w0
 eec:	d37cec00 	lsl	x0, x0, #4
 ef0:	f9401fe1 	ldr	x1, [sp, #56]
 ef4:	8b000020 	add	x0, x1, x0
 ef8:	f9001fe0 	str	x0, [sp, #56]
                p->s.size = nunits;
 efc:	f9401fe0 	ldr	x0, [sp, #56]
 f00:	b9402fe1 	ldr	w1, [sp, #44]
 f04:	b9000801 	str	w1, [x0, #8]
            }
            freep = prevp;
 f08:	b0000000 	adrp	x0, 1000 <buf+0x30>
 f0c:	91078000 	add	x0, x0, #0x1e0
 f10:	f9401be1 	ldr	x1, [sp, #48]
 f14:	f9000001 	str	x1, [x0]
            return (void*)(p + 1);
 f18:	f9401fe0 	ldr	x0, [sp, #56]
 f1c:	91004000 	add	x0, x0, #0x10
 f20:	14000015 	b	f74 <malloc+0x170>
        }
        if(p == freep)
 f24:	b0000000 	adrp	x0, 1000 <buf+0x30>
 f28:	91078000 	add	x0, x0, #0x1e0
 f2c:	f9400000 	ldr	x0, [x0]
 f30:	f9401fe1 	ldr	x1, [sp, #56]
 f34:	eb00003f 	cmp	x1, x0
 f38:	54000121 	b.ne	f5c <malloc+0x158>  // b.any
            if((p = morecore(nunits)) == 0)
 f3c:	b9402fe0 	ldr	w0, [sp, #44]
 f40:	97ffff93 	bl	d8c <morecore>
 f44:	f9001fe0 	str	x0, [sp, #56]
 f48:	f9401fe0 	ldr	x0, [sp, #56]
 f4c:	f100001f 	cmp	x0, #0x0
 f50:	54000061 	b.ne	f5c <malloc+0x158>  // b.any
                return 0;
 f54:	d2800000 	mov	x0, #0x0                   	// #0
 f58:	14000007 	b	f74 <malloc+0x170>
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f5c:	f9401fe0 	ldr	x0, [sp, #56]
 f60:	f9001be0 	str	x0, [sp, #48]
 f64:	f9401fe0 	ldr	x0, [sp, #56]
 f68:	f9400000 	ldr	x0, [x0]
 f6c:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
 f70:	17ffffc7 	b	e8c <malloc+0x88>
    }
}
 f74:	a8c47bfd 	ldp	x29, x30, [sp], #64
 f78:	d65f03c0 	ret
