
_ln:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
   4:	910003fd 	mov	x29, sp
   8:	b9001fe0 	str	w0, [sp, #28]
   c:	f9000be1 	str	x1, [sp, #16]
    if(argc != 3){
  10:	b9401fe0 	ldr	w0, [sp, #28]
  14:	71000c1f 	cmp	w0, #0x3
  18:	540000c0 	b.eq	30 <main+0x30>  // b.none
        printf(2, "Usage: ln old new\n");
  1c:	90000000 	adrp	x0, 0 <main>
  20:	913b8001 	add	x1, x0, #0xee0
  24:	52800040 	mov	w0, #0x2                   	// #2
  28:	9400023b 	bl	914 <printf>
        exit();
  2c:	94000133 	bl	4f8 <exit>
    }
    if(link(argv[1], argv[2]) < 0)
  30:	f9400be0 	ldr	x0, [sp, #16]
  34:	91002000 	add	x0, x0, #0x8
  38:	f9400002 	ldr	x2, [x0]
  3c:	f9400be0 	ldr	x0, [sp, #16]
  40:	91004000 	add	x0, x0, #0x10
  44:	f9400000 	ldr	x0, [x0]
  48:	aa0003e1 	mov	x1, x0
  4c:	aa0203e0 	mov	x0, x2
  50:	94000196 	bl	6a8 <link>
  54:	7100001f 	cmp	w0, #0x0
  58:	540001aa 	b.ge	8c <main+0x8c>  // b.tcont
        printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  5c:	f9400be0 	ldr	x0, [sp, #16]
  60:	91002000 	add	x0, x0, #0x8
  64:	f9400001 	ldr	x1, [x0]
  68:	f9400be0 	ldr	x0, [sp, #16]
  6c:	91004000 	add	x0, x0, #0x10
  70:	f9400000 	ldr	x0, [x0]
  74:	aa0003e3 	mov	x3, x0
  78:	aa0103e2 	mov	x2, x1
  7c:	90000000 	adrp	x0, 0 <main>
  80:	913be001 	add	x1, x0, #0xef8
  84:	52800040 	mov	w0, #0x2                   	// #2
  88:	94000223 	bl	914 <printf>
    exit();
  8c:	9400011b 	bl	4f8 <exit>

0000000000000090 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  90:	d10083ff 	sub	sp, sp, #0x20
  94:	f90007e0 	str	x0, [sp, #8]
  98:	f90003e1 	str	x1, [sp]
    char *os;
    
    os = s;
  9c:	f94007e0 	ldr	x0, [sp, #8]
  a0:	f9000fe0 	str	x0, [sp, #24]
    while((*s++ = *t++) != 0)
  a4:	d503201f 	nop
  a8:	f94003e1 	ldr	x1, [sp]
  ac:	91000420 	add	x0, x1, #0x1
  b0:	f90003e0 	str	x0, [sp]
  b4:	f94007e0 	ldr	x0, [sp, #8]
  b8:	91000402 	add	x2, x0, #0x1
  bc:	f90007e2 	str	x2, [sp, #8]
  c0:	39400021 	ldrb	w1, [x1]
  c4:	39000001 	strb	w1, [x0]
  c8:	39400000 	ldrb	w0, [x0]
  cc:	7100001f 	cmp	w0, #0x0
  d0:	54fffec1 	b.ne	a8 <strcpy+0x18>  // b.any
        ;
    return os;
  d4:	f9400fe0 	ldr	x0, [sp, #24]
}
  d8:	910083ff 	add	sp, sp, #0x20
  dc:	d65f03c0 	ret

00000000000000e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e0:	d10043ff 	sub	sp, sp, #0x10
  e4:	f90007e0 	str	x0, [sp, #8]
  e8:	f90003e1 	str	x1, [sp]
    while(*p && *p == *q)
  ec:	14000007 	b	108 <strcmp+0x28>
        p++, q++;
  f0:	f94007e0 	ldr	x0, [sp, #8]
  f4:	91000400 	add	x0, x0, #0x1
  f8:	f90007e0 	str	x0, [sp, #8]
  fc:	f94003e0 	ldr	x0, [sp]
 100:	91000400 	add	x0, x0, #0x1
 104:	f90003e0 	str	x0, [sp]
    while(*p && *p == *q)
 108:	f94007e0 	ldr	x0, [sp, #8]
 10c:	39400000 	ldrb	w0, [x0]
 110:	7100001f 	cmp	w0, #0x0
 114:	540000e0 	b.eq	130 <strcmp+0x50>  // b.none
 118:	f94007e0 	ldr	x0, [sp, #8]
 11c:	39400001 	ldrb	w1, [x0]
 120:	f94003e0 	ldr	x0, [sp]
 124:	39400000 	ldrb	w0, [x0]
 128:	6b00003f 	cmp	w1, w0
 12c:	54fffe20 	b.eq	f0 <strcmp+0x10>  // b.none
    return (uchar)*p - (uchar)*q;
 130:	f94007e0 	ldr	x0, [sp, #8]
 134:	39400000 	ldrb	w0, [x0]
 138:	2a0003e1 	mov	w1, w0
 13c:	f94003e0 	ldr	x0, [sp]
 140:	39400000 	ldrb	w0, [x0]
 144:	4b000020 	sub	w0, w1, w0
}
 148:	910043ff 	add	sp, sp, #0x10
 14c:	d65f03c0 	ret

0000000000000150 <strlen>:

uint
strlen(char *s)
{
 150:	d10083ff 	sub	sp, sp, #0x20
 154:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    for(n = 0; s[n]; n++)
 158:	b9001fff 	str	wzr, [sp, #28]
 15c:	14000004 	b	16c <strlen+0x1c>
 160:	b9401fe0 	ldr	w0, [sp, #28]
 164:	11000400 	add	w0, w0, #0x1
 168:	b9001fe0 	str	w0, [sp, #28]
 16c:	b9801fe0 	ldrsw	x0, [sp, #28]
 170:	f94007e1 	ldr	x1, [sp, #8]
 174:	8b000020 	add	x0, x1, x0
 178:	39400000 	ldrb	w0, [x0]
 17c:	7100001f 	cmp	w0, #0x0
 180:	54ffff01 	b.ne	160 <strlen+0x10>  // b.any
        ;
    return n;
 184:	b9401fe0 	ldr	w0, [sp, #28]
}
 188:	910083ff 	add	sp, sp, #0x20
 18c:	d65f03c0 	ret

0000000000000190 <memset>:

void*
memset(void *dst, int v, uint n)
{
 190:	d100c3ff 	sub	sp, sp, #0x30
 194:	f90007e0 	str	x0, [sp, #8]
 198:	b90007e1 	str	w1, [sp, #4]
 19c:	b90003e2 	str	w2, [sp]
	uint8	*p;
	uint8	c;
	uint32	val;
	uint32	*p4;

	p   = dst;
 1a0:	f94007e0 	ldr	x0, [sp, #8]
 1a4:	f90017e0 	str	x0, [sp, #40]
	c   = v & 0xff;
 1a8:	b94007e0 	ldr	w0, [sp, #4]
 1ac:	39007fe0 	strb	w0, [sp, #31]
	val = (c << 24) | (c << 16) | (c << 8) | c;
 1b0:	39407fe1 	ldrb	w1, [sp, #31]
 1b4:	2a0103e0 	mov	w0, w1
 1b8:	53185c00 	lsl	w0, w0, #8
 1bc:	0b010000 	add	w0, w0, w1
 1c0:	53103c00 	lsl	w0, w0, #16
 1c4:	2a0003e1 	mov	w1, w0
 1c8:	39407fe0 	ldrb	w0, [sp, #31]
 1cc:	53185c00 	lsl	w0, w0, #8
 1d0:	2a000021 	orr	w1, w1, w0
 1d4:	39407fe0 	ldrb	w0, [sp, #31]
 1d8:	2a000020 	orr	w0, w1, w0
 1dc:	b9001be0 	str	w0, [sp, #24]

	// set bytes before whole uint32
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
 1e0:	1400000a 	b	208 <memset+0x78>
		*p = c;
 1e4:	f94017e0 	ldr	x0, [sp, #40]
 1e8:	39407fe1 	ldrb	w1, [sp, #31]
 1ec:	39000001 	strb	w1, [x0]
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
 1f0:	b94003e0 	ldr	w0, [sp]
 1f4:	51000400 	sub	w0, w0, #0x1
 1f8:	b90003e0 	str	w0, [sp]
 1fc:	f94017e0 	ldr	x0, [sp, #40]
 200:	91000400 	add	x0, x0, #0x1
 204:	f90017e0 	str	x0, [sp, #40]
 208:	b94003e0 	ldr	w0, [sp]
 20c:	7100001f 	cmp	w0, #0x0
 210:	540000a0 	b.eq	224 <memset+0x94>  // b.none
 214:	f94017e0 	ldr	x0, [sp, #40]
 218:	92400400 	and	x0, x0, #0x3
 21c:	f100001f 	cmp	x0, #0x0
 220:	54fffe21 	b.ne	1e4 <memset+0x54>  // b.any
	}

	// set memory 4 bytes a time
	p4 = (uint*)p;
 224:	f94017e0 	ldr	x0, [sp, #40]
 228:	f90013e0 	str	x0, [sp, #32]

	for (; n >= 4; n -= 4, p4++) {
 22c:	1400000a 	b	254 <memset+0xc4>
		*p4 = val;
 230:	f94013e0 	ldr	x0, [sp, #32]
 234:	b9401be1 	ldr	w1, [sp, #24]
 238:	b9000001 	str	w1, [x0]
	for (; n >= 4; n -= 4, p4++) {
 23c:	b94003e0 	ldr	w0, [sp]
 240:	51001000 	sub	w0, w0, #0x4
 244:	b90003e0 	str	w0, [sp]
 248:	f94013e0 	ldr	x0, [sp, #32]
 24c:	91001000 	add	x0, x0, #0x4
 250:	f90013e0 	str	x0, [sp, #32]
 254:	b94003e0 	ldr	w0, [sp]
 258:	71000c1f 	cmp	w0, #0x3
 25c:	54fffea8 	b.hi	230 <memset+0xa0>  // b.pmore
	}

	// set leftover one byte a time
	p = (uint8*)p4;
 260:	f94013e0 	ldr	x0, [sp, #32]
 264:	f90017e0 	str	x0, [sp, #40]

	for (; n > 0; n--, p++) {
 268:	1400000a 	b	290 <memset+0x100>
		*p = c;
 26c:	f94017e0 	ldr	x0, [sp, #40]
 270:	39407fe1 	ldrb	w1, [sp, #31]
 274:	39000001 	strb	w1, [x0]
	for (; n > 0; n--, p++) {
 278:	b94003e0 	ldr	w0, [sp]
 27c:	51000400 	sub	w0, w0, #0x1
 280:	b90003e0 	str	w0, [sp]
 284:	f94017e0 	ldr	x0, [sp, #40]
 288:	91000400 	add	x0, x0, #0x1
 28c:	f90017e0 	str	x0, [sp, #40]
 290:	b94003e0 	ldr	w0, [sp]
 294:	7100001f 	cmp	w0, #0x0
 298:	54fffea1 	b.ne	26c <memset+0xdc>  // b.any
	}

	return dst;
 29c:	f94007e0 	ldr	x0, [sp, #8]
}
 2a0:	9100c3ff 	add	sp, sp, #0x30
 2a4:	d65f03c0 	ret

00000000000002a8 <strchr>:

char*
strchr(const char *s, char c)
{
 2a8:	d10043ff 	sub	sp, sp, #0x10
 2ac:	f90007e0 	str	x0, [sp, #8]
 2b0:	39001fe1 	strb	w1, [sp, #7]
    for(; *s; s++)
 2b4:	1400000b 	b	2e0 <strchr+0x38>
        if(*s == c)
 2b8:	f94007e0 	ldr	x0, [sp, #8]
 2bc:	39400000 	ldrb	w0, [x0]
 2c0:	39401fe1 	ldrb	w1, [sp, #7]
 2c4:	6b00003f 	cmp	w1, w0
 2c8:	54000061 	b.ne	2d4 <strchr+0x2c>  // b.any
            return (char*)s;
 2cc:	f94007e0 	ldr	x0, [sp, #8]
 2d0:	14000009 	b	2f4 <strchr+0x4c>
    for(; *s; s++)
 2d4:	f94007e0 	ldr	x0, [sp, #8]
 2d8:	91000400 	add	x0, x0, #0x1
 2dc:	f90007e0 	str	x0, [sp, #8]
 2e0:	f94007e0 	ldr	x0, [sp, #8]
 2e4:	39400000 	ldrb	w0, [x0]
 2e8:	7100001f 	cmp	w0, #0x0
 2ec:	54fffe61 	b.ne	2b8 <strchr+0x10>  // b.any
    return 0;
 2f0:	d2800000 	mov	x0, #0x0                   	// #0
}
 2f4:	910043ff 	add	sp, sp, #0x10
 2f8:	d65f03c0 	ret

00000000000002fc <gets>:

char*
gets(char *buf, int max)
{
 2fc:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 300:	910003fd 	mov	x29, sp
 304:	f9000fe0 	str	x0, [sp, #24]
 308:	b90017e1 	str	w1, [sp, #20]
    int i, cc;
    char c;
    
    for(i=0; i+1 < max; ){
 30c:	b9002fff 	str	wzr, [sp, #44]
 310:	14000018 	b	370 <gets+0x74>
        cc = read(0, &c, 1);
 314:	91009fe0 	add	x0, sp, #0x27
 318:	52800022 	mov	w2, #0x1                   	// #1
 31c:	aa0003e1 	mov	x1, x0
 320:	52800000 	mov	w0, #0x0                   	// #0
 324:	94000090 	bl	564 <read>
 328:	b9002be0 	str	w0, [sp, #40]
        if(cc < 1)
 32c:	b9402be0 	ldr	w0, [sp, #40]
 330:	7100001f 	cmp	w0, #0x0
 334:	540002ad 	b.le	388 <gets+0x8c>
            break;
        buf[i++] = c;
 338:	b9402fe0 	ldr	w0, [sp, #44]
 33c:	11000401 	add	w1, w0, #0x1
 340:	b9002fe1 	str	w1, [sp, #44]
 344:	93407c00 	sxtw	x0, w0
 348:	f9400fe1 	ldr	x1, [sp, #24]
 34c:	8b000020 	add	x0, x1, x0
 350:	39409fe1 	ldrb	w1, [sp, #39]
 354:	39000001 	strb	w1, [x0]
        if(c == '\n' || c == '\r')
 358:	39409fe0 	ldrb	w0, [sp, #39]
 35c:	7100281f 	cmp	w0, #0xa
 360:	54000160 	b.eq	38c <gets+0x90>  // b.none
 364:	39409fe0 	ldrb	w0, [sp, #39]
 368:	7100341f 	cmp	w0, #0xd
 36c:	54000100 	b.eq	38c <gets+0x90>  // b.none
    for(i=0; i+1 < max; ){
 370:	b9402fe0 	ldr	w0, [sp, #44]
 374:	11000400 	add	w0, w0, #0x1
 378:	b94017e1 	ldr	w1, [sp, #20]
 37c:	6b00003f 	cmp	w1, w0
 380:	54fffcac 	b.gt	314 <gets+0x18>
 384:	14000002 	b	38c <gets+0x90>
            break;
 388:	d503201f 	nop
            break;
    }
    buf[i] = '\0';
 38c:	b9802fe0 	ldrsw	x0, [sp, #44]
 390:	f9400fe1 	ldr	x1, [sp, #24]
 394:	8b000020 	add	x0, x1, x0
 398:	3900001f 	strb	wzr, [x0]
    return buf;
 39c:	f9400fe0 	ldr	x0, [sp, #24]
}
 3a0:	a8c37bfd 	ldp	x29, x30, [sp], #48
 3a4:	d65f03c0 	ret

00000000000003a8 <stat>:

int
stat(char *n, struct stat *st)
{
 3a8:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 3ac:	910003fd 	mov	x29, sp
 3b0:	f9000fe0 	str	x0, [sp, #24]
 3b4:	f9000be1 	str	x1, [sp, #16]
    int fd;
    int r;
    
    fd = open(n, O_RDONLY);
 3b8:	52800001 	mov	w1, #0x0                   	// #0
 3bc:	f9400fe0 	ldr	x0, [sp, #24]
 3c0:	94000096 	bl	618 <open>
 3c4:	b9002fe0 	str	w0, [sp, #44]
    if(fd < 0)
 3c8:	b9402fe0 	ldr	w0, [sp, #44]
 3cc:	7100001f 	cmp	w0, #0x0
 3d0:	5400006a 	b.ge	3dc <stat+0x34>  // b.tcont
        return -1;
 3d4:	12800000 	mov	w0, #0xffffffff            	// #-1
 3d8:	14000008 	b	3f8 <stat+0x50>
    r = fstat(fd, st);
 3dc:	f9400be1 	ldr	x1, [sp, #16]
 3e0:	b9402fe0 	ldr	w0, [sp, #44]
 3e4:	940000a8 	bl	684 <fstat>
 3e8:	b9002be0 	str	w0, [sp, #40]
    close(fd);
 3ec:	b9402fe0 	ldr	w0, [sp, #44]
 3f0:	9400006f 	bl	5ac <close>
    return r;
 3f4:	b9402be0 	ldr	w0, [sp, #40]
}
 3f8:	a8c37bfd 	ldp	x29, x30, [sp], #48
 3fc:	d65f03c0 	ret

0000000000000400 <atoi>:

int
atoi(const char *s)
{
 400:	d10083ff 	sub	sp, sp, #0x20
 404:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    n = 0;
 408:	b9001fff 	str	wzr, [sp, #28]
    while('0' <= *s && *s <= '9')
 40c:	1400000e 	b	444 <atoi+0x44>
        n = n*10 + *s++ - '0';
 410:	b9401fe1 	ldr	w1, [sp, #28]
 414:	2a0103e0 	mov	w0, w1
 418:	531e7400 	lsl	w0, w0, #2
 41c:	0b010000 	add	w0, w0, w1
 420:	531f7800 	lsl	w0, w0, #1
 424:	2a0003e2 	mov	w2, w0
 428:	f94007e0 	ldr	x0, [sp, #8]
 42c:	91000401 	add	x1, x0, #0x1
 430:	f90007e1 	str	x1, [sp, #8]
 434:	39400000 	ldrb	w0, [x0]
 438:	0b000040 	add	w0, w2, w0
 43c:	5100c000 	sub	w0, w0, #0x30
 440:	b9001fe0 	str	w0, [sp, #28]
    while('0' <= *s && *s <= '9')
 444:	f94007e0 	ldr	x0, [sp, #8]
 448:	39400000 	ldrb	w0, [x0]
 44c:	7100bc1f 	cmp	w0, #0x2f
 450:	540000a9 	b.ls	464 <atoi+0x64>  // b.plast
 454:	f94007e0 	ldr	x0, [sp, #8]
 458:	39400000 	ldrb	w0, [x0]
 45c:	7100e41f 	cmp	w0, #0x39
 460:	54fffd89 	b.ls	410 <atoi+0x10>  // b.plast
    return n;
 464:	b9401fe0 	ldr	w0, [sp, #28]
}
 468:	910083ff 	add	sp, sp, #0x20
 46c:	d65f03c0 	ret

0000000000000470 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 470:	d100c3ff 	sub	sp, sp, #0x30
 474:	f9000fe0 	str	x0, [sp, #24]
 478:	f9000be1 	str	x1, [sp, #16]
 47c:	b9000fe2 	str	w2, [sp, #12]
    char *dst, *src;
    
    dst = vdst;
 480:	f9400fe0 	ldr	x0, [sp, #24]
 484:	f90017e0 	str	x0, [sp, #40]
    src = vsrc;
 488:	f9400be0 	ldr	x0, [sp, #16]
 48c:	f90013e0 	str	x0, [sp, #32]
    while(n-- > 0)
 490:	14000009 	b	4b4 <memmove+0x44>
        *dst++ = *src++;
 494:	f94013e1 	ldr	x1, [sp, #32]
 498:	91000420 	add	x0, x1, #0x1
 49c:	f90013e0 	str	x0, [sp, #32]
 4a0:	f94017e0 	ldr	x0, [sp, #40]
 4a4:	91000402 	add	x2, x0, #0x1
 4a8:	f90017e2 	str	x2, [sp, #40]
 4ac:	39400021 	ldrb	w1, [x1]
 4b0:	39000001 	strb	w1, [x0]
    while(n-- > 0)
 4b4:	b9400fe0 	ldr	w0, [sp, #12]
 4b8:	51000401 	sub	w1, w0, #0x1
 4bc:	b9000fe1 	str	w1, [sp, #12]
 4c0:	7100001f 	cmp	w0, #0x0
 4c4:	54fffe8c 	b.gt	494 <memmove+0x24>
    return vdst;
 4c8:	f9400fe0 	ldr	x0, [sp, #24]
}
 4cc:	9100c3ff 	add	sp, sp, #0x30
 4d0:	d65f03c0 	ret

00000000000004d4 <fork>:
 4d4:	f81f8fe4 	str	x4, [sp, #-8]!
 4d8:	aa0303e4 	mov	x4, x3
 4dc:	aa0203e3 	mov	x3, x2
 4e0:	aa0103e2 	mov	x2, x1
 4e4:	aa0003e1 	mov	x1, x0
 4e8:	d2800020 	mov	x0, #0x1                   	// #1
 4ec:	d4000001 	svc	#0x0
 4f0:	f84087e4 	ldr	x4, [sp], #8
 4f4:	d61f03c0 	br	x30

00000000000004f8 <exit>:
 4f8:	f81f8fe4 	str	x4, [sp, #-8]!
 4fc:	aa0303e4 	mov	x4, x3
 500:	aa0203e3 	mov	x3, x2
 504:	aa0103e2 	mov	x2, x1
 508:	aa0003e1 	mov	x1, x0
 50c:	d2800040 	mov	x0, #0x2                   	// #2
 510:	d4000001 	svc	#0x0
 514:	f84087e4 	ldr	x4, [sp], #8
 518:	d61f03c0 	br	x30

000000000000051c <wait>:
 51c:	f81f8fe4 	str	x4, [sp, #-8]!
 520:	aa0303e4 	mov	x4, x3
 524:	aa0203e3 	mov	x3, x2
 528:	aa0103e2 	mov	x2, x1
 52c:	aa0003e1 	mov	x1, x0
 530:	d2800060 	mov	x0, #0x3                   	// #3
 534:	d4000001 	svc	#0x0
 538:	f84087e4 	ldr	x4, [sp], #8
 53c:	d61f03c0 	br	x30

0000000000000540 <pipe>:
 540:	f81f8fe4 	str	x4, [sp, #-8]!
 544:	aa0303e4 	mov	x4, x3
 548:	aa0203e3 	mov	x3, x2
 54c:	aa0103e2 	mov	x2, x1
 550:	aa0003e1 	mov	x1, x0
 554:	d2800080 	mov	x0, #0x4                   	// #4
 558:	d4000001 	svc	#0x0
 55c:	f84087e4 	ldr	x4, [sp], #8
 560:	d61f03c0 	br	x30

0000000000000564 <read>:
 564:	f81f8fe4 	str	x4, [sp, #-8]!
 568:	aa0303e4 	mov	x4, x3
 56c:	aa0203e3 	mov	x3, x2
 570:	aa0103e2 	mov	x2, x1
 574:	aa0003e1 	mov	x1, x0
 578:	d28000a0 	mov	x0, #0x5                   	// #5
 57c:	d4000001 	svc	#0x0
 580:	f84087e4 	ldr	x4, [sp], #8
 584:	d61f03c0 	br	x30

0000000000000588 <write>:
 588:	f81f8fe4 	str	x4, [sp, #-8]!
 58c:	aa0303e4 	mov	x4, x3
 590:	aa0203e3 	mov	x3, x2
 594:	aa0103e2 	mov	x2, x1
 598:	aa0003e1 	mov	x1, x0
 59c:	d2800200 	mov	x0, #0x10                  	// #16
 5a0:	d4000001 	svc	#0x0
 5a4:	f84087e4 	ldr	x4, [sp], #8
 5a8:	d61f03c0 	br	x30

00000000000005ac <close>:
 5ac:	f81f8fe4 	str	x4, [sp, #-8]!
 5b0:	aa0303e4 	mov	x4, x3
 5b4:	aa0203e3 	mov	x3, x2
 5b8:	aa0103e2 	mov	x2, x1
 5bc:	aa0003e1 	mov	x1, x0
 5c0:	d28002a0 	mov	x0, #0x15                  	// #21
 5c4:	d4000001 	svc	#0x0
 5c8:	f84087e4 	ldr	x4, [sp], #8
 5cc:	d61f03c0 	br	x30

00000000000005d0 <kill>:
 5d0:	f81f8fe4 	str	x4, [sp, #-8]!
 5d4:	aa0303e4 	mov	x4, x3
 5d8:	aa0203e3 	mov	x3, x2
 5dc:	aa0103e2 	mov	x2, x1
 5e0:	aa0003e1 	mov	x1, x0
 5e4:	d28000c0 	mov	x0, #0x6                   	// #6
 5e8:	d4000001 	svc	#0x0
 5ec:	f84087e4 	ldr	x4, [sp], #8
 5f0:	d61f03c0 	br	x30

00000000000005f4 <exec>:
 5f4:	f81f8fe4 	str	x4, [sp, #-8]!
 5f8:	aa0303e4 	mov	x4, x3
 5fc:	aa0203e3 	mov	x3, x2
 600:	aa0103e2 	mov	x2, x1
 604:	aa0003e1 	mov	x1, x0
 608:	d28000e0 	mov	x0, #0x7                   	// #7
 60c:	d4000001 	svc	#0x0
 610:	f84087e4 	ldr	x4, [sp], #8
 614:	d61f03c0 	br	x30

0000000000000618 <open>:
 618:	f81f8fe4 	str	x4, [sp, #-8]!
 61c:	aa0303e4 	mov	x4, x3
 620:	aa0203e3 	mov	x3, x2
 624:	aa0103e2 	mov	x2, x1
 628:	aa0003e1 	mov	x1, x0
 62c:	d28001e0 	mov	x0, #0xf                   	// #15
 630:	d4000001 	svc	#0x0
 634:	f84087e4 	ldr	x4, [sp], #8
 638:	d61f03c0 	br	x30

000000000000063c <mknod>:
 63c:	f81f8fe4 	str	x4, [sp, #-8]!
 640:	aa0303e4 	mov	x4, x3
 644:	aa0203e3 	mov	x3, x2
 648:	aa0103e2 	mov	x2, x1
 64c:	aa0003e1 	mov	x1, x0
 650:	d2800220 	mov	x0, #0x11                  	// #17
 654:	d4000001 	svc	#0x0
 658:	f84087e4 	ldr	x4, [sp], #8
 65c:	d61f03c0 	br	x30

0000000000000660 <unlink>:
 660:	f81f8fe4 	str	x4, [sp, #-8]!
 664:	aa0303e4 	mov	x4, x3
 668:	aa0203e3 	mov	x3, x2
 66c:	aa0103e2 	mov	x2, x1
 670:	aa0003e1 	mov	x1, x0
 674:	d2800240 	mov	x0, #0x12                  	// #18
 678:	d4000001 	svc	#0x0
 67c:	f84087e4 	ldr	x4, [sp], #8
 680:	d61f03c0 	br	x30

0000000000000684 <fstat>:
 684:	f81f8fe4 	str	x4, [sp, #-8]!
 688:	aa0303e4 	mov	x4, x3
 68c:	aa0203e3 	mov	x3, x2
 690:	aa0103e2 	mov	x2, x1
 694:	aa0003e1 	mov	x1, x0
 698:	d2800100 	mov	x0, #0x8                   	// #8
 69c:	d4000001 	svc	#0x0
 6a0:	f84087e4 	ldr	x4, [sp], #8
 6a4:	d61f03c0 	br	x30

00000000000006a8 <link>:
 6a8:	f81f8fe4 	str	x4, [sp, #-8]!
 6ac:	aa0303e4 	mov	x4, x3
 6b0:	aa0203e3 	mov	x3, x2
 6b4:	aa0103e2 	mov	x2, x1
 6b8:	aa0003e1 	mov	x1, x0
 6bc:	d2800260 	mov	x0, #0x13                  	// #19
 6c0:	d4000001 	svc	#0x0
 6c4:	f84087e4 	ldr	x4, [sp], #8
 6c8:	d61f03c0 	br	x30

00000000000006cc <mkdir>:
 6cc:	f81f8fe4 	str	x4, [sp, #-8]!
 6d0:	aa0303e4 	mov	x4, x3
 6d4:	aa0203e3 	mov	x3, x2
 6d8:	aa0103e2 	mov	x2, x1
 6dc:	aa0003e1 	mov	x1, x0
 6e0:	d2800280 	mov	x0, #0x14                  	// #20
 6e4:	d4000001 	svc	#0x0
 6e8:	f84087e4 	ldr	x4, [sp], #8
 6ec:	d61f03c0 	br	x30

00000000000006f0 <chdir>:
 6f0:	f81f8fe4 	str	x4, [sp, #-8]!
 6f4:	aa0303e4 	mov	x4, x3
 6f8:	aa0203e3 	mov	x3, x2
 6fc:	aa0103e2 	mov	x2, x1
 700:	aa0003e1 	mov	x1, x0
 704:	d2800120 	mov	x0, #0x9                   	// #9
 708:	d4000001 	svc	#0x0
 70c:	f84087e4 	ldr	x4, [sp], #8
 710:	d61f03c0 	br	x30

0000000000000714 <dup>:
 714:	f81f8fe4 	str	x4, [sp, #-8]!
 718:	aa0303e4 	mov	x4, x3
 71c:	aa0203e3 	mov	x3, x2
 720:	aa0103e2 	mov	x2, x1
 724:	aa0003e1 	mov	x1, x0
 728:	d2800140 	mov	x0, #0xa                   	// #10
 72c:	d4000001 	svc	#0x0
 730:	f84087e4 	ldr	x4, [sp], #8
 734:	d61f03c0 	br	x30

0000000000000738 <getpid>:
 738:	f81f8fe4 	str	x4, [sp, #-8]!
 73c:	aa0303e4 	mov	x4, x3
 740:	aa0203e3 	mov	x3, x2
 744:	aa0103e2 	mov	x2, x1
 748:	aa0003e1 	mov	x1, x0
 74c:	d2800160 	mov	x0, #0xb                   	// #11
 750:	d4000001 	svc	#0x0
 754:	f84087e4 	ldr	x4, [sp], #8
 758:	d61f03c0 	br	x30

000000000000075c <sbrk>:
 75c:	f81f8fe4 	str	x4, [sp, #-8]!
 760:	aa0303e4 	mov	x4, x3
 764:	aa0203e3 	mov	x3, x2
 768:	aa0103e2 	mov	x2, x1
 76c:	aa0003e1 	mov	x1, x0
 770:	d2800180 	mov	x0, #0xc                   	// #12
 774:	d4000001 	svc	#0x0
 778:	f84087e4 	ldr	x4, [sp], #8
 77c:	d61f03c0 	br	x30

0000000000000780 <sleep>:
 780:	f81f8fe4 	str	x4, [sp, #-8]!
 784:	aa0303e4 	mov	x4, x3
 788:	aa0203e3 	mov	x3, x2
 78c:	aa0103e2 	mov	x2, x1
 790:	aa0003e1 	mov	x1, x0
 794:	d28001a0 	mov	x0, #0xd                   	// #13
 798:	d4000001 	svc	#0x0
 79c:	f84087e4 	ldr	x4, [sp], #8
 7a0:	d61f03c0 	br	x30

00000000000007a4 <uptime>:
 7a4:	f81f8fe4 	str	x4, [sp, #-8]!
 7a8:	aa0303e4 	mov	x4, x3
 7ac:	aa0203e3 	mov	x3, x2
 7b0:	aa0103e2 	mov	x2, x1
 7b4:	aa0003e1 	mov	x1, x0
 7b8:	d28001c0 	mov	x0, #0xe                   	// #14
 7bc:	d4000001 	svc	#0x0
 7c0:	f84087e4 	ldr	x4, [sp], #8
 7c4:	d61f03c0 	br	x30

00000000000007c8 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 7c8:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
 7cc:	910003fd 	mov	x29, sp
 7d0:	b9001fe0 	str	w0, [sp, #28]
 7d4:	39006fe1 	strb	w1, [sp, #27]
    write(fd, &c, 1);
 7d8:	91006fe0 	add	x0, sp, #0x1b
 7dc:	52800022 	mov	w2, #0x1                   	// #1
 7e0:	aa0003e1 	mov	x1, x0
 7e4:	b9401fe0 	ldr	w0, [sp, #28]
 7e8:	97ffff68 	bl	588 <write>
}
 7ec:	d503201f 	nop
 7f0:	a8c27bfd 	ldp	x29, x30, [sp], #32
 7f4:	d65f03c0 	ret

00000000000007f8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 7f8:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 7fc:	910003fd 	mov	x29, sp
 800:	b9001fe0 	str	w0, [sp, #28]
 804:	b9001be1 	str	w1, [sp, #24]
 808:	b90017e2 	str	w2, [sp, #20]
 80c:	b90013e3 	str	w3, [sp, #16]
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
 810:	b9003bff 	str	wzr, [sp, #56]
    if(sgn && xx < 0){
 814:	b94013e0 	ldr	w0, [sp, #16]
 818:	7100001f 	cmp	w0, #0x0
 81c:	54000140 	b.eq	844 <printint+0x4c>  // b.none
 820:	b9401be0 	ldr	w0, [sp, #24]
 824:	7100001f 	cmp	w0, #0x0
 828:	540000ea 	b.ge	844 <printint+0x4c>  // b.tcont
        neg = 1;
 82c:	52800020 	mov	w0, #0x1                   	// #1
 830:	b9003be0 	str	w0, [sp, #56]
        x = -xx;
 834:	b9401be0 	ldr	w0, [sp, #24]
 838:	4b0003e0 	neg	w0, w0
 83c:	b90037e0 	str	w0, [sp, #52]
 840:	14000003 	b	84c <printint+0x54>
    } else {
        x = xx;
 844:	b9401be0 	ldr	w0, [sp, #24]
 848:	b90037e0 	str	w0, [sp, #52]
    }
    
    i = 0;
 84c:	b9003fff 	str	wzr, [sp, #60]
    do{
        buf[i++] = digits[x % base];
 850:	b94017e1 	ldr	w1, [sp, #20]
 854:	b94037e0 	ldr	w0, [sp, #52]
 858:	1ac10802 	udiv	w2, w0, w1
 85c:	1b017c41 	mul	w1, w2, w1
 860:	4b010003 	sub	w3, w0, w1
 864:	b9403fe0 	ldr	w0, [sp, #60]
 868:	11000401 	add	w1, w0, #0x1
 86c:	b9003fe1 	str	w1, [sp, #60]
 870:	90000001 	adrp	x1, 0 <main>
 874:	913c6022 	add	x2, x1, #0xf18
 878:	2a0303e1 	mov	w1, w3
 87c:	38616842 	ldrb	w2, [x2, x1]
 880:	93407c00 	sxtw	x0, w0
 884:	910083e1 	add	x1, sp, #0x20
 888:	38206822 	strb	w2, [x1, x0]
    }while((x /= base) != 0);
 88c:	b94017e0 	ldr	w0, [sp, #20]
 890:	b94037e1 	ldr	w1, [sp, #52]
 894:	1ac00820 	udiv	w0, w1, w0
 898:	b90037e0 	str	w0, [sp, #52]
 89c:	b94037e0 	ldr	w0, [sp, #52]
 8a0:	7100001f 	cmp	w0, #0x0
 8a4:	54fffd61 	b.ne	850 <printint+0x58>  // b.any
    if(neg)
 8a8:	b9403be0 	ldr	w0, [sp, #56]
 8ac:	7100001f 	cmp	w0, #0x0
 8b0:	540001e0 	b.eq	8ec <printint+0xf4>  // b.none
        buf[i++] = '-';
 8b4:	b9403fe0 	ldr	w0, [sp, #60]
 8b8:	11000401 	add	w1, w0, #0x1
 8bc:	b9003fe1 	str	w1, [sp, #60]
 8c0:	93407c00 	sxtw	x0, w0
 8c4:	910083e1 	add	x1, sp, #0x20
 8c8:	528005a2 	mov	w2, #0x2d                  	// #45
 8cc:	38206822 	strb	w2, [x1, x0]
    
    while(--i >= 0)
 8d0:	14000007 	b	8ec <printint+0xf4>
        putc(fd, buf[i]);
 8d4:	b9803fe0 	ldrsw	x0, [sp, #60]
 8d8:	910083e1 	add	x1, sp, #0x20
 8dc:	38606820 	ldrb	w0, [x1, x0]
 8e0:	2a0003e1 	mov	w1, w0
 8e4:	b9401fe0 	ldr	w0, [sp, #28]
 8e8:	97ffffb8 	bl	7c8 <putc>
    while(--i >= 0)
 8ec:	b9403fe0 	ldr	w0, [sp, #60]
 8f0:	51000400 	sub	w0, w0, #0x1
 8f4:	b9003fe0 	str	w0, [sp, #60]
 8f8:	b9403fe0 	ldr	w0, [sp, #60]
 8fc:	7100001f 	cmp	w0, #0x0
 900:	54fffeaa 	b.ge	8d4 <printint+0xdc>  // b.tcont
}
 904:	d503201f 	nop
 908:	d503201f 	nop
 90c:	a8c47bfd 	ldp	x29, x30, [sp], #64
 910:	d65f03c0 	ret

0000000000000914 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 914:	a9b17bfd 	stp	x29, x30, [sp, #-240]!
 918:	910003fd 	mov	x29, sp
 91c:	b9001fe0 	str	w0, [sp, #28]
 920:	f9000be1 	str	x1, [sp, #16]
 924:	f90063e2 	str	x2, [sp, #192]
 928:	f90067e3 	str	x3, [sp, #200]
 92c:	f9006be4 	str	x4, [sp, #208]
 930:	f9006fe5 	str	x5, [sp, #216]
 934:	f90073e6 	str	x6, [sp, #224]
 938:	f90077e7 	str	x7, [sp, #232]
 93c:	3d8013e0 	str	q0, [sp, #64]
 940:	3d8017e1 	str	q1, [sp, #80]
 944:	3d801be2 	str	q2, [sp, #96]
 948:	3d801fe3 	str	q3, [sp, #112]
 94c:	3d8023e4 	str	q4, [sp, #128]
 950:	3d8027e5 	str	q5, [sp, #144]
 954:	3d802be6 	str	q6, [sp, #160]
 958:	3d802fe7 	str	q7, [sp, #176]
    char *s;
    int c, i, state;
    uint64 *ap;
    
    state = 0;
 95c:	b90033ff 	str	wzr, [sp, #48]
    ap = (uint64*)(void*)&fmt + 22;
 960:	910043e0 	add	x0, sp, #0x10
 964:	9102c000 	add	x0, x0, #0xb0
 968:	f90017e0 	str	x0, [sp, #40]
    for(i = 0; fmt[i]; i++){
 96c:	b90037ff 	str	wzr, [sp, #52]
 970:	14000076 	b	b48 <printf+0x234>
        c = fmt[i] & 0xff;
 974:	f9400be1 	ldr	x1, [sp, #16]
 978:	b98037e0 	ldrsw	x0, [sp, #52]
 97c:	8b000020 	add	x0, x1, x0
 980:	39400000 	ldrb	w0, [x0]
 984:	b90027e0 	str	w0, [sp, #36]
        if(state == 0){
 988:	b94033e0 	ldr	w0, [sp, #48]
 98c:	7100001f 	cmp	w0, #0x0
 990:	540001a1 	b.ne	9c4 <printf+0xb0>  // b.any
            if(c == '%'){
 994:	b94027e0 	ldr	w0, [sp, #36]
 998:	7100941f 	cmp	w0, #0x25
 99c:	54000081 	b.ne	9ac <printf+0x98>  // b.any
                state = '%';
 9a0:	528004a0 	mov	w0, #0x25                  	// #37
 9a4:	b90033e0 	str	w0, [sp, #48]
 9a8:	14000065 	b	b3c <printf+0x228>
            } else {
                putc(fd, c);
 9ac:	b94027e0 	ldr	w0, [sp, #36]
 9b0:	12001c00 	and	w0, w0, #0xff
 9b4:	2a0003e1 	mov	w1, w0
 9b8:	b9401fe0 	ldr	w0, [sp, #28]
 9bc:	97ffff83 	bl	7c8 <putc>
 9c0:	1400005f 	b	b3c <printf+0x228>
            }
        } else if(state == '%'){
 9c4:	b94033e0 	ldr	w0, [sp, #48]
 9c8:	7100941f 	cmp	w0, #0x25
 9cc:	54000b81 	b.ne	b3c <printf+0x228>  // b.any
            if(c == 'd'){
 9d0:	b94027e0 	ldr	w0, [sp, #36]
 9d4:	7101901f 	cmp	w0, #0x64
 9d8:	54000181 	b.ne	a08 <printf+0xf4>  // b.any
                printint(fd, *ap, 10, 1);
 9dc:	f94017e0 	ldr	x0, [sp, #40]
 9e0:	f9400000 	ldr	x0, [x0]
 9e4:	52800023 	mov	w3, #0x1                   	// #1
 9e8:	52800142 	mov	w2, #0xa                   	// #10
 9ec:	2a0003e1 	mov	w1, w0
 9f0:	b9401fe0 	ldr	w0, [sp, #28]
 9f4:	97ffff81 	bl	7f8 <printint>
                ap++;
 9f8:	f94017e0 	ldr	x0, [sp, #40]
 9fc:	91002000 	add	x0, x0, #0x8
 a00:	f90017e0 	str	x0, [sp, #40]
 a04:	1400004d 	b	b38 <printf+0x224>
            } else if(c == 'x' || c == 'p'){
 a08:	b94027e0 	ldr	w0, [sp, #36]
 a0c:	7101e01f 	cmp	w0, #0x78
 a10:	54000080 	b.eq	a20 <printf+0x10c>  // b.none
 a14:	b94027e0 	ldr	w0, [sp, #36]
 a18:	7101c01f 	cmp	w0, #0x70
 a1c:	54000181 	b.ne	a4c <printf+0x138>  // b.any
                printint(fd, *ap, 16, 0);
 a20:	f94017e0 	ldr	x0, [sp, #40]
 a24:	f9400000 	ldr	x0, [x0]
 a28:	52800003 	mov	w3, #0x0                   	// #0
 a2c:	52800202 	mov	w2, #0x10                  	// #16
 a30:	2a0003e1 	mov	w1, w0
 a34:	b9401fe0 	ldr	w0, [sp, #28]
 a38:	97ffff70 	bl	7f8 <printint>
                ap++;
 a3c:	f94017e0 	ldr	x0, [sp, #40]
 a40:	91002000 	add	x0, x0, #0x8
 a44:	f90017e0 	str	x0, [sp, #40]
 a48:	1400003c 	b	b38 <printf+0x224>
            } else if(c == 's'){
 a4c:	b94027e0 	ldr	w0, [sp, #36]
 a50:	7101cc1f 	cmp	w0, #0x73
 a54:	54000361 	b.ne	ac0 <printf+0x1ac>  // b.any
                s = (char*)*ap;
 a58:	f94017e0 	ldr	x0, [sp, #40]
 a5c:	f9400000 	ldr	x0, [x0]
 a60:	f9001fe0 	str	x0, [sp, #56]
                ap++;
 a64:	f94017e0 	ldr	x0, [sp, #40]
 a68:	91002000 	add	x0, x0, #0x8
 a6c:	f90017e0 	str	x0, [sp, #40]
                if(s == 0)
 a70:	f9401fe0 	ldr	x0, [sp, #56]
 a74:	f100001f 	cmp	x0, #0x0
 a78:	540001a1 	b.ne	aac <printf+0x198>  // b.any
                    s = "(null)";
 a7c:	90000000 	adrp	x0, 0 <main>
 a80:	913c4000 	add	x0, x0, #0xf10
 a84:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
 a88:	14000009 	b	aac <printf+0x198>
                    putc(fd, *s);
 a8c:	f9401fe0 	ldr	x0, [sp, #56]
 a90:	39400000 	ldrb	w0, [x0]
 a94:	2a0003e1 	mov	w1, w0
 a98:	b9401fe0 	ldr	w0, [sp, #28]
 a9c:	97ffff4b 	bl	7c8 <putc>
                    s++;
 aa0:	f9401fe0 	ldr	x0, [sp, #56]
 aa4:	91000400 	add	x0, x0, #0x1
 aa8:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
 aac:	f9401fe0 	ldr	x0, [sp, #56]
 ab0:	39400000 	ldrb	w0, [x0]
 ab4:	7100001f 	cmp	w0, #0x0
 ab8:	54fffea1 	b.ne	a8c <printf+0x178>  // b.any
 abc:	1400001f 	b	b38 <printf+0x224>
                }
            } else if(c == 'c'){
 ac0:	b94027e0 	ldr	w0, [sp, #36]
 ac4:	71018c1f 	cmp	w0, #0x63
 ac8:	54000161 	b.ne	af4 <printf+0x1e0>  // b.any
                putc(fd, *ap);
 acc:	f94017e0 	ldr	x0, [sp, #40]
 ad0:	f9400000 	ldr	x0, [x0]
 ad4:	12001c00 	and	w0, w0, #0xff
 ad8:	2a0003e1 	mov	w1, w0
 adc:	b9401fe0 	ldr	w0, [sp, #28]
 ae0:	97ffff3a 	bl	7c8 <putc>
                ap++;
 ae4:	f94017e0 	ldr	x0, [sp, #40]
 ae8:	91002000 	add	x0, x0, #0x8
 aec:	f90017e0 	str	x0, [sp, #40]
 af0:	14000012 	b	b38 <printf+0x224>
            } else if(c == '%'){
 af4:	b94027e0 	ldr	w0, [sp, #36]
 af8:	7100941f 	cmp	w0, #0x25
 afc:	540000e1 	b.ne	b18 <printf+0x204>  // b.any
                putc(fd, c);
 b00:	b94027e0 	ldr	w0, [sp, #36]
 b04:	12001c00 	and	w0, w0, #0xff
 b08:	2a0003e1 	mov	w1, w0
 b0c:	b9401fe0 	ldr	w0, [sp, #28]
 b10:	97ffff2e 	bl	7c8 <putc>
 b14:	14000009 	b	b38 <printf+0x224>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
 b18:	528004a1 	mov	w1, #0x25                  	// #37
 b1c:	b9401fe0 	ldr	w0, [sp, #28]
 b20:	97ffff2a 	bl	7c8 <putc>
                putc(fd, c);
 b24:	b94027e0 	ldr	w0, [sp, #36]
 b28:	12001c00 	and	w0, w0, #0xff
 b2c:	2a0003e1 	mov	w1, w0
 b30:	b9401fe0 	ldr	w0, [sp, #28]
 b34:	97ffff25 	bl	7c8 <putc>
            }
            state = 0;
 b38:	b90033ff 	str	wzr, [sp, #48]
    for(i = 0; fmt[i]; i++){
 b3c:	b94037e0 	ldr	w0, [sp, #52]
 b40:	11000400 	add	w0, w0, #0x1
 b44:	b90037e0 	str	w0, [sp, #52]
 b48:	f9400be1 	ldr	x1, [sp, #16]
 b4c:	b98037e0 	ldrsw	x0, [sp, #52]
 b50:	8b000020 	add	x0, x1, x0
 b54:	39400000 	ldrb	w0, [x0]
 b58:	7100001f 	cmp	w0, #0x0
 b5c:	54fff0c1 	b.ne	974 <printf+0x60>  // b.any
        }
    }
}
 b60:	d503201f 	nop
 b64:	d503201f 	nop
 b68:	a8cf7bfd 	ldp	x29, x30, [sp], #240
 b6c:	d65f03c0 	ret

0000000000000b70 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b70:	d10083ff 	sub	sp, sp, #0x20
 b74:	f90007e0 	str	x0, [sp, #8]
    Header *bp, *p;
    
    bp = (Header*)ap - 1;
 b78:	f94007e0 	ldr	x0, [sp, #8]
 b7c:	d1004000 	sub	x0, x0, #0x10
 b80:	f9000be0 	str	x0, [sp, #16]
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b84:	90000000 	adrp	x0, 0 <main>
 b88:	913d0000 	add	x0, x0, #0xf40
 b8c:	f9400000 	ldr	x0, [x0]
 b90:	f9000fe0 	str	x0, [sp, #24]
 b94:	14000012 	b	bdc <free+0x6c>
        if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b98:	f9400fe0 	ldr	x0, [sp, #24]
 b9c:	f9400000 	ldr	x0, [x0]
 ba0:	f9400fe1 	ldr	x1, [sp, #24]
 ba4:	eb00003f 	cmp	x1, x0
 ba8:	54000143 	b.cc	bd0 <free+0x60>  // b.lo, b.ul, b.last
 bac:	f9400be1 	ldr	x1, [sp, #16]
 bb0:	f9400fe0 	ldr	x0, [sp, #24]
 bb4:	eb00003f 	cmp	x1, x0
 bb8:	54000248 	b.hi	c00 <free+0x90>  // b.pmore
 bbc:	f9400fe0 	ldr	x0, [sp, #24]
 bc0:	f9400000 	ldr	x0, [x0]
 bc4:	f9400be1 	ldr	x1, [sp, #16]
 bc8:	eb00003f 	cmp	x1, x0
 bcc:	540001a3 	b.cc	c00 <free+0x90>  // b.lo, b.ul, b.last
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 bd0:	f9400fe0 	ldr	x0, [sp, #24]
 bd4:	f9400000 	ldr	x0, [x0]
 bd8:	f9000fe0 	str	x0, [sp, #24]
 bdc:	f9400be1 	ldr	x1, [sp, #16]
 be0:	f9400fe0 	ldr	x0, [sp, #24]
 be4:	eb00003f 	cmp	x1, x0
 be8:	54fffd89 	b.ls	b98 <free+0x28>  // b.plast
 bec:	f9400fe0 	ldr	x0, [sp, #24]
 bf0:	f9400000 	ldr	x0, [x0]
 bf4:	f9400be1 	ldr	x1, [sp, #16]
 bf8:	eb00003f 	cmp	x1, x0
 bfc:	54fffce2 	b.cs	b98 <free+0x28>  // b.hs, b.nlast
            break;
    if(bp + bp->s.size == p->s.ptr){
 c00:	f9400be0 	ldr	x0, [sp, #16]
 c04:	b9400800 	ldr	w0, [x0, #8]
 c08:	2a0003e0 	mov	w0, w0
 c0c:	d37cec00 	lsl	x0, x0, #4
 c10:	f9400be1 	ldr	x1, [sp, #16]
 c14:	8b000021 	add	x1, x1, x0
 c18:	f9400fe0 	ldr	x0, [sp, #24]
 c1c:	f9400000 	ldr	x0, [x0]
 c20:	eb00003f 	cmp	x1, x0
 c24:	540001e1 	b.ne	c60 <free+0xf0>  // b.any
        bp->s.size += p->s.ptr->s.size;
 c28:	f9400be0 	ldr	x0, [sp, #16]
 c2c:	b9400801 	ldr	w1, [x0, #8]
 c30:	f9400fe0 	ldr	x0, [sp, #24]
 c34:	f9400000 	ldr	x0, [x0]
 c38:	b9400800 	ldr	w0, [x0, #8]
 c3c:	0b000021 	add	w1, w1, w0
 c40:	f9400be0 	ldr	x0, [sp, #16]
 c44:	b9000801 	str	w1, [x0, #8]
        bp->s.ptr = p->s.ptr->s.ptr;
 c48:	f9400fe0 	ldr	x0, [sp, #24]
 c4c:	f9400000 	ldr	x0, [x0]
 c50:	f9400001 	ldr	x1, [x0]
 c54:	f9400be0 	ldr	x0, [sp, #16]
 c58:	f9000001 	str	x1, [x0]
 c5c:	14000005 	b	c70 <free+0x100>
    } else
        bp->s.ptr = p->s.ptr;
 c60:	f9400fe0 	ldr	x0, [sp, #24]
 c64:	f9400001 	ldr	x1, [x0]
 c68:	f9400be0 	ldr	x0, [sp, #16]
 c6c:	f9000001 	str	x1, [x0]
    if(p + p->s.size == bp){
 c70:	f9400fe0 	ldr	x0, [sp, #24]
 c74:	b9400800 	ldr	w0, [x0, #8]
 c78:	2a0003e0 	mov	w0, w0
 c7c:	d37cec00 	lsl	x0, x0, #4
 c80:	f9400fe1 	ldr	x1, [sp, #24]
 c84:	8b000020 	add	x0, x1, x0
 c88:	f9400be1 	ldr	x1, [sp, #16]
 c8c:	eb00003f 	cmp	x1, x0
 c90:	540001a1 	b.ne	cc4 <free+0x154>  // b.any
        p->s.size += bp->s.size;
 c94:	f9400fe0 	ldr	x0, [sp, #24]
 c98:	b9400801 	ldr	w1, [x0, #8]
 c9c:	f9400be0 	ldr	x0, [sp, #16]
 ca0:	b9400800 	ldr	w0, [x0, #8]
 ca4:	0b000021 	add	w1, w1, w0
 ca8:	f9400fe0 	ldr	x0, [sp, #24]
 cac:	b9000801 	str	w1, [x0, #8]
        p->s.ptr = bp->s.ptr;
 cb0:	f9400be0 	ldr	x0, [sp, #16]
 cb4:	f9400001 	ldr	x1, [x0]
 cb8:	f9400fe0 	ldr	x0, [sp, #24]
 cbc:	f9000001 	str	x1, [x0]
 cc0:	14000004 	b	cd0 <free+0x160>
    } else
        p->s.ptr = bp;
 cc4:	f9400fe0 	ldr	x0, [sp, #24]
 cc8:	f9400be1 	ldr	x1, [sp, #16]
 ccc:	f9000001 	str	x1, [x0]
    freep = p;
 cd0:	90000000 	adrp	x0, 0 <main>
 cd4:	913d0000 	add	x0, x0, #0xf40
 cd8:	f9400fe1 	ldr	x1, [sp, #24]
 cdc:	f9000001 	str	x1, [x0]
}
 ce0:	d503201f 	nop
 ce4:	910083ff 	add	sp, sp, #0x20
 ce8:	d65f03c0 	ret

0000000000000cec <morecore>:

static Header*
morecore(uint nu)
{
 cec:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 cf0:	910003fd 	mov	x29, sp
 cf4:	b9001fe0 	str	w0, [sp, #28]
    char *p;
    Header *hp;
    
    if(nu < 4096)
 cf8:	b9401fe0 	ldr	w0, [sp, #28]
 cfc:	713ffc1f 	cmp	w0, #0xfff
 d00:	54000068 	b.hi	d0c <morecore+0x20>  // b.pmore
        nu = 4096;
 d04:	52820000 	mov	w0, #0x1000                	// #4096
 d08:	b9001fe0 	str	w0, [sp, #28]
    p = sbrk(nu * sizeof(Header));
 d0c:	b9401fe0 	ldr	w0, [sp, #28]
 d10:	531c6c00 	lsl	w0, w0, #4
 d14:	97fffe92 	bl	75c <sbrk>
 d18:	f90017e0 	str	x0, [sp, #40]
    if(p == (char*)-1)
 d1c:	f94017e0 	ldr	x0, [sp, #40]
 d20:	b100041f 	cmn	x0, #0x1
 d24:	54000061 	b.ne	d30 <morecore+0x44>  // b.any
        return 0;
 d28:	d2800000 	mov	x0, #0x0                   	// #0
 d2c:	1400000c 	b	d5c <morecore+0x70>
    hp = (Header*)p;
 d30:	f94017e0 	ldr	x0, [sp, #40]
 d34:	f90013e0 	str	x0, [sp, #32]
    hp->s.size = nu;
 d38:	f94013e0 	ldr	x0, [sp, #32]
 d3c:	b9401fe1 	ldr	w1, [sp, #28]
 d40:	b9000801 	str	w1, [x0, #8]
    free((void*)(hp + 1));
 d44:	f94013e0 	ldr	x0, [sp, #32]
 d48:	91004000 	add	x0, x0, #0x10
 d4c:	97ffff89 	bl	b70 <free>
    return freep;
 d50:	90000000 	adrp	x0, 0 <main>
 d54:	913d0000 	add	x0, x0, #0xf40
 d58:	f9400000 	ldr	x0, [x0]
}
 d5c:	a8c37bfd 	ldp	x29, x30, [sp], #48
 d60:	d65f03c0 	ret

0000000000000d64 <malloc>:

void*
malloc(uint nbytes)
{
 d64:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 d68:	910003fd 	mov	x29, sp
 d6c:	b9001fe0 	str	w0, [sp, #28]
    Header *p, *prevp;
    uint nunits;
    
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d70:	b9401fe0 	ldr	w0, [sp, #28]
 d74:	91003c00 	add	x0, x0, #0xf
 d78:	d344fc00 	lsr	x0, x0, #4
 d7c:	11000400 	add	w0, w0, #0x1
 d80:	b9002fe0 	str	w0, [sp, #44]
    if((prevp = freep) == 0){
 d84:	90000000 	adrp	x0, 0 <main>
 d88:	913d0000 	add	x0, x0, #0xf40
 d8c:	f9400000 	ldr	x0, [x0]
 d90:	f9001be0 	str	x0, [sp, #48]
 d94:	f9401be0 	ldr	x0, [sp, #48]
 d98:	f100001f 	cmp	x0, #0x0
 d9c:	54000221 	b.ne	de0 <malloc+0x7c>  // b.any
        base.s.ptr = freep = prevp = &base;
 da0:	90000000 	adrp	x0, 0 <main>
 da4:	913cc000 	add	x0, x0, #0xf30
 da8:	f9001be0 	str	x0, [sp, #48]
 dac:	90000000 	adrp	x0, 0 <main>
 db0:	913d0000 	add	x0, x0, #0xf40
 db4:	f9401be1 	ldr	x1, [sp, #48]
 db8:	f9000001 	str	x1, [x0]
 dbc:	90000000 	adrp	x0, 0 <main>
 dc0:	913d0000 	add	x0, x0, #0xf40
 dc4:	f9400001 	ldr	x1, [x0]
 dc8:	90000000 	adrp	x0, 0 <main>
 dcc:	913cc000 	add	x0, x0, #0xf30
 dd0:	f9000001 	str	x1, [x0]
        base.s.size = 0;
 dd4:	90000000 	adrp	x0, 0 <main>
 dd8:	913cc000 	add	x0, x0, #0xf30
 ddc:	b900081f 	str	wzr, [x0, #8]
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 de0:	f9401be0 	ldr	x0, [sp, #48]
 de4:	f9400000 	ldr	x0, [x0]
 de8:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
 dec:	f9401fe0 	ldr	x0, [sp, #56]
 df0:	b9400800 	ldr	w0, [x0, #8]
 df4:	b9402fe1 	ldr	w1, [sp, #44]
 df8:	6b00003f 	cmp	w1, w0
 dfc:	54000448 	b.hi	e84 <malloc+0x120>  // b.pmore
            if(p->s.size == nunits)
 e00:	f9401fe0 	ldr	x0, [sp, #56]
 e04:	b9400800 	ldr	w0, [x0, #8]
 e08:	b9402fe1 	ldr	w1, [sp, #44]
 e0c:	6b00003f 	cmp	w1, w0
 e10:	540000c1 	b.ne	e28 <malloc+0xc4>  // b.any
                prevp->s.ptr = p->s.ptr;
 e14:	f9401fe0 	ldr	x0, [sp, #56]
 e18:	f9400001 	ldr	x1, [x0]
 e1c:	f9401be0 	ldr	x0, [sp, #48]
 e20:	f9000001 	str	x1, [x0]
 e24:	14000011 	b	e68 <malloc+0x104>
            else {
                p->s.size -= nunits;
 e28:	f9401fe0 	ldr	x0, [sp, #56]
 e2c:	b9400801 	ldr	w1, [x0, #8]
 e30:	b9402fe0 	ldr	w0, [sp, #44]
 e34:	4b000021 	sub	w1, w1, w0
 e38:	f9401fe0 	ldr	x0, [sp, #56]
 e3c:	b9000801 	str	w1, [x0, #8]
                p += p->s.size;
 e40:	f9401fe0 	ldr	x0, [sp, #56]
 e44:	b9400800 	ldr	w0, [x0, #8]
 e48:	2a0003e0 	mov	w0, w0
 e4c:	d37cec00 	lsl	x0, x0, #4
 e50:	f9401fe1 	ldr	x1, [sp, #56]
 e54:	8b000020 	add	x0, x1, x0
 e58:	f9001fe0 	str	x0, [sp, #56]
                p->s.size = nunits;
 e5c:	f9401fe0 	ldr	x0, [sp, #56]
 e60:	b9402fe1 	ldr	w1, [sp, #44]
 e64:	b9000801 	str	w1, [x0, #8]
            }
            freep = prevp;
 e68:	90000000 	adrp	x0, 0 <main>
 e6c:	913d0000 	add	x0, x0, #0xf40
 e70:	f9401be1 	ldr	x1, [sp, #48]
 e74:	f9000001 	str	x1, [x0]
            return (void*)(p + 1);
 e78:	f9401fe0 	ldr	x0, [sp, #56]
 e7c:	91004000 	add	x0, x0, #0x10
 e80:	14000015 	b	ed4 <malloc+0x170>
        }
        if(p == freep)
 e84:	90000000 	adrp	x0, 0 <main>
 e88:	913d0000 	add	x0, x0, #0xf40
 e8c:	f9400000 	ldr	x0, [x0]
 e90:	f9401fe1 	ldr	x1, [sp, #56]
 e94:	eb00003f 	cmp	x1, x0
 e98:	54000121 	b.ne	ebc <malloc+0x158>  // b.any
            if((p = morecore(nunits)) == 0)
 e9c:	b9402fe0 	ldr	w0, [sp, #44]
 ea0:	97ffff93 	bl	cec <morecore>
 ea4:	f9001fe0 	str	x0, [sp, #56]
 ea8:	f9401fe0 	ldr	x0, [sp, #56]
 eac:	f100001f 	cmp	x0, #0x0
 eb0:	54000061 	b.ne	ebc <malloc+0x158>  // b.any
                return 0;
 eb4:	d2800000 	mov	x0, #0x0                   	// #0
 eb8:	14000007 	b	ed4 <malloc+0x170>
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ebc:	f9401fe0 	ldr	x0, [sp, #56]
 ec0:	f9001be0 	str	x0, [sp, #48]
 ec4:	f9401fe0 	ldr	x0, [sp, #56]
 ec8:	f9400000 	ldr	x0, [x0]
 ecc:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
 ed0:	17ffffc7 	b	dec <malloc+0x88>
    }
}
 ed4:	a8c47bfd 	ldp	x29, x30, [sp], #64
 ed8:	d65f03c0 	ret
