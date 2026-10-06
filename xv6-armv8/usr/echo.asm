
_echo:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
   4:	910003fd 	mov	x29, sp
   8:	b9001fe0 	str	w0, [sp, #28]
   c:	f9000be1 	str	x1, [sp, #16]
    int i;
    
    for(i = 1; i < argc; i++)
  10:	52800020 	mov	w0, #0x1                   	// #1
  14:	b9002fe0 	str	w0, [sp, #44]
  18:	14000018 	b	78 <main+0x78>
        printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  1c:	b9802fe0 	ldrsw	x0, [sp, #44]
  20:	d37df000 	lsl	x0, x0, #3
  24:	f9400be1 	ldr	x1, [sp, #16]
  28:	8b000020 	add	x0, x1, x0
  2c:	f9400002 	ldr	x2, [x0]
  30:	b9402fe0 	ldr	w0, [sp, #44]
  34:	11000400 	add	w0, w0, #0x1
  38:	b9401fe1 	ldr	w1, [sp, #28]
  3c:	6b00003f 	cmp	w1, w0
  40:	5400008d 	b.le	50 <main+0x50>
  44:	90000000 	adrp	x0, 0 <main>
  48:	913b6000 	add	x0, x0, #0xed8
  4c:	14000003 	b	58 <main+0x58>
  50:	90000000 	adrp	x0, 0 <main>
  54:	913b8000 	add	x0, x0, #0xee0
  58:	aa0003e3 	mov	x3, x0
  5c:	90000000 	adrp	x0, 0 <main>
  60:	913ba001 	add	x1, x0, #0xee8
  64:	52800020 	mov	w0, #0x1                   	// #1
  68:	9400022a 	bl	910 <printf>
    for(i = 1; i < argc; i++)
  6c:	b9402fe0 	ldr	w0, [sp, #44]
  70:	11000400 	add	w0, w0, #0x1
  74:	b9002fe0 	str	w0, [sp, #44]
  78:	b9402fe1 	ldr	w1, [sp, #44]
  7c:	b9401fe0 	ldr	w0, [sp, #28]
  80:	6b00003f 	cmp	w1, w0
  84:	54fffccb 	b.lt	1c <main+0x1c>  // b.tstop
    exit();
  88:	9400011b 	bl	4f4 <exit>

000000000000008c <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  8c:	d10083ff 	sub	sp, sp, #0x20
  90:	f90007e0 	str	x0, [sp, #8]
  94:	f90003e1 	str	x1, [sp]
    char *os;
    
    os = s;
  98:	f94007e0 	ldr	x0, [sp, #8]
  9c:	f9000fe0 	str	x0, [sp, #24]
    while((*s++ = *t++) != 0)
  a0:	d503201f 	nop
  a4:	f94003e1 	ldr	x1, [sp]
  a8:	91000420 	add	x0, x1, #0x1
  ac:	f90003e0 	str	x0, [sp]
  b0:	f94007e0 	ldr	x0, [sp, #8]
  b4:	91000402 	add	x2, x0, #0x1
  b8:	f90007e2 	str	x2, [sp, #8]
  bc:	39400021 	ldrb	w1, [x1]
  c0:	39000001 	strb	w1, [x0]
  c4:	39400000 	ldrb	w0, [x0]
  c8:	7100001f 	cmp	w0, #0x0
  cc:	54fffec1 	b.ne	a4 <strcpy+0x18>  // b.any
        ;
    return os;
  d0:	f9400fe0 	ldr	x0, [sp, #24]
}
  d4:	910083ff 	add	sp, sp, #0x20
  d8:	d65f03c0 	ret

00000000000000dc <strcmp>:

int
strcmp(const char *p, const char *q)
{
  dc:	d10043ff 	sub	sp, sp, #0x10
  e0:	f90007e0 	str	x0, [sp, #8]
  e4:	f90003e1 	str	x1, [sp]
    while(*p && *p == *q)
  e8:	14000007 	b	104 <strcmp+0x28>
        p++, q++;
  ec:	f94007e0 	ldr	x0, [sp, #8]
  f0:	91000400 	add	x0, x0, #0x1
  f4:	f90007e0 	str	x0, [sp, #8]
  f8:	f94003e0 	ldr	x0, [sp]
  fc:	91000400 	add	x0, x0, #0x1
 100:	f90003e0 	str	x0, [sp]
    while(*p && *p == *q)
 104:	f94007e0 	ldr	x0, [sp, #8]
 108:	39400000 	ldrb	w0, [x0]
 10c:	7100001f 	cmp	w0, #0x0
 110:	540000e0 	b.eq	12c <strcmp+0x50>  // b.none
 114:	f94007e0 	ldr	x0, [sp, #8]
 118:	39400001 	ldrb	w1, [x0]
 11c:	f94003e0 	ldr	x0, [sp]
 120:	39400000 	ldrb	w0, [x0]
 124:	6b00003f 	cmp	w1, w0
 128:	54fffe20 	b.eq	ec <strcmp+0x10>  // b.none
    return (uchar)*p - (uchar)*q;
 12c:	f94007e0 	ldr	x0, [sp, #8]
 130:	39400000 	ldrb	w0, [x0]
 134:	2a0003e1 	mov	w1, w0
 138:	f94003e0 	ldr	x0, [sp]
 13c:	39400000 	ldrb	w0, [x0]
 140:	4b000020 	sub	w0, w1, w0
}
 144:	910043ff 	add	sp, sp, #0x10
 148:	d65f03c0 	ret

000000000000014c <strlen>:

uint
strlen(char *s)
{
 14c:	d10083ff 	sub	sp, sp, #0x20
 150:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    for(n = 0; s[n]; n++)
 154:	b9001fff 	str	wzr, [sp, #28]
 158:	14000004 	b	168 <strlen+0x1c>
 15c:	b9401fe0 	ldr	w0, [sp, #28]
 160:	11000400 	add	w0, w0, #0x1
 164:	b9001fe0 	str	w0, [sp, #28]
 168:	b9801fe0 	ldrsw	x0, [sp, #28]
 16c:	f94007e1 	ldr	x1, [sp, #8]
 170:	8b000020 	add	x0, x1, x0
 174:	39400000 	ldrb	w0, [x0]
 178:	7100001f 	cmp	w0, #0x0
 17c:	54ffff01 	b.ne	15c <strlen+0x10>  // b.any
        ;
    return n;
 180:	b9401fe0 	ldr	w0, [sp, #28]
}
 184:	910083ff 	add	sp, sp, #0x20
 188:	d65f03c0 	ret

000000000000018c <memset>:

void*
memset(void *dst, int v, uint n)
{
 18c:	d100c3ff 	sub	sp, sp, #0x30
 190:	f90007e0 	str	x0, [sp, #8]
 194:	b90007e1 	str	w1, [sp, #4]
 198:	b90003e2 	str	w2, [sp]
	uint8	*p;
	uint8	c;
	uint32	val;
	uint32	*p4;

	p   = dst;
 19c:	f94007e0 	ldr	x0, [sp, #8]
 1a0:	f90017e0 	str	x0, [sp, #40]
	c   = v & 0xff;
 1a4:	b94007e0 	ldr	w0, [sp, #4]
 1a8:	39007fe0 	strb	w0, [sp, #31]
	val = (c << 24) | (c << 16) | (c << 8) | c;
 1ac:	39407fe1 	ldrb	w1, [sp, #31]
 1b0:	2a0103e0 	mov	w0, w1
 1b4:	53185c00 	lsl	w0, w0, #8
 1b8:	0b010000 	add	w0, w0, w1
 1bc:	53103c00 	lsl	w0, w0, #16
 1c0:	2a0003e1 	mov	w1, w0
 1c4:	39407fe0 	ldrb	w0, [sp, #31]
 1c8:	53185c00 	lsl	w0, w0, #8
 1cc:	2a000021 	orr	w1, w1, w0
 1d0:	39407fe0 	ldrb	w0, [sp, #31]
 1d4:	2a000020 	orr	w0, w1, w0
 1d8:	b9001be0 	str	w0, [sp, #24]

	// set bytes before whole uint32
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
 1dc:	1400000a 	b	204 <memset+0x78>
		*p = c;
 1e0:	f94017e0 	ldr	x0, [sp, #40]
 1e4:	39407fe1 	ldrb	w1, [sp, #31]
 1e8:	39000001 	strb	w1, [x0]
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
 1ec:	b94003e0 	ldr	w0, [sp]
 1f0:	51000400 	sub	w0, w0, #0x1
 1f4:	b90003e0 	str	w0, [sp]
 1f8:	f94017e0 	ldr	x0, [sp, #40]
 1fc:	91000400 	add	x0, x0, #0x1
 200:	f90017e0 	str	x0, [sp, #40]
 204:	b94003e0 	ldr	w0, [sp]
 208:	7100001f 	cmp	w0, #0x0
 20c:	540000a0 	b.eq	220 <memset+0x94>  // b.none
 210:	f94017e0 	ldr	x0, [sp, #40]
 214:	92400400 	and	x0, x0, #0x3
 218:	f100001f 	cmp	x0, #0x0
 21c:	54fffe21 	b.ne	1e0 <memset+0x54>  // b.any
	}

	// set memory 4 bytes a time
	p4 = (uint*)p;
 220:	f94017e0 	ldr	x0, [sp, #40]
 224:	f90013e0 	str	x0, [sp, #32]

	for (; n >= 4; n -= 4, p4++) {
 228:	1400000a 	b	250 <memset+0xc4>
		*p4 = val;
 22c:	f94013e0 	ldr	x0, [sp, #32]
 230:	b9401be1 	ldr	w1, [sp, #24]
 234:	b9000001 	str	w1, [x0]
	for (; n >= 4; n -= 4, p4++) {
 238:	b94003e0 	ldr	w0, [sp]
 23c:	51001000 	sub	w0, w0, #0x4
 240:	b90003e0 	str	w0, [sp]
 244:	f94013e0 	ldr	x0, [sp, #32]
 248:	91001000 	add	x0, x0, #0x4
 24c:	f90013e0 	str	x0, [sp, #32]
 250:	b94003e0 	ldr	w0, [sp]
 254:	71000c1f 	cmp	w0, #0x3
 258:	54fffea8 	b.hi	22c <memset+0xa0>  // b.pmore
	}

	// set leftover one byte a time
	p = (uint8*)p4;
 25c:	f94013e0 	ldr	x0, [sp, #32]
 260:	f90017e0 	str	x0, [sp, #40]

	for (; n > 0; n--, p++) {
 264:	1400000a 	b	28c <memset+0x100>
		*p = c;
 268:	f94017e0 	ldr	x0, [sp, #40]
 26c:	39407fe1 	ldrb	w1, [sp, #31]
 270:	39000001 	strb	w1, [x0]
	for (; n > 0; n--, p++) {
 274:	b94003e0 	ldr	w0, [sp]
 278:	51000400 	sub	w0, w0, #0x1
 27c:	b90003e0 	str	w0, [sp]
 280:	f94017e0 	ldr	x0, [sp, #40]
 284:	91000400 	add	x0, x0, #0x1
 288:	f90017e0 	str	x0, [sp, #40]
 28c:	b94003e0 	ldr	w0, [sp]
 290:	7100001f 	cmp	w0, #0x0
 294:	54fffea1 	b.ne	268 <memset+0xdc>  // b.any
	}

	return dst;
 298:	f94007e0 	ldr	x0, [sp, #8]
}
 29c:	9100c3ff 	add	sp, sp, #0x30
 2a0:	d65f03c0 	ret

00000000000002a4 <strchr>:

char*
strchr(const char *s, char c)
{
 2a4:	d10043ff 	sub	sp, sp, #0x10
 2a8:	f90007e0 	str	x0, [sp, #8]
 2ac:	39001fe1 	strb	w1, [sp, #7]
    for(; *s; s++)
 2b0:	1400000b 	b	2dc <strchr+0x38>
        if(*s == c)
 2b4:	f94007e0 	ldr	x0, [sp, #8]
 2b8:	39400000 	ldrb	w0, [x0]
 2bc:	39401fe1 	ldrb	w1, [sp, #7]
 2c0:	6b00003f 	cmp	w1, w0
 2c4:	54000061 	b.ne	2d0 <strchr+0x2c>  // b.any
            return (char*)s;
 2c8:	f94007e0 	ldr	x0, [sp, #8]
 2cc:	14000009 	b	2f0 <strchr+0x4c>
    for(; *s; s++)
 2d0:	f94007e0 	ldr	x0, [sp, #8]
 2d4:	91000400 	add	x0, x0, #0x1
 2d8:	f90007e0 	str	x0, [sp, #8]
 2dc:	f94007e0 	ldr	x0, [sp, #8]
 2e0:	39400000 	ldrb	w0, [x0]
 2e4:	7100001f 	cmp	w0, #0x0
 2e8:	54fffe61 	b.ne	2b4 <strchr+0x10>  // b.any
    return 0;
 2ec:	d2800000 	mov	x0, #0x0                   	// #0
}
 2f0:	910043ff 	add	sp, sp, #0x10
 2f4:	d65f03c0 	ret

00000000000002f8 <gets>:

char*
gets(char *buf, int max)
{
 2f8:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 2fc:	910003fd 	mov	x29, sp
 300:	f9000fe0 	str	x0, [sp, #24]
 304:	b90017e1 	str	w1, [sp, #20]
    int i, cc;
    char c;
    
    for(i=0; i+1 < max; ){
 308:	b9002fff 	str	wzr, [sp, #44]
 30c:	14000018 	b	36c <gets+0x74>
        cc = read(0, &c, 1);
 310:	91009fe0 	add	x0, sp, #0x27
 314:	52800022 	mov	w2, #0x1                   	// #1
 318:	aa0003e1 	mov	x1, x0
 31c:	52800000 	mov	w0, #0x0                   	// #0
 320:	94000090 	bl	560 <read>
 324:	b9002be0 	str	w0, [sp, #40]
        if(cc < 1)
 328:	b9402be0 	ldr	w0, [sp, #40]
 32c:	7100001f 	cmp	w0, #0x0
 330:	540002ad 	b.le	384 <gets+0x8c>
            break;
        buf[i++] = c;
 334:	b9402fe0 	ldr	w0, [sp, #44]
 338:	11000401 	add	w1, w0, #0x1
 33c:	b9002fe1 	str	w1, [sp, #44]
 340:	93407c00 	sxtw	x0, w0
 344:	f9400fe1 	ldr	x1, [sp, #24]
 348:	8b000020 	add	x0, x1, x0
 34c:	39409fe1 	ldrb	w1, [sp, #39]
 350:	39000001 	strb	w1, [x0]
        if(c == '\n' || c == '\r')
 354:	39409fe0 	ldrb	w0, [sp, #39]
 358:	7100281f 	cmp	w0, #0xa
 35c:	54000160 	b.eq	388 <gets+0x90>  // b.none
 360:	39409fe0 	ldrb	w0, [sp, #39]
 364:	7100341f 	cmp	w0, #0xd
 368:	54000100 	b.eq	388 <gets+0x90>  // b.none
    for(i=0; i+1 < max; ){
 36c:	b9402fe0 	ldr	w0, [sp, #44]
 370:	11000400 	add	w0, w0, #0x1
 374:	b94017e1 	ldr	w1, [sp, #20]
 378:	6b00003f 	cmp	w1, w0
 37c:	54fffcac 	b.gt	310 <gets+0x18>
 380:	14000002 	b	388 <gets+0x90>
            break;
 384:	d503201f 	nop
            break;
    }
    buf[i] = '\0';
 388:	b9802fe0 	ldrsw	x0, [sp, #44]
 38c:	f9400fe1 	ldr	x1, [sp, #24]
 390:	8b000020 	add	x0, x1, x0
 394:	3900001f 	strb	wzr, [x0]
    return buf;
 398:	f9400fe0 	ldr	x0, [sp, #24]
}
 39c:	a8c37bfd 	ldp	x29, x30, [sp], #48
 3a0:	d65f03c0 	ret

00000000000003a4 <stat>:

int
stat(char *n, struct stat *st)
{
 3a4:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 3a8:	910003fd 	mov	x29, sp
 3ac:	f9000fe0 	str	x0, [sp, #24]
 3b0:	f9000be1 	str	x1, [sp, #16]
    int fd;
    int r;
    
    fd = open(n, O_RDONLY);
 3b4:	52800001 	mov	w1, #0x0                   	// #0
 3b8:	f9400fe0 	ldr	x0, [sp, #24]
 3bc:	94000096 	bl	614 <open>
 3c0:	b9002fe0 	str	w0, [sp, #44]
    if(fd < 0)
 3c4:	b9402fe0 	ldr	w0, [sp, #44]
 3c8:	7100001f 	cmp	w0, #0x0
 3cc:	5400006a 	b.ge	3d8 <stat+0x34>  // b.tcont
        return -1;
 3d0:	12800000 	mov	w0, #0xffffffff            	// #-1
 3d4:	14000008 	b	3f4 <stat+0x50>
    r = fstat(fd, st);
 3d8:	f9400be1 	ldr	x1, [sp, #16]
 3dc:	b9402fe0 	ldr	w0, [sp, #44]
 3e0:	940000a8 	bl	680 <fstat>
 3e4:	b9002be0 	str	w0, [sp, #40]
    close(fd);
 3e8:	b9402fe0 	ldr	w0, [sp, #44]
 3ec:	9400006f 	bl	5a8 <close>
    return r;
 3f0:	b9402be0 	ldr	w0, [sp, #40]
}
 3f4:	a8c37bfd 	ldp	x29, x30, [sp], #48
 3f8:	d65f03c0 	ret

00000000000003fc <atoi>:

int
atoi(const char *s)
{
 3fc:	d10083ff 	sub	sp, sp, #0x20
 400:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    n = 0;
 404:	b9001fff 	str	wzr, [sp, #28]
    while('0' <= *s && *s <= '9')
 408:	1400000e 	b	440 <atoi+0x44>
        n = n*10 + *s++ - '0';
 40c:	b9401fe1 	ldr	w1, [sp, #28]
 410:	2a0103e0 	mov	w0, w1
 414:	531e7400 	lsl	w0, w0, #2
 418:	0b010000 	add	w0, w0, w1
 41c:	531f7800 	lsl	w0, w0, #1
 420:	2a0003e2 	mov	w2, w0
 424:	f94007e0 	ldr	x0, [sp, #8]
 428:	91000401 	add	x1, x0, #0x1
 42c:	f90007e1 	str	x1, [sp, #8]
 430:	39400000 	ldrb	w0, [x0]
 434:	0b000040 	add	w0, w2, w0
 438:	5100c000 	sub	w0, w0, #0x30
 43c:	b9001fe0 	str	w0, [sp, #28]
    while('0' <= *s && *s <= '9')
 440:	f94007e0 	ldr	x0, [sp, #8]
 444:	39400000 	ldrb	w0, [x0]
 448:	7100bc1f 	cmp	w0, #0x2f
 44c:	540000a9 	b.ls	460 <atoi+0x64>  // b.plast
 450:	f94007e0 	ldr	x0, [sp, #8]
 454:	39400000 	ldrb	w0, [x0]
 458:	7100e41f 	cmp	w0, #0x39
 45c:	54fffd89 	b.ls	40c <atoi+0x10>  // b.plast
    return n;
 460:	b9401fe0 	ldr	w0, [sp, #28]
}
 464:	910083ff 	add	sp, sp, #0x20
 468:	d65f03c0 	ret

000000000000046c <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 46c:	d100c3ff 	sub	sp, sp, #0x30
 470:	f9000fe0 	str	x0, [sp, #24]
 474:	f9000be1 	str	x1, [sp, #16]
 478:	b9000fe2 	str	w2, [sp, #12]
    char *dst, *src;
    
    dst = vdst;
 47c:	f9400fe0 	ldr	x0, [sp, #24]
 480:	f90017e0 	str	x0, [sp, #40]
    src = vsrc;
 484:	f9400be0 	ldr	x0, [sp, #16]
 488:	f90013e0 	str	x0, [sp, #32]
    while(n-- > 0)
 48c:	14000009 	b	4b0 <memmove+0x44>
        *dst++ = *src++;
 490:	f94013e1 	ldr	x1, [sp, #32]
 494:	91000420 	add	x0, x1, #0x1
 498:	f90013e0 	str	x0, [sp, #32]
 49c:	f94017e0 	ldr	x0, [sp, #40]
 4a0:	91000402 	add	x2, x0, #0x1
 4a4:	f90017e2 	str	x2, [sp, #40]
 4a8:	39400021 	ldrb	w1, [x1]
 4ac:	39000001 	strb	w1, [x0]
    while(n-- > 0)
 4b0:	b9400fe0 	ldr	w0, [sp, #12]
 4b4:	51000401 	sub	w1, w0, #0x1
 4b8:	b9000fe1 	str	w1, [sp, #12]
 4bc:	7100001f 	cmp	w0, #0x0
 4c0:	54fffe8c 	b.gt	490 <memmove+0x24>
    return vdst;
 4c4:	f9400fe0 	ldr	x0, [sp, #24]
}
 4c8:	9100c3ff 	add	sp, sp, #0x30
 4cc:	d65f03c0 	ret

00000000000004d0 <fork>:
 4d0:	f81f8fe4 	str	x4, [sp, #-8]!
 4d4:	aa0303e4 	mov	x4, x3
 4d8:	aa0203e3 	mov	x3, x2
 4dc:	aa0103e2 	mov	x2, x1
 4e0:	aa0003e1 	mov	x1, x0
 4e4:	d2800020 	mov	x0, #0x1                   	// #1
 4e8:	d4000001 	svc	#0x0
 4ec:	f84087e4 	ldr	x4, [sp], #8
 4f0:	d61f03c0 	br	x30

00000000000004f4 <exit>:
 4f4:	f81f8fe4 	str	x4, [sp, #-8]!
 4f8:	aa0303e4 	mov	x4, x3
 4fc:	aa0203e3 	mov	x3, x2
 500:	aa0103e2 	mov	x2, x1
 504:	aa0003e1 	mov	x1, x0
 508:	d2800040 	mov	x0, #0x2                   	// #2
 50c:	d4000001 	svc	#0x0
 510:	f84087e4 	ldr	x4, [sp], #8
 514:	d61f03c0 	br	x30

0000000000000518 <wait>:
 518:	f81f8fe4 	str	x4, [sp, #-8]!
 51c:	aa0303e4 	mov	x4, x3
 520:	aa0203e3 	mov	x3, x2
 524:	aa0103e2 	mov	x2, x1
 528:	aa0003e1 	mov	x1, x0
 52c:	d2800060 	mov	x0, #0x3                   	// #3
 530:	d4000001 	svc	#0x0
 534:	f84087e4 	ldr	x4, [sp], #8
 538:	d61f03c0 	br	x30

000000000000053c <pipe>:
 53c:	f81f8fe4 	str	x4, [sp, #-8]!
 540:	aa0303e4 	mov	x4, x3
 544:	aa0203e3 	mov	x3, x2
 548:	aa0103e2 	mov	x2, x1
 54c:	aa0003e1 	mov	x1, x0
 550:	d2800080 	mov	x0, #0x4                   	// #4
 554:	d4000001 	svc	#0x0
 558:	f84087e4 	ldr	x4, [sp], #8
 55c:	d61f03c0 	br	x30

0000000000000560 <read>:
 560:	f81f8fe4 	str	x4, [sp, #-8]!
 564:	aa0303e4 	mov	x4, x3
 568:	aa0203e3 	mov	x3, x2
 56c:	aa0103e2 	mov	x2, x1
 570:	aa0003e1 	mov	x1, x0
 574:	d28000a0 	mov	x0, #0x5                   	// #5
 578:	d4000001 	svc	#0x0
 57c:	f84087e4 	ldr	x4, [sp], #8
 580:	d61f03c0 	br	x30

0000000000000584 <write>:
 584:	f81f8fe4 	str	x4, [sp, #-8]!
 588:	aa0303e4 	mov	x4, x3
 58c:	aa0203e3 	mov	x3, x2
 590:	aa0103e2 	mov	x2, x1
 594:	aa0003e1 	mov	x1, x0
 598:	d2800200 	mov	x0, #0x10                  	// #16
 59c:	d4000001 	svc	#0x0
 5a0:	f84087e4 	ldr	x4, [sp], #8
 5a4:	d61f03c0 	br	x30

00000000000005a8 <close>:
 5a8:	f81f8fe4 	str	x4, [sp, #-8]!
 5ac:	aa0303e4 	mov	x4, x3
 5b0:	aa0203e3 	mov	x3, x2
 5b4:	aa0103e2 	mov	x2, x1
 5b8:	aa0003e1 	mov	x1, x0
 5bc:	d28002a0 	mov	x0, #0x15                  	// #21
 5c0:	d4000001 	svc	#0x0
 5c4:	f84087e4 	ldr	x4, [sp], #8
 5c8:	d61f03c0 	br	x30

00000000000005cc <kill>:
 5cc:	f81f8fe4 	str	x4, [sp, #-8]!
 5d0:	aa0303e4 	mov	x4, x3
 5d4:	aa0203e3 	mov	x3, x2
 5d8:	aa0103e2 	mov	x2, x1
 5dc:	aa0003e1 	mov	x1, x0
 5e0:	d28000c0 	mov	x0, #0x6                   	// #6
 5e4:	d4000001 	svc	#0x0
 5e8:	f84087e4 	ldr	x4, [sp], #8
 5ec:	d61f03c0 	br	x30

00000000000005f0 <exec>:
 5f0:	f81f8fe4 	str	x4, [sp, #-8]!
 5f4:	aa0303e4 	mov	x4, x3
 5f8:	aa0203e3 	mov	x3, x2
 5fc:	aa0103e2 	mov	x2, x1
 600:	aa0003e1 	mov	x1, x0
 604:	d28000e0 	mov	x0, #0x7                   	// #7
 608:	d4000001 	svc	#0x0
 60c:	f84087e4 	ldr	x4, [sp], #8
 610:	d61f03c0 	br	x30

0000000000000614 <open>:
 614:	f81f8fe4 	str	x4, [sp, #-8]!
 618:	aa0303e4 	mov	x4, x3
 61c:	aa0203e3 	mov	x3, x2
 620:	aa0103e2 	mov	x2, x1
 624:	aa0003e1 	mov	x1, x0
 628:	d28001e0 	mov	x0, #0xf                   	// #15
 62c:	d4000001 	svc	#0x0
 630:	f84087e4 	ldr	x4, [sp], #8
 634:	d61f03c0 	br	x30

0000000000000638 <mknod>:
 638:	f81f8fe4 	str	x4, [sp, #-8]!
 63c:	aa0303e4 	mov	x4, x3
 640:	aa0203e3 	mov	x3, x2
 644:	aa0103e2 	mov	x2, x1
 648:	aa0003e1 	mov	x1, x0
 64c:	d2800220 	mov	x0, #0x11                  	// #17
 650:	d4000001 	svc	#0x0
 654:	f84087e4 	ldr	x4, [sp], #8
 658:	d61f03c0 	br	x30

000000000000065c <unlink>:
 65c:	f81f8fe4 	str	x4, [sp, #-8]!
 660:	aa0303e4 	mov	x4, x3
 664:	aa0203e3 	mov	x3, x2
 668:	aa0103e2 	mov	x2, x1
 66c:	aa0003e1 	mov	x1, x0
 670:	d2800240 	mov	x0, #0x12                  	// #18
 674:	d4000001 	svc	#0x0
 678:	f84087e4 	ldr	x4, [sp], #8
 67c:	d61f03c0 	br	x30

0000000000000680 <fstat>:
 680:	f81f8fe4 	str	x4, [sp, #-8]!
 684:	aa0303e4 	mov	x4, x3
 688:	aa0203e3 	mov	x3, x2
 68c:	aa0103e2 	mov	x2, x1
 690:	aa0003e1 	mov	x1, x0
 694:	d2800100 	mov	x0, #0x8                   	// #8
 698:	d4000001 	svc	#0x0
 69c:	f84087e4 	ldr	x4, [sp], #8
 6a0:	d61f03c0 	br	x30

00000000000006a4 <link>:
 6a4:	f81f8fe4 	str	x4, [sp, #-8]!
 6a8:	aa0303e4 	mov	x4, x3
 6ac:	aa0203e3 	mov	x3, x2
 6b0:	aa0103e2 	mov	x2, x1
 6b4:	aa0003e1 	mov	x1, x0
 6b8:	d2800260 	mov	x0, #0x13                  	// #19
 6bc:	d4000001 	svc	#0x0
 6c0:	f84087e4 	ldr	x4, [sp], #8
 6c4:	d61f03c0 	br	x30

00000000000006c8 <mkdir>:
 6c8:	f81f8fe4 	str	x4, [sp, #-8]!
 6cc:	aa0303e4 	mov	x4, x3
 6d0:	aa0203e3 	mov	x3, x2
 6d4:	aa0103e2 	mov	x2, x1
 6d8:	aa0003e1 	mov	x1, x0
 6dc:	d2800280 	mov	x0, #0x14                  	// #20
 6e0:	d4000001 	svc	#0x0
 6e4:	f84087e4 	ldr	x4, [sp], #8
 6e8:	d61f03c0 	br	x30

00000000000006ec <chdir>:
 6ec:	f81f8fe4 	str	x4, [sp, #-8]!
 6f0:	aa0303e4 	mov	x4, x3
 6f4:	aa0203e3 	mov	x3, x2
 6f8:	aa0103e2 	mov	x2, x1
 6fc:	aa0003e1 	mov	x1, x0
 700:	d2800120 	mov	x0, #0x9                   	// #9
 704:	d4000001 	svc	#0x0
 708:	f84087e4 	ldr	x4, [sp], #8
 70c:	d61f03c0 	br	x30

0000000000000710 <dup>:
 710:	f81f8fe4 	str	x4, [sp, #-8]!
 714:	aa0303e4 	mov	x4, x3
 718:	aa0203e3 	mov	x3, x2
 71c:	aa0103e2 	mov	x2, x1
 720:	aa0003e1 	mov	x1, x0
 724:	d2800140 	mov	x0, #0xa                   	// #10
 728:	d4000001 	svc	#0x0
 72c:	f84087e4 	ldr	x4, [sp], #8
 730:	d61f03c0 	br	x30

0000000000000734 <getpid>:
 734:	f81f8fe4 	str	x4, [sp, #-8]!
 738:	aa0303e4 	mov	x4, x3
 73c:	aa0203e3 	mov	x3, x2
 740:	aa0103e2 	mov	x2, x1
 744:	aa0003e1 	mov	x1, x0
 748:	d2800160 	mov	x0, #0xb                   	// #11
 74c:	d4000001 	svc	#0x0
 750:	f84087e4 	ldr	x4, [sp], #8
 754:	d61f03c0 	br	x30

0000000000000758 <sbrk>:
 758:	f81f8fe4 	str	x4, [sp, #-8]!
 75c:	aa0303e4 	mov	x4, x3
 760:	aa0203e3 	mov	x3, x2
 764:	aa0103e2 	mov	x2, x1
 768:	aa0003e1 	mov	x1, x0
 76c:	d2800180 	mov	x0, #0xc                   	// #12
 770:	d4000001 	svc	#0x0
 774:	f84087e4 	ldr	x4, [sp], #8
 778:	d61f03c0 	br	x30

000000000000077c <sleep>:
 77c:	f81f8fe4 	str	x4, [sp, #-8]!
 780:	aa0303e4 	mov	x4, x3
 784:	aa0203e3 	mov	x3, x2
 788:	aa0103e2 	mov	x2, x1
 78c:	aa0003e1 	mov	x1, x0
 790:	d28001a0 	mov	x0, #0xd                   	// #13
 794:	d4000001 	svc	#0x0
 798:	f84087e4 	ldr	x4, [sp], #8
 79c:	d61f03c0 	br	x30

00000000000007a0 <uptime>:
 7a0:	f81f8fe4 	str	x4, [sp, #-8]!
 7a4:	aa0303e4 	mov	x4, x3
 7a8:	aa0203e3 	mov	x3, x2
 7ac:	aa0103e2 	mov	x2, x1
 7b0:	aa0003e1 	mov	x1, x0
 7b4:	d28001c0 	mov	x0, #0xe                   	// #14
 7b8:	d4000001 	svc	#0x0
 7bc:	f84087e4 	ldr	x4, [sp], #8
 7c0:	d61f03c0 	br	x30

00000000000007c4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 7c4:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
 7c8:	910003fd 	mov	x29, sp
 7cc:	b9001fe0 	str	w0, [sp, #28]
 7d0:	39006fe1 	strb	w1, [sp, #27]
    write(fd, &c, 1);
 7d4:	91006fe0 	add	x0, sp, #0x1b
 7d8:	52800022 	mov	w2, #0x1                   	// #1
 7dc:	aa0003e1 	mov	x1, x0
 7e0:	b9401fe0 	ldr	w0, [sp, #28]
 7e4:	97ffff68 	bl	584 <write>
}
 7e8:	d503201f 	nop
 7ec:	a8c27bfd 	ldp	x29, x30, [sp], #32
 7f0:	d65f03c0 	ret

00000000000007f4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7f4:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 7f8:	910003fd 	mov	x29, sp
 7fc:	b9001fe0 	str	w0, [sp, #28]
 800:	b9001be1 	str	w1, [sp, #24]
 804:	b90017e2 	str	w2, [sp, #20]
 808:	b90013e3 	str	w3, [sp, #16]
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
 80c:	b9003bff 	str	wzr, [sp, #56]
    if(sgn && xx < 0){
 810:	b94013e0 	ldr	w0, [sp, #16]
 814:	7100001f 	cmp	w0, #0x0
 818:	54000140 	b.eq	840 <printint+0x4c>  // b.none
 81c:	b9401be0 	ldr	w0, [sp, #24]
 820:	7100001f 	cmp	w0, #0x0
 824:	540000ea 	b.ge	840 <printint+0x4c>  // b.tcont
        neg = 1;
 828:	52800020 	mov	w0, #0x1                   	// #1
 82c:	b9003be0 	str	w0, [sp, #56]
        x = -xx;
 830:	b9401be0 	ldr	w0, [sp, #24]
 834:	4b0003e0 	neg	w0, w0
 838:	b90037e0 	str	w0, [sp, #52]
 83c:	14000003 	b	848 <printint+0x54>
    } else {
        x = xx;
 840:	b9401be0 	ldr	w0, [sp, #24]
 844:	b90037e0 	str	w0, [sp, #52]
    }
    
    i = 0;
 848:	b9003fff 	str	wzr, [sp, #60]
    do{
        buf[i++] = digits[x % base];
 84c:	b94017e1 	ldr	w1, [sp, #20]
 850:	b94037e0 	ldr	w0, [sp, #52]
 854:	1ac10802 	udiv	w2, w0, w1
 858:	1b017c41 	mul	w1, w2, w1
 85c:	4b010003 	sub	w3, w0, w1
 860:	b9403fe0 	ldr	w0, [sp, #60]
 864:	11000401 	add	w1, w0, #0x1
 868:	b9003fe1 	str	w1, [sp, #60]
 86c:	90000001 	adrp	x1, 0 <main>
 870:	913be022 	add	x2, x1, #0xef8
 874:	2a0303e1 	mov	w1, w3
 878:	38616842 	ldrb	w2, [x2, x1]
 87c:	93407c00 	sxtw	x0, w0
 880:	910083e1 	add	x1, sp, #0x20
 884:	38206822 	strb	w2, [x1, x0]
    }while((x /= base) != 0);
 888:	b94017e0 	ldr	w0, [sp, #20]
 88c:	b94037e1 	ldr	w1, [sp, #52]
 890:	1ac00820 	udiv	w0, w1, w0
 894:	b90037e0 	str	w0, [sp, #52]
 898:	b94037e0 	ldr	w0, [sp, #52]
 89c:	7100001f 	cmp	w0, #0x0
 8a0:	54fffd61 	b.ne	84c <printint+0x58>  // b.any
    if(neg)
 8a4:	b9403be0 	ldr	w0, [sp, #56]
 8a8:	7100001f 	cmp	w0, #0x0
 8ac:	540001e0 	b.eq	8e8 <printint+0xf4>  // b.none
        buf[i++] = '-';
 8b0:	b9403fe0 	ldr	w0, [sp, #60]
 8b4:	11000401 	add	w1, w0, #0x1
 8b8:	b9003fe1 	str	w1, [sp, #60]
 8bc:	93407c00 	sxtw	x0, w0
 8c0:	910083e1 	add	x1, sp, #0x20
 8c4:	528005a2 	mov	w2, #0x2d                  	// #45
 8c8:	38206822 	strb	w2, [x1, x0]
    
    while(--i >= 0)
 8cc:	14000007 	b	8e8 <printint+0xf4>
        putc(fd, buf[i]);
 8d0:	b9803fe0 	ldrsw	x0, [sp, #60]
 8d4:	910083e1 	add	x1, sp, #0x20
 8d8:	38606820 	ldrb	w0, [x1, x0]
 8dc:	2a0003e1 	mov	w1, w0
 8e0:	b9401fe0 	ldr	w0, [sp, #28]
 8e4:	97ffffb8 	bl	7c4 <putc>
    while(--i >= 0)
 8e8:	b9403fe0 	ldr	w0, [sp, #60]
 8ec:	51000400 	sub	w0, w0, #0x1
 8f0:	b9003fe0 	str	w0, [sp, #60]
 8f4:	b9403fe0 	ldr	w0, [sp, #60]
 8f8:	7100001f 	cmp	w0, #0x0
 8fc:	54fffeaa 	b.ge	8d0 <printint+0xdc>  // b.tcont
}
 900:	d503201f 	nop
 904:	d503201f 	nop
 908:	a8c47bfd 	ldp	x29, x30, [sp], #64
 90c:	d65f03c0 	ret

0000000000000910 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 910:	a9b17bfd 	stp	x29, x30, [sp, #-240]!
 914:	910003fd 	mov	x29, sp
 918:	b9001fe0 	str	w0, [sp, #28]
 91c:	f9000be1 	str	x1, [sp, #16]
 920:	f90063e2 	str	x2, [sp, #192]
 924:	f90067e3 	str	x3, [sp, #200]
 928:	f9006be4 	str	x4, [sp, #208]
 92c:	f9006fe5 	str	x5, [sp, #216]
 930:	f90073e6 	str	x6, [sp, #224]
 934:	f90077e7 	str	x7, [sp, #232]
 938:	3d8013e0 	str	q0, [sp, #64]
 93c:	3d8017e1 	str	q1, [sp, #80]
 940:	3d801be2 	str	q2, [sp, #96]
 944:	3d801fe3 	str	q3, [sp, #112]
 948:	3d8023e4 	str	q4, [sp, #128]
 94c:	3d8027e5 	str	q5, [sp, #144]
 950:	3d802be6 	str	q6, [sp, #160]
 954:	3d802fe7 	str	q7, [sp, #176]
    char *s;
    int c, i, state;
    uint64 *ap;
    
    state = 0;
 958:	b90033ff 	str	wzr, [sp, #48]
    ap = (uint64*)(void*)&fmt + 22;
 95c:	910043e0 	add	x0, sp, #0x10
 960:	9102c000 	add	x0, x0, #0xb0
 964:	f90017e0 	str	x0, [sp, #40]
    for(i = 0; fmt[i]; i++){
 968:	b90037ff 	str	wzr, [sp, #52]
 96c:	14000076 	b	b44 <printf+0x234>
        c = fmt[i] & 0xff;
 970:	f9400be1 	ldr	x1, [sp, #16]
 974:	b98037e0 	ldrsw	x0, [sp, #52]
 978:	8b000020 	add	x0, x1, x0
 97c:	39400000 	ldrb	w0, [x0]
 980:	b90027e0 	str	w0, [sp, #36]
        if(state == 0){
 984:	b94033e0 	ldr	w0, [sp, #48]
 988:	7100001f 	cmp	w0, #0x0
 98c:	540001a1 	b.ne	9c0 <printf+0xb0>  // b.any
            if(c == '%'){
 990:	b94027e0 	ldr	w0, [sp, #36]
 994:	7100941f 	cmp	w0, #0x25
 998:	54000081 	b.ne	9a8 <printf+0x98>  // b.any
                state = '%';
 99c:	528004a0 	mov	w0, #0x25                  	// #37
 9a0:	b90033e0 	str	w0, [sp, #48]
 9a4:	14000065 	b	b38 <printf+0x228>
            } else {
                putc(fd, c);
 9a8:	b94027e0 	ldr	w0, [sp, #36]
 9ac:	12001c00 	and	w0, w0, #0xff
 9b0:	2a0003e1 	mov	w1, w0
 9b4:	b9401fe0 	ldr	w0, [sp, #28]
 9b8:	97ffff83 	bl	7c4 <putc>
 9bc:	1400005f 	b	b38 <printf+0x228>
            }
        } else if(state == '%'){
 9c0:	b94033e0 	ldr	w0, [sp, #48]
 9c4:	7100941f 	cmp	w0, #0x25
 9c8:	54000b81 	b.ne	b38 <printf+0x228>  // b.any
            if(c == 'd'){
 9cc:	b94027e0 	ldr	w0, [sp, #36]
 9d0:	7101901f 	cmp	w0, #0x64
 9d4:	54000181 	b.ne	a04 <printf+0xf4>  // b.any
                printint(fd, *ap, 10, 1);
 9d8:	f94017e0 	ldr	x0, [sp, #40]
 9dc:	f9400000 	ldr	x0, [x0]
 9e0:	52800023 	mov	w3, #0x1                   	// #1
 9e4:	52800142 	mov	w2, #0xa                   	// #10
 9e8:	2a0003e1 	mov	w1, w0
 9ec:	b9401fe0 	ldr	w0, [sp, #28]
 9f0:	97ffff81 	bl	7f4 <printint>
                ap++;
 9f4:	f94017e0 	ldr	x0, [sp, #40]
 9f8:	91002000 	add	x0, x0, #0x8
 9fc:	f90017e0 	str	x0, [sp, #40]
 a00:	1400004d 	b	b34 <printf+0x224>
            } else if(c == 'x' || c == 'p'){
 a04:	b94027e0 	ldr	w0, [sp, #36]
 a08:	7101e01f 	cmp	w0, #0x78
 a0c:	54000080 	b.eq	a1c <printf+0x10c>  // b.none
 a10:	b94027e0 	ldr	w0, [sp, #36]
 a14:	7101c01f 	cmp	w0, #0x70
 a18:	54000181 	b.ne	a48 <printf+0x138>  // b.any
                printint(fd, *ap, 16, 0);
 a1c:	f94017e0 	ldr	x0, [sp, #40]
 a20:	f9400000 	ldr	x0, [x0]
 a24:	52800003 	mov	w3, #0x0                   	// #0
 a28:	52800202 	mov	w2, #0x10                  	// #16
 a2c:	2a0003e1 	mov	w1, w0
 a30:	b9401fe0 	ldr	w0, [sp, #28]
 a34:	97ffff70 	bl	7f4 <printint>
                ap++;
 a38:	f94017e0 	ldr	x0, [sp, #40]
 a3c:	91002000 	add	x0, x0, #0x8
 a40:	f90017e0 	str	x0, [sp, #40]
 a44:	1400003c 	b	b34 <printf+0x224>
            } else if(c == 's'){
 a48:	b94027e0 	ldr	w0, [sp, #36]
 a4c:	7101cc1f 	cmp	w0, #0x73
 a50:	54000361 	b.ne	abc <printf+0x1ac>  // b.any
                s = (char*)*ap;
 a54:	f94017e0 	ldr	x0, [sp, #40]
 a58:	f9400000 	ldr	x0, [x0]
 a5c:	f9001fe0 	str	x0, [sp, #56]
                ap++;
 a60:	f94017e0 	ldr	x0, [sp, #40]
 a64:	91002000 	add	x0, x0, #0x8
 a68:	f90017e0 	str	x0, [sp, #40]
                if(s == 0)
 a6c:	f9401fe0 	ldr	x0, [sp, #56]
 a70:	f100001f 	cmp	x0, #0x0
 a74:	540001a1 	b.ne	aa8 <printf+0x198>  // b.any
                    s = "(null)";
 a78:	90000000 	adrp	x0, 0 <main>
 a7c:	913bc000 	add	x0, x0, #0xef0
 a80:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
 a84:	14000009 	b	aa8 <printf+0x198>
                    putc(fd, *s);
 a88:	f9401fe0 	ldr	x0, [sp, #56]
 a8c:	39400000 	ldrb	w0, [x0]
 a90:	2a0003e1 	mov	w1, w0
 a94:	b9401fe0 	ldr	w0, [sp, #28]
 a98:	97ffff4b 	bl	7c4 <putc>
                    s++;
 a9c:	f9401fe0 	ldr	x0, [sp, #56]
 aa0:	91000400 	add	x0, x0, #0x1
 aa4:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
 aa8:	f9401fe0 	ldr	x0, [sp, #56]
 aac:	39400000 	ldrb	w0, [x0]
 ab0:	7100001f 	cmp	w0, #0x0
 ab4:	54fffea1 	b.ne	a88 <printf+0x178>  // b.any
 ab8:	1400001f 	b	b34 <printf+0x224>
                }
            } else if(c == 'c'){
 abc:	b94027e0 	ldr	w0, [sp, #36]
 ac0:	71018c1f 	cmp	w0, #0x63
 ac4:	54000161 	b.ne	af0 <printf+0x1e0>  // b.any
                putc(fd, *ap);
 ac8:	f94017e0 	ldr	x0, [sp, #40]
 acc:	f9400000 	ldr	x0, [x0]
 ad0:	12001c00 	and	w0, w0, #0xff
 ad4:	2a0003e1 	mov	w1, w0
 ad8:	b9401fe0 	ldr	w0, [sp, #28]
 adc:	97ffff3a 	bl	7c4 <putc>
                ap++;
 ae0:	f94017e0 	ldr	x0, [sp, #40]
 ae4:	91002000 	add	x0, x0, #0x8
 ae8:	f90017e0 	str	x0, [sp, #40]
 aec:	14000012 	b	b34 <printf+0x224>
            } else if(c == '%'){
 af0:	b94027e0 	ldr	w0, [sp, #36]
 af4:	7100941f 	cmp	w0, #0x25
 af8:	540000e1 	b.ne	b14 <printf+0x204>  // b.any
                putc(fd, c);
 afc:	b94027e0 	ldr	w0, [sp, #36]
 b00:	12001c00 	and	w0, w0, #0xff
 b04:	2a0003e1 	mov	w1, w0
 b08:	b9401fe0 	ldr	w0, [sp, #28]
 b0c:	97ffff2e 	bl	7c4 <putc>
 b10:	14000009 	b	b34 <printf+0x224>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
 b14:	528004a1 	mov	w1, #0x25                  	// #37
 b18:	b9401fe0 	ldr	w0, [sp, #28]
 b1c:	97ffff2a 	bl	7c4 <putc>
                putc(fd, c);
 b20:	b94027e0 	ldr	w0, [sp, #36]
 b24:	12001c00 	and	w0, w0, #0xff
 b28:	2a0003e1 	mov	w1, w0
 b2c:	b9401fe0 	ldr	w0, [sp, #28]
 b30:	97ffff25 	bl	7c4 <putc>
            }
            state = 0;
 b34:	b90033ff 	str	wzr, [sp, #48]
    for(i = 0; fmt[i]; i++){
 b38:	b94037e0 	ldr	w0, [sp, #52]
 b3c:	11000400 	add	w0, w0, #0x1
 b40:	b90037e0 	str	w0, [sp, #52]
 b44:	f9400be1 	ldr	x1, [sp, #16]
 b48:	b98037e0 	ldrsw	x0, [sp, #52]
 b4c:	8b000020 	add	x0, x1, x0
 b50:	39400000 	ldrb	w0, [x0]
 b54:	7100001f 	cmp	w0, #0x0
 b58:	54fff0c1 	b.ne	970 <printf+0x60>  // b.any
        }
    }
}
 b5c:	d503201f 	nop
 b60:	d503201f 	nop
 b64:	a8cf7bfd 	ldp	x29, x30, [sp], #240
 b68:	d65f03c0 	ret

0000000000000b6c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b6c:	d10083ff 	sub	sp, sp, #0x20
 b70:	f90007e0 	str	x0, [sp, #8]
    Header *bp, *p;
    
    bp = (Header*)ap - 1;
 b74:	f94007e0 	ldr	x0, [sp, #8]
 b78:	d1004000 	sub	x0, x0, #0x10
 b7c:	f9000be0 	str	x0, [sp, #16]
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b80:	90000000 	adrp	x0, 0 <main>
 b84:	913c8000 	add	x0, x0, #0xf20
 b88:	f9400000 	ldr	x0, [x0]
 b8c:	f9000fe0 	str	x0, [sp, #24]
 b90:	14000012 	b	bd8 <free+0x6c>
        if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b94:	f9400fe0 	ldr	x0, [sp, #24]
 b98:	f9400000 	ldr	x0, [x0]
 b9c:	f9400fe1 	ldr	x1, [sp, #24]
 ba0:	eb00003f 	cmp	x1, x0
 ba4:	54000143 	b.cc	bcc <free+0x60>  // b.lo, b.ul, b.last
 ba8:	f9400be1 	ldr	x1, [sp, #16]
 bac:	f9400fe0 	ldr	x0, [sp, #24]
 bb0:	eb00003f 	cmp	x1, x0
 bb4:	54000248 	b.hi	bfc <free+0x90>  // b.pmore
 bb8:	f9400fe0 	ldr	x0, [sp, #24]
 bbc:	f9400000 	ldr	x0, [x0]
 bc0:	f9400be1 	ldr	x1, [sp, #16]
 bc4:	eb00003f 	cmp	x1, x0
 bc8:	540001a3 	b.cc	bfc <free+0x90>  // b.lo, b.ul, b.last
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bcc:	f9400fe0 	ldr	x0, [sp, #24]
 bd0:	f9400000 	ldr	x0, [x0]
 bd4:	f9000fe0 	str	x0, [sp, #24]
 bd8:	f9400be1 	ldr	x1, [sp, #16]
 bdc:	f9400fe0 	ldr	x0, [sp, #24]
 be0:	eb00003f 	cmp	x1, x0
 be4:	54fffd89 	b.ls	b94 <free+0x28>  // b.plast
 be8:	f9400fe0 	ldr	x0, [sp, #24]
 bec:	f9400000 	ldr	x0, [x0]
 bf0:	f9400be1 	ldr	x1, [sp, #16]
 bf4:	eb00003f 	cmp	x1, x0
 bf8:	54fffce2 	b.cs	b94 <free+0x28>  // b.hs, b.nlast
            break;
    if(bp + bp->s.size == p->s.ptr){
 bfc:	f9400be0 	ldr	x0, [sp, #16]
 c00:	b9400800 	ldr	w0, [x0, #8]
 c04:	2a0003e0 	mov	w0, w0
 c08:	d37cec00 	lsl	x0, x0, #4
 c0c:	f9400be1 	ldr	x1, [sp, #16]
 c10:	8b000021 	add	x1, x1, x0
 c14:	f9400fe0 	ldr	x0, [sp, #24]
 c18:	f9400000 	ldr	x0, [x0]
 c1c:	eb00003f 	cmp	x1, x0
 c20:	540001e1 	b.ne	c5c <free+0xf0>  // b.any
        bp->s.size += p->s.ptr->s.size;
 c24:	f9400be0 	ldr	x0, [sp, #16]
 c28:	b9400801 	ldr	w1, [x0, #8]
 c2c:	f9400fe0 	ldr	x0, [sp, #24]
 c30:	f9400000 	ldr	x0, [x0]
 c34:	b9400800 	ldr	w0, [x0, #8]
 c38:	0b000021 	add	w1, w1, w0
 c3c:	f9400be0 	ldr	x0, [sp, #16]
 c40:	b9000801 	str	w1, [x0, #8]
        bp->s.ptr = p->s.ptr->s.ptr;
 c44:	f9400fe0 	ldr	x0, [sp, #24]
 c48:	f9400000 	ldr	x0, [x0]
 c4c:	f9400001 	ldr	x1, [x0]
 c50:	f9400be0 	ldr	x0, [sp, #16]
 c54:	f9000001 	str	x1, [x0]
 c58:	14000005 	b	c6c <free+0x100>
    } else
        bp->s.ptr = p->s.ptr;
 c5c:	f9400fe0 	ldr	x0, [sp, #24]
 c60:	f9400001 	ldr	x1, [x0]
 c64:	f9400be0 	ldr	x0, [sp, #16]
 c68:	f9000001 	str	x1, [x0]
    if(p + p->s.size == bp){
 c6c:	f9400fe0 	ldr	x0, [sp, #24]
 c70:	b9400800 	ldr	w0, [x0, #8]
 c74:	2a0003e0 	mov	w0, w0
 c78:	d37cec00 	lsl	x0, x0, #4
 c7c:	f9400fe1 	ldr	x1, [sp, #24]
 c80:	8b000020 	add	x0, x1, x0
 c84:	f9400be1 	ldr	x1, [sp, #16]
 c88:	eb00003f 	cmp	x1, x0
 c8c:	540001a1 	b.ne	cc0 <free+0x154>  // b.any
        p->s.size += bp->s.size;
 c90:	f9400fe0 	ldr	x0, [sp, #24]
 c94:	b9400801 	ldr	w1, [x0, #8]
 c98:	f9400be0 	ldr	x0, [sp, #16]
 c9c:	b9400800 	ldr	w0, [x0, #8]
 ca0:	0b000021 	add	w1, w1, w0
 ca4:	f9400fe0 	ldr	x0, [sp, #24]
 ca8:	b9000801 	str	w1, [x0, #8]
        p->s.ptr = bp->s.ptr;
 cac:	f9400be0 	ldr	x0, [sp, #16]
 cb0:	f9400001 	ldr	x1, [x0]
 cb4:	f9400fe0 	ldr	x0, [sp, #24]
 cb8:	f9000001 	str	x1, [x0]
 cbc:	14000004 	b	ccc <free+0x160>
    } else
        p->s.ptr = bp;
 cc0:	f9400fe0 	ldr	x0, [sp, #24]
 cc4:	f9400be1 	ldr	x1, [sp, #16]
 cc8:	f9000001 	str	x1, [x0]
    freep = p;
 ccc:	90000000 	adrp	x0, 0 <main>
 cd0:	913c8000 	add	x0, x0, #0xf20
 cd4:	f9400fe1 	ldr	x1, [sp, #24]
 cd8:	f9000001 	str	x1, [x0]
}
 cdc:	d503201f 	nop
 ce0:	910083ff 	add	sp, sp, #0x20
 ce4:	d65f03c0 	ret

0000000000000ce8 <morecore>:

static Header*
morecore(uint nu)
{
 ce8:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 cec:	910003fd 	mov	x29, sp
 cf0:	b9001fe0 	str	w0, [sp, #28]
    char *p;
    Header *hp;
    
    if(nu < 4096)
 cf4:	b9401fe0 	ldr	w0, [sp, #28]
 cf8:	713ffc1f 	cmp	w0, #0xfff
 cfc:	54000068 	b.hi	d08 <morecore+0x20>  // b.pmore
        nu = 4096;
 d00:	52820000 	mov	w0, #0x1000                	// #4096
 d04:	b9001fe0 	str	w0, [sp, #28]
    p = sbrk(nu * sizeof(Header));
 d08:	b9401fe0 	ldr	w0, [sp, #28]
 d0c:	531c6c00 	lsl	w0, w0, #4
 d10:	97fffe92 	bl	758 <sbrk>
 d14:	f90017e0 	str	x0, [sp, #40]
    if(p == (char*)-1)
 d18:	f94017e0 	ldr	x0, [sp, #40]
 d1c:	b100041f 	cmn	x0, #0x1
 d20:	54000061 	b.ne	d2c <morecore+0x44>  // b.any
        return 0;
 d24:	d2800000 	mov	x0, #0x0                   	// #0
 d28:	1400000c 	b	d58 <morecore+0x70>
    hp = (Header*)p;
 d2c:	f94017e0 	ldr	x0, [sp, #40]
 d30:	f90013e0 	str	x0, [sp, #32]
    hp->s.size = nu;
 d34:	f94013e0 	ldr	x0, [sp, #32]
 d38:	b9401fe1 	ldr	w1, [sp, #28]
 d3c:	b9000801 	str	w1, [x0, #8]
    free((void*)(hp + 1));
 d40:	f94013e0 	ldr	x0, [sp, #32]
 d44:	91004000 	add	x0, x0, #0x10
 d48:	97ffff89 	bl	b6c <free>
    return freep;
 d4c:	90000000 	adrp	x0, 0 <main>
 d50:	913c8000 	add	x0, x0, #0xf20
 d54:	f9400000 	ldr	x0, [x0]
}
 d58:	a8c37bfd 	ldp	x29, x30, [sp], #48
 d5c:	d65f03c0 	ret

0000000000000d60 <malloc>:

void*
malloc(uint nbytes)
{
 d60:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 d64:	910003fd 	mov	x29, sp
 d68:	b9001fe0 	str	w0, [sp, #28]
    Header *p, *prevp;
    uint nunits;
    
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d6c:	b9401fe0 	ldr	w0, [sp, #28]
 d70:	91003c00 	add	x0, x0, #0xf
 d74:	d344fc00 	lsr	x0, x0, #4
 d78:	11000400 	add	w0, w0, #0x1
 d7c:	b9002fe0 	str	w0, [sp, #44]
    if((prevp = freep) == 0){
 d80:	90000000 	adrp	x0, 0 <main>
 d84:	913c8000 	add	x0, x0, #0xf20
 d88:	f9400000 	ldr	x0, [x0]
 d8c:	f9001be0 	str	x0, [sp, #48]
 d90:	f9401be0 	ldr	x0, [sp, #48]
 d94:	f100001f 	cmp	x0, #0x0
 d98:	54000221 	b.ne	ddc <malloc+0x7c>  // b.any
        base.s.ptr = freep = prevp = &base;
 d9c:	90000000 	adrp	x0, 0 <main>
 da0:	913c4000 	add	x0, x0, #0xf10
 da4:	f9001be0 	str	x0, [sp, #48]
 da8:	90000000 	adrp	x0, 0 <main>
 dac:	913c8000 	add	x0, x0, #0xf20
 db0:	f9401be1 	ldr	x1, [sp, #48]
 db4:	f9000001 	str	x1, [x0]
 db8:	90000000 	adrp	x0, 0 <main>
 dbc:	913c8000 	add	x0, x0, #0xf20
 dc0:	f9400001 	ldr	x1, [x0]
 dc4:	90000000 	adrp	x0, 0 <main>
 dc8:	913c4000 	add	x0, x0, #0xf10
 dcc:	f9000001 	str	x1, [x0]
        base.s.size = 0;
 dd0:	90000000 	adrp	x0, 0 <main>
 dd4:	913c4000 	add	x0, x0, #0xf10
 dd8:	b900081f 	str	wzr, [x0, #8]
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ddc:	f9401be0 	ldr	x0, [sp, #48]
 de0:	f9400000 	ldr	x0, [x0]
 de4:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
 de8:	f9401fe0 	ldr	x0, [sp, #56]
 dec:	b9400800 	ldr	w0, [x0, #8]
 df0:	b9402fe1 	ldr	w1, [sp, #44]
 df4:	6b00003f 	cmp	w1, w0
 df8:	54000448 	b.hi	e80 <malloc+0x120>  // b.pmore
            if(p->s.size == nunits)
 dfc:	f9401fe0 	ldr	x0, [sp, #56]
 e00:	b9400800 	ldr	w0, [x0, #8]
 e04:	b9402fe1 	ldr	w1, [sp, #44]
 e08:	6b00003f 	cmp	w1, w0
 e0c:	540000c1 	b.ne	e24 <malloc+0xc4>  // b.any
                prevp->s.ptr = p->s.ptr;
 e10:	f9401fe0 	ldr	x0, [sp, #56]
 e14:	f9400001 	ldr	x1, [x0]
 e18:	f9401be0 	ldr	x0, [sp, #48]
 e1c:	f9000001 	str	x1, [x0]
 e20:	14000011 	b	e64 <malloc+0x104>
            else {
                p->s.size -= nunits;
 e24:	f9401fe0 	ldr	x0, [sp, #56]
 e28:	b9400801 	ldr	w1, [x0, #8]
 e2c:	b9402fe0 	ldr	w0, [sp, #44]
 e30:	4b000021 	sub	w1, w1, w0
 e34:	f9401fe0 	ldr	x0, [sp, #56]
 e38:	b9000801 	str	w1, [x0, #8]
                p += p->s.size;
 e3c:	f9401fe0 	ldr	x0, [sp, #56]
 e40:	b9400800 	ldr	w0, [x0, #8]
 e44:	2a0003e0 	mov	w0, w0
 e48:	d37cec00 	lsl	x0, x0, #4
 e4c:	f9401fe1 	ldr	x1, [sp, #56]
 e50:	8b000020 	add	x0, x1, x0
 e54:	f9001fe0 	str	x0, [sp, #56]
                p->s.size = nunits;
 e58:	f9401fe0 	ldr	x0, [sp, #56]
 e5c:	b9402fe1 	ldr	w1, [sp, #44]
 e60:	b9000801 	str	w1, [x0, #8]
            }
            freep = prevp;
 e64:	90000000 	adrp	x0, 0 <main>
 e68:	913c8000 	add	x0, x0, #0xf20
 e6c:	f9401be1 	ldr	x1, [sp, #48]
 e70:	f9000001 	str	x1, [x0]
            return (void*)(p + 1);
 e74:	f9401fe0 	ldr	x0, [sp, #56]
 e78:	91004000 	add	x0, x0, #0x10
 e7c:	14000015 	b	ed0 <malloc+0x170>
        }
        if(p == freep)
 e80:	90000000 	adrp	x0, 0 <main>
 e84:	913c8000 	add	x0, x0, #0xf20
 e88:	f9400000 	ldr	x0, [x0]
 e8c:	f9401fe1 	ldr	x1, [sp, #56]
 e90:	eb00003f 	cmp	x1, x0
 e94:	54000121 	b.ne	eb8 <malloc+0x158>  // b.any
            if((p = morecore(nunits)) == 0)
 e98:	b9402fe0 	ldr	w0, [sp, #44]
 e9c:	97ffff93 	bl	ce8 <morecore>
 ea0:	f9001fe0 	str	x0, [sp, #56]
 ea4:	f9401fe0 	ldr	x0, [sp, #56]
 ea8:	f100001f 	cmp	x0, #0x0
 eac:	54000061 	b.ne	eb8 <malloc+0x158>  // b.any
                return 0;
 eb0:	d2800000 	mov	x0, #0x0                   	// #0
 eb4:	14000007 	b	ed0 <malloc+0x170>
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 eb8:	f9401fe0 	ldr	x0, [sp, #56]
 ebc:	f9001be0 	str	x0, [sp, #48]
 ec0:	f9401fe0 	ldr	x0, [sp, #56]
 ec4:	f9400000 	ldr	x0, [x0]
 ec8:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
 ecc:	17ffffc7 	b	de8 <malloc+0x88>
    }
}
 ed0:	a8c47bfd 	ldp	x29, x30, [sp], #64
 ed4:	d65f03c0 	ret
