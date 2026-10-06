
_sh:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <runcmd>:

// Execute cmd.  Never returns.
#pragma GCC diagnostic ignored "-Winfinite-recursion"
void
runcmd(struct cmd *cmd)
{
       0:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
       4:	910003fd 	mov	x29, sp
       8:	f9000fe0 	str	x0, [sp, #24]
    struct execcmd *ecmd;
    struct listcmd *lcmd;
    struct pipecmd *pcmd;
    struct redircmd *rcmd;
    
    if(cmd == 0)
       c:	f9400fe0 	ldr	x0, [sp, #24]
      10:	f100001f 	cmp	x0, #0x0
      14:	54000041 	b.ne	1c <runcmd+0x1c>  // b.any
        exit();
      18:	940004dc 	bl	1388 <exit>
    
    switch(cmd->type){
      1c:	f9400fe0 	ldr	x0, [sp, #24]
      20:	b9400000 	ldr	w0, [x0]
      24:	7100141f 	cmp	w0, #0x5
      28:	54000f60 	b.eq	214 <runcmd+0x214>  // b.none
      2c:	7100141f 	cmp	w0, #0x5
      30:	540001ac 	b.gt	64 <runcmd+0x64>
      34:	7100101f 	cmp	w0, #0x4
      38:	540007c0 	b.eq	130 <runcmd+0x130>  // b.none
      3c:	7100101f 	cmp	w0, #0x4
      40:	5400012c 	b.gt	64 <runcmd+0x64>
      44:	71000c1f 	cmp	w0, #0x3
      48:	540008e0 	b.eq	164 <runcmd+0x164>  // b.none
      4c:	71000c1f 	cmp	w0, #0x3
      50:	540000ac 	b.gt	64 <runcmd+0x64>
      54:	7100041f 	cmp	w0, #0x1
      58:	540000c0 	b.eq	70 <runcmd+0x70>  // b.none
      5c:	7100081f 	cmp	w0, #0x2
      60:	54000340 	b.eq	c8 <runcmd+0xc8>  // b.none
        default:
            panic("runcmd");
      64:	b0000000 	adrp	x0, 1000 <strlen+0x20>
      68:	9135c000 	add	x0, x0, #0xd70
      6c:	940000d4 	bl	3bc <panic>
            
        case EXEC:
            ecmd = (struct execcmd*)cmd;
      70:	f9400fe0 	ldr	x0, [sp, #24]
      74:	f90017e0 	str	x0, [sp, #40]
            if(ecmd->argv[0] == 0)
      78:	f94017e0 	ldr	x0, [sp, #40]
      7c:	f9400400 	ldr	x0, [x0, #8]
      80:	f100001f 	cmp	x0, #0x0
      84:	54000041 	b.ne	8c <runcmd+0x8c>  // b.any
                exit();
      88:	940004c0 	bl	1388 <exit>
            exec(ecmd->argv[0], ecmd->argv);
      8c:	f94017e0 	ldr	x0, [sp, #40]
      90:	f9400402 	ldr	x2, [x0, #8]
      94:	f94017e0 	ldr	x0, [sp, #40]
      98:	91002000 	add	x0, x0, #0x8
      9c:	aa0003e1 	mov	x1, x0
      a0:	aa0203e0 	mov	x0, x2
      a4:	940004f8 	bl	1484 <exec>
            printf(2, "exec %s failed\n", ecmd->argv[0]);
      a8:	f94017e0 	ldr	x0, [sp, #40]
      ac:	f9400400 	ldr	x0, [x0, #8]
      b0:	aa0003e2 	mov	x2, x0
      b4:	b0000000 	adrp	x0, 1000 <strlen+0x20>
      b8:	9135e001 	add	x1, x0, #0xd78
      bc:	52800040 	mov	w0, #0x2                   	// #2
      c0:	940005b9 	bl	17a4 <printf>
            break;
      c4:	1400005d 	b	238 <runcmd+0x238>
            
        case REDIR:
            rcmd = (struct redircmd*)cmd;
      c8:	f9400fe0 	ldr	x0, [sp, #24]
      cc:	f9001be0 	str	x0, [sp, #48]
            close(rcmd->fd);
      d0:	f9401be0 	ldr	x0, [sp, #48]
      d4:	b9402400 	ldr	w0, [x0, #36]
      d8:	940004d9 	bl	143c <close>
            if(open(rcmd->file, rcmd->mode) < 0){
      dc:	f9401be0 	ldr	x0, [sp, #48]
      e0:	f9400802 	ldr	x2, [x0, #16]
      e4:	f9401be0 	ldr	x0, [sp, #48]
      e8:	b9402000 	ldr	w0, [x0, #32]
      ec:	2a0003e1 	mov	w1, w0
      f0:	aa0203e0 	mov	x0, x2
      f4:	940004ed 	bl	14a8 <open>
      f8:	7100001f 	cmp	w0, #0x0
      fc:	5400012a 	b.ge	120 <runcmd+0x120>  // b.tcont
                printf(2, "open %s failed\n", rcmd->file);
     100:	f9401be0 	ldr	x0, [sp, #48]
     104:	f9400800 	ldr	x0, [x0, #16]
     108:	aa0003e2 	mov	x2, x0
     10c:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     110:	91362001 	add	x1, x0, #0xd88
     114:	52800040 	mov	w0, #0x2                   	// #2
     118:	940005a3 	bl	17a4 <printf>
                exit();
     11c:	9400049b 	bl	1388 <exit>
            }
            runcmd(rcmd->cmd);
     120:	f9401be0 	ldr	x0, [sp, #48]
     124:	f9400400 	ldr	x0, [x0, #8]
     128:	97ffffb6 	bl	0 <runcmd>
            break;
     12c:	14000043 	b	238 <runcmd+0x238>
            
        case LIST:
            lcmd = (struct listcmd*)cmd;
     130:	f9400fe0 	ldr	x0, [sp, #24]
     134:	f90023e0 	str	x0, [sp, #64]
            if(fork1() == 0)
     138:	940000aa 	bl	3e0 <fork1>
     13c:	7100001f 	cmp	w0, #0x0
     140:	54000081 	b.ne	150 <runcmd+0x150>  // b.any
                runcmd(lcmd->left);
     144:	f94023e0 	ldr	x0, [sp, #64]
     148:	f9400400 	ldr	x0, [x0, #8]
     14c:	97ffffad 	bl	0 <runcmd>
            wait();
     150:	94000497 	bl	13ac <wait>
            runcmd(lcmd->right);
     154:	f94023e0 	ldr	x0, [sp, #64]
     158:	f9400800 	ldr	x0, [x0, #16]
     15c:	97ffffa9 	bl	0 <runcmd>
            break;
     160:	14000036 	b	238 <runcmd+0x238>
            
        case PIPE:
            pcmd = (struct pipecmd*)cmd;
     164:	f9400fe0 	ldr	x0, [sp, #24]
     168:	f9001fe0 	str	x0, [sp, #56]
            if(pipe(p) < 0)
     16c:	910083e0 	add	x0, sp, #0x20
     170:	94000498 	bl	13d0 <pipe>
     174:	7100001f 	cmp	w0, #0x0
     178:	5400008a 	b.ge	188 <runcmd+0x188>  // b.tcont
                panic("pipe");
     17c:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     180:	91366000 	add	x0, x0, #0xd98
     184:	9400008e 	bl	3bc <panic>
            if(fork1() == 0){
     188:	94000096 	bl	3e0 <fork1>
     18c:	7100001f 	cmp	w0, #0x0
     190:	54000181 	b.ne	1c0 <runcmd+0x1c0>  // b.any
                close(1);
     194:	52800020 	mov	w0, #0x1                   	// #1
     198:	940004a9 	bl	143c <close>
                dup(p[1]);
     19c:	b94027e0 	ldr	w0, [sp, #36]
     1a0:	94000501 	bl	15a4 <dup>
                close(p[0]);
     1a4:	b94023e0 	ldr	w0, [sp, #32]
     1a8:	940004a5 	bl	143c <close>
                close(p[1]);
     1ac:	b94027e0 	ldr	w0, [sp, #36]
     1b0:	940004a3 	bl	143c <close>
                runcmd(pcmd->left);
     1b4:	f9401fe0 	ldr	x0, [sp, #56]
     1b8:	f9400400 	ldr	x0, [x0, #8]
     1bc:	97ffff91 	bl	0 <runcmd>
            }
            if(fork1() == 0){
     1c0:	94000088 	bl	3e0 <fork1>
     1c4:	7100001f 	cmp	w0, #0x0
     1c8:	54000181 	b.ne	1f8 <runcmd+0x1f8>  // b.any
                close(0);
     1cc:	52800000 	mov	w0, #0x0                   	// #0
     1d0:	9400049b 	bl	143c <close>
                dup(p[0]);
     1d4:	b94023e0 	ldr	w0, [sp, #32]
     1d8:	940004f3 	bl	15a4 <dup>
                close(p[0]);
     1dc:	b94023e0 	ldr	w0, [sp, #32]
     1e0:	94000497 	bl	143c <close>
                close(p[1]);
     1e4:	b94027e0 	ldr	w0, [sp, #36]
     1e8:	94000495 	bl	143c <close>
                runcmd(pcmd->right);
     1ec:	f9401fe0 	ldr	x0, [sp, #56]
     1f0:	f9400800 	ldr	x0, [x0, #16]
     1f4:	97ffff83 	bl	0 <runcmd>
            }
            close(p[0]);
     1f8:	b94023e0 	ldr	w0, [sp, #32]
     1fc:	94000490 	bl	143c <close>
            close(p[1]);
     200:	b94027e0 	ldr	w0, [sp, #36]
     204:	9400048e 	bl	143c <close>
            wait();
     208:	94000469 	bl	13ac <wait>
            wait();
     20c:	94000468 	bl	13ac <wait>
            break;
     210:	1400000a 	b	238 <runcmd+0x238>
            
        case BACK:
            bcmd = (struct backcmd*)cmd;
     214:	f9400fe0 	ldr	x0, [sp, #24]
     218:	f90027e0 	str	x0, [sp, #72]
            if(fork1() == 0)
     21c:	94000071 	bl	3e0 <fork1>
     220:	7100001f 	cmp	w0, #0x0
     224:	54000081 	b.ne	234 <runcmd+0x234>  // b.any
                runcmd(bcmd->cmd);
     228:	f94027e0 	ldr	x0, [sp, #72]
     22c:	f9400400 	ldr	x0, [x0, #8]
     230:	97ffff74 	bl	0 <runcmd>
            break;
     234:	d503201f 	nop
    }
    exit();
     238:	94000454 	bl	1388 <exit>

000000000000023c <getcmd>:
}

int
getcmd(char *buf, int nbuf)
{
     23c:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
     240:	910003fd 	mov	x29, sp
     244:	f9000fe0 	str	x0, [sp, #24]
     248:	b90017e1 	str	w1, [sp, #20]
    printf(2, "$ ");
     24c:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     250:	91368001 	add	x1, x0, #0xda0
     254:	52800040 	mov	w0, #0x2                   	// #2
     258:	94000553 	bl	17a4 <printf>
    memset(buf, 0, nbuf);
     25c:	b94017e0 	ldr	w0, [sp, #20]
     260:	2a0003e2 	mov	w2, w0
     264:	52800001 	mov	w1, #0x0                   	// #0
     268:	f9400fe0 	ldr	x0, [sp, #24]
     26c:	9400036d 	bl	1020 <memset>
    gets(buf, nbuf);
     270:	b94017e1 	ldr	w1, [sp, #20]
     274:	f9400fe0 	ldr	x0, [sp, #24]
     278:	940003c5 	bl	118c <gets>
    if(buf[0] == 0) // EOF
     27c:	f9400fe0 	ldr	x0, [sp, #24]
     280:	39400000 	ldrb	w0, [x0]
     284:	7100001f 	cmp	w0, #0x0
     288:	54000061 	b.ne	294 <getcmd+0x58>  // b.any
        return -1;
     28c:	12800000 	mov	w0, #0xffffffff            	// #-1
     290:	14000002 	b	298 <getcmd+0x5c>
    return 0;
     294:	52800000 	mov	w0, #0x0                   	// #0
}
     298:	a8c27bfd 	ldp	x29, x30, [sp], #32
     29c:	d65f03c0 	ret

00000000000002a0 <main>:

int
main(void)
{
     2a0:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
     2a4:	910003fd 	mov	x29, sp
    static char buf[100];
    int fd;
    
    // Assumes three file descriptors open.
    while((fd = open("console", O_RDWR)) >= 0){
     2a8:	14000007 	b	2c4 <main+0x24>
        if(fd >= 3){
     2ac:	b9401fe0 	ldr	w0, [sp, #28]
     2b0:	7100081f 	cmp	w0, #0x2
     2b4:	5400008d 	b.le	2c4 <main+0x24>
            close(fd);
     2b8:	b9401fe0 	ldr	w0, [sp, #28]
     2bc:	94000460 	bl	143c <close>
            break;
     2c0:	14000009 	b	2e4 <main+0x44>
    while((fd = open("console", O_RDWR)) >= 0){
     2c4:	52800041 	mov	w1, #0x2                   	// #2
     2c8:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     2cc:	9136a000 	add	x0, x0, #0xda8
     2d0:	94000476 	bl	14a8 <open>
     2d4:	b9001fe0 	str	w0, [sp, #28]
     2d8:	b9401fe0 	ldr	w0, [sp, #28]
     2dc:	7100001f 	cmp	w0, #0x0
     2e0:	54fffe6a 	b.ge	2ac <main+0xc>  // b.tcont
        }
    }
    
    // Read and run input commands.
    while(getcmd(buf, sizeof(buf)) >= 0){
     2e4:	1400002f 	b	3a0 <main+0x100>
        if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
     2e8:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     2ec:	913ac000 	add	x0, x0, #0xeb0
     2f0:	39400000 	ldrb	w0, [x0]
     2f4:	71018c1f 	cmp	w0, #0x63
     2f8:	54000401 	b.ne	378 <main+0xd8>  // b.any
     2fc:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     300:	913ac000 	add	x0, x0, #0xeb0
     304:	39400400 	ldrb	w0, [x0, #1]
     308:	7101901f 	cmp	w0, #0x64
     30c:	54000361 	b.ne	378 <main+0xd8>  // b.any
     310:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     314:	913ac000 	add	x0, x0, #0xeb0
     318:	39400800 	ldrb	w0, [x0, #2]
     31c:	7100801f 	cmp	w0, #0x20
     320:	540002c1 	b.ne	378 <main+0xd8>  // b.any
            // Clumsy but will have to do for now.
            // Chdir has no effect on the parent if run in the child.
            buf[strlen(buf)-1] = 0;  // chop \n
     324:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     328:	913ac000 	add	x0, x0, #0xeb0
     32c:	9400032d 	bl	fe0 <strlen>
     330:	51000402 	sub	w2, w0, #0x1
     334:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     338:	913ac001 	add	x1, x0, #0xeb0
     33c:	2a0203e0 	mov	w0, w2
     340:	3820683f 	strb	wzr, [x1, x0]
            if(chdir(buf+3) < 0)
     344:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     348:	913acc00 	add	x0, x0, #0xeb3
     34c:	9400048d 	bl	1580 <chdir>
     350:	7100001f 	cmp	w0, #0x0
     354:	5400024a 	b.ge	39c <main+0xfc>  // b.tcont
                printf(2, "cannot cd %s\n", buf+3);
     358:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     35c:	913acc00 	add	x0, x0, #0xeb3
     360:	aa0003e2 	mov	x2, x0
     364:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     368:	9136c001 	add	x1, x0, #0xdb0
     36c:	52800040 	mov	w0, #0x2                   	// #2
     370:	9400050d 	bl	17a4 <printf>
            continue;
     374:	1400000a 	b	39c <main+0xfc>
        }
        if(fork1() == 0)
     378:	9400001a 	bl	3e0 <fork1>
     37c:	7100001f 	cmp	w0, #0x0
     380:	540000a1 	b.ne	394 <main+0xf4>  // b.any
            runcmd(parsecmd(buf));
     384:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     388:	913ac000 	add	x0, x0, #0xeb0
     38c:	94000145 	bl	8a0 <parsecmd>
     390:	97ffff1c 	bl	0 <runcmd>
        wait();
     394:	94000406 	bl	13ac <wait>
     398:	14000002 	b	3a0 <main+0x100>
            continue;
     39c:	d503201f 	nop
    while(getcmd(buf, sizeof(buf)) >= 0){
     3a0:	52800c81 	mov	w1, #0x64                  	// #100
     3a4:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     3a8:	913ac000 	add	x0, x0, #0xeb0
     3ac:	97ffffa4 	bl	23c <getcmd>
     3b0:	7100001f 	cmp	w0, #0x0
     3b4:	54fff9aa 	b.ge	2e8 <main+0x48>  // b.tcont
    }
    exit();
     3b8:	940003f4 	bl	1388 <exit>

00000000000003bc <panic>:
}

void
panic(char *s)
{
     3bc:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
     3c0:	910003fd 	mov	x29, sp
     3c4:	f9000fe0 	str	x0, [sp, #24]
    printf(2, "%s\n", s);
     3c8:	f9400fe2 	ldr	x2, [sp, #24]
     3cc:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     3d0:	91370001 	add	x1, x0, #0xdc0
     3d4:	52800040 	mov	w0, #0x2                   	// #2
     3d8:	940004f3 	bl	17a4 <printf>
    exit();
     3dc:	940003eb 	bl	1388 <exit>

00000000000003e0 <fork1>:
}

int
fork1(void)
{
     3e0:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
     3e4:	910003fd 	mov	x29, sp
    int pid;
    
    pid = fork();
     3e8:	940003df 	bl	1364 <fork>
     3ec:	b9001fe0 	str	w0, [sp, #28]
    if(pid == -1)
     3f0:	b9401fe0 	ldr	w0, [sp, #28]
     3f4:	3100041f 	cmn	w0, #0x1
     3f8:	54000081 	b.ne	408 <fork1+0x28>  // b.any
        panic("fork");
     3fc:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     400:	91372000 	add	x0, x0, #0xdc8
     404:	97ffffee 	bl	3bc <panic>
    return pid;
     408:	b9401fe0 	ldr	w0, [sp, #28]
}
     40c:	a8c27bfd 	ldp	x29, x30, [sp], #32
     410:	d65f03c0 	ret

0000000000000414 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     414:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
     418:	910003fd 	mov	x29, sp
    struct execcmd *cmd;
    
    cmd = malloc(sizeof(*cmd));
     41c:	52801500 	mov	w0, #0xa8                  	// #168
     420:	940005f5 	bl	1bf4 <malloc>
     424:	f9000fe0 	str	x0, [sp, #24]
    memset(cmd, 0, sizeof(*cmd));
     428:	52801502 	mov	w2, #0xa8                  	// #168
     42c:	52800001 	mov	w1, #0x0                   	// #0
     430:	f9400fe0 	ldr	x0, [sp, #24]
     434:	940002fb 	bl	1020 <memset>
    cmd->type = EXEC;
     438:	f9400fe0 	ldr	x0, [sp, #24]
     43c:	52800021 	mov	w1, #0x1                   	// #1
     440:	b9000001 	str	w1, [x0]
    return (struct cmd*)cmd;
     444:	f9400fe0 	ldr	x0, [sp, #24]
}
     448:	a8c27bfd 	ldp	x29, x30, [sp], #32
     44c:	d65f03c0 	ret

0000000000000450 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     450:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
     454:	910003fd 	mov	x29, sp
     458:	f90017e0 	str	x0, [sp, #40]
     45c:	f90013e1 	str	x1, [sp, #32]
     460:	f9000fe2 	str	x2, [sp, #24]
     464:	b90017e3 	str	w3, [sp, #20]
     468:	b90013e4 	str	w4, [sp, #16]
    struct redircmd *cmd;
    
    cmd = malloc(sizeof(*cmd));
     46c:	52800500 	mov	w0, #0x28                  	// #40
     470:	940005e1 	bl	1bf4 <malloc>
     474:	f9001fe0 	str	x0, [sp, #56]
    memset(cmd, 0, sizeof(*cmd));
     478:	52800502 	mov	w2, #0x28                  	// #40
     47c:	52800001 	mov	w1, #0x0                   	// #0
     480:	f9401fe0 	ldr	x0, [sp, #56]
     484:	940002e7 	bl	1020 <memset>
    cmd->type = REDIR;
     488:	f9401fe0 	ldr	x0, [sp, #56]
     48c:	52800041 	mov	w1, #0x2                   	// #2
     490:	b9000001 	str	w1, [x0]
    cmd->cmd = subcmd;
     494:	f9401fe0 	ldr	x0, [sp, #56]
     498:	f94017e1 	ldr	x1, [sp, #40]
     49c:	f9000401 	str	x1, [x0, #8]
    cmd->file = file;
     4a0:	f9401fe0 	ldr	x0, [sp, #56]
     4a4:	f94013e1 	ldr	x1, [sp, #32]
     4a8:	f9000801 	str	x1, [x0, #16]
    cmd->efile = efile;
     4ac:	f9401fe0 	ldr	x0, [sp, #56]
     4b0:	f9400fe1 	ldr	x1, [sp, #24]
     4b4:	f9000c01 	str	x1, [x0, #24]
    cmd->mode = mode;
     4b8:	f9401fe0 	ldr	x0, [sp, #56]
     4bc:	b94017e1 	ldr	w1, [sp, #20]
     4c0:	b9002001 	str	w1, [x0, #32]
    cmd->fd = fd;
     4c4:	f9401fe0 	ldr	x0, [sp, #56]
     4c8:	b94013e1 	ldr	w1, [sp, #16]
     4cc:	b9002401 	str	w1, [x0, #36]
    return (struct cmd*)cmd;
     4d0:	f9401fe0 	ldr	x0, [sp, #56]
}
     4d4:	a8c47bfd 	ldp	x29, x30, [sp], #64
     4d8:	d65f03c0 	ret

00000000000004dc <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     4dc:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     4e0:	910003fd 	mov	x29, sp
     4e4:	f9000fe0 	str	x0, [sp, #24]
     4e8:	f9000be1 	str	x1, [sp, #16]
    struct pipecmd *cmd;
    
    cmd = malloc(sizeof(*cmd));
     4ec:	52800300 	mov	w0, #0x18                  	// #24
     4f0:	940005c1 	bl	1bf4 <malloc>
     4f4:	f90017e0 	str	x0, [sp, #40]
    memset(cmd, 0, sizeof(*cmd));
     4f8:	52800302 	mov	w2, #0x18                  	// #24
     4fc:	52800001 	mov	w1, #0x0                   	// #0
     500:	f94017e0 	ldr	x0, [sp, #40]
     504:	940002c7 	bl	1020 <memset>
    cmd->type = PIPE;
     508:	f94017e0 	ldr	x0, [sp, #40]
     50c:	52800061 	mov	w1, #0x3                   	// #3
     510:	b9000001 	str	w1, [x0]
    cmd->left = left;
     514:	f94017e0 	ldr	x0, [sp, #40]
     518:	f9400fe1 	ldr	x1, [sp, #24]
     51c:	f9000401 	str	x1, [x0, #8]
    cmd->right = right;
     520:	f94017e0 	ldr	x0, [sp, #40]
     524:	f9400be1 	ldr	x1, [sp, #16]
     528:	f9000801 	str	x1, [x0, #16]
    return (struct cmd*)cmd;
     52c:	f94017e0 	ldr	x0, [sp, #40]
}
     530:	a8c37bfd 	ldp	x29, x30, [sp], #48
     534:	d65f03c0 	ret

0000000000000538 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     538:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     53c:	910003fd 	mov	x29, sp
     540:	f9000fe0 	str	x0, [sp, #24]
     544:	f9000be1 	str	x1, [sp, #16]
    struct listcmd *cmd;
    
    cmd = malloc(sizeof(*cmd));
     548:	52800300 	mov	w0, #0x18                  	// #24
     54c:	940005aa 	bl	1bf4 <malloc>
     550:	f90017e0 	str	x0, [sp, #40]
    memset(cmd, 0, sizeof(*cmd));
     554:	52800302 	mov	w2, #0x18                  	// #24
     558:	52800001 	mov	w1, #0x0                   	// #0
     55c:	f94017e0 	ldr	x0, [sp, #40]
     560:	940002b0 	bl	1020 <memset>
    cmd->type = LIST;
     564:	f94017e0 	ldr	x0, [sp, #40]
     568:	52800081 	mov	w1, #0x4                   	// #4
     56c:	b9000001 	str	w1, [x0]
    cmd->left = left;
     570:	f94017e0 	ldr	x0, [sp, #40]
     574:	f9400fe1 	ldr	x1, [sp, #24]
     578:	f9000401 	str	x1, [x0, #8]
    cmd->right = right;
     57c:	f94017e0 	ldr	x0, [sp, #40]
     580:	f9400be1 	ldr	x1, [sp, #16]
     584:	f9000801 	str	x1, [x0, #16]
    return (struct cmd*)cmd;
     588:	f94017e0 	ldr	x0, [sp, #40]
}
     58c:	a8c37bfd 	ldp	x29, x30, [sp], #48
     590:	d65f03c0 	ret

0000000000000594 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     594:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     598:	910003fd 	mov	x29, sp
     59c:	f9000fe0 	str	x0, [sp, #24]
    struct backcmd *cmd;
    
    cmd = malloc(sizeof(*cmd));
     5a0:	52800200 	mov	w0, #0x10                  	// #16
     5a4:	94000594 	bl	1bf4 <malloc>
     5a8:	f90017e0 	str	x0, [sp, #40]
    memset(cmd, 0, sizeof(*cmd));
     5ac:	52800202 	mov	w2, #0x10                  	// #16
     5b0:	52800001 	mov	w1, #0x0                   	// #0
     5b4:	f94017e0 	ldr	x0, [sp, #40]
     5b8:	9400029a 	bl	1020 <memset>
    cmd->type = BACK;
     5bc:	f94017e0 	ldr	x0, [sp, #40]
     5c0:	528000a1 	mov	w1, #0x5                   	// #5
     5c4:	b9000001 	str	w1, [x0]
    cmd->cmd = subcmd;
     5c8:	f94017e0 	ldr	x0, [sp, #40]
     5cc:	f9400fe1 	ldr	x1, [sp, #24]
     5d0:	f9000401 	str	x1, [x0, #8]
    return (struct cmd*)cmd;
     5d4:	f94017e0 	ldr	x0, [sp, #40]
}
     5d8:	a8c37bfd 	ldp	x29, x30, [sp], #48
     5dc:	d65f03c0 	ret

00000000000005e0 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     5e0:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
     5e4:	910003fd 	mov	x29, sp
     5e8:	f90017e0 	str	x0, [sp, #40]
     5ec:	f90013e1 	str	x1, [sp, #32]
     5f0:	f9000fe2 	str	x2, [sp, #24]
     5f4:	f9000be3 	str	x3, [sp, #16]
    char *s;
    int ret;
    
    s = *ps;
     5f8:	f94017e0 	ldr	x0, [sp, #40]
     5fc:	f9400000 	ldr	x0, [x0]
     600:	f9001fe0 	str	x0, [sp, #56]
    while(s < es && strchr(whitespace, *s))
     604:	14000004 	b	614 <gettoken+0x34>
        s++;
     608:	f9401fe0 	ldr	x0, [sp, #56]
     60c:	91000400 	add	x0, x0, #0x1
     610:	f9001fe0 	str	x0, [sp, #56]
    while(s < es && strchr(whitespace, *s))
     614:	f9401fe1 	ldr	x1, [sp, #56]
     618:	f94013e0 	ldr	x0, [sp, #32]
     61c:	eb00003f 	cmp	x1, x0
     620:	54000122 	b.cs	644 <gettoken+0x64>  // b.hs, b.nlast
     624:	f9401fe0 	ldr	x0, [sp, #56]
     628:	39400000 	ldrb	w0, [x0]
     62c:	2a0003e1 	mov	w1, w0
     630:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     634:	913a2000 	add	x0, x0, #0xe88
     638:	940002c0 	bl	1138 <strchr>
     63c:	f100001f 	cmp	x0, #0x0
     640:	54fffe41 	b.ne	608 <gettoken+0x28>  // b.any
    if(q)
     644:	f9400fe0 	ldr	x0, [sp, #24]
     648:	f100001f 	cmp	x0, #0x0
     64c:	54000080 	b.eq	65c <gettoken+0x7c>  // b.none
        *q = s;
     650:	f9400fe0 	ldr	x0, [sp, #24]
     654:	f9401fe1 	ldr	x1, [sp, #56]
     658:	f9000001 	str	x1, [x0]
    ret = *s;
     65c:	f9401fe0 	ldr	x0, [sp, #56]
     660:	39400000 	ldrb	w0, [x0]
     664:	b90037e0 	str	w0, [sp, #52]
    switch(*s){
     668:	f9401fe0 	ldr	x0, [sp, #56]
     66c:	39400000 	ldrb	w0, [x0]
     670:	7101f01f 	cmp	w0, #0x7c
     674:	54000260 	b.eq	6c0 <gettoken+0xe0>  // b.none
     678:	7101f01f 	cmp	w0, #0x7c
     67c:	5400044c 	b.gt	704 <gettoken+0x124>
     680:	7100f81f 	cmp	w0, #0x3e
     684:	54000260 	b.eq	6d0 <gettoken+0xf0>  // b.none
     688:	7100f81f 	cmp	w0, #0x3e
     68c:	540003cc 	b.gt	704 <gettoken+0x124>
     690:	7100f01f 	cmp	w0, #0x3c
     694:	5400038c 	b.gt	704 <gettoken+0x124>
     698:	7100ec1f 	cmp	w0, #0x3b
     69c:	5400012a 	b.ge	6c0 <gettoken+0xe0>  // b.tcont
     6a0:	7100a41f 	cmp	w0, #0x29
     6a4:	5400030c 	b.gt	704 <gettoken+0x124>
     6a8:	7100a01f 	cmp	w0, #0x28
     6ac:	540000aa 	b.ge	6c0 <gettoken+0xe0>  // b.tcont
     6b0:	7100001f 	cmp	w0, #0x0
     6b4:	540005e0 	b.eq	770 <gettoken+0x190>  // b.none
     6b8:	7100981f 	cmp	w0, #0x26
     6bc:	54000241 	b.ne	704 <gettoken+0x124>  // b.any
        case '(':
        case ')':
        case ';':
        case '&':
        case '<':
            s++;
     6c0:	f9401fe0 	ldr	x0, [sp, #56]
     6c4:	91000400 	add	x0, x0, #0x1
     6c8:	f9001fe0 	str	x0, [sp, #56]
            break;
     6cc:	1400002e 	b	784 <gettoken+0x1a4>
        case '>':
            s++;
     6d0:	f9401fe0 	ldr	x0, [sp, #56]
     6d4:	91000400 	add	x0, x0, #0x1
     6d8:	f9001fe0 	str	x0, [sp, #56]
            if(*s == '>'){
     6dc:	f9401fe0 	ldr	x0, [sp, #56]
     6e0:	39400000 	ldrb	w0, [x0]
     6e4:	7100f81f 	cmp	w0, #0x3e
     6e8:	54000481 	b.ne	778 <gettoken+0x198>  // b.any
                ret = '+';
     6ec:	52800560 	mov	w0, #0x2b                  	// #43
     6f0:	b90037e0 	str	w0, [sp, #52]
                s++;
     6f4:	f9401fe0 	ldr	x0, [sp, #56]
     6f8:	91000400 	add	x0, x0, #0x1
     6fc:	f9001fe0 	str	x0, [sp, #56]
            }
            break;
     700:	1400001e 	b	778 <gettoken+0x198>
        default:
            ret = 'a';
     704:	52800c20 	mov	w0, #0x61                  	// #97
     708:	b90037e0 	str	w0, [sp, #52]
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     70c:	14000004 	b	71c <gettoken+0x13c>
                s++;
     710:	f9401fe0 	ldr	x0, [sp, #56]
     714:	91000400 	add	x0, x0, #0x1
     718:	f9001fe0 	str	x0, [sp, #56]
            while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     71c:	f9401fe1 	ldr	x1, [sp, #56]
     720:	f94013e0 	ldr	x0, [sp, #32]
     724:	eb00003f 	cmp	x1, x0
     728:	540002c2 	b.cs	780 <gettoken+0x1a0>  // b.hs, b.nlast
     72c:	f9401fe0 	ldr	x0, [sp, #56]
     730:	39400000 	ldrb	w0, [x0]
     734:	2a0003e1 	mov	w1, w0
     738:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     73c:	913a2000 	add	x0, x0, #0xe88
     740:	9400027e 	bl	1138 <strchr>
     744:	f100001f 	cmp	x0, #0x0
     748:	540001c1 	b.ne	780 <gettoken+0x1a0>  // b.any
     74c:	f9401fe0 	ldr	x0, [sp, #56]
     750:	39400000 	ldrb	w0, [x0]
     754:	2a0003e1 	mov	w1, w0
     758:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     75c:	913a4000 	add	x0, x0, #0xe90
     760:	94000276 	bl	1138 <strchr>
     764:	f100001f 	cmp	x0, #0x0
     768:	54fffd40 	b.eq	710 <gettoken+0x130>  // b.none
            break;
     76c:	14000005 	b	780 <gettoken+0x1a0>
            break;
     770:	d503201f 	nop
     774:	14000004 	b	784 <gettoken+0x1a4>
            break;
     778:	d503201f 	nop
     77c:	14000002 	b	784 <gettoken+0x1a4>
            break;
     780:	d503201f 	nop
    }
    if(eq)
     784:	f9400be0 	ldr	x0, [sp, #16]
     788:	f100001f 	cmp	x0, #0x0
     78c:	54000100 	b.eq	7ac <gettoken+0x1cc>  // b.none
        *eq = s;
     790:	f9400be0 	ldr	x0, [sp, #16]
     794:	f9401fe1 	ldr	x1, [sp, #56]
     798:	f9000001 	str	x1, [x0]
    
    while(s < es && strchr(whitespace, *s))
     79c:	14000004 	b	7ac <gettoken+0x1cc>
        s++;
     7a0:	f9401fe0 	ldr	x0, [sp, #56]
     7a4:	91000400 	add	x0, x0, #0x1
     7a8:	f9001fe0 	str	x0, [sp, #56]
    while(s < es && strchr(whitespace, *s))
     7ac:	f9401fe1 	ldr	x1, [sp, #56]
     7b0:	f94013e0 	ldr	x0, [sp, #32]
     7b4:	eb00003f 	cmp	x1, x0
     7b8:	54000122 	b.cs	7dc <gettoken+0x1fc>  // b.hs, b.nlast
     7bc:	f9401fe0 	ldr	x0, [sp, #56]
     7c0:	39400000 	ldrb	w0, [x0]
     7c4:	2a0003e1 	mov	w1, w0
     7c8:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     7cc:	913a2000 	add	x0, x0, #0xe88
     7d0:	9400025a 	bl	1138 <strchr>
     7d4:	f100001f 	cmp	x0, #0x0
     7d8:	54fffe41 	b.ne	7a0 <gettoken+0x1c0>  // b.any
    *ps = s;
     7dc:	f94017e0 	ldr	x0, [sp, #40]
     7e0:	f9401fe1 	ldr	x1, [sp, #56]
     7e4:	f9000001 	str	x1, [x0]
    return ret;
     7e8:	b94037e0 	ldr	w0, [sp, #52]
}
     7ec:	a8c47bfd 	ldp	x29, x30, [sp], #64
     7f0:	d65f03c0 	ret

00000000000007f4 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     7f4:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
     7f8:	910003fd 	mov	x29, sp
     7fc:	f90017e0 	str	x0, [sp, #40]
     800:	f90013e1 	str	x1, [sp, #32]
     804:	f9000fe2 	str	x2, [sp, #24]
    char *s;
    
    s = *ps;
     808:	f94017e0 	ldr	x0, [sp, #40]
     80c:	f9400000 	ldr	x0, [x0]
     810:	f9001fe0 	str	x0, [sp, #56]
    while(s < es && strchr(whitespace, *s))
     814:	14000004 	b	824 <peek+0x30>
        s++;
     818:	f9401fe0 	ldr	x0, [sp, #56]
     81c:	91000400 	add	x0, x0, #0x1
     820:	f9001fe0 	str	x0, [sp, #56]
    while(s < es && strchr(whitespace, *s))
     824:	f9401fe1 	ldr	x1, [sp, #56]
     828:	f94013e0 	ldr	x0, [sp, #32]
     82c:	eb00003f 	cmp	x1, x0
     830:	54000122 	b.cs	854 <peek+0x60>  // b.hs, b.nlast
     834:	f9401fe0 	ldr	x0, [sp, #56]
     838:	39400000 	ldrb	w0, [x0]
     83c:	2a0003e1 	mov	w1, w0
     840:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     844:	913a2000 	add	x0, x0, #0xe88
     848:	9400023c 	bl	1138 <strchr>
     84c:	f100001f 	cmp	x0, #0x0
     850:	54fffe41 	b.ne	818 <peek+0x24>  // b.any
    *ps = s;
     854:	f94017e0 	ldr	x0, [sp, #40]
     858:	f9401fe1 	ldr	x1, [sp, #56]
     85c:	f9000001 	str	x1, [x0]
    return *s && strchr(toks, *s);
     860:	f9401fe0 	ldr	x0, [sp, #56]
     864:	39400000 	ldrb	w0, [x0]
     868:	7100001f 	cmp	w0, #0x0
     86c:	54000140 	b.eq	894 <peek+0xa0>  // b.none
     870:	f9401fe0 	ldr	x0, [sp, #56]
     874:	39400000 	ldrb	w0, [x0]
     878:	2a0003e1 	mov	w1, w0
     87c:	f9400fe0 	ldr	x0, [sp, #24]
     880:	9400022e 	bl	1138 <strchr>
     884:	f100001f 	cmp	x0, #0x0
     888:	54000060 	b.eq	894 <peek+0xa0>  // b.none
     88c:	52800020 	mov	w0, #0x1                   	// #1
     890:	14000002 	b	898 <peek+0xa4>
     894:	52800000 	mov	w0, #0x0                   	// #0
}
     898:	a8c47bfd 	ldp	x29, x30, [sp], #64
     89c:	d65f03c0 	ret

00000000000008a0 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     8a0:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
     8a4:	910003fd 	mov	x29, sp
     8a8:	f9000bf3 	str	x19, [sp, #16]
     8ac:	f90017e0 	str	x0, [sp, #40]
    char *es;
    struct cmd *cmd;
    
    es = s + strlen(s);
     8b0:	f94017f3 	ldr	x19, [sp, #40]
     8b4:	f94017e0 	ldr	x0, [sp, #40]
     8b8:	940001ca 	bl	fe0 <strlen>
     8bc:	2a0003e0 	mov	w0, w0
     8c0:	8b000260 	add	x0, x19, x0
     8c4:	f9001fe0 	str	x0, [sp, #56]
    cmd = parseline(&s, es);
     8c8:	9100a3e0 	add	x0, sp, #0x28
     8cc:	f9401fe1 	ldr	x1, [sp, #56]
     8d0:	9400001b 	bl	93c <parseline>
     8d4:	f9001be0 	str	x0, [sp, #48]
    peek(&s, es, "");
     8d8:	9100a3e3 	add	x3, sp, #0x28
     8dc:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     8e0:	91374002 	add	x2, x0, #0xdd0
     8e4:	f9401fe1 	ldr	x1, [sp, #56]
     8e8:	aa0303e0 	mov	x0, x3
     8ec:	97ffffc2 	bl	7f4 <peek>
    if(s != es){
     8f0:	f94017e0 	ldr	x0, [sp, #40]
     8f4:	f9401fe1 	ldr	x1, [sp, #56]
     8f8:	eb00003f 	cmp	x1, x0
     8fc:	54000140 	b.eq	924 <parsecmd+0x84>  // b.none
        printf(2, "leftovers: %s\n", s);
     900:	f94017e0 	ldr	x0, [sp, #40]
     904:	aa0003e2 	mov	x2, x0
     908:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     90c:	91376001 	add	x1, x0, #0xdd8
     910:	52800040 	mov	w0, #0x2                   	// #2
     914:	940003a4 	bl	17a4 <printf>
        panic("syntax");
     918:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     91c:	9137a000 	add	x0, x0, #0xde8
     920:	97fffea7 	bl	3bc <panic>
    }
    nulterminate(cmd);
     924:	f9401be0 	ldr	x0, [sp, #48]
     928:	94000129 	bl	dcc <nulterminate>
    return cmd;
     92c:	f9401be0 	ldr	x0, [sp, #48]
}
     930:	f9400bf3 	ldr	x19, [sp, #16]
     934:	a8c47bfd 	ldp	x29, x30, [sp], #64
     938:	d65f03c0 	ret

000000000000093c <parseline>:

struct cmd*
parseline(char **ps, char *es)
{
     93c:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     940:	910003fd 	mov	x29, sp
     944:	f9000fe0 	str	x0, [sp, #24]
     948:	f9000be1 	str	x1, [sp, #16]
    struct cmd *cmd;
    
    cmd = parsepipe(ps, es);
     94c:	f9400be1 	ldr	x1, [sp, #16]
     950:	f9400fe0 	ldr	x0, [sp, #24]
     954:	94000028 	bl	9f4 <parsepipe>
     958:	f90017e0 	str	x0, [sp, #40]
    while(peek(ps, es, "&")){
     95c:	14000009 	b	980 <parseline+0x44>
        gettoken(ps, es, 0, 0);
     960:	d2800003 	mov	x3, #0x0                   	// #0
     964:	d2800002 	mov	x2, #0x0                   	// #0
     968:	f9400be1 	ldr	x1, [sp, #16]
     96c:	f9400fe0 	ldr	x0, [sp, #24]
     970:	97ffff1c 	bl	5e0 <gettoken>
        cmd = backcmd(cmd);
     974:	f94017e0 	ldr	x0, [sp, #40]
     978:	97ffff07 	bl	594 <backcmd>
     97c:	f90017e0 	str	x0, [sp, #40]
    while(peek(ps, es, "&")){
     980:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     984:	9137c002 	add	x2, x0, #0xdf0
     988:	f9400be1 	ldr	x1, [sp, #16]
     98c:	f9400fe0 	ldr	x0, [sp, #24]
     990:	97ffff99 	bl	7f4 <peek>
     994:	7100001f 	cmp	w0, #0x0
     998:	54fffe41 	b.ne	960 <parseline+0x24>  // b.any
    }
    if(peek(ps, es, ";")){
     99c:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     9a0:	9137e002 	add	x2, x0, #0xdf8
     9a4:	f9400be1 	ldr	x1, [sp, #16]
     9a8:	f9400fe0 	ldr	x0, [sp, #24]
     9ac:	97ffff92 	bl	7f4 <peek>
     9b0:	7100001f 	cmp	w0, #0x0
     9b4:	540001a0 	b.eq	9e8 <parseline+0xac>  // b.none
        gettoken(ps, es, 0, 0);
     9b8:	d2800003 	mov	x3, #0x0                   	// #0
     9bc:	d2800002 	mov	x2, #0x0                   	// #0
     9c0:	f9400be1 	ldr	x1, [sp, #16]
     9c4:	f9400fe0 	ldr	x0, [sp, #24]
     9c8:	97ffff06 	bl	5e0 <gettoken>
        cmd = listcmd(cmd, parseline(ps, es));
     9cc:	f9400be1 	ldr	x1, [sp, #16]
     9d0:	f9400fe0 	ldr	x0, [sp, #24]
     9d4:	97ffffda 	bl	93c <parseline>
     9d8:	aa0003e1 	mov	x1, x0
     9dc:	f94017e0 	ldr	x0, [sp, #40]
     9e0:	97fffed6 	bl	538 <listcmd>
     9e4:	f90017e0 	str	x0, [sp, #40]
    }
    return cmd;
     9e8:	f94017e0 	ldr	x0, [sp, #40]
}
     9ec:	a8c37bfd 	ldp	x29, x30, [sp], #48
     9f0:	d65f03c0 	ret

00000000000009f4 <parsepipe>:

struct cmd*
parsepipe(char **ps, char *es)
{
     9f4:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     9f8:	910003fd 	mov	x29, sp
     9fc:	f9000fe0 	str	x0, [sp, #24]
     a00:	f9000be1 	str	x1, [sp, #16]
    struct cmd *cmd;
    
    cmd = parseexec(ps, es);
     a04:	f9400be1 	ldr	x1, [sp, #16]
     a08:	f9400fe0 	ldr	x0, [sp, #24]
     a0c:	94000093 	bl	c58 <parseexec>
     a10:	f90017e0 	str	x0, [sp, #40]
    if(peek(ps, es, "|")){
     a14:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     a18:	91380002 	add	x2, x0, #0xe00
     a1c:	f9400be1 	ldr	x1, [sp, #16]
     a20:	f9400fe0 	ldr	x0, [sp, #24]
     a24:	97ffff74 	bl	7f4 <peek>
     a28:	7100001f 	cmp	w0, #0x0
     a2c:	540001a0 	b.eq	a60 <parsepipe+0x6c>  // b.none
        gettoken(ps, es, 0, 0);
     a30:	d2800003 	mov	x3, #0x0                   	// #0
     a34:	d2800002 	mov	x2, #0x0                   	// #0
     a38:	f9400be1 	ldr	x1, [sp, #16]
     a3c:	f9400fe0 	ldr	x0, [sp, #24]
     a40:	97fffee8 	bl	5e0 <gettoken>
        cmd = pipecmd(cmd, parsepipe(ps, es));
     a44:	f9400be1 	ldr	x1, [sp, #16]
     a48:	f9400fe0 	ldr	x0, [sp, #24]
     a4c:	97ffffea 	bl	9f4 <parsepipe>
     a50:	aa0003e1 	mov	x1, x0
     a54:	f94017e0 	ldr	x0, [sp, #40]
     a58:	97fffea1 	bl	4dc <pipecmd>
     a5c:	f90017e0 	str	x0, [sp, #40]
    }
    return cmd;
     a60:	f94017e0 	ldr	x0, [sp, #40]
}
     a64:	a8c37bfd 	ldp	x29, x30, [sp], #48
     a68:	d65f03c0 	ret

0000000000000a6c <parseredirs>:

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     a6c:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
     a70:	910003fd 	mov	x29, sp
     a74:	f90017e0 	str	x0, [sp, #40]
     a78:	f90013e1 	str	x1, [sp, #32]
     a7c:	f9000fe2 	str	x2, [sp, #24]
    int tok;
    char *q, *eq;
    
    while(peek(ps, es, "<>")){
     a80:	1400003e 	b	b78 <parseredirs+0x10c>
        tok = gettoken(ps, es, 0, 0);
     a84:	d2800003 	mov	x3, #0x0                   	// #0
     a88:	d2800002 	mov	x2, #0x0                   	// #0
     a8c:	f9400fe1 	ldr	x1, [sp, #24]
     a90:	f94013e0 	ldr	x0, [sp, #32]
     a94:	97fffed3 	bl	5e0 <gettoken>
     a98:	b9004fe0 	str	w0, [sp, #76]
        if(gettoken(ps, es, &q, &eq) != 'a')
     a9c:	9100e3e1 	add	x1, sp, #0x38
     aa0:	910103e0 	add	x0, sp, #0x40
     aa4:	aa0103e3 	mov	x3, x1
     aa8:	aa0003e2 	mov	x2, x0
     aac:	f9400fe1 	ldr	x1, [sp, #24]
     ab0:	f94013e0 	ldr	x0, [sp, #32]
     ab4:	97fffecb 	bl	5e0 <gettoken>
     ab8:	7101841f 	cmp	w0, #0x61
     abc:	54000080 	b.eq	acc <parseredirs+0x60>  // b.none
            panic("missing file for redirection");
     ac0:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     ac4:	91382000 	add	x0, x0, #0xe08
     ac8:	97fffe3d 	bl	3bc <panic>
        switch(tok){
     acc:	b9404fe0 	ldr	w0, [sp, #76]
     ad0:	7100f81f 	cmp	w0, #0x3e
     ad4:	540002a0 	b.eq	b28 <parseredirs+0xbc>  // b.none
     ad8:	b9404fe0 	ldr	w0, [sp, #76]
     adc:	7100f81f 	cmp	w0, #0x3e
     ae0:	540004cc 	b.gt	b78 <parseredirs+0x10c>
     ae4:	b9404fe0 	ldr	w0, [sp, #76]
     ae8:	7100ac1f 	cmp	w0, #0x2b
     aec:	54000320 	b.eq	b50 <parseredirs+0xe4>  // b.none
     af0:	b9404fe0 	ldr	w0, [sp, #76]
     af4:	7100f01f 	cmp	w0, #0x3c
     af8:	54000040 	b.eq	b00 <parseredirs+0x94>  // b.none
     afc:	1400001f 	b	b78 <parseredirs+0x10c>
            case '<':
                cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     b00:	f94023e0 	ldr	x0, [sp, #64]
     b04:	f9401fe1 	ldr	x1, [sp, #56]
     b08:	52800004 	mov	w4, #0x0                   	// #0
     b0c:	52800003 	mov	w3, #0x0                   	// #0
     b10:	aa0103e2 	mov	x2, x1
     b14:	aa0003e1 	mov	x1, x0
     b18:	f94017e0 	ldr	x0, [sp, #40]
     b1c:	97fffe4d 	bl	450 <redircmd>
     b20:	f90017e0 	str	x0, [sp, #40]
                break;
     b24:	14000015 	b	b78 <parseredirs+0x10c>
            case '>':
                cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     b28:	f94023e0 	ldr	x0, [sp, #64]
     b2c:	f9401fe1 	ldr	x1, [sp, #56]
     b30:	52800024 	mov	w4, #0x1                   	// #1
     b34:	52804023 	mov	w3, #0x201                 	// #513
     b38:	aa0103e2 	mov	x2, x1
     b3c:	aa0003e1 	mov	x1, x0
     b40:	f94017e0 	ldr	x0, [sp, #40]
     b44:	97fffe43 	bl	450 <redircmd>
     b48:	f90017e0 	str	x0, [sp, #40]
                break;
     b4c:	1400000b 	b	b78 <parseredirs+0x10c>
            case '+':  // >>
                cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     b50:	f94023e0 	ldr	x0, [sp, #64]
     b54:	f9401fe1 	ldr	x1, [sp, #56]
     b58:	52800024 	mov	w4, #0x1                   	// #1
     b5c:	52804023 	mov	w3, #0x201                 	// #513
     b60:	aa0103e2 	mov	x2, x1
     b64:	aa0003e1 	mov	x1, x0
     b68:	f94017e0 	ldr	x0, [sp, #40]
     b6c:	97fffe39 	bl	450 <redircmd>
     b70:	f90017e0 	str	x0, [sp, #40]
                break;
     b74:	d503201f 	nop
    while(peek(ps, es, "<>")){
     b78:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     b7c:	9138a002 	add	x2, x0, #0xe28
     b80:	f9400fe1 	ldr	x1, [sp, #24]
     b84:	f94013e0 	ldr	x0, [sp, #32]
     b88:	97ffff1b 	bl	7f4 <peek>
     b8c:	7100001f 	cmp	w0, #0x0
     b90:	54fff7a1 	b.ne	a84 <parseredirs+0x18>  // b.any
        }
    }
    return cmd;
     b94:	f94017e0 	ldr	x0, [sp, #40]
}
     b98:	a8c57bfd 	ldp	x29, x30, [sp], #80
     b9c:	d65f03c0 	ret

0000000000000ba0 <parseblock>:

struct cmd*
parseblock(char **ps, char *es)
{
     ba0:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
     ba4:	910003fd 	mov	x29, sp
     ba8:	f9000fe0 	str	x0, [sp, #24]
     bac:	f9000be1 	str	x1, [sp, #16]
    struct cmd *cmd;
    
    if(!peek(ps, es, "("))
     bb0:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     bb4:	9138c002 	add	x2, x0, #0xe30
     bb8:	f9400be1 	ldr	x1, [sp, #16]
     bbc:	f9400fe0 	ldr	x0, [sp, #24]
     bc0:	97ffff0d 	bl	7f4 <peek>
     bc4:	7100001f 	cmp	w0, #0x0
     bc8:	54000081 	b.ne	bd8 <parseblock+0x38>  // b.any
        panic("parseblock");
     bcc:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     bd0:	9138e000 	add	x0, x0, #0xe38
     bd4:	97fffdfa 	bl	3bc <panic>
    gettoken(ps, es, 0, 0);
     bd8:	d2800003 	mov	x3, #0x0                   	// #0
     bdc:	d2800002 	mov	x2, #0x0                   	// #0
     be0:	f9400be1 	ldr	x1, [sp, #16]
     be4:	f9400fe0 	ldr	x0, [sp, #24]
     be8:	97fffe7e 	bl	5e0 <gettoken>
    cmd = parseline(ps, es);
     bec:	f9400be1 	ldr	x1, [sp, #16]
     bf0:	f9400fe0 	ldr	x0, [sp, #24]
     bf4:	97ffff52 	bl	93c <parseline>
     bf8:	f90017e0 	str	x0, [sp, #40]
    if(!peek(ps, es, ")"))
     bfc:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     c00:	91392002 	add	x2, x0, #0xe48
     c04:	f9400be1 	ldr	x1, [sp, #16]
     c08:	f9400fe0 	ldr	x0, [sp, #24]
     c0c:	97fffefa 	bl	7f4 <peek>
     c10:	7100001f 	cmp	w0, #0x0
     c14:	54000081 	b.ne	c24 <parseblock+0x84>  // b.any
        panic("syntax - missing )");
     c18:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     c1c:	91394000 	add	x0, x0, #0xe50
     c20:	97fffde7 	bl	3bc <panic>
    gettoken(ps, es, 0, 0);
     c24:	d2800003 	mov	x3, #0x0                   	// #0
     c28:	d2800002 	mov	x2, #0x0                   	// #0
     c2c:	f9400be1 	ldr	x1, [sp, #16]
     c30:	f9400fe0 	ldr	x0, [sp, #24]
     c34:	97fffe6b 	bl	5e0 <gettoken>
    cmd = parseredirs(cmd, ps, es);
     c38:	f9400be2 	ldr	x2, [sp, #16]
     c3c:	f9400fe1 	ldr	x1, [sp, #24]
     c40:	f94017e0 	ldr	x0, [sp, #40]
     c44:	97ffff8a 	bl	a6c <parseredirs>
     c48:	f90017e0 	str	x0, [sp, #40]
    return cmd;
     c4c:	f94017e0 	ldr	x0, [sp, #40]
}
     c50:	a8c37bfd 	ldp	x29, x30, [sp], #48
     c54:	d65f03c0 	ret

0000000000000c58 <parseexec>:

struct cmd*
parseexec(char **ps, char *es)
{
     c58:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
     c5c:	910003fd 	mov	x29, sp
     c60:	f9000fe0 	str	x0, [sp, #24]
     c64:	f9000be1 	str	x1, [sp, #16]
    char *q, *eq;
    int tok, argc;
    struct execcmd *cmd;
    struct cmd *ret;
    
    if(peek(ps, es, "("))
     c68:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     c6c:	9138c002 	add	x2, x0, #0xe30
     c70:	f9400be1 	ldr	x1, [sp, #16]
     c74:	f9400fe0 	ldr	x0, [sp, #24]
     c78:	97fffedf 	bl	7f4 <peek>
     c7c:	7100001f 	cmp	w0, #0x0
     c80:	540000a0 	b.eq	c94 <parseexec+0x3c>  // b.none
        return parseblock(ps, es);
     c84:	f9400be1 	ldr	x1, [sp, #16]
     c88:	f9400fe0 	ldr	x0, [sp, #24]
     c8c:	97ffffc5 	bl	ba0 <parseblock>
     c90:	1400004d 	b	dc4 <parseexec+0x16c>
    
    ret = execcmd();
     c94:	97fffde0 	bl	414 <execcmd>
     c98:	f90023e0 	str	x0, [sp, #64]
    cmd = (struct execcmd*)ret;
     c9c:	f94023e0 	ldr	x0, [sp, #64]
     ca0:	f9001fe0 	str	x0, [sp, #56]
    
    argc = 0;
     ca4:	b9004fff 	str	wzr, [sp, #76]
    ret = parseredirs(ret, ps, es);
     ca8:	f9400be2 	ldr	x2, [sp, #16]
     cac:	f9400fe1 	ldr	x1, [sp, #24]
     cb0:	f94023e0 	ldr	x0, [sp, #64]
     cb4:	97ffff6e 	bl	a6c <parseredirs>
     cb8:	f90023e0 	str	x0, [sp, #64]
    while(!peek(ps, es, "|)&;")){
     cbc:	1400002d 	b	d70 <parseexec+0x118>
        if((tok=gettoken(ps, es, &q, &eq)) == 0)
     cc0:	910083e1 	add	x1, sp, #0x20
     cc4:	9100a3e0 	add	x0, sp, #0x28
     cc8:	aa0103e3 	mov	x3, x1
     ccc:	aa0003e2 	mov	x2, x0
     cd0:	f9400be1 	ldr	x1, [sp, #16]
     cd4:	f9400fe0 	ldr	x0, [sp, #24]
     cd8:	97fffe42 	bl	5e0 <gettoken>
     cdc:	b90037e0 	str	w0, [sp, #52]
     ce0:	b94037e0 	ldr	w0, [sp, #52]
     ce4:	7100001f 	cmp	w0, #0x0
     ce8:	54000540 	b.eq	d90 <parseexec+0x138>  // b.none
            break;
        if(tok != 'a')
     cec:	b94037e0 	ldr	w0, [sp, #52]
     cf0:	7101841f 	cmp	w0, #0x61
     cf4:	54000080 	b.eq	d04 <parseexec+0xac>  // b.none
            panic("syntax");
     cf8:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     cfc:	9137a000 	add	x0, x0, #0xde8
     d00:	97fffdaf 	bl	3bc <panic>
        cmd->argv[argc] = q;
     d04:	f94017e1 	ldr	x1, [sp, #40]
     d08:	f9401fe2 	ldr	x2, [sp, #56]
     d0c:	b9804fe0 	ldrsw	x0, [sp, #76]
     d10:	d37df000 	lsl	x0, x0, #3
     d14:	8b000040 	add	x0, x2, x0
     d18:	f9000401 	str	x1, [x0, #8]
        cmd->eargv[argc] = eq;
     d1c:	f94013e1 	ldr	x1, [sp, #32]
     d20:	f9401fe2 	ldr	x2, [sp, #56]
     d24:	b9804fe0 	ldrsw	x0, [sp, #76]
     d28:	91002800 	add	x0, x0, #0xa
     d2c:	d37df000 	lsl	x0, x0, #3
     d30:	8b000040 	add	x0, x2, x0
     d34:	f9000401 	str	x1, [x0, #8]
        argc++;
     d38:	b9404fe0 	ldr	w0, [sp, #76]
     d3c:	11000400 	add	w0, w0, #0x1
     d40:	b9004fe0 	str	w0, [sp, #76]
        if(argc >= MAXARGS)
     d44:	b9404fe0 	ldr	w0, [sp, #76]
     d48:	7100241f 	cmp	w0, #0x9
     d4c:	5400008d 	b.le	d5c <parseexec+0x104>
            panic("too many args");
     d50:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     d54:	9139a000 	add	x0, x0, #0xe68
     d58:	97fffd99 	bl	3bc <panic>
        ret = parseredirs(ret, ps, es);
     d5c:	f9400be2 	ldr	x2, [sp, #16]
     d60:	f9400fe1 	ldr	x1, [sp, #24]
     d64:	f94023e0 	ldr	x0, [sp, #64]
     d68:	97ffff41 	bl	a6c <parseredirs>
     d6c:	f90023e0 	str	x0, [sp, #64]
    while(!peek(ps, es, "|)&;")){
     d70:	b0000000 	adrp	x0, 1000 <strlen+0x20>
     d74:	9139e002 	add	x2, x0, #0xe78
     d78:	f9400be1 	ldr	x1, [sp, #16]
     d7c:	f9400fe0 	ldr	x0, [sp, #24]
     d80:	97fffe9d 	bl	7f4 <peek>
     d84:	7100001f 	cmp	w0, #0x0
     d88:	54fff9c0 	b.eq	cc0 <parseexec+0x68>  // b.none
     d8c:	14000002 	b	d94 <parseexec+0x13c>
            break;
     d90:	d503201f 	nop
    }
    cmd->argv[argc] = 0;
     d94:	f9401fe1 	ldr	x1, [sp, #56]
     d98:	b9804fe0 	ldrsw	x0, [sp, #76]
     d9c:	d37df000 	lsl	x0, x0, #3
     da0:	8b000020 	add	x0, x1, x0
     da4:	f900041f 	str	xzr, [x0, #8]
    cmd->eargv[argc] = 0;
     da8:	f9401fe1 	ldr	x1, [sp, #56]
     dac:	b9804fe0 	ldrsw	x0, [sp, #76]
     db0:	91002800 	add	x0, x0, #0xa
     db4:	d37df000 	lsl	x0, x0, #3
     db8:	8b000020 	add	x0, x1, x0
     dbc:	f900041f 	str	xzr, [x0, #8]
    return ret;
     dc0:	f94023e0 	ldr	x0, [sp, #64]
}
     dc4:	a8c57bfd 	ldp	x29, x30, [sp], #80
     dc8:	d65f03c0 	ret

0000000000000dcc <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     dcc:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
     dd0:	910003fd 	mov	x29, sp
     dd4:	f9000fe0 	str	x0, [sp, #24]
    struct execcmd *ecmd;
    struct listcmd *lcmd;
    struct pipecmd *pcmd;
    struct redircmd *rcmd;
    
    if(cmd == 0)
     dd8:	f9400fe0 	ldr	x0, [sp, #24]
     ddc:	f100001f 	cmp	x0, #0x0
     de0:	54000061 	b.ne	dec <nulterminate+0x20>  // b.any
        return 0;
     de4:	d2800000 	mov	x0, #0x0                   	// #0
     de8:	1400004c 	b	f18 <nulterminate+0x14c>
    
    switch(cmd->type){
     dec:	f9400fe0 	ldr	x0, [sp, #24]
     df0:	b9400000 	ldr	w0, [x0]
     df4:	7100141f 	cmp	w0, #0x5
     df8:	54000820 	b.eq	efc <nulterminate+0x130>  // b.none
     dfc:	7100141f 	cmp	w0, #0x5
     e00:	540008ac 	b.gt	f14 <nulterminate+0x148>
     e04:	7100101f 	cmp	w0, #0x4
     e08:	54000680 	b.eq	ed8 <nulterminate+0x10c>  // b.none
     e0c:	7100101f 	cmp	w0, #0x4
     e10:	5400082c 	b.gt	f14 <nulterminate+0x148>
     e14:	71000c1f 	cmp	w0, #0x3
     e18:	540004e0 	b.eq	eb4 <nulterminate+0xe8>  // b.none
     e1c:	71000c1f 	cmp	w0, #0x3
     e20:	540007ac 	b.gt	f14 <nulterminate+0x148>
     e24:	7100041f 	cmp	w0, #0x1
     e28:	54000080 	b.eq	e38 <nulterminate+0x6c>  // b.none
     e2c:	7100081f 	cmp	w0, #0x2
     e30:	54000300 	b.eq	e90 <nulterminate+0xc4>  // b.none
     e34:	14000038 	b	f14 <nulterminate+0x148>
        case EXEC:
            ecmd = (struct execcmd*)cmd;
     e38:	f9400fe0 	ldr	x0, [sp, #24]
     e3c:	f90013e0 	str	x0, [sp, #32]
            for(i=0; ecmd->argv[i]; i++)
     e40:	b9004fff 	str	wzr, [sp, #76]
     e44:	1400000b 	b	e70 <nulterminate+0xa4>
                *ecmd->eargv[i] = 0;
     e48:	f94013e1 	ldr	x1, [sp, #32]
     e4c:	b9804fe0 	ldrsw	x0, [sp, #76]
     e50:	91002800 	add	x0, x0, #0xa
     e54:	d37df000 	lsl	x0, x0, #3
     e58:	8b000020 	add	x0, x1, x0
     e5c:	f9400400 	ldr	x0, [x0, #8]
     e60:	3900001f 	strb	wzr, [x0]
            for(i=0; ecmd->argv[i]; i++)
     e64:	b9404fe0 	ldr	w0, [sp, #76]
     e68:	11000400 	add	w0, w0, #0x1
     e6c:	b9004fe0 	str	w0, [sp, #76]
     e70:	f94013e1 	ldr	x1, [sp, #32]
     e74:	b9804fe0 	ldrsw	x0, [sp, #76]
     e78:	d37df000 	lsl	x0, x0, #3
     e7c:	8b000020 	add	x0, x1, x0
     e80:	f9400400 	ldr	x0, [x0, #8]
     e84:	f100001f 	cmp	x0, #0x0
     e88:	54fffe01 	b.ne	e48 <nulterminate+0x7c>  // b.any
            break;
     e8c:	14000022 	b	f14 <nulterminate+0x148>
            
        case REDIR:
            rcmd = (struct redircmd*)cmd;
     e90:	f9400fe0 	ldr	x0, [sp, #24]
     e94:	f90017e0 	str	x0, [sp, #40]
            nulterminate(rcmd->cmd);
     e98:	f94017e0 	ldr	x0, [sp, #40]
     e9c:	f9400400 	ldr	x0, [x0, #8]
     ea0:	97ffffcb 	bl	dcc <nulterminate>
            *rcmd->efile = 0;
     ea4:	f94017e0 	ldr	x0, [sp, #40]
     ea8:	f9400c00 	ldr	x0, [x0, #24]
     eac:	3900001f 	strb	wzr, [x0]
            break;
     eb0:	14000019 	b	f14 <nulterminate+0x148>
            
        case PIPE:
            pcmd = (struct pipecmd*)cmd;
     eb4:	f9400fe0 	ldr	x0, [sp, #24]
     eb8:	f9001be0 	str	x0, [sp, #48]
            nulterminate(pcmd->left);
     ebc:	f9401be0 	ldr	x0, [sp, #48]
     ec0:	f9400400 	ldr	x0, [x0, #8]
     ec4:	97ffffc2 	bl	dcc <nulterminate>
            nulterminate(pcmd->right);
     ec8:	f9401be0 	ldr	x0, [sp, #48]
     ecc:	f9400800 	ldr	x0, [x0, #16]
     ed0:	97ffffbf 	bl	dcc <nulterminate>
            break;
     ed4:	14000010 	b	f14 <nulterminate+0x148>
            
        case LIST:
            lcmd = (struct listcmd*)cmd;
     ed8:	f9400fe0 	ldr	x0, [sp, #24]
     edc:	f9001fe0 	str	x0, [sp, #56]
            nulterminate(lcmd->left);
     ee0:	f9401fe0 	ldr	x0, [sp, #56]
     ee4:	f9400400 	ldr	x0, [x0, #8]
     ee8:	97ffffb9 	bl	dcc <nulterminate>
            nulterminate(lcmd->right);
     eec:	f9401fe0 	ldr	x0, [sp, #56]
     ef0:	f9400800 	ldr	x0, [x0, #16]
     ef4:	97ffffb6 	bl	dcc <nulterminate>
            break;
     ef8:	14000007 	b	f14 <nulterminate+0x148>
            
        case BACK:
            bcmd = (struct backcmd*)cmd;
     efc:	f9400fe0 	ldr	x0, [sp, #24]
     f00:	f90023e0 	str	x0, [sp, #64]
            nulterminate(bcmd->cmd);
     f04:	f94023e0 	ldr	x0, [sp, #64]
     f08:	f9400400 	ldr	x0, [x0, #8]
     f0c:	97ffffb0 	bl	dcc <nulterminate>
            break;
     f10:	d503201f 	nop
    }
    return cmd;
     f14:	f9400fe0 	ldr	x0, [sp, #24]
}
     f18:	a8c57bfd 	ldp	x29, x30, [sp], #80
     f1c:	d65f03c0 	ret

0000000000000f20 <strcpy>:
#include "fcntl.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
     f20:	d10083ff 	sub	sp, sp, #0x20
     f24:	f90007e0 	str	x0, [sp, #8]
     f28:	f90003e1 	str	x1, [sp]
    char *os;
    
    os = s;
     f2c:	f94007e0 	ldr	x0, [sp, #8]
     f30:	f9000fe0 	str	x0, [sp, #24]
    while((*s++ = *t++) != 0)
     f34:	d503201f 	nop
     f38:	f94003e1 	ldr	x1, [sp]
     f3c:	91000420 	add	x0, x1, #0x1
     f40:	f90003e0 	str	x0, [sp]
     f44:	f94007e0 	ldr	x0, [sp, #8]
     f48:	91000402 	add	x2, x0, #0x1
     f4c:	f90007e2 	str	x2, [sp, #8]
     f50:	39400021 	ldrb	w1, [x1]
     f54:	39000001 	strb	w1, [x0]
     f58:	39400000 	ldrb	w0, [x0]
     f5c:	7100001f 	cmp	w0, #0x0
     f60:	54fffec1 	b.ne	f38 <strcpy+0x18>  // b.any
        ;
    return os;
     f64:	f9400fe0 	ldr	x0, [sp, #24]
}
     f68:	910083ff 	add	sp, sp, #0x20
     f6c:	d65f03c0 	ret

0000000000000f70 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     f70:	d10043ff 	sub	sp, sp, #0x10
     f74:	f90007e0 	str	x0, [sp, #8]
     f78:	f90003e1 	str	x1, [sp]
    while(*p && *p == *q)
     f7c:	14000007 	b	f98 <strcmp+0x28>
        p++, q++;
     f80:	f94007e0 	ldr	x0, [sp, #8]
     f84:	91000400 	add	x0, x0, #0x1
     f88:	f90007e0 	str	x0, [sp, #8]
     f8c:	f94003e0 	ldr	x0, [sp]
     f90:	91000400 	add	x0, x0, #0x1
     f94:	f90003e0 	str	x0, [sp]
    while(*p && *p == *q)
     f98:	f94007e0 	ldr	x0, [sp, #8]
     f9c:	39400000 	ldrb	w0, [x0]
     fa0:	7100001f 	cmp	w0, #0x0
     fa4:	540000e0 	b.eq	fc0 <strcmp+0x50>  // b.none
     fa8:	f94007e0 	ldr	x0, [sp, #8]
     fac:	39400001 	ldrb	w1, [x0]
     fb0:	f94003e0 	ldr	x0, [sp]
     fb4:	39400000 	ldrb	w0, [x0]
     fb8:	6b00003f 	cmp	w1, w0
     fbc:	54fffe20 	b.eq	f80 <strcmp+0x10>  // b.none
    return (uchar)*p - (uchar)*q;
     fc0:	f94007e0 	ldr	x0, [sp, #8]
     fc4:	39400000 	ldrb	w0, [x0]
     fc8:	2a0003e1 	mov	w1, w0
     fcc:	f94003e0 	ldr	x0, [sp]
     fd0:	39400000 	ldrb	w0, [x0]
     fd4:	4b000020 	sub	w0, w1, w0
}
     fd8:	910043ff 	add	sp, sp, #0x10
     fdc:	d65f03c0 	ret

0000000000000fe0 <strlen>:

uint
strlen(char *s)
{
     fe0:	d10083ff 	sub	sp, sp, #0x20
     fe4:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    for(n = 0; s[n]; n++)
     fe8:	b9001fff 	str	wzr, [sp, #28]
     fec:	14000004 	b	ffc <strlen+0x1c>
     ff0:	b9401fe0 	ldr	w0, [sp, #28]
     ff4:	11000400 	add	w0, w0, #0x1
     ff8:	b9001fe0 	str	w0, [sp, #28]
     ffc:	b9801fe0 	ldrsw	x0, [sp, #28]
    1000:	f94007e1 	ldr	x1, [sp, #8]
    1004:	8b000020 	add	x0, x1, x0
    1008:	39400000 	ldrb	w0, [x0]
    100c:	7100001f 	cmp	w0, #0x0
    1010:	54ffff01 	b.ne	ff0 <strlen+0x10>  // b.any
        ;
    return n;
    1014:	b9401fe0 	ldr	w0, [sp, #28]
}
    1018:	910083ff 	add	sp, sp, #0x20
    101c:	d65f03c0 	ret

0000000000001020 <memset>:

void*
memset(void *dst, int v, uint n)
{
    1020:	d100c3ff 	sub	sp, sp, #0x30
    1024:	f90007e0 	str	x0, [sp, #8]
    1028:	b90007e1 	str	w1, [sp, #4]
    102c:	b90003e2 	str	w2, [sp]
	uint8	*p;
	uint8	c;
	uint32	val;
	uint32	*p4;

	p   = dst;
    1030:	f94007e0 	ldr	x0, [sp, #8]
    1034:	f90017e0 	str	x0, [sp, #40]
	c   = v & 0xff;
    1038:	b94007e0 	ldr	w0, [sp, #4]
    103c:	39007fe0 	strb	w0, [sp, #31]
	val = (c << 24) | (c << 16) | (c << 8) | c;
    1040:	39407fe1 	ldrb	w1, [sp, #31]
    1044:	2a0103e0 	mov	w0, w1
    1048:	53185c00 	lsl	w0, w0, #8
    104c:	0b010000 	add	w0, w0, w1
    1050:	53103c00 	lsl	w0, w0, #16
    1054:	2a0003e1 	mov	w1, w0
    1058:	39407fe0 	ldrb	w0, [sp, #31]
    105c:	53185c00 	lsl	w0, w0, #8
    1060:	2a000021 	orr	w1, w1, w0
    1064:	39407fe0 	ldrb	w0, [sp, #31]
    1068:	2a000020 	orr	w0, w1, w0
    106c:	b9001be0 	str	w0, [sp, #24]

	// set bytes before whole uint32
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
    1070:	1400000a 	b	1098 <memset+0x78>
		*p = c;
    1074:	f94017e0 	ldr	x0, [sp, #40]
    1078:	39407fe1 	ldrb	w1, [sp, #31]
    107c:	39000001 	strb	w1, [x0]
	for (; (n > 0) && ((uint64)p % 4); n--, p++){
    1080:	b94003e0 	ldr	w0, [sp]
    1084:	51000400 	sub	w0, w0, #0x1
    1088:	b90003e0 	str	w0, [sp]
    108c:	f94017e0 	ldr	x0, [sp, #40]
    1090:	91000400 	add	x0, x0, #0x1
    1094:	f90017e0 	str	x0, [sp, #40]
    1098:	b94003e0 	ldr	w0, [sp]
    109c:	7100001f 	cmp	w0, #0x0
    10a0:	540000a0 	b.eq	10b4 <memset+0x94>  // b.none
    10a4:	f94017e0 	ldr	x0, [sp, #40]
    10a8:	92400400 	and	x0, x0, #0x3
    10ac:	f100001f 	cmp	x0, #0x0
    10b0:	54fffe21 	b.ne	1074 <memset+0x54>  // b.any
	}

	// set memory 4 bytes a time
	p4 = (uint*)p;
    10b4:	f94017e0 	ldr	x0, [sp, #40]
    10b8:	f90013e0 	str	x0, [sp, #32]

	for (; n >= 4; n -= 4, p4++) {
    10bc:	1400000a 	b	10e4 <memset+0xc4>
		*p4 = val;
    10c0:	f94013e0 	ldr	x0, [sp, #32]
    10c4:	b9401be1 	ldr	w1, [sp, #24]
    10c8:	b9000001 	str	w1, [x0]
	for (; n >= 4; n -= 4, p4++) {
    10cc:	b94003e0 	ldr	w0, [sp]
    10d0:	51001000 	sub	w0, w0, #0x4
    10d4:	b90003e0 	str	w0, [sp]
    10d8:	f94013e0 	ldr	x0, [sp, #32]
    10dc:	91001000 	add	x0, x0, #0x4
    10e0:	f90013e0 	str	x0, [sp, #32]
    10e4:	b94003e0 	ldr	w0, [sp]
    10e8:	71000c1f 	cmp	w0, #0x3
    10ec:	54fffea8 	b.hi	10c0 <memset+0xa0>  // b.pmore
	}

	// set leftover one byte a time
	p = (uint8*)p4;
    10f0:	f94013e0 	ldr	x0, [sp, #32]
    10f4:	f90017e0 	str	x0, [sp, #40]

	for (; n > 0; n--, p++) {
    10f8:	1400000a 	b	1120 <memset+0x100>
		*p = c;
    10fc:	f94017e0 	ldr	x0, [sp, #40]
    1100:	39407fe1 	ldrb	w1, [sp, #31]
    1104:	39000001 	strb	w1, [x0]
	for (; n > 0; n--, p++) {
    1108:	b94003e0 	ldr	w0, [sp]
    110c:	51000400 	sub	w0, w0, #0x1
    1110:	b90003e0 	str	w0, [sp]
    1114:	f94017e0 	ldr	x0, [sp, #40]
    1118:	91000400 	add	x0, x0, #0x1
    111c:	f90017e0 	str	x0, [sp, #40]
    1120:	b94003e0 	ldr	w0, [sp]
    1124:	7100001f 	cmp	w0, #0x0
    1128:	54fffea1 	b.ne	10fc <memset+0xdc>  // b.any
	}

	return dst;
    112c:	f94007e0 	ldr	x0, [sp, #8]
}
    1130:	9100c3ff 	add	sp, sp, #0x30
    1134:	d65f03c0 	ret

0000000000001138 <strchr>:

char*
strchr(const char *s, char c)
{
    1138:	d10043ff 	sub	sp, sp, #0x10
    113c:	f90007e0 	str	x0, [sp, #8]
    1140:	39001fe1 	strb	w1, [sp, #7]
    for(; *s; s++)
    1144:	1400000b 	b	1170 <strchr+0x38>
        if(*s == c)
    1148:	f94007e0 	ldr	x0, [sp, #8]
    114c:	39400000 	ldrb	w0, [x0]
    1150:	39401fe1 	ldrb	w1, [sp, #7]
    1154:	6b00003f 	cmp	w1, w0
    1158:	54000061 	b.ne	1164 <strchr+0x2c>  // b.any
            return (char*)s;
    115c:	f94007e0 	ldr	x0, [sp, #8]
    1160:	14000009 	b	1184 <strchr+0x4c>
    for(; *s; s++)
    1164:	f94007e0 	ldr	x0, [sp, #8]
    1168:	91000400 	add	x0, x0, #0x1
    116c:	f90007e0 	str	x0, [sp, #8]
    1170:	f94007e0 	ldr	x0, [sp, #8]
    1174:	39400000 	ldrb	w0, [x0]
    1178:	7100001f 	cmp	w0, #0x0
    117c:	54fffe61 	b.ne	1148 <strchr+0x10>  // b.any
    return 0;
    1180:	d2800000 	mov	x0, #0x0                   	// #0
}
    1184:	910043ff 	add	sp, sp, #0x10
    1188:	d65f03c0 	ret

000000000000118c <gets>:

char*
gets(char *buf, int max)
{
    118c:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
    1190:	910003fd 	mov	x29, sp
    1194:	f9000fe0 	str	x0, [sp, #24]
    1198:	b90017e1 	str	w1, [sp, #20]
    int i, cc;
    char c;
    
    for(i=0; i+1 < max; ){
    119c:	b9002fff 	str	wzr, [sp, #44]
    11a0:	14000018 	b	1200 <gets+0x74>
        cc = read(0, &c, 1);
    11a4:	91009fe0 	add	x0, sp, #0x27
    11a8:	52800022 	mov	w2, #0x1                   	// #1
    11ac:	aa0003e1 	mov	x1, x0
    11b0:	52800000 	mov	w0, #0x0                   	// #0
    11b4:	94000090 	bl	13f4 <read>
    11b8:	b9002be0 	str	w0, [sp, #40]
        if(cc < 1)
    11bc:	b9402be0 	ldr	w0, [sp, #40]
    11c0:	7100001f 	cmp	w0, #0x0
    11c4:	540002ad 	b.le	1218 <gets+0x8c>
            break;
        buf[i++] = c;
    11c8:	b9402fe0 	ldr	w0, [sp, #44]
    11cc:	11000401 	add	w1, w0, #0x1
    11d0:	b9002fe1 	str	w1, [sp, #44]
    11d4:	93407c00 	sxtw	x0, w0
    11d8:	f9400fe1 	ldr	x1, [sp, #24]
    11dc:	8b000020 	add	x0, x1, x0
    11e0:	39409fe1 	ldrb	w1, [sp, #39]
    11e4:	39000001 	strb	w1, [x0]
        if(c == '\n' || c == '\r')
    11e8:	39409fe0 	ldrb	w0, [sp, #39]
    11ec:	7100281f 	cmp	w0, #0xa
    11f0:	54000160 	b.eq	121c <gets+0x90>  // b.none
    11f4:	39409fe0 	ldrb	w0, [sp, #39]
    11f8:	7100341f 	cmp	w0, #0xd
    11fc:	54000100 	b.eq	121c <gets+0x90>  // b.none
    for(i=0; i+1 < max; ){
    1200:	b9402fe0 	ldr	w0, [sp, #44]
    1204:	11000400 	add	w0, w0, #0x1
    1208:	b94017e1 	ldr	w1, [sp, #20]
    120c:	6b00003f 	cmp	w1, w0
    1210:	54fffcac 	b.gt	11a4 <gets+0x18>
    1214:	14000002 	b	121c <gets+0x90>
            break;
    1218:	d503201f 	nop
            break;
    }
    buf[i] = '\0';
    121c:	b9802fe0 	ldrsw	x0, [sp, #44]
    1220:	f9400fe1 	ldr	x1, [sp, #24]
    1224:	8b000020 	add	x0, x1, x0
    1228:	3900001f 	strb	wzr, [x0]
    return buf;
    122c:	f9400fe0 	ldr	x0, [sp, #24]
}
    1230:	a8c37bfd 	ldp	x29, x30, [sp], #48
    1234:	d65f03c0 	ret

0000000000001238 <stat>:

int
stat(char *n, struct stat *st)
{
    1238:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
    123c:	910003fd 	mov	x29, sp
    1240:	f9000fe0 	str	x0, [sp, #24]
    1244:	f9000be1 	str	x1, [sp, #16]
    int fd;
    int r;
    
    fd = open(n, O_RDONLY);
    1248:	52800001 	mov	w1, #0x0                   	// #0
    124c:	f9400fe0 	ldr	x0, [sp, #24]
    1250:	94000096 	bl	14a8 <open>
    1254:	b9002fe0 	str	w0, [sp, #44]
    if(fd < 0)
    1258:	b9402fe0 	ldr	w0, [sp, #44]
    125c:	7100001f 	cmp	w0, #0x0
    1260:	5400006a 	b.ge	126c <stat+0x34>  // b.tcont
        return -1;
    1264:	12800000 	mov	w0, #0xffffffff            	// #-1
    1268:	14000008 	b	1288 <stat+0x50>
    r = fstat(fd, st);
    126c:	f9400be1 	ldr	x1, [sp, #16]
    1270:	b9402fe0 	ldr	w0, [sp, #44]
    1274:	940000a8 	bl	1514 <fstat>
    1278:	b9002be0 	str	w0, [sp, #40]
    close(fd);
    127c:	b9402fe0 	ldr	w0, [sp, #44]
    1280:	9400006f 	bl	143c <close>
    return r;
    1284:	b9402be0 	ldr	w0, [sp, #40]
}
    1288:	a8c37bfd 	ldp	x29, x30, [sp], #48
    128c:	d65f03c0 	ret

0000000000001290 <atoi>:

int
atoi(const char *s)
{
    1290:	d10083ff 	sub	sp, sp, #0x20
    1294:	f90007e0 	str	x0, [sp, #8]
    int n;
    
    n = 0;
    1298:	b9001fff 	str	wzr, [sp, #28]
    while('0' <= *s && *s <= '9')
    129c:	1400000e 	b	12d4 <atoi+0x44>
        n = n*10 + *s++ - '0';
    12a0:	b9401fe1 	ldr	w1, [sp, #28]
    12a4:	2a0103e0 	mov	w0, w1
    12a8:	531e7400 	lsl	w0, w0, #2
    12ac:	0b010000 	add	w0, w0, w1
    12b0:	531f7800 	lsl	w0, w0, #1
    12b4:	2a0003e2 	mov	w2, w0
    12b8:	f94007e0 	ldr	x0, [sp, #8]
    12bc:	91000401 	add	x1, x0, #0x1
    12c0:	f90007e1 	str	x1, [sp, #8]
    12c4:	39400000 	ldrb	w0, [x0]
    12c8:	0b000040 	add	w0, w2, w0
    12cc:	5100c000 	sub	w0, w0, #0x30
    12d0:	b9001fe0 	str	w0, [sp, #28]
    while('0' <= *s && *s <= '9')
    12d4:	f94007e0 	ldr	x0, [sp, #8]
    12d8:	39400000 	ldrb	w0, [x0]
    12dc:	7100bc1f 	cmp	w0, #0x2f
    12e0:	540000a9 	b.ls	12f4 <atoi+0x64>  // b.plast
    12e4:	f94007e0 	ldr	x0, [sp, #8]
    12e8:	39400000 	ldrb	w0, [x0]
    12ec:	7100e41f 	cmp	w0, #0x39
    12f0:	54fffd89 	b.ls	12a0 <atoi+0x10>  // b.plast
    return n;
    12f4:	b9401fe0 	ldr	w0, [sp, #28]
}
    12f8:	910083ff 	add	sp, sp, #0x20
    12fc:	d65f03c0 	ret

0000000000001300 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    1300:	d100c3ff 	sub	sp, sp, #0x30
    1304:	f9000fe0 	str	x0, [sp, #24]
    1308:	f9000be1 	str	x1, [sp, #16]
    130c:	b9000fe2 	str	w2, [sp, #12]
    char *dst, *src;
    
    dst = vdst;
    1310:	f9400fe0 	ldr	x0, [sp, #24]
    1314:	f90017e0 	str	x0, [sp, #40]
    src = vsrc;
    1318:	f9400be0 	ldr	x0, [sp, #16]
    131c:	f90013e0 	str	x0, [sp, #32]
    while(n-- > 0)
    1320:	14000009 	b	1344 <memmove+0x44>
        *dst++ = *src++;
    1324:	f94013e1 	ldr	x1, [sp, #32]
    1328:	91000420 	add	x0, x1, #0x1
    132c:	f90013e0 	str	x0, [sp, #32]
    1330:	f94017e0 	ldr	x0, [sp, #40]
    1334:	91000402 	add	x2, x0, #0x1
    1338:	f90017e2 	str	x2, [sp, #40]
    133c:	39400021 	ldrb	w1, [x1]
    1340:	39000001 	strb	w1, [x0]
    while(n-- > 0)
    1344:	b9400fe0 	ldr	w0, [sp, #12]
    1348:	51000401 	sub	w1, w0, #0x1
    134c:	b9000fe1 	str	w1, [sp, #12]
    1350:	7100001f 	cmp	w0, #0x0
    1354:	54fffe8c 	b.gt	1324 <memmove+0x24>
    return vdst;
    1358:	f9400fe0 	ldr	x0, [sp, #24]
}
    135c:	9100c3ff 	add	sp, sp, #0x30
    1360:	d65f03c0 	ret

0000000000001364 <fork>:
    1364:	f81f8fe4 	str	x4, [sp, #-8]!
    1368:	aa0303e4 	mov	x4, x3
    136c:	aa0203e3 	mov	x3, x2
    1370:	aa0103e2 	mov	x2, x1
    1374:	aa0003e1 	mov	x1, x0
    1378:	d2800020 	mov	x0, #0x1                   	// #1
    137c:	d4000001 	svc	#0x0
    1380:	f84087e4 	ldr	x4, [sp], #8
    1384:	d61f03c0 	br	x30

0000000000001388 <exit>:
    1388:	f81f8fe4 	str	x4, [sp, #-8]!
    138c:	aa0303e4 	mov	x4, x3
    1390:	aa0203e3 	mov	x3, x2
    1394:	aa0103e2 	mov	x2, x1
    1398:	aa0003e1 	mov	x1, x0
    139c:	d2800040 	mov	x0, #0x2                   	// #2
    13a0:	d4000001 	svc	#0x0
    13a4:	f84087e4 	ldr	x4, [sp], #8
    13a8:	d61f03c0 	br	x30

00000000000013ac <wait>:
    13ac:	f81f8fe4 	str	x4, [sp, #-8]!
    13b0:	aa0303e4 	mov	x4, x3
    13b4:	aa0203e3 	mov	x3, x2
    13b8:	aa0103e2 	mov	x2, x1
    13bc:	aa0003e1 	mov	x1, x0
    13c0:	d2800060 	mov	x0, #0x3                   	// #3
    13c4:	d4000001 	svc	#0x0
    13c8:	f84087e4 	ldr	x4, [sp], #8
    13cc:	d61f03c0 	br	x30

00000000000013d0 <pipe>:
    13d0:	f81f8fe4 	str	x4, [sp, #-8]!
    13d4:	aa0303e4 	mov	x4, x3
    13d8:	aa0203e3 	mov	x3, x2
    13dc:	aa0103e2 	mov	x2, x1
    13e0:	aa0003e1 	mov	x1, x0
    13e4:	d2800080 	mov	x0, #0x4                   	// #4
    13e8:	d4000001 	svc	#0x0
    13ec:	f84087e4 	ldr	x4, [sp], #8
    13f0:	d61f03c0 	br	x30

00000000000013f4 <read>:
    13f4:	f81f8fe4 	str	x4, [sp, #-8]!
    13f8:	aa0303e4 	mov	x4, x3
    13fc:	aa0203e3 	mov	x3, x2
    1400:	aa0103e2 	mov	x2, x1
    1404:	aa0003e1 	mov	x1, x0
    1408:	d28000a0 	mov	x0, #0x5                   	// #5
    140c:	d4000001 	svc	#0x0
    1410:	f84087e4 	ldr	x4, [sp], #8
    1414:	d61f03c0 	br	x30

0000000000001418 <write>:
    1418:	f81f8fe4 	str	x4, [sp, #-8]!
    141c:	aa0303e4 	mov	x4, x3
    1420:	aa0203e3 	mov	x3, x2
    1424:	aa0103e2 	mov	x2, x1
    1428:	aa0003e1 	mov	x1, x0
    142c:	d2800200 	mov	x0, #0x10                  	// #16
    1430:	d4000001 	svc	#0x0
    1434:	f84087e4 	ldr	x4, [sp], #8
    1438:	d61f03c0 	br	x30

000000000000143c <close>:
    143c:	f81f8fe4 	str	x4, [sp, #-8]!
    1440:	aa0303e4 	mov	x4, x3
    1444:	aa0203e3 	mov	x3, x2
    1448:	aa0103e2 	mov	x2, x1
    144c:	aa0003e1 	mov	x1, x0
    1450:	d28002a0 	mov	x0, #0x15                  	// #21
    1454:	d4000001 	svc	#0x0
    1458:	f84087e4 	ldr	x4, [sp], #8
    145c:	d61f03c0 	br	x30

0000000000001460 <kill>:
    1460:	f81f8fe4 	str	x4, [sp, #-8]!
    1464:	aa0303e4 	mov	x4, x3
    1468:	aa0203e3 	mov	x3, x2
    146c:	aa0103e2 	mov	x2, x1
    1470:	aa0003e1 	mov	x1, x0
    1474:	d28000c0 	mov	x0, #0x6                   	// #6
    1478:	d4000001 	svc	#0x0
    147c:	f84087e4 	ldr	x4, [sp], #8
    1480:	d61f03c0 	br	x30

0000000000001484 <exec>:
    1484:	f81f8fe4 	str	x4, [sp, #-8]!
    1488:	aa0303e4 	mov	x4, x3
    148c:	aa0203e3 	mov	x3, x2
    1490:	aa0103e2 	mov	x2, x1
    1494:	aa0003e1 	mov	x1, x0
    1498:	d28000e0 	mov	x0, #0x7                   	// #7
    149c:	d4000001 	svc	#0x0
    14a0:	f84087e4 	ldr	x4, [sp], #8
    14a4:	d61f03c0 	br	x30

00000000000014a8 <open>:
    14a8:	f81f8fe4 	str	x4, [sp, #-8]!
    14ac:	aa0303e4 	mov	x4, x3
    14b0:	aa0203e3 	mov	x3, x2
    14b4:	aa0103e2 	mov	x2, x1
    14b8:	aa0003e1 	mov	x1, x0
    14bc:	d28001e0 	mov	x0, #0xf                   	// #15
    14c0:	d4000001 	svc	#0x0
    14c4:	f84087e4 	ldr	x4, [sp], #8
    14c8:	d61f03c0 	br	x30

00000000000014cc <mknod>:
    14cc:	f81f8fe4 	str	x4, [sp, #-8]!
    14d0:	aa0303e4 	mov	x4, x3
    14d4:	aa0203e3 	mov	x3, x2
    14d8:	aa0103e2 	mov	x2, x1
    14dc:	aa0003e1 	mov	x1, x0
    14e0:	d2800220 	mov	x0, #0x11                  	// #17
    14e4:	d4000001 	svc	#0x0
    14e8:	f84087e4 	ldr	x4, [sp], #8
    14ec:	d61f03c0 	br	x30

00000000000014f0 <unlink>:
    14f0:	f81f8fe4 	str	x4, [sp, #-8]!
    14f4:	aa0303e4 	mov	x4, x3
    14f8:	aa0203e3 	mov	x3, x2
    14fc:	aa0103e2 	mov	x2, x1
    1500:	aa0003e1 	mov	x1, x0
    1504:	d2800240 	mov	x0, #0x12                  	// #18
    1508:	d4000001 	svc	#0x0
    150c:	f84087e4 	ldr	x4, [sp], #8
    1510:	d61f03c0 	br	x30

0000000000001514 <fstat>:
    1514:	f81f8fe4 	str	x4, [sp, #-8]!
    1518:	aa0303e4 	mov	x4, x3
    151c:	aa0203e3 	mov	x3, x2
    1520:	aa0103e2 	mov	x2, x1
    1524:	aa0003e1 	mov	x1, x0
    1528:	d2800100 	mov	x0, #0x8                   	// #8
    152c:	d4000001 	svc	#0x0
    1530:	f84087e4 	ldr	x4, [sp], #8
    1534:	d61f03c0 	br	x30

0000000000001538 <link>:
    1538:	f81f8fe4 	str	x4, [sp, #-8]!
    153c:	aa0303e4 	mov	x4, x3
    1540:	aa0203e3 	mov	x3, x2
    1544:	aa0103e2 	mov	x2, x1
    1548:	aa0003e1 	mov	x1, x0
    154c:	d2800260 	mov	x0, #0x13                  	// #19
    1550:	d4000001 	svc	#0x0
    1554:	f84087e4 	ldr	x4, [sp], #8
    1558:	d61f03c0 	br	x30

000000000000155c <mkdir>:
    155c:	f81f8fe4 	str	x4, [sp, #-8]!
    1560:	aa0303e4 	mov	x4, x3
    1564:	aa0203e3 	mov	x3, x2
    1568:	aa0103e2 	mov	x2, x1
    156c:	aa0003e1 	mov	x1, x0
    1570:	d2800280 	mov	x0, #0x14                  	// #20
    1574:	d4000001 	svc	#0x0
    1578:	f84087e4 	ldr	x4, [sp], #8
    157c:	d61f03c0 	br	x30

0000000000001580 <chdir>:
    1580:	f81f8fe4 	str	x4, [sp, #-8]!
    1584:	aa0303e4 	mov	x4, x3
    1588:	aa0203e3 	mov	x3, x2
    158c:	aa0103e2 	mov	x2, x1
    1590:	aa0003e1 	mov	x1, x0
    1594:	d2800120 	mov	x0, #0x9                   	// #9
    1598:	d4000001 	svc	#0x0
    159c:	f84087e4 	ldr	x4, [sp], #8
    15a0:	d61f03c0 	br	x30

00000000000015a4 <dup>:
    15a4:	f81f8fe4 	str	x4, [sp, #-8]!
    15a8:	aa0303e4 	mov	x4, x3
    15ac:	aa0203e3 	mov	x3, x2
    15b0:	aa0103e2 	mov	x2, x1
    15b4:	aa0003e1 	mov	x1, x0
    15b8:	d2800140 	mov	x0, #0xa                   	// #10
    15bc:	d4000001 	svc	#0x0
    15c0:	f84087e4 	ldr	x4, [sp], #8
    15c4:	d61f03c0 	br	x30

00000000000015c8 <getpid>:
    15c8:	f81f8fe4 	str	x4, [sp, #-8]!
    15cc:	aa0303e4 	mov	x4, x3
    15d0:	aa0203e3 	mov	x3, x2
    15d4:	aa0103e2 	mov	x2, x1
    15d8:	aa0003e1 	mov	x1, x0
    15dc:	d2800160 	mov	x0, #0xb                   	// #11
    15e0:	d4000001 	svc	#0x0
    15e4:	f84087e4 	ldr	x4, [sp], #8
    15e8:	d61f03c0 	br	x30

00000000000015ec <sbrk>:
    15ec:	f81f8fe4 	str	x4, [sp, #-8]!
    15f0:	aa0303e4 	mov	x4, x3
    15f4:	aa0203e3 	mov	x3, x2
    15f8:	aa0103e2 	mov	x2, x1
    15fc:	aa0003e1 	mov	x1, x0
    1600:	d2800180 	mov	x0, #0xc                   	// #12
    1604:	d4000001 	svc	#0x0
    1608:	f84087e4 	ldr	x4, [sp], #8
    160c:	d61f03c0 	br	x30

0000000000001610 <sleep>:
    1610:	f81f8fe4 	str	x4, [sp, #-8]!
    1614:	aa0303e4 	mov	x4, x3
    1618:	aa0203e3 	mov	x3, x2
    161c:	aa0103e2 	mov	x2, x1
    1620:	aa0003e1 	mov	x1, x0
    1624:	d28001a0 	mov	x0, #0xd                   	// #13
    1628:	d4000001 	svc	#0x0
    162c:	f84087e4 	ldr	x4, [sp], #8
    1630:	d61f03c0 	br	x30

0000000000001634 <uptime>:
    1634:	f81f8fe4 	str	x4, [sp, #-8]!
    1638:	aa0303e4 	mov	x4, x3
    163c:	aa0203e3 	mov	x3, x2
    1640:	aa0103e2 	mov	x2, x1
    1644:	aa0003e1 	mov	x1, x0
    1648:	d28001c0 	mov	x0, #0xe                   	// #14
    164c:	d4000001 	svc	#0x0
    1650:	f84087e4 	ldr	x4, [sp], #8
    1654:	d61f03c0 	br	x30

0000000000001658 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    1658:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    165c:	910003fd 	mov	x29, sp
    1660:	b9001fe0 	str	w0, [sp, #28]
    1664:	39006fe1 	strb	w1, [sp, #27]
    write(fd, &c, 1);
    1668:	91006fe0 	add	x0, sp, #0x1b
    166c:	52800022 	mov	w2, #0x1                   	// #1
    1670:	aa0003e1 	mov	x1, x0
    1674:	b9401fe0 	ldr	w0, [sp, #28]
    1678:	97ffff68 	bl	1418 <write>
}
    167c:	d503201f 	nop
    1680:	a8c27bfd 	ldp	x29, x30, [sp], #32
    1684:	d65f03c0 	ret

0000000000001688 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    1688:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
    168c:	910003fd 	mov	x29, sp
    1690:	b9001fe0 	str	w0, [sp, #28]
    1694:	b9001be1 	str	w1, [sp, #24]
    1698:	b90017e2 	str	w2, [sp, #20]
    169c:	b90013e3 	str	w3, [sp, #16]
    static char digits[] = "0123456789ABCDEF";
    char buf[16];
    int i, neg;
    uint x;
    
    neg = 0;
    16a0:	b9003bff 	str	wzr, [sp, #56]
    if(sgn && xx < 0){
    16a4:	b94013e0 	ldr	w0, [sp, #16]
    16a8:	7100001f 	cmp	w0, #0x0
    16ac:	54000140 	b.eq	16d4 <printint+0x4c>  // b.none
    16b0:	b9401be0 	ldr	w0, [sp, #24]
    16b4:	7100001f 	cmp	w0, #0x0
    16b8:	540000ea 	b.ge	16d4 <printint+0x4c>  // b.tcont
        neg = 1;
    16bc:	52800020 	mov	w0, #0x1                   	// #1
    16c0:	b9003be0 	str	w0, [sp, #56]
        x = -xx;
    16c4:	b9401be0 	ldr	w0, [sp, #24]
    16c8:	4b0003e0 	neg	w0, w0
    16cc:	b90037e0 	str	w0, [sp, #52]
    16d0:	14000003 	b	16dc <printint+0x54>
    } else {
        x = xx;
    16d4:	b9401be0 	ldr	w0, [sp, #24]
    16d8:	b90037e0 	str	w0, [sp, #52]
    }
    
    i = 0;
    16dc:	b9003fff 	str	wzr, [sp, #60]
    do{
        buf[i++] = digits[x % base];
    16e0:	b94017e1 	ldr	w1, [sp, #20]
    16e4:	b94037e0 	ldr	w0, [sp, #52]
    16e8:	1ac10802 	udiv	w2, w0, w1
    16ec:	1b017c41 	mul	w1, w2, w1
    16f0:	4b010003 	sub	w3, w0, w1
    16f4:	b9403fe0 	ldr	w0, [sp, #60]
    16f8:	11000401 	add	w1, w0, #0x1
    16fc:	b9003fe1 	str	w1, [sp, #60]
    1700:	90000001 	adrp	x1, 1000 <strlen+0x20>
    1704:	913a6022 	add	x2, x1, #0xe98
    1708:	2a0303e1 	mov	w1, w3
    170c:	38616842 	ldrb	w2, [x2, x1]
    1710:	93407c00 	sxtw	x0, w0
    1714:	910083e1 	add	x1, sp, #0x20
    1718:	38206822 	strb	w2, [x1, x0]
    }while((x /= base) != 0);
    171c:	b94017e0 	ldr	w0, [sp, #20]
    1720:	b94037e1 	ldr	w1, [sp, #52]
    1724:	1ac00820 	udiv	w0, w1, w0
    1728:	b90037e0 	str	w0, [sp, #52]
    172c:	b94037e0 	ldr	w0, [sp, #52]
    1730:	7100001f 	cmp	w0, #0x0
    1734:	54fffd61 	b.ne	16e0 <printint+0x58>  // b.any
    if(neg)
    1738:	b9403be0 	ldr	w0, [sp, #56]
    173c:	7100001f 	cmp	w0, #0x0
    1740:	540001e0 	b.eq	177c <printint+0xf4>  // b.none
        buf[i++] = '-';
    1744:	b9403fe0 	ldr	w0, [sp, #60]
    1748:	11000401 	add	w1, w0, #0x1
    174c:	b9003fe1 	str	w1, [sp, #60]
    1750:	93407c00 	sxtw	x0, w0
    1754:	910083e1 	add	x1, sp, #0x20
    1758:	528005a2 	mov	w2, #0x2d                  	// #45
    175c:	38206822 	strb	w2, [x1, x0]
    
    while(--i >= 0)
    1760:	14000007 	b	177c <printint+0xf4>
        putc(fd, buf[i]);
    1764:	b9803fe0 	ldrsw	x0, [sp, #60]
    1768:	910083e1 	add	x1, sp, #0x20
    176c:	38606820 	ldrb	w0, [x1, x0]
    1770:	2a0003e1 	mov	w1, w0
    1774:	b9401fe0 	ldr	w0, [sp, #28]
    1778:	97ffffb8 	bl	1658 <putc>
    while(--i >= 0)
    177c:	b9403fe0 	ldr	w0, [sp, #60]
    1780:	51000400 	sub	w0, w0, #0x1
    1784:	b9003fe0 	str	w0, [sp, #60]
    1788:	b9403fe0 	ldr	w0, [sp, #60]
    178c:	7100001f 	cmp	w0, #0x0
    1790:	54fffeaa 	b.ge	1764 <printint+0xdc>  // b.tcont
}
    1794:	d503201f 	nop
    1798:	d503201f 	nop
    179c:	a8c47bfd 	ldp	x29, x30, [sp], #64
    17a0:	d65f03c0 	ret

00000000000017a4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    17a4:	a9b17bfd 	stp	x29, x30, [sp, #-240]!
    17a8:	910003fd 	mov	x29, sp
    17ac:	b9001fe0 	str	w0, [sp, #28]
    17b0:	f9000be1 	str	x1, [sp, #16]
    17b4:	f90063e2 	str	x2, [sp, #192]
    17b8:	f90067e3 	str	x3, [sp, #200]
    17bc:	f9006be4 	str	x4, [sp, #208]
    17c0:	f9006fe5 	str	x5, [sp, #216]
    17c4:	f90073e6 	str	x6, [sp, #224]
    17c8:	f90077e7 	str	x7, [sp, #232]
    17cc:	3d8013e0 	str	q0, [sp, #64]
    17d0:	3d8017e1 	str	q1, [sp, #80]
    17d4:	3d801be2 	str	q2, [sp, #96]
    17d8:	3d801fe3 	str	q3, [sp, #112]
    17dc:	3d8023e4 	str	q4, [sp, #128]
    17e0:	3d8027e5 	str	q5, [sp, #144]
    17e4:	3d802be6 	str	q6, [sp, #160]
    17e8:	3d802fe7 	str	q7, [sp, #176]
    char *s;
    int c, i, state;
    uint64 *ap;
    
    state = 0;
    17ec:	b90033ff 	str	wzr, [sp, #48]
    ap = (uint64*)(void*)&fmt + 22;
    17f0:	910043e0 	add	x0, sp, #0x10
    17f4:	9102c000 	add	x0, x0, #0xb0
    17f8:	f90017e0 	str	x0, [sp, #40]
    for(i = 0; fmt[i]; i++){
    17fc:	b90037ff 	str	wzr, [sp, #52]
    1800:	14000076 	b	19d8 <printf+0x234>
        c = fmt[i] & 0xff;
    1804:	f9400be1 	ldr	x1, [sp, #16]
    1808:	b98037e0 	ldrsw	x0, [sp, #52]
    180c:	8b000020 	add	x0, x1, x0
    1810:	39400000 	ldrb	w0, [x0]
    1814:	b90027e0 	str	w0, [sp, #36]
        if(state == 0){
    1818:	b94033e0 	ldr	w0, [sp, #48]
    181c:	7100001f 	cmp	w0, #0x0
    1820:	540001a1 	b.ne	1854 <printf+0xb0>  // b.any
            if(c == '%'){
    1824:	b94027e0 	ldr	w0, [sp, #36]
    1828:	7100941f 	cmp	w0, #0x25
    182c:	54000081 	b.ne	183c <printf+0x98>  // b.any
                state = '%';
    1830:	528004a0 	mov	w0, #0x25                  	// #37
    1834:	b90033e0 	str	w0, [sp, #48]
    1838:	14000065 	b	19cc <printf+0x228>
            } else {
                putc(fd, c);
    183c:	b94027e0 	ldr	w0, [sp, #36]
    1840:	12001c00 	and	w0, w0, #0xff
    1844:	2a0003e1 	mov	w1, w0
    1848:	b9401fe0 	ldr	w0, [sp, #28]
    184c:	97ffff83 	bl	1658 <putc>
    1850:	1400005f 	b	19cc <printf+0x228>
            }
        } else if(state == '%'){
    1854:	b94033e0 	ldr	w0, [sp, #48]
    1858:	7100941f 	cmp	w0, #0x25
    185c:	54000b81 	b.ne	19cc <printf+0x228>  // b.any
            if(c == 'd'){
    1860:	b94027e0 	ldr	w0, [sp, #36]
    1864:	7101901f 	cmp	w0, #0x64
    1868:	54000181 	b.ne	1898 <printf+0xf4>  // b.any
                printint(fd, *ap, 10, 1);
    186c:	f94017e0 	ldr	x0, [sp, #40]
    1870:	f9400000 	ldr	x0, [x0]
    1874:	52800023 	mov	w3, #0x1                   	// #1
    1878:	52800142 	mov	w2, #0xa                   	// #10
    187c:	2a0003e1 	mov	w1, w0
    1880:	b9401fe0 	ldr	w0, [sp, #28]
    1884:	97ffff81 	bl	1688 <printint>
                ap++;
    1888:	f94017e0 	ldr	x0, [sp, #40]
    188c:	91002000 	add	x0, x0, #0x8
    1890:	f90017e0 	str	x0, [sp, #40]
    1894:	1400004d 	b	19c8 <printf+0x224>
            } else if(c == 'x' || c == 'p'){
    1898:	b94027e0 	ldr	w0, [sp, #36]
    189c:	7101e01f 	cmp	w0, #0x78
    18a0:	54000080 	b.eq	18b0 <printf+0x10c>  // b.none
    18a4:	b94027e0 	ldr	w0, [sp, #36]
    18a8:	7101c01f 	cmp	w0, #0x70
    18ac:	54000181 	b.ne	18dc <printf+0x138>  // b.any
                printint(fd, *ap, 16, 0);
    18b0:	f94017e0 	ldr	x0, [sp, #40]
    18b4:	f9400000 	ldr	x0, [x0]
    18b8:	52800003 	mov	w3, #0x0                   	// #0
    18bc:	52800202 	mov	w2, #0x10                  	// #16
    18c0:	2a0003e1 	mov	w1, w0
    18c4:	b9401fe0 	ldr	w0, [sp, #28]
    18c8:	97ffff70 	bl	1688 <printint>
                ap++;
    18cc:	f94017e0 	ldr	x0, [sp, #40]
    18d0:	91002000 	add	x0, x0, #0x8
    18d4:	f90017e0 	str	x0, [sp, #40]
    18d8:	1400003c 	b	19c8 <printf+0x224>
            } else if(c == 's'){
    18dc:	b94027e0 	ldr	w0, [sp, #36]
    18e0:	7101cc1f 	cmp	w0, #0x73
    18e4:	54000361 	b.ne	1950 <printf+0x1ac>  // b.any
                s = (char*)*ap;
    18e8:	f94017e0 	ldr	x0, [sp, #40]
    18ec:	f9400000 	ldr	x0, [x0]
    18f0:	f9001fe0 	str	x0, [sp, #56]
                ap++;
    18f4:	f94017e0 	ldr	x0, [sp, #40]
    18f8:	91002000 	add	x0, x0, #0x8
    18fc:	f90017e0 	str	x0, [sp, #40]
                if(s == 0)
    1900:	f9401fe0 	ldr	x0, [sp, #56]
    1904:	f100001f 	cmp	x0, #0x0
    1908:	540001a1 	b.ne	193c <printf+0x198>  // b.any
                    s = "(null)";
    190c:	90000000 	adrp	x0, 1000 <strlen+0x20>
    1910:	913a0000 	add	x0, x0, #0xe80
    1914:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
    1918:	14000009 	b	193c <printf+0x198>
                    putc(fd, *s);
    191c:	f9401fe0 	ldr	x0, [sp, #56]
    1920:	39400000 	ldrb	w0, [x0]
    1924:	2a0003e1 	mov	w1, w0
    1928:	b9401fe0 	ldr	w0, [sp, #28]
    192c:	97ffff4b 	bl	1658 <putc>
                    s++;
    1930:	f9401fe0 	ldr	x0, [sp, #56]
    1934:	91000400 	add	x0, x0, #0x1
    1938:	f9001fe0 	str	x0, [sp, #56]
                while(*s != 0){
    193c:	f9401fe0 	ldr	x0, [sp, #56]
    1940:	39400000 	ldrb	w0, [x0]
    1944:	7100001f 	cmp	w0, #0x0
    1948:	54fffea1 	b.ne	191c <printf+0x178>  // b.any
    194c:	1400001f 	b	19c8 <printf+0x224>
                }
            } else if(c == 'c'){
    1950:	b94027e0 	ldr	w0, [sp, #36]
    1954:	71018c1f 	cmp	w0, #0x63
    1958:	54000161 	b.ne	1984 <printf+0x1e0>  // b.any
                putc(fd, *ap);
    195c:	f94017e0 	ldr	x0, [sp, #40]
    1960:	f9400000 	ldr	x0, [x0]
    1964:	12001c00 	and	w0, w0, #0xff
    1968:	2a0003e1 	mov	w1, w0
    196c:	b9401fe0 	ldr	w0, [sp, #28]
    1970:	97ffff3a 	bl	1658 <putc>
                ap++;
    1974:	f94017e0 	ldr	x0, [sp, #40]
    1978:	91002000 	add	x0, x0, #0x8
    197c:	f90017e0 	str	x0, [sp, #40]
    1980:	14000012 	b	19c8 <printf+0x224>
            } else if(c == '%'){
    1984:	b94027e0 	ldr	w0, [sp, #36]
    1988:	7100941f 	cmp	w0, #0x25
    198c:	540000e1 	b.ne	19a8 <printf+0x204>  // b.any
                putc(fd, c);
    1990:	b94027e0 	ldr	w0, [sp, #36]
    1994:	12001c00 	and	w0, w0, #0xff
    1998:	2a0003e1 	mov	w1, w0
    199c:	b9401fe0 	ldr	w0, [sp, #28]
    19a0:	97ffff2e 	bl	1658 <putc>
    19a4:	14000009 	b	19c8 <printf+0x224>
            } else {
                // Unknown % sequence.  Print it to draw attention.
                putc(fd, '%');
    19a8:	528004a1 	mov	w1, #0x25                  	// #37
    19ac:	b9401fe0 	ldr	w0, [sp, #28]
    19b0:	97ffff2a 	bl	1658 <putc>
                putc(fd, c);
    19b4:	b94027e0 	ldr	w0, [sp, #36]
    19b8:	12001c00 	and	w0, w0, #0xff
    19bc:	2a0003e1 	mov	w1, w0
    19c0:	b9401fe0 	ldr	w0, [sp, #28]
    19c4:	97ffff25 	bl	1658 <putc>
            }
            state = 0;
    19c8:	b90033ff 	str	wzr, [sp, #48]
    for(i = 0; fmt[i]; i++){
    19cc:	b94037e0 	ldr	w0, [sp, #52]
    19d0:	11000400 	add	w0, w0, #0x1
    19d4:	b90037e0 	str	w0, [sp, #52]
    19d8:	f9400be1 	ldr	x1, [sp, #16]
    19dc:	b98037e0 	ldrsw	x0, [sp, #52]
    19e0:	8b000020 	add	x0, x1, x0
    19e4:	39400000 	ldrb	w0, [x0]
    19e8:	7100001f 	cmp	w0, #0x0
    19ec:	54fff0c1 	b.ne	1804 <printf+0x60>  // b.any
        }
    }
}
    19f0:	d503201f 	nop
    19f4:	d503201f 	nop
    19f8:	a8cf7bfd 	ldp	x29, x30, [sp], #240
    19fc:	d65f03c0 	ret

0000000000001a00 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1a00:	d10083ff 	sub	sp, sp, #0x20
    1a04:	f90007e0 	str	x0, [sp, #8]
    Header *bp, *p;
    
    bp = (Header*)ap - 1;
    1a08:	f94007e0 	ldr	x0, [sp, #8]
    1a0c:	d1004000 	sub	x0, x0, #0x10
    1a10:	f9000be0 	str	x0, [sp, #16]
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1a14:	90000000 	adrp	x0, 1000 <strlen+0x20>
    1a18:	913ca000 	add	x0, x0, #0xf28
    1a1c:	f9400000 	ldr	x0, [x0]
    1a20:	f9000fe0 	str	x0, [sp, #24]
    1a24:	14000012 	b	1a6c <free+0x6c>
        if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1a28:	f9400fe0 	ldr	x0, [sp, #24]
    1a2c:	f9400000 	ldr	x0, [x0]
    1a30:	f9400fe1 	ldr	x1, [sp, #24]
    1a34:	eb00003f 	cmp	x1, x0
    1a38:	54000143 	b.cc	1a60 <free+0x60>  // b.lo, b.ul, b.last
    1a3c:	f9400be1 	ldr	x1, [sp, #16]
    1a40:	f9400fe0 	ldr	x0, [sp, #24]
    1a44:	eb00003f 	cmp	x1, x0
    1a48:	54000248 	b.hi	1a90 <free+0x90>  // b.pmore
    1a4c:	f9400fe0 	ldr	x0, [sp, #24]
    1a50:	f9400000 	ldr	x0, [x0]
    1a54:	f9400be1 	ldr	x1, [sp, #16]
    1a58:	eb00003f 	cmp	x1, x0
    1a5c:	540001a3 	b.cc	1a90 <free+0x90>  // b.lo, b.ul, b.last
    for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1a60:	f9400fe0 	ldr	x0, [sp, #24]
    1a64:	f9400000 	ldr	x0, [x0]
    1a68:	f9000fe0 	str	x0, [sp, #24]
    1a6c:	f9400be1 	ldr	x1, [sp, #16]
    1a70:	f9400fe0 	ldr	x0, [sp, #24]
    1a74:	eb00003f 	cmp	x1, x0
    1a78:	54fffd89 	b.ls	1a28 <free+0x28>  // b.plast
    1a7c:	f9400fe0 	ldr	x0, [sp, #24]
    1a80:	f9400000 	ldr	x0, [x0]
    1a84:	f9400be1 	ldr	x1, [sp, #16]
    1a88:	eb00003f 	cmp	x1, x0
    1a8c:	54fffce2 	b.cs	1a28 <free+0x28>  // b.hs, b.nlast
            break;
    if(bp + bp->s.size == p->s.ptr){
    1a90:	f9400be0 	ldr	x0, [sp, #16]
    1a94:	b9400800 	ldr	w0, [x0, #8]
    1a98:	2a0003e0 	mov	w0, w0
    1a9c:	d37cec00 	lsl	x0, x0, #4
    1aa0:	f9400be1 	ldr	x1, [sp, #16]
    1aa4:	8b000021 	add	x1, x1, x0
    1aa8:	f9400fe0 	ldr	x0, [sp, #24]
    1aac:	f9400000 	ldr	x0, [x0]
    1ab0:	eb00003f 	cmp	x1, x0
    1ab4:	540001e1 	b.ne	1af0 <free+0xf0>  // b.any
        bp->s.size += p->s.ptr->s.size;
    1ab8:	f9400be0 	ldr	x0, [sp, #16]
    1abc:	b9400801 	ldr	w1, [x0, #8]
    1ac0:	f9400fe0 	ldr	x0, [sp, #24]
    1ac4:	f9400000 	ldr	x0, [x0]
    1ac8:	b9400800 	ldr	w0, [x0, #8]
    1acc:	0b000021 	add	w1, w1, w0
    1ad0:	f9400be0 	ldr	x0, [sp, #16]
    1ad4:	b9000801 	str	w1, [x0, #8]
        bp->s.ptr = p->s.ptr->s.ptr;
    1ad8:	f9400fe0 	ldr	x0, [sp, #24]
    1adc:	f9400000 	ldr	x0, [x0]
    1ae0:	f9400001 	ldr	x1, [x0]
    1ae4:	f9400be0 	ldr	x0, [sp, #16]
    1ae8:	f9000001 	str	x1, [x0]
    1aec:	14000005 	b	1b00 <free+0x100>
    } else
        bp->s.ptr = p->s.ptr;
    1af0:	f9400fe0 	ldr	x0, [sp, #24]
    1af4:	f9400001 	ldr	x1, [x0]
    1af8:	f9400be0 	ldr	x0, [sp, #16]
    1afc:	f9000001 	str	x1, [x0]
    if(p + p->s.size == bp){
    1b00:	f9400fe0 	ldr	x0, [sp, #24]
    1b04:	b9400800 	ldr	w0, [x0, #8]
    1b08:	2a0003e0 	mov	w0, w0
    1b0c:	d37cec00 	lsl	x0, x0, #4
    1b10:	f9400fe1 	ldr	x1, [sp, #24]
    1b14:	8b000020 	add	x0, x1, x0
    1b18:	f9400be1 	ldr	x1, [sp, #16]
    1b1c:	eb00003f 	cmp	x1, x0
    1b20:	540001a1 	b.ne	1b54 <free+0x154>  // b.any
        p->s.size += bp->s.size;
    1b24:	f9400fe0 	ldr	x0, [sp, #24]
    1b28:	b9400801 	ldr	w1, [x0, #8]
    1b2c:	f9400be0 	ldr	x0, [sp, #16]
    1b30:	b9400800 	ldr	w0, [x0, #8]
    1b34:	0b000021 	add	w1, w1, w0
    1b38:	f9400fe0 	ldr	x0, [sp, #24]
    1b3c:	b9000801 	str	w1, [x0, #8]
        p->s.ptr = bp->s.ptr;
    1b40:	f9400be0 	ldr	x0, [sp, #16]
    1b44:	f9400001 	ldr	x1, [x0]
    1b48:	f9400fe0 	ldr	x0, [sp, #24]
    1b4c:	f9000001 	str	x1, [x0]
    1b50:	14000004 	b	1b60 <free+0x160>
    } else
        p->s.ptr = bp;
    1b54:	f9400fe0 	ldr	x0, [sp, #24]
    1b58:	f9400be1 	ldr	x1, [sp, #16]
    1b5c:	f9000001 	str	x1, [x0]
    freep = p;
    1b60:	90000000 	adrp	x0, 1000 <strlen+0x20>
    1b64:	913ca000 	add	x0, x0, #0xf28
    1b68:	f9400fe1 	ldr	x1, [sp, #24]
    1b6c:	f9000001 	str	x1, [x0]
}
    1b70:	d503201f 	nop
    1b74:	910083ff 	add	sp, sp, #0x20
    1b78:	d65f03c0 	ret

0000000000001b7c <morecore>:

static Header*
morecore(uint nu)
{
    1b7c:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
    1b80:	910003fd 	mov	x29, sp
    1b84:	b9001fe0 	str	w0, [sp, #28]
    char *p;
    Header *hp;
    
    if(nu < 4096)
    1b88:	b9401fe0 	ldr	w0, [sp, #28]
    1b8c:	713ffc1f 	cmp	w0, #0xfff
    1b90:	54000068 	b.hi	1b9c <morecore+0x20>  // b.pmore
        nu = 4096;
    1b94:	52820000 	mov	w0, #0x1000                	// #4096
    1b98:	b9001fe0 	str	w0, [sp, #28]
    p = sbrk(nu * sizeof(Header));
    1b9c:	b9401fe0 	ldr	w0, [sp, #28]
    1ba0:	531c6c00 	lsl	w0, w0, #4
    1ba4:	97fffe92 	bl	15ec <sbrk>
    1ba8:	f90017e0 	str	x0, [sp, #40]
    if(p == (char*)-1)
    1bac:	f94017e0 	ldr	x0, [sp, #40]
    1bb0:	b100041f 	cmn	x0, #0x1
    1bb4:	54000061 	b.ne	1bc0 <morecore+0x44>  // b.any
        return 0;
    1bb8:	d2800000 	mov	x0, #0x0                   	// #0
    1bbc:	1400000c 	b	1bec <morecore+0x70>
    hp = (Header*)p;
    1bc0:	f94017e0 	ldr	x0, [sp, #40]
    1bc4:	f90013e0 	str	x0, [sp, #32]
    hp->s.size = nu;
    1bc8:	f94013e0 	ldr	x0, [sp, #32]
    1bcc:	b9401fe1 	ldr	w1, [sp, #28]
    1bd0:	b9000801 	str	w1, [x0, #8]
    free((void*)(hp + 1));
    1bd4:	f94013e0 	ldr	x0, [sp, #32]
    1bd8:	91004000 	add	x0, x0, #0x10
    1bdc:	97ffff89 	bl	1a00 <free>
    return freep;
    1be0:	90000000 	adrp	x0, 1000 <strlen+0x20>
    1be4:	913ca000 	add	x0, x0, #0xf28
    1be8:	f9400000 	ldr	x0, [x0]
}
    1bec:	a8c37bfd 	ldp	x29, x30, [sp], #48
    1bf0:	d65f03c0 	ret

0000000000001bf4 <malloc>:

void*
malloc(uint nbytes)
{
    1bf4:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
    1bf8:	910003fd 	mov	x29, sp
    1bfc:	b9001fe0 	str	w0, [sp, #28]
    Header *p, *prevp;
    uint nunits;
    
    nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    1c00:	b9401fe0 	ldr	w0, [sp, #28]
    1c04:	91003c00 	add	x0, x0, #0xf
    1c08:	d344fc00 	lsr	x0, x0, #4
    1c0c:	11000400 	add	w0, w0, #0x1
    1c10:	b9002fe0 	str	w0, [sp, #44]
    if((prevp = freep) == 0){
    1c14:	90000000 	adrp	x0, 1000 <strlen+0x20>
    1c18:	913ca000 	add	x0, x0, #0xf28
    1c1c:	f9400000 	ldr	x0, [x0]
    1c20:	f9001be0 	str	x0, [sp, #48]
    1c24:	f9401be0 	ldr	x0, [sp, #48]
    1c28:	f100001f 	cmp	x0, #0x0
    1c2c:	54000221 	b.ne	1c70 <malloc+0x7c>  // b.any
        base.s.ptr = freep = prevp = &base;
    1c30:	90000000 	adrp	x0, 1000 <strlen+0x20>
    1c34:	913c6000 	add	x0, x0, #0xf18
    1c38:	f9001be0 	str	x0, [sp, #48]
    1c3c:	90000000 	adrp	x0, 1000 <strlen+0x20>
    1c40:	913ca000 	add	x0, x0, #0xf28
    1c44:	f9401be1 	ldr	x1, [sp, #48]
    1c48:	f9000001 	str	x1, [x0]
    1c4c:	90000000 	adrp	x0, 1000 <strlen+0x20>
    1c50:	913ca000 	add	x0, x0, #0xf28
    1c54:	f9400001 	ldr	x1, [x0]
    1c58:	90000000 	adrp	x0, 1000 <strlen+0x20>
    1c5c:	913c6000 	add	x0, x0, #0xf18
    1c60:	f9000001 	str	x1, [x0]
        base.s.size = 0;
    1c64:	90000000 	adrp	x0, 1000 <strlen+0x20>
    1c68:	913c6000 	add	x0, x0, #0xf18
    1c6c:	b900081f 	str	wzr, [x0, #8]
    }
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1c70:	f9401be0 	ldr	x0, [sp, #48]
    1c74:	f9400000 	ldr	x0, [x0]
    1c78:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
    1c7c:	f9401fe0 	ldr	x0, [sp, #56]
    1c80:	b9400800 	ldr	w0, [x0, #8]
    1c84:	b9402fe1 	ldr	w1, [sp, #44]
    1c88:	6b00003f 	cmp	w1, w0
    1c8c:	54000448 	b.hi	1d14 <malloc+0x120>  // b.pmore
            if(p->s.size == nunits)
    1c90:	f9401fe0 	ldr	x0, [sp, #56]
    1c94:	b9400800 	ldr	w0, [x0, #8]
    1c98:	b9402fe1 	ldr	w1, [sp, #44]
    1c9c:	6b00003f 	cmp	w1, w0
    1ca0:	540000c1 	b.ne	1cb8 <malloc+0xc4>  // b.any
                prevp->s.ptr = p->s.ptr;
    1ca4:	f9401fe0 	ldr	x0, [sp, #56]
    1ca8:	f9400001 	ldr	x1, [x0]
    1cac:	f9401be0 	ldr	x0, [sp, #48]
    1cb0:	f9000001 	str	x1, [x0]
    1cb4:	14000011 	b	1cf8 <malloc+0x104>
            else {
                p->s.size -= nunits;
    1cb8:	f9401fe0 	ldr	x0, [sp, #56]
    1cbc:	b9400801 	ldr	w1, [x0, #8]
    1cc0:	b9402fe0 	ldr	w0, [sp, #44]
    1cc4:	4b000021 	sub	w1, w1, w0
    1cc8:	f9401fe0 	ldr	x0, [sp, #56]
    1ccc:	b9000801 	str	w1, [x0, #8]
                p += p->s.size;
    1cd0:	f9401fe0 	ldr	x0, [sp, #56]
    1cd4:	b9400800 	ldr	w0, [x0, #8]
    1cd8:	2a0003e0 	mov	w0, w0
    1cdc:	d37cec00 	lsl	x0, x0, #4
    1ce0:	f9401fe1 	ldr	x1, [sp, #56]
    1ce4:	8b000020 	add	x0, x1, x0
    1ce8:	f9001fe0 	str	x0, [sp, #56]
                p->s.size = nunits;
    1cec:	f9401fe0 	ldr	x0, [sp, #56]
    1cf0:	b9402fe1 	ldr	w1, [sp, #44]
    1cf4:	b9000801 	str	w1, [x0, #8]
            }
            freep = prevp;
    1cf8:	90000000 	adrp	x0, 1000 <strlen+0x20>
    1cfc:	913ca000 	add	x0, x0, #0xf28
    1d00:	f9401be1 	ldr	x1, [sp, #48]
    1d04:	f9000001 	str	x1, [x0]
            return (void*)(p + 1);
    1d08:	f9401fe0 	ldr	x0, [sp, #56]
    1d0c:	91004000 	add	x0, x0, #0x10
    1d10:	14000015 	b	1d64 <malloc+0x170>
        }
        if(p == freep)
    1d14:	90000000 	adrp	x0, 1000 <strlen+0x20>
    1d18:	913ca000 	add	x0, x0, #0xf28
    1d1c:	f9400000 	ldr	x0, [x0]
    1d20:	f9401fe1 	ldr	x1, [sp, #56]
    1d24:	eb00003f 	cmp	x1, x0
    1d28:	54000121 	b.ne	1d4c <malloc+0x158>  // b.any
            if((p = morecore(nunits)) == 0)
    1d2c:	b9402fe0 	ldr	w0, [sp, #44]
    1d30:	97ffff93 	bl	1b7c <morecore>
    1d34:	f9001fe0 	str	x0, [sp, #56]
    1d38:	f9401fe0 	ldr	x0, [sp, #56]
    1d3c:	f100001f 	cmp	x0, #0x0
    1d40:	54000061 	b.ne	1d4c <malloc+0x158>  // b.any
                return 0;
    1d44:	d2800000 	mov	x0, #0x0                   	// #0
    1d48:	14000007 	b	1d64 <malloc+0x170>
    for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1d4c:	f9401fe0 	ldr	x0, [sp, #56]
    1d50:	f9001be0 	str	x0, [sp, #48]
    1d54:	f9401fe0 	ldr	x0, [sp, #56]
    1d58:	f9400000 	ldr	x0, [x0]
    1d5c:	f9001fe0 	str	x0, [sp, #56]
        if(p->s.size >= nunits){
    1d60:	17ffffc7 	b	1c7c <malloc+0x88>
    }
}
    1d64:	a8c47bfd 	ldp	x29, x30, [sp], #64
    1d68:	d65f03c0 	ret
