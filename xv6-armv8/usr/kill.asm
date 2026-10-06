
_kill:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
   4:	910003fd 	mov	x29, sp
   8:	b9001fe0 	str	w0, [sp, #28]
   c:	f9000be1 	str	x1, [sp, #16]
    int i;
    
    if(argc < 1){
  10:	b9401fe0 	ldr	w0, [sp, #28]
  14:	7100001f 	cmp	w0, #0x0
  18:	540000cc 	b.gt	30 <main+0x30>
        printf(2, "usage: kill pid...\n");
  1c:	90000000 	adrp	x0, 0 <main>
  20:	913b2001 	add	x1, x0, #0xec8
  24:	52800040 	mov	w0, #0x2                   	// #2
  28:	94000235 	bl	8fc <printf>
        exit();
  2c:	9400012d 	bl	4e0 <exit>
    }
    for(i=1; i<argc; i++)
  30:	52800020 	mov	w0, #0x1                   	// #1
  34:	b9002fe0 	str	w0, [sp, #44]
  38:	1400000b 	b	64 <main+0x64>
        kill(atoi(argv[i]));
  3c:	b9802fe0 	ldrsw	x0, [sp, #44]
  40:	d37df000 	lsl	x0, x0, #3
  44:	f9400be1 	ldr	x1, [sp, #16]
  48:	8b000020 	add	x0, x1, x0
  4c:	f9400000 	ldr	x0, [x0]
  50:	940000e6 	bl	3e8 <atoi>
  54:	94000159 	bl	5b8 <kill>
    for(i=1; i<argc; i++)
  58:	b9402fe0 	ldr	w0, [sp, #44]
  5c:	11000400 	add	w0, w0, #0x1
  60:	b9002fe0 	str	w0, [sp, #44]
  64:	b9402fe1 	ldr	w1, [sp, #44]
  68:	b9401fe0 	ldr	w0, [sp, #28]
  6c:	6b00003f 	cmp	w1, w0
  70:	54fffe6b 	b.lt	3c <main+0x3c>  // b.tstop
    exit();
  74:	9400011b 	bl	4e0 <exit>

0000000000000078 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  78:	d10083ff 	sub	sp, sp, #0x20
  7c:	f90007e0 	str	x0, [sp, #8]
  80:	f90003e1 	str	x1, [sp]
    char *os;
    
    os = s;
  84:	f94007e0 	ldr	x0, [sp, #8]
  88:	f9000fe0 	str	x0, [sp, #24]
    while((*s++ = *t++) != 0)
  8c:	d503201f 	nop
  90:	f94003e1 	ldr	x1, [sp]
  94:	91000420 	add	x0, x1, #0x1
  98:	f90003e0 	str	x0, [sp]
  9c:	f94007e0 	ldr	x0, [sp, #8]
  a0:	91000402 	add	x2, x0, #0x1
  a4:	f90007e2 	str	x2, [sp, #8]
  a8:	39400021 	ldrb	w1, [x1]
  ac:	39000001 	strb	w1, [x0]
  b0:	39400000 	ldrb	w0, [x0]
  b4:	7100001f 	cmp	w0, #0x0
  b8:	54fffec1 	b.ne	90 <strcpy+0x18>  // b.any
        ;
    return os;
  bc:	f9400fe0 	ldr	x0, [sp, #24]
}
  c0:	910083ff 	add	sp, sp, #0x20
  c4:	d65f03c0 	ret

00000000000000c8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c8:	d10043ff 	sub	sp, sp, #0x10
  cc:	f90007e0 	str	x0, [sp, #8]
  d0:	f90003e1 	str	x1, [sp]
    while(*p && *p == *q)
  d4:	14000007 	b	f0 <strcmp+0x28>
        p++, q++;
  d8:	f94007e0 	ldr	x0, [sp, #8]
  dc:	91000400 	add	x0, x0, #0x1
  e0:	f90007e0 	str	x0, [sp, #8]
  e4:	f94003e0 	ldr	x0, [sp]
  e8:	91000400 	add	x0, x0, #0x1
  ec:	f90003e0 	str	x0, [sp]
    while(*p && *p == *q)
  f0:	f94007e0 	ldr	x0, [sp, #8]
  f4:	39400000 	ldrb	w0, [x0]
  f8:	7100001f 	cmp	w0, #0x0
  fc:	540000e0 	b.eq	118 <strcmp+0x50>  // b.none
 100:	f94007e0 	ldr	x0, [sp, #8]
 104:	39400001 	ldrb	w1, [x0]
 108:	f94003e0 	ldr	x0, [sp]
 10c:	39400000 	ldrb	w0, [x0]
 110:	6b00003f 	cmp	w1, w0
 114:	54fffe20 	b.eq	d8 <strcmp+0x10>  // b.none
    return (uchar)*p - (uchar)*q;
 118:	f94007e0 	ldr	x0, [sp, #8]
 11c:	39400000 	ldrb	w0, [x0]
 120:	2a0003e1 	mov	w1, w0
 124:	f94003e0 	ldr	x0, [sp]
 128:	39400000 	ldrb	w0, [x0]
 12c:	4b000020 	sub	w0, w1, w0
}
 130:	910043ff 	add	sp, sp, #0x10
 134:	d65f03c0 	ret

0000000000000138 <strlen>:

uint
strlen(char *s)
{
 138:	d10083ff 	sub	sp, sp, #0x20
 13c:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    for(n = 0; s[n]; n++)
 140:	b9001fff 	str	wzr, [sp, #28]
 144:	14000004 	b	154 <strlen+0x1c>
 148:	b9401fe0 	ldr	w0, [sp, #28]
 14c:	11000400 	add	w0, w0, #0x1
 150:	b9001fe0 	str	w0, [sp, #28]
 154:	b9801fe0 	ldrsw	x0, [sp, #28]
 158:	f94007e1 	ldr	x1, [sp, #8]
 15c:	8b000020 	add	x0, x1, x0
 160:	39400000 	ldrb	w0, [x0]
 164:	7100001f 	cmp	w0, #0x0
 168:	54ffff01 	b.ne	148 <strlen+0x10>  // b.any
        ;
    return n;
 16c:	b9401fe0 	ldr	w0, [sp, #28]
}
 170:	910083ff 	add	sp, sp, #0x20
 174:	d65f03c0 	ret

0000000000000178 <memset>:

void*
memset(void *dst, int v, uint n)
{
 178:	d100c3ff 	sub	sp, sp, #0x30
 17c:	f90007e0 	str	x0, [sp, #8]
 180:	b90007e1 	str	w1, [sp, #4]
 184:	b90003e2 	str	w2, [sp]
	uint8	*p;
	uint8	c;
	uint32	val;
	uint32	*p4;

	p   = dst;
 188:	f94007e0 	ldr	x0, [sp, #8]
 18c:	f90017e0 	str	x0, [sp, #40]
	c   = v & 0xff;
 190:	b94007e0 	ldr	w0, [sp, #4]
 194:	39007fe0 	strb	w0, [sp, #31]
	val = (c << 24) | (c << 16) | (c << 8) | c;
 198:	39407fe1 	ldrb	w1, [sp, #31]
 19c:	2a0103e0 	mov	w0, w1
 1a0:	53185c00 	lsl	w0, w0, #8
 1a4:	0b010000 	add	w0, w0, w1
 1a8:	53103c00 	lsl	w0, w0, #16
 1ac:	2a0003e1 	mov	w1, w0
 1b0:	39407fe0 	ldrb	w0, [sp, #31]
 1b4:	53185c00 	lsl	w0, w0, #8
 1b8:	2a000021 	orr	w1, w1, w0
 1bc:	39407fe0 	ldrb	w0, [sp, #31]
 1c0:	2a000020 	orr	w0, w1, w0
 1c4:	b9001be0 	str	w0, [sp, #24]

	// set bytes before whole uint32
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
 1c8:	1400000a 	b	1f0 <memset+0x78>
		*p = c;
 1cc:	f94017e0 	ldr	x0, [sp, #40]
 1d0:	39407fe1 	ldrb	w1, [sp, #31]
 1d4:	39000001 	strb	w1, [x0]
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
 1d8:	b94003e0 	ldr	w0, [sp]
 1dc:	51000400 	sub	w0, w0, #0x1
 1e0:	b90003e0 	str	w0, [sp]
 1e4:	f94017e0 	ldr	x0, [sp, #40]
 1e8:	91000400 	add	x0, x0, #0x1
 1ec:	f90017e0 	str	x0, [sp, #40]
 1f0:	b94003e0 	ldr	w0, [sp]
 1f4:	7100001f 	cmp	w0, #0x0
 1f8:	540000a0 	b.eq	20c <memset+0x94>  // b.none
 1fc:	f94017e0 	ldr	x0, [sp, #40]
 200:	92400400 	and	x0, x0, #0x3
 204:	f100001f 	cmp	x0, #0x0
 208:	54fffe21 	b.ne	1cc <memset+0x54>  // b.any
	}

	// set memory 4 bytes a time
	p4 = (uint*)p;
 20c:	f94017e0 	ldr	x0, [sp, #40]
 210:	f90013e0 	str	x0, [sp, #32]

	for (; n >= 4; n -= 4, p4++) {
 214:	1400000a 	b	23c <memset+0xc4>
		*p4 = val;
 218:	f94013e0 	ldr	x0, [sp, #32]
 21c:	b9401be1 	ldr	w1, [sp, #24]
 220:	b9000001 	str	w1, [x0]
	for (; n >= 4; n -= 4, p4++) {
 224:	b94003e0 	ldr	w0, [sp]
 228:	51001000 	sub	w0, w0, #0x4
 22c:	b90003e0 	str	w0, [sp]
 230:	f94013e0 	ldr	x0, [sp, #32]
 234:	91001000 	add	x0, x0, #0x4
 238:	f90013e0 	str	x0, [sp, #32]
 23c:	b94003e0 	ldr	w0, [sp]
 240:	71000c1f 	cmp	w0, #0x3
 244:	54fffea8 	b.hi	218 <memset+0xa0>  // b.pmore
	}

	// set leftover one byte a time
	p = (uint8*)p4;
 248:	f94013e0 	ldr	x0, [sp, #32]
 24c:	f90017e0 	str	x0, [sp, #40]

	for (; n > 0; n--, p++) {
 250:	1400000a 	b	278 <memset+0x100>
		*p = c;
 254:	f94017e0 	ldr	x0, [sp, #40]
 258:	39407fe1 	ldrb	w1, [sp, #31]
 25c:	39000001 	strb	w1, [x0]
	for (; n > 0; n--, p++) {
 260:	b94003e0 	ldr	w0, [sp]
 264:	51000400 	sub	w0, w0, #0x1
 268:	b90003e0 	str	w0, [sp]
 26c:	f94017e0 	ldr	x0, [sp, #40]
 270:	91000400 	add	x0, x0, #0x1
 274:	f90017e0 	str	x0, [sp, #40]
 278:	b94003e0 	ldr	w0, [sp]
 27c:	7100001f 	cmp	w0, #0x0
 280:	54fffea1 	b.ne	254 <memset+0xdc>  // b.any
	}

	return dst;
 284:	f94007e0 	ldr	x0, [sp, #8]
}
 288:	9100c3ff 	add	sp, sp, #0x30
 28c:	d65f03c0 	ret

0000000000000290 <strchr>:

char*
strchr(const char *s, char c)
{
 290:	d10043ff 	sub	sp, sp, #0x10
 294:	f90007e0 	str	x0, [sp, #8]
 298:	39001fe1 	strb	w1, [sp, #7]
    for(; *s; s++)
 29c:	1400000b 	b	2c8 <strchr+0x38>
        if(*s == c)
 2a0:	f94007e0 	ldr	x0, [sp, #8]
 2a4:	39400000 	ldrb	w0, [x0]
 2a8:	39401fe1 	ldrb	w1, [sp, #7]
 2ac:	6b00003f 	cmp	w1, w0
 2b0:	54000061 	b.ne	2bc <strchr+0x2c>  // b.any
            return (char*)s;
 2b4:	f94007e0 	ldr	x0, [sp, #8]
 2b8:	14000009 	b	2dc <strchr+0x4c>
    for(; *s; s++)
 2bc:	f94007e0 	ldr	x0, [sp, #8]
 2c0:	91000400 	add	x0, x0, #0x1
 2c4:	f90007e0 	str	x0, [sp, #8]
 2c8:	f94007e0 	ldr	x0, [sp, #8]
 2cc:	39400000 	ldrb	w0, [x0]
 2d0:	7100001f 	cmp	w0, #0x0
 2d4:	54fffe61 	b.ne	2a0 <strchr+0x10>  // b.any
    return 0;
 2d8:	d2800000 	mov	x0, #0x0                   	// #0
}
 2dc:	910043ff 	add	sp, sp, #0x10
 2e0:	d65f03c0 	ret

00000000000002e4 <gets>:

char*
gets(char *buf, int max)
{
 2e4:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 2e8:	910003fd 	mov	x29, sp
 2ec:	f9000fe0 	str	x0, [sp, #24]
 2f0:	b90017e1 	str	w1, [sp, #20]
    int i, cc;
    char c;
    
    for(i=0; i+1 < max; ){
 2f4:	b9002fff 	str	wzr, [sp, #44]
 2f8:	14000018 	b	358 <gets+0x74>
        cc = read(0, &c, 1);
 2fc:	91009fe0 	add	x0, sp, #0x27
 300:	52800022 	mov	w2, #0x1                   	// #1
 304:	aa0003e1 	mov	x1, x0
 308:	52800000 	mov	w0, #0x0                   	// #0
 30c:	94000090 	bl	54c <read>
 310:	b9002be0 	str	w0, [sp, #40]
        if(cc < 1)
 314:	b9402be0 	ldr	w0, [sp, #40]
 318:	7100001f 	cmp	w0, #0x0
 31c:	540002ad 	b.le	370 <gets+0x8c>
            break;
        buf[i++] = c;
 320:	b9402fe0 	ldr	w0, [sp, #44]
 324:	11000401 	add	w1, w0, #0x1
 328:	b9002fe1 	str	w1, [sp, #44]
 32c:	93407c00 	sxtw	x0, w0
 330:	f9400fe1 	ldr	x1, [sp, #24]
 334:	8b000020 	add	x0, x1, x0
 338:	39409fe1 	ldrb	w1, [sp, #39]
 33c:	39000001 	strb	w1, [x0]
        if(c == '\n' || c == '\r')
 340:	39409fe0 	ldrb	w0, [sp, #39]
 344:	7100281f 	cmp	w0, #0xa
 348:	54000160 	b.eq	374 <gets+0x90>  // b.none
 34c:	39409fe0 	ldrb	w0, [sp, #39]
 350:	7100341f 	cmp	w0, #0xd
 354:	54000100 	b.eq	374 <gets+0x90>  // b.none
    for(i=0; i+1 < max; ){
 358:	b9402fe0 	ldr	w0, [sp, #44]
 35c:	11000400 	add	w0, w0, #0x1
 360:	b94017e1 	ldr	w1, [sp, #20]
 364:	6b00003f 	cmp	w1, w0
 368:	54fffcac 	b.gt	2fc <gets+0x18>
 36c:	14000002 	b	374 <gets+0x90>
            break;
 370:	d503201f 	nop
            break;
    }
    buf[i] = '\0';
 374:	b9802fe0 	ldrsw	x0, [sp, #44]
 378:	f9400fe1 	ldr	x1, [sp, #24]
 37c:	8b000020 	add	x0, x1, x0
 380:	3900001f 	strb	wzr, [x0]
    return buf;
 384:	f9400fe0 	ldr	x0, [sp, #24]
}
 388:	a8c37bfd 	ldp	x29, x30, [sp], #48
 38c:	d65f03c0 	ret

0000000000000390 <stat>:

int
stat(char *n, struct stat *st)
{
 390:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 394:	910003fd 	mov	x29, sp
 398:	f9000fe0 	str	x0, [sp, #24]
 39c:	f9000be1 	str	x1, [sp, #16]
    int fd;
    int r;
    
    fd = open(n, O_RDONLY);
 3a0:	52800001 	mov	w1, #0x0                   	// #0
 3a4:	f9400fe0 	ldr	x0, [sp, #24]
 3a8:	94000096 	bl	600 <open>
 3ac:	b9002fe0 	str	w0, [sp, #44]
    if(fd < 0)
 3b0:	b9402fe0 	ldr	w0, [sp, #44]
 3b4:	7100001f 	cmp	w0, #0x0
 3b8:	5400006a 	b.ge	3c4 <stat+0x34>  // b.tcont
        return -1;
 3bc:	12800000 	mov	w0, #0xffffffff            	// #-1
 3c0:	14000008 	b	3e0 <stat+0x50>
    r = fstat(fd, st);
 3c4:	f9400be1 	ldr	x1, [sp, #16]
 3c8:	b9402fe0 	ldr	w0, [sp, #44]
 3cc:	940000a8 	bl	66c <fstat>
 3d0:	b9002be0 	str	w0, [sp, #40]
    close(fd);
 3d4:	b9402fe0 	ldr	w0, [sp, #44]
 3d8:	9400006f 	bl	594 <close>
    return r;
 3dc:	b9402be0 	ldr	w0, [sp, #40]
}
 3e0:	a8c37bfd 	ldp	x29, x30, [sp], #48
 3e4:	d65f03c0 	ret

00000000000003e8 <atoi>:

int
atoi(const char *s)
{
 3e8:	d10083ff 	sub	sp, sp, #0x20
 3ec:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    n = 0;
 3f0:	b9001fff 	str	wzr, [sp, #28]
    while('0' <= *s && *s <= '9')
 3f4:	1400000e 	b	42c <atoi+0x44>
        n = n*10 + *s++ - '0';
 3f8:	b9401fe1 	ldr	w1, [sp, #28]
 3fc:	2a0103e0 	mov	w0, w1
 400:	531e7400 	lsl	w0, w0, #2
 404:	0b010000 	add	w0, w0, w1
 408:	531f7800 	lsl	w0, w0, #1
 40c:	2a0003e2 	mov	w2, w0
 410:	f94007e0 	ldr	x0, [sp, #8]
 414:	91000401 	add	x1, x0, #0x1
 418:	f90007e1 	str	x1, [sp, #8]
 41c:	39400000 	ldrb	w0, [x0]
 420:	0b000040 	add	w0, w2, w0
 424:	5100c000 	sub	w0, w0, #0x30
 428:	b9001fe0 	str	w0, [sp, #28]
    while('0' <= *s && *s <= '9')
 42c:	f94007e0 	ldr	x0, [sp, #8]
 430:	39400000 	ldrb	w0, [x0]
 434:	7100bc1f 	cmp	w0, #0x2f
 438:	540000a9 	b.ls	44c <atoi+0x64>  // b.plast
 43c:	f94007e0 	ldr	x0, [sp, #8]
 440:	39400000 	ldrb	w0, [x0]
 444:	7100e41f 	cmp	w0, #0x39
 448:	54fffd89 	b.ls	3f8 <atoi+0x10>  // b.plast
    return n;
 44c:	b9401fe0 	ldr	w0, [sp, #28]
}
 450:	910083ff 	add	sp, sp, #0x20
 454:	d65f03c0 	ret

0000000000000458 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 458:	d100c3ff 	sub	sp, sp, #0x30
 45c:	f9000fe0 	str	x0, [sp, #24]
 460:	f9000be1 	str	x1, [sp, #16]
 464:	b9000fe2 	str	w2, [sp, #12]
    char *dst, *src;
    
    dst = vdst;
 468:	f9400fe0 	ldr	x0, [sp, #24]
 46c:	f90017e0 	str	x0, [sp, #40]
    src = vsrc;
 470:	f9400be0 	ldr	x0, [sp, #16]
 474:	f90013e0 	str	x0, [sp, #32]
    while(n-- > 0)
 478:	14000009 	b	49c <memmove+0x44>
        *dst++ = *src++;
 47c:	f94013e1 	ldr	x1, [sp, #32]
 480:	91000420 	add	x0, x1, #0x1
 484:	f90013e0 	str	x0, [sp, #32]
 488:	f94017e0 	ldr	x0, [sp, #40]
 48c:	91000402 	add	x2, x0, #0x1
 490:	f90017e2 	str	x2, [sp, #40]
 494:	39400021 	ldrb	w1, [x1]
 498:	39000001 	strb	w1, [x0]
    while(n-- > 0)
 49c:	b9400fe0 	ldr	w0, [sp, #12]
 4a0:	51000401 	sub	w1, w0, #0x1
 4a4:	b9000fe1 	str	w1, [sp, #12]
 4a8:	7100001f 	cmp	w0, #0x0
 4ac:	54fffe8c 	b.gt	47c <memmove+0x24>
    return vdst;
 4b0:	f9400fe0 	ldr	x0, [sp, #24]
}
 4b4:	9100c3ff 	add	sp, sp, #0x30
 4b8:	d65f03c0 	ret

00000000000004bc <fork>:
 4bc:	f81f8fe4 	str	x4, [sp, #-8]!
 4c0:	aa0303e4 	mov	x4, x3
 4c4:	aa0203e3 	mov	x3, x2
 4c8:	aa0103e2 	mov	x2, x1
 4cc:	aa0003e1 	mov	x1, x0
 4d0:	d2800020 	mov	x0, #0x1                   	// #1
 4d4:	d4000001 	svc	#0x0
 4d8:	f84087e4 	ldr	x4, [sp], #8
 4dc:	d61f03c0 	br	x30

00000000000004e0 <exit>:
 4e0:	f81f8fe4 	str	x4, [sp, #-8]!
 4e4:	aa0303e4 	mov	x4, x3
 4e8:	aa0203e3 	mov	x3, x2
 4ec:	aa0103e2 	mov	x2, x1
 4f0:	aa0003e1 	mov	x1, x0
 4f4:	d2800040 	mov	x0, #0x2                   	// #2
 4f8:	d4000001 	svc	#0x0
 4fc:	f84087e4 	ldr	x4, [sp], #8
 500:	d61f03c0 	br	x30

0000000000000504 <wait>:
 504:	f81f8fe4 	str	x4, [sp, #-8]!
 508:	aa0303e4 	mov	x4, x3
 50c:	aa0203e3 	mov	x3, x2
 510:	aa0103e2 	mov	x2, x1
 514:	aa0003e1 	mov	x1, x0
 518:	d2800060 	mov	x0, #0x3                   	// #3
 51c:	d4000001 	svc	#0x0
 520:	f84087e4 	ldr	x4, [sp], #8
 524:	d61f03c0 	br	x30

0000000000000528 <pipe>:
 528:	f81f8fe4 	str	x4, [sp, #-8]!
 52c:	aa0303e4 	mov	x4, x3
 530:	aa0203e3 	mov	x3, x2
 534:	aa0103e2 	mov	x2, x1
 538:	aa0003e1 	mov	x1, x0
 53c:	d2800080 	mov	x0, #0x4                   	// #4
 540:	d4000001 	svc	#0x0
 544:	f84087e4 	ldr	x4, [sp], #8
 548:	d61f03c0 	br	x30

000000000000054c <read>:
 54c:	f81f8fe4 	str	x4, [sp, #-8]!
 550:	aa0303e4 	mov	x4, x3
 554:	aa0203e3 	mov	x3, x2
 558:	aa0103e2 	mov	x2, x1
 55c:	aa0003e1 	mov	x1, x0
 560:	d28000a0 	mov	x0, #0x5                   	// #5
 564:	d4000001 	svc	#0x0
 568:	f84087e4 	ldr	x4, [sp], #8
 56c:	d61f03c0 	br	x30

0000000000000570 <write>:
 570:	f81f8fe4 	str	x4, [sp, #-8]!
 574:	aa0303e4 	mov	x4, x3
 578:	aa0203e3 	mov	x3, x2
 57c:	aa0103e2 	mov	x2, x1
 580:	aa0003e1 	mov	x1, x0
 584:	d2800200 	mov	x0, #0x10                  	// #16
 588:	d4000001 	svc	#0x0
 58c:	f84087e4 	ldr	x4, [sp], #8
 590:	d61f03c0 	br	x30

0000000000000594 <close>:
 594:	f81f8fe4 	str	x4, [sp, #-8]!
 598:	aa0303e4 	mov	x4, x3
 59c:	aa0203e3 	mov	x3, x2
 5a0:	aa0103e2 	mov	x2, x1
 5a4:	aa0003e1 	mov	x1, x0
 5a8:	d28002a0 	mov	x0, #0x15                  	// #21
 5ac:	d4000001 	svc	#0x0
 5b0:	f84087e4 	ldr	x4, [sp], #8
 5b4:	d61f03c0 	br	x30

00000000000005b8 <kill>:
 5b8:	f81f8fe4 	str	x4, [sp, #-8]!
 5bc:	aa0303e4 	mov	x4, x3
 5c0:	aa0203e3 	mov	x3, x2
 5c4:	aa0103e2 	mov	x2, x1
 5c8:	aa0003e1 	mov	x1, x0
 5cc:	d28000c0 	mov	x0, #0x6                   	// #6
 5d0:	d4000001 	svc	#0x0
 5d4:	f84087e4 	ldr	x4, [sp], #8
 5d8:	d61f03c0 	br	x30

00000000000005dc <exec>:
 5dc:	f81f8fe4 	str	x4, [sp, #-8]!
 5e0:	aa0303e4 	mov	x4, x3
 5e4:	aa0203e3 	mov	x3, x2
 5e8:	aa0103e2 	mov	x2, x1
 5ec:	aa0003e1 	mov	x1, x0
 5f0:	d28000e0 	mov	x0, #0x7                   	// #7
 5f4:	d4000001 	svc	#0x0
 5f8:	f84087e4 	ldr	x4, [sp], #8
 5fc:	d61f03c0 	br	x30

0000000000000600 <open>:
 600:	f81f8fe4 	str	x4, [sp, #-8]!
 604:	aa0303e4 	mov	x4, x3
 608:	aa0203e3 	mov	x3, x2
 60c:	aa0103e2 	mov	x2, x1
 610:	aa0003e1 	mov	x1, x0
 614:	d28001e0 	mov	x0, #0xf                   	// #15
 618:	d4000001 	svc	#0x0
 61c:	f84087e4 	ldr	x4, [sp], #8
 620:	d61f03c0 	br	x30

0000000000000624 <mknod>:
 624:	f81f8fe4 	str	x4, [sp, #-8]!
 628:	aa0303e4 	mov	x4, x3
 62c:	aa0203e3 	mov	x3, x2
 630:	aa0103e2 	mov	x2, x1
 634:	aa0003e1 	mov	x1, x0
 638:	d2800220 	mov	x0, #0x11                  	// #17
 63c:	d4000001 	svc	#0x0
 640:	f84087e4 	ldr	x4, [sp], #8
 644:	d61f03c0 	br	x30

0000000000000648 <unlink>:
 648:	f81f8fe4 	str	x4, [sp, #-8]!
 64c:	aa0303e4 	mov	x4, x3
 650:	aa0203e3 	mov	x3, x2
 654:	aa0103e2 	mov	x2, x1
 658:	aa0003e1 	mov	x1, x0
 65c:	d2800240 	mov	x0, #0x12                  	// #18
 660:	d4000001 	svc	#0x0
 664:	f84087e4 	ldr	x4, [sp], #8
 668:	d61f03c0 	br	x30

000000000000066c <fstat>:
 66c:	f81f8fe4 	str	x4, [sp, #-8]!
 670:	aa0303e4 	mov	x4, x3
 674:	aa0203e3 	mov	x3, x2
 678:	aa0103e2 	mov	x2, x1
 67c:	aa0003e1 	mov	x1, x0
 680:	d2800100 	mov	x0, #0x8                   	// #8
 684:	d4000001 	svc	#0x0
 688:	f84087e4 	ldr	x4, [sp], #8
 68c:	d61f03c0 	br	x30

0000000000000690 <link>:
 690:	f81f8fe4 	str	x4, [sp, #-8]!
 694:	aa0303e4 	mov	x4, x3
 698:	aa0203e3 	mov	x3, x2
 69c:	aa0103e2 	mov	x2, x1
 6a0:	aa0003e1 	mov	x1, x0
 6a4:	d2800260 	mov	x0, #0x13                  	// #19
 6a8:	d4000001 	svc	#0x0
 6ac:	f84087e4 	ldr	x4, [sp], #8
 6b0:	d61f03c0 	br	x30

00000000000006b4 <mkdir>:
 6b4:	f81f8fe4 	str	x4, [sp, #-8]!
 6b8:	aa0303e4 	mov	x4, x3
 6bc:	aa0203e3 	mov	x3, x2
 6c0:	aa0103e2 	mov	x2, x1
 6c4:	aa0003e1 	mov	x1, x0
 6c8:	d2800280 	mov	x0, #0x14                  	// #20
 6cc:	d4000001 	svc	#0x0
 6d0:	f84087e4 	ldr	x4, [sp], #8
 6d4:	d61f03c0 	br	x30

00000000000006d8 <chdir>:
 6d8:	f81f8fe4 	str	x4, [sp, #-8]!
 6dc:	aa0303e4 	mov	x4, x3
 6e0:	aa0203e3 	mov	x3, x2
 6e4:	aa0103e2 	mov	x2, x1
 6e8:	aa0003e1 	mov	x1, x0
 6ec:	d2800120 	mov	x0, #0x9                   	// #9
 6f0:	d4000001 	svc	#0x0
 6f4:	f84087e4 	ldr	x4, [sp], #8
 6f8:	d61f03c0 	br	x30

00000000000006fc <dup>:
 6fc:	f81f8fe4 	str	x4, [sp, #-8]!
 700:	aa0303e4 	mov	x4, x3
 704:	aa0203e3 	mov	x3, x2
 708:	aa0103e2 	mov	x2, x1
 70c:	aa0003e1 	mov	x1, x0
 710:	d2800140 	mov	x0, #0xa                   	// #10
 714:	d4000001 	svc	#0x0
 718:	f84087e4 	ldr	x4, [sp], #8
 71c:	d61f03c0 	br	x30

0000000000000720 <getpid>:
 720:	f81f8fe4 	str	x4, [sp, #-8]!
 724:	aa0303e4 	mov	x4, x3
 728:	aa0203e3 	mov	x3, x2
 72c:	aa0103e2 	mov	x2, x1
 730:	aa0003e1 	mov	x1, x0
 734:	d2800160 	mov	x0, #0xb                   	// #11
 738:	d4000001 	svc	#0x0
 73c:	f84087e4 	ldr	x4, [sp], #8
 740:	d61f03c0 	br	x30

0000000000000744 <sbrk>:
 744:	f81f8fe4 	str	x4, [sp, #-8]!
 748:	aa0303e4 	mov	x4, x3
 74c:	aa0203e3 	mov	x3, x2
 750:	aa0103e2 	mov	x2, x1
 754:	aa0003e1 	mov	x1, x0
 758:	d2800180 	mov	x0, #0xc                   	// #12
 75c:	d4000001 	svc	#0x0
 760:	f84087e4 	ldr	x4, [sp], #8
 764:	d61f03c0 	br	x30

0000000000000768 <sleep>:
 768:	f81f8fe4 	str	x4, [sp, #-8]!
 76c:	aa0303e4 	mov	x4, x3
 770:	aa0203e3 	mov	x3, x2
 774:	aa0103e2 	mov	x2, x1
 778:	aa0003e1 	mov	x1, x0
 77c:	d28001a0 	mov	x0, #0xd                   	// #13
 780:	d4000001 	svc	#0x0
 784:	f84087e4 	ldr	x4, [sp], #8
 788:	d61f03c0 	br	x30

000000000000078c <uptime>:
 78c:	f81f8fe4 	str	x4, [sp, #-8]!
 790:	aa0303e4 	mov	x4, x3
 794:	aa0203e3 	mov	x3, x2
 798:	aa0103e2 	mov	x2, x1
 79c:	aa0003e1 	mov	x1, x0
 7a0:	d28001c0 	mov	x0, #0xe                   	// #14
 7a4:	d4000001 	svc	#0x0
 7a8:	f84087e4 	ldr	x4, [sp], #8
 7ac:	d61f03c0 	br	x30

00000000000007b0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 7b0:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
 7b4:	910003fd 	mov	x29, sp
 7b8:	b9001fe0 	str	w0, [sp, #28]
 7bc:	39006fe1 	strb	w1, [sp, #27]
    write(fd, &c, 1);
 7c0:	91006fe0 	add	x0, sp, #0x1b
 7c4:	52800022 	mov	w2, #0x1                   	// #1
 7c8:	aa0003e1 	mov	x1, x0
 7cc:	b9401fe0 	ldr	w0, [sp, #28]
 7d0:	97ffff68 	bl	570 <write>
}
 7d4:	d503201f 	nop
 7d8:	a8c27bfd 	ldp	x29, x30, [sp], #32
 7dc:	d65f03c0 	ret

00000000000007e0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7e0:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 7e4:	910003fd 	mov	x29, sp
 7e8:	b9001fe0 	str	w0, [sp, #28]
 7ec:	b9001be1 	str	w1, [sp, #24]
 7f0:	b90017e2 	str	w2, [sp, #20]
 7f4:	b90013e3 	str	w3, [sp, #16]
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
 7f8:	b9003bff 	str	wzr, [sp, #56]
    if(sgn && xx < 0){
 7fc:	b94013e0 	ldr	w0, [sp, #16]
 800:	7100001f 	cmp	w0, #0x0
 804:	54000140 	b.eq	82c <printint+0x4c>  // b.none
 808:	b9401be0 	ldr	w0, [sp, #24]
 80c:	7100001f 	cmp	w0, #0x0
 810:	540000ea 	b.ge	82c <printint+0x4c>  // b.tcont
        neg = 1;
 814:	52800020 	mov	w0, #0x1                   	// #1
 818:	b9003be0 	str	w0, [sp, #56]
        x = -xx;
 81c:	b9401be0 	ldr	w0, [sp, #24]
 820:	4b0003e0 	neg	w0, w0
 824:	b90037e0 	str	w0, [sp, #52]
 828:	14000003 	b	834 <printint+0x54>
    } else {
        x = xx;
 82c:	b9401be0 	ldr	w0, [sp, #24]
 830:	b90037e0 	str	w0, [sp, #52]
    }
    
    i = 0;
 834:	b9003fff 	str	wzr, [sp, #60]
    do{
        buf[i++] = digits[x % base];
 838:	b94017e1 	ldr	w1, [sp, #20]
 83c:	b94037e0 	ldr	w0, [sp, #52]
 840:	1ac10802 	udiv	w2, w0, w1
 844:	1b017c41 	mul	w1, w2, w1
 848:	4b010003 	sub	w3, w0, w1
 84c:	b9403fe0 	ldr	w0, [sp, #60]
 850:	11000401 	add	w1, w0, #0x1
 854:	b9003fe1 	str	w1, [sp, #60]
 858:	90000001 	adrp	x1, 0 <main>
 85c:	913ba022 	add	x2, x1, #0xee8
 860:	2a0303e1 	mov	w1, w3
 864:	38616842 	ldrb	w2, [x2, x1]
 868:	93407c00 	sxtw	x0, w0
 86c:	910083e1 	add	x1, sp, #0x20
 870:	38206822 	strb	w2, [x1, x0]
    }while((x /= base) != 0);
 874:	b94017e0 	ldr	w0, [sp, #20]
 878:	b94037e1 	ldr	w1, [sp, #52]
 87c:	1ac00820 	udiv	w0, w1, w0
 880:	b90037e0 	str	w0, [sp, #52]
 884:	b94037e0 	ldr	w0, [sp, #52]
 888:	7100001f 	cmp	w0, #0x0
 88c:	54fffd61 	b.ne	838 <printint+0x58>  // b.any
    if(neg)
 890:	b9403be0 	ldr	w0, [sp, #56]
 894:	7100001f 	cmp	w0, #0x0
 898:	540001e0 	b.eq	8d4 <printint+0xf4>  // b.none
        buf[i++] = '-';
 89c:	b9403fe0 	ldr	w0, [sp, #60]
 8a0:	11000401 	add	w1, w0, #0x1
 8a4:	b9003fe1 	str	w1, [sp, #60]
 8a8:	93407c00 	sxtw	x0, w0
 8ac:	910083e1 	add	x1, sp, #0x20
 8b0:	528005a2 	mov	w2, #0x2d                  	// #45
 8b4:	38206822 	strb	w2, [x1, x0]
    
    while(--i >= 0)
 8b8:	14000007 	b	8d4 <printint+0xf4>
        putc(fd, buf[i]);
 8bc:	b9803fe0 	ldrsw	x0, [sp, #60]
 8c0:	910083e1 	add	x1, sp, #0x20
 8c4:	38606820 	ldrb	w0, [x1, x0]
 8c8:	2a0003e1 	mov	w1, w0
 8cc:	b9401fe0 	ldr	w0, [sp, #28]
 8d0:	97ffffb8 	bl	7b0 <putc>
    while(--i >= 0)
 8d4:	b9403fe0 	ldr	w0, [sp, #60]
 8d8:	51000400 	sub	w0, w0, #0x1
 8dc:	b9003fe0 	str	w0, [sp, #60]
 8e0:	b9403fe0 	ldr	w0, [sp, #60]
 8e4:	7100001f 	cmp	w0, #0x0
 8e8:	54fffeaa 	b.ge	8bc <printint+0xdc>  // b.tcont
}
 8ec:	d503201f 	nop
 8f0:	d503201f 	nop
 8f4:	a8c47bfd 	ldp	x29, x30, [sp], #64
 8f8:	d65f03c0 	ret

00000000000008fc <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 8fc:	a9b17bfd 	stp	x29, x30, [sp, #-240]!
 900:	910003fd 	mov	x29, sp
 904:	b9001fe0 	str	w0, [sp, #28]
 908:	f9000be1 	str	x1, [sp, #16]
 90c:	f90063e2 	str	x2, [sp, #192]
 910:	f90067e3 	str	x3, [sp, #200]
 914:	f9006be4 	str	x4, [sp, #208]
 918:	f9006fe5 	str	x5, [sp, #216]
 91c:	f90073e6 	str	x6, [sp, #224]
 920:	f90077e7 	str	x7, [sp, #232]
 924:	3d8013e0 	str	q0, [sp, #64]
 928:	3d8017e1 	str	q1, [sp, #80]
 92c:	3d801be2 	str	q2, [sp, #96]
 930:	3d801fe3 	str	q3, [sp, #112]
 934:	3d8023e4 	str	q4, [sp, #128]
 938:	3d8027e5 	str	q5, [sp, #144]
 93c:	3d802be6 	str	q6, [sp, #160]
 940:	3d802fe7 	str	q7, [sp, #176]
    char *s;
    int c, i, state;
    uint64 *ap;
    
    state = 0;
 944:	b90033ff 	str	wzr, [sp, #48]
    ap = (uint64*)(void*)&fmt + 22;
 948:	910043e0 	add	x0, sp, #0x10
 94c:	9102c000 	add	x0, x0, #0xb0
 950:	f90017e0 	str	x0, [sp, #40]
    for(i = 0; fmt[i]; i++){
 954:	b90037ff 	str	wzr, [sp, #52]
 958:	14000076 	b	b30 <printf+0x234>
        c = fmt[i] & 0xff;
 95c:	f9400be1 	ldr	x1, [sp, #16]
 960:	b98037e0 	ldrsw	x0, [sp, #52]
 964:	8b000020 	add	x0, x1, x0
 968:	39400000 	ldrb	w0, [x0]
 96c:	b90027e0 	str	w0, [sp, #36]
        if(state == 0){
 970:	b94033e0 	ldr	w0, [sp, #48]
 974:	7100001f 	cmp	w0, #0x0
 978:	540001a1 	b.ne	9ac <printf+0xb0>  // b.any
            if(c == '%'){
 97c:	b94027e0 	ldr	w0, [sp, #36]
 980:	7100941f 	cmp	w0, #0x25
 984:	54000081 	b.ne	994 <printf+0x98>  // b.any
                state = '%';
 988:	528004a0 	mov	w0, #0x25                  	// #37
 98c:	b90033e0 	str	w0, [sp, #48]
 990:	14000065 	b	b24 <printf+0x228>
            } else {
                putc(fd, c);
 994:	b94027e0 	ldr	w0, [sp, #36]
 998:	12001c00 	and	w0, w0, #0xff
 99c:	2a0003e1 	mov	w1, w0
 9a0:	b9401fe0 	ldr	w0, [sp, #28]
 9a4:	97ffff83 	bl	7b0 <putc>
 9a8:	1400005f 	b	b24 <printf+0x228>
            }
        } else if(state == '%'){
 9ac:	b94033e0 	ldr	w0, [sp, #48]
 9b0:	7100941f 	cmp	w0, #0x25
 9b4:	54000b81 	b.ne	b24 <printf+0x228>  // b.any
            if(c == 'd'){
 9b8:	b94027e0 	ldr	w0, [sp, #36]
 9bc:	7101901f 	cmp	w0, #0x64
 9c0:	54000181 	b.ne	9f0 <printf+0xf4>  // b.any
                printint(fd, *ap, 10, 1);
 9c4:	f94017e0 	ldr	x0, [sp, #40]
 9c8:	f9400000 	ldr	x0, [x0]
 9cc:	52800023 	mov	w3, #0x1                   	// #1
 9d0:	52800142 	mov	w2, #0xa                   	// #10
 9d4:	2a0003e1 	mov	w1, w0
 9d8:	b9401fe0 	ldr	w0, [sp, #28]
 9dc:	97ffff81 	bl	7e0 <printint>
                ap++;
 9e0:	f94017e0 	ldr	x0, [sp, #40]
 9e4:	91002000 	add	x0, x0, #0x8
 9e8:	f90017e0 	str	x0, [sp, #40]
 9ec:	1400004d 	b	b20 <printf+0x224>
            } else if(c == 'x' || c == 'p'){
 9f0:	b94027e0 	ldr	w0, [sp, #36]
 9f4:	7101e01f 	cmp	w0, #0x78
 9f8:	54000080 	b.eq	a08 <printf+0x10c>  // b.none
 9fc:	b94027e0 	ldr	w0, [sp, #36]
 a00:	7101c01f 	cmp	w0, #0x70
 a04:	54000181 	b.ne	a34 <printf+0x138>  // b.any
                printint(fd, *ap, 16, 0);
 a08:	f94017e0 	ldr	x0, [sp, #40]
 a0c:	f9400000 	ldr	x0, [x0]
 a10:	52800003 	mov	w3, #0x0                   	// #0
 a14:	52800202 	mov	w2, #0x10                  	// #16
 a18:	2a0003e1 	mov	w1, w0
 a1c:	b9401fe0 	ldr	w0, [sp, #28]
 a20:	97ffff70 	bl	7e0 <printint>
                ap++;
 a24:	f94017e0 	ldr	x0, [sp, #40]
 a28:	91002000 	add	x0, x0, #0x8
 a2c:	f90017e0 	str	x0, [sp, #40]
 a30:	1400003c 	b	b20 <printf+0x224>
            } else if(c == 's'){
 a34:	b94027e0 	ldr	w0, [sp, #36]
 a38:	7101cc1f 	cmp	w0, #0x73
 a3c:	54000361 	b.ne	aa8 <printf+0x1ac>  // b.any
                s = (char*)*ap;
 a40:	f94017e0 	ldr	x0, [sp, #40]
 a44:	f9400000 	ldr	x0, [x0]
 a48:	f9001fe0 	str	x0, [sp, #56]
                ap++;
 a4c:	f94017e0 	ldr	x0, [sp, #40]
 a50:	91002000 	add	x0, x0, #0x8
 a54:	f90017e0 	str	x0, [sp, #40]
                if(s == 0)
 a58:	f9401fe0 	ldr	x0, [sp, #56]
 a5c:	f100001f 	cmp	x0, #0x0
 a60:	540001a1 	b.ne	a94 <printf+0x198>  // b.any
                    s = "(null)";
 a64:	90000000 	adrp	x0, 0 <main>
 a68:	913b8000 	add	x0, x0, #0xee0
 a6c:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
 a70:	14000009 	b	a94 <printf+0x198>
                    putc(fd, *s);
 a74:	f9401fe0 	ldr	x0, [sp, #56]
 a78:	39400000 	ldrb	w0, [x0]
 a7c:	2a0003e1 	mov	w1, w0
 a80:	b9401fe0 	ldr	w0, [sp, #28]
 a84:	97ffff4b 	bl	7b0 <putc>
                    s++;
 a88:	f9401fe0 	ldr	x0, [sp, #56]
 a8c:	91000400 	add	x0, x0, #0x1
 a90:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
 a94:	f9401fe0 	ldr	x0, [sp, #56]
 a98:	39400000 	ldrb	w0, [x0]
 a9c:	7100001f 	cmp	w0, #0x0
 aa0:	54fffea1 	b.ne	a74 <printf+0x178>  // b.any
 aa4:	1400001f 	b	b20 <printf+0x224>
                }
            } else if(c == 'c'){
 aa8:	b94027e0 	ldr	w0, [sp, #36]
 aac:	71018c1f 	cmp	w0, #0x63
 ab0:	54000161 	b.ne	adc <printf+0x1e0>  // b.any
                putc(fd, *ap);
 ab4:	f94017e0 	ldr	x0, [sp, #40]
 ab8:	f9400000 	ldr	x0, [x0]
 abc:	12001c00 	and	w0, w0, #0xff
 ac0:	2a0003e1 	mov	w1, w0
 ac4:	b9401fe0 	ldr	w0, [sp, #28]
 ac8:	97ffff3a 	bl	7b0 <putc>
                ap++;
 acc:	f94017e0 	ldr	x0, [sp, #40]
 ad0:	91002000 	add	x0, x0, #0x8
 ad4:	f90017e0 	str	x0, [sp, #40]
 ad8:	14000012 	b	b20 <printf+0x224>
            } else if(c == '%'){
 adc:	b94027e0 	ldr	w0, [sp, #36]
 ae0:	7100941f 	cmp	w0, #0x25
 ae4:	540000e1 	b.ne	b00 <printf+0x204>  // b.any
                putc(fd, c);
 ae8:	b94027e0 	ldr	w0, [sp, #36]
 aec:	12001c00 	and	w0, w0, #0xff
 af0:	2a0003e1 	mov	w1, w0
 af4:	b9401fe0 	ldr	w0, [sp, #28]
 af8:	97ffff2e 	bl	7b0 <putc>
 afc:	14000009 	b	b20 <printf+0x224>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
 b00:	528004a1 	mov	w1, #0x25                  	// #37
 b04:	b9401fe0 	ldr	w0, [sp, #28]
 b08:	97ffff2a 	bl	7b0 <putc>
                putc(fd, c);
 b0c:	b94027e0 	ldr	w0, [sp, #36]
 b10:	12001c00 	and	w0, w0, #0xff
 b14:	2a0003e1 	mov	w1, w0
 b18:	b9401fe0 	ldr	w0, [sp, #28]
 b1c:	97ffff25 	bl	7b0 <putc>
            }
            state = 0;
 b20:	b90033ff 	str	wzr, [sp, #48]
    for(i = 0; fmt[i]; i++){
 b24:	b94037e0 	ldr	w0, [sp, #52]
 b28:	11000400 	add	w0, w0, #0x1
 b2c:	b90037e0 	str	w0, [sp, #52]
 b30:	f9400be1 	ldr	x1, [sp, #16]
 b34:	b98037e0 	ldrsw	x0, [sp, #52]
 b38:	8b000020 	add	x0, x1, x0
 b3c:	39400000 	ldrb	w0, [x0]
 b40:	7100001f 	cmp	w0, #0x0
 b44:	54fff0c1 	b.ne	95c <printf+0x60>  // b.any
        }
    }
}
 b48:	d503201f 	nop
 b4c:	d503201f 	nop
 b50:	a8cf7bfd 	ldp	x29, x30, [sp], #240
 b54:	d65f03c0 	ret

0000000000000b58 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b58:	d10083ff 	sub	sp, sp, #0x20
 b5c:	f90007e0 	str	x0, [sp, #8]
    Header *bp, *p;
    
    bp = (Header*)ap - 1;
 b60:	f94007e0 	ldr	x0, [sp, #8]
 b64:	d1004000 	sub	x0, x0, #0x10
 b68:	f9000be0 	str	x0, [sp, #16]
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b6c:	90000000 	adrp	x0, 0 <main>
 b70:	913c4000 	add	x0, x0, #0xf10
 b74:	f9400000 	ldr	x0, [x0]
 b78:	f9000fe0 	str	x0, [sp, #24]
 b7c:	14000012 	b	bc4 <free+0x6c>
        if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b80:	f9400fe0 	ldr	x0, [sp, #24]
 b84:	f9400000 	ldr	x0, [x0]
 b88:	f9400fe1 	ldr	x1, [sp, #24]
 b8c:	eb00003f 	cmp	x1, x0
 b90:	54000143 	b.cc	bb8 <free+0x60>  // b.lo, b.ul, b.last
 b94:	f9400be1 	ldr	x1, [sp, #16]
 b98:	f9400fe0 	ldr	x0, [sp, #24]
 b9c:	eb00003f 	cmp	x1, x0
 ba0:	54000248 	b.hi	be8 <free+0x90>  // b.pmore
 ba4:	f9400fe0 	ldr	x0, [sp, #24]
 ba8:	f9400000 	ldr	x0, [x0]
 bac:	f9400be1 	ldr	x1, [sp, #16]
 bb0:	eb00003f 	cmp	x1, x0
 bb4:	540001a3 	b.cc	be8 <free+0x90>  // b.lo, b.ul, b.last
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bb8:	f9400fe0 	ldr	x0, [sp, #24]
 bbc:	f9400000 	ldr	x0, [x0]
 bc0:	f9000fe0 	str	x0, [sp, #24]
 bc4:	f9400be1 	ldr	x1, [sp, #16]
 bc8:	f9400fe0 	ldr	x0, [sp, #24]
 bcc:	eb00003f 	cmp	x1, x0
 bd0:	54fffd89 	b.ls	b80 <free+0x28>  // b.plast
 bd4:	f9400fe0 	ldr	x0, [sp, #24]
 bd8:	f9400000 	ldr	x0, [x0]
 bdc:	f9400be1 	ldr	x1, [sp, #16]
 be0:	eb00003f 	cmp	x1, x0
 be4:	54fffce2 	b.cs	b80 <free+0x28>  // b.hs, b.nlast
            break;
    if(bp + bp->s.size == p->s.ptr){
 be8:	f9400be0 	ldr	x0, [sp, #16]
 bec:	b9400800 	ldr	w0, [x0, #8]
 bf0:	2a0003e0 	mov	w0, w0
 bf4:	d37cec00 	lsl	x0, x0, #4
 bf8:	f9400be1 	ldr	x1, [sp, #16]
 bfc:	8b000021 	add	x1, x1, x0
 c00:	f9400fe0 	ldr	x0, [sp, #24]
 c04:	f9400000 	ldr	x0, [x0]
 c08:	eb00003f 	cmp	x1, x0
 c0c:	540001e1 	b.ne	c48 <free+0xf0>  // b.any
        bp->s.size += p->s.ptr->s.size;
 c10:	f9400be0 	ldr	x0, [sp, #16]
 c14:	b9400801 	ldr	w1, [x0, #8]
 c18:	f9400fe0 	ldr	x0, [sp, #24]
 c1c:	f9400000 	ldr	x0, [x0]
 c20:	b9400800 	ldr	w0, [x0, #8]
 c24:	0b000021 	add	w1, w1, w0
 c28:	f9400be0 	ldr	x0, [sp, #16]
 c2c:	b9000801 	str	w1, [x0, #8]
        bp->s.ptr = p->s.ptr->s.ptr;
 c30:	f9400fe0 	ldr	x0, [sp, #24]
 c34:	f9400000 	ldr	x0, [x0]
 c38:	f9400001 	ldr	x1, [x0]
 c3c:	f9400be0 	ldr	x0, [sp, #16]
 c40:	f9000001 	str	x1, [x0]
 c44:	14000005 	b	c58 <free+0x100>
    } else
        bp->s.ptr = p->s.ptr;
 c48:	f9400fe0 	ldr	x0, [sp, #24]
 c4c:	f9400001 	ldr	x1, [x0]
 c50:	f9400be0 	ldr	x0, [sp, #16]
 c54:	f9000001 	str	x1, [x0]
    if(p + p->s.size == bp){
 c58:	f9400fe0 	ldr	x0, [sp, #24]
 c5c:	b9400800 	ldr	w0, [x0, #8]
 c60:	2a0003e0 	mov	w0, w0
 c64:	d37cec00 	lsl	x0, x0, #4
 c68:	f9400fe1 	ldr	x1, [sp, #24]
 c6c:	8b000020 	add	x0, x1, x0
 c70:	f9400be1 	ldr	x1, [sp, #16]
 c74:	eb00003f 	cmp	x1, x0
 c78:	540001a1 	b.ne	cac <free+0x154>  // b.any
        p->s.size += bp->s.size;
 c7c:	f9400fe0 	ldr	x0, [sp, #24]
 c80:	b9400801 	ldr	w1, [x0, #8]
 c84:	f9400be0 	ldr	x0, [sp, #16]
 c88:	b9400800 	ldr	w0, [x0, #8]
 c8c:	0b000021 	add	w1, w1, w0
 c90:	f9400fe0 	ldr	x0, [sp, #24]
 c94:	b9000801 	str	w1, [x0, #8]
        p->s.ptr = bp->s.ptr;
 c98:	f9400be0 	ldr	x0, [sp, #16]
 c9c:	f9400001 	ldr	x1, [x0]
 ca0:	f9400fe0 	ldr	x0, [sp, #24]
 ca4:	f9000001 	str	x1, [x0]
 ca8:	14000004 	b	cb8 <free+0x160>
    } else
        p->s.ptr = bp;
 cac:	f9400fe0 	ldr	x0, [sp, #24]
 cb0:	f9400be1 	ldr	x1, [sp, #16]
 cb4:	f9000001 	str	x1, [x0]
    freep = p;
 cb8:	90000000 	adrp	x0, 0 <main>
 cbc:	913c4000 	add	x0, x0, #0xf10
 cc0:	f9400fe1 	ldr	x1, [sp, #24]
 cc4:	f9000001 	str	x1, [x0]
}
 cc8:	d503201f 	nop
 ccc:	910083ff 	add	sp, sp, #0x20
 cd0:	d65f03c0 	ret

0000000000000cd4 <morecore>:

static Header*
morecore(uint nu)
{
 cd4:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 cd8:	910003fd 	mov	x29, sp
 cdc:	b9001fe0 	str	w0, [sp, #28]
    char *p;
    Header *hp;
    
    if(nu < 4096)
 ce0:	b9401fe0 	ldr	w0, [sp, #28]
 ce4:	713ffc1f 	cmp	w0, #0xfff
 ce8:	54000068 	b.hi	cf4 <morecore+0x20>  // b.pmore
        nu = 4096;
 cec:	52820000 	mov	w0, #0x1000                	// #4096
 cf0:	b9001fe0 	str	w0, [sp, #28]
    p = sbrk(nu * sizeof(Header));
 cf4:	b9401fe0 	ldr	w0, [sp, #28]
 cf8:	531c6c00 	lsl	w0, w0, #4
 cfc:	97fffe92 	bl	744 <sbrk>
 d00:	f90017e0 	str	x0, [sp, #40]
    if(p == (char*)-1)
 d04:	f94017e0 	ldr	x0, [sp, #40]
 d08:	b100041f 	cmn	x0, #0x1
 d0c:	54000061 	b.ne	d18 <morecore+0x44>  // b.any
        return 0;
 d10:	d2800000 	mov	x0, #0x0                   	// #0
 d14:	1400000c 	b	d44 <morecore+0x70>
    hp = (Header*)p;
 d18:	f94017e0 	ldr	x0, [sp, #40]
 d1c:	f90013e0 	str	x0, [sp, #32]
    hp->s.size = nu;
 d20:	f94013e0 	ldr	x0, [sp, #32]
 d24:	b9401fe1 	ldr	w1, [sp, #28]
 d28:	b9000801 	str	w1, [x0, #8]
    free((void*)(hp + 1));
 d2c:	f94013e0 	ldr	x0, [sp, #32]
 d30:	91004000 	add	x0, x0, #0x10
 d34:	97ffff89 	bl	b58 <free>
    return freep;
 d38:	90000000 	adrp	x0, 0 <main>
 d3c:	913c4000 	add	x0, x0, #0xf10
 d40:	f9400000 	ldr	x0, [x0]
}
 d44:	a8c37bfd 	ldp	x29, x30, [sp], #48
 d48:	d65f03c0 	ret

0000000000000d4c <malloc>:

void*
malloc(uint nbytes)
{
 d4c:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 d50:	910003fd 	mov	x29, sp
 d54:	b9001fe0 	str	w0, [sp, #28]
    Header *p, *prevp;
    uint nunits;
    
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d58:	b9401fe0 	ldr	w0, [sp, #28]
 d5c:	91003c00 	add	x0, x0, #0xf
 d60:	d344fc00 	lsr	x0, x0, #4
 d64:	11000400 	add	w0, w0, #0x1
 d68:	b9002fe0 	str	w0, [sp, #44]
    if((prevp = freep) == 0){
 d6c:	90000000 	adrp	x0, 0 <main>
 d70:	913c4000 	add	x0, x0, #0xf10
 d74:	f9400000 	ldr	x0, [x0]
 d78:	f9001be0 	str	x0, [sp, #48]
 d7c:	f9401be0 	ldr	x0, [sp, #48]
 d80:	f100001f 	cmp	x0, #0x0
 d84:	54000221 	b.ne	dc8 <malloc+0x7c>  // b.any
        base.s.ptr = freep = prevp = &base;
 d88:	90000000 	adrp	x0, 0 <main>
 d8c:	913c0000 	add	x0, x0, #0xf00
 d90:	f9001be0 	str	x0, [sp, #48]
 d94:	90000000 	adrp	x0, 0 <main>
 d98:	913c4000 	add	x0, x0, #0xf10
 d9c:	f9401be1 	ldr	x1, [sp, #48]
 da0:	f9000001 	str	x1, [x0]
 da4:	90000000 	adrp	x0, 0 <main>
 da8:	913c4000 	add	x0, x0, #0xf10
 dac:	f9400001 	ldr	x1, [x0]
 db0:	90000000 	adrp	x0, 0 <main>
 db4:	913c0000 	add	x0, x0, #0xf00
 db8:	f9000001 	str	x1, [x0]
        base.s.size = 0;
 dbc:	90000000 	adrp	x0, 0 <main>
 dc0:	913c0000 	add	x0, x0, #0xf00
 dc4:	b900081f 	str	wzr, [x0, #8]
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 dc8:	f9401be0 	ldr	x0, [sp, #48]
 dcc:	f9400000 	ldr	x0, [x0]
 dd0:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
 dd4:	f9401fe0 	ldr	x0, [sp, #56]
 dd8:	b9400800 	ldr	w0, [x0, #8]
 ddc:	b9402fe1 	ldr	w1, [sp, #44]
 de0:	6b00003f 	cmp	w1, w0
 de4:	54000448 	b.hi	e6c <malloc+0x120>  // b.pmore
            if(p->s.size == nunits)
 de8:	f9401fe0 	ldr	x0, [sp, #56]
 dec:	b9400800 	ldr	w0, [x0, #8]
 df0:	b9402fe1 	ldr	w1, [sp, #44]
 df4:	6b00003f 	cmp	w1, w0
 df8:	540000c1 	b.ne	e10 <malloc+0xc4>  // b.any
                prevp->s.ptr = p->s.ptr;
 dfc:	f9401fe0 	ldr	x0, [sp, #56]
 e00:	f9400001 	ldr	x1, [x0]
 e04:	f9401be0 	ldr	x0, [sp, #48]
 e08:	f9000001 	str	x1, [x0]
 e0c:	14000011 	b	e50 <malloc+0x104>
            else {
                p->s.size -= nunits;
 e10:	f9401fe0 	ldr	x0, [sp, #56]
 e14:	b9400801 	ldr	w1, [x0, #8]
 e18:	b9402fe0 	ldr	w0, [sp, #44]
 e1c:	4b000021 	sub	w1, w1, w0
 e20:	f9401fe0 	ldr	x0, [sp, #56]
 e24:	b9000801 	str	w1, [x0, #8]
                p += p->s.size;
 e28:	f9401fe0 	ldr	x0, [sp, #56]
 e2c:	b9400800 	ldr	w0, [x0, #8]
 e30:	2a0003e0 	mov	w0, w0
 e34:	d37cec00 	lsl	x0, x0, #4
 e38:	f9401fe1 	ldr	x1, [sp, #56]
 e3c:	8b000020 	add	x0, x1, x0
 e40:	f9001fe0 	str	x0, [sp, #56]
                p->s.size = nunits;
 e44:	f9401fe0 	ldr	x0, [sp, #56]
 e48:	b9402fe1 	ldr	w1, [sp, #44]
 e4c:	b9000801 	str	w1, [x0, #8]
            }
            freep = prevp;
 e50:	90000000 	adrp	x0, 0 <main>
 e54:	913c4000 	add	x0, x0, #0xf10
 e58:	f9401be1 	ldr	x1, [sp, #48]
 e5c:	f9000001 	str	x1, [x0]
            return (void*)(p + 1);
 e60:	f9401fe0 	ldr	x0, [sp, #56]
 e64:	91004000 	add	x0, x0, #0x10
 e68:	14000015 	b	ebc <malloc+0x170>
        }
        if(p == freep)
 e6c:	90000000 	adrp	x0, 0 <main>
 e70:	913c4000 	add	x0, x0, #0xf10
 e74:	f9400000 	ldr	x0, [x0]
 e78:	f9401fe1 	ldr	x1, [sp, #56]
 e7c:	eb00003f 	cmp	x1, x0
 e80:	54000121 	b.ne	ea4 <malloc+0x158>  // b.any
            if((p = morecore(nunits)) == 0)
 e84:	b9402fe0 	ldr	w0, [sp, #44]
 e88:	97ffff93 	bl	cd4 <morecore>
 e8c:	f9001fe0 	str	x0, [sp, #56]
 e90:	f9401fe0 	ldr	x0, [sp, #56]
 e94:	f100001f 	cmp	x0, #0x0
 e98:	54000061 	b.ne	ea4 <malloc+0x158>  // b.any
                return 0;
 e9c:	d2800000 	mov	x0, #0x0                   	// #0
 ea0:	14000007 	b	ebc <malloc+0x170>
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ea4:	f9401fe0 	ldr	x0, [sp, #56]
 ea8:	f9001be0 	str	x0, [sp, #48]
 eac:	f9401fe0 	ldr	x0, [sp, #56]
 eb0:	f9400000 	ldr	x0, [x0]
 eb4:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
 eb8:	17ffffc7 	b	dd4 <malloc+0x88>
    }
}
 ebc:	a8c47bfd 	ldp	x29, x30, [sp], #64
 ec0:	d65f03c0 	ret
