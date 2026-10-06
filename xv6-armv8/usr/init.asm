
_init:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
   4:	910003fd 	mov	x29, sp
    int pid, wpid;
    
    if(open("console", O_RDWR) < 0){
   8:	52800041 	mov	w1, #0x2                   	// #2
   c:	90000000 	adrp	x0, 0 <main>
  10:	913f8000 	add	x0, x0, #0xfe0
  14:	940001bf 	bl	710 <open>
  18:	7100001f 	cmp	w0, #0x0
  1c:	5400014a 	b.ge	44 <main+0x44>  // b.tcont
        mknod("console", 1, 1);
  20:	52800022 	mov	w2, #0x1                   	// #1
  24:	52800021 	mov	w1, #0x1                   	// #1
  28:	90000000 	adrp	x0, 0 <main>
  2c:	913f8000 	add	x0, x0, #0xfe0
  30:	940001c1 	bl	734 <mknod>
        open("console", O_RDWR);
  34:	52800041 	mov	w1, #0x2                   	// #2
  38:	90000000 	adrp	x0, 0 <main>
  3c:	913f8000 	add	x0, x0, #0xfe0
  40:	940001b4 	bl	710 <open>
    }
    dup(0);  // stdout
  44:	52800000 	mov	w0, #0x0                   	// #0
  48:	940001f1 	bl	80c <dup>
    dup(0);  // stderr
  4c:	52800000 	mov	w0, #0x0                   	// #0
  50:	940001ef 	bl	80c <dup>

    printf(1, "\n");
  54:	90000000 	adrp	x0, 0 <main>
  58:	913fa001 	add	x1, x0, #0xfe8
  5c:	52800020 	mov	w0, #0x1                   	// #1
  60:	9400026b 	bl	a0c <printf>
    printf(1, "**************************************************************************\n");
  64:	90000000 	adrp	x0, 0 <main>
  68:	913fc001 	add	x1, x0, #0xff0
  6c:	52800020 	mov	w0, #0x1                   	// #1
  70:	94000267 	bl	a0c <printf>
    printf(1, "**                                                                      **\n");
  74:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
  78:	91010001 	add	x1, x0, #0x40
  7c:	52800020 	mov	w0, #0x1                   	// #1
  80:	94000263 	bl	a0c <printf>
    printf(1, "**                                                                      **\n");
  84:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
  88:	91010001 	add	x1, x0, #0x40
  8c:	52800020 	mov	w0, #0x1                   	// #1
  90:	9400025f 	bl	a0c <printf>
    printf(1, "**                  xv6 on ARMv8-A (64-bit) Architecture                **\n");
  94:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
  98:	91024001 	add	x1, x0, #0x90
  9c:	52800020 	mov	w0, #0x1                   	// #1
  a0:	9400025b 	bl	a0c <printf>
    printf(1, "**                                                                      **\n");
  a4:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
  a8:	91010001 	add	x1, x0, #0x40
  ac:	52800020 	mov	w0, #0x1                   	// #1
  b0:	94000257 	bl	a0c <printf>
    printf(1, "**                                                                      **\n");
  b4:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
  b8:	91010001 	add	x1, x0, #0x40
  bc:	52800020 	mov	w0, #0x1                   	// #1
  c0:	94000253 	bl	a0c <printf>
    printf(1, "**************************************************************************\n");
  c4:	90000000 	adrp	x0, 0 <main>
  c8:	913fc001 	add	x1, x0, #0xff0
  cc:	52800020 	mov	w0, #0x1                   	// #1
  d0:	9400024f 	bl	a0c <printf>
    printf(1, "\n");
  d4:	90000000 	adrp	x0, 0 <main>
  d8:	913fa001 	add	x1, x0, #0xfe8
  dc:	52800020 	mov	w0, #0x1                   	// #1
  e0:	9400024b 	bl	a0c <printf>

    for(;;){
        printf(1, "init: Starting Shell\n");
  e4:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
  e8:	91038001 	add	x1, x0, #0xe0
  ec:	52800020 	mov	w0, #0x1                   	// #1
  f0:	94000247 	bl	a0c <printf>
        pid = fork();
  f4:	94000136 	bl	5cc <fork>
  f8:	b9001fe0 	str	w0, [sp, #28]
        if(pid < 0){
  fc:	b9401fe0 	ldr	w0, [sp, #28]
 100:	7100001f 	cmp	w0, #0x0
 104:	540000ca 	b.ge	11c <main+0x11c>  // b.tcont
            printf(1, "init: fork failed\n");
 108:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
 10c:	9103e001 	add	x1, x0, #0xf8
 110:	52800020 	mov	w0, #0x1                   	// #1
 114:	9400023e 	bl	a0c <printf>
            exit();
 118:	94000136 	bl	5f0 <exit>
        }
        if(pid == 0){
 11c:	b9401fe0 	ldr	w0, [sp, #28]
 120:	7100001f 	cmp	w0, #0x0
 124:	540001e1 	b.ne	160 <main+0x160>  // b.any
            exec("sh", argv);
 128:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
 12c:	91050001 	add	x1, x0, #0x140
 130:	90000000 	adrp	x0, 0 <main>
 134:	913f6000 	add	x0, x0, #0xfd8
 138:	9400016d 	bl	6ec <exec>
            printf(1, "init: exec sh failed\n");
 13c:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
 140:	91044001 	add	x1, x0, #0x110
 144:	52800020 	mov	w0, #0x1                   	// #1
 148:	94000231 	bl	a0c <printf>
            exit();
 14c:	94000129 	bl	5f0 <exit>
        }
        while((wpid=wait()) >= 0 && wpid != pid)
            printf(1, "zombie!\n");
 150:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
 154:	9104a001 	add	x1, x0, #0x128
 158:	52800020 	mov	w0, #0x1                   	// #1
 15c:	9400022c 	bl	a0c <printf>
        while((wpid=wait()) >= 0 && wpid != pid)
 160:	9400012d 	bl	614 <wait>
 164:	b9001be0 	str	w0, [sp, #24]
 168:	b9401be0 	ldr	w0, [sp, #24]
 16c:	7100001f 	cmp	w0, #0x0
 170:	54fffbab 	b.lt	e4 <main+0xe4>  // b.tstop
 174:	b9401be1 	ldr	w1, [sp, #24]
 178:	b9401fe0 	ldr	w0, [sp, #28]
 17c:	6b00003f 	cmp	w1, w0
 180:	54fffe81 	b.ne	150 <main+0x150>  // b.any
        printf(1, "init: Starting Shell\n");
 184:	17ffffd8 	b	e4 <main+0xe4>

0000000000000188 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 188:	d10083ff 	sub	sp, sp, #0x20
 18c:	f90007e0 	str	x0, [sp, #8]
 190:	f90003e1 	str	x1, [sp]
    char *os;
    
    os = s;
 194:	f94007e0 	ldr	x0, [sp, #8]
 198:	f9000fe0 	str	x0, [sp, #24]
    while((*s++ = *t++) != 0)
 19c:	d503201f 	nop
 1a0:	f94003e1 	ldr	x1, [sp]
 1a4:	91000420 	add	x0, x1, #0x1
 1a8:	f90003e0 	str	x0, [sp]
 1ac:	f94007e0 	ldr	x0, [sp, #8]
 1b0:	91000402 	add	x2, x0, #0x1
 1b4:	f90007e2 	str	x2, [sp, #8]
 1b8:	39400021 	ldrb	w1, [x1]
 1bc:	39000001 	strb	w1, [x0]
 1c0:	39400000 	ldrb	w0, [x0]
 1c4:	7100001f 	cmp	w0, #0x0
 1c8:	54fffec1 	b.ne	1a0 <strcpy+0x18>  // b.any
        ;
    return os;
 1cc:	f9400fe0 	ldr	x0, [sp, #24]
}
 1d0:	910083ff 	add	sp, sp, #0x20
 1d4:	d65f03c0 	ret

00000000000001d8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1d8:	d10043ff 	sub	sp, sp, #0x10
 1dc:	f90007e0 	str	x0, [sp, #8]
 1e0:	f90003e1 	str	x1, [sp]
    while(*p && *p == *q)
 1e4:	14000007 	b	200 <strcmp+0x28>
        p++, q++;
 1e8:	f94007e0 	ldr	x0, [sp, #8]
 1ec:	91000400 	add	x0, x0, #0x1
 1f0:	f90007e0 	str	x0, [sp, #8]
 1f4:	f94003e0 	ldr	x0, [sp]
 1f8:	91000400 	add	x0, x0, #0x1
 1fc:	f90003e0 	str	x0, [sp]
    while(*p && *p == *q)
 200:	f94007e0 	ldr	x0, [sp, #8]
 204:	39400000 	ldrb	w0, [x0]
 208:	7100001f 	cmp	w0, #0x0
 20c:	540000e0 	b.eq	228 <strcmp+0x50>  // b.none
 210:	f94007e0 	ldr	x0, [sp, #8]
 214:	39400001 	ldrb	w1, [x0]
 218:	f94003e0 	ldr	x0, [sp]
 21c:	39400000 	ldrb	w0, [x0]
 220:	6b00003f 	cmp	w1, w0
 224:	54fffe20 	b.eq	1e8 <strcmp+0x10>  // b.none
    return (uchar)*p - (uchar)*q;
 228:	f94007e0 	ldr	x0, [sp, #8]
 22c:	39400000 	ldrb	w0, [x0]
 230:	2a0003e1 	mov	w1, w0
 234:	f94003e0 	ldr	x0, [sp]
 238:	39400000 	ldrb	w0, [x0]
 23c:	4b000020 	sub	w0, w1, w0
}
 240:	910043ff 	add	sp, sp, #0x10
 244:	d65f03c0 	ret

0000000000000248 <strlen>:

uint
strlen(char *s)
{
 248:	d10083ff 	sub	sp, sp, #0x20
 24c:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    for(n = 0; s[n]; n++)
 250:	b9001fff 	str	wzr, [sp, #28]
 254:	14000004 	b	264 <strlen+0x1c>
 258:	b9401fe0 	ldr	w0, [sp, #28]
 25c:	11000400 	add	w0, w0, #0x1
 260:	b9001fe0 	str	w0, [sp, #28]
 264:	b9801fe0 	ldrsw	x0, [sp, #28]
 268:	f94007e1 	ldr	x1, [sp, #8]
 26c:	8b000020 	add	x0, x1, x0
 270:	39400000 	ldrb	w0, [x0]
 274:	7100001f 	cmp	w0, #0x0
 278:	54ffff01 	b.ne	258 <strlen+0x10>  // b.any
        ;
    return n;
 27c:	b9401fe0 	ldr	w0, [sp, #28]
}
 280:	910083ff 	add	sp, sp, #0x20
 284:	d65f03c0 	ret

0000000000000288 <memset>:

void*
memset(void *dst, int v, uint n)
{
 288:	d100c3ff 	sub	sp, sp, #0x30
 28c:	f90007e0 	str	x0, [sp, #8]
 290:	b90007e1 	str	w1, [sp, #4]
 294:	b90003e2 	str	w2, [sp]
	uint8	*p;
	uint8	c;
	uint32	val;
	uint32	*p4;

	p   = dst;
 298:	f94007e0 	ldr	x0, [sp, #8]
 29c:	f90017e0 	str	x0, [sp, #40]
	c   = v & 0xff;
 2a0:	b94007e0 	ldr	w0, [sp, #4]
 2a4:	39007fe0 	strb	w0, [sp, #31]
	val = (c << 24) | (c << 16) | (c << 8) | c;
 2a8:	39407fe1 	ldrb	w1, [sp, #31]
 2ac:	2a0103e0 	mov	w0, w1
 2b0:	53185c00 	lsl	w0, w0, #8
 2b4:	0b010000 	add	w0, w0, w1
 2b8:	53103c00 	lsl	w0, w0, #16
 2bc:	2a0003e1 	mov	w1, w0
 2c0:	39407fe0 	ldrb	w0, [sp, #31]
 2c4:	53185c00 	lsl	w0, w0, #8
 2c8:	2a000021 	orr	w1, w1, w0
 2cc:	39407fe0 	ldrb	w0, [sp, #31]
 2d0:	2a000020 	orr	w0, w1, w0
 2d4:	b9001be0 	str	w0, [sp, #24]

	// set bytes before whole uint32
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
 2d8:	1400000a 	b	300 <memset+0x78>
		*p = c;
 2dc:	f94017e0 	ldr	x0, [sp, #40]
 2e0:	39407fe1 	ldrb	w1, [sp, #31]
 2e4:	39000001 	strb	w1, [x0]
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
 2e8:	b94003e0 	ldr	w0, [sp]
 2ec:	51000400 	sub	w0, w0, #0x1
 2f0:	b90003e0 	str	w0, [sp]
 2f4:	f94017e0 	ldr	x0, [sp, #40]
 2f8:	91000400 	add	x0, x0, #0x1
 2fc:	f90017e0 	str	x0, [sp, #40]
 300:	b94003e0 	ldr	w0, [sp]
 304:	7100001f 	cmp	w0, #0x0
 308:	540000a0 	b.eq	31c <memset+0x94>  // b.none
 30c:	f94017e0 	ldr	x0, [sp, #40]
 310:	92400400 	and	x0, x0, #0x3
 314:	f100001f 	cmp	x0, #0x0
 318:	54fffe21 	b.ne	2dc <memset+0x54>  // b.any
	}

	// set memory 4 bytes a time
	p4 = (uint*)p;
 31c:	f94017e0 	ldr	x0, [sp, #40]
 320:	f90013e0 	str	x0, [sp, #32]

	for (; n >= 4; n -= 4, p4++) {
 324:	1400000a 	b	34c <memset+0xc4>
		*p4 = val;
 328:	f94013e0 	ldr	x0, [sp, #32]
 32c:	b9401be1 	ldr	w1, [sp, #24]
 330:	b9000001 	str	w1, [x0]
	for (; n >= 4; n -= 4, p4++) {
 334:	b94003e0 	ldr	w0, [sp]
 338:	51001000 	sub	w0, w0, #0x4
 33c:	b90003e0 	str	w0, [sp]
 340:	f94013e0 	ldr	x0, [sp, #32]
 344:	91001000 	add	x0, x0, #0x4
 348:	f90013e0 	str	x0, [sp, #32]
 34c:	b94003e0 	ldr	w0, [sp]
 350:	71000c1f 	cmp	w0, #0x3
 354:	54fffea8 	b.hi	328 <memset+0xa0>  // b.pmore
	}

	// set leftover one byte a time
	p = (uint8*)p4;
 358:	f94013e0 	ldr	x0, [sp, #32]
 35c:	f90017e0 	str	x0, [sp, #40]

	for (; n > 0; n--, p++) {
 360:	1400000a 	b	388 <memset+0x100>
		*p = c;
 364:	f94017e0 	ldr	x0, [sp, #40]
 368:	39407fe1 	ldrb	w1, [sp, #31]
 36c:	39000001 	strb	w1, [x0]
	for (; n > 0; n--, p++) {
 370:	b94003e0 	ldr	w0, [sp]
 374:	51000400 	sub	w0, w0, #0x1
 378:	b90003e0 	str	w0, [sp]
 37c:	f94017e0 	ldr	x0, [sp, #40]
 380:	91000400 	add	x0, x0, #0x1
 384:	f90017e0 	str	x0, [sp, #40]
 388:	b94003e0 	ldr	w0, [sp]
 38c:	7100001f 	cmp	w0, #0x0
 390:	54fffea1 	b.ne	364 <memset+0xdc>  // b.any
	}

	return dst;
 394:	f94007e0 	ldr	x0, [sp, #8]
}
 398:	9100c3ff 	add	sp, sp, #0x30
 39c:	d65f03c0 	ret

00000000000003a0 <strchr>:

char*
strchr(const char *s, char c)
{
 3a0:	d10043ff 	sub	sp, sp, #0x10
 3a4:	f90007e0 	str	x0, [sp, #8]
 3a8:	39001fe1 	strb	w1, [sp, #7]
    for(; *s; s++)
 3ac:	1400000b 	b	3d8 <strchr+0x38>
        if(*s == c)
 3b0:	f94007e0 	ldr	x0, [sp, #8]
 3b4:	39400000 	ldrb	w0, [x0]
 3b8:	39401fe1 	ldrb	w1, [sp, #7]
 3bc:	6b00003f 	cmp	w1, w0
 3c0:	54000061 	b.ne	3cc <strchr+0x2c>  // b.any
            return (char*)s;
 3c4:	f94007e0 	ldr	x0, [sp, #8]
 3c8:	14000009 	b	3ec <strchr+0x4c>
    for(; *s; s++)
 3cc:	f94007e0 	ldr	x0, [sp, #8]
 3d0:	91000400 	add	x0, x0, #0x1
 3d4:	f90007e0 	str	x0, [sp, #8]
 3d8:	f94007e0 	ldr	x0, [sp, #8]
 3dc:	39400000 	ldrb	w0, [x0]
 3e0:	7100001f 	cmp	w0, #0x0
 3e4:	54fffe61 	b.ne	3b0 <strchr+0x10>  // b.any
    return 0;
 3e8:	d2800000 	mov	x0, #0x0                   	// #0
}
 3ec:	910043ff 	add	sp, sp, #0x10
 3f0:	d65f03c0 	ret

00000000000003f4 <gets>:

char*
gets(char *buf, int max)
{
 3f4:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 3f8:	910003fd 	mov	x29, sp
 3fc:	f9000fe0 	str	x0, [sp, #24]
 400:	b90017e1 	str	w1, [sp, #20]
    int i, cc;
    char c;
    
    for(i=0; i+1 < max; ){
 404:	b9002fff 	str	wzr, [sp, #44]
 408:	14000018 	b	468 <gets+0x74>
        cc = read(0, &c, 1);
 40c:	91009fe0 	add	x0, sp, #0x27
 410:	52800022 	mov	w2, #0x1                   	// #1
 414:	aa0003e1 	mov	x1, x0
 418:	52800000 	mov	w0, #0x0                   	// #0
 41c:	94000090 	bl	65c <read>
 420:	b9002be0 	str	w0, [sp, #40]
        if(cc < 1)
 424:	b9402be0 	ldr	w0, [sp, #40]
 428:	7100001f 	cmp	w0, #0x0
 42c:	540002ad 	b.le	480 <gets+0x8c>
            break;
        buf[i++] = c;
 430:	b9402fe0 	ldr	w0, [sp, #44]
 434:	11000401 	add	w1, w0, #0x1
 438:	b9002fe1 	str	w1, [sp, #44]
 43c:	93407c00 	sxtw	x0, w0
 440:	f9400fe1 	ldr	x1, [sp, #24]
 444:	8b000020 	add	x0, x1, x0
 448:	39409fe1 	ldrb	w1, [sp, #39]
 44c:	39000001 	strb	w1, [x0]
        if(c == '\n' || c == '\r')
 450:	39409fe0 	ldrb	w0, [sp, #39]
 454:	7100281f 	cmp	w0, #0xa
 458:	54000160 	b.eq	484 <gets+0x90>  // b.none
 45c:	39409fe0 	ldrb	w0, [sp, #39]
 460:	7100341f 	cmp	w0, #0xd
 464:	54000100 	b.eq	484 <gets+0x90>  // b.none
    for(i=0; i+1 < max; ){
 468:	b9402fe0 	ldr	w0, [sp, #44]
 46c:	11000400 	add	w0, w0, #0x1
 470:	b94017e1 	ldr	w1, [sp, #20]
 474:	6b00003f 	cmp	w1, w0
 478:	54fffcac 	b.gt	40c <gets+0x18>
 47c:	14000002 	b	484 <gets+0x90>
            break;
 480:	d503201f 	nop
            break;
    }
    buf[i] = '\0';
 484:	b9802fe0 	ldrsw	x0, [sp, #44]
 488:	f9400fe1 	ldr	x1, [sp, #24]
 48c:	8b000020 	add	x0, x1, x0
 490:	3900001f 	strb	wzr, [x0]
    return buf;
 494:	f9400fe0 	ldr	x0, [sp, #24]
}
 498:	a8c37bfd 	ldp	x29, x30, [sp], #48
 49c:	d65f03c0 	ret

00000000000004a0 <stat>:

int
stat(char *n, struct stat *st)
{
 4a0:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 4a4:	910003fd 	mov	x29, sp
 4a8:	f9000fe0 	str	x0, [sp, #24]
 4ac:	f9000be1 	str	x1, [sp, #16]
    int fd;
    int r;
    
    fd = open(n, O_RDONLY);
 4b0:	52800001 	mov	w1, #0x0                   	// #0
 4b4:	f9400fe0 	ldr	x0, [sp, #24]
 4b8:	94000096 	bl	710 <open>
 4bc:	b9002fe0 	str	w0, [sp, #44]
    if(fd < 0)
 4c0:	b9402fe0 	ldr	w0, [sp, #44]
 4c4:	7100001f 	cmp	w0, #0x0
 4c8:	5400006a 	b.ge	4d4 <stat+0x34>  // b.tcont
        return -1;
 4cc:	12800000 	mov	w0, #0xffffffff            	// #-1
 4d0:	14000008 	b	4f0 <stat+0x50>
    r = fstat(fd, st);
 4d4:	f9400be1 	ldr	x1, [sp, #16]
 4d8:	b9402fe0 	ldr	w0, [sp, #44]
 4dc:	940000a8 	bl	77c <fstat>
 4e0:	b9002be0 	str	w0, [sp, #40]
    close(fd);
 4e4:	b9402fe0 	ldr	w0, [sp, #44]
 4e8:	9400006f 	bl	6a4 <close>
    return r;
 4ec:	b9402be0 	ldr	w0, [sp, #40]
}
 4f0:	a8c37bfd 	ldp	x29, x30, [sp], #48
 4f4:	d65f03c0 	ret

00000000000004f8 <atoi>:

int
atoi(const char *s)
{
 4f8:	d10083ff 	sub	sp, sp, #0x20
 4fc:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    n = 0;
 500:	b9001fff 	str	wzr, [sp, #28]
    while('0' <= *s && *s <= '9')
 504:	1400000e 	b	53c <atoi+0x44>
        n = n*10 + *s++ - '0';
 508:	b9401fe1 	ldr	w1, [sp, #28]
 50c:	2a0103e0 	mov	w0, w1
 510:	531e7400 	lsl	w0, w0, #2
 514:	0b010000 	add	w0, w0, w1
 518:	531f7800 	lsl	w0, w0, #1
 51c:	2a0003e2 	mov	w2, w0
 520:	f94007e0 	ldr	x0, [sp, #8]
 524:	91000401 	add	x1, x0, #0x1
 528:	f90007e1 	str	x1, [sp, #8]
 52c:	39400000 	ldrb	w0, [x0]
 530:	0b000040 	add	w0, w2, w0
 534:	5100c000 	sub	w0, w0, #0x30
 538:	b9001fe0 	str	w0, [sp, #28]
    while('0' <= *s && *s <= '9')
 53c:	f94007e0 	ldr	x0, [sp, #8]
 540:	39400000 	ldrb	w0, [x0]
 544:	7100bc1f 	cmp	w0, #0x2f
 548:	540000a9 	b.ls	55c <atoi+0x64>  // b.plast
 54c:	f94007e0 	ldr	x0, [sp, #8]
 550:	39400000 	ldrb	w0, [x0]
 554:	7100e41f 	cmp	w0, #0x39
 558:	54fffd89 	b.ls	508 <atoi+0x10>  // b.plast
    return n;
 55c:	b9401fe0 	ldr	w0, [sp, #28]
}
 560:	910083ff 	add	sp, sp, #0x20
 564:	d65f03c0 	ret

0000000000000568 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 568:	d100c3ff 	sub	sp, sp, #0x30
 56c:	f9000fe0 	str	x0, [sp, #24]
 570:	f9000be1 	str	x1, [sp, #16]
 574:	b9000fe2 	str	w2, [sp, #12]
    char *dst, *src;
    
    dst = vdst;
 578:	f9400fe0 	ldr	x0, [sp, #24]
 57c:	f90017e0 	str	x0, [sp, #40]
    src = vsrc;
 580:	f9400be0 	ldr	x0, [sp, #16]
 584:	f90013e0 	str	x0, [sp, #32]
    while(n-- > 0)
 588:	14000009 	b	5ac <memmove+0x44>
        *dst++ = *src++;
 58c:	f94013e1 	ldr	x1, [sp, #32]
 590:	91000420 	add	x0, x1, #0x1
 594:	f90013e0 	str	x0, [sp, #32]
 598:	f94017e0 	ldr	x0, [sp, #40]
 59c:	91000402 	add	x2, x0, #0x1
 5a0:	f90017e2 	str	x2, [sp, #40]
 5a4:	39400021 	ldrb	w1, [x1]
 5a8:	39000001 	strb	w1, [x0]
    while(n-- > 0)
 5ac:	b9400fe0 	ldr	w0, [sp, #12]
 5b0:	51000401 	sub	w1, w0, #0x1
 5b4:	b9000fe1 	str	w1, [sp, #12]
 5b8:	7100001f 	cmp	w0, #0x0
 5bc:	54fffe8c 	b.gt	58c <memmove+0x24>
    return vdst;
 5c0:	f9400fe0 	ldr	x0, [sp, #24]
}
 5c4:	9100c3ff 	add	sp, sp, #0x30
 5c8:	d65f03c0 	ret

00000000000005cc <fork>:
 5cc:	f81f8fe4 	str	x4, [sp, #-8]!
 5d0:	aa0303e4 	mov	x4, x3
 5d4:	aa0203e3 	mov	x3, x2
 5d8:	aa0103e2 	mov	x2, x1
 5dc:	aa0003e1 	mov	x1, x0
 5e0:	d2800020 	mov	x0, #0x1                   	// #1
 5e4:	d4000001 	svc	#0x0
 5e8:	f84087e4 	ldr	x4, [sp], #8
 5ec:	d61f03c0 	br	x30

00000000000005f0 <exit>:
 5f0:	f81f8fe4 	str	x4, [sp, #-8]!
 5f4:	aa0303e4 	mov	x4, x3
 5f8:	aa0203e3 	mov	x3, x2
 5fc:	aa0103e2 	mov	x2, x1
 600:	aa0003e1 	mov	x1, x0
 604:	d2800040 	mov	x0, #0x2                   	// #2
 608:	d4000001 	svc	#0x0
 60c:	f84087e4 	ldr	x4, [sp], #8
 610:	d61f03c0 	br	x30

0000000000000614 <wait>:
 614:	f81f8fe4 	str	x4, [sp, #-8]!
 618:	aa0303e4 	mov	x4, x3
 61c:	aa0203e3 	mov	x3, x2
 620:	aa0103e2 	mov	x2, x1
 624:	aa0003e1 	mov	x1, x0
 628:	d2800060 	mov	x0, #0x3                   	// #3
 62c:	d4000001 	svc	#0x0
 630:	f84087e4 	ldr	x4, [sp], #8
 634:	d61f03c0 	br	x30

0000000000000638 <pipe>:
 638:	f81f8fe4 	str	x4, [sp, #-8]!
 63c:	aa0303e4 	mov	x4, x3
 640:	aa0203e3 	mov	x3, x2
 644:	aa0103e2 	mov	x2, x1
 648:	aa0003e1 	mov	x1, x0
 64c:	d2800080 	mov	x0, #0x4                   	// #4
 650:	d4000001 	svc	#0x0
 654:	f84087e4 	ldr	x4, [sp], #8
 658:	d61f03c0 	br	x30

000000000000065c <read>:
 65c:	f81f8fe4 	str	x4, [sp, #-8]!
 660:	aa0303e4 	mov	x4, x3
 664:	aa0203e3 	mov	x3, x2
 668:	aa0103e2 	mov	x2, x1
 66c:	aa0003e1 	mov	x1, x0
 670:	d28000a0 	mov	x0, #0x5                   	// #5
 674:	d4000001 	svc	#0x0
 678:	f84087e4 	ldr	x4, [sp], #8
 67c:	d61f03c0 	br	x30

0000000000000680 <write>:
 680:	f81f8fe4 	str	x4, [sp, #-8]!
 684:	aa0303e4 	mov	x4, x3
 688:	aa0203e3 	mov	x3, x2
 68c:	aa0103e2 	mov	x2, x1
 690:	aa0003e1 	mov	x1, x0
 694:	d2800200 	mov	x0, #0x10                  	// #16
 698:	d4000001 	svc	#0x0
 69c:	f84087e4 	ldr	x4, [sp], #8
 6a0:	d61f03c0 	br	x30

00000000000006a4 <close>:
 6a4:	f81f8fe4 	str	x4, [sp, #-8]!
 6a8:	aa0303e4 	mov	x4, x3
 6ac:	aa0203e3 	mov	x3, x2
 6b0:	aa0103e2 	mov	x2, x1
 6b4:	aa0003e1 	mov	x1, x0
 6b8:	d28002a0 	mov	x0, #0x15                  	// #21
 6bc:	d4000001 	svc	#0x0
 6c0:	f84087e4 	ldr	x4, [sp], #8
 6c4:	d61f03c0 	br	x30

00000000000006c8 <kill>:
 6c8:	f81f8fe4 	str	x4, [sp, #-8]!
 6cc:	aa0303e4 	mov	x4, x3
 6d0:	aa0203e3 	mov	x3, x2
 6d4:	aa0103e2 	mov	x2, x1
 6d8:	aa0003e1 	mov	x1, x0
 6dc:	d28000c0 	mov	x0, #0x6                   	// #6
 6e0:	d4000001 	svc	#0x0
 6e4:	f84087e4 	ldr	x4, [sp], #8
 6e8:	d61f03c0 	br	x30

00000000000006ec <exec>:
 6ec:	f81f8fe4 	str	x4, [sp, #-8]!
 6f0:	aa0303e4 	mov	x4, x3
 6f4:	aa0203e3 	mov	x3, x2
 6f8:	aa0103e2 	mov	x2, x1
 6fc:	aa0003e1 	mov	x1, x0
 700:	d28000e0 	mov	x0, #0x7                   	// #7
 704:	d4000001 	svc	#0x0
 708:	f84087e4 	ldr	x4, [sp], #8
 70c:	d61f03c0 	br	x30

0000000000000710 <open>:
 710:	f81f8fe4 	str	x4, [sp, #-8]!
 714:	aa0303e4 	mov	x4, x3
 718:	aa0203e3 	mov	x3, x2
 71c:	aa0103e2 	mov	x2, x1
 720:	aa0003e1 	mov	x1, x0
 724:	d28001e0 	mov	x0, #0xf                   	// #15
 728:	d4000001 	svc	#0x0
 72c:	f84087e4 	ldr	x4, [sp], #8
 730:	d61f03c0 	br	x30

0000000000000734 <mknod>:
 734:	f81f8fe4 	str	x4, [sp, #-8]!
 738:	aa0303e4 	mov	x4, x3
 73c:	aa0203e3 	mov	x3, x2
 740:	aa0103e2 	mov	x2, x1
 744:	aa0003e1 	mov	x1, x0
 748:	d2800220 	mov	x0, #0x11                  	// #17
 74c:	d4000001 	svc	#0x0
 750:	f84087e4 	ldr	x4, [sp], #8
 754:	d61f03c0 	br	x30

0000000000000758 <unlink>:
 758:	f81f8fe4 	str	x4, [sp, #-8]!
 75c:	aa0303e4 	mov	x4, x3
 760:	aa0203e3 	mov	x3, x2
 764:	aa0103e2 	mov	x2, x1
 768:	aa0003e1 	mov	x1, x0
 76c:	d2800240 	mov	x0, #0x12                  	// #18
 770:	d4000001 	svc	#0x0
 774:	f84087e4 	ldr	x4, [sp], #8
 778:	d61f03c0 	br	x30

000000000000077c <fstat>:
 77c:	f81f8fe4 	str	x4, [sp, #-8]!
 780:	aa0303e4 	mov	x4, x3
 784:	aa0203e3 	mov	x3, x2
 788:	aa0103e2 	mov	x2, x1
 78c:	aa0003e1 	mov	x1, x0
 790:	d2800100 	mov	x0, #0x8                   	// #8
 794:	d4000001 	svc	#0x0
 798:	f84087e4 	ldr	x4, [sp], #8
 79c:	d61f03c0 	br	x30

00000000000007a0 <link>:
 7a0:	f81f8fe4 	str	x4, [sp, #-8]!
 7a4:	aa0303e4 	mov	x4, x3
 7a8:	aa0203e3 	mov	x3, x2
 7ac:	aa0103e2 	mov	x2, x1
 7b0:	aa0003e1 	mov	x1, x0
 7b4:	d2800260 	mov	x0, #0x13                  	// #19
 7b8:	d4000001 	svc	#0x0
 7bc:	f84087e4 	ldr	x4, [sp], #8
 7c0:	d61f03c0 	br	x30

00000000000007c4 <mkdir>:
 7c4:	f81f8fe4 	str	x4, [sp, #-8]!
 7c8:	aa0303e4 	mov	x4, x3
 7cc:	aa0203e3 	mov	x3, x2
 7d0:	aa0103e2 	mov	x2, x1
 7d4:	aa0003e1 	mov	x1, x0
 7d8:	d2800280 	mov	x0, #0x14                  	// #20
 7dc:	d4000001 	svc	#0x0
 7e0:	f84087e4 	ldr	x4, [sp], #8
 7e4:	d61f03c0 	br	x30

00000000000007e8 <chdir>:
 7e8:	f81f8fe4 	str	x4, [sp, #-8]!
 7ec:	aa0303e4 	mov	x4, x3
 7f0:	aa0203e3 	mov	x3, x2
 7f4:	aa0103e2 	mov	x2, x1
 7f8:	aa0003e1 	mov	x1, x0
 7fc:	d2800120 	mov	x0, #0x9                   	// #9
 800:	d4000001 	svc	#0x0
 804:	f84087e4 	ldr	x4, [sp], #8
 808:	d61f03c0 	br	x30

000000000000080c <dup>:
 80c:	f81f8fe4 	str	x4, [sp, #-8]!
 810:	aa0303e4 	mov	x4, x3
 814:	aa0203e3 	mov	x3, x2
 818:	aa0103e2 	mov	x2, x1
 81c:	aa0003e1 	mov	x1, x0
 820:	d2800140 	mov	x0, #0xa                   	// #10
 824:	d4000001 	svc	#0x0
 828:	f84087e4 	ldr	x4, [sp], #8
 82c:	d61f03c0 	br	x30

0000000000000830 <getpid>:
 830:	f81f8fe4 	str	x4, [sp, #-8]!
 834:	aa0303e4 	mov	x4, x3
 838:	aa0203e3 	mov	x3, x2
 83c:	aa0103e2 	mov	x2, x1
 840:	aa0003e1 	mov	x1, x0
 844:	d2800160 	mov	x0, #0xb                   	// #11
 848:	d4000001 	svc	#0x0
 84c:	f84087e4 	ldr	x4, [sp], #8
 850:	d61f03c0 	br	x30

0000000000000854 <sbrk>:
 854:	f81f8fe4 	str	x4, [sp, #-8]!
 858:	aa0303e4 	mov	x4, x3
 85c:	aa0203e3 	mov	x3, x2
 860:	aa0103e2 	mov	x2, x1
 864:	aa0003e1 	mov	x1, x0
 868:	d2800180 	mov	x0, #0xc                   	// #12
 86c:	d4000001 	svc	#0x0
 870:	f84087e4 	ldr	x4, [sp], #8
 874:	d61f03c0 	br	x30

0000000000000878 <sleep>:
 878:	f81f8fe4 	str	x4, [sp, #-8]!
 87c:	aa0303e4 	mov	x4, x3
 880:	aa0203e3 	mov	x3, x2
 884:	aa0103e2 	mov	x2, x1
 888:	aa0003e1 	mov	x1, x0
 88c:	d28001a0 	mov	x0, #0xd                   	// #13
 890:	d4000001 	svc	#0x0
 894:	f84087e4 	ldr	x4, [sp], #8
 898:	d61f03c0 	br	x30

000000000000089c <uptime>:
 89c:	f81f8fe4 	str	x4, [sp, #-8]!
 8a0:	aa0303e4 	mov	x4, x3
 8a4:	aa0203e3 	mov	x3, x2
 8a8:	aa0103e2 	mov	x2, x1
 8ac:	aa0003e1 	mov	x1, x0
 8b0:	d28001c0 	mov	x0, #0xe                   	// #14
 8b4:	d4000001 	svc	#0x0
 8b8:	f84087e4 	ldr	x4, [sp], #8
 8bc:	d61f03c0 	br	x30

00000000000008c0 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 8c0:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
 8c4:	910003fd 	mov	x29, sp
 8c8:	b9001fe0 	str	w0, [sp, #28]
 8cc:	39006fe1 	strb	w1, [sp, #27]
    write(fd, &c, 1);
 8d0:	91006fe0 	add	x0, sp, #0x1b
 8d4:	52800022 	mov	w2, #0x1                   	// #1
 8d8:	aa0003e1 	mov	x1, x0
 8dc:	b9401fe0 	ldr	w0, [sp, #28]
 8e0:	97ffff68 	bl	680 <write>
}
 8e4:	d503201f 	nop
 8e8:	a8c27bfd 	ldp	x29, x30, [sp], #32
 8ec:	d65f03c0 	ret

00000000000008f0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 8f0:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 8f4:	910003fd 	mov	x29, sp
 8f8:	b9001fe0 	str	w0, [sp, #28]
 8fc:	b9001be1 	str	w1, [sp, #24]
 900:	b90017e2 	str	w2, [sp, #20]
 904:	b90013e3 	str	w3, [sp, #16]
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
 908:	b9003bff 	str	wzr, [sp, #56]
    if(sgn && xx < 0){
 90c:	b94013e0 	ldr	w0, [sp, #16]
 910:	7100001f 	cmp	w0, #0x0
 914:	54000140 	b.eq	93c <printint+0x4c>  // b.none
 918:	b9401be0 	ldr	w0, [sp, #24]
 91c:	7100001f 	cmp	w0, #0x0
 920:	540000ea 	b.ge	93c <printint+0x4c>  // b.tcont
        neg = 1;
 924:	52800020 	mov	w0, #0x1                   	// #1
 928:	b9003be0 	str	w0, [sp, #56]
        x = -xx;
 92c:	b9401be0 	ldr	w0, [sp, #24]
 930:	4b0003e0 	neg	w0, w0
 934:	b90037e0 	str	w0, [sp, #52]
 938:	14000003 	b	944 <printint+0x54>
    } else {
        x = xx;
 93c:	b9401be0 	ldr	w0, [sp, #24]
 940:	b90037e0 	str	w0, [sp, #52]
    }
    
    i = 0;
 944:	b9003fff 	str	wzr, [sp, #60]
    do{
        buf[i++] = digits[x % base];
 948:	b94017e1 	ldr	w1, [sp, #20]
 94c:	b94037e0 	ldr	w0, [sp, #52]
 950:	1ac10802 	udiv	w2, w0, w1
 954:	1b017c41 	mul	w1, w2, w1
 958:	4b010003 	sub	w3, w0, w1
 95c:	b9403fe0 	ldr	w0, [sp, #60]
 960:	11000401 	add	w1, w0, #0x1
 964:	b9003fe1 	str	w1, [sp, #60]
 968:	b0000001 	adrp	x1, 1000 <malloc+0x1a4>
 96c:	91054022 	add	x2, x1, #0x150
 970:	2a0303e1 	mov	w1, w3
 974:	38616842 	ldrb	w2, [x2, x1]
 978:	93407c00 	sxtw	x0, w0
 97c:	910083e1 	add	x1, sp, #0x20
 980:	38206822 	strb	w2, [x1, x0]
    }while((x /= base) != 0);
 984:	b94017e0 	ldr	w0, [sp, #20]
 988:	b94037e1 	ldr	w1, [sp, #52]
 98c:	1ac00820 	udiv	w0, w1, w0
 990:	b90037e0 	str	w0, [sp, #52]
 994:	b94037e0 	ldr	w0, [sp, #52]
 998:	7100001f 	cmp	w0, #0x0
 99c:	54fffd61 	b.ne	948 <printint+0x58>  // b.any
    if(neg)
 9a0:	b9403be0 	ldr	w0, [sp, #56]
 9a4:	7100001f 	cmp	w0, #0x0
 9a8:	540001e0 	b.eq	9e4 <printint+0xf4>  // b.none
        buf[i++] = '-';
 9ac:	b9403fe0 	ldr	w0, [sp, #60]
 9b0:	11000401 	add	w1, w0, #0x1
 9b4:	b9003fe1 	str	w1, [sp, #60]
 9b8:	93407c00 	sxtw	x0, w0
 9bc:	910083e1 	add	x1, sp, #0x20
 9c0:	528005a2 	mov	w2, #0x2d                  	// #45
 9c4:	38206822 	strb	w2, [x1, x0]
    
    while(--i >= 0)
 9c8:	14000007 	b	9e4 <printint+0xf4>
        putc(fd, buf[i]);
 9cc:	b9803fe0 	ldrsw	x0, [sp, #60]
 9d0:	910083e1 	add	x1, sp, #0x20
 9d4:	38606820 	ldrb	w0, [x1, x0]
 9d8:	2a0003e1 	mov	w1, w0
 9dc:	b9401fe0 	ldr	w0, [sp, #28]
 9e0:	97ffffb8 	bl	8c0 <putc>
    while(--i >= 0)
 9e4:	b9403fe0 	ldr	w0, [sp, #60]
 9e8:	51000400 	sub	w0, w0, #0x1
 9ec:	b9003fe0 	str	w0, [sp, #60]
 9f0:	b9403fe0 	ldr	w0, [sp, #60]
 9f4:	7100001f 	cmp	w0, #0x0
 9f8:	54fffeaa 	b.ge	9cc <printint+0xdc>  // b.tcont
}
 9fc:	d503201f 	nop
 a00:	d503201f 	nop
 a04:	a8c47bfd 	ldp	x29, x30, [sp], #64
 a08:	d65f03c0 	ret

0000000000000a0c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 a0c:	a9b17bfd 	stp	x29, x30, [sp, #-240]!
 a10:	910003fd 	mov	x29, sp
 a14:	b9001fe0 	str	w0, [sp, #28]
 a18:	f9000be1 	str	x1, [sp, #16]
 a1c:	f90063e2 	str	x2, [sp, #192]
 a20:	f90067e3 	str	x3, [sp, #200]
 a24:	f9006be4 	str	x4, [sp, #208]
 a28:	f9006fe5 	str	x5, [sp, #216]
 a2c:	f90073e6 	str	x6, [sp, #224]
 a30:	f90077e7 	str	x7, [sp, #232]
 a34:	3d8013e0 	str	q0, [sp, #64]
 a38:	3d8017e1 	str	q1, [sp, #80]
 a3c:	3d801be2 	str	q2, [sp, #96]
 a40:	3d801fe3 	str	q3, [sp, #112]
 a44:	3d8023e4 	str	q4, [sp, #128]
 a48:	3d8027e5 	str	q5, [sp, #144]
 a4c:	3d802be6 	str	q6, [sp, #160]
 a50:	3d802fe7 	str	q7, [sp, #176]
    char *s;
    int c, i, state;
    uint64 *ap;
    
    state = 0;
 a54:	b90033ff 	str	wzr, [sp, #48]
    ap = (uint64*)(void*)&fmt + 22;
 a58:	910043e0 	add	x0, sp, #0x10
 a5c:	9102c000 	add	x0, x0, #0xb0
 a60:	f90017e0 	str	x0, [sp, #40]
    for(i = 0; fmt[i]; i++){
 a64:	b90037ff 	str	wzr, [sp, #52]
 a68:	14000076 	b	c40 <printf+0x234>
        c = fmt[i] & 0xff;
 a6c:	f9400be1 	ldr	x1, [sp, #16]
 a70:	b98037e0 	ldrsw	x0, [sp, #52]
 a74:	8b000020 	add	x0, x1, x0
 a78:	39400000 	ldrb	w0, [x0]
 a7c:	b90027e0 	str	w0, [sp, #36]
        if(state == 0){
 a80:	b94033e0 	ldr	w0, [sp, #48]
 a84:	7100001f 	cmp	w0, #0x0
 a88:	540001a1 	b.ne	abc <printf+0xb0>  // b.any
            if(c == '%'){
 a8c:	b94027e0 	ldr	w0, [sp, #36]
 a90:	7100941f 	cmp	w0, #0x25
 a94:	54000081 	b.ne	aa4 <printf+0x98>  // b.any
                state = '%';
 a98:	528004a0 	mov	w0, #0x25                  	// #37
 a9c:	b90033e0 	str	w0, [sp, #48]
 aa0:	14000065 	b	c34 <printf+0x228>
            } else {
                putc(fd, c);
 aa4:	b94027e0 	ldr	w0, [sp, #36]
 aa8:	12001c00 	and	w0, w0, #0xff
 aac:	2a0003e1 	mov	w1, w0
 ab0:	b9401fe0 	ldr	w0, [sp, #28]
 ab4:	97ffff83 	bl	8c0 <putc>
 ab8:	1400005f 	b	c34 <printf+0x228>
            }
        } else if(state == '%'){
 abc:	b94033e0 	ldr	w0, [sp, #48]
 ac0:	7100941f 	cmp	w0, #0x25
 ac4:	54000b81 	b.ne	c34 <printf+0x228>  // b.any
            if(c == 'd'){
 ac8:	b94027e0 	ldr	w0, [sp, #36]
 acc:	7101901f 	cmp	w0, #0x64
 ad0:	54000181 	b.ne	b00 <printf+0xf4>  // b.any
                printint(fd, *ap, 10, 1);
 ad4:	f94017e0 	ldr	x0, [sp, #40]
 ad8:	f9400000 	ldr	x0, [x0]
 adc:	52800023 	mov	w3, #0x1                   	// #1
 ae0:	52800142 	mov	w2, #0xa                   	// #10
 ae4:	2a0003e1 	mov	w1, w0
 ae8:	b9401fe0 	ldr	w0, [sp, #28]
 aec:	97ffff81 	bl	8f0 <printint>
                ap++;
 af0:	f94017e0 	ldr	x0, [sp, #40]
 af4:	91002000 	add	x0, x0, #0x8
 af8:	f90017e0 	str	x0, [sp, #40]
 afc:	1400004d 	b	c30 <printf+0x224>
            } else if(c == 'x' || c == 'p'){
 b00:	b94027e0 	ldr	w0, [sp, #36]
 b04:	7101e01f 	cmp	w0, #0x78
 b08:	54000080 	b.eq	b18 <printf+0x10c>  // b.none
 b0c:	b94027e0 	ldr	w0, [sp, #36]
 b10:	7101c01f 	cmp	w0, #0x70
 b14:	54000181 	b.ne	b44 <printf+0x138>  // b.any
                printint(fd, *ap, 16, 0);
 b18:	f94017e0 	ldr	x0, [sp, #40]
 b1c:	f9400000 	ldr	x0, [x0]
 b20:	52800003 	mov	w3, #0x0                   	// #0
 b24:	52800202 	mov	w2, #0x10                  	// #16
 b28:	2a0003e1 	mov	w1, w0
 b2c:	b9401fe0 	ldr	w0, [sp, #28]
 b30:	97ffff70 	bl	8f0 <printint>
                ap++;
 b34:	f94017e0 	ldr	x0, [sp, #40]
 b38:	91002000 	add	x0, x0, #0x8
 b3c:	f90017e0 	str	x0, [sp, #40]
 b40:	1400003c 	b	c30 <printf+0x224>
            } else if(c == 's'){
 b44:	b94027e0 	ldr	w0, [sp, #36]
 b48:	7101cc1f 	cmp	w0, #0x73
 b4c:	54000361 	b.ne	bb8 <printf+0x1ac>  // b.any
                s = (char*)*ap;
 b50:	f94017e0 	ldr	x0, [sp, #40]
 b54:	f9400000 	ldr	x0, [x0]
 b58:	f9001fe0 	str	x0, [sp, #56]
                ap++;
 b5c:	f94017e0 	ldr	x0, [sp, #40]
 b60:	91002000 	add	x0, x0, #0x8
 b64:	f90017e0 	str	x0, [sp, #40]
                if(s == 0)
 b68:	f9401fe0 	ldr	x0, [sp, #56]
 b6c:	f100001f 	cmp	x0, #0x0
 b70:	540001a1 	b.ne	ba4 <printf+0x198>  // b.any
                    s = "(null)";
 b74:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
 b78:	9104e000 	add	x0, x0, #0x138
 b7c:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
 b80:	14000009 	b	ba4 <printf+0x198>
                    putc(fd, *s);
 b84:	f9401fe0 	ldr	x0, [sp, #56]
 b88:	39400000 	ldrb	w0, [x0]
 b8c:	2a0003e1 	mov	w1, w0
 b90:	b9401fe0 	ldr	w0, [sp, #28]
 b94:	97ffff4b 	bl	8c0 <putc>
                    s++;
 b98:	f9401fe0 	ldr	x0, [sp, #56]
 b9c:	91000400 	add	x0, x0, #0x1
 ba0:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
 ba4:	f9401fe0 	ldr	x0, [sp, #56]
 ba8:	39400000 	ldrb	w0, [x0]
 bac:	7100001f 	cmp	w0, #0x0
 bb0:	54fffea1 	b.ne	b84 <printf+0x178>  // b.any
 bb4:	1400001f 	b	c30 <printf+0x224>
                }
            } else if(c == 'c'){
 bb8:	b94027e0 	ldr	w0, [sp, #36]
 bbc:	71018c1f 	cmp	w0, #0x63
 bc0:	54000161 	b.ne	bec <printf+0x1e0>  // b.any
                putc(fd, *ap);
 bc4:	f94017e0 	ldr	x0, [sp, #40]
 bc8:	f9400000 	ldr	x0, [x0]
 bcc:	12001c00 	and	w0, w0, #0xff
 bd0:	2a0003e1 	mov	w1, w0
 bd4:	b9401fe0 	ldr	w0, [sp, #28]
 bd8:	97ffff3a 	bl	8c0 <putc>
                ap++;
 bdc:	f94017e0 	ldr	x0, [sp, #40]
 be0:	91002000 	add	x0, x0, #0x8
 be4:	f90017e0 	str	x0, [sp, #40]
 be8:	14000012 	b	c30 <printf+0x224>
            } else if(c == '%'){
 bec:	b94027e0 	ldr	w0, [sp, #36]
 bf0:	7100941f 	cmp	w0, #0x25
 bf4:	540000e1 	b.ne	c10 <printf+0x204>  // b.any
                putc(fd, c);
 bf8:	b94027e0 	ldr	w0, [sp, #36]
 bfc:	12001c00 	and	w0, w0, #0xff
 c00:	2a0003e1 	mov	w1, w0
 c04:	b9401fe0 	ldr	w0, [sp, #28]
 c08:	97ffff2e 	bl	8c0 <putc>
 c0c:	14000009 	b	c30 <printf+0x224>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
 c10:	528004a1 	mov	w1, #0x25                  	// #37
 c14:	b9401fe0 	ldr	w0, [sp, #28]
 c18:	97ffff2a 	bl	8c0 <putc>
                putc(fd, c);
 c1c:	b94027e0 	ldr	w0, [sp, #36]
 c20:	12001c00 	and	w0, w0, #0xff
 c24:	2a0003e1 	mov	w1, w0
 c28:	b9401fe0 	ldr	w0, [sp, #28]
 c2c:	97ffff25 	bl	8c0 <putc>
            }
            state = 0;
 c30:	b90033ff 	str	wzr, [sp, #48]
    for(i = 0; fmt[i]; i++){
 c34:	b94037e0 	ldr	w0, [sp, #52]
 c38:	11000400 	add	w0, w0, #0x1
 c3c:	b90037e0 	str	w0, [sp, #52]
 c40:	f9400be1 	ldr	x1, [sp, #16]
 c44:	b98037e0 	ldrsw	x0, [sp, #52]
 c48:	8b000020 	add	x0, x1, x0
 c4c:	39400000 	ldrb	w0, [x0]
 c50:	7100001f 	cmp	w0, #0x0
 c54:	54fff0c1 	b.ne	a6c <printf+0x60>  // b.any
        }
    }
}
 c58:	d503201f 	nop
 c5c:	d503201f 	nop
 c60:	a8cf7bfd 	ldp	x29, x30, [sp], #240
 c64:	d65f03c0 	ret

0000000000000c68 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 c68:	d10083ff 	sub	sp, sp, #0x20
 c6c:	f90007e0 	str	x0, [sp, #8]
    Header *bp, *p;
    
    bp = (Header*)ap - 1;
 c70:	f94007e0 	ldr	x0, [sp, #8]
 c74:	d1004000 	sub	x0, x0, #0x10
 c78:	f9000be0 	str	x0, [sp, #16]
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 c7c:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
 c80:	9105e000 	add	x0, x0, #0x178
 c84:	f9400000 	ldr	x0, [x0]
 c88:	f9000fe0 	str	x0, [sp, #24]
 c8c:	14000012 	b	cd4 <free+0x6c>
        if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 c90:	f9400fe0 	ldr	x0, [sp, #24]
 c94:	f9400000 	ldr	x0, [x0]
 c98:	f9400fe1 	ldr	x1, [sp, #24]
 c9c:	eb00003f 	cmp	x1, x0
 ca0:	54000143 	b.cc	cc8 <free+0x60>  // b.lo, b.ul, b.last
 ca4:	f9400be1 	ldr	x1, [sp, #16]
 ca8:	f9400fe0 	ldr	x0, [sp, #24]
 cac:	eb00003f 	cmp	x1, x0
 cb0:	54000248 	b.hi	cf8 <free+0x90>  // b.pmore
 cb4:	f9400fe0 	ldr	x0, [sp, #24]
 cb8:	f9400000 	ldr	x0, [x0]
 cbc:	f9400be1 	ldr	x1, [sp, #16]
 cc0:	eb00003f 	cmp	x1, x0
 cc4:	540001a3 	b.cc	cf8 <free+0x90>  // b.lo, b.ul, b.last
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 cc8:	f9400fe0 	ldr	x0, [sp, #24]
 ccc:	f9400000 	ldr	x0, [x0]
 cd0:	f9000fe0 	str	x0, [sp, #24]
 cd4:	f9400be1 	ldr	x1, [sp, #16]
 cd8:	f9400fe0 	ldr	x0, [sp, #24]
 cdc:	eb00003f 	cmp	x1, x0
 ce0:	54fffd89 	b.ls	c90 <free+0x28>  // b.plast
 ce4:	f9400fe0 	ldr	x0, [sp, #24]
 ce8:	f9400000 	ldr	x0, [x0]
 cec:	f9400be1 	ldr	x1, [sp, #16]
 cf0:	eb00003f 	cmp	x1, x0
 cf4:	54fffce2 	b.cs	c90 <free+0x28>  // b.hs, b.nlast
            break;
    if(bp + bp->s.size == p->s.ptr){
 cf8:	f9400be0 	ldr	x0, [sp, #16]
 cfc:	b9400800 	ldr	w0, [x0, #8]
 d00:	2a0003e0 	mov	w0, w0
 d04:	d37cec00 	lsl	x0, x0, #4
 d08:	f9400be1 	ldr	x1, [sp, #16]
 d0c:	8b000021 	add	x1, x1, x0
 d10:	f9400fe0 	ldr	x0, [sp, #24]
 d14:	f9400000 	ldr	x0, [x0]
 d18:	eb00003f 	cmp	x1, x0
 d1c:	540001e1 	b.ne	d58 <free+0xf0>  // b.any
        bp->s.size += p->s.ptr->s.size;
 d20:	f9400be0 	ldr	x0, [sp, #16]
 d24:	b9400801 	ldr	w1, [x0, #8]
 d28:	f9400fe0 	ldr	x0, [sp, #24]
 d2c:	f9400000 	ldr	x0, [x0]
 d30:	b9400800 	ldr	w0, [x0, #8]
 d34:	0b000021 	add	w1, w1, w0
 d38:	f9400be0 	ldr	x0, [sp, #16]
 d3c:	b9000801 	str	w1, [x0, #8]
        bp->s.ptr = p->s.ptr->s.ptr;
 d40:	f9400fe0 	ldr	x0, [sp, #24]
 d44:	f9400000 	ldr	x0, [x0]
 d48:	f9400001 	ldr	x1, [x0]
 d4c:	f9400be0 	ldr	x0, [sp, #16]
 d50:	f9000001 	str	x1, [x0]
 d54:	14000005 	b	d68 <free+0x100>
    } else
        bp->s.ptr = p->s.ptr;
 d58:	f9400fe0 	ldr	x0, [sp, #24]
 d5c:	f9400001 	ldr	x1, [x0]
 d60:	f9400be0 	ldr	x0, [sp, #16]
 d64:	f9000001 	str	x1, [x0]
    if(p + p->s.size == bp){
 d68:	f9400fe0 	ldr	x0, [sp, #24]
 d6c:	b9400800 	ldr	w0, [x0, #8]
 d70:	2a0003e0 	mov	w0, w0
 d74:	d37cec00 	lsl	x0, x0, #4
 d78:	f9400fe1 	ldr	x1, [sp, #24]
 d7c:	8b000020 	add	x0, x1, x0
 d80:	f9400be1 	ldr	x1, [sp, #16]
 d84:	eb00003f 	cmp	x1, x0
 d88:	540001a1 	b.ne	dbc <free+0x154>  // b.any
        p->s.size += bp->s.size;
 d8c:	f9400fe0 	ldr	x0, [sp, #24]
 d90:	b9400801 	ldr	w1, [x0, #8]
 d94:	f9400be0 	ldr	x0, [sp, #16]
 d98:	b9400800 	ldr	w0, [x0, #8]
 d9c:	0b000021 	add	w1, w1, w0
 da0:	f9400fe0 	ldr	x0, [sp, #24]
 da4:	b9000801 	str	w1, [x0, #8]
        p->s.ptr = bp->s.ptr;
 da8:	f9400be0 	ldr	x0, [sp, #16]
 dac:	f9400001 	ldr	x1, [x0]
 db0:	f9400fe0 	ldr	x0, [sp, #24]
 db4:	f9000001 	str	x1, [x0]
 db8:	14000004 	b	dc8 <free+0x160>
    } else
        p->s.ptr = bp;
 dbc:	f9400fe0 	ldr	x0, [sp, #24]
 dc0:	f9400be1 	ldr	x1, [sp, #16]
 dc4:	f9000001 	str	x1, [x0]
    freep = p;
 dc8:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
 dcc:	9105e000 	add	x0, x0, #0x178
 dd0:	f9400fe1 	ldr	x1, [sp, #24]
 dd4:	f9000001 	str	x1, [x0]
}
 dd8:	d503201f 	nop
 ddc:	910083ff 	add	sp, sp, #0x20
 de0:	d65f03c0 	ret

0000000000000de4 <morecore>:

static Header*
morecore(uint nu)
{
 de4:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
 de8:	910003fd 	mov	x29, sp
 dec:	b9001fe0 	str	w0, [sp, #28]
    char *p;
    Header *hp;
    
    if(nu < 4096)
 df0:	b9401fe0 	ldr	w0, [sp, #28]
 df4:	713ffc1f 	cmp	w0, #0xfff
 df8:	54000068 	b.hi	e04 <morecore+0x20>  // b.pmore
        nu = 4096;
 dfc:	52820000 	mov	w0, #0x1000                	// #4096
 e00:	b9001fe0 	str	w0, [sp, #28]
    p = sbrk(nu * sizeof(Header));
 e04:	b9401fe0 	ldr	w0, [sp, #28]
 e08:	531c6c00 	lsl	w0, w0, #4
 e0c:	97fffe92 	bl	854 <sbrk>
 e10:	f90017e0 	str	x0, [sp, #40]
    if(p == (char*)-1)
 e14:	f94017e0 	ldr	x0, [sp, #40]
 e18:	b100041f 	cmn	x0, #0x1
 e1c:	54000061 	b.ne	e28 <morecore+0x44>  // b.any
        return 0;
 e20:	d2800000 	mov	x0, #0x0                   	// #0
 e24:	1400000c 	b	e54 <morecore+0x70>
    hp = (Header*)p;
 e28:	f94017e0 	ldr	x0, [sp, #40]
 e2c:	f90013e0 	str	x0, [sp, #32]
    hp->s.size = nu;
 e30:	f94013e0 	ldr	x0, [sp, #32]
 e34:	b9401fe1 	ldr	w1, [sp, #28]
 e38:	b9000801 	str	w1, [x0, #8]
    free((void*)(hp + 1));
 e3c:	f94013e0 	ldr	x0, [sp, #32]
 e40:	91004000 	add	x0, x0, #0x10
 e44:	97ffff89 	bl	c68 <free>
    return freep;
 e48:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
 e4c:	9105e000 	add	x0, x0, #0x178
 e50:	f9400000 	ldr	x0, [x0]
}
 e54:	a8c37bfd 	ldp	x29, x30, [sp], #48
 e58:	d65f03c0 	ret

0000000000000e5c <malloc>:

void*
malloc(uint nbytes)
{
 e5c:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
 e60:	910003fd 	mov	x29, sp
 e64:	b9001fe0 	str	w0, [sp, #28]
    Header *p, *prevp;
    uint nunits;
    
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 e68:	b9401fe0 	ldr	w0, [sp, #28]
 e6c:	91003c00 	add	x0, x0, #0xf
 e70:	d344fc00 	lsr	x0, x0, #4
 e74:	11000400 	add	w0, w0, #0x1
 e78:	b9002fe0 	str	w0, [sp, #44]
    if((prevp = freep) == 0){
 e7c:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
 e80:	9105e000 	add	x0, x0, #0x178
 e84:	f9400000 	ldr	x0, [x0]
 e88:	f9001be0 	str	x0, [sp, #48]
 e8c:	f9401be0 	ldr	x0, [sp, #48]
 e90:	f100001f 	cmp	x0, #0x0
 e94:	54000221 	b.ne	ed8 <malloc+0x7c>  // b.any
        base.s.ptr = freep = prevp = &base;
 e98:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
 e9c:	9105a000 	add	x0, x0, #0x168
 ea0:	f9001be0 	str	x0, [sp, #48]
 ea4:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
 ea8:	9105e000 	add	x0, x0, #0x178
 eac:	f9401be1 	ldr	x1, [sp, #48]
 eb0:	f9000001 	str	x1, [x0]
 eb4:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
 eb8:	9105e000 	add	x0, x0, #0x178
 ebc:	f9400001 	ldr	x1, [x0]
 ec0:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
 ec4:	9105a000 	add	x0, x0, #0x168
 ec8:	f9000001 	str	x1, [x0]
        base.s.size = 0;
 ecc:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
 ed0:	9105a000 	add	x0, x0, #0x168
 ed4:	b900081f 	str	wzr, [x0, #8]
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ed8:	f9401be0 	ldr	x0, [sp, #48]
 edc:	f9400000 	ldr	x0, [x0]
 ee0:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
 ee4:	f9401fe0 	ldr	x0, [sp, #56]
 ee8:	b9400800 	ldr	w0, [x0, #8]
 eec:	b9402fe1 	ldr	w1, [sp, #44]
 ef0:	6b00003f 	cmp	w1, w0
 ef4:	54000448 	b.hi	f7c <malloc+0x120>  // b.pmore
            if(p->s.size == nunits)
 ef8:	f9401fe0 	ldr	x0, [sp, #56]
 efc:	b9400800 	ldr	w0, [x0, #8]
 f00:	b9402fe1 	ldr	w1, [sp, #44]
 f04:	6b00003f 	cmp	w1, w0
 f08:	540000c1 	b.ne	f20 <malloc+0xc4>  // b.any
                prevp->s.ptr = p->s.ptr;
 f0c:	f9401fe0 	ldr	x0, [sp, #56]
 f10:	f9400001 	ldr	x1, [x0]
 f14:	f9401be0 	ldr	x0, [sp, #48]
 f18:	f9000001 	str	x1, [x0]
 f1c:	14000011 	b	f60 <malloc+0x104>
            else {
                p->s.size -= nunits;
 f20:	f9401fe0 	ldr	x0, [sp, #56]
 f24:	b9400801 	ldr	w1, [x0, #8]
 f28:	b9402fe0 	ldr	w0, [sp, #44]
 f2c:	4b000021 	sub	w1, w1, w0
 f30:	f9401fe0 	ldr	x0, [sp, #56]
 f34:	b9000801 	str	w1, [x0, #8]
                p += p->s.size;
 f38:	f9401fe0 	ldr	x0, [sp, #56]
 f3c:	b9400800 	ldr	w0, [x0, #8]
 f40:	2a0003e0 	mov	w0, w0
 f44:	d37cec00 	lsl	x0, x0, #4
 f48:	f9401fe1 	ldr	x1, [sp, #56]
 f4c:	8b000020 	add	x0, x1, x0
 f50:	f9001fe0 	str	x0, [sp, #56]
                p->s.size = nunits;
 f54:	f9401fe0 	ldr	x0, [sp, #56]
 f58:	b9402fe1 	ldr	w1, [sp, #44]
 f5c:	b9000801 	str	w1, [x0, #8]
            }
            freep = prevp;
 f60:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
 f64:	9105e000 	add	x0, x0, #0x178
 f68:	f9401be1 	ldr	x1, [sp, #48]
 f6c:	f9000001 	str	x1, [x0]
            return (void*)(p + 1);
 f70:	f9401fe0 	ldr	x0, [sp, #56]
 f74:	91004000 	add	x0, x0, #0x10
 f78:	14000015 	b	fcc <malloc+0x170>
        }
        if(p == freep)
 f7c:	b0000000 	adrp	x0, 1000 <malloc+0x1a4>
 f80:	9105e000 	add	x0, x0, #0x178
 f84:	f9400000 	ldr	x0, [x0]
 f88:	f9401fe1 	ldr	x1, [sp, #56]
 f8c:	eb00003f 	cmp	x1, x0
 f90:	54000121 	b.ne	fb4 <malloc+0x158>  // b.any
            if((p = morecore(nunits)) == 0)
 f94:	b9402fe0 	ldr	w0, [sp, #44]
 f98:	97ffff93 	bl	de4 <morecore>
 f9c:	f9001fe0 	str	x0, [sp, #56]
 fa0:	f9401fe0 	ldr	x0, [sp, #56]
 fa4:	f100001f 	cmp	x0, #0x0
 fa8:	54000061 	b.ne	fb4 <malloc+0x158>  // b.any
                return 0;
 fac:	d2800000 	mov	x0, #0x0                   	// #0
 fb0:	14000007 	b	fcc <malloc+0x170>
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 fb4:	f9401fe0 	ldr	x0, [sp, #56]
 fb8:	f9001be0 	str	x0, [sp, #48]
 fbc:	f9401fe0 	ldr	x0, [sp, #56]
 fc0:	f9400000 	ldr	x0, [x0]
 fc4:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
 fc8:	17ffffc7 	b	ee4 <malloc+0x88>
    }
}
 fcc:	a8c47bfd 	ldp	x29, x30, [sp], #64
 fd0:	d65f03c0 	ret
