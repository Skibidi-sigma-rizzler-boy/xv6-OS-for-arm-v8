
_zombie:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
   4:	910003fd 	mov	x29, sp
    if(fork() > 0)
   8:	94000117 	bl	464 <fork>
   c:	7100001f 	cmp	w0, #0x0
  10:	5400006d 	b.le	1c <main+0x1c>
        sleep(5);  // Let child exit before parent.
  14:	528000a0 	mov	w0, #0x5                   	// #5
  18:	940001be 	bl	710 <sleep>
    exit();
  1c:	9400011b 	bl	488 <exit>

0000000000000020 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  20:	d10083ff 	sub	sp, sp, #0x20
  24:	f90007e0 	str	x0, [sp, #8]
  28:	f90003e1 	str	x1, [sp]
    char *os;
    
    os = s;
  2c:	f94007e0 	ldr	x0, [sp, #8]
  30:	f9000fe0 	str	x0, [sp, #24]
    while((*s++ = *t++) != 0)
  34:	d503201f 	nop
  38:	f94003e1 	ldr	x1, [sp]
  3c:	91000420 	add	x0, x1, #0x1
  40:	f90003e0 	str	x0, [sp]
  44:	f94007e0 	ldr	x0, [sp, #8]
  48:	91000402 	add	x2, x0, #0x1
  4c:	f90007e2 	str	x2, [sp, #8]
  50:	39400021 	ldrb	w1, [x1]
  54:	39000001 	strb	w1, [x0]
  58:	39400000 	ldrb	w0, [x0]
  5c:	7100001f 	cmp	w0, #0x0
  60:	54fffec1 	b.ne	38 <strcpy+0x18>  // b.any
        ;
    return os;
  64:	f9400fe0 	ldr	x0, [sp, #24]
}
  68:	910083ff 	add	sp, sp, #0x20
  6c:	d65f03c0 	ret

0000000000000070 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  70:	d10043ff 	sub	sp, sp, #0x10
  74:	f90007e0 	str	x0, [sp, #8]
  78:	f90003e1 	str	x1, [sp]
    while(*p && *p == *q)
  7c:	14000007 	b	98 <strcmp+0x28>
        p++, q++;
  80:	f94007e0 	ldr	x0, [sp, #8]
  84:	91000400 	add	x0, x0, #0x1
  88:	f90007e0 	str	x0, [sp, #8]
  8c:	f94003e0 	ldr	x0, [sp]
  90:	91000400 	add	x0, x0, #0x1
  94:	f90003e0 	str	x0, [sp]
    while(*p && *p == *q)
  98:	f94007e0 	ldr	x0, [sp, #8]
  9c:	39400000 	ldrb	w0, [x0]
  a0:	7100001f 	cmp	w0, #0x0
  a4:	540000e0 	b.eq	c0 <strcmp+0x50>  // b.none
  a8:	f94007e0 	ldr	x0, [sp, #8]
  ac:	39400001 	ldrb	w1, [x0]
  b0:	f94003e0 	ldr	x0, [sp]
  b4:	39400000 	ldrb	w0, [x0]
  b8:	6b00003f 	cmp	w1, w0
  bc:	54fffe20 	b.eq	80 <strcmp+0x10>  // b.none
    return (uchar)*p - (uchar)*q;
  c0:	f94007e0 	ldr	x0, [sp, #8]
  c4:	39400000 	ldrb	w0, [x0]
  c8:	2a0003e1 	mov	w1, w0
  cc:	f94003e0 	ldr	x0, [sp]
  d0:	39400000 	ldrb	w0, [x0]
  d4:	4b000020 	sub	w0, w1, w0
}
  d8:	910043ff 	add	sp, sp, #0x10
  dc:	d65f03c0 	ret

00000000000000e0 <strlen>:

uint
strlen(char *s)
{
  e0:	d10083ff 	sub	sp, sp, #0x20
  e4:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    for(n = 0; s[n]; n++)
  e8:	b9001fff 	str	wzr, [sp, #28]
  ec:	14000004 	b	fc <strlen+0x1c>
  f0:	b9401fe0 	ldr	w0, [sp, #28]
  f4:	11000400 	add	w0, w0, #0x1
  f8:	b9001fe0 	str	w0, [sp, #28]
  fc:	b9801fe0 	ldrsw	x0, [sp, #28]
 100:	f94007e1 	ldr	x1, [sp, #8]
 104:	8b000020 	add	x0, x1, x0
 108:	39400000 	ldrb	w0, [x0]
 10c:	7100001f 	cmp	w0, #0x0
 110:	54ffff01 	b.ne	f0 <strlen+0x10>  // b.any
        ;
    return n;
 114:	b9401fe0 	ldr	w0, [sp, #28]
}
 118:	910083ff 	add	sp, sp, #0x20
 11c:	d65f03c0 	ret

0000000000000120 <memset>:

void*
memset(void *dst, int v, uint n)
{
 120:	d100c3ff 	sub	sp, sp, #0x30
 124:	f90007e0 	str	x0, [sp, #8]
 128:	b90007e1 	str	w1, [sp, #4]
 12c:	b90003e2 	str	w2, [sp]
	uint8	*p;
	uint8	c;
	uint32	val;
	uint32	*p4;

	p   = dst;
 130:	f94007e0 	ldr	x0, [sp, #8]
 134:	f90017e0 	str	x0, [sp, #40]
	c   = v & 0xff;
 138:	b94007e0 	ldr	w0, [sp, #4]
 13c:	39007fe0 	strb	w0, [sp, #31]
	val = (c << 24) | (c << 16) | (c << 8) | c;
 140:	39407fe1 	ldrb	w1, [sp, #31]
 144:	2a0103e0 	mov	w0, w1
 148:	53185c00 	lsl	w0, w0, #8
 14c:	0b010000 	add	w0, w0, w1
 150:	53103c00 	lsl	w0, w0, #16
 154:	2a0003e1 	mov	w1, w0
 158:	39407fe0 	ldrb	w0, [sp, #31]
 15c:	53185c00 	lsl	w0, w0, #8
 160:	2a000021 	orr	w1, w1, w0
 164:	39407fe0 	ldrb	w0, [sp, #31]
 168:	2a000020 	orr	w0, w1, w0
 16c:	b9001be0 	str	w0, [sp, #24]

	// set bytes before whole uint32
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
 170:	1400000a 	b	198 <memset+0x78>
		*p = c;
 174:	f94017e0 	ldr	x0, [sp, #40]
 178:	39407fe1 	ldrb	w1, [sp, #31]
 17c:	39000001 	strb	w1, [x0]
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
 180:	b94003e0 	ldr	w0, [sp]
 184:	51000400 	sub	w0, w0, #0x1
 188:	b90003e0 	str	w0, [sp]
 18c:	f94017e0 	ldr	x0, [sp, #40]
 190:	91000400 	add	x0, x0, #0x1
 194:	f90017e0 	str	x0, [sp, #40]
 198:	b94003e0 	ldr	w0, [sp]
 19c:	7100001f 	cmp	w0, #0x0
 1a0:	540000a0 	b.eq	1b4 <memset+0x94>  // b.none
 1a4:	f94017e0 	ldr	x0, [sp, #40]
 1a8:	92400400 	and	x0, x0, #0x3
 1ac:	f100001f 	cmp	x0, #0x0
 1b0:	54fffe21 	b.ne	174 <memset+0x54>  // b.any
	}

	// set memory 4 bytes a time
	p4 = (uint*)p;
 1b4:	f94017e0 	ldr	x0, [sp, #40]
 1b8:	f90013e0 	str	x0, [sp, #32]

	for (; n >= 4; n -= 4, p4++) {
 1bc:	1400000a 	b	1e4 <memset+0xc4>
		*p4 = val;
 1c0:	f94013e0 	ldr	x0, [sp, #32]
 1c4:	b9401be1 	ldr	w1, [sp, #24]
 1c8:	b9000001 	str	w1, [x0]
	for (; n >= 4; n -= 4, p4++) {
 1cc:	b94003e0 	ldr	w0, [sp]
 1d0:	51001000 	sub	w0, w0, #0x4
 1d4:	b90003e0 	str	w0, [sp]
 1d8:	f94013e0 	ldr	x0, [sp, #32]
 1dc:	91001000 	add	x0, x0, #0x4
 1e0:	f90013e0 	str	x0, [sp, #32]
 1e4:	b94003e0 	ldr	w0, [sp]
 1e8:	71000c1f 	cmp	w0, #0x3
 1ec:	54fffea8 	b.hi	1c0 <memset+0xa0>  // b.pmore
	}

	// set leftover one byte a time
	p = (uint8*)p4;
 1f0:	f94013e0 	ldr	x0, [sp, #32]
 1f4:	f90017e0 	str	x0, [sp, #40]

	for (; n > 0; n--, p++) {
 1f8:	1400000a 	b	220 <memset+0x100>
		*p = c;
 1fc:	f94017e0 	ldr	x0, [sp, #40]
 200:	39407fe1 	ldrb	w1, [sp, #31]
 204:	39000001 	strb	w1, [x0]
	for (; n > 0; n--, p++) {
 208:	b94003e0 	ldr	w0, [sp]
 20c:	51000400 	sub	w0, w0, #0x1
 210:	b90003e0 	str	w0, [sp]
 214:	f94017e0 	ldr	x0, [sp, #40]
 218:	91000400 	add	x0, x0, #0x1
 21c:	f90017e0 	str	x0, [sp, #40]
 220:	b94003e0 	ldr	w0, [sp]
 224:	7100001f 	cmp	w0, #0x0
 228:	54fffea1 	b.ne	1fc <memset+0xdc>  // b.any
	}

	return dst;
 22c:	f94007e0 	ldr	x0, [sp, #8]
}
 230:	9100c3ff 	add	sp, sp, #0x30
 234:	d65f03c0 	ret

0000000000000238 <strchr>:

char*
strchr(const char *s, char c)
{
 238:	d10043ff 	sub	sp, sp, #0x10
 23c:	f90007e0 	str	x0, [sp, #8]
 240:	39001fe1 	strb	w1, [sp, #7]
    for(; *s; s++)
 244:	1400000b 	b	270 <strchr+0x38>
        if(*s == c)
 248:	f94007e0 	ldr	x0, [sp, #8]
 24c:	39400000 	ldrb	w0, [x0]
 250:	39401fe1 	ldrb	w1, [sp, #7]
 254:	6b00003f 	cmp	w1, w0
 258:	54000061 	b.ne	264 <strchr+0x2c>  // b.any
            return (char*)s;
 25c:	f94007e0 	ldr	x0, [sp, #8]
 260:	14000009 	b	284 <strchr+0x4c>
    for(; *s; s++)
 264:	f94007e0 	ldr	x0, [sp, #8]
 268:	91000400 	add	x0, x0, #0x1
 26c:	f90007e0 	str	x0, [sp, #8]
 270:	f94007e0 	ldr	x0, [sp, #8]
 274:	39400000 	ldrb	w0, [x0]
 278:	7100001f 	cmp	w0, #0x0
 27c:	54fffe61 	b.ne	248 <strchr+0x10>  // b.any
    return 0;
 280:	d2800000 	mov	x0, #0x0                   	// #0
}
 284:	910043ff 	add	sp, sp, #0x10
 288:	d65f03c0 	ret

000000000000028c <gets>:

char*
gets(char *buf, int max)
{
 28c:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 290:	910003fd 	mov	x29, sp
 294:	f9000fe0 	str	x0, [sp, #24]
 298:	b90017e1 	str	w1, [sp, #20]
    int i, cc;
    char c;
    
    for(i=0; i+1 < max; ){
 29c:	b9002fff 	str	wzr, [sp, #44]
 2a0:	14000018 	b	300 <gets+0x74>
        cc = read(0, &c, 1);
 2a4:	91009fe0 	add	x0, sp, #0x27
 2a8:	52800022 	mov	w2, #0x1                   	// #1
 2ac:	aa0003e1 	mov	x1, x0
 2b0:	52800000 	mov	w0, #0x0                   	// #0
 2b4:	94000090 	bl	4f4 <read>
 2b8:	b9002be0 	str	w0, [sp, #40]
        if(cc < 1)
 2bc:	b9402be0 	ldr	w0, [sp, #40]
 2c0:	7100001f 	cmp	w0, #0x0
 2c4:	540002ad 	b.le	318 <gets+0x8c>
            break;
        buf[i++] = c;
 2c8:	b9402fe0 	ldr	w0, [sp, #44]
 2cc:	11000401 	add	w1, w0, #0x1
 2d0:	b9002fe1 	str	w1, [sp, #44]
 2d4:	93407c00 	sxtw	x0, w0
 2d8:	f9400fe1 	ldr	x1, [sp, #24]
 2dc:	8b000020 	add	x0, x1, x0
 2e0:	39409fe1 	ldrb	w1, [sp, #39]
 2e4:	39000001 	strb	w1, [x0]
        if(c == '\n' || c == '\r')
 2e8:	39409fe0 	ldrb	w0, [sp, #39]
 2ec:	7100281f 	cmp	w0, #0xa
 2f0:	54000160 	b.eq	31c <gets+0x90>  // b.none
 2f4:	39409fe0 	ldrb	w0, [sp, #39]
 2f8:	7100341f 	cmp	w0, #0xd
 2fc:	54000100 	b.eq	31c <gets+0x90>  // b.none
    for(i=0; i+1 < max; ){
 300:	b9402fe0 	ldr	w0, [sp, #44]
 304:	11000400 	add	w0, w0, #0x1
 308:	b94017e1 	ldr	w1, [sp, #20]
 30c:	6b00003f 	cmp	w1, w0
 310:	54fffcac 	b.gt	2a4 <gets+0x18>
 314:	14000002 	b	31c <gets+0x90>
            break;
 318:	d503201f 	nop
            break;
    }
    buf[i] = '\0';
 31c:	b9802fe0 	ldrsw	x0, [sp, #44]
 320:	f9400fe1 	ldr	x1, [sp, #24]
 324:	8b000020 	add	x0, x1, x0
 328:	3900001f 	strb	wzr, [x0]
    return buf;
 32c:	f9400fe0 	ldr	x0, [sp, #24]
}
 330:	a8c37bfd 	ldp	x29, x30, [sp], #48
 334:	d65f03c0 	ret

0000000000000338 <stat>:

int
stat(char *n, struct stat *st)
{
 338:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 33c:	910003fd 	mov	x29, sp
 340:	f9000fe0 	str	x0, [sp, #24]
 344:	f9000be1 	str	x1, [sp, #16]
    int fd;
    int r;
    
    fd = open(n, O_RDONLY);
 348:	52800001 	mov	w1, #0x0                   	// #0
 34c:	f9400fe0 	ldr	x0, [sp, #24]
 350:	94000096 	bl	5a8 <open>
 354:	b9002fe0 	str	w0, [sp, #44]
    if(fd < 0)
 358:	b9402fe0 	ldr	w0, [sp, #44]
 35c:	7100001f 	cmp	w0, #0x0
 360:	5400006a 	b.ge	36c <stat+0x34>  // b.tcont
        return -1;
 364:	12800000 	mov	w0, #0xffffffff            	// #-1
 368:	14000008 	b	388 <stat+0x50>
    r = fstat(fd, st);
 36c:	f9400be1 	ldr	x1, [sp, #16]
 370:	b9402fe0 	ldr	w0, [sp, #44]
 374:	940000a8 	bl	614 <fstat>
 378:	b9002be0 	str	w0, [sp, #40]
    close(fd);
 37c:	b9402fe0 	ldr	w0, [sp, #44]
 380:	9400006f 	bl	53c <close>
    return r;
 384:	b9402be0 	ldr	w0, [sp, #40]
}
 388:	a8c37bfd 	ldp	x29, x30, [sp], #48
 38c:	d65f03c0 	ret

0000000000000390 <atoi>:

int
atoi(const char *s)
{
 390:	d10083ff 	sub	sp, sp, #0x20
 394:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    n = 0;
 398:	b9001fff 	str	wzr, [sp, #28]
    while('0' <= *s && *s <= '9')
 39c:	1400000e 	b	3d4 <atoi+0x44>
        n = n*10 + *s++ - '0';
 3a0:	b9401fe1 	ldr	w1, [sp, #28]
 3a4:	2a0103e0 	mov	w0, w1
 3a8:	531e7400 	lsl	w0, w0, #2
 3ac:	0b010000 	add	w0, w0, w1
 3b0:	531f7800 	lsl	w0, w0, #1
 3b4:	2a0003e2 	mov	w2, w0
 3b8:	f94007e0 	ldr	x0, [sp, #8]
 3bc:	91000401 	add	x1, x0, #0x1
 3c0:	f90007e1 	str	x1, [sp, #8]
 3c4:	39400000 	ldrb	w0, [x0]
 3c8:	0b000040 	add	w0, w2, w0
 3cc:	5100c000 	sub	w0, w0, #0x30
 3d0:	b9001fe0 	str	w0, [sp, #28]
    while('0' <= *s && *s <= '9')
 3d4:	f94007e0 	ldr	x0, [sp, #8]
 3d8:	39400000 	ldrb	w0, [x0]
 3dc:	7100bc1f 	cmp	w0, #0x2f
 3e0:	540000a9 	b.ls	3f4 <atoi+0x64>  // b.plast
 3e4:	f94007e0 	ldr	x0, [sp, #8]
 3e8:	39400000 	ldrb	w0, [x0]
 3ec:	7100e41f 	cmp	w0, #0x39
 3f0:	54fffd89 	b.ls	3a0 <atoi+0x10>  // b.plast
    return n;
 3f4:	b9401fe0 	ldr	w0, [sp, #28]
}
 3f8:	910083ff 	add	sp, sp, #0x20
 3fc:	d65f03c0 	ret

0000000000000400 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 400:	d100c3ff 	sub	sp, sp, #0x30
 404:	f9000fe0 	str	x0, [sp, #24]
 408:	f9000be1 	str	x1, [sp, #16]
 40c:	b9000fe2 	str	w2, [sp, #12]
    char *dst, *src;
    
    dst = vdst;
 410:	f9400fe0 	ldr	x0, [sp, #24]
 414:	f90017e0 	str	x0, [sp, #40]
    src = vsrc;
 418:	f9400be0 	ldr	x0, [sp, #16]
 41c:	f90013e0 	str	x0, [sp, #32]
    while(n-- > 0)
 420:	14000009 	b	444 <memmove+0x44>
        *dst++ = *src++;
 424:	f94013e1 	ldr	x1, [sp, #32]
 428:	91000420 	add	x0, x1, #0x1
 42c:	f90013e0 	str	x0, [sp, #32]
 430:	f94017e0 	ldr	x0, [sp, #40]
 434:	91000402 	add	x2, x0, #0x1
 438:	f90017e2 	str	x2, [sp, #40]
 43c:	39400021 	ldrb	w1, [x1]
 440:	39000001 	strb	w1, [x0]
    while(n-- > 0)
 444:	b9400fe0 	ldr	w0, [sp, #12]
 448:	51000401 	sub	w1, w0, #0x1
 44c:	b9000fe1 	str	w1, [sp, #12]
 450:	7100001f 	cmp	w0, #0x0
 454:	54fffe8c 	b.gt	424 <memmove+0x24>
    return vdst;
 458:	f9400fe0 	ldr	x0, [sp, #24]
}
 45c:	9100c3ff 	add	sp, sp, #0x30
 460:	d65f03c0 	ret

0000000000000464 <fork>:
 464:	f81f8fe4 	str	x4, [sp, #-8]!
 468:	aa0303e4 	mov	x4, x3
 46c:	aa0203e3 	mov	x3, x2
 470:	aa0103e2 	mov	x2, x1
 474:	aa0003e1 	mov	x1, x0
 478:	d2800020 	mov	x0, #0x1                   	// #1
 47c:	d4000001 	svc	#0x0
 480:	f84087e4 	ldr	x4, [sp], #8
 484:	d61f03c0 	br	x30

0000000000000488 <exit>:
 488:	f81f8fe4 	str	x4, [sp, #-8]!
 48c:	aa0303e4 	mov	x4, x3
 490:	aa0203e3 	mov	x3, x2
 494:	aa0103e2 	mov	x2, x1
 498:	aa0003e1 	mov	x1, x0
 49c:	d2800040 	mov	x0, #0x2                   	// #2
 4a0:	d4000001 	svc	#0x0
 4a4:	f84087e4 	ldr	x4, [sp], #8
 4a8:	d61f03c0 	br	x30

00000000000004ac <wait>:
 4ac:	f81f8fe4 	str	x4, [sp, #-8]!
 4b0:	aa0303e4 	mov	x4, x3
 4b4:	aa0203e3 	mov	x3, x2
 4b8:	aa0103e2 	mov	x2, x1
 4bc:	aa0003e1 	mov	x1, x0
 4c0:	d2800060 	mov	x0, #0x3                   	// #3
 4c4:	d4000001 	svc	#0x0
 4c8:	f84087e4 	ldr	x4, [sp], #8
 4cc:	d61f03c0 	br	x30

00000000000004d0 <pipe>:
 4d0:	f81f8fe4 	str	x4, [sp, #-8]!
 4d4:	aa0303e4 	mov	x4, x3
 4d8:	aa0203e3 	mov	x3, x2
 4dc:	aa0103e2 	mov	x2, x1
 4e0:	aa0003e1 	mov	x1, x0
 4e4:	d2800080 	mov	x0, #0x4                   	// #4
 4e8:	d4000001 	svc	#0x0
 4ec:	f84087e4 	ldr	x4, [sp], #8
 4f0:	d61f03c0 	br	x30

00000000000004f4 <read>:
 4f4:	f81f8fe4 	str	x4, [sp, #-8]!
 4f8:	aa0303e4 	mov	x4, x3
 4fc:	aa0203e3 	mov	x3, x2
 500:	aa0103e2 	mov	x2, x1
 504:	aa0003e1 	mov	x1, x0
 508:	d28000a0 	mov	x0, #0x5                   	// #5
 50c:	d4000001 	svc	#0x0
 510:	f84087e4 	ldr	x4, [sp], #8
 514:	d61f03c0 	br	x30

0000000000000518 <write>:
 518:	f81f8fe4 	str	x4, [sp, #-8]!
 51c:	aa0303e4 	mov	x4, x3
 520:	aa0203e3 	mov	x3, x2
 524:	aa0103e2 	mov	x2, x1
 528:	aa0003e1 	mov	x1, x0
 52c:	d2800200 	mov	x0, #0x10                  	// #16
 530:	d4000001 	svc	#0x0
 534:	f84087e4 	ldr	x4, [sp], #8
 538:	d61f03c0 	br	x30

000000000000053c <close>:
 53c:	f81f8fe4 	str	x4, [sp, #-8]!
 540:	aa0303e4 	mov	x4, x3
 544:	aa0203e3 	mov	x3, x2
 548:	aa0103e2 	mov	x2, x1
 54c:	aa0003e1 	mov	x1, x0
 550:	d28002a0 	mov	x0, #0x15                  	// #21
 554:	d4000001 	svc	#0x0
 558:	f84087e4 	ldr	x4, [sp], #8
 55c:	d61f03c0 	br	x30

0000000000000560 <kill>:
 560:	f81f8fe4 	str	x4, [sp, #-8]!
 564:	aa0303e4 	mov	x4, x3
 568:	aa0203e3 	mov	x3, x2
 56c:	aa0103e2 	mov	x2, x1
 570:	aa0003e1 	mov	x1, x0
 574:	d28000c0 	mov	x0, #0x6                   	// #6
 578:	d4000001 	svc	#0x0
 57c:	f84087e4 	ldr	x4, [sp], #8
 580:	d61f03c0 	br	x30

0000000000000584 <exec>:
 584:	f81f8fe4 	str	x4, [sp, #-8]!
 588:	aa0303e4 	mov	x4, x3
 58c:	aa0203e3 	mov	x3, x2
 590:	aa0103e2 	mov	x2, x1
 594:	aa0003e1 	mov	x1, x0
 598:	d28000e0 	mov	x0, #0x7                   	// #7
 59c:	d4000001 	svc	#0x0
 5a0:	f84087e4 	ldr	x4, [sp], #8
 5a4:	d61f03c0 	br	x30

00000000000005a8 <open>:
 5a8:	f81f8fe4 	str	x4, [sp, #-8]!
 5ac:	aa0303e4 	mov	x4, x3
 5b0:	aa0203e3 	mov	x3, x2
 5b4:	aa0103e2 	mov	x2, x1
 5b8:	aa0003e1 	mov	x1, x0
 5bc:	d28001e0 	mov	x0, #0xf                   	// #15
 5c0:	d4000001 	svc	#0x0
 5c4:	f84087e4 	ldr	x4, [sp], #8
 5c8:	d61f03c0 	br	x30

00000000000005cc <mknod>:
 5cc:	f81f8fe4 	str	x4, [sp, #-8]!
 5d0:	aa0303e4 	mov	x4, x3
 5d4:	aa0203e3 	mov	x3, x2
 5d8:	aa0103e2 	mov	x2, x1
 5dc:	aa0003e1 	mov	x1, x0
 5e0:	d2800220 	mov	x0, #0x11                  	// #17
 5e4:	d4000001 	svc	#0x0
 5e8:	f84087e4 	ldr	x4, [sp], #8
 5ec:	d61f03c0 	br	x30

00000000000005f0 <unlink>:
 5f0:	f81f8fe4 	str	x4, [sp, #-8]!
 5f4:	aa0303e4 	mov	x4, x3
 5f8:	aa0203e3 	mov	x3, x2
 5fc:	aa0103e2 	mov	x2, x1
 600:	aa0003e1 	mov	x1, x0
 604:	d2800240 	mov	x0, #0x12                  	// #18
 608:	d4000001 	svc	#0x0
 60c:	f84087e4 	ldr	x4, [sp], #8
 610:	d61f03c0 	br	x30

0000000000000614 <fstat>:
 614:	f81f8fe4 	str	x4, [sp, #-8]!
 618:	aa0303e4 	mov	x4, x3
 61c:	aa0203e3 	mov	x3, x2
 620:	aa0103e2 	mov	x2, x1
 624:	aa0003e1 	mov	x1, x0
 628:	d2800100 	mov	x0, #0x8                   	// #8
 62c:	d4000001 	svc	#0x0
 630:	f84087e4 	ldr	x4, [sp], #8
 634:	d61f03c0 	br	x30

0000000000000638 <link>:
 638:	f81f8fe4 	str	x4, [sp, #-8]!
 63c:	aa0303e4 	mov	x4, x3
 640:	aa0203e3 	mov	x3, x2
 644:	aa0103e2 	mov	x2, x1
 648:	aa0003e1 	mov	x1, x0
 64c:	d2800260 	mov	x0, #0x13                  	// #19
 650:	d4000001 	svc	#0x0
 654:	f84087e4 	ldr	x4, [sp], #8
 658:	d61f03c0 	br	x30

000000000000065c <mkdir>:
 65c:	f81f8fe4 	str	x4, [sp, #-8]!
 660:	aa0303e4 	mov	x4, x3
 664:	aa0203e3 	mov	x3, x2
 668:	aa0103e2 	mov	x2, x1
 66c:	aa0003e1 	mov	x1, x0
 670:	d2800280 	mov	x0, #0x14                  	// #20
 674:	d4000001 	svc	#0x0
 678:	f84087e4 	ldr	x4, [sp], #8
 67c:	d61f03c0 	br	x30

0000000000000680 <chdir>:
 680:	f81f8fe4 	str	x4, [sp, #-8]!
 684:	aa0303e4 	mov	x4, x3
 688:	aa0203e3 	mov	x3, x2
 68c:	aa0103e2 	mov	x2, x1
 690:	aa0003e1 	mov	x1, x0
 694:	d2800120 	mov	x0, #0x9                   	// #9
 698:	d4000001 	svc	#0x0
 69c:	f84087e4 	ldr	x4, [sp], #8
 6a0:	d61f03c0 	br	x30

00000000000006a4 <dup>:
 6a4:	f81f8fe4 	str	x4, [sp, #-8]!
 6a8:	aa0303e4 	mov	x4, x3
 6ac:	aa0203e3 	mov	x3, x2
 6b0:	aa0103e2 	mov	x2, x1
 6b4:	aa0003e1 	mov	x1, x0
 6b8:	d2800140 	mov	x0, #0xa                   	// #10
 6bc:	d4000001 	svc	#0x0
 6c0:	f84087e4 	ldr	x4, [sp], #8
 6c4:	d61f03c0 	br	x30

00000000000006c8 <getpid>:
 6c8:	f81f8fe4 	str	x4, [sp, #-8]!
 6cc:	aa0303e4 	mov	x4, x3
 6d0:	aa0203e3 	mov	x3, x2
 6d4:	aa0103e2 	mov	x2, x1
 6d8:	aa0003e1 	mov	x1, x0
 6dc:	d2800160 	mov	x0, #0xb                   	// #11
 6e0:	d4000001 	svc	#0x0
 6e4:	f84087e4 	ldr	x4, [sp], #8
 6e8:	d61f03c0 	br	x30

00000000000006ec <sbrk>:
 6ec:	f81f8fe4 	str	x4, [sp, #-8]!
 6f0:	aa0303e4 	mov	x4, x3
 6f4:	aa0203e3 	mov	x3, x2
 6f8:	aa0103e2 	mov	x2, x1
 6fc:	aa0003e1 	mov	x1, x0
 700:	d2800180 	mov	x0, #0xc                   	// #12
 704:	d4000001 	svc	#0x0
 708:	f84087e4 	ldr	x4, [sp], #8
 70c:	d61f03c0 	br	x30

0000000000000710 <sleep>:
 710:	f81f8fe4 	str	x4, [sp, #-8]!
 714:	aa0303e4 	mov	x4, x3
 718:	aa0203e3 	mov	x3, x2
 71c:	aa0103e2 	mov	x2, x1
 720:	aa0003e1 	mov	x1, x0
 724:	d28001a0 	mov	x0, #0xd                   	// #13
 728:	d4000001 	svc	#0x0
 72c:	f84087e4 	ldr	x4, [sp], #8
 730:	d61f03c0 	br	x30

0000000000000734 <uptime>:
 734:	f81f8fe4 	str	x4, [sp, #-8]!
 738:	aa0303e4 	mov	x4, x3
 73c:	aa0203e3 	mov	x3, x2
 740:	aa0103e2 	mov	x2, x1
 744:	aa0003e1 	mov	x1, x0
 748:	d28001c0 	mov	x0, #0xe                   	// #14
 74c:	d4000001 	svc	#0x0
 750:	f84087e4 	ldr	x4, [sp], #8
 754:	d61f03c0 	br	x30

0000000000000758 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 758:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
 75c:	910003fd 	mov	x29, sp
 760:	b9001fe0 	str	w0, [sp, #28]
 764:	39006fe1 	strb	w1, [sp, #27]
    write(fd, &c, 1);
 768:	91006fe0 	add	x0, sp, #0x1b
 76c:	52800022 	mov	w2, #0x1                   	// #1
 770:	aa0003e1 	mov	x1, x0
 774:	b9401fe0 	ldr	w0, [sp, #28]
 778:	97ffff68 	bl	518 <write>
}
 77c:	d503201f 	nop
 780:	a8c27bfd 	ldp	x29, x30, [sp], #32
 784:	d65f03c0 	ret

0000000000000788 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 788:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 78c:	910003fd 	mov	x29, sp
 790:	b9001fe0 	str	w0, [sp, #28]
 794:	b9001be1 	str	w1, [sp, #24]
 798:	b90017e2 	str	w2, [sp, #20]
 79c:	b90013e3 	str	w3, [sp, #16]
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
 7a0:	b9003bff 	str	wzr, [sp, #56]
    if(sgn && xx < 0){
 7a4:	b94013e0 	ldr	w0, [sp, #16]
 7a8:	7100001f 	cmp	w0, #0x0
 7ac:	54000140 	b.eq	7d4 <printint+0x4c>  // b.none
 7b0:	b9401be0 	ldr	w0, [sp, #24]
 7b4:	7100001f 	cmp	w0, #0x0
 7b8:	540000ea 	b.ge	7d4 <printint+0x4c>  // b.tcont
        neg = 1;
 7bc:	52800020 	mov	w0, #0x1                   	// #1
 7c0:	b9003be0 	str	w0, [sp, #56]
        x = -xx;
 7c4:	b9401be0 	ldr	w0, [sp, #24]
 7c8:	4b0003e0 	neg	w0, w0
 7cc:	b90037e0 	str	w0, [sp, #52]
 7d0:	14000003 	b	7dc <printint+0x54>
    } else {
        x = xx;
 7d4:	b9401be0 	ldr	w0, [sp, #24]
 7d8:	b90037e0 	str	w0, [sp, #52]
    }
    
    i = 0;
 7dc:	b9003fff 	str	wzr, [sp, #60]
    do{
        buf[i++] = digits[x % base];
 7e0:	b94017e1 	ldr	w1, [sp, #20]
 7e4:	b94037e0 	ldr	w0, [sp, #52]
 7e8:	1ac10802 	udiv	w2, w0, w1
 7ec:	1b017c41 	mul	w1, w2, w1
 7f0:	4b010003 	sub	w3, w0, w1
 7f4:	b9403fe0 	ldr	w0, [sp, #60]
 7f8:	11000401 	add	w1, w0, #0x1
 7fc:	b9003fe1 	str	w1, [sp, #60]
 800:	90000001 	adrp	x1, 0 <main>
 804:	9139e022 	add	x2, x1, #0xe78
 808:	2a0303e1 	mov	w1, w3
 80c:	38616842 	ldrb	w2, [x2, x1]
 810:	93407c00 	sxtw	x0, w0
 814:	910083e1 	add	x1, sp, #0x20
 818:	38206822 	strb	w2, [x1, x0]
    }while((x /= base) != 0);
 81c:	b94017e0 	ldr	w0, [sp, #20]
 820:	b94037e1 	ldr	w1, [sp, #52]
 824:	1ac00820 	udiv	w0, w1, w0
 828:	b90037e0 	str	w0, [sp, #52]
 82c:	b94037e0 	ldr	w0, [sp, #52]
 830:	7100001f 	cmp	w0, #0x0
 834:	54fffd61 	b.ne	7e0 <printint+0x58>  // b.any
    if(neg)
 838:	b9403be0 	ldr	w0, [sp, #56]
 83c:	7100001f 	cmp	w0, #0x0
 840:	540001e0 	b.eq	87c <printint+0xf4>  // b.none
        buf[i++] = '-';
 844:	b9403fe0 	ldr	w0, [sp, #60]
 848:	11000401 	add	w1, w0, #0x1
 84c:	b9003fe1 	str	w1, [sp, #60]
 850:	93407c00 	sxtw	x0, w0
 854:	910083e1 	add	x1, sp, #0x20
 858:	528005a2 	mov	w2, #0x2d                  	// #45
 85c:	38206822 	strb	w2, [x1, x0]
    
    while(--i >= 0)
 860:	14000007 	b	87c <printint+0xf4>
        putc(fd, buf[i]);
 864:	b9803fe0 	ldrsw	x0, [sp, #60]
 868:	910083e1 	add	x1, sp, #0x20
 86c:	38606820 	ldrb	w0, [x1, x0]
 870:	2a0003e1 	mov	w1, w0
 874:	b9401fe0 	ldr	w0, [sp, #28]
 878:	97ffffb8 	bl	758 <putc>
    while(--i >= 0)
 87c:	b9403fe0 	ldr	w0, [sp, #60]
 880:	51000400 	sub	w0, w0, #0x1
 884:	b9003fe0 	str	w0, [sp, #60]
 888:	b9403fe0 	ldr	w0, [sp, #60]
 88c:	7100001f 	cmp	w0, #0x0
 890:	54fffeaa 	b.ge	864 <printint+0xdc>  // b.tcont
}
 894:	d503201f 	nop
 898:	d503201f 	nop
 89c:	a8c47bfd 	ldp	x29, x30, [sp], #64
 8a0:	d65f03c0 	ret

00000000000008a4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 8a4:	a9b17bfd 	stp	x29, x30, [sp, #-240]!
 8a8:	910003fd 	mov	x29, sp
 8ac:	b9001fe0 	str	w0, [sp, #28]
 8b0:	f9000be1 	str	x1, [sp, #16]
 8b4:	f90063e2 	str	x2, [sp, #192]
 8b8:	f90067e3 	str	x3, [sp, #200]
 8bc:	f9006be4 	str	x4, [sp, #208]
 8c0:	f9006fe5 	str	x5, [sp, #216]
 8c4:	f90073e6 	str	x6, [sp, #224]
 8c8:	f90077e7 	str	x7, [sp, #232]
 8cc:	3d8013e0 	str	q0, [sp, #64]
 8d0:	3d8017e1 	str	q1, [sp, #80]
 8d4:	3d801be2 	str	q2, [sp, #96]
 8d8:	3d801fe3 	str	q3, [sp, #112]
 8dc:	3d8023e4 	str	q4, [sp, #128]
 8e0:	3d8027e5 	str	q5, [sp, #144]
 8e4:	3d802be6 	str	q6, [sp, #160]
 8e8:	3d802fe7 	str	q7, [sp, #176]
    char *s;
    int c, i, state;
    uint64 *ap;
    
    state = 0;
 8ec:	b90033ff 	str	wzr, [sp, #48]
    ap = (uint64*)(void*)&fmt + 22;
 8f0:	910043e0 	add	x0, sp, #0x10
 8f4:	9102c000 	add	x0, x0, #0xb0
 8f8:	f90017e0 	str	x0, [sp, #40]
    for(i = 0; fmt[i]; i++){
 8fc:	b90037ff 	str	wzr, [sp, #52]
 900:	14000076 	b	ad8 <printf+0x234>
        c = fmt[i] & 0xff;
 904:	f9400be1 	ldr	x1, [sp, #16]
 908:	b98037e0 	ldrsw	x0, [sp, #52]
 90c:	8b000020 	add	x0, x1, x0
 910:	39400000 	ldrb	w0, [x0]
 914:	b90027e0 	str	w0, [sp, #36]
        if(state == 0){
 918:	b94033e0 	ldr	w0, [sp, #48]
 91c:	7100001f 	cmp	w0, #0x0
 920:	540001a1 	b.ne	954 <printf+0xb0>  // b.any
            if(c == '%'){
 924:	b94027e0 	ldr	w0, [sp, #36]
 928:	7100941f 	cmp	w0, #0x25
 92c:	54000081 	b.ne	93c <printf+0x98>  // b.any
                state = '%';
 930:	528004a0 	mov	w0, #0x25                  	// #37
 934:	b90033e0 	str	w0, [sp, #48]
 938:	14000065 	b	acc <printf+0x228>
            } else {
                putc(fd, c);
 93c:	b94027e0 	ldr	w0, [sp, #36]
 940:	12001c00 	and	w0, w0, #0xff
 944:	2a0003e1 	mov	w1, w0
 948:	b9401fe0 	ldr	w0, [sp, #28]
 94c:	97ffff83 	bl	758 <putc>
 950:	1400005f 	b	acc <printf+0x228>
            }
        } else if(state == '%'){
 954:	b94033e0 	ldr	w0, [sp, #48]
 958:	7100941f 	cmp	w0, #0x25
 95c:	54000b81 	b.ne	acc <printf+0x228>  // b.any
            if(c == 'd'){
 960:	b94027e0 	ldr	w0, [sp, #36]
 964:	7101901f 	cmp	w0, #0x64
 968:	54000181 	b.ne	998 <printf+0xf4>  // b.any
                printint(fd, *ap, 10, 1);
 96c:	f94017e0 	ldr	x0, [sp, #40]
 970:	f9400000 	ldr	x0, [x0]
 974:	52800023 	mov	w3, #0x1                   	// #1
 978:	52800142 	mov	w2, #0xa                   	// #10
 97c:	2a0003e1 	mov	w1, w0
 980:	b9401fe0 	ldr	w0, [sp, #28]
 984:	97ffff81 	bl	788 <printint>
                ap++;
 988:	f94017e0 	ldr	x0, [sp, #40]
 98c:	91002000 	add	x0, x0, #0x8
 990:	f90017e0 	str	x0, [sp, #40]
 994:	1400004d 	b	ac8 <printf+0x224>
            } else if(c == 'x' || c == 'p'){
 998:	b94027e0 	ldr	w0, [sp, #36]
 99c:	7101e01f 	cmp	w0, #0x78
 9a0:	54000080 	b.eq	9b0 <printf+0x10c>  // b.none
 9a4:	b94027e0 	ldr	w0, [sp, #36]
 9a8:	7101c01f 	cmp	w0, #0x70
 9ac:	54000181 	b.ne	9dc <printf+0x138>  // b.any
                printint(fd, *ap, 16, 0);
 9b0:	f94017e0 	ldr	x0, [sp, #40]
 9b4:	f9400000 	ldr	x0, [x0]
 9b8:	52800003 	mov	w3, #0x0                   	// #0
 9bc:	52800202 	mov	w2, #0x10                  	// #16
 9c0:	2a0003e1 	mov	w1, w0
 9c4:	b9401fe0 	ldr	w0, [sp, #28]
 9c8:	97ffff70 	bl	788 <printint>
                ap++;
 9cc:	f94017e0 	ldr	x0, [sp, #40]
 9d0:	91002000 	add	x0, x0, #0x8
 9d4:	f90017e0 	str	x0, [sp, #40]
 9d8:	1400003c 	b	ac8 <printf+0x224>
            } else if(c == 's'){
 9dc:	b94027e0 	ldr	w0, [sp, #36]
 9e0:	7101cc1f 	cmp	w0, #0x73
 9e4:	54000361 	b.ne	a50 <printf+0x1ac>  // b.any
                s = (char*)*ap;
 9e8:	f94017e0 	ldr	x0, [sp, #40]
 9ec:	f9400000 	ldr	x0, [x0]
 9f0:	f9001fe0 	str	x0, [sp, #56]
                ap++;
 9f4:	f94017e0 	ldr	x0, [sp, #40]
 9f8:	91002000 	add	x0, x0, #0x8
 9fc:	f90017e0 	str	x0, [sp, #40]
                if(s == 0)
 a00:	f9401fe0 	ldr	x0, [sp, #56]
 a04:	f100001f 	cmp	x0, #0x0
 a08:	540001a1 	b.ne	a3c <printf+0x198>  // b.any
                    s = "(null)";
 a0c:	90000000 	adrp	x0, 0 <main>
 a10:	9139c000 	add	x0, x0, #0xe70
 a14:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
 a18:	14000009 	b	a3c <printf+0x198>
                    putc(fd, *s);
 a1c:	f9401fe0 	ldr	x0, [sp, #56]
 a20:	39400000 	ldrb	w0, [x0]
 a24:	2a0003e1 	mov	w1, w0
 a28:	b9401fe0 	ldr	w0, [sp, #28]
 a2c:	97ffff4b 	bl	758 <putc>
                    s++;
 a30:	f9401fe0 	ldr	x0, [sp, #56]
 a34:	91000400 	add	x0, x0, #0x1
 a38:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
 a3c:	f9401fe0 	ldr	x0, [sp, #56]
 a40:	39400000 	ldrb	w0, [x0]
 a44:	7100001f 	cmp	w0, #0x0
 a48:	54fffea1 	b.ne	a1c <printf+0x178>  // b.any
 a4c:	1400001f 	b	ac8 <printf+0x224>
                }
            } else if(c == 'c'){
 a50:	b94027e0 	ldr	w0, [sp, #36]
 a54:	71018c1f 	cmp	w0, #0x63
 a58:	54000161 	b.ne	a84 <printf+0x1e0>  // b.any
                putc(fd, *ap);
 a5c:	f94017e0 	ldr	x0, [sp, #40]
 a60:	f9400000 	ldr	x0, [x0]
 a64:	12001c00 	and	w0, w0, #0xff
 a68:	2a0003e1 	mov	w1, w0
 a6c:	b9401fe0 	ldr	w0, [sp, #28]
 a70:	97ffff3a 	bl	758 <putc>
                ap++;
 a74:	f94017e0 	ldr	x0, [sp, #40]
 a78:	91002000 	add	x0, x0, #0x8
 a7c:	f90017e0 	str	x0, [sp, #40]
 a80:	14000012 	b	ac8 <printf+0x224>
            } else if(c == '%'){
 a84:	b94027e0 	ldr	w0, [sp, #36]
 a88:	7100941f 	cmp	w0, #0x25
 a8c:	540000e1 	b.ne	aa8 <printf+0x204>  // b.any
                putc(fd, c);
 a90:	b94027e0 	ldr	w0, [sp, #36]
 a94:	12001c00 	and	w0, w0, #0xff
 a98:	2a0003e1 	mov	w1, w0
 a9c:	b9401fe0 	ldr	w0, [sp, #28]
 aa0:	97ffff2e 	bl	758 <putc>
 aa4:	14000009 	b	ac8 <printf+0x224>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
 aa8:	528004a1 	mov	w1, #0x25                  	// #37
 aac:	b9401fe0 	ldr	w0, [sp, #28]
 ab0:	97ffff2a 	bl	758 <putc>
                putc(fd, c);
 ab4:	b94027e0 	ldr	w0, [sp, #36]
 ab8:	12001c00 	and	w0, w0, #0xff
 abc:	2a0003e1 	mov	w1, w0
 ac0:	b9401fe0 	ldr	w0, [sp, #28]
 ac4:	97ffff25 	bl	758 <putc>
            }
            state = 0;
 ac8:	b90033ff 	str	wzr, [sp, #48]
    for(i = 0; fmt[i]; i++){
 acc:	b94037e0 	ldr	w0, [sp, #52]
 ad0:	11000400 	add	w0, w0, #0x1
 ad4:	b90037e0 	str	w0, [sp, #52]
 ad8:	f9400be1 	ldr	x1, [sp, #16]
 adc:	b98037e0 	ldrsw	x0, [sp, #52]
 ae0:	8b000020 	add	x0, x1, x0
 ae4:	39400000 	ldrb	w0, [x0]
 ae8:	7100001f 	cmp	w0, #0x0
 aec:	54fff0c1 	b.ne	904 <printf+0x60>  // b.any
        }
    }
}
 af0:	d503201f 	nop
 af4:	d503201f 	nop
 af8:	a8cf7bfd 	ldp	x29, x30, [sp], #240
 afc:	d65f03c0 	ret

0000000000000b00 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b00:	d10083ff 	sub	sp, sp, #0x20
 b04:	f90007e0 	str	x0, [sp, #8]
    Header *bp, *p;
    
    bp = (Header*)ap - 1;
 b08:	f94007e0 	ldr	x0, [sp, #8]
 b0c:	d1004000 	sub	x0, x0, #0x10
 b10:	f9000be0 	str	x0, [sp, #16]
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b14:	90000000 	adrp	x0, 0 <main>
 b18:	913a8000 	add	x0, x0, #0xea0
 b1c:	f9400000 	ldr	x0, [x0]
 b20:	f9000fe0 	str	x0, [sp, #24]
 b24:	14000012 	b	b6c <free+0x6c>
        if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b28:	f9400fe0 	ldr	x0, [sp, #24]
 b2c:	f9400000 	ldr	x0, [x0]
 b30:	f9400fe1 	ldr	x1, [sp, #24]
 b34:	eb00003f 	cmp	x1, x0
 b38:	54000143 	b.cc	b60 <free+0x60>  // b.lo, b.ul, b.last
 b3c:	f9400be1 	ldr	x1, [sp, #16]
 b40:	f9400fe0 	ldr	x0, [sp, #24]
 b44:	eb00003f 	cmp	x1, x0
 b48:	54000248 	b.hi	b90 <free+0x90>  // b.pmore
 b4c:	f9400fe0 	ldr	x0, [sp, #24]
 b50:	f9400000 	ldr	x0, [x0]
 b54:	f9400be1 	ldr	x1, [sp, #16]
 b58:	eb00003f 	cmp	x1, x0
 b5c:	540001a3 	b.cc	b90 <free+0x90>  // b.lo, b.ul, b.last
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b60:	f9400fe0 	ldr	x0, [sp, #24]
 b64:	f9400000 	ldr	x0, [x0]
 b68:	f9000fe0 	str	x0, [sp, #24]
 b6c:	f9400be1 	ldr	x1, [sp, #16]
 b70:	f9400fe0 	ldr	x0, [sp, #24]
 b74:	eb00003f 	cmp	x1, x0
 b78:	54fffd89 	b.ls	b28 <free+0x28>  // b.plast
 b7c:	f9400fe0 	ldr	x0, [sp, #24]
 b80:	f9400000 	ldr	x0, [x0]
 b84:	f9400be1 	ldr	x1, [sp, #16]
 b88:	eb00003f 	cmp	x1, x0
 b8c:	54fffce2 	b.cs	b28 <free+0x28>  // b.hs, b.nlast
            break;
    if(bp + bp->s.size == p->s.ptr){
 b90:	f9400be0 	ldr	x0, [sp, #16]
 b94:	b9400800 	ldr	w0, [x0, #8]
 b98:	2a0003e0 	mov	w0, w0
 b9c:	d37cec00 	lsl	x0, x0, #4
 ba0:	f9400be1 	ldr	x1, [sp, #16]
 ba4:	8b000021 	add	x1, x1, x0
 ba8:	f9400fe0 	ldr	x0, [sp, #24]
 bac:	f9400000 	ldr	x0, [x0]
 bb0:	eb00003f 	cmp	x1, x0
 bb4:	540001e1 	b.ne	bf0 <free+0xf0>  // b.any
        bp->s.size += p->s.ptr->s.size;
 bb8:	f9400be0 	ldr	x0, [sp, #16]
 bbc:	b9400801 	ldr	w1, [x0, #8]
 bc0:	f9400fe0 	ldr	x0, [sp, #24]
 bc4:	f9400000 	ldr	x0, [x0]
 bc8:	b9400800 	ldr	w0, [x0, #8]
 bcc:	0b000021 	add	w1, w1, w0
 bd0:	f9400be0 	ldr	x0, [sp, #16]
 bd4:	b9000801 	str	w1, [x0, #8]
        bp->s.ptr = p->s.ptr->s.ptr;
 bd8:	f9400fe0 	ldr	x0, [sp, #24]
 bdc:	f9400000 	ldr	x0, [x0]
 be0:	f9400001 	ldr	x1, [x0]
 be4:	f9400be0 	ldr	x0, [sp, #16]
 be8:	f9000001 	str	x1, [x0]
 bec:	14000005 	b	c00 <free+0x100>
    } else
        bp->s.ptr = p->s.ptr;
 bf0:	f9400fe0 	ldr	x0, [sp, #24]
 bf4:	f9400001 	ldr	x1, [x0]
 bf8:	f9400be0 	ldr	x0, [sp, #16]
 bfc:	f9000001 	str	x1, [x0]
    if(p + p->s.size == bp){
 c00:	f9400fe0 	ldr	x0, [sp, #24]
 c04:	b9400800 	ldr	w0, [x0, #8]
 c08:	2a0003e0 	mov	w0, w0
 c0c:	d37cec00 	lsl	x0, x0, #4
 c10:	f9400fe1 	ldr	x1, [sp, #24]
 c14:	8b000020 	add	x0, x1, x0
 c18:	f9400be1 	ldr	x1, [sp, #16]
 c1c:	eb00003f 	cmp	x1, x0
 c20:	540001a1 	b.ne	c54 <free+0x154>  // b.any
        p->s.size += bp->s.size;
 c24:	f9400fe0 	ldr	x0, [sp, #24]
 c28:	b9400801 	ldr	w1, [x0, #8]
 c2c:	f9400be0 	ldr	x0, [sp, #16]
 c30:	b9400800 	ldr	w0, [x0, #8]
 c34:	0b000021 	add	w1, w1, w0
 c38:	f9400fe0 	ldr	x0, [sp, #24]
 c3c:	b9000801 	str	w1, [x0, #8]
        p->s.ptr = bp->s.ptr;
 c40:	f9400be0 	ldr	x0, [sp, #16]
 c44:	f9400001 	ldr	x1, [x0]
 c48:	f9400fe0 	ldr	x0, [sp, #24]
 c4c:	f9000001 	str	x1, [x0]
 c50:	14000004 	b	c60 <free+0x160>
    } else
        p->s.ptr = bp;
 c54:	f9400fe0 	ldr	x0, [sp, #24]
 c58:	f9400be1 	ldr	x1, [sp, #16]
 c5c:	f9000001 	str	x1, [x0]
    freep = p;
 c60:	90000000 	adrp	x0, 0 <main>
 c64:	913a8000 	add	x0, x0, #0xea0
 c68:	f9400fe1 	ldr	x1, [sp, #24]
 c6c:	f9000001 	str	x1, [x0]
}
 c70:	d503201f 	nop
 c74:	910083ff 	add	sp, sp, #0x20
 c78:	d65f03c0 	ret

0000000000000c7c <morecore>:

static Header*
morecore(uint nu)
{
 c7c:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 c80:	910003fd 	mov	x29, sp
 c84:	b9001fe0 	str	w0, [sp, #28]
    char *p;
    Header *hp;
    
    if(nu < 4096)
 c88:	b9401fe0 	ldr	w0, [sp, #28]
 c8c:	713ffc1f 	cmp	w0, #0xfff
 c90:	54000068 	b.hi	c9c <morecore+0x20>  // b.pmore
        nu = 4096;
 c94:	52820000 	mov	w0, #0x1000                	// #4096
 c98:	b9001fe0 	str	w0, [sp, #28]
    p = sbrk(nu * sizeof(Header));
 c9c:	b9401fe0 	ldr	w0, [sp, #28]
 ca0:	531c6c00 	lsl	w0, w0, #4
 ca4:	97fffe92 	bl	6ec <sbrk>
 ca8:	f90017e0 	str	x0, [sp, #40]
    if(p == (char*)-1)
 cac:	f94017e0 	ldr	x0, [sp, #40]
 cb0:	b100041f 	cmn	x0, #0x1
 cb4:	54000061 	b.ne	cc0 <morecore+0x44>  // b.any
        return 0;
 cb8:	d2800000 	mov	x0, #0x0                   	// #0
 cbc:	1400000c 	b	cec <morecore+0x70>
    hp = (Header*)p;
 cc0:	f94017e0 	ldr	x0, [sp, #40]
 cc4:	f90013e0 	str	x0, [sp, #32]
    hp->s.size = nu;
 cc8:	f94013e0 	ldr	x0, [sp, #32]
 ccc:	b9401fe1 	ldr	w1, [sp, #28]
 cd0:	b9000801 	str	w1, [x0, #8]
    free((void*)(hp + 1));
 cd4:	f94013e0 	ldr	x0, [sp, #32]
 cd8:	91004000 	add	x0, x0, #0x10
 cdc:	97ffff89 	bl	b00 <free>
    return freep;
 ce0:	90000000 	adrp	x0, 0 <main>
 ce4:	913a8000 	add	x0, x0, #0xea0
 ce8:	f9400000 	ldr	x0, [x0]
}
 cec:	a8c37bfd 	ldp	x29, x30, [sp], #48
 cf0:	d65f03c0 	ret

0000000000000cf4 <malloc>:

void*
malloc(uint nbytes)
{
 cf4:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 cf8:	910003fd 	mov	x29, sp
 cfc:	b9001fe0 	str	w0, [sp, #28]
    Header *p, *prevp;
    uint nunits;
    
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d00:	b9401fe0 	ldr	w0, [sp, #28]
 d04:	91003c00 	add	x0, x0, #0xf
 d08:	d344fc00 	lsr	x0, x0, #4
 d0c:	11000400 	add	w0, w0, #0x1
 d10:	b9002fe0 	str	w0, [sp, #44]
    if((prevp = freep) == 0){
 d14:	90000000 	adrp	x0, 0 <main>
 d18:	913a8000 	add	x0, x0, #0xea0
 d1c:	f9400000 	ldr	x0, [x0]
 d20:	f9001be0 	str	x0, [sp, #48]
 d24:	f9401be0 	ldr	x0, [sp, #48]
 d28:	f100001f 	cmp	x0, #0x0
 d2c:	54000221 	b.ne	d70 <malloc+0x7c>  // b.any
        base.s.ptr = freep = prevp = &base;
 d30:	90000000 	adrp	x0, 0 <main>
 d34:	913a4000 	add	x0, x0, #0xe90
 d38:	f9001be0 	str	x0, [sp, #48]
 d3c:	90000000 	adrp	x0, 0 <main>
 d40:	913a8000 	add	x0, x0, #0xea0
 d44:	f9401be1 	ldr	x1, [sp, #48]
 d48:	f9000001 	str	x1, [x0]
 d4c:	90000000 	adrp	x0, 0 <main>
 d50:	913a8000 	add	x0, x0, #0xea0
 d54:	f9400001 	ldr	x1, [x0]
 d58:	90000000 	adrp	x0, 0 <main>
 d5c:	913a4000 	add	x0, x0, #0xe90
 d60:	f9000001 	str	x1, [x0]
        base.s.size = 0;
 d64:	90000000 	adrp	x0, 0 <main>
 d68:	913a4000 	add	x0, x0, #0xe90
 d6c:	b900081f 	str	wzr, [x0, #8]
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 d70:	f9401be0 	ldr	x0, [sp, #48]
 d74:	f9400000 	ldr	x0, [x0]
 d78:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
 d7c:	f9401fe0 	ldr	x0, [sp, #56]
 d80:	b9400800 	ldr	w0, [x0, #8]
 d84:	b9402fe1 	ldr	w1, [sp, #44]
 d88:	6b00003f 	cmp	w1, w0
 d8c:	54000448 	b.hi	e14 <malloc+0x120>  // b.pmore
            if(p->s.size == nunits)
 d90:	f9401fe0 	ldr	x0, [sp, #56]
 d94:	b9400800 	ldr	w0, [x0, #8]
 d98:	b9402fe1 	ldr	w1, [sp, #44]
 d9c:	6b00003f 	cmp	w1, w0
 da0:	540000c1 	b.ne	db8 <malloc+0xc4>  // b.any
                prevp->s.ptr = p->s.ptr;
 da4:	f9401fe0 	ldr	x0, [sp, #56]
 da8:	f9400001 	ldr	x1, [x0]
 dac:	f9401be0 	ldr	x0, [sp, #48]
 db0:	f9000001 	str	x1, [x0]
 db4:	14000011 	b	df8 <malloc+0x104>
            else {
                p->s.size -= nunits;
 db8:	f9401fe0 	ldr	x0, [sp, #56]
 dbc:	b9400801 	ldr	w1, [x0, #8]
 dc0:	b9402fe0 	ldr	w0, [sp, #44]
 dc4:	4b000021 	sub	w1, w1, w0
 dc8:	f9401fe0 	ldr	x0, [sp, #56]
 dcc:	b9000801 	str	w1, [x0, #8]
                p += p->s.size;
 dd0:	f9401fe0 	ldr	x0, [sp, #56]
 dd4:	b9400800 	ldr	w0, [x0, #8]
 dd8:	2a0003e0 	mov	w0, w0
 ddc:	d37cec00 	lsl	x0, x0, #4
 de0:	f9401fe1 	ldr	x1, [sp, #56]
 de4:	8b000020 	add	x0, x1, x0
 de8:	f9001fe0 	str	x0, [sp, #56]
                p->s.size = nunits;
 dec:	f9401fe0 	ldr	x0, [sp, #56]
 df0:	b9402fe1 	ldr	w1, [sp, #44]
 df4:	b9000801 	str	w1, [x0, #8]
            }
            freep = prevp;
 df8:	90000000 	adrp	x0, 0 <main>
 dfc:	913a8000 	add	x0, x0, #0xea0
 e00:	f9401be1 	ldr	x1, [sp, #48]
 e04:	f9000001 	str	x1, [x0]
            return (void*)(p + 1);
 e08:	f9401fe0 	ldr	x0, [sp, #56]
 e0c:	91004000 	add	x0, x0, #0x10
 e10:	14000015 	b	e64 <malloc+0x170>
        }
        if(p == freep)
 e14:	90000000 	adrp	x0, 0 <main>
 e18:	913a8000 	add	x0, x0, #0xea0
 e1c:	f9400000 	ldr	x0, [x0]
 e20:	f9401fe1 	ldr	x1, [sp, #56]
 e24:	eb00003f 	cmp	x1, x0
 e28:	54000121 	b.ne	e4c <malloc+0x158>  // b.any
            if((p = morecore(nunits)) == 0)
 e2c:	b9402fe0 	ldr	w0, [sp, #44]
 e30:	97ffff93 	bl	c7c <morecore>
 e34:	f9001fe0 	str	x0, [sp, #56]
 e38:	f9401fe0 	ldr	x0, [sp, #56]
 e3c:	f100001f 	cmp	x0, #0x0
 e40:	54000061 	b.ne	e4c <malloc+0x158>  // b.any
                return 0;
 e44:	d2800000 	mov	x0, #0x0                   	// #0
 e48:	14000007 	b	e64 <malloc+0x170>
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 e4c:	f9401fe0 	ldr	x0, [sp, #56]
 e50:	f9001be0 	str	x0, [sp, #48]
 e54:	f9401fe0 	ldr	x0, [sp, #56]
 e58:	f9400000 	ldr	x0, [x0]
 e5c:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
 e60:	17ffffc7 	b	d7c <malloc+0x88>
    }
}
 e64:	a8c47bfd 	ldp	x29, x30, [sp], #64
 e68:	d65f03c0 	ret
