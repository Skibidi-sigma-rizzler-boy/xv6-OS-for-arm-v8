
_stressfs:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	d10903ff 	sub	sp, sp, #0x240
   4:	a9007bfd 	stp	x29, x30, [sp]
   8:	910003fd 	mov	x29, sp
   c:	b9001fe0 	str	w0, [sp, #28]
  10:	f9000be1 	str	x1, [sp, #16]
    int fd, i;
    char path[] = "stressfs0";
  14:	90000000 	adrp	x0, 0 <main>
  18:	913f8001 	add	x1, x0, #0xfe0
  1c:	9108a3e0 	add	x0, sp, #0x228
  20:	f9400022 	ldr	x2, [x1]
  24:	79401021 	ldrh	w1, [x1, #8]
  28:	f9000002 	str	x2, [x0]
  2c:	79001001 	strh	w1, [x0, #8]
    char data[512];
    
    printf(1, "stressfs starting\n");
  30:	90000000 	adrp	x0, 0 <main>
  34:	913ec001 	add	x1, x0, #0xfb0
  38:	52800020 	mov	w0, #0x1                   	// #1
  3c:	9400026a 	bl	9e4 <printf>
    memset(data, 'a', sizeof(data));
  40:	9100a3e0 	add	x0, sp, #0x28
  44:	52804002 	mov	w2, #0x200                 	// #512
  48:	52800c21 	mov	w1, #0x61                  	// #97
  4c:	94000085 	bl	260 <memset>
    
    for(i = 0; i < 4; i++)
  50:	b9023fff 	str	wzr, [sp, #572]
  54:	14000007 	b	70 <main+0x70>
        if(fork() > 0)
  58:	94000153 	bl	5a4 <fork>
  5c:	7100001f 	cmp	w0, #0x0
  60:	5400010c 	b.gt	80 <main+0x80>
    for(i = 0; i < 4; i++)
  64:	b9423fe0 	ldr	w0, [sp, #572]
  68:	11000400 	add	w0, w0, #0x1
  6c:	b9023fe0 	str	w0, [sp, #572]
  70:	b9423fe0 	ldr	w0, [sp, #572]
  74:	71000c1f 	cmp	w0, #0x3
  78:	54ffff0d 	b.le	58 <main+0x58>
  7c:	14000002 	b	84 <main+0x84>
            break;
  80:	d503201f 	nop
    
    printf(1, "write %d\n", i);
  84:	b9423fe2 	ldr	w2, [sp, #572]
  88:	90000000 	adrp	x0, 0 <main>
  8c:	913f2001 	add	x1, x0, #0xfc8
  90:	52800020 	mov	w0, #0x1                   	// #1
  94:	94000254 	bl	9e4 <printf>
    
    path[8] += i;
  98:	3948c3e1 	ldrb	w1, [sp, #560]
  9c:	b9423fe0 	ldr	w0, [sp, #572]
  a0:	12001c00 	and	w0, w0, #0xff
  a4:	0b000020 	add	w0, w1, w0
  a8:	12001c00 	and	w0, w0, #0xff
  ac:	3908c3e0 	strb	w0, [sp, #560]
    fd = open(path, O_CREATE | O_RDWR);
  b0:	9108a3e0 	add	x0, sp, #0x228
  b4:	52804041 	mov	w1, #0x202                 	// #514
  b8:	9400018c 	bl	6e8 <open>
  bc:	b9023be0 	str	w0, [sp, #568]
    for(i = 0; i < 20; i++)
  c0:	b9023fff 	str	wzr, [sp, #572]
  c4:	14000009 	b	e8 <main+0xe8>
        //    printf(fd, "%d\n", i);
        write(fd, data, sizeof(data));
  c8:	9100a3e0 	add	x0, sp, #0x28
  cc:	52804002 	mov	w2, #0x200                 	// #512
  d0:	aa0003e1 	mov	x1, x0
  d4:	b9423be0 	ldr	w0, [sp, #568]
  d8:	94000160 	bl	658 <write>
    for(i = 0; i < 20; i++)
  dc:	b9423fe0 	ldr	w0, [sp, #572]
  e0:	11000400 	add	w0, w0, #0x1
  e4:	b9023fe0 	str	w0, [sp, #572]
  e8:	b9423fe0 	ldr	w0, [sp, #572]
  ec:	71004c1f 	cmp	w0, #0x13
  f0:	54fffecd 	b.le	c8 <main+0xc8>
    close(fd);
  f4:	b9423be0 	ldr	w0, [sp, #568]
  f8:	94000161 	bl	67c <close>
    
    printf(1, "read\n");
  fc:	90000000 	adrp	x0, 0 <main>
 100:	913f6001 	add	x1, x0, #0xfd8
 104:	52800020 	mov	w0, #0x1                   	// #1
 108:	94000237 	bl	9e4 <printf>
    
    fd = open(path, O_RDONLY);
 10c:	9108a3e0 	add	x0, sp, #0x228
 110:	52800001 	mov	w1, #0x0                   	// #0
 114:	94000175 	bl	6e8 <open>
 118:	b9023be0 	str	w0, [sp, #568]
    for (i = 0; i < 20; i++)
 11c:	b9023fff 	str	wzr, [sp, #572]
 120:	14000009 	b	144 <main+0x144>
        read(fd, data, sizeof(data));
 124:	9100a3e0 	add	x0, sp, #0x28
 128:	52804002 	mov	w2, #0x200                 	// #512
 12c:	aa0003e1 	mov	x1, x0
 130:	b9423be0 	ldr	w0, [sp, #568]
 134:	94000140 	bl	634 <read>
    for (i = 0; i < 20; i++)
 138:	b9423fe0 	ldr	w0, [sp, #572]
 13c:	11000400 	add	w0, w0, #0x1
 140:	b9023fe0 	str	w0, [sp, #572]
 144:	b9423fe0 	ldr	w0, [sp, #572]
 148:	71004c1f 	cmp	w0, #0x13
 14c:	54fffecd 	b.le	124 <main+0x124>
    close(fd);
 150:	b9423be0 	ldr	w0, [sp, #568]
 154:	9400014a 	bl	67c <close>
    
    wait();
 158:	94000125 	bl	5ec <wait>
    
    exit();
 15c:	9400011b 	bl	5c8 <exit>

0000000000000160 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 160:	d10083ff 	sub	sp, sp, #0x20
 164:	f90007e0 	str	x0, [sp, #8]
 168:	f90003e1 	str	x1, [sp]
    char *os;
    
    os = s;
 16c:	f94007e0 	ldr	x0, [sp, #8]
 170:	f9000fe0 	str	x0, [sp, #24]
    while((*s++ = *t++) != 0)
 174:	d503201f 	nop
 178:	f94003e1 	ldr	x1, [sp]
 17c:	91000420 	add	x0, x1, #0x1
 180:	f90003e0 	str	x0, [sp]
 184:	f94007e0 	ldr	x0, [sp, #8]
 188:	91000402 	add	x2, x0, #0x1
 18c:	f90007e2 	str	x2, [sp, #8]
 190:	39400021 	ldrb	w1, [x1]
 194:	39000001 	strb	w1, [x0]
 198:	39400000 	ldrb	w0, [x0]
 19c:	7100001f 	cmp	w0, #0x0
 1a0:	54fffec1 	b.ne	178 <strcpy+0x18>  // b.any
        ;
    return os;
 1a4:	f9400fe0 	ldr	x0, [sp, #24]
}
 1a8:	910083ff 	add	sp, sp, #0x20
 1ac:	d65f03c0 	ret

00000000000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	d10043ff 	sub	sp, sp, #0x10
 1b4:	f90007e0 	str	x0, [sp, #8]
 1b8:	f90003e1 	str	x1, [sp]
    while(*p && *p == *q)
 1bc:	14000007 	b	1d8 <strcmp+0x28>
        p++, q++;
 1c0:	f94007e0 	ldr	x0, [sp, #8]
 1c4:	91000400 	add	x0, x0, #0x1
 1c8:	f90007e0 	str	x0, [sp, #8]
 1cc:	f94003e0 	ldr	x0, [sp]
 1d0:	91000400 	add	x0, x0, #0x1
 1d4:	f90003e0 	str	x0, [sp]
    while(*p && *p == *q)
 1d8:	f94007e0 	ldr	x0, [sp, #8]
 1dc:	39400000 	ldrb	w0, [x0]
 1e0:	7100001f 	cmp	w0, #0x0
 1e4:	540000e0 	b.eq	200 <strcmp+0x50>  // b.none
 1e8:	f94007e0 	ldr	x0, [sp, #8]
 1ec:	39400001 	ldrb	w1, [x0]
 1f0:	f94003e0 	ldr	x0, [sp]
 1f4:	39400000 	ldrb	w0, [x0]
 1f8:	6b00003f 	cmp	w1, w0
 1fc:	54fffe20 	b.eq	1c0 <strcmp+0x10>  // b.none
    return (uchar)*p - (uchar)*q;
 200:	f94007e0 	ldr	x0, [sp, #8]
 204:	39400000 	ldrb	w0, [x0]
 208:	2a0003e1 	mov	w1, w0
 20c:	f94003e0 	ldr	x0, [sp]
 210:	39400000 	ldrb	w0, [x0]
 214:	4b000020 	sub	w0, w1, w0
}
 218:	910043ff 	add	sp, sp, #0x10
 21c:	d65f03c0 	ret

0000000000000220 <strlen>:

uint
strlen(char *s)
{
 220:	d10083ff 	sub	sp, sp, #0x20
 224:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    for(n = 0; s[n]; n++)
 228:	b9001fff 	str	wzr, [sp, #28]
 22c:	14000004 	b	23c <strlen+0x1c>
 230:	b9401fe0 	ldr	w0, [sp, #28]
 234:	11000400 	add	w0, w0, #0x1
 238:	b9001fe0 	str	w0, [sp, #28]
 23c:	b9801fe0 	ldrsw	x0, [sp, #28]
 240:	f94007e1 	ldr	x1, [sp, #8]
 244:	8b000020 	add	x0, x1, x0
 248:	39400000 	ldrb	w0, [x0]
 24c:	7100001f 	cmp	w0, #0x0
 250:	54ffff01 	b.ne	230 <strlen+0x10>  // b.any
        ;
    return n;
 254:	b9401fe0 	ldr	w0, [sp, #28]
}
 258:	910083ff 	add	sp, sp, #0x20
 25c:	d65f03c0 	ret

0000000000000260 <memset>:

void*
memset(void *dst, int v, uint n)
{
 260:	d100c3ff 	sub	sp, sp, #0x30
 264:	f90007e0 	str	x0, [sp, #8]
 268:	b90007e1 	str	w1, [sp, #4]
 26c:	b90003e2 	str	w2, [sp]
	uint8	*p;
	uint8	c;
	uint32	val;
	uint32	*p4;

	p   = dst;
 270:	f94007e0 	ldr	x0, [sp, #8]
 274:	f90017e0 	str	x0, [sp, #40]
	c   = v & 0xff;
 278:	b94007e0 	ldr	w0, [sp, #4]
 27c:	39007fe0 	strb	w0, [sp, #31]
	val = (c << 24) | (c << 16) | (c << 8) | c;
 280:	39407fe1 	ldrb	w1, [sp, #31]
 284:	2a0103e0 	mov	w0, w1
 288:	53185c00 	lsl	w0, w0, #8
 28c:	0b010000 	add	w0, w0, w1
 290:	53103c00 	lsl	w0, w0, #16
 294:	2a0003e1 	mov	w1, w0
 298:	39407fe0 	ldrb	w0, [sp, #31]
 29c:	53185c00 	lsl	w0, w0, #8
 2a0:	2a000021 	orr	w1, w1, w0
 2a4:	39407fe0 	ldrb	w0, [sp, #31]
 2a8:	2a000020 	orr	w0, w1, w0
 2ac:	b9001be0 	str	w0, [sp, #24]

	// set bytes before whole uint32
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
 2b0:	1400000a 	b	2d8 <memset+0x78>
		*p = c;
 2b4:	f94017e0 	ldr	x0, [sp, #40]
 2b8:	39407fe1 	ldrb	w1, [sp, #31]
 2bc:	39000001 	strb	w1, [x0]
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
 2c0:	b94003e0 	ldr	w0, [sp]
 2c4:	51000400 	sub	w0, w0, #0x1
 2c8:	b90003e0 	str	w0, [sp]
 2cc:	f94017e0 	ldr	x0, [sp, #40]
 2d0:	91000400 	add	x0, x0, #0x1
 2d4:	f90017e0 	str	x0, [sp, #40]
 2d8:	b94003e0 	ldr	w0, [sp]
 2dc:	7100001f 	cmp	w0, #0x0
 2e0:	540000a0 	b.eq	2f4 <memset+0x94>  // b.none
 2e4:	f94017e0 	ldr	x0, [sp, #40]
 2e8:	92400400 	and	x0, x0, #0x3
 2ec:	f100001f 	cmp	x0, #0x0
 2f0:	54fffe21 	b.ne	2b4 <memset+0x54>  // b.any
	}

	// set memory 4 bytes a time
	p4 = (uint*)p;
 2f4:	f94017e0 	ldr	x0, [sp, #40]
 2f8:	f90013e0 	str	x0, [sp, #32]

	for (; n >= 4; n -= 4, p4++) {
 2fc:	1400000a 	b	324 <memset+0xc4>
		*p4 = val;
 300:	f94013e0 	ldr	x0, [sp, #32]
 304:	b9401be1 	ldr	w1, [sp, #24]
 308:	b9000001 	str	w1, [x0]
	for (; n >= 4; n -= 4, p4++) {
 30c:	b94003e0 	ldr	w0, [sp]
 310:	51001000 	sub	w0, w0, #0x4
 314:	b90003e0 	str	w0, [sp]
 318:	f94013e0 	ldr	x0, [sp, #32]
 31c:	91001000 	add	x0, x0, #0x4
 320:	f90013e0 	str	x0, [sp, #32]
 324:	b94003e0 	ldr	w0, [sp]
 328:	71000c1f 	cmp	w0, #0x3
 32c:	54fffea8 	b.hi	300 <memset+0xa0>  // b.pmore
	}

	// set leftover one byte a time
	p = (uint8*)p4;
 330:	f94013e0 	ldr	x0, [sp, #32]
 334:	f90017e0 	str	x0, [sp, #40]

	for (; n > 0; n--, p++) {
 338:	1400000a 	b	360 <memset+0x100>
		*p = c;
 33c:	f94017e0 	ldr	x0, [sp, #40]
 340:	39407fe1 	ldrb	w1, [sp, #31]
 344:	39000001 	strb	w1, [x0]
	for (; n > 0; n--, p++) {
 348:	b94003e0 	ldr	w0, [sp]
 34c:	51000400 	sub	w0, w0, #0x1
 350:	b90003e0 	str	w0, [sp]
 354:	f94017e0 	ldr	x0, [sp, #40]
 358:	91000400 	add	x0, x0, #0x1
 35c:	f90017e0 	str	x0, [sp, #40]
 360:	b94003e0 	ldr	w0, [sp]
 364:	7100001f 	cmp	w0, #0x0
 368:	54fffea1 	b.ne	33c <memset+0xdc>  // b.any
	}

	return dst;
 36c:	f94007e0 	ldr	x0, [sp, #8]
}
 370:	9100c3ff 	add	sp, sp, #0x30
 374:	d65f03c0 	ret

0000000000000378 <strchr>:

char*
strchr(const char *s, char c)
{
 378:	d10043ff 	sub	sp, sp, #0x10
 37c:	f90007e0 	str	x0, [sp, #8]
 380:	39001fe1 	strb	w1, [sp, #7]
    for(; *s; s++)
 384:	1400000b 	b	3b0 <strchr+0x38>
        if(*s == c)
 388:	f94007e0 	ldr	x0, [sp, #8]
 38c:	39400000 	ldrb	w0, [x0]
 390:	39401fe1 	ldrb	w1, [sp, #7]
 394:	6b00003f 	cmp	w1, w0
 398:	54000061 	b.ne	3a4 <strchr+0x2c>  // b.any
            return (char*)s;
 39c:	f94007e0 	ldr	x0, [sp, #8]
 3a0:	14000009 	b	3c4 <strchr+0x4c>
    for(; *s; s++)
 3a4:	f94007e0 	ldr	x0, [sp, #8]
 3a8:	91000400 	add	x0, x0, #0x1
 3ac:	f90007e0 	str	x0, [sp, #8]
 3b0:	f94007e0 	ldr	x0, [sp, #8]
 3b4:	39400000 	ldrb	w0, [x0]
 3b8:	7100001f 	cmp	w0, #0x0
 3bc:	54fffe61 	b.ne	388 <strchr+0x10>  // b.any
    return 0;
 3c0:	d2800000 	mov	x0, #0x0                   	// #0
}
 3c4:	910043ff 	add	sp, sp, #0x10
 3c8:	d65f03c0 	ret

00000000000003cc <gets>:

char*
gets(char *buf, int max)
{
 3cc:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 3d0:	910003fd 	mov	x29, sp
 3d4:	f9000fe0 	str	x0, [sp, #24]
 3d8:	b90017e1 	str	w1, [sp, #20]
    int i, cc;
    char c;
    
    for(i=0; i+1 < max; ){
 3dc:	b9002fff 	str	wzr, [sp, #44]
 3e0:	14000018 	b	440 <gets+0x74>
        cc = read(0, &c, 1);
 3e4:	91009fe0 	add	x0, sp, #0x27
 3e8:	52800022 	mov	w2, #0x1                   	// #1
 3ec:	aa0003e1 	mov	x1, x0
 3f0:	52800000 	mov	w0, #0x0                   	// #0
 3f4:	94000090 	bl	634 <read>
 3f8:	b9002be0 	str	w0, [sp, #40]
        if(cc < 1)
 3fc:	b9402be0 	ldr	w0, [sp, #40]
 400:	7100001f 	cmp	w0, #0x0
 404:	540002ad 	b.le	458 <gets+0x8c>
            break;
        buf[i++] = c;
 408:	b9402fe0 	ldr	w0, [sp, #44]
 40c:	11000401 	add	w1, w0, #0x1
 410:	b9002fe1 	str	w1, [sp, #44]
 414:	93407c00 	sxtw	x0, w0
 418:	f9400fe1 	ldr	x1, [sp, #24]
 41c:	8b000020 	add	x0, x1, x0
 420:	39409fe1 	ldrb	w1, [sp, #39]
 424:	39000001 	strb	w1, [x0]
        if(c == '\n' || c == '\r')
 428:	39409fe0 	ldrb	w0, [sp, #39]
 42c:	7100281f 	cmp	w0, #0xa
 430:	54000160 	b.eq	45c <gets+0x90>  // b.none
 434:	39409fe0 	ldrb	w0, [sp, #39]
 438:	7100341f 	cmp	w0, #0xd
 43c:	54000100 	b.eq	45c <gets+0x90>  // b.none
    for(i=0; i+1 < max; ){
 440:	b9402fe0 	ldr	w0, [sp, #44]
 444:	11000400 	add	w0, w0, #0x1
 448:	b94017e1 	ldr	w1, [sp, #20]
 44c:	6b00003f 	cmp	w1, w0
 450:	54fffcac 	b.gt	3e4 <gets+0x18>
 454:	14000002 	b	45c <gets+0x90>
            break;
 458:	d503201f 	nop
            break;
    }
    buf[i] = '\0';
 45c:	b9802fe0 	ldrsw	x0, [sp, #44]
 460:	f9400fe1 	ldr	x1, [sp, #24]
 464:	8b000020 	add	x0, x1, x0
 468:	3900001f 	strb	wzr, [x0]
    return buf;
 46c:	f9400fe0 	ldr	x0, [sp, #24]
}
 470:	a8c37bfd 	ldp	x29, x30, [sp], #48
 474:	d65f03c0 	ret

0000000000000478 <stat>:

int
stat(char *n, struct stat *st)
{
 478:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 47c:	910003fd 	mov	x29, sp
 480:	f9000fe0 	str	x0, [sp, #24]
 484:	f9000be1 	str	x1, [sp, #16]
    int fd;
    int r;
    
    fd = open(n, O_RDONLY);
 488:	52800001 	mov	w1, #0x0                   	// #0
 48c:	f9400fe0 	ldr	x0, [sp, #24]
 490:	94000096 	bl	6e8 <open>
 494:	b9002fe0 	str	w0, [sp, #44]
    if(fd < 0)
 498:	b9402fe0 	ldr	w0, [sp, #44]
 49c:	7100001f 	cmp	w0, #0x0
 4a0:	5400006a 	b.ge	4ac <stat+0x34>  // b.tcont
        return -1;
 4a4:	12800000 	mov	w0, #0xffffffff            	// #-1
 4a8:	14000008 	b	4c8 <stat+0x50>
    r = fstat(fd, st);
 4ac:	f9400be1 	ldr	x1, [sp, #16]
 4b0:	b9402fe0 	ldr	w0, [sp, #44]
 4b4:	940000a8 	bl	754 <fstat>
 4b8:	b9002be0 	str	w0, [sp, #40]
    close(fd);
 4bc:	b9402fe0 	ldr	w0, [sp, #44]
 4c0:	9400006f 	bl	67c <close>
    return r;
 4c4:	b9402be0 	ldr	w0, [sp, #40]
}
 4c8:	a8c37bfd 	ldp	x29, x30, [sp], #48
 4cc:	d65f03c0 	ret

00000000000004d0 <atoi>:

int
atoi(const char *s)
{
 4d0:	d10083ff 	sub	sp, sp, #0x20
 4d4:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    n = 0;
 4d8:	b9001fff 	str	wzr, [sp, #28]
    while('0' <= *s && *s <= '9')
 4dc:	1400000e 	b	514 <atoi+0x44>
        n = n*10 + *s++ - '0';
 4e0:	b9401fe1 	ldr	w1, [sp, #28]
 4e4:	2a0103e0 	mov	w0, w1
 4e8:	531e7400 	lsl	w0, w0, #2
 4ec:	0b010000 	add	w0, w0, w1
 4f0:	531f7800 	lsl	w0, w0, #1
 4f4:	2a0003e2 	mov	w2, w0
 4f8:	f94007e0 	ldr	x0, [sp, #8]
 4fc:	91000401 	add	x1, x0, #0x1
 500:	f90007e1 	str	x1, [sp, #8]
 504:	39400000 	ldrb	w0, [x0]
 508:	0b000040 	add	w0, w2, w0
 50c:	5100c000 	sub	w0, w0, #0x30
 510:	b9001fe0 	str	w0, [sp, #28]
    while('0' <= *s && *s <= '9')
 514:	f94007e0 	ldr	x0, [sp, #8]
 518:	39400000 	ldrb	w0, [x0]
 51c:	7100bc1f 	cmp	w0, #0x2f
 520:	540000a9 	b.ls	534 <atoi+0x64>  // b.plast
 524:	f94007e0 	ldr	x0, [sp, #8]
 528:	39400000 	ldrb	w0, [x0]
 52c:	7100e41f 	cmp	w0, #0x39
 530:	54fffd89 	b.ls	4e0 <atoi+0x10>  // b.plast
    return n;
 534:	b9401fe0 	ldr	w0, [sp, #28]
}
 538:	910083ff 	add	sp, sp, #0x20
 53c:	d65f03c0 	ret

0000000000000540 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 540:	d100c3ff 	sub	sp, sp, #0x30
 544:	f9000fe0 	str	x0, [sp, #24]
 548:	f9000be1 	str	x1, [sp, #16]
 54c:	b9000fe2 	str	w2, [sp, #12]
    char *dst, *src;
    
    dst = vdst;
 550:	f9400fe0 	ldr	x0, [sp, #24]
 554:	f90017e0 	str	x0, [sp, #40]
    src = vsrc;
 558:	f9400be0 	ldr	x0, [sp, #16]
 55c:	f90013e0 	str	x0, [sp, #32]
    while(n-- > 0)
 560:	14000009 	b	584 <memmove+0x44>
        *dst++ = *src++;
 564:	f94013e1 	ldr	x1, [sp, #32]
 568:	91000420 	add	x0, x1, #0x1
 56c:	f90013e0 	str	x0, [sp, #32]
 570:	f94017e0 	ldr	x0, [sp, #40]
 574:	91000402 	add	x2, x0, #0x1
 578:	f90017e2 	str	x2, [sp, #40]
 57c:	39400021 	ldrb	w1, [x1]
 580:	39000001 	strb	w1, [x0]
    while(n-- > 0)
 584:	b9400fe0 	ldr	w0, [sp, #12]
 588:	51000401 	sub	w1, w0, #0x1
 58c:	b9000fe1 	str	w1, [sp, #12]
 590:	7100001f 	cmp	w0, #0x0
 594:	54fffe8c 	b.gt	564 <memmove+0x24>
    return vdst;
 598:	f9400fe0 	ldr	x0, [sp, #24]
}
 59c:	9100c3ff 	add	sp, sp, #0x30
 5a0:	d65f03c0 	ret

00000000000005a4 <fork>:
 5a4:	f81f8fe4 	str	x4, [sp, #-8]!
 5a8:	aa0303e4 	mov	x4, x3
 5ac:	aa0203e3 	mov	x3, x2
 5b0:	aa0103e2 	mov	x2, x1
 5b4:	aa0003e1 	mov	x1, x0
 5b8:	d2800020 	mov	x0, #0x1                   	// #1
 5bc:	d4000001 	svc	#0x0
 5c0:	f84087e4 	ldr	x4, [sp], #8
 5c4:	d61f03c0 	br	x30

00000000000005c8 <exit>:
 5c8:	f81f8fe4 	str	x4, [sp, #-8]!
 5cc:	aa0303e4 	mov	x4, x3
 5d0:	aa0203e3 	mov	x3, x2
 5d4:	aa0103e2 	mov	x2, x1
 5d8:	aa0003e1 	mov	x1, x0
 5dc:	d2800040 	mov	x0, #0x2                   	// #2
 5e0:	d4000001 	svc	#0x0
 5e4:	f84087e4 	ldr	x4, [sp], #8
 5e8:	d61f03c0 	br	x30

00000000000005ec <wait>:
 5ec:	f81f8fe4 	str	x4, [sp, #-8]!
 5f0:	aa0303e4 	mov	x4, x3
 5f4:	aa0203e3 	mov	x3, x2
 5f8:	aa0103e2 	mov	x2, x1
 5fc:	aa0003e1 	mov	x1, x0
 600:	d2800060 	mov	x0, #0x3                   	// #3
 604:	d4000001 	svc	#0x0
 608:	f84087e4 	ldr	x4, [sp], #8
 60c:	d61f03c0 	br	x30

0000000000000610 <pipe>:
 610:	f81f8fe4 	str	x4, [sp, #-8]!
 614:	aa0303e4 	mov	x4, x3
 618:	aa0203e3 	mov	x3, x2
 61c:	aa0103e2 	mov	x2, x1
 620:	aa0003e1 	mov	x1, x0
 624:	d2800080 	mov	x0, #0x4                   	// #4
 628:	d4000001 	svc	#0x0
 62c:	f84087e4 	ldr	x4, [sp], #8
 630:	d61f03c0 	br	x30

0000000000000634 <read>:
 634:	f81f8fe4 	str	x4, [sp, #-8]!
 638:	aa0303e4 	mov	x4, x3
 63c:	aa0203e3 	mov	x3, x2
 640:	aa0103e2 	mov	x2, x1
 644:	aa0003e1 	mov	x1, x0
 648:	d28000a0 	mov	x0, #0x5                   	// #5
 64c:	d4000001 	svc	#0x0
 650:	f84087e4 	ldr	x4, [sp], #8
 654:	d61f03c0 	br	x30

0000000000000658 <write>:
 658:	f81f8fe4 	str	x4, [sp, #-8]!
 65c:	aa0303e4 	mov	x4, x3
 660:	aa0203e3 	mov	x3, x2
 664:	aa0103e2 	mov	x2, x1
 668:	aa0003e1 	mov	x1, x0
 66c:	d2800200 	mov	x0, #0x10                  	// #16
 670:	d4000001 	svc	#0x0
 674:	f84087e4 	ldr	x4, [sp], #8
 678:	d61f03c0 	br	x30

000000000000067c <close>:
 67c:	f81f8fe4 	str	x4, [sp, #-8]!
 680:	aa0303e4 	mov	x4, x3
 684:	aa0203e3 	mov	x3, x2
 688:	aa0103e2 	mov	x2, x1
 68c:	aa0003e1 	mov	x1, x0
 690:	d28002a0 	mov	x0, #0x15                  	// #21
 694:	d4000001 	svc	#0x0
 698:	f84087e4 	ldr	x4, [sp], #8
 69c:	d61f03c0 	br	x30

00000000000006a0 <kill>:
 6a0:	f81f8fe4 	str	x4, [sp, #-8]!
 6a4:	aa0303e4 	mov	x4, x3
 6a8:	aa0203e3 	mov	x3, x2
 6ac:	aa0103e2 	mov	x2, x1
 6b0:	aa0003e1 	mov	x1, x0
 6b4:	d28000c0 	mov	x0, #0x6                   	// #6
 6b8:	d4000001 	svc	#0x0
 6bc:	f84087e4 	ldr	x4, [sp], #8
 6c0:	d61f03c0 	br	x30

00000000000006c4 <exec>:
 6c4:	f81f8fe4 	str	x4, [sp, #-8]!
 6c8:	aa0303e4 	mov	x4, x3
 6cc:	aa0203e3 	mov	x3, x2
 6d0:	aa0103e2 	mov	x2, x1
 6d4:	aa0003e1 	mov	x1, x0
 6d8:	d28000e0 	mov	x0, #0x7                   	// #7
 6dc:	d4000001 	svc	#0x0
 6e0:	f84087e4 	ldr	x4, [sp], #8
 6e4:	d61f03c0 	br	x30

00000000000006e8 <open>:
 6e8:	f81f8fe4 	str	x4, [sp, #-8]!
 6ec:	aa0303e4 	mov	x4, x3
 6f0:	aa0203e3 	mov	x3, x2
 6f4:	aa0103e2 	mov	x2, x1
 6f8:	aa0003e1 	mov	x1, x0
 6fc:	d28001e0 	mov	x0, #0xf                   	// #15
 700:	d4000001 	svc	#0x0
 704:	f84087e4 	ldr	x4, [sp], #8
 708:	d61f03c0 	br	x30

000000000000070c <mknod>:
 70c:	f81f8fe4 	str	x4, [sp, #-8]!
 710:	aa0303e4 	mov	x4, x3
 714:	aa0203e3 	mov	x3, x2
 718:	aa0103e2 	mov	x2, x1
 71c:	aa0003e1 	mov	x1, x0
 720:	d2800220 	mov	x0, #0x11                  	// #17
 724:	d4000001 	svc	#0x0
 728:	f84087e4 	ldr	x4, [sp], #8
 72c:	d61f03c0 	br	x30

0000000000000730 <unlink>:
 730:	f81f8fe4 	str	x4, [sp, #-8]!
 734:	aa0303e4 	mov	x4, x3
 738:	aa0203e3 	mov	x3, x2
 73c:	aa0103e2 	mov	x2, x1
 740:	aa0003e1 	mov	x1, x0
 744:	d2800240 	mov	x0, #0x12                  	// #18
 748:	d4000001 	svc	#0x0
 74c:	f84087e4 	ldr	x4, [sp], #8
 750:	d61f03c0 	br	x30

0000000000000754 <fstat>:
 754:	f81f8fe4 	str	x4, [sp, #-8]!
 758:	aa0303e4 	mov	x4, x3
 75c:	aa0203e3 	mov	x3, x2
 760:	aa0103e2 	mov	x2, x1
 764:	aa0003e1 	mov	x1, x0
 768:	d2800100 	mov	x0, #0x8                   	// #8
 76c:	d4000001 	svc	#0x0
 770:	f84087e4 	ldr	x4, [sp], #8
 774:	d61f03c0 	br	x30

0000000000000778 <link>:
 778:	f81f8fe4 	str	x4, [sp, #-8]!
 77c:	aa0303e4 	mov	x4, x3
 780:	aa0203e3 	mov	x3, x2
 784:	aa0103e2 	mov	x2, x1
 788:	aa0003e1 	mov	x1, x0
 78c:	d2800260 	mov	x0, #0x13                  	// #19
 790:	d4000001 	svc	#0x0
 794:	f84087e4 	ldr	x4, [sp], #8
 798:	d61f03c0 	br	x30

000000000000079c <mkdir>:
 79c:	f81f8fe4 	str	x4, [sp, #-8]!
 7a0:	aa0303e4 	mov	x4, x3
 7a4:	aa0203e3 	mov	x3, x2
 7a8:	aa0103e2 	mov	x2, x1
 7ac:	aa0003e1 	mov	x1, x0
 7b0:	d2800280 	mov	x0, #0x14                  	// #20
 7b4:	d4000001 	svc	#0x0
 7b8:	f84087e4 	ldr	x4, [sp], #8
 7bc:	d61f03c0 	br	x30

00000000000007c0 <chdir>:
 7c0:	f81f8fe4 	str	x4, [sp, #-8]!
 7c4:	aa0303e4 	mov	x4, x3
 7c8:	aa0203e3 	mov	x3, x2
 7cc:	aa0103e2 	mov	x2, x1
 7d0:	aa0003e1 	mov	x1, x0
 7d4:	d2800120 	mov	x0, #0x9                   	// #9
 7d8:	d4000001 	svc	#0x0
 7dc:	f84087e4 	ldr	x4, [sp], #8
 7e0:	d61f03c0 	br	x30

00000000000007e4 <dup>:
 7e4:	f81f8fe4 	str	x4, [sp, #-8]!
 7e8:	aa0303e4 	mov	x4, x3
 7ec:	aa0203e3 	mov	x3, x2
 7f0:	aa0103e2 	mov	x2, x1
 7f4:	aa0003e1 	mov	x1, x0
 7f8:	d2800140 	mov	x0, #0xa                   	// #10
 7fc:	d4000001 	svc	#0x0
 800:	f84087e4 	ldr	x4, [sp], #8
 804:	d61f03c0 	br	x30

0000000000000808 <getpid>:
 808:	f81f8fe4 	str	x4, [sp, #-8]!
 80c:	aa0303e4 	mov	x4, x3
 810:	aa0203e3 	mov	x3, x2
 814:	aa0103e2 	mov	x2, x1
 818:	aa0003e1 	mov	x1, x0
 81c:	d2800160 	mov	x0, #0xb                   	// #11
 820:	d4000001 	svc	#0x0
 824:	f84087e4 	ldr	x4, [sp], #8
 828:	d61f03c0 	br	x30

000000000000082c <sbrk>:
 82c:	f81f8fe4 	str	x4, [sp, #-8]!
 830:	aa0303e4 	mov	x4, x3
 834:	aa0203e3 	mov	x3, x2
 838:	aa0103e2 	mov	x2, x1
 83c:	aa0003e1 	mov	x1, x0
 840:	d2800180 	mov	x0, #0xc                   	// #12
 844:	d4000001 	svc	#0x0
 848:	f84087e4 	ldr	x4, [sp], #8
 84c:	d61f03c0 	br	x30

0000000000000850 <sleep>:
 850:	f81f8fe4 	str	x4, [sp, #-8]!
 854:	aa0303e4 	mov	x4, x3
 858:	aa0203e3 	mov	x3, x2
 85c:	aa0103e2 	mov	x2, x1
 860:	aa0003e1 	mov	x1, x0
 864:	d28001a0 	mov	x0, #0xd                   	// #13
 868:	d4000001 	svc	#0x0
 86c:	f84087e4 	ldr	x4, [sp], #8
 870:	d61f03c0 	br	x30

0000000000000874 <uptime>:
 874:	f81f8fe4 	str	x4, [sp, #-8]!
 878:	aa0303e4 	mov	x4, x3
 87c:	aa0203e3 	mov	x3, x2
 880:	aa0103e2 	mov	x2, x1
 884:	aa0003e1 	mov	x1, x0
 888:	d28001c0 	mov	x0, #0xe                   	// #14
 88c:	d4000001 	svc	#0x0
 890:	f84087e4 	ldr	x4, [sp], #8
 894:	d61f03c0 	br	x30

0000000000000898 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 898:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
 89c:	910003fd 	mov	x29, sp
 8a0:	b9001fe0 	str	w0, [sp, #28]
 8a4:	39006fe1 	strb	w1, [sp, #27]
    write(fd, &c, 1);
 8a8:	91006fe0 	add	x0, sp, #0x1b
 8ac:	52800022 	mov	w2, #0x1                   	// #1
 8b0:	aa0003e1 	mov	x1, x0
 8b4:	b9401fe0 	ldr	w0, [sp, #28]
 8b8:	97ffff68 	bl	658 <write>
}
 8bc:	d503201f 	nop
 8c0:	a8c27bfd 	ldp	x29, x30, [sp], #32
 8c4:	d65f03c0 	ret

00000000000008c8 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 8c8:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 8cc:	910003fd 	mov	x29, sp
 8d0:	b9001fe0 	str	w0, [sp, #28]
 8d4:	b9001be1 	str	w1, [sp, #24]
 8d8:	b90017e2 	str	w2, [sp, #20]
 8dc:	b90013e3 	str	w3, [sp, #16]
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
 8e0:	b9003bff 	str	wzr, [sp, #56]
    if(sgn && xx < 0){
 8e4:	b94013e0 	ldr	w0, [sp, #16]
 8e8:	7100001f 	cmp	w0, #0x0
 8ec:	54000140 	b.eq	914 <printint+0x4c>  // b.none
 8f0:	b9401be0 	ldr	w0, [sp, #24]
 8f4:	7100001f 	cmp	w0, #0x0
 8f8:	540000ea 	b.ge	914 <printint+0x4c>  // b.tcont
        neg = 1;
 8fc:	52800020 	mov	w0, #0x1                   	// #1
 900:	b9003be0 	str	w0, [sp, #56]
        x = -xx;
 904:	b9401be0 	ldr	w0, [sp, #24]
 908:	4b0003e0 	neg	w0, w0
 90c:	b90037e0 	str	w0, [sp, #52]
 910:	14000003 	b	91c <printint+0x54>
    } else {
        x = xx;
 914:	b9401be0 	ldr	w0, [sp, #24]
 918:	b90037e0 	str	w0, [sp, #52]
    }
    
    i = 0;
 91c:	b9003fff 	str	wzr, [sp, #60]
    do{
        buf[i++] = digits[x % base];
 920:	b94017e1 	ldr	w1, [sp, #20]
 924:	b94037e0 	ldr	w0, [sp, #52]
 928:	1ac10802 	udiv	w2, w0, w1
 92c:	1b017c41 	mul	w1, w2, w1
 930:	4b010003 	sub	w3, w0, w1
 934:	b9403fe0 	ldr	w0, [sp, #60]
 938:	11000401 	add	w1, w0, #0x1
 93c:	b9003fe1 	str	w1, [sp, #60]
 940:	90000001 	adrp	x1, 0 <main>
 944:	913fe022 	add	x2, x1, #0xff8
 948:	2a0303e1 	mov	w1, w3
 94c:	38616842 	ldrb	w2, [x2, x1]
 950:	93407c00 	sxtw	x0, w0
 954:	910083e1 	add	x1, sp, #0x20
 958:	38206822 	strb	w2, [x1, x0]
    }while((x /= base) != 0);
 95c:	b94017e0 	ldr	w0, [sp, #20]
 960:	b94037e1 	ldr	w1, [sp, #52]
 964:	1ac00820 	udiv	w0, w1, w0
 968:	b90037e0 	str	w0, [sp, #52]
 96c:	b94037e0 	ldr	w0, [sp, #52]
 970:	7100001f 	cmp	w0, #0x0
 974:	54fffd61 	b.ne	920 <printint+0x58>  // b.any
    if(neg)
 978:	b9403be0 	ldr	w0, [sp, #56]
 97c:	7100001f 	cmp	w0, #0x0
 980:	540001e0 	b.eq	9bc <printint+0xf4>  // b.none
        buf[i++] = '-';
 984:	b9403fe0 	ldr	w0, [sp, #60]
 988:	11000401 	add	w1, w0, #0x1
 98c:	b9003fe1 	str	w1, [sp, #60]
 990:	93407c00 	sxtw	x0, w0
 994:	910083e1 	add	x1, sp, #0x20
 998:	528005a2 	mov	w2, #0x2d                  	// #45
 99c:	38206822 	strb	w2, [x1, x0]
    
    while(--i >= 0)
 9a0:	14000007 	b	9bc <printint+0xf4>
        putc(fd, buf[i]);
 9a4:	b9803fe0 	ldrsw	x0, [sp, #60]
 9a8:	910083e1 	add	x1, sp, #0x20
 9ac:	38606820 	ldrb	w0, [x1, x0]
 9b0:	2a0003e1 	mov	w1, w0
 9b4:	b9401fe0 	ldr	w0, [sp, #28]
 9b8:	97ffffb8 	bl	898 <putc>
    while(--i >= 0)
 9bc:	b9403fe0 	ldr	w0, [sp, #60]
 9c0:	51000400 	sub	w0, w0, #0x1
 9c4:	b9003fe0 	str	w0, [sp, #60]
 9c8:	b9403fe0 	ldr	w0, [sp, #60]
 9cc:	7100001f 	cmp	w0, #0x0
 9d0:	54fffeaa 	b.ge	9a4 <printint+0xdc>  // b.tcont
}
 9d4:	d503201f 	nop
 9d8:	d503201f 	nop
 9dc:	a8c47bfd 	ldp	x29, x30, [sp], #64
 9e0:	d65f03c0 	ret

00000000000009e4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 9e4:	a9b17bfd 	stp	x29, x30, [sp, #-240]!
 9e8:	910003fd 	mov	x29, sp
 9ec:	b9001fe0 	str	w0, [sp, #28]
 9f0:	f9000be1 	str	x1, [sp, #16]
 9f4:	f90063e2 	str	x2, [sp, #192]
 9f8:	f90067e3 	str	x3, [sp, #200]
 9fc:	f9006be4 	str	x4, [sp, #208]
 a00:	f9006fe5 	str	x5, [sp, #216]
 a04:	f90073e6 	str	x6, [sp, #224]
 a08:	f90077e7 	str	x7, [sp, #232]
 a0c:	3d8013e0 	str	q0, [sp, #64]
 a10:	3d8017e1 	str	q1, [sp, #80]
 a14:	3d801be2 	str	q2, [sp, #96]
 a18:	3d801fe3 	str	q3, [sp, #112]
 a1c:	3d8023e4 	str	q4, [sp, #128]
 a20:	3d8027e5 	str	q5, [sp, #144]
 a24:	3d802be6 	str	q6, [sp, #160]
 a28:	3d802fe7 	str	q7, [sp, #176]
    char *s;
    int c, i, state;
    uint64 *ap;
    
    state = 0;
 a2c:	b90033ff 	str	wzr, [sp, #48]
    ap = (uint64*)(void*)&fmt + 22;
 a30:	910043e0 	add	x0, sp, #0x10
 a34:	9102c000 	add	x0, x0, #0xb0
 a38:	f90017e0 	str	x0, [sp, #40]
    for(i = 0; fmt[i]; i++){
 a3c:	b90037ff 	str	wzr, [sp, #52]
 a40:	14000076 	b	c18 <printf+0x234>
        c = fmt[i] & 0xff;
 a44:	f9400be1 	ldr	x1, [sp, #16]
 a48:	b98037e0 	ldrsw	x0, [sp, #52]
 a4c:	8b000020 	add	x0, x1, x0
 a50:	39400000 	ldrb	w0, [x0]
 a54:	b90027e0 	str	w0, [sp, #36]
        if(state == 0){
 a58:	b94033e0 	ldr	w0, [sp, #48]
 a5c:	7100001f 	cmp	w0, #0x0
 a60:	540001a1 	b.ne	a94 <printf+0xb0>  // b.any
            if(c == '%'){
 a64:	b94027e0 	ldr	w0, [sp, #36]
 a68:	7100941f 	cmp	w0, #0x25
 a6c:	54000081 	b.ne	a7c <printf+0x98>  // b.any
                state = '%';
 a70:	528004a0 	mov	w0, #0x25                  	// #37
 a74:	b90033e0 	str	w0, [sp, #48]
 a78:	14000065 	b	c0c <printf+0x228>
            } else {
                putc(fd, c);
 a7c:	b94027e0 	ldr	w0, [sp, #36]
 a80:	12001c00 	and	w0, w0, #0xff
 a84:	2a0003e1 	mov	w1, w0
 a88:	b9401fe0 	ldr	w0, [sp, #28]
 a8c:	97ffff83 	bl	898 <putc>
 a90:	1400005f 	b	c0c <printf+0x228>
            }
        } else if(state == '%'){
 a94:	b94033e0 	ldr	w0, [sp, #48]
 a98:	7100941f 	cmp	w0, #0x25
 a9c:	54000b81 	b.ne	c0c <printf+0x228>  // b.any
            if(c == 'd'){
 aa0:	b94027e0 	ldr	w0, [sp, #36]
 aa4:	7101901f 	cmp	w0, #0x64
 aa8:	54000181 	b.ne	ad8 <printf+0xf4>  // b.any
                printint(fd, *ap, 10, 1);
 aac:	f94017e0 	ldr	x0, [sp, #40]
 ab0:	f9400000 	ldr	x0, [x0]
 ab4:	52800023 	mov	w3, #0x1                   	// #1
 ab8:	52800142 	mov	w2, #0xa                   	// #10
 abc:	2a0003e1 	mov	w1, w0
 ac0:	b9401fe0 	ldr	w0, [sp, #28]
 ac4:	97ffff81 	bl	8c8 <printint>
                ap++;
 ac8:	f94017e0 	ldr	x0, [sp, #40]
 acc:	91002000 	add	x0, x0, #0x8
 ad0:	f90017e0 	str	x0, [sp, #40]
 ad4:	1400004d 	b	c08 <printf+0x224>
            } else if(c == 'x' || c == 'p'){
 ad8:	b94027e0 	ldr	w0, [sp, #36]
 adc:	7101e01f 	cmp	w0, #0x78
 ae0:	54000080 	b.eq	af0 <printf+0x10c>  // b.none
 ae4:	b94027e0 	ldr	w0, [sp, #36]
 ae8:	7101c01f 	cmp	w0, #0x70
 aec:	54000181 	b.ne	b1c <printf+0x138>  // b.any
                printint(fd, *ap, 16, 0);
 af0:	f94017e0 	ldr	x0, [sp, #40]
 af4:	f9400000 	ldr	x0, [x0]
 af8:	52800003 	mov	w3, #0x0                   	// #0
 afc:	52800202 	mov	w2, #0x10                  	// #16
 b00:	2a0003e1 	mov	w1, w0
 b04:	b9401fe0 	ldr	w0, [sp, #28]
 b08:	97ffff70 	bl	8c8 <printint>
                ap++;
 b0c:	f94017e0 	ldr	x0, [sp, #40]
 b10:	91002000 	add	x0, x0, #0x8
 b14:	f90017e0 	str	x0, [sp, #40]
 b18:	1400003c 	b	c08 <printf+0x224>
            } else if(c == 's'){
 b1c:	b94027e0 	ldr	w0, [sp, #36]
 b20:	7101cc1f 	cmp	w0, #0x73
 b24:	54000361 	b.ne	b90 <printf+0x1ac>  // b.any
                s = (char*)*ap;
 b28:	f94017e0 	ldr	x0, [sp, #40]
 b2c:	f9400000 	ldr	x0, [x0]
 b30:	f9001fe0 	str	x0, [sp, #56]
                ap++;
 b34:	f94017e0 	ldr	x0, [sp, #40]
 b38:	91002000 	add	x0, x0, #0x8
 b3c:	f90017e0 	str	x0, [sp, #40]
                if(s == 0)
 b40:	f9401fe0 	ldr	x0, [sp, #56]
 b44:	f100001f 	cmp	x0, #0x0
 b48:	540001a1 	b.ne	b7c <printf+0x198>  // b.any
                    s = "(null)";
 b4c:	90000000 	adrp	x0, 0 <main>
 b50:	913fc000 	add	x0, x0, #0xff0
 b54:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
 b58:	14000009 	b	b7c <printf+0x198>
                    putc(fd, *s);
 b5c:	f9401fe0 	ldr	x0, [sp, #56]
 b60:	39400000 	ldrb	w0, [x0]
 b64:	2a0003e1 	mov	w1, w0
 b68:	b9401fe0 	ldr	w0, [sp, #28]
 b6c:	97ffff4b 	bl	898 <putc>
                    s++;
 b70:	f9401fe0 	ldr	x0, [sp, #56]
 b74:	91000400 	add	x0, x0, #0x1
 b78:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
 b7c:	f9401fe0 	ldr	x0, [sp, #56]
 b80:	39400000 	ldrb	w0, [x0]
 b84:	7100001f 	cmp	w0, #0x0
 b88:	54fffea1 	b.ne	b5c <printf+0x178>  // b.any
 b8c:	1400001f 	b	c08 <printf+0x224>
                }
            } else if(c == 'c'){
 b90:	b94027e0 	ldr	w0, [sp, #36]
 b94:	71018c1f 	cmp	w0, #0x63
 b98:	54000161 	b.ne	bc4 <printf+0x1e0>  // b.any
                putc(fd, *ap);
 b9c:	f94017e0 	ldr	x0, [sp, #40]
 ba0:	f9400000 	ldr	x0, [x0]
 ba4:	12001c00 	and	w0, w0, #0xff
 ba8:	2a0003e1 	mov	w1, w0
 bac:	b9401fe0 	ldr	w0, [sp, #28]
 bb0:	97ffff3a 	bl	898 <putc>
                ap++;
 bb4:	f94017e0 	ldr	x0, [sp, #40]
 bb8:	91002000 	add	x0, x0, #0x8
 bbc:	f90017e0 	str	x0, [sp, #40]
 bc0:	14000012 	b	c08 <printf+0x224>
            } else if(c == '%'){
 bc4:	b94027e0 	ldr	w0, [sp, #36]
 bc8:	7100941f 	cmp	w0, #0x25
 bcc:	540000e1 	b.ne	be8 <printf+0x204>  // b.any
                putc(fd, c);
 bd0:	b94027e0 	ldr	w0, [sp, #36]
 bd4:	12001c00 	and	w0, w0, #0xff
 bd8:	2a0003e1 	mov	w1, w0
 bdc:	b9401fe0 	ldr	w0, [sp, #28]
 be0:	97ffff2e 	bl	898 <putc>
 be4:	14000009 	b	c08 <printf+0x224>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
 be8:	528004a1 	mov	w1, #0x25                  	// #37
 bec:	b9401fe0 	ldr	w0, [sp, #28]
 bf0:	97ffff2a 	bl	898 <putc>
                putc(fd, c);
 bf4:	b94027e0 	ldr	w0, [sp, #36]
 bf8:	12001c00 	and	w0, w0, #0xff
 bfc:	2a0003e1 	mov	w1, w0
 c00:	b9401fe0 	ldr	w0, [sp, #28]
 c04:	97ffff25 	bl	898 <putc>
            }
            state = 0;
 c08:	b90033ff 	str	wzr, [sp, #48]
    for(i = 0; fmt[i]; i++){
 c0c:	b94037e0 	ldr	w0, [sp, #52]
 c10:	11000400 	add	w0, w0, #0x1
 c14:	b90037e0 	str	w0, [sp, #52]
 c18:	f9400be1 	ldr	x1, [sp, #16]
 c1c:	b98037e0 	ldrsw	x0, [sp, #52]
 c20:	8b000020 	add	x0, x1, x0
 c24:	39400000 	ldrb	w0, [x0]
 c28:	7100001f 	cmp	w0, #0x0
 c2c:	54fff0c1 	b.ne	a44 <printf+0x60>  // b.any
        }
    }
}
 c30:	d503201f 	nop
 c34:	d503201f 	nop
 c38:	a8cf7bfd 	ldp	x29, x30, [sp], #240
 c3c:	d65f03c0 	ret

0000000000000c40 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 c40:	d10083ff 	sub	sp, sp, #0x20
 c44:	f90007e0 	str	x0, [sp, #8]
    Header *bp, *p;
    
    bp = (Header*)ap - 1;
 c48:	f94007e0 	ldr	x0, [sp, #8]
 c4c:	d1004000 	sub	x0, x0, #0x10
 c50:	f9000be0 	str	x0, [sp, #16]
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c54:	b0000000 	adrp	x0, 1000 <digits.0+0x8>
 c58:	91008000 	add	x0, x0, #0x20
 c5c:	f9400000 	ldr	x0, [x0]
 c60:	f9000fe0 	str	x0, [sp, #24]
 c64:	14000012 	b	cac <free+0x6c>
        if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c68:	f9400fe0 	ldr	x0, [sp, #24]
 c6c:	f9400000 	ldr	x0, [x0]
 c70:	f9400fe1 	ldr	x1, [sp, #24]
 c74:	eb00003f 	cmp	x1, x0
 c78:	54000143 	b.cc	ca0 <free+0x60>  // b.lo, b.ul, b.last
 c7c:	f9400be1 	ldr	x1, [sp, #16]
 c80:	f9400fe0 	ldr	x0, [sp, #24]
 c84:	eb00003f 	cmp	x1, x0
 c88:	54000248 	b.hi	cd0 <free+0x90>  // b.pmore
 c8c:	f9400fe0 	ldr	x0, [sp, #24]
 c90:	f9400000 	ldr	x0, [x0]
 c94:	f9400be1 	ldr	x1, [sp, #16]
 c98:	eb00003f 	cmp	x1, x0
 c9c:	540001a3 	b.cc	cd0 <free+0x90>  // b.lo, b.ul, b.last
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ca0:	f9400fe0 	ldr	x0, [sp, #24]
 ca4:	f9400000 	ldr	x0, [x0]
 ca8:	f9000fe0 	str	x0, [sp, #24]
 cac:	f9400be1 	ldr	x1, [sp, #16]
 cb0:	f9400fe0 	ldr	x0, [sp, #24]
 cb4:	eb00003f 	cmp	x1, x0
 cb8:	54fffd89 	b.ls	c68 <free+0x28>  // b.plast
 cbc:	f9400fe0 	ldr	x0, [sp, #24]
 cc0:	f9400000 	ldr	x0, [x0]
 cc4:	f9400be1 	ldr	x1, [sp, #16]
 cc8:	eb00003f 	cmp	x1, x0
 ccc:	54fffce2 	b.cs	c68 <free+0x28>  // b.hs, b.nlast
            break;
    if(bp + bp->s.size == p->s.ptr){
 cd0:	f9400be0 	ldr	x0, [sp, #16]
 cd4:	b9400800 	ldr	w0, [x0, #8]
 cd8:	2a0003e0 	mov	w0, w0
 cdc:	d37cec00 	lsl	x0, x0, #4
 ce0:	f9400be1 	ldr	x1, [sp, #16]
 ce4:	8b000021 	add	x1, x1, x0
 ce8:	f9400fe0 	ldr	x0, [sp, #24]
 cec:	f9400000 	ldr	x0, [x0]
 cf0:	eb00003f 	cmp	x1, x0
 cf4:	540001e1 	b.ne	d30 <free+0xf0>  // b.any
        bp->s.size += p->s.ptr->s.size;
 cf8:	f9400be0 	ldr	x0, [sp, #16]
 cfc:	b9400801 	ldr	w1, [x0, #8]
 d00:	f9400fe0 	ldr	x0, [sp, #24]
 d04:	f9400000 	ldr	x0, [x0]
 d08:	b9400800 	ldr	w0, [x0, #8]
 d0c:	0b000021 	add	w1, w1, w0
 d10:	f9400be0 	ldr	x0, [sp, #16]
 d14:	b9000801 	str	w1, [x0, #8]
        bp->s.ptr = p->s.ptr->s.ptr;
 d18:	f9400fe0 	ldr	x0, [sp, #24]
 d1c:	f9400000 	ldr	x0, [x0]
 d20:	f9400001 	ldr	x1, [x0]
 d24:	f9400be0 	ldr	x0, [sp, #16]
 d28:	f9000001 	str	x1, [x0]
 d2c:	14000005 	b	d40 <free+0x100>
    } else
        bp->s.ptr = p->s.ptr;
 d30:	f9400fe0 	ldr	x0, [sp, #24]
 d34:	f9400001 	ldr	x1, [x0]
 d38:	f9400be0 	ldr	x0, [sp, #16]
 d3c:	f9000001 	str	x1, [x0]
    if(p + p->s.size == bp){
 d40:	f9400fe0 	ldr	x0, [sp, #24]
 d44:	b9400800 	ldr	w0, [x0, #8]
 d48:	2a0003e0 	mov	w0, w0
 d4c:	d37cec00 	lsl	x0, x0, #4
 d50:	f9400fe1 	ldr	x1, [sp, #24]
 d54:	8b000020 	add	x0, x1, x0
 d58:	f9400be1 	ldr	x1, [sp, #16]
 d5c:	eb00003f 	cmp	x1, x0
 d60:	540001a1 	b.ne	d94 <free+0x154>  // b.any
        p->s.size += bp->s.size;
 d64:	f9400fe0 	ldr	x0, [sp, #24]
 d68:	b9400801 	ldr	w1, [x0, #8]
 d6c:	f9400be0 	ldr	x0, [sp, #16]
 d70:	b9400800 	ldr	w0, [x0, #8]
 d74:	0b000021 	add	w1, w1, w0
 d78:	f9400fe0 	ldr	x0, [sp, #24]
 d7c:	b9000801 	str	w1, [x0, #8]
        p->s.ptr = bp->s.ptr;
 d80:	f9400be0 	ldr	x0, [sp, #16]
 d84:	f9400001 	ldr	x1, [x0]
 d88:	f9400fe0 	ldr	x0, [sp, #24]
 d8c:	f9000001 	str	x1, [x0]
 d90:	14000004 	b	da0 <free+0x160>
    } else
        p->s.ptr = bp;
 d94:	f9400fe0 	ldr	x0, [sp, #24]
 d98:	f9400be1 	ldr	x1, [sp, #16]
 d9c:	f9000001 	str	x1, [x0]
    freep = p;
 da0:	b0000000 	adrp	x0, 1000 <digits.0+0x8>
 da4:	91008000 	add	x0, x0, #0x20
 da8:	f9400fe1 	ldr	x1, [sp, #24]
 dac:	f9000001 	str	x1, [x0]
}
 db0:	d503201f 	nop
 db4:	910083ff 	add	sp, sp, #0x20
 db8:	d65f03c0 	ret

0000000000000dbc <morecore>:

static Header*
morecore(uint nu)
{
 dbc:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 dc0:	910003fd 	mov	x29, sp
 dc4:	b9001fe0 	str	w0, [sp, #28]
    char *p;
    Header *hp;
    
    if(nu < 4096)
 dc8:	b9401fe0 	ldr	w0, [sp, #28]
 dcc:	713ffc1f 	cmp	w0, #0xfff
 dd0:	54000068 	b.hi	ddc <morecore+0x20>  // b.pmore
        nu = 4096;
 dd4:	52820000 	mov	w0, #0x1000                	// #4096
 dd8:	b9001fe0 	str	w0, [sp, #28]
    p = sbrk(nu * sizeof(Header));
 ddc:	b9401fe0 	ldr	w0, [sp, #28]
 de0:	531c6c00 	lsl	w0, w0, #4
 de4:	97fffe92 	bl	82c <sbrk>
 de8:	f90017e0 	str	x0, [sp, #40]
    if(p == (char*)-1)
 dec:	f94017e0 	ldr	x0, [sp, #40]
 df0:	b100041f 	cmn	x0, #0x1
 df4:	54000061 	b.ne	e00 <morecore+0x44>  // b.any
        return 0;
 df8:	d2800000 	mov	x0, #0x0                   	// #0
 dfc:	1400000c 	b	e2c <morecore+0x70>
    hp = (Header*)p;
 e00:	f94017e0 	ldr	x0, [sp, #40]
 e04:	f90013e0 	str	x0, [sp, #32]
    hp->s.size = nu;
 e08:	f94013e0 	ldr	x0, [sp, #32]
 e0c:	b9401fe1 	ldr	w1, [sp, #28]
 e10:	b9000801 	str	w1, [x0, #8]
    free((void*)(hp + 1));
 e14:	f94013e0 	ldr	x0, [sp, #32]
 e18:	91004000 	add	x0, x0, #0x10
 e1c:	97ffff89 	bl	c40 <free>
    return freep;
 e20:	b0000000 	adrp	x0, 1000 <digits.0+0x8>
 e24:	91008000 	add	x0, x0, #0x20
 e28:	f9400000 	ldr	x0, [x0]
}
 e2c:	a8c37bfd 	ldp	x29, x30, [sp], #48
 e30:	d65f03c0 	ret

0000000000000e34 <malloc>:

void*
malloc(uint nbytes)
{
 e34:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 e38:	910003fd 	mov	x29, sp
 e3c:	b9001fe0 	str	w0, [sp, #28]
    Header *p, *prevp;
    uint nunits;
    
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e40:	b9401fe0 	ldr	w0, [sp, #28]
 e44:	91003c00 	add	x0, x0, #0xf
 e48:	d344fc00 	lsr	x0, x0, #4
 e4c:	11000400 	add	w0, w0, #0x1
 e50:	b9002fe0 	str	w0, [sp, #44]
    if((prevp = freep) == 0){
 e54:	b0000000 	adrp	x0, 1000 <digits.0+0x8>
 e58:	91008000 	add	x0, x0, #0x20
 e5c:	f9400000 	ldr	x0, [x0]
 e60:	f9001be0 	str	x0, [sp, #48]
 e64:	f9401be0 	ldr	x0, [sp, #48]
 e68:	f100001f 	cmp	x0, #0x0
 e6c:	54000221 	b.ne	eb0 <malloc+0x7c>  // b.any
        base.s.ptr = freep = prevp = &base;
 e70:	b0000000 	adrp	x0, 1000 <digits.0+0x8>
 e74:	91004000 	add	x0, x0, #0x10
 e78:	f9001be0 	str	x0, [sp, #48]
 e7c:	b0000000 	adrp	x0, 1000 <digits.0+0x8>
 e80:	91008000 	add	x0, x0, #0x20
 e84:	f9401be1 	ldr	x1, [sp, #48]
 e88:	f9000001 	str	x1, [x0]
 e8c:	b0000000 	adrp	x0, 1000 <digits.0+0x8>
 e90:	91008000 	add	x0, x0, #0x20
 e94:	f9400001 	ldr	x1, [x0]
 e98:	b0000000 	adrp	x0, 1000 <digits.0+0x8>
 e9c:	91004000 	add	x0, x0, #0x10
 ea0:	f9000001 	str	x1, [x0]
        base.s.size = 0;
 ea4:	b0000000 	adrp	x0, 1000 <digits.0+0x8>
 ea8:	91004000 	add	x0, x0, #0x10
 eac:	b900081f 	str	wzr, [x0, #8]
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 eb0:	f9401be0 	ldr	x0, [sp, #48]
 eb4:	f9400000 	ldr	x0, [x0]
 eb8:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
 ebc:	f9401fe0 	ldr	x0, [sp, #56]
 ec0:	b9400800 	ldr	w0, [x0, #8]
 ec4:	b9402fe1 	ldr	w1, [sp, #44]
 ec8:	6b00003f 	cmp	w1, w0
 ecc:	54000448 	b.hi	f54 <malloc+0x120>  // b.pmore
            if(p->s.size == nunits)
 ed0:	f9401fe0 	ldr	x0, [sp, #56]
 ed4:	b9400800 	ldr	w0, [x0, #8]
 ed8:	b9402fe1 	ldr	w1, [sp, #44]
 edc:	6b00003f 	cmp	w1, w0
 ee0:	540000c1 	b.ne	ef8 <malloc+0xc4>  // b.any
                prevp->s.ptr = p->s.ptr;
 ee4:	f9401fe0 	ldr	x0, [sp, #56]
 ee8:	f9400001 	ldr	x1, [x0]
 eec:	f9401be0 	ldr	x0, [sp, #48]
 ef0:	f9000001 	str	x1, [x0]
 ef4:	14000011 	b	f38 <malloc+0x104>
            else {
                p->s.size -= nunits;
 ef8:	f9401fe0 	ldr	x0, [sp, #56]
 efc:	b9400801 	ldr	w1, [x0, #8]
 f00:	b9402fe0 	ldr	w0, [sp, #44]
 f04:	4b000021 	sub	w1, w1, w0
 f08:	f9401fe0 	ldr	x0, [sp, #56]
 f0c:	b9000801 	str	w1, [x0, #8]
                p += p->s.size;
 f10:	f9401fe0 	ldr	x0, [sp, #56]
 f14:	b9400800 	ldr	w0, [x0, #8]
 f18:	2a0003e0 	mov	w0, w0
 f1c:	d37cec00 	lsl	x0, x0, #4
 f20:	f9401fe1 	ldr	x1, [sp, #56]
 f24:	8b000020 	add	x0, x1, x0
 f28:	f9001fe0 	str	x0, [sp, #56]
                p->s.size = nunits;
 f2c:	f9401fe0 	ldr	x0, [sp, #56]
 f30:	b9402fe1 	ldr	w1, [sp, #44]
 f34:	b9000801 	str	w1, [x0, #8]
            }
            freep = prevp;
 f38:	b0000000 	adrp	x0, 1000 <digits.0+0x8>
 f3c:	91008000 	add	x0, x0, #0x20
 f40:	f9401be1 	ldr	x1, [sp, #48]
 f44:	f9000001 	str	x1, [x0]
            return (void*)(p + 1);
 f48:	f9401fe0 	ldr	x0, [sp, #56]
 f4c:	91004000 	add	x0, x0, #0x10
 f50:	14000015 	b	fa4 <malloc+0x170>
        }
        if(p == freep)
 f54:	b0000000 	adrp	x0, 1000 <digits.0+0x8>
 f58:	91008000 	add	x0, x0, #0x20
 f5c:	f9400000 	ldr	x0, [x0]
 f60:	f9401fe1 	ldr	x1, [sp, #56]
 f64:	eb00003f 	cmp	x1, x0
 f68:	54000121 	b.ne	f8c <malloc+0x158>  // b.any
            if((p = morecore(nunits)) == 0)
 f6c:	b9402fe0 	ldr	w0, [sp, #44]
 f70:	97ffff93 	bl	dbc <morecore>
 f74:	f9001fe0 	str	x0, [sp, #56]
 f78:	f9401fe0 	ldr	x0, [sp, #56]
 f7c:	f100001f 	cmp	x0, #0x0
 f80:	54000061 	b.ne	f8c <malloc+0x158>  // b.any
                return 0;
 f84:	d2800000 	mov	x0, #0x0                   	// #0
 f88:	14000007 	b	fa4 <malloc+0x170>
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 f8c:	f9401fe0 	ldr	x0, [sp, #56]
 f90:	f9001be0 	str	x0, [sp, #48]
 f94:	f9401fe0 	ldr	x0, [sp, #56]
 f98:	f9400000 	ldr	x0, [x0]
 f9c:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
 fa0:	17ffffc7 	b	ebc <malloc+0x88>
    }
}
 fa4:	a8c47bfd 	ldp	x29, x30, [sp], #64
 fa8:	d65f03c0 	ret
