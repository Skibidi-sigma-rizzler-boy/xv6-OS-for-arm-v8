
_grep:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
       0:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
       4:	910003fd 	mov	x29, sp
       8:	f9000fe0 	str	x0, [sp, #24]
       c:	b90017e1 	str	w1, [sp, #20]
    int n, m;
    char *p, *q;
    
    m = 0;
      10:	b9003fff 	str	wzr, [sp, #60]
    while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
      14:	1400003a 	b	fc <grep+0xfc>
        m += n;
      18:	b9403fe1 	ldr	w1, [sp, #60]
      1c:	b9402fe0 	ldr	w0, [sp, #44]
      20:	0b000020 	add	w0, w1, w0
      24:	b9003fe0 	str	w0, [sp, #60]
        p = buf;
      28:	b0000000 	adrp	x0, 1000 <free+0xf8>
      2c:	910b4000 	add	x0, x0, #0x2d0
      30:	f9001be0 	str	x0, [sp, #48]
        while((q = strchr(p, '\n')) != 0){
      34:	14000016 	b	8c <grep+0x8c>
            *q = 0;
      38:	f94013e0 	ldr	x0, [sp, #32]
      3c:	3900001f 	strb	wzr, [x0]
            if(match(pattern, p)){
      40:	f9401be1 	ldr	x1, [sp, #48]
      44:	f9400fe0 	ldr	x0, [sp, #24]
      48:	9400007c 	bl	238 <match>
      4c:	7100001f 	cmp	w0, #0x0
      50:	54000180 	b.eq	80 <grep+0x80>  // b.none
                *q = '\n';
      54:	f94013e0 	ldr	x0, [sp, #32]
      58:	52800141 	mov	w1, #0xa                   	// #10
      5c:	39000001 	strb	w1, [x0]
                write(1, p, q+1 - p);
      60:	f94013e0 	ldr	x0, [sp, #32]
      64:	91000401 	add	x1, x0, #0x1
      68:	f9401be0 	ldr	x0, [sp, #48]
      6c:	cb000020 	sub	x0, x1, x0
      70:	2a0003e2 	mov	w2, w0
      74:	f9401be1 	ldr	x1, [sp, #48]
      78:	52800020 	mov	w0, #0x1                   	// #1
      7c:	94000229 	bl	920 <write>
            }
            p = q+1;
      80:	f94013e0 	ldr	x0, [sp, #32]
      84:	91000400 	add	x0, x0, #0x1
      88:	f9001be0 	str	x0, [sp, #48]
        while((q = strchr(p, '\n')) != 0){
      8c:	52800141 	mov	w1, #0xa                   	// #10
      90:	f9401be0 	ldr	x0, [sp, #48]
      94:	9400016b 	bl	640 <strchr>
      98:	f90013e0 	str	x0, [sp, #32]
      9c:	f94013e0 	ldr	x0, [sp, #32]
      a0:	f100001f 	cmp	x0, #0x0
      a4:	54fffca1 	b.ne	38 <grep+0x38>  // b.any
        }
        if(p == buf)
      a8:	f9401be1 	ldr	x1, [sp, #48]
      ac:	b0000000 	adrp	x0, 1000 <free+0xf8>
      b0:	910b4000 	add	x0, x0, #0x2d0
      b4:	eb00003f 	cmp	x1, x0
      b8:	54000041 	b.ne	c0 <grep+0xc0>  // b.any
            m = 0;
      bc:	b9003fff 	str	wzr, [sp, #60]
        if(m > 0){
      c0:	b9403fe0 	ldr	w0, [sp, #60]
      c4:	7100001f 	cmp	w0, #0x0
      c8:	540001ad 	b.le	fc <grep+0xfc>
            m -= p - buf;
      cc:	b9403fe0 	ldr	w0, [sp, #60]
      d0:	f9401be2 	ldr	x2, [sp, #48]
      d4:	b0000001 	adrp	x1, 1000 <free+0xf8>
      d8:	910b4021 	add	x1, x1, #0x2d0
      dc:	cb010041 	sub	x1, x2, x1
      e0:	4b010000 	sub	w0, w0, w1
      e4:	b9003fe0 	str	w0, [sp, #60]
            memmove(buf, p, m);
      e8:	b9403fe2 	ldr	w2, [sp, #60]
      ec:	f9401be1 	ldr	x1, [sp, #48]
      f0:	b0000000 	adrp	x0, 1000 <free+0xf8>
      f4:	910b4000 	add	x0, x0, #0x2d0
      f8:	940001c4 	bl	808 <memmove>
    while((n = read(fd, buf+m, sizeof(buf)-m)) > 0){
      fc:	b9803fe1 	ldrsw	x1, [sp, #60]
     100:	b0000000 	adrp	x0, 1000 <free+0xf8>
     104:	910b4000 	add	x0, x0, #0x2d0
     108:	8b000023 	add	x3, x1, x0
     10c:	b9403fe0 	ldr	w0, [sp, #60]
     110:	52808001 	mov	w1, #0x400                 	// #1024
     114:	4b000020 	sub	w0, w1, w0
     118:	2a0003e2 	mov	w2, w0
     11c:	aa0303e1 	mov	x1, x3
     120:	b94017e0 	ldr	w0, [sp, #20]
     124:	940001f6 	bl	8fc <read>
     128:	b9002fe0 	str	w0, [sp, #44]
     12c:	b9402fe0 	ldr	w0, [sp, #44]
     130:	7100001f 	cmp	w0, #0x0
     134:	54fff72c 	b.gt	18 <grep+0x18>
        }
    }
}
     138:	d503201f 	nop
     13c:	d503201f 	nop
     140:	a8c47bfd 	ldp	x29, x30, [sp], #64
     144:	d65f03c0 	ret

0000000000000148 <main>:

int
main(int argc, char *argv[])
{
     148:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
     14c:	910003fd 	mov	x29, sp
     150:	b9001fe0 	str	w0, [sp, #28]
     154:	f9000be1 	str	x1, [sp, #16]
    int fd, i;
    char *pattern;
    
    if(argc <= 1){
     158:	b9401fe0 	ldr	w0, [sp, #28]
     15c:	7100041f 	cmp	w0, #0x1
     160:	540000cc 	b.gt	178 <main+0x30>
        printf(2, "usage: grep pattern [file ...]\n");
     164:	b0000000 	adrp	x0, 1000 <free+0xf8>
     168:	9109e001 	add	x1, x0, #0x278
     16c:	52800040 	mov	w0, #0x2                   	// #2
     170:	940002cf 	bl	cac <printf>
        exit();
     174:	940001c7 	bl	890 <exit>
    }
    pattern = argv[1];
     178:	f9400be0 	ldr	x0, [sp, #16]
     17c:	f9400400 	ldr	x0, [x0, #8]
     180:	f9001be0 	str	x0, [sp, #48]
    
    if(argc <= 2){
     184:	b9401fe0 	ldr	w0, [sp, #28]
     188:	7100081f 	cmp	w0, #0x2
     18c:	540000ac 	b.gt	1a0 <main+0x58>
        grep(pattern, 0);
     190:	52800001 	mov	w1, #0x0                   	// #0
     194:	f9401be0 	ldr	x0, [sp, #48]
     198:	97ffff9a 	bl	0 <grep>
        exit();
     19c:	940001bd 	bl	890 <exit>
    }
    
    for(i = 2; i < argc; i++){
     1a0:	52800040 	mov	w0, #0x2                   	// #2
     1a4:	b9003fe0 	str	w0, [sp, #60]
     1a8:	1400001f 	b	224 <main+0xdc>
        if((fd = open(argv[i], 0)) < 0){
     1ac:	b9803fe0 	ldrsw	x0, [sp, #60]
     1b0:	d37df000 	lsl	x0, x0, #3
     1b4:	f9400be1 	ldr	x1, [sp, #16]
     1b8:	8b000020 	add	x0, x1, x0
     1bc:	f9400000 	ldr	x0, [x0]
     1c0:	52800001 	mov	w1, #0x0                   	// #0
     1c4:	940001fb 	bl	9b0 <open>
     1c8:	b9002fe0 	str	w0, [sp, #44]
     1cc:	b9402fe0 	ldr	w0, [sp, #44]
     1d0:	7100001f 	cmp	w0, #0x0
     1d4:	5400018a 	b.ge	204 <main+0xbc>  // b.tcont
            printf(1, "grep: cannot open %s\n", argv[i]);
     1d8:	b9803fe0 	ldrsw	x0, [sp, #60]
     1dc:	d37df000 	lsl	x0, x0, #3
     1e0:	f9400be1 	ldr	x1, [sp, #16]
     1e4:	8b000020 	add	x0, x1, x0
     1e8:	f9400000 	ldr	x0, [x0]
     1ec:	aa0003e2 	mov	x2, x0
     1f0:	b0000000 	adrp	x0, 1000 <free+0xf8>
     1f4:	910a6001 	add	x1, x0, #0x298
     1f8:	52800020 	mov	w0, #0x1                   	// #1
     1fc:	940002ac 	bl	cac <printf>
            exit();
     200:	940001a4 	bl	890 <exit>
        }
        grep(pattern, fd);
     204:	b9402fe1 	ldr	w1, [sp, #44]
     208:	f9401be0 	ldr	x0, [sp, #48]
     20c:	97ffff7d 	bl	0 <grep>
        close(fd);
     210:	b9402fe0 	ldr	w0, [sp, #44]
     214:	940001cc 	bl	944 <close>
    for(i = 2; i < argc; i++){
     218:	b9403fe0 	ldr	w0, [sp, #60]
     21c:	11000400 	add	w0, w0, #0x1
     220:	b9003fe0 	str	w0, [sp, #60]
     224:	b9403fe1 	ldr	w1, [sp, #60]
     228:	b9401fe0 	ldr	w0, [sp, #28]
     22c:	6b00003f 	cmp	w1, w0
     230:	54fffbeb 	b.lt	1ac <main+0x64>  // b.tstop
    }
    exit();
     234:	94000197 	bl	890 <exit>

0000000000000238 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
     238:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
     23c:	910003fd 	mov	x29, sp
     240:	f9000fe0 	str	x0, [sp, #24]
     244:	f9000be1 	str	x1, [sp, #16]
    if(re[0] == '^')
     248:	f9400fe0 	ldr	x0, [sp, #24]
     24c:	39400000 	ldrb	w0, [x0]
     250:	7101781f 	cmp	w0, #0x5e
     254:	540000c1 	b.ne	26c <match+0x34>  // b.any
        return matchhere(re+1, text);
     258:	f9400fe0 	ldr	x0, [sp, #24]
     25c:	91000400 	add	x0, x0, #0x1
     260:	f9400be1 	ldr	x1, [sp, #16]
     264:	94000012 	bl	2ac <matchhere>
     268:	1400000f 	b	2a4 <match+0x6c>
    do{  // must look at empty string
        if(matchhere(re, text))
     26c:	f9400be1 	ldr	x1, [sp, #16]
     270:	f9400fe0 	ldr	x0, [sp, #24]
     274:	9400000e 	bl	2ac <matchhere>
     278:	7100001f 	cmp	w0, #0x0
     27c:	54000060 	b.eq	288 <match+0x50>  // b.none
            return 1;
     280:	52800020 	mov	w0, #0x1                   	// #1
     284:	14000008 	b	2a4 <match+0x6c>
    }while(*text++ != '\0');
     288:	f9400be0 	ldr	x0, [sp, #16]
     28c:	91000401 	add	x1, x0, #0x1
     290:	f9000be1 	str	x1, [sp, #16]
     294:	39400000 	ldrb	w0, [x0]
     298:	7100001f 	cmp	w0, #0x0
     29c:	54fffe81 	b.ne	26c <match+0x34>  // b.any
    return 0;
     2a0:	52800000 	mov	w0, #0x0                   	// #0
}
     2a4:	a8c27bfd 	ldp	x29, x30, [sp], #32
     2a8:	d65f03c0 	ret

00000000000002ac <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
     2ac:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
     2b0:	910003fd 	mov	x29, sp
     2b4:	f9000fe0 	str	x0, [sp, #24]
     2b8:	f9000be1 	str	x1, [sp, #16]
    if(re[0] == '\0')
     2bc:	f9400fe0 	ldr	x0, [sp, #24]
     2c0:	39400000 	ldrb	w0, [x0]
     2c4:	7100001f 	cmp	w0, #0x0
     2c8:	54000061 	b.ne	2d4 <matchhere+0x28>  // b.any
        return 1;
     2cc:	52800020 	mov	w0, #0x1                   	// #1
     2d0:	14000036 	b	3a8 <matchhere+0xfc>
    if(re[1] == '*')
     2d4:	f9400fe0 	ldr	x0, [sp, #24]
     2d8:	91000400 	add	x0, x0, #0x1
     2dc:	39400000 	ldrb	w0, [x0]
     2e0:	7100a81f 	cmp	w0, #0x2a
     2e4:	54000161 	b.ne	310 <matchhere+0x64>  // b.any
        return matchstar(re[0], re+2, text);
     2e8:	f9400fe0 	ldr	x0, [sp, #24]
     2ec:	39400000 	ldrb	w0, [x0]
     2f0:	2a0003e3 	mov	w3, w0
     2f4:	f9400fe0 	ldr	x0, [sp, #24]
     2f8:	91000800 	add	x0, x0, #0x2
     2fc:	f9400be2 	ldr	x2, [sp, #16]
     300:	aa0003e1 	mov	x1, x0
     304:	2a0303e0 	mov	w0, w3
     308:	9400002a 	bl	3b0 <matchstar>
     30c:	14000027 	b	3a8 <matchhere+0xfc>
    if(re[0] == '$' && re[1] == '\0')
     310:	f9400fe0 	ldr	x0, [sp, #24]
     314:	39400000 	ldrb	w0, [x0]
     318:	7100901f 	cmp	w0, #0x24
     31c:	54000181 	b.ne	34c <matchhere+0xa0>  // b.any
     320:	f9400fe0 	ldr	x0, [sp, #24]
     324:	91000400 	add	x0, x0, #0x1
     328:	39400000 	ldrb	w0, [x0]
     32c:	7100001f 	cmp	w0, #0x0
     330:	540000e1 	b.ne	34c <matchhere+0xa0>  // b.any
        return *text == '\0';
     334:	f9400be0 	ldr	x0, [sp, #16]
     338:	39400000 	ldrb	w0, [x0]
     33c:	7100001f 	cmp	w0, #0x0
     340:	1a9f17e0 	cset	w0, eq	// eq = none
     344:	12001c00 	and	w0, w0, #0xff
     348:	14000018 	b	3a8 <matchhere+0xfc>
    if(*text!='\0' && (re[0]=='.' || re[0]==*text))
     34c:	f9400be0 	ldr	x0, [sp, #16]
     350:	39400000 	ldrb	w0, [x0]
     354:	7100001f 	cmp	w0, #0x0
     358:	54000260 	b.eq	3a4 <matchhere+0xf8>  // b.none
     35c:	f9400fe0 	ldr	x0, [sp, #24]
     360:	39400000 	ldrb	w0, [x0]
     364:	7100b81f 	cmp	w0, #0x2e
     368:	540000e0 	b.eq	384 <matchhere+0xd8>  // b.none
     36c:	f9400fe0 	ldr	x0, [sp, #24]
     370:	39400001 	ldrb	w1, [x0]
     374:	f9400be0 	ldr	x0, [sp, #16]
     378:	39400000 	ldrb	w0, [x0]
     37c:	6b00003f 	cmp	w1, w0
     380:	54000121 	b.ne	3a4 <matchhere+0xf8>  // b.any
        return matchhere(re+1, text+1);
     384:	f9400fe0 	ldr	x0, [sp, #24]
     388:	91000402 	add	x2, x0, #0x1
     38c:	f9400be0 	ldr	x0, [sp, #16]
     390:	91000400 	add	x0, x0, #0x1
     394:	aa0003e1 	mov	x1, x0
     398:	aa0203e0 	mov	x0, x2
     39c:	97ffffc4 	bl	2ac <matchhere>
     3a0:	14000002 	b	3a8 <matchhere+0xfc>
    return 0;
     3a4:	52800000 	mov	w0, #0x0                   	// #0
}
     3a8:	a8c27bfd 	ldp	x29, x30, [sp], #32
     3ac:	d65f03c0 	ret

00000000000003b0 <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
     3b0:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     3b4:	910003fd 	mov	x29, sp
     3b8:	b9002fe0 	str	w0, [sp, #44]
     3bc:	f90013e1 	str	x1, [sp, #32]
     3c0:	f9000fe2 	str	x2, [sp, #24]
    do{  // a * matches zero or more instances
        if(matchhere(re, text))
     3c4:	f9400fe1 	ldr	x1, [sp, #24]
     3c8:	f94013e0 	ldr	x0, [sp, #32]
     3cc:	97ffffb8 	bl	2ac <matchhere>
     3d0:	7100001f 	cmp	w0, #0x0
     3d4:	54000060 	b.eq	3e0 <matchstar+0x30>  // b.none
            return 1;
     3d8:	52800020 	mov	w0, #0x1                   	// #1
     3dc:	14000011 	b	420 <matchstar+0x70>
    }while(*text!='\0' && (*text++==c || c=='.'));
     3e0:	f9400fe0 	ldr	x0, [sp, #24]
     3e4:	39400000 	ldrb	w0, [x0]
     3e8:	7100001f 	cmp	w0, #0x0
     3ec:	54000180 	b.eq	41c <matchstar+0x6c>  // b.none
     3f0:	f9400fe0 	ldr	x0, [sp, #24]
     3f4:	91000401 	add	x1, x0, #0x1
     3f8:	f9000fe1 	str	x1, [sp, #24]
     3fc:	39400000 	ldrb	w0, [x0]
     400:	2a0003e1 	mov	w1, w0
     404:	b9402fe0 	ldr	w0, [sp, #44]
     408:	6b01001f 	cmp	w0, w1
     40c:	54fffdc0 	b.eq	3c4 <matchstar+0x14>  // b.none
     410:	b9402fe0 	ldr	w0, [sp, #44]
     414:	7100b81f 	cmp	w0, #0x2e
     418:	54fffd60 	b.eq	3c4 <matchstar+0x14>  // b.none
    return 0;
     41c:	52800000 	mov	w0, #0x0                   	// #0
}
     420:	a8c37bfd 	ldp	x29, x30, [sp], #48
     424:	d65f03c0 	ret

0000000000000428 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
     428:	d10083ff 	sub	sp, sp, #0x20
     42c:	f90007e0 	str	x0, [sp, #8]
     430:	f90003e1 	str	x1, [sp]
    char *os;
    
    os = s;
     434:	f94007e0 	ldr	x0, [sp, #8]
     438:	f9000fe0 	str	x0, [sp, #24]
    while((*s++ = *t++) != 0)
     43c:	d503201f 	nop
     440:	f94003e1 	ldr	x1, [sp]
     444:	91000420 	add	x0, x1, #0x1
     448:	f90003e0 	str	x0, [sp]
     44c:	f94007e0 	ldr	x0, [sp, #8]
     450:	91000402 	add	x2, x0, #0x1
     454:	f90007e2 	str	x2, [sp, #8]
     458:	39400021 	ldrb	w1, [x1]
     45c:	39000001 	strb	w1, [x0]
     460:	39400000 	ldrb	w0, [x0]
     464:	7100001f 	cmp	w0, #0x0
     468:	54fffec1 	b.ne	440 <strcpy+0x18>  // b.any
        ;
    return os;
     46c:	f9400fe0 	ldr	x0, [sp, #24]
}
     470:	910083ff 	add	sp, sp, #0x20
     474:	d65f03c0 	ret

0000000000000478 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     478:	d10043ff 	sub	sp, sp, #0x10
     47c:	f90007e0 	str	x0, [sp, #8]
     480:	f90003e1 	str	x1, [sp]
    while(*p && *p == *q)
     484:	14000007 	b	4a0 <strcmp+0x28>
        p++, q++;
     488:	f94007e0 	ldr	x0, [sp, #8]
     48c:	91000400 	add	x0, x0, #0x1
     490:	f90007e0 	str	x0, [sp, #8]
     494:	f94003e0 	ldr	x0, [sp]
     498:	91000400 	add	x0, x0, #0x1
     49c:	f90003e0 	str	x0, [sp]
    while(*p && *p == *q)
     4a0:	f94007e0 	ldr	x0, [sp, #8]
     4a4:	39400000 	ldrb	w0, [x0]
     4a8:	7100001f 	cmp	w0, #0x0
     4ac:	540000e0 	b.eq	4c8 <strcmp+0x50>  // b.none
     4b0:	f94007e0 	ldr	x0, [sp, #8]
     4b4:	39400001 	ldrb	w1, [x0]
     4b8:	f94003e0 	ldr	x0, [sp]
     4bc:	39400000 	ldrb	w0, [x0]
     4c0:	6b00003f 	cmp	w1, w0
     4c4:	54fffe20 	b.eq	488 <strcmp+0x10>  // b.none
    return (uchar)*p - (uchar)*q;
     4c8:	f94007e0 	ldr	x0, [sp, #8]
     4cc:	39400000 	ldrb	w0, [x0]
     4d0:	2a0003e1 	mov	w1, w0
     4d4:	f94003e0 	ldr	x0, [sp]
     4d8:	39400000 	ldrb	w0, [x0]
     4dc:	4b000020 	sub	w0, w1, w0
}
     4e0:	910043ff 	add	sp, sp, #0x10
     4e4:	d65f03c0 	ret

00000000000004e8 <strlen>:

uint
strlen(char *s)
{
     4e8:	d10083ff 	sub	sp, sp, #0x20
     4ec:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    for(n = 0; s[n]; n++)
     4f0:	b9001fff 	str	wzr, [sp, #28]
     4f4:	14000004 	b	504 <strlen+0x1c>
     4f8:	b9401fe0 	ldr	w0, [sp, #28]
     4fc:	11000400 	add	w0, w0, #0x1
     500:	b9001fe0 	str	w0, [sp, #28]
     504:	b9801fe0 	ldrsw	x0, [sp, #28]
     508:	f94007e1 	ldr	x1, [sp, #8]
     50c:	8b000020 	add	x0, x1, x0
     510:	39400000 	ldrb	w0, [x0]
     514:	7100001f 	cmp	w0, #0x0
     518:	54ffff01 	b.ne	4f8 <strlen+0x10>  // b.any
        ;
    return n;
     51c:	b9401fe0 	ldr	w0, [sp, #28]
}
     520:	910083ff 	add	sp, sp, #0x20
     524:	d65f03c0 	ret

0000000000000528 <memset>:

void*
memset(void *dst, int v, uint n)
{
     528:	d100c3ff 	sub	sp, sp, #0x30
     52c:	f90007e0 	str	x0, [sp, #8]
     530:	b90007e1 	str	w1, [sp, #4]
     534:	b90003e2 	str	w2, [sp]
	uint8	*p;
	uint8	c;
	uint32	val;
	uint32	*p4;

	p   = dst;
     538:	f94007e0 	ldr	x0, [sp, #8]
     53c:	f90017e0 	str	x0, [sp, #40]
	c   = v & 0xff;
     540:	b94007e0 	ldr	w0, [sp, #4]
     544:	39007fe0 	strb	w0, [sp, #31]
	val = (c << 24) | (c << 16) | (c << 8) | c;
     548:	39407fe1 	ldrb	w1, [sp, #31]
     54c:	2a0103e0 	mov	w0, w1
     550:	53185c00 	lsl	w0, w0, #8
     554:	0b010000 	add	w0, w0, w1
     558:	53103c00 	lsl	w0, w0, #16
     55c:	2a0003e1 	mov	w1, w0
     560:	39407fe0 	ldrb	w0, [sp, #31]
     564:	53185c00 	lsl	w0, w0, #8
     568:	2a000021 	orr	w1, w1, w0
     56c:	39407fe0 	ldrb	w0, [sp, #31]
     570:	2a000020 	orr	w0, w1, w0
     574:	b9001be0 	str	w0, [sp, #24]

	// set bytes before whole uint32
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
     578:	1400000a 	b	5a0 <memset+0x78>
		*p = c;
     57c:	f94017e0 	ldr	x0, [sp, #40]
     580:	39407fe1 	ldrb	w1, [sp, #31]
     584:	39000001 	strb	w1, [x0]
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
     588:	b94003e0 	ldr	w0, [sp]
     58c:	51000400 	sub	w0, w0, #0x1
     590:	b90003e0 	str	w0, [sp]
     594:	f94017e0 	ldr	x0, [sp, #40]
     598:	91000400 	add	x0, x0, #0x1
     59c:	f90017e0 	str	x0, [sp, #40]
     5a0:	b94003e0 	ldr	w0, [sp]
     5a4:	7100001f 	cmp	w0, #0x0
     5a8:	540000a0 	b.eq	5bc <memset+0x94>  // b.none
     5ac:	f94017e0 	ldr	x0, [sp, #40]
     5b0:	92400400 	and	x0, x0, #0x3
     5b4:	f100001f 	cmp	x0, #0x0
     5b8:	54fffe21 	b.ne	57c <memset+0x54>  // b.any
	}

	// set memory 4 bytes a time
	p4 = (uint*)p;
     5bc:	f94017e0 	ldr	x0, [sp, #40]
     5c0:	f90013e0 	str	x0, [sp, #32]

	for (; n >= 4; n -= 4, p4++) {
     5c4:	1400000a 	b	5ec <memset+0xc4>
		*p4 = val;
     5c8:	f94013e0 	ldr	x0, [sp, #32]
     5cc:	b9401be1 	ldr	w1, [sp, #24]
     5d0:	b9000001 	str	w1, [x0]
	for (; n >= 4; n -= 4, p4++) {
     5d4:	b94003e0 	ldr	w0, [sp]
     5d8:	51001000 	sub	w0, w0, #0x4
     5dc:	b90003e0 	str	w0, [sp]
     5e0:	f94013e0 	ldr	x0, [sp, #32]
     5e4:	91001000 	add	x0, x0, #0x4
     5e8:	f90013e0 	str	x0, [sp, #32]
     5ec:	b94003e0 	ldr	w0, [sp]
     5f0:	71000c1f 	cmp	w0, #0x3
     5f4:	54fffea8 	b.hi	5c8 <memset+0xa0>  // b.pmore
	}

	// set leftover one byte a time
	p = (uint8*)p4;
     5f8:	f94013e0 	ldr	x0, [sp, #32]
     5fc:	f90017e0 	str	x0, [sp, #40]

	for (; n > 0; n--, p++) {
     600:	1400000a 	b	628 <memset+0x100>
		*p = c;
     604:	f94017e0 	ldr	x0, [sp, #40]
     608:	39407fe1 	ldrb	w1, [sp, #31]
     60c:	39000001 	strb	w1, [x0]
	for (; n > 0; n--, p++) {
     610:	b94003e0 	ldr	w0, [sp]
     614:	51000400 	sub	w0, w0, #0x1
     618:	b90003e0 	str	w0, [sp]
     61c:	f94017e0 	ldr	x0, [sp, #40]
     620:	91000400 	add	x0, x0, #0x1
     624:	f90017e0 	str	x0, [sp, #40]
     628:	b94003e0 	ldr	w0, [sp]
     62c:	7100001f 	cmp	w0, #0x0
     630:	54fffea1 	b.ne	604 <memset+0xdc>  // b.any
	}

	return dst;
     634:	f94007e0 	ldr	x0, [sp, #8]
}
     638:	9100c3ff 	add	sp, sp, #0x30
     63c:	d65f03c0 	ret

0000000000000640 <strchr>:

char*
strchr(const char *s, char c)
{
     640:	d10043ff 	sub	sp, sp, #0x10
     644:	f90007e0 	str	x0, [sp, #8]
     648:	39001fe1 	strb	w1, [sp, #7]
    for(; *s; s++)
     64c:	1400000b 	b	678 <strchr+0x38>
        if(*s == c)
     650:	f94007e0 	ldr	x0, [sp, #8]
     654:	39400000 	ldrb	w0, [x0]
     658:	39401fe1 	ldrb	w1, [sp, #7]
     65c:	6b00003f 	cmp	w1, w0
     660:	54000061 	b.ne	66c <strchr+0x2c>  // b.any
            return (char*)s;
     664:	f94007e0 	ldr	x0, [sp, #8]
     668:	14000009 	b	68c <strchr+0x4c>
    for(; *s; s++)
     66c:	f94007e0 	ldr	x0, [sp, #8]
     670:	91000400 	add	x0, x0, #0x1
     674:	f90007e0 	str	x0, [sp, #8]
     678:	f94007e0 	ldr	x0, [sp, #8]
     67c:	39400000 	ldrb	w0, [x0]
     680:	7100001f 	cmp	w0, #0x0
     684:	54fffe61 	b.ne	650 <strchr+0x10>  // b.any
    return 0;
     688:	d2800000 	mov	x0, #0x0                   	// #0
}
     68c:	910043ff 	add	sp, sp, #0x10
     690:	d65f03c0 	ret

0000000000000694 <gets>:

char*
gets(char *buf, int max)
{
     694:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     698:	910003fd 	mov	x29, sp
     69c:	f9000fe0 	str	x0, [sp, #24]
     6a0:	b90017e1 	str	w1, [sp, #20]
    int i, cc;
    char c;
    
    for(i=0; i+1 < max; ){
     6a4:	b9002fff 	str	wzr, [sp, #44]
     6a8:	14000018 	b	708 <gets+0x74>
        cc = read(0, &c, 1);
     6ac:	91009fe0 	add	x0, sp, #0x27
     6b0:	52800022 	mov	w2, #0x1                   	// #1
     6b4:	aa0003e1 	mov	x1, x0
     6b8:	52800000 	mov	w0, #0x0                   	// #0
     6bc:	94000090 	bl	8fc <read>
     6c0:	b9002be0 	str	w0, [sp, #40]
        if(cc < 1)
     6c4:	b9402be0 	ldr	w0, [sp, #40]
     6c8:	7100001f 	cmp	w0, #0x0
     6cc:	540002ad 	b.le	720 <gets+0x8c>
            break;
        buf[i++] = c;
     6d0:	b9402fe0 	ldr	w0, [sp, #44]
     6d4:	11000401 	add	w1, w0, #0x1
     6d8:	b9002fe1 	str	w1, [sp, #44]
     6dc:	93407c00 	sxtw	x0, w0
     6e0:	f9400fe1 	ldr	x1, [sp, #24]
     6e4:	8b000020 	add	x0, x1, x0
     6e8:	39409fe1 	ldrb	w1, [sp, #39]
     6ec:	39000001 	strb	w1, [x0]
        if(c == '\n' || c == '\r')
     6f0:	39409fe0 	ldrb	w0, [sp, #39]
     6f4:	7100281f 	cmp	w0, #0xa
     6f8:	54000160 	b.eq	724 <gets+0x90>  // b.none
     6fc:	39409fe0 	ldrb	w0, [sp, #39]
     700:	7100341f 	cmp	w0, #0xd
     704:	54000100 	b.eq	724 <gets+0x90>  // b.none
    for(i=0; i+1 < max; ){
     708:	b9402fe0 	ldr	w0, [sp, #44]
     70c:	11000400 	add	w0, w0, #0x1
     710:	b94017e1 	ldr	w1, [sp, #20]
     714:	6b00003f 	cmp	w1, w0
     718:	54fffcac 	b.gt	6ac <gets+0x18>
     71c:	14000002 	b	724 <gets+0x90>
            break;
     720:	d503201f 	nop
            break;
    }
    buf[i] = '\0';
     724:	b9802fe0 	ldrsw	x0, [sp, #44]
     728:	f9400fe1 	ldr	x1, [sp, #24]
     72c:	8b000020 	add	x0, x1, x0
     730:	3900001f 	strb	wzr, [x0]
    return buf;
     734:	f9400fe0 	ldr	x0, [sp, #24]
}
     738:	a8c37bfd 	ldp	x29, x30, [sp], #48
     73c:	d65f03c0 	ret

0000000000000740 <stat>:

int
stat(char *n, struct stat *st)
{
     740:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     744:	910003fd 	mov	x29, sp
     748:	f9000fe0 	str	x0, [sp, #24]
     74c:	f9000be1 	str	x1, [sp, #16]
    int fd;
    int r;
    
    fd = open(n, O_RDONLY);
     750:	52800001 	mov	w1, #0x0                   	// #0
     754:	f9400fe0 	ldr	x0, [sp, #24]
     758:	94000096 	bl	9b0 <open>
     75c:	b9002fe0 	str	w0, [sp, #44]
    if(fd < 0)
     760:	b9402fe0 	ldr	w0, [sp, #44]
     764:	7100001f 	cmp	w0, #0x0
     768:	5400006a 	b.ge	774 <stat+0x34>  // b.tcont
        return -1;
     76c:	12800000 	mov	w0, #0xffffffff            	// #-1
     770:	14000008 	b	790 <stat+0x50>
    r = fstat(fd, st);
     774:	f9400be1 	ldr	x1, [sp, #16]
     778:	b9402fe0 	ldr	w0, [sp, #44]
     77c:	940000a8 	bl	a1c <fstat>
     780:	b9002be0 	str	w0, [sp, #40]
    close(fd);
     784:	b9402fe0 	ldr	w0, [sp, #44]
     788:	9400006f 	bl	944 <close>
    return r;
     78c:	b9402be0 	ldr	w0, [sp, #40]
}
     790:	a8c37bfd 	ldp	x29, x30, [sp], #48
     794:	d65f03c0 	ret

0000000000000798 <atoi>:

int
atoi(const char *s)
{
     798:	d10083ff 	sub	sp, sp, #0x20
     79c:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    n = 0;
     7a0:	b9001fff 	str	wzr, [sp, #28]
    while('0' <= *s && *s <= '9')
     7a4:	1400000e 	b	7dc <atoi+0x44>
        n = n*10 + *s++ - '0';
     7a8:	b9401fe1 	ldr	w1, [sp, #28]
     7ac:	2a0103e0 	mov	w0, w1
     7b0:	531e7400 	lsl	w0, w0, #2
     7b4:	0b010000 	add	w0, w0, w1
     7b8:	531f7800 	lsl	w0, w0, #1
     7bc:	2a0003e2 	mov	w2, w0
     7c0:	f94007e0 	ldr	x0, [sp, #8]
     7c4:	91000401 	add	x1, x0, #0x1
     7c8:	f90007e1 	str	x1, [sp, #8]
     7cc:	39400000 	ldrb	w0, [x0]
     7d0:	0b000040 	add	w0, w2, w0
     7d4:	5100c000 	sub	w0, w0, #0x30
     7d8:	b9001fe0 	str	w0, [sp, #28]
    while('0' <= *s && *s <= '9')
     7dc:	f94007e0 	ldr	x0, [sp, #8]
     7e0:	39400000 	ldrb	w0, [x0]
     7e4:	7100bc1f 	cmp	w0, #0x2f
     7e8:	540000a9 	b.ls	7fc <atoi+0x64>  // b.plast
     7ec:	f94007e0 	ldr	x0, [sp, #8]
     7f0:	39400000 	ldrb	w0, [x0]
     7f4:	7100e41f 	cmp	w0, #0x39
     7f8:	54fffd89 	b.ls	7a8 <atoi+0x10>  // b.plast
    return n;
     7fc:	b9401fe0 	ldr	w0, [sp, #28]
}
     800:	910083ff 	add	sp, sp, #0x20
     804:	d65f03c0 	ret

0000000000000808 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     808:	d100c3ff 	sub	sp, sp, #0x30
     80c:	f9000fe0 	str	x0, [sp, #24]
     810:	f9000be1 	str	x1, [sp, #16]
     814:	b9000fe2 	str	w2, [sp, #12]
    char *dst, *src;
    
    dst = vdst;
     818:	f9400fe0 	ldr	x0, [sp, #24]
     81c:	f90017e0 	str	x0, [sp, #40]
    src = vsrc;
     820:	f9400be0 	ldr	x0, [sp, #16]
     824:	f90013e0 	str	x0, [sp, #32]
    while(n-- > 0)
     828:	14000009 	b	84c <memmove+0x44>
        *dst++ = *src++;
     82c:	f94013e1 	ldr	x1, [sp, #32]
     830:	91000420 	add	x0, x1, #0x1
     834:	f90013e0 	str	x0, [sp, #32]
     838:	f94017e0 	ldr	x0, [sp, #40]
     83c:	91000402 	add	x2, x0, #0x1
     840:	f90017e2 	str	x2, [sp, #40]
     844:	39400021 	ldrb	w1, [x1]
     848:	39000001 	strb	w1, [x0]
    while(n-- > 0)
     84c:	b9400fe0 	ldr	w0, [sp, #12]
     850:	51000401 	sub	w1, w0, #0x1
     854:	b9000fe1 	str	w1, [sp, #12]
     858:	7100001f 	cmp	w0, #0x0
     85c:	54fffe8c 	b.gt	82c <memmove+0x24>
    return vdst;
     860:	f9400fe0 	ldr	x0, [sp, #24]
}
     864:	9100c3ff 	add	sp, sp, #0x30
     868:	d65f03c0 	ret

000000000000086c <fork>:
     86c:	f81f8fe4 	str	x4, [sp, #-8]!
     870:	aa0303e4 	mov	x4, x3
     874:	aa0203e3 	mov	x3, x2
     878:	aa0103e2 	mov	x2, x1
     87c:	aa0003e1 	mov	x1, x0
     880:	d2800020 	mov	x0, #0x1                   	// #1
     884:	d4000001 	svc	#0x0
     888:	f84087e4 	ldr	x4, [sp], #8
     88c:	d61f03c0 	br	x30

0000000000000890 <exit>:
     890:	f81f8fe4 	str	x4, [sp, #-8]!
     894:	aa0303e4 	mov	x4, x3
     898:	aa0203e3 	mov	x3, x2
     89c:	aa0103e2 	mov	x2, x1
     8a0:	aa0003e1 	mov	x1, x0
     8a4:	d2800040 	mov	x0, #0x2                   	// #2
     8a8:	d4000001 	svc	#0x0
     8ac:	f84087e4 	ldr	x4, [sp], #8
     8b0:	d61f03c0 	br	x30

00000000000008b4 <wait>:
     8b4:	f81f8fe4 	str	x4, [sp, #-8]!
     8b8:	aa0303e4 	mov	x4, x3
     8bc:	aa0203e3 	mov	x3, x2
     8c0:	aa0103e2 	mov	x2, x1
     8c4:	aa0003e1 	mov	x1, x0
     8c8:	d2800060 	mov	x0, #0x3                   	// #3
     8cc:	d4000001 	svc	#0x0
     8d0:	f84087e4 	ldr	x4, [sp], #8
     8d4:	d61f03c0 	br	x30

00000000000008d8 <pipe>:
     8d8:	f81f8fe4 	str	x4, [sp, #-8]!
     8dc:	aa0303e4 	mov	x4, x3
     8e0:	aa0203e3 	mov	x3, x2
     8e4:	aa0103e2 	mov	x2, x1
     8e8:	aa0003e1 	mov	x1, x0
     8ec:	d2800080 	mov	x0, #0x4                   	// #4
     8f0:	d4000001 	svc	#0x0
     8f4:	f84087e4 	ldr	x4, [sp], #8
     8f8:	d61f03c0 	br	x30

00000000000008fc <read>:
     8fc:	f81f8fe4 	str	x4, [sp, #-8]!
     900:	aa0303e4 	mov	x4, x3
     904:	aa0203e3 	mov	x3, x2
     908:	aa0103e2 	mov	x2, x1
     90c:	aa0003e1 	mov	x1, x0
     910:	d28000a0 	mov	x0, #0x5                   	// #5
     914:	d4000001 	svc	#0x0
     918:	f84087e4 	ldr	x4, [sp], #8
     91c:	d61f03c0 	br	x30

0000000000000920 <write>:
     920:	f81f8fe4 	str	x4, [sp, #-8]!
     924:	aa0303e4 	mov	x4, x3
     928:	aa0203e3 	mov	x3, x2
     92c:	aa0103e2 	mov	x2, x1
     930:	aa0003e1 	mov	x1, x0
     934:	d2800200 	mov	x0, #0x10                  	// #16
     938:	d4000001 	svc	#0x0
     93c:	f84087e4 	ldr	x4, [sp], #8
     940:	d61f03c0 	br	x30

0000000000000944 <close>:
     944:	f81f8fe4 	str	x4, [sp, #-8]!
     948:	aa0303e4 	mov	x4, x3
     94c:	aa0203e3 	mov	x3, x2
     950:	aa0103e2 	mov	x2, x1
     954:	aa0003e1 	mov	x1, x0
     958:	d28002a0 	mov	x0, #0x15                  	// #21
     95c:	d4000001 	svc	#0x0
     960:	f84087e4 	ldr	x4, [sp], #8
     964:	d61f03c0 	br	x30

0000000000000968 <kill>:
     968:	f81f8fe4 	str	x4, [sp, #-8]!
     96c:	aa0303e4 	mov	x4, x3
     970:	aa0203e3 	mov	x3, x2
     974:	aa0103e2 	mov	x2, x1
     978:	aa0003e1 	mov	x1, x0
     97c:	d28000c0 	mov	x0, #0x6                   	// #6
     980:	d4000001 	svc	#0x0
     984:	f84087e4 	ldr	x4, [sp], #8
     988:	d61f03c0 	br	x30

000000000000098c <exec>:
     98c:	f81f8fe4 	str	x4, [sp, #-8]!
     990:	aa0303e4 	mov	x4, x3
     994:	aa0203e3 	mov	x3, x2
     998:	aa0103e2 	mov	x2, x1
     99c:	aa0003e1 	mov	x1, x0
     9a0:	d28000e0 	mov	x0, #0x7                   	// #7
     9a4:	d4000001 	svc	#0x0
     9a8:	f84087e4 	ldr	x4, [sp], #8
     9ac:	d61f03c0 	br	x30

00000000000009b0 <open>:
     9b0:	f81f8fe4 	str	x4, [sp, #-8]!
     9b4:	aa0303e4 	mov	x4, x3
     9b8:	aa0203e3 	mov	x3, x2
     9bc:	aa0103e2 	mov	x2, x1
     9c0:	aa0003e1 	mov	x1, x0
     9c4:	d28001e0 	mov	x0, #0xf                   	// #15
     9c8:	d4000001 	svc	#0x0
     9cc:	f84087e4 	ldr	x4, [sp], #8
     9d0:	d61f03c0 	br	x30

00000000000009d4 <mknod>:
     9d4:	f81f8fe4 	str	x4, [sp, #-8]!
     9d8:	aa0303e4 	mov	x4, x3
     9dc:	aa0203e3 	mov	x3, x2
     9e0:	aa0103e2 	mov	x2, x1
     9e4:	aa0003e1 	mov	x1, x0
     9e8:	d2800220 	mov	x0, #0x11                  	// #17
     9ec:	d4000001 	svc	#0x0
     9f0:	f84087e4 	ldr	x4, [sp], #8
     9f4:	d61f03c0 	br	x30

00000000000009f8 <unlink>:
     9f8:	f81f8fe4 	str	x4, [sp, #-8]!
     9fc:	aa0303e4 	mov	x4, x3
     a00:	aa0203e3 	mov	x3, x2
     a04:	aa0103e2 	mov	x2, x1
     a08:	aa0003e1 	mov	x1, x0
     a0c:	d2800240 	mov	x0, #0x12                  	// #18
     a10:	d4000001 	svc	#0x0
     a14:	f84087e4 	ldr	x4, [sp], #8
     a18:	d61f03c0 	br	x30

0000000000000a1c <fstat>:
     a1c:	f81f8fe4 	str	x4, [sp, #-8]!
     a20:	aa0303e4 	mov	x4, x3
     a24:	aa0203e3 	mov	x3, x2
     a28:	aa0103e2 	mov	x2, x1
     a2c:	aa0003e1 	mov	x1, x0
     a30:	d2800100 	mov	x0, #0x8                   	// #8
     a34:	d4000001 	svc	#0x0
     a38:	f84087e4 	ldr	x4, [sp], #8
     a3c:	d61f03c0 	br	x30

0000000000000a40 <link>:
     a40:	f81f8fe4 	str	x4, [sp, #-8]!
     a44:	aa0303e4 	mov	x4, x3
     a48:	aa0203e3 	mov	x3, x2
     a4c:	aa0103e2 	mov	x2, x1
     a50:	aa0003e1 	mov	x1, x0
     a54:	d2800260 	mov	x0, #0x13                  	// #19
     a58:	d4000001 	svc	#0x0
     a5c:	f84087e4 	ldr	x4, [sp], #8
     a60:	d61f03c0 	br	x30

0000000000000a64 <mkdir>:
     a64:	f81f8fe4 	str	x4, [sp, #-8]!
     a68:	aa0303e4 	mov	x4, x3
     a6c:	aa0203e3 	mov	x3, x2
     a70:	aa0103e2 	mov	x2, x1
     a74:	aa0003e1 	mov	x1, x0
     a78:	d2800280 	mov	x0, #0x14                  	// #20
     a7c:	d4000001 	svc	#0x0
     a80:	f84087e4 	ldr	x4, [sp], #8
     a84:	d61f03c0 	br	x30

0000000000000a88 <chdir>:
     a88:	f81f8fe4 	str	x4, [sp, #-8]!
     a8c:	aa0303e4 	mov	x4, x3
     a90:	aa0203e3 	mov	x3, x2
     a94:	aa0103e2 	mov	x2, x1
     a98:	aa0003e1 	mov	x1, x0
     a9c:	d2800120 	mov	x0, #0x9                   	// #9
     aa0:	d4000001 	svc	#0x0
     aa4:	f84087e4 	ldr	x4, [sp], #8
     aa8:	d61f03c0 	br	x30

0000000000000aac <dup>:
     aac:	f81f8fe4 	str	x4, [sp, #-8]!
     ab0:	aa0303e4 	mov	x4, x3
     ab4:	aa0203e3 	mov	x3, x2
     ab8:	aa0103e2 	mov	x2, x1
     abc:	aa0003e1 	mov	x1, x0
     ac0:	d2800140 	mov	x0, #0xa                   	// #10
     ac4:	d4000001 	svc	#0x0
     ac8:	f84087e4 	ldr	x4, [sp], #8
     acc:	d61f03c0 	br	x30

0000000000000ad0 <getpid>:
     ad0:	f81f8fe4 	str	x4, [sp, #-8]!
     ad4:	aa0303e4 	mov	x4, x3
     ad8:	aa0203e3 	mov	x3, x2
     adc:	aa0103e2 	mov	x2, x1
     ae0:	aa0003e1 	mov	x1, x0
     ae4:	d2800160 	mov	x0, #0xb                   	// #11
     ae8:	d4000001 	svc	#0x0
     aec:	f84087e4 	ldr	x4, [sp], #8
     af0:	d61f03c0 	br	x30

0000000000000af4 <sbrk>:
     af4:	f81f8fe4 	str	x4, [sp, #-8]!
     af8:	aa0303e4 	mov	x4, x3
     afc:	aa0203e3 	mov	x3, x2
     b00:	aa0103e2 	mov	x2, x1
     b04:	aa0003e1 	mov	x1, x0
     b08:	d2800180 	mov	x0, #0xc                   	// #12
     b0c:	d4000001 	svc	#0x0
     b10:	f84087e4 	ldr	x4, [sp], #8
     b14:	d61f03c0 	br	x30

0000000000000b18 <sleep>:
     b18:	f81f8fe4 	str	x4, [sp, #-8]!
     b1c:	aa0303e4 	mov	x4, x3
     b20:	aa0203e3 	mov	x3, x2
     b24:	aa0103e2 	mov	x2, x1
     b28:	aa0003e1 	mov	x1, x0
     b2c:	d28001a0 	mov	x0, #0xd                   	// #13
     b30:	d4000001 	svc	#0x0
     b34:	f84087e4 	ldr	x4, [sp], #8
     b38:	d61f03c0 	br	x30

0000000000000b3c <uptime>:
     b3c:	f81f8fe4 	str	x4, [sp, #-8]!
     b40:	aa0303e4 	mov	x4, x3
     b44:	aa0203e3 	mov	x3, x2
     b48:	aa0103e2 	mov	x2, x1
     b4c:	aa0003e1 	mov	x1, x0
     b50:	d28001c0 	mov	x0, #0xe                   	// #14
     b54:	d4000001 	svc	#0x0
     b58:	f84087e4 	ldr	x4, [sp], #8
     b5c:	d61f03c0 	br	x30

0000000000000b60 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
     b60:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
     b64:	910003fd 	mov	x29, sp
     b68:	b9001fe0 	str	w0, [sp, #28]
     b6c:	39006fe1 	strb	w1, [sp, #27]
    write(fd, &c, 1);
     b70:	91006fe0 	add	x0, sp, #0x1b
     b74:	52800022 	mov	w2, #0x1                   	// #1
     b78:	aa0003e1 	mov	x1, x0
     b7c:	b9401fe0 	ldr	w0, [sp, #28]
     b80:	97ffff68 	bl	920 <write>
}
     b84:	d503201f 	nop
     b88:	a8c27bfd 	ldp	x29, x30, [sp], #32
     b8c:	d65f03c0 	ret

0000000000000b90 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     b90:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
     b94:	910003fd 	mov	x29, sp
     b98:	b9001fe0 	str	w0, [sp, #28]
     b9c:	b9001be1 	str	w1, [sp, #24]
     ba0:	b90017e2 	str	w2, [sp, #20]
     ba4:	b90013e3 	str	w3, [sp, #16]
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
     ba8:	b9003bff 	str	wzr, [sp, #56]
    if(sgn && xx < 0){
     bac:	b94013e0 	ldr	w0, [sp, #16]
     bb0:	7100001f 	cmp	w0, #0x0
     bb4:	54000140 	b.eq	bdc <printint+0x4c>  // b.none
     bb8:	b9401be0 	ldr	w0, [sp, #24]
     bbc:	7100001f 	cmp	w0, #0x0
     bc0:	540000ea 	b.ge	bdc <printint+0x4c>  // b.tcont
        neg = 1;
     bc4:	52800020 	mov	w0, #0x1                   	// #1
     bc8:	b9003be0 	str	w0, [sp, #56]
        x = -xx;
     bcc:	b9401be0 	ldr	w0, [sp, #24]
     bd0:	4b0003e0 	neg	w0, w0
     bd4:	b90037e0 	str	w0, [sp, #52]
     bd8:	14000003 	b	be4 <printint+0x54>
    } else {
        x = xx;
     bdc:	b9401be0 	ldr	w0, [sp, #24]
     be0:	b90037e0 	str	w0, [sp, #52]
    }
    
    i = 0;
     be4:	b9003fff 	str	wzr, [sp, #60]
    do{
        buf[i++] = digits[x % base];
     be8:	b94017e1 	ldr	w1, [sp, #20]
     bec:	b94037e0 	ldr	w0, [sp, #52]
     bf0:	1ac10802 	udiv	w2, w0, w1
     bf4:	1b017c41 	mul	w1, w2, w1
     bf8:	4b010003 	sub	w3, w0, w1
     bfc:	b9403fe0 	ldr	w0, [sp, #60]
     c00:	11000401 	add	w1, w0, #0x1
     c04:	b9003fe1 	str	w1, [sp, #60]
     c08:	b0000001 	adrp	x1, 1000 <free+0xf8>
     c0c:	910ae022 	add	x2, x1, #0x2b8
     c10:	2a0303e1 	mov	w1, w3
     c14:	38616842 	ldrb	w2, [x2, x1]
     c18:	93407c00 	sxtw	x0, w0
     c1c:	910083e1 	add	x1, sp, #0x20
     c20:	38206822 	strb	w2, [x1, x0]
    }while((x /= base) != 0);
     c24:	b94017e0 	ldr	w0, [sp, #20]
     c28:	b94037e1 	ldr	w1, [sp, #52]
     c2c:	1ac00820 	udiv	w0, w1, w0
     c30:	b90037e0 	str	w0, [sp, #52]
     c34:	b94037e0 	ldr	w0, [sp, #52]
     c38:	7100001f 	cmp	w0, #0x0
     c3c:	54fffd61 	b.ne	be8 <printint+0x58>  // b.any
    if(neg)
     c40:	b9403be0 	ldr	w0, [sp, #56]
     c44:	7100001f 	cmp	w0, #0x0
     c48:	540001e0 	b.eq	c84 <printint+0xf4>  // b.none
        buf[i++] = '-';
     c4c:	b9403fe0 	ldr	w0, [sp, #60]
     c50:	11000401 	add	w1, w0, #0x1
     c54:	b9003fe1 	str	w1, [sp, #60]
     c58:	93407c00 	sxtw	x0, w0
     c5c:	910083e1 	add	x1, sp, #0x20
     c60:	528005a2 	mov	w2, #0x2d                  	// #45
     c64:	38206822 	strb	w2, [x1, x0]
    
    while(--i >= 0)
     c68:	14000007 	b	c84 <printint+0xf4>
        putc(fd, buf[i]);
     c6c:	b9803fe0 	ldrsw	x0, [sp, #60]
     c70:	910083e1 	add	x1, sp, #0x20
     c74:	38606820 	ldrb	w0, [x1, x0]
     c78:	2a0003e1 	mov	w1, w0
     c7c:	b9401fe0 	ldr	w0, [sp, #28]
     c80:	97ffffb8 	bl	b60 <putc>
    while(--i >= 0)
     c84:	b9403fe0 	ldr	w0, [sp, #60]
     c88:	51000400 	sub	w0, w0, #0x1
     c8c:	b9003fe0 	str	w0, [sp, #60]
     c90:	b9403fe0 	ldr	w0, [sp, #60]
     c94:	7100001f 	cmp	w0, #0x0
     c98:	54fffeaa 	b.ge	c6c <printint+0xdc>  // b.tcont
}
     c9c:	d503201f 	nop
     ca0:	d503201f 	nop
     ca4:	a8c47bfd 	ldp	x29, x30, [sp], #64
     ca8:	d65f03c0 	ret

0000000000000cac <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     cac:	a9b17bfd 	stp	x29, x30, [sp, #-240]!
     cb0:	910003fd 	mov	x29, sp
     cb4:	b9001fe0 	str	w0, [sp, #28]
     cb8:	f9000be1 	str	x1, [sp, #16]
     cbc:	f90063e2 	str	x2, [sp, #192]
     cc0:	f90067e3 	str	x3, [sp, #200]
     cc4:	f9006be4 	str	x4, [sp, #208]
     cc8:	f9006fe5 	str	x5, [sp, #216]
     ccc:	f90073e6 	str	x6, [sp, #224]
     cd0:	f90077e7 	str	x7, [sp, #232]
     cd4:	3d8013e0 	str	q0, [sp, #64]
     cd8:	3d8017e1 	str	q1, [sp, #80]
     cdc:	3d801be2 	str	q2, [sp, #96]
     ce0:	3d801fe3 	str	q3, [sp, #112]
     ce4:	3d8023e4 	str	q4, [sp, #128]
     ce8:	3d8027e5 	str	q5, [sp, #144]
     cec:	3d802be6 	str	q6, [sp, #160]
     cf0:	3d802fe7 	str	q7, [sp, #176]
    char *s;
    int c, i, state;
    uint64 *ap;
    
    state = 0;
     cf4:	b90033ff 	str	wzr, [sp, #48]
    ap = (uint64*)(void*)&fmt + 22;
     cf8:	910043e0 	add	x0, sp, #0x10
     cfc:	9102c000 	add	x0, x0, #0xb0
     d00:	f90017e0 	str	x0, [sp, #40]
    for(i = 0; fmt[i]; i++){
     d04:	b90037ff 	str	wzr, [sp, #52]
     d08:	14000076 	b	ee0 <printf+0x234>
        c = fmt[i] & 0xff;
     d0c:	f9400be1 	ldr	x1, [sp, #16]
     d10:	b98037e0 	ldrsw	x0, [sp, #52]
     d14:	8b000020 	add	x0, x1, x0
     d18:	39400000 	ldrb	w0, [x0]
     d1c:	b90027e0 	str	w0, [sp, #36]
        if(state == 0){
     d20:	b94033e0 	ldr	w0, [sp, #48]
     d24:	7100001f 	cmp	w0, #0x0
     d28:	540001a1 	b.ne	d5c <printf+0xb0>  // b.any
            if(c == '%'){
     d2c:	b94027e0 	ldr	w0, [sp, #36]
     d30:	7100941f 	cmp	w0, #0x25
     d34:	54000081 	b.ne	d44 <printf+0x98>  // b.any
                state = '%';
     d38:	528004a0 	mov	w0, #0x25                  	// #37
     d3c:	b90033e0 	str	w0, [sp, #48]
     d40:	14000065 	b	ed4 <printf+0x228>
            } else {
                putc(fd, c);
     d44:	b94027e0 	ldr	w0, [sp, #36]
     d48:	12001c00 	and	w0, w0, #0xff
     d4c:	2a0003e1 	mov	w1, w0
     d50:	b9401fe0 	ldr	w0, [sp, #28]
     d54:	97ffff83 	bl	b60 <putc>
     d58:	1400005f 	b	ed4 <printf+0x228>
            }
        } else if(state == '%'){
     d5c:	b94033e0 	ldr	w0, [sp, #48]
     d60:	7100941f 	cmp	w0, #0x25
     d64:	54000b81 	b.ne	ed4 <printf+0x228>  // b.any
            if(c == 'd'){
     d68:	b94027e0 	ldr	w0, [sp, #36]
     d6c:	7101901f 	cmp	w0, #0x64
     d70:	54000181 	b.ne	da0 <printf+0xf4>  // b.any
                printint(fd, *ap, 10, 1);
     d74:	f94017e0 	ldr	x0, [sp, #40]
     d78:	f9400000 	ldr	x0, [x0]
     d7c:	52800023 	mov	w3, #0x1                   	// #1
     d80:	52800142 	mov	w2, #0xa                   	// #10
     d84:	2a0003e1 	mov	w1, w0
     d88:	b9401fe0 	ldr	w0, [sp, #28]
     d8c:	97ffff81 	bl	b90 <printint>
                ap++;
     d90:	f94017e0 	ldr	x0, [sp, #40]
     d94:	91002000 	add	x0, x0, #0x8
     d98:	f90017e0 	str	x0, [sp, #40]
     d9c:	1400004d 	b	ed0 <printf+0x224>
            } else if(c == 'x' || c == 'p'){
     da0:	b94027e0 	ldr	w0, [sp, #36]
     da4:	7101e01f 	cmp	w0, #0x78
     da8:	54000080 	b.eq	db8 <printf+0x10c>  // b.none
     dac:	b94027e0 	ldr	w0, [sp, #36]
     db0:	7101c01f 	cmp	w0, #0x70
     db4:	54000181 	b.ne	de4 <printf+0x138>  // b.any
                printint(fd, *ap, 16, 0);
     db8:	f94017e0 	ldr	x0, [sp, #40]
     dbc:	f9400000 	ldr	x0, [x0]
     dc0:	52800003 	mov	w3, #0x0                   	// #0
     dc4:	52800202 	mov	w2, #0x10                  	// #16
     dc8:	2a0003e1 	mov	w1, w0
     dcc:	b9401fe0 	ldr	w0, [sp, #28]
     dd0:	97ffff70 	bl	b90 <printint>
                ap++;
     dd4:	f94017e0 	ldr	x0, [sp, #40]
     dd8:	91002000 	add	x0, x0, #0x8
     ddc:	f90017e0 	str	x0, [sp, #40]
     de0:	1400003c 	b	ed0 <printf+0x224>
            } else if(c == 's'){
     de4:	b94027e0 	ldr	w0, [sp, #36]
     de8:	7101cc1f 	cmp	w0, #0x73
     dec:	54000361 	b.ne	e58 <printf+0x1ac>  // b.any
                s = (char*)*ap;
     df0:	f94017e0 	ldr	x0, [sp, #40]
     df4:	f9400000 	ldr	x0, [x0]
     df8:	f9001fe0 	str	x0, [sp, #56]
                ap++;
     dfc:	f94017e0 	ldr	x0, [sp, #40]
     e00:	91002000 	add	x0, x0, #0x8
     e04:	f90017e0 	str	x0, [sp, #40]
                if(s == 0)
     e08:	f9401fe0 	ldr	x0, [sp, #56]
     e0c:	f100001f 	cmp	x0, #0x0
     e10:	540001a1 	b.ne	e44 <printf+0x198>  // b.any
                    s = "(null)";
     e14:	b0000000 	adrp	x0, 1000 <free+0xf8>
     e18:	910ac000 	add	x0, x0, #0x2b0
     e1c:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
     e20:	14000009 	b	e44 <printf+0x198>
                    putc(fd, *s);
     e24:	f9401fe0 	ldr	x0, [sp, #56]
     e28:	39400000 	ldrb	w0, [x0]
     e2c:	2a0003e1 	mov	w1, w0
     e30:	b9401fe0 	ldr	w0, [sp, #28]
     e34:	97ffff4b 	bl	b60 <putc>
                    s++;
     e38:	f9401fe0 	ldr	x0, [sp, #56]
     e3c:	91000400 	add	x0, x0, #0x1
     e40:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
     e44:	f9401fe0 	ldr	x0, [sp, #56]
     e48:	39400000 	ldrb	w0, [x0]
     e4c:	7100001f 	cmp	w0, #0x0
     e50:	54fffea1 	b.ne	e24 <printf+0x178>  // b.any
     e54:	1400001f 	b	ed0 <printf+0x224>
                }
            } else if(c == 'c'){
     e58:	b94027e0 	ldr	w0, [sp, #36]
     e5c:	71018c1f 	cmp	w0, #0x63
     e60:	54000161 	b.ne	e8c <printf+0x1e0>  // b.any
                putc(fd, *ap);
     e64:	f94017e0 	ldr	x0, [sp, #40]
     e68:	f9400000 	ldr	x0, [x0]
     e6c:	12001c00 	and	w0, w0, #0xff
     e70:	2a0003e1 	mov	w1, w0
     e74:	b9401fe0 	ldr	w0, [sp, #28]
     e78:	97ffff3a 	bl	b60 <putc>
                ap++;
     e7c:	f94017e0 	ldr	x0, [sp, #40]
     e80:	91002000 	add	x0, x0, #0x8
     e84:	f90017e0 	str	x0, [sp, #40]
     e88:	14000012 	b	ed0 <printf+0x224>
            } else if(c == '%'){
     e8c:	b94027e0 	ldr	w0, [sp, #36]
     e90:	7100941f 	cmp	w0, #0x25
     e94:	540000e1 	b.ne	eb0 <printf+0x204>  // b.any
                putc(fd, c);
     e98:	b94027e0 	ldr	w0, [sp, #36]
     e9c:	12001c00 	and	w0, w0, #0xff
     ea0:	2a0003e1 	mov	w1, w0
     ea4:	b9401fe0 	ldr	w0, [sp, #28]
     ea8:	97ffff2e 	bl	b60 <putc>
     eac:	14000009 	b	ed0 <printf+0x224>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
     eb0:	528004a1 	mov	w1, #0x25                  	// #37
     eb4:	b9401fe0 	ldr	w0, [sp, #28]
     eb8:	97ffff2a 	bl	b60 <putc>
                putc(fd, c);
     ebc:	b94027e0 	ldr	w0, [sp, #36]
     ec0:	12001c00 	and	w0, w0, #0xff
     ec4:	2a0003e1 	mov	w1, w0
     ec8:	b9401fe0 	ldr	w0, [sp, #28]
     ecc:	97ffff25 	bl	b60 <putc>
            }
            state = 0;
     ed0:	b90033ff 	str	wzr, [sp, #48]
    for(i = 0; fmt[i]; i++){
     ed4:	b94037e0 	ldr	w0, [sp, #52]
     ed8:	11000400 	add	w0, w0, #0x1
     edc:	b90037e0 	str	w0, [sp, #52]
     ee0:	f9400be1 	ldr	x1, [sp, #16]
     ee4:	b98037e0 	ldrsw	x0, [sp, #52]
     ee8:	8b000020 	add	x0, x1, x0
     eec:	39400000 	ldrb	w0, [x0]
     ef0:	7100001f 	cmp	w0, #0x0
     ef4:	54fff0c1 	b.ne	d0c <printf+0x60>  // b.any
        }
    }
}
     ef8:	d503201f 	nop
     efc:	d503201f 	nop
     f00:	a8cf7bfd 	ldp	x29, x30, [sp], #240
     f04:	d65f03c0 	ret

0000000000000f08 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     f08:	d10083ff 	sub	sp, sp, #0x20
     f0c:	f90007e0 	str	x0, [sp, #8]
    Header *bp, *p;
    
    bp = (Header*)ap - 1;
     f10:	f94007e0 	ldr	x0, [sp, #8]
     f14:	d1004000 	sub	x0, x0, #0x10
     f18:	f9000be0 	str	x0, [sp, #16]
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f1c:	b0000000 	adrp	x0, 1000 <free+0xf8>
     f20:	911b8000 	add	x0, x0, #0x6e0
     f24:	f9400000 	ldr	x0, [x0]
     f28:	f9000fe0 	str	x0, [sp, #24]
     f2c:	14000012 	b	f74 <free+0x6c>
        if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     f30:	f9400fe0 	ldr	x0, [sp, #24]
     f34:	f9400000 	ldr	x0, [x0]
     f38:	f9400fe1 	ldr	x1, [sp, #24]
     f3c:	eb00003f 	cmp	x1, x0
     f40:	54000143 	b.cc	f68 <free+0x60>  // b.lo, b.ul, b.last
     f44:	f9400be1 	ldr	x1, [sp, #16]
     f48:	f9400fe0 	ldr	x0, [sp, #24]
     f4c:	eb00003f 	cmp	x1, x0
     f50:	54000248 	b.hi	f98 <free+0x90>  // b.pmore
     f54:	f9400fe0 	ldr	x0, [sp, #24]
     f58:	f9400000 	ldr	x0, [x0]
     f5c:	f9400be1 	ldr	x1, [sp, #16]
     f60:	eb00003f 	cmp	x1, x0
     f64:	540001a3 	b.cc	f98 <free+0x90>  // b.lo, b.ul, b.last
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     f68:	f9400fe0 	ldr	x0, [sp, #24]
     f6c:	f9400000 	ldr	x0, [x0]
     f70:	f9000fe0 	str	x0, [sp, #24]
     f74:	f9400be1 	ldr	x1, [sp, #16]
     f78:	f9400fe0 	ldr	x0, [sp, #24]
     f7c:	eb00003f 	cmp	x1, x0
     f80:	54fffd89 	b.ls	f30 <free+0x28>  // b.plast
     f84:	f9400fe0 	ldr	x0, [sp, #24]
     f88:	f9400000 	ldr	x0, [x0]
     f8c:	f9400be1 	ldr	x1, [sp, #16]
     f90:	eb00003f 	cmp	x1, x0
     f94:	54fffce2 	b.cs	f30 <free+0x28>  // b.hs, b.nlast
            break;
    if(bp + bp->s.size == p->s.ptr){
     f98:	f9400be0 	ldr	x0, [sp, #16]
     f9c:	b9400800 	ldr	w0, [x0, #8]
     fa0:	2a0003e0 	mov	w0, w0
     fa4:	d37cec00 	lsl	x0, x0, #4
     fa8:	f9400be1 	ldr	x1, [sp, #16]
     fac:	8b000021 	add	x1, x1, x0
     fb0:	f9400fe0 	ldr	x0, [sp, #24]
     fb4:	f9400000 	ldr	x0, [x0]
     fb8:	eb00003f 	cmp	x1, x0
     fbc:	540001e1 	b.ne	ff8 <free+0xf0>  // b.any
        bp->s.size += p->s.ptr->s.size;
     fc0:	f9400be0 	ldr	x0, [sp, #16]
     fc4:	b9400801 	ldr	w1, [x0, #8]
     fc8:	f9400fe0 	ldr	x0, [sp, #24]
     fcc:	f9400000 	ldr	x0, [x0]
     fd0:	b9400800 	ldr	w0, [x0, #8]
     fd4:	0b000021 	add	w1, w1, w0
     fd8:	f9400be0 	ldr	x0, [sp, #16]
     fdc:	b9000801 	str	w1, [x0, #8]
        bp->s.ptr = p->s.ptr->s.ptr;
     fe0:	f9400fe0 	ldr	x0, [sp, #24]
     fe4:	f9400000 	ldr	x0, [x0]
     fe8:	f9400001 	ldr	x1, [x0]
     fec:	f9400be0 	ldr	x0, [sp, #16]
     ff0:	f9000001 	str	x1, [x0]
     ff4:	14000005 	b	1008 <free+0x100>
    } else
        bp->s.ptr = p->s.ptr;
     ff8:	f9400fe0 	ldr	x0, [sp, #24]
     ffc:	f9400001 	ldr	x1, [x0]
    1000:	f9400be0 	ldr	x0, [sp, #16]
    1004:	f9000001 	str	x1, [x0]
    if(p + p->s.size == bp){
    1008:	f9400fe0 	ldr	x0, [sp, #24]
    100c:	b9400800 	ldr	w0, [x0, #8]
    1010:	2a0003e0 	mov	w0, w0
    1014:	d37cec00 	lsl	x0, x0, #4
    1018:	f9400fe1 	ldr	x1, [sp, #24]
    101c:	8b000020 	add	x0, x1, x0
    1020:	f9400be1 	ldr	x1, [sp, #16]
    1024:	eb00003f 	cmp	x1, x0
    1028:	540001a1 	b.ne	105c <free+0x154>  // b.any
        p->s.size += bp->s.size;
    102c:	f9400fe0 	ldr	x0, [sp, #24]
    1030:	b9400801 	ldr	w1, [x0, #8]
    1034:	f9400be0 	ldr	x0, [sp, #16]
    1038:	b9400800 	ldr	w0, [x0, #8]
    103c:	0b000021 	add	w1, w1, w0
    1040:	f9400fe0 	ldr	x0, [sp, #24]
    1044:	b9000801 	str	w1, [x0, #8]
        p->s.ptr = bp->s.ptr;
    1048:	f9400be0 	ldr	x0, [sp, #16]
    104c:	f9400001 	ldr	x1, [x0]
    1050:	f9400fe0 	ldr	x0, [sp, #24]
    1054:	f9000001 	str	x1, [x0]
    1058:	14000004 	b	1068 <free+0x160>
    } else
        p->s.ptr = bp;
    105c:	f9400fe0 	ldr	x0, [sp, #24]
    1060:	f9400be1 	ldr	x1, [sp, #16]
    1064:	f9000001 	str	x1, [x0]
    freep = p;
    1068:	90000000 	adrp	x0, 1000 <free+0xf8>
    106c:	911b8000 	add	x0, x0, #0x6e0
    1070:	f9400fe1 	ldr	x1, [sp, #24]
    1074:	f9000001 	str	x1, [x0]
}
    1078:	d503201f 	nop
    107c:	910083ff 	add	sp, sp, #0x20
    1080:	d65f03c0 	ret

0000000000001084 <morecore>:

static Header*
morecore(uint nu)
{
    1084:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
    1088:	910003fd 	mov	x29, sp
    108c:	b9001fe0 	str	w0, [sp, #28]
    char *p;
    Header *hp;
    
    if(nu < 4096)
    1090:	b9401fe0 	ldr	w0, [sp, #28]
    1094:	713ffc1f 	cmp	w0, #0xfff
    1098:	54000068 	b.hi	10a4 <morecore+0x20>  // b.pmore
        nu = 4096;
    109c:	52820000 	mov	w0, #0x1000                	// #4096
    10a0:	b9001fe0 	str	w0, [sp, #28]
    p = sbrk(nu * sizeof(Header));
    10a4:	b9401fe0 	ldr	w0, [sp, #28]
    10a8:	531c6c00 	lsl	w0, w0, #4
    10ac:	97fffe92 	bl	af4 <sbrk>
    10b0:	f90017e0 	str	x0, [sp, #40]
    if(p == (char*)-1)
    10b4:	f94017e0 	ldr	x0, [sp, #40]
    10b8:	b100041f 	cmn	x0, #0x1
    10bc:	54000061 	b.ne	10c8 <morecore+0x44>  // b.any
        return 0;
    10c0:	d2800000 	mov	x0, #0x0                   	// #0
    10c4:	1400000c 	b	10f4 <morecore+0x70>
    hp = (Header*)p;
    10c8:	f94017e0 	ldr	x0, [sp, #40]
    10cc:	f90013e0 	str	x0, [sp, #32]
    hp->s.size = nu;
    10d0:	f94013e0 	ldr	x0, [sp, #32]
    10d4:	b9401fe1 	ldr	w1, [sp, #28]
    10d8:	b9000801 	str	w1, [x0, #8]
    free((void*)(hp + 1));
    10dc:	f94013e0 	ldr	x0, [sp, #32]
    10e0:	91004000 	add	x0, x0, #0x10
    10e4:	97ffff89 	bl	f08 <free>
    return freep;
    10e8:	90000000 	adrp	x0, 1000 <free+0xf8>
    10ec:	911b8000 	add	x0, x0, #0x6e0
    10f0:	f9400000 	ldr	x0, [x0]
}
    10f4:	a8c37bfd 	ldp	x29, x30, [sp], #48
    10f8:	d65f03c0 	ret

00000000000010fc <malloc>:

void*
malloc(uint nbytes)
{
    10fc:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
    1100:	910003fd 	mov	x29, sp
    1104:	b9001fe0 	str	w0, [sp, #28]
    Header *p, *prevp;
    uint nunits;
    
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1108:	b9401fe0 	ldr	w0, [sp, #28]
    110c:	91003c00 	add	x0, x0, #0xf
    1110:	d344fc00 	lsr	x0, x0, #4
    1114:	11000400 	add	w0, w0, #0x1
    1118:	b9002fe0 	str	w0, [sp, #44]
    if((prevp = freep) == 0){
    111c:	90000000 	adrp	x0, 1000 <free+0xf8>
    1120:	911b8000 	add	x0, x0, #0x6e0
    1124:	f9400000 	ldr	x0, [x0]
    1128:	f9001be0 	str	x0, [sp, #48]
    112c:	f9401be0 	ldr	x0, [sp, #48]
    1130:	f100001f 	cmp	x0, #0x0
    1134:	54000221 	b.ne	1178 <malloc+0x7c>  // b.any
        base.s.ptr = freep = prevp = &base;
    1138:	90000000 	adrp	x0, 1000 <free+0xf8>
    113c:	911b4000 	add	x0, x0, #0x6d0
    1140:	f9001be0 	str	x0, [sp, #48]
    1144:	90000000 	adrp	x0, 1000 <free+0xf8>
    1148:	911b8000 	add	x0, x0, #0x6e0
    114c:	f9401be1 	ldr	x1, [sp, #48]
    1150:	f9000001 	str	x1, [x0]
    1154:	90000000 	adrp	x0, 1000 <free+0xf8>
    1158:	911b8000 	add	x0, x0, #0x6e0
    115c:	f9400001 	ldr	x1, [x0]
    1160:	90000000 	adrp	x0, 1000 <free+0xf8>
    1164:	911b4000 	add	x0, x0, #0x6d0
    1168:	f9000001 	str	x1, [x0]
        base.s.size = 0;
    116c:	90000000 	adrp	x0, 1000 <free+0xf8>
    1170:	911b4000 	add	x0, x0, #0x6d0
    1174:	b900081f 	str	wzr, [x0, #8]
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1178:	f9401be0 	ldr	x0, [sp, #48]
    117c:	f9400000 	ldr	x0, [x0]
    1180:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
    1184:	f9401fe0 	ldr	x0, [sp, #56]
    1188:	b9400800 	ldr	w0, [x0, #8]
    118c:	b9402fe1 	ldr	w1, [sp, #44]
    1190:	6b00003f 	cmp	w1, w0
    1194:	54000448 	b.hi	121c <malloc+0x120>  // b.pmore
            if(p->s.size == nunits)
    1198:	f9401fe0 	ldr	x0, [sp, #56]
    119c:	b9400800 	ldr	w0, [x0, #8]
    11a0:	b9402fe1 	ldr	w1, [sp, #44]
    11a4:	6b00003f 	cmp	w1, w0
    11a8:	540000c1 	b.ne	11c0 <malloc+0xc4>  // b.any
                prevp->s.ptr = p->s.ptr;
    11ac:	f9401fe0 	ldr	x0, [sp, #56]
    11b0:	f9400001 	ldr	x1, [x0]
    11b4:	f9401be0 	ldr	x0, [sp, #48]
    11b8:	f9000001 	str	x1, [x0]
    11bc:	14000011 	b	1200 <malloc+0x104>
            else {
                p->s.size -= nunits;
    11c0:	f9401fe0 	ldr	x0, [sp, #56]
    11c4:	b9400801 	ldr	w1, [x0, #8]
    11c8:	b9402fe0 	ldr	w0, [sp, #44]
    11cc:	4b000021 	sub	w1, w1, w0
    11d0:	f9401fe0 	ldr	x0, [sp, #56]
    11d4:	b9000801 	str	w1, [x0, #8]
                p += p->s.size;
    11d8:	f9401fe0 	ldr	x0, [sp, #56]
    11dc:	b9400800 	ldr	w0, [x0, #8]
    11e0:	2a0003e0 	mov	w0, w0
    11e4:	d37cec00 	lsl	x0, x0, #4
    11e8:	f9401fe1 	ldr	x1, [sp, #56]
    11ec:	8b000020 	add	x0, x1, x0
    11f0:	f9001fe0 	str	x0, [sp, #56]
                p->s.size = nunits;
    11f4:	f9401fe0 	ldr	x0, [sp, #56]
    11f8:	b9402fe1 	ldr	w1, [sp, #44]
    11fc:	b9000801 	str	w1, [x0, #8]
            }
            freep = prevp;
    1200:	90000000 	adrp	x0, 1000 <free+0xf8>
    1204:	911b8000 	add	x0, x0, #0x6e0
    1208:	f9401be1 	ldr	x1, [sp, #48]
    120c:	f9000001 	str	x1, [x0]
            return (void*)(p + 1);
    1210:	f9401fe0 	ldr	x0, [sp, #56]
    1214:	91004000 	add	x0, x0, #0x10
    1218:	14000015 	b	126c <malloc+0x170>
        }
        if(p == freep)
    121c:	90000000 	adrp	x0, 1000 <free+0xf8>
    1220:	911b8000 	add	x0, x0, #0x6e0
    1224:	f9400000 	ldr	x0, [x0]
    1228:	f9401fe1 	ldr	x1, [sp, #56]
    122c:	eb00003f 	cmp	x1, x0
    1230:	54000121 	b.ne	1254 <malloc+0x158>  // b.any
            if((p = morecore(nunits)) == 0)
    1234:	b9402fe0 	ldr	w0, [sp, #44]
    1238:	97ffff93 	bl	1084 <morecore>
    123c:	f9001fe0 	str	x0, [sp, #56]
    1240:	f9401fe0 	ldr	x0, [sp, #56]
    1244:	f100001f 	cmp	x0, #0x0
    1248:	54000061 	b.ne	1254 <malloc+0x158>  // b.any
                return 0;
    124c:	d2800000 	mov	x0, #0x0                   	// #0
    1250:	14000007 	b	126c <malloc+0x170>
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1254:	f9401fe0 	ldr	x0, [sp, #56]
    1258:	f9001be0 	str	x0, [sp, #48]
    125c:	f9401fe0 	ldr	x0, [sp, #56]
    1260:	f9400000 	ldr	x0, [x0]
    1264:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
    1268:	17ffffc7 	b	1184 <malloc+0x88>
    }
}
    126c:	a8c47bfd 	ldp	x29, x30, [sp], #64
    1270:	d65f03c0 	ret
