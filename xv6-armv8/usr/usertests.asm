
_usertests:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <opentest>:

// simple file system tests

void
opentest(void)
{
       0:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
       4:	910003fd 	mov	x29, sp
    int fd;
    
    printf(stdout, "open test\n");
       8:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
       c:	9121e000 	add	x0, x0, #0x878
      10:	b9400002 	ldr	w2, [x0]
      14:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
      18:	9137c001 	add	x1, x0, #0xdf0
      1c:	2a0203e0 	mov	w0, w2
      20:	940011fa 	bl	4808 <printf>
    fd = open("echo", 0);
      24:	52800001 	mov	w1, #0x0                   	// #0
      28:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
      2c:	91374000 	add	x0, x0, #0xdd0
      30:	94001137 	bl	450c <open>
      34:	b9001fe0 	str	w0, [sp, #28]
    if(fd < 0){
      38:	b9401fe0 	ldr	w0, [sp, #28]
      3c:	7100001f 	cmp	w0, #0x0
      40:	5400012a 	b.ge	64 <opentest+0x64>  // b.tcont
        printf(stdout, "open echo failed!\n");
      44:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
      48:	9121e000 	add	x0, x0, #0x878
      4c:	b9400002 	ldr	w2, [x0]
      50:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
      54:	91380001 	add	x1, x0, #0xe00
      58:	2a0203e0 	mov	w0, w2
      5c:	940011eb 	bl	4808 <printf>
        exit();
      60:	940010e3 	bl	43ec <exit>
    }
    close(fd);
      64:	b9401fe0 	ldr	w0, [sp, #28]
      68:	9400110e 	bl	44a0 <close>
    fd = open("doesnotexist", 0);
      6c:	52800001 	mov	w1, #0x0                   	// #0
      70:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
      74:	91386000 	add	x0, x0, #0xe18
      78:	94001125 	bl	450c <open>
      7c:	b9001fe0 	str	w0, [sp, #28]
    if(fd >= 0){
      80:	b9401fe0 	ldr	w0, [sp, #28]
      84:	7100001f 	cmp	w0, #0x0
      88:	5400012b 	b.lt	ac <opentest+0xac>  // b.tstop
        printf(stdout, "open doesnotexist succeeded!\n");
      8c:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
      90:	9121e000 	add	x0, x0, #0x878
      94:	b9400002 	ldr	w2, [x0]
      98:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
      9c:	9138a001 	add	x1, x0, #0xe28
      a0:	2a0203e0 	mov	w0, w2
      a4:	940011d9 	bl	4808 <printf>
        exit();
      a8:	940010d1 	bl	43ec <exit>
    }
    printf(stdout, "open test ok\n");
      ac:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
      b0:	9121e000 	add	x0, x0, #0x878
      b4:	b9400002 	ldr	w2, [x0]
      b8:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
      bc:	91392001 	add	x1, x0, #0xe48
      c0:	2a0203e0 	mov	w0, w2
      c4:	940011d1 	bl	4808 <printf>
}
      c8:	d503201f 	nop
      cc:	a8c27bfd 	ldp	x29, x30, [sp], #32
      d0:	d65f03c0 	ret

00000000000000d4 <writetest>:

void
writetest(void)
{
      d4:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
      d8:	910003fd 	mov	x29, sp
    int fd;
    int i;
    
    printf(stdout, "small file test\n");
      dc:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
      e0:	9121e000 	add	x0, x0, #0x878
      e4:	b9400002 	ldr	w2, [x0]
      e8:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
      ec:	91396001 	add	x1, x0, #0xe58
      f0:	2a0203e0 	mov	w0, w2
      f4:	940011c5 	bl	4808 <printf>
    fd = open("small", O_CREATE|O_RDWR);
      f8:	52804041 	mov	w1, #0x202                 	// #514
      fc:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     100:	9139c000 	add	x0, x0, #0xe70
     104:	94001102 	bl	450c <open>
     108:	b9001be0 	str	w0, [sp, #24]
    if(fd >= 0){
     10c:	b9401be0 	ldr	w0, [sp, #24]
     110:	7100001f 	cmp	w0, #0x0
     114:	5400014b 	b.lt	13c <writetest+0x68>  // b.tstop
        printf(stdout, "creat small succeeded; ok\n");
     118:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     11c:	9121e000 	add	x0, x0, #0x878
     120:	b9400002 	ldr	w2, [x0]
     124:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     128:	9139e001 	add	x1, x0, #0xe78
     12c:	2a0203e0 	mov	w0, w2
     130:	940011b6 	bl	4808 <printf>
    } else {
        printf(stdout, "error: creat small failed!\n");
        exit();
    }
    for(i = 0; i < 100; i++){
     134:	b9001fff 	str	wzr, [sp, #28]
     138:	1400002c 	b	1e8 <writetest+0x114>
        printf(stdout, "error: creat small failed!\n");
     13c:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     140:	9121e000 	add	x0, x0, #0x878
     144:	b9400002 	ldr	w2, [x0]
     148:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     14c:	913a6001 	add	x1, x0, #0xe98
     150:	2a0203e0 	mov	w0, w2
     154:	940011ad 	bl	4808 <printf>
        exit();
     158:	940010a5 	bl	43ec <exit>
        if(write(fd, "aaaaaaaaaa", 10) != 10){
     15c:	52800142 	mov	w2, #0xa                   	// #10
     160:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     164:	913ae001 	add	x1, x0, #0xeb8
     168:	b9401be0 	ldr	w0, [sp, #24]
     16c:	940010c4 	bl	447c <write>
     170:	7100281f 	cmp	w0, #0xa
     174:	54000140 	b.eq	19c <writetest+0xc8>  // b.none
            printf(stdout, "error: write aa %d new file failed\n", i);
     178:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     17c:	9121e000 	add	x0, x0, #0x878
     180:	b9400003 	ldr	w3, [x0]
     184:	b9401fe2 	ldr	w2, [sp, #28]
     188:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     18c:	913b2001 	add	x1, x0, #0xec8
     190:	2a0303e0 	mov	w0, w3
     194:	9400119d 	bl	4808 <printf>
            exit();
     198:	94001095 	bl	43ec <exit>
        }
        if(write(fd, "bbbbbbbbbb", 10) != 10){
     19c:	52800142 	mov	w2, #0xa                   	// #10
     1a0:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     1a4:	913bc001 	add	x1, x0, #0xef0
     1a8:	b9401be0 	ldr	w0, [sp, #24]
     1ac:	940010b4 	bl	447c <write>
     1b0:	7100281f 	cmp	w0, #0xa
     1b4:	54000140 	b.eq	1dc <writetest+0x108>  // b.none
            printf(stdout, "error: write bb %d new file failed\n", i);
     1b8:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     1bc:	9121e000 	add	x0, x0, #0x878
     1c0:	b9400003 	ldr	w3, [x0]
     1c4:	b9401fe2 	ldr	w2, [sp, #28]
     1c8:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     1cc:	913c0001 	add	x1, x0, #0xf00
     1d0:	2a0303e0 	mov	w0, w3
     1d4:	9400118d 	bl	4808 <printf>
            exit();
     1d8:	94001085 	bl	43ec <exit>
    for(i = 0; i < 100; i++){
     1dc:	b9401fe0 	ldr	w0, [sp, #28]
     1e0:	11000400 	add	w0, w0, #0x1
     1e4:	b9001fe0 	str	w0, [sp, #28]
     1e8:	b9401fe0 	ldr	w0, [sp, #28]
     1ec:	71018c1f 	cmp	w0, #0x63
     1f0:	54fffb6d 	b.le	15c <writetest+0x88>
        }
    }
    printf(stdout, "writes ok\n");
     1f4:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     1f8:	9121e000 	add	x0, x0, #0x878
     1fc:	b9400002 	ldr	w2, [x0]
     200:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     204:	913ca001 	add	x1, x0, #0xf28
     208:	2a0203e0 	mov	w0, w2
     20c:	9400117f 	bl	4808 <printf>
    close(fd);
     210:	b9401be0 	ldr	w0, [sp, #24]
     214:	940010a3 	bl	44a0 <close>
    fd = open("small", O_RDONLY);
     218:	52800001 	mov	w1, #0x0                   	// #0
     21c:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     220:	9139c000 	add	x0, x0, #0xe70
     224:	940010ba 	bl	450c <open>
     228:	b9001be0 	str	w0, [sp, #24]
    if(fd >= 0){
     22c:	b9401be0 	ldr	w0, [sp, #24]
     230:	7100001f 	cmp	w0, #0x0
     234:	5400024b 	b.lt	27c <writetest+0x1a8>  // b.tstop
        printf(stdout, "open small succeeded ok\n");
     238:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     23c:	9121e000 	add	x0, x0, #0x878
     240:	b9400002 	ldr	w2, [x0]
     244:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     248:	913ce001 	add	x1, x0, #0xf38
     24c:	2a0203e0 	mov	w0, w2
     250:	9400116e 	bl	4808 <printf>
    } else {
        printf(stdout, "error: open small failed!\n");
        exit();
    }
    i = read(fd, buf, 2000);
     254:	5280fa02 	mov	w2, #0x7d0                 	// #2000
     258:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     25c:	91228001 	add	x1, x0, #0x8a0
     260:	b9401be0 	ldr	w0, [sp, #24]
     264:	9400107d 	bl	4458 <read>
     268:	b9001fe0 	str	w0, [sp, #28]
    if(i == 2000){
     26c:	b9401fe0 	ldr	w0, [sp, #28]
     270:	711f401f 	cmp	w0, #0x7d0
     274:	54000140 	b.eq	29c <writetest+0x1c8>  // b.none
     278:	14000018 	b	2d8 <writetest+0x204>
        printf(stdout, "error: open small failed!\n");
     27c:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     280:	9121e000 	add	x0, x0, #0x878
     284:	b9400002 	ldr	w2, [x0]
     288:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     28c:	913d6001 	add	x1, x0, #0xf58
     290:	2a0203e0 	mov	w0, w2
     294:	9400115d 	bl	4808 <printf>
        exit();
     298:	94001055 	bl	43ec <exit>
        printf(stdout, "read succeeded ok\n");
     29c:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     2a0:	9121e000 	add	x0, x0, #0x878
     2a4:	b9400002 	ldr	w2, [x0]
     2a8:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     2ac:	913de001 	add	x1, x0, #0xf78
     2b0:	2a0203e0 	mov	w0, w2
     2b4:	94001155 	bl	4808 <printf>
    } else {
        printf(stdout, "read failed\n");
        exit();
    }
    close(fd);
     2b8:	b9401be0 	ldr	w0, [sp, #24]
     2bc:	94001079 	bl	44a0 <close>
    
    if(unlink("small") < 0){
     2c0:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     2c4:	9139c000 	add	x0, x0, #0xe70
     2c8:	940010a3 	bl	4554 <unlink>
     2cc:	7100001f 	cmp	w0, #0x0
     2d0:	5400014b 	b.lt	2f8 <writetest+0x224>  // b.tstop
     2d4:	14000011 	b	318 <writetest+0x244>
        printf(stdout, "read failed\n");
     2d8:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     2dc:	9121e000 	add	x0, x0, #0x878
     2e0:	b9400002 	ldr	w2, [x0]
     2e4:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     2e8:	913e4001 	add	x1, x0, #0xf90
     2ec:	2a0203e0 	mov	w0, w2
     2f0:	94001146 	bl	4808 <printf>
        exit();
     2f4:	9400103e 	bl	43ec <exit>
        printf(stdout, "unlink small failed\n");
     2f8:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     2fc:	9121e000 	add	x0, x0, #0x878
     300:	b9400002 	ldr	w2, [x0]
     304:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     308:	913e8001 	add	x1, x0, #0xfa0
     30c:	2a0203e0 	mov	w0, w2
     310:	9400113e 	bl	4808 <printf>
        exit();
     314:	94001036 	bl	43ec <exit>
    }
    printf(stdout, "small file test ok\n");
     318:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     31c:	9121e000 	add	x0, x0, #0x878
     320:	b9400002 	ldr	w2, [x0]
     324:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     328:	913ee001 	add	x1, x0, #0xfb8
     32c:	2a0203e0 	mov	w0, w2
     330:	94001136 	bl	4808 <printf>
}
     334:	d503201f 	nop
     338:	a8c27bfd 	ldp	x29, x30, [sp], #32
     33c:	d65f03c0 	ret

0000000000000340 <writetest1>:

void
writetest1(void)
{
     340:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
     344:	910003fd 	mov	x29, sp
    int i, fd, n;
    
    printf(stdout, "big files test\n");
     348:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     34c:	9121e000 	add	x0, x0, #0x878
     350:	b9400002 	ldr	w2, [x0]
     354:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     358:	913f4001 	add	x1, x0, #0xfd0
     35c:	2a0203e0 	mov	w0, w2
     360:	9400112a 	bl	4808 <printf>
    
    fd = open("big", O_CREATE|O_RDWR);
     364:	52804041 	mov	w1, #0x202                 	// #514
     368:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     36c:	913f8000 	add	x0, x0, #0xfe0
     370:	94001067 	bl	450c <open>
     374:	b90017e0 	str	w0, [sp, #20]
    if(fd < 0){
     378:	b94017e0 	ldr	w0, [sp, #20]
     37c:	7100001f 	cmp	w0, #0x0
     380:	5400012a 	b.ge	3a4 <writetest1+0x64>  // b.tcont
        printf(stdout, "error: creat big failed!\n");
     384:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     388:	9121e000 	add	x0, x0, #0x878
     38c:	b9400002 	ldr	w2, [x0]
     390:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     394:	913fa001 	add	x1, x0, #0xfe8
     398:	2a0203e0 	mov	w0, w2
     39c:	9400111b 	bl	4808 <printf>
        exit();
     3a0:	94001013 	bl	43ec <exit>
    }
    
    for(i = 0; i < MAXFILE; i++){
     3a4:	b9001fff 	str	wzr, [sp, #28]
     3a8:	14000018 	b	408 <writetest1+0xc8>
        ((int*)buf)[0] = i;
     3ac:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     3b0:	91228000 	add	x0, x0, #0x8a0
     3b4:	b9401fe1 	ldr	w1, [sp, #28]
     3b8:	b9000001 	str	w1, [x0]
        if(write(fd, buf, 512) != 512){
     3bc:	52804002 	mov	w2, #0x200                 	// #512
     3c0:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     3c4:	91228001 	add	x1, x0, #0x8a0
     3c8:	b94017e0 	ldr	w0, [sp, #20]
     3cc:	9400102c 	bl	447c <write>
     3d0:	7108001f 	cmp	w0, #0x200
     3d4:	54000140 	b.eq	3fc <writetest1+0xbc>  // b.none
            printf(stdout, "error: write big file failed\n", i);
     3d8:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     3dc:	9121e000 	add	x0, x0, #0x878
     3e0:	b9400003 	ldr	w3, [x0]
     3e4:	b9401fe2 	ldr	w2, [sp, #28]
     3e8:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     3ec:	91002001 	add	x1, x0, #0x8
     3f0:	2a0303e0 	mov	w0, w3
     3f4:	94001105 	bl	4808 <printf>
            exit();
     3f8:	94000ffd 	bl	43ec <exit>
    for(i = 0; i < MAXFILE; i++){
     3fc:	b9401fe0 	ldr	w0, [sp, #28]
     400:	11000400 	add	w0, w0, #0x1
     404:	b9001fe0 	str	w0, [sp, #28]
     408:	b9401fe0 	ldr	w0, [sp, #28]
     40c:	71022c1f 	cmp	w0, #0x8b
     410:	54fffce9 	b.ls	3ac <writetest1+0x6c>  // b.plast
        }
    }
    
    close(fd);
     414:	b94017e0 	ldr	w0, [sp, #20]
     418:	94001022 	bl	44a0 <close>
    
    fd = open("big", O_RDONLY);
     41c:	52800001 	mov	w1, #0x0                   	// #0
     420:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     424:	913f8000 	add	x0, x0, #0xfe0
     428:	94001039 	bl	450c <open>
     42c:	b90017e0 	str	w0, [sp, #20]
    if(fd < 0){
     430:	b94017e0 	ldr	w0, [sp, #20]
     434:	7100001f 	cmp	w0, #0x0
     438:	5400012a 	b.ge	45c <writetest1+0x11c>  // b.tcont
        printf(stdout, "error: open big failed!\n");
     43c:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     440:	9121e000 	add	x0, x0, #0x878
     444:	b9400002 	ldr	w2, [x0]
     448:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     44c:	9100a001 	add	x1, x0, #0x28
     450:	2a0203e0 	mov	w0, w2
     454:	940010ed 	bl	4808 <printf>
        exit();
     458:	94000fe5 	bl	43ec <exit>
    }
    
    n = 0;
     45c:	b9001bff 	str	wzr, [sp, #24]
    for(;;){
        i = read(fd, buf, 512);
     460:	52804002 	mov	w2, #0x200                 	// #512
     464:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     468:	91228001 	add	x1, x0, #0x8a0
     46c:	b94017e0 	ldr	w0, [sp, #20]
     470:	94000ffa 	bl	4458 <read>
     474:	b9001fe0 	str	w0, [sp, #28]
        if(i == 0){
     478:	b9401fe0 	ldr	w0, [sp, #28]
     47c:	7100001f 	cmp	w0, #0x0
     480:	540001a1 	b.ne	4b4 <writetest1+0x174>  // b.any
            if(n == MAXFILE - 1){
     484:	b9401be0 	ldr	w0, [sp, #24]
     488:	71022c1f 	cmp	w0, #0x8b
     48c:	540005a1 	b.ne	540 <writetest1+0x200>  // b.any
                printf(stdout, "read only %d blocks from big", n);
     490:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     494:	9121e000 	add	x0, x0, #0x878
     498:	b9400003 	ldr	w3, [x0]
     49c:	b9401be2 	ldr	w2, [sp, #24]
     4a0:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     4a4:	91012001 	add	x1, x0, #0x48
     4a8:	2a0303e0 	mov	w0, w3
     4ac:	940010d7 	bl	4808 <printf>
                exit();
     4b0:	94000fcf 	bl	43ec <exit>
            }
            break;
        } else if(i != 512){
     4b4:	b9401fe0 	ldr	w0, [sp, #28]
     4b8:	7108001f 	cmp	w0, #0x200
     4bc:	54000140 	b.eq	4e4 <writetest1+0x1a4>  // b.none
            printf(stdout, "read failed %d\n", i);
     4c0:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     4c4:	9121e000 	add	x0, x0, #0x878
     4c8:	b9400003 	ldr	w3, [x0]
     4cc:	b9401fe2 	ldr	w2, [sp, #28]
     4d0:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     4d4:	9101a001 	add	x1, x0, #0x68
     4d8:	2a0303e0 	mov	w0, w3
     4dc:	940010cb 	bl	4808 <printf>
            exit();
     4e0:	94000fc3 	bl	43ec <exit>
        }
        if(((int*)buf)[0] != n){
     4e4:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     4e8:	91228000 	add	x0, x0, #0x8a0
     4ec:	b9400000 	ldr	w0, [x0]
     4f0:	b9401be1 	ldr	w1, [sp, #24]
     4f4:	6b00003f 	cmp	w1, w0
     4f8:	540001c0 	b.eq	530 <writetest1+0x1f0>  // b.none
            printf(stdout, "read content of block %d is %d\n",
     4fc:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     500:	9121e000 	add	x0, x0, #0x878
     504:	b9400004 	ldr	w4, [x0]
                   n, ((int*)buf)[0]);
     508:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     50c:	91228000 	add	x0, x0, #0x8a0
            printf(stdout, "read content of block %d is %d\n",
     510:	b9400000 	ldr	w0, [x0]
     514:	2a0003e3 	mov	w3, w0
     518:	b9401be2 	ldr	w2, [sp, #24]
     51c:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     520:	9101e001 	add	x1, x0, #0x78
     524:	2a0403e0 	mov	w0, w4
     528:	940010b8 	bl	4808 <printf>
            exit();
     52c:	94000fb0 	bl	43ec <exit>
        }
        n++;
     530:	b9401be0 	ldr	w0, [sp, #24]
     534:	11000400 	add	w0, w0, #0x1
     538:	b9001be0 	str	w0, [sp, #24]
        i = read(fd, buf, 512);
     53c:	17ffffc9 	b	460 <writetest1+0x120>
            break;
     540:	d503201f 	nop
    }
    close(fd);
     544:	b94017e0 	ldr	w0, [sp, #20]
     548:	94000fd6 	bl	44a0 <close>
    if(unlink("big") < 0){
     54c:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     550:	913f8000 	add	x0, x0, #0xfe0
     554:	94001000 	bl	4554 <unlink>
     558:	7100001f 	cmp	w0, #0x0
     55c:	5400012a 	b.ge	580 <writetest1+0x240>  // b.tcont
        printf(stdout, "unlink big failed\n");
     560:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     564:	9121e000 	add	x0, x0, #0x878
     568:	b9400002 	ldr	w2, [x0]
     56c:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     570:	91026001 	add	x1, x0, #0x98
     574:	2a0203e0 	mov	w0, w2
     578:	940010a4 	bl	4808 <printf>
        exit();
     57c:	94000f9c 	bl	43ec <exit>
    }
    printf(stdout, "big files ok\n");
     580:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     584:	9121e000 	add	x0, x0, #0x878
     588:	b9400002 	ldr	w2, [x0]
     58c:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     590:	9102c001 	add	x1, x0, #0xb0
     594:	2a0203e0 	mov	w0, w2
     598:	9400109c 	bl	4808 <printf>
}
     59c:	d503201f 	nop
     5a0:	a8c27bfd 	ldp	x29, x30, [sp], #32
     5a4:	d65f03c0 	ret

00000000000005a8 <createtest>:

void
createtest(void)
{
     5a8:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
     5ac:	910003fd 	mov	x29, sp
    int i, fd;
    
    printf(stdout, "many creates, followed by unlink test\n");
     5b0:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     5b4:	9121e000 	add	x0, x0, #0x878
     5b8:	b9400002 	ldr	w2, [x0]
     5bc:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     5c0:	91030001 	add	x1, x0, #0xc0
     5c4:	2a0203e0 	mov	w0, w2
     5c8:	94001090 	bl	4808 <printf>
    
    name[0] = 'a';
     5cc:	90000040 	adrp	x0, 8000 <buf+0x1760>
     5d0:	91228000 	add	x0, x0, #0x8a0
     5d4:	52800c21 	mov	w1, #0x61                  	// #97
     5d8:	39000001 	strb	w1, [x0]
    name[2] = '\0';
     5dc:	90000040 	adrp	x0, 8000 <buf+0x1760>
     5e0:	91228000 	add	x0, x0, #0x8a0
     5e4:	3900081f 	strb	wzr, [x0, #2]
    for(i = 0; i < 52; i++){
     5e8:	b9001fff 	str	wzr, [sp, #28]
     5ec:	14000012 	b	634 <createtest+0x8c>
        name[1] = '0' + i;
     5f0:	b9401fe0 	ldr	w0, [sp, #28]
     5f4:	12001c00 	and	w0, w0, #0xff
     5f8:	1100c000 	add	w0, w0, #0x30
     5fc:	12001c01 	and	w1, w0, #0xff
     600:	90000040 	adrp	x0, 8000 <buf+0x1760>
     604:	91228000 	add	x0, x0, #0x8a0
     608:	39000401 	strb	w1, [x0, #1]
        fd = open(name, O_CREATE|O_RDWR);
     60c:	52804041 	mov	w1, #0x202                 	// #514
     610:	90000040 	adrp	x0, 8000 <buf+0x1760>
     614:	91228000 	add	x0, x0, #0x8a0
     618:	94000fbd 	bl	450c <open>
     61c:	b9001be0 	str	w0, [sp, #24]
        close(fd);
     620:	b9401be0 	ldr	w0, [sp, #24]
     624:	94000f9f 	bl	44a0 <close>
    for(i = 0; i < 52; i++){
     628:	b9401fe0 	ldr	w0, [sp, #28]
     62c:	11000400 	add	w0, w0, #0x1
     630:	b9001fe0 	str	w0, [sp, #28]
     634:	b9401fe0 	ldr	w0, [sp, #28]
     638:	7100cc1f 	cmp	w0, #0x33
     63c:	54fffdad 	b.le	5f0 <createtest+0x48>
    }
    name[0] = 'a';
     640:	90000040 	adrp	x0, 8000 <buf+0x1760>
     644:	91228000 	add	x0, x0, #0x8a0
     648:	52800c21 	mov	w1, #0x61                  	// #97
     64c:	39000001 	strb	w1, [x0]
    name[2] = '\0';
     650:	90000040 	adrp	x0, 8000 <buf+0x1760>
     654:	91228000 	add	x0, x0, #0x8a0
     658:	3900081f 	strb	wzr, [x0, #2]
    for(i = 0; i < 52; i++){
     65c:	b9001fff 	str	wzr, [sp, #28]
     660:	1400000e 	b	698 <createtest+0xf0>
        name[1] = '0' + i;
     664:	b9401fe0 	ldr	w0, [sp, #28]
     668:	12001c00 	and	w0, w0, #0xff
     66c:	1100c000 	add	w0, w0, #0x30
     670:	12001c01 	and	w1, w0, #0xff
     674:	90000040 	adrp	x0, 8000 <buf+0x1760>
     678:	91228000 	add	x0, x0, #0x8a0
     67c:	39000401 	strb	w1, [x0, #1]
        unlink(name);
     680:	90000040 	adrp	x0, 8000 <buf+0x1760>
     684:	91228000 	add	x0, x0, #0x8a0
     688:	94000fb3 	bl	4554 <unlink>
    for(i = 0; i < 52; i++){
     68c:	b9401fe0 	ldr	w0, [sp, #28]
     690:	11000400 	add	w0, w0, #0x1
     694:	b9001fe0 	str	w0, [sp, #28]
     698:	b9401fe0 	ldr	w0, [sp, #28]
     69c:	7100cc1f 	cmp	w0, #0x33
     6a0:	54fffe2d 	b.le	664 <createtest+0xbc>
    }
    printf(stdout, "many creates, followed by unlink; ok\n");
     6a4:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     6a8:	9121e000 	add	x0, x0, #0x878
     6ac:	b9400002 	ldr	w2, [x0]
     6b0:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     6b4:	9103a001 	add	x1, x0, #0xe8
     6b8:	2a0203e0 	mov	w0, w2
     6bc:	94001053 	bl	4808 <printf>
}
     6c0:	d503201f 	nop
     6c4:	a8c27bfd 	ldp	x29, x30, [sp], #32
     6c8:	d65f03c0 	ret

00000000000006cc <dirtest>:

void dirtest(void)
{
     6cc:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
     6d0:	910003fd 	mov	x29, sp
    printf(stdout, "mkdir test\n");
     6d4:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     6d8:	9121e000 	add	x0, x0, #0x878
     6dc:	b9400002 	ldr	w2, [x0]
     6e0:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     6e4:	91044001 	add	x1, x0, #0x110
     6e8:	2a0203e0 	mov	w0, w2
     6ec:	94001047 	bl	4808 <printf>
    
    if(mkdir("dir0") < 0){
     6f0:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     6f4:	91048000 	add	x0, x0, #0x120
     6f8:	94000fb2 	bl	45c0 <mkdir>
     6fc:	7100001f 	cmp	w0, #0x0
     700:	5400012a 	b.ge	724 <dirtest+0x58>  // b.tcont
        printf(stdout, "mkdir failed\n");
     704:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     708:	9121e000 	add	x0, x0, #0x878
     70c:	b9400002 	ldr	w2, [x0]
     710:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     714:	9104a001 	add	x1, x0, #0x128
     718:	2a0203e0 	mov	w0, w2
     71c:	9400103b 	bl	4808 <printf>
        exit();
     720:	94000f33 	bl	43ec <exit>
    }
    
    if(chdir("dir0") < 0){
     724:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     728:	91048000 	add	x0, x0, #0x120
     72c:	94000fae 	bl	45e4 <chdir>
     730:	7100001f 	cmp	w0, #0x0
     734:	5400012a 	b.ge	758 <dirtest+0x8c>  // b.tcont
        printf(stdout, "chdir dir0 failed\n");
     738:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     73c:	9121e000 	add	x0, x0, #0x878
     740:	b9400002 	ldr	w2, [x0]
     744:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     748:	9104e001 	add	x1, x0, #0x138
     74c:	2a0203e0 	mov	w0, w2
     750:	9400102e 	bl	4808 <printf>
        exit();
     754:	94000f26 	bl	43ec <exit>
    }
    
    if(chdir("..") < 0){
     758:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     75c:	91054000 	add	x0, x0, #0x150
     760:	94000fa1 	bl	45e4 <chdir>
     764:	7100001f 	cmp	w0, #0x0
     768:	5400012a 	b.ge	78c <dirtest+0xc0>  // b.tcont
        printf(stdout, "chdir .. failed\n");
     76c:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     770:	9121e000 	add	x0, x0, #0x878
     774:	b9400002 	ldr	w2, [x0]
     778:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     77c:	91056001 	add	x1, x0, #0x158
     780:	2a0203e0 	mov	w0, w2
     784:	94001021 	bl	4808 <printf>
        exit();
     788:	94000f19 	bl	43ec <exit>
    }
    
    if(unlink("dir0") < 0){
     78c:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     790:	91048000 	add	x0, x0, #0x120
     794:	94000f70 	bl	4554 <unlink>
     798:	7100001f 	cmp	w0, #0x0
     79c:	5400012a 	b.ge	7c0 <dirtest+0xf4>  // b.tcont
        printf(stdout, "unlink dir0 failed\n");
     7a0:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     7a4:	9121e000 	add	x0, x0, #0x878
     7a8:	b9400002 	ldr	w2, [x0]
     7ac:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     7b0:	9105c001 	add	x1, x0, #0x170
     7b4:	2a0203e0 	mov	w0, w2
     7b8:	94001014 	bl	4808 <printf>
        exit();
     7bc:	94000f0c 	bl	43ec <exit>
    }
    printf(stdout, "mkdir test\n");
     7c0:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     7c4:	9121e000 	add	x0, x0, #0x878
     7c8:	b9400002 	ldr	w2, [x0]
     7cc:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     7d0:	91044001 	add	x1, x0, #0x110
     7d4:	2a0203e0 	mov	w0, w2
     7d8:	9400100c 	bl	4808 <printf>
}
     7dc:	d503201f 	nop
     7e0:	a8c17bfd 	ldp	x29, x30, [sp], #16
     7e4:	d65f03c0 	ret

00000000000007e8 <exectest>:

void
exectest(void)
{
     7e8:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
     7ec:	910003fd 	mov	x29, sp
    printf(stdout, "exec test\n");
     7f0:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     7f4:	9121e000 	add	x0, x0, #0x878
     7f8:	b9400002 	ldr	w2, [x0]
     7fc:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     800:	91062001 	add	x1, x0, #0x188
     804:	2a0203e0 	mov	w0, w2
     808:	94001000 	bl	4808 <printf>
    if(exec("echo", echoargv) < 0){
     80c:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     810:	91214001 	add	x1, x0, #0x850
     814:	90000020 	adrp	x0, 4000 <strcmp+0x2c>
     818:	91374000 	add	x0, x0, #0xdd0
     81c:	94000f33 	bl	44e8 <exec>
     820:	7100001f 	cmp	w0, #0x0
     824:	5400012a 	b.ge	848 <exectest+0x60>  // b.tcont
        printf(stdout, "exec echo failed\n");
     828:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     82c:	9121e000 	add	x0, x0, #0x878
     830:	b9400002 	ldr	w2, [x0]
     834:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     838:	91066001 	add	x1, x0, #0x198
     83c:	2a0203e0 	mov	w0, w2
     840:	94000ff2 	bl	4808 <printf>
        exit();
     844:	94000eea 	bl	43ec <exit>
    }
}
     848:	d503201f 	nop
     84c:	a8c17bfd 	ldp	x29, x30, [sp], #16
     850:	d65f03c0 	ret

0000000000000854 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     854:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     858:	910003fd 	mov	x29, sp
    int fds[2], pid;
    int seq, i, n, cc, total;
    
    if(pipe(fds) != 0){
     85c:	910043e0 	add	x0, sp, #0x10
     860:	94000ef5 	bl	4434 <pipe>
     864:	7100001f 	cmp	w0, #0x0
     868:	540000c0 	b.eq	880 <pipe1+0x2c>  // b.none
        printf(1, "pipe() failed\n");
     86c:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     870:	9106c001 	add	x1, x0, #0x1b0
     874:	52800020 	mov	w0, #0x1                   	// #1
     878:	94000fe4 	bl	4808 <printf>
        exit();
     87c:	94000edc 	bl	43ec <exit>
    }
    pid = fork();
     880:	94000ed2 	bl	43c8 <fork>
     884:	b9001be0 	str	w0, [sp, #24]
    seq = 0;
     888:	b9002fff 	str	wzr, [sp, #44]
    if(pid == 0){
     88c:	b9401be0 	ldr	w0, [sp, #24]
     890:	7100001f 	cmp	w0, #0x0
     894:	54000521 	b.ne	938 <pipe1+0xe4>  // b.any
        close(fds[0]);
     898:	b94013e0 	ldr	w0, [sp, #16]
     89c:	94000f01 	bl	44a0 <close>
        for(n = 0; n < 5; n++){
     8a0:	b90027ff 	str	wzr, [sp, #36]
     8a4:	14000021 	b	928 <pipe1+0xd4>
            for(i = 0; i < 1033; i++)
     8a8:	b9002bff 	str	wzr, [sp, #40]
     8ac:	1400000c 	b	8dc <pipe1+0x88>
                buf[i] = seq++;
     8b0:	b9402fe0 	ldr	w0, [sp, #44]
     8b4:	11000401 	add	w1, w0, #0x1
     8b8:	b9002fe1 	str	w1, [sp, #44]
     8bc:	12001c02 	and	w2, w0, #0xff
     8c0:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     8c4:	91228001 	add	x1, x0, #0x8a0
     8c8:	b9802be0 	ldrsw	x0, [sp, #40]
     8cc:	38206822 	strb	w2, [x1, x0]
            for(i = 0; i < 1033; i++)
     8d0:	b9402be0 	ldr	w0, [sp, #40]
     8d4:	11000400 	add	w0, w0, #0x1
     8d8:	b9002be0 	str	w0, [sp, #40]
     8dc:	b9402be0 	ldr	w0, [sp, #40]
     8e0:	7110201f 	cmp	w0, #0x408
     8e4:	54fffe6d 	b.le	8b0 <pipe1+0x5c>
            if(write(fds[1], buf, 1033) != 1033){
     8e8:	b94017e3 	ldr	w3, [sp, #20]
     8ec:	52808122 	mov	w2, #0x409                 	// #1033
     8f0:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     8f4:	91228001 	add	x1, x0, #0x8a0
     8f8:	2a0303e0 	mov	w0, w3
     8fc:	94000ee0 	bl	447c <write>
     900:	7110241f 	cmp	w0, #0x409
     904:	540000c0 	b.eq	91c <pipe1+0xc8>  // b.none
                printf(1, "pipe1 oops 1\n");
     908:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     90c:	91070001 	add	x1, x0, #0x1c0
     910:	52800020 	mov	w0, #0x1                   	// #1
     914:	94000fbd 	bl	4808 <printf>
                exit();
     918:	94000eb5 	bl	43ec <exit>
        for(n = 0; n < 5; n++){
     91c:	b94027e0 	ldr	w0, [sp, #36]
     920:	11000400 	add	w0, w0, #0x1
     924:	b90027e0 	str	w0, [sp, #36]
     928:	b94027e0 	ldr	w0, [sp, #36]
     92c:	7100101f 	cmp	w0, #0x4
     930:	54fffbcd 	b.le	8a8 <pipe1+0x54>
            }
        }
        exit();
     934:	94000eae 	bl	43ec <exit>
    } else if(pid > 0){
     938:	b9401be0 	ldr	w0, [sp, #24]
     93c:	7100001f 	cmp	w0, #0x0
     940:	5400090d 	b.le	a60 <pipe1+0x20c>
        close(fds[1]);
     944:	b94017e0 	ldr	w0, [sp, #20]
     948:	94000ed6 	bl	44a0 <close>
        total = 0;
     94c:	b9001fff 	str	wzr, [sp, #28]
        cc = 1;
     950:	52800020 	mov	w0, #0x1                   	// #1
     954:	b90023e0 	str	w0, [sp, #32]
        while((n = read(fds[0], buf, cc)) > 0){
     958:	14000026 	b	9f0 <pipe1+0x19c>
            for(i = 0; i < n; i++){
     95c:	b9002bff 	str	wzr, [sp, #40]
     960:	14000014 	b	9b0 <pipe1+0x15c>
                if((buf[i] & 0xff) != (seq++ & 0xff)){
     964:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     968:	91228001 	add	x1, x0, #0x8a0
     96c:	b9802be0 	ldrsw	x0, [sp, #40]
     970:	38606820 	ldrb	w0, [x1, x0]
     974:	2a0003e2 	mov	w2, w0
     978:	b9402fe0 	ldr	w0, [sp, #44]
     97c:	11000401 	add	w1, w0, #0x1
     980:	b9002fe1 	str	w1, [sp, #44]
     984:	12001c00 	and	w0, w0, #0xff
     988:	6b00005f 	cmp	w2, w0
     98c:	540000c0 	b.eq	9a4 <pipe1+0x150>  // b.none
                    printf(1, "pipe1 oops 2\n");
     990:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     994:	91074001 	add	x1, x0, #0x1d0
     998:	52800020 	mov	w0, #0x1                   	// #1
     99c:	94000f9b 	bl	4808 <printf>
     9a0:	14000035 	b	a74 <pipe1+0x220>
            for(i = 0; i < n; i++){
     9a4:	b9402be0 	ldr	w0, [sp, #40]
     9a8:	11000400 	add	w0, w0, #0x1
     9ac:	b9002be0 	str	w0, [sp, #40]
     9b0:	b9402be1 	ldr	w1, [sp, #40]
     9b4:	b94027e0 	ldr	w0, [sp, #36]
     9b8:	6b00003f 	cmp	w1, w0
     9bc:	54fffd4b 	b.lt	964 <pipe1+0x110>  // b.tstop
                    return;
                }
            }
            total += n;
     9c0:	b9401fe1 	ldr	w1, [sp, #28]
     9c4:	b94027e0 	ldr	w0, [sp, #36]
     9c8:	0b000020 	add	w0, w1, w0
     9cc:	b9001fe0 	str	w0, [sp, #28]
            cc = cc * 2;
     9d0:	b94023e0 	ldr	w0, [sp, #32]
     9d4:	531f7800 	lsl	w0, w0, #1
     9d8:	b90023e0 	str	w0, [sp, #32]
            if(cc > sizeof(buf))
     9dc:	b94023e0 	ldr	w0, [sp, #32]
     9e0:	7140081f 	cmp	w0, #0x2, lsl #12
     9e4:	54000069 	b.ls	9f0 <pipe1+0x19c>  // b.plast
                cc = sizeof(buf);
     9e8:	52840000 	mov	w0, #0x2000                	// #8192
     9ec:	b90023e0 	str	w0, [sp, #32]
        while((n = read(fds[0], buf, cc)) > 0){
     9f0:	b94013e3 	ldr	w3, [sp, #16]
     9f4:	b94023e2 	ldr	w2, [sp, #32]
     9f8:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     9fc:	91228001 	add	x1, x0, #0x8a0
     a00:	2a0303e0 	mov	w0, w3
     a04:	94000e95 	bl	4458 <read>
     a08:	b90027e0 	str	w0, [sp, #36]
     a0c:	b94027e0 	ldr	w0, [sp, #36]
     a10:	7100001f 	cmp	w0, #0x0
     a14:	54fffa4c 	b.gt	95c <pipe1+0x108>
        }
        if(total != 5 * 1033){
     a18:	b9401fe1 	ldr	w1, [sp, #28]
     a1c:	528285a0 	mov	w0, #0x142d                	// #5165
     a20:	6b00003f 	cmp	w1, w0
     a24:	540000e0 	b.eq	a40 <pipe1+0x1ec>  // b.none
            printf(1, "pipe1 oops 3 total %d\n", total);
     a28:	b9401fe2 	ldr	w2, [sp, #28]
     a2c:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     a30:	91078001 	add	x1, x0, #0x1e0
     a34:	52800020 	mov	w0, #0x1                   	// #1
     a38:	94000f74 	bl	4808 <printf>
            exit();
     a3c:	94000e6c 	bl	43ec <exit>
        }
        close(fds[0]);
     a40:	b94013e0 	ldr	w0, [sp, #16]
     a44:	94000e97 	bl	44a0 <close>
        wait();
     a48:	94000e72 	bl	4410 <wait>
    } else {
        printf(1, "fork() failed\n");
        exit();
    }
    printf(1, "pipe1 ok\n");
     a4c:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     a50:	9107e001 	add	x1, x0, #0x1f8
     a54:	52800020 	mov	w0, #0x1                   	// #1
     a58:	94000f6c 	bl	4808 <printf>
     a5c:	14000006 	b	a74 <pipe1+0x220>
        printf(1, "fork() failed\n");
     a60:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     a64:	91082001 	add	x1, x0, #0x208
     a68:	52800020 	mov	w0, #0x1                   	// #1
     a6c:	94000f67 	bl	4808 <printf>
        exit();
     a70:	94000e5f 	bl	43ec <exit>
}
     a74:	a8c37bfd 	ldp	x29, x30, [sp], #48
     a78:	d65f03c0 	ret

0000000000000a7c <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     a7c:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     a80:	910003fd 	mov	x29, sp
    int pid1, pid2, pid3;
    int pfds[2];
    
    printf(1, "preempt: ");
     a84:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     a88:	91086001 	add	x1, x0, #0x218
     a8c:	52800020 	mov	w0, #0x1                   	// #1
     a90:	94000f5e 	bl	4808 <printf>
    pid1 = fork();
     a94:	94000e4d 	bl	43c8 <fork>
     a98:	b9002fe0 	str	w0, [sp, #44]
    if(pid1 == 0)
     a9c:	b9402fe0 	ldr	w0, [sp, #44]
     aa0:	7100001f 	cmp	w0, #0x0
     aa4:	54000061 	b.ne	ab0 <preempt+0x34>  // b.any
        for(;;)
     aa8:	d503201f 	nop
     aac:	17ffffff 	b	aa8 <preempt+0x2c>
            ;
    
    pid2 = fork();
     ab0:	94000e46 	bl	43c8 <fork>
     ab4:	b9002be0 	str	w0, [sp, #40]
    if(pid2 == 0)
     ab8:	b9402be0 	ldr	w0, [sp, #40]
     abc:	7100001f 	cmp	w0, #0x0
     ac0:	54000061 	b.ne	acc <preempt+0x50>  // b.any
        for(;;)
     ac4:	d503201f 	nop
     ac8:	17ffffff 	b	ac4 <preempt+0x48>
            ;
    
    pipe(pfds);
     acc:	910063e0 	add	x0, sp, #0x18
     ad0:	94000e59 	bl	4434 <pipe>
    pid3 = fork();
     ad4:	94000e3d 	bl	43c8 <fork>
     ad8:	b90027e0 	str	w0, [sp, #36]
    if(pid3 == 0){
     adc:	b94027e0 	ldr	w0, [sp, #36]
     ae0:	7100001f 	cmp	w0, #0x0
     ae4:	54000261 	b.ne	b30 <preempt+0xb4>  // b.any
        close(pfds[0]);
     ae8:	b9401be0 	ldr	w0, [sp, #24]
     aec:	94000e6d 	bl	44a0 <close>
        if(write(pfds[1], "x", 1) != 1)
     af0:	b9401fe3 	ldr	w3, [sp, #28]
     af4:	52800022 	mov	w2, #0x1                   	// #1
     af8:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     afc:	9108a001 	add	x1, x0, #0x228
     b00:	2a0303e0 	mov	w0, w3
     b04:	94000e5e 	bl	447c <write>
     b08:	7100041f 	cmp	w0, #0x1
     b0c:	540000a0 	b.eq	b20 <preempt+0xa4>  // b.none
            printf(1, "preempt write error");
     b10:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     b14:	9108c001 	add	x1, x0, #0x230
     b18:	52800020 	mov	w0, #0x1                   	// #1
     b1c:	94000f3b 	bl	4808 <printf>
        close(pfds[1]);
     b20:	b9401fe0 	ldr	w0, [sp, #28]
     b24:	94000e5f 	bl	44a0 <close>
        for(;;)
     b28:	d503201f 	nop
     b2c:	17ffffff 	b	b28 <preempt+0xac>
            ;
    }
    
    close(pfds[1]);
     b30:	b9401fe0 	ldr	w0, [sp, #28]
     b34:	94000e5b 	bl	44a0 <close>
    if(read(pfds[0], buf, sizeof(buf)) != 1){
     b38:	b9401be3 	ldr	w3, [sp, #24]
     b3c:	52840002 	mov	w2, #0x2000                	// #8192
     b40:	d0000020 	adrp	x0, 6000 <malloc+0x13a8>
     b44:	91228001 	add	x1, x0, #0x8a0
     b48:	2a0303e0 	mov	w0, w3
     b4c:	94000e43 	bl	4458 <read>
     b50:	7100041f 	cmp	w0, #0x1
     b54:	540000c0 	b.eq	b6c <preempt+0xf0>  // b.none
        printf(1, "preempt read error");
     b58:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     b5c:	91092001 	add	x1, x0, #0x248
     b60:	52800020 	mov	w0, #0x1                   	// #1
     b64:	94000f29 	bl	4808 <printf>
     b68:	14000018 	b	bc8 <preempt+0x14c>
        return;
    }
    close(pfds[0]);
     b6c:	b9401be0 	ldr	w0, [sp, #24]
     b70:	94000e4c 	bl	44a0 <close>
    printf(1, "kill... ");
     b74:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     b78:	91098001 	add	x1, x0, #0x260
     b7c:	52800020 	mov	w0, #0x1                   	// #1
     b80:	94000f22 	bl	4808 <printf>
    kill(pid1);
     b84:	b9402fe0 	ldr	w0, [sp, #44]
     b88:	94000e4f 	bl	44c4 <kill>
    kill(pid2);
     b8c:	b9402be0 	ldr	w0, [sp, #40]
     b90:	94000e4d 	bl	44c4 <kill>
    kill(pid3);
     b94:	b94027e0 	ldr	w0, [sp, #36]
     b98:	94000e4b 	bl	44c4 <kill>
    printf(1, "wait... ");
     b9c:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     ba0:	9109c001 	add	x1, x0, #0x270
     ba4:	52800020 	mov	w0, #0x1                   	// #1
     ba8:	94000f18 	bl	4808 <printf>
    wait();
     bac:	94000e19 	bl	4410 <wait>
    wait();
     bb0:	94000e18 	bl	4410 <wait>
    wait();
     bb4:	94000e17 	bl	4410 <wait>
    printf(1, "preempt ok\n");
     bb8:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     bbc:	910a0001 	add	x1, x0, #0x280
     bc0:	52800020 	mov	w0, #0x1                   	// #1
     bc4:	94000f11 	bl	4808 <printf>
}
     bc8:	a8c37bfd 	ldp	x29, x30, [sp], #48
     bcc:	d65f03c0 	ret

0000000000000bd0 <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
     bd0:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
     bd4:	910003fd 	mov	x29, sp
    int i, pid;
    
    for(i = 0; i < 100; i++){
     bd8:	b9001fff 	str	wzr, [sp, #28]
     bdc:	1400001c 	b	c4c <exitwait+0x7c>
        pid = fork();
     be0:	94000dfa 	bl	43c8 <fork>
     be4:	b9001be0 	str	w0, [sp, #24]
        if(pid < 0){
     be8:	b9401be0 	ldr	w0, [sp, #24]
     bec:	7100001f 	cmp	w0, #0x0
     bf0:	540000ca 	b.ge	c08 <exitwait+0x38>  // b.tcont
            printf(1, "fork failed\n");
     bf4:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     bf8:	910a4001 	add	x1, x0, #0x290
     bfc:	52800020 	mov	w0, #0x1                   	// #1
     c00:	94000f02 	bl	4808 <printf>
            return;
     c04:	14000019 	b	c68 <exitwait+0x98>
        }
        if(pid){
     c08:	b9401be0 	ldr	w0, [sp, #24]
     c0c:	7100001f 	cmp	w0, #0x0
     c10:	54000160 	b.eq	c3c <exitwait+0x6c>  // b.none
            if(wait() != pid){
     c14:	94000dff 	bl	4410 <wait>
     c18:	2a0003e1 	mov	w1, w0
     c1c:	b9401be0 	ldr	w0, [sp, #24]
     c20:	6b01001f 	cmp	w0, w1
     c24:	540000e0 	b.eq	c40 <exitwait+0x70>  // b.none
                printf(1, "wait wrong pid\n");
     c28:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     c2c:	910a8001 	add	x1, x0, #0x2a0
     c30:	52800020 	mov	w0, #0x1                   	// #1
     c34:	94000ef5 	bl	4808 <printf>
                return;
     c38:	1400000c 	b	c68 <exitwait+0x98>
            }
        } else {
            exit();
     c3c:	94000dec 	bl	43ec <exit>
    for(i = 0; i < 100; i++){
     c40:	b9401fe0 	ldr	w0, [sp, #28]
     c44:	11000400 	add	w0, w0, #0x1
     c48:	b9001fe0 	str	w0, [sp, #28]
     c4c:	b9401fe0 	ldr	w0, [sp, #28]
     c50:	71018c1f 	cmp	w0, #0x63
     c54:	54fffc6d 	b.le	be0 <exitwait+0x10>
        }
    }
    printf(1, "exitwait ok\n");
     c58:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     c5c:	910ac001 	add	x1, x0, #0x2b0
     c60:	52800020 	mov	w0, #0x1                   	// #1
     c64:	94000ee9 	bl	4808 <printf>
}
     c68:	a8c27bfd 	ldp	x29, x30, [sp], #32
     c6c:	d65f03c0 	ret

0000000000000c70 <mem>:

void
mem(void)
{
     c70:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     c74:	910003fd 	mov	x29, sp
    void *m1, *m2;
    int pid, ppid;
    
    printf(1, "mem test\n");
     c78:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     c7c:	910b0001 	add	x1, x0, #0x2c0
     c80:	52800020 	mov	w0, #0x1                   	// #1
     c84:	94000ee1 	bl	4808 <printf>
    ppid = getpid();
     c88:	94000e69 	bl	462c <getpid>
     c8c:	b90027e0 	str	w0, [sp, #36]
    if((pid = fork()) == 0){
     c90:	94000dce 	bl	43c8 <fork>
     c94:	b90023e0 	str	w0, [sp, #32]
     c98:	b94023e0 	ldr	w0, [sp, #32]
     c9c:	7100001f 	cmp	w0, #0x0
     ca0:	540005a1 	b.ne	d54 <mem+0xe4>  // b.any
        m1 = 0;
     ca4:	f90017ff 	str	xzr, [sp, #40]
        while((m2 = malloc(10001)) != 0){
     ca8:	14000006 	b	cc0 <mem+0x50>
            *(char**)m2 = m1;
     cac:	f9400fe0 	ldr	x0, [sp, #24]
     cb0:	f94017e1 	ldr	x1, [sp, #40]
     cb4:	f9000001 	str	x1, [x0]
            m1 = m2;
     cb8:	f9400fe0 	ldr	x0, [sp, #24]
     cbc:	f90017e0 	str	x0, [sp, #40]
        while((m2 = malloc(10001)) != 0){
     cc0:	5284e220 	mov	w0, #0x2711                	// #10001
     cc4:	94000fe5 	bl	4c58 <malloc>
     cc8:	f9000fe0 	str	x0, [sp, #24]
     ccc:	f9400fe0 	ldr	x0, [sp, #24]
     cd0:	f100001f 	cmp	x0, #0x0
     cd4:	54fffec1 	b.ne	cac <mem+0x3c>  // b.any
        }
        while(m1){
     cd8:	14000008 	b	cf8 <mem+0x88>
            m2 = *(char**)m1;
     cdc:	f94017e0 	ldr	x0, [sp, #40]
     ce0:	f9400000 	ldr	x0, [x0]
     ce4:	f9000fe0 	str	x0, [sp, #24]
            free(m1);
     ce8:	f94017e0 	ldr	x0, [sp, #40]
     cec:	94000f5e 	bl	4a64 <free>
            m1 = m2;
     cf0:	f9400fe0 	ldr	x0, [sp, #24]
     cf4:	f90017e0 	str	x0, [sp, #40]
        while(m1){
     cf8:	f94017e0 	ldr	x0, [sp, #40]
     cfc:	f100001f 	cmp	x0, #0x0
     d00:	54fffee1 	b.ne	cdc <mem+0x6c>  // b.any
        }
        m1 = malloc(1024*20);
     d04:	528a0000 	mov	w0, #0x5000                	// #20480
     d08:	94000fd4 	bl	4c58 <malloc>
     d0c:	f90017e0 	str	x0, [sp, #40]
        if(m1 == 0){
     d10:	f94017e0 	ldr	x0, [sp, #40]
     d14:	f100001f 	cmp	x0, #0x0
     d18:	54000101 	b.ne	d38 <mem+0xc8>  // b.any
            printf(1, "couldn't allocate mem?!!\n");
     d1c:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     d20:	910b4001 	add	x1, x0, #0x2d0
     d24:	52800020 	mov	w0, #0x1                   	// #1
     d28:	94000eb8 	bl	4808 <printf>
            kill(ppid);
     d2c:	b94027e0 	ldr	w0, [sp, #36]
     d30:	94000de5 	bl	44c4 <kill>
            exit();
     d34:	94000dae 	bl	43ec <exit>
        }
        free(m1);
     d38:	f94017e0 	ldr	x0, [sp, #40]
     d3c:	94000f4a 	bl	4a64 <free>
        printf(1, "mem ok\n");
     d40:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     d44:	910bc001 	add	x1, x0, #0x2f0
     d48:	52800020 	mov	w0, #0x1                   	// #1
     d4c:	94000eaf 	bl	4808 <printf>
        exit();
     d50:	94000da7 	bl	43ec <exit>
    } else {
        wait();
     d54:	94000daf 	bl	4410 <wait>
    }
}
     d58:	d503201f 	nop
     d5c:	a8c37bfd 	ldp	x29, x30, [sp], #48
     d60:	d65f03c0 	ret

0000000000000d64 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     d64:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
     d68:	910003fd 	mov	x29, sp
    int fd, pid, i, n, nc, np;
    char buf[10];
    
    printf(1, "sharedfd test\n");
     d6c:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     d70:	910be001 	add	x1, x0, #0x2f8
     d74:	52800020 	mov	w0, #0x1                   	// #1
     d78:	94000ea4 	bl	4808 <printf>
    
    unlink("sharedfd");
     d7c:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     d80:	910c2000 	add	x0, x0, #0x308
     d84:	94000df4 	bl	4554 <unlink>
    fd = open("sharedfd", O_CREATE|O_RDWR);
     d88:	52804041 	mov	w1, #0x202                 	// #514
     d8c:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     d90:	910c2000 	add	x0, x0, #0x308
     d94:	94000dde 	bl	450c <open>
     d98:	b90033e0 	str	w0, [sp, #48]
    if(fd < 0){
     d9c:	b94033e0 	ldr	w0, [sp, #48]
     da0:	7100001f 	cmp	w0, #0x0
     da4:	540000ca 	b.ge	dbc <sharedfd+0x58>  // b.tcont
        printf(1, "fstests: cannot open sharedfd for writing");
     da8:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     dac:	910c6001 	add	x1, x0, #0x318
     db0:	52800020 	mov	w0, #0x1                   	// #1
     db4:	94000e95 	bl	4808 <printf>
        return;
     db8:	14000074 	b	f88 <sharedfd+0x224>
    }
    pid = fork();
     dbc:	94000d83 	bl	43c8 <fork>
     dc0:	b9002fe0 	str	w0, [sp, #44]
    memset(buf, pid==0?'c':'p', sizeof(buf));
     dc4:	b9402fe0 	ldr	w0, [sp, #44]
     dc8:	7100001f 	cmp	w0, #0x0
     dcc:	54000061 	b.ne	dd8 <sharedfd+0x74>  // b.any
     dd0:	52800c60 	mov	w0, #0x63                  	// #99
     dd4:	14000002 	b	ddc <sharedfd+0x78>
     dd8:	52800e00 	mov	w0, #0x70                  	// #112
     ddc:	910063e3 	add	x3, sp, #0x18
     de0:	52800142 	mov	w2, #0xa                   	// #10
     de4:	2a0003e1 	mov	w1, w0
     de8:	aa0303e0 	mov	x0, x3
     dec:	94000ca6 	bl	4084 <memset>
    for(i = 0; i < 1000; i++){
     df0:	b9003fff 	str	wzr, [sp, #60]
     df4:	14000010 	b	e34 <sharedfd+0xd0>
        if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     df8:	910063e0 	add	x0, sp, #0x18
     dfc:	52800142 	mov	w2, #0xa                   	// #10
     e00:	aa0003e1 	mov	x1, x0
     e04:	b94033e0 	ldr	w0, [sp, #48]
     e08:	94000d9d 	bl	447c <write>
     e0c:	7100281f 	cmp	w0, #0xa
     e10:	540000c0 	b.eq	e28 <sharedfd+0xc4>  // b.none
            printf(1, "fstests: write sharedfd failed\n");
     e14:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     e18:	910d2001 	add	x1, x0, #0x348
     e1c:	52800020 	mov	w0, #0x1                   	// #1
     e20:	94000e7a 	bl	4808 <printf>
            break;
     e24:	14000007 	b	e40 <sharedfd+0xdc>
    for(i = 0; i < 1000; i++){
     e28:	b9403fe0 	ldr	w0, [sp, #60]
     e2c:	11000400 	add	w0, w0, #0x1
     e30:	b9003fe0 	str	w0, [sp, #60]
     e34:	b9403fe0 	ldr	w0, [sp, #60]
     e38:	710f9c1f 	cmp	w0, #0x3e7
     e3c:	54fffded 	b.le	df8 <sharedfd+0x94>
        }
    }
    if(pid == 0)
     e40:	b9402fe0 	ldr	w0, [sp, #44]
     e44:	7100001f 	cmp	w0, #0x0
     e48:	54000041 	b.ne	e50 <sharedfd+0xec>  // b.any
        exit();
     e4c:	94000d68 	bl	43ec <exit>
    else
        wait();
     e50:	94000d70 	bl	4410 <wait>
    close(fd);
     e54:	b94033e0 	ldr	w0, [sp, #48]
     e58:	94000d92 	bl	44a0 <close>
    fd = open("sharedfd", 0);
     e5c:	52800001 	mov	w1, #0x0                   	// #0
     e60:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     e64:	910c2000 	add	x0, x0, #0x308
     e68:	94000da9 	bl	450c <open>
     e6c:	b90033e0 	str	w0, [sp, #48]
    if(fd < 0){
     e70:	b94033e0 	ldr	w0, [sp, #48]
     e74:	7100001f 	cmp	w0, #0x0
     e78:	540000ca 	b.ge	e90 <sharedfd+0x12c>  // b.tcont
        printf(1, "fstests: cannot open sharedfd for reading\n");
     e7c:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     e80:	910da001 	add	x1, x0, #0x368
     e84:	52800020 	mov	w0, #0x1                   	// #1
     e88:	94000e60 	bl	4808 <printf>
        return;
     e8c:	1400003f 	b	f88 <sharedfd+0x224>
    }
    nc = np = 0;
     e90:	b90037ff 	str	wzr, [sp, #52]
     e94:	b94037e0 	ldr	w0, [sp, #52]
     e98:	b9003be0 	str	w0, [sp, #56]
    while((n = read(fd, buf, sizeof(buf))) > 0){
     e9c:	14000019 	b	f00 <sharedfd+0x19c>
        for(i = 0; i < sizeof(buf); i++){
     ea0:	b9003fff 	str	wzr, [sp, #60]
     ea4:	14000014 	b	ef4 <sharedfd+0x190>
            if(buf[i] == 'c')
     ea8:	b9803fe0 	ldrsw	x0, [sp, #60]
     eac:	910063e1 	add	x1, sp, #0x18
     eb0:	38606820 	ldrb	w0, [x1, x0]
     eb4:	71018c1f 	cmp	w0, #0x63
     eb8:	54000081 	b.ne	ec8 <sharedfd+0x164>  // b.any
                nc++;
     ebc:	b9403be0 	ldr	w0, [sp, #56]
     ec0:	11000400 	add	w0, w0, #0x1
     ec4:	b9003be0 	str	w0, [sp, #56]
            if(buf[i] == 'p')
     ec8:	b9803fe0 	ldrsw	x0, [sp, #60]
     ecc:	910063e1 	add	x1, sp, #0x18
     ed0:	38606820 	ldrb	w0, [x1, x0]
     ed4:	7101c01f 	cmp	w0, #0x70
     ed8:	54000081 	b.ne	ee8 <sharedfd+0x184>  // b.any
                np++;
     edc:	b94037e0 	ldr	w0, [sp, #52]
     ee0:	11000400 	add	w0, w0, #0x1
     ee4:	b90037e0 	str	w0, [sp, #52]
        for(i = 0; i < sizeof(buf); i++){
     ee8:	b9403fe0 	ldr	w0, [sp, #60]
     eec:	11000400 	add	w0, w0, #0x1
     ef0:	b9003fe0 	str	w0, [sp, #60]
     ef4:	b9403fe0 	ldr	w0, [sp, #60]
     ef8:	7100241f 	cmp	w0, #0x9
     efc:	54fffd69 	b.ls	ea8 <sharedfd+0x144>  // b.plast
    while((n = read(fd, buf, sizeof(buf))) > 0){
     f00:	910063e0 	add	x0, sp, #0x18
     f04:	52800142 	mov	w2, #0xa                   	// #10
     f08:	aa0003e1 	mov	x1, x0
     f0c:	b94033e0 	ldr	w0, [sp, #48]
     f10:	94000d52 	bl	4458 <read>
     f14:	b9002be0 	str	w0, [sp, #40]
     f18:	b9402be0 	ldr	w0, [sp, #40]
     f1c:	7100001f 	cmp	w0, #0x0
     f20:	54fffc0c 	b.gt	ea0 <sharedfd+0x13c>
        }
    }
    close(fd);
     f24:	b94033e0 	ldr	w0, [sp, #48]
     f28:	94000d5e 	bl	44a0 <close>
    unlink("sharedfd");
     f2c:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     f30:	910c2000 	add	x0, x0, #0x308
     f34:	94000d88 	bl	4554 <unlink>
    if(nc == 10000 && np == 10000){
     f38:	b9403be1 	ldr	w1, [sp, #56]
     f3c:	5284e200 	mov	w0, #0x2710                	// #10000
     f40:	6b00003f 	cmp	w1, w0
     f44:	54000141 	b.ne	f6c <sharedfd+0x208>  // b.any
     f48:	b94037e1 	ldr	w1, [sp, #52]
     f4c:	5284e200 	mov	w0, #0x2710                	// #10000
     f50:	6b00003f 	cmp	w1, w0
     f54:	540000c1 	b.ne	f6c <sharedfd+0x208>  // b.any
        printf(1, "sharedfd ok\n");
     f58:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     f5c:	910e6001 	add	x1, x0, #0x398
     f60:	52800020 	mov	w0, #0x1                   	// #1
     f64:	94000e29 	bl	4808 <printf>
     f68:	14000008 	b	f88 <sharedfd+0x224>
    } else {
        printf(1, "sharedfd oops %d %d\n", nc, np);
     f6c:	b94037e3 	ldr	w3, [sp, #52]
     f70:	b9403be2 	ldr	w2, [sp, #56]
     f74:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     f78:	910ea001 	add	x1, x0, #0x3a8
     f7c:	52800020 	mov	w0, #0x1                   	// #1
     f80:	94000e22 	bl	4808 <printf>
        exit();
     f84:	94000d1a 	bl	43ec <exit>
    }
}
     f88:	a8c47bfd 	ldp	x29, x30, [sp], #64
     f8c:	d65f03c0 	ret

0000000000000f90 <twofiles>:

// two processes write two different files at the same
// time, to test block allocation.
void
twofiles(void)
{
     f90:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
     f94:	910003fd 	mov	x29, sp
    int fd, pid, i, j, n, total;
    char *fname;
    
    printf(1, "twofiles test\n");
     f98:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     f9c:	910f0001 	add	x1, x0, #0x3c0
     fa0:	52800020 	mov	w0, #0x1                   	// #1
     fa4:	94000e19 	bl	4808 <printf>
    
    unlink("f1");
     fa8:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     fac:	910f4000 	add	x0, x0, #0x3d0
     fb0:	94000d69 	bl	4554 <unlink>
    unlink("f2");
     fb4:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     fb8:	910f6000 	add	x0, x0, #0x3d8
     fbc:	94000d66 	bl	4554 <unlink>
    
    pid = fork();
     fc0:	94000d02 	bl	43c8 <fork>
     fc4:	b90027e0 	str	w0, [sp, #36]
    if(pid < 0){
     fc8:	b94027e0 	ldr	w0, [sp, #36]
     fcc:	7100001f 	cmp	w0, #0x0
     fd0:	540000ca 	b.ge	fe8 <twofiles+0x58>  // b.tcont
        printf(1, "fork failed\n");
     fd4:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     fd8:	910a4001 	add	x1, x0, #0x290
     fdc:	52800020 	mov	w0, #0x1                   	// #1
     fe0:	94000e0a 	bl	4808 <printf>
        exit();
     fe4:	94000d02 	bl	43ec <exit>
    }
    
    fname = pid ? "f1" : "f2";
     fe8:	b94027e0 	ldr	w0, [sp, #36]
     fec:	7100001f 	cmp	w0, #0x0
     ff0:	540000a0 	b.eq	1004 <twofiles+0x74>  // b.none
     ff4:	b0000020 	adrp	x0, 5000 <malloc+0x3a8>
     ff8:	910f4000 	add	x0, x0, #0x3d0
     ffc:	f90017e0 	str	x0, [sp, #40]
    1000:	14000004 	b	1010 <twofiles+0x80>
    1004:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1008:	910f6000 	add	x0, x0, #0x3d8
    100c:	f90017e0 	str	x0, [sp, #40]
    fd = open(fname, O_CREATE | O_RDWR);
    1010:	52804041 	mov	w1, #0x202                 	// #514
    1014:	f94017e0 	ldr	x0, [sp, #40]
    1018:	94000d3d 	bl	450c <open>
    101c:	b90023e0 	str	w0, [sp, #32]
    if(fd < 0){
    1020:	b94023e0 	ldr	w0, [sp, #32]
    1024:	7100001f 	cmp	w0, #0x0
    1028:	540000ca 	b.ge	1040 <twofiles+0xb0>  // b.tcont
        printf(1, "create failed\n");
    102c:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1030:	910f8001 	add	x1, x0, #0x3e0
    1034:	52800020 	mov	w0, #0x1                   	// #1
    1038:	94000df4 	bl	4808 <printf>
        exit();
    103c:	94000cec 	bl	43ec <exit>
    }
    
    memset(buf, pid?'p':'c', 512);
    1040:	b94027e0 	ldr	w0, [sp, #36]
    1044:	7100001f 	cmp	w0, #0x0
    1048:	54000060 	b.eq	1054 <twofiles+0xc4>  // b.none
    104c:	52800e00 	mov	w0, #0x70                  	// #112
    1050:	14000002 	b	1058 <twofiles+0xc8>
    1054:	52800c60 	mov	w0, #0x63                  	// #99
    1058:	52804002 	mov	w2, #0x200                 	// #512
    105c:	2a0003e1 	mov	w1, w0
    1060:	b0000020 	adrp	x0, 6000 <malloc+0x13a8>
    1064:	91228000 	add	x0, x0, #0x8a0
    1068:	94000c07 	bl	4084 <memset>
    for(i = 0; i < 12; i++){
    106c:	b9003fff 	str	wzr, [sp, #60]
    1070:	14000013 	b	10bc <twofiles+0x12c>
        if((n = write(fd, buf, 500)) != 500){
    1074:	52803e82 	mov	w2, #0x1f4                 	// #500
    1078:	b0000020 	adrp	x0, 6000 <malloc+0x13a8>
    107c:	91228001 	add	x1, x0, #0x8a0
    1080:	b94023e0 	ldr	w0, [sp, #32]
    1084:	94000cfe 	bl	447c <write>
    1088:	b9001fe0 	str	w0, [sp, #28]
    108c:	b9401fe0 	ldr	w0, [sp, #28]
    1090:	7107d01f 	cmp	w0, #0x1f4
    1094:	540000e0 	b.eq	10b0 <twofiles+0x120>  // b.none
            printf(1, "write failed %d\n", n);
    1098:	b9401fe2 	ldr	w2, [sp, #28]
    109c:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    10a0:	910fc001 	add	x1, x0, #0x3f0
    10a4:	52800020 	mov	w0, #0x1                   	// #1
    10a8:	94000dd8 	bl	4808 <printf>
            exit();
    10ac:	94000cd0 	bl	43ec <exit>
    for(i = 0; i < 12; i++){
    10b0:	b9403fe0 	ldr	w0, [sp, #60]
    10b4:	11000400 	add	w0, w0, #0x1
    10b8:	b9003fe0 	str	w0, [sp, #60]
    10bc:	b9403fe0 	ldr	w0, [sp, #60]
    10c0:	71002c1f 	cmp	w0, #0xb
    10c4:	54fffd8d 	b.le	1074 <twofiles+0xe4>
        }
    }
    close(fd);
    10c8:	b94023e0 	ldr	w0, [sp, #32]
    10cc:	94000cf5 	bl	44a0 <close>
    if(pid)
    10d0:	b94027e0 	ldr	w0, [sp, #36]
    10d4:	7100001f 	cmp	w0, #0x0
    10d8:	54000080 	b.eq	10e8 <twofiles+0x158>  // b.none
        wait();
    10dc:	94000ccd 	bl	4410 <wait>
    else
        exit();
    
    for(i = 0; i < 2; i++){
    10e0:	b9003fff 	str	wzr, [sp, #60]
    10e4:	14000046 	b	11fc <twofiles+0x26c>
        exit();
    10e8:	94000cc1 	bl	43ec <exit>
        fd = open(i?"f1":"f2", 0);
    10ec:	b9403fe0 	ldr	w0, [sp, #60]
    10f0:	7100001f 	cmp	w0, #0x0
    10f4:	54000080 	b.eq	1104 <twofiles+0x174>  // b.none
    10f8:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    10fc:	910f4000 	add	x0, x0, #0x3d0
    1100:	14000003 	b	110c <twofiles+0x17c>
    1104:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1108:	910f6000 	add	x0, x0, #0x3d8
    110c:	52800001 	mov	w1, #0x0                   	// #0
    1110:	94000cff 	bl	450c <open>
    1114:	b90023e0 	str	w0, [sp, #32]
        total = 0;
    1118:	b90037ff 	str	wzr, [sp, #52]
        while((n = read(fd, buf, sizeof(buf))) > 0){
    111c:	14000020 	b	119c <twofiles+0x20c>
            for(j = 0; j < n; j++){
    1120:	b9003bff 	str	wzr, [sp, #56]
    1124:	14000016 	b	117c <twofiles+0x1ec>
                if(buf[j] != (i?'p':'c')){
    1128:	b0000020 	adrp	x0, 6000 <malloc+0x13a8>
    112c:	91228001 	add	x1, x0, #0x8a0
    1130:	b9803be0 	ldrsw	x0, [sp, #56]
    1134:	38606820 	ldrb	w0, [x1, x0]
    1138:	2a0003e1 	mov	w1, w0
    113c:	b9403fe0 	ldr	w0, [sp, #60]
    1140:	7100001f 	cmp	w0, #0x0
    1144:	54000060 	b.eq	1150 <twofiles+0x1c0>  // b.none
    1148:	52800e00 	mov	w0, #0x70                  	// #112
    114c:	14000002 	b	1154 <twofiles+0x1c4>
    1150:	52800c60 	mov	w0, #0x63                  	// #99
    1154:	6b01001f 	cmp	w0, w1
    1158:	540000c0 	b.eq	1170 <twofiles+0x1e0>  // b.none
                    printf(1, "wrong char\n");
    115c:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1160:	91102001 	add	x1, x0, #0x408
    1164:	52800020 	mov	w0, #0x1                   	// #1
    1168:	94000da8 	bl	4808 <printf>
                    exit();
    116c:	94000ca0 	bl	43ec <exit>
            for(j = 0; j < n; j++){
    1170:	b9403be0 	ldr	w0, [sp, #56]
    1174:	11000400 	add	w0, w0, #0x1
    1178:	b9003be0 	str	w0, [sp, #56]
    117c:	b9403be1 	ldr	w1, [sp, #56]
    1180:	b9401fe0 	ldr	w0, [sp, #28]
    1184:	6b00003f 	cmp	w1, w0
    1188:	54fffd0b 	b.lt	1128 <twofiles+0x198>  // b.tstop
                }
            }
            total += n;
    118c:	b94037e1 	ldr	w1, [sp, #52]
    1190:	b9401fe0 	ldr	w0, [sp, #28]
    1194:	0b000020 	add	w0, w1, w0
    1198:	b90037e0 	str	w0, [sp, #52]
        while((n = read(fd, buf, sizeof(buf))) > 0){
    119c:	52840002 	mov	w2, #0x2000                	// #8192
    11a0:	b0000020 	adrp	x0, 6000 <malloc+0x13a8>
    11a4:	91228001 	add	x1, x0, #0x8a0
    11a8:	b94023e0 	ldr	w0, [sp, #32]
    11ac:	94000cab 	bl	4458 <read>
    11b0:	b9001fe0 	str	w0, [sp, #28]
    11b4:	b9401fe0 	ldr	w0, [sp, #28]
    11b8:	7100001f 	cmp	w0, #0x0
    11bc:	54fffb2c 	b.gt	1120 <twofiles+0x190>
        }
        close(fd);
    11c0:	b94023e0 	ldr	w0, [sp, #32]
    11c4:	94000cb7 	bl	44a0 <close>
        if(total != 12*500){
    11c8:	b94037e1 	ldr	w1, [sp, #52]
    11cc:	5282ee00 	mov	w0, #0x1770                	// #6000
    11d0:	6b00003f 	cmp	w1, w0
    11d4:	540000e0 	b.eq	11f0 <twofiles+0x260>  // b.none
            printf(1, "wrong length %d\n", total);
    11d8:	b94037e2 	ldr	w2, [sp, #52]
    11dc:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    11e0:	91106001 	add	x1, x0, #0x418
    11e4:	52800020 	mov	w0, #0x1                   	// #1
    11e8:	94000d88 	bl	4808 <printf>
            exit();
    11ec:	94000c80 	bl	43ec <exit>
    for(i = 0; i < 2; i++){
    11f0:	b9403fe0 	ldr	w0, [sp, #60]
    11f4:	11000400 	add	w0, w0, #0x1
    11f8:	b9003fe0 	str	w0, [sp, #60]
    11fc:	b9403fe0 	ldr	w0, [sp, #60]
    1200:	7100041f 	cmp	w0, #0x1
    1204:	54fff74d 	b.le	10ec <twofiles+0x15c>
        }
    }
    
    unlink("f1");
    1208:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    120c:	910f4000 	add	x0, x0, #0x3d0
    1210:	94000cd1 	bl	4554 <unlink>
    unlink("f2");
    1214:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1218:	910f6000 	add	x0, x0, #0x3d8
    121c:	94000cce 	bl	4554 <unlink>
    
    printf(1, "twofiles ok\n");
    1220:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1224:	9110c001 	add	x1, x0, #0x430
    1228:	52800020 	mov	w0, #0x1                   	// #1
    122c:	94000d77 	bl	4808 <printf>
}
    1230:	d503201f 	nop
    1234:	a8c47bfd 	ldp	x29, x30, [sp], #64
    1238:	d65f03c0 	ret

000000000000123c <createdelete>:

// two processes create and delete different files in same directory
void
createdelete(void)
{
    123c:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
    1240:	910003fd 	mov	x29, sp
    enum { N = 20 };
    int pid, i, fd;
    char name[32];
    
    printf(1, "createdelete test\n");
    1244:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1248:	91110001 	add	x1, x0, #0x440
    124c:	52800020 	mov	w0, #0x1                   	// #1
    1250:	94000d6e 	bl	4808 <printf>
    pid = fork();
    1254:	94000c5d 	bl	43c8 <fork>
    1258:	b9003be0 	str	w0, [sp, #56]
    if(pid < 0){
    125c:	b9403be0 	ldr	w0, [sp, #56]
    1260:	7100001f 	cmp	w0, #0x0
    1264:	540000ca 	b.ge	127c <createdelete+0x40>  // b.tcont
        printf(1, "fork failed\n");
    1268:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    126c:	910a4001 	add	x1, x0, #0x290
    1270:	52800020 	mov	w0, #0x1                   	// #1
    1274:	94000d65 	bl	4808 <printf>
        exit();
    1278:	94000c5d 	bl	43ec <exit>
    }
    
    name[0] = pid ? 'p' : 'c';
    127c:	b9403be0 	ldr	w0, [sp, #56]
    1280:	7100001f 	cmp	w0, #0x0
    1284:	54000060 	b.eq	1290 <createdelete+0x54>  // b.none
    1288:	52800e00 	mov	w0, #0x70                  	// #112
    128c:	14000002 	b	1294 <createdelete+0x58>
    1290:	52800c60 	mov	w0, #0x63                  	// #99
    1294:	390043e0 	strb	w0, [sp, #16]
    name[2] = '\0';
    1298:	39004bff 	strb	wzr, [sp, #18]
    for(i = 0; i < N; i++){
    129c:	b9003fff 	str	wzr, [sp, #60]
    12a0:	1400002f 	b	135c <createdelete+0x120>
        name[1] = '0' + i;
    12a4:	b9403fe0 	ldr	w0, [sp, #60]
    12a8:	12001c00 	and	w0, w0, #0xff
    12ac:	1100c000 	add	w0, w0, #0x30
    12b0:	12001c00 	and	w0, w0, #0xff
    12b4:	390047e0 	strb	w0, [sp, #17]
        fd = open(name, O_CREATE | O_RDWR);
    12b8:	910043e0 	add	x0, sp, #0x10
    12bc:	52804041 	mov	w1, #0x202                 	// #514
    12c0:	94000c93 	bl	450c <open>
    12c4:	b90037e0 	str	w0, [sp, #52]
        if(fd < 0){
    12c8:	b94037e0 	ldr	w0, [sp, #52]
    12cc:	7100001f 	cmp	w0, #0x0
    12d0:	540000ca 	b.ge	12e8 <createdelete+0xac>  // b.tcont
            printf(1, "create failed\n");
    12d4:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    12d8:	910f8001 	add	x1, x0, #0x3e0
    12dc:	52800020 	mov	w0, #0x1                   	// #1
    12e0:	94000d4a 	bl	4808 <printf>
            exit();
    12e4:	94000c42 	bl	43ec <exit>
        }
        close(fd);
    12e8:	b94037e0 	ldr	w0, [sp, #52]
    12ec:	94000c6d 	bl	44a0 <close>
        if(i > 0 && (i % 2 ) == 0){
    12f0:	b9403fe0 	ldr	w0, [sp, #60]
    12f4:	7100001f 	cmp	w0, #0x0
    12f8:	540002cd 	b.le	1350 <createdelete+0x114>
    12fc:	b9403fe0 	ldr	w0, [sp, #60]
    1300:	12000000 	and	w0, w0, #0x1
    1304:	7100001f 	cmp	w0, #0x0
    1308:	54000241 	b.ne	1350 <createdelete+0x114>  // b.any
            name[1] = '0' + (i / 2);
    130c:	b9403fe0 	ldr	w0, [sp, #60]
    1310:	531f7c01 	lsr	w1, w0, #31
    1314:	0b000020 	add	w0, w1, w0
    1318:	13017c00 	asr	w0, w0, #1
    131c:	12001c00 	and	w0, w0, #0xff
    1320:	1100c000 	add	w0, w0, #0x30
    1324:	12001c00 	and	w0, w0, #0xff
    1328:	390047e0 	strb	w0, [sp, #17]
            if(unlink(name) < 0){
    132c:	910043e0 	add	x0, sp, #0x10
    1330:	94000c89 	bl	4554 <unlink>
    1334:	7100001f 	cmp	w0, #0x0
    1338:	540000ca 	b.ge	1350 <createdelete+0x114>  // b.tcont
                printf(1, "unlink failed\n");
    133c:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1340:	91116001 	add	x1, x0, #0x458
    1344:	52800020 	mov	w0, #0x1                   	// #1
    1348:	94000d30 	bl	4808 <printf>
                exit();
    134c:	94000c28 	bl	43ec <exit>
    for(i = 0; i < N; i++){
    1350:	b9403fe0 	ldr	w0, [sp, #60]
    1354:	11000400 	add	w0, w0, #0x1
    1358:	b9003fe0 	str	w0, [sp, #60]
    135c:	b9403fe0 	ldr	w0, [sp, #60]
    1360:	71004c1f 	cmp	w0, #0x13
    1364:	54fffa0d 	b.le	12a4 <createdelete+0x68>
            }
        }
    }
    
    if(pid==0)
    1368:	b9403be0 	ldr	w0, [sp, #56]
    136c:	7100001f 	cmp	w0, #0x0
    1370:	54000041 	b.ne	1378 <createdelete+0x13c>  // b.any
        exit();
    1374:	94000c1e 	bl	43ec <exit>
    else
        wait();
    1378:	94000c26 	bl	4410 <wait>
    
    for(i = 0; i < N; i++){
    137c:	b9003fff 	str	wzr, [sp, #60]
    1380:	14000064 	b	1510 <createdelete+0x2d4>
        name[0] = 'p';
    1384:	52800e00 	mov	w0, #0x70                  	// #112
    1388:	390043e0 	strb	w0, [sp, #16]
        name[1] = '0' + i;
    138c:	b9403fe0 	ldr	w0, [sp, #60]
    1390:	12001c00 	and	w0, w0, #0xff
    1394:	1100c000 	add	w0, w0, #0x30
    1398:	12001c00 	and	w0, w0, #0xff
    139c:	390047e0 	strb	w0, [sp, #17]
        fd = open(name, 0);
    13a0:	910043e0 	add	x0, sp, #0x10
    13a4:	52800001 	mov	w1, #0x0                   	// #0
    13a8:	94000c59 	bl	450c <open>
    13ac:	b90037e0 	str	w0, [sp, #52]
        if((i == 0 || i >= N/2) && fd < 0){
    13b0:	b9403fe0 	ldr	w0, [sp, #60]
    13b4:	7100001f 	cmp	w0, #0x0
    13b8:	54000080 	b.eq	13c8 <createdelete+0x18c>  // b.none
    13bc:	b9403fe0 	ldr	w0, [sp, #60]
    13c0:	7100241f 	cmp	w0, #0x9
    13c4:	5400016d 	b.le	13f0 <createdelete+0x1b4>
    13c8:	b94037e0 	ldr	w0, [sp, #52]
    13cc:	7100001f 	cmp	w0, #0x0
    13d0:	5400010a 	b.ge	13f0 <createdelete+0x1b4>  // b.tcont
            printf(1, "oops createdelete %s didn't exist\n", name);
    13d4:	910043e0 	add	x0, sp, #0x10
    13d8:	aa0003e2 	mov	x2, x0
    13dc:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    13e0:	9111a001 	add	x1, x0, #0x468
    13e4:	52800020 	mov	w0, #0x1                   	// #1
    13e8:	94000d08 	bl	4808 <printf>
            exit();
    13ec:	94000c00 	bl	43ec <exit>
        } else if((i >= 1 && i < N/2) && fd >= 0){
    13f0:	b9403fe0 	ldr	w0, [sp, #60]
    13f4:	7100001f 	cmp	w0, #0x0
    13f8:	540001cd 	b.le	1430 <createdelete+0x1f4>
    13fc:	b9403fe0 	ldr	w0, [sp, #60]
    1400:	7100241f 	cmp	w0, #0x9
    1404:	5400016c 	b.gt	1430 <createdelete+0x1f4>
    1408:	b94037e0 	ldr	w0, [sp, #52]
    140c:	7100001f 	cmp	w0, #0x0
    1410:	5400010b 	b.lt	1430 <createdelete+0x1f4>  // b.tstop
            printf(1, "oops createdelete %s did exist\n", name);
    1414:	910043e0 	add	x0, sp, #0x10
    1418:	aa0003e2 	mov	x2, x0
    141c:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1420:	91124001 	add	x1, x0, #0x490
    1424:	52800020 	mov	w0, #0x1                   	// #1
    1428:	94000cf8 	bl	4808 <printf>
            exit();
    142c:	94000bf0 	bl	43ec <exit>
        }
        if(fd >= 0)
    1430:	b94037e0 	ldr	w0, [sp, #52]
    1434:	7100001f 	cmp	w0, #0x0
    1438:	5400006b 	b.lt	1444 <createdelete+0x208>  // b.tstop
            close(fd);
    143c:	b94037e0 	ldr	w0, [sp, #52]
    1440:	94000c18 	bl	44a0 <close>
        
        name[0] = 'c';
    1444:	52800c60 	mov	w0, #0x63                  	// #99
    1448:	390043e0 	strb	w0, [sp, #16]
        name[1] = '0' + i;
    144c:	b9403fe0 	ldr	w0, [sp, #60]
    1450:	12001c00 	and	w0, w0, #0xff
    1454:	1100c000 	add	w0, w0, #0x30
    1458:	12001c00 	and	w0, w0, #0xff
    145c:	390047e0 	strb	w0, [sp, #17]
        fd = open(name, 0);
    1460:	910043e0 	add	x0, sp, #0x10
    1464:	52800001 	mov	w1, #0x0                   	// #0
    1468:	94000c29 	bl	450c <open>
    146c:	b90037e0 	str	w0, [sp, #52]
        if((i == 0 || i >= N/2) && fd < 0){
    1470:	b9403fe0 	ldr	w0, [sp, #60]
    1474:	7100001f 	cmp	w0, #0x0
    1478:	54000080 	b.eq	1488 <createdelete+0x24c>  // b.none
    147c:	b9403fe0 	ldr	w0, [sp, #60]
    1480:	7100241f 	cmp	w0, #0x9
    1484:	5400016d 	b.le	14b0 <createdelete+0x274>
    1488:	b94037e0 	ldr	w0, [sp, #52]
    148c:	7100001f 	cmp	w0, #0x0
    1490:	5400010a 	b.ge	14b0 <createdelete+0x274>  // b.tcont
            printf(1, "oops createdelete %s didn't exist\n", name);
    1494:	910043e0 	add	x0, sp, #0x10
    1498:	aa0003e2 	mov	x2, x0
    149c:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    14a0:	9111a001 	add	x1, x0, #0x468
    14a4:	52800020 	mov	w0, #0x1                   	// #1
    14a8:	94000cd8 	bl	4808 <printf>
            exit();
    14ac:	94000bd0 	bl	43ec <exit>
        } else if((i >= 1 && i < N/2) && fd >= 0){
    14b0:	b9403fe0 	ldr	w0, [sp, #60]
    14b4:	7100001f 	cmp	w0, #0x0
    14b8:	540001cd 	b.le	14f0 <createdelete+0x2b4>
    14bc:	b9403fe0 	ldr	w0, [sp, #60]
    14c0:	7100241f 	cmp	w0, #0x9
    14c4:	5400016c 	b.gt	14f0 <createdelete+0x2b4>
    14c8:	b94037e0 	ldr	w0, [sp, #52]
    14cc:	7100001f 	cmp	w0, #0x0
    14d0:	5400010b 	b.lt	14f0 <createdelete+0x2b4>  // b.tstop
            printf(1, "oops createdelete %s did exist\n", name);
    14d4:	910043e0 	add	x0, sp, #0x10
    14d8:	aa0003e2 	mov	x2, x0
    14dc:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    14e0:	91124001 	add	x1, x0, #0x490
    14e4:	52800020 	mov	w0, #0x1                   	// #1
    14e8:	94000cc8 	bl	4808 <printf>
            exit();
    14ec:	94000bc0 	bl	43ec <exit>
        }
        if(fd >= 0)
    14f0:	b94037e0 	ldr	w0, [sp, #52]
    14f4:	7100001f 	cmp	w0, #0x0
    14f8:	5400006b 	b.lt	1504 <createdelete+0x2c8>  // b.tstop
            close(fd);
    14fc:	b94037e0 	ldr	w0, [sp, #52]
    1500:	94000be8 	bl	44a0 <close>
    for(i = 0; i < N; i++){
    1504:	b9403fe0 	ldr	w0, [sp, #60]
    1508:	11000400 	add	w0, w0, #0x1
    150c:	b9003fe0 	str	w0, [sp, #60]
    1510:	b9403fe0 	ldr	w0, [sp, #60]
    1514:	71004c1f 	cmp	w0, #0x13
    1518:	54fff36d 	b.le	1384 <createdelete+0x148>
    }
    
    for(i = 0; i < N; i++){
    151c:	b9003fff 	str	wzr, [sp, #60]
    1520:	14000011 	b	1564 <createdelete+0x328>
        name[0] = 'p';
    1524:	52800e00 	mov	w0, #0x70                  	// #112
    1528:	390043e0 	strb	w0, [sp, #16]
        name[1] = '0' + i;
    152c:	b9403fe0 	ldr	w0, [sp, #60]
    1530:	12001c00 	and	w0, w0, #0xff
    1534:	1100c000 	add	w0, w0, #0x30
    1538:	12001c00 	and	w0, w0, #0xff
    153c:	390047e0 	strb	w0, [sp, #17]
        unlink(name);
    1540:	910043e0 	add	x0, sp, #0x10
    1544:	94000c04 	bl	4554 <unlink>
        name[0] = 'c';
    1548:	52800c60 	mov	w0, #0x63                  	// #99
    154c:	390043e0 	strb	w0, [sp, #16]
        unlink(name);
    1550:	910043e0 	add	x0, sp, #0x10
    1554:	94000c00 	bl	4554 <unlink>
    for(i = 0; i < N; i++){
    1558:	b9403fe0 	ldr	w0, [sp, #60]
    155c:	11000400 	add	w0, w0, #0x1
    1560:	b9003fe0 	str	w0, [sp, #60]
    1564:	b9403fe0 	ldr	w0, [sp, #60]
    1568:	71004c1f 	cmp	w0, #0x13
    156c:	54fffdcd 	b.le	1524 <createdelete+0x2e8>
    }
    
    printf(1, "createdelete ok\n");
    1570:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1574:	9112c001 	add	x1, x0, #0x4b0
    1578:	52800020 	mov	w0, #0x1                   	// #1
    157c:	94000ca3 	bl	4808 <printf>
}
    1580:	d503201f 	nop
    1584:	a8c47bfd 	ldp	x29, x30, [sp], #64
    1588:	d65f03c0 	ret

000000000000158c <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    158c:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    1590:	910003fd 	mov	x29, sp
    int fd, fd1;
    
    printf(1, "unlinkread test\n");
    1594:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1598:	91132001 	add	x1, x0, #0x4c8
    159c:	52800020 	mov	w0, #0x1                   	// #1
    15a0:	94000c9a 	bl	4808 <printf>
    fd = open("unlinkread", O_CREATE | O_RDWR);
    15a4:	52804041 	mov	w1, #0x202                 	// #514
    15a8:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    15ac:	91138000 	add	x0, x0, #0x4e0
    15b0:	94000bd7 	bl	450c <open>
    15b4:	b9001fe0 	str	w0, [sp, #28]
    if(fd < 0){
    15b8:	b9401fe0 	ldr	w0, [sp, #28]
    15bc:	7100001f 	cmp	w0, #0x0
    15c0:	540000ca 	b.ge	15d8 <unlinkread+0x4c>  // b.tcont
        printf(1, "create unlinkread failed\n");
    15c4:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    15c8:	9113c001 	add	x1, x0, #0x4f0
    15cc:	52800020 	mov	w0, #0x1                   	// #1
    15d0:	94000c8e 	bl	4808 <printf>
        exit();
    15d4:	94000b86 	bl	43ec <exit>
    }
    write(fd, "hello", 5);
    15d8:	528000a2 	mov	w2, #0x5                   	// #5
    15dc:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    15e0:	91144001 	add	x1, x0, #0x510
    15e4:	b9401fe0 	ldr	w0, [sp, #28]
    15e8:	94000ba5 	bl	447c <write>
    close(fd);
    15ec:	b9401fe0 	ldr	w0, [sp, #28]
    15f0:	94000bac 	bl	44a0 <close>
    
    fd = open("unlinkread", O_RDWR);
    15f4:	52800041 	mov	w1, #0x2                   	// #2
    15f8:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    15fc:	91138000 	add	x0, x0, #0x4e0
    1600:	94000bc3 	bl	450c <open>
    1604:	b9001fe0 	str	w0, [sp, #28]
    if(fd < 0){
    1608:	b9401fe0 	ldr	w0, [sp, #28]
    160c:	7100001f 	cmp	w0, #0x0
    1610:	540000ca 	b.ge	1628 <unlinkread+0x9c>  // b.tcont
        printf(1, "open unlinkread failed\n");
    1614:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1618:	91146001 	add	x1, x0, #0x518
    161c:	52800020 	mov	w0, #0x1                   	// #1
    1620:	94000c7a 	bl	4808 <printf>
        exit();
    1624:	94000b72 	bl	43ec <exit>
    }
    if(unlink("unlinkread") != 0){
    1628:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    162c:	91138000 	add	x0, x0, #0x4e0
    1630:	94000bc9 	bl	4554 <unlink>
    1634:	7100001f 	cmp	w0, #0x0
    1638:	540000c0 	b.eq	1650 <unlinkread+0xc4>  // b.none
        printf(1, "unlink unlinkread failed\n");
    163c:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1640:	9114c001 	add	x1, x0, #0x530
    1644:	52800020 	mov	w0, #0x1                   	// #1
    1648:	94000c70 	bl	4808 <printf>
        exit();
    164c:	94000b68 	bl	43ec <exit>
    }
    
    fd1 = open("unlinkread", O_CREATE | O_RDWR);
    1650:	52804041 	mov	w1, #0x202                 	// #514
    1654:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1658:	91138000 	add	x0, x0, #0x4e0
    165c:	94000bac 	bl	450c <open>
    1660:	b9001be0 	str	w0, [sp, #24]
    write(fd1, "yyy", 3);
    1664:	52800062 	mov	w2, #0x3                   	// #3
    1668:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    166c:	91154001 	add	x1, x0, #0x550
    1670:	b9401be0 	ldr	w0, [sp, #24]
    1674:	94000b82 	bl	447c <write>
    close(fd1);
    1678:	b9401be0 	ldr	w0, [sp, #24]
    167c:	94000b89 	bl	44a0 <close>
    
    if(read(fd, buf, sizeof(buf)) != 5){
    1680:	52840002 	mov	w2, #0x2000                	// #8192
    1684:	b0000020 	adrp	x0, 6000 <malloc+0x13a8>
    1688:	91228001 	add	x1, x0, #0x8a0
    168c:	b9401fe0 	ldr	w0, [sp, #28]
    1690:	94000b72 	bl	4458 <read>
    1694:	7100141f 	cmp	w0, #0x5
    1698:	540000c0 	b.eq	16b0 <unlinkread+0x124>  // b.none
        printf(1, "unlinkread read failed");
    169c:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    16a0:	91156001 	add	x1, x0, #0x558
    16a4:	52800020 	mov	w0, #0x1                   	// #1
    16a8:	94000c58 	bl	4808 <printf>
        exit();
    16ac:	94000b50 	bl	43ec <exit>
    }
    if(buf[0] != 'h'){
    16b0:	b0000020 	adrp	x0, 6000 <malloc+0x13a8>
    16b4:	91228000 	add	x0, x0, #0x8a0
    16b8:	39400000 	ldrb	w0, [x0]
    16bc:	7101a01f 	cmp	w0, #0x68
    16c0:	540000c0 	b.eq	16d8 <unlinkread+0x14c>  // b.none
        printf(1, "unlinkread wrong data\n");
    16c4:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    16c8:	9115c001 	add	x1, x0, #0x570
    16cc:	52800020 	mov	w0, #0x1                   	// #1
    16d0:	94000c4e 	bl	4808 <printf>
        exit();
    16d4:	94000b46 	bl	43ec <exit>
    }
    if(write(fd, buf, 10) != 10){
    16d8:	52800142 	mov	w2, #0xa                   	// #10
    16dc:	b0000020 	adrp	x0, 6000 <malloc+0x13a8>
    16e0:	91228001 	add	x1, x0, #0x8a0
    16e4:	b9401fe0 	ldr	w0, [sp, #28]
    16e8:	94000b65 	bl	447c <write>
    16ec:	7100281f 	cmp	w0, #0xa
    16f0:	540000c0 	b.eq	1708 <unlinkread+0x17c>  // b.none
        printf(1, "unlinkread write failed\n");
    16f4:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    16f8:	91162001 	add	x1, x0, #0x588
    16fc:	52800020 	mov	w0, #0x1                   	// #1
    1700:	94000c42 	bl	4808 <printf>
        exit();
    1704:	94000b3a 	bl	43ec <exit>
    }
    close(fd);
    1708:	b9401fe0 	ldr	w0, [sp, #28]
    170c:	94000b65 	bl	44a0 <close>
    unlink("unlinkread");
    1710:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1714:	91138000 	add	x0, x0, #0x4e0
    1718:	94000b8f 	bl	4554 <unlink>
    printf(1, "unlinkread ok\n");
    171c:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1720:	9116a001 	add	x1, x0, #0x5a8
    1724:	52800020 	mov	w0, #0x1                   	// #1
    1728:	94000c38 	bl	4808 <printf>
}
    172c:	d503201f 	nop
    1730:	a8c27bfd 	ldp	x29, x30, [sp], #32
    1734:	d65f03c0 	ret

0000000000001738 <linktest>:

void
linktest(void)
{
    1738:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    173c:	910003fd 	mov	x29, sp
    int fd;
    
    printf(1, "linktest\n");
    1740:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1744:	9116e001 	add	x1, x0, #0x5b8
    1748:	52800020 	mov	w0, #0x1                   	// #1
    174c:	94000c2f 	bl	4808 <printf>
    
    unlink("lf1");
    1750:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1754:	91172000 	add	x0, x0, #0x5c8
    1758:	94000b7f 	bl	4554 <unlink>
    unlink("lf2");
    175c:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1760:	91174000 	add	x0, x0, #0x5d0
    1764:	94000b7c 	bl	4554 <unlink>
    
    fd = open("lf1", O_CREATE|O_RDWR);
    1768:	52804041 	mov	w1, #0x202                 	// #514
    176c:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1770:	91172000 	add	x0, x0, #0x5c8
    1774:	94000b66 	bl	450c <open>
    1778:	b9001fe0 	str	w0, [sp, #28]
    if(fd < 0){
    177c:	b9401fe0 	ldr	w0, [sp, #28]
    1780:	7100001f 	cmp	w0, #0x0
    1784:	540000ca 	b.ge	179c <linktest+0x64>  // b.tcont
        printf(1, "create lf1 failed\n");
    1788:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    178c:	91176001 	add	x1, x0, #0x5d8
    1790:	52800020 	mov	w0, #0x1                   	// #1
    1794:	94000c1d 	bl	4808 <printf>
        exit();
    1798:	94000b15 	bl	43ec <exit>
    }
    if(write(fd, "hello", 5) != 5){
    179c:	528000a2 	mov	w2, #0x5                   	// #5
    17a0:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    17a4:	91144001 	add	x1, x0, #0x510
    17a8:	b9401fe0 	ldr	w0, [sp, #28]
    17ac:	94000b34 	bl	447c <write>
    17b0:	7100141f 	cmp	w0, #0x5
    17b4:	540000c0 	b.eq	17cc <linktest+0x94>  // b.none
        printf(1, "write lf1 failed\n");
    17b8:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    17bc:	9117c001 	add	x1, x0, #0x5f0
    17c0:	52800020 	mov	w0, #0x1                   	// #1
    17c4:	94000c11 	bl	4808 <printf>
        exit();
    17c8:	94000b09 	bl	43ec <exit>
    }
    close(fd);
    17cc:	b9401fe0 	ldr	w0, [sp, #28]
    17d0:	94000b34 	bl	44a0 <close>
    
    if(link("lf1", "lf2") < 0){
    17d4:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    17d8:	91174001 	add	x1, x0, #0x5d0
    17dc:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    17e0:	91172000 	add	x0, x0, #0x5c8
    17e4:	94000b6e 	bl	459c <link>
    17e8:	7100001f 	cmp	w0, #0x0
    17ec:	540000ca 	b.ge	1804 <linktest+0xcc>  // b.tcont
        printf(1, "link lf1 lf2 failed\n");
    17f0:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    17f4:	91182001 	add	x1, x0, #0x608
    17f8:	52800020 	mov	w0, #0x1                   	// #1
    17fc:	94000c03 	bl	4808 <printf>
        exit();
    1800:	94000afb 	bl	43ec <exit>
    }
    unlink("lf1");
    1804:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1808:	91172000 	add	x0, x0, #0x5c8
    180c:	94000b52 	bl	4554 <unlink>
    
    if(open("lf1", 0) >= 0){
    1810:	52800001 	mov	w1, #0x0                   	// #0
    1814:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1818:	91172000 	add	x0, x0, #0x5c8
    181c:	94000b3c 	bl	450c <open>
    1820:	7100001f 	cmp	w0, #0x0
    1824:	540000cb 	b.lt	183c <linktest+0x104>  // b.tstop
        printf(1, "unlinked lf1 but it is still there!\n");
    1828:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    182c:	91188001 	add	x1, x0, #0x620
    1830:	52800020 	mov	w0, #0x1                   	// #1
    1834:	94000bf5 	bl	4808 <printf>
        exit();
    1838:	94000aed 	bl	43ec <exit>
    }
    
    fd = open("lf2", 0);
    183c:	52800001 	mov	w1, #0x0                   	// #0
    1840:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1844:	91174000 	add	x0, x0, #0x5d0
    1848:	94000b31 	bl	450c <open>
    184c:	b9001fe0 	str	w0, [sp, #28]
    if(fd < 0){
    1850:	b9401fe0 	ldr	w0, [sp, #28]
    1854:	7100001f 	cmp	w0, #0x0
    1858:	540000ca 	b.ge	1870 <linktest+0x138>  // b.tcont
        printf(1, "open lf2 failed\n");
    185c:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1860:	91192001 	add	x1, x0, #0x648
    1864:	52800020 	mov	w0, #0x1                   	// #1
    1868:	94000be8 	bl	4808 <printf>
        exit();
    186c:	94000ae0 	bl	43ec <exit>
    }
    if(read(fd, buf, sizeof(buf)) != 5){
    1870:	52840002 	mov	w2, #0x2000                	// #8192
    1874:	b0000020 	adrp	x0, 6000 <malloc+0x13a8>
    1878:	91228001 	add	x1, x0, #0x8a0
    187c:	b9401fe0 	ldr	w0, [sp, #28]
    1880:	94000af6 	bl	4458 <read>
    1884:	7100141f 	cmp	w0, #0x5
    1888:	540000c0 	b.eq	18a0 <linktest+0x168>  // b.none
        printf(1, "read lf2 failed\n");
    188c:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1890:	91198001 	add	x1, x0, #0x660
    1894:	52800020 	mov	w0, #0x1                   	// #1
    1898:	94000bdc 	bl	4808 <printf>
        exit();
    189c:	94000ad4 	bl	43ec <exit>
    }
    close(fd);
    18a0:	b9401fe0 	ldr	w0, [sp, #28]
    18a4:	94000aff 	bl	44a0 <close>
    
    if(link("lf2", "lf2") >= 0){
    18a8:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    18ac:	91174001 	add	x1, x0, #0x5d0
    18b0:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    18b4:	91174000 	add	x0, x0, #0x5d0
    18b8:	94000b39 	bl	459c <link>
    18bc:	7100001f 	cmp	w0, #0x0
    18c0:	540000cb 	b.lt	18d8 <linktest+0x1a0>  // b.tstop
        printf(1, "link lf2 lf2 succeeded! oops\n");
    18c4:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    18c8:	9119e001 	add	x1, x0, #0x678
    18cc:	52800020 	mov	w0, #0x1                   	// #1
    18d0:	94000bce 	bl	4808 <printf>
        exit();
    18d4:	94000ac6 	bl	43ec <exit>
    }
    
    unlink("lf2");
    18d8:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    18dc:	91174000 	add	x0, x0, #0x5d0
    18e0:	94000b1d 	bl	4554 <unlink>
    if(link("lf2", "lf1") >= 0){
    18e4:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    18e8:	91172001 	add	x1, x0, #0x5c8
    18ec:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    18f0:	91174000 	add	x0, x0, #0x5d0
    18f4:	94000b2a 	bl	459c <link>
    18f8:	7100001f 	cmp	w0, #0x0
    18fc:	540000cb 	b.lt	1914 <linktest+0x1dc>  // b.tstop
        printf(1, "link non-existant succeeded! oops\n");
    1900:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1904:	911a6001 	add	x1, x0, #0x698
    1908:	52800020 	mov	w0, #0x1                   	// #1
    190c:	94000bbf 	bl	4808 <printf>
        exit();
    1910:	94000ab7 	bl	43ec <exit>
    }
    
    if(link(".", "lf1") >= 0){
    1914:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1918:	91172001 	add	x1, x0, #0x5c8
    191c:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1920:	911b0000 	add	x0, x0, #0x6c0
    1924:	94000b1e 	bl	459c <link>
    1928:	7100001f 	cmp	w0, #0x0
    192c:	540000cb 	b.lt	1944 <linktest+0x20c>  // b.tstop
        printf(1, "link . lf1 succeeded! oops\n");
    1930:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1934:	911b2001 	add	x1, x0, #0x6c8
    1938:	52800020 	mov	w0, #0x1                   	// #1
    193c:	94000bb3 	bl	4808 <printf>
        exit();
    1940:	94000aab 	bl	43ec <exit>
    }
    
    printf(1, "linktest ok\n");
    1944:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1948:	911ba001 	add	x1, x0, #0x6e8
    194c:	52800020 	mov	w0, #0x1                   	// #1
    1950:	94000bae 	bl	4808 <printf>
}
    1954:	d503201f 	nop
    1958:	a8c27bfd 	ldp	x29, x30, [sp], #32
    195c:	d65f03c0 	ret

0000000000001960 <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    1960:	a9ba7bfd 	stp	x29, x30, [sp, #-96]!
    1964:	910003fd 	mov	x29, sp
    struct {
        ushort inum;
        char name[14];
    } de;
    
    printf(1, "concreate test\n");
    1968:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    196c:	911be001 	add	x1, x0, #0x6f8
    1970:	52800020 	mov	w0, #0x1                   	// #1
    1974:	94000ba5 	bl	4808 <printf>
    file[0] = 'C';
    1978:	52800860 	mov	w0, #0x43                  	// #67
    197c:	390123e0 	strb	w0, [sp, #72]
    file[2] = '\0';
    1980:	39012bff 	strb	wzr, [sp, #74]
    for(i = 0; i < 40; i++){
    1984:	b9005fff 	str	wzr, [sp, #92]
    1988:	1400004f 	b	1ac4 <concreate+0x164>
        file[1] = '0' + i;
    198c:	b9405fe0 	ldr	w0, [sp, #92]
    1990:	12001c00 	and	w0, w0, #0xff
    1994:	1100c000 	add	w0, w0, #0x30
    1998:	12001c00 	and	w0, w0, #0xff
    199c:	390127e0 	strb	w0, [sp, #73]
        unlink(file);
    19a0:	910123e0 	add	x0, sp, #0x48
    19a4:	94000aec 	bl	4554 <unlink>
        pid = fork();
    19a8:	94000a88 	bl	43c8 <fork>
    19ac:	b90053e0 	str	w0, [sp, #80]
        if(pid && (i % 3) == 1){
    19b0:	b94053e0 	ldr	w0, [sp, #80]
    19b4:	7100001f 	cmp	w0, #0x0
    19b8:	54000280 	b.eq	1a08 <concreate+0xa8>  // b.none
    19bc:	b9405fe2 	ldr	w2, [sp, #92]
    19c0:	528aaac0 	mov	w0, #0x5556                	// #21846
    19c4:	72aaaaa0 	movk	w0, #0x5555, lsl #16
    19c8:	9b207c40 	smull	x0, w2, w0
    19cc:	d360fc01 	lsr	x1, x0, #32
    19d0:	131f7c40 	asr	w0, w2, #31
    19d4:	4b000021 	sub	w1, w1, w0
    19d8:	2a0103e0 	mov	w0, w1
    19dc:	531f7800 	lsl	w0, w0, #1
    19e0:	0b010000 	add	w0, w0, w1
    19e4:	4b000041 	sub	w1, w2, w0
    19e8:	7100043f 	cmp	w1, #0x1
    19ec:	540000e1 	b.ne	1a08 <concreate+0xa8>  // b.any
            link("C0", file);
    19f0:	910123e0 	add	x0, sp, #0x48
    19f4:	aa0003e1 	mov	x1, x0
    19f8:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    19fc:	911c2000 	add	x0, x0, #0x708
    1a00:	94000ae7 	bl	459c <link>
    1a04:	14000028 	b	1aa4 <concreate+0x144>
        } else if(pid == 0 && (i % 5) == 1){
    1a08:	b94053e0 	ldr	w0, [sp, #80]
    1a0c:	7100001f 	cmp	w0, #0x0
    1a10:	540002a1 	b.ne	1a64 <concreate+0x104>  // b.any
    1a14:	b9405fe2 	ldr	w2, [sp, #92]
    1a18:	528ccce0 	mov	w0, #0x6667                	// #26215
    1a1c:	72acccc0 	movk	w0, #0x6666, lsl #16
    1a20:	9b207c40 	smull	x0, w2, w0
    1a24:	d360fc00 	lsr	x0, x0, #32
    1a28:	13017c01 	asr	w1, w0, #1
    1a2c:	131f7c40 	asr	w0, w2, #31
    1a30:	4b000021 	sub	w1, w1, w0
    1a34:	2a0103e0 	mov	w0, w1
    1a38:	531e7400 	lsl	w0, w0, #2
    1a3c:	0b010000 	add	w0, w0, w1
    1a40:	4b000041 	sub	w1, w2, w0
    1a44:	7100043f 	cmp	w1, #0x1
    1a48:	540000e1 	b.ne	1a64 <concreate+0x104>  // b.any
            link("C0", file);
    1a4c:	910123e0 	add	x0, sp, #0x48
    1a50:	aa0003e1 	mov	x1, x0
    1a54:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1a58:	911c2000 	add	x0, x0, #0x708
    1a5c:	94000ad0 	bl	459c <link>
    1a60:	14000011 	b	1aa4 <concreate+0x144>
        } else {
            fd = open(file, O_CREATE | O_RDWR);
    1a64:	910123e0 	add	x0, sp, #0x48
    1a68:	52804041 	mov	w1, #0x202                 	// #514
    1a6c:	94000aa8 	bl	450c <open>
    1a70:	b90057e0 	str	w0, [sp, #84]
            if(fd < 0){
    1a74:	b94057e0 	ldr	w0, [sp, #84]
    1a78:	7100001f 	cmp	w0, #0x0
    1a7c:	5400010a 	b.ge	1a9c <concreate+0x13c>  // b.tcont
                printf(1, "concreate create %s failed\n", file);
    1a80:	910123e0 	add	x0, sp, #0x48
    1a84:	aa0003e2 	mov	x2, x0
    1a88:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1a8c:	911c4001 	add	x1, x0, #0x710
    1a90:	52800020 	mov	w0, #0x1                   	// #1
    1a94:	94000b5d 	bl	4808 <printf>
                exit();
    1a98:	94000a55 	bl	43ec <exit>
            }
            close(fd);
    1a9c:	b94057e0 	ldr	w0, [sp, #84]
    1aa0:	94000a80 	bl	44a0 <close>
        }
        if(pid == 0)
    1aa4:	b94053e0 	ldr	w0, [sp, #80]
    1aa8:	7100001f 	cmp	w0, #0x0
    1aac:	54000041 	b.ne	1ab4 <concreate+0x154>  // b.any
            exit();
    1ab0:	94000a4f 	bl	43ec <exit>
        else
            wait();
    1ab4:	94000a57 	bl	4410 <wait>
    for(i = 0; i < 40; i++){
    1ab8:	b9405fe0 	ldr	w0, [sp, #92]
    1abc:	11000400 	add	w0, w0, #0x1
    1ac0:	b9005fe0 	str	w0, [sp, #92]
    1ac4:	b9405fe0 	ldr	w0, [sp, #92]
    1ac8:	71009c1f 	cmp	w0, #0x27
    1acc:	54fff60d 	b.le	198c <concreate+0x2c>
    }
    
    memset(fa, 0, sizeof(fa));
    1ad0:	910083e0 	add	x0, sp, #0x20
    1ad4:	52800502 	mov	w2, #0x28                  	// #40
    1ad8:	52800001 	mov	w1, #0x0                   	// #0
    1adc:	9400096a 	bl	4084 <memset>
    fd = open(".", 0);
    1ae0:	52800001 	mov	w1, #0x0                   	// #0
    1ae4:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1ae8:	911b0000 	add	x0, x0, #0x6c0
    1aec:	94000a88 	bl	450c <open>
    1af0:	b90057e0 	str	w0, [sp, #84]
    n = 0;
    1af4:	b9005bff 	str	wzr, [sp, #88]
    while(read(fd, &de, sizeof(de)) > 0){
    1af8:	14000031 	b	1bbc <concreate+0x25c>
        if(de.inum == 0)
    1afc:	794023e0 	ldrh	w0, [sp, #16]
    1b00:	7100001f 	cmp	w0, #0x0
    1b04:	540005a0 	b.eq	1bb8 <concreate+0x258>  // b.none
            continue;
        if(de.name[0] == 'C' && de.name[2] == '\0'){
    1b08:	39404be0 	ldrb	w0, [sp, #18]
    1b0c:	71010c1f 	cmp	w0, #0x43
    1b10:	54000561 	b.ne	1bbc <concreate+0x25c>  // b.any
    1b14:	394053e0 	ldrb	w0, [sp, #20]
    1b18:	7100001f 	cmp	w0, #0x0
    1b1c:	54000501 	b.ne	1bbc <concreate+0x25c>  // b.any
            i = de.name[1] - '0';
    1b20:	39404fe0 	ldrb	w0, [sp, #19]
    1b24:	5100c000 	sub	w0, w0, #0x30
    1b28:	b9005fe0 	str	w0, [sp, #92]
            if(i < 0 || i >= sizeof(fa)){
    1b2c:	b9405fe0 	ldr	w0, [sp, #92]
    1b30:	7100001f 	cmp	w0, #0x0
    1b34:	5400008b 	b.lt	1b44 <concreate+0x1e4>  // b.tstop
    1b38:	b9405fe0 	ldr	w0, [sp, #92]
    1b3c:	71009c1f 	cmp	w0, #0x27
    1b40:	54000129 	b.ls	1b64 <concreate+0x204>  // b.plast
                printf(1, "concreate weird file %s\n", de.name);
    1b44:	910043e0 	add	x0, sp, #0x10
    1b48:	91000800 	add	x0, x0, #0x2
    1b4c:	aa0003e2 	mov	x2, x0
    1b50:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1b54:	911cc001 	add	x1, x0, #0x730
    1b58:	52800020 	mov	w0, #0x1                   	// #1
    1b5c:	94000b2b 	bl	4808 <printf>
                exit();
    1b60:	94000a23 	bl	43ec <exit>
            }
            if(fa[i]){
    1b64:	b9805fe0 	ldrsw	x0, [sp, #92]
    1b68:	910083e1 	add	x1, sp, #0x20
    1b6c:	38606820 	ldrb	w0, [x1, x0]
    1b70:	7100001f 	cmp	w0, #0x0
    1b74:	54000120 	b.eq	1b98 <concreate+0x238>  // b.none
                printf(1, "concreate duplicate file %s\n", de.name);
    1b78:	910043e0 	add	x0, sp, #0x10
    1b7c:	91000800 	add	x0, x0, #0x2
    1b80:	aa0003e2 	mov	x2, x0
    1b84:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1b88:	911d4001 	add	x1, x0, #0x750
    1b8c:	52800020 	mov	w0, #0x1                   	// #1
    1b90:	94000b1e 	bl	4808 <printf>
                exit();
    1b94:	94000a16 	bl	43ec <exit>
            }
            fa[i] = 1;
    1b98:	b9805fe0 	ldrsw	x0, [sp, #92]
    1b9c:	910083e1 	add	x1, sp, #0x20
    1ba0:	52800022 	mov	w2, #0x1                   	// #1
    1ba4:	38206822 	strb	w2, [x1, x0]
            n++;
    1ba8:	b9405be0 	ldr	w0, [sp, #88]
    1bac:	11000400 	add	w0, w0, #0x1
    1bb0:	b9005be0 	str	w0, [sp, #88]
    1bb4:	14000002 	b	1bbc <concreate+0x25c>
            continue;
    1bb8:	d503201f 	nop
    while(read(fd, &de, sizeof(de)) > 0){
    1bbc:	910043e0 	add	x0, sp, #0x10
    1bc0:	52800202 	mov	w2, #0x10                  	// #16
    1bc4:	aa0003e1 	mov	x1, x0
    1bc8:	b94057e0 	ldr	w0, [sp, #84]
    1bcc:	94000a23 	bl	4458 <read>
    1bd0:	7100001f 	cmp	w0, #0x0
    1bd4:	54fff94c 	b.gt	1afc <concreate+0x19c>
        }
    }
    close(fd);
    1bd8:	b94057e0 	ldr	w0, [sp, #84]
    1bdc:	94000a31 	bl	44a0 <close>
    
    if(n != 40){
    1be0:	b9405be0 	ldr	w0, [sp, #88]
    1be4:	7100a01f 	cmp	w0, #0x28
    1be8:	540000c0 	b.eq	1c00 <concreate+0x2a0>  // b.none
        printf(1, "concreate not enough files in directory listing\n");
    1bec:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1bf0:	911dc001 	add	x1, x0, #0x770
    1bf4:	52800020 	mov	w0, #0x1                   	// #1
    1bf8:	94000b04 	bl	4808 <printf>
        exit();
    1bfc:	940009fc 	bl	43ec <exit>
    }
    
    for(i = 0; i < 40; i++){
    1c00:	b9005fff 	str	wzr, [sp, #92]
    1c04:	14000051 	b	1d48 <concreate+0x3e8>
        file[1] = '0' + i;
    1c08:	b9405fe0 	ldr	w0, [sp, #92]
    1c0c:	12001c00 	and	w0, w0, #0xff
    1c10:	1100c000 	add	w0, w0, #0x30
    1c14:	12001c00 	and	w0, w0, #0xff
    1c18:	390127e0 	strb	w0, [sp, #73]
        pid = fork();
    1c1c:	940009eb 	bl	43c8 <fork>
    1c20:	b90053e0 	str	w0, [sp, #80]
        if(pid < 0){
    1c24:	b94053e0 	ldr	w0, [sp, #80]
    1c28:	7100001f 	cmp	w0, #0x0
    1c2c:	540000ca 	b.ge	1c44 <concreate+0x2e4>  // b.tcont
            printf(1, "fork failed\n");
    1c30:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1c34:	910a4001 	add	x1, x0, #0x290
    1c38:	52800020 	mov	w0, #0x1                   	// #1
    1c3c:	94000af3 	bl	4808 <printf>
            exit();
    1c40:	940009eb 	bl	43ec <exit>
        }
        if(((i % 3) == 0 && pid == 0) ||
    1c44:	b9405fe2 	ldr	w2, [sp, #92]
    1c48:	528aaac0 	mov	w0, #0x5556                	// #21846
    1c4c:	72aaaaa0 	movk	w0, #0x5555, lsl #16
    1c50:	9b207c40 	smull	x0, w2, w0
    1c54:	d360fc01 	lsr	x1, x0, #32
    1c58:	131f7c40 	asr	w0, w2, #31
    1c5c:	4b000021 	sub	w1, w1, w0
    1c60:	2a0103e0 	mov	w0, w1
    1c64:	531f7800 	lsl	w0, w0, #1
    1c68:	0b010000 	add	w0, w0, w1
    1c6c:	4b000041 	sub	w1, w2, w0
    1c70:	7100003f 	cmp	w1, #0x0
    1c74:	54000081 	b.ne	1c84 <concreate+0x324>  // b.any
    1c78:	b94053e0 	ldr	w0, [sp, #80]
    1c7c:	7100001f 	cmp	w0, #0x0
    1c80:	54000220 	b.eq	1cc4 <concreate+0x364>  // b.none
           ((i % 3) == 1 && pid != 0)){
    1c84:	b9405fe2 	ldr	w2, [sp, #92]
    1c88:	528aaac0 	mov	w0, #0x5556                	// #21846
    1c8c:	72aaaaa0 	movk	w0, #0x5555, lsl #16
    1c90:	9b207c40 	smull	x0, w2, w0
    1c94:	d360fc01 	lsr	x1, x0, #32
    1c98:	131f7c40 	asr	w0, w2, #31
    1c9c:	4b000021 	sub	w1, w1, w0
    1ca0:	2a0103e0 	mov	w0, w1
    1ca4:	531f7800 	lsl	w0, w0, #1
    1ca8:	0b010000 	add	w0, w0, w1
    1cac:	4b000041 	sub	w1, w2, w0
        if(((i % 3) == 0 && pid == 0) ||
    1cb0:	7100043f 	cmp	w1, #0x1
    1cb4:	540002a1 	b.ne	1d08 <concreate+0x3a8>  // b.any
           ((i % 3) == 1 && pid != 0)){
    1cb8:	b94053e0 	ldr	w0, [sp, #80]
    1cbc:	7100001f 	cmp	w0, #0x0
    1cc0:	54000240 	b.eq	1d08 <concreate+0x3a8>  // b.none
            close(open(file, 0));
    1cc4:	910123e0 	add	x0, sp, #0x48
    1cc8:	52800001 	mov	w1, #0x0                   	// #0
    1ccc:	94000a10 	bl	450c <open>
    1cd0:	940009f4 	bl	44a0 <close>
            close(open(file, 0));
    1cd4:	910123e0 	add	x0, sp, #0x48
    1cd8:	52800001 	mov	w1, #0x0                   	// #0
    1cdc:	94000a0c 	bl	450c <open>
    1ce0:	940009f0 	bl	44a0 <close>
            close(open(file, 0));
    1ce4:	910123e0 	add	x0, sp, #0x48
    1ce8:	52800001 	mov	w1, #0x0                   	// #0
    1cec:	94000a08 	bl	450c <open>
    1cf0:	940009ec 	bl	44a0 <close>
            close(open(file, 0));
    1cf4:	910123e0 	add	x0, sp, #0x48
    1cf8:	52800001 	mov	w1, #0x0                   	// #0
    1cfc:	94000a04 	bl	450c <open>
    1d00:	940009e8 	bl	44a0 <close>
    1d04:	14000009 	b	1d28 <concreate+0x3c8>
        } else {
            unlink(file);
    1d08:	910123e0 	add	x0, sp, #0x48
    1d0c:	94000a12 	bl	4554 <unlink>
            unlink(file);
    1d10:	910123e0 	add	x0, sp, #0x48
    1d14:	94000a10 	bl	4554 <unlink>
            unlink(file);
    1d18:	910123e0 	add	x0, sp, #0x48
    1d1c:	94000a0e 	bl	4554 <unlink>
            unlink(file);
    1d20:	910123e0 	add	x0, sp, #0x48
    1d24:	94000a0c 	bl	4554 <unlink>
        }
        if(pid == 0)
    1d28:	b94053e0 	ldr	w0, [sp, #80]
    1d2c:	7100001f 	cmp	w0, #0x0
    1d30:	54000041 	b.ne	1d38 <concreate+0x3d8>  // b.any
            exit();
    1d34:	940009ae 	bl	43ec <exit>
        else
            wait();
    1d38:	940009b6 	bl	4410 <wait>
    for(i = 0; i < 40; i++){
    1d3c:	b9405fe0 	ldr	w0, [sp, #92]
    1d40:	11000400 	add	w0, w0, #0x1
    1d44:	b9005fe0 	str	w0, [sp, #92]
    1d48:	b9405fe0 	ldr	w0, [sp, #92]
    1d4c:	71009c1f 	cmp	w0, #0x27
    1d50:	54fff5cd 	b.le	1c08 <concreate+0x2a8>
    }
    
    printf(1, "concreate ok\n");
    1d54:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1d58:	911ea001 	add	x1, x0, #0x7a8
    1d5c:	52800020 	mov	w0, #0x1                   	// #1
    1d60:	94000aaa 	bl	4808 <printf>
}
    1d64:	d503201f 	nop
    1d68:	a8c67bfd 	ldp	x29, x30, [sp], #96
    1d6c:	d65f03c0 	ret

0000000000001d70 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1d70:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    1d74:	910003fd 	mov	x29, sp
    int pid, i;
    
    printf(1, "linkunlink test\n");
    1d78:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1d7c:	911ee001 	add	x1, x0, #0x7b8
    1d80:	52800020 	mov	w0, #0x1                   	// #1
    1d84:	94000aa1 	bl	4808 <printf>
    
    unlink("x");
    1d88:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1d8c:	9108a000 	add	x0, x0, #0x228
    1d90:	940009f1 	bl	4554 <unlink>
    pid = fork();
    1d94:	9400098d 	bl	43c8 <fork>
    1d98:	b90017e0 	str	w0, [sp, #20]
    if(pid < 0){
    1d9c:	b94017e0 	ldr	w0, [sp, #20]
    1da0:	7100001f 	cmp	w0, #0x0
    1da4:	540000ca 	b.ge	1dbc <linkunlink+0x4c>  // b.tcont
        printf(1, "fork failed\n");
    1da8:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1dac:	910a4001 	add	x1, x0, #0x290
    1db0:	52800020 	mov	w0, #0x1                   	// #1
    1db4:	94000a95 	bl	4808 <printf>
        exit();
    1db8:	9400098d 	bl	43ec <exit>
    }
    
    unsigned int x = (pid ? 1 : 97);
    1dbc:	b94017e0 	ldr	w0, [sp, #20]
    1dc0:	7100001f 	cmp	w0, #0x0
    1dc4:	54000080 	b.eq	1dd4 <linkunlink+0x64>  // b.none
    1dc8:	52800020 	mov	w0, #0x1                   	// #1
    1dcc:	b9001be0 	str	w0, [sp, #24]
    1dd0:	14000003 	b	1ddc <linkunlink+0x6c>
    1dd4:	52800c20 	mov	w0, #0x61                  	// #97
    1dd8:	b9001be0 	str	w0, [sp, #24]
    for(i = 0; i < 100; i++){
    1ddc:	b9001fff 	str	wzr, [sp, #28]
    1de0:	14000032 	b	1ea8 <linkunlink+0x138>
        x = x * 1103515245 + 12345;
    1de4:	b9401be1 	ldr	w1, [sp, #24]
    1de8:	5289cda0 	mov	w0, #0x4e6d                	// #20077
    1dec:	72a838c0 	movk	w0, #0x41c6, lsl #16
    1df0:	1b007c21 	mul	w1, w1, w0
    1df4:	52860720 	mov	w0, #0x3039                	// #12345
    1df8:	0b000020 	add	w0, w1, w0
    1dfc:	b9001be0 	str	w0, [sp, #24]
        if((x % 3) == 0){
    1e00:	b9401be2 	ldr	w2, [sp, #24]
    1e04:	52955560 	mov	w0, #0xaaab                	// #43691
    1e08:	72b55540 	movk	w0, #0xaaaa, lsl #16
    1e0c:	9ba07c40 	umull	x0, w2, w0
    1e10:	d360fc00 	lsr	x0, x0, #32
    1e14:	53017c01 	lsr	w1, w0, #1
    1e18:	2a0103e0 	mov	w0, w1
    1e1c:	531f7800 	lsl	w0, w0, #1
    1e20:	0b010000 	add	w0, w0, w1
    1e24:	4b000041 	sub	w1, w2, w0
    1e28:	7100003f 	cmp	w1, #0x0
    1e2c:	540000e1 	b.ne	1e48 <linkunlink+0xd8>  // b.any
            close(open("x", O_RDWR | O_CREATE));
    1e30:	52804041 	mov	w1, #0x202                 	// #514
    1e34:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1e38:	9108a000 	add	x0, x0, #0x228
    1e3c:	940009b4 	bl	450c <open>
    1e40:	94000998 	bl	44a0 <close>
    1e44:	14000016 	b	1e9c <linkunlink+0x12c>
        } else if((x % 3) == 1){
    1e48:	b9401be2 	ldr	w2, [sp, #24]
    1e4c:	52955560 	mov	w0, #0xaaab                	// #43691
    1e50:	72b55540 	movk	w0, #0xaaaa, lsl #16
    1e54:	9ba07c40 	umull	x0, w2, w0
    1e58:	d360fc00 	lsr	x0, x0, #32
    1e5c:	53017c01 	lsr	w1, w0, #1
    1e60:	2a0103e0 	mov	w0, w1
    1e64:	531f7800 	lsl	w0, w0, #1
    1e68:	0b010000 	add	w0, w0, w1
    1e6c:	4b000041 	sub	w1, w2, w0
    1e70:	7100043f 	cmp	w1, #0x1
    1e74:	540000e1 	b.ne	1e90 <linkunlink+0x120>  // b.any
            link("cat", "x");
    1e78:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1e7c:	9108a001 	add	x1, x0, #0x228
    1e80:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1e84:	911f4000 	add	x0, x0, #0x7d0
    1e88:	940009c5 	bl	459c <link>
    1e8c:	14000004 	b	1e9c <linkunlink+0x12c>
        } else {
            unlink("x");
    1e90:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1e94:	9108a000 	add	x0, x0, #0x228
    1e98:	940009af 	bl	4554 <unlink>
    for(i = 0; i < 100; i++){
    1e9c:	b9401fe0 	ldr	w0, [sp, #28]
    1ea0:	11000400 	add	w0, w0, #0x1
    1ea4:	b9001fe0 	str	w0, [sp, #28]
    1ea8:	b9401fe0 	ldr	w0, [sp, #28]
    1eac:	71018c1f 	cmp	w0, #0x63
    1eb0:	54fff9ad 	b.le	1de4 <linkunlink+0x74>
        }
    }
    
    if(pid)
    1eb4:	b94017e0 	ldr	w0, [sp, #20]
    1eb8:	7100001f 	cmp	w0, #0x0
    1ebc:	540000e0 	b.eq	1ed8 <linkunlink+0x168>  // b.none
        wait();
    1ec0:	94000954 	bl	4410 <wait>
    else
        exit();
    
    printf(1, "linkunlink ok\n");
    1ec4:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1ec8:	911f6001 	add	x1, x0, #0x7d8
    1ecc:	52800020 	mov	w0, #0x1                   	// #1
    1ed0:	94000a4e 	bl	4808 <printf>
}
    1ed4:	14000002 	b	1edc <linkunlink+0x16c>
        exit();
    1ed8:	94000945 	bl	43ec <exit>
}
    1edc:	a8c27bfd 	ldp	x29, x30, [sp], #32
    1ee0:	d65f03c0 	ret

0000000000001ee4 <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    1ee4:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
    1ee8:	910003fd 	mov	x29, sp
    int i, fd;
    char name[10];
    
    printf(1, "bigdir test\n");
    1eec:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1ef0:	911fa001 	add	x1, x0, #0x7e8
    1ef4:	52800020 	mov	w0, #0x1                   	// #1
    1ef8:	94000a44 	bl	4808 <printf>
    unlink("bd");
    1efc:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1f00:	911fe000 	add	x0, x0, #0x7f8
    1f04:	94000994 	bl	4554 <unlink>
    
    fd = open("bd", O_CREATE);
    1f08:	52804001 	mov	w1, #0x200                 	// #512
    1f0c:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1f10:	911fe000 	add	x0, x0, #0x7f8
    1f14:	9400097e 	bl	450c <open>
    1f18:	b9002be0 	str	w0, [sp, #40]
    if(fd < 0){
    1f1c:	b9402be0 	ldr	w0, [sp, #40]
    1f20:	7100001f 	cmp	w0, #0x0
    1f24:	540000ca 	b.ge	1f3c <bigdir+0x58>  // b.tcont
        printf(1, "bigdir create failed\n");
    1f28:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1f2c:	91200001 	add	x1, x0, #0x800
    1f30:	52800020 	mov	w0, #0x1                   	// #1
    1f34:	94000a35 	bl	4808 <printf>
        exit();
    1f38:	9400092d 	bl	43ec <exit>
    }
    close(fd);
    1f3c:	b9402be0 	ldr	w0, [sp, #40]
    1f40:	94000958 	bl	44a0 <close>
    
    for(i = 0; i < 500; i++){
    1f44:	b9002fff 	str	wzr, [sp, #44]
    1f48:	14000025 	b	1fdc <bigdir+0xf8>
        name[0] = 'x';
    1f4c:	52800f00 	mov	w0, #0x78                  	// #120
    1f50:	390063e0 	strb	w0, [sp, #24]
        name[1] = '0' + (i / 64);
    1f54:	b9402fe0 	ldr	w0, [sp, #44]
    1f58:	1100fc01 	add	w1, w0, #0x3f
    1f5c:	7100001f 	cmp	w0, #0x0
    1f60:	1a80b020 	csel	w0, w1, w0, lt	// lt = tstop
    1f64:	13067c00 	asr	w0, w0, #6
    1f68:	12001c00 	and	w0, w0, #0xff
    1f6c:	1100c000 	add	w0, w0, #0x30
    1f70:	12001c00 	and	w0, w0, #0xff
    1f74:	390067e0 	strb	w0, [sp, #25]
        name[2] = '0' + (i % 64);
    1f78:	b9402fe0 	ldr	w0, [sp, #44]
    1f7c:	6b0003e1 	negs	w1, w0
    1f80:	12001400 	and	w0, w0, #0x3f
    1f84:	12001421 	and	w1, w1, #0x3f
    1f88:	5a814400 	csneg	w0, w0, w1, mi	// mi = first
    1f8c:	12001c00 	and	w0, w0, #0xff
    1f90:	1100c000 	add	w0, w0, #0x30
    1f94:	12001c00 	and	w0, w0, #0xff
    1f98:	39006be0 	strb	w0, [sp, #26]
        name[3] = '\0';
    1f9c:	39006fff 	strb	wzr, [sp, #27]
        if(link("bd", name) != 0){
    1fa0:	910063e0 	add	x0, sp, #0x18
    1fa4:	aa0003e1 	mov	x1, x0
    1fa8:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1fac:	911fe000 	add	x0, x0, #0x7f8
    1fb0:	9400097b 	bl	459c <link>
    1fb4:	7100001f 	cmp	w0, #0x0
    1fb8:	540000c0 	b.eq	1fd0 <bigdir+0xec>  // b.none
            printf(1, "bigdir link failed\n");
    1fbc:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1fc0:	91206001 	add	x1, x0, #0x818
    1fc4:	52800020 	mov	w0, #0x1                   	// #1
    1fc8:	94000a10 	bl	4808 <printf>
            exit();
    1fcc:	94000908 	bl	43ec <exit>
    for(i = 0; i < 500; i++){
    1fd0:	b9402fe0 	ldr	w0, [sp, #44]
    1fd4:	11000400 	add	w0, w0, #0x1
    1fd8:	b9002fe0 	str	w0, [sp, #44]
    1fdc:	b9402fe0 	ldr	w0, [sp, #44]
    1fe0:	7107cc1f 	cmp	w0, #0x1f3
    1fe4:	54fffb4d 	b.le	1f4c <bigdir+0x68>
        }
    }
    
    unlink("bd");
    1fe8:	90000020 	adrp	x0, 5000 <malloc+0x3a8>
    1fec:	911fe000 	add	x0, x0, #0x7f8
    1ff0:	94000959 	bl	4554 <unlink>
    for(i = 0; i < 500; i++){
    1ff4:	b9002fff 	str	wzr, [sp, #44]
    1ff8:	14000022 	b	2080 <bigdir+0x19c>
        name[0] = 'x';
    1ffc:	52800f00 	mov	w0, #0x78                  	// #120
    2000:	390063e0 	strb	w0, [sp, #24]
        name[1] = '0' + (i / 64);
    2004:	b9402fe0 	ldr	w0, [sp, #44]
    2008:	1100fc01 	add	w1, w0, #0x3f
    200c:	7100001f 	cmp	w0, #0x0
    2010:	1a80b020 	csel	w0, w1, w0, lt	// lt = tstop
    2014:	13067c00 	asr	w0, w0, #6
    2018:	12001c00 	and	w0, w0, #0xff
    201c:	1100c000 	add	w0, w0, #0x30
    2020:	12001c00 	and	w0, w0, #0xff
    2024:	390067e0 	strb	w0, [sp, #25]
        name[2] = '0' + (i % 64);
    2028:	b9402fe0 	ldr	w0, [sp, #44]
    202c:	6b0003e1 	negs	w1, w0
    2030:	12001400 	and	w0, w0, #0x3f
    2034:	12001421 	and	w1, w1, #0x3f
    2038:	5a814400 	csneg	w0, w0, w1, mi	// mi = first
    203c:	12001c00 	and	w0, w0, #0xff
    2040:	1100c000 	add	w0, w0, #0x30
    2044:	12001c00 	and	w0, w0, #0xff
    2048:	39006be0 	strb	w0, [sp, #26]
        name[3] = '\0';
    204c:	39006fff 	strb	wzr, [sp, #27]
        if(unlink(name) != 0){
    2050:	910063e0 	add	x0, sp, #0x18
    2054:	94000940 	bl	4554 <unlink>
    2058:	7100001f 	cmp	w0, #0x0
    205c:	540000c0 	b.eq	2074 <bigdir+0x190>  // b.none
            printf(1, "bigdir unlink failed");
    2060:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2064:	9120c001 	add	x1, x0, #0x830
    2068:	52800020 	mov	w0, #0x1                   	// #1
    206c:	940009e7 	bl	4808 <printf>
            exit();
    2070:	940008df 	bl	43ec <exit>
    for(i = 0; i < 500; i++){
    2074:	b9402fe0 	ldr	w0, [sp, #44]
    2078:	11000400 	add	w0, w0, #0x1
    207c:	b9002fe0 	str	w0, [sp, #44]
    2080:	b9402fe0 	ldr	w0, [sp, #44]
    2084:	7107cc1f 	cmp	w0, #0x1f3
    2088:	54fffbad 	b.le	1ffc <bigdir+0x118>
        }
    }
    
    printf(1, "bigdir ok\n");
    208c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2090:	91212001 	add	x1, x0, #0x848
    2094:	52800020 	mov	w0, #0x1                   	// #1
    2098:	940009dc 	bl	4808 <printf>
}
    209c:	d503201f 	nop
    20a0:	a8c37bfd 	ldp	x29, x30, [sp], #48
    20a4:	d65f03c0 	ret

00000000000020a8 <subdir>:

void
subdir(void)
{
    20a8:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    20ac:	910003fd 	mov	x29, sp
    int fd, cc;
    
    printf(1, "subdir test\n");
    20b0:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    20b4:	91216001 	add	x1, x0, #0x858
    20b8:	52800020 	mov	w0, #0x1                   	// #1
    20bc:	940009d3 	bl	4808 <printf>
    
    unlink("ff");
    20c0:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    20c4:	9121a000 	add	x0, x0, #0x868
    20c8:	94000923 	bl	4554 <unlink>
    if(mkdir("dd") != 0){
    20cc:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    20d0:	9121c000 	add	x0, x0, #0x870
    20d4:	9400093b 	bl	45c0 <mkdir>
    20d8:	7100001f 	cmp	w0, #0x0
    20dc:	540000c0 	b.eq	20f4 <subdir+0x4c>  // b.none
        printf(1, "subdir mkdir dd failed\n");
    20e0:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    20e4:	9121e001 	add	x1, x0, #0x878
    20e8:	52800020 	mov	w0, #0x1                   	// #1
    20ec:	940009c7 	bl	4808 <printf>
        exit();
    20f0:	940008bf 	bl	43ec <exit>
    }
    
    fd = open("dd/ff", O_CREATE | O_RDWR);
    20f4:	52804041 	mov	w1, #0x202                 	// #514
    20f8:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    20fc:	91224000 	add	x0, x0, #0x890
    2100:	94000903 	bl	450c <open>
    2104:	b9001fe0 	str	w0, [sp, #28]
    if(fd < 0){
    2108:	b9401fe0 	ldr	w0, [sp, #28]
    210c:	7100001f 	cmp	w0, #0x0
    2110:	540000ca 	b.ge	2128 <subdir+0x80>  // b.tcont
        printf(1, "create dd/ff failed\n");
    2114:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2118:	91226001 	add	x1, x0, #0x898
    211c:	52800020 	mov	w0, #0x1                   	// #1
    2120:	940009ba 	bl	4808 <printf>
        exit();
    2124:	940008b2 	bl	43ec <exit>
    }
    write(fd, "ff", 2);
    2128:	52800042 	mov	w2, #0x2                   	// #2
    212c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2130:	9121a001 	add	x1, x0, #0x868
    2134:	b9401fe0 	ldr	w0, [sp, #28]
    2138:	940008d1 	bl	447c <write>
    close(fd);
    213c:	b9401fe0 	ldr	w0, [sp, #28]
    2140:	940008d8 	bl	44a0 <close>
    
    if(unlink("dd") >= 0){
    2144:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2148:	9121c000 	add	x0, x0, #0x870
    214c:	94000902 	bl	4554 <unlink>
    2150:	7100001f 	cmp	w0, #0x0
    2154:	540000cb 	b.lt	216c <subdir+0xc4>  // b.tstop
        printf(1, "unlink dd (non-empty dir) succeeded!\n");
    2158:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    215c:	9122c001 	add	x1, x0, #0x8b0
    2160:	52800020 	mov	w0, #0x1                   	// #1
    2164:	940009a9 	bl	4808 <printf>
        exit();
    2168:	940008a1 	bl	43ec <exit>
    }
    
    if(mkdir("/dd/dd") != 0){
    216c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2170:	91236000 	add	x0, x0, #0x8d8
    2174:	94000913 	bl	45c0 <mkdir>
    2178:	7100001f 	cmp	w0, #0x0
    217c:	540000c0 	b.eq	2194 <subdir+0xec>  // b.none
        printf(1, "subdir mkdir dd/dd failed\n");
    2180:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2184:	91238001 	add	x1, x0, #0x8e0
    2188:	52800020 	mov	w0, #0x1                   	// #1
    218c:	9400099f 	bl	4808 <printf>
        exit();
    2190:	94000897 	bl	43ec <exit>
    }
    
    fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    2194:	52804041 	mov	w1, #0x202                 	// #514
    2198:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    219c:	91240000 	add	x0, x0, #0x900
    21a0:	940008db 	bl	450c <open>
    21a4:	b9001fe0 	str	w0, [sp, #28]
    if(fd < 0){
    21a8:	b9401fe0 	ldr	w0, [sp, #28]
    21ac:	7100001f 	cmp	w0, #0x0
    21b0:	540000ca 	b.ge	21c8 <subdir+0x120>  // b.tcont
        printf(1, "create dd/dd/ff failed\n");
    21b4:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    21b8:	91244001 	add	x1, x0, #0x910
    21bc:	52800020 	mov	w0, #0x1                   	// #1
    21c0:	94000992 	bl	4808 <printf>
        exit();
    21c4:	9400088a 	bl	43ec <exit>
    }
    write(fd, "FF", 2);
    21c8:	52800042 	mov	w2, #0x2                   	// #2
    21cc:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    21d0:	9124a001 	add	x1, x0, #0x928
    21d4:	b9401fe0 	ldr	w0, [sp, #28]
    21d8:	940008a9 	bl	447c <write>
    close(fd);
    21dc:	b9401fe0 	ldr	w0, [sp, #28]
    21e0:	940008b0 	bl	44a0 <close>
    
    fd = open("dd/dd/../ff", 0);
    21e4:	52800001 	mov	w1, #0x0                   	// #0
    21e8:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    21ec:	9124c000 	add	x0, x0, #0x930
    21f0:	940008c7 	bl	450c <open>
    21f4:	b9001fe0 	str	w0, [sp, #28]
    if(fd < 0){
    21f8:	b9401fe0 	ldr	w0, [sp, #28]
    21fc:	7100001f 	cmp	w0, #0x0
    2200:	540000ca 	b.ge	2218 <subdir+0x170>  // b.tcont
        printf(1, "open dd/dd/../ff failed\n");
    2204:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2208:	91250001 	add	x1, x0, #0x940
    220c:	52800020 	mov	w0, #0x1                   	// #1
    2210:	9400097e 	bl	4808 <printf>
        exit();
    2214:	94000876 	bl	43ec <exit>
    }
    cc = read(fd, buf, sizeof(buf));
    2218:	52840002 	mov	w2, #0x2000                	// #8192
    221c:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2220:	91228001 	add	x1, x0, #0x8a0
    2224:	b9401fe0 	ldr	w0, [sp, #28]
    2228:	9400088c 	bl	4458 <read>
    222c:	b9001be0 	str	w0, [sp, #24]
    if(cc != 2 || buf[0] != 'f'){
    2230:	b9401be0 	ldr	w0, [sp, #24]
    2234:	7100081f 	cmp	w0, #0x2
    2238:	540000c1 	b.ne	2250 <subdir+0x1a8>  // b.any
    223c:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2240:	91228000 	add	x0, x0, #0x8a0
    2244:	39400000 	ldrb	w0, [x0]
    2248:	7101981f 	cmp	w0, #0x66
    224c:	540000c0 	b.eq	2264 <subdir+0x1bc>  // b.none
        printf(1, "dd/dd/../ff wrong content\n");
    2250:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2254:	91258001 	add	x1, x0, #0x960
    2258:	52800020 	mov	w0, #0x1                   	// #1
    225c:	9400096b 	bl	4808 <printf>
        exit();
    2260:	94000863 	bl	43ec <exit>
    }
    close(fd);
    2264:	b9401fe0 	ldr	w0, [sp, #28]
    2268:	9400088e 	bl	44a0 <close>
    
    if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    226c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2270:	91260001 	add	x1, x0, #0x980
    2274:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2278:	91240000 	add	x0, x0, #0x900
    227c:	940008c8 	bl	459c <link>
    2280:	7100001f 	cmp	w0, #0x0
    2284:	540000c0 	b.eq	229c <subdir+0x1f4>  // b.none
        printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    2288:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    228c:	91264001 	add	x1, x0, #0x990
    2290:	52800020 	mov	w0, #0x1                   	// #1
    2294:	9400095d 	bl	4808 <printf>
        exit();
    2298:	94000855 	bl	43ec <exit>
    }
    
    if(unlink("dd/dd/ff") != 0){
    229c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    22a0:	91240000 	add	x0, x0, #0x900
    22a4:	940008ac 	bl	4554 <unlink>
    22a8:	7100001f 	cmp	w0, #0x0
    22ac:	540000c0 	b.eq	22c4 <subdir+0x21c>  // b.none
        printf(1, "unlink dd/dd/ff failed\n");
    22b0:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    22b4:	9126e001 	add	x1, x0, #0x9b8
    22b8:	52800020 	mov	w0, #0x1                   	// #1
    22bc:	94000953 	bl	4808 <printf>
        exit();
    22c0:	9400084b 	bl	43ec <exit>
    }
    if(open("dd/dd/ff", O_RDONLY) >= 0){
    22c4:	52800001 	mov	w1, #0x0                   	// #0
    22c8:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    22cc:	91240000 	add	x0, x0, #0x900
    22d0:	9400088f 	bl	450c <open>
    22d4:	7100001f 	cmp	w0, #0x0
    22d8:	540000cb 	b.lt	22f0 <subdir+0x248>  // b.tstop
        printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    22dc:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    22e0:	91274001 	add	x1, x0, #0x9d0
    22e4:	52800020 	mov	w0, #0x1                   	// #1
    22e8:	94000948 	bl	4808 <printf>
        exit();
    22ec:	94000840 	bl	43ec <exit>
    }
    
    if(chdir("dd") != 0){
    22f0:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    22f4:	9121c000 	add	x0, x0, #0x870
    22f8:	940008bb 	bl	45e4 <chdir>
    22fc:	7100001f 	cmp	w0, #0x0
    2300:	540000c0 	b.eq	2318 <subdir+0x270>  // b.none
        printf(1, "chdir dd failed\n");
    2304:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2308:	9127e001 	add	x1, x0, #0x9f8
    230c:	52800020 	mov	w0, #0x1                   	// #1
    2310:	9400093e 	bl	4808 <printf>
        exit();
    2314:	94000836 	bl	43ec <exit>
    }
    if(chdir("dd/../../dd") != 0){
    2318:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    231c:	91284000 	add	x0, x0, #0xa10
    2320:	940008b1 	bl	45e4 <chdir>
    2324:	7100001f 	cmp	w0, #0x0
    2328:	540000c0 	b.eq	2340 <subdir+0x298>  // b.none
        printf(1, "chdir dd/../../dd failed\n");
    232c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2330:	91288001 	add	x1, x0, #0xa20
    2334:	52800020 	mov	w0, #0x1                   	// #1
    2338:	94000934 	bl	4808 <printf>
        exit();
    233c:	9400082c 	bl	43ec <exit>
    }
    if(chdir("dd/../../../dd") != 0){
    2340:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2344:	91290000 	add	x0, x0, #0xa40
    2348:	940008a7 	bl	45e4 <chdir>
    234c:	7100001f 	cmp	w0, #0x0
    2350:	540000c0 	b.eq	2368 <subdir+0x2c0>  // b.none
        printf(1, "chdir dd/../../dd failed\n");
    2354:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2358:	91288001 	add	x1, x0, #0xa20
    235c:	52800020 	mov	w0, #0x1                   	// #1
    2360:	9400092a 	bl	4808 <printf>
        exit();
    2364:	94000822 	bl	43ec <exit>
    }
    if(chdir("./..") != 0){
    2368:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    236c:	91294000 	add	x0, x0, #0xa50
    2370:	9400089d 	bl	45e4 <chdir>
    2374:	7100001f 	cmp	w0, #0x0
    2378:	540000c0 	b.eq	2390 <subdir+0x2e8>  // b.none
        printf(1, "chdir ./.. failed\n");
    237c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2380:	91296001 	add	x1, x0, #0xa58
    2384:	52800020 	mov	w0, #0x1                   	// #1
    2388:	94000920 	bl	4808 <printf>
        exit();
    238c:	94000818 	bl	43ec <exit>
    }
    
    fd = open("dd/dd/ffff", 0);
    2390:	52800001 	mov	w1, #0x0                   	// #0
    2394:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2398:	91260000 	add	x0, x0, #0x980
    239c:	9400085c 	bl	450c <open>
    23a0:	b9001fe0 	str	w0, [sp, #28]
    if(fd < 0){
    23a4:	b9401fe0 	ldr	w0, [sp, #28]
    23a8:	7100001f 	cmp	w0, #0x0
    23ac:	540000ca 	b.ge	23c4 <subdir+0x31c>  // b.tcont
        printf(1, "open dd/dd/ffff failed\n");
    23b0:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    23b4:	9129c001 	add	x1, x0, #0xa70
    23b8:	52800020 	mov	w0, #0x1                   	// #1
    23bc:	94000913 	bl	4808 <printf>
        exit();
    23c0:	9400080b 	bl	43ec <exit>
    }
    if(read(fd, buf, sizeof(buf)) != 2){
    23c4:	52840002 	mov	w2, #0x2000                	// #8192
    23c8:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    23cc:	91228001 	add	x1, x0, #0x8a0
    23d0:	b9401fe0 	ldr	w0, [sp, #28]
    23d4:	94000821 	bl	4458 <read>
    23d8:	7100081f 	cmp	w0, #0x2
    23dc:	540000c0 	b.eq	23f4 <subdir+0x34c>  // b.none
        printf(1, "read dd/dd/ffff wrong len\n");
    23e0:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    23e4:	912a2001 	add	x1, x0, #0xa88
    23e8:	52800020 	mov	w0, #0x1                   	// #1
    23ec:	94000907 	bl	4808 <printf>
        exit();
    23f0:	940007ff 	bl	43ec <exit>
    }
    close(fd);
    23f4:	b9401fe0 	ldr	w0, [sp, #28]
    23f8:	9400082a 	bl	44a0 <close>
    
    if(open("dd/dd/ff", O_RDONLY) >= 0){
    23fc:	52800001 	mov	w1, #0x0                   	// #0
    2400:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2404:	91240000 	add	x0, x0, #0x900
    2408:	94000841 	bl	450c <open>
    240c:	7100001f 	cmp	w0, #0x0
    2410:	540000cb 	b.lt	2428 <subdir+0x380>  // b.tstop
        printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    2414:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2418:	912aa001 	add	x1, x0, #0xaa8
    241c:	52800020 	mov	w0, #0x1                   	// #1
    2420:	940008fa 	bl	4808 <printf>
        exit();
    2424:	940007f2 	bl	43ec <exit>
    }
    
    if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    2428:	52804041 	mov	w1, #0x202                 	// #514
    242c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2430:	912b4000 	add	x0, x0, #0xad0
    2434:	94000836 	bl	450c <open>
    2438:	7100001f 	cmp	w0, #0x0
    243c:	540000cb 	b.lt	2454 <subdir+0x3ac>  // b.tstop
        printf(1, "create dd/ff/ff succeeded!\n");
    2440:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2444:	912b8001 	add	x1, x0, #0xae0
    2448:	52800020 	mov	w0, #0x1                   	// #1
    244c:	940008ef 	bl	4808 <printf>
        exit();
    2450:	940007e7 	bl	43ec <exit>
    }
    if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    2454:	52804041 	mov	w1, #0x202                 	// #514
    2458:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    245c:	912c0000 	add	x0, x0, #0xb00
    2460:	9400082b 	bl	450c <open>
    2464:	7100001f 	cmp	w0, #0x0
    2468:	540000cb 	b.lt	2480 <subdir+0x3d8>  // b.tstop
        printf(1, "create dd/xx/ff succeeded!\n");
    246c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2470:	912c4001 	add	x1, x0, #0xb10
    2474:	52800020 	mov	w0, #0x1                   	// #1
    2478:	940008e4 	bl	4808 <printf>
        exit();
    247c:	940007dc 	bl	43ec <exit>
    }
    if(open("dd", O_CREATE) >= 0){
    2480:	52804001 	mov	w1, #0x200                 	// #512
    2484:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2488:	9121c000 	add	x0, x0, #0x870
    248c:	94000820 	bl	450c <open>
    2490:	7100001f 	cmp	w0, #0x0
    2494:	540000cb 	b.lt	24ac <subdir+0x404>  // b.tstop
        printf(1, "create dd succeeded!\n");
    2498:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    249c:	912cc001 	add	x1, x0, #0xb30
    24a0:	52800020 	mov	w0, #0x1                   	// #1
    24a4:	940008d9 	bl	4808 <printf>
        exit();
    24a8:	940007d1 	bl	43ec <exit>
    }
    if(open("dd", O_RDWR) >= 0){
    24ac:	52800041 	mov	w1, #0x2                   	// #2
    24b0:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    24b4:	9121c000 	add	x0, x0, #0x870
    24b8:	94000815 	bl	450c <open>
    24bc:	7100001f 	cmp	w0, #0x0
    24c0:	540000cb 	b.lt	24d8 <subdir+0x430>  // b.tstop
        printf(1, "open dd rdwr succeeded!\n");
    24c4:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    24c8:	912d2001 	add	x1, x0, #0xb48
    24cc:	52800020 	mov	w0, #0x1                   	// #1
    24d0:	940008ce 	bl	4808 <printf>
        exit();
    24d4:	940007c6 	bl	43ec <exit>
    }
    if(open("dd", O_WRONLY) >= 0){
    24d8:	52800021 	mov	w1, #0x1                   	// #1
    24dc:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    24e0:	9121c000 	add	x0, x0, #0x870
    24e4:	9400080a 	bl	450c <open>
    24e8:	7100001f 	cmp	w0, #0x0
    24ec:	540000cb 	b.lt	2504 <subdir+0x45c>  // b.tstop
        printf(1, "open dd wronly succeeded!\n");
    24f0:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    24f4:	912da001 	add	x1, x0, #0xb68
    24f8:	52800020 	mov	w0, #0x1                   	// #1
    24fc:	940008c3 	bl	4808 <printf>
        exit();
    2500:	940007bb 	bl	43ec <exit>
    }
    if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2504:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2508:	912e2001 	add	x1, x0, #0xb88
    250c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2510:	912b4000 	add	x0, x0, #0xad0
    2514:	94000822 	bl	459c <link>
    2518:	7100001f 	cmp	w0, #0x0
    251c:	540000c1 	b.ne	2534 <subdir+0x48c>  // b.any
        printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    2520:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2524:	912e6001 	add	x1, x0, #0xb98
    2528:	52800020 	mov	w0, #0x1                   	// #1
    252c:	940008b7 	bl	4808 <printf>
        exit();
    2530:	940007af 	bl	43ec <exit>
    }
    if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2534:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2538:	912e2001 	add	x1, x0, #0xb88
    253c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2540:	912c0000 	add	x0, x0, #0xb00
    2544:	94000816 	bl	459c <link>
    2548:	7100001f 	cmp	w0, #0x0
    254c:	540000c1 	b.ne	2564 <subdir+0x4bc>  // b.any
        printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    2550:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2554:	912f0001 	add	x1, x0, #0xbc0
    2558:	52800020 	mov	w0, #0x1                   	// #1
    255c:	940008ab 	bl	4808 <printf>
        exit();
    2560:	940007a3 	bl	43ec <exit>
    }
    if(link("dd/ff", "dd/dd/ffff") == 0){
    2564:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2568:	91260001 	add	x1, x0, #0x980
    256c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2570:	91224000 	add	x0, x0, #0x890
    2574:	9400080a 	bl	459c <link>
    2578:	7100001f 	cmp	w0, #0x0
    257c:	540000c1 	b.ne	2594 <subdir+0x4ec>  // b.any
        printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    2580:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2584:	912fa001 	add	x1, x0, #0xbe8
    2588:	52800020 	mov	w0, #0x1                   	// #1
    258c:	9400089f 	bl	4808 <printf>
        exit();
    2590:	94000797 	bl	43ec <exit>
    }
    if(mkdir("dd/ff/ff") == 0){
    2594:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2598:	912b4000 	add	x0, x0, #0xad0
    259c:	94000809 	bl	45c0 <mkdir>
    25a0:	7100001f 	cmp	w0, #0x0
    25a4:	540000c1 	b.ne	25bc <subdir+0x514>  // b.any
        printf(1, "mkdir dd/ff/ff succeeded!\n");
    25a8:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    25ac:	91304001 	add	x1, x0, #0xc10
    25b0:	52800020 	mov	w0, #0x1                   	// #1
    25b4:	94000895 	bl	4808 <printf>
        exit();
    25b8:	9400078d 	bl	43ec <exit>
    }
    if(mkdir("dd/xx/ff") == 0){
    25bc:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    25c0:	912c0000 	add	x0, x0, #0xb00
    25c4:	940007ff 	bl	45c0 <mkdir>
    25c8:	7100001f 	cmp	w0, #0x0
    25cc:	540000c1 	b.ne	25e4 <subdir+0x53c>  // b.any
        printf(1, "mkdir dd/xx/ff succeeded!\n");
    25d0:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    25d4:	9130c001 	add	x1, x0, #0xc30
    25d8:	52800020 	mov	w0, #0x1                   	// #1
    25dc:	9400088b 	bl	4808 <printf>
        exit();
    25e0:	94000783 	bl	43ec <exit>
    }
    if(mkdir("dd/dd/ffff") == 0){
    25e4:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    25e8:	91260000 	add	x0, x0, #0x980
    25ec:	940007f5 	bl	45c0 <mkdir>
    25f0:	7100001f 	cmp	w0, #0x0
    25f4:	540000c1 	b.ne	260c <subdir+0x564>  // b.any
        printf(1, "mkdir dd/dd/ffff succeeded!\n");
    25f8:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    25fc:	91314001 	add	x1, x0, #0xc50
    2600:	52800020 	mov	w0, #0x1                   	// #1
    2604:	94000881 	bl	4808 <printf>
        exit();
    2608:	94000779 	bl	43ec <exit>
    }
    if(unlink("dd/xx/ff") == 0){
    260c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2610:	912c0000 	add	x0, x0, #0xb00
    2614:	940007d0 	bl	4554 <unlink>
    2618:	7100001f 	cmp	w0, #0x0
    261c:	540000c1 	b.ne	2634 <subdir+0x58c>  // b.any
        printf(1, "unlink dd/xx/ff succeeded!\n");
    2620:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2624:	9131c001 	add	x1, x0, #0xc70
    2628:	52800020 	mov	w0, #0x1                   	// #1
    262c:	94000877 	bl	4808 <printf>
        exit();
    2630:	9400076f 	bl	43ec <exit>
    }
    if(unlink("dd/ff/ff") == 0){
    2634:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2638:	912b4000 	add	x0, x0, #0xad0
    263c:	940007c6 	bl	4554 <unlink>
    2640:	7100001f 	cmp	w0, #0x0
    2644:	540000c1 	b.ne	265c <subdir+0x5b4>  // b.any
        printf(1, "unlink dd/ff/ff succeeded!\n");
    2648:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    264c:	91324001 	add	x1, x0, #0xc90
    2650:	52800020 	mov	w0, #0x1                   	// #1
    2654:	9400086d 	bl	4808 <printf>
        exit();
    2658:	94000765 	bl	43ec <exit>
    }
    if(chdir("dd/ff") == 0){
    265c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2660:	91224000 	add	x0, x0, #0x890
    2664:	940007e0 	bl	45e4 <chdir>
    2668:	7100001f 	cmp	w0, #0x0
    266c:	540000c1 	b.ne	2684 <subdir+0x5dc>  // b.any
        printf(1, "chdir dd/ff succeeded!\n");
    2670:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2674:	9132c001 	add	x1, x0, #0xcb0
    2678:	52800020 	mov	w0, #0x1                   	// #1
    267c:	94000863 	bl	4808 <printf>
        exit();
    2680:	9400075b 	bl	43ec <exit>
    }
    if(chdir("dd/xx") == 0){
    2684:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2688:	91332000 	add	x0, x0, #0xcc8
    268c:	940007d6 	bl	45e4 <chdir>
    2690:	7100001f 	cmp	w0, #0x0
    2694:	540000c1 	b.ne	26ac <subdir+0x604>  // b.any
        printf(1, "chdir dd/xx succeeded!\n");
    2698:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    269c:	91334001 	add	x1, x0, #0xcd0
    26a0:	52800020 	mov	w0, #0x1                   	// #1
    26a4:	94000859 	bl	4808 <printf>
        exit();
    26a8:	94000751 	bl	43ec <exit>
    }
    
    if(unlink("dd/dd/ffff") != 0){
    26ac:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    26b0:	91260000 	add	x0, x0, #0x980
    26b4:	940007a8 	bl	4554 <unlink>
    26b8:	7100001f 	cmp	w0, #0x0
    26bc:	540000c0 	b.eq	26d4 <subdir+0x62c>  // b.none
        printf(1, "unlink dd/dd/ff failed\n");
    26c0:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    26c4:	9126e001 	add	x1, x0, #0x9b8
    26c8:	52800020 	mov	w0, #0x1                   	// #1
    26cc:	9400084f 	bl	4808 <printf>
        exit();
    26d0:	94000747 	bl	43ec <exit>
    }
    if(unlink("dd/ff") != 0){
    26d4:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    26d8:	91224000 	add	x0, x0, #0x890
    26dc:	9400079e 	bl	4554 <unlink>
    26e0:	7100001f 	cmp	w0, #0x0
    26e4:	540000c0 	b.eq	26fc <subdir+0x654>  // b.none
        printf(1, "unlink dd/ff failed\n");
    26e8:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    26ec:	9133a001 	add	x1, x0, #0xce8
    26f0:	52800020 	mov	w0, #0x1                   	// #1
    26f4:	94000845 	bl	4808 <printf>
        exit();
    26f8:	9400073d 	bl	43ec <exit>
    }
    if(unlink("dd") == 0){
    26fc:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2700:	9121c000 	add	x0, x0, #0x870
    2704:	94000794 	bl	4554 <unlink>
    2708:	7100001f 	cmp	w0, #0x0
    270c:	540000c1 	b.ne	2724 <subdir+0x67c>  // b.any
        printf(1, "unlink non-empty dd succeeded!\n");
    2710:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2714:	91340001 	add	x1, x0, #0xd00
    2718:	52800020 	mov	w0, #0x1                   	// #1
    271c:	9400083b 	bl	4808 <printf>
        exit();
    2720:	94000733 	bl	43ec <exit>
    }
    if(unlink("dd/dd") < 0){
    2724:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2728:	91348000 	add	x0, x0, #0xd20
    272c:	9400078a 	bl	4554 <unlink>
    2730:	7100001f 	cmp	w0, #0x0
    2734:	540000ca 	b.ge	274c <subdir+0x6a4>  // b.tcont
        printf(1, "unlink dd/dd failed\n");
    2738:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    273c:	9134a001 	add	x1, x0, #0xd28
    2740:	52800020 	mov	w0, #0x1                   	// #1
    2744:	94000831 	bl	4808 <printf>
        exit();
    2748:	94000729 	bl	43ec <exit>
    }
    if(unlink("dd") < 0){
    274c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2750:	9121c000 	add	x0, x0, #0x870
    2754:	94000780 	bl	4554 <unlink>
    2758:	7100001f 	cmp	w0, #0x0
    275c:	540000ca 	b.ge	2774 <subdir+0x6cc>  // b.tcont
        printf(1, "unlink dd failed\n");
    2760:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2764:	91350001 	add	x1, x0, #0xd40
    2768:	52800020 	mov	w0, #0x1                   	// #1
    276c:	94000827 	bl	4808 <printf>
        exit();
    2770:	9400071f 	bl	43ec <exit>
    }
    
    printf(1, "subdir ok\n");
    2774:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2778:	91356001 	add	x1, x0, #0xd58
    277c:	52800020 	mov	w0, #0x1                   	// #1
    2780:	94000822 	bl	4808 <printf>
}
    2784:	d503201f 	nop
    2788:	a8c27bfd 	ldp	x29, x30, [sp], #32
    278c:	d65f03c0 	ret

0000000000002790 <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    2790:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    2794:	910003fd 	mov	x29, sp
    int fd, sz;
    
    printf(1, "bigwrite test\n");
    2798:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    279c:	9135a001 	add	x1, x0, #0xd68
    27a0:	52800020 	mov	w0, #0x1                   	// #1
    27a4:	94000819 	bl	4808 <printf>
    
    unlink("bigwrite");
    27a8:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    27ac:	9135e000 	add	x0, x0, #0xd78
    27b0:	94000769 	bl	4554 <unlink>
    for(sz = 499; sz < 12*512; sz += 471){
    27b4:	52803e60 	mov	w0, #0x1f3                 	// #499
    27b8:	b9001fe0 	str	w0, [sp, #28]
    27bc:	1400002f 	b	2878 <bigwrite+0xe8>
        fd = open("bigwrite", O_CREATE | O_RDWR);
    27c0:	52804041 	mov	w1, #0x202                 	// #514
    27c4:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    27c8:	9135e000 	add	x0, x0, #0xd78
    27cc:	94000750 	bl	450c <open>
    27d0:	b90017e0 	str	w0, [sp, #20]
        if(fd < 0){
    27d4:	b94017e0 	ldr	w0, [sp, #20]
    27d8:	7100001f 	cmp	w0, #0x0
    27dc:	540000ca 	b.ge	27f4 <bigwrite+0x64>  // b.tcont
            printf(1, "cannot create bigwrite\n");
    27e0:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    27e4:	91362001 	add	x1, x0, #0xd88
    27e8:	52800020 	mov	w0, #0x1                   	// #1
    27ec:	94000807 	bl	4808 <printf>
            exit();
    27f0:	940006ff 	bl	43ec <exit>
        }
        int i;
        for(i = 0; i < 2; i++){
    27f4:	b9001bff 	str	wzr, [sp, #24]
    27f8:	14000015 	b	284c <bigwrite+0xbc>
            int cc = write(fd, buf, sz);
    27fc:	b9401fe2 	ldr	w2, [sp, #28]
    2800:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2804:	91228001 	add	x1, x0, #0x8a0
    2808:	b94017e0 	ldr	w0, [sp, #20]
    280c:	9400071c 	bl	447c <write>
    2810:	b90013e0 	str	w0, [sp, #16]
            if(cc != sz){
    2814:	b94013e1 	ldr	w1, [sp, #16]
    2818:	b9401fe0 	ldr	w0, [sp, #28]
    281c:	6b00003f 	cmp	w1, w0
    2820:	54000100 	b.eq	2840 <bigwrite+0xb0>  // b.none
                printf(1, "write(%d) ret %d\n", sz, cc);
    2824:	b94013e3 	ldr	w3, [sp, #16]
    2828:	b9401fe2 	ldr	w2, [sp, #28]
    282c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2830:	91368001 	add	x1, x0, #0xda0
    2834:	52800020 	mov	w0, #0x1                   	// #1
    2838:	940007f4 	bl	4808 <printf>
                exit();
    283c:	940006ec 	bl	43ec <exit>
        for(i = 0; i < 2; i++){
    2840:	b9401be0 	ldr	w0, [sp, #24]
    2844:	11000400 	add	w0, w0, #0x1
    2848:	b9001be0 	str	w0, [sp, #24]
    284c:	b9401be0 	ldr	w0, [sp, #24]
    2850:	7100041f 	cmp	w0, #0x1
    2854:	54fffd4d 	b.le	27fc <bigwrite+0x6c>
            }
        }
        close(fd);
    2858:	b94017e0 	ldr	w0, [sp, #20]
    285c:	94000711 	bl	44a0 <close>
        unlink("bigwrite");
    2860:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2864:	9135e000 	add	x0, x0, #0xd78
    2868:	9400073b 	bl	4554 <unlink>
    for(sz = 499; sz < 12*512; sz += 471){
    286c:	b9401fe0 	ldr	w0, [sp, #28]
    2870:	11075c00 	add	w0, w0, #0x1d7
    2874:	b9001fe0 	str	w0, [sp, #28]
    2878:	b9401fe1 	ldr	w1, [sp, #28]
    287c:	5282ffe0 	mov	w0, #0x17ff                	// #6143
    2880:	6b00003f 	cmp	w1, w0
    2884:	54fff9ed 	b.le	27c0 <bigwrite+0x30>
    }
    
    printf(1, "bigwrite ok\n");
    2888:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    288c:	9136e001 	add	x1, x0, #0xdb8
    2890:	52800020 	mov	w0, #0x1                   	// #1
    2894:	940007dd 	bl	4808 <printf>
}
    2898:	d503201f 	nop
    289c:	a8c27bfd 	ldp	x29, x30, [sp], #32
    28a0:	d65f03c0 	ret

00000000000028a4 <bigfile>:

void
bigfile(void)
{
    28a4:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    28a8:	910003fd 	mov	x29, sp
    int fd, i, total, cc;
    
    printf(1, "bigfile test\n");
    28ac:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    28b0:	91372001 	add	x1, x0, #0xdc8
    28b4:	52800020 	mov	w0, #0x1                   	// #1
    28b8:	940007d4 	bl	4808 <printf>
    
    unlink("bigfile");
    28bc:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    28c0:	91376000 	add	x0, x0, #0xdd8
    28c4:	94000724 	bl	4554 <unlink>
    fd = open("bigfile", O_CREATE | O_RDWR);
    28c8:	52804041 	mov	w1, #0x202                 	// #514
    28cc:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    28d0:	91376000 	add	x0, x0, #0xdd8
    28d4:	9400070e 	bl	450c <open>
    28d8:	b90017e0 	str	w0, [sp, #20]
    if(fd < 0){
    28dc:	b94017e0 	ldr	w0, [sp, #20]
    28e0:	7100001f 	cmp	w0, #0x0
    28e4:	540000ca 	b.ge	28fc <bigfile+0x58>  // b.tcont
        printf(1, "cannot create bigfile");
    28e8:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    28ec:	91378001 	add	x1, x0, #0xde0
    28f0:	52800020 	mov	w0, #0x1                   	// #1
    28f4:	940007c5 	bl	4808 <printf>
        exit();
    28f8:	940006bd 	bl	43ec <exit>
    }
    for(i = 0; i < 20; i++){
    28fc:	b9001fff 	str	wzr, [sp, #28]
    2900:	14000015 	b	2954 <bigfile+0xb0>
        memset(buf, i, 600);
    2904:	52804b02 	mov	w2, #0x258                 	// #600
    2908:	b9401fe1 	ldr	w1, [sp, #28]
    290c:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2910:	91228000 	add	x0, x0, #0x8a0
    2914:	940005dc 	bl	4084 <memset>
        if(write(fd, buf, 600) != 600){
    2918:	52804b02 	mov	w2, #0x258                 	// #600
    291c:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2920:	91228001 	add	x1, x0, #0x8a0
    2924:	b94017e0 	ldr	w0, [sp, #20]
    2928:	940006d5 	bl	447c <write>
    292c:	7109601f 	cmp	w0, #0x258
    2930:	540000c0 	b.eq	2948 <bigfile+0xa4>  // b.none
            printf(1, "write bigfile failed\n");
    2934:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2938:	9137e001 	add	x1, x0, #0xdf8
    293c:	52800020 	mov	w0, #0x1                   	// #1
    2940:	940007b2 	bl	4808 <printf>
            exit();
    2944:	940006aa 	bl	43ec <exit>
    for(i = 0; i < 20; i++){
    2948:	b9401fe0 	ldr	w0, [sp, #28]
    294c:	11000400 	add	w0, w0, #0x1
    2950:	b9001fe0 	str	w0, [sp, #28]
    2954:	b9401fe0 	ldr	w0, [sp, #28]
    2958:	71004c1f 	cmp	w0, #0x13
    295c:	54fffd4d 	b.le	2904 <bigfile+0x60>
        }
    }
    close(fd);
    2960:	b94017e0 	ldr	w0, [sp, #20]
    2964:	940006cf 	bl	44a0 <close>
    
    fd = open("bigfile", 0);
    2968:	52800001 	mov	w1, #0x0                   	// #0
    296c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2970:	91376000 	add	x0, x0, #0xdd8
    2974:	940006e6 	bl	450c <open>
    2978:	b90017e0 	str	w0, [sp, #20]
    if(fd < 0){
    297c:	b94017e0 	ldr	w0, [sp, #20]
    2980:	7100001f 	cmp	w0, #0x0
    2984:	540000ca 	b.ge	299c <bigfile+0xf8>  // b.tcont
        printf(1, "cannot open bigfile\n");
    2988:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    298c:	91384001 	add	x1, x0, #0xe10
    2990:	52800020 	mov	w0, #0x1                   	// #1
    2994:	9400079d 	bl	4808 <printf>
        exit();
    2998:	94000695 	bl	43ec <exit>
    }
    total = 0;
    299c:	b9001bff 	str	wzr, [sp, #24]
    for(i = 0; ; i++){
    29a0:	b9001fff 	str	wzr, [sp, #28]
        cc = read(fd, buf, 300);
    29a4:	52802582 	mov	w2, #0x12c                 	// #300
    29a8:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    29ac:	91228001 	add	x1, x0, #0x8a0
    29b0:	b94017e0 	ldr	w0, [sp, #20]
    29b4:	940006a9 	bl	4458 <read>
    29b8:	b90013e0 	str	w0, [sp, #16]
        if(cc < 0){
    29bc:	b94013e0 	ldr	w0, [sp, #16]
    29c0:	7100001f 	cmp	w0, #0x0
    29c4:	540000ca 	b.ge	29dc <bigfile+0x138>  // b.tcont
            printf(1, "read bigfile failed\n");
    29c8:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    29cc:	9138a001 	add	x1, x0, #0xe28
    29d0:	52800020 	mov	w0, #0x1                   	// #1
    29d4:	9400078d 	bl	4808 <printf>
            exit();
    29d8:	94000685 	bl	43ec <exit>
        }
        if(cc == 0)
    29dc:	b94013e0 	ldr	w0, [sp, #16]
    29e0:	7100001f 	cmp	w0, #0x0
    29e4:	54000540 	b.eq	2a8c <bigfile+0x1e8>  // b.none
            break;
        if(cc != 300){
    29e8:	b94013e0 	ldr	w0, [sp, #16]
    29ec:	7104b01f 	cmp	w0, #0x12c
    29f0:	540000c0 	b.eq	2a08 <bigfile+0x164>  // b.none
            printf(1, "short read bigfile\n");
    29f4:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    29f8:	91390001 	add	x1, x0, #0xe40
    29fc:	52800020 	mov	w0, #0x1                   	// #1
    2a00:	94000782 	bl	4808 <printf>
            exit();
    2a04:	9400067a 	bl	43ec <exit>
        }
        if(buf[0] != i/2 || buf[299] != i/2){
    2a08:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2a0c:	91228000 	add	x0, x0, #0x8a0
    2a10:	39400000 	ldrb	w0, [x0]
    2a14:	2a0003e2 	mov	w2, w0
    2a18:	b9401fe0 	ldr	w0, [sp, #28]
    2a1c:	531f7c01 	lsr	w1, w0, #31
    2a20:	0b000020 	add	w0, w1, w0
    2a24:	13017c00 	asr	w0, w0, #1
    2a28:	6b00005f 	cmp	w2, w0
    2a2c:	54000161 	b.ne	2a58 <bigfile+0x1b4>  // b.any
    2a30:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2a34:	91228000 	add	x0, x0, #0x8a0
    2a38:	3944ac00 	ldrb	w0, [x0, #299]
    2a3c:	2a0003e2 	mov	w2, w0
    2a40:	b9401fe0 	ldr	w0, [sp, #28]
    2a44:	531f7c01 	lsr	w1, w0, #31
    2a48:	0b000020 	add	w0, w1, w0
    2a4c:	13017c00 	asr	w0, w0, #1
    2a50:	6b00005f 	cmp	w2, w0
    2a54:	540000c0 	b.eq	2a6c <bigfile+0x1c8>  // b.none
            printf(1, "read bigfile wrong data\n");
    2a58:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2a5c:	91396001 	add	x1, x0, #0xe58
    2a60:	52800020 	mov	w0, #0x1                   	// #1
    2a64:	94000769 	bl	4808 <printf>
            exit();
    2a68:	94000661 	bl	43ec <exit>
        }
        total += cc;
    2a6c:	b9401be1 	ldr	w1, [sp, #24]
    2a70:	b94013e0 	ldr	w0, [sp, #16]
    2a74:	0b000020 	add	w0, w1, w0
    2a78:	b9001be0 	str	w0, [sp, #24]
    for(i = 0; ; i++){
    2a7c:	b9401fe0 	ldr	w0, [sp, #28]
    2a80:	11000400 	add	w0, w0, #0x1
    2a84:	b9001fe0 	str	w0, [sp, #28]
        cc = read(fd, buf, 300);
    2a88:	17ffffc7 	b	29a4 <bigfile+0x100>
            break;
    2a8c:	d503201f 	nop
    }
    close(fd);
    2a90:	b94017e0 	ldr	w0, [sp, #20]
    2a94:	94000683 	bl	44a0 <close>
    if(total != 20*600){
    2a98:	b9401be1 	ldr	w1, [sp, #24]
    2a9c:	5285dc00 	mov	w0, #0x2ee0                	// #12000
    2aa0:	6b00003f 	cmp	w1, w0
    2aa4:	540000c0 	b.eq	2abc <bigfile+0x218>  // b.none
        printf(1, "read bigfile wrong total\n");
    2aa8:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2aac:	9139e001 	add	x1, x0, #0xe78
    2ab0:	52800020 	mov	w0, #0x1                   	// #1
    2ab4:	94000755 	bl	4808 <printf>
        exit();
    2ab8:	9400064d 	bl	43ec <exit>
    }
    unlink("bigfile");
    2abc:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2ac0:	91376000 	add	x0, x0, #0xdd8
    2ac4:	940006a4 	bl	4554 <unlink>
    
    printf(1, "bigfile test ok\n");
    2ac8:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2acc:	913a6001 	add	x1, x0, #0xe98
    2ad0:	52800020 	mov	w0, #0x1                   	// #1
    2ad4:	9400074d 	bl	4808 <printf>
}
    2ad8:	d503201f 	nop
    2adc:	a8c27bfd 	ldp	x29, x30, [sp], #32
    2ae0:	d65f03c0 	ret

0000000000002ae4 <fourteen>:

void
fourteen(void)
{
    2ae4:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    2ae8:	910003fd 	mov	x29, sp
    int fd;
    
    // DIRSIZ is 14.
    printf(1, "fourteen test\n");
    2aec:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2af0:	913ac001 	add	x1, x0, #0xeb0
    2af4:	52800020 	mov	w0, #0x1                   	// #1
    2af8:	94000744 	bl	4808 <printf>
    
    if(mkdir("12345678901234") != 0){
    2afc:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2b00:	913b0000 	add	x0, x0, #0xec0
    2b04:	940006af 	bl	45c0 <mkdir>
    2b08:	7100001f 	cmp	w0, #0x0
    2b0c:	540000c0 	b.eq	2b24 <fourteen+0x40>  // b.none
        printf(1, "mkdir 12345678901234 failed\n");
    2b10:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2b14:	913b4001 	add	x1, x0, #0xed0
    2b18:	52800020 	mov	w0, #0x1                   	// #1
    2b1c:	9400073b 	bl	4808 <printf>
        exit();
    2b20:	94000633 	bl	43ec <exit>
    }
    if(mkdir("12345678901234/123456789012345") != 0){
    2b24:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2b28:	913bc000 	add	x0, x0, #0xef0
    2b2c:	940006a5 	bl	45c0 <mkdir>
    2b30:	7100001f 	cmp	w0, #0x0
    2b34:	540000c0 	b.eq	2b4c <fourteen+0x68>  // b.none
        printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    2b38:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2b3c:	913c4001 	add	x1, x0, #0xf10
    2b40:	52800020 	mov	w0, #0x1                   	// #1
    2b44:	94000731 	bl	4808 <printf>
        exit();
    2b48:	94000629 	bl	43ec <exit>
    }
    fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2b4c:	52804001 	mov	w1, #0x200                 	// #512
    2b50:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2b54:	913d0000 	add	x0, x0, #0xf40
    2b58:	9400066d 	bl	450c <open>
    2b5c:	b9001fe0 	str	w0, [sp, #28]
    if(fd < 0){
    2b60:	b9401fe0 	ldr	w0, [sp, #28]
    2b64:	7100001f 	cmp	w0, #0x0
    2b68:	540000ca 	b.ge	2b80 <fourteen+0x9c>  // b.tcont
        printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    2b6c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2b70:	913dc001 	add	x1, x0, #0xf70
    2b74:	52800020 	mov	w0, #0x1                   	// #1
    2b78:	94000724 	bl	4808 <printf>
        exit();
    2b7c:	9400061c 	bl	43ec <exit>
    }
    close(fd);
    2b80:	b9401fe0 	ldr	w0, [sp, #28]
    2b84:	94000647 	bl	44a0 <close>
    fd = open("12345678901234/12345678901234/12345678901234", 0);
    2b88:	52800001 	mov	w1, #0x0                   	// #0
    2b8c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2b90:	913ec000 	add	x0, x0, #0xfb0
    2b94:	9400065e 	bl	450c <open>
    2b98:	b9001fe0 	str	w0, [sp, #28]
    if(fd < 0){
    2b9c:	b9401fe0 	ldr	w0, [sp, #28]
    2ba0:	7100001f 	cmp	w0, #0x0
    2ba4:	540000ca 	b.ge	2bbc <fourteen+0xd8>  // b.tcont
        printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2ba8:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2bac:	913f8001 	add	x1, x0, #0xfe0
    2bb0:	52800020 	mov	w0, #0x1                   	// #1
    2bb4:	94000715 	bl	4808 <printf>
        exit();
    2bb8:	9400060d 	bl	43ec <exit>
    }
    close(fd);
    2bbc:	b9401fe0 	ldr	w0, [sp, #28]
    2bc0:	94000638 	bl	44a0 <close>
    
    if(mkdir("12345678901234/12345678901234") == 0){
    2bc4:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2bc8:	91008000 	add	x0, x0, #0x20
    2bcc:	9400067d 	bl	45c0 <mkdir>
    2bd0:	7100001f 	cmp	w0, #0x0
    2bd4:	540000c1 	b.ne	2bec <fourteen+0x108>  // b.any
        printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2bd8:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2bdc:	91010001 	add	x1, x0, #0x40
    2be0:	52800020 	mov	w0, #0x1                   	// #1
    2be4:	94000709 	bl	4808 <printf>
        exit();
    2be8:	94000601 	bl	43ec <exit>
    }
    if(mkdir("123456789012345/12345678901234") == 0){
    2bec:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2bf0:	9101c000 	add	x0, x0, #0x70
    2bf4:	94000673 	bl	45c0 <mkdir>
    2bf8:	7100001f 	cmp	w0, #0x0
    2bfc:	540000c1 	b.ne	2c14 <fourteen+0x130>  // b.any
        printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2c00:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2c04:	91024001 	add	x1, x0, #0x90
    2c08:	52800020 	mov	w0, #0x1                   	// #1
    2c0c:	940006ff 	bl	4808 <printf>
        exit();
    2c10:	940005f7 	bl	43ec <exit>
    }
    
    printf(1, "fourteen ok\n");
    2c14:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2c18:	91032001 	add	x1, x0, #0xc8
    2c1c:	52800020 	mov	w0, #0x1                   	// #1
    2c20:	940006fa 	bl	4808 <printf>
}
    2c24:	d503201f 	nop
    2c28:	a8c27bfd 	ldp	x29, x30, [sp], #32
    2c2c:	d65f03c0 	ret

0000000000002c30 <rmdot>:

void
rmdot(void)
{
    2c30:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    2c34:	910003fd 	mov	x29, sp
    printf(1, "rmdot test\n");
    2c38:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2c3c:	91036001 	add	x1, x0, #0xd8
    2c40:	52800020 	mov	w0, #0x1                   	// #1
    2c44:	940006f1 	bl	4808 <printf>
    if(mkdir("dots") != 0){
    2c48:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2c4c:	9103a000 	add	x0, x0, #0xe8
    2c50:	9400065c 	bl	45c0 <mkdir>
    2c54:	7100001f 	cmp	w0, #0x0
    2c58:	540000c0 	b.eq	2c70 <rmdot+0x40>  // b.none
        printf(1, "mkdir dots failed\n");
    2c5c:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2c60:	9103c001 	add	x1, x0, #0xf0
    2c64:	52800020 	mov	w0, #0x1                   	// #1
    2c68:	940006e8 	bl	4808 <printf>
        exit();
    2c6c:	940005e0 	bl	43ec <exit>
    }
    if(chdir("dots") != 0){
    2c70:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2c74:	9103a000 	add	x0, x0, #0xe8
    2c78:	9400065b 	bl	45e4 <chdir>
    2c7c:	7100001f 	cmp	w0, #0x0
    2c80:	540000c0 	b.eq	2c98 <rmdot+0x68>  // b.none
        printf(1, "chdir dots failed\n");
    2c84:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2c88:	91042001 	add	x1, x0, #0x108
    2c8c:	52800020 	mov	w0, #0x1                   	// #1
    2c90:	940006de 	bl	4808 <printf>
        exit();
    2c94:	940005d6 	bl	43ec <exit>
    }
    if(unlink(".") == 0){
    2c98:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2c9c:	911b0000 	add	x0, x0, #0x6c0
    2ca0:	9400062d 	bl	4554 <unlink>
    2ca4:	7100001f 	cmp	w0, #0x0
    2ca8:	540000c1 	b.ne	2cc0 <rmdot+0x90>  // b.any
        printf(1, "rm . worked!\n");
    2cac:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2cb0:	91048001 	add	x1, x0, #0x120
    2cb4:	52800020 	mov	w0, #0x1                   	// #1
    2cb8:	940006d4 	bl	4808 <printf>
        exit();
    2cbc:	940005cc 	bl	43ec <exit>
    }
    if(unlink("..") == 0){
    2cc0:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2cc4:	91054000 	add	x0, x0, #0x150
    2cc8:	94000623 	bl	4554 <unlink>
    2ccc:	7100001f 	cmp	w0, #0x0
    2cd0:	540000c1 	b.ne	2ce8 <rmdot+0xb8>  // b.any
        printf(1, "rm .. worked!\n");
    2cd4:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2cd8:	9104c001 	add	x1, x0, #0x130
    2cdc:	52800020 	mov	w0, #0x1                   	// #1
    2ce0:	940006ca 	bl	4808 <printf>
        exit();
    2ce4:	940005c2 	bl	43ec <exit>
    }
    if(chdir("/") != 0){
    2ce8:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2cec:	91050000 	add	x0, x0, #0x140
    2cf0:	9400063d 	bl	45e4 <chdir>
    2cf4:	7100001f 	cmp	w0, #0x0
    2cf8:	540000c0 	b.eq	2d10 <rmdot+0xe0>  // b.none
        printf(1, "chdir / failed\n");
    2cfc:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2d00:	91052001 	add	x1, x0, #0x148
    2d04:	52800020 	mov	w0, #0x1                   	// #1
    2d08:	940006c0 	bl	4808 <printf>
        exit();
    2d0c:	940005b8 	bl	43ec <exit>
    }
    if(unlink("dots/.") == 0){
    2d10:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2d14:	91056000 	add	x0, x0, #0x158
    2d18:	9400060f 	bl	4554 <unlink>
    2d1c:	7100001f 	cmp	w0, #0x0
    2d20:	540000c1 	b.ne	2d38 <rmdot+0x108>  // b.any
        printf(1, "unlink dots/. worked!\n");
    2d24:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2d28:	91058001 	add	x1, x0, #0x160
    2d2c:	52800020 	mov	w0, #0x1                   	// #1
    2d30:	940006b6 	bl	4808 <printf>
        exit();
    2d34:	940005ae 	bl	43ec <exit>
    }
    if(unlink("dots/..") == 0){
    2d38:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2d3c:	9105e000 	add	x0, x0, #0x178
    2d40:	94000605 	bl	4554 <unlink>
    2d44:	7100001f 	cmp	w0, #0x0
    2d48:	540000c1 	b.ne	2d60 <rmdot+0x130>  // b.any
        printf(1, "unlink dots/.. worked!\n");
    2d4c:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2d50:	91060001 	add	x1, x0, #0x180
    2d54:	52800020 	mov	w0, #0x1                   	// #1
    2d58:	940006ac 	bl	4808 <printf>
        exit();
    2d5c:	940005a4 	bl	43ec <exit>
    }
    if(unlink("dots") != 0){
    2d60:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2d64:	9103a000 	add	x0, x0, #0xe8
    2d68:	940005fb 	bl	4554 <unlink>
    2d6c:	7100001f 	cmp	w0, #0x0
    2d70:	540000c0 	b.eq	2d88 <rmdot+0x158>  // b.none
        printf(1, "unlink dots failed!\n");
    2d74:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2d78:	91066001 	add	x1, x0, #0x198
    2d7c:	52800020 	mov	w0, #0x1                   	// #1
    2d80:	940006a2 	bl	4808 <printf>
        exit();
    2d84:	9400059a 	bl	43ec <exit>
    }
    printf(1, "rmdot ok\n");
    2d88:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2d8c:	9106c001 	add	x1, x0, #0x1b0
    2d90:	52800020 	mov	w0, #0x1                   	// #1
    2d94:	9400069d 	bl	4808 <printf>
}
    2d98:	d503201f 	nop
    2d9c:	a8c17bfd 	ldp	x29, x30, [sp], #16
    2da0:	d65f03c0 	ret

0000000000002da4 <dirfile>:

void
dirfile(void)
{
    2da4:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    2da8:	910003fd 	mov	x29, sp
    int fd;
    
    printf(1, "dir vs file\n");
    2dac:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2db0:	91070001 	add	x1, x0, #0x1c0
    2db4:	52800020 	mov	w0, #0x1                   	// #1
    2db8:	94000694 	bl	4808 <printf>
    
    fd = open("dirfile", O_CREATE);
    2dbc:	52804001 	mov	w1, #0x200                 	// #512
    2dc0:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2dc4:	91074000 	add	x0, x0, #0x1d0
    2dc8:	940005d1 	bl	450c <open>
    2dcc:	b9001fe0 	str	w0, [sp, #28]
    if(fd < 0){
    2dd0:	b9401fe0 	ldr	w0, [sp, #28]
    2dd4:	7100001f 	cmp	w0, #0x0
    2dd8:	540000ca 	b.ge	2df0 <dirfile+0x4c>  // b.tcont
        printf(1, "create dirfile failed\n");
    2ddc:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2de0:	91076001 	add	x1, x0, #0x1d8
    2de4:	52800020 	mov	w0, #0x1                   	// #1
    2de8:	94000688 	bl	4808 <printf>
        exit();
    2dec:	94000580 	bl	43ec <exit>
    }
    close(fd);
    2df0:	b9401fe0 	ldr	w0, [sp, #28]
    2df4:	940005ab 	bl	44a0 <close>
    if(chdir("dirfile") == 0){
    2df8:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2dfc:	91074000 	add	x0, x0, #0x1d0
    2e00:	940005f9 	bl	45e4 <chdir>
    2e04:	7100001f 	cmp	w0, #0x0
    2e08:	540000c1 	b.ne	2e20 <dirfile+0x7c>  // b.any
        printf(1, "chdir dirfile succeeded!\n");
    2e0c:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2e10:	9107c001 	add	x1, x0, #0x1f0
    2e14:	52800020 	mov	w0, #0x1                   	// #1
    2e18:	9400067c 	bl	4808 <printf>
        exit();
    2e1c:	94000574 	bl	43ec <exit>
    }
    fd = open("dirfile/xx", 0);
    2e20:	52800001 	mov	w1, #0x0                   	// #0
    2e24:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2e28:	91084000 	add	x0, x0, #0x210
    2e2c:	940005b8 	bl	450c <open>
    2e30:	b9001fe0 	str	w0, [sp, #28]
    if(fd >= 0){
    2e34:	b9401fe0 	ldr	w0, [sp, #28]
    2e38:	7100001f 	cmp	w0, #0x0
    2e3c:	540000cb 	b.lt	2e54 <dirfile+0xb0>  // b.tstop
        printf(1, "create dirfile/xx succeeded!\n");
    2e40:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2e44:	91088001 	add	x1, x0, #0x220
    2e48:	52800020 	mov	w0, #0x1                   	// #1
    2e4c:	9400066f 	bl	4808 <printf>
        exit();
    2e50:	94000567 	bl	43ec <exit>
    }
    fd = open("dirfile/xx", O_CREATE);
    2e54:	52804001 	mov	w1, #0x200                 	// #512
    2e58:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2e5c:	91084000 	add	x0, x0, #0x210
    2e60:	940005ab 	bl	450c <open>
    2e64:	b9001fe0 	str	w0, [sp, #28]
    if(fd >= 0){
    2e68:	b9401fe0 	ldr	w0, [sp, #28]
    2e6c:	7100001f 	cmp	w0, #0x0
    2e70:	540000cb 	b.lt	2e88 <dirfile+0xe4>  // b.tstop
        printf(1, "create dirfile/xx succeeded!\n");
    2e74:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2e78:	91088001 	add	x1, x0, #0x220
    2e7c:	52800020 	mov	w0, #0x1                   	// #1
    2e80:	94000662 	bl	4808 <printf>
        exit();
    2e84:	9400055a 	bl	43ec <exit>
    }
    if(mkdir("dirfile/xx") == 0){
    2e88:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2e8c:	91084000 	add	x0, x0, #0x210
    2e90:	940005cc 	bl	45c0 <mkdir>
    2e94:	7100001f 	cmp	w0, #0x0
    2e98:	540000c1 	b.ne	2eb0 <dirfile+0x10c>  // b.any
        printf(1, "mkdir dirfile/xx succeeded!\n");
    2e9c:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2ea0:	91090001 	add	x1, x0, #0x240
    2ea4:	52800020 	mov	w0, #0x1                   	// #1
    2ea8:	94000658 	bl	4808 <printf>
        exit();
    2eac:	94000550 	bl	43ec <exit>
    }
    if(unlink("dirfile/xx") == 0){
    2eb0:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2eb4:	91084000 	add	x0, x0, #0x210
    2eb8:	940005a7 	bl	4554 <unlink>
    2ebc:	7100001f 	cmp	w0, #0x0
    2ec0:	540000c1 	b.ne	2ed8 <dirfile+0x134>  // b.any
        printf(1, "unlink dirfile/xx succeeded!\n");
    2ec4:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2ec8:	91098001 	add	x1, x0, #0x260
    2ecc:	52800020 	mov	w0, #0x1                   	// #1
    2ed0:	9400064e 	bl	4808 <printf>
        exit();
    2ed4:	94000546 	bl	43ec <exit>
    }
    if(link("README", "dirfile/xx") == 0){
    2ed8:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2edc:	91084001 	add	x1, x0, #0x210
    2ee0:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2ee4:	910a0000 	add	x0, x0, #0x280
    2ee8:	940005ad 	bl	459c <link>
    2eec:	7100001f 	cmp	w0, #0x0
    2ef0:	540000c1 	b.ne	2f08 <dirfile+0x164>  // b.any
        printf(1, "link to dirfile/xx succeeded!\n");
    2ef4:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2ef8:	910a2001 	add	x1, x0, #0x288
    2efc:	52800020 	mov	w0, #0x1                   	// #1
    2f00:	94000642 	bl	4808 <printf>
        exit();
    2f04:	9400053a 	bl	43ec <exit>
    }
    if(unlink("dirfile") != 0){
    2f08:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2f0c:	91074000 	add	x0, x0, #0x1d0
    2f10:	94000591 	bl	4554 <unlink>
    2f14:	7100001f 	cmp	w0, #0x0
    2f18:	540000c0 	b.eq	2f30 <dirfile+0x18c>  // b.none
        printf(1, "unlink dirfile failed!\n");
    2f1c:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2f20:	910aa001 	add	x1, x0, #0x2a8
    2f24:	52800020 	mov	w0, #0x1                   	// #1
    2f28:	94000638 	bl	4808 <printf>
        exit();
    2f2c:	94000530 	bl	43ec <exit>
    }
    
    fd = open(".", O_RDWR);
    2f30:	52800041 	mov	w1, #0x2                   	// #2
    2f34:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2f38:	911b0000 	add	x0, x0, #0x6c0
    2f3c:	94000574 	bl	450c <open>
    2f40:	b9001fe0 	str	w0, [sp, #28]
    if(fd >= 0){
    2f44:	b9401fe0 	ldr	w0, [sp, #28]
    2f48:	7100001f 	cmp	w0, #0x0
    2f4c:	540000cb 	b.lt	2f64 <dirfile+0x1c0>  // b.tstop
        printf(1, "open . for writing succeeded!\n");
    2f50:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2f54:	910b0001 	add	x1, x0, #0x2c0
    2f58:	52800020 	mov	w0, #0x1                   	// #1
    2f5c:	9400062b 	bl	4808 <printf>
        exit();
    2f60:	94000523 	bl	43ec <exit>
    }
    fd = open(".", 0);
    2f64:	52800001 	mov	w1, #0x0                   	// #0
    2f68:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2f6c:	911b0000 	add	x0, x0, #0x6c0
    2f70:	94000567 	bl	450c <open>
    2f74:	b9001fe0 	str	w0, [sp, #28]
    if(write(fd, "x", 1) > 0){
    2f78:	52800022 	mov	w2, #0x1                   	// #1
    2f7c:	f0000000 	adrp	x0, 5000 <malloc+0x3a8>
    2f80:	9108a001 	add	x1, x0, #0x228
    2f84:	b9401fe0 	ldr	w0, [sp, #28]
    2f88:	9400053d 	bl	447c <write>
    2f8c:	7100001f 	cmp	w0, #0x0
    2f90:	540000cd 	b.le	2fa8 <dirfile+0x204>
        printf(1, "write . succeeded!\n");
    2f94:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2f98:	910b8001 	add	x1, x0, #0x2e0
    2f9c:	52800020 	mov	w0, #0x1                   	// #1
    2fa0:	9400061a 	bl	4808 <printf>
        exit();
    2fa4:	94000512 	bl	43ec <exit>
    }
    close(fd);
    2fa8:	b9401fe0 	ldr	w0, [sp, #28]
    2fac:	9400053d 	bl	44a0 <close>
    
    printf(1, "dir vs file OK\n");
    2fb0:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2fb4:	910be001 	add	x1, x0, #0x2f8
    2fb8:	52800020 	mov	w0, #0x1                   	// #1
    2fbc:	94000613 	bl	4808 <printf>
}
    2fc0:	d503201f 	nop
    2fc4:	a8c27bfd 	ldp	x29, x30, [sp], #32
    2fc8:	d65f03c0 	ret

0000000000002fcc <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2fcc:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    2fd0:	910003fd 	mov	x29, sp
    int i, fd;
    
    printf(1, "empty file name\n");
    2fd4:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2fd8:	910c2001 	add	x1, x0, #0x308
    2fdc:	52800020 	mov	w0, #0x1                   	// #1
    2fe0:	9400060a 	bl	4808 <printf>
    
    // the 50 is NINODE
    for(i = 0; i < 50 + 1; i++){
    2fe4:	b9001fff 	str	wzr, [sp, #28]
    2fe8:	14000037 	b	30c4 <iref+0xf8>
        if(mkdir("irefd") != 0){
    2fec:	90000020 	adrp	x0, 6000 <malloc+0x13a8>
    2ff0:	910c8000 	add	x0, x0, #0x320
    2ff4:	94000573 	bl	45c0 <mkdir>
    2ff8:	7100001f 	cmp	w0, #0x0
    2ffc:	540000c0 	b.eq	3014 <iref+0x48>  // b.none
            printf(1, "mkdir irefd failed\n");
    3000:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3004:	910ca001 	add	x1, x0, #0x328
    3008:	52800020 	mov	w0, #0x1                   	// #1
    300c:	940005ff 	bl	4808 <printf>
            exit();
    3010:	940004f7 	bl	43ec <exit>
        }
        if(chdir("irefd") != 0){
    3014:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3018:	910c8000 	add	x0, x0, #0x320
    301c:	94000572 	bl	45e4 <chdir>
    3020:	7100001f 	cmp	w0, #0x0
    3024:	540000c0 	b.eq	303c <iref+0x70>  // b.none
            printf(1, "chdir irefd failed\n");
    3028:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    302c:	910d0001 	add	x1, x0, #0x340
    3030:	52800020 	mov	w0, #0x1                   	// #1
    3034:	940005f5 	bl	4808 <printf>
            exit();
    3038:	940004ed 	bl	43ec <exit>
        }
        
        mkdir("");
    303c:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3040:	910d6000 	add	x0, x0, #0x358
    3044:	9400055f 	bl	45c0 <mkdir>
        link("README", "");
    3048:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    304c:	910d6001 	add	x1, x0, #0x358
    3050:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3054:	910a0000 	add	x0, x0, #0x280
    3058:	94000551 	bl	459c <link>
        fd = open("", O_CREATE);
    305c:	52804001 	mov	w1, #0x200                 	// #512
    3060:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3064:	910d6000 	add	x0, x0, #0x358
    3068:	94000529 	bl	450c <open>
    306c:	b9001be0 	str	w0, [sp, #24]
        if(fd >= 0)
    3070:	b9401be0 	ldr	w0, [sp, #24]
    3074:	7100001f 	cmp	w0, #0x0
    3078:	5400006b 	b.lt	3084 <iref+0xb8>  // b.tstop
            close(fd);
    307c:	b9401be0 	ldr	w0, [sp, #24]
    3080:	94000508 	bl	44a0 <close>
        fd = open("xx", O_CREATE);
    3084:	52804001 	mov	w1, #0x200                 	// #512
    3088:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    308c:	910d8000 	add	x0, x0, #0x360
    3090:	9400051f 	bl	450c <open>
    3094:	b9001be0 	str	w0, [sp, #24]
        if(fd >= 0)
    3098:	b9401be0 	ldr	w0, [sp, #24]
    309c:	7100001f 	cmp	w0, #0x0
    30a0:	5400006b 	b.lt	30ac <iref+0xe0>  // b.tstop
            close(fd);
    30a4:	b9401be0 	ldr	w0, [sp, #24]
    30a8:	940004fe 	bl	44a0 <close>
        unlink("xx");
    30ac:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    30b0:	910d8000 	add	x0, x0, #0x360
    30b4:	94000528 	bl	4554 <unlink>
    for(i = 0; i < 50 + 1; i++){
    30b8:	b9401fe0 	ldr	w0, [sp, #28]
    30bc:	11000400 	add	w0, w0, #0x1
    30c0:	b9001fe0 	str	w0, [sp, #28]
    30c4:	b9401fe0 	ldr	w0, [sp, #28]
    30c8:	7100c81f 	cmp	w0, #0x32
    30cc:	54fff90d 	b.le	2fec <iref+0x20>
    }
    
    chdir("/");
    30d0:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    30d4:	91050000 	add	x0, x0, #0x140
    30d8:	94000543 	bl	45e4 <chdir>
    printf(1, "empty file name OK\n");
    30dc:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    30e0:	910da001 	add	x1, x0, #0x368
    30e4:	52800020 	mov	w0, #0x1                   	// #1
    30e8:	940005c8 	bl	4808 <printf>
}
    30ec:	d503201f 	nop
    30f0:	a8c27bfd 	ldp	x29, x30, [sp], #32
    30f4:	d65f03c0 	ret

00000000000030f8 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    30f8:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    30fc:	910003fd 	mov	x29, sp
    int n, pid;
    
    printf(1, "fork test\n");
    3100:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3104:	910e0001 	add	x1, x0, #0x380
    3108:	52800020 	mov	w0, #0x1                   	// #1
    310c:	940005bf 	bl	4808 <printf>
    
    for(n=0; n<1000; n++){
    3110:	b9001fff 	str	wzr, [sp, #28]
    3114:	1400000d 	b	3148 <forktest+0x50>
        pid = fork();
    3118:	940004ac 	bl	43c8 <fork>
    311c:	b9001be0 	str	w0, [sp, #24]
        if(pid < 0)
    3120:	b9401be0 	ldr	w0, [sp, #24]
    3124:	7100001f 	cmp	w0, #0x0
    3128:	5400018b 	b.lt	3158 <forktest+0x60>  // b.tstop
            break;
        if(pid == 0)
    312c:	b9401be0 	ldr	w0, [sp, #24]
    3130:	7100001f 	cmp	w0, #0x0
    3134:	54000041 	b.ne	313c <forktest+0x44>  // b.any
            exit();
    3138:	940004ad 	bl	43ec <exit>
    for(n=0; n<1000; n++){
    313c:	b9401fe0 	ldr	w0, [sp, #28]
    3140:	11000400 	add	w0, w0, #0x1
    3144:	b9001fe0 	str	w0, [sp, #28]
    3148:	b9401fe0 	ldr	w0, [sp, #28]
    314c:	710f9c1f 	cmp	w0, #0x3e7
    3150:	54fffe4d 	b.le	3118 <forktest+0x20>
    3154:	14000002 	b	315c <forktest+0x64>
            break;
    3158:	d503201f 	nop
    }
    
    if(n == 1000){
    315c:	b9401fe0 	ldr	w0, [sp, #28]
    3160:	710fa01f 	cmp	w0, #0x3e8
    3164:	54000221 	b.ne	31a8 <forktest+0xb0>  // b.any
        printf(1, "fork claimed to work 1000 times!\n");
    3168:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    316c:	910e4001 	add	x1, x0, #0x390
    3170:	52800020 	mov	w0, #0x1                   	// #1
    3174:	940005a5 	bl	4808 <printf>
        exit();
    3178:	9400049d 	bl	43ec <exit>
    }
    
    for(; n > 0; n--){
        if(wait() < 0){
    317c:	940004a5 	bl	4410 <wait>
    3180:	7100001f 	cmp	w0, #0x0
    3184:	540000ca 	b.ge	319c <forktest+0xa4>  // b.tcont
            printf(1, "wait stopped early\n");
    3188:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    318c:	910ee001 	add	x1, x0, #0x3b8
    3190:	52800020 	mov	w0, #0x1                   	// #1
    3194:	9400059d 	bl	4808 <printf>
            exit();
    3198:	94000495 	bl	43ec <exit>
    for(; n > 0; n--){
    319c:	b9401fe0 	ldr	w0, [sp, #28]
    31a0:	51000400 	sub	w0, w0, #0x1
    31a4:	b9001fe0 	str	w0, [sp, #28]
    31a8:	b9401fe0 	ldr	w0, [sp, #28]
    31ac:	7100001f 	cmp	w0, #0x0
    31b0:	54fffe6c 	b.gt	317c <forktest+0x84>
        }
    }
    
    if(wait() != -1){
    31b4:	94000497 	bl	4410 <wait>
    31b8:	3100041f 	cmn	w0, #0x1
    31bc:	540000c0 	b.eq	31d4 <forktest+0xdc>  // b.none
        printf(1, "wait got too many\n");
    31c0:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    31c4:	910f4001 	add	x1, x0, #0x3d0
    31c8:	52800020 	mov	w0, #0x1                   	// #1
    31cc:	9400058f 	bl	4808 <printf>
        exit();
    31d0:	94000487 	bl	43ec <exit>
    }
    
    printf(1, "fork test OK\n");
    31d4:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    31d8:	910fa001 	add	x1, x0, #0x3e8
    31dc:	52800020 	mov	w0, #0x1                   	// #1
    31e0:	9400058a 	bl	4808 <printf>
}
    31e4:	d503201f 	nop
    31e8:	a8c27bfd 	ldp	x29, x30, [sp], #32
    31ec:	d65f03c0 	ret

00000000000031f0 <sbrktest>:

void
sbrktest(void)
{
    31f0:	a9b67bfd 	stp	x29, x30, [sp, #-160]!
    31f4:	910003fd 	mov	x29, sp
    int fds[2], pid, pids[10], ppid;
    char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
    uint amt;
    
    printf(stdout, "sbrk test\n");
    31f8:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    31fc:	9121e000 	add	x0, x0, #0x878
    3200:	b9400002 	ldr	w2, [x0]
    3204:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3208:	910fe001 	add	x1, x0, #0x3f8
    320c:	2a0203e0 	mov	w0, w2
    3210:	9400057e 	bl	4808 <printf>
    oldbrk = sbrk(0);
    3214:	52800000 	mov	w0, #0x0                   	// #0
    3218:	9400050e 	bl	4650 <sbrk>
    321c:	f90047e0 	str	x0, [sp, #136]
    
    // can one sbrk() less than a page?
    a = sbrk(0);
    3220:	52800000 	mov	w0, #0x0                   	// #0
    3224:	9400050b 	bl	4650 <sbrk>
    3228:	f9004fe0 	str	x0, [sp, #152]
    int i;
    for(i = 0; i < 5000; i++){
    322c:	b90097ff 	str	wzr, [sp, #148]
    3230:	1400001c 	b	32a0 <sbrktest+0xb0>
        b = sbrk(1);
    3234:	52800020 	mov	w0, #0x1                   	// #1
    3238:	94000506 	bl	4650 <sbrk>
    323c:	f9002be0 	str	x0, [sp, #80]
        if(b != a){
    3240:	f9402be1 	ldr	x1, [sp, #80]
    3244:	f9404fe0 	ldr	x0, [sp, #152]
    3248:	eb00003f 	cmp	x1, x0
    324c:	54000180 	b.eq	327c <sbrktest+0x8c>  // b.none
            printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    3250:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3254:	9121e000 	add	x0, x0, #0x878
    3258:	b9400005 	ldr	w5, [x0]
    325c:	f9402be4 	ldr	x4, [sp, #80]
    3260:	f9404fe3 	ldr	x3, [sp, #152]
    3264:	b94097e2 	ldr	w2, [sp, #148]
    3268:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    326c:	91102001 	add	x1, x0, #0x408
    3270:	2a0503e0 	mov	w0, w5
    3274:	94000565 	bl	4808 <printf>
            exit();
    3278:	9400045d 	bl	43ec <exit>
        }
        *b = 1;
    327c:	f9402be0 	ldr	x0, [sp, #80]
    3280:	52800021 	mov	w1, #0x1                   	// #1
    3284:	39000001 	strb	w1, [x0]
        a = b + 1;
    3288:	f9402be0 	ldr	x0, [sp, #80]
    328c:	91000400 	add	x0, x0, #0x1
    3290:	f9004fe0 	str	x0, [sp, #152]
    for(i = 0; i < 5000; i++){
    3294:	b94097e0 	ldr	w0, [sp, #148]
    3298:	11000400 	add	w0, w0, #0x1
    329c:	b90097e0 	str	w0, [sp, #148]
    32a0:	b94097e1 	ldr	w1, [sp, #148]
    32a4:	528270e0 	mov	w0, #0x1387                	// #4999
    32a8:	6b00003f 	cmp	w1, w0
    32ac:	54fffc4d 	b.le	3234 <sbrktest+0x44>
    }
    pid = fork();
    32b0:	94000446 	bl	43c8 <fork>
    32b4:	b90087e0 	str	w0, [sp, #132]
    if(pid < 0){
    32b8:	b94087e0 	ldr	w0, [sp, #132]
    32bc:	7100001f 	cmp	w0, #0x0
    32c0:	5400012a 	b.ge	32e4 <sbrktest+0xf4>  // b.tcont
        printf(stdout, "sbrk test fork failed\n");
    32c4:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    32c8:	9121e000 	add	x0, x0, #0x878
    32cc:	b9400002 	ldr	w2, [x0]
    32d0:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    32d4:	9110a001 	add	x1, x0, #0x428
    32d8:	2a0203e0 	mov	w0, w2
    32dc:	9400054b 	bl	4808 <printf>
        exit();
    32e0:	94000443 	bl	43ec <exit>
    }
    c = sbrk(1);
    32e4:	52800020 	mov	w0, #0x1                   	// #1
    32e8:	940004da 	bl	4650 <sbrk>
    32ec:	f9003fe0 	str	x0, [sp, #120]
    c = sbrk(1);
    32f0:	52800020 	mov	w0, #0x1                   	// #1
    32f4:	940004d7 	bl	4650 <sbrk>
    32f8:	f9003fe0 	str	x0, [sp, #120]
    if(c != a + 1){
    32fc:	f9404fe0 	ldr	x0, [sp, #152]
    3300:	91000400 	add	x0, x0, #0x1
    3304:	f9403fe1 	ldr	x1, [sp, #120]
    3308:	eb00003f 	cmp	x1, x0
    330c:	54000120 	b.eq	3330 <sbrktest+0x140>  // b.none
        printf(stdout, "sbrk test failed post-fork\n");
    3310:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3314:	9121e000 	add	x0, x0, #0x878
    3318:	b9400002 	ldr	w2, [x0]
    331c:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3320:	91110001 	add	x1, x0, #0x440
    3324:	2a0203e0 	mov	w0, w2
    3328:	94000538 	bl	4808 <printf>
        exit();
    332c:	94000430 	bl	43ec <exit>
    }
    if(pid == 0)
    3330:	b94087e0 	ldr	w0, [sp, #132]
    3334:	7100001f 	cmp	w0, #0x0
    3338:	54000041 	b.ne	3340 <sbrktest+0x150>  // b.any
        exit();
    333c:	9400042c 	bl	43ec <exit>
    wait();
    3340:	94000434 	bl	4410 <wait>
    
    // can one grow address space to something big?
#define BIG (100*1024*1024)
    a = sbrk(0);
    3344:	52800000 	mov	w0, #0x0                   	// #0
    3348:	940004c2 	bl	4650 <sbrk>
    334c:	f9004fe0 	str	x0, [sp, #152]
    amt = (BIG) - (uint64)a;
    3350:	f9404fe0 	ldr	x0, [sp, #152]
    3354:	2a0003e1 	mov	w1, w0
    3358:	52a0c800 	mov	w0, #0x6400000             	// #104857600
    335c:	4b010000 	sub	w0, w0, w1
    3360:	b90077e0 	str	w0, [sp, #116]
    p = sbrk(amt);
    3364:	b94077e0 	ldr	w0, [sp, #116]
    3368:	940004ba 	bl	4650 <sbrk>
    336c:	f90037e0 	str	x0, [sp, #104]
    if (p != a) {
    3370:	f94037e1 	ldr	x1, [sp, #104]
    3374:	f9404fe0 	ldr	x0, [sp, #152]
    3378:	eb00003f 	cmp	x1, x0
    337c:	54000120 	b.eq	33a0 <sbrktest+0x1b0>  // b.none
        printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    3380:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3384:	9121e000 	add	x0, x0, #0x878
    3388:	b9400002 	ldr	w2, [x0]
    338c:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3390:	91118001 	add	x1, x0, #0x460
    3394:	2a0203e0 	mov	w0, w2
    3398:	9400051c 	bl	4808 <printf>
        exit();
    339c:	94000414 	bl	43ec <exit>
    }
    lastaddr = (char*) (BIG-1);
    33a0:	12bf3800 	mov	w0, #0x63fffff             	// #104857599
    33a4:	f90033e0 	str	x0, [sp, #96]
    *lastaddr = 99;
    33a8:	f94033e0 	ldr	x0, [sp, #96]
    33ac:	52800c61 	mov	w1, #0x63                  	// #99
    33b0:	39000001 	strb	w1, [x0]
    
    // can one de-allocate?
    a = sbrk(0);
    33b4:	52800000 	mov	w0, #0x0                   	// #0
    33b8:	940004a6 	bl	4650 <sbrk>
    33bc:	f9004fe0 	str	x0, [sp, #152]
    c = sbrk(-4096);
    33c0:	1281ffe0 	mov	w0, #0xfffff000            	// #-4096
    33c4:	940004a3 	bl	4650 <sbrk>
    33c8:	f9003fe0 	str	x0, [sp, #120]
    if(c == (char*)0xffffffff){
    33cc:	f9403fe1 	ldr	x1, [sp, #120]
    33d0:	b2407fe0 	mov	x0, #0xffffffff            	// #4294967295
    33d4:	eb00003f 	cmp	x1, x0
    33d8:	54000121 	b.ne	33fc <sbrktest+0x20c>  // b.any
        printf(stdout, "sbrk could not deallocate\n");
    33dc:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    33e0:	9121e000 	add	x0, x0, #0x878
    33e4:	b9400002 	ldr	w2, [x0]
    33e8:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    33ec:	91128001 	add	x1, x0, #0x4a0
    33f0:	2a0203e0 	mov	w0, w2
    33f4:	94000505 	bl	4808 <printf>
        exit();
    33f8:	940003fd 	bl	43ec <exit>
    }
    c = sbrk(0);
    33fc:	52800000 	mov	w0, #0x0                   	// #0
    3400:	94000494 	bl	4650 <sbrk>
    3404:	f9003fe0 	str	x0, [sp, #120]
    if(c != a - 4096){
    3408:	f9404fe0 	ldr	x0, [sp, #152]
    340c:	d1400400 	sub	x0, x0, #0x1, lsl #12
    3410:	f9403fe1 	ldr	x1, [sp, #120]
    3414:	eb00003f 	cmp	x1, x0
    3418:	54000160 	b.eq	3444 <sbrktest+0x254>  // b.none
        printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    341c:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3420:	9121e000 	add	x0, x0, #0x878
    3424:	b9400004 	ldr	w4, [x0]
    3428:	f9403fe3 	ldr	x3, [sp, #120]
    342c:	f9404fe2 	ldr	x2, [sp, #152]
    3430:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3434:	91130001 	add	x1, x0, #0x4c0
    3438:	2a0403e0 	mov	w0, w4
    343c:	940004f3 	bl	4808 <printf>
        exit();
    3440:	940003eb 	bl	43ec <exit>
    }
    
    // can one re-allocate that page?
    a = sbrk(0);
    3444:	52800000 	mov	w0, #0x0                   	// #0
    3448:	94000482 	bl	4650 <sbrk>
    344c:	f9004fe0 	str	x0, [sp, #152]
    c = sbrk(4096);
    3450:	52820000 	mov	w0, #0x1000                	// #4096
    3454:	9400047f 	bl	4650 <sbrk>
    3458:	f9003fe0 	str	x0, [sp, #120]
    if(c != a || sbrk(0) != a + 4096){
    345c:	f9403fe1 	ldr	x1, [sp, #120]
    3460:	f9404fe0 	ldr	x0, [sp, #152]
    3464:	eb00003f 	cmp	x1, x0
    3468:	54000101 	b.ne	3488 <sbrktest+0x298>  // b.any
    346c:	52800000 	mov	w0, #0x0                   	// #0
    3470:	94000478 	bl	4650 <sbrk>
    3474:	aa0003e1 	mov	x1, x0
    3478:	f9404fe0 	ldr	x0, [sp, #152]
    347c:	91400400 	add	x0, x0, #0x1, lsl #12
    3480:	eb00003f 	cmp	x1, x0
    3484:	54000160 	b.eq	34b0 <sbrktest+0x2c0>  // b.none
        printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    3488:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    348c:	9121e000 	add	x0, x0, #0x878
    3490:	b9400004 	ldr	w4, [x0]
    3494:	f9403fe3 	ldr	x3, [sp, #120]
    3498:	f9404fe2 	ldr	x2, [sp, #152]
    349c:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    34a0:	9113e001 	add	x1, x0, #0x4f8
    34a4:	2a0403e0 	mov	w0, w4
    34a8:	940004d8 	bl	4808 <printf>
        exit();
    34ac:	940003d0 	bl	43ec <exit>
    }
    if(*lastaddr == 99){
    34b0:	f94033e0 	ldr	x0, [sp, #96]
    34b4:	39400000 	ldrb	w0, [x0]
    34b8:	71018c1f 	cmp	w0, #0x63
    34bc:	54000121 	b.ne	34e0 <sbrktest+0x2f0>  // b.any
        // should be zero
        printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    34c0:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    34c4:	9121e000 	add	x0, x0, #0x878
    34c8:	b9400002 	ldr	w2, [x0]
    34cc:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    34d0:	91148001 	add	x1, x0, #0x520
    34d4:	2a0203e0 	mov	w0, w2
    34d8:	940004cc 	bl	4808 <printf>
        exit();
    34dc:	940003c4 	bl	43ec <exit>
    }
    
    a = sbrk(0);
    34e0:	52800000 	mov	w0, #0x0                   	// #0
    34e4:	9400045b 	bl	4650 <sbrk>
    34e8:	f9004fe0 	str	x0, [sp, #152]
    c = sbrk(-(sbrk(0) - oldbrk));
    34ec:	52800000 	mov	w0, #0x0                   	// #0
    34f0:	94000458 	bl	4650 <sbrk>
    34f4:	aa0003e1 	mov	x1, x0
    34f8:	f94047e0 	ldr	x0, [sp, #136]
    34fc:	cb010000 	sub	x0, x0, x1
    3500:	94000454 	bl	4650 <sbrk>
    3504:	f9003fe0 	str	x0, [sp, #120]
    if(c != a){
    3508:	f9403fe1 	ldr	x1, [sp, #120]
    350c:	f9404fe0 	ldr	x0, [sp, #152]
    3510:	eb00003f 	cmp	x1, x0
    3514:	54000160 	b.eq	3540 <sbrktest+0x350>  // b.none
        printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    3518:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    351c:	9121e000 	add	x0, x0, #0x878
    3520:	b9400004 	ldr	w4, [x0]
    3524:	f9403fe3 	ldr	x3, [sp, #120]
    3528:	f9404fe2 	ldr	x2, [sp, #152]
    352c:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3530:	91154001 	add	x1, x0, #0x550
    3534:	2a0403e0 	mov	w0, w4
    3538:	940004b4 	bl	4808 <printf>
        exit();
    353c:	940003ac 	bl	43ec <exit>
    }
    
    // can we read the kernel's memory?
    for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3540:	b2607fe0 	mov	x0, #0xffffffff00000000    	// #-4294967296
    3544:	f9004fe0 	str	x0, [sp, #152]
    3548:	14000026 	b	35e0 <sbrktest+0x3f0>
        ppid = getpid();
    354c:	94000438 	bl	462c <getpid>
    3550:	b9005fe0 	str	w0, [sp, #92]
        pid = fork();
    3554:	9400039d 	bl	43c8 <fork>
    3558:	b90087e0 	str	w0, [sp, #132]
        if(pid < 0){
    355c:	b94087e0 	ldr	w0, [sp, #132]
    3560:	7100001f 	cmp	w0, #0x0
    3564:	5400012a 	b.ge	3588 <sbrktest+0x398>  // b.tcont
            printf(stdout, "fork failed\n");
    3568:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    356c:	9121e000 	add	x0, x0, #0x878
    3570:	b9400002 	ldr	w2, [x0]
    3574:	d0000000 	adrp	x0, 5000 <malloc+0x3a8>
    3578:	910a4001 	add	x1, x0, #0x290
    357c:	2a0203e0 	mov	w0, w2
    3580:	940004a2 	bl	4808 <printf>
            exit();
    3584:	9400039a 	bl	43ec <exit>
        }
        if(pid == 0){
    3588:	b94087e0 	ldr	w0, [sp, #132]
    358c:	7100001f 	cmp	w0, #0x0
    3590:	540001e1 	b.ne	35cc <sbrktest+0x3dc>  // b.any
            printf(stdout, "oops could read %x = %x\n", a, *a);
    3594:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3598:	9121e000 	add	x0, x0, #0x878
    359c:	b9400004 	ldr	w4, [x0]
    35a0:	f9404fe0 	ldr	x0, [sp, #152]
    35a4:	39400000 	ldrb	w0, [x0]
    35a8:	2a0003e3 	mov	w3, w0
    35ac:	f9404fe2 	ldr	x2, [sp, #152]
    35b0:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    35b4:	9115e001 	add	x1, x0, #0x578
    35b8:	2a0403e0 	mov	w0, w4
    35bc:	94000493 	bl	4808 <printf>
            kill(ppid);
    35c0:	b9405fe0 	ldr	w0, [sp, #92]
    35c4:	940003c0 	bl	44c4 <kill>
            exit();
    35c8:	94000389 	bl	43ec <exit>
        }
        wait();
    35cc:	94000391 	bl	4410 <wait>
    for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    35d0:	f9404fe1 	ldr	x1, [sp, #152]
    35d4:	d2986a00 	mov	x0, #0xc350                	// #50000
    35d8:	8b000020 	add	x0, x1, x0
    35dc:	f9004fe0 	str	x0, [sp, #152]
    35e0:	f9404fe1 	ldr	x1, [sp, #152]
    35e4:	928f7000 	mov	x0, #0xffffffffffff847f    	// #-31617
    35e8:	f2a003c0 	movk	x0, #0x1e, lsl #16
    35ec:	eb00003f 	cmp	x1, x0
    35f0:	54fffae9 	b.ls	354c <sbrktest+0x35c>  // b.plast
    }
    
    // if we run the system out of memory, does it clean up the last
    // failed allocation?
    if(pipe(fds) != 0){
    35f4:	910123e0 	add	x0, sp, #0x48
    35f8:	9400038f 	bl	4434 <pipe>
    35fc:	7100001f 	cmp	w0, #0x0
    3600:	540000c0 	b.eq	3618 <sbrktest+0x428>  // b.none
        printf(1, "pipe() failed\n");
    3604:	d0000000 	adrp	x0, 5000 <malloc+0x3a8>
    3608:	9106c001 	add	x1, x0, #0x1b0
    360c:	52800020 	mov	w0, #0x1                   	// #1
    3610:	9400047e 	bl	4808 <printf>
        exit();
    3614:	94000376 	bl	43ec <exit>
    }
    for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3618:	b90097ff 	str	wzr, [sp, #148]
    361c:	14000029 	b	36c0 <sbrktest+0x4d0>
        if((pids[i] = fork()) == 0){
    3620:	9400036a 	bl	43c8 <fork>
    3624:	2a0003e2 	mov	w2, w0
    3628:	b98097e0 	ldrsw	x0, [sp, #148]
    362c:	d37ef400 	lsl	x0, x0, #2
    3630:	910083e1 	add	x1, sp, #0x20
    3634:	b8206822 	str	w2, [x1, x0]
    3638:	b98097e0 	ldrsw	x0, [sp, #148]
    363c:	d37ef400 	lsl	x0, x0, #2
    3640:	910083e1 	add	x1, sp, #0x20
    3644:	b8606820 	ldr	w0, [x1, x0]
    3648:	7100001f 	cmp	w0, #0x0
    364c:	54000201 	b.ne	368c <sbrktest+0x49c>  // b.any
            // allocate a lot of memory
            sbrk(BIG - (uint64)sbrk(0));
    3650:	52800000 	mov	w0, #0x0                   	// #0
    3654:	940003ff 	bl	4650 <sbrk>
    3658:	2a0003e1 	mov	w1, w0
    365c:	52a0c800 	mov	w0, #0x6400000             	// #104857600
    3660:	4b010000 	sub	w0, w0, w1
    3664:	940003fb 	bl	4650 <sbrk>
            write(fds[1], "x", 1);
    3668:	b9404fe3 	ldr	w3, [sp, #76]
    366c:	52800022 	mov	w2, #0x1                   	// #1
    3670:	d0000000 	adrp	x0, 5000 <malloc+0x3a8>
    3674:	9108a001 	add	x1, x0, #0x228
    3678:	2a0303e0 	mov	w0, w3
    367c:	94000380 	bl	447c <write>
            // sit around until killed
            for(;;) sleep(1000);
    3680:	52807d00 	mov	w0, #0x3e8                 	// #1000
    3684:	940003fc 	bl	4674 <sleep>
    3688:	17fffffe 	b	3680 <sbrktest+0x490>
        }
        if(pids[i] != -1)
    368c:	b98097e0 	ldrsw	x0, [sp, #148]
    3690:	d37ef400 	lsl	x0, x0, #2
    3694:	910083e1 	add	x1, sp, #0x20
    3698:	b8606820 	ldr	w0, [x1, x0]
    369c:	3100041f 	cmn	w0, #0x1
    36a0:	540000a0 	b.eq	36b4 <sbrktest+0x4c4>  // b.none
            read(fds[0], &scratch, 1);
    36a4:	b9404be0 	ldr	w0, [sp, #72]
    36a8:	91007fe1 	add	x1, sp, #0x1f
    36ac:	52800022 	mov	w2, #0x1                   	// #1
    36b0:	9400036a 	bl	4458 <read>
    for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    36b4:	b94097e0 	ldr	w0, [sp, #148]
    36b8:	11000400 	add	w0, w0, #0x1
    36bc:	b90097e0 	str	w0, [sp, #148]
    36c0:	b94097e0 	ldr	w0, [sp, #148]
    36c4:	7100241f 	cmp	w0, #0x9
    36c8:	54fffac9 	b.ls	3620 <sbrktest+0x430>  // b.plast
    }
    // if those failed allocations freed up the pages they did allocate,
    // we'll be able to allocate here
    c = sbrk(4096);
    36cc:	52820000 	mov	w0, #0x1000                	// #4096
    36d0:	940003e0 	bl	4650 <sbrk>
    36d4:	f9003fe0 	str	x0, [sp, #120]
    for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    36d8:	b90097ff 	str	wzr, [sp, #148]
    36dc:	14000012 	b	3724 <sbrktest+0x534>
        if(pids[i] == -1)
    36e0:	b98097e0 	ldrsw	x0, [sp, #148]
    36e4:	d37ef400 	lsl	x0, x0, #2
    36e8:	910083e1 	add	x1, sp, #0x20
    36ec:	b8606820 	ldr	w0, [x1, x0]
    36f0:	3100041f 	cmn	w0, #0x1
    36f4:	54000100 	b.eq	3714 <sbrktest+0x524>  // b.none
            continue;
        kill(pids[i]);
    36f8:	b98097e0 	ldrsw	x0, [sp, #148]
    36fc:	d37ef400 	lsl	x0, x0, #2
    3700:	910083e1 	add	x1, sp, #0x20
    3704:	b8606820 	ldr	w0, [x1, x0]
    3708:	9400036f 	bl	44c4 <kill>
        wait();
    370c:	94000341 	bl	4410 <wait>
    3710:	14000002 	b	3718 <sbrktest+0x528>
            continue;
    3714:	d503201f 	nop
    for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    3718:	b94097e0 	ldr	w0, [sp, #148]
    371c:	11000400 	add	w0, w0, #0x1
    3720:	b90097e0 	str	w0, [sp, #148]
    3724:	b94097e0 	ldr	w0, [sp, #148]
    3728:	7100241f 	cmp	w0, #0x9
    372c:	54fffda9 	b.ls	36e0 <sbrktest+0x4f0>  // b.plast
    }
    if(c == (char*)0xffffffff){
    3730:	f9403fe1 	ldr	x1, [sp, #120]
    3734:	b2407fe0 	mov	x0, #0xffffffff            	// #4294967295
    3738:	eb00003f 	cmp	x1, x0
    373c:	54000121 	b.ne	3760 <sbrktest+0x570>  // b.any
        printf(stdout, "failed sbrk leaked memory\n");
    3740:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3744:	9121e000 	add	x0, x0, #0x878
    3748:	b9400002 	ldr	w2, [x0]
    374c:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3750:	91166001 	add	x1, x0, #0x598
    3754:	2a0203e0 	mov	w0, w2
    3758:	9400042c 	bl	4808 <printf>
        exit();
    375c:	94000324 	bl	43ec <exit>
    }
    
    if(sbrk(0) > oldbrk)
    3760:	52800000 	mov	w0, #0x0                   	// #0
    3764:	940003bb 	bl	4650 <sbrk>
    3768:	aa0003e1 	mov	x1, x0
    376c:	f94047e0 	ldr	x0, [sp, #136]
    3770:	eb01001f 	cmp	x0, x1
    3774:	540000e2 	b.cs	3790 <sbrktest+0x5a0>  // b.hs, b.nlast
        sbrk(-(sbrk(0) - oldbrk));
    3778:	52800000 	mov	w0, #0x0                   	// #0
    377c:	940003b5 	bl	4650 <sbrk>
    3780:	aa0003e1 	mov	x1, x0
    3784:	f94047e0 	ldr	x0, [sp, #136]
    3788:	cb010000 	sub	x0, x0, x1
    378c:	940003b1 	bl	4650 <sbrk>
    
    printf(stdout, "sbrk test OK\n");
    3790:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3794:	9121e000 	add	x0, x0, #0x878
    3798:	b9400002 	ldr	w2, [x0]
    379c:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    37a0:	9116e001 	add	x1, x0, #0x5b8
    37a4:	2a0203e0 	mov	w0, w2
    37a8:	94000418 	bl	4808 <printf>
}
    37ac:	d503201f 	nop
    37b0:	a8ca7bfd 	ldp	x29, x30, [sp], #160
    37b4:	d65f03c0 	ret

00000000000037b8 <validateint>:

void
validateint(int *p)
{
    37b8:	d10043ff 	sub	sp, sp, #0x10
    37bc:	f90007e0 	str	x0, [sp, #8]
}
    37c0:	d503201f 	nop
    37c4:	910043ff 	add	sp, sp, #0x10
    37c8:	d65f03c0 	ret

00000000000037cc <validatetest>:

void
validatetest(void)
{
    37cc:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    37d0:	910003fd 	mov	x29, sp
    int hi, pid;
    uint64 p;
    
    printf(stdout, "validate test\n");
    37d4:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    37d8:	9121e000 	add	x0, x0, #0x878
    37dc:	b9400002 	ldr	w2, [x0]
    37e0:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    37e4:	91172001 	add	x1, x0, #0x5c8
    37e8:	2a0203e0 	mov	w0, w2
    37ec:	94000407 	bl	4808 <printf>
    hi = 1100*1024;
    37f0:	52860000 	mov	w0, #0x3000                	// #12288
    37f4:	72a00220 	movk	w0, #0x11, lsl #16
    37f8:	b90017e0 	str	w0, [sp, #20]
    
    for(p = 0; p <= (uint)hi; p += 4096){
    37fc:	f9000fff 	str	xzr, [sp, #24]
    3800:	14000022 	b	3888 <validatetest+0xbc>
        if((pid = fork()) == 0){
    3804:	940002f1 	bl	43c8 <fork>
    3808:	b90013e0 	str	w0, [sp, #16]
    380c:	b94013e0 	ldr	w0, [sp, #16]
    3810:	7100001f 	cmp	w0, #0x0
    3814:	54000081 	b.ne	3824 <validatetest+0x58>  // b.any
            // try to crash the kernel by passing in a badly placed integer
            validateint((int*)p);
    3818:	f9400fe0 	ldr	x0, [sp, #24]
    381c:	97ffffe7 	bl	37b8 <validateint>
            exit();
    3820:	940002f3 	bl	43ec <exit>
        }
        sleep(0);
    3824:	52800000 	mov	w0, #0x0                   	// #0
    3828:	94000393 	bl	4674 <sleep>
        sleep(0);
    382c:	52800000 	mov	w0, #0x0                   	// #0
    3830:	94000391 	bl	4674 <sleep>
        kill(pid);
    3834:	b94013e0 	ldr	w0, [sp, #16]
    3838:	94000323 	bl	44c4 <kill>
        wait();
    383c:	940002f5 	bl	4410 <wait>
        
        // try to crash the kernel by passing in a bad string pointer
        if(link("nosuchfile", (char*)p) != -1){
    3840:	f9400fe0 	ldr	x0, [sp, #24]
    3844:	aa0003e1 	mov	x1, x0
    3848:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    384c:	91176000 	add	x0, x0, #0x5d8
    3850:	94000353 	bl	459c <link>
    3854:	3100041f 	cmn	w0, #0x1
    3858:	54000120 	b.eq	387c <validatetest+0xb0>  // b.none
            printf(stdout, "link should not succeed\n");
    385c:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3860:	9121e000 	add	x0, x0, #0x878
    3864:	b9400002 	ldr	w2, [x0]
    3868:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    386c:	9117a001 	add	x1, x0, #0x5e8
    3870:	2a0203e0 	mov	w0, w2
    3874:	940003e5 	bl	4808 <printf>
            exit();
    3878:	940002dd 	bl	43ec <exit>
    for(p = 0; p <= (uint)hi; p += 4096){
    387c:	f9400fe0 	ldr	x0, [sp, #24]
    3880:	91400400 	add	x0, x0, #0x1, lsl #12
    3884:	f9000fe0 	str	x0, [sp, #24]
    3888:	b94017e0 	ldr	w0, [sp, #20]
    388c:	2a0003e0 	mov	w0, w0
    3890:	f9400fe1 	ldr	x1, [sp, #24]
    3894:	eb00003f 	cmp	x1, x0
    3898:	54fffb69 	b.ls	3804 <validatetest+0x38>  // b.plast
        }
    }
    
    printf(stdout, "validate ok\n");
    389c:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    38a0:	9121e000 	add	x0, x0, #0x878
    38a4:	b9400002 	ldr	w2, [x0]
    38a8:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    38ac:	91182001 	add	x1, x0, #0x608
    38b0:	2a0203e0 	mov	w0, w2
    38b4:	940003d5 	bl	4808 <printf>
}
    38b8:	d503201f 	nop
    38bc:	a8c27bfd 	ldp	x29, x30, [sp], #32
    38c0:	d65f03c0 	ret

00000000000038c4 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    38c4:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    38c8:	910003fd 	mov	x29, sp
    int i;
    
    printf(stdout, "bss test\n");
    38cc:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    38d0:	9121e000 	add	x0, x0, #0x878
    38d4:	b9400002 	ldr	w2, [x0]
    38d8:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    38dc:	91186001 	add	x1, x0, #0x618
    38e0:	2a0203e0 	mov	w0, w2
    38e4:	940003c9 	bl	4808 <printf>
    for(i = 0; i < sizeof(uninit); i++){
    38e8:	b9001fff 	str	wzr, [sp, #28]
    38ec:	14000012 	b	3934 <bsstest+0x70>
        if(uninit[i] != '\0'){
    38f0:	b0000020 	adrp	x0, 8000 <buf+0x1760>
    38f4:	9122a001 	add	x1, x0, #0x8a8
    38f8:	b9801fe0 	ldrsw	x0, [sp, #28]
    38fc:	38606820 	ldrb	w0, [x1, x0]
    3900:	7100001f 	cmp	w0, #0x0
    3904:	54000120 	b.eq	3928 <bsstest+0x64>  // b.none
            printf(stdout, "bss test failed\n");
    3908:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    390c:	9121e000 	add	x0, x0, #0x878
    3910:	b9400002 	ldr	w2, [x0]
    3914:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3918:	9118a001 	add	x1, x0, #0x628
    391c:	2a0203e0 	mov	w0, w2
    3920:	940003ba 	bl	4808 <printf>
            exit();
    3924:	940002b2 	bl	43ec <exit>
    for(i = 0; i < sizeof(uninit); i++){
    3928:	b9401fe0 	ldr	w0, [sp, #28]
    392c:	11000400 	add	w0, w0, #0x1
    3930:	b9001fe0 	str	w0, [sp, #28]
    3934:	b9401fe1 	ldr	w1, [sp, #28]
    3938:	5284e1e0 	mov	w0, #0x270f                	// #9999
    393c:	6b00003f 	cmp	w1, w0
    3940:	54fffd89 	b.ls	38f0 <bsstest+0x2c>  // b.plast
        }
    }
    printf(stdout, "bss test ok\n");
    3944:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3948:	9121e000 	add	x0, x0, #0x878
    394c:	b9400002 	ldr	w2, [x0]
    3950:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3954:	91190001 	add	x1, x0, #0x640
    3958:	2a0203e0 	mov	w0, w2
    395c:	940003ab 	bl	4808 <printf>
}
    3960:	d503201f 	nop
    3964:	a8c27bfd 	ldp	x29, x30, [sp], #32
    3968:	d65f03c0 	ret

000000000000396c <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    396c:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    3970:	910003fd 	mov	x29, sp
    int pid, fd;
    
    unlink("bigarg-ok");
    3974:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3978:	91194000 	add	x0, x0, #0x650
    397c:	940002f6 	bl	4554 <unlink>
    pid = fork();
    3980:	94000292 	bl	43c8 <fork>
    3984:	b9001be0 	str	w0, [sp, #24]
    if(pid == 0){
    3988:	b9401be0 	ldr	w0, [sp, #24]
    398c:	7100001f 	cmp	w0, #0x0
    3990:	540005a1 	b.ne	3a44 <bigargtest+0xd8>  // b.any
        static char *args[MAXARG];
        int i;
        for(i = 0; i < MAXARG-1; i++)
    3994:	b9001fff 	str	wzr, [sp, #28]
    3998:	1400000a 	b	39c0 <bigargtest+0x54>
            args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    399c:	f0000020 	adrp	x0, a000 <uninit+0x1758>
    39a0:	913ee000 	add	x0, x0, #0xfb8
    39a4:	b9801fe1 	ldrsw	x1, [sp, #28]
    39a8:	f0000002 	adrp	x2, 6000 <malloc+0x13a8>
    39ac:	91198042 	add	x2, x2, #0x660
    39b0:	f8217802 	str	x2, [x0, x1, lsl #3]
        for(i = 0; i < MAXARG-1; i++)
    39b4:	b9401fe0 	ldr	w0, [sp, #28]
    39b8:	11000400 	add	w0, w0, #0x1
    39bc:	b9001fe0 	str	w0, [sp, #28]
    39c0:	b9401fe0 	ldr	w0, [sp, #28]
    39c4:	7100781f 	cmp	w0, #0x1e
    39c8:	54fffead 	b.le	399c <bigargtest+0x30>
        args[MAXARG-1] = 0;
    39cc:	f0000020 	adrp	x0, a000 <uninit+0x1758>
    39d0:	913ee000 	add	x0, x0, #0xfb8
    39d4:	f9007c1f 	str	xzr, [x0, #248]
        printf(stdout, "bigarg test\n");
    39d8:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    39dc:	9121e000 	add	x0, x0, #0x878
    39e0:	b9400002 	ldr	w2, [x0]
    39e4:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    39e8:	911d0001 	add	x1, x0, #0x740
    39ec:	2a0203e0 	mov	w0, w2
    39f0:	94000386 	bl	4808 <printf>
        exec("echo", args);
    39f4:	f0000020 	adrp	x0, a000 <uninit+0x1758>
    39f8:	913ee001 	add	x1, x0, #0xfb8
    39fc:	b0000000 	adrp	x0, 4000 <strcmp+0x2c>
    3a00:	91374000 	add	x0, x0, #0xdd0
    3a04:	940002b9 	bl	44e8 <exec>
        printf(stdout, "bigarg test ok\n");
    3a08:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3a0c:	9121e000 	add	x0, x0, #0x878
    3a10:	b9400002 	ldr	w2, [x0]
    3a14:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3a18:	911d4001 	add	x1, x0, #0x750
    3a1c:	2a0203e0 	mov	w0, w2
    3a20:	9400037a 	bl	4808 <printf>
        fd = open("bigarg-ok", O_CREATE);
    3a24:	52804001 	mov	w1, #0x200                 	// #512
    3a28:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3a2c:	91194000 	add	x0, x0, #0x650
    3a30:	940002b7 	bl	450c <open>
    3a34:	b90017e0 	str	w0, [sp, #20]
        close(fd);
    3a38:	b94017e0 	ldr	w0, [sp, #20]
    3a3c:	94000299 	bl	44a0 <close>
        exit();
    3a40:	9400026b 	bl	43ec <exit>
    } else if(pid < 0){
    3a44:	b9401be0 	ldr	w0, [sp, #24]
    3a48:	7100001f 	cmp	w0, #0x0
    3a4c:	5400012a 	b.ge	3a70 <bigargtest+0x104>  // b.tcont
        printf(stdout, "bigargtest: fork failed\n");
    3a50:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3a54:	9121e000 	add	x0, x0, #0x878
    3a58:	b9400002 	ldr	w2, [x0]
    3a5c:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3a60:	911d8001 	add	x1, x0, #0x760
    3a64:	2a0203e0 	mov	w0, w2
    3a68:	94000368 	bl	4808 <printf>
        exit();
    3a6c:	94000260 	bl	43ec <exit>
    }
    wait();
    3a70:	94000268 	bl	4410 <wait>
    fd = open("bigarg-ok", 0);
    3a74:	52800001 	mov	w1, #0x0                   	// #0
    3a78:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3a7c:	91194000 	add	x0, x0, #0x650
    3a80:	940002a3 	bl	450c <open>
    3a84:	b90017e0 	str	w0, [sp, #20]
    if(fd < 0){
    3a88:	b94017e0 	ldr	w0, [sp, #20]
    3a8c:	7100001f 	cmp	w0, #0x0
    3a90:	5400012a 	b.ge	3ab4 <bigargtest+0x148>  // b.tcont
        printf(stdout, "bigarg test failed!\n");
    3a94:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3a98:	9121e000 	add	x0, x0, #0x878
    3a9c:	b9400002 	ldr	w2, [x0]
    3aa0:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3aa4:	911e0001 	add	x1, x0, #0x780
    3aa8:	2a0203e0 	mov	w0, w2
    3aac:	94000357 	bl	4808 <printf>
        exit();
    3ab0:	9400024f 	bl	43ec <exit>
    }
    close(fd);
    3ab4:	b94017e0 	ldr	w0, [sp, #20]
    3ab8:	9400027a 	bl	44a0 <close>
    unlink("bigarg-ok");
    3abc:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3ac0:	91194000 	add	x0, x0, #0x650
    3ac4:	940002a4 	bl	4554 <unlink>
}
    3ac8:	d503201f 	nop
    3acc:	a8c27bfd 	ldp	x29, x30, [sp], #32
    3ad0:	d65f03c0 	ret

0000000000003ad4 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3ad4:	a9b97bfd 	stp	x29, x30, [sp, #-112]!
    3ad8:	910003fd 	mov	x29, sp
    int nfiles;
    int fsblocks = 0;
    3adc:	b9006bff 	str	wzr, [sp, #104]
    
    printf(1, "fsfull test\n");
    3ae0:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3ae4:	911e6001 	add	x1, x0, #0x798
    3ae8:	52800020 	mov	w0, #0x1                   	// #1
    3aec:	94000347 	bl	4808 <printf>
    
    for(nfiles = 0; ; nfiles++){
    3af0:	b9006fff 	str	wzr, [sp, #108]
        char name[64];
        name[0] = 'f';
    3af4:	52800cc0 	mov	w0, #0x66                  	// #102
    3af8:	390063e0 	strb	w0, [sp, #24]
        name[1] = '0' + nfiles / 1000;
    3afc:	b9406fe0 	ldr	w0, [sp, #108]
    3b00:	5289ba61 	mov	w1, #0x4dd3                	// #19923
    3b04:	72a20c41 	movk	w1, #0x1062, lsl #16
    3b08:	9b217c01 	smull	x1, w0, w1
    3b0c:	d360fc21 	lsr	x1, x1, #32
    3b10:	13067c21 	asr	w1, w1, #6
    3b14:	131f7c00 	asr	w0, w0, #31
    3b18:	4b000020 	sub	w0, w1, w0
    3b1c:	12001c00 	and	w0, w0, #0xff
    3b20:	1100c000 	add	w0, w0, #0x30
    3b24:	12001c00 	and	w0, w0, #0xff
    3b28:	390067e0 	strb	w0, [sp, #25]
        name[2] = '0' + (nfiles % 1000) / 100;
    3b2c:	b9406fe1 	ldr	w1, [sp, #108]
    3b30:	5289ba60 	mov	w0, #0x4dd3                	// #19923
    3b34:	72a20c40 	movk	w0, #0x1062, lsl #16
    3b38:	9b207c20 	smull	x0, w1, w0
    3b3c:	d360fc00 	lsr	x0, x0, #32
    3b40:	13067c02 	asr	w2, w0, #6
    3b44:	131f7c20 	asr	w0, w1, #31
    3b48:	4b000040 	sub	w0, w2, w0
    3b4c:	52807d02 	mov	w2, #0x3e8                 	// #1000
    3b50:	1b027c00 	mul	w0, w0, w2
    3b54:	4b000020 	sub	w0, w1, w0
    3b58:	5290a3e1 	mov	w1, #0x851f                	// #34079
    3b5c:	72aa3d61 	movk	w1, #0x51eb, lsl #16
    3b60:	9b217c01 	smull	x1, w0, w1
    3b64:	d360fc21 	lsr	x1, x1, #32
    3b68:	13057c21 	asr	w1, w1, #5
    3b6c:	131f7c00 	asr	w0, w0, #31
    3b70:	4b000020 	sub	w0, w1, w0
    3b74:	12001c00 	and	w0, w0, #0xff
    3b78:	1100c000 	add	w0, w0, #0x30
    3b7c:	12001c00 	and	w0, w0, #0xff
    3b80:	39006be0 	strb	w0, [sp, #26]
        name[3] = '0' + (nfiles % 100) / 10;
    3b84:	b9406fe1 	ldr	w1, [sp, #108]
    3b88:	5290a3e0 	mov	w0, #0x851f                	// #34079
    3b8c:	72aa3d60 	movk	w0, #0x51eb, lsl #16
    3b90:	9b207c20 	smull	x0, w1, w0
    3b94:	d360fc00 	lsr	x0, x0, #32
    3b98:	13057c02 	asr	w2, w0, #5
    3b9c:	131f7c20 	asr	w0, w1, #31
    3ba0:	4b000040 	sub	w0, w2, w0
    3ba4:	52800c82 	mov	w2, #0x64                  	// #100
    3ba8:	1b027c00 	mul	w0, w0, w2
    3bac:	4b000020 	sub	w0, w1, w0
    3bb0:	528ccce1 	mov	w1, #0x6667                	// #26215
    3bb4:	72acccc1 	movk	w1, #0x6666, lsl #16
    3bb8:	9b217c01 	smull	x1, w0, w1
    3bbc:	d360fc21 	lsr	x1, x1, #32
    3bc0:	13027c21 	asr	w1, w1, #2
    3bc4:	131f7c00 	asr	w0, w0, #31
    3bc8:	4b000020 	sub	w0, w1, w0
    3bcc:	12001c00 	and	w0, w0, #0xff
    3bd0:	1100c000 	add	w0, w0, #0x30
    3bd4:	12001c00 	and	w0, w0, #0xff
    3bd8:	39006fe0 	strb	w0, [sp, #27]
        name[4] = '0' + (nfiles % 10);
    3bdc:	b9406fe1 	ldr	w1, [sp, #108]
    3be0:	528ccce0 	mov	w0, #0x6667                	// #26215
    3be4:	72acccc0 	movk	w0, #0x6666, lsl #16
    3be8:	9b207c20 	smull	x0, w1, w0
    3bec:	d360fc00 	lsr	x0, x0, #32
    3bf0:	13027c02 	asr	w2, w0, #2
    3bf4:	131f7c20 	asr	w0, w1, #31
    3bf8:	4b000042 	sub	w2, w2, w0
    3bfc:	2a0203e0 	mov	w0, w2
    3c00:	531e7400 	lsl	w0, w0, #2
    3c04:	0b020000 	add	w0, w0, w2
    3c08:	531f7800 	lsl	w0, w0, #1
    3c0c:	4b000022 	sub	w2, w1, w0
    3c10:	12001c40 	and	w0, w2, #0xff
    3c14:	1100c000 	add	w0, w0, #0x30
    3c18:	12001c00 	and	w0, w0, #0xff
    3c1c:	390073e0 	strb	w0, [sp, #28]
        name[5] = '\0';
    3c20:	390077ff 	strb	wzr, [sp, #29]
        printf(1, "writing %s\n", name);
    3c24:	910063e0 	add	x0, sp, #0x18
    3c28:	aa0003e2 	mov	x2, x0
    3c2c:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3c30:	911ea001 	add	x1, x0, #0x7a8
    3c34:	52800020 	mov	w0, #0x1                   	// #1
    3c38:	940002f4 	bl	4808 <printf>
        int fd = open(name, O_CREATE|O_RDWR);
    3c3c:	910063e0 	add	x0, sp, #0x18
    3c40:	52804041 	mov	w1, #0x202                 	// #514
    3c44:	94000232 	bl	450c <open>
    3c48:	b90063e0 	str	w0, [sp, #96]
        if(fd < 0){
    3c4c:	b94063e0 	ldr	w0, [sp, #96]
    3c50:	7100001f 	cmp	w0, #0x0
    3c54:	5400010a 	b.ge	3c74 <fsfull+0x1a0>  // b.tcont
            printf(1, "open %s failed\n", name);
    3c58:	910063e0 	add	x0, sp, #0x18
    3c5c:	aa0003e2 	mov	x2, x0
    3c60:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3c64:	911ee001 	add	x1, x0, #0x7b8
    3c68:	52800020 	mov	w0, #0x1                   	// #1
    3c6c:	940002e7 	bl	4808 <printf>
            break;
    3c70:	14000023 	b	3cfc <fsfull+0x228>
        }
        int total = 0;
    3c74:	b90067ff 	str	wzr, [sp, #100]
        while(1){
            int cc = write(fd, buf, 512);
    3c78:	52804002 	mov	w2, #0x200                 	// #512
    3c7c:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3c80:	91228001 	add	x1, x0, #0x8a0
    3c84:	b94063e0 	ldr	w0, [sp, #96]
    3c88:	940001fd 	bl	447c <write>
    3c8c:	b9005fe0 	str	w0, [sp, #92]
            if(cc < 512)
    3c90:	b9405fe0 	ldr	w0, [sp, #92]
    3c94:	7107fc1f 	cmp	w0, #0x1ff
    3c98:	5400012d 	b.le	3cbc <fsfull+0x1e8>
                break;
            total += cc;
    3c9c:	b94067e1 	ldr	w1, [sp, #100]
    3ca0:	b9405fe0 	ldr	w0, [sp, #92]
    3ca4:	0b000020 	add	w0, w1, w0
    3ca8:	b90067e0 	str	w0, [sp, #100]
            fsblocks++;
    3cac:	b9406be0 	ldr	w0, [sp, #104]
    3cb0:	11000400 	add	w0, w0, #0x1
    3cb4:	b9006be0 	str	w0, [sp, #104]
        while(1){
    3cb8:	17fffff0 	b	3c78 <fsfull+0x1a4>
                break;
    3cbc:	d503201f 	nop
        }
        printf(1, "wrote %d bytes\n", total);
    3cc0:	b94067e2 	ldr	w2, [sp, #100]
    3cc4:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3cc8:	911f2001 	add	x1, x0, #0x7c8
    3ccc:	52800020 	mov	w0, #0x1                   	// #1
    3cd0:	940002ce 	bl	4808 <printf>
        close(fd);
    3cd4:	b94063e0 	ldr	w0, [sp, #96]
    3cd8:	940001f2 	bl	44a0 <close>
        if(total == 0)
    3cdc:	b94067e0 	ldr	w0, [sp, #100]
    3ce0:	7100001f 	cmp	w0, #0x0
    3ce4:	540000a0 	b.eq	3cf8 <fsfull+0x224>  // b.none
    for(nfiles = 0; ; nfiles++){
    3ce8:	b9406fe0 	ldr	w0, [sp, #108]
    3cec:	11000400 	add	w0, w0, #0x1
    3cf0:	b9006fe0 	str	w0, [sp, #108]
    3cf4:	17ffff80 	b	3af4 <fsfull+0x20>
            break;
    3cf8:	d503201f 	nop
    }
    (void)fsblocks;
    
    while(nfiles >= 0){
    3cfc:	14000052 	b	3e44 <fsfull+0x370>
        char name[64];
        name[0] = 'f';
    3d00:	52800cc0 	mov	w0, #0x66                  	// #102
    3d04:	390063e0 	strb	w0, [sp, #24]
        name[1] = '0' + nfiles / 1000;
    3d08:	b9406fe0 	ldr	w0, [sp, #108]
    3d0c:	5289ba61 	mov	w1, #0x4dd3                	// #19923
    3d10:	72a20c41 	movk	w1, #0x1062, lsl #16
    3d14:	9b217c01 	smull	x1, w0, w1
    3d18:	d360fc21 	lsr	x1, x1, #32
    3d1c:	13067c21 	asr	w1, w1, #6
    3d20:	131f7c00 	asr	w0, w0, #31
    3d24:	4b000020 	sub	w0, w1, w0
    3d28:	12001c00 	and	w0, w0, #0xff
    3d2c:	1100c000 	add	w0, w0, #0x30
    3d30:	12001c00 	and	w0, w0, #0xff
    3d34:	390067e0 	strb	w0, [sp, #25]
        name[2] = '0' + (nfiles % 1000) / 100;
    3d38:	b9406fe1 	ldr	w1, [sp, #108]
    3d3c:	5289ba60 	mov	w0, #0x4dd3                	// #19923
    3d40:	72a20c40 	movk	w0, #0x1062, lsl #16
    3d44:	9b207c20 	smull	x0, w1, w0
    3d48:	d360fc00 	lsr	x0, x0, #32
    3d4c:	13067c02 	asr	w2, w0, #6
    3d50:	131f7c20 	asr	w0, w1, #31
    3d54:	4b000040 	sub	w0, w2, w0
    3d58:	52807d02 	mov	w2, #0x3e8                 	// #1000
    3d5c:	1b027c00 	mul	w0, w0, w2
    3d60:	4b000020 	sub	w0, w1, w0
    3d64:	5290a3e1 	mov	w1, #0x851f                	// #34079
    3d68:	72aa3d61 	movk	w1, #0x51eb, lsl #16
    3d6c:	9b217c01 	smull	x1, w0, w1
    3d70:	d360fc21 	lsr	x1, x1, #32
    3d74:	13057c21 	asr	w1, w1, #5
    3d78:	131f7c00 	asr	w0, w0, #31
    3d7c:	4b000020 	sub	w0, w1, w0
    3d80:	12001c00 	and	w0, w0, #0xff
    3d84:	1100c000 	add	w0, w0, #0x30
    3d88:	12001c00 	and	w0, w0, #0xff
    3d8c:	39006be0 	strb	w0, [sp, #26]
        name[3] = '0' + (nfiles % 100) / 10;
    3d90:	b9406fe1 	ldr	w1, [sp, #108]
    3d94:	5290a3e0 	mov	w0, #0x851f                	// #34079
    3d98:	72aa3d60 	movk	w0, #0x51eb, lsl #16
    3d9c:	9b207c20 	smull	x0, w1, w0
    3da0:	d360fc00 	lsr	x0, x0, #32
    3da4:	13057c02 	asr	w2, w0, #5
    3da8:	131f7c20 	asr	w0, w1, #31
    3dac:	4b000040 	sub	w0, w2, w0
    3db0:	52800c82 	mov	w2, #0x64                  	// #100
    3db4:	1b027c00 	mul	w0, w0, w2
    3db8:	4b000020 	sub	w0, w1, w0
    3dbc:	528ccce1 	mov	w1, #0x6667                	// #26215
    3dc0:	72acccc1 	movk	w1, #0x6666, lsl #16
    3dc4:	9b217c01 	smull	x1, w0, w1
    3dc8:	d360fc21 	lsr	x1, x1, #32
    3dcc:	13027c21 	asr	w1, w1, #2
    3dd0:	131f7c00 	asr	w0, w0, #31
    3dd4:	4b000020 	sub	w0, w1, w0
    3dd8:	12001c00 	and	w0, w0, #0xff
    3ddc:	1100c000 	add	w0, w0, #0x30
    3de0:	12001c00 	and	w0, w0, #0xff
    3de4:	39006fe0 	strb	w0, [sp, #27]
        name[4] = '0' + (nfiles % 10);
    3de8:	b9406fe1 	ldr	w1, [sp, #108]
    3dec:	528ccce0 	mov	w0, #0x6667                	// #26215
    3df0:	72acccc0 	movk	w0, #0x6666, lsl #16
    3df4:	9b207c20 	smull	x0, w1, w0
    3df8:	d360fc00 	lsr	x0, x0, #32
    3dfc:	13027c02 	asr	w2, w0, #2
    3e00:	131f7c20 	asr	w0, w1, #31
    3e04:	4b000042 	sub	w2, w2, w0
    3e08:	2a0203e0 	mov	w0, w2
    3e0c:	531e7400 	lsl	w0, w0, #2
    3e10:	0b020000 	add	w0, w0, w2
    3e14:	531f7800 	lsl	w0, w0, #1
    3e18:	4b000022 	sub	w2, w1, w0
    3e1c:	12001c40 	and	w0, w2, #0xff
    3e20:	1100c000 	add	w0, w0, #0x30
    3e24:	12001c00 	and	w0, w0, #0xff
    3e28:	390073e0 	strb	w0, [sp, #28]
        name[5] = '\0';
    3e2c:	390077ff 	strb	wzr, [sp, #29]
        unlink(name);
    3e30:	910063e0 	add	x0, sp, #0x18
    3e34:	940001c8 	bl	4554 <unlink>
        nfiles--;
    3e38:	b9406fe0 	ldr	w0, [sp, #108]
    3e3c:	51000400 	sub	w0, w0, #0x1
    3e40:	b9006fe0 	str	w0, [sp, #108]
    while(nfiles >= 0){
    3e44:	b9406fe0 	ldr	w0, [sp, #108]
    3e48:	7100001f 	cmp	w0, #0x0
    3e4c:	54fff5aa 	b.ge	3d00 <fsfull+0x22c>  // b.tcont
    }
    
    printf(1, "fsfull test finished\n");
    3e50:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3e54:	911f6001 	add	x1, x0, #0x7d8
    3e58:	52800020 	mov	w0, #0x1                   	// #1
    3e5c:	9400026b 	bl	4808 <printf>
}
    3e60:	d503201f 	nop
    3e64:	a8c77bfd 	ldp	x29, x30, [sp], #112
    3e68:	d65f03c0 	ret

0000000000003e6c <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
    randstate = randstate * 1664525 + 1013904223;
    3e6c:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3e70:	91220000 	add	x0, x0, #0x880
    3e74:	f9400001 	ldr	x1, [x0]
    3e78:	d28cc1a0 	mov	x0, #0x660d                	// #26125
    3e7c:	f2a00320 	movk	x0, #0x19, lsl #16
    3e80:	9b007c21 	mul	x1, x1, x0
    3e84:	d29e6be0 	mov	x0, #0xf35f                	// #62303
    3e88:	f2a78dc0 	movk	x0, #0x3c6e, lsl #16
    3e8c:	8b000021 	add	x1, x1, x0
    3e90:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3e94:	91220000 	add	x0, x0, #0x880
    3e98:	f9000001 	str	x1, [x0]
    return randstate;
    3e9c:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3ea0:	91220000 	add	x0, x0, #0x880
    3ea4:	f9400000 	ldr	x0, [x0]
}
    3ea8:	d65f03c0 	ret

0000000000003eac <main>:

int
main(int argc, char *argv[])
{
    3eac:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    3eb0:	910003fd 	mov	x29, sp
    3eb4:	b9001fe0 	str	w0, [sp, #28]
    3eb8:	f9000be1 	str	x1, [sp, #16]
    printf(1, "usertests starting\n");
    3ebc:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3ec0:	911fc001 	add	x1, x0, #0x7f0
    3ec4:	52800020 	mov	w0, #0x1                   	// #1
    3ec8:	94000250 	bl	4808 <printf>
    
    if(open("usertests.ran", 0) >= 0){
    3ecc:	52800001 	mov	w1, #0x0                   	// #0
    3ed0:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3ed4:	91202000 	add	x0, x0, #0x808
    3ed8:	9400018d 	bl	450c <open>
    3edc:	7100001f 	cmp	w0, #0x0
    3ee0:	540000cb 	b.lt	3ef8 <main+0x4c>  // b.tstop
        printf(1, "already ran user tests -- rebuild fs.img\n");
    3ee4:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3ee8:	91206001 	add	x1, x0, #0x818
    3eec:	52800020 	mov	w0, #0x1                   	// #1
    3ef0:	94000246 	bl	4808 <printf>
        exit();
    3ef4:	9400013e 	bl	43ec <exit>
    }
    close(open("usertests.ran", O_CREATE));
    3ef8:	52804001 	mov	w1, #0x200                 	// #512
    3efc:	f0000000 	adrp	x0, 6000 <malloc+0x13a8>
    3f00:	91202000 	add	x0, x0, #0x808
    3f04:	94000182 	bl	450c <open>
    3f08:	94000166 	bl	44a0 <close>
    
    bigargtest();
    3f0c:	97fffe98 	bl	396c <bigargtest>
    bigwrite();
    3f10:	97fffa20 	bl	2790 <bigwrite>
    bigargtest();
    3f14:	97fffe96 	bl	396c <bigargtest>
    bsstest();
    3f18:	97fffe6b 	bl	38c4 <bsstest>
    sbrktest();
    3f1c:	97fffcb5 	bl	31f0 <sbrktest>
    validatetest();
    3f20:	97fffe2b 	bl	37cc <validatetest>
    
    opentest();
    3f24:	97fff037 	bl	0 <opentest>
    writetest();
    3f28:	97fff06b 	bl	d4 <writetest>
    writetest1();
    3f2c:	97fff105 	bl	340 <writetest1>
    createtest();
    3f30:	97fff19e 	bl	5a8 <createtest>
    
    mem();
    3f34:	97fff34f 	bl	c70 <mem>
    pipe1();
    3f38:	97fff247 	bl	854 <pipe1>
    //preempt();
    exitwait();
    3f3c:	97fff325 	bl	bd0 <exitwait>
    
    rmdot();
    3f40:	97fffb3c 	bl	2c30 <rmdot>
    fourteen();
    3f44:	97fffae8 	bl	2ae4 <fourteen>
    bigfile();
    3f48:	97fffa57 	bl	28a4 <bigfile>
    subdir();
    3f4c:	97fff857 	bl	20a8 <subdir>
    concreate();
    3f50:	97fff684 	bl	1960 <concreate>
    linkunlink();
    3f54:	97fff787 	bl	1d70 <linkunlink>
    linktest();
    3f58:	97fff5f8 	bl	1738 <linktest>
    unlinkread();
    3f5c:	97fff58c 	bl	158c <unlinkread>
    createdelete();
    3f60:	97fff4b7 	bl	123c <createdelete>
    twofiles();
    3f64:	97fff40b 	bl	f90 <twofiles>
    sharedfd();
    3f68:	97fff37f 	bl	d64 <sharedfd>
    dirfile();
    3f6c:	97fffb8e 	bl	2da4 <dirfile>
    iref();
    3f70:	97fffc17 	bl	2fcc <iref>
    forktest();
    3f74:	97fffc61 	bl	30f8 <forktest>
    bigdir(); // slow
    3f78:	97fff7db 	bl	1ee4 <bigdir>
    
    exectest();
    3f7c:	97fff21b 	bl	7e8 <exectest>
    
    exit();
    3f80:	9400011b 	bl	43ec <exit>

0000000000003f84 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
    3f84:	d10083ff 	sub	sp, sp, #0x20
    3f88:	f90007e0 	str	x0, [sp, #8]
    3f8c:	f90003e1 	str	x1, [sp]
    char *os;
    
    os = s;
    3f90:	f94007e0 	ldr	x0, [sp, #8]
    3f94:	f9000fe0 	str	x0, [sp, #24]
    while((*s++ = *t++) != 0)
    3f98:	d503201f 	nop
    3f9c:	f94003e1 	ldr	x1, [sp]
    3fa0:	91000420 	add	x0, x1, #0x1
    3fa4:	f90003e0 	str	x0, [sp]
    3fa8:	f94007e0 	ldr	x0, [sp, #8]
    3fac:	91000402 	add	x2, x0, #0x1
    3fb0:	f90007e2 	str	x2, [sp, #8]
    3fb4:	39400021 	ldrb	w1, [x1]
    3fb8:	39000001 	strb	w1, [x0]
    3fbc:	39400000 	ldrb	w0, [x0]
    3fc0:	7100001f 	cmp	w0, #0x0
    3fc4:	54fffec1 	b.ne	3f9c <strcpy+0x18>  // b.any
        ;
    return os;
    3fc8:	f9400fe0 	ldr	x0, [sp, #24]
}
    3fcc:	910083ff 	add	sp, sp, #0x20
    3fd0:	d65f03c0 	ret

0000000000003fd4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3fd4:	d10043ff 	sub	sp, sp, #0x10
    3fd8:	f90007e0 	str	x0, [sp, #8]
    3fdc:	f90003e1 	str	x1, [sp]
    while(*p && *p == *q)
    3fe0:	14000007 	b	3ffc <strcmp+0x28>
        p++, q++;
    3fe4:	f94007e0 	ldr	x0, [sp, #8]
    3fe8:	91000400 	add	x0, x0, #0x1
    3fec:	f90007e0 	str	x0, [sp, #8]
    3ff0:	f94003e0 	ldr	x0, [sp]
    3ff4:	91000400 	add	x0, x0, #0x1
    3ff8:	f90003e0 	str	x0, [sp]
    while(*p && *p == *q)
    3ffc:	f94007e0 	ldr	x0, [sp, #8]
    4000:	39400000 	ldrb	w0, [x0]
    4004:	7100001f 	cmp	w0, #0x0
    4008:	540000e0 	b.eq	4024 <strcmp+0x50>  // b.none
    400c:	f94007e0 	ldr	x0, [sp, #8]
    4010:	39400001 	ldrb	w1, [x0]
    4014:	f94003e0 	ldr	x0, [sp]
    4018:	39400000 	ldrb	w0, [x0]
    401c:	6b00003f 	cmp	w1, w0
    4020:	54fffe20 	b.eq	3fe4 <strcmp+0x10>  // b.none
    return (uchar)*p - (uchar)*q;
    4024:	f94007e0 	ldr	x0, [sp, #8]
    4028:	39400000 	ldrb	w0, [x0]
    402c:	2a0003e1 	mov	w1, w0
    4030:	f94003e0 	ldr	x0, [sp]
    4034:	39400000 	ldrb	w0, [x0]
    4038:	4b000020 	sub	w0, w1, w0
}
    403c:	910043ff 	add	sp, sp, #0x10
    4040:	d65f03c0 	ret

0000000000004044 <strlen>:

uint
strlen(char *s)
{
    4044:	d10083ff 	sub	sp, sp, #0x20
    4048:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    for(n = 0; s[n]; n++)
    404c:	b9001fff 	str	wzr, [sp, #28]
    4050:	14000004 	b	4060 <strlen+0x1c>
    4054:	b9401fe0 	ldr	w0, [sp, #28]
    4058:	11000400 	add	w0, w0, #0x1
    405c:	b9001fe0 	str	w0, [sp, #28]
    4060:	b9801fe0 	ldrsw	x0, [sp, #28]
    4064:	f94007e1 	ldr	x1, [sp, #8]
    4068:	8b000020 	add	x0, x1, x0
    406c:	39400000 	ldrb	w0, [x0]
    4070:	7100001f 	cmp	w0, #0x0
    4074:	54ffff01 	b.ne	4054 <strlen+0x10>  // b.any
        ;
    return n;
    4078:	b9401fe0 	ldr	w0, [sp, #28]
}
    407c:	910083ff 	add	sp, sp, #0x20
    4080:	d65f03c0 	ret

0000000000004084 <memset>:

void*
memset(void *dst, int v, uint n)
{
    4084:	d100c3ff 	sub	sp, sp, #0x30
    4088:	f90007e0 	str	x0, [sp, #8]
    408c:	b90007e1 	str	w1, [sp, #4]
    4090:	b90003e2 	str	w2, [sp]
	uint8	*p;
	uint8	c;
	uint32	val;
	uint32	*p4;

	p   = dst;
    4094:	f94007e0 	ldr	x0, [sp, #8]
    4098:	f90017e0 	str	x0, [sp, #40]
	c   = v & 0xff;
    409c:	b94007e0 	ldr	w0, [sp, #4]
    40a0:	39007fe0 	strb	w0, [sp, #31]
	val = (c << 24) | (c << 16) | (c << 8) | c;
    40a4:	39407fe1 	ldrb	w1, [sp, #31]
    40a8:	2a0103e0 	mov	w0, w1
    40ac:	53185c00 	lsl	w0, w0, #8
    40b0:	0b010000 	add	w0, w0, w1
    40b4:	53103c00 	lsl	w0, w0, #16
    40b8:	2a0003e1 	mov	w1, w0
    40bc:	39407fe0 	ldrb	w0, [sp, #31]
    40c0:	53185c00 	lsl	w0, w0, #8
    40c4:	2a000021 	orr	w1, w1, w0
    40c8:	39407fe0 	ldrb	w0, [sp, #31]
    40cc:	2a000020 	orr	w0, w1, w0
    40d0:	b9001be0 	str	w0, [sp, #24]

	// set bytes before whole uint32
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
    40d4:	1400000a 	b	40fc <memset+0x78>
		*p = c;
    40d8:	f94017e0 	ldr	x0, [sp, #40]
    40dc:	39407fe1 	ldrb	w1, [sp, #31]
    40e0:	39000001 	strb	w1, [x0]
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
    40e4:	b94003e0 	ldr	w0, [sp]
    40e8:	51000400 	sub	w0, w0, #0x1
    40ec:	b90003e0 	str	w0, [sp]
    40f0:	f94017e0 	ldr	x0, [sp, #40]
    40f4:	91000400 	add	x0, x0, #0x1
    40f8:	f90017e0 	str	x0, [sp, #40]
    40fc:	b94003e0 	ldr	w0, [sp]
    4100:	7100001f 	cmp	w0, #0x0
    4104:	540000a0 	b.eq	4118 <memset+0x94>  // b.none
    4108:	f94017e0 	ldr	x0, [sp, #40]
    410c:	92400400 	and	x0, x0, #0x3
    4110:	f100001f 	cmp	x0, #0x0
    4114:	54fffe21 	b.ne	40d8 <memset+0x54>  // b.any
	}

	// set memory 4 bytes a time
	p4 = (uint*)p;
    4118:	f94017e0 	ldr	x0, [sp, #40]
    411c:	f90013e0 	str	x0, [sp, #32]

	for (; n >= 4; n -= 4, p4++) {
    4120:	1400000a 	b	4148 <memset+0xc4>
		*p4 = val;
    4124:	f94013e0 	ldr	x0, [sp, #32]
    4128:	b9401be1 	ldr	w1, [sp, #24]
    412c:	b9000001 	str	w1, [x0]
	for (; n >= 4; n -= 4, p4++) {
    4130:	b94003e0 	ldr	w0, [sp]
    4134:	51001000 	sub	w0, w0, #0x4
    4138:	b90003e0 	str	w0, [sp]
    413c:	f94013e0 	ldr	x0, [sp, #32]
    4140:	91001000 	add	x0, x0, #0x4
    4144:	f90013e0 	str	x0, [sp, #32]
    4148:	b94003e0 	ldr	w0, [sp]
    414c:	71000c1f 	cmp	w0, #0x3
    4150:	54fffea8 	b.hi	4124 <memset+0xa0>  // b.pmore
	}

	// set leftover one byte a time
	p = (uint8*)p4;
    4154:	f94013e0 	ldr	x0, [sp, #32]
    4158:	f90017e0 	str	x0, [sp, #40]

	for (; n > 0; n--, p++) {
    415c:	1400000a 	b	4184 <memset+0x100>
		*p = c;
    4160:	f94017e0 	ldr	x0, [sp, #40]
    4164:	39407fe1 	ldrb	w1, [sp, #31]
    4168:	39000001 	strb	w1, [x0]
	for (; n > 0; n--, p++) {
    416c:	b94003e0 	ldr	w0, [sp]
    4170:	51000400 	sub	w0, w0, #0x1
    4174:	b90003e0 	str	w0, [sp]
    4178:	f94017e0 	ldr	x0, [sp, #40]
    417c:	91000400 	add	x0, x0, #0x1
    4180:	f90017e0 	str	x0, [sp, #40]
    4184:	b94003e0 	ldr	w0, [sp]
    4188:	7100001f 	cmp	w0, #0x0
    418c:	54fffea1 	b.ne	4160 <memset+0xdc>  // b.any
	}

	return dst;
    4190:	f94007e0 	ldr	x0, [sp, #8]
}
    4194:	9100c3ff 	add	sp, sp, #0x30
    4198:	d65f03c0 	ret

000000000000419c <strchr>:

char*
strchr(const char *s, char c)
{
    419c:	d10043ff 	sub	sp, sp, #0x10
    41a0:	f90007e0 	str	x0, [sp, #8]
    41a4:	39001fe1 	strb	w1, [sp, #7]
    for(; *s; s++)
    41a8:	1400000b 	b	41d4 <strchr+0x38>
        if(*s == c)
    41ac:	f94007e0 	ldr	x0, [sp, #8]
    41b0:	39400000 	ldrb	w0, [x0]
    41b4:	39401fe1 	ldrb	w1, [sp, #7]
    41b8:	6b00003f 	cmp	w1, w0
    41bc:	54000061 	b.ne	41c8 <strchr+0x2c>  // b.any
            return (char*)s;
    41c0:	f94007e0 	ldr	x0, [sp, #8]
    41c4:	14000009 	b	41e8 <strchr+0x4c>
    for(; *s; s++)
    41c8:	f94007e0 	ldr	x0, [sp, #8]
    41cc:	91000400 	add	x0, x0, #0x1
    41d0:	f90007e0 	str	x0, [sp, #8]
    41d4:	f94007e0 	ldr	x0, [sp, #8]
    41d8:	39400000 	ldrb	w0, [x0]
    41dc:	7100001f 	cmp	w0, #0x0
    41e0:	54fffe61 	b.ne	41ac <strchr+0x10>  // b.any
    return 0;
    41e4:	d2800000 	mov	x0, #0x0                   	// #0
}
    41e8:	910043ff 	add	sp, sp, #0x10
    41ec:	d65f03c0 	ret

00000000000041f0 <gets>:

char*
gets(char *buf, int max)
{
    41f0:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
    41f4:	910003fd 	mov	x29, sp
    41f8:	f9000fe0 	str	x0, [sp, #24]
    41fc:	b90017e1 	str	w1, [sp, #20]
    int i, cc;
    char c;
    
    for(i=0; i+1 < max; ){
    4200:	b9002fff 	str	wzr, [sp, #44]
    4204:	14000018 	b	4264 <gets+0x74>
        cc = read(0, &c, 1);
    4208:	91009fe0 	add	x0, sp, #0x27
    420c:	52800022 	mov	w2, #0x1                   	// #1
    4210:	aa0003e1 	mov	x1, x0
    4214:	52800000 	mov	w0, #0x0                   	// #0
    4218:	94000090 	bl	4458 <read>
    421c:	b9002be0 	str	w0, [sp, #40]
        if(cc < 1)
    4220:	b9402be0 	ldr	w0, [sp, #40]
    4224:	7100001f 	cmp	w0, #0x0
    4228:	540002ad 	b.le	427c <gets+0x8c>
            break;
        buf[i++] = c;
    422c:	b9402fe0 	ldr	w0, [sp, #44]
    4230:	11000401 	add	w1, w0, #0x1
    4234:	b9002fe1 	str	w1, [sp, #44]
    4238:	93407c00 	sxtw	x0, w0
    423c:	f9400fe1 	ldr	x1, [sp, #24]
    4240:	8b000020 	add	x0, x1, x0
    4244:	39409fe1 	ldrb	w1, [sp, #39]
    4248:	39000001 	strb	w1, [x0]
        if(c == '\n' || c == '\r')
    424c:	39409fe0 	ldrb	w0, [sp, #39]
    4250:	7100281f 	cmp	w0, #0xa
    4254:	54000160 	b.eq	4280 <gets+0x90>  // b.none
    4258:	39409fe0 	ldrb	w0, [sp, #39]
    425c:	7100341f 	cmp	w0, #0xd
    4260:	54000100 	b.eq	4280 <gets+0x90>  // b.none
    for(i=0; i+1 < max; ){
    4264:	b9402fe0 	ldr	w0, [sp, #44]
    4268:	11000400 	add	w0, w0, #0x1
    426c:	b94017e1 	ldr	w1, [sp, #20]
    4270:	6b00003f 	cmp	w1, w0
    4274:	54fffcac 	b.gt	4208 <gets+0x18>
    4278:	14000002 	b	4280 <gets+0x90>
            break;
    427c:	d503201f 	nop
            break;
    }
    buf[i] = '\0';
    4280:	b9802fe0 	ldrsw	x0, [sp, #44]
    4284:	f9400fe1 	ldr	x1, [sp, #24]
    4288:	8b000020 	add	x0, x1, x0
    428c:	3900001f 	strb	wzr, [x0]
    return buf;
    4290:	f9400fe0 	ldr	x0, [sp, #24]
}
    4294:	a8c37bfd 	ldp	x29, x30, [sp], #48
    4298:	d65f03c0 	ret

000000000000429c <stat>:

int
stat(char *n, struct stat *st)
{
    429c:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
    42a0:	910003fd 	mov	x29, sp
    42a4:	f9000fe0 	str	x0, [sp, #24]
    42a8:	f9000be1 	str	x1, [sp, #16]
    int fd;
    int r;
    
    fd = open(n, O_RDONLY);
    42ac:	52800001 	mov	w1, #0x0                   	// #0
    42b0:	f9400fe0 	ldr	x0, [sp, #24]
    42b4:	94000096 	bl	450c <open>
    42b8:	b9002fe0 	str	w0, [sp, #44]
    if(fd < 0)
    42bc:	b9402fe0 	ldr	w0, [sp, #44]
    42c0:	7100001f 	cmp	w0, #0x0
    42c4:	5400006a 	b.ge	42d0 <stat+0x34>  // b.tcont
        return -1;
    42c8:	12800000 	mov	w0, #0xffffffff            	// #-1
    42cc:	14000008 	b	42ec <stat+0x50>
    r = fstat(fd, st);
    42d0:	f9400be1 	ldr	x1, [sp, #16]
    42d4:	b9402fe0 	ldr	w0, [sp, #44]
    42d8:	940000a8 	bl	4578 <fstat>
    42dc:	b9002be0 	str	w0, [sp, #40]
    close(fd);
    42e0:	b9402fe0 	ldr	w0, [sp, #44]
    42e4:	9400006f 	bl	44a0 <close>
    return r;
    42e8:	b9402be0 	ldr	w0, [sp, #40]
}
    42ec:	a8c37bfd 	ldp	x29, x30, [sp], #48
    42f0:	d65f03c0 	ret

00000000000042f4 <atoi>:

int
atoi(const char *s)
{
    42f4:	d10083ff 	sub	sp, sp, #0x20
    42f8:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    n = 0;
    42fc:	b9001fff 	str	wzr, [sp, #28]
    while('0' <= *s && *s <= '9')
    4300:	1400000e 	b	4338 <atoi+0x44>
        n = n*10 + *s++ - '0';
    4304:	b9401fe1 	ldr	w1, [sp, #28]
    4308:	2a0103e0 	mov	w0, w1
    430c:	531e7400 	lsl	w0, w0, #2
    4310:	0b010000 	add	w0, w0, w1
    4314:	531f7800 	lsl	w0, w0, #1
    4318:	2a0003e2 	mov	w2, w0
    431c:	f94007e0 	ldr	x0, [sp, #8]
    4320:	91000401 	add	x1, x0, #0x1
    4324:	f90007e1 	str	x1, [sp, #8]
    4328:	39400000 	ldrb	w0, [x0]
    432c:	0b000040 	add	w0, w2, w0
    4330:	5100c000 	sub	w0, w0, #0x30
    4334:	b9001fe0 	str	w0, [sp, #28]
    while('0' <= *s && *s <= '9')
    4338:	f94007e0 	ldr	x0, [sp, #8]
    433c:	39400000 	ldrb	w0, [x0]
    4340:	7100bc1f 	cmp	w0, #0x2f
    4344:	540000a9 	b.ls	4358 <atoi+0x64>  // b.plast
    4348:	f94007e0 	ldr	x0, [sp, #8]
    434c:	39400000 	ldrb	w0, [x0]
    4350:	7100e41f 	cmp	w0, #0x39
    4354:	54fffd89 	b.ls	4304 <atoi+0x10>  // b.plast
    return n;
    4358:	b9401fe0 	ldr	w0, [sp, #28]
}
    435c:	910083ff 	add	sp, sp, #0x20
    4360:	d65f03c0 	ret

0000000000004364 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    4364:	d100c3ff 	sub	sp, sp, #0x30
    4368:	f9000fe0 	str	x0, [sp, #24]
    436c:	f9000be1 	str	x1, [sp, #16]
    4370:	b9000fe2 	str	w2, [sp, #12]
    char *dst, *src;
    
    dst = vdst;
    4374:	f9400fe0 	ldr	x0, [sp, #24]
    4378:	f90017e0 	str	x0, [sp, #40]
    src = vsrc;
    437c:	f9400be0 	ldr	x0, [sp, #16]
    4380:	f90013e0 	str	x0, [sp, #32]
    while(n-- > 0)
    4384:	14000009 	b	43a8 <memmove+0x44>
        *dst++ = *src++;
    4388:	f94013e1 	ldr	x1, [sp, #32]
    438c:	91000420 	add	x0, x1, #0x1
    4390:	f90013e0 	str	x0, [sp, #32]
    4394:	f94017e0 	ldr	x0, [sp, #40]
    4398:	91000402 	add	x2, x0, #0x1
    439c:	f90017e2 	str	x2, [sp, #40]
    43a0:	39400021 	ldrb	w1, [x1]
    43a4:	39000001 	strb	w1, [x0]
    while(n-- > 0)
    43a8:	b9400fe0 	ldr	w0, [sp, #12]
    43ac:	51000401 	sub	w1, w0, #0x1
    43b0:	b9000fe1 	str	w1, [sp, #12]
    43b4:	7100001f 	cmp	w0, #0x0
    43b8:	54fffe8c 	b.gt	4388 <memmove+0x24>
    return vdst;
    43bc:	f9400fe0 	ldr	x0, [sp, #24]
}
    43c0:	9100c3ff 	add	sp, sp, #0x30
    43c4:	d65f03c0 	ret

00000000000043c8 <fork>:
    43c8:	f81f8fe4 	str	x4, [sp, #-8]!
    43cc:	aa0303e4 	mov	x4, x3
    43d0:	aa0203e3 	mov	x3, x2
    43d4:	aa0103e2 	mov	x2, x1
    43d8:	aa0003e1 	mov	x1, x0
    43dc:	d2800020 	mov	x0, #0x1                   	// #1
    43e0:	d4000001 	svc	#0x0
    43e4:	f84087e4 	ldr	x4, [sp], #8
    43e8:	d61f03c0 	br	x30

00000000000043ec <exit>:
    43ec:	f81f8fe4 	str	x4, [sp, #-8]!
    43f0:	aa0303e4 	mov	x4, x3
    43f4:	aa0203e3 	mov	x3, x2
    43f8:	aa0103e2 	mov	x2, x1
    43fc:	aa0003e1 	mov	x1, x0
    4400:	d2800040 	mov	x0, #0x2                   	// #2
    4404:	d4000001 	svc	#0x0
    4408:	f84087e4 	ldr	x4, [sp], #8
    440c:	d61f03c0 	br	x30

0000000000004410 <wait>:
    4410:	f81f8fe4 	str	x4, [sp, #-8]!
    4414:	aa0303e4 	mov	x4, x3
    4418:	aa0203e3 	mov	x3, x2
    441c:	aa0103e2 	mov	x2, x1
    4420:	aa0003e1 	mov	x1, x0
    4424:	d2800060 	mov	x0, #0x3                   	// #3
    4428:	d4000001 	svc	#0x0
    442c:	f84087e4 	ldr	x4, [sp], #8
    4430:	d61f03c0 	br	x30

0000000000004434 <pipe>:
    4434:	f81f8fe4 	str	x4, [sp, #-8]!
    4438:	aa0303e4 	mov	x4, x3
    443c:	aa0203e3 	mov	x3, x2
    4440:	aa0103e2 	mov	x2, x1
    4444:	aa0003e1 	mov	x1, x0
    4448:	d2800080 	mov	x0, #0x4                   	// #4
    444c:	d4000001 	svc	#0x0
    4450:	f84087e4 	ldr	x4, [sp], #8
    4454:	d61f03c0 	br	x30

0000000000004458 <read>:
    4458:	f81f8fe4 	str	x4, [sp, #-8]!
    445c:	aa0303e4 	mov	x4, x3
    4460:	aa0203e3 	mov	x3, x2
    4464:	aa0103e2 	mov	x2, x1
    4468:	aa0003e1 	mov	x1, x0
    446c:	d28000a0 	mov	x0, #0x5                   	// #5
    4470:	d4000001 	svc	#0x0
    4474:	f84087e4 	ldr	x4, [sp], #8
    4478:	d61f03c0 	br	x30

000000000000447c <write>:
    447c:	f81f8fe4 	str	x4, [sp, #-8]!
    4480:	aa0303e4 	mov	x4, x3
    4484:	aa0203e3 	mov	x3, x2
    4488:	aa0103e2 	mov	x2, x1
    448c:	aa0003e1 	mov	x1, x0
    4490:	d2800200 	mov	x0, #0x10                  	// #16
    4494:	d4000001 	svc	#0x0
    4498:	f84087e4 	ldr	x4, [sp], #8
    449c:	d61f03c0 	br	x30

00000000000044a0 <close>:
    44a0:	f81f8fe4 	str	x4, [sp, #-8]!
    44a4:	aa0303e4 	mov	x4, x3
    44a8:	aa0203e3 	mov	x3, x2
    44ac:	aa0103e2 	mov	x2, x1
    44b0:	aa0003e1 	mov	x1, x0
    44b4:	d28002a0 	mov	x0, #0x15                  	// #21
    44b8:	d4000001 	svc	#0x0
    44bc:	f84087e4 	ldr	x4, [sp], #8
    44c0:	d61f03c0 	br	x30

00000000000044c4 <kill>:
    44c4:	f81f8fe4 	str	x4, [sp, #-8]!
    44c8:	aa0303e4 	mov	x4, x3
    44cc:	aa0203e3 	mov	x3, x2
    44d0:	aa0103e2 	mov	x2, x1
    44d4:	aa0003e1 	mov	x1, x0
    44d8:	d28000c0 	mov	x0, #0x6                   	// #6
    44dc:	d4000001 	svc	#0x0
    44e0:	f84087e4 	ldr	x4, [sp], #8
    44e4:	d61f03c0 	br	x30

00000000000044e8 <exec>:
    44e8:	f81f8fe4 	str	x4, [sp, #-8]!
    44ec:	aa0303e4 	mov	x4, x3
    44f0:	aa0203e3 	mov	x3, x2
    44f4:	aa0103e2 	mov	x2, x1
    44f8:	aa0003e1 	mov	x1, x0
    44fc:	d28000e0 	mov	x0, #0x7                   	// #7
    4500:	d4000001 	svc	#0x0
    4504:	f84087e4 	ldr	x4, [sp], #8
    4508:	d61f03c0 	br	x30

000000000000450c <open>:
    450c:	f81f8fe4 	str	x4, [sp, #-8]!
    4510:	aa0303e4 	mov	x4, x3
    4514:	aa0203e3 	mov	x3, x2
    4518:	aa0103e2 	mov	x2, x1
    451c:	aa0003e1 	mov	x1, x0
    4520:	d28001e0 	mov	x0, #0xf                   	// #15
    4524:	d4000001 	svc	#0x0
    4528:	f84087e4 	ldr	x4, [sp], #8
    452c:	d61f03c0 	br	x30

0000000000004530 <mknod>:
    4530:	f81f8fe4 	str	x4, [sp, #-8]!
    4534:	aa0303e4 	mov	x4, x3
    4538:	aa0203e3 	mov	x3, x2
    453c:	aa0103e2 	mov	x2, x1
    4540:	aa0003e1 	mov	x1, x0
    4544:	d2800220 	mov	x0, #0x11                  	// #17
    4548:	d4000001 	svc	#0x0
    454c:	f84087e4 	ldr	x4, [sp], #8
    4550:	d61f03c0 	br	x30

0000000000004554 <unlink>:
    4554:	f81f8fe4 	str	x4, [sp, #-8]!
    4558:	aa0303e4 	mov	x4, x3
    455c:	aa0203e3 	mov	x3, x2
    4560:	aa0103e2 	mov	x2, x1
    4564:	aa0003e1 	mov	x1, x0
    4568:	d2800240 	mov	x0, #0x12                  	// #18
    456c:	d4000001 	svc	#0x0
    4570:	f84087e4 	ldr	x4, [sp], #8
    4574:	d61f03c0 	br	x30

0000000000004578 <fstat>:
    4578:	f81f8fe4 	str	x4, [sp, #-8]!
    457c:	aa0303e4 	mov	x4, x3
    4580:	aa0203e3 	mov	x3, x2
    4584:	aa0103e2 	mov	x2, x1
    4588:	aa0003e1 	mov	x1, x0
    458c:	d2800100 	mov	x0, #0x8                   	// #8
    4590:	d4000001 	svc	#0x0
    4594:	f84087e4 	ldr	x4, [sp], #8
    4598:	d61f03c0 	br	x30

000000000000459c <link>:
    459c:	f81f8fe4 	str	x4, [sp, #-8]!
    45a0:	aa0303e4 	mov	x4, x3
    45a4:	aa0203e3 	mov	x3, x2
    45a8:	aa0103e2 	mov	x2, x1
    45ac:	aa0003e1 	mov	x1, x0
    45b0:	d2800260 	mov	x0, #0x13                  	// #19
    45b4:	d4000001 	svc	#0x0
    45b8:	f84087e4 	ldr	x4, [sp], #8
    45bc:	d61f03c0 	br	x30

00000000000045c0 <mkdir>:
    45c0:	f81f8fe4 	str	x4, [sp, #-8]!
    45c4:	aa0303e4 	mov	x4, x3
    45c8:	aa0203e3 	mov	x3, x2
    45cc:	aa0103e2 	mov	x2, x1
    45d0:	aa0003e1 	mov	x1, x0
    45d4:	d2800280 	mov	x0, #0x14                  	// #20
    45d8:	d4000001 	svc	#0x0
    45dc:	f84087e4 	ldr	x4, [sp], #8
    45e0:	d61f03c0 	br	x30

00000000000045e4 <chdir>:
    45e4:	f81f8fe4 	str	x4, [sp, #-8]!
    45e8:	aa0303e4 	mov	x4, x3
    45ec:	aa0203e3 	mov	x3, x2
    45f0:	aa0103e2 	mov	x2, x1
    45f4:	aa0003e1 	mov	x1, x0
    45f8:	d2800120 	mov	x0, #0x9                   	// #9
    45fc:	d4000001 	svc	#0x0
    4600:	f84087e4 	ldr	x4, [sp], #8
    4604:	d61f03c0 	br	x30

0000000000004608 <dup>:
    4608:	f81f8fe4 	str	x4, [sp, #-8]!
    460c:	aa0303e4 	mov	x4, x3
    4610:	aa0203e3 	mov	x3, x2
    4614:	aa0103e2 	mov	x2, x1
    4618:	aa0003e1 	mov	x1, x0
    461c:	d2800140 	mov	x0, #0xa                   	// #10
    4620:	d4000001 	svc	#0x0
    4624:	f84087e4 	ldr	x4, [sp], #8
    4628:	d61f03c0 	br	x30

000000000000462c <getpid>:
    462c:	f81f8fe4 	str	x4, [sp, #-8]!
    4630:	aa0303e4 	mov	x4, x3
    4634:	aa0203e3 	mov	x3, x2
    4638:	aa0103e2 	mov	x2, x1
    463c:	aa0003e1 	mov	x1, x0
    4640:	d2800160 	mov	x0, #0xb                   	// #11
    4644:	d4000001 	svc	#0x0
    4648:	f84087e4 	ldr	x4, [sp], #8
    464c:	d61f03c0 	br	x30

0000000000004650 <sbrk>:
    4650:	f81f8fe4 	str	x4, [sp, #-8]!
    4654:	aa0303e4 	mov	x4, x3
    4658:	aa0203e3 	mov	x3, x2
    465c:	aa0103e2 	mov	x2, x1
    4660:	aa0003e1 	mov	x1, x0
    4664:	d2800180 	mov	x0, #0xc                   	// #12
    4668:	d4000001 	svc	#0x0
    466c:	f84087e4 	ldr	x4, [sp], #8
    4670:	d61f03c0 	br	x30

0000000000004674 <sleep>:
    4674:	f81f8fe4 	str	x4, [sp, #-8]!
    4678:	aa0303e4 	mov	x4, x3
    467c:	aa0203e3 	mov	x3, x2
    4680:	aa0103e2 	mov	x2, x1
    4684:	aa0003e1 	mov	x1, x0
    4688:	d28001a0 	mov	x0, #0xd                   	// #13
    468c:	d4000001 	svc	#0x0
    4690:	f84087e4 	ldr	x4, [sp], #8
    4694:	d61f03c0 	br	x30

0000000000004698 <uptime>:
    4698:	f81f8fe4 	str	x4, [sp, #-8]!
    469c:	aa0303e4 	mov	x4, x3
    46a0:	aa0203e3 	mov	x3, x2
    46a4:	aa0103e2 	mov	x2, x1
    46a8:	aa0003e1 	mov	x1, x0
    46ac:	d28001c0 	mov	x0, #0xe                   	// #14
    46b0:	d4000001 	svc	#0x0
    46b4:	f84087e4 	ldr	x4, [sp], #8
    46b8:	d61f03c0 	br	x30

00000000000046bc <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    46bc:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    46c0:	910003fd 	mov	x29, sp
    46c4:	b9001fe0 	str	w0, [sp, #28]
    46c8:	39006fe1 	strb	w1, [sp, #27]
    write(fd, &c, 1);
    46cc:	91006fe0 	add	x0, sp, #0x1b
    46d0:	52800022 	mov	w2, #0x1                   	// #1
    46d4:	aa0003e1 	mov	x1, x0
    46d8:	b9401fe0 	ldr	w0, [sp, #28]
    46dc:	97ffff68 	bl	447c <write>
}
    46e0:	d503201f 	nop
    46e4:	a8c27bfd 	ldp	x29, x30, [sp], #32
    46e8:	d65f03c0 	ret

00000000000046ec <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    46ec:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
    46f0:	910003fd 	mov	x29, sp
    46f4:	b9001fe0 	str	w0, [sp, #28]
    46f8:	b9001be1 	str	w1, [sp, #24]
    46fc:	b90017e2 	str	w2, [sp, #20]
    4700:	b90013e3 	str	w3, [sp, #16]
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    4704:	b9003bff 	str	wzr, [sp, #56]
    if(sgn && xx < 0){
    4708:	b94013e0 	ldr	w0, [sp, #16]
    470c:	7100001f 	cmp	w0, #0x0
    4710:	54000140 	b.eq	4738 <printint+0x4c>  // b.none
    4714:	b9401be0 	ldr	w0, [sp, #24]
    4718:	7100001f 	cmp	w0, #0x0
    471c:	540000ea 	b.ge	4738 <printint+0x4c>  // b.tcont
        neg = 1;
    4720:	52800020 	mov	w0, #0x1                   	// #1
    4724:	b9003be0 	str	w0, [sp, #56]
        x = -xx;
    4728:	b9401be0 	ldr	w0, [sp, #24]
    472c:	4b0003e0 	neg	w0, w0
    4730:	b90037e0 	str	w0, [sp, #52]
    4734:	14000003 	b	4740 <printint+0x54>
    } else {
        x = xx;
    4738:	b9401be0 	ldr	w0, [sp, #24]
    473c:	b90037e0 	str	w0, [sp, #52]
    }
    
    i = 0;
    4740:	b9003fff 	str	wzr, [sp, #60]
    do{
        buf[i++] = digits[x % base];
    4744:	b94017e1 	ldr	w1, [sp, #20]
    4748:	b94037e0 	ldr	w0, [sp, #52]
    474c:	1ac10802 	udiv	w2, w0, w1
    4750:	1b017c41 	mul	w1, w2, w1
    4754:	4b010003 	sub	w3, w0, w1
    4758:	b9403fe0 	ldr	w0, [sp, #60]
    475c:	11000401 	add	w1, w0, #0x1
    4760:	b9003fe1 	str	w1, [sp, #60]
    4764:	d0000001 	adrp	x1, 6000 <malloc+0x13a8>
    4768:	91222022 	add	x2, x1, #0x888
    476c:	2a0303e1 	mov	w1, w3
    4770:	38616842 	ldrb	w2, [x2, x1]
    4774:	93407c00 	sxtw	x0, w0
    4778:	910083e1 	add	x1, sp, #0x20
    477c:	38206822 	strb	w2, [x1, x0]
    }while((x /= base) != 0);
    4780:	b94017e0 	ldr	w0, [sp, #20]
    4784:	b94037e1 	ldr	w1, [sp, #52]
    4788:	1ac00820 	udiv	w0, w1, w0
    478c:	b90037e0 	str	w0, [sp, #52]
    4790:	b94037e0 	ldr	w0, [sp, #52]
    4794:	7100001f 	cmp	w0, #0x0
    4798:	54fffd61 	b.ne	4744 <printint+0x58>  // b.any
    if(neg)
    479c:	b9403be0 	ldr	w0, [sp, #56]
    47a0:	7100001f 	cmp	w0, #0x0
    47a4:	540001e0 	b.eq	47e0 <printint+0xf4>  // b.none
        buf[i++] = '-';
    47a8:	b9403fe0 	ldr	w0, [sp, #60]
    47ac:	11000401 	add	w1, w0, #0x1
    47b0:	b9003fe1 	str	w1, [sp, #60]
    47b4:	93407c00 	sxtw	x0, w0
    47b8:	910083e1 	add	x1, sp, #0x20
    47bc:	528005a2 	mov	w2, #0x2d                  	// #45
    47c0:	38206822 	strb	w2, [x1, x0]
    
    while(--i >= 0)
    47c4:	14000007 	b	47e0 <printint+0xf4>
        putc(fd, buf[i]);
    47c8:	b9803fe0 	ldrsw	x0, [sp, #60]
    47cc:	910083e1 	add	x1, sp, #0x20
    47d0:	38606820 	ldrb	w0, [x1, x0]
    47d4:	2a0003e1 	mov	w1, w0
    47d8:	b9401fe0 	ldr	w0, [sp, #28]
    47dc:	97ffffb8 	bl	46bc <putc>
    while(--i >= 0)
    47e0:	b9403fe0 	ldr	w0, [sp, #60]
    47e4:	51000400 	sub	w0, w0, #0x1
    47e8:	b9003fe0 	str	w0, [sp, #60]
    47ec:	b9403fe0 	ldr	w0, [sp, #60]
    47f0:	7100001f 	cmp	w0, #0x0
    47f4:	54fffeaa 	b.ge	47c8 <printint+0xdc>  // b.tcont
}
    47f8:	d503201f 	nop
    47fc:	d503201f 	nop
    4800:	a8c47bfd 	ldp	x29, x30, [sp], #64
    4804:	d65f03c0 	ret

0000000000004808 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    4808:	a9b17bfd 	stp	x29, x30, [sp, #-240]!
    480c:	910003fd 	mov	x29, sp
    4810:	b9001fe0 	str	w0, [sp, #28]
    4814:	f9000be1 	str	x1, [sp, #16]
    4818:	f90063e2 	str	x2, [sp, #192]
    481c:	f90067e3 	str	x3, [sp, #200]
    4820:	f9006be4 	str	x4, [sp, #208]
    4824:	f9006fe5 	str	x5, [sp, #216]
    4828:	f90073e6 	str	x6, [sp, #224]
    482c:	f90077e7 	str	x7, [sp, #232]
    4830:	3d8013e0 	str	q0, [sp, #64]
    4834:	3d8017e1 	str	q1, [sp, #80]
    4838:	3d801be2 	str	q2, [sp, #96]
    483c:	3d801fe3 	str	q3, [sp, #112]
    4840:	3d8023e4 	str	q4, [sp, #128]
    4844:	3d8027e5 	str	q5, [sp, #144]
    4848:	3d802be6 	str	q6, [sp, #160]
    484c:	3d802fe7 	str	q7, [sp, #176]
    char *s;
    int c, i, state;
    uint64 *ap;
    
    state = 0;
    4850:	b90033ff 	str	wzr, [sp, #48]
    ap = (uint64*)(void*)&fmt + 22;
    4854:	910043e0 	add	x0, sp, #0x10
    4858:	9102c000 	add	x0, x0, #0xb0
    485c:	f90017e0 	str	x0, [sp, #40]
    for(i = 0; fmt[i]; i++){
    4860:	b90037ff 	str	wzr, [sp, #52]
    4864:	14000076 	b	4a3c <printf+0x234>
        c = fmt[i] & 0xff;
    4868:	f9400be1 	ldr	x1, [sp, #16]
    486c:	b98037e0 	ldrsw	x0, [sp, #52]
    4870:	8b000020 	add	x0, x1, x0
    4874:	39400000 	ldrb	w0, [x0]
    4878:	b90027e0 	str	w0, [sp, #36]
        if(state == 0){
    487c:	b94033e0 	ldr	w0, [sp, #48]
    4880:	7100001f 	cmp	w0, #0x0
    4884:	540001a1 	b.ne	48b8 <printf+0xb0>  // b.any
            if(c == '%'){
    4888:	b94027e0 	ldr	w0, [sp, #36]
    488c:	7100941f 	cmp	w0, #0x25
    4890:	54000081 	b.ne	48a0 <printf+0x98>  // b.any
                state = '%';
    4894:	528004a0 	mov	w0, #0x25                  	// #37
    4898:	b90033e0 	str	w0, [sp, #48]
    489c:	14000065 	b	4a30 <printf+0x228>
            } else {
                putc(fd, c);
    48a0:	b94027e0 	ldr	w0, [sp, #36]
    48a4:	12001c00 	and	w0, w0, #0xff
    48a8:	2a0003e1 	mov	w1, w0
    48ac:	b9401fe0 	ldr	w0, [sp, #28]
    48b0:	97ffff83 	bl	46bc <putc>
    48b4:	1400005f 	b	4a30 <printf+0x228>
            }
        } else if(state == '%'){
    48b8:	b94033e0 	ldr	w0, [sp, #48]
    48bc:	7100941f 	cmp	w0, #0x25
    48c0:	54000b81 	b.ne	4a30 <printf+0x228>  // b.any
            if(c == 'd'){
    48c4:	b94027e0 	ldr	w0, [sp, #36]
    48c8:	7101901f 	cmp	w0, #0x64
    48cc:	54000181 	b.ne	48fc <printf+0xf4>  // b.any
                printint(fd, *ap, 10, 1);
    48d0:	f94017e0 	ldr	x0, [sp, #40]
    48d4:	f9400000 	ldr	x0, [x0]
    48d8:	52800023 	mov	w3, #0x1                   	// #1
    48dc:	52800142 	mov	w2, #0xa                   	// #10
    48e0:	2a0003e1 	mov	w1, w0
    48e4:	b9401fe0 	ldr	w0, [sp, #28]
    48e8:	97ffff81 	bl	46ec <printint>
                ap++;
    48ec:	f94017e0 	ldr	x0, [sp, #40]
    48f0:	91002000 	add	x0, x0, #0x8
    48f4:	f90017e0 	str	x0, [sp, #40]
    48f8:	1400004d 	b	4a2c <printf+0x224>
            } else if(c == 'x' || c == 'p'){
    48fc:	b94027e0 	ldr	w0, [sp, #36]
    4900:	7101e01f 	cmp	w0, #0x78
    4904:	54000080 	b.eq	4914 <printf+0x10c>  // b.none
    4908:	b94027e0 	ldr	w0, [sp, #36]
    490c:	7101c01f 	cmp	w0, #0x70
    4910:	54000181 	b.ne	4940 <printf+0x138>  // b.any
                printint(fd, *ap, 16, 0);
    4914:	f94017e0 	ldr	x0, [sp, #40]
    4918:	f9400000 	ldr	x0, [x0]
    491c:	52800003 	mov	w3, #0x0                   	// #0
    4920:	52800202 	mov	w2, #0x10                  	// #16
    4924:	2a0003e1 	mov	w1, w0
    4928:	b9401fe0 	ldr	w0, [sp, #28]
    492c:	97ffff70 	bl	46ec <printint>
                ap++;
    4930:	f94017e0 	ldr	x0, [sp, #40]
    4934:	91002000 	add	x0, x0, #0x8
    4938:	f90017e0 	str	x0, [sp, #40]
    493c:	1400003c 	b	4a2c <printf+0x224>
            } else if(c == 's'){
    4940:	b94027e0 	ldr	w0, [sp, #36]
    4944:	7101cc1f 	cmp	w0, #0x73
    4948:	54000361 	b.ne	49b4 <printf+0x1ac>  // b.any
                s = (char*)*ap;
    494c:	f94017e0 	ldr	x0, [sp, #40]
    4950:	f9400000 	ldr	x0, [x0]
    4954:	f9001fe0 	str	x0, [sp, #56]
                ap++;
    4958:	f94017e0 	ldr	x0, [sp, #40]
    495c:	91002000 	add	x0, x0, #0x8
    4960:	f90017e0 	str	x0, [sp, #40]
                if(s == 0)
    4964:	f9401fe0 	ldr	x0, [sp, #56]
    4968:	f100001f 	cmp	x0, #0x0
    496c:	540001a1 	b.ne	49a0 <printf+0x198>  // b.any
                    s = "(null)";
    4970:	d0000000 	adrp	x0, 6000 <malloc+0x13a8>
    4974:	91212000 	add	x0, x0, #0x848
    4978:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
    497c:	14000009 	b	49a0 <printf+0x198>
                    putc(fd, *s);
    4980:	f9401fe0 	ldr	x0, [sp, #56]
    4984:	39400000 	ldrb	w0, [x0]
    4988:	2a0003e1 	mov	w1, w0
    498c:	b9401fe0 	ldr	w0, [sp, #28]
    4990:	97ffff4b 	bl	46bc <putc>
                    s++;
    4994:	f9401fe0 	ldr	x0, [sp, #56]
    4998:	91000400 	add	x0, x0, #0x1
    499c:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
    49a0:	f9401fe0 	ldr	x0, [sp, #56]
    49a4:	39400000 	ldrb	w0, [x0]
    49a8:	7100001f 	cmp	w0, #0x0
    49ac:	54fffea1 	b.ne	4980 <printf+0x178>  // b.any
    49b0:	1400001f 	b	4a2c <printf+0x224>
                }
            } else if(c == 'c'){
    49b4:	b94027e0 	ldr	w0, [sp, #36]
    49b8:	71018c1f 	cmp	w0, #0x63
    49bc:	54000161 	b.ne	49e8 <printf+0x1e0>  // b.any
                putc(fd, *ap);
    49c0:	f94017e0 	ldr	x0, [sp, #40]
    49c4:	f9400000 	ldr	x0, [x0]
    49c8:	12001c00 	and	w0, w0, #0xff
    49cc:	2a0003e1 	mov	w1, w0
    49d0:	b9401fe0 	ldr	w0, [sp, #28]
    49d4:	97ffff3a 	bl	46bc <putc>
                ap++;
    49d8:	f94017e0 	ldr	x0, [sp, #40]
    49dc:	91002000 	add	x0, x0, #0x8
    49e0:	f90017e0 	str	x0, [sp, #40]
    49e4:	14000012 	b	4a2c <printf+0x224>
            } else if(c == '%'){
    49e8:	b94027e0 	ldr	w0, [sp, #36]
    49ec:	7100941f 	cmp	w0, #0x25
    49f0:	540000e1 	b.ne	4a0c <printf+0x204>  // b.any
                putc(fd, c);
    49f4:	b94027e0 	ldr	w0, [sp, #36]
    49f8:	12001c00 	and	w0, w0, #0xff
    49fc:	2a0003e1 	mov	w1, w0
    4a00:	b9401fe0 	ldr	w0, [sp, #28]
    4a04:	97ffff2e 	bl	46bc <putc>
    4a08:	14000009 	b	4a2c <printf+0x224>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
    4a0c:	528004a1 	mov	w1, #0x25                  	// #37
    4a10:	b9401fe0 	ldr	w0, [sp, #28]
    4a14:	97ffff2a 	bl	46bc <putc>
                putc(fd, c);
    4a18:	b94027e0 	ldr	w0, [sp, #36]
    4a1c:	12001c00 	and	w0, w0, #0xff
    4a20:	2a0003e1 	mov	w1, w0
    4a24:	b9401fe0 	ldr	w0, [sp, #28]
    4a28:	97ffff25 	bl	46bc <putc>
            }
            state = 0;
    4a2c:	b90033ff 	str	wzr, [sp, #48]
    for(i = 0; fmt[i]; i++){
    4a30:	b94037e0 	ldr	w0, [sp, #52]
    4a34:	11000400 	add	w0, w0, #0x1
    4a38:	b90037e0 	str	w0, [sp, #52]
    4a3c:	f9400be1 	ldr	x1, [sp, #16]
    4a40:	b98037e0 	ldrsw	x0, [sp, #52]
    4a44:	8b000020 	add	x0, x1, x0
    4a48:	39400000 	ldrb	w0, [x0]
    4a4c:	7100001f 	cmp	w0, #0x0
    4a50:	54fff0c1 	b.ne	4868 <printf+0x60>  // b.any
        }
    }
}
    4a54:	d503201f 	nop
    4a58:	d503201f 	nop
    4a5c:	a8cf7bfd 	ldp	x29, x30, [sp], #240
    4a60:	d65f03c0 	ret

0000000000004a64 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    4a64:	d10083ff 	sub	sp, sp, #0x20
    4a68:	f90007e0 	str	x0, [sp, #8]
    Header *bp, *p;
    
    bp = (Header*)ap - 1;
    4a6c:	f94007e0 	ldr	x0, [sp, #8]
    4a70:	d1004000 	sub	x0, x0, #0x10
    4a74:	f9000be0 	str	x0, [sp, #16]
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4a78:	f0000020 	adrp	x0, b000 <args.0+0x48>
    4a7c:	91032000 	add	x0, x0, #0xc8
    4a80:	f9400000 	ldr	x0, [x0]
    4a84:	f9000fe0 	str	x0, [sp, #24]
    4a88:	14000012 	b	4ad0 <free+0x6c>
        if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4a8c:	f9400fe0 	ldr	x0, [sp, #24]
    4a90:	f9400000 	ldr	x0, [x0]
    4a94:	f9400fe1 	ldr	x1, [sp, #24]
    4a98:	eb00003f 	cmp	x1, x0
    4a9c:	54000143 	b.cc	4ac4 <free+0x60>  // b.lo, b.ul, b.last
    4aa0:	f9400be1 	ldr	x1, [sp, #16]
    4aa4:	f9400fe0 	ldr	x0, [sp, #24]
    4aa8:	eb00003f 	cmp	x1, x0
    4aac:	54000248 	b.hi	4af4 <free+0x90>  // b.pmore
    4ab0:	f9400fe0 	ldr	x0, [sp, #24]
    4ab4:	f9400000 	ldr	x0, [x0]
    4ab8:	f9400be1 	ldr	x1, [sp, #16]
    4abc:	eb00003f 	cmp	x1, x0
    4ac0:	540001a3 	b.cc	4af4 <free+0x90>  // b.lo, b.ul, b.last
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4ac4:	f9400fe0 	ldr	x0, [sp, #24]
    4ac8:	f9400000 	ldr	x0, [x0]
    4acc:	f9000fe0 	str	x0, [sp, #24]
    4ad0:	f9400be1 	ldr	x1, [sp, #16]
    4ad4:	f9400fe0 	ldr	x0, [sp, #24]
    4ad8:	eb00003f 	cmp	x1, x0
    4adc:	54fffd89 	b.ls	4a8c <free+0x28>  // b.plast
    4ae0:	f9400fe0 	ldr	x0, [sp, #24]
    4ae4:	f9400000 	ldr	x0, [x0]
    4ae8:	f9400be1 	ldr	x1, [sp, #16]
    4aec:	eb00003f 	cmp	x1, x0
    4af0:	54fffce2 	b.cs	4a8c <free+0x28>  // b.hs, b.nlast
            break;
    if(bp + bp->s.size == p->s.ptr){
    4af4:	f9400be0 	ldr	x0, [sp, #16]
    4af8:	b9400800 	ldr	w0, [x0, #8]
    4afc:	2a0003e0 	mov	w0, w0
    4b00:	d37cec00 	lsl	x0, x0, #4
    4b04:	f9400be1 	ldr	x1, [sp, #16]
    4b08:	8b000021 	add	x1, x1, x0
    4b0c:	f9400fe0 	ldr	x0, [sp, #24]
    4b10:	f9400000 	ldr	x0, [x0]
    4b14:	eb00003f 	cmp	x1, x0
    4b18:	540001e1 	b.ne	4b54 <free+0xf0>  // b.any
        bp->s.size += p->s.ptr->s.size;
    4b1c:	f9400be0 	ldr	x0, [sp, #16]
    4b20:	b9400801 	ldr	w1, [x0, #8]
    4b24:	f9400fe0 	ldr	x0, [sp, #24]
    4b28:	f9400000 	ldr	x0, [x0]
    4b2c:	b9400800 	ldr	w0, [x0, #8]
    4b30:	0b000021 	add	w1, w1, w0
    4b34:	f9400be0 	ldr	x0, [sp, #16]
    4b38:	b9000801 	str	w1, [x0, #8]
        bp->s.ptr = p->s.ptr->s.ptr;
    4b3c:	f9400fe0 	ldr	x0, [sp, #24]
    4b40:	f9400000 	ldr	x0, [x0]
    4b44:	f9400001 	ldr	x1, [x0]
    4b48:	f9400be0 	ldr	x0, [sp, #16]
    4b4c:	f9000001 	str	x1, [x0]
    4b50:	14000005 	b	4b64 <free+0x100>
    } else
        bp->s.ptr = p->s.ptr;
    4b54:	f9400fe0 	ldr	x0, [sp, #24]
    4b58:	f9400001 	ldr	x1, [x0]
    4b5c:	f9400be0 	ldr	x0, [sp, #16]
    4b60:	f9000001 	str	x1, [x0]
    if(p + p->s.size == bp){
    4b64:	f9400fe0 	ldr	x0, [sp, #24]
    4b68:	b9400800 	ldr	w0, [x0, #8]
    4b6c:	2a0003e0 	mov	w0, w0
    4b70:	d37cec00 	lsl	x0, x0, #4
    4b74:	f9400fe1 	ldr	x1, [sp, #24]
    4b78:	8b000020 	add	x0, x1, x0
    4b7c:	f9400be1 	ldr	x1, [sp, #16]
    4b80:	eb00003f 	cmp	x1, x0
    4b84:	540001a1 	b.ne	4bb8 <free+0x154>  // b.any
        p->s.size += bp->s.size;
    4b88:	f9400fe0 	ldr	x0, [sp, #24]
    4b8c:	b9400801 	ldr	w1, [x0, #8]
    4b90:	f9400be0 	ldr	x0, [sp, #16]
    4b94:	b9400800 	ldr	w0, [x0, #8]
    4b98:	0b000021 	add	w1, w1, w0
    4b9c:	f9400fe0 	ldr	x0, [sp, #24]
    4ba0:	b9000801 	str	w1, [x0, #8]
        p->s.ptr = bp->s.ptr;
    4ba4:	f9400be0 	ldr	x0, [sp, #16]
    4ba8:	f9400001 	ldr	x1, [x0]
    4bac:	f9400fe0 	ldr	x0, [sp, #24]
    4bb0:	f9000001 	str	x1, [x0]
    4bb4:	14000004 	b	4bc4 <free+0x160>
    } else
        p->s.ptr = bp;
    4bb8:	f9400fe0 	ldr	x0, [sp, #24]
    4bbc:	f9400be1 	ldr	x1, [sp, #16]
    4bc0:	f9000001 	str	x1, [x0]
    freep = p;
    4bc4:	f0000020 	adrp	x0, b000 <args.0+0x48>
    4bc8:	91032000 	add	x0, x0, #0xc8
    4bcc:	f9400fe1 	ldr	x1, [sp, #24]
    4bd0:	f9000001 	str	x1, [x0]
}
    4bd4:	d503201f 	nop
    4bd8:	910083ff 	add	sp, sp, #0x20
    4bdc:	d65f03c0 	ret

0000000000004be0 <morecore>:

static Header*
morecore(uint nu)
{
    4be0:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
    4be4:	910003fd 	mov	x29, sp
    4be8:	b9001fe0 	str	w0, [sp, #28]
    char *p;
    Header *hp;
    
    if(nu < 4096)
    4bec:	b9401fe0 	ldr	w0, [sp, #28]
    4bf0:	713ffc1f 	cmp	w0, #0xfff
    4bf4:	54000068 	b.hi	4c00 <morecore+0x20>  // b.pmore
        nu = 4096;
    4bf8:	52820000 	mov	w0, #0x1000                	// #4096
    4bfc:	b9001fe0 	str	w0, [sp, #28]
    p = sbrk(nu * sizeof(Header));
    4c00:	b9401fe0 	ldr	w0, [sp, #28]
    4c04:	531c6c00 	lsl	w0, w0, #4
    4c08:	97fffe92 	bl	4650 <sbrk>
    4c0c:	f90017e0 	str	x0, [sp, #40]
    if(p == (char*)-1)
    4c10:	f94017e0 	ldr	x0, [sp, #40]
    4c14:	b100041f 	cmn	x0, #0x1
    4c18:	54000061 	b.ne	4c24 <morecore+0x44>  // b.any
        return 0;
    4c1c:	d2800000 	mov	x0, #0x0                   	// #0
    4c20:	1400000c 	b	4c50 <morecore+0x70>
    hp = (Header*)p;
    4c24:	f94017e0 	ldr	x0, [sp, #40]
    4c28:	f90013e0 	str	x0, [sp, #32]
    hp->s.size = nu;
    4c2c:	f94013e0 	ldr	x0, [sp, #32]
    4c30:	b9401fe1 	ldr	w1, [sp, #28]
    4c34:	b9000801 	str	w1, [x0, #8]
    free((void*)(hp + 1));
    4c38:	f94013e0 	ldr	x0, [sp, #32]
    4c3c:	91004000 	add	x0, x0, #0x10
    4c40:	97ffff89 	bl	4a64 <free>
    return freep;
    4c44:	f0000020 	adrp	x0, b000 <args.0+0x48>
    4c48:	91032000 	add	x0, x0, #0xc8
    4c4c:	f9400000 	ldr	x0, [x0]
}
    4c50:	a8c37bfd 	ldp	x29, x30, [sp], #48
    4c54:	d65f03c0 	ret

0000000000004c58 <malloc>:

void*
malloc(uint nbytes)
{
    4c58:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
    4c5c:	910003fd 	mov	x29, sp
    4c60:	b9001fe0 	str	w0, [sp, #28]
    Header *p, *prevp;
    uint nunits;
    
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    4c64:	b9401fe0 	ldr	w0, [sp, #28]
    4c68:	91003c00 	add	x0, x0, #0xf
    4c6c:	d344fc00 	lsr	x0, x0, #4
    4c70:	11000400 	add	w0, w0, #0x1
    4c74:	b9002fe0 	str	w0, [sp, #44]
    if((prevp = freep) == 0){
    4c78:	f0000020 	adrp	x0, b000 <args.0+0x48>
    4c7c:	91032000 	add	x0, x0, #0xc8
    4c80:	f9400000 	ldr	x0, [x0]
    4c84:	f9001be0 	str	x0, [sp, #48]
    4c88:	f9401be0 	ldr	x0, [sp, #48]
    4c8c:	f100001f 	cmp	x0, #0x0
    4c90:	54000221 	b.ne	4cd4 <malloc+0x7c>  // b.any
        base.s.ptr = freep = prevp = &base;
    4c94:	f0000020 	adrp	x0, b000 <args.0+0x48>
    4c98:	9102e000 	add	x0, x0, #0xb8
    4c9c:	f9001be0 	str	x0, [sp, #48]
    4ca0:	f0000020 	adrp	x0, b000 <args.0+0x48>
    4ca4:	91032000 	add	x0, x0, #0xc8
    4ca8:	f9401be1 	ldr	x1, [sp, #48]
    4cac:	f9000001 	str	x1, [x0]
    4cb0:	f0000020 	adrp	x0, b000 <args.0+0x48>
    4cb4:	91032000 	add	x0, x0, #0xc8
    4cb8:	f9400001 	ldr	x1, [x0]
    4cbc:	f0000020 	adrp	x0, b000 <args.0+0x48>
    4cc0:	9102e000 	add	x0, x0, #0xb8
    4cc4:	f9000001 	str	x1, [x0]
        base.s.size = 0;
    4cc8:	f0000020 	adrp	x0, b000 <args.0+0x48>
    4ccc:	9102e000 	add	x0, x0, #0xb8
    4cd0:	b900081f 	str	wzr, [x0, #8]
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4cd4:	f9401be0 	ldr	x0, [sp, #48]
    4cd8:	f9400000 	ldr	x0, [x0]
    4cdc:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
    4ce0:	f9401fe0 	ldr	x0, [sp, #56]
    4ce4:	b9400800 	ldr	w0, [x0, #8]
    4ce8:	b9402fe1 	ldr	w1, [sp, #44]
    4cec:	6b00003f 	cmp	w1, w0
    4cf0:	54000448 	b.hi	4d78 <malloc+0x120>  // b.pmore
            if(p->s.size == nunits)
    4cf4:	f9401fe0 	ldr	x0, [sp, #56]
    4cf8:	b9400800 	ldr	w0, [x0, #8]
    4cfc:	b9402fe1 	ldr	w1, [sp, #44]
    4d00:	6b00003f 	cmp	w1, w0
    4d04:	540000c1 	b.ne	4d1c <malloc+0xc4>  // b.any
                prevp->s.ptr = p->s.ptr;
    4d08:	f9401fe0 	ldr	x0, [sp, #56]
    4d0c:	f9400001 	ldr	x1, [x0]
    4d10:	f9401be0 	ldr	x0, [sp, #48]
    4d14:	f9000001 	str	x1, [x0]
    4d18:	14000011 	b	4d5c <malloc+0x104>
            else {
                p->s.size -= nunits;
    4d1c:	f9401fe0 	ldr	x0, [sp, #56]
    4d20:	b9400801 	ldr	w1, [x0, #8]
    4d24:	b9402fe0 	ldr	w0, [sp, #44]
    4d28:	4b000021 	sub	w1, w1, w0
    4d2c:	f9401fe0 	ldr	x0, [sp, #56]
    4d30:	b9000801 	str	w1, [x0, #8]
                p += p->s.size;
    4d34:	f9401fe0 	ldr	x0, [sp, #56]
    4d38:	b9400800 	ldr	w0, [x0, #8]
    4d3c:	2a0003e0 	mov	w0, w0
    4d40:	d37cec00 	lsl	x0, x0, #4
    4d44:	f9401fe1 	ldr	x1, [sp, #56]
    4d48:	8b000020 	add	x0, x1, x0
    4d4c:	f9001fe0 	str	x0, [sp, #56]
                p->s.size = nunits;
    4d50:	f9401fe0 	ldr	x0, [sp, #56]
    4d54:	b9402fe1 	ldr	w1, [sp, #44]
    4d58:	b9000801 	str	w1, [x0, #8]
            }
            freep = prevp;
    4d5c:	f0000020 	adrp	x0, b000 <args.0+0x48>
    4d60:	91032000 	add	x0, x0, #0xc8
    4d64:	f9401be1 	ldr	x1, [sp, #48]
    4d68:	f9000001 	str	x1, [x0]
            return (void*)(p + 1);
    4d6c:	f9401fe0 	ldr	x0, [sp, #56]
    4d70:	91004000 	add	x0, x0, #0x10
    4d74:	14000015 	b	4dc8 <malloc+0x170>
        }
        if(p == freep)
    4d78:	f0000020 	adrp	x0, b000 <args.0+0x48>
    4d7c:	91032000 	add	x0, x0, #0xc8
    4d80:	f9400000 	ldr	x0, [x0]
    4d84:	f9401fe1 	ldr	x1, [sp, #56]
    4d88:	eb00003f 	cmp	x1, x0
    4d8c:	54000121 	b.ne	4db0 <malloc+0x158>  // b.any
            if((p = morecore(nunits)) == 0)
    4d90:	b9402fe0 	ldr	w0, [sp, #44]
    4d94:	97ffff93 	bl	4be0 <morecore>
    4d98:	f9001fe0 	str	x0, [sp, #56]
    4d9c:	f9401fe0 	ldr	x0, [sp, #56]
    4da0:	f100001f 	cmp	x0, #0x0
    4da4:	54000061 	b.ne	4db0 <malloc+0x158>  // b.any
                return 0;
    4da8:	d2800000 	mov	x0, #0x0                   	// #0
    4dac:	14000007 	b	4dc8 <malloc+0x170>
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4db0:	f9401fe0 	ldr	x0, [sp, #56]
    4db4:	f9001be0 	str	x0, [sp, #48]
    4db8:	f9401fe0 	ldr	x0, [sp, #56]
    4dbc:	f9400000 	ldr	x0, [x0]
    4dc0:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
    4dc4:	17ffffc7 	b	4ce0 <malloc+0x88>
    }
}
    4dc8:	a8c47bfd 	ldp	x29, x30, [sp], #64
    4dcc:	d65f03c0 	ret
