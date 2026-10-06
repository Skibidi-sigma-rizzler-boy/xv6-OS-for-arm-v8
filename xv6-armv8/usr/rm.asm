
_rm:     file format elf64-littleaarch64


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
    
    if(argc < 2){
  10:	b9401fe0 	ldr	w0, [sp, #28]
  14:	7100041f 	cmp	w0, #0x1
  18:	540000cc 	b.gt	30 <main+0x30>
        printf(2, "Usage: rm files...\n");
  1c:	90000000 	adrp	x0, 0 <main>
  20:	913be001 	add	x1, x0, #0xef8
  24:	52800040 	mov	w0, #0x2                   	// #2
  28:	94000241 	bl	92c <printf>
        exit();
  2c:	94000139 	bl	510 <exit>
    }
    
    for(i = 1; i < argc; i++){
  30:	52800020 	mov	w0, #0x1                   	// #1
  34:	b9002fe0 	str	w0, [sp, #44]
  38:	14000017 	b	94 <main+0x94>
        if(unlink(argv[i]) < 0){
  3c:	b9802fe0 	ldrsw	x0, [sp, #44]
  40:	d37df000 	lsl	x0, x0, #3
  44:	f9400be1 	ldr	x1, [sp, #16]
  48:	8b000020 	add	x0, x1, x0
  4c:	f9400000 	ldr	x0, [x0]
  50:	9400018a 	bl	678 <unlink>
  54:	7100001f 	cmp	w0, #0x0
  58:	5400018a 	b.ge	88 <main+0x88>  // b.tcont
            printf(2, "rm: %s failed to delete\n", argv[i]);
  5c:	b9802fe0 	ldrsw	x0, [sp, #44]
  60:	d37df000 	lsl	x0, x0, #3
  64:	f9400be1 	ldr	x1, [sp, #16]
  68:	8b000020 	add	x0, x1, x0
  6c:	f9400000 	ldr	x0, [x0]
  70:	aa0003e2 	mov	x2, x0
  74:	90000000 	adrp	x0, 0 <main>
  78:	913c4001 	add	x1, x0, #0xf10
  7c:	52800040 	mov	w0, #0x2                   	// #2
  80:	9400022b 	bl	92c <printf>
            break;
  84:	14000008 	b	a4 <main+0xa4>
    for(i = 1; i < argc; i++){
  88:	b9402fe0 	ldr	w0, [sp, #44]
  8c:	11000400 	add	w0, w0, #0x1
  90:	b9002fe0 	str	w0, [sp, #44]
  94:	b9402fe1 	ldr	w1, [sp, #44]
  98:	b9401fe0 	ldr	w0, [sp, #28]
  9c:	6b00003f 	cmp	w1, w0
  a0:	54fffceb 	b.lt	3c <main+0x3c>  // b.tstop
        }
    }
    
    exit();
  a4:	9400011b 	bl	510 <exit>

00000000000000a8 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  a8:	d10083ff 	sub	sp, sp, #0x20
  ac:	f90007e0 	str	x0, [sp, #8]
  b0:	f90003e1 	str	x1, [sp]
    char *os;
    
    os = s;
  b4:	f94007e0 	ldr	x0, [sp, #8]
  b8:	f9000fe0 	str	x0, [sp, #24]
    while((*s++ = *t++) != 0)
  bc:	d503201f 	nop
  c0:	f94003e1 	ldr	x1, [sp]
  c4:	91000420 	add	x0, x1, #0x1
  c8:	f90003e0 	str	x0, [sp]
  cc:	f94007e0 	ldr	x0, [sp, #8]
  d0:	91000402 	add	x2, x0, #0x1
  d4:	f90007e2 	str	x2, [sp, #8]
  d8:	39400021 	ldrb	w1, [x1]
  dc:	39000001 	strb	w1, [x0]
  e0:	39400000 	ldrb	w0, [x0]
  e4:	7100001f 	cmp	w0, #0x0
  e8:	54fffec1 	b.ne	c0 <strcpy+0x18>  // b.any
        ;
    return os;
  ec:	f9400fe0 	ldr	x0, [sp, #24]
}
  f0:	910083ff 	add	sp, sp, #0x20
  f4:	d65f03c0 	ret

00000000000000f8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  f8:	d10043ff 	sub	sp, sp, #0x10
  fc:	f90007e0 	str	x0, [sp, #8]
 100:	f90003e1 	str	x1, [sp]
    while(*p && *p == *q)
 104:	14000007 	b	120 <strcmp+0x28>
        p++, q++;
 108:	f94007e0 	ldr	x0, [sp, #8]
 10c:	91000400 	add	x0, x0, #0x1
 110:	f90007e0 	str	x0, [sp, #8]
 114:	f94003e0 	ldr	x0, [sp]
 118:	91000400 	add	x0, x0, #0x1
 11c:	f90003e0 	str	x0, [sp]
    while(*p && *p == *q)
 120:	f94007e0 	ldr	x0, [sp, #8]
 124:	39400000 	ldrb	w0, [x0]
 128:	7100001f 	cmp	w0, #0x0
 12c:	540000e0 	b.eq	148 <strcmp+0x50>  // b.none
 130:	f94007e0 	ldr	x0, [sp, #8]
 134:	39400001 	ldrb	w1, [x0]
 138:	f94003e0 	ldr	x0, [sp]
 13c:	39400000 	ldrb	w0, [x0]
 140:	6b00003f 	cmp	w1, w0
 144:	54fffe20 	b.eq	108 <strcmp+0x10>  // b.none
    return (uchar)*p - (uchar)*q;
 148:	f94007e0 	ldr	x0, [sp, #8]
 14c:	39400000 	ldrb	w0, [x0]
 150:	2a0003e1 	mov	w1, w0
 154:	f94003e0 	ldr	x0, [sp]
 158:	39400000 	ldrb	w0, [x0]
 15c:	4b000020 	sub	w0, w1, w0
}
 160:	910043ff 	add	sp, sp, #0x10
 164:	d65f03c0 	ret

0000000000000168 <strlen>:

uint
strlen(char *s)
{
 168:	d10083ff 	sub	sp, sp, #0x20
 16c:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    for(n = 0; s[n]; n++)
 170:	b9001fff 	str	wzr, [sp, #28]
 174:	14000004 	b	184 <strlen+0x1c>
 178:	b9401fe0 	ldr	w0, [sp, #28]
 17c:	11000400 	add	w0, w0, #0x1
 180:	b9001fe0 	str	w0, [sp, #28]
 184:	b9801fe0 	ldrsw	x0, [sp, #28]
 188:	f94007e1 	ldr	x1, [sp, #8]
 18c:	8b000020 	add	x0, x1, x0
 190:	39400000 	ldrb	w0, [x0]
 194:	7100001f 	cmp	w0, #0x0
 198:	54ffff01 	b.ne	178 <strlen+0x10>  // b.any
        ;
    return n;
 19c:	b9401fe0 	ldr	w0, [sp, #28]
}
 1a0:	910083ff 	add	sp, sp, #0x20
 1a4:	d65f03c0 	ret

00000000000001a8 <memset>:

void*
memset(void *dst, int v, uint n)
{
 1a8:	d100c3ff 	sub	sp, sp, #0x30
 1ac:	f90007e0 	str	x0, [sp, #8]
 1b0:	b90007e1 	str	w1, [sp, #4]
 1b4:	b90003e2 	str	w2, [sp]
	uint8	*p;
	uint8	c;
	uint32	val;
	uint32	*p4;

	p   = dst;
 1b8:	f94007e0 	ldr	x0, [sp, #8]
 1bc:	f90017e0 	str	x0, [sp, #40]
	c   = v & 0xff;
 1c0:	b94007e0 	ldr	w0, [sp, #4]
 1c4:	39007fe0 	strb	w0, [sp, #31]
	val = (c << 24) | (c << 16) | (c << 8) | c;
 1c8:	39407fe1 	ldrb	w1, [sp, #31]
 1cc:	2a0103e0 	mov	w0, w1
 1d0:	53185c00 	lsl	w0, w0, #8
 1d4:	0b010000 	add	w0, w0, w1
 1d8:	53103c00 	lsl	w0, w0, #16
 1dc:	2a0003e1 	mov	w1, w0
 1e0:	39407fe0 	ldrb	w0, [sp, #31]
 1e4:	53185c00 	lsl	w0, w0, #8
 1e8:	2a000021 	orr	w1, w1, w0
 1ec:	39407fe0 	ldrb	w0, [sp, #31]
 1f0:	2a000020 	orr	w0, w1, w0
 1f4:	b9001be0 	str	w0, [sp, #24]

	// set bytes before whole uint32
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
 1f8:	1400000a 	b	220 <memset+0x78>
		*p = c;
 1fc:	f94017e0 	ldr	x0, [sp, #40]
 200:	39407fe1 	ldrb	w1, [sp, #31]
 204:	39000001 	strb	w1, [x0]
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
 208:	b94003e0 	ldr	w0, [sp]
 20c:	51000400 	sub	w0, w0, #0x1
 210:	b90003e0 	str	w0, [sp]
 214:	f94017e0 	ldr	x0, [sp, #40]
 218:	91000400 	add	x0, x0, #0x1
 21c:	f90017e0 	str	x0, [sp, #40]
 220:	b94003e0 	ldr	w0, [sp]
 224:	7100001f 	cmp	w0, #0x0
 228:	540000a0 	b.eq	23c <memset+0x94>  // b.none
 22c:	f94017e0 	ldr	x0, [sp, #40]
 230:	92400400 	and	x0, x0, #0x3
 234:	f100001f 	cmp	x0, #0x0
 238:	54fffe21 	b.ne	1fc <memset+0x54>  // b.any
	}

	// set memory 4 bytes a time
	p4 = (uint*)p;
 23c:	f94017e0 	ldr	x0, [sp, #40]
 240:	f90013e0 	str	x0, [sp, #32]

	for (; n >= 4; n -= 4, p4++) {
 244:	1400000a 	b	26c <memset+0xc4>
		*p4 = val;
 248:	f94013e0 	ldr	x0, [sp, #32]
 24c:	b9401be1 	ldr	w1, [sp, #24]
 250:	b9000001 	str	w1, [x0]
	for (; n >= 4; n -= 4, p4++) {
 254:	b94003e0 	ldr	w0, [sp]
 258:	51001000 	sub	w0, w0, #0x4
 25c:	b90003e0 	str	w0, [sp]
 260:	f94013e0 	ldr	x0, [sp, #32]
 264:	91001000 	add	x0, x0, #0x4
 268:	f90013e0 	str	x0, [sp, #32]
 26c:	b94003e0 	ldr	w0, [sp]
 270:	71000c1f 	cmp	w0, #0x3
 274:	54fffea8 	b.hi	248 <memset+0xa0>  // b.pmore
	}

	// set leftover one byte a time
	p = (uint8*)p4;
 278:	f94013e0 	ldr	x0, [sp, #32]
 27c:	f90017e0 	str	x0, [sp, #40]

	for (; n > 0; n--, p++) {
 280:	1400000a 	b	2a8 <memset+0x100>
		*p = c;
 284:	f94017e0 	ldr	x0, [sp, #40]
 288:	39407fe1 	ldrb	w1, [sp, #31]
 28c:	39000001 	strb	w1, [x0]
	for (; n > 0; n--, p++) {
 290:	b94003e0 	ldr	w0, [sp]
 294:	51000400 	sub	w0, w0, #0x1
 298:	b90003e0 	str	w0, [sp]
 29c:	f94017e0 	ldr	x0, [sp, #40]
 2a0:	91000400 	add	x0, x0, #0x1
 2a4:	f90017e0 	str	x0, [sp, #40]
 2a8:	b94003e0 	ldr	w0, [sp]
 2ac:	7100001f 	cmp	w0, #0x0
 2b0:	54fffea1 	b.ne	284 <memset+0xdc>  // b.any
	}

	return dst;
 2b4:	f94007e0 	ldr	x0, [sp, #8]
}
 2b8:	9100c3ff 	add	sp, sp, #0x30
 2bc:	d65f03c0 	ret

00000000000002c0 <strchr>:

char*
strchr(const char *s, char c)
{
 2c0:	d10043ff 	sub	sp, sp, #0x10
 2c4:	f90007e0 	str	x0, [sp, #8]
 2c8:	39001fe1 	strb	w1, [sp, #7]
    for(; *s; s++)
 2cc:	1400000b 	b	2f8 <strchr+0x38>
        if(*s == c)
 2d0:	f94007e0 	ldr	x0, [sp, #8]
 2d4:	39400000 	ldrb	w0, [x0]
 2d8:	39401fe1 	ldrb	w1, [sp, #7]
 2dc:	6b00003f 	cmp	w1, w0
 2e0:	54000061 	b.ne	2ec <strchr+0x2c>  // b.any
            return (char*)s;
 2e4:	f94007e0 	ldr	x0, [sp, #8]
 2e8:	14000009 	b	30c <strchr+0x4c>
    for(; *s; s++)
 2ec:	f94007e0 	ldr	x0, [sp, #8]
 2f0:	91000400 	add	x0, x0, #0x1
 2f4:	f90007e0 	str	x0, [sp, #8]
 2f8:	f94007e0 	ldr	x0, [sp, #8]
 2fc:	39400000 	ldrb	w0, [x0]
 300:	7100001f 	cmp	w0, #0x0
 304:	54fffe61 	b.ne	2d0 <strchr+0x10>  // b.any
    return 0;
 308:	d2800000 	mov	x0, #0x0                   	// #0
}
 30c:	910043ff 	add	sp, sp, #0x10
 310:	d65f03c0 	ret

0000000000000314 <gets>:

char*
gets(char *buf, int max)
{
 314:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 318:	910003fd 	mov	x29, sp
 31c:	f9000fe0 	str	x0, [sp, #24]
 320:	b90017e1 	str	w1, [sp, #20]
    int i, cc;
    char c;
    
    for(i=0; i+1 < max; ){
 324:	b9002fff 	str	wzr, [sp, #44]
 328:	14000018 	b	388 <gets+0x74>
        cc = read(0, &c, 1);
 32c:	91009fe0 	add	x0, sp, #0x27
 330:	52800022 	mov	w2, #0x1                   	// #1
 334:	aa0003e1 	mov	x1, x0
 338:	52800000 	mov	w0, #0x0                   	// #0
 33c:	94000090 	bl	57c <read>
 340:	b9002be0 	str	w0, [sp, #40]
        if(cc < 1)
 344:	b9402be0 	ldr	w0, [sp, #40]
 348:	7100001f 	cmp	w0, #0x0
 34c:	540002ad 	b.le	3a0 <gets+0x8c>
            break;
        buf[i++] = c;
 350:	b9402fe0 	ldr	w0, [sp, #44]
 354:	11000401 	add	w1, w0, #0x1
 358:	b9002fe1 	str	w1, [sp, #44]
 35c:	93407c00 	sxtw	x0, w0
 360:	f9400fe1 	ldr	x1, [sp, #24]
 364:	8b000020 	add	x0, x1, x0
 368:	39409fe1 	ldrb	w1, [sp, #39]
 36c:	39000001 	strb	w1, [x0]
        if(c == '\n' || c == '\r')
 370:	39409fe0 	ldrb	w0, [sp, #39]
 374:	7100281f 	cmp	w0, #0xa
 378:	54000160 	b.eq	3a4 <gets+0x90>  // b.none
 37c:	39409fe0 	ldrb	w0, [sp, #39]
 380:	7100341f 	cmp	w0, #0xd
 384:	54000100 	b.eq	3a4 <gets+0x90>  // b.none
    for(i=0; i+1 < max; ){
 388:	b9402fe0 	ldr	w0, [sp, #44]
 38c:	11000400 	add	w0, w0, #0x1
 390:	b94017e1 	ldr	w1, [sp, #20]
 394:	6b00003f 	cmp	w1, w0
 398:	54fffcac 	b.gt	32c <gets+0x18>
 39c:	14000002 	b	3a4 <gets+0x90>
            break;
 3a0:	d503201f 	nop
            break;
    }
    buf[i] = '\0';
 3a4:	b9802fe0 	ldrsw	x0, [sp, #44]
 3a8:	f9400fe1 	ldr	x1, [sp, #24]
 3ac:	8b000020 	add	x0, x1, x0
 3b0:	3900001f 	strb	wzr, [x0]
    return buf;
 3b4:	f9400fe0 	ldr	x0, [sp, #24]
}
 3b8:	a8c37bfd 	ldp	x29, x30, [sp], #48
 3bc:	d65f03c0 	ret

00000000000003c0 <stat>:

int
stat(char *n, struct stat *st)
{
 3c0:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 3c4:	910003fd 	mov	x29, sp
 3c8:	f9000fe0 	str	x0, [sp, #24]
 3cc:	f9000be1 	str	x1, [sp, #16]
    int fd;
    int r;
    
    fd = open(n, O_RDONLY);
 3d0:	52800001 	mov	w1, #0x0                   	// #0
 3d4:	f9400fe0 	ldr	x0, [sp, #24]
 3d8:	94000096 	bl	630 <open>
 3dc:	b9002fe0 	str	w0, [sp, #44]
    if(fd < 0)
 3e0:	b9402fe0 	ldr	w0, [sp, #44]
 3e4:	7100001f 	cmp	w0, #0x0
 3e8:	5400006a 	b.ge	3f4 <stat+0x34>  // b.tcont
        return -1;
 3ec:	12800000 	mov	w0, #0xffffffff            	// #-1
 3f0:	14000008 	b	410 <stat+0x50>
    r = fstat(fd, st);
 3f4:	f9400be1 	ldr	x1, [sp, #16]
 3f8:	b9402fe0 	ldr	w0, [sp, #44]
 3fc:	940000a8 	bl	69c <fstat>
 400:	b9002be0 	str	w0, [sp, #40]
    close(fd);
 404:	b9402fe0 	ldr	w0, [sp, #44]
 408:	9400006f 	bl	5c4 <close>
    return r;
 40c:	b9402be0 	ldr	w0, [sp, #40]
}
 410:	a8c37bfd 	ldp	x29, x30, [sp], #48
 414:	d65f03c0 	ret

0000000000000418 <atoi>:

int
atoi(const char *s)
{
 418:	d10083ff 	sub	sp, sp, #0x20
 41c:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    n = 0;
 420:	b9001fff 	str	wzr, [sp, #28]
    while('0' <= *s && *s <= '9')
 424:	1400000e 	b	45c <atoi+0x44>
        n = n*10 + *s++ - '0';
 428:	b9401fe1 	ldr	w1, [sp, #28]
 42c:	2a0103e0 	mov	w0, w1
 430:	531e7400 	lsl	w0, w0, #2
 434:	0b010000 	add	w0, w0, w1
 438:	531f7800 	lsl	w0, w0, #1
 43c:	2a0003e2 	mov	w2, w0
 440:	f94007e0 	ldr	x0, [sp, #8]
 444:	91000401 	add	x1, x0, #0x1
 448:	f90007e1 	str	x1, [sp, #8]
 44c:	39400000 	ldrb	w0, [x0]
 450:	0b000040 	add	w0, w2, w0
 454:	5100c000 	sub	w0, w0, #0x30
 458:	b9001fe0 	str	w0, [sp, #28]
    while('0' <= *s && *s <= '9')
 45c:	f94007e0 	ldr	x0, [sp, #8]
 460:	39400000 	ldrb	w0, [x0]
 464:	7100bc1f 	cmp	w0, #0x2f
 468:	540000a9 	b.ls	47c <atoi+0x64>  // b.plast
 46c:	f94007e0 	ldr	x0, [sp, #8]
 470:	39400000 	ldrb	w0, [x0]
 474:	7100e41f 	cmp	w0, #0x39
 478:	54fffd89 	b.ls	428 <atoi+0x10>  // b.plast
    return n;
 47c:	b9401fe0 	ldr	w0, [sp, #28]
}
 480:	910083ff 	add	sp, sp, #0x20
 484:	d65f03c0 	ret

0000000000000488 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 488:	d100c3ff 	sub	sp, sp, #0x30
 48c:	f9000fe0 	str	x0, [sp, #24]
 490:	f9000be1 	str	x1, [sp, #16]
 494:	b9000fe2 	str	w2, [sp, #12]
    char *dst, *src;
    
    dst = vdst;
 498:	f9400fe0 	ldr	x0, [sp, #24]
 49c:	f90017e0 	str	x0, [sp, #40]
    src = vsrc;
 4a0:	f9400be0 	ldr	x0, [sp, #16]
 4a4:	f90013e0 	str	x0, [sp, #32]
    while(n-- > 0)
 4a8:	14000009 	b	4cc <memmove+0x44>
        *dst++ = *src++;
 4ac:	f94013e1 	ldr	x1, [sp, #32]
 4b0:	91000420 	add	x0, x1, #0x1
 4b4:	f90013e0 	str	x0, [sp, #32]
 4b8:	f94017e0 	ldr	x0, [sp, #40]
 4bc:	91000402 	add	x2, x0, #0x1
 4c0:	f90017e2 	str	x2, [sp, #40]
 4c4:	39400021 	ldrb	w1, [x1]
 4c8:	39000001 	strb	w1, [x0]
    while(n-- > 0)
 4cc:	b9400fe0 	ldr	w0, [sp, #12]
 4d0:	51000401 	sub	w1, w0, #0x1
 4d4:	b9000fe1 	str	w1, [sp, #12]
 4d8:	7100001f 	cmp	w0, #0x0
 4dc:	54fffe8c 	b.gt	4ac <memmove+0x24>
    return vdst;
 4e0:	f9400fe0 	ldr	x0, [sp, #24]
}
 4e4:	9100c3ff 	add	sp, sp, #0x30
 4e8:	d65f03c0 	ret

00000000000004ec <fork>:
 4ec:	f81f8fe4 	str	x4, [sp, #-8]!
 4f0:	aa0303e4 	mov	x4, x3
 4f4:	aa0203e3 	mov	x3, x2
 4f8:	aa0103e2 	mov	x2, x1
 4fc:	aa0003e1 	mov	x1, x0
 500:	d2800020 	mov	x0, #0x1                   	// #1
 504:	d4000001 	svc	#0x0
 508:	f84087e4 	ldr	x4, [sp], #8
 50c:	d61f03c0 	br	x30

0000000000000510 <exit>:
 510:	f81f8fe4 	str	x4, [sp, #-8]!
 514:	aa0303e4 	mov	x4, x3
 518:	aa0203e3 	mov	x3, x2
 51c:	aa0103e2 	mov	x2, x1
 520:	aa0003e1 	mov	x1, x0
 524:	d2800040 	mov	x0, #0x2                   	// #2
 528:	d4000001 	svc	#0x0
 52c:	f84087e4 	ldr	x4, [sp], #8
 530:	d61f03c0 	br	x30

0000000000000534 <wait>:
 534:	f81f8fe4 	str	x4, [sp, #-8]!
 538:	aa0303e4 	mov	x4, x3
 53c:	aa0203e3 	mov	x3, x2
 540:	aa0103e2 	mov	x2, x1
 544:	aa0003e1 	mov	x1, x0
 548:	d2800060 	mov	x0, #0x3                   	// #3
 54c:	d4000001 	svc	#0x0
 550:	f84087e4 	ldr	x4, [sp], #8
 554:	d61f03c0 	br	x30

0000000000000558 <pipe>:
 558:	f81f8fe4 	str	x4, [sp, #-8]!
 55c:	aa0303e4 	mov	x4, x3
 560:	aa0203e3 	mov	x3, x2
 564:	aa0103e2 	mov	x2, x1
 568:	aa0003e1 	mov	x1, x0
 56c:	d2800080 	mov	x0, #0x4                   	// #4
 570:	d4000001 	svc	#0x0
 574:	f84087e4 	ldr	x4, [sp], #8
 578:	d61f03c0 	br	x30

000000000000057c <read>:
 57c:	f81f8fe4 	str	x4, [sp, #-8]!
 580:	aa0303e4 	mov	x4, x3
 584:	aa0203e3 	mov	x3, x2
 588:	aa0103e2 	mov	x2, x1
 58c:	aa0003e1 	mov	x1, x0
 590:	d28000a0 	mov	x0, #0x5                   	// #5
 594:	d4000001 	svc	#0x0
 598:	f84087e4 	ldr	x4, [sp], #8
 59c:	d61f03c0 	br	x30

00000000000005a0 <write>:
 5a0:	f81f8fe4 	str	x4, [sp, #-8]!
 5a4:	aa0303e4 	mov	x4, x3
 5a8:	aa0203e3 	mov	x3, x2
 5ac:	aa0103e2 	mov	x2, x1
 5b0:	aa0003e1 	mov	x1, x0
 5b4:	d2800200 	mov	x0, #0x10                  	// #16
 5b8:	d4000001 	svc	#0x0
 5bc:	f84087e4 	ldr	x4, [sp], #8
 5c0:	d61f03c0 	br	x30

00000000000005c4 <close>:
 5c4:	f81f8fe4 	str	x4, [sp, #-8]!
 5c8:	aa0303e4 	mov	x4, x3
 5cc:	aa0203e3 	mov	x3, x2
 5d0:	aa0103e2 	mov	x2, x1
 5d4:	aa0003e1 	mov	x1, x0
 5d8:	d28002a0 	mov	x0, #0x15                  	// #21
 5dc:	d4000001 	svc	#0x0
 5e0:	f84087e4 	ldr	x4, [sp], #8
 5e4:	d61f03c0 	br	x30

00000000000005e8 <kill>:
 5e8:	f81f8fe4 	str	x4, [sp, #-8]!
 5ec:	aa0303e4 	mov	x4, x3
 5f0:	aa0203e3 	mov	x3, x2
 5f4:	aa0103e2 	mov	x2, x1
 5f8:	aa0003e1 	mov	x1, x0
 5fc:	d28000c0 	mov	x0, #0x6                   	// #6
 600:	d4000001 	svc	#0x0
 604:	f84087e4 	ldr	x4, [sp], #8
 608:	d61f03c0 	br	x30

000000000000060c <exec>:
 60c:	f81f8fe4 	str	x4, [sp, #-8]!
 610:	aa0303e4 	mov	x4, x3
 614:	aa0203e3 	mov	x3, x2
 618:	aa0103e2 	mov	x2, x1
 61c:	aa0003e1 	mov	x1, x0
 620:	d28000e0 	mov	x0, #0x7                   	// #7
 624:	d4000001 	svc	#0x0
 628:	f84087e4 	ldr	x4, [sp], #8
 62c:	d61f03c0 	br	x30

0000000000000630 <open>:
 630:	f81f8fe4 	str	x4, [sp, #-8]!
 634:	aa0303e4 	mov	x4, x3
 638:	aa0203e3 	mov	x3, x2
 63c:	aa0103e2 	mov	x2, x1
 640:	aa0003e1 	mov	x1, x0
 644:	d28001e0 	mov	x0, #0xf                   	// #15
 648:	d4000001 	svc	#0x0
 64c:	f84087e4 	ldr	x4, [sp], #8
 650:	d61f03c0 	br	x30

0000000000000654 <mknod>:
 654:	f81f8fe4 	str	x4, [sp, #-8]!
 658:	aa0303e4 	mov	x4, x3
 65c:	aa0203e3 	mov	x3, x2
 660:	aa0103e2 	mov	x2, x1
 664:	aa0003e1 	mov	x1, x0
 668:	d2800220 	mov	x0, #0x11                  	// #17
 66c:	d4000001 	svc	#0x0
 670:	f84087e4 	ldr	x4, [sp], #8
 674:	d61f03c0 	br	x30

0000000000000678 <unlink>:
 678:	f81f8fe4 	str	x4, [sp, #-8]!
 67c:	aa0303e4 	mov	x4, x3
 680:	aa0203e3 	mov	x3, x2
 684:	aa0103e2 	mov	x2, x1
 688:	aa0003e1 	mov	x1, x0
 68c:	d2800240 	mov	x0, #0x12                  	// #18
 690:	d4000001 	svc	#0x0
 694:	f84087e4 	ldr	x4, [sp], #8
 698:	d61f03c0 	br	x30

000000000000069c <fstat>:
 69c:	f81f8fe4 	str	x4, [sp, #-8]!
 6a0:	aa0303e4 	mov	x4, x3
 6a4:	aa0203e3 	mov	x3, x2
 6a8:	aa0103e2 	mov	x2, x1
 6ac:	aa0003e1 	mov	x1, x0
 6b0:	d2800100 	mov	x0, #0x8                   	// #8
 6b4:	d4000001 	svc	#0x0
 6b8:	f84087e4 	ldr	x4, [sp], #8
 6bc:	d61f03c0 	br	x30

00000000000006c0 <link>:
 6c0:	f81f8fe4 	str	x4, [sp, #-8]!
 6c4:	aa0303e4 	mov	x4, x3
 6c8:	aa0203e3 	mov	x3, x2
 6cc:	aa0103e2 	mov	x2, x1
 6d0:	aa0003e1 	mov	x1, x0
 6d4:	d2800260 	mov	x0, #0x13                  	// #19
 6d8:	d4000001 	svc	#0x0
 6dc:	f84087e4 	ldr	x4, [sp], #8
 6e0:	d61f03c0 	br	x30

00000000000006e4 <mkdir>:
 6e4:	f81f8fe4 	str	x4, [sp, #-8]!
 6e8:	aa0303e4 	mov	x4, x3
 6ec:	aa0203e3 	mov	x3, x2
 6f0:	aa0103e2 	mov	x2, x1
 6f4:	aa0003e1 	mov	x1, x0
 6f8:	d2800280 	mov	x0, #0x14                  	// #20
 6fc:	d4000001 	svc	#0x0
 700:	f84087e4 	ldr	x4, [sp], #8
 704:	d61f03c0 	br	x30

0000000000000708 <chdir>:
 708:	f81f8fe4 	str	x4, [sp, #-8]!
 70c:	aa0303e4 	mov	x4, x3
 710:	aa0203e3 	mov	x3, x2
 714:	aa0103e2 	mov	x2, x1
 718:	aa0003e1 	mov	x1, x0
 71c:	d2800120 	mov	x0, #0x9                   	// #9
 720:	d4000001 	svc	#0x0
 724:	f84087e4 	ldr	x4, [sp], #8
 728:	d61f03c0 	br	x30

000000000000072c <dup>:
 72c:	f81f8fe4 	str	x4, [sp, #-8]!
 730:	aa0303e4 	mov	x4, x3
 734:	aa0203e3 	mov	x3, x2
 738:	aa0103e2 	mov	x2, x1
 73c:	aa0003e1 	mov	x1, x0
 740:	d2800140 	mov	x0, #0xa                   	// #10
 744:	d4000001 	svc	#0x0
 748:	f84087e4 	ldr	x4, [sp], #8
 74c:	d61f03c0 	br	x30

0000000000000750 <getpid>:
 750:	f81f8fe4 	str	x4, [sp, #-8]!
 754:	aa0303e4 	mov	x4, x3
 758:	aa0203e3 	mov	x3, x2
 75c:	aa0103e2 	mov	x2, x1
 760:	aa0003e1 	mov	x1, x0
 764:	d2800160 	mov	x0, #0xb                   	// #11
 768:	d4000001 	svc	#0x0
 76c:	f84087e4 	ldr	x4, [sp], #8
 770:	d61f03c0 	br	x30

0000000000000774 <sbrk>:
 774:	f81f8fe4 	str	x4, [sp, #-8]!
 778:	aa0303e4 	mov	x4, x3
 77c:	aa0203e3 	mov	x3, x2
 780:	aa0103e2 	mov	x2, x1
 784:	aa0003e1 	mov	x1, x0
 788:	d2800180 	mov	x0, #0xc                   	// #12
 78c:	d4000001 	svc	#0x0
 790:	f84087e4 	ldr	x4, [sp], #8
 794:	d61f03c0 	br	x30

0000000000000798 <sleep>:
 798:	f81f8fe4 	str	x4, [sp, #-8]!
 79c:	aa0303e4 	mov	x4, x3
 7a0:	aa0203e3 	mov	x3, x2
 7a4:	aa0103e2 	mov	x2, x1
 7a8:	aa0003e1 	mov	x1, x0
 7ac:	d28001a0 	mov	x0, #0xd                   	// #13
 7b0:	d4000001 	svc	#0x0
 7b4:	f84087e4 	ldr	x4, [sp], #8
 7b8:	d61f03c0 	br	x30

00000000000007bc <uptime>:
 7bc:	f81f8fe4 	str	x4, [sp, #-8]!
 7c0:	aa0303e4 	mov	x4, x3
 7c4:	aa0203e3 	mov	x3, x2
 7c8:	aa0103e2 	mov	x2, x1
 7cc:	aa0003e1 	mov	x1, x0
 7d0:	d28001c0 	mov	x0, #0xe                   	// #14
 7d4:	d4000001 	svc	#0x0
 7d8:	f84087e4 	ldr	x4, [sp], #8
 7dc:	d61f03c0 	br	x30

00000000000007e0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 7e0:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
 7e4:	910003fd 	mov	x29, sp
 7e8:	b9001fe0 	str	w0, [sp, #28]
 7ec:	39006fe1 	strb	w1, [sp, #27]
    write(fd, &c, 1);
 7f0:	91006fe0 	add	x0, sp, #0x1b
 7f4:	52800022 	mov	w2, #0x1                   	// #1
 7f8:	aa0003e1 	mov	x1, x0
 7fc:	b9401fe0 	ldr	w0, [sp, #28]
 800:	97ffff68 	bl	5a0 <write>
}
 804:	d503201f 	nop
 808:	a8c27bfd 	ldp	x29, x30, [sp], #32
 80c:	d65f03c0 	ret

0000000000000810 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 810:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 814:	910003fd 	mov	x29, sp
 818:	b9001fe0 	str	w0, [sp, #28]
 81c:	b9001be1 	str	w1, [sp, #24]
 820:	b90017e2 	str	w2, [sp, #20]
 824:	b90013e3 	str	w3, [sp, #16]
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
 828:	b9003bff 	str	wzr, [sp, #56]
    if(sgn && xx < 0){
 82c:	b94013e0 	ldr	w0, [sp, #16]
 830:	7100001f 	cmp	w0, #0x0
 834:	54000140 	b.eq	85c <printint+0x4c>  // b.none
 838:	b9401be0 	ldr	w0, [sp, #24]
 83c:	7100001f 	cmp	w0, #0x0
 840:	540000ea 	b.ge	85c <printint+0x4c>  // b.tcont
        neg = 1;
 844:	52800020 	mov	w0, #0x1                   	// #1
 848:	b9003be0 	str	w0, [sp, #56]
        x = -xx;
 84c:	b9401be0 	ldr	w0, [sp, #24]
 850:	4b0003e0 	neg	w0, w0
 854:	b90037e0 	str	w0, [sp, #52]
 858:	14000003 	b	864 <printint+0x54>
    } else {
        x = xx;
 85c:	b9401be0 	ldr	w0, [sp, #24]
 860:	b90037e0 	str	w0, [sp, #52]
    }
    
    i = 0;
 864:	b9003fff 	str	wzr, [sp, #60]
    do{
        buf[i++] = digits[x % base];
 868:	b94017e1 	ldr	w1, [sp, #20]
 86c:	b94037e0 	ldr	w0, [sp, #52]
 870:	1ac10802 	udiv	w2, w0, w1
 874:	1b017c41 	mul	w1, w2, w1
 878:	4b010003 	sub	w3, w0, w1
 87c:	b9403fe0 	ldr	w0, [sp, #60]
 880:	11000401 	add	w1, w0, #0x1
 884:	b9003fe1 	str	w1, [sp, #60]
 888:	90000001 	adrp	x1, 0 <main>
 88c:	913ce022 	add	x2, x1, #0xf38
 890:	2a0303e1 	mov	w1, w3
 894:	38616842 	ldrb	w2, [x2, x1]
 898:	93407c00 	sxtw	x0, w0
 89c:	910083e1 	add	x1, sp, #0x20
 8a0:	38206822 	strb	w2, [x1, x0]
    }while((x /= base) != 0);
 8a4:	b94017e0 	ldr	w0, [sp, #20]
 8a8:	b94037e1 	ldr	w1, [sp, #52]
 8ac:	1ac00820 	udiv	w0, w1, w0
 8b0:	b90037e0 	str	w0, [sp, #52]
 8b4:	b94037e0 	ldr	w0, [sp, #52]
 8b8:	7100001f 	cmp	w0, #0x0
 8bc:	54fffd61 	b.ne	868 <printint+0x58>  // b.any
    if(neg)
 8c0:	b9403be0 	ldr	w0, [sp, #56]
 8c4:	7100001f 	cmp	w0, #0x0
 8c8:	540001e0 	b.eq	904 <printint+0xf4>  // b.none
        buf[i++] = '-';
 8cc:	b9403fe0 	ldr	w0, [sp, #60]
 8d0:	11000401 	add	w1, w0, #0x1
 8d4:	b9003fe1 	str	w1, [sp, #60]
 8d8:	93407c00 	sxtw	x0, w0
 8dc:	910083e1 	add	x1, sp, #0x20
 8e0:	528005a2 	mov	w2, #0x2d                  	// #45
 8e4:	38206822 	strb	w2, [x1, x0]
    
    while(--i >= 0)
 8e8:	14000007 	b	904 <printint+0xf4>
        putc(fd, buf[i]);
 8ec:	b9803fe0 	ldrsw	x0, [sp, #60]
 8f0:	910083e1 	add	x1, sp, #0x20
 8f4:	38606820 	ldrb	w0, [x1, x0]
 8f8:	2a0003e1 	mov	w1, w0
 8fc:	b9401fe0 	ldr	w0, [sp, #28]
 900:	97ffffb8 	bl	7e0 <putc>
    while(--i >= 0)
 904:	b9403fe0 	ldr	w0, [sp, #60]
 908:	51000400 	sub	w0, w0, #0x1
 90c:	b9003fe0 	str	w0, [sp, #60]
 910:	b9403fe0 	ldr	w0, [sp, #60]
 914:	7100001f 	cmp	w0, #0x0
 918:	54fffeaa 	b.ge	8ec <printint+0xdc>  // b.tcont
}
 91c:	d503201f 	nop
 920:	d503201f 	nop
 924:	a8c47bfd 	ldp	x29, x30, [sp], #64
 928:	d65f03c0 	ret

000000000000092c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 92c:	a9b17bfd 	stp	x29, x30, [sp, #-240]!
 930:	910003fd 	mov	x29, sp
 934:	b9001fe0 	str	w0, [sp, #28]
 938:	f9000be1 	str	x1, [sp, #16]
 93c:	f90063e2 	str	x2, [sp, #192]
 940:	f90067e3 	str	x3, [sp, #200]
 944:	f9006be4 	str	x4, [sp, #208]
 948:	f9006fe5 	str	x5, [sp, #216]
 94c:	f90073e6 	str	x6, [sp, #224]
 950:	f90077e7 	str	x7, [sp, #232]
 954:	3d8013e0 	str	q0, [sp, #64]
 958:	3d8017e1 	str	q1, [sp, #80]
 95c:	3d801be2 	str	q2, [sp, #96]
 960:	3d801fe3 	str	q3, [sp, #112]
 964:	3d8023e4 	str	q4, [sp, #128]
 968:	3d8027e5 	str	q5, [sp, #144]
 96c:	3d802be6 	str	q6, [sp, #160]
 970:	3d802fe7 	str	q7, [sp, #176]
    char *s;
    int c, i, state;
    uint64 *ap;
    
    state = 0;
 974:	b90033ff 	str	wzr, [sp, #48]
    ap = (uint64*)(void*)&fmt + 22;
 978:	910043e0 	add	x0, sp, #0x10
 97c:	9102c000 	add	x0, x0, #0xb0
 980:	f90017e0 	str	x0, [sp, #40]
    for(i = 0; fmt[i]; i++){
 984:	b90037ff 	str	wzr, [sp, #52]
 988:	14000076 	b	b60 <printf+0x234>
        c = fmt[i] & 0xff;
 98c:	f9400be1 	ldr	x1, [sp, #16]
 990:	b98037e0 	ldrsw	x0, [sp, #52]
 994:	8b000020 	add	x0, x1, x0
 998:	39400000 	ldrb	w0, [x0]
 99c:	b90027e0 	str	w0, [sp, #36]
        if(state == 0){
 9a0:	b94033e0 	ldr	w0, [sp, #48]
 9a4:	7100001f 	cmp	w0, #0x0
 9a8:	540001a1 	b.ne	9dc <printf+0xb0>  // b.any
            if(c == '%'){
 9ac:	b94027e0 	ldr	w0, [sp, #36]
 9b0:	7100941f 	cmp	w0, #0x25
 9b4:	54000081 	b.ne	9c4 <printf+0x98>  // b.any
                state = '%';
 9b8:	528004a0 	mov	w0, #0x25                  	// #37
 9bc:	b90033e0 	str	w0, [sp, #48]
 9c0:	14000065 	b	b54 <printf+0x228>
            } else {
                putc(fd, c);
 9c4:	b94027e0 	ldr	w0, [sp, #36]
 9c8:	12001c00 	and	w0, w0, #0xff
 9cc:	2a0003e1 	mov	w1, w0
 9d0:	b9401fe0 	ldr	w0, [sp, #28]
 9d4:	97ffff83 	bl	7e0 <putc>
 9d8:	1400005f 	b	b54 <printf+0x228>
            }
        } else if(state == '%'){
 9dc:	b94033e0 	ldr	w0, [sp, #48]
 9e0:	7100941f 	cmp	w0, #0x25
 9e4:	54000b81 	b.ne	b54 <printf+0x228>  // b.any
            if(c == 'd'){
 9e8:	b94027e0 	ldr	w0, [sp, #36]
 9ec:	7101901f 	cmp	w0, #0x64
 9f0:	54000181 	b.ne	a20 <printf+0xf4>  // b.any
                printint(fd, *ap, 10, 1);
 9f4:	f94017e0 	ldr	x0, [sp, #40]
 9f8:	f9400000 	ldr	x0, [x0]
 9fc:	52800023 	mov	w3, #0x1                   	// #1
 a00:	52800142 	mov	w2, #0xa                   	// #10
 a04:	2a0003e1 	mov	w1, w0
 a08:	b9401fe0 	ldr	w0, [sp, #28]
 a0c:	97ffff81 	bl	810 <printint>
                ap++;
 a10:	f94017e0 	ldr	x0, [sp, #40]
 a14:	91002000 	add	x0, x0, #0x8
 a18:	f90017e0 	str	x0, [sp, #40]
 a1c:	1400004d 	b	b50 <printf+0x224>
            } else if(c == 'x' || c == 'p'){
 a20:	b94027e0 	ldr	w0, [sp, #36]
 a24:	7101e01f 	cmp	w0, #0x78
 a28:	54000080 	b.eq	a38 <printf+0x10c>  // b.none
 a2c:	b94027e0 	ldr	w0, [sp, #36]
 a30:	7101c01f 	cmp	w0, #0x70
 a34:	54000181 	b.ne	a64 <printf+0x138>  // b.any
                printint(fd, *ap, 16, 0);
 a38:	f94017e0 	ldr	x0, [sp, #40]
 a3c:	f9400000 	ldr	x0, [x0]
 a40:	52800003 	mov	w3, #0x0                   	// #0
 a44:	52800202 	mov	w2, #0x10                  	// #16
 a48:	2a0003e1 	mov	w1, w0
 a4c:	b9401fe0 	ldr	w0, [sp, #28]
 a50:	97ffff70 	bl	810 <printint>
                ap++;
 a54:	f94017e0 	ldr	x0, [sp, #40]
 a58:	91002000 	add	x0, x0, #0x8
 a5c:	f90017e0 	str	x0, [sp, #40]
 a60:	1400003c 	b	b50 <printf+0x224>
            } else if(c == 's'){
 a64:	b94027e0 	ldr	w0, [sp, #36]
 a68:	7101cc1f 	cmp	w0, #0x73
 a6c:	54000361 	b.ne	ad8 <printf+0x1ac>  // b.any
                s = (char*)*ap;
 a70:	f94017e0 	ldr	x0, [sp, #40]
 a74:	f9400000 	ldr	x0, [x0]
 a78:	f9001fe0 	str	x0, [sp, #56]
                ap++;
 a7c:	f94017e0 	ldr	x0, [sp, #40]
 a80:	91002000 	add	x0, x0, #0x8
 a84:	f90017e0 	str	x0, [sp, #40]
                if(s == 0)
 a88:	f9401fe0 	ldr	x0, [sp, #56]
 a8c:	f100001f 	cmp	x0, #0x0
 a90:	540001a1 	b.ne	ac4 <printf+0x198>  // b.any
                    s = "(null)";
 a94:	90000000 	adrp	x0, 0 <main>
 a98:	913cc000 	add	x0, x0, #0xf30
 a9c:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
 aa0:	14000009 	b	ac4 <printf+0x198>
                    putc(fd, *s);
 aa4:	f9401fe0 	ldr	x0, [sp, #56]
 aa8:	39400000 	ldrb	w0, [x0]
 aac:	2a0003e1 	mov	w1, w0
 ab0:	b9401fe0 	ldr	w0, [sp, #28]
 ab4:	97ffff4b 	bl	7e0 <putc>
                    s++;
 ab8:	f9401fe0 	ldr	x0, [sp, #56]
 abc:	91000400 	add	x0, x0, #0x1
 ac0:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
 ac4:	f9401fe0 	ldr	x0, [sp, #56]
 ac8:	39400000 	ldrb	w0, [x0]
 acc:	7100001f 	cmp	w0, #0x0
 ad0:	54fffea1 	b.ne	aa4 <printf+0x178>  // b.any
 ad4:	1400001f 	b	b50 <printf+0x224>
                }
            } else if(c == 'c'){
 ad8:	b94027e0 	ldr	w0, [sp, #36]
 adc:	71018c1f 	cmp	w0, #0x63
 ae0:	54000161 	b.ne	b0c <printf+0x1e0>  // b.any
                putc(fd, *ap);
 ae4:	f94017e0 	ldr	x0, [sp, #40]
 ae8:	f9400000 	ldr	x0, [x0]
 aec:	12001c00 	and	w0, w0, #0xff
 af0:	2a0003e1 	mov	w1, w0
 af4:	b9401fe0 	ldr	w0, [sp, #28]
 af8:	97ffff3a 	bl	7e0 <putc>
                ap++;
 afc:	f94017e0 	ldr	x0, [sp, #40]
 b00:	91002000 	add	x0, x0, #0x8
 b04:	f90017e0 	str	x0, [sp, #40]
 b08:	14000012 	b	b50 <printf+0x224>
            } else if(c == '%'){
 b0c:	b94027e0 	ldr	w0, [sp, #36]
 b10:	7100941f 	cmp	w0, #0x25
 b14:	540000e1 	b.ne	b30 <printf+0x204>  // b.any
                putc(fd, c);
 b18:	b94027e0 	ldr	w0, [sp, #36]
 b1c:	12001c00 	and	w0, w0, #0xff
 b20:	2a0003e1 	mov	w1, w0
 b24:	b9401fe0 	ldr	w0, [sp, #28]
 b28:	97ffff2e 	bl	7e0 <putc>
 b2c:	14000009 	b	b50 <printf+0x224>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
 b30:	528004a1 	mov	w1, #0x25                  	// #37
 b34:	b9401fe0 	ldr	w0, [sp, #28]
 b38:	97ffff2a 	bl	7e0 <putc>
                putc(fd, c);
 b3c:	b94027e0 	ldr	w0, [sp, #36]
 b40:	12001c00 	and	w0, w0, #0xff
 b44:	2a0003e1 	mov	w1, w0
 b48:	b9401fe0 	ldr	w0, [sp, #28]
 b4c:	97ffff25 	bl	7e0 <putc>
            }
            state = 0;
 b50:	b90033ff 	str	wzr, [sp, #48]
    for(i = 0; fmt[i]; i++){
 b54:	b94037e0 	ldr	w0, [sp, #52]
 b58:	11000400 	add	w0, w0, #0x1
 b5c:	b90037e0 	str	w0, [sp, #52]
 b60:	f9400be1 	ldr	x1, [sp, #16]
 b64:	b98037e0 	ldrsw	x0, [sp, #52]
 b68:	8b000020 	add	x0, x1, x0
 b6c:	39400000 	ldrb	w0, [x0]
 b70:	7100001f 	cmp	w0, #0x0
 b74:	54fff0c1 	b.ne	98c <printf+0x60>  // b.any
        }
    }
}
 b78:	d503201f 	nop
 b7c:	d503201f 	nop
 b80:	a8cf7bfd 	ldp	x29, x30, [sp], #240
 b84:	d65f03c0 	ret

0000000000000b88 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 b88:	d10083ff 	sub	sp, sp, #0x20
 b8c:	f90007e0 	str	x0, [sp, #8]
    Header *bp, *p;
    
    bp = (Header*)ap - 1;
 b90:	f94007e0 	ldr	x0, [sp, #8]
 b94:	d1004000 	sub	x0, x0, #0x10
 b98:	f9000be0 	str	x0, [sp, #16]
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b9c:	90000000 	adrp	x0, 0 <main>
 ba0:	913d8000 	add	x0, x0, #0xf60
 ba4:	f9400000 	ldr	x0, [x0]
 ba8:	f9000fe0 	str	x0, [sp, #24]
 bac:	14000012 	b	bf4 <free+0x6c>
        if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 bb0:	f9400fe0 	ldr	x0, [sp, #24]
 bb4:	f9400000 	ldr	x0, [x0]
 bb8:	f9400fe1 	ldr	x1, [sp, #24]
 bbc:	eb00003f 	cmp	x1, x0
 bc0:	54000143 	b.cc	be8 <free+0x60>  // b.lo, b.ul, b.last
 bc4:	f9400be1 	ldr	x1, [sp, #16]
 bc8:	f9400fe0 	ldr	x0, [sp, #24]
 bcc:	eb00003f 	cmp	x1, x0
 bd0:	54000248 	b.hi	c18 <free+0x90>  // b.pmore
 bd4:	f9400fe0 	ldr	x0, [sp, #24]
 bd8:	f9400000 	ldr	x0, [x0]
 bdc:	f9400be1 	ldr	x1, [sp, #16]
 be0:	eb00003f 	cmp	x1, x0
 be4:	540001a3 	b.cc	c18 <free+0x90>  // b.lo, b.ul, b.last
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 be8:	f9400fe0 	ldr	x0, [sp, #24]
 bec:	f9400000 	ldr	x0, [x0]
 bf0:	f9000fe0 	str	x0, [sp, #24]
 bf4:	f9400be1 	ldr	x1, [sp, #16]
 bf8:	f9400fe0 	ldr	x0, [sp, #24]
 bfc:	eb00003f 	cmp	x1, x0
 c00:	54fffd89 	b.ls	bb0 <free+0x28>  // b.plast
 c04:	f9400fe0 	ldr	x0, [sp, #24]
 c08:	f9400000 	ldr	x0, [x0]
 c0c:	f9400be1 	ldr	x1, [sp, #16]
 c10:	eb00003f 	cmp	x1, x0
 c14:	54fffce2 	b.cs	bb0 <free+0x28>  // b.hs, b.nlast
            break;
    if(bp + bp->s.size == p->s.ptr){
 c18:	f9400be0 	ldr	x0, [sp, #16]
 c1c:	b9400800 	ldr	w0, [x0, #8]
 c20:	2a0003e0 	mov	w0, w0
 c24:	d37cec00 	lsl	x0, x0, #4
 c28:	f9400be1 	ldr	x1, [sp, #16]
 c2c:	8b000021 	add	x1, x1, x0
 c30:	f9400fe0 	ldr	x0, [sp, #24]
 c34:	f9400000 	ldr	x0, [x0]
 c38:	eb00003f 	cmp	x1, x0
 c3c:	540001e1 	b.ne	c78 <free+0xf0>  // b.any
        bp->s.size += p->s.ptr->s.size;
 c40:	f9400be0 	ldr	x0, [sp, #16]
 c44:	b9400801 	ldr	w1, [x0, #8]
 c48:	f9400fe0 	ldr	x0, [sp, #24]
 c4c:	f9400000 	ldr	x0, [x0]
 c50:	b9400800 	ldr	w0, [x0, #8]
 c54:	0b000021 	add	w1, w1, w0
 c58:	f9400be0 	ldr	x0, [sp, #16]
 c5c:	b9000801 	str	w1, [x0, #8]
        bp->s.ptr = p->s.ptr->s.ptr;
 c60:	f9400fe0 	ldr	x0, [sp, #24]
 c64:	f9400000 	ldr	x0, [x0]
 c68:	f9400001 	ldr	x1, [x0]
 c6c:	f9400be0 	ldr	x0, [sp, #16]
 c70:	f9000001 	str	x1, [x0]
 c74:	14000005 	b	c88 <free+0x100>
    } else
        bp->s.ptr = p->s.ptr;
 c78:	f9400fe0 	ldr	x0, [sp, #24]
 c7c:	f9400001 	ldr	x1, [x0]
 c80:	f9400be0 	ldr	x0, [sp, #16]
 c84:	f9000001 	str	x1, [x0]
    if(p + p->s.size == bp){
 c88:	f9400fe0 	ldr	x0, [sp, #24]
 c8c:	b9400800 	ldr	w0, [x0, #8]
 c90:	2a0003e0 	mov	w0, w0
 c94:	d37cec00 	lsl	x0, x0, #4
 c98:	f9400fe1 	ldr	x1, [sp, #24]
 c9c:	8b000020 	add	x0, x1, x0
 ca0:	f9400be1 	ldr	x1, [sp, #16]
 ca4:	eb00003f 	cmp	x1, x0
 ca8:	540001a1 	b.ne	cdc <free+0x154>  // b.any
        p->s.size += bp->s.size;
 cac:	f9400fe0 	ldr	x0, [sp, #24]
 cb0:	b9400801 	ldr	w1, [x0, #8]
 cb4:	f9400be0 	ldr	x0, [sp, #16]
 cb8:	b9400800 	ldr	w0, [x0, #8]
 cbc:	0b000021 	add	w1, w1, w0
 cc0:	f9400fe0 	ldr	x0, [sp, #24]
 cc4:	b9000801 	str	w1, [x0, #8]
        p->s.ptr = bp->s.ptr;
 cc8:	f9400be0 	ldr	x0, [sp, #16]
 ccc:	f9400001 	ldr	x1, [x0]
 cd0:	f9400fe0 	ldr	x0, [sp, #24]
 cd4:	f9000001 	str	x1, [x0]
 cd8:	14000004 	b	ce8 <free+0x160>
    } else
        p->s.ptr = bp;
 cdc:	f9400fe0 	ldr	x0, [sp, #24]
 ce0:	f9400be1 	ldr	x1, [sp, #16]
 ce4:	f9000001 	str	x1, [x0]
    freep = p;
 ce8:	90000000 	adrp	x0, 0 <main>
 cec:	913d8000 	add	x0, x0, #0xf60
 cf0:	f9400fe1 	ldr	x1, [sp, #24]
 cf4:	f9000001 	str	x1, [x0]
}
 cf8:	d503201f 	nop
 cfc:	910083ff 	add	sp, sp, #0x20
 d00:	d65f03c0 	ret

0000000000000d04 <morecore>:

static Header*
morecore(uint nu)
{
 d04:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 d08:	910003fd 	mov	x29, sp
 d0c:	b9001fe0 	str	w0, [sp, #28]
    char *p;
    Header *hp;
    
    if(nu < 4096)
 d10:	b9401fe0 	ldr	w0, [sp, #28]
 d14:	713ffc1f 	cmp	w0, #0xfff
 d18:	54000068 	b.hi	d24 <morecore+0x20>  // b.pmore
        nu = 4096;
 d1c:	52820000 	mov	w0, #0x1000                	// #4096
 d20:	b9001fe0 	str	w0, [sp, #28]
    p = sbrk(nu * sizeof(Header));
 d24:	b9401fe0 	ldr	w0, [sp, #28]
 d28:	531c6c00 	lsl	w0, w0, #4
 d2c:	97fffe92 	bl	774 <sbrk>
 d30:	f90017e0 	str	x0, [sp, #40]
    if(p == (char*)-1)
 d34:	f94017e0 	ldr	x0, [sp, #40]
 d38:	b100041f 	cmn	x0, #0x1
 d3c:	54000061 	b.ne	d48 <morecore+0x44>  // b.any
        return 0;
 d40:	d2800000 	mov	x0, #0x0                   	// #0
 d44:	1400000c 	b	d74 <morecore+0x70>
    hp = (Header*)p;
 d48:	f94017e0 	ldr	x0, [sp, #40]
 d4c:	f90013e0 	str	x0, [sp, #32]
    hp->s.size = nu;
 d50:	f94013e0 	ldr	x0, [sp, #32]
 d54:	b9401fe1 	ldr	w1, [sp, #28]
 d58:	b9000801 	str	w1, [x0, #8]
    free((void*)(hp + 1));
 d5c:	f94013e0 	ldr	x0, [sp, #32]
 d60:	91004000 	add	x0, x0, #0x10
 d64:	97ffff89 	bl	b88 <free>
    return freep;
 d68:	90000000 	adrp	x0, 0 <main>
 d6c:	913d8000 	add	x0, x0, #0xf60
 d70:	f9400000 	ldr	x0, [x0]
}
 d74:	a8c37bfd 	ldp	x29, x30, [sp], #48
 d78:	d65f03c0 	ret

0000000000000d7c <malloc>:

void*
malloc(uint nbytes)
{
 d7c:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 d80:	910003fd 	mov	x29, sp
 d84:	b9001fe0 	str	w0, [sp, #28]
    Header *p, *prevp;
    uint nunits;
    
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 d88:	b9401fe0 	ldr	w0, [sp, #28]
 d8c:	91003c00 	add	x0, x0, #0xf
 d90:	d344fc00 	lsr	x0, x0, #4
 d94:	11000400 	add	w0, w0, #0x1
 d98:	b9002fe0 	str	w0, [sp, #44]
    if((prevp = freep) == 0){
 d9c:	90000000 	adrp	x0, 0 <main>
 da0:	913d8000 	add	x0, x0, #0xf60
 da4:	f9400000 	ldr	x0, [x0]
 da8:	f9001be0 	str	x0, [sp, #48]
 dac:	f9401be0 	ldr	x0, [sp, #48]
 db0:	f100001f 	cmp	x0, #0x0
 db4:	54000221 	b.ne	df8 <malloc+0x7c>  // b.any
        base.s.ptr = freep = prevp = &base;
 db8:	90000000 	adrp	x0, 0 <main>
 dbc:	913d4000 	add	x0, x0, #0xf50
 dc0:	f9001be0 	str	x0, [sp, #48]
 dc4:	90000000 	adrp	x0, 0 <main>
 dc8:	913d8000 	add	x0, x0, #0xf60
 dcc:	f9401be1 	ldr	x1, [sp, #48]
 dd0:	f9000001 	str	x1, [x0]
 dd4:	90000000 	adrp	x0, 0 <main>
 dd8:	913d8000 	add	x0, x0, #0xf60
 ddc:	f9400001 	ldr	x1, [x0]
 de0:	90000000 	adrp	x0, 0 <main>
 de4:	913d4000 	add	x0, x0, #0xf50
 de8:	f9000001 	str	x1, [x0]
        base.s.size = 0;
 dec:	90000000 	adrp	x0, 0 <main>
 df0:	913d4000 	add	x0, x0, #0xf50
 df4:	b900081f 	str	wzr, [x0, #8]
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 df8:	f9401be0 	ldr	x0, [sp, #48]
 dfc:	f9400000 	ldr	x0, [x0]
 e00:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
 e04:	f9401fe0 	ldr	x0, [sp, #56]
 e08:	b9400800 	ldr	w0, [x0, #8]
 e0c:	b9402fe1 	ldr	w1, [sp, #44]
 e10:	6b00003f 	cmp	w1, w0
 e14:	54000448 	b.hi	e9c <malloc+0x120>  // b.pmore
            if(p->s.size == nunits)
 e18:	f9401fe0 	ldr	x0, [sp, #56]
 e1c:	b9400800 	ldr	w0, [x0, #8]
 e20:	b9402fe1 	ldr	w1, [sp, #44]
 e24:	6b00003f 	cmp	w1, w0
 e28:	540000c1 	b.ne	e40 <malloc+0xc4>  // b.any
                prevp->s.ptr = p->s.ptr;
 e2c:	f9401fe0 	ldr	x0, [sp, #56]
 e30:	f9400001 	ldr	x1, [x0]
 e34:	f9401be0 	ldr	x0, [sp, #48]
 e38:	f9000001 	str	x1, [x0]
 e3c:	14000011 	b	e80 <malloc+0x104>
            else {
                p->s.size -= nunits;
 e40:	f9401fe0 	ldr	x0, [sp, #56]
 e44:	b9400801 	ldr	w1, [x0, #8]
 e48:	b9402fe0 	ldr	w0, [sp, #44]
 e4c:	4b000021 	sub	w1, w1, w0
 e50:	f9401fe0 	ldr	x0, [sp, #56]
 e54:	b9000801 	str	w1, [x0, #8]
                p += p->s.size;
 e58:	f9401fe0 	ldr	x0, [sp, #56]
 e5c:	b9400800 	ldr	w0, [x0, #8]
 e60:	2a0003e0 	mov	w0, w0
 e64:	d37cec00 	lsl	x0, x0, #4
 e68:	f9401fe1 	ldr	x1, [sp, #56]
 e6c:	8b000020 	add	x0, x1, x0
 e70:	f9001fe0 	str	x0, [sp, #56]
                p->s.size = nunits;
 e74:	f9401fe0 	ldr	x0, [sp, #56]
 e78:	b9402fe1 	ldr	w1, [sp, #44]
 e7c:	b9000801 	str	w1, [x0, #8]
            }
            freep = prevp;
 e80:	90000000 	adrp	x0, 0 <main>
 e84:	913d8000 	add	x0, x0, #0xf60
 e88:	f9401be1 	ldr	x1, [sp, #48]
 e8c:	f9000001 	str	x1, [x0]
            return (void*)(p + 1);
 e90:	f9401fe0 	ldr	x0, [sp, #56]
 e94:	91004000 	add	x0, x0, #0x10
 e98:	14000015 	b	eec <malloc+0x170>
        }
        if(p == freep)
 e9c:	90000000 	adrp	x0, 0 <main>
 ea0:	913d8000 	add	x0, x0, #0xf60
 ea4:	f9400000 	ldr	x0, [x0]
 ea8:	f9401fe1 	ldr	x1, [sp, #56]
 eac:	eb00003f 	cmp	x1, x0
 eb0:	54000121 	b.ne	ed4 <malloc+0x158>  // b.any
            if((p = morecore(nunits)) == 0)
 eb4:	b9402fe0 	ldr	w0, [sp, #44]
 eb8:	97ffff93 	bl	d04 <morecore>
 ebc:	f9001fe0 	str	x0, [sp, #56]
 ec0:	f9401fe0 	ldr	x0, [sp, #56]
 ec4:	f100001f 	cmp	x0, #0x0
 ec8:	54000061 	b.ne	ed4 <malloc+0x158>  // b.any
                return 0;
 ecc:	d2800000 	mov	x0, #0x0                   	// #0
 ed0:	14000007 	b	eec <malloc+0x170>
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ed4:	f9401fe0 	ldr	x0, [sp, #56]
 ed8:	f9001be0 	str	x0, [sp, #48]
 edc:	f9401fe0 	ldr	x0, [sp, #56]
 ee0:	f9400000 	ldr	x0, [x0]
 ee4:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
 ee8:	17ffffc7 	b	e04 <malloc+0x88>
    }
}
 eec:	a8c47bfd 	ldp	x29, x30, [sp], #64
 ef0:	d65f03c0 	ret
