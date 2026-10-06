
_info:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <main>:
#include "user.h"
#include "fcntl.h"

int
main(void)
{
   0:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
   4:	910003fd 	mov	x29, sp
    printf(1, "Size of char:  %d byte%s\n", sizeof(char), sizeof(char) > 1 ? "s" : "");
   8:	90000000 	adrp	x0, 0 <main>
   c:	913b2003 	add	x3, x0, #0xec8
  10:	d2800022 	mov	x2, #0x1                   	// #1
  14:	90000000 	adrp	x0, 0 <main>
  18:	913b4001 	add	x1, x0, #0xed0
  1c:	52800020 	mov	w0, #0x1                   	// #1
  20:	94000238 	bl	900 <printf>
    printf(1, "Size of short: %d byte%s\n", sizeof(short), sizeof(short) > 1 ? "s" : "");
  24:	90000000 	adrp	x0, 0 <main>
  28:	913bc003 	add	x3, x0, #0xef0
  2c:	d2800042 	mov	x2, #0x2                   	// #2
  30:	90000000 	adrp	x0, 0 <main>
  34:	913be001 	add	x1, x0, #0xef8
  38:	52800020 	mov	w0, #0x1                   	// #1
  3c:	94000231 	bl	900 <printf>
    printf(1, "Size of int:   %d byte%s\n", sizeof(int), sizeof(int) > 1 ? "s" : "");
  40:	90000000 	adrp	x0, 0 <main>
  44:	913bc003 	add	x3, x0, #0xef0
  48:	d2800082 	mov	x2, #0x4                   	// #4
  4c:	90000000 	adrp	x0, 0 <main>
  50:	913c6001 	add	x1, x0, #0xf18
  54:	52800020 	mov	w0, #0x1                   	// #1
  58:	9400022a 	bl	900 <printf>
    printf(1, "Size of long:  %d byte%s\n", sizeof(long), sizeof(long) > 1 ? "s" : "");
  5c:	90000000 	adrp	x0, 0 <main>
  60:	913bc003 	add	x3, x0, #0xef0
  64:	d2800102 	mov	x2, #0x8                   	// #8
  68:	90000000 	adrp	x0, 0 <main>
  6c:	913ce001 	add	x1, x0, #0xf38
  70:	52800020 	mov	w0, #0x1                   	// #1
  74:	94000223 	bl	900 <printf>
    exit();
  78:	9400011b 	bl	4e4 <exit>

000000000000007c <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  7c:	d10083ff 	sub	sp, sp, #0x20
  80:	f90007e0 	str	x0, [sp, #8]
  84:	f90003e1 	str	x1, [sp]
    char *os;
    
    os = s;
  88:	f94007e0 	ldr	x0, [sp, #8]
  8c:	f9000fe0 	str	x0, [sp, #24]
    while((*s++ = *t++) != 0)
  90:	d503201f 	nop
  94:	f94003e1 	ldr	x1, [sp]
  98:	91000420 	add	x0, x1, #0x1
  9c:	f90003e0 	str	x0, [sp]
  a0:	f94007e0 	ldr	x0, [sp, #8]
  a4:	91000402 	add	x2, x0, #0x1
  a8:	f90007e2 	str	x2, [sp, #8]
  ac:	39400021 	ldrb	w1, [x1]
  b0:	39000001 	strb	w1, [x0]
  b4:	39400000 	ldrb	w0, [x0]
  b8:	7100001f 	cmp	w0, #0x0
  bc:	54fffec1 	b.ne	94 <strcpy+0x18>  // b.any
        ;
    return os;
  c0:	f9400fe0 	ldr	x0, [sp, #24]
}
  c4:	910083ff 	add	sp, sp, #0x20
  c8:	d65f03c0 	ret

00000000000000cc <strcmp>:

int
strcmp(const char *p, const char *q)
{
  cc:	d10043ff 	sub	sp, sp, #0x10
  d0:	f90007e0 	str	x0, [sp, #8]
  d4:	f90003e1 	str	x1, [sp]
    while(*p && *p == *q)
  d8:	14000007 	b	f4 <strcmp+0x28>
        p++, q++;
  dc:	f94007e0 	ldr	x0, [sp, #8]
  e0:	91000400 	add	x0, x0, #0x1
  e4:	f90007e0 	str	x0, [sp, #8]
  e8:	f94003e0 	ldr	x0, [sp]
  ec:	91000400 	add	x0, x0, #0x1
  f0:	f90003e0 	str	x0, [sp]
    while(*p && *p == *q)
  f4:	f94007e0 	ldr	x0, [sp, #8]
  f8:	39400000 	ldrb	w0, [x0]
  fc:	7100001f 	cmp	w0, #0x0
 100:	540000e0 	b.eq	11c <strcmp+0x50>  // b.none
 104:	f94007e0 	ldr	x0, [sp, #8]
 108:	39400001 	ldrb	w1, [x0]
 10c:	f94003e0 	ldr	x0, [sp]
 110:	39400000 	ldrb	w0, [x0]
 114:	6b00003f 	cmp	w1, w0
 118:	54fffe20 	b.eq	dc <strcmp+0x10>  // b.none
    return (uchar)*p - (uchar)*q;
 11c:	f94007e0 	ldr	x0, [sp, #8]
 120:	39400000 	ldrb	w0, [x0]
 124:	2a0003e1 	mov	w1, w0
 128:	f94003e0 	ldr	x0, [sp]
 12c:	39400000 	ldrb	w0, [x0]
 130:	4b000020 	sub	w0, w1, w0
}
 134:	910043ff 	add	sp, sp, #0x10
 138:	d65f03c0 	ret

000000000000013c <strlen>:

uint
strlen(char *s)
{
 13c:	d10083ff 	sub	sp, sp, #0x20
 140:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    for(n = 0; s[n]; n++)
 144:	b9001fff 	str	wzr, [sp, #28]
 148:	14000004 	b	158 <strlen+0x1c>
 14c:	b9401fe0 	ldr	w0, [sp, #28]
 150:	11000400 	add	w0, w0, #0x1
 154:	b9001fe0 	str	w0, [sp, #28]
 158:	b9801fe0 	ldrsw	x0, [sp, #28]
 15c:	f94007e1 	ldr	x1, [sp, #8]
 160:	8b000020 	add	x0, x1, x0
 164:	39400000 	ldrb	w0, [x0]
 168:	7100001f 	cmp	w0, #0x0
 16c:	54ffff01 	b.ne	14c <strlen+0x10>  // b.any
        ;
    return n;
 170:	b9401fe0 	ldr	w0, [sp, #28]
}
 174:	910083ff 	add	sp, sp, #0x20
 178:	d65f03c0 	ret

000000000000017c <memset>:

void*
memset(void *dst, int v, uint n)
{
 17c:	d100c3ff 	sub	sp, sp, #0x30
 180:	f90007e0 	str	x0, [sp, #8]
 184:	b90007e1 	str	w1, [sp, #4]
 188:	b90003e2 	str	w2, [sp]
	uint8	*p;
	uint8	c;
	uint32	val;
	uint32	*p4;

	p   = dst;
 18c:	f94007e0 	ldr	x0, [sp, #8]
 190:	f90017e0 	str	x0, [sp, #40]
	c   = v & 0xff;
 194:	b94007e0 	ldr	w0, [sp, #4]
 198:	39007fe0 	strb	w0, [sp, #31]
	val = (c << 24) | (c << 16) | (c << 8) | c;
 19c:	39407fe1 	ldrb	w1, [sp, #31]
 1a0:	2a0103e0 	mov	w0, w1
 1a4:	53185c00 	lsl	w0, w0, #8
 1a8:	0b010000 	add	w0, w0, w1
 1ac:	53103c00 	lsl	w0, w0, #16
 1b0:	2a0003e1 	mov	w1, w0
 1b4:	39407fe0 	ldrb	w0, [sp, #31]
 1b8:	53185c00 	lsl	w0, w0, #8
 1bc:	2a000021 	orr	w1, w1, w0
 1c0:	39407fe0 	ldrb	w0, [sp, #31]
 1c4:	2a000020 	orr	w0, w1, w0
 1c8:	b9001be0 	str	w0, [sp, #24]

	// set bytes before whole uint32
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
 1cc:	1400000a 	b	1f4 <memset+0x78>
		*p = c;
 1d0:	f94017e0 	ldr	x0, [sp, #40]
 1d4:	39407fe1 	ldrb	w1, [sp, #31]
 1d8:	39000001 	strb	w1, [x0]
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
 1dc:	b94003e0 	ldr	w0, [sp]
 1e0:	51000400 	sub	w0, w0, #0x1
 1e4:	b90003e0 	str	w0, [sp]
 1e8:	f94017e0 	ldr	x0, [sp, #40]
 1ec:	91000400 	add	x0, x0, #0x1
 1f0:	f90017e0 	str	x0, [sp, #40]
 1f4:	b94003e0 	ldr	w0, [sp]
 1f8:	7100001f 	cmp	w0, #0x0
 1fc:	540000a0 	b.eq	210 <memset+0x94>  // b.none
 200:	f94017e0 	ldr	x0, [sp, #40]
 204:	92400400 	and	x0, x0, #0x3
 208:	f100001f 	cmp	x0, #0x0
 20c:	54fffe21 	b.ne	1d0 <memset+0x54>  // b.any
	}

	// set memory 4 bytes a time
	p4 = (uint*)p;
 210:	f94017e0 	ldr	x0, [sp, #40]
 214:	f90013e0 	str	x0, [sp, #32]

	for (; n >= 4; n -= 4, p4++) {
 218:	1400000a 	b	240 <memset+0xc4>
		*p4 = val;
 21c:	f94013e0 	ldr	x0, [sp, #32]
 220:	b9401be1 	ldr	w1, [sp, #24]
 224:	b9000001 	str	w1, [x0]
	for (; n >= 4; n -= 4, p4++) {
 228:	b94003e0 	ldr	w0, [sp]
 22c:	51001000 	sub	w0, w0, #0x4
 230:	b90003e0 	str	w0, [sp]
 234:	f94013e0 	ldr	x0, [sp, #32]
 238:	91001000 	add	x0, x0, #0x4
 23c:	f90013e0 	str	x0, [sp, #32]
 240:	b94003e0 	ldr	w0, [sp]
 244:	71000c1f 	cmp	w0, #0x3
 248:	54fffea8 	b.hi	21c <memset+0xa0>  // b.pmore
	}

	// set leftover one byte a time
	p = (uint8*)p4;
 24c:	f94013e0 	ldr	x0, [sp, #32]
 250:	f90017e0 	str	x0, [sp, #40]

	for (; n > 0; n--, p++) {
 254:	1400000a 	b	27c <memset+0x100>
		*p = c;
 258:	f94017e0 	ldr	x0, [sp, #40]
 25c:	39407fe1 	ldrb	w1, [sp, #31]
 260:	39000001 	strb	w1, [x0]
	for (; n > 0; n--, p++) {
 264:	b94003e0 	ldr	w0, [sp]
 268:	51000400 	sub	w0, w0, #0x1
 26c:	b90003e0 	str	w0, [sp]
 270:	f94017e0 	ldr	x0, [sp, #40]
 274:	91000400 	add	x0, x0, #0x1
 278:	f90017e0 	str	x0, [sp, #40]
 27c:	b94003e0 	ldr	w0, [sp]
 280:	7100001f 	cmp	w0, #0x0
 284:	54fffea1 	b.ne	258 <memset+0xdc>  // b.any
	}

	return dst;
 288:	f94007e0 	ldr	x0, [sp, #8]
}
 28c:	9100c3ff 	add	sp, sp, #0x30
 290:	d65f03c0 	ret

0000000000000294 <strchr>:

char*
strchr(const char *s, char c)
{
 294:	d10043ff 	sub	sp, sp, #0x10
 298:	f90007e0 	str	x0, [sp, #8]
 29c:	39001fe1 	strb	w1, [sp, #7]
    for(; *s; s++)
 2a0:	1400000b 	b	2cc <strchr+0x38>
        if(*s == c)
 2a4:	f94007e0 	ldr	x0, [sp, #8]
 2a8:	39400000 	ldrb	w0, [x0]
 2ac:	39401fe1 	ldrb	w1, [sp, #7]
 2b0:	6b00003f 	cmp	w1, w0
 2b4:	54000061 	b.ne	2c0 <strchr+0x2c>  // b.any
            return (char*)s;
 2b8:	f94007e0 	ldr	x0, [sp, #8]
 2bc:	14000009 	b	2e0 <strchr+0x4c>
    for(; *s; s++)
 2c0:	f94007e0 	ldr	x0, [sp, #8]
 2c4:	91000400 	add	x0, x0, #0x1
 2c8:	f90007e0 	str	x0, [sp, #8]
 2cc:	f94007e0 	ldr	x0, [sp, #8]
 2d0:	39400000 	ldrb	w0, [x0]
 2d4:	7100001f 	cmp	w0, #0x0
 2d8:	54fffe61 	b.ne	2a4 <strchr+0x10>  // b.any
    return 0;
 2dc:	d2800000 	mov	x0, #0x0                   	// #0
}
 2e0:	910043ff 	add	sp, sp, #0x10
 2e4:	d65f03c0 	ret

00000000000002e8 <gets>:

char*
gets(char *buf, int max)
{
 2e8:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 2ec:	910003fd 	mov	x29, sp
 2f0:	f9000fe0 	str	x0, [sp, #24]
 2f4:	b90017e1 	str	w1, [sp, #20]
    int i, cc;
    char c;
    
    for(i=0; i+1 < max; ){
 2f8:	b9002fff 	str	wzr, [sp, #44]
 2fc:	14000018 	b	35c <gets+0x74>
        cc = read(0, &c, 1);
 300:	91009fe0 	add	x0, sp, #0x27
 304:	52800022 	mov	w2, #0x1                   	// #1
 308:	aa0003e1 	mov	x1, x0
 30c:	52800000 	mov	w0, #0x0                   	// #0
 310:	94000090 	bl	550 <read>
 314:	b9002be0 	str	w0, [sp, #40]
        if(cc < 1)
 318:	b9402be0 	ldr	w0, [sp, #40]
 31c:	7100001f 	cmp	w0, #0x0
 320:	540002ad 	b.le	374 <gets+0x8c>
            break;
        buf[i++] = c;
 324:	b9402fe0 	ldr	w0, [sp, #44]
 328:	11000401 	add	w1, w0, #0x1
 32c:	b9002fe1 	str	w1, [sp, #44]
 330:	93407c00 	sxtw	x0, w0
 334:	f9400fe1 	ldr	x1, [sp, #24]
 338:	8b000020 	add	x0, x1, x0
 33c:	39409fe1 	ldrb	w1, [sp, #39]
 340:	39000001 	strb	w1, [x0]
        if(c == '\n' || c == '\r')
 344:	39409fe0 	ldrb	w0, [sp, #39]
 348:	7100281f 	cmp	w0, #0xa
 34c:	54000160 	b.eq	378 <gets+0x90>  // b.none
 350:	39409fe0 	ldrb	w0, [sp, #39]
 354:	7100341f 	cmp	w0, #0xd
 358:	54000100 	b.eq	378 <gets+0x90>  // b.none
    for(i=0; i+1 < max; ){
 35c:	b9402fe0 	ldr	w0, [sp, #44]
 360:	11000400 	add	w0, w0, #0x1
 364:	b94017e1 	ldr	w1, [sp, #20]
 368:	6b00003f 	cmp	w1, w0
 36c:	54fffcac 	b.gt	300 <gets+0x18>
 370:	14000002 	b	378 <gets+0x90>
            break;
 374:	d503201f 	nop
            break;
    }
    buf[i] = '\0';
 378:	b9802fe0 	ldrsw	x0, [sp, #44]
 37c:	f9400fe1 	ldr	x1, [sp, #24]
 380:	8b000020 	add	x0, x1, x0
 384:	3900001f 	strb	wzr, [x0]
    return buf;
 388:	f9400fe0 	ldr	x0, [sp, #24]
}
 38c:	a8c37bfd 	ldp	x29, x30, [sp], #48
 390:	d65f03c0 	ret

0000000000000394 <stat>:

int
stat(char *n, struct stat *st)
{
 394:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 398:	910003fd 	mov	x29, sp
 39c:	f9000fe0 	str	x0, [sp, #24]
 3a0:	f9000be1 	str	x1, [sp, #16]
    int fd;
    int r;
    
    fd = open(n, O_RDONLY);
 3a4:	52800001 	mov	w1, #0x0                   	// #0
 3a8:	f9400fe0 	ldr	x0, [sp, #24]
 3ac:	94000096 	bl	604 <open>
 3b0:	b9002fe0 	str	w0, [sp, #44]
    if(fd < 0)
 3b4:	b9402fe0 	ldr	w0, [sp, #44]
 3b8:	7100001f 	cmp	w0, #0x0
 3bc:	5400006a 	b.ge	3c8 <stat+0x34>  // b.tcont
        return -1;
 3c0:	12800000 	mov	w0, #0xffffffff            	// #-1
 3c4:	14000008 	b	3e4 <stat+0x50>
    r = fstat(fd, st);
 3c8:	f9400be1 	ldr	x1, [sp, #16]
 3cc:	b9402fe0 	ldr	w0, [sp, #44]
 3d0:	940000a8 	bl	670 <fstat>
 3d4:	b9002be0 	str	w0, [sp, #40]
    close(fd);
 3d8:	b9402fe0 	ldr	w0, [sp, #44]
 3dc:	9400006f 	bl	598 <close>
    return r;
 3e0:	b9402be0 	ldr	w0, [sp, #40]
}
 3e4:	a8c37bfd 	ldp	x29, x30, [sp], #48
 3e8:	d65f03c0 	ret

00000000000003ec <atoi>:

int
atoi(const char *s)
{
 3ec:	d10083ff 	sub	sp, sp, #0x20
 3f0:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    n = 0;
 3f4:	b9001fff 	str	wzr, [sp, #28]
    while('0' <= *s && *s <= '9')
 3f8:	1400000e 	b	430 <atoi+0x44>
        n = n*10 + *s++ - '0';
 3fc:	b9401fe1 	ldr	w1, [sp, #28]
 400:	2a0103e0 	mov	w0, w1
 404:	531e7400 	lsl	w0, w0, #2
 408:	0b010000 	add	w0, w0, w1
 40c:	531f7800 	lsl	w0, w0, #1
 410:	2a0003e2 	mov	w2, w0
 414:	f94007e0 	ldr	x0, [sp, #8]
 418:	91000401 	add	x1, x0, #0x1
 41c:	f90007e1 	str	x1, [sp, #8]
 420:	39400000 	ldrb	w0, [x0]
 424:	0b000040 	add	w0, w2, w0
 428:	5100c000 	sub	w0, w0, #0x30
 42c:	b9001fe0 	str	w0, [sp, #28]
    while('0' <= *s && *s <= '9')
 430:	f94007e0 	ldr	x0, [sp, #8]
 434:	39400000 	ldrb	w0, [x0]
 438:	7100bc1f 	cmp	w0, #0x2f
 43c:	540000a9 	b.ls	450 <atoi+0x64>  // b.plast
 440:	f94007e0 	ldr	x0, [sp, #8]
 444:	39400000 	ldrb	w0, [x0]
 448:	7100e41f 	cmp	w0, #0x39
 44c:	54fffd89 	b.ls	3fc <atoi+0x10>  // b.plast
    return n;
 450:	b9401fe0 	ldr	w0, [sp, #28]
}
 454:	910083ff 	add	sp, sp, #0x20
 458:	d65f03c0 	ret

000000000000045c <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 45c:	d100c3ff 	sub	sp, sp, #0x30
 460:	f9000fe0 	str	x0, [sp, #24]
 464:	f9000be1 	str	x1, [sp, #16]
 468:	b9000fe2 	str	w2, [sp, #12]
    char *dst, *src;
    
    dst = vdst;
 46c:	f9400fe0 	ldr	x0, [sp, #24]
 470:	f90017e0 	str	x0, [sp, #40]
    src = vsrc;
 474:	f9400be0 	ldr	x0, [sp, #16]
 478:	f90013e0 	str	x0, [sp, #32]
    while(n-- > 0)
 47c:	14000009 	b	4a0 <memmove+0x44>
        *dst++ = *src++;
 480:	f94013e1 	ldr	x1, [sp, #32]
 484:	91000420 	add	x0, x1, #0x1
 488:	f90013e0 	str	x0, [sp, #32]
 48c:	f94017e0 	ldr	x0, [sp, #40]
 490:	91000402 	add	x2, x0, #0x1
 494:	f90017e2 	str	x2, [sp, #40]
 498:	39400021 	ldrb	w1, [x1]
 49c:	39000001 	strb	w1, [x0]
    while(n-- > 0)
 4a0:	b9400fe0 	ldr	w0, [sp, #12]
 4a4:	51000401 	sub	w1, w0, #0x1
 4a8:	b9000fe1 	str	w1, [sp, #12]
 4ac:	7100001f 	cmp	w0, #0x0
 4b0:	54fffe8c 	b.gt	480 <memmove+0x24>
    return vdst;
 4b4:	f9400fe0 	ldr	x0, [sp, #24]
}
 4b8:	9100c3ff 	add	sp, sp, #0x30
 4bc:	d65f03c0 	ret

00000000000004c0 <fork>:
 4c0:	f81f8fe4 	str	x4, [sp, #-8]!
 4c4:	aa0303e4 	mov	x4, x3
 4c8:	aa0203e3 	mov	x3, x2
 4cc:	aa0103e2 	mov	x2, x1
 4d0:	aa0003e1 	mov	x1, x0
 4d4:	d2800020 	mov	x0, #0x1                   	// #1
 4d8:	d4000001 	svc	#0x0
 4dc:	f84087e4 	ldr	x4, [sp], #8
 4e0:	d61f03c0 	br	x30

00000000000004e4 <exit>:
 4e4:	f81f8fe4 	str	x4, [sp, #-8]!
 4e8:	aa0303e4 	mov	x4, x3
 4ec:	aa0203e3 	mov	x3, x2
 4f0:	aa0103e2 	mov	x2, x1
 4f4:	aa0003e1 	mov	x1, x0
 4f8:	d2800040 	mov	x0, #0x2                   	// #2
 4fc:	d4000001 	svc	#0x0
 500:	f84087e4 	ldr	x4, [sp], #8
 504:	d61f03c0 	br	x30

0000000000000508 <wait>:
 508:	f81f8fe4 	str	x4, [sp, #-8]!
 50c:	aa0303e4 	mov	x4, x3
 510:	aa0203e3 	mov	x3, x2
 514:	aa0103e2 	mov	x2, x1
 518:	aa0003e1 	mov	x1, x0
 51c:	d2800060 	mov	x0, #0x3                   	// #3
 520:	d4000001 	svc	#0x0
 524:	f84087e4 	ldr	x4, [sp], #8
 528:	d61f03c0 	br	x30

000000000000052c <pipe>:
 52c:	f81f8fe4 	str	x4, [sp, #-8]!
 530:	aa0303e4 	mov	x4, x3
 534:	aa0203e3 	mov	x3, x2
 538:	aa0103e2 	mov	x2, x1
 53c:	aa0003e1 	mov	x1, x0
 540:	d2800080 	mov	x0, #0x4                   	// #4
 544:	d4000001 	svc	#0x0
 548:	f84087e4 	ldr	x4, [sp], #8
 54c:	d61f03c0 	br	x30

0000000000000550 <read>:
 550:	f81f8fe4 	str	x4, [sp, #-8]!
 554:	aa0303e4 	mov	x4, x3
 558:	aa0203e3 	mov	x3, x2
 55c:	aa0103e2 	mov	x2, x1
 560:	aa0003e1 	mov	x1, x0
 564:	d28000a0 	mov	x0, #0x5                   	// #5
 568:	d4000001 	svc	#0x0
 56c:	f84087e4 	ldr	x4, [sp], #8
 570:	d61f03c0 	br	x30

0000000000000574 <write>:
 574:	f81f8fe4 	str	x4, [sp, #-8]!
 578:	aa0303e4 	mov	x4, x3
 57c:	aa0203e3 	mov	x3, x2
 580:	aa0103e2 	mov	x2, x1
 584:	aa0003e1 	mov	x1, x0
 588:	d2800200 	mov	x0, #0x10                  	// #16
 58c:	d4000001 	svc	#0x0
 590:	f84087e4 	ldr	x4, [sp], #8
 594:	d61f03c0 	br	x30

0000000000000598 <close>:
 598:	f81f8fe4 	str	x4, [sp, #-8]!
 59c:	aa0303e4 	mov	x4, x3
 5a0:	aa0203e3 	mov	x3, x2
 5a4:	aa0103e2 	mov	x2, x1
 5a8:	aa0003e1 	mov	x1, x0
 5ac:	d28002a0 	mov	x0, #0x15                  	// #21
 5b0:	d4000001 	svc	#0x0
 5b4:	f84087e4 	ldr	x4, [sp], #8
 5b8:	d61f03c0 	br	x30

00000000000005bc <kill>:
 5bc:	f81f8fe4 	str	x4, [sp, #-8]!
 5c0:	aa0303e4 	mov	x4, x3
 5c4:	aa0203e3 	mov	x3, x2
 5c8:	aa0103e2 	mov	x2, x1
 5cc:	aa0003e1 	mov	x1, x0
 5d0:	d28000c0 	mov	x0, #0x6                   	// #6
 5d4:	d4000001 	svc	#0x0
 5d8:	f84087e4 	ldr	x4, [sp], #8
 5dc:	d61f03c0 	br	x30

00000000000005e0 <exec>:
 5e0:	f81f8fe4 	str	x4, [sp, #-8]!
 5e4:	aa0303e4 	mov	x4, x3
 5e8:	aa0203e3 	mov	x3, x2
 5ec:	aa0103e2 	mov	x2, x1
 5f0:	aa0003e1 	mov	x1, x0
 5f4:	d28000e0 	mov	x0, #0x7                   	// #7
 5f8:	d4000001 	svc	#0x0
 5fc:	f84087e4 	ldr	x4, [sp], #8
 600:	d61f03c0 	br	x30

0000000000000604 <open>:
 604:	f81f8fe4 	str	x4, [sp, #-8]!
 608:	aa0303e4 	mov	x4, x3
 60c:	aa0203e3 	mov	x3, x2
 610:	aa0103e2 	mov	x2, x1
 614:	aa0003e1 	mov	x1, x0
 618:	d28001e0 	mov	x0, #0xf                   	// #15
 61c:	d4000001 	svc	#0x0
 620:	f84087e4 	ldr	x4, [sp], #8
 624:	d61f03c0 	br	x30

0000000000000628 <mknod>:
 628:	f81f8fe4 	str	x4, [sp, #-8]!
 62c:	aa0303e4 	mov	x4, x3
 630:	aa0203e3 	mov	x3, x2
 634:	aa0103e2 	mov	x2, x1
 638:	aa0003e1 	mov	x1, x0
 63c:	d2800220 	mov	x0, #0x11                  	// #17
 640:	d4000001 	svc	#0x0
 644:	f84087e4 	ldr	x4, [sp], #8
 648:	d61f03c0 	br	x30

000000000000064c <unlink>:
 64c:	f81f8fe4 	str	x4, [sp, #-8]!
 650:	aa0303e4 	mov	x4, x3
 654:	aa0203e3 	mov	x3, x2
 658:	aa0103e2 	mov	x2, x1
 65c:	aa0003e1 	mov	x1, x0
 660:	d2800240 	mov	x0, #0x12                  	// #18
 664:	d4000001 	svc	#0x0
 668:	f84087e4 	ldr	x4, [sp], #8
 66c:	d61f03c0 	br	x30

0000000000000670 <fstat>:
 670:	f81f8fe4 	str	x4, [sp, #-8]!
 674:	aa0303e4 	mov	x4, x3
 678:	aa0203e3 	mov	x3, x2
 67c:	aa0103e2 	mov	x2, x1
 680:	aa0003e1 	mov	x1, x0
 684:	d2800100 	mov	x0, #0x8                   	// #8
 688:	d4000001 	svc	#0x0
 68c:	f84087e4 	ldr	x4, [sp], #8
 690:	d61f03c0 	br	x30

0000000000000694 <link>:
 694:	f81f8fe4 	str	x4, [sp, #-8]!
 698:	aa0303e4 	mov	x4, x3
 69c:	aa0203e3 	mov	x3, x2
 6a0:	aa0103e2 	mov	x2, x1
 6a4:	aa0003e1 	mov	x1, x0
 6a8:	d2800260 	mov	x0, #0x13                  	// #19
 6ac:	d4000001 	svc	#0x0
 6b0:	f84087e4 	ldr	x4, [sp], #8
 6b4:	d61f03c0 	br	x30

00000000000006b8 <mkdir>:
 6b8:	f81f8fe4 	str	x4, [sp, #-8]!
 6bc:	aa0303e4 	mov	x4, x3
 6c0:	aa0203e3 	mov	x3, x2
 6c4:	aa0103e2 	mov	x2, x1
 6c8:	aa0003e1 	mov	x1, x0
 6cc:	d2800280 	mov	x0, #0x14                  	// #20
 6d0:	d4000001 	svc	#0x0
 6d4:	f84087e4 	ldr	x4, [sp], #8
 6d8:	d61f03c0 	br	x30

00000000000006dc <chdir>:
 6dc:	f81f8fe4 	str	x4, [sp, #-8]!
 6e0:	aa0303e4 	mov	x4, x3
 6e4:	aa0203e3 	mov	x3, x2
 6e8:	aa0103e2 	mov	x2, x1
 6ec:	aa0003e1 	mov	x1, x0
 6f0:	d2800120 	mov	x0, #0x9                   	// #9
 6f4:	d4000001 	svc	#0x0
 6f8:	f84087e4 	ldr	x4, [sp], #8
 6fc:	d61f03c0 	br	x30

0000000000000700 <dup>:
 700:	f81f8fe4 	str	x4, [sp, #-8]!
 704:	aa0303e4 	mov	x4, x3
 708:	aa0203e3 	mov	x3, x2
 70c:	aa0103e2 	mov	x2, x1
 710:	aa0003e1 	mov	x1, x0
 714:	d2800140 	mov	x0, #0xa                   	// #10
 718:	d4000001 	svc	#0x0
 71c:	f84087e4 	ldr	x4, [sp], #8
 720:	d61f03c0 	br	x30

0000000000000724 <getpid>:
 724:	f81f8fe4 	str	x4, [sp, #-8]!
 728:	aa0303e4 	mov	x4, x3
 72c:	aa0203e3 	mov	x3, x2
 730:	aa0103e2 	mov	x2, x1
 734:	aa0003e1 	mov	x1, x0
 738:	d2800160 	mov	x0, #0xb                   	// #11
 73c:	d4000001 	svc	#0x0
 740:	f84087e4 	ldr	x4, [sp], #8
 744:	d61f03c0 	br	x30

0000000000000748 <sbrk>:
 748:	f81f8fe4 	str	x4, [sp, #-8]!
 74c:	aa0303e4 	mov	x4, x3
 750:	aa0203e3 	mov	x3, x2
 754:	aa0103e2 	mov	x2, x1
 758:	aa0003e1 	mov	x1, x0
 75c:	d2800180 	mov	x0, #0xc                   	// #12
 760:	d4000001 	svc	#0x0
 764:	f84087e4 	ldr	x4, [sp], #8
 768:	d61f03c0 	br	x30

000000000000076c <sleep>:
 76c:	f81f8fe4 	str	x4, [sp, #-8]!
 770:	aa0303e4 	mov	x4, x3
 774:	aa0203e3 	mov	x3, x2
 778:	aa0103e2 	mov	x2, x1
 77c:	aa0003e1 	mov	x1, x0
 780:	d28001a0 	mov	x0, #0xd                   	// #13
 784:	d4000001 	svc	#0x0
 788:	f84087e4 	ldr	x4, [sp], #8
 78c:	d61f03c0 	br	x30

0000000000000790 <uptime>:
 790:	f81f8fe4 	str	x4, [sp, #-8]!
 794:	aa0303e4 	mov	x4, x3
 798:	aa0203e3 	mov	x3, x2
 79c:	aa0103e2 	mov	x2, x1
 7a0:	aa0003e1 	mov	x1, x0
 7a4:	d28001c0 	mov	x0, #0xe                   	// #14
 7a8:	d4000001 	svc	#0x0
 7ac:	f84087e4 	ldr	x4, [sp], #8
 7b0:	d61f03c0 	br	x30

00000000000007b4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 7b4:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
 7b8:	910003fd 	mov	x29, sp
 7bc:	b9001fe0 	str	w0, [sp, #28]
 7c0:	39006fe1 	strb	w1, [sp, #27]
    write(fd, &c, 1);
 7c4:	91006fe0 	add	x0, sp, #0x1b
 7c8:	52800022 	mov	w2, #0x1                   	// #1
 7cc:	aa0003e1 	mov	x1, x0
 7d0:	b9401fe0 	ldr	w0, [sp, #28]
 7d4:	97ffff68 	bl	574 <write>
}
 7d8:	d503201f 	nop
 7dc:	a8c27bfd 	ldp	x29, x30, [sp], #32
 7e0:	d65f03c0 	ret

00000000000007e4 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7e4:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 7e8:	910003fd 	mov	x29, sp
 7ec:	b9001fe0 	str	w0, [sp, #28]
 7f0:	b9001be1 	str	w1, [sp, #24]
 7f4:	b90017e2 	str	w2, [sp, #20]
 7f8:	b90013e3 	str	w3, [sp, #16]
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
 7fc:	b9003bff 	str	wzr, [sp, #56]
    if(sgn && xx < 0){
 800:	b94013e0 	ldr	w0, [sp, #16]
 804:	7100001f 	cmp	w0, #0x0
 808:	54000140 	b.eq	830 <printint+0x4c>  // b.none
 80c:	b9401be0 	ldr	w0, [sp, #24]
 810:	7100001f 	cmp	w0, #0x0
 814:	540000ea 	b.ge	830 <printint+0x4c>  // b.tcont
        neg = 1;
 818:	52800020 	mov	w0, #0x1                   	// #1
 81c:	b9003be0 	str	w0, [sp, #56]
        x = -xx;
 820:	b9401be0 	ldr	w0, [sp, #24]
 824:	4b0003e0 	neg	w0, w0
 828:	b90037e0 	str	w0, [sp, #52]
 82c:	14000003 	b	838 <printint+0x54>
    } else {
        x = xx;
 830:	b9401be0 	ldr	w0, [sp, #24]
 834:	b90037e0 	str	w0, [sp, #52]
    }
    
    i = 0;
 838:	b9003fff 	str	wzr, [sp, #60]
    do{
        buf[i++] = digits[x % base];
 83c:	b94017e1 	ldr	w1, [sp, #20]
 840:	b94037e0 	ldr	w0, [sp, #52]
 844:	1ac10802 	udiv	w2, w0, w1
 848:	1b017c41 	mul	w1, w2, w1
 84c:	4b010003 	sub	w3, w0, w1
 850:	b9403fe0 	ldr	w0, [sp, #60]
 854:	11000401 	add	w1, w0, #0x1
 858:	b9003fe1 	str	w1, [sp, #60]
 85c:	90000001 	adrp	x1, 0 <main>
 860:	913d8022 	add	x2, x1, #0xf60
 864:	2a0303e1 	mov	w1, w3
 868:	38616842 	ldrb	w2, [x2, x1]
 86c:	93407c00 	sxtw	x0, w0
 870:	910083e1 	add	x1, sp, #0x20
 874:	38206822 	strb	w2, [x1, x0]
    }while((x /= base) != 0);
 878:	b94017e0 	ldr	w0, [sp, #20]
 87c:	b94037e1 	ldr	w1, [sp, #52]
 880:	1ac00820 	udiv	w0, w1, w0
 884:	b90037e0 	str	w0, [sp, #52]
 888:	b94037e0 	ldr	w0, [sp, #52]
 88c:	7100001f 	cmp	w0, #0x0
 890:	54fffd61 	b.ne	83c <printint+0x58>  // b.any
    if(neg)
 894:	b9403be0 	ldr	w0, [sp, #56]
 898:	7100001f 	cmp	w0, #0x0
 89c:	540001e0 	b.eq	8d8 <printint+0xf4>  // b.none
        buf[i++] = '-';
 8a0:	b9403fe0 	ldr	w0, [sp, #60]
 8a4:	11000401 	add	w1, w0, #0x1
 8a8:	b9003fe1 	str	w1, [sp, #60]
 8ac:	93407c00 	sxtw	x0, w0
 8b0:	910083e1 	add	x1, sp, #0x20
 8b4:	528005a2 	mov	w2, #0x2d                  	// #45
 8b8:	38206822 	strb	w2, [x1, x0]
    
    while(--i >= 0)
 8bc:	14000007 	b	8d8 <printint+0xf4>
        putc(fd, buf[i]);
 8c0:	b9803fe0 	ldrsw	x0, [sp, #60]
 8c4:	910083e1 	add	x1, sp, #0x20
 8c8:	38606820 	ldrb	w0, [x1, x0]
 8cc:	2a0003e1 	mov	w1, w0
 8d0:	b9401fe0 	ldr	w0, [sp, #28]
 8d4:	97ffffb8 	bl	7b4 <putc>
    while(--i >= 0)
 8d8:	b9403fe0 	ldr	w0, [sp, #60]
 8dc:	51000400 	sub	w0, w0, #0x1
 8e0:	b9003fe0 	str	w0, [sp, #60]
 8e4:	b9403fe0 	ldr	w0, [sp, #60]
 8e8:	7100001f 	cmp	w0, #0x0
 8ec:	54fffeaa 	b.ge	8c0 <printint+0xdc>  // b.tcont
}
 8f0:	d503201f 	nop
 8f4:	d503201f 	nop
 8f8:	a8c47bfd 	ldp	x29, x30, [sp], #64
 8fc:	d65f03c0 	ret

0000000000000900 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 900:	a9b17bfd 	stp	x29, x30, [sp, #-240]!
 904:	910003fd 	mov	x29, sp
 908:	b9001fe0 	str	w0, [sp, #28]
 90c:	f9000be1 	str	x1, [sp, #16]
 910:	f90063e2 	str	x2, [sp, #192]
 914:	f90067e3 	str	x3, [sp, #200]
 918:	f9006be4 	str	x4, [sp, #208]
 91c:	f9006fe5 	str	x5, [sp, #216]
 920:	f90073e6 	str	x6, [sp, #224]
 924:	f90077e7 	str	x7, [sp, #232]
 928:	3d8013e0 	str	q0, [sp, #64]
 92c:	3d8017e1 	str	q1, [sp, #80]
 930:	3d801be2 	str	q2, [sp, #96]
 934:	3d801fe3 	str	q3, [sp, #112]
 938:	3d8023e4 	str	q4, [sp, #128]
 93c:	3d8027e5 	str	q5, [sp, #144]
 940:	3d802be6 	str	q6, [sp, #160]
 944:	3d802fe7 	str	q7, [sp, #176]
    char *s;
    int c, i, state;
    uint64 *ap;
    
    state = 0;
 948:	b90033ff 	str	wzr, [sp, #48]
    ap = (uint64*)(void*)&fmt + 22;
 94c:	910043e0 	add	x0, sp, #0x10
 950:	9102c000 	add	x0, x0, #0xb0
 954:	f90017e0 	str	x0, [sp, #40]
    for(i = 0; fmt[i]; i++){
 958:	b90037ff 	str	wzr, [sp, #52]
 95c:	14000076 	b	b34 <printf+0x234>
        c = fmt[i] & 0xff;
 960:	f9400be1 	ldr	x1, [sp, #16]
 964:	b98037e0 	ldrsw	x0, [sp, #52]
 968:	8b000020 	add	x0, x1, x0
 96c:	39400000 	ldrb	w0, [x0]
 970:	b90027e0 	str	w0, [sp, #36]
        if(state == 0){
 974:	b94033e0 	ldr	w0, [sp, #48]
 978:	7100001f 	cmp	w0, #0x0
 97c:	540001a1 	b.ne	9b0 <printf+0xb0>  // b.any
            if(c == '%'){
 980:	b94027e0 	ldr	w0, [sp, #36]
 984:	7100941f 	cmp	w0, #0x25
 988:	54000081 	b.ne	998 <printf+0x98>  // b.any
                state = '%';
 98c:	528004a0 	mov	w0, #0x25                  	// #37
 990:	b90033e0 	str	w0, [sp, #48]
 994:	14000065 	b	b28 <printf+0x228>
            } else {
                putc(fd, c);
 998:	b94027e0 	ldr	w0, [sp, #36]
 99c:	12001c00 	and	w0, w0, #0xff
 9a0:	2a0003e1 	mov	w1, w0
 9a4:	b9401fe0 	ldr	w0, [sp, #28]
 9a8:	97ffff83 	bl	7b4 <putc>
 9ac:	1400005f 	b	b28 <printf+0x228>
            }
        } else if(state == '%'){
 9b0:	b94033e0 	ldr	w0, [sp, #48]
 9b4:	7100941f 	cmp	w0, #0x25
 9b8:	54000b81 	b.ne	b28 <printf+0x228>  // b.any
            if(c == 'd'){
 9bc:	b94027e0 	ldr	w0, [sp, #36]
 9c0:	7101901f 	cmp	w0, #0x64
 9c4:	54000181 	b.ne	9f4 <printf+0xf4>  // b.any
                printint(fd, *ap, 10, 1);
 9c8:	f94017e0 	ldr	x0, [sp, #40]
 9cc:	f9400000 	ldr	x0, [x0]
 9d0:	52800023 	mov	w3, #0x1                   	// #1
 9d4:	52800142 	mov	w2, #0xa                   	// #10
 9d8:	2a0003e1 	mov	w1, w0
 9dc:	b9401fe0 	ldr	w0, [sp, #28]
 9e0:	97ffff81 	bl	7e4 <printint>
                ap++;
 9e4:	f94017e0 	ldr	x0, [sp, #40]
 9e8:	91002000 	add	x0, x0, #0x8
 9ec:	f90017e0 	str	x0, [sp, #40]
 9f0:	1400004d 	b	b24 <printf+0x224>
            } else if(c == 'x' || c == 'p'){
 9f4:	b94027e0 	ldr	w0, [sp, #36]
 9f8:	7101e01f 	cmp	w0, #0x78
 9fc:	54000080 	b.eq	a0c <printf+0x10c>  // b.none
 a00:	b94027e0 	ldr	w0, [sp, #36]
 a04:	7101c01f 	cmp	w0, #0x70
 a08:	54000181 	b.ne	a38 <printf+0x138>  // b.any
                printint(fd, *ap, 16, 0);
 a0c:	f94017e0 	ldr	x0, [sp, #40]
 a10:	f9400000 	ldr	x0, [x0]
 a14:	52800003 	mov	w3, #0x0                   	// #0
 a18:	52800202 	mov	w2, #0x10                  	// #16
 a1c:	2a0003e1 	mov	w1, w0
 a20:	b9401fe0 	ldr	w0, [sp, #28]
 a24:	97ffff70 	bl	7e4 <printint>
                ap++;
 a28:	f94017e0 	ldr	x0, [sp, #40]
 a2c:	91002000 	add	x0, x0, #0x8
 a30:	f90017e0 	str	x0, [sp, #40]
 a34:	1400003c 	b	b24 <printf+0x224>
            } else if(c == 's'){
 a38:	b94027e0 	ldr	w0, [sp, #36]
 a3c:	7101cc1f 	cmp	w0, #0x73
 a40:	54000361 	b.ne	aac <printf+0x1ac>  // b.any
                s = (char*)*ap;
 a44:	f94017e0 	ldr	x0, [sp, #40]
 a48:	f9400000 	ldr	x0, [x0]
 a4c:	f9001fe0 	str	x0, [sp, #56]
                ap++;
 a50:	f94017e0 	ldr	x0, [sp, #40]
 a54:	91002000 	add	x0, x0, #0x8
 a58:	f90017e0 	str	x0, [sp, #40]
                if(s == 0)
 a5c:	f9401fe0 	ldr	x0, [sp, #56]
 a60:	f100001f 	cmp	x0, #0x0
 a64:	540001a1 	b.ne	a98 <printf+0x198>  // b.any
                    s = "(null)";
 a68:	90000000 	adrp	x0, 0 <main>
 a6c:	913d6000 	add	x0, x0, #0xf58
 a70:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
 a74:	14000009 	b	a98 <printf+0x198>
                    putc(fd, *s);
 a78:	f9401fe0 	ldr	x0, [sp, #56]
 a7c:	39400000 	ldrb	w0, [x0]
 a80:	2a0003e1 	mov	w1, w0
 a84:	b9401fe0 	ldr	w0, [sp, #28]
 a88:	97ffff4b 	bl	7b4 <putc>
                    s++;
 a8c:	f9401fe0 	ldr	x0, [sp, #56]
 a90:	91000400 	add	x0, x0, #0x1
 a94:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
 a98:	f9401fe0 	ldr	x0, [sp, #56]
 a9c:	39400000 	ldrb	w0, [x0]
 aa0:	7100001f 	cmp	w0, #0x0
 aa4:	54fffea1 	b.ne	a78 <printf+0x178>  // b.any
 aa8:	1400001f 	b	b24 <printf+0x224>
                }
            } else if(c == 'c'){
 aac:	b94027e0 	ldr	w0, [sp, #36]
 ab0:	71018c1f 	cmp	w0, #0x63
 ab4:	54000161 	b.ne	ae0 <printf+0x1e0>  // b.any
                putc(fd, *ap);
 ab8:	f94017e0 	ldr	x0, [sp, #40]
 abc:	f9400000 	ldr	x0, [x0]
 ac0:	12001c00 	and	w0, w0, #0xff
 ac4:	2a0003e1 	mov	w1, w0
 ac8:	b9401fe0 	ldr	w0, [sp, #28]
 acc:	97ffff3a 	bl	7b4 <putc>
                ap++;
 ad0:	f94017e0 	ldr	x0, [sp, #40]
 ad4:	91002000 	add	x0, x0, #0x8
 ad8:	f90017e0 	str	x0, [sp, #40]
 adc:	14000012 	b	b24 <printf+0x224>
            } else if(c == '%'){
 ae0:	b94027e0 	ldr	w0, [sp, #36]
 ae4:	7100941f 	cmp	w0, #0x25
 ae8:	540000e1 	b.ne	b04 <printf+0x204>  // b.any
                putc(fd, c);
 aec:	b94027e0 	ldr	w0, [sp, #36]
 af0:	12001c00 	and	w0, w0, #0xff
 af4:	2a0003e1 	mov	w1, w0
 af8:	b9401fe0 	ldr	w0, [sp, #28]
 afc:	97ffff2e 	bl	7b4 <putc>
 b00:	14000009 	b	b24 <printf+0x224>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
 b04:	528004a1 	mov	w1, #0x25                  	// #37
 b08:	b9401fe0 	ldr	w0, [sp, #28]
 b0c:	97ffff2a 	bl	7b4 <putc>
                putc(fd, c);
 b10:	b94027e0 	ldr	w0, [sp, #36]
 b14:	12001c00 	and	w0, w0, #0xff
 b18:	2a0003e1 	mov	w1, w0
 b1c:	b9401fe0 	ldr	w0, [sp, #28]
 b20:	97ffff25 	bl	7b4 <putc>
            }
            state = 0;
 b24:	b90033ff 	str	wzr, [sp, #48]
    for(i = 0; fmt[i]; i++){
 b28:	b94037e0 	ldr	w0, [sp, #52]
 b2c:	11000400 	add	w0, w0, #0x1
 b30:	b90037e0 	str	w0, [sp, #52]
 b34:	f9400be1 	ldr	x1, [sp, #16]
 b38:	b98037e0 	ldrsw	x0, [sp, #52]
 b3c:	8b000020 	add	x0, x1, x0
 b40:	39400000 	ldrb	w0, [x0]
 b44:	7100001f 	cmp	w0, #0x0
 b48:	54fff0c1 	b.ne	960 <printf+0x60>  // b.any
        }
    }
}
 b4c:	d503201f 	nop
 b50:	d503201f 	nop
 b54:	a8cf7bfd 	ldp	x29, x30, [sp], #240
 b58:	d65f03c0 	ret

0000000000000b5c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b5c:	d10083ff 	sub	sp, sp, #0x20
 b60:	f90007e0 	str	x0, [sp, #8]
    Header *bp, *p;
    
    bp = (Header*)ap - 1;
 b64:	f94007e0 	ldr	x0, [sp, #8]
 b68:	d1004000 	sub	x0, x0, #0x10
 b6c:	f9000be0 	str	x0, [sp, #16]
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b70:	90000000 	adrp	x0, 0 <main>
 b74:	913e2000 	add	x0, x0, #0xf88
 b78:	f9400000 	ldr	x0, [x0]
 b7c:	f9000fe0 	str	x0, [sp, #24]
 b80:	14000012 	b	bc8 <free+0x6c>
        if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b84:	f9400fe0 	ldr	x0, [sp, #24]
 b88:	f9400000 	ldr	x0, [x0]
 b8c:	f9400fe1 	ldr	x1, [sp, #24]
 b90:	eb00003f 	cmp	x1, x0
 b94:	54000143 	b.cc	bbc <free+0x60>  // b.lo, b.ul, b.last
 b98:	f9400be1 	ldr	x1, [sp, #16]
 b9c:	f9400fe0 	ldr	x0, [sp, #24]
 ba0:	eb00003f 	cmp	x1, x0
 ba4:	54000248 	b.hi	bec <free+0x90>  // b.pmore
 ba8:	f9400fe0 	ldr	x0, [sp, #24]
 bac:	f9400000 	ldr	x0, [x0]
 bb0:	f9400be1 	ldr	x1, [sp, #16]
 bb4:	eb00003f 	cmp	x1, x0
 bb8:	540001a3 	b.cc	bec <free+0x90>  // b.lo, b.ul, b.last
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bbc:	f9400fe0 	ldr	x0, [sp, #24]
 bc0:	f9400000 	ldr	x0, [x0]
 bc4:	f9000fe0 	str	x0, [sp, #24]
 bc8:	f9400be1 	ldr	x1, [sp, #16]
 bcc:	f9400fe0 	ldr	x0, [sp, #24]
 bd0:	eb00003f 	cmp	x1, x0
 bd4:	54fffd89 	b.ls	b84 <free+0x28>  // b.plast
 bd8:	f9400fe0 	ldr	x0, [sp, #24]
 bdc:	f9400000 	ldr	x0, [x0]
 be0:	f9400be1 	ldr	x1, [sp, #16]
 be4:	eb00003f 	cmp	x1, x0
 be8:	54fffce2 	b.cs	b84 <free+0x28>  // b.hs, b.nlast
            break;
    if(bp + bp->s.size == p->s.ptr){
 bec:	f9400be0 	ldr	x0, [sp, #16]
 bf0:	b9400800 	ldr	w0, [x0, #8]
 bf4:	2a0003e0 	mov	w0, w0
 bf8:	d37cec00 	lsl	x0, x0, #4
 bfc:	f9400be1 	ldr	x1, [sp, #16]
 c00:	8b000021 	add	x1, x1, x0
 c04:	f9400fe0 	ldr	x0, [sp, #24]
 c08:	f9400000 	ldr	x0, [x0]
 c0c:	eb00003f 	cmp	x1, x0
 c10:	540001e1 	b.ne	c4c <free+0xf0>  // b.any
        bp->s.size += p->s.ptr->s.size;
 c14:	f9400be0 	ldr	x0, [sp, #16]
 c18:	b9400801 	ldr	w1, [x0, #8]
 c1c:	f9400fe0 	ldr	x0, [sp, #24]
 c20:	f9400000 	ldr	x0, [x0]
 c24:	b9400800 	ldr	w0, [x0, #8]
 c28:	0b000021 	add	w1, w1, w0
 c2c:	f9400be0 	ldr	x0, [sp, #16]
 c30:	b9000801 	str	w1, [x0, #8]
        bp->s.ptr = p->s.ptr->s.ptr;
 c34:	f9400fe0 	ldr	x0, [sp, #24]
 c38:	f9400000 	ldr	x0, [x0]
 c3c:	f9400001 	ldr	x1, [x0]
 c40:	f9400be0 	ldr	x0, [sp, #16]
 c44:	f9000001 	str	x1, [x0]
 c48:	14000005 	b	c5c <free+0x100>
    } else
        bp->s.ptr = p->s.ptr;
 c4c:	f9400fe0 	ldr	x0, [sp, #24]
 c50:	f9400001 	ldr	x1, [x0]
 c54:	f9400be0 	ldr	x0, [sp, #16]
 c58:	f9000001 	str	x1, [x0]
    if(p + p->s.size == bp){
 c5c:	f9400fe0 	ldr	x0, [sp, #24]
 c60:	b9400800 	ldr	w0, [x0, #8]
 c64:	2a0003e0 	mov	w0, w0
 c68:	d37cec00 	lsl	x0, x0, #4
 c6c:	f9400fe1 	ldr	x1, [sp, #24]
 c70:	8b000020 	add	x0, x1, x0
 c74:	f9400be1 	ldr	x1, [sp, #16]
 c78:	eb00003f 	cmp	x1, x0
 c7c:	540001a1 	b.ne	cb0 <free+0x154>  // b.any
        p->s.size += bp->s.size;
 c80:	f9400fe0 	ldr	x0, [sp, #24]
 c84:	b9400801 	ldr	w1, [x0, #8]
 c88:	f9400be0 	ldr	x0, [sp, #16]
 c8c:	b9400800 	ldr	w0, [x0, #8]
 c90:	0b000021 	add	w1, w1, w0
 c94:	f9400fe0 	ldr	x0, [sp, #24]
 c98:	b9000801 	str	w1, [x0, #8]
        p->s.ptr = bp->s.ptr;
 c9c:	f9400be0 	ldr	x0, [sp, #16]
 ca0:	f9400001 	ldr	x1, [x0]
 ca4:	f9400fe0 	ldr	x0, [sp, #24]
 ca8:	f9000001 	str	x1, [x0]
 cac:	14000004 	b	cbc <free+0x160>
    } else
        p->s.ptr = bp;
 cb0:	f9400fe0 	ldr	x0, [sp, #24]
 cb4:	f9400be1 	ldr	x1, [sp, #16]
 cb8:	f9000001 	str	x1, [x0]
    freep = p;
 cbc:	90000000 	adrp	x0, 0 <main>
 cc0:	913e2000 	add	x0, x0, #0xf88
 cc4:	f9400fe1 	ldr	x1, [sp, #24]
 cc8:	f9000001 	str	x1, [x0]
}
 ccc:	d503201f 	nop
 cd0:	910083ff 	add	sp, sp, #0x20
 cd4:	d65f03c0 	ret

0000000000000cd8 <morecore>:

static Header*
morecore(uint nu)
{
 cd8:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 cdc:	910003fd 	mov	x29, sp
 ce0:	b9001fe0 	str	w0, [sp, #28]
    char *p;
    Header *hp;
    
    if(nu < 4096)
 ce4:	b9401fe0 	ldr	w0, [sp, #28]
 ce8:	713ffc1f 	cmp	w0, #0xfff
 cec:	54000068 	b.hi	cf8 <morecore+0x20>  // b.pmore
        nu = 4096;
 cf0:	52820000 	mov	w0, #0x1000                	// #4096
 cf4:	b9001fe0 	str	w0, [sp, #28]
    p = sbrk(nu * sizeof(Header));
 cf8:	b9401fe0 	ldr	w0, [sp, #28]
 cfc:	531c6c00 	lsl	w0, w0, #4
 d00:	97fffe92 	bl	748 <sbrk>
 d04:	f90017e0 	str	x0, [sp, #40]
    if(p == (char*)-1)
 d08:	f94017e0 	ldr	x0, [sp, #40]
 d0c:	b100041f 	cmn	x0, #0x1
 d10:	54000061 	b.ne	d1c <morecore+0x44>  // b.any
        return 0;
 d14:	d2800000 	mov	x0, #0x0                   	// #0
 d18:	1400000c 	b	d48 <morecore+0x70>
    hp = (Header*)p;
 d1c:	f94017e0 	ldr	x0, [sp, #40]
 d20:	f90013e0 	str	x0, [sp, #32]
    hp->s.size = nu;
 d24:	f94013e0 	ldr	x0, [sp, #32]
 d28:	b9401fe1 	ldr	w1, [sp, #28]
 d2c:	b9000801 	str	w1, [x0, #8]
    free((void*)(hp + 1));
 d30:	f94013e0 	ldr	x0, [sp, #32]
 d34:	91004000 	add	x0, x0, #0x10
 d38:	97ffff89 	bl	b5c <free>
    return freep;
 d3c:	90000000 	adrp	x0, 0 <main>
 d40:	913e2000 	add	x0, x0, #0xf88
 d44:	f9400000 	ldr	x0, [x0]
}
 d48:	a8c37bfd 	ldp	x29, x30, [sp], #48
 d4c:	d65f03c0 	ret

0000000000000d50 <malloc>:

void*
malloc(uint nbytes)
{
 d50:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 d54:	910003fd 	mov	x29, sp
 d58:	b9001fe0 	str	w0, [sp, #28]
    Header *p, *prevp;
    uint nunits;
    
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d5c:	b9401fe0 	ldr	w0, [sp, #28]
 d60:	91003c00 	add	x0, x0, #0xf
 d64:	d344fc00 	lsr	x0, x0, #4
 d68:	11000400 	add	w0, w0, #0x1
 d6c:	b9002fe0 	str	w0, [sp, #44]
    if((prevp = freep) == 0){
 d70:	90000000 	adrp	x0, 0 <main>
 d74:	913e2000 	add	x0, x0, #0xf88
 d78:	f9400000 	ldr	x0, [x0]
 d7c:	f9001be0 	str	x0, [sp, #48]
 d80:	f9401be0 	ldr	x0, [sp, #48]
 d84:	f100001f 	cmp	x0, #0x0
 d88:	54000221 	b.ne	dcc <malloc+0x7c>  // b.any
        base.s.ptr = freep = prevp = &base;
 d8c:	90000000 	adrp	x0, 0 <main>
 d90:	913de000 	add	x0, x0, #0xf78
 d94:	f9001be0 	str	x0, [sp, #48]
 d98:	90000000 	adrp	x0, 0 <main>
 d9c:	913e2000 	add	x0, x0, #0xf88
 da0:	f9401be1 	ldr	x1, [sp, #48]
 da4:	f9000001 	str	x1, [x0]
 da8:	90000000 	adrp	x0, 0 <main>
 dac:	913e2000 	add	x0, x0, #0xf88
 db0:	f9400001 	ldr	x1, [x0]
 db4:	90000000 	adrp	x0, 0 <main>
 db8:	913de000 	add	x0, x0, #0xf78
 dbc:	f9000001 	str	x1, [x0]
        base.s.size = 0;
 dc0:	90000000 	adrp	x0, 0 <main>
 dc4:	913de000 	add	x0, x0, #0xf78
 dc8:	b900081f 	str	wzr, [x0, #8]
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 dcc:	f9401be0 	ldr	x0, [sp, #48]
 dd0:	f9400000 	ldr	x0, [x0]
 dd4:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
 dd8:	f9401fe0 	ldr	x0, [sp, #56]
 ddc:	b9400800 	ldr	w0, [x0, #8]
 de0:	b9402fe1 	ldr	w1, [sp, #44]
 de4:	6b00003f 	cmp	w1, w0
 de8:	54000448 	b.hi	e70 <malloc+0x120>  // b.pmore
            if(p->s.size == nunits)
 dec:	f9401fe0 	ldr	x0, [sp, #56]
 df0:	b9400800 	ldr	w0, [x0, #8]
 df4:	b9402fe1 	ldr	w1, [sp, #44]
 df8:	6b00003f 	cmp	w1, w0
 dfc:	540000c1 	b.ne	e14 <malloc+0xc4>  // b.any
                prevp->s.ptr = p->s.ptr;
 e00:	f9401fe0 	ldr	x0, [sp, #56]
 e04:	f9400001 	ldr	x1, [x0]
 e08:	f9401be0 	ldr	x0, [sp, #48]
 e0c:	f9000001 	str	x1, [x0]
 e10:	14000011 	b	e54 <malloc+0x104>
            else {
                p->s.size -= nunits;
 e14:	f9401fe0 	ldr	x0, [sp, #56]
 e18:	b9400801 	ldr	w1, [x0, #8]
 e1c:	b9402fe0 	ldr	w0, [sp, #44]
 e20:	4b000021 	sub	w1, w1, w0
 e24:	f9401fe0 	ldr	x0, [sp, #56]
 e28:	b9000801 	str	w1, [x0, #8]
                p += p->s.size;
 e2c:	f9401fe0 	ldr	x0, [sp, #56]
 e30:	b9400800 	ldr	w0, [x0, #8]
 e34:	2a0003e0 	mov	w0, w0
 e38:	d37cec00 	lsl	x0, x0, #4
 e3c:	f9401fe1 	ldr	x1, [sp, #56]
 e40:	8b000020 	add	x0, x1, x0
 e44:	f9001fe0 	str	x0, [sp, #56]
                p->s.size = nunits;
 e48:	f9401fe0 	ldr	x0, [sp, #56]
 e4c:	b9402fe1 	ldr	w1, [sp, #44]
 e50:	b9000801 	str	w1, [x0, #8]
            }
            freep = prevp;
 e54:	90000000 	adrp	x0, 0 <main>
 e58:	913e2000 	add	x0, x0, #0xf88
 e5c:	f9401be1 	ldr	x1, [sp, #48]
 e60:	f9000001 	str	x1, [x0]
            return (void*)(p + 1);
 e64:	f9401fe0 	ldr	x0, [sp, #56]
 e68:	91004000 	add	x0, x0, #0x10
 e6c:	14000015 	b	ec0 <malloc+0x170>
        }
        if(p == freep)
 e70:	90000000 	adrp	x0, 0 <main>
 e74:	913e2000 	add	x0, x0, #0xf88
 e78:	f9400000 	ldr	x0, [x0]
 e7c:	f9401fe1 	ldr	x1, [sp, #56]
 e80:	eb00003f 	cmp	x1, x0
 e84:	54000121 	b.ne	ea8 <malloc+0x158>  // b.any
            if((p = morecore(nunits)) == 0)
 e88:	b9402fe0 	ldr	w0, [sp, #44]
 e8c:	97ffff93 	bl	cd8 <morecore>
 e90:	f9001fe0 	str	x0, [sp, #56]
 e94:	f9401fe0 	ldr	x0, [sp, #56]
 e98:	f100001f 	cmp	x0, #0x0
 e9c:	54000061 	b.ne	ea8 <malloc+0x158>  // b.any
                return 0;
 ea0:	d2800000 	mov	x0, #0x0                   	// #0
 ea4:	14000007 	b	ec0 <malloc+0x170>
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ea8:	f9401fe0 	ldr	x0, [sp, #56]
 eac:	f9001be0 	str	x0, [sp, #48]
 eb0:	f9401fe0 	ldr	x0, [sp, #56]
 eb4:	f9400000 	ldr	x0, [x0]
 eb8:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
 ebc:	17ffffc7 	b	dd8 <malloc+0x88>
    }
}
 ec0:	a8c47bfd 	ldp	x29, x30, [sp], #64
 ec4:	d65f03c0 	ret
