
usys.o:     file format elf64-littleaarch64


Disassembly of section .text:

0000000000000000 <fork>:
   0:	f81f8fe4 	str	x4, [sp, #-8]!
   4:	aa0303e4 	mov	x4, x3
   8:	aa0203e3 	mov	x3, x2
   c:	aa0103e2 	mov	x2, x1
  10:	aa0003e1 	mov	x1, x0
  14:	d2800020 	mov	x0, #0x1                   	// #1
  18:	d4000001 	svc	#0x0
  1c:	f84087e4 	ldr	x4, [sp], #8
  20:	d61f03c0 	br	x30

0000000000000024 <exit>:
  24:	f81f8fe4 	str	x4, [sp, #-8]!
  28:	aa0303e4 	mov	x4, x3
  2c:	aa0203e3 	mov	x3, x2
  30:	aa0103e2 	mov	x2, x1
  34:	aa0003e1 	mov	x1, x0
  38:	d2800040 	mov	x0, #0x2                   	// #2
  3c:	d4000001 	svc	#0x0
  40:	f84087e4 	ldr	x4, [sp], #8
  44:	d61f03c0 	br	x30

0000000000000048 <wait>:
  48:	f81f8fe4 	str	x4, [sp, #-8]!
  4c:	aa0303e4 	mov	x4, x3
  50:	aa0203e3 	mov	x3, x2
  54:	aa0103e2 	mov	x2, x1
  58:	aa0003e1 	mov	x1, x0
  5c:	d2800060 	mov	x0, #0x3                   	// #3
  60:	d4000001 	svc	#0x0
  64:	f84087e4 	ldr	x4, [sp], #8
  68:	d61f03c0 	br	x30

000000000000006c <pipe>:
  6c:	f81f8fe4 	str	x4, [sp, #-8]!
  70:	aa0303e4 	mov	x4, x3
  74:	aa0203e3 	mov	x3, x2
  78:	aa0103e2 	mov	x2, x1
  7c:	aa0003e1 	mov	x1, x0
  80:	d2800080 	mov	x0, #0x4                   	// #4
  84:	d4000001 	svc	#0x0
  88:	f84087e4 	ldr	x4, [sp], #8
  8c:	d61f03c0 	br	x30

0000000000000090 <read>:
  90:	f81f8fe4 	str	x4, [sp, #-8]!
  94:	aa0303e4 	mov	x4, x3
  98:	aa0203e3 	mov	x3, x2
  9c:	aa0103e2 	mov	x2, x1
  a0:	aa0003e1 	mov	x1, x0
  a4:	d28000a0 	mov	x0, #0x5                   	// #5
  a8:	d4000001 	svc	#0x0
  ac:	f84087e4 	ldr	x4, [sp], #8
  b0:	d61f03c0 	br	x30

00000000000000b4 <write>:
  b4:	f81f8fe4 	str	x4, [sp, #-8]!
  b8:	aa0303e4 	mov	x4, x3
  bc:	aa0203e3 	mov	x3, x2
  c0:	aa0103e2 	mov	x2, x1
  c4:	aa0003e1 	mov	x1, x0
  c8:	d2800200 	mov	x0, #0x10                  	// #16
  cc:	d4000001 	svc	#0x0
  d0:	f84087e4 	ldr	x4, [sp], #8
  d4:	d61f03c0 	br	x30

00000000000000d8 <close>:
  d8:	f81f8fe4 	str	x4, [sp, #-8]!
  dc:	aa0303e4 	mov	x4, x3
  e0:	aa0203e3 	mov	x3, x2
  e4:	aa0103e2 	mov	x2, x1
  e8:	aa0003e1 	mov	x1, x0
  ec:	d28002a0 	mov	x0, #0x15                  	// #21
  f0:	d4000001 	svc	#0x0
  f4:	f84087e4 	ldr	x4, [sp], #8
  f8:	d61f03c0 	br	x30

00000000000000fc <kill>:
  fc:	f81f8fe4 	str	x4, [sp, #-8]!
 100:	aa0303e4 	mov	x4, x3
 104:	aa0203e3 	mov	x3, x2
 108:	aa0103e2 	mov	x2, x1
 10c:	aa0003e1 	mov	x1, x0
 110:	d28000c0 	mov	x0, #0x6                   	// #6
 114:	d4000001 	svc	#0x0
 118:	f84087e4 	ldr	x4, [sp], #8
 11c:	d61f03c0 	br	x30

0000000000000120 <exec>:
 120:	f81f8fe4 	str	x4, [sp, #-8]!
 124:	aa0303e4 	mov	x4, x3
 128:	aa0203e3 	mov	x3, x2
 12c:	aa0103e2 	mov	x2, x1
 130:	aa0003e1 	mov	x1, x0
 134:	d28000e0 	mov	x0, #0x7                   	// #7
 138:	d4000001 	svc	#0x0
 13c:	f84087e4 	ldr	x4, [sp], #8
 140:	d61f03c0 	br	x30

0000000000000144 <open>:
 144:	f81f8fe4 	str	x4, [sp, #-8]!
 148:	aa0303e4 	mov	x4, x3
 14c:	aa0203e3 	mov	x3, x2
 150:	aa0103e2 	mov	x2, x1
 154:	aa0003e1 	mov	x1, x0
 158:	d28001e0 	mov	x0, #0xf                   	// #15
 15c:	d4000001 	svc	#0x0
 160:	f84087e4 	ldr	x4, [sp], #8
 164:	d61f03c0 	br	x30

0000000000000168 <mknod>:
 168:	f81f8fe4 	str	x4, [sp, #-8]!
 16c:	aa0303e4 	mov	x4, x3
 170:	aa0203e3 	mov	x3, x2
 174:	aa0103e2 	mov	x2, x1
 178:	aa0003e1 	mov	x1, x0
 17c:	d2800220 	mov	x0, #0x11                  	// #17
 180:	d4000001 	svc	#0x0
 184:	f84087e4 	ldr	x4, [sp], #8
 188:	d61f03c0 	br	x30

000000000000018c <unlink>:
 18c:	f81f8fe4 	str	x4, [sp, #-8]!
 190:	aa0303e4 	mov	x4, x3
 194:	aa0203e3 	mov	x3, x2
 198:	aa0103e2 	mov	x2, x1
 19c:	aa0003e1 	mov	x1, x0
 1a0:	d2800240 	mov	x0, #0x12                  	// #18
 1a4:	d4000001 	svc	#0x0
 1a8:	f84087e4 	ldr	x4, [sp], #8
 1ac:	d61f03c0 	br	x30

00000000000001b0 <fstat>:
 1b0:	f81f8fe4 	str	x4, [sp, #-8]!
 1b4:	aa0303e4 	mov	x4, x3
 1b8:	aa0203e3 	mov	x3, x2
 1bc:	aa0103e2 	mov	x2, x1
 1c0:	aa0003e1 	mov	x1, x0
 1c4:	d2800100 	mov	x0, #0x8                   	// #8
 1c8:	d4000001 	svc	#0x0
 1cc:	f84087e4 	ldr	x4, [sp], #8
 1d0:	d61f03c0 	br	x30

00000000000001d4 <link>:
 1d4:	f81f8fe4 	str	x4, [sp, #-8]!
 1d8:	aa0303e4 	mov	x4, x3
 1dc:	aa0203e3 	mov	x3, x2
 1e0:	aa0103e2 	mov	x2, x1
 1e4:	aa0003e1 	mov	x1, x0
 1e8:	d2800260 	mov	x0, #0x13                  	// #19
 1ec:	d4000001 	svc	#0x0
 1f0:	f84087e4 	ldr	x4, [sp], #8
 1f4:	d61f03c0 	br	x30

00000000000001f8 <mkdir>:
 1f8:	f81f8fe4 	str	x4, [sp, #-8]!
 1fc:	aa0303e4 	mov	x4, x3
 200:	aa0203e3 	mov	x3, x2
 204:	aa0103e2 	mov	x2, x1
 208:	aa0003e1 	mov	x1, x0
 20c:	d2800280 	mov	x0, #0x14                  	// #20
 210:	d4000001 	svc	#0x0
 214:	f84087e4 	ldr	x4, [sp], #8
 218:	d61f03c0 	br	x30

000000000000021c <chdir>:
 21c:	f81f8fe4 	str	x4, [sp, #-8]!
 220:	aa0303e4 	mov	x4, x3
 224:	aa0203e3 	mov	x3, x2
 228:	aa0103e2 	mov	x2, x1
 22c:	aa0003e1 	mov	x1, x0
 230:	d2800120 	mov	x0, #0x9                   	// #9
 234:	d4000001 	svc	#0x0
 238:	f84087e4 	ldr	x4, [sp], #8
 23c:	d61f03c0 	br	x30

0000000000000240 <dup>:
 240:	f81f8fe4 	str	x4, [sp, #-8]!
 244:	aa0303e4 	mov	x4, x3
 248:	aa0203e3 	mov	x3, x2
 24c:	aa0103e2 	mov	x2, x1
 250:	aa0003e1 	mov	x1, x0
 254:	d2800140 	mov	x0, #0xa                   	// #10
 258:	d4000001 	svc	#0x0
 25c:	f84087e4 	ldr	x4, [sp], #8
 260:	d61f03c0 	br	x30

0000000000000264 <getpid>:
 264:	f81f8fe4 	str	x4, [sp, #-8]!
 268:	aa0303e4 	mov	x4, x3
 26c:	aa0203e3 	mov	x3, x2
 270:	aa0103e2 	mov	x2, x1
 274:	aa0003e1 	mov	x1, x0
 278:	d2800160 	mov	x0, #0xb                   	// #11
 27c:	d4000001 	svc	#0x0
 280:	f84087e4 	ldr	x4, [sp], #8
 284:	d61f03c0 	br	x30

0000000000000288 <sbrk>:
 288:	f81f8fe4 	str	x4, [sp, #-8]!
 28c:	aa0303e4 	mov	x4, x3
 290:	aa0203e3 	mov	x3, x2
 294:	aa0103e2 	mov	x2, x1
 298:	aa0003e1 	mov	x1, x0
 29c:	d2800180 	mov	x0, #0xc                   	// #12
 2a0:	d4000001 	svc	#0x0
 2a4:	f84087e4 	ldr	x4, [sp], #8
 2a8:	d61f03c0 	br	x30

00000000000002ac <sleep>:
 2ac:	f81f8fe4 	str	x4, [sp, #-8]!
 2b0:	aa0303e4 	mov	x4, x3
 2b4:	aa0203e3 	mov	x3, x2
 2b8:	aa0103e2 	mov	x2, x1
 2bc:	aa0003e1 	mov	x1, x0
 2c0:	d28001a0 	mov	x0, #0xd                   	// #13
 2c4:	d4000001 	svc	#0x0
 2c8:	f84087e4 	ldr	x4, [sp], #8
 2cc:	d61f03c0 	br	x30

00000000000002d0 <uptime>:
 2d0:	f81f8fe4 	str	x4, [sp, #-8]!
 2d4:	aa0303e4 	mov	x4, x3
 2d8:	aa0203e3 	mov	x3, x2
 2dc:	aa0103e2 	mov	x2, x1
 2e0:	aa0003e1 	mov	x1, x0
 2e4:	d28001c0 	mov	x0, #0xe                   	// #14
 2e8:	d4000001 	svc	#0x0
 2ec:	f84087e4 	ldr	x4, [sp], #8
 2f0:	d61f03c0 	br	x30
