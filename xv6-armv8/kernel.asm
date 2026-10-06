
kernel.elf:     file format elf64-littleaarch64


Disassembly of section .start_sec:

0000000040010000 <_start>:
    40010000:	d2800020 	mov	x0, #0x1                   	// #1
    40010004:	d5184200 	msr	spsel, x0
    40010008:	d5033fdf 	isb
    4001000c:	f0000000 	adrp	x0, 40013000 <_kernel_pgtbl>
    40010010:	9100001f 	mov	sp, x0
    40010014:	580001e1 	ldr	x1, 40010050 <jump_stack+0x14>
    40010018:	58000202 	ldr	x2, 40010058 <jump_stack+0x1c>
    4001001c:	d2800003 	mov	x3, #0x0                   	// #0
    40010020:	eb02003f 	cmp	x1, x2
    40010024:	5400008c 	b.gt	40010034 <_start+0x34>
    40010028:	f9000023 	str	x3, [x1]
    4001002c:	91002021 	add	x1, x1, #0x8
    40010030:	54ffff8b 	b.lt	40010020 <_start+0x20>  // b.tstop
    40010034:	94000149 	bl	40010558 <start>
    40010038:	14000000 	b	40010038 <_start+0x38>

000000004001003c <jump_stack>:
    4001003c:	910003e0 	mov	x0, sp
    40010040:	58000101 	ldr	x1, 40010060 <jump_stack+0x24>
    40010044:	8b20603f 	add	sp, x1, x0
    40010048:	d65f03c0 	ret
    4001004c:	00000000 	udf	#0
    40010050:	40010a38 	.word	0x40010a38
    40010054:	00000000 	.word	0x00000000
    40010058:	4001d000 	.word	0x4001d000
	...
    40010064:	ffffffff 	.word	0xffffffff

0000000040010068 <_uart_putc>:
#include "mmu.h"
#include "defs.h"
#include "memlayout.h"

void _uart_putc(int c)
{
    40010068:	d10083ff 	sub	sp, sp, #0x20
    4001006c:	b9000fe0 	str	w0, [sp, #12]
    volatile uint8 * uart0 = (uint8*)UART0;
    40010070:	d2a12000 	mov	x0, #0x9000000             	// #150994944
    40010074:	f9000fe0 	str	x0, [sp, #24]
    *uart0 = c;
    40010078:	b9400fe0 	ldr	w0, [sp, #12]
    4001007c:	12001c01 	and	w1, w0, #0xff
    40010080:	f9400fe0 	ldr	x0, [sp, #24]
    40010084:	39000001 	strb	w1, [x0]
}
    40010088:	d503201f 	nop
    4001008c:	910083ff 	add	sp, sp, #0x20
    40010090:	d65f03c0 	ret

0000000040010094 <_puts>:


void _puts (char *s)
{
    40010094:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    40010098:	910003fd 	mov	x29, sp
    4001009c:	f9000fe0 	str	x0, [sp, #24]
    while (*s != '\0') {
    400100a0:	14000007 	b	400100bc <_puts+0x28>
        _uart_putc(*s);
    400100a4:	f9400fe0 	ldr	x0, [sp, #24]
    400100a8:	39400000 	ldrb	w0, [x0]
    400100ac:	97ffffef 	bl	40010068 <_uart_putc>
        s++;
    400100b0:	f9400fe0 	ldr	x0, [sp, #24]
    400100b4:	91000400 	add	x0, x0, #0x1
    400100b8:	f9000fe0 	str	x0, [sp, #24]
    while (*s != '\0') {
    400100bc:	f9400fe0 	ldr	x0, [sp, #24]
    400100c0:	39400000 	ldrb	w0, [x0]
    400100c4:	7100001f 	cmp	w0, #0x0
    400100c8:	54fffee1 	b.ne	400100a4 <_puts+0x10>  // b.any
    }
}
    400100cc:	d503201f 	nop
    400100d0:	d503201f 	nop
    400100d4:	a8c27bfd 	ldp	x29, x30, [sp], #32
    400100d8:	d65f03c0 	ret

00000000400100dc <_putint>:

void _putint (char *prefix, uint val, char* suffix)
{
    400100dc:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
    400100e0:	910003fd 	mov	x29, sp
    400100e4:	f90017e0 	str	x0, [sp, #40]
    400100e8:	b90027e1 	str	w1, [sp, #36]
    400100ec:	f9000fe2 	str	x2, [sp, #24]
    char* arr = "0123456789ABCDEF";
    400100f0:	90000000 	adrp	x0, 40010000 <_start>
    400100f4:	911d6000 	add	x0, x0, #0x758
    400100f8:	f9001be0 	str	x0, [sp, #48]
    int idx;

    if (prefix) {
    400100fc:	f94017e0 	ldr	x0, [sp, #40]
    40010100:	f100001f 	cmp	x0, #0x0
    40010104:	54000060 	b.eq	40010110 <_putint+0x34>  // b.none
        _puts(prefix);
    40010108:	f94017e0 	ldr	x0, [sp, #40]
    4001010c:	97ffffe2 	bl	40010094 <_puts>
    }

    for (idx = sizeof(val) * 8 - 4; idx >= 0; idx -= 4) {
    40010110:	52800380 	mov	w0, #0x1c                  	// #28
    40010114:	b9003fe0 	str	w0, [sp, #60]
    40010118:	1400000d 	b	4001014c <_putint+0x70>
        _uart_putc(arr[(val >> idx) & 0x0F]);
    4001011c:	b9403fe0 	ldr	w0, [sp, #60]
    40010120:	b94027e1 	ldr	w1, [sp, #36]
    40010124:	1ac02420 	lsr	w0, w1, w0
    40010128:	2a0003e0 	mov	w0, w0
    4001012c:	92400c00 	and	x0, x0, #0xf
    40010130:	f9401be1 	ldr	x1, [sp, #48]
    40010134:	8b000020 	add	x0, x1, x0
    40010138:	39400000 	ldrb	w0, [x0]
    4001013c:	97ffffcb 	bl	40010068 <_uart_putc>
    for (idx = sizeof(val) * 8 - 4; idx >= 0; idx -= 4) {
    40010140:	b9403fe0 	ldr	w0, [sp, #60]
    40010144:	51001000 	sub	w0, w0, #0x4
    40010148:	b9003fe0 	str	w0, [sp, #60]
    4001014c:	b9403fe0 	ldr	w0, [sp, #60]
    40010150:	7100001f 	cmp	w0, #0x0
    40010154:	54fffe4a 	b.ge	4001011c <_putint+0x40>  // b.tcont
    }

    if (suffix) {
    40010158:	f9400fe0 	ldr	x0, [sp, #24]
    4001015c:	f100001f 	cmp	x0, #0x0
    40010160:	54000060 	b.eq	4001016c <_putint+0x90>  // b.none
        _puts(suffix);
    40010164:	f9400fe0 	ldr	x0, [sp, #24]
    40010168:	97ffffcb 	bl	40010094 <_puts>
    }
}
    4001016c:	d503201f 	nop
    40010170:	a8c47bfd 	ldp	x29, x30, [sp], #64
    40010174:	d65f03c0 	ret

0000000040010178 <_do_exception>:

void _do_exception(void)
{
    40010178:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    4001017c:	910003fd 	mov	x29, sp
    _puts("Exception Raised\n");
    40010180:	90000000 	adrp	x0, 40010000 <_start>
    40010184:	911dc000 	add	x0, x0, #0x770
    40010188:	97ffffc3 	bl	40010094 <_puts>
    while(1);
    4001018c:	d503201f 	nop
    40010190:	17ffffff 	b	4001018c <_do_exception+0x14>

0000000040010194 <set_bootpgtbl>:

extern void * vectors;

// setup the boot page table: dev_mem whether it is device memory
void set_bootpgtbl (uint64 virt, uint64 phy, uint len, int dev_mem )
{
    40010194:	d10103ff 	sub	sp, sp, #0x40
    40010198:	f9000fe0 	str	x0, [sp, #24]
    4001019c:	f9000be1 	str	x1, [sp, #16]
    400101a0:	b9000fe2 	str	w2, [sp, #12]
    400101a4:	b9000be3 	str	w3, [sp, #8]
    int         idx;
    int		pgdidx;
    int		pmdidx;
    uint64	*level2;

    for (idx = 0; idx < len; idx = idx + 0x200000) {
    400101a8:	b90037ff 	str	wzr, [sp, #52]
    400101ac:	14000040 	b	400102ac <set_bootpgtbl+0x118>

        pgdidx = PGD_IDX(virt);
    400101b0:	f9400fe0 	ldr	x0, [sp, #24]
    400101b4:	d35efc00 	lsr	x0, x0, #30
    400101b8:	12000400 	and	w0, w0, #0x3
    400101bc:	b90033e0 	str	w0, [sp, #48]
        pmdidx = PMD_IDX(virt);
    400101c0:	f9400fe0 	ldr	x0, [sp, #24]
    400101c4:	d355fc00 	lsr	x0, x0, #21
    400101c8:	12002000 	and	w0, w0, #0x1ff
    400101cc:	b9002fe0 	str	w0, [sp, #44]

        pde = phy & PMD_MASK;
    400101d0:	f9400be0 	ldr	x0, [sp, #16]
    400101d4:	926ba800 	and	x0, x0, #0xffffffffffe00000
    400101d8:	f9001fe0 	str	x0, [sp, #56]

        if (!dev_mem) {
    400101dc:	b9400be0 	ldr	w0, [sp, #8]
    400101e0:	7100001f 	cmp	w0, #0x0
    400101e4:	540000e1 	b.ne	40010200 <set_bootpgtbl+0x6c>  // b.any
            // normal memory
            pde |= ACCESS_FLAG | SH_IN_SH | AP_RW_1 | NON_SECURE_PA | MEM_ATTR_IDX_4 | ENTRY_BLOCK | ENTRY_VALID | UXN;
    400101e8:	f9401fe1 	ldr	x1, [sp, #56]
    400101ec:	d280e620 	mov	x0, #0x731                 	// #1841
    400101f0:	f2e00800 	movk	x0, #0x40, lsl #48
    400101f4:	aa000020 	orr	x0, x1, x0
    400101f8:	f9001fe0 	str	x0, [sp, #56]
    400101fc:	14000005 	b	40010210 <set_bootpgtbl+0x7c>
        } else {
            // device memory
            pde |= ACCESS_FLAG | AP_RW_1 | MEM_ATTR_IDX_0 | ENTRY_BLOCK | ENTRY_VALID;
    40010200:	f9401fe1 	ldr	x1, [sp, #56]
    40010204:	d2808020 	mov	x0, #0x401                 	// #1025
    40010208:	aa000020 	orr	x0, x1, x0
    4001020c:	f9001fe0 	str	x0, [sp, #56]
        }

        level2 = (uint64 *)(kernel_pgtbl[pgdidx] & PG_ADDR_MASK);
    40010210:	90000000 	adrp	x0, 40010000 <_start>
    40010214:	9128a000 	add	x0, x0, #0xa28
    40010218:	f9400001 	ldr	x1, [x0]
    4001021c:	b98033e0 	ldrsw	x0, [sp, #48]
    40010220:	d37df000 	lsl	x0, x0, #3
    40010224:	8b000020 	add	x0, x1, x0
    40010228:	f9400000 	ldr	x0, [x0]
    4001022c:	92748c00 	and	x0, x0, #0xfffffffff000
    40010230:	f90013e0 	str	x0, [sp, #32]
        level2[pmdidx] = pde;
    40010234:	b9802fe0 	ldrsw	x0, [sp, #44]
    40010238:	d37df000 	lsl	x0, x0, #3
    4001023c:	f94013e1 	ldr	x1, [sp, #32]
    40010240:	8b000020 	add	x0, x1, x0
    40010244:	f9401fe1 	ldr	x1, [sp, #56]
    40010248:	f9000001 	str	x1, [x0]

        level2 = (uint64 *)(user_pgtbl[pgdidx] & PG_ADDR_MASK);
    4001024c:	90000000 	adrp	x0, 40010000 <_start>
    40010250:	9128c000 	add	x0, x0, #0xa30
    40010254:	f9400001 	ldr	x1, [x0]
    40010258:	b98033e0 	ldrsw	x0, [sp, #48]
    4001025c:	d37df000 	lsl	x0, x0, #3
    40010260:	8b000020 	add	x0, x1, x0
    40010264:	f9400000 	ldr	x0, [x0]
    40010268:	92748c00 	and	x0, x0, #0xfffffffff000
    4001026c:	f90013e0 	str	x0, [sp, #32]
        level2[pmdidx] = pde;
    40010270:	b9802fe0 	ldrsw	x0, [sp, #44]
    40010274:	d37df000 	lsl	x0, x0, #3
    40010278:	f94013e1 	ldr	x1, [sp, #32]
    4001027c:	8b000020 	add	x0, x1, x0
    40010280:	f9401fe1 	ldr	x1, [sp, #56]
    40010284:	f9000001 	str	x1, [x0]

        virt = virt + 0x200000;
    40010288:	f9400fe0 	ldr	x0, [sp, #24]
    4001028c:	91480000 	add	x0, x0, #0x200, lsl #12
    40010290:	f9000fe0 	str	x0, [sp, #24]
        phy = phy + 0x200000;
    40010294:	f9400be0 	ldr	x0, [sp, #16]
    40010298:	91480000 	add	x0, x0, #0x200, lsl #12
    4001029c:	f9000be0 	str	x0, [sp, #16]
    for (idx = 0; idx < len; idx = idx + 0x200000) {
    400102a0:	b94037e0 	ldr	w0, [sp, #52]
    400102a4:	11480000 	add	w0, w0, #0x200, lsl #12
    400102a8:	b90037e0 	str	w0, [sp, #52]
    400102ac:	b94037e0 	ldr	w0, [sp, #52]
    400102b0:	b9400fe1 	ldr	w1, [sp, #12]
    400102b4:	6b00003f 	cmp	w1, w0
    400102b8:	54fff7c8 	b.hi	400101b0 <set_bootpgtbl+0x1c>  // b.pmore

    }
}
    400102bc:	d503201f 	nop
    400102c0:	d503201f 	nop
    400102c4:	910103ff 	add	sp, sp, #0x40
    400102c8:	d65f03c0 	ret

00000000400102cc <load_pgtlb>:

void load_pgtlb (uint64* kern_pgtbl, uint64* user_pgtbl)
{
    400102cc:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
    400102d0:	910003fd 	mov	x29, sp
    400102d4:	f9000fe0 	str	x0, [sp, #24]
    400102d8:	f9000be1 	str	x1, [sp, #16]
    char	arch;
    uint32	val32;
    uint64	val64;

    // read the main id register to make sure we are running on ARMv6
    asm("MRS %[r], MIDR_EL1":[r]"=r" (val32): :);
    400102dc:	d5380000 	mrs	x0, midr_el1
    400102e0:	b9002fe0 	str	w0, [sp, #44]

    if (val32 >> 24 == 0x41) {
    400102e4:	b9402fe0 	ldr	w0, [sp, #44]
    400102e8:	53187c00 	lsr	w0, w0, #24
    400102ec:	7101041f 	cmp	w0, #0x41
    400102f0:	54000081 	b.ne	40010300 <load_pgtlb+0x34>  // b.any
        _puts ("Implementer: ARM Limited\n");
    400102f4:	90000000 	adrp	x0, 40010000 <_start>
    400102f8:	911e2000 	add	x0, x0, #0x788
    400102fc:	97ffff66 	bl	40010094 <_puts>
    }

    arch = (val32 >> 16) & 0x0F;
    40010300:	b9402fe0 	ldr	w0, [sp, #44]
    40010304:	53107c00 	lsr	w0, w0, #16
    40010308:	12001c00 	and	w0, w0, #0xff
    4001030c:	12000c00 	and	w0, w0, #0xf
    40010310:	3900afe0 	strb	w0, [sp, #43]

    if ((arch != 7) && (arch != 0xF)) {
    40010314:	3940afe0 	ldrb	w0, [sp, #43]
    40010318:	71001c1f 	cmp	w0, #0x7
    4001031c:	540000e0 	b.eq	40010338 <load_pgtlb+0x6c>  // b.none
    40010320:	3940afe0 	ldrb	w0, [sp, #43]
    40010324:	71003c1f 	cmp	w0, #0xf
    40010328:	54000080 	b.eq	40010338 <load_pgtlb+0x6c>  // b.none
        _puts ("Need AARM v6 or higher\n");
    4001032c:	90000000 	adrp	x0, 40010000 <_start>
    40010330:	911ea000 	add	x0, x0, #0x7a8
    40010334:	97ffff58 	bl	40010094 <_puts>
    }

    //EL?
    asm("MRS %[r], CurrentEL":[r]"=r" (val32): :);
    40010338:	d5384240 	mrs	x0, currentel
    4001033c:	b9002fe0 	str	w0, [sp, #44]

    val32 = (val32 & 0x0C) >> 2;
    40010340:	b9402fe0 	ldr	w0, [sp, #44]
    40010344:	53027c00 	lsr	w0, w0, #2
    40010348:	12000400 	and	w0, w0, #0x3
    4001034c:	b9002fe0 	str	w0, [sp, #44]
    switch(val32) {
    40010350:	b9402fe0 	ldr	w0, [sp, #44]
    40010354:	71000c1f 	cmp	w0, #0x3
    40010358:	540003a0 	b.eq	400103cc <load_pgtlb+0x100>  // b.none
    4001035c:	b9402fe0 	ldr	w0, [sp, #44]
    40010360:	71000c1f 	cmp	w0, #0x3
    40010364:	540003c8 	b.hi	400103dc <load_pgtlb+0x110>  // b.pmore
    40010368:	b9402fe0 	ldr	w0, [sp, #44]
    4001036c:	7100081f 	cmp	w0, #0x2
    40010370:	54000260 	b.eq	400103bc <load_pgtlb+0xf0>  // b.none
    40010374:	b9402fe0 	ldr	w0, [sp, #44]
    40010378:	7100081f 	cmp	w0, #0x2
    4001037c:	54000308 	b.hi	400103dc <load_pgtlb+0x110>  // b.pmore
    40010380:	b9402fe0 	ldr	w0, [sp, #44]
    40010384:	7100001f 	cmp	w0, #0x0
    40010388:	540000a0 	b.eq	4001039c <load_pgtlb+0xd0>  // b.none
    4001038c:	b9402fe0 	ldr	w0, [sp, #44]
    40010390:	7100041f 	cmp	w0, #0x1
    40010394:	540000c0 	b.eq	400103ac <load_pgtlb+0xe0>  // b.none
    40010398:	14000011 	b	400103dc <load_pgtlb+0x110>
        case 0:
            _puts("Current EL: EL0\n");
    4001039c:	90000000 	adrp	x0, 40010000 <_start>
    400103a0:	911f0000 	add	x0, x0, #0x7c0
    400103a4:	97ffff3c 	bl	40010094 <_puts>
            break;
    400103a8:	14000010 	b	400103e8 <load_pgtlb+0x11c>
        case 1:
            _puts("Current EL: EL1\n");
    400103ac:	90000000 	adrp	x0, 40010000 <_start>
    400103b0:	911f6000 	add	x0, x0, #0x7d8
    400103b4:	97ffff38 	bl	40010094 <_puts>
            break;
    400103b8:	1400000c 	b	400103e8 <load_pgtlb+0x11c>
        case 2:
            _puts("Current EL: EL2\n");
    400103bc:	90000000 	adrp	x0, 40010000 <_start>
    400103c0:	911fc000 	add	x0, x0, #0x7f0
    400103c4:	97ffff34 	bl	40010094 <_puts>
            break;
    400103c8:	14000008 	b	400103e8 <load_pgtlb+0x11c>
        case 3:
            _puts("Current EL: EL3\n");
    400103cc:	90000000 	adrp	x0, 40010000 <_start>
    400103d0:	91202000 	add	x0, x0, #0x808
    400103d4:	97ffff30 	bl	40010094 <_puts>
            break;
    400103d8:	14000004 	b	400103e8 <load_pgtlb+0x11c>
        default:
            _puts("Current EL: Unknown\n");
    400103dc:	90000000 	adrp	x0, 40010000 <_start>
    400103e0:	91208000 	add	x0, x0, #0x820
    400103e4:	97ffff2c 	bl	40010094 <_puts>
    }

    // flush TLB and cache
    _puts("Flushing TLB and Instr Cache\n");
    400103e8:	90000000 	adrp	x0, 40010000 <_start>
    400103ec:	9120e000 	add	x0, x0, #0x838
    400103f0:	97ffff29 	bl	40010094 <_puts>

    //flush Instr Cache
    asm("IC IALLUIS": : :);
    400103f4:	d508711f 	ic	ialluis

    //flush TLB
    asm("TLBI VMALLE1" : : :);
    400103f8:	d508871f 	tlbi	vmalle1
    asm("DSB SY" : : :);
    400103fc:	d5033f9f 	dsb	sy

    // no trapping on FP/SIMD instructions
    val32 = 0x03 << 20;
    40010400:	52a00600 	mov	w0, #0x300000              	// #3145728
    40010404:	b9002fe0 	str	w0, [sp, #44]
    asm("MSR CPACR_EL1, %[v]": :[v]"r" (val32):);
    40010408:	b9402fe0 	ldr	w0, [sp, #44]
    4001040c:	d5181040 	msr	cpacr_el1, x0

    // monitor debug: all disabled
    asm("MSR MDSCR_EL1, xzr":::);
    40010410:	d510025f 	msr	mdscr_el1, xzr

    // set memory attribute indirection register
    _puts("Setting Memory Attribute Indirection Register (MAIR_EL1)\n");
    40010414:	90000000 	adrp	x0, 40010000 <_start>
    40010418:	91216000 	add	x0, x0, #0x858
    4001041c:	97ffff1e 	bl	40010094 <_puts>
    val64 = (uint64)0xFF440C0400;
    40010420:	d2808000 	mov	x0, #0x400                 	// #1024
    40010424:	f2a88180 	movk	x0, #0x440c, lsl #16
    40010428:	f2c01fe0 	movk	x0, #0xff, lsl #32
    4001042c:	f90013e0 	str	x0, [sp, #32]
    asm("MSR MAIR_EL1, %[v]": :[v]"r" (val64):);
    40010430:	f94013e0 	ldr	x0, [sp, #32]
    40010434:	d518a200 	msr	mair_el1, x0
    asm("ISB": : :);
    40010438:	d5033fdf 	isb

    // set vector base address register
    _puts("Setting Vector Base Address Register (VBAR_EL1)\n");
    4001043c:	90000000 	adrp	x0, 40010000 <_start>
    40010440:	91226000 	add	x0, x0, #0x898
    40010444:	97ffff14 	bl	40010094 <_puts>
    val64 = (uint64)&vectors;
    40010448:	b0800140 	adrp	x0, ffffffff40039000 <vectors>
    4001044c:	91000000 	add	x0, x0, #0x0
    40010450:	f90013e0 	str	x0, [sp, #32]
    //val64 = val64 + (uint64)KERNBASE;
    asm("MSR VBAR_EL1, %[v]": :[v]"r" (val64):);
    40010454:	f94013e0 	ldr	x0, [sp, #32]
    40010458:	d518c000 	msr	vbar_el1, x0

    // set translation control register
    _puts("Setting Translation Control Register (TCR_EL1)\n");
    4001045c:	90000000 	adrp	x0, 40010000 <_start>
    40010460:	91234000 	add	x0, x0, #0x8d0
    40010464:	97ffff0c 	bl	40010094 <_puts>
    val64 = (uint64)0x34B5203520;
    40010468:	d286a400 	mov	x0, #0x3520                	// #13600
    4001046c:	f2b6a400 	movk	x0, #0xb520, lsl #16
    40010470:	f2c00680 	movk	x0, #0x34, lsl #32
    40010474:	f90013e0 	str	x0, [sp, #32]
    asm("MSR TCR_EL1, %[v]": :[v]"r" (val64):);
    40010478:	f94013e0 	ldr	x0, [sp, #32]
    4001047c:	d5182040 	msr	tcr_el1, x0
    asm("ISB": : :);
    40010480:	d5033fdf 	isb

    // set translation table base register 1 (kernel)
    _puts("Setting Translation Table Base Register 1 (TTBR1_EL1)\n");
    40010484:	90000000 	adrp	x0, 40010000 <_start>
    40010488:	91240000 	add	x0, x0, #0x900
    4001048c:	97ffff02 	bl	40010094 <_puts>
    val64 = (uint64)kernel_pgtbl;
    40010490:	90000000 	adrp	x0, 40010000 <_start>
    40010494:	9128a000 	add	x0, x0, #0xa28
    40010498:	f9400000 	ldr	x0, [x0]
    4001049c:	f90013e0 	str	x0, [sp, #32]
    asm("MSR TTBR1_EL1, %[v]": :[v]"r" (val64):);
    400104a0:	f94013e0 	ldr	x0, [sp, #32]
    400104a4:	d5182020 	msr	ttbr1_el1, x0

    // set translation table base register 0 (user)
    _puts("Setting Translation Table Base Register 0 (TTBR0_EL1)\n");
    400104a8:	90000000 	adrp	x0, 40010000 <_start>
    400104ac:	9124e000 	add	x0, x0, #0x938
    400104b0:	97fffef9 	bl	40010094 <_puts>
    val64 = (uint64)user_pgtbl;
    400104b4:	f9400be0 	ldr	x0, [sp, #16]
    400104b8:	f90013e0 	str	x0, [sp, #32]
    asm("MSR TTBR0_EL1, %[v]": :[v]"r" (val64):);
    400104bc:	f94013e0 	ldr	x0, [sp, #32]
    400104c0:	d5182000 	msr	ttbr0_el1, x0
    asm("ISB":::);
    400104c4:	d5033fdf 	isb

    // set system control register
    _puts("Setting System Control Register (SCTLR_EL1)\n");
    400104c8:	90000000 	adrp	x0, 40010000 <_start>
    400104cc:	9125c000 	add	x0, x0, #0x970
    400104d0:	97fffef1 	bl	40010094 <_puts>
    asm("MRS %[r], SCTLR_EL1":[r]"=r" (val32): :); //0x0000000000c50838
    400104d4:	d5381000 	mrs	x0, sctlr_el1
    400104d8:	b9002fe0 	str	w0, [sp, #44]
    val32 = val32 | 0x01;
    400104dc:	b9402fe0 	ldr	w0, [sp, #44]
    400104e0:	32000000 	orr	w0, w0, #0x1
    400104e4:	b9002fe0 	str	w0, [sp, #44]
    asm("MSR SCTLR_EL1, %[v]": :[v]"r" (val32):);
    400104e8:	b9402fe0 	ldr	w0, [sp, #44]
    400104ec:	d5181000 	msr	sctlr_el1, x0
    asm("ISB": : :);
    400104f0:	d5033fdf 	isb

    _puts("System Configure Completed...\n\n");
    400104f4:	90000000 	adrp	x0, 40010000 <_start>
    400104f8:	91268000 	add	x0, x0, #0x9a0
    400104fc:	97fffee6 	bl	40010094 <_puts>

}
    40010500:	d503201f 	nop
    40010504:	a8c37bfd 	ldp	x29, x30, [sp], #48
    40010508:	d65f03c0 	ret

000000004001050c <clear_bss>:
extern void jump_stack (void);
extern void kmain (void);

// clear the BSS section for the main kernel, see kernel.ld
void clear_bss (void)
{
    4001050c:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
    40010510:	910003fd 	mov	x29, sp
    _puts("clearing BSS section for the main kernel\n");
    40010514:	90000000 	adrp	x0, 40010000 <_start>
    40010518:	91270000 	add	x0, x0, #0x9c0
    4001051c:	97fffede 	bl	40010094 <_puts>
    memset(&edata, 0x00, &end-&edata);
    40010520:	908006a0 	adrp	x0, ffffffff400e4000 <end>
    40010524:	91000001 	add	x1, x0, #0x0
    40010528:	90800560 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
    4001052c:	91054000 	add	x0, x0, #0x150
    40010530:	cb000020 	sub	x0, x1, x0
    40010534:	9343fc00 	asr	x0, x0, #3
    40010538:	2a0003e2 	mov	w2, w0
    4001053c:	52800001 	mov	w1, #0x0                   	// #0
    40010540:	90800560 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
    40010544:	91054000 	add	x0, x0, #0x150
    40010548:	9400007c 	bl	40010738 <__memset_veneer>
}
    4001054c:	d503201f 	nop
    40010550:	a8c17bfd 	ldp	x29, x30, [sp], #16
    40010554:	d65f03c0 	ret

0000000040010558 <start>:

void start (void)
{
    40010558:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
    4001055c:	910003fd 	mov	x29, sp
    uint64	l2pgtbl;
    uint	index;

    _puts("starting xv6 for ARMv8...\n");
    40010560:	90000000 	adrp	x0, 40010000 <_start>
    40010564:	9127c000 	add	x0, x0, #0x9f0
    40010568:	97fffecb 	bl	40010094 <_puts>

    // Set PGD Entries (4 entries...supporting 32 bits)
    for(index = 0; index < 4; index++) {
    4001056c:	b9001fff 	str	wzr, [sp, #28]
    40010570:	14000018 	b	400105d0 <start+0x78>
        l2pgtbl = (uint64)&_K_l2_pgtbl;
    40010574:	b0000020 	adrp	x0, 40015000 <_K_l2_pgtbl>
    40010578:	91000000 	add	x0, x0, #0x0
    4001057c:	f9000be0 	str	x0, [sp, #16]
        l2pgtbl += index * 4096;
    40010580:	b9401fe0 	ldr	w0, [sp, #28]
    40010584:	53144c00 	lsl	w0, w0, #12
    40010588:	2a0003e0 	mov	w0, w0
    4001058c:	f9400be1 	ldr	x1, [sp, #16]
    40010590:	8b000020 	add	x0, x1, x0
    40010594:	f9000be0 	str	x0, [sp, #16]
        l2pgtbl = l2pgtbl | ENTRY_TABLE | ENTRY_VALID;
    40010598:	f9400be0 	ldr	x0, [sp, #16]
    4001059c:	b2400400 	orr	x0, x0, #0x3
    400105a0:	f9000be0 	str	x0, [sp, #16]
        kernel_pgtbl[index] = l2pgtbl;
    400105a4:	90000000 	adrp	x0, 40010000 <_start>
    400105a8:	9128a000 	add	x0, x0, #0xa28
    400105ac:	f9400001 	ldr	x1, [x0]
    400105b0:	b9401fe0 	ldr	w0, [sp, #28]
    400105b4:	d37df000 	lsl	x0, x0, #3
    400105b8:	8b000020 	add	x0, x1, x0
    400105bc:	f9400be1 	ldr	x1, [sp, #16]
    400105c0:	f9000001 	str	x1, [x0]
    for(index = 0; index < 4; index++) {
    400105c4:	b9401fe0 	ldr	w0, [sp, #28]
    400105c8:	11000400 	add	w0, w0, #0x1
    400105cc:	b9001fe0 	str	w0, [sp, #28]
    400105d0:	b9401fe0 	ldr	w0, [sp, #28]
    400105d4:	71000c1f 	cmp	w0, #0x3
    400105d8:	54fffce9 	b.ls	40010574 <start+0x1c>  // b.plast
    }

    for(index = 0; index < 4; index++) {
    400105dc:	b9001fff 	str	wzr, [sp, #28]
    400105e0:	14000018 	b	40010640 <start+0xe8>
        l2pgtbl = (uint64)&_U_l2_pgtbl;
    400105e4:	b0000040 	adrp	x0, 40019000 <_U_l2_pgtbl>
    400105e8:	91000000 	add	x0, x0, #0x0
    400105ec:	f9000be0 	str	x0, [sp, #16]
        l2pgtbl += index * 4096;
    400105f0:	b9401fe0 	ldr	w0, [sp, #28]
    400105f4:	53144c00 	lsl	w0, w0, #12
    400105f8:	2a0003e0 	mov	w0, w0
    400105fc:	f9400be1 	ldr	x1, [sp, #16]
    40010600:	8b000020 	add	x0, x1, x0
    40010604:	f9000be0 	str	x0, [sp, #16]
        l2pgtbl = l2pgtbl | ENTRY_TABLE | ENTRY_VALID;
    40010608:	f9400be0 	ldr	x0, [sp, #16]
    4001060c:	b2400400 	orr	x0, x0, #0x3
    40010610:	f9000be0 	str	x0, [sp, #16]
        user_pgtbl[index] = l2pgtbl;
    40010614:	90000000 	adrp	x0, 40010000 <_start>
    40010618:	9128c000 	add	x0, x0, #0xa30
    4001061c:	f9400001 	ldr	x1, [x0]
    40010620:	b9401fe0 	ldr	w0, [sp, #28]
    40010624:	d37df000 	lsl	x0, x0, #3
    40010628:	8b000020 	add	x0, x1, x0
    4001062c:	f9400be1 	ldr	x1, [sp, #16]
    40010630:	f9000001 	str	x1, [x0]
    for(index = 0; index < 4; index++) {
    40010634:	b9401fe0 	ldr	w0, [sp, #28]
    40010638:	11000400 	add	w0, w0, #0x1
    4001063c:	b9001fe0 	str	w0, [sp, #28]
    40010640:	b9401fe0 	ldr	w0, [sp, #28]
    40010644:	71000c1f 	cmp	w0, #0x3
    40010648:	54fffce9 	b.ls	400105e4 <start+0x8c>  // b.plast
    }

    // double map the low memory, required to enable paging
    // we do not map all the physical memory
    set_bootpgtbl((uint64)PHY_START, (uint64)PHY_START, INIT_KERN_SZ, 0);
    4001064c:	52800003 	mov	w3, #0x0                   	// #0
    40010650:	52a00402 	mov	w2, #0x200000              	// #2097152
    40010654:	d2a80001 	mov	x1, #0x40000000            	// #1073741824
    40010658:	d2a80000 	mov	x0, #0x40000000            	// #1073741824
    4001065c:	97fffece 	bl	40010194 <set_bootpgtbl>
    set_bootpgtbl((uint64)KERNBASE + (uint64)PHY_START, (uint64)PHY_START, INIT_KERN_SZ, 0);
    40010660:	52800003 	mov	w3, #0x0                   	// #0
    40010664:	52a00402 	mov	w2, #0x200000              	// #2097152
    40010668:	d2a80001 	mov	x1, #0x40000000            	// #1073741824
    4001066c:	929fffe0 	mov	x0, #0xffffffffffff0000    	// #-65536
    40010670:	f2a80000 	movk	x0, #0x4000, lsl #16
    40010674:	97fffec8 	bl	40010194 <set_bootpgtbl>

    //add to prevent crash on _puts
    set_bootpgtbl((uint64)DEVBASE2, (uint64)DEVBASE2, DEV_MEM_SZ, 1); // V, P, SZ, ISDEV
    40010678:	52800023 	mov	w3, #0x1                   	// #1
    4001067c:	52a02002 	mov	w2, #0x1000000             	// #16777216
    40010680:	d2a12001 	mov	x1, #0x9000000             	// #150994944
    40010684:	d2a12000 	mov	x0, #0x9000000             	// #150994944
    40010688:	97fffec3 	bl	40010194 <set_bootpgtbl>

    // V, P, len, is_mem
    set_bootpgtbl((uint64)KERNBASE+(uint64)DEVBASE1, (uint64)DEVBASE1, DEV_MEM_SZ, 1); // V, P, SZ, ISDEV
    4001068c:	52800023 	mov	w3, #0x1                   	// #1
    40010690:	52a02002 	mov	w2, #0x1000000             	// #16777216
    40010694:	d2a10001 	mov	x1, #0x8000000             	// #134217728
    40010698:	929fffe0 	mov	x0, #0xffffffffffff0000    	// #-65536
    4001069c:	f2a10000 	movk	x0, #0x800, lsl #16
    400106a0:	97fffebd 	bl	40010194 <set_bootpgtbl>
    set_bootpgtbl((uint64)KERNBASE+(uint64)DEVBASE2, (uint64)DEVBASE2, DEV_MEM_SZ, 1); // V, P, SZ, ISDEV
    400106a4:	52800023 	mov	w3, #0x1                   	// #1
    400106a8:	52a02002 	mov	w2, #0x1000000             	// #16777216
    400106ac:	d2a12001 	mov	x1, #0x9000000             	// #150994944
    400106b0:	929fffe0 	mov	x0, #0xffffffffffff0000    	// #-65536
    400106b4:	f2a12000 	movk	x0, #0x900, lsl #16
    400106b8:	97fffeb7 	bl	40010194 <set_bootpgtbl>
    set_bootpgtbl((uint64)KERNBASE+(uint64)DEVBASE3, (uint64)DEVBASE2, DEV_MEM_SZ, 1); // V, P, SZ, ISDEV
    400106bc:	52800023 	mov	w3, #0x1                   	// #1
    400106c0:	52a02002 	mov	w2, #0x1000000             	// #16777216
    400106c4:	d2a12001 	mov	x1, #0x9000000             	// #150994944
    400106c8:	929fffe0 	mov	x0, #0xffffffffffff0000    	// #-65536
    400106cc:	f2a14000 	movk	x0, #0xa00, lsl #16
    400106d0:	97fffeb1 	bl	40010194 <set_bootpgtbl>

    load_pgtlb (kernel_pgtbl, user_pgtbl);
    400106d4:	90000000 	adrp	x0, 40010000 <_start>
    400106d8:	9128a000 	add	x0, x0, #0xa28
    400106dc:	f9400002 	ldr	x2, [x0]
    400106e0:	90000000 	adrp	x0, 40010000 <_start>
    400106e4:	9128c000 	add	x0, x0, #0xa30
    400106e8:	f9400000 	ldr	x0, [x0]
    400106ec:	aa0003e1 	mov	x1, x0
    400106f0:	aa0203e0 	mov	x0, x2
    400106f4:	97fffef6 	bl	400102cc <load_pgtlb>

    // Chnage SP from physical to virtual
    jump_stack ();
    400106f8:	97fffe51 	bl	4001003c <jump_stack>

    // We can now call normal kernel functions at high memory
    clear_bss ();
    400106fc:	97ffff84 	bl	4001050c <clear_bss>

    _puts("Starting Kernel\n");
    40010700:	90000000 	adrp	x0, 40010000 <_start>
    40010704:	91284000 	add	x0, x0, #0xa10
    40010708:	97fffe63 	bl	40010094 <_puts>
    kmain ();
    4001070c:	94000007 	bl	40010728 <__kmain_veneer>
}
    40010710:	d503201f 	nop
    40010714:	a8c27bfd 	ldp	x29, x30, [sp], #32
    40010718:	d65f03c0 	ret
    4001071c:	00000000 	udf	#0
    40010720:	1400000e 	b	40010758 <__memset_veneer+0x20>
    40010724:	d503201f 	nop

0000000040010728 <__kmain_veneer>:
    40010728:	90800130 	adrp	x16, ffffffff40034000 <read_head+0x50>
    4001072c:	910fd210 	add	x16, x16, #0x3f4
    40010730:	d61f0200 	br	x16
    40010734:	00000000 	udf	#0

0000000040010738 <__memset_veneer>:
    40010738:	90800110 	adrp	x16, ffffffff40030000 <memset>
    4001073c:	91000210 	add	x16, x16, #0x0
    40010740:	d61f0200 	br	x16
	...
    40010758:	33323130 	.word	0x33323130
    4001075c:	37363534 	.word	0x37363534
    40010760:	42413938 	.word	0x42413938
    40010764:	46454443 	.word	0x46454443
	...
    40010770:	65637845 	.word	0x65637845
    40010774:	6f697470 	.word	0x6f697470
    40010778:	6152206e 	.word	0x6152206e
    4001077c:	64657369 	.word	0x64657369
    40010780:	0000000a 	.word	0x0000000a
    40010784:	00000000 	.word	0x00000000
    40010788:	6c706d49 	.word	0x6c706d49
    4001078c:	6e656d65 	.word	0x6e656d65
    40010790:	3a726574 	.word	0x3a726574
    40010794:	4d524120 	.word	0x4d524120
    40010798:	6d694c20 	.word	0x6d694c20
    4001079c:	64657469 	.word	0x64657469
    400107a0:	0000000a 	.word	0x0000000a
    400107a4:	00000000 	.word	0x00000000
    400107a8:	6465654e 	.word	0x6465654e
    400107ac:	52414120 	.word	0x52414120
    400107b0:	3676204d 	.word	0x3676204d
    400107b4:	20726f20 	.word	0x20726f20
    400107b8:	68676968 	.word	0x68676968
    400107bc:	000a7265 	.word	0x000a7265
    400107c0:	72727543 	.word	0x72727543
    400107c4:	20746e65 	.word	0x20746e65
    400107c8:	203a4c45 	.word	0x203a4c45
    400107cc:	0a304c45 	.word	0x0a304c45
	...
    400107d8:	72727543 	.word	0x72727543
    400107dc:	20746e65 	.word	0x20746e65
    400107e0:	203a4c45 	.word	0x203a4c45
    400107e4:	0a314c45 	.word	0x0a314c45
	...
    400107f0:	72727543 	.word	0x72727543
    400107f4:	20746e65 	.word	0x20746e65
    400107f8:	203a4c45 	.word	0x203a4c45
    400107fc:	0a324c45 	.word	0x0a324c45
	...
    40010808:	72727543 	.word	0x72727543
    4001080c:	20746e65 	.word	0x20746e65
    40010810:	203a4c45 	.word	0x203a4c45
    40010814:	0a334c45 	.word	0x0a334c45
	...
    40010820:	72727543 	.word	0x72727543
    40010824:	20746e65 	.word	0x20746e65
    40010828:	203a4c45 	.word	0x203a4c45
    4001082c:	6e6b6e55 	.word	0x6e6b6e55
    40010830:	0a6e776f 	.word	0x0a6e776f
    40010834:	00000000 	.word	0x00000000
    40010838:	73756c46 	.word	0x73756c46
    4001083c:	676e6968 	.word	0x676e6968
    40010840:	424c5420 	.word	0x424c5420
    40010844:	646e6120 	.word	0x646e6120
    40010848:	736e4920 	.word	0x736e4920
    4001084c:	43207274 	.word	0x43207274
    40010850:	65686361 	.word	0x65686361
    40010854:	0000000a 	.word	0x0000000a
    40010858:	74746553 	.word	0x74746553
    4001085c:	20676e69 	.word	0x20676e69
    40010860:	6f6d654d 	.word	0x6f6d654d
    40010864:	41207972 	.word	0x41207972
    40010868:	69727474 	.word	0x69727474
    4001086c:	65747562 	.word	0x65747562
    40010870:	646e4920 	.word	0x646e4920
    40010874:	63657269 	.word	0x63657269
    40010878:	6e6f6974 	.word	0x6e6f6974
    4001087c:	67655220 	.word	0x67655220
    40010880:	65747369 	.word	0x65747369
    40010884:	4d282072 	.word	0x4d282072
    40010888:	5f524941 	.word	0x5f524941
    4001088c:	29314c45 	.word	0x29314c45
    40010890:	0000000a 	.word	0x0000000a
    40010894:	00000000 	.word	0x00000000
    40010898:	74746553 	.word	0x74746553
    4001089c:	20676e69 	.word	0x20676e69
    400108a0:	74636556 	.word	0x74636556
    400108a4:	4220726f 	.word	0x4220726f
    400108a8:	20657361 	.word	0x20657361
    400108ac:	72646441 	.word	0x72646441
    400108b0:	20737365 	.word	0x20737365
    400108b4:	69676552 	.word	0x69676552
    400108b8:	72657473 	.word	0x72657473
    400108bc:	42562820 	.word	0x42562820
    400108c0:	455f5241 	.word	0x455f5241
    400108c4:	0a29314c 	.word	0x0a29314c
	...
    400108d0:	74746553 	.word	0x74746553
    400108d4:	20676e69 	.word	0x20676e69
    400108d8:	6e617254 	.word	0x6e617254
    400108dc:	74616c73 	.word	0x74616c73
    400108e0:	206e6f69 	.word	0x206e6f69
    400108e4:	746e6f43 	.word	0x746e6f43
    400108e8:	206c6f72 	.word	0x206c6f72
    400108ec:	69676552 	.word	0x69676552
    400108f0:	72657473 	.word	0x72657473
    400108f4:	43542820 	.word	0x43542820
    400108f8:	4c455f52 	.word	0x4c455f52
    400108fc:	000a2931 	.word	0x000a2931
    40010900:	74746553 	.word	0x74746553
    40010904:	20676e69 	.word	0x20676e69
    40010908:	6e617254 	.word	0x6e617254
    4001090c:	74616c73 	.word	0x74616c73
    40010910:	206e6f69 	.word	0x206e6f69
    40010914:	6c626154 	.word	0x6c626154
    40010918:	61422065 	.word	0x61422065
    4001091c:	52206573 	.word	0x52206573
    40010920:	73696765 	.word	0x73696765
    40010924:	20726574 	.word	0x20726574
    40010928:	54282031 	.word	0x54282031
    4001092c:	31524254 	.word	0x31524254
    40010930:	314c455f 	.word	0x314c455f
    40010934:	00000a29 	.word	0x00000a29
    40010938:	74746553 	.word	0x74746553
    4001093c:	20676e69 	.word	0x20676e69
    40010940:	6e617254 	.word	0x6e617254
    40010944:	74616c73 	.word	0x74616c73
    40010948:	206e6f69 	.word	0x206e6f69
    4001094c:	6c626154 	.word	0x6c626154
    40010950:	61422065 	.word	0x61422065
    40010954:	52206573 	.word	0x52206573
    40010958:	73696765 	.word	0x73696765
    4001095c:	20726574 	.word	0x20726574
    40010960:	54282030 	.word	0x54282030
    40010964:	30524254 	.word	0x30524254
    40010968:	314c455f 	.word	0x314c455f
    4001096c:	00000a29 	.word	0x00000a29
    40010970:	74746553 	.word	0x74746553
    40010974:	20676e69 	.word	0x20676e69
    40010978:	74737953 	.word	0x74737953
    4001097c:	43206d65 	.word	0x43206d65
    40010980:	72746e6f 	.word	0x72746e6f
    40010984:	52206c6f 	.word	0x52206c6f
    40010988:	73696765 	.word	0x73696765
    4001098c:	20726574 	.word	0x20726574
    40010990:	54435328 	.word	0x54435328
    40010994:	455f524c 	.word	0x455f524c
    40010998:	0a29314c 	.word	0x0a29314c
    4001099c:	00000000 	.word	0x00000000
    400109a0:	74737953 	.word	0x74737953
    400109a4:	43206d65 	.word	0x43206d65
    400109a8:	69666e6f 	.word	0x69666e6f
    400109ac:	65727567 	.word	0x65727567
    400109b0:	6d6f4320 	.word	0x6d6f4320
    400109b4:	74656c70 	.word	0x74656c70
    400109b8:	2e2e6465 	.word	0x2e2e6465
    400109bc:	000a0a2e 	.word	0x000a0a2e
    400109c0:	61656c63 	.word	0x61656c63
    400109c4:	676e6972 	.word	0x676e6972
    400109c8:	53534220 	.word	0x53534220
    400109cc:	63657320 	.word	0x63657320
    400109d0:	6e6f6974 	.word	0x6e6f6974
    400109d4:	726f6620 	.word	0x726f6620
    400109d8:	65687420 	.word	0x65687420
    400109dc:	69616d20 	.word	0x69616d20
    400109e0:	656b206e 	.word	0x656b206e
    400109e4:	6c656e72 	.word	0x6c656e72
    400109e8:	0000000a 	.word	0x0000000a
    400109ec:	00000000 	.word	0x00000000
    400109f0:	72617473 	.word	0x72617473
    400109f4:	676e6974 	.word	0x676e6974
    400109f8:	36767820 	.word	0x36767820
    400109fc:	726f6620 	.word	0x726f6620
    40010a00:	4d524120 	.word	0x4d524120
    40010a04:	2e2e3876 	.word	0x2e2e3876
    40010a08:	00000a2e 	.word	0x00000a2e
    40010a0c:	00000000 	.word	0x00000000
    40010a10:	72617453 	.word	0x72617453
    40010a14:	676e6974 	.word	0x676e6974
    40010a18:	72654b20 	.word	0x72654b20
    40010a1c:	0a6c656e 	.word	0x0a6c656e
	...

0000000040010a28 <kernel_pgtbl>:
    40010a28:	40013000 00000000                       .0.@....

0000000040010a30 <user_pgtbl>:
    40010a30:	40014000 00000000                       .@.@....

0000000040010a38 <edata_entry>:
	...

0000000040013000 <_kernel_pgtbl>:
	...

0000000040014000 <_user_pgtbl>:
	...

0000000040015000 <_K_l2_pgtbl>:
	...

0000000040019000 <_U_l2_pgtbl>:
	...

Disassembly of section .text:

ffffffff40030000 <memset>:
#include "types.h"
#include "arm.h"


void* memset(void *dst, int v, int n)
{
ffffffff40030000:	d100c3ff 	sub	sp, sp, #0x30
ffffffff40030004:	f90007e0 	str	x0, [sp, #8]
ffffffff40030008:	b90007e1 	str	w1, [sp, #4]
ffffffff4003000c:	b90003e2 	str	w2, [sp]
    uint8	*p;
    uint8	c;
    uint32	val;
    uint32	*p4;

    p   = dst;
ffffffff40030010:	f94007e0 	ldr	x0, [sp, #8]
ffffffff40030014:	f90017e0 	str	x0, [sp, #40]
    c   = v & 0xff;
ffffffff40030018:	b94007e0 	ldr	w0, [sp, #4]
ffffffff4003001c:	39007fe0 	strb	w0, [sp, #31]
    val = (c << 24) | (c << 16) | (c << 8) | c;
ffffffff40030020:	39407fe1 	ldrb	w1, [sp, #31]
ffffffff40030024:	2a0103e0 	mov	w0, w1
ffffffff40030028:	53185c00 	lsl	w0, w0, #8
ffffffff4003002c:	0b010000 	add	w0, w0, w1
ffffffff40030030:	53103c00 	lsl	w0, w0, #16
ffffffff40030034:	2a0003e1 	mov	w1, w0
ffffffff40030038:	39407fe0 	ldrb	w0, [sp, #31]
ffffffff4003003c:	53185c00 	lsl	w0, w0, #8
ffffffff40030040:	2a000021 	orr	w1, w1, w0
ffffffff40030044:	39407fe0 	ldrb	w0, [sp, #31]
ffffffff40030048:	2a000020 	orr	w0, w1, w0
ffffffff4003004c:	b9001be0 	str	w0, [sp, #24]

    // set bytes before whole uint32
    for (; (n > 0) && ((uint64)p % 4); n--, p++){
ffffffff40030050:	1400000a 	b	ffffffff40030078 <memset+0x78>
        *p = c;
ffffffff40030054:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40030058:	39407fe1 	ldrb	w1, [sp, #31]
ffffffff4003005c:	39000001 	strb	w1, [x0]
    for (; (n > 0) && ((uint64)p % 4); n--, p++){
ffffffff40030060:	b94003e0 	ldr	w0, [sp]
ffffffff40030064:	51000400 	sub	w0, w0, #0x1
ffffffff40030068:	b90003e0 	str	w0, [sp]
ffffffff4003006c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40030070:	91000400 	add	x0, x0, #0x1
ffffffff40030074:	f90017e0 	str	x0, [sp, #40]
ffffffff40030078:	b94003e0 	ldr	w0, [sp]
ffffffff4003007c:	7100001f 	cmp	w0, #0x0
ffffffff40030080:	540000ad 	b.le	ffffffff40030094 <memset+0x94>
ffffffff40030084:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40030088:	92400400 	and	x0, x0, #0x3
ffffffff4003008c:	f100001f 	cmp	x0, #0x0
ffffffff40030090:	54fffe21 	b.ne	ffffffff40030054 <memset+0x54>  // b.any
    }

    // set memory 4 bytes a time
    p4 = (uint*)p;
ffffffff40030094:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40030098:	f90013e0 	str	x0, [sp, #32]

    for (; n >= 4; n -= 4, p4++) {
ffffffff4003009c:	1400000a 	b	ffffffff400300c4 <memset+0xc4>
        *p4 = val;
ffffffff400300a0:	f94013e0 	ldr	x0, [sp, #32]
ffffffff400300a4:	b9401be1 	ldr	w1, [sp, #24]
ffffffff400300a8:	b9000001 	str	w1, [x0]
    for (; n >= 4; n -= 4, p4++) {
ffffffff400300ac:	b94003e0 	ldr	w0, [sp]
ffffffff400300b0:	51001000 	sub	w0, w0, #0x4
ffffffff400300b4:	b90003e0 	str	w0, [sp]
ffffffff400300b8:	f94013e0 	ldr	x0, [sp, #32]
ffffffff400300bc:	91001000 	add	x0, x0, #0x4
ffffffff400300c0:	f90013e0 	str	x0, [sp, #32]
ffffffff400300c4:	b94003e0 	ldr	w0, [sp]
ffffffff400300c8:	71000c1f 	cmp	w0, #0x3
ffffffff400300cc:	54fffeac 	b.gt	ffffffff400300a0 <memset+0xa0>
    }

    // set leftover one byte a time
    p = (uint8*)p4;
ffffffff400300d0:	f94013e0 	ldr	x0, [sp, #32]
ffffffff400300d4:	f90017e0 	str	x0, [sp, #40]

    for (; n > 0; n--, p++) {
ffffffff400300d8:	1400000a 	b	ffffffff40030100 <memset+0x100>
        *p = c;
ffffffff400300dc:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400300e0:	39407fe1 	ldrb	w1, [sp, #31]
ffffffff400300e4:	39000001 	strb	w1, [x0]
    for (; n > 0; n--, p++) {
ffffffff400300e8:	b94003e0 	ldr	w0, [sp]
ffffffff400300ec:	51000400 	sub	w0, w0, #0x1
ffffffff400300f0:	b90003e0 	str	w0, [sp]
ffffffff400300f4:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400300f8:	91000400 	add	x0, x0, #0x1
ffffffff400300fc:	f90017e0 	str	x0, [sp, #40]
ffffffff40030100:	b94003e0 	ldr	w0, [sp]
ffffffff40030104:	7100001f 	cmp	w0, #0x0
ffffffff40030108:	54fffeac 	b.gt	ffffffff400300dc <memset+0xdc>
    }

    return dst;
ffffffff4003010c:	f94007e0 	ldr	x0, [sp, #8]
}
ffffffff40030110:	9100c3ff 	add	sp, sp, #0x30
ffffffff40030114:	d65f03c0 	ret

ffffffff40030118 <memcmp>:


int memcmp(const void *v1, const void *v2, uint n)
{
ffffffff40030118:	d100c3ff 	sub	sp, sp, #0x30
ffffffff4003011c:	f9000fe0 	str	x0, [sp, #24]
ffffffff40030120:	f9000be1 	str	x1, [sp, #16]
ffffffff40030124:	b9000fe2 	str	w2, [sp, #12]
    const uchar *s1, *s2;

    s1 = v1;
ffffffff40030128:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003012c:	f90017e0 	str	x0, [sp, #40]
    s2 = v2;
ffffffff40030130:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40030134:	f90013e0 	str	x0, [sp, #32]

    while(n-- > 0){
ffffffff40030138:	14000014 	b	ffffffff40030188 <memcmp+0x70>
        if(*s1 != *s2) {
ffffffff4003013c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40030140:	39400001 	ldrb	w1, [x0]
ffffffff40030144:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40030148:	39400000 	ldrb	w0, [x0]
ffffffff4003014c:	6b00003f 	cmp	w1, w0
ffffffff40030150:	54000100 	b.eq	ffffffff40030170 <memcmp+0x58>  // b.none
            return *s1 - *s2;
ffffffff40030154:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40030158:	39400000 	ldrb	w0, [x0]
ffffffff4003015c:	2a0003e1 	mov	w1, w0
ffffffff40030160:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40030164:	39400000 	ldrb	w0, [x0]
ffffffff40030168:	4b000020 	sub	w0, w1, w0
ffffffff4003016c:	1400000d 	b	ffffffff400301a0 <memcmp+0x88>
        }

        s1++, s2++;
ffffffff40030170:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40030174:	91000400 	add	x0, x0, #0x1
ffffffff40030178:	f90017e0 	str	x0, [sp, #40]
ffffffff4003017c:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40030180:	91000400 	add	x0, x0, #0x1
ffffffff40030184:	f90013e0 	str	x0, [sp, #32]
    while(n-- > 0){
ffffffff40030188:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff4003018c:	51000401 	sub	w1, w0, #0x1
ffffffff40030190:	b9000fe1 	str	w1, [sp, #12]
ffffffff40030194:	7100001f 	cmp	w0, #0x0
ffffffff40030198:	54fffd21 	b.ne	ffffffff4003013c <memcmp+0x24>  // b.any
    }

    return 0;
ffffffff4003019c:	52800000 	mov	w0, #0x0                   	// #0
}
ffffffff400301a0:	9100c3ff 	add	sp, sp, #0x30
ffffffff400301a4:	d65f03c0 	ret

ffffffff400301a8 <memmove>:

void* memmove(void *dst, const void *src, uint n)
{
ffffffff400301a8:	d100c3ff 	sub	sp, sp, #0x30
ffffffff400301ac:	f9000fe0 	str	x0, [sp, #24]
ffffffff400301b0:	f9000be1 	str	x1, [sp, #16]
ffffffff400301b4:	b9000fe2 	str	w2, [sp, #12]
    const char *s;
    char *d;

    s = src;
ffffffff400301b8:	f9400be0 	ldr	x0, [sp, #16]
ffffffff400301bc:	f90017e0 	str	x0, [sp, #40]
    d = dst;
ffffffff400301c0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400301c4:	f90013e0 	str	x0, [sp, #32]

    if(s < d && s + n > d){
ffffffff400301c8:	f94017e1 	ldr	x1, [sp, #40]
ffffffff400301cc:	f94013e0 	ldr	x0, [sp, #32]
ffffffff400301d0:	eb00003f 	cmp	x1, x0
ffffffff400301d4:	54000502 	b.cs	ffffffff40030274 <memmove+0xcc>  // b.hs, b.nlast
ffffffff400301d8:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff400301dc:	f94017e1 	ldr	x1, [sp, #40]
ffffffff400301e0:	8b000020 	add	x0, x1, x0
ffffffff400301e4:	f94013e1 	ldr	x1, [sp, #32]
ffffffff400301e8:	eb00003f 	cmp	x1, x0
ffffffff400301ec:	54000442 	b.cs	ffffffff40030274 <memmove+0xcc>  // b.hs, b.nlast
        s += n;
ffffffff400301f0:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff400301f4:	f94017e1 	ldr	x1, [sp, #40]
ffffffff400301f8:	8b000020 	add	x0, x1, x0
ffffffff400301fc:	f90017e0 	str	x0, [sp, #40]
        d += n;
ffffffff40030200:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff40030204:	f94013e1 	ldr	x1, [sp, #32]
ffffffff40030208:	8b000020 	add	x0, x1, x0
ffffffff4003020c:	f90013e0 	str	x0, [sp, #32]

        while(n-- > 0) {
ffffffff40030210:	1400000b 	b	ffffffff4003023c <memmove+0x94>
            *--d = *--s;
ffffffff40030214:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40030218:	d1000400 	sub	x0, x0, #0x1
ffffffff4003021c:	f90017e0 	str	x0, [sp, #40]
ffffffff40030220:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40030224:	d1000400 	sub	x0, x0, #0x1
ffffffff40030228:	f90013e0 	str	x0, [sp, #32]
ffffffff4003022c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40030230:	39400001 	ldrb	w1, [x0]
ffffffff40030234:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40030238:	39000001 	strb	w1, [x0]
        while(n-- > 0) {
ffffffff4003023c:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff40030240:	51000401 	sub	w1, w0, #0x1
ffffffff40030244:	b9000fe1 	str	w1, [sp, #12]
ffffffff40030248:	7100001f 	cmp	w0, #0x0
ffffffff4003024c:	54fffe41 	b.ne	ffffffff40030214 <memmove+0x6c>  // b.any
    if(s < d && s + n > d){
ffffffff40030250:	1400000e 	b	ffffffff40030288 <memmove+0xe0>
        }

    } else {
        while(n-- > 0) {
            *d++ = *s++;
ffffffff40030254:	f94017e1 	ldr	x1, [sp, #40]
ffffffff40030258:	91000420 	add	x0, x1, #0x1
ffffffff4003025c:	f90017e0 	str	x0, [sp, #40]
ffffffff40030260:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40030264:	91000402 	add	x2, x0, #0x1
ffffffff40030268:	f90013e2 	str	x2, [sp, #32]
ffffffff4003026c:	39400021 	ldrb	w1, [x1]
ffffffff40030270:	39000001 	strb	w1, [x0]
        while(n-- > 0) {
ffffffff40030274:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff40030278:	51000401 	sub	w1, w0, #0x1
ffffffff4003027c:	b9000fe1 	str	w1, [sp, #12]
ffffffff40030280:	7100001f 	cmp	w0, #0x0
ffffffff40030284:	54fffe81 	b.ne	ffffffff40030254 <memmove+0xac>  // b.any
        }
    }

    return dst;
ffffffff40030288:	f9400fe0 	ldr	x0, [sp, #24]
}
ffffffff4003028c:	9100c3ff 	add	sp, sp, #0x30
ffffffff40030290:	d65f03c0 	ret

ffffffff40030294 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void* memcpy(void *dst, const void *src, uint n)
{
ffffffff40030294:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40030298:	910003fd 	mov	x29, sp
ffffffff4003029c:	f90017e0 	str	x0, [sp, #40]
ffffffff400302a0:	f90013e1 	str	x1, [sp, #32]
ffffffff400302a4:	b9001fe2 	str	w2, [sp, #28]
    return memmove(dst, src, n);
ffffffff400302a8:	b9401fe2 	ldr	w2, [sp, #28]
ffffffff400302ac:	f94013e1 	ldr	x1, [sp, #32]
ffffffff400302b0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400302b4:	97ffffbd 	bl	ffffffff400301a8 <memmove>
}
ffffffff400302b8:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff400302bc:	d65f03c0 	ret

ffffffff400302c0 <strncmp>:

int strncmp(const char *p, const char *q, uint n)
{
ffffffff400302c0:	d10083ff 	sub	sp, sp, #0x20
ffffffff400302c4:	f9000fe0 	str	x0, [sp, #24]
ffffffff400302c8:	f9000be1 	str	x1, [sp, #16]
ffffffff400302cc:	b9000fe2 	str	w2, [sp, #12]
    while(n > 0 && *p && *p == *q) {
ffffffff400302d0:	1400000a 	b	ffffffff400302f8 <strncmp+0x38>
        n--, p++, q++;
ffffffff400302d4:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff400302d8:	51000400 	sub	w0, w0, #0x1
ffffffff400302dc:	b9000fe0 	str	w0, [sp, #12]
ffffffff400302e0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400302e4:	91000400 	add	x0, x0, #0x1
ffffffff400302e8:	f9000fe0 	str	x0, [sp, #24]
ffffffff400302ec:	f9400be0 	ldr	x0, [sp, #16]
ffffffff400302f0:	91000400 	add	x0, x0, #0x1
ffffffff400302f4:	f9000be0 	str	x0, [sp, #16]
    while(n > 0 && *p && *p == *q) {
ffffffff400302f8:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff400302fc:	7100001f 	cmp	w0, #0x0
ffffffff40030300:	54000160 	b.eq	ffffffff4003032c <strncmp+0x6c>  // b.none
ffffffff40030304:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030308:	39400000 	ldrb	w0, [x0]
ffffffff4003030c:	7100001f 	cmp	w0, #0x0
ffffffff40030310:	540000e0 	b.eq	ffffffff4003032c <strncmp+0x6c>  // b.none
ffffffff40030314:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030318:	39400001 	ldrb	w1, [x0]
ffffffff4003031c:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40030320:	39400000 	ldrb	w0, [x0]
ffffffff40030324:	6b00003f 	cmp	w1, w0
ffffffff40030328:	54fffd60 	b.eq	ffffffff400302d4 <strncmp+0x14>  // b.none
    }

    if(n == 0) {
ffffffff4003032c:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff40030330:	7100001f 	cmp	w0, #0x0
ffffffff40030334:	54000061 	b.ne	ffffffff40030340 <strncmp+0x80>  // b.any
        return 0;
ffffffff40030338:	52800000 	mov	w0, #0x0                   	// #0
ffffffff4003033c:	14000007 	b	ffffffff40030358 <strncmp+0x98>
    }

    return (uchar)*p - (uchar)*q;
ffffffff40030340:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030344:	39400000 	ldrb	w0, [x0]
ffffffff40030348:	2a0003e1 	mov	w1, w0
ffffffff4003034c:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40030350:	39400000 	ldrb	w0, [x0]
ffffffff40030354:	4b000020 	sub	w0, w1, w0
}
ffffffff40030358:	910083ff 	add	sp, sp, #0x20
ffffffff4003035c:	d65f03c0 	ret

ffffffff40030360 <strncpy>:

char* strncpy(char *s, const char *t, int n)
{
ffffffff40030360:	d100c3ff 	sub	sp, sp, #0x30
ffffffff40030364:	f9000fe0 	str	x0, [sp, #24]
ffffffff40030368:	f9000be1 	str	x1, [sp, #16]
ffffffff4003036c:	b9000fe2 	str	w2, [sp, #12]
    char *os;

    os = s;
ffffffff40030370:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030374:	f90017e0 	str	x0, [sp, #40]

    while(n-- > 0 && (*s++ = *t++) != 0)
ffffffff40030378:	d503201f 	nop
ffffffff4003037c:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff40030380:	51000401 	sub	w1, w0, #0x1
ffffffff40030384:	b9000fe1 	str	w1, [sp, #12]
ffffffff40030388:	7100001f 	cmp	w0, #0x0
ffffffff4003038c:	5400022d 	b.le	ffffffff400303d0 <strncpy+0x70>
ffffffff40030390:	f9400be1 	ldr	x1, [sp, #16]
ffffffff40030394:	91000420 	add	x0, x1, #0x1
ffffffff40030398:	f9000be0 	str	x0, [sp, #16]
ffffffff4003039c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400303a0:	91000402 	add	x2, x0, #0x1
ffffffff400303a4:	f9000fe2 	str	x2, [sp, #24]
ffffffff400303a8:	39400021 	ldrb	w1, [x1]
ffffffff400303ac:	39000001 	strb	w1, [x0]
ffffffff400303b0:	39400000 	ldrb	w0, [x0]
ffffffff400303b4:	7100001f 	cmp	w0, #0x0
ffffffff400303b8:	54fffe21 	b.ne	ffffffff4003037c <strncpy+0x1c>  // b.any
        ;

    while(n-- > 0) {
ffffffff400303bc:	14000005 	b	ffffffff400303d0 <strncpy+0x70>
        *s++ = 0;
ffffffff400303c0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400303c4:	91000401 	add	x1, x0, #0x1
ffffffff400303c8:	f9000fe1 	str	x1, [sp, #24]
ffffffff400303cc:	3900001f 	strb	wzr, [x0]
    while(n-- > 0) {
ffffffff400303d0:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff400303d4:	51000401 	sub	w1, w0, #0x1
ffffffff400303d8:	b9000fe1 	str	w1, [sp, #12]
ffffffff400303dc:	7100001f 	cmp	w0, #0x0
ffffffff400303e0:	54ffff0c 	b.gt	ffffffff400303c0 <strncpy+0x60>
    }

    return os;
ffffffff400303e4:	f94017e0 	ldr	x0, [sp, #40]
}
ffffffff400303e8:	9100c3ff 	add	sp, sp, #0x30
ffffffff400303ec:	d65f03c0 	ret

ffffffff400303f0 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char* safestrcpy(char *s, const char *t, int n)
{
ffffffff400303f0:	d100c3ff 	sub	sp, sp, #0x30
ffffffff400303f4:	f9000fe0 	str	x0, [sp, #24]
ffffffff400303f8:	f9000be1 	str	x1, [sp, #16]
ffffffff400303fc:	b9000fe2 	str	w2, [sp, #12]
    char *os;

    os = s;
ffffffff40030400:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030404:	f90017e0 	str	x0, [sp, #40]

    if(n <= 0) {
ffffffff40030408:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff4003040c:	7100001f 	cmp	w0, #0x0
ffffffff40030410:	5400006c 	b.gt	ffffffff4003041c <safestrcpy+0x2c>
        return os;
ffffffff40030414:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40030418:	14000016 	b	ffffffff40030470 <safestrcpy+0x80>
    }

    while(--n > 0 && (*s++ = *t++) != 0)
ffffffff4003041c:	d503201f 	nop
ffffffff40030420:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff40030424:	51000400 	sub	w0, w0, #0x1
ffffffff40030428:	b9000fe0 	str	w0, [sp, #12]
ffffffff4003042c:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff40030430:	7100001f 	cmp	w0, #0x0
ffffffff40030434:	5400018d 	b.le	ffffffff40030464 <safestrcpy+0x74>
ffffffff40030438:	f9400be1 	ldr	x1, [sp, #16]
ffffffff4003043c:	91000420 	add	x0, x1, #0x1
ffffffff40030440:	f9000be0 	str	x0, [sp, #16]
ffffffff40030444:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030448:	91000402 	add	x2, x0, #0x1
ffffffff4003044c:	f9000fe2 	str	x2, [sp, #24]
ffffffff40030450:	39400021 	ldrb	w1, [x1]
ffffffff40030454:	39000001 	strb	w1, [x0]
ffffffff40030458:	39400000 	ldrb	w0, [x0]
ffffffff4003045c:	7100001f 	cmp	w0, #0x0
ffffffff40030460:	54fffe01 	b.ne	ffffffff40030420 <safestrcpy+0x30>  // b.any
        ;

    *s = 0;
ffffffff40030464:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030468:	3900001f 	strb	wzr, [x0]
    return os;
ffffffff4003046c:	f94017e0 	ldr	x0, [sp, #40]
}
ffffffff40030470:	9100c3ff 	add	sp, sp, #0x30
ffffffff40030474:	d65f03c0 	ret

ffffffff40030478 <strlen>:

int strlen(const char *s)
{
ffffffff40030478:	d10083ff 	sub	sp, sp, #0x20
ffffffff4003047c:	f90007e0 	str	x0, [sp, #8]
    int n;

    for(n = 0; s[n]; n++)
ffffffff40030480:	b9001fff 	str	wzr, [sp, #28]
ffffffff40030484:	14000004 	b	ffffffff40030494 <strlen+0x1c>
ffffffff40030488:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003048c:	11000400 	add	w0, w0, #0x1
ffffffff40030490:	b9001fe0 	str	w0, [sp, #28]
ffffffff40030494:	b9801fe0 	ldrsw	x0, [sp, #28]
ffffffff40030498:	f94007e1 	ldr	x1, [sp, #8]
ffffffff4003049c:	8b000020 	add	x0, x1, x0
ffffffff400304a0:	39400000 	ldrb	w0, [x0]
ffffffff400304a4:	7100001f 	cmp	w0, #0x0
ffffffff400304a8:	54ffff01 	b.ne	ffffffff40030488 <strlen+0x10>  // b.any
        ;

    return n;
ffffffff400304ac:	b9401fe0 	ldr	w0, [sp, #28]
}
ffffffff400304b0:	910083ff 	add	sp, sp, #0x20
ffffffff400304b4:	d65f03c0 	ret

ffffffff400304b8 <cli>:
#include "arm.h"
#include "mmu.h"

void cli (void)
{
    asm("MSR DAIFSET, #2":::);
ffffffff400304b8:	d50342df 	msr	daifset, #0x2
}
ffffffff400304bc:	d503201f 	nop
ffffffff400304c0:	d65f03c0 	ret

ffffffff400304c4 <sti>:

void sti (void)
{
    asm("MSR DAIFCLR, #2":::);
ffffffff400304c4:	d50342ff 	msr	daifclr, #0x2
}
ffffffff400304c8:	d503201f 	nop
ffffffff400304cc:	d65f03c0 	ret

ffffffff400304d0 <int_enabled>:

// return whether interrupt is currently enabled
int int_enabled ()
{
ffffffff400304d0:	d10043ff 	sub	sp, sp, #0x10
    uint32 val;

    asm("MRS %[v], DAIF": [v]"=r" (val)::);
ffffffff400304d4:	d53b4220 	mrs	x0, daif
ffffffff400304d8:	b9000fe0 	str	w0, [sp, #12]

    return !(val & DIS_INT);
ffffffff400304dc:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff400304e0:	12190000 	and	w0, w0, #0x80
ffffffff400304e4:	d3471c00 	ubfx	x0, x0, #7, #1
ffffffff400304e8:	52000000 	eor	w0, w0, #0x1
ffffffff400304ec:	12001c00 	and	w0, w0, #0xff
}
ffffffff400304f0:	910043ff 	add	sp, sp, #0x10
ffffffff400304f4:	d65f03c0 	ret

ffffffff400304f8 <pushcli>:
// Pushcli/popcli are like cli/sti except that they are matched:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void pushcli (void)
{
ffffffff400304f8:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff400304fc:	910003fd 	mov	x29, sp
    int enabled;

    enabled = int_enabled();
ffffffff40030500:	97fffff4 	bl	ffffffff400304d0 <int_enabled>
ffffffff40030504:	b9001fe0 	str	w0, [sp, #28]

    cli();
ffffffff40030508:	97ffffec 	bl	ffffffff400304b8 <cli>

    if (cpu->ncli++ == 0) {
ffffffff4003050c:	f0000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40030510:	913b6000 	add	x0, x0, #0xed8
ffffffff40030514:	f9400001 	ldr	x1, [x0]
ffffffff40030518:	b9401420 	ldr	w0, [x1, #20]
ffffffff4003051c:	11000402 	add	w2, w0, #0x1
ffffffff40030520:	b9001422 	str	w2, [x1, #20]
ffffffff40030524:	7100001f 	cmp	w0, #0x0
ffffffff40030528:	540000c1 	b.ne	ffffffff40030540 <pushcli+0x48>  // b.any
        cpu->intena = enabled;
ffffffff4003052c:	f0000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40030530:	913b6000 	add	x0, x0, #0xed8
ffffffff40030534:	f9400000 	ldr	x0, [x0]
ffffffff40030538:	b9401fe1 	ldr	w1, [sp, #28]
ffffffff4003053c:	b9001801 	str	w1, [x0, #24]
    }
}
ffffffff40030540:	d503201f 	nop
ffffffff40030544:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40030548:	d65f03c0 	ret

ffffffff4003054c <popcli>:

void popcli (void)
{
ffffffff4003054c:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff40030550:	910003fd 	mov	x29, sp
    if (int_enabled()) {
ffffffff40030554:	97ffffdf 	bl	ffffffff400304d0 <int_enabled>
ffffffff40030558:	7100001f 	cmp	w0, #0x0
ffffffff4003055c:	54000080 	b.eq	ffffffff4003056c <popcli+0x20>  // b.none
        panic("popcli - interruptible");
ffffffff40030560:	f0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40030564:	91114000 	add	x0, x0, #0x450
ffffffff40030568:	940004d8 	bl	ffffffff400318c8 <panic>
    }

    if (--cpu->ncli < 0) {
ffffffff4003056c:	f0000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40030570:	913b6000 	add	x0, x0, #0xed8
ffffffff40030574:	f9400000 	ldr	x0, [x0]
ffffffff40030578:	b9401401 	ldr	w1, [x0, #20]
ffffffff4003057c:	51000421 	sub	w1, w1, #0x1
ffffffff40030580:	b9001401 	str	w1, [x0, #20]
ffffffff40030584:	b9401400 	ldr	w0, [x0, #20]
ffffffff40030588:	7100001f 	cmp	w0, #0x0
ffffffff4003058c:	540001ea 	b.ge	ffffffff400305c8 <popcli+0x7c>  // b.tcont
        cprintf("cpu (%d)->ncli: %d\n", cpu, cpu->ncli);
ffffffff40030590:	f0000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40030594:	913b6000 	add	x0, x0, #0xed8
ffffffff40030598:	f9400001 	ldr	x1, [x0]
ffffffff4003059c:	f0000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff400305a0:	913b6000 	add	x0, x0, #0xed8
ffffffff400305a4:	f9400000 	ldr	x0, [x0]
ffffffff400305a8:	b9401400 	ldr	w0, [x0, #20]
ffffffff400305ac:	2a0003e2 	mov	w2, w0
ffffffff400305b0:	f0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400305b4:	9111a000 	add	x0, x0, #0x468
ffffffff400305b8:	9400042f 	bl	ffffffff40031674 <cprintf>
        panic("popcli -- ncli < 0");
ffffffff400305bc:	f0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400305c0:	91120000 	add	x0, x0, #0x480
ffffffff400305c4:	940004c1 	bl	ffffffff400318c8 <panic>
    }

    if ((cpu->ncli == 0) && cpu->intena) {
ffffffff400305c8:	f0000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff400305cc:	913b6000 	add	x0, x0, #0xed8
ffffffff400305d0:	f9400000 	ldr	x0, [x0]
ffffffff400305d4:	b9401400 	ldr	w0, [x0, #20]
ffffffff400305d8:	7100001f 	cmp	w0, #0x0
ffffffff400305dc:	54000101 	b.ne	ffffffff400305fc <popcli+0xb0>  // b.any
ffffffff400305e0:	f0000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff400305e4:	913b6000 	add	x0, x0, #0xed8
ffffffff400305e8:	f9400000 	ldr	x0, [x0]
ffffffff400305ec:	b9401800 	ldr	w0, [x0, #24]
ffffffff400305f0:	7100001f 	cmp	w0, #0x0
ffffffff400305f4:	54000040 	b.eq	ffffffff400305fc <popcli+0xb0>  // b.none
        sti();
ffffffff400305f8:	97ffffb3 	bl	ffffffff400304c4 <sti>
    }
}
ffffffff400305fc:	d503201f 	nop
ffffffff40030600:	a8c17bfd 	ldp	x29, x30, [sp], #16
ffffffff40030604:	d65f03c0 	ret

ffffffff40030608 <getcallerpcs>:
// In ARM ABI, the function prologue is as:
//		push	{fp, lr}
//		add		fp, sp, #4
// so, fp points to lr, the return address
void getcallerpcs (void * v, uint64 pcs[])
{
ffffffff40030608:	d10083ff 	sub	sp, sp, #0x20
ffffffff4003060c:	f90007e0 	str	x0, [sp, #8]
ffffffff40030610:	f90003e1 	str	x1, [sp]
    uint64 *fp;
    int i;

    fp = (uint64*) v;
ffffffff40030614:	f94007e0 	ldr	x0, [sp, #8]
ffffffff40030618:	f9000fe0 	str	x0, [sp, #24]

    for (i = 0; i < N_CALLSTK; i++) {
ffffffff4003061c:	b90017ff 	str	wzr, [sp, #20]
ffffffff40030620:	1400001c 	b	ffffffff40030690 <getcallerpcs+0x88>
        if ((fp == 0) || (fp < (uint64*) KERNBASE) || (fp == (uint64*) 0xffffffff)) {
ffffffff40030624:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030628:	f100001f 	cmp	x0, #0x0
ffffffff4003062c:	540004a0 	b.eq	ffffffff400306c0 <getcallerpcs+0xb8>  // b.none
ffffffff40030630:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40030634:	92c00020 	mov	x0, #0xfffffffeffffffff    	// #-4294967297
ffffffff40030638:	eb00003f 	cmp	x1, x0
ffffffff4003063c:	54000429 	b.ls	ffffffff400306c0 <getcallerpcs+0xb8>  // b.plast
ffffffff40030640:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40030644:	b2407fe0 	mov	x0, #0xffffffff            	// #4294967295
ffffffff40030648:	eb00003f 	cmp	x1, x0
ffffffff4003064c:	540003a0 	b.eq	ffffffff400306c0 <getcallerpcs+0xb8>  // b.none
            break;
        }

        fp = fp - 1;			// points fp to the saved fp
ffffffff40030650:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030654:	d1002000 	sub	x0, x0, #0x8
ffffffff40030658:	f9000fe0 	str	x0, [sp, #24]
        pcs[i] = fp[1];     // saved lr
ffffffff4003065c:	b98017e0 	ldrsw	x0, [sp, #20]
ffffffff40030660:	d37df000 	lsl	x0, x0, #3
ffffffff40030664:	f94003e1 	ldr	x1, [sp]
ffffffff40030668:	8b000020 	add	x0, x1, x0
ffffffff4003066c:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40030670:	f9400421 	ldr	x1, [x1, #8]
ffffffff40030674:	f9000001 	str	x1, [x0]
        fp = (uint64*) fp[0];	// saved fp
ffffffff40030678:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003067c:	f9400000 	ldr	x0, [x0]
ffffffff40030680:	f9000fe0 	str	x0, [sp, #24]
    for (i = 0; i < N_CALLSTK; i++) {
ffffffff40030684:	b94017e0 	ldr	w0, [sp, #20]
ffffffff40030688:	11000400 	add	w0, w0, #0x1
ffffffff4003068c:	b90017e0 	str	w0, [sp, #20]
ffffffff40030690:	b94017e0 	ldr	w0, [sp, #20]
ffffffff40030694:	7100381f 	cmp	w0, #0xe
ffffffff40030698:	54fffc6d 	b.le	ffffffff40030624 <getcallerpcs+0x1c>
    }

    for (; i < N_CALLSTK; i++) {
ffffffff4003069c:	14000009 	b	ffffffff400306c0 <getcallerpcs+0xb8>
        pcs[i] = 0;
ffffffff400306a0:	b98017e0 	ldrsw	x0, [sp, #20]
ffffffff400306a4:	d37df000 	lsl	x0, x0, #3
ffffffff400306a8:	f94003e1 	ldr	x1, [sp]
ffffffff400306ac:	8b000020 	add	x0, x1, x0
ffffffff400306b0:	f900001f 	str	xzr, [x0]
    for (; i < N_CALLSTK; i++) {
ffffffff400306b4:	b94017e0 	ldr	w0, [sp, #20]
ffffffff400306b8:	11000400 	add	w0, w0, #0x1
ffffffff400306bc:	b90017e0 	str	w0, [sp, #20]
ffffffff400306c0:	b94017e0 	ldr	w0, [sp, #20]
ffffffff400306c4:	7100381f 	cmp	w0, #0xe
ffffffff400306c8:	54fffecd 	b.le	ffffffff400306a0 <getcallerpcs+0x98>
    }
}
ffffffff400306cc:	d503201f 	nop
ffffffff400306d0:	d503201f 	nop
ffffffff400306d4:	910083ff 	add	sp, sp, #0x20
ffffffff400306d8:	d65f03c0 	ret

ffffffff400306dc <show_callstk>:

void show_callstk (char *s)
{
ffffffff400306dc:	a9b57bfd 	stp	x29, x30, [sp, #-176]!
ffffffff400306e0:	910003fd 	mov	x29, sp
ffffffff400306e4:	f9000fe0 	str	x0, [sp, #24]
    int i;
    uint64 fp;
    uint64 pcs[N_CALLSTK];

    cprintf("%s\n", s);
ffffffff400306e8:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff400306ec:	f0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400306f0:	91126000 	add	x0, x0, #0x498
ffffffff400306f4:	940003e0 	bl	ffffffff40031674 <cprintf>

    asm("MOV %[r], x29":[r]"=r" (fp): :);
ffffffff400306f8:	aa1d03e0 	mov	x0, x29
ffffffff400306fc:	f90053e0 	str	x0, [sp, #160]

    getcallerpcs((void *)fp, pcs);
ffffffff40030700:	f94053e0 	ldr	x0, [sp, #160]
ffffffff40030704:	9100a3e1 	add	x1, sp, #0x28
ffffffff40030708:	97ffffc0 	bl	ffffffff40030608 <getcallerpcs>

    for (i = N_CALLSTK - 1; i >= 0; i--) {
ffffffff4003070c:	528001c0 	mov	w0, #0xe                   	// #14
ffffffff40030710:	b900afe0 	str	w0, [sp, #172]
ffffffff40030714:	1400000f 	b	ffffffff40030750 <show_callstk+0x74>
        cprintf("%d: 0x%x\n", i + 1, pcs[i]);
ffffffff40030718:	b940afe0 	ldr	w0, [sp, #172]
ffffffff4003071c:	11000403 	add	w3, w0, #0x1
ffffffff40030720:	b980afe0 	ldrsw	x0, [sp, #172]
ffffffff40030724:	d37df000 	lsl	x0, x0, #3
ffffffff40030728:	9100a3e1 	add	x1, sp, #0x28
ffffffff4003072c:	f8606820 	ldr	x0, [x1, x0]
ffffffff40030730:	aa0003e2 	mov	x2, x0
ffffffff40030734:	2a0303e1 	mov	w1, w3
ffffffff40030738:	f0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003073c:	91128000 	add	x0, x0, #0x4a0
ffffffff40030740:	940003cd 	bl	ffffffff40031674 <cprintf>
    for (i = N_CALLSTK - 1; i >= 0; i--) {
ffffffff40030744:	b940afe0 	ldr	w0, [sp, #172]
ffffffff40030748:	51000400 	sub	w0, w0, #0x1
ffffffff4003074c:	b900afe0 	str	w0, [sp, #172]
ffffffff40030750:	b940afe0 	ldr	w0, [sp, #172]
ffffffff40030754:	7100001f 	cmp	w0, #0x0
ffffffff40030758:	54fffe0a 	b.ge	ffffffff40030718 <show_callstk+0x3c>  // b.tcont
    }

}
ffffffff4003075c:	d503201f 	nop
ffffffff40030760:	d503201f 	nop
ffffffff40030764:	a8cb7bfd 	ldp	x29, x30, [sp], #176
ffffffff40030768:	d65f03c0 	ret

ffffffff4003076c <binit>:
    // head.next is most recently used.
    struct buf head;
} bcache;

void binit (void)
{
ffffffff4003076c:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40030770:	910003fd 	mov	x29, sp
    struct buf *b;

    initlock(&bcache.lock, "bcache");
ffffffff40030774:	f0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40030778:	9112c001 	add	x1, x0, #0x4b0
ffffffff4003077c:	90000460 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
ffffffff40030780:	91054000 	add	x0, x0, #0x150
ffffffff40030784:	94001533 	bl	ffffffff40035c50 <initlock>

    //PAGEBREAK!
    // Create linked list of buffers
    bcache.head.prev = &bcache.head;
ffffffff40030788:	90000460 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
ffffffff4003078c:	91054000 	add	x0, x0, #0x150
ffffffff40030790:	b0000461 	adrp	x1, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030794:	911c8021 	add	x1, x1, #0x720
ffffffff40030798:	f90af001 	str	x1, [x0, #5600]
    bcache.head.next = &bcache.head;
ffffffff4003079c:	90000460 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
ffffffff400307a0:	91054000 	add	x0, x0, #0x150
ffffffff400307a4:	b0000461 	adrp	x1, ffffffff400bd000 <bcache+0xeb0>
ffffffff400307a8:	911c8021 	add	x1, x1, #0x720
ffffffff400307ac:	f90af401 	str	x1, [x0, #5608]

    for (b = bcache.buf; b < bcache.buf + NBUF; b++) {
ffffffff400307b0:	90000460 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
ffffffff400307b4:	91064000 	add	x0, x0, #0x190
ffffffff400307b8:	f9000fe0 	str	x0, [sp, #24]
ffffffff400307bc:	14000019 	b	ffffffff40030820 <binit+0xb4>
        b->next = bcache.head.next;
ffffffff400307c0:	90000460 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
ffffffff400307c4:	91054000 	add	x0, x0, #0x150
ffffffff400307c8:	f94af401 	ldr	x1, [x0, #5608]
ffffffff400307cc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400307d0:	f9000c01 	str	x1, [x0, #24]
        b->prev = &bcache.head;
ffffffff400307d4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400307d8:	b0000461 	adrp	x1, ffffffff400bd000 <bcache+0xeb0>
ffffffff400307dc:	911c8021 	add	x1, x1, #0x720
ffffffff400307e0:	f9000801 	str	x1, [x0, #16]
        b->dev = -1;
ffffffff400307e4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400307e8:	12800001 	mov	w1, #0xffffffff            	// #-1
ffffffff400307ec:	b9000401 	str	w1, [x0, #4]
        bcache.head.next->prev = b;
ffffffff400307f0:	90000460 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
ffffffff400307f4:	91054000 	add	x0, x0, #0x150
ffffffff400307f8:	f94af400 	ldr	x0, [x0, #5608]
ffffffff400307fc:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40030800:	f9000801 	str	x1, [x0, #16]
        bcache.head.next = b;
ffffffff40030804:	90000460 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
ffffffff40030808:	91054000 	add	x0, x0, #0x150
ffffffff4003080c:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40030810:	f90af401 	str	x1, [x0, #5608]
    for (b = bcache.buf; b < bcache.buf + NBUF; b++) {
ffffffff40030814:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030818:	9108a000 	add	x0, x0, #0x228
ffffffff4003081c:	f9000fe0 	str	x0, [sp, #24]
ffffffff40030820:	b0000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030824:	911c8000 	add	x0, x0, #0x720
ffffffff40030828:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff4003082c:	eb00003f 	cmp	x1, x0
ffffffff40030830:	54fffc83 	b.cc	ffffffff400307c0 <binit+0x54>  // b.lo, b.ul, b.last
    }
}
ffffffff40030834:	d503201f 	nop
ffffffff40030838:	d503201f 	nop
ffffffff4003083c:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40030840:	d65f03c0 	ret

ffffffff40030844 <bget>:

// Look through buffer cache for sector on device dev.
// If not found, allocate fresh block.
// In either case, return B_BUSY buffer.
static struct buf* bget (uint dev, uint sector)
{
ffffffff40030844:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40030848:	910003fd 	mov	x29, sp
ffffffff4003084c:	b9001fe0 	str	w0, [sp, #28]
ffffffff40030850:	b9001be1 	str	w1, [sp, #24]
    struct buf *b;

    acquire(&bcache.lock);
ffffffff40030854:	90000460 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
ffffffff40030858:	91054000 	add	x0, x0, #0x150
ffffffff4003085c:	9400150a 	bl	ffffffff40035c84 <acquire>

    loop:
    // Is the sector already cached?
    for (b = bcache.head.next; b != &bcache.head; b = b->next) {
ffffffff40030860:	90000460 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
ffffffff40030864:	91054000 	add	x0, x0, #0x150
ffffffff40030868:	f94af400 	ldr	x0, [x0, #5608]
ffffffff4003086c:	f90017e0 	str	x0, [sp, #40]
ffffffff40030870:	14000022 	b	ffffffff400308f8 <bget+0xb4>
        if (b->dev == dev && b->sector == sector) {
ffffffff40030874:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40030878:	b9400400 	ldr	w0, [x0, #4]
ffffffff4003087c:	b9401fe1 	ldr	w1, [sp, #28]
ffffffff40030880:	6b00003f 	cmp	w1, w0
ffffffff40030884:	54000341 	b.ne	ffffffff400308ec <bget+0xa8>  // b.any
ffffffff40030888:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003088c:	b9400800 	ldr	w0, [x0, #8]
ffffffff40030890:	b9401be1 	ldr	w1, [sp, #24]
ffffffff40030894:	6b00003f 	cmp	w1, w0
ffffffff40030898:	540002a1 	b.ne	ffffffff400308ec <bget+0xa8>  // b.any
            if (!(b->flags & B_BUSY)) {
ffffffff4003089c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400308a0:	b9400000 	ldr	w0, [x0]
ffffffff400308a4:	12000000 	and	w0, w0, #0x1
ffffffff400308a8:	7100001f 	cmp	w0, #0x0
ffffffff400308ac:	54000161 	b.ne	ffffffff400308d8 <bget+0x94>  // b.any
                b->flags |= B_BUSY;
ffffffff400308b0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400308b4:	b9400000 	ldr	w0, [x0]
ffffffff400308b8:	32000001 	orr	w1, w0, #0x1
ffffffff400308bc:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400308c0:	b9000001 	str	w1, [x0]
                release(&bcache.lock);
ffffffff400308c4:	90000460 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
ffffffff400308c8:	91054000 	add	x0, x0, #0x150
ffffffff400308cc:	940014f8 	bl	ffffffff40035cac <release>
                return b;
ffffffff400308d0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400308d4:	14000036 	b	ffffffff400309ac <bget+0x168>
            }

            sleep(b, &bcache.lock);
ffffffff400308d8:	90000460 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
ffffffff400308dc:	91054001 	add	x1, x0, #0x150
ffffffff400308e0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400308e4:	94001411 	bl	ffffffff40035928 <sleep>
            goto loop;
ffffffff400308e8:	17ffffde 	b	ffffffff40030860 <bget+0x1c>
    for (b = bcache.head.next; b != &bcache.head; b = b->next) {
ffffffff400308ec:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400308f0:	f9400c00 	ldr	x0, [x0, #24]
ffffffff400308f4:	f90017e0 	str	x0, [sp, #40]
ffffffff400308f8:	f94017e1 	ldr	x1, [sp, #40]
ffffffff400308fc:	b0000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030900:	911c8000 	add	x0, x0, #0x720
ffffffff40030904:	eb00003f 	cmp	x1, x0
ffffffff40030908:	54fffb61 	b.ne	ffffffff40030874 <bget+0x30>  // b.any
        }
    }

    // Not cached; recycle some non-busy and clean buffer.
    for (b = bcache.head.prev; b != &bcache.head; b = b->prev) {
ffffffff4003090c:	90000460 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
ffffffff40030910:	91054000 	add	x0, x0, #0x150
ffffffff40030914:	f94af000 	ldr	x0, [x0, #5600]
ffffffff40030918:	f90017e0 	str	x0, [sp, #40]
ffffffff4003091c:	1400001c 	b	ffffffff4003098c <bget+0x148>
        if ((b->flags & B_BUSY) == 0 && (b->flags & B_DIRTY) == 0) {
ffffffff40030920:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40030924:	b9400000 	ldr	w0, [x0]
ffffffff40030928:	12000000 	and	w0, w0, #0x1
ffffffff4003092c:	7100001f 	cmp	w0, #0x0
ffffffff40030930:	54000281 	b.ne	ffffffff40030980 <bget+0x13c>  // b.any
ffffffff40030934:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40030938:	b9400000 	ldr	w0, [x0]
ffffffff4003093c:	121e0000 	and	w0, w0, #0x4
ffffffff40030940:	7100001f 	cmp	w0, #0x0
ffffffff40030944:	540001e1 	b.ne	ffffffff40030980 <bget+0x13c>  // b.any
            b->dev = dev;
ffffffff40030948:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003094c:	b9401fe1 	ldr	w1, [sp, #28]
ffffffff40030950:	b9000401 	str	w1, [x0, #4]
            b->sector = sector;
ffffffff40030954:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40030958:	b9401be1 	ldr	w1, [sp, #24]
ffffffff4003095c:	b9000801 	str	w1, [x0, #8]
            b->flags = B_BUSY;
ffffffff40030960:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40030964:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40030968:	b9000001 	str	w1, [x0]
            release(&bcache.lock);
ffffffff4003096c:	90000460 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
ffffffff40030970:	91054000 	add	x0, x0, #0x150
ffffffff40030974:	940014ce 	bl	ffffffff40035cac <release>
            return b;
ffffffff40030978:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003097c:	1400000c 	b	ffffffff400309ac <bget+0x168>
    for (b = bcache.head.prev; b != &bcache.head; b = b->prev) {
ffffffff40030980:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40030984:	f9400800 	ldr	x0, [x0, #16]
ffffffff40030988:	f90017e0 	str	x0, [sp, #40]
ffffffff4003098c:	f94017e1 	ldr	x1, [sp, #40]
ffffffff40030990:	b0000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030994:	911c8000 	add	x0, x0, #0x720
ffffffff40030998:	eb00003f 	cmp	x1, x0
ffffffff4003099c:	54fffc21 	b.ne	ffffffff40030920 <bget+0xdc>  // b.any
        }
    }

    panic("bget: no buffers");
ffffffff400309a0:	f0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400309a4:	9112e000 	add	x0, x0, #0x4b8
ffffffff400309a8:	940003c8 	bl	ffffffff400318c8 <panic>
}
ffffffff400309ac:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff400309b0:	d65f03c0 	ret

ffffffff400309b4 <bread>:

// Return a B_BUSY buf with the contents of the indicated disk sector.
struct buf* bread (uint dev, uint sector)
{
ffffffff400309b4:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff400309b8:	910003fd 	mov	x29, sp
ffffffff400309bc:	b9001fe0 	str	w0, [sp, #28]
ffffffff400309c0:	b9001be1 	str	w1, [sp, #24]
    struct buf *b;

    b = bget(dev, sector);
ffffffff400309c4:	b9401be1 	ldr	w1, [sp, #24]
ffffffff400309c8:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff400309cc:	97ffff9e 	bl	ffffffff40030844 <bget>
ffffffff400309d0:	f90017e0 	str	x0, [sp, #40]

    if (!(b->flags & B_VALID)) {
ffffffff400309d4:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400309d8:	b9400000 	ldr	w0, [x0]
ffffffff400309dc:	121f0000 	and	w0, w0, #0x2
ffffffff400309e0:	7100001f 	cmp	w0, #0x0
ffffffff400309e4:	54000061 	b.ne	ffffffff400309f0 <bread+0x3c>  // b.any
        iderw(b);
ffffffff400309e8:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400309ec:	94000ebb 	bl	ffffffff400344d8 <iderw>
    }

    return b;
ffffffff400309f0:	f94017e0 	ldr	x0, [sp, #40]
}
ffffffff400309f4:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff400309f8:	d65f03c0 	ret

ffffffff400309fc <bwrite>:

// Write b's contents to disk.  Must be B_BUSY.
void bwrite (struct buf *b)
{
ffffffff400309fc:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40030a00:	910003fd 	mov	x29, sp
ffffffff40030a04:	f9000fe0 	str	x0, [sp, #24]
    if ((b->flags & B_BUSY) == 0) {
ffffffff40030a08:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030a0c:	b9400000 	ldr	w0, [x0]
ffffffff40030a10:	12000000 	and	w0, w0, #0x1
ffffffff40030a14:	7100001f 	cmp	w0, #0x0
ffffffff40030a18:	54000081 	b.ne	ffffffff40030a28 <bwrite+0x2c>  // b.any
        panic("bwrite");
ffffffff40030a1c:	f0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40030a20:	91134000 	add	x0, x0, #0x4d0
ffffffff40030a24:	940003a9 	bl	ffffffff400318c8 <panic>
    }

    b->flags |= B_DIRTY;
ffffffff40030a28:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030a2c:	b9400000 	ldr	w0, [x0]
ffffffff40030a30:	321e0001 	orr	w1, w0, #0x4
ffffffff40030a34:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030a38:	b9000001 	str	w1, [x0]
    iderw(b);
ffffffff40030a3c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030a40:	94000ea6 	bl	ffffffff400344d8 <iderw>
}
ffffffff40030a44:	d503201f 	nop
ffffffff40030a48:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40030a4c:	d65f03c0 	ret

ffffffff40030a50 <brelse>:

// Release a B_BUSY buffer.
// Move to the head of the MRU list.
void brelse (struct buf *b)
{
ffffffff40030a50:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40030a54:	910003fd 	mov	x29, sp
ffffffff40030a58:	f9000fe0 	str	x0, [sp, #24]
    if ((b->flags & B_BUSY) == 0) {
ffffffff40030a5c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030a60:	b9400000 	ldr	w0, [x0]
ffffffff40030a64:	12000000 	and	w0, w0, #0x1
ffffffff40030a68:	7100001f 	cmp	w0, #0x0
ffffffff40030a6c:	54000081 	b.ne	ffffffff40030a7c <brelse+0x2c>  // b.any
        panic("brelse");
ffffffff40030a70:	f0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40030a74:	91136000 	add	x0, x0, #0x4d8
ffffffff40030a78:	94000394 	bl	ffffffff400318c8 <panic>
    }

    acquire(&bcache.lock);
ffffffff40030a7c:	90000460 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
ffffffff40030a80:	91054000 	add	x0, x0, #0x150
ffffffff40030a84:	94001480 	bl	ffffffff40035c84 <acquire>

    b->next->prev = b->prev;
ffffffff40030a88:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030a8c:	f9400c00 	ldr	x0, [x0, #24]
ffffffff40030a90:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40030a94:	f9400821 	ldr	x1, [x1, #16]
ffffffff40030a98:	f9000801 	str	x1, [x0, #16]
    b->prev->next = b->next;
ffffffff40030a9c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030aa0:	f9400800 	ldr	x0, [x0, #16]
ffffffff40030aa4:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40030aa8:	f9400c21 	ldr	x1, [x1, #24]
ffffffff40030aac:	f9000c01 	str	x1, [x0, #24]
    b->next = bcache.head.next;
ffffffff40030ab0:	90000460 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
ffffffff40030ab4:	91054000 	add	x0, x0, #0x150
ffffffff40030ab8:	f94af401 	ldr	x1, [x0, #5608]
ffffffff40030abc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030ac0:	f9000c01 	str	x1, [x0, #24]
    b->prev = &bcache.head;
ffffffff40030ac4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030ac8:	b0000461 	adrp	x1, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030acc:	911c8021 	add	x1, x1, #0x720
ffffffff40030ad0:	f9000801 	str	x1, [x0, #16]
    bcache.head.next->prev = b;
ffffffff40030ad4:	90000460 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
ffffffff40030ad8:	91054000 	add	x0, x0, #0x150
ffffffff40030adc:	f94af400 	ldr	x0, [x0, #5608]
ffffffff40030ae0:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40030ae4:	f9000801 	str	x1, [x0, #16]
    bcache.head.next = b;
ffffffff40030ae8:	90000460 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
ffffffff40030aec:	91054000 	add	x0, x0, #0x150
ffffffff40030af0:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40030af4:	f90af401 	str	x1, [x0, #5608]

    b->flags &= ~B_BUSY;
ffffffff40030af8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030afc:	b9400000 	ldr	w0, [x0]
ffffffff40030b00:	121f7801 	and	w1, w0, #0xfffffffe
ffffffff40030b04:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030b08:	b9000001 	str	w1, [x0]
    wakeup(b);
ffffffff40030b0c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40030b10:	940013dc 	bl	ffffffff40035a80 <wakeup>

    release(&bcache.lock);
ffffffff40030b14:	90000460 	adrp	x0, ffffffff400bc000 <_binary_fs_img_start+0x7feb0>
ffffffff40030b18:	91054000 	add	x0, x0, #0x150
ffffffff40030b1c:	94001464 	bl	ffffffff40035cac <release>
}
ffffffff40030b20:	d503201f 	nop
ffffffff40030b24:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40030b28:	d65f03c0 	ret

ffffffff40030b2c <get_mark>:

static struct kmem kmem;

// coversion between block id to mark and memory address
static inline struct mark* get_mark (int order, int idx)
{
ffffffff40030b2c:	d10043ff 	sub	sp, sp, #0x10
ffffffff40030b30:	b9000fe0 	str	w0, [sp, #12]
ffffffff40030b34:	b9000be1 	str	w1, [sp, #8]
    return (struct mark*)kmem.start + (kmem.orders[order - MIN_ORD].offset + idx);
ffffffff40030b38:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff40030b3c:	51001802 	sub	w2, w0, #0x6
ffffffff40030b40:	b0000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030b44:	91252001 	add	x1, x0, #0x948
ffffffff40030b48:	93407c40 	sxtw	x0, w2
ffffffff40030b4c:	91002800 	add	x0, x0, #0xa
ffffffff40030b50:	d37df000 	lsl	x0, x0, #3
ffffffff40030b54:	8b000020 	add	x0, x1, x0
ffffffff40030b58:	b9400c01 	ldr	w1, [x0, #12]
ffffffff40030b5c:	b9400be0 	ldr	w0, [sp, #8]
ffffffff40030b60:	0b000020 	add	w0, w1, w0
ffffffff40030b64:	2a0003e0 	mov	w0, w0
ffffffff40030b68:	d37df001 	lsl	x1, x0, #3
ffffffff40030b6c:	b0000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030b70:	91252000 	add	x0, x0, #0x948
ffffffff40030b74:	f9402000 	ldr	x0, [x0, #64]
ffffffff40030b78:	8b000020 	add	x0, x1, x0
}
ffffffff40030b7c:	910043ff 	add	sp, sp, #0x10
ffffffff40030b80:	d65f03c0 	ret

ffffffff40030b84 <blkid2mem>:

static inline void* blkid2mem (int order, int blkid)
{
ffffffff40030b84:	d10043ff 	sub	sp, sp, #0x10
ffffffff40030b88:	b9000fe0 	str	w0, [sp, #12]
ffffffff40030b8c:	b9000be1 	str	w1, [sp, #8]
    return (void*)(kmem.start_heap + (1 << order) * blkid);
ffffffff40030b90:	b0000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030b94:	91252000 	add	x0, x0, #0x948
ffffffff40030b98:	f9402401 	ldr	x1, [x0, #72]
ffffffff40030b9c:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff40030ba0:	b9400be2 	ldr	w2, [sp, #8]
ffffffff40030ba4:	1ac02040 	lsl	w0, w2, w0
ffffffff40030ba8:	93407c00 	sxtw	x0, w0
ffffffff40030bac:	8b000020 	add	x0, x1, x0
}
ffffffff40030bb0:	910043ff 	add	sp, sp, #0x10
ffffffff40030bb4:	d65f03c0 	ret

ffffffff40030bb8 <mem2blkid>:

static inline int mem2blkid (int order, void *mem)
{
ffffffff40030bb8:	d10043ff 	sub	sp, sp, #0x10
ffffffff40030bbc:	b9000fe0 	str	w0, [sp, #12]
ffffffff40030bc0:	f90003e1 	str	x1, [sp]
    return ((uint64)mem - kmem.start_heap) >> order;
ffffffff40030bc4:	f94003e1 	ldr	x1, [sp]
ffffffff40030bc8:	b0000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030bcc:	91252000 	add	x0, x0, #0x948
ffffffff40030bd0:	f9402400 	ldr	x0, [x0, #72]
ffffffff40030bd4:	cb000021 	sub	x1, x1, x0
ffffffff40030bd8:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff40030bdc:	9ac02420 	lsr	x0, x1, x0
}
ffffffff40030be0:	910043ff 	add	sp, sp, #0x10
ffffffff40030be4:	d65f03c0 	ret

ffffffff40030be8 <available>:

static inline int available (uint bitmap, int blk_id)
{
ffffffff40030be8:	d10043ff 	sub	sp, sp, #0x10
ffffffff40030bec:	b9000fe0 	str	w0, [sp, #12]
ffffffff40030bf0:	b9000be1 	str	w1, [sp, #8]
    return bitmap & (1 << (blk_id & 0x1F));
ffffffff40030bf4:	b9400be0 	ldr	w0, [sp, #8]
ffffffff40030bf8:	12001000 	and	w0, w0, #0x1f
ffffffff40030bfc:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40030c00:	1ac02020 	lsl	w0, w1, w0
ffffffff40030c04:	2a0003e1 	mov	w1, w0
ffffffff40030c08:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff40030c0c:	0a000020 	and	w0, w1, w0
}
ffffffff40030c10:	910043ff 	add	sp, sp, #0x10
ffffffff40030c14:	d65f03c0 	ret

ffffffff40030c18 <kmem_init>:

void kmem_init (void)
{
ffffffff40030c18:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff40030c1c:	910003fd 	mov	x29, sp
    initlock(&kmem.lock, "kmem");
ffffffff40030c20:	f0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40030c24:	91138001 	add	x1, x0, #0x4e0
ffffffff40030c28:	b0000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030c2c:	91252000 	add	x0, x0, #0x948
ffffffff40030c30:	94001408 	bl	ffffffff40035c50 <initlock>
}
ffffffff40030c34:	d503201f 	nop
ffffffff40030c38:	a8c17bfd 	ldp	x29, x30, [sp], #16
ffffffff40030c3c:	d65f03c0 	ret

ffffffff40030c40 <kmem_init2>:

void kmem_init2(void *vstart, void *vend)
{
ffffffff40030c40:	a9ba7bfd 	stp	x29, x30, [sp, #-96]!
ffffffff40030c44:	910003fd 	mov	x29, sp
ffffffff40030c48:	f9000fe0 	str	x0, [sp, #24]
ffffffff40030c4c:	f9000be1 	str	x1, [sp, #16]
    uint64          total, n;
    uint64          len;
    struct order    *ord;
    struct mark     *mk;
    
    kmem.start = (uint64)vstart;
ffffffff40030c50:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40030c54:	b0000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030c58:	91252000 	add	x0, x0, #0x948
ffffffff40030c5c:	f9002001 	str	x1, [x0, #64]
    kmem.end   = (uint64)vend;
ffffffff40030c60:	f9400be1 	ldr	x1, [sp, #16]
ffffffff40030c64:	b0000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030c68:	91252000 	add	x0, x0, #0x948
ffffffff40030c6c:	f9002801 	str	x1, [x0, #80]
    len = kmem.end - kmem.start;
ffffffff40030c70:	b0000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030c74:	91252000 	add	x0, x0, #0x948
ffffffff40030c78:	f9402801 	ldr	x1, [x0, #80]
ffffffff40030c7c:	b0000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030c80:	91252000 	add	x0, x0, #0x948
ffffffff40030c84:	f9402000 	ldr	x0, [x0, #64]
ffffffff40030c88:	cb000020 	sub	x0, x1, x0
ffffffff40030c8c:	f9001fe0 	str	x0, [sp, #56]

    // reserved memory at vstart for an array of marks (for all the orders)
    n = (len >> (MAX_ORD + 5)) + 1; // estimated # of marks for max order
ffffffff40030c90:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40030c94:	d351fc00 	lsr	x0, x0, #17
ffffffff40030c98:	91000400 	add	x0, x0, #0x1
ffffffff40030c9c:	f90023e0 	str	x0, [sp, #64]
    total = 0;
ffffffff40030ca0:	f90027ff 	str	xzr, [sp, #72]
    
    for (i = N_ORD - 1; i >= 0; i--) {
ffffffff40030ca4:	d28000c0 	mov	x0, #0x6                   	// #6
ffffffff40030ca8:	f9002fe0 	str	x0, [sp, #88]
ffffffff40030cac:	1400002e 	b	ffffffff40030d64 <kmem_init2+0x124>
        ord = kmem.orders + i;
ffffffff40030cb0:	f9402fe0 	ldr	x0, [sp, #88]
ffffffff40030cb4:	d37df001 	lsl	x1, x0, #3
ffffffff40030cb8:	b0000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030cbc:	91268000 	add	x0, x0, #0x9a0
ffffffff40030cc0:	8b000020 	add	x0, x1, x0
ffffffff40030cc4:	f9001be0 	str	x0, [sp, #48]
        ord->offset = total;
ffffffff40030cc8:	f94027e0 	ldr	x0, [sp, #72]
ffffffff40030ccc:	2a0003e1 	mov	w1, w0
ffffffff40030cd0:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40030cd4:	b9000401 	str	w1, [x0, #4]
        ord->head = NIL;
ffffffff40030cd8:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40030cdc:	529fffe1 	mov	w1, #0xffff                	// #65535
ffffffff40030ce0:	b9000001 	str	w1, [x0]
        
        // set the bitmaps to mark all blocks not available
        for (j = 0; j < n; j++) {
ffffffff40030ce4:	f9002bff 	str	xzr, [sp, #80]
ffffffff40030ce8:	14000011 	b	ffffffff40030d2c <kmem_init2+0xec>
            mk = get_mark(i + MIN_ORD, j);
ffffffff40030cec:	f9402fe0 	ldr	x0, [sp, #88]
ffffffff40030cf0:	11001800 	add	w0, w0, #0x6
ffffffff40030cf4:	2a0003e2 	mov	w2, w0
ffffffff40030cf8:	f9402be0 	ldr	x0, [sp, #80]
ffffffff40030cfc:	2a0003e1 	mov	w1, w0
ffffffff40030d00:	2a0203e0 	mov	w0, w2
ffffffff40030d04:	97ffff8a 	bl	ffffffff40030b2c <get_mark>
ffffffff40030d08:	f90017e0 	str	x0, [sp, #40]
            mk->lnks = LNKS(NIL, NIL);
ffffffff40030d0c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40030d10:	12800001 	mov	w1, #0xffffffff            	// #-1
ffffffff40030d14:	b9000001 	str	w1, [x0]
            mk->bitmap = 0;
ffffffff40030d18:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40030d1c:	b900041f 	str	wzr, [x0, #4]
        for (j = 0; j < n; j++) {
ffffffff40030d20:	f9402be0 	ldr	x0, [sp, #80]
ffffffff40030d24:	91000400 	add	x0, x0, #0x1
ffffffff40030d28:	f9002be0 	str	x0, [sp, #80]
ffffffff40030d2c:	f9402be0 	ldr	x0, [sp, #80]
ffffffff40030d30:	f94023e1 	ldr	x1, [sp, #64]
ffffffff40030d34:	eb00003f 	cmp	x1, x0
ffffffff40030d38:	54fffda8 	b.hi	ffffffff40030cec <kmem_init2+0xac>  // b.pmore
        }

        total += n;
ffffffff40030d3c:	f94027e1 	ldr	x1, [sp, #72]
ffffffff40030d40:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40030d44:	8b000020 	add	x0, x1, x0
ffffffff40030d48:	f90027e0 	str	x0, [sp, #72]
        n <<= 1;     // each order doubles required marks
ffffffff40030d4c:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40030d50:	d37ff800 	lsl	x0, x0, #1
ffffffff40030d54:	f90023e0 	str	x0, [sp, #64]
    for (i = N_ORD - 1; i >= 0; i--) {
ffffffff40030d58:	f9402fe0 	ldr	x0, [sp, #88]
ffffffff40030d5c:	d1000400 	sub	x0, x0, #0x1
ffffffff40030d60:	f9002fe0 	str	x0, [sp, #88]
ffffffff40030d64:	f9402fe0 	ldr	x0, [sp, #88]
ffffffff40030d68:	f100001f 	cmp	x0, #0x0
ffffffff40030d6c:	54fffa2a 	b.ge	ffffffff40030cb0 <kmem_init2+0x70>  // b.tcont
    }

    // add all available memory to the highest order bucket
    kmem.start_heap = align_up(kmem.start + total * sizeof(*mk), 1 << MAX_ORD);
ffffffff40030d70:	b0000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030d74:	91252000 	add	x0, x0, #0x948
ffffffff40030d78:	f9402001 	ldr	x1, [x0, #64]
ffffffff40030d7c:	f94027e0 	ldr	x0, [sp, #72]
ffffffff40030d80:	d37df000 	lsl	x0, x0, #3
ffffffff40030d84:	8b000020 	add	x0, x1, x0
ffffffff40030d88:	913ffc00 	add	x0, x0, #0xfff
ffffffff40030d8c:	9274cc01 	and	x1, x0, #0xfffffffffffff000
ffffffff40030d90:	b0000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030d94:	91252000 	add	x0, x0, #0x948
ffffffff40030d98:	f9002401 	str	x1, [x0, #72]
    
    for (i = kmem.start_heap; i < kmem.end; i += (1 << MAX_ORD)){
ffffffff40030d9c:	b0000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030da0:	91252000 	add	x0, x0, #0x948
ffffffff40030da4:	f9402400 	ldr	x0, [x0, #72]
ffffffff40030da8:	f9002fe0 	str	x0, [sp, #88]
ffffffff40030dac:	14000007 	b	ffffffff40030dc8 <kmem_init2+0x188>
        kfree ((void*)i, MAX_ORD);
ffffffff40030db0:	f9402fe0 	ldr	x0, [sp, #88]
ffffffff40030db4:	52800181 	mov	w1, #0xc                   	// #12
ffffffff40030db8:	9400017a 	bl	ffffffff400313a0 <kfree>
    for (i = kmem.start_heap; i < kmem.end; i += (1 << MAX_ORD)){
ffffffff40030dbc:	f9402fe0 	ldr	x0, [sp, #88]
ffffffff40030dc0:	91400400 	add	x0, x0, #0x1, lsl #12
ffffffff40030dc4:	f9002fe0 	str	x0, [sp, #88]
ffffffff40030dc8:	b0000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030dcc:	91252000 	add	x0, x0, #0x948
ffffffff40030dd0:	f9402801 	ldr	x1, [x0, #80]
ffffffff40030dd4:	f9402fe0 	ldr	x0, [sp, #88]
ffffffff40030dd8:	eb00003f 	cmp	x1, x0
ffffffff40030ddc:	54fffea8 	b.hi	ffffffff40030db0 <kmem_init2+0x170>  // b.pmore
    }
}
ffffffff40030de0:	d503201f 	nop
ffffffff40030de4:	d503201f 	nop
ffffffff40030de8:	a8c67bfd 	ldp	x29, x30, [sp], #96
ffffffff40030dec:	d65f03c0 	ret

ffffffff40030df0 <unmark_blk>:

// mark a block as unavailable
static void unmark_blk (int order, int blk_id)
{
ffffffff40030df0:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff40030df4:	910003fd 	mov	x29, sp
ffffffff40030df8:	b9001fe0 	str	w0, [sp, #28]
ffffffff40030dfc:	b9001be1 	str	w1, [sp, #24]
    struct mark     *mk, *p;
    struct order    *ord;
    int             prev, next;

    ord = &kmem.orders[order - MIN_ORD];
ffffffff40030e00:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40030e04:	51001800 	sub	w0, w0, #0x6
ffffffff40030e08:	93407c00 	sxtw	x0, w0
ffffffff40030e0c:	91002800 	add	x0, x0, #0xa
ffffffff40030e10:	d37df001 	lsl	x1, x0, #3
ffffffff40030e14:	b0000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030e18:	91252000 	add	x0, x0, #0x948
ffffffff40030e1c:	8b000020 	add	x0, x1, x0
ffffffff40030e20:	91002000 	add	x0, x0, #0x8
ffffffff40030e24:	f9001fe0 	str	x0, [sp, #56]
    mk  = get_mark (order, blk_id >> 5);
ffffffff40030e28:	b9401be0 	ldr	w0, [sp, #24]
ffffffff40030e2c:	13057c00 	asr	w0, w0, #5
ffffffff40030e30:	2a0003e1 	mov	w1, w0
ffffffff40030e34:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40030e38:	97ffff3d 	bl	ffffffff40030b2c <get_mark>
ffffffff40030e3c:	f9001be0 	str	x0, [sp, #48]

    // clear the bit in the bitmap
    if (!available(mk->bitmap, blk_id)) {
ffffffff40030e40:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40030e44:	b9400400 	ldr	w0, [x0, #4]
ffffffff40030e48:	b9401be1 	ldr	w1, [sp, #24]
ffffffff40030e4c:	97ffff67 	bl	ffffffff40030be8 <available>
ffffffff40030e50:	7100001f 	cmp	w0, #0x0
ffffffff40030e54:	54000081 	b.ne	ffffffff40030e64 <unmark_blk+0x74>  // b.any
        panic ("double alloc\n");
ffffffff40030e58:	f0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40030e5c:	9113a000 	add	x0, x0, #0x4e8
ffffffff40030e60:	9400029a 	bl	ffffffff400318c8 <panic>
    }

    mk->bitmap &= ~(1 << (blk_id & 0x1F));
ffffffff40030e64:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40030e68:	b9400400 	ldr	w0, [x0, #4]
ffffffff40030e6c:	b9401be1 	ldr	w1, [sp, #24]
ffffffff40030e70:	12001021 	and	w1, w1, #0x1f
ffffffff40030e74:	52800022 	mov	w2, #0x1                   	// #1
ffffffff40030e78:	1ac12041 	lsl	w1, w2, w1
ffffffff40030e7c:	2a2103e1 	mvn	w1, w1
ffffffff40030e80:	0a010001 	and	w1, w0, w1
ffffffff40030e84:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40030e88:	b9000401 	str	w1, [x0, #4]
    
    // if it's the last block in the bitmap, delete from the list
    if (mk->bitmap == 0) {
ffffffff40030e8c:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40030e90:	b9400400 	ldr	w0, [x0, #4]
ffffffff40030e94:	7100001f 	cmp	w0, #0x0
ffffffff40030e98:	54000701 	b.ne	ffffffff40030f78 <unmark_blk+0x188>  // b.any
        blk_id >>= 5;
ffffffff40030e9c:	b9401be0 	ldr	w0, [sp, #24]
ffffffff40030ea0:	13057c00 	asr	w0, w0, #5
ffffffff40030ea4:	b9001be0 	str	w0, [sp, #24]
        
        prev = PRE_LNK(mk->lnks);
ffffffff40030ea8:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40030eac:	b9400000 	ldr	w0, [x0]
ffffffff40030eb0:	53107c00 	lsr	w0, w0, #16
ffffffff40030eb4:	b9002fe0 	str	w0, [sp, #44]
        next = NEXT_LNK(mk->lnks);
ffffffff40030eb8:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40030ebc:	b9400000 	ldr	w0, [x0]
ffffffff40030ec0:	12003c00 	and	w0, w0, #0xffff
ffffffff40030ec4:	b9002be0 	str	w0, [sp, #40]

        if (prev != NIL) {
ffffffff40030ec8:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff40030ecc:	529fffe0 	mov	w0, #0xffff                	// #65535
ffffffff40030ed0:	6b00003f 	cmp	w1, w0
ffffffff40030ed4:	540001c0 	b.eq	ffffffff40030f0c <unmark_blk+0x11c>  // b.none
            p = get_mark(order, prev);
ffffffff40030ed8:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff40030edc:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40030ee0:	97ffff13 	bl	ffffffff40030b2c <get_mark>
ffffffff40030ee4:	f90013e0 	str	x0, [sp, #32]
            p->lnks = LNKS(PRE_LNK(p->lnks), next);
ffffffff40030ee8:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40030eec:	b9400000 	ldr	w0, [x0]
ffffffff40030ef0:	12103c01 	and	w1, w0, #0xffff0000
ffffffff40030ef4:	b9402be0 	ldr	w0, [sp, #40]
ffffffff40030ef8:	12003c00 	and	w0, w0, #0xffff
ffffffff40030efc:	2a000021 	orr	w1, w1, w0
ffffffff40030f00:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40030f04:	b9000001 	str	w1, [x0]
ffffffff40030f08:	14000009 	b	ffffffff40030f2c <unmark_blk+0x13c>
            
        } else if (ord->head == blk_id) {
ffffffff40030f0c:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40030f10:	b9400001 	ldr	w1, [x0]
ffffffff40030f14:	b9401be0 	ldr	w0, [sp, #24]
ffffffff40030f18:	6b00003f 	cmp	w1, w0
ffffffff40030f1c:	54000081 	b.ne	ffffffff40030f2c <unmark_blk+0x13c>  // b.any
            // if we are the first in the link
            ord->head = next;
ffffffff40030f20:	b9402be1 	ldr	w1, [sp, #40]
ffffffff40030f24:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40030f28:	b9000001 	str	w1, [x0]
        }

        if (next != NIL) {
ffffffff40030f2c:	b9402be1 	ldr	w1, [sp, #40]
ffffffff40030f30:	529fffe0 	mov	w0, #0xffff                	// #65535
ffffffff40030f34:	6b00003f 	cmp	w1, w0
ffffffff40030f38:	540001a0 	b.eq	ffffffff40030f6c <unmark_blk+0x17c>  // b.none
            p = get_mark(order, next);
ffffffff40030f3c:	b9402be1 	ldr	w1, [sp, #40]
ffffffff40030f40:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40030f44:	97fffefa 	bl	ffffffff40030b2c <get_mark>
ffffffff40030f48:	f90013e0 	str	x0, [sp, #32]
            p->lnks = LNKS(prev, NEXT_LNK(p->lnks));
ffffffff40030f4c:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40030f50:	53103c01 	lsl	w1, w0, #16
ffffffff40030f54:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40030f58:	b9400000 	ldr	w0, [x0]
ffffffff40030f5c:	12003c00 	and	w0, w0, #0xffff
ffffffff40030f60:	2a000021 	orr	w1, w1, w0
ffffffff40030f64:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40030f68:	b9000001 	str	w1, [x0]
        }

        mk->lnks = LNKS(NIL, NIL);
ffffffff40030f6c:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40030f70:	12800001 	mov	w1, #0xffffffff            	// #-1
ffffffff40030f74:	b9000001 	str	w1, [x0]
    }
}
ffffffff40030f78:	d503201f 	nop
ffffffff40030f7c:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff40030f80:	d65f03c0 	ret

ffffffff40030f84 <mark_blk>:

// mark a block as available
static void mark_blk (int order, int blk_id)
{
ffffffff40030f84:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff40030f88:	910003fd 	mov	x29, sp
ffffffff40030f8c:	b9001fe0 	str	w0, [sp, #28]
ffffffff40030f90:	b9001be1 	str	w1, [sp, #24]
    struct mark     *mk, *p;
    struct order    *ord;
    int             insert;
    
    ord = &kmem.orders[order - MIN_ORD];
ffffffff40030f94:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40030f98:	51001800 	sub	w0, w0, #0x6
ffffffff40030f9c:	93407c00 	sxtw	x0, w0
ffffffff40030fa0:	91002800 	add	x0, x0, #0xa
ffffffff40030fa4:	d37df001 	lsl	x1, x0, #3
ffffffff40030fa8:	b0000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40030fac:	91252000 	add	x0, x0, #0x948
ffffffff40030fb0:	8b000020 	add	x0, x1, x0
ffffffff40030fb4:	91002000 	add	x0, x0, #0x8
ffffffff40030fb8:	f9001fe0 	str	x0, [sp, #56]
    mk  = get_mark (order, blk_id >> 5);
ffffffff40030fbc:	b9401be0 	ldr	w0, [sp, #24]
ffffffff40030fc0:	13057c00 	asr	w0, w0, #5
ffffffff40030fc4:	2a0003e1 	mov	w1, w0
ffffffff40030fc8:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40030fcc:	97fffed8 	bl	ffffffff40030b2c <get_mark>
ffffffff40030fd0:	f9001be0 	str	x0, [sp, #48]

    // whether we need to insert it into the list
    insert = (mk->bitmap == 0);
ffffffff40030fd4:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40030fd8:	b9400400 	ldr	w0, [x0, #4]
ffffffff40030fdc:	7100001f 	cmp	w0, #0x0
ffffffff40030fe0:	1a9f17e0 	cset	w0, eq	// eq = none
ffffffff40030fe4:	12001c00 	and	w0, w0, #0xff
ffffffff40030fe8:	b9002fe0 	str	w0, [sp, #44]

    // clear the bit map
    if (available(mk->bitmap, blk_id)) {
ffffffff40030fec:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40030ff0:	b9400400 	ldr	w0, [x0, #4]
ffffffff40030ff4:	b9401be1 	ldr	w1, [sp, #24]
ffffffff40030ff8:	97fffefc 	bl	ffffffff40030be8 <available>
ffffffff40030ffc:	7100001f 	cmp	w0, #0x0
ffffffff40031000:	54000080 	b.eq	ffffffff40031010 <mark_blk+0x8c>  // b.none
        panic ("double free\n");
ffffffff40031004:	d0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40031008:	9113e000 	add	x0, x0, #0x4f8
ffffffff4003100c:	9400022f 	bl	ffffffff400318c8 <panic>
    }
    
    mk->bitmap |= (1 << (blk_id & 0x1F));
ffffffff40031010:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40031014:	b9400400 	ldr	w0, [x0, #4]
ffffffff40031018:	b9401be1 	ldr	w1, [sp, #24]
ffffffff4003101c:	12001021 	and	w1, w1, #0x1f
ffffffff40031020:	52800022 	mov	w2, #0x1                   	// #1
ffffffff40031024:	1ac12041 	lsl	w1, w2, w1
ffffffff40031028:	2a010001 	orr	w1, w0, w1
ffffffff4003102c:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40031030:	b9000401 	str	w1, [x0, #4]
    
    // just insert it to the head, no need to keep the list ordered
    if (insert) {
ffffffff40031034:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40031038:	7100001f 	cmp	w0, #0x0
ffffffff4003103c:	540003e0 	b.eq	ffffffff400310b8 <mark_blk+0x134>  // b.none
        blk_id >>= 5;
ffffffff40031040:	b9401be0 	ldr	w0, [sp, #24]
ffffffff40031044:	13057c00 	asr	w0, w0, #5
ffffffff40031048:	b9001be0 	str	w0, [sp, #24]
        mk->lnks = LNKS(NIL, ord->head);
ffffffff4003104c:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40031050:	b9400000 	ldr	w0, [x0]
ffffffff40031054:	32103c01 	orr	w1, w0, #0xffff0000
ffffffff40031058:	f9401be0 	ldr	x0, [sp, #48]
ffffffff4003105c:	b9000001 	str	w1, [x0]

        // fix the pre pointer of the next mark
        if (ord->head != NIL) {
ffffffff40031060:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40031064:	b9400001 	ldr	w1, [x0]
ffffffff40031068:	529fffe0 	mov	w0, #0xffff                	// #65535
ffffffff4003106c:	6b00003f 	cmp	w1, w0
ffffffff40031070:	540001e0 	b.eq	ffffffff400310ac <mark_blk+0x128>  // b.none
            p = get_mark(order, ord->head);
ffffffff40031074:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40031078:	b9400000 	ldr	w0, [x0]
ffffffff4003107c:	2a0003e1 	mov	w1, w0
ffffffff40031080:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40031084:	97fffeaa 	bl	ffffffff40030b2c <get_mark>
ffffffff40031088:	f90013e0 	str	x0, [sp, #32]
            p->lnks = LNKS(blk_id, NEXT_LNK(p->lnks));
ffffffff4003108c:	b9401be0 	ldr	w0, [sp, #24]
ffffffff40031090:	53103c01 	lsl	w1, w0, #16
ffffffff40031094:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40031098:	b9400000 	ldr	w0, [x0]
ffffffff4003109c:	12003c00 	and	w0, w0, #0xffff
ffffffff400310a0:	2a000021 	orr	w1, w1, w0
ffffffff400310a4:	f94013e0 	ldr	x0, [sp, #32]
ffffffff400310a8:	b9000001 	str	w1, [x0]
        }
        
        ord->head = blk_id;
ffffffff400310ac:	b9401be1 	ldr	w1, [sp, #24]
ffffffff400310b0:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff400310b4:	b9000001 	str	w1, [x0]
    }
}
ffffffff400310b8:	d503201f 	nop
ffffffff400310bc:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff400310c0:	d65f03c0 	ret

ffffffff400310c4 <get_blk>:

// get a block
static void* get_blk (int order)
{
ffffffff400310c4:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff400310c8:	910003fd 	mov	x29, sp
ffffffff400310cc:	b9001fe0 	str	w0, [sp, #28]
    struct mark *mk;
    int blk_id;
    int i;
    struct order *ord;

    ord = &kmem.orders[order - MIN_ORD];
ffffffff400310d0:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff400310d4:	51001800 	sub	w0, w0, #0x6
ffffffff400310d8:	93407c00 	sxtw	x0, w0
ffffffff400310dc:	91002800 	add	x0, x0, #0xa
ffffffff400310e0:	d37df001 	lsl	x1, x0, #3
ffffffff400310e4:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff400310e8:	91252000 	add	x0, x0, #0x948
ffffffff400310ec:	8b000020 	add	x0, x1, x0
ffffffff400310f0:	91002000 	add	x0, x0, #0x8
ffffffff400310f4:	f9001be0 	str	x0, [sp, #48]
    mk = get_mark(order, ord->head);
ffffffff400310f8:	f9401be0 	ldr	x0, [sp, #48]
ffffffff400310fc:	b9400000 	ldr	w0, [x0]
ffffffff40031100:	2a0003e1 	mov	w1, w0
ffffffff40031104:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40031108:	97fffe89 	bl	ffffffff40030b2c <get_mark>
ffffffff4003110c:	f90017e0 	str	x0, [sp, #40]

    if (mk->bitmap == 0) {
ffffffff40031110:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40031114:	b9400400 	ldr	w0, [x0, #4]
ffffffff40031118:	7100001f 	cmp	w0, #0x0
ffffffff4003111c:	54000081 	b.ne	ffffffff4003112c <get_blk+0x68>  // b.any
        panic ("empty mark in the list\n");
ffffffff40031120:	d0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40031124:	91142000 	add	x0, x0, #0x508
ffffffff40031128:	940001e8 	bl	ffffffff400318c8 <panic>
    }

    for (i = 0; i < 32; i++) {
ffffffff4003112c:	b9003fff 	str	wzr, [sp, #60]
ffffffff40031130:	14000019 	b	ffffffff40031194 <get_blk+0xd0>
        if (mk->bitmap & (1 << i)) {
ffffffff40031134:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40031138:	b9400400 	ldr	w0, [x0, #4]
ffffffff4003113c:	b9403fe1 	ldr	w1, [sp, #60]
ffffffff40031140:	52800022 	mov	w2, #0x1                   	// #1
ffffffff40031144:	1ac12041 	lsl	w1, w2, w1
ffffffff40031148:	0a010000 	and	w0, w0, w1
ffffffff4003114c:	7100001f 	cmp	w0, #0x0
ffffffff40031150:	540001c0 	b.eq	ffffffff40031188 <get_blk+0xc4>  // b.none
            blk_id = ord->head * 32 + i;
ffffffff40031154:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40031158:	b9400000 	ldr	w0, [x0]
ffffffff4003115c:	531b6801 	lsl	w1, w0, #5
ffffffff40031160:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40031164:	0b000020 	add	w0, w1, w0
ffffffff40031168:	b90027e0 	str	w0, [sp, #36]
            unmark_blk(order, blk_id);
ffffffff4003116c:	b94027e1 	ldr	w1, [sp, #36]
ffffffff40031170:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40031174:	97ffff1f 	bl	ffffffff40030df0 <unmark_blk>
            
            return blkid2mem(order, blk_id);
ffffffff40031178:	b94027e1 	ldr	w1, [sp, #36]
ffffffff4003117c:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40031180:	97fffe81 	bl	ffffffff40030b84 <blkid2mem>
ffffffff40031184:	14000008 	b	ffffffff400311a4 <get_blk+0xe0>
    for (i = 0; i < 32; i++) {
ffffffff40031188:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff4003118c:	11000400 	add	w0, w0, #0x1
ffffffff40031190:	b9003fe0 	str	w0, [sp, #60]
ffffffff40031194:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40031198:	71007c1f 	cmp	w0, #0x1f
ffffffff4003119c:	54fffccd 	b.le	ffffffff40031134 <get_blk+0x70>
        }
    }

    return NULL;
ffffffff400311a0:	d2800000 	mov	x0, #0x0                   	// #0
}
ffffffff400311a4:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff400311a8:	d65f03c0 	ret

ffffffff400311ac <_kmalloc>:

void _kfree (void *mem, int order);


static void *_kmalloc (int order)
{
ffffffff400311ac:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff400311b0:	910003fd 	mov	x29, sp
ffffffff400311b4:	b9001fe0 	str	w0, [sp, #28]
    struct order *ord;
    uint8         *up;

    ord = &kmem.orders[order - MIN_ORD];
ffffffff400311b8:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff400311bc:	51001800 	sub	w0, w0, #0x6
ffffffff400311c0:	93407c00 	sxtw	x0, w0
ffffffff400311c4:	91002800 	add	x0, x0, #0xa
ffffffff400311c8:	d37df001 	lsl	x1, x0, #3
ffffffff400311cc:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff400311d0:	91252000 	add	x0, x0, #0x948
ffffffff400311d4:	8b000020 	add	x0, x1, x0
ffffffff400311d8:	91002000 	add	x0, x0, #0x8
ffffffff400311dc:	f90013e0 	str	x0, [sp, #32]
    up  = NULL;
ffffffff400311e0:	f90017ff 	str	xzr, [sp, #40]
    
    if (ord->head != NIL) {
ffffffff400311e4:	f94013e0 	ldr	x0, [sp, #32]
ffffffff400311e8:	b9400001 	ldr	w1, [x0]
ffffffff400311ec:	529fffe0 	mov	w0, #0xffff                	// #65535
ffffffff400311f0:	6b00003f 	cmp	w1, w0
ffffffff400311f4:	540000a0 	b.eq	ffffffff40031208 <_kmalloc+0x5c>  // b.none
        up = get_blk(order);
ffffffff400311f8:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff400311fc:	97ffffb2 	bl	ffffffff400310c4 <get_blk>
ffffffff40031200:	f90017e0 	str	x0, [sp, #40]
ffffffff40031204:	14000013 	b	ffffffff40031250 <_kmalloc+0xa4>
        
    } else if (order < MAX_ORD){
ffffffff40031208:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003120c:	71002c1f 	cmp	w0, #0xb
ffffffff40031210:	5400020c 	b.gt	ffffffff40031250 <_kmalloc+0xa4>
        // if currently no block available, try to split a parent
        up = _kmalloc (order + 1);
ffffffff40031214:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40031218:	11000400 	add	w0, w0, #0x1
ffffffff4003121c:	97ffffe4 	bl	ffffffff400311ac <_kmalloc>
ffffffff40031220:	f90017e0 	str	x0, [sp, #40]

        if (up != NULL) {
ffffffff40031224:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40031228:	f100001f 	cmp	x0, #0x0
ffffffff4003122c:	54000120 	b.eq	ffffffff40031250 <_kmalloc+0xa4>  // b.none
            _kfree (up + (1 << order), order);
ffffffff40031230:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40031234:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40031238:	1ac02020 	lsl	w0, w1, w0
ffffffff4003123c:	93407c00 	sxtw	x0, w0
ffffffff40031240:	f94017e1 	ldr	x1, [sp, #40]
ffffffff40031244:	8b000020 	add	x0, x1, x0
ffffffff40031248:	b9401fe1 	ldr	w1, [sp, #28]
ffffffff4003124c:	9400001c 	bl	ffffffff400312bc <_kfree>
        }
    }

    return up;
ffffffff40031250:	f94017e0 	ldr	x0, [sp, #40]
}
ffffffff40031254:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff40031258:	d65f03c0 	ret

ffffffff4003125c <kmalloc>:

// allocate memory that has the size of (1 << order)
void *kmalloc (int order)
{
ffffffff4003125c:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40031260:	910003fd 	mov	x29, sp
ffffffff40031264:	b9001fe0 	str	w0, [sp, #28]
    uint8         *up;

    if ((order > MAX_ORD) || (order < MIN_ORD)) {
ffffffff40031268:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003126c:	7100301f 	cmp	w0, #0xc
ffffffff40031270:	5400008c 	b.gt	ffffffff40031280 <kmalloc+0x24>
ffffffff40031274:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40031278:	7100141f 	cmp	w0, #0x5
ffffffff4003127c:	5400008c 	b.gt	ffffffff4003128c <kmalloc+0x30>
        panic("kmalloc: order out of range\n");
ffffffff40031280:	d0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40031284:	91148000 	add	x0, x0, #0x520
ffffffff40031288:	94000190 	bl	ffffffff400318c8 <panic>
    }

    acquire(&kmem.lock);
ffffffff4003128c:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031290:	91252000 	add	x0, x0, #0x948
ffffffff40031294:	9400127c 	bl	ffffffff40035c84 <acquire>
    up = _kmalloc(order);
ffffffff40031298:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003129c:	97ffffc4 	bl	ffffffff400311ac <_kmalloc>
ffffffff400312a0:	f90017e0 	str	x0, [sp, #40]
    release(&kmem.lock);
ffffffff400312a4:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff400312a8:	91252000 	add	x0, x0, #0x948
ffffffff400312ac:	94001280 	bl	ffffffff40035cac <release>

    return up;
ffffffff400312b0:	f94017e0 	ldr	x0, [sp, #40]
}
ffffffff400312b4:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff400312b8:	d65f03c0 	ret

ffffffff400312bc <_kfree>:

void _kfree (void *mem, int order)
{
ffffffff400312bc:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff400312c0:	910003fd 	mov	x29, sp
ffffffff400312c4:	f9000fe0 	str	x0, [sp, #24]
ffffffff400312c8:	b90017e1 	str	w1, [sp, #20]
    int blk_id, buddy_id;
    struct mark *mk;

    blk_id = mem2blkid(order, mem);
ffffffff400312cc:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff400312d0:	b94017e0 	ldr	w0, [sp, #20]
ffffffff400312d4:	97fffe39 	bl	ffffffff40030bb8 <mem2blkid>
ffffffff400312d8:	b9003fe0 	str	w0, [sp, #60]
    mk = get_mark(order, blk_id >> 5);
ffffffff400312dc:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff400312e0:	13057c00 	asr	w0, w0, #5
ffffffff400312e4:	2a0003e1 	mov	w1, w0
ffffffff400312e8:	b94017e0 	ldr	w0, [sp, #20]
ffffffff400312ec:	97fffe10 	bl	ffffffff40030b2c <get_mark>
ffffffff400312f0:	f9001be0 	str	x0, [sp, #48]

    if (available(mk->bitmap, blk_id)) {
ffffffff400312f4:	f9401be0 	ldr	x0, [sp, #48]
ffffffff400312f8:	b9400400 	ldr	w0, [x0, #4]
ffffffff400312fc:	b9403fe1 	ldr	w1, [sp, #60]
ffffffff40031300:	97fffe3a 	bl	ffffffff40030be8 <available>
ffffffff40031304:	7100001f 	cmp	w0, #0x0
ffffffff40031308:	54000080 	b.eq	ffffffff40031318 <_kfree+0x5c>  // b.none
        panic ("kfree: double free");
ffffffff4003130c:	d0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40031310:	91150000 	add	x0, x0, #0x540
ffffffff40031314:	9400016d 	bl	ffffffff400318c8 <panic>
    }

    buddy_id = blk_id ^ 0x0001; // blk_id and buddy_id differs in the last bit
ffffffff40031318:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff4003131c:	52000000 	eor	w0, w0, #0x1
ffffffff40031320:	b9002fe0 	str	w0, [sp, #44]
                                // buddy must be in the same bit map
    if (!available(mk->bitmap, buddy_id) || (order == MAX_ORD)) {
ffffffff40031324:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40031328:	b9400400 	ldr	w0, [x0, #4]
ffffffff4003132c:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff40031330:	97fffe2e 	bl	ffffffff40030be8 <available>
ffffffff40031334:	7100001f 	cmp	w0, #0x0
ffffffff40031338:	54000080 	b.eq	ffffffff40031348 <_kfree+0x8c>  // b.none
ffffffff4003133c:	b94017e0 	ldr	w0, [sp, #20]
ffffffff40031340:	7100301f 	cmp	w0, #0xc
ffffffff40031344:	540000a1 	b.ne	ffffffff40031358 <_kfree+0x9c>  // b.any
        mark_blk(order, blk_id);
ffffffff40031348:	b9403fe1 	ldr	w1, [sp, #60]
ffffffff4003134c:	b94017e0 	ldr	w0, [sp, #20]
ffffffff40031350:	97ffff0d 	bl	ffffffff40030f84 <mark_blk>
ffffffff40031354:	14000010 	b	ffffffff40031394 <_kfree+0xd8>
    } else {
        // our buddy is also free, merge it
        unmark_blk (order, buddy_id);
ffffffff40031358:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff4003135c:	b94017e0 	ldr	w0, [sp, #20]
ffffffff40031360:	97fffea4 	bl	ffffffff40030df0 <unmark_blk>
        _kfree (blkid2mem(order, blk_id & ~0x0001), order+1);
ffffffff40031364:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40031368:	121f7800 	and	w0, w0, #0xfffffffe
ffffffff4003136c:	2a0003e1 	mov	w1, w0
ffffffff40031370:	b94017e0 	ldr	w0, [sp, #20]
ffffffff40031374:	97fffe04 	bl	ffffffff40030b84 <blkid2mem>
ffffffff40031378:	aa0003e2 	mov	x2, x0
ffffffff4003137c:	b94017e0 	ldr	w0, [sp, #20]
ffffffff40031380:	11000400 	add	w0, w0, #0x1
ffffffff40031384:	2a0003e1 	mov	w1, w0
ffffffff40031388:	aa0203e0 	mov	x0, x2
ffffffff4003138c:	97ffffcc 	bl	ffffffff400312bc <_kfree>
    }
}
ffffffff40031390:	d503201f 	nop
ffffffff40031394:	d503201f 	nop
ffffffff40031398:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff4003139c:	d65f03c0 	ret

ffffffff400313a0 <kfree>:

// free kernel memory, we require order parameter here to avoid
// storing size info somewhere which might break the alignment
void kfree (void *mem, int order)
{
ffffffff400313a0:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff400313a4:	910003fd 	mov	x29, sp
ffffffff400313a8:	f9000fe0 	str	x0, [sp, #24]
ffffffff400313ac:	b90017e1 	str	w1, [sp, #20]
    if ((order > MAX_ORD) || (order < MIN_ORD) || (uint64)mem & ((1<<order) -1)) {
ffffffff400313b0:	b94017e0 	ldr	w0, [sp, #20]
ffffffff400313b4:	7100301f 	cmp	w0, #0xc
ffffffff400313b8:	540001ac 	b.gt	ffffffff400313ec <kfree+0x4c>
ffffffff400313bc:	b94017e0 	ldr	w0, [sp, #20]
ffffffff400313c0:	7100141f 	cmp	w0, #0x5
ffffffff400313c4:	5400014d 	b.le	ffffffff400313ec <kfree+0x4c>
ffffffff400313c8:	b94017e0 	ldr	w0, [sp, #20]
ffffffff400313cc:	52800021 	mov	w1, #0x1                   	// #1
ffffffff400313d0:	1ac02020 	lsl	w0, w1, w0
ffffffff400313d4:	51000400 	sub	w0, w0, #0x1
ffffffff400313d8:	93407c01 	sxtw	x1, w0
ffffffff400313dc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400313e0:	8a000020 	and	x0, x1, x0
ffffffff400313e4:	f100001f 	cmp	x0, #0x0
ffffffff400313e8:	54000080 	b.eq	ffffffff400313f8 <kfree+0x58>  // b.none
        panic("kfree: order out of range or memory unaligned\n");
ffffffff400313ec:	d0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400313f0:	91156000 	add	x0, x0, #0x558
ffffffff400313f4:	94000135 	bl	ffffffff400318c8 <panic>
    }

    acquire(&kmem.lock);
ffffffff400313f8:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff400313fc:	91252000 	add	x0, x0, #0x948
ffffffff40031400:	94001221 	bl	ffffffff40035c84 <acquire>
    _kfree(mem, order);
ffffffff40031404:	b94017e1 	ldr	w1, [sp, #20]
ffffffff40031408:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003140c:	97ffffac 	bl	ffffffff400312bc <_kfree>
    release(&kmem.lock);
ffffffff40031410:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031414:	91252000 	add	x0, x0, #0x948
ffffffff40031418:	94001225 	bl	ffffffff40035cac <release>
}
ffffffff4003141c:	d503201f 	nop
ffffffff40031420:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40031424:	d65f03c0 	ret

ffffffff40031428 <free_page>:

// free a page
void free_page(void *v)
{
ffffffff40031428:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff4003142c:	910003fd 	mov	x29, sp
ffffffff40031430:	f9000fe0 	str	x0, [sp, #24]
    kfree (v, PTE_SHIFT);
ffffffff40031434:	52800181 	mov	w1, #0xc                   	// #12
ffffffff40031438:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003143c:	97ffffd9 	bl	ffffffff400313a0 <kfree>
}
ffffffff40031440:	d503201f 	nop
ffffffff40031444:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40031448:	d65f03c0 	ret

ffffffff4003144c <alloc_page>:

// allocate a page
void* alloc_page (void)
{
ffffffff4003144c:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff40031450:	910003fd 	mov	x29, sp
    return kmalloc (PTE_SHIFT);
ffffffff40031454:	52800180 	mov	w0, #0xc                   	// #12
ffffffff40031458:	97ffff81 	bl	ffffffff4003125c <kmalloc>
}
ffffffff4003145c:	a8c17bfd 	ldp	x29, x30, [sp], #16
ffffffff40031460:	d65f03c0 	ret

ffffffff40031464 <get_order>:

// round up power of 2, then get the order
//   http://graphics.stanford.edu/~seander/bithacks.html#RoundUpPowerOf2
int get_order (uint32 v)
{
ffffffff40031464:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40031468:	910003fd 	mov	x29, sp
ffffffff4003146c:	b9001fe0 	str	w0, [sp, #28]
    uint32 ord;
    
    v--;
ffffffff40031470:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40031474:	51000400 	sub	w0, w0, #0x1
ffffffff40031478:	b9001fe0 	str	w0, [sp, #28]
    v |= v >> 1;
ffffffff4003147c:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40031480:	53017c00 	lsr	w0, w0, #1
ffffffff40031484:	b9401fe1 	ldr	w1, [sp, #28]
ffffffff40031488:	2a000020 	orr	w0, w1, w0
ffffffff4003148c:	b9001fe0 	str	w0, [sp, #28]
    v |= v >> 2;
ffffffff40031490:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40031494:	53027c00 	lsr	w0, w0, #2
ffffffff40031498:	b9401fe1 	ldr	w1, [sp, #28]
ffffffff4003149c:	2a000020 	orr	w0, w1, w0
ffffffff400314a0:	b9001fe0 	str	w0, [sp, #28]
    v |= v >> 4;
ffffffff400314a4:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff400314a8:	53047c00 	lsr	w0, w0, #4
ffffffff400314ac:	b9401fe1 	ldr	w1, [sp, #28]
ffffffff400314b0:	2a000020 	orr	w0, w1, w0
ffffffff400314b4:	b9001fe0 	str	w0, [sp, #28]
    v |= v >> 8;
ffffffff400314b8:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff400314bc:	53087c00 	lsr	w0, w0, #8
ffffffff400314c0:	b9401fe1 	ldr	w1, [sp, #28]
ffffffff400314c4:	2a000020 	orr	w0, w1, w0
ffffffff400314c8:	b9001fe0 	str	w0, [sp, #28]
    v |= v >> 16;
ffffffff400314cc:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff400314d0:	53107c00 	lsr	w0, w0, #16
ffffffff400314d4:	b9401fe1 	ldr	w1, [sp, #28]
ffffffff400314d8:	2a000020 	orr	w0, w1, w0
ffffffff400314dc:	b9001fe0 	str	w0, [sp, #28]
    v++;
ffffffff400314e0:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff400314e4:	11000400 	add	w0, w0, #0x1
ffffffff400314e8:	b9001fe0 	str	w0, [sp, #28]

    for (ord = 0; ord < 32; ord++) {
ffffffff400314ec:	b9002fff 	str	wzr, [sp, #44]
ffffffff400314f0:	1400000c 	b	ffffffff40031520 <get_order+0xbc>
        if (v & (1 << ord)) {
ffffffff400314f4:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff400314f8:	52800021 	mov	w1, #0x1                   	// #1
ffffffff400314fc:	1ac02020 	lsl	w0, w1, w0
ffffffff40031500:	2a0003e1 	mov	w1, w0
ffffffff40031504:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40031508:	0a000020 	and	w0, w1, w0
ffffffff4003150c:	7100001f 	cmp	w0, #0x0
ffffffff40031510:	54000101 	b.ne	ffffffff40031530 <get_order+0xcc>  // b.any
    for (ord = 0; ord < 32; ord++) {
ffffffff40031514:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40031518:	11000400 	add	w0, w0, #0x1
ffffffff4003151c:	b9002fe0 	str	w0, [sp, #44]
ffffffff40031520:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40031524:	71007c1f 	cmp	w0, #0x1f
ffffffff40031528:	54fffe69 	b.ls	ffffffff400314f4 <get_order+0x90>  // b.plast
ffffffff4003152c:	14000002 	b	ffffffff40031534 <get_order+0xd0>
            break;
ffffffff40031530:	d503201f 	nop
        }
    }
    
    if (ord < MIN_ORD) {
ffffffff40031534:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40031538:	7100141f 	cmp	w0, #0x5
ffffffff4003153c:	54000088 	b.hi	ffffffff4003154c <get_order+0xe8>  // b.pmore
        ord = MIN_ORD;
ffffffff40031540:	528000c0 	mov	w0, #0x6                   	// #6
ffffffff40031544:	b9002fe0 	str	w0, [sp, #44]
ffffffff40031548:	14000007 	b	ffffffff40031564 <get_order+0x100>
    } else if (ord > MAX_ORD) {
ffffffff4003154c:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40031550:	7100301f 	cmp	w0, #0xc
ffffffff40031554:	54000089 	b.ls	ffffffff40031564 <get_order+0x100>  // b.plast
        panic ("order too big!");
ffffffff40031558:	d0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003155c:	91162000 	add	x0, x0, #0x588
ffffffff40031560:	940000da 	bl	ffffffff400318c8 <panic>
    }
    
    return ord;
ffffffff40031564:	b9402fe0 	ldr	w0, [sp, #44]

}
ffffffff40031568:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff4003156c:	d65f03c0 	ret

ffffffff40031570 <printint>:
    struct spinlock lock;
    int locking;
} cons;

static void printint (uint64 xx, int base, int sign)
{
ffffffff40031570:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff40031574:	910003fd 	mov	x29, sp
ffffffff40031578:	f9000fe0 	str	x0, [sp, #24]
ffffffff4003157c:	b90017e1 	str	w1, [sp, #20]
ffffffff40031580:	b90013e2 	str	w2, [sp, #16]
    static char digits[] = "0123456789abcdef";
    char buf[16];
    int i;
    uint64 x;

    if (sign && (sign = xx < 0)) {
ffffffff40031584:	b94013e0 	ldr	w0, [sp, #16]
ffffffff40031588:	7100001f 	cmp	w0, #0x0
ffffffff4003158c:	54000120 	b.eq	ffffffff400315b0 <printint+0x40>  // b.none
ffffffff40031590:	b90013ff 	str	wzr, [sp, #16]
ffffffff40031594:	b94013e0 	ldr	w0, [sp, #16]
ffffffff40031598:	7100001f 	cmp	w0, #0x0
ffffffff4003159c:	540000a0 	b.eq	ffffffff400315b0 <printint+0x40>  // b.none
        x = -xx;
ffffffff400315a0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400315a4:	cb0003e0 	neg	x0, x0
ffffffff400315a8:	f9001be0 	str	x0, [sp, #48]
ffffffff400315ac:	14000003 	b	ffffffff400315b8 <printint+0x48>
    } else {
        x = xx;
ffffffff400315b0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400315b4:	f9001be0 	str	x0, [sp, #48]
    }

    i = 0;
ffffffff400315b8:	b9003fff 	str	wzr, [sp, #60]

    do {
        buf[i++] = digits[x % base];
ffffffff400315bc:	b98017e1 	ldrsw	x1, [sp, #20]
ffffffff400315c0:	f9401be0 	ldr	x0, [sp, #48]
ffffffff400315c4:	9ac10802 	udiv	x2, x0, x1
ffffffff400315c8:	9b017c41 	mul	x1, x2, x1
ffffffff400315cc:	cb010001 	sub	x1, x0, x1
ffffffff400315d0:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff400315d4:	11000402 	add	w2, w0, #0x1
ffffffff400315d8:	b9003fe2 	str	w2, [sp, #60]
ffffffff400315dc:	f0000042 	adrp	x2, ffffffff4003c000 <digits.0>
ffffffff400315e0:	91000042 	add	x2, x2, #0x0
ffffffff400315e4:	38616842 	ldrb	w2, [x2, x1]
ffffffff400315e8:	93407c00 	sxtw	x0, w0
ffffffff400315ec:	910083e1 	add	x1, sp, #0x20
ffffffff400315f0:	38206822 	strb	w2, [x1, x0]
    } while ((x /= base) != 0);
ffffffff400315f4:	b98017e0 	ldrsw	x0, [sp, #20]
ffffffff400315f8:	f9401be1 	ldr	x1, [sp, #48]
ffffffff400315fc:	9ac00820 	udiv	x0, x1, x0
ffffffff40031600:	f9001be0 	str	x0, [sp, #48]
ffffffff40031604:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40031608:	f100001f 	cmp	x0, #0x0
ffffffff4003160c:	54fffd81 	b.ne	ffffffff400315bc <printint+0x4c>  // b.any

    if (sign) {
ffffffff40031610:	b94013e0 	ldr	w0, [sp, #16]
ffffffff40031614:	7100001f 	cmp	w0, #0x0
ffffffff40031618:	540001a0 	b.eq	ffffffff4003164c <printint+0xdc>  // b.none
        buf[i++] = '-';
ffffffff4003161c:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40031620:	11000401 	add	w1, w0, #0x1
ffffffff40031624:	b9003fe1 	str	w1, [sp, #60]
ffffffff40031628:	93407c00 	sxtw	x0, w0
ffffffff4003162c:	910083e1 	add	x1, sp, #0x20
ffffffff40031630:	528005a2 	mov	w2, #0x2d                  	// #45
ffffffff40031634:	38206822 	strb	w2, [x1, x0]
    }

    while (--i >= 0) {
ffffffff40031638:	14000005 	b	ffffffff4003164c <printint+0xdc>
        consputc(buf[i]);
ffffffff4003163c:	b9803fe0 	ldrsw	x0, [sp, #60]
ffffffff40031640:	910083e1 	add	x1, sp, #0x20
ffffffff40031644:	38606820 	ldrb	w0, [x1, x0]
ffffffff40031648:	940000b7 	bl	ffffffff40031924 <consputc>
    while (--i >= 0) {
ffffffff4003164c:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40031650:	51000400 	sub	w0, w0, #0x1
ffffffff40031654:	b9003fe0 	str	w0, [sp, #60]
ffffffff40031658:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff4003165c:	7100001f 	cmp	w0, #0x0
ffffffff40031660:	54fffeea 	b.ge	ffffffff4003163c <printint+0xcc>  // b.tcont
    }
}
ffffffff40031664:	d503201f 	nop
ffffffff40031668:	d503201f 	nop
ffffffff4003166c:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff40031670:	d65f03c0 	ret

ffffffff40031674 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void cprintf (char *fmt, ...)
{
ffffffff40031674:	a9b07bfd 	stp	x29, x30, [sp, #-256]!
ffffffff40031678:	910003fd 	mov	x29, sp
ffffffff4003167c:	f9000fe0 	str	x0, [sp, #24]
ffffffff40031680:	f90067e1 	str	x1, [sp, #200]
ffffffff40031684:	f9006be2 	str	x2, [sp, #208]
ffffffff40031688:	f9006fe3 	str	x3, [sp, #216]
ffffffff4003168c:	f90073e4 	str	x4, [sp, #224]
ffffffff40031690:	f90077e5 	str	x5, [sp, #232]
ffffffff40031694:	f9007be6 	str	x6, [sp, #240]
ffffffff40031698:	f9007fe7 	str	x7, [sp, #248]
ffffffff4003169c:	3d8013e0 	str	q0, [sp, #64]
ffffffff400316a0:	3d8017e1 	str	q1, [sp, #80]
ffffffff400316a4:	3d801be2 	str	q2, [sp, #96]
ffffffff400316a8:	3d801fe3 	str	q3, [sp, #112]
ffffffff400316ac:	3d8023e4 	str	q4, [sp, #128]
ffffffff400316b0:	3d8027e5 	str	q5, [sp, #144]
ffffffff400316b4:	3d802be6 	str	q6, [sp, #160]
ffffffff400316b8:	3d802fe7 	str	q7, [sp, #176]
    int i, c, locking;
    uint64 *argp;
    char *s;

    locking = cons.locking;
ffffffff400316bc:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff400316c0:	9130c000 	add	x0, x0, #0xc30
ffffffff400316c4:	b9404000 	ldr	w0, [x0, #64]
ffffffff400316c8:	b90027e0 	str	w0, [sp, #36]

    if (locking) {
ffffffff400316cc:	b94027e0 	ldr	w0, [sp, #36]
ffffffff400316d0:	7100001f 	cmp	w0, #0x0
ffffffff400316d4:	54000080 	b.eq	ffffffff400316e4 <cprintf+0x70>  // b.none
        acquire(&cons.lock);
ffffffff400316d8:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff400316dc:	9130c000 	add	x0, x0, #0xc30
ffffffff400316e0:	94001169 	bl	ffffffff40035c84 <acquire>
    }

    if (fmt == 0) {
ffffffff400316e4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400316e8:	f100001f 	cmp	x0, #0x0
ffffffff400316ec:	54000081 	b.ne	ffffffff400316fc <cprintf+0x88>  // b.any
        panic("null fmt");
ffffffff400316f0:	d0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400316f4:	91166000 	add	x0, x0, #0x598
ffffffff400316f8:	94000074 	bl	ffffffff400318c8 <panic>
    }

    argp = (uint64*) (void*) (&fmt + 22);
ffffffff400316fc:	910063e0 	add	x0, sp, #0x18
ffffffff40031700:	9102c000 	add	x0, x0, #0xb0
ffffffff40031704:	f9001be0 	str	x0, [sp, #48]

    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
ffffffff40031708:	b9003fff 	str	wzr, [sp, #60]
ffffffff4003170c:	1400005c 	b	ffffffff4003187c <cprintf+0x208>
        if (c != '%') {
ffffffff40031710:	b94023e0 	ldr	w0, [sp, #32]
ffffffff40031714:	7100941f 	cmp	w0, #0x25
ffffffff40031718:	54000080 	b.eq	ffffffff40031728 <cprintf+0xb4>  // b.none
            consputc(c);
ffffffff4003171c:	b94023e0 	ldr	w0, [sp, #32]
ffffffff40031720:	94000081 	bl	ffffffff40031924 <consputc>
            continue;
ffffffff40031724:	14000053 	b	ffffffff40031870 <cprintf+0x1fc>
        }

        c = fmt[++i] & 0xff;
ffffffff40031728:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff4003172c:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40031730:	11000400 	add	w0, w0, #0x1
ffffffff40031734:	b9003fe0 	str	w0, [sp, #60]
ffffffff40031738:	b9803fe0 	ldrsw	x0, [sp, #60]
ffffffff4003173c:	8b000020 	add	x0, x1, x0
ffffffff40031740:	39400000 	ldrb	w0, [x0]
ffffffff40031744:	b90023e0 	str	w0, [sp, #32]

        if (c == 0) {
ffffffff40031748:	b94023e0 	ldr	w0, [sp, #32]
ffffffff4003174c:	7100001f 	cmp	w0, #0x0
ffffffff40031750:	54000a80 	b.eq	ffffffff400318a0 <cprintf+0x22c>  // b.none
            break;
        }

        switch (c) {
ffffffff40031754:	b94023e0 	ldr	w0, [sp, #32]
ffffffff40031758:	7101e01f 	cmp	w0, #0x78
ffffffff4003175c:	540003c0 	b.eq	ffffffff400317d4 <cprintf+0x160>  // b.none
ffffffff40031760:	b94023e0 	ldr	w0, [sp, #32]
ffffffff40031764:	7101e01f 	cmp	w0, #0x78
ffffffff40031768:	540007ac 	b.gt	ffffffff4003185c <cprintf+0x1e8>
ffffffff4003176c:	b94023e0 	ldr	w0, [sp, #32]
ffffffff40031770:	7101cc1f 	cmp	w0, #0x73
ffffffff40031774:	54000400 	b.eq	ffffffff400317f4 <cprintf+0x180>  // b.none
ffffffff40031778:	b94023e0 	ldr	w0, [sp, #32]
ffffffff4003177c:	7101cc1f 	cmp	w0, #0x73
ffffffff40031780:	540006ec 	b.gt	ffffffff4003185c <cprintf+0x1e8>
ffffffff40031784:	b94023e0 	ldr	w0, [sp, #32]
ffffffff40031788:	7101c01f 	cmp	w0, #0x70
ffffffff4003178c:	54000240 	b.eq	ffffffff400317d4 <cprintf+0x160>  // b.none
ffffffff40031790:	b94023e0 	ldr	w0, [sp, #32]
ffffffff40031794:	7101c01f 	cmp	w0, #0x70
ffffffff40031798:	5400062c 	b.gt	ffffffff4003185c <cprintf+0x1e8>
ffffffff4003179c:	b94023e0 	ldr	w0, [sp, #32]
ffffffff400317a0:	7100941f 	cmp	w0, #0x25
ffffffff400317a4:	54000560 	b.eq	ffffffff40031850 <cprintf+0x1dc>  // b.none
ffffffff400317a8:	b94023e0 	ldr	w0, [sp, #32]
ffffffff400317ac:	7101901f 	cmp	w0, #0x64
ffffffff400317b0:	54000561 	b.ne	ffffffff4003185c <cprintf+0x1e8>  // b.any
        case 'd':
            printint(*argp++, 10, 1);
ffffffff400317b4:	f9401be0 	ldr	x0, [sp, #48]
ffffffff400317b8:	91002001 	add	x1, x0, #0x8
ffffffff400317bc:	f9001be1 	str	x1, [sp, #48]
ffffffff400317c0:	f9400000 	ldr	x0, [x0]
ffffffff400317c4:	52800022 	mov	w2, #0x1                   	// #1
ffffffff400317c8:	52800141 	mov	w1, #0xa                   	// #10
ffffffff400317cc:	97ffff69 	bl	ffffffff40031570 <printint>
            break;
ffffffff400317d0:	14000028 	b	ffffffff40031870 <cprintf+0x1fc>

        case 'x':
        case 'p':
            printint(*argp++, 16, 0);
ffffffff400317d4:	f9401be0 	ldr	x0, [sp, #48]
ffffffff400317d8:	91002001 	add	x1, x0, #0x8
ffffffff400317dc:	f9001be1 	str	x1, [sp, #48]
ffffffff400317e0:	f9400000 	ldr	x0, [x0]
ffffffff400317e4:	52800002 	mov	w2, #0x0                   	// #0
ffffffff400317e8:	52800201 	mov	w1, #0x10                  	// #16
ffffffff400317ec:	97ffff61 	bl	ffffffff40031570 <printint>
            break;
ffffffff400317f0:	14000020 	b	ffffffff40031870 <cprintf+0x1fc>

        case 's':
            if ((s = (char*) *argp++) == 0) {
ffffffff400317f4:	f9401be0 	ldr	x0, [sp, #48]
ffffffff400317f8:	91002001 	add	x1, x0, #0x8
ffffffff400317fc:	f9001be1 	str	x1, [sp, #48]
ffffffff40031800:	f9400000 	ldr	x0, [x0]
ffffffff40031804:	f90017e0 	str	x0, [sp, #40]
ffffffff40031808:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003180c:	f100001f 	cmp	x0, #0x0
ffffffff40031810:	54000161 	b.ne	ffffffff4003183c <cprintf+0x1c8>  // b.any
                s = "(null)";
ffffffff40031814:	d0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40031818:	9116a000 	add	x0, x0, #0x5a8
ffffffff4003181c:	f90017e0 	str	x0, [sp, #40]
            }

            for (; *s; s++) {
ffffffff40031820:	14000007 	b	ffffffff4003183c <cprintf+0x1c8>
                consputc(*s);
ffffffff40031824:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40031828:	39400000 	ldrb	w0, [x0]
ffffffff4003182c:	9400003e 	bl	ffffffff40031924 <consputc>
            for (; *s; s++) {
ffffffff40031830:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40031834:	91000400 	add	x0, x0, #0x1
ffffffff40031838:	f90017e0 	str	x0, [sp, #40]
ffffffff4003183c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40031840:	39400000 	ldrb	w0, [x0]
ffffffff40031844:	7100001f 	cmp	w0, #0x0
ffffffff40031848:	54fffee1 	b.ne	ffffffff40031824 <cprintf+0x1b0>  // b.any
            }
            break;
ffffffff4003184c:	14000009 	b	ffffffff40031870 <cprintf+0x1fc>

        case '%':
            consputc('%');
ffffffff40031850:	528004a0 	mov	w0, #0x25                  	// #37
ffffffff40031854:	94000034 	bl	ffffffff40031924 <consputc>
            break;
ffffffff40031858:	14000006 	b	ffffffff40031870 <cprintf+0x1fc>

        default:
            // Print unknown % sequence to draw attention.
            consputc('%');
ffffffff4003185c:	528004a0 	mov	w0, #0x25                  	// #37
ffffffff40031860:	94000031 	bl	ffffffff40031924 <consputc>
            consputc(c);
ffffffff40031864:	b94023e0 	ldr	w0, [sp, #32]
ffffffff40031868:	9400002f 	bl	ffffffff40031924 <consputc>
            break;
ffffffff4003186c:	d503201f 	nop
    for (i = 0; (c = fmt[i] & 0xff) != 0; i++) {
ffffffff40031870:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40031874:	11000400 	add	w0, w0, #0x1
ffffffff40031878:	b9003fe0 	str	w0, [sp, #60]
ffffffff4003187c:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40031880:	b9803fe0 	ldrsw	x0, [sp, #60]
ffffffff40031884:	8b000020 	add	x0, x1, x0
ffffffff40031888:	39400000 	ldrb	w0, [x0]
ffffffff4003188c:	b90023e0 	str	w0, [sp, #32]
ffffffff40031890:	b94023e0 	ldr	w0, [sp, #32]
ffffffff40031894:	7100001f 	cmp	w0, #0x0
ffffffff40031898:	54fff3c1 	b.ne	ffffffff40031710 <cprintf+0x9c>  // b.any
ffffffff4003189c:	14000002 	b	ffffffff400318a4 <cprintf+0x230>
            break;
ffffffff400318a0:	d503201f 	nop
        }
    }

    if (locking) {
ffffffff400318a4:	b94027e0 	ldr	w0, [sp, #36]
ffffffff400318a8:	7100001f 	cmp	w0, #0x0
ffffffff400318ac:	54000080 	b.eq	ffffffff400318bc <cprintf+0x248>  // b.none
        release(&cons.lock);
ffffffff400318b0:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff400318b4:	9130c000 	add	x0, x0, #0xc30
ffffffff400318b8:	940010fd 	bl	ffffffff40035cac <release>
    }
}
ffffffff400318bc:	d503201f 	nop
ffffffff400318c0:	a8d07bfd 	ldp	x29, x30, [sp], #256
ffffffff400318c4:	d65f03c0 	ret

ffffffff400318c8 <panic>:

void panic (char *s)
{
ffffffff400318c8:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff400318cc:	910003fd 	mov	x29, sp
ffffffff400318d0:	f9000fe0 	str	x0, [sp, #24]
    cli();
ffffffff400318d4:	97fffaf9 	bl	ffffffff400304b8 <cli>

    cons.locking = 0;
ffffffff400318d8:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff400318dc:	9130c000 	add	x0, x0, #0xc30
ffffffff400318e0:	b900401f 	str	wzr, [x0, #64]

    cprintf("cpu%d: panic: ", cpu->id);
ffffffff400318e4:	d0000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff400318e8:	913b6000 	add	x0, x0, #0xed8
ffffffff400318ec:	f9400000 	ldr	x0, [x0]
ffffffff400318f0:	39400000 	ldrb	w0, [x0]
ffffffff400318f4:	2a0003e1 	mov	w1, w0
ffffffff400318f8:	d0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400318fc:	9116c000 	add	x0, x0, #0x5b0
ffffffff40031900:	97ffff5d 	bl	ffffffff40031674 <cprintf>

    show_callstk(s);
ffffffff40031904:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40031908:	97fffb75 	bl	ffffffff400306dc <show_callstk>
    panicked = 1; // freeze other CPU
ffffffff4003190c:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031910:	9130a000 	add	x0, x0, #0xc28
ffffffff40031914:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40031918:	b9000001 	str	w1, [x0]

    while (1)
ffffffff4003191c:	d503201f 	nop
ffffffff40031920:	17ffffff 	b	ffffffff4003191c <panic+0x54>

ffffffff40031924 <consputc>:
//PAGEBREAK: 50
#define BACKSPACE 0x100
#define CRTPORT 0x3d4

void consputc (int c)
{
ffffffff40031924:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40031928:	910003fd 	mov	x29, sp
ffffffff4003192c:	b9001fe0 	str	w0, [sp, #28]
    if (panicked) {
ffffffff40031930:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031934:	9130a000 	add	x0, x0, #0xc28
ffffffff40031938:	b9400000 	ldr	w0, [x0]
ffffffff4003193c:	7100001f 	cmp	w0, #0x0
ffffffff40031940:	54000080 	b.eq	ffffffff40031950 <consputc+0x2c>  // b.none
        cli();
ffffffff40031944:	97fffadd 	bl	ffffffff400304b8 <cli>
        while (1)
ffffffff40031948:	d503201f 	nop
ffffffff4003194c:	17ffffff 	b	ffffffff40031948 <consputc+0x24>
            ;
    }

    if (c == BACKSPACE) {
ffffffff40031950:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40031954:	7104001f 	cmp	w0, #0x100
ffffffff40031958:	54000101 	b.ne	ffffffff40031978 <consputc+0x54>  // b.any
        uartputc('\b');
ffffffff4003195c:	52800100 	mov	w0, #0x8                   	// #8
ffffffff40031960:	940024b1 	bl	ffffffff4003ac24 <uartputc>
        uartputc(' ');
ffffffff40031964:	52800400 	mov	w0, #0x20                  	// #32
ffffffff40031968:	940024af 	bl	ffffffff4003ac24 <uartputc>
        uartputc('\b');
ffffffff4003196c:	52800100 	mov	w0, #0x8                   	// #8
ffffffff40031970:	940024ad 	bl	ffffffff4003ac24 <uartputc>
    } else {
        uartputc(c);
    }

    // cgaputc(c);
}
ffffffff40031974:	14000003 	b	ffffffff40031980 <consputc+0x5c>
        uartputc(c);
ffffffff40031978:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003197c:	940024aa 	bl	ffffffff4003ac24 <uartputc>
}
ffffffff40031980:	d503201f 	nop
ffffffff40031984:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40031988:	d65f03c0 	ret

ffffffff4003198c <consoleintr>:
    uint e;  // Edit index
} input;

#define C(x)  ((x)-'@')  // Control-x
void consoleintr (int (*getc) (void))
{
ffffffff4003198c:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40031990:	910003fd 	mov	x29, sp
ffffffff40031994:	f9000fe0 	str	x0, [sp, #24]
    int c;

    acquire(&input.lock);
ffffffff40031998:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff4003199c:	91276000 	add	x0, x0, #0x9d8
ffffffff400319a0:	940010b9 	bl	ffffffff40035c84 <acquire>

    while ((c = getc()) >= 0) {
ffffffff400319a4:	14000088 	b	ffffffff40031bc4 <consoleintr+0x238>
        switch (c) {
ffffffff400319a8:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff400319ac:	7101fc1f 	cmp	w0, #0x7f
ffffffff400319b0:	54000600 	b.eq	ffffffff40031a70 <consoleintr+0xe4>  // b.none
ffffffff400319b4:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff400319b8:	7101fc1f 	cmp	w0, #0x7f
ffffffff400319bc:	540007ec 	b.gt	ffffffff40031ab8 <consoleintr+0x12c>
ffffffff400319c0:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff400319c4:	7100541f 	cmp	w0, #0x15
ffffffff400319c8:	540002a0 	b.eq	ffffffff40031a1c <consoleintr+0x90>  // b.none
ffffffff400319cc:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff400319d0:	7100541f 	cmp	w0, #0x15
ffffffff400319d4:	5400072c 	b.gt	ffffffff40031ab8 <consoleintr+0x12c>
ffffffff400319d8:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff400319dc:	7100201f 	cmp	w0, #0x8
ffffffff400319e0:	54000480 	b.eq	ffffffff40031a70 <consoleintr+0xe4>  // b.none
ffffffff400319e4:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff400319e8:	7100401f 	cmp	w0, #0x10
ffffffff400319ec:	54000661 	b.ne	ffffffff40031ab8 <consoleintr+0x12c>  // b.any
        case C('P'):  // Process listing.
            procdump();
ffffffff400319f0:	9400105e 	bl	ffffffff40035b68 <procdump>
            break;
ffffffff400319f4:	14000074 	b	ffffffff40031bc4 <consoleintr+0x238>

        case C('U'):  // Kill line.
            while ((input.e != input.w) && (input.buf[(input.e - 1) % INPUT_BUF] != '\n')) {
                input.e--;
ffffffff400319f8:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff400319fc:	91276000 	add	x0, x0, #0x9d8
ffffffff40031a00:	b9424800 	ldr	w0, [x0, #584]
ffffffff40031a04:	51000401 	sub	w1, w0, #0x1
ffffffff40031a08:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031a0c:	91276000 	add	x0, x0, #0x9d8
ffffffff40031a10:	b9024801 	str	w1, [x0, #584]
                consputc(BACKSPACE);
ffffffff40031a14:	52802000 	mov	w0, #0x100                 	// #256
ffffffff40031a18:	97ffffc3 	bl	ffffffff40031924 <consputc>
            while ((input.e != input.w) && (input.buf[(input.e - 1) % INPUT_BUF] != '\n')) {
ffffffff40031a1c:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031a20:	91276000 	add	x0, x0, #0x9d8
ffffffff40031a24:	b9424801 	ldr	w1, [x0, #584]
ffffffff40031a28:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031a2c:	91276000 	add	x0, x0, #0x9d8
ffffffff40031a30:	b9424400 	ldr	w0, [x0, #580]
ffffffff40031a34:	6b00003f 	cmp	w1, w0
ffffffff40031a38:	54000bc0 	b.eq	ffffffff40031bb0 <consoleintr+0x224>  // b.none
ffffffff40031a3c:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031a40:	91276000 	add	x0, x0, #0x9d8
ffffffff40031a44:	b9424800 	ldr	w0, [x0, #584]
ffffffff40031a48:	51000400 	sub	w0, w0, #0x1
ffffffff40031a4c:	12002002 	and	w2, w0, #0x1ff
ffffffff40031a50:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031a54:	91276001 	add	x1, x0, #0x9d8
ffffffff40031a58:	2a0203e0 	mov	w0, w2
ffffffff40031a5c:	8b000020 	add	x0, x1, x0
ffffffff40031a60:	39410000 	ldrb	w0, [x0, #64]
ffffffff40031a64:	7100281f 	cmp	w0, #0xa
ffffffff40031a68:	54fffc81 	b.ne	ffffffff400319f8 <consoleintr+0x6c>  // b.any
            }

            break;
ffffffff40031a6c:	14000051 	b	ffffffff40031bb0 <consoleintr+0x224>

        case C('H'):
        case '\x7f':  // Backspace
            if (input.e != input.w) {
ffffffff40031a70:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031a74:	91276000 	add	x0, x0, #0x9d8
ffffffff40031a78:	b9424801 	ldr	w1, [x0, #584]
ffffffff40031a7c:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031a80:	91276000 	add	x0, x0, #0x9d8
ffffffff40031a84:	b9424400 	ldr	w0, [x0, #580]
ffffffff40031a88:	6b00003f 	cmp	w1, w0
ffffffff40031a8c:	54000960 	b.eq	ffffffff40031bb8 <consoleintr+0x22c>  // b.none
                input.e--;
ffffffff40031a90:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031a94:	91276000 	add	x0, x0, #0x9d8
ffffffff40031a98:	b9424800 	ldr	w0, [x0, #584]
ffffffff40031a9c:	51000401 	sub	w1, w0, #0x1
ffffffff40031aa0:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031aa4:	91276000 	add	x0, x0, #0x9d8
ffffffff40031aa8:	b9024801 	str	w1, [x0, #584]
                consputc(BACKSPACE);
ffffffff40031aac:	52802000 	mov	w0, #0x100                 	// #256
ffffffff40031ab0:	97ffff9d 	bl	ffffffff40031924 <consputc>
            }

            break;
ffffffff40031ab4:	14000041 	b	ffffffff40031bb8 <consoleintr+0x22c>

        default:
            if ((c != 0) && (input.e - input.r < INPUT_BUF)) {
ffffffff40031ab8:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40031abc:	7100001f 	cmp	w0, #0x0
ffffffff40031ac0:	54000800 	b.eq	ffffffff40031bc0 <consoleintr+0x234>  // b.none
ffffffff40031ac4:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031ac8:	91276000 	add	x0, x0, #0x9d8
ffffffff40031acc:	b9424801 	ldr	w1, [x0, #584]
ffffffff40031ad0:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031ad4:	91276000 	add	x0, x0, #0x9d8
ffffffff40031ad8:	b9424000 	ldr	w0, [x0, #576]
ffffffff40031adc:	4b000020 	sub	w0, w1, w0
ffffffff40031ae0:	7107fc1f 	cmp	w0, #0x1ff
ffffffff40031ae4:	540006e8 	b.hi	ffffffff40031bc0 <consoleintr+0x234>  // b.pmore
                c = (c == '\r') ? '\n' : c;
ffffffff40031ae8:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40031aec:	7100341f 	cmp	w0, #0xd
ffffffff40031af0:	54000081 	b.ne	ffffffff40031b00 <consoleintr+0x174>  // b.any
ffffffff40031af4:	52800140 	mov	w0, #0xa                   	// #10
ffffffff40031af8:	b9002fe0 	str	w0, [sp, #44]
ffffffff40031afc:	14000002 	b	ffffffff40031b04 <consoleintr+0x178>
ffffffff40031b00:	d503201f 	nop

                input.buf[input.e++ % INPUT_BUF] = c;
ffffffff40031b04:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031b08:	91276000 	add	x0, x0, #0x9d8
ffffffff40031b0c:	b9424800 	ldr	w0, [x0, #584]
ffffffff40031b10:	11000402 	add	w2, w0, #0x1
ffffffff40031b14:	90000461 	adrp	x1, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031b18:	91276021 	add	x1, x1, #0x9d8
ffffffff40031b1c:	b9024822 	str	w2, [x1, #584]
ffffffff40031b20:	12002003 	and	w3, w0, #0x1ff
ffffffff40031b24:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40031b28:	12001c02 	and	w2, w0, #0xff
ffffffff40031b2c:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031b30:	91276001 	add	x1, x0, #0x9d8
ffffffff40031b34:	2a0303e0 	mov	w0, w3
ffffffff40031b38:	8b000020 	add	x0, x1, x0
ffffffff40031b3c:	2a0203e1 	mov	w1, w2
ffffffff40031b40:	39010001 	strb	w1, [x0, #64]
                consputc(c);
ffffffff40031b44:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40031b48:	97ffff77 	bl	ffffffff40031924 <consputc>

                if (c == '\n' || c == C('D') || input.e == input.r + INPUT_BUF) {
ffffffff40031b4c:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40031b50:	7100281f 	cmp	w0, #0xa
ffffffff40031b54:	540001a0 	b.eq	ffffffff40031b88 <consoleintr+0x1fc>  // b.none
ffffffff40031b58:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40031b5c:	7100101f 	cmp	w0, #0x4
ffffffff40031b60:	54000140 	b.eq	ffffffff40031b88 <consoleintr+0x1fc>  // b.none
ffffffff40031b64:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031b68:	91276000 	add	x0, x0, #0x9d8
ffffffff40031b6c:	b9424801 	ldr	w1, [x0, #584]
ffffffff40031b70:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031b74:	91276000 	add	x0, x0, #0x9d8
ffffffff40031b78:	b9424000 	ldr	w0, [x0, #576]
ffffffff40031b7c:	11080000 	add	w0, w0, #0x200
ffffffff40031b80:	6b00003f 	cmp	w1, w0
ffffffff40031b84:	540001e1 	b.ne	ffffffff40031bc0 <consoleintr+0x234>  // b.any
                    input.w = input.e;
ffffffff40031b88:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031b8c:	91276000 	add	x0, x0, #0x9d8
ffffffff40031b90:	b9424801 	ldr	w1, [x0, #584]
ffffffff40031b94:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031b98:	91276000 	add	x0, x0, #0x9d8
ffffffff40031b9c:	b9024401 	str	w1, [x0, #580]
                    wakeup(&input.r);
ffffffff40031ba0:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031ba4:	91306000 	add	x0, x0, #0xc18
ffffffff40031ba8:	94000fb6 	bl	ffffffff40035a80 <wakeup>
                }
            }

            break;
ffffffff40031bac:	14000005 	b	ffffffff40031bc0 <consoleintr+0x234>
            break;
ffffffff40031bb0:	d503201f 	nop
ffffffff40031bb4:	14000004 	b	ffffffff40031bc4 <consoleintr+0x238>
            break;
ffffffff40031bb8:	d503201f 	nop
ffffffff40031bbc:	14000002 	b	ffffffff40031bc4 <consoleintr+0x238>
            break;
ffffffff40031bc0:	d503201f 	nop
    while ((c = getc()) >= 0) {
ffffffff40031bc4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40031bc8:	d63f0000 	blr	x0
ffffffff40031bcc:	b9002fe0 	str	w0, [sp, #44]
ffffffff40031bd0:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40031bd4:	7100001f 	cmp	w0, #0x0
ffffffff40031bd8:	54ffee8a 	b.ge	ffffffff400319a8 <consoleintr+0x1c>  // b.tcont
        }
    }

    release(&input.lock);
ffffffff40031bdc:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031be0:	91276000 	add	x0, x0, #0x9d8
ffffffff40031be4:	94001032 	bl	ffffffff40035cac <release>
}
ffffffff40031be8:	d503201f 	nop
ffffffff40031bec:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff40031bf0:	d65f03c0 	ret

ffffffff40031bf4 <consoleread>:

int consoleread (struct inode *ip, char *dst, int n)
{
ffffffff40031bf4:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff40031bf8:	910003fd 	mov	x29, sp
ffffffff40031bfc:	f90017e0 	str	x0, [sp, #40]
ffffffff40031c00:	f90013e1 	str	x1, [sp, #32]
ffffffff40031c04:	b9001fe2 	str	w2, [sp, #28]
    uint target;
    int c;

    iunlock(ip);
ffffffff40031c08:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40031c0c:	94000525 	bl	ffffffff400330a0 <iunlock>

    target = n;
ffffffff40031c10:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40031c14:	b9003fe0 	str	w0, [sp, #60]
    acquire(&input.lock);
ffffffff40031c18:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031c1c:	91276000 	add	x0, x0, #0x9d8
ffffffff40031c20:	94001019 	bl	ffffffff40035c84 <acquire>

    while (n > 0) {
ffffffff40031c24:	14000044 	b	ffffffff40031d34 <consoleread+0x140>
        while (input.r == input.w) {
            if (proc->killed) {
ffffffff40031c28:	d0000580 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40031c2c:	911e0000 	add	x0, x0, #0x780
ffffffff40031c30:	f9400000 	ldr	x0, [x0]
ffffffff40031c34:	b9404000 	ldr	w0, [x0, #64]
ffffffff40031c38:	7100001f 	cmp	w0, #0x0
ffffffff40031c3c:	54000100 	b.eq	ffffffff40031c5c <consoleread+0x68>  // b.none
                release(&input.lock);
ffffffff40031c40:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031c44:	91276000 	add	x0, x0, #0x9d8
ffffffff40031c48:	94001019 	bl	ffffffff40035cac <release>
                ilock(ip);
ffffffff40031c4c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40031c50:	940004ad 	bl	ffffffff40032f04 <ilock>
                return -1;
ffffffff40031c54:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40031c58:	14000046 	b	ffffffff40031d70 <consoleread+0x17c>
            }

            sleep(&input.r, &input.lock);
ffffffff40031c5c:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031c60:	91276001 	add	x1, x0, #0x9d8
ffffffff40031c64:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031c68:	91306000 	add	x0, x0, #0xc18
ffffffff40031c6c:	94000f2f 	bl	ffffffff40035928 <sleep>
        while (input.r == input.w) {
ffffffff40031c70:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031c74:	91276000 	add	x0, x0, #0x9d8
ffffffff40031c78:	b9424001 	ldr	w1, [x0, #576]
ffffffff40031c7c:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031c80:	91276000 	add	x0, x0, #0x9d8
ffffffff40031c84:	b9424400 	ldr	w0, [x0, #580]
ffffffff40031c88:	6b00003f 	cmp	w1, w0
ffffffff40031c8c:	54fffce0 	b.eq	ffffffff40031c28 <consoleread+0x34>  // b.none
        }

        c = input.buf[input.r++ % INPUT_BUF];
ffffffff40031c90:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031c94:	91276000 	add	x0, x0, #0x9d8
ffffffff40031c98:	b9424000 	ldr	w0, [x0, #576]
ffffffff40031c9c:	11000402 	add	w2, w0, #0x1
ffffffff40031ca0:	90000461 	adrp	x1, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031ca4:	91276021 	add	x1, x1, #0x9d8
ffffffff40031ca8:	b9024022 	str	w2, [x1, #576]
ffffffff40031cac:	12002002 	and	w2, w0, #0x1ff
ffffffff40031cb0:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031cb4:	91276001 	add	x1, x0, #0x9d8
ffffffff40031cb8:	2a0203e0 	mov	w0, w2
ffffffff40031cbc:	8b000020 	add	x0, x1, x0
ffffffff40031cc0:	39410000 	ldrb	w0, [x0, #64]
ffffffff40031cc4:	b9003be0 	str	w0, [sp, #56]

        if (c == C('D')) {  // EOF
ffffffff40031cc8:	b9403be0 	ldr	w0, [sp, #56]
ffffffff40031ccc:	7100101f 	cmp	w0, #0x4
ffffffff40031cd0:	540001a1 	b.ne	ffffffff40031d04 <consoleread+0x110>  // b.any
            if (n < target) {
ffffffff40031cd4:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40031cd8:	b9403fe1 	ldr	w1, [sp, #60]
ffffffff40031cdc:	6b00003f 	cmp	w1, w0
ffffffff40031ce0:	54000329 	b.ls	ffffffff40031d44 <consoleread+0x150>  // b.plast
                // Save ^D for next time, to make sure
                // caller gets a 0-byte result.
                input.r--;
ffffffff40031ce4:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031ce8:	91276000 	add	x0, x0, #0x9d8
ffffffff40031cec:	b9424000 	ldr	w0, [x0, #576]
ffffffff40031cf0:	51000401 	sub	w1, w0, #0x1
ffffffff40031cf4:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031cf8:	91276000 	add	x0, x0, #0x9d8
ffffffff40031cfc:	b9024001 	str	w1, [x0, #576]
            }

            break;
ffffffff40031d00:	14000011 	b	ffffffff40031d44 <consoleread+0x150>
        }

        *dst++ = c;
ffffffff40031d04:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40031d08:	91000401 	add	x1, x0, #0x1
ffffffff40031d0c:	f90013e1 	str	x1, [sp, #32]
ffffffff40031d10:	b9403be1 	ldr	w1, [sp, #56]
ffffffff40031d14:	12001c21 	and	w1, w1, #0xff
ffffffff40031d18:	39000001 	strb	w1, [x0]
        --n;
ffffffff40031d1c:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40031d20:	51000400 	sub	w0, w0, #0x1
ffffffff40031d24:	b9001fe0 	str	w0, [sp, #28]

        if (c == '\n') {
ffffffff40031d28:	b9403be0 	ldr	w0, [sp, #56]
ffffffff40031d2c:	7100281f 	cmp	w0, #0xa
ffffffff40031d30:	540000e0 	b.eq	ffffffff40031d4c <consoleread+0x158>  // b.none
    while (n > 0) {
ffffffff40031d34:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40031d38:	7100001f 	cmp	w0, #0x0
ffffffff40031d3c:	54fff9ac 	b.gt	ffffffff40031c70 <consoleread+0x7c>
ffffffff40031d40:	14000004 	b	ffffffff40031d50 <consoleread+0x15c>
            break;
ffffffff40031d44:	d503201f 	nop
ffffffff40031d48:	14000002 	b	ffffffff40031d50 <consoleread+0x15c>
            break;
ffffffff40031d4c:	d503201f 	nop
        }
    }

    release(&input.lock);
ffffffff40031d50:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031d54:	91276000 	add	x0, x0, #0x9d8
ffffffff40031d58:	94000fd5 	bl	ffffffff40035cac <release>
    ilock(ip);
ffffffff40031d5c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40031d60:	94000469 	bl	ffffffff40032f04 <ilock>

    return target - n;
ffffffff40031d64:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40031d68:	b9403fe1 	ldr	w1, [sp, #60]
ffffffff40031d6c:	4b000020 	sub	w0, w1, w0
}
ffffffff40031d70:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff40031d74:	d65f03c0 	ret

ffffffff40031d78 <consolewrite>:

int consolewrite (struct inode *ip, char *buf, int n)
{
ffffffff40031d78:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff40031d7c:	910003fd 	mov	x29, sp
ffffffff40031d80:	f90017e0 	str	x0, [sp, #40]
ffffffff40031d84:	f90013e1 	str	x1, [sp, #32]
ffffffff40031d88:	b9001fe2 	str	w2, [sp, #28]
    int i;

    iunlock(ip);
ffffffff40031d8c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40031d90:	940004c4 	bl	ffffffff400330a0 <iunlock>

    acquire(&cons.lock);
ffffffff40031d94:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031d98:	9130c000 	add	x0, x0, #0xc30
ffffffff40031d9c:	94000fba 	bl	ffffffff40035c84 <acquire>

    for (i = 0; i < n; i++) {
ffffffff40031da0:	b9003fff 	str	wzr, [sp, #60]
ffffffff40031da4:	14000009 	b	ffffffff40031dc8 <consolewrite+0x50>
        consputc(buf[i] & 0xff);
ffffffff40031da8:	b9803fe0 	ldrsw	x0, [sp, #60]
ffffffff40031dac:	f94013e1 	ldr	x1, [sp, #32]
ffffffff40031db0:	8b000020 	add	x0, x1, x0
ffffffff40031db4:	39400000 	ldrb	w0, [x0]
ffffffff40031db8:	97fffedb 	bl	ffffffff40031924 <consputc>
    for (i = 0; i < n; i++) {
ffffffff40031dbc:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40031dc0:	11000400 	add	w0, w0, #0x1
ffffffff40031dc4:	b9003fe0 	str	w0, [sp, #60]
ffffffff40031dc8:	b9403fe1 	ldr	w1, [sp, #60]
ffffffff40031dcc:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40031dd0:	6b00003f 	cmp	w1, w0
ffffffff40031dd4:	54fffeab 	b.lt	ffffffff40031da8 <consolewrite+0x30>  // b.tstop
    }

    release(&cons.lock);
ffffffff40031dd8:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031ddc:	9130c000 	add	x0, x0, #0xc30
ffffffff40031de0:	94000fb3 	bl	ffffffff40035cac <release>

    ilock(ip);
ffffffff40031de4:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40031de8:	94000447 	bl	ffffffff40032f04 <ilock>

    return n;
ffffffff40031dec:	b9401fe0 	ldr	w0, [sp, #28]
}
ffffffff40031df0:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff40031df4:	d65f03c0 	ret

ffffffff40031df8 <consoleinit>:

void consoleinit (void)
{
ffffffff40031df8:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff40031dfc:	910003fd 	mov	x29, sp
    initlock(&cons.lock, "console");
ffffffff40031e00:	d0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40031e04:	91170001 	add	x1, x0, #0x5c0
ffffffff40031e08:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031e0c:	9130c000 	add	x0, x0, #0xc30
ffffffff40031e10:	94000f90 	bl	ffffffff40035c50 <initlock>
    initlock(&input.lock, "input");
ffffffff40031e14:	d0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40031e18:	91172001 	add	x1, x0, #0x5c8
ffffffff40031e1c:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031e20:	91276000 	add	x0, x0, #0x9d8
ffffffff40031e24:	94000f8b 	bl	ffffffff40035c50 <initlock>

    devsw[CONSOLE].write = consolewrite;
ffffffff40031e28:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031e2c:	9131e000 	add	x0, x0, #0xc78
ffffffff40031e30:	90000001 	adrp	x1, ffffffff40031000 <mark_blk+0x7c>
ffffffff40031e34:	9135e021 	add	x1, x1, #0xd78
ffffffff40031e38:	f9000c01 	str	x1, [x0, #24]
    devsw[CONSOLE].read = consoleread;
ffffffff40031e3c:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031e40:	9131e000 	add	x0, x0, #0xc78
ffffffff40031e44:	90000001 	adrp	x1, ffffffff40031000 <mark_blk+0x7c>
ffffffff40031e48:	912fd021 	add	x1, x1, #0xbf4
ffffffff40031e4c:	f9000801 	str	x1, [x0, #16]

    cons.locking = 1;
ffffffff40031e50:	90000460 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40031e54:	9130c000 	add	x0, x0, #0xc30
ffffffff40031e58:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40031e5c:	b9004001 	str	w1, [x0, #64]
}
ffffffff40031e60:	d503201f 	nop
ffffffff40031e64:	a8c17bfd 	ldp	x29, x30, [sp], #16
ffffffff40031e68:	d65f03c0 	ret

ffffffff40031e6c <exec>:
#include "elf.h"
#include "arm.h"

// load a user program for execution
int exec (char *path, char **argv)
{
ffffffff40031e6c:	d10843ff 	sub	sp, sp, #0x210
ffffffff40031e70:	a9007bfd 	stp	x29, x30, [sp]
ffffffff40031e74:	910003fd 	mov	x29, sp
ffffffff40031e78:	a90153f3 	stp	x19, x20, [sp, #16]
ffffffff40031e7c:	f90017e0 	str	x0, [sp, #40]
ffffffff40031e80:	f90013e1 	str	x1, [sp, #32]
    uint argc;
    uint64 sz;
    uint64 sp;
    uint64 ustack[3 + MAXARG + 1];

    if ((ip = namei(path)) == 0) {
ffffffff40031e84:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40031e88:	940007db 	bl	ffffffff40033df4 <namei>
ffffffff40031e8c:	f90107e0 	str	x0, [sp, #520]
ffffffff40031e90:	f94107e0 	ldr	x0, [sp, #520]
ffffffff40031e94:	f100001f 	cmp	x0, #0x0
ffffffff40031e98:	54000061 	b.ne	ffffffff40031ea4 <exec+0x38>  // b.any
        return -1;
ffffffff40031e9c:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40031ea0:	14000128 	b	ffffffff40032340 <exec+0x4d4>
    }

    ilock(ip);
ffffffff40031ea4:	f94107e0 	ldr	x0, [sp, #520]
ffffffff40031ea8:	94000417 	bl	ffffffff40032f04 <ilock>

    // Check ELF header
    if (readi(ip, (char*) &elf, 0, sizeof(elf)) < sizeof(elf)) {
ffffffff40031eac:	910623e0 	add	x0, sp, #0x188
ffffffff40031eb0:	52800803 	mov	w3, #0x40                  	// #64
ffffffff40031eb4:	52800002 	mov	w2, #0x0                   	// #0
ffffffff40031eb8:	aa0003e1 	mov	x1, x0
ffffffff40031ebc:	f94107e0 	ldr	x0, [sp, #520]
ffffffff40031ec0:	940005b2 	bl	ffffffff40033588 <readi>
ffffffff40031ec4:	7100fc1f 	cmp	w0, #0x3f
ffffffff40031ec8:	54001fc9 	b.ls	ffffffff400322c0 <exec+0x454>  // b.plast
        goto bad;
    }

    if (elf.magic != ELF_MAGIC) {
ffffffff40031ecc:	b9418be1 	ldr	w1, [sp, #392]
ffffffff40031ed0:	5288afe0 	mov	w0, #0x457f                	// #17791
ffffffff40031ed4:	72a8c980 	movk	w0, #0x464c, lsl #16
ffffffff40031ed8:	6b00003f 	cmp	w1, w0
ffffffff40031edc:	54001f61 	b.ne	ffffffff400322c8 <exec+0x45c>  // b.any
        goto bad;
    }

    pgdir = 0;
ffffffff40031ee0:	f90103ff 	str	xzr, [sp, #512]

    if ((pgdir = kpt_alloc()) == 0) {
ffffffff40031ee4:	94001fe2 	bl	ffffffff40039e6c <kpt_alloc>
ffffffff40031ee8:	f90103e0 	str	x0, [sp, #512]
ffffffff40031eec:	f94103e0 	ldr	x0, [sp, #512]
ffffffff40031ef0:	f100001f 	cmp	x0, #0x0
ffffffff40031ef4:	54001ee0 	b.eq	ffffffff400322d0 <exec+0x464>  // b.none
        goto bad;
    }

    // Load program into memory.
    sz = 0;
ffffffff40031ef8:	f900efff 	str	xzr, [sp, #472]

    for (i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)) {
ffffffff40031efc:	b901efff 	str	wzr, [sp, #492]
ffffffff40031f00:	f940d7e0 	ldr	x0, [sp, #424]
ffffffff40031f04:	b901ebe0 	str	w0, [sp, #488]
ffffffff40031f08:	14000034 	b	ffffffff40031fd8 <exec+0x16c>
        if (readi(ip, (char*) &ph, off, sizeof(ph)) != sizeof(ph)) {
ffffffff40031f0c:	b941ebe1 	ldr	w1, [sp, #488]
ffffffff40031f10:	910543e0 	add	x0, sp, #0x150
ffffffff40031f14:	52800703 	mov	w3, #0x38                  	// #56
ffffffff40031f18:	2a0103e2 	mov	w2, w1
ffffffff40031f1c:	aa0003e1 	mov	x1, x0
ffffffff40031f20:	f94107e0 	ldr	x0, [sp, #520]
ffffffff40031f24:	94000599 	bl	ffffffff40033588 <readi>
ffffffff40031f28:	7100e01f 	cmp	w0, #0x38
ffffffff40031f2c:	54001d61 	b.ne	ffffffff400322d8 <exec+0x46c>  // b.any
            goto bad;
        }

        if (ph.type != ELF_PROG_LOAD) {
ffffffff40031f30:	b94153e0 	ldr	w0, [sp, #336]
ffffffff40031f34:	7100041f 	cmp	w0, #0x1
ffffffff40031f38:	54000421 	b.ne	ffffffff40031fbc <exec+0x150>  // b.any
            continue;
        }

        if (ph.memsz < ph.filesz) {
ffffffff40031f3c:	f940bfe1 	ldr	x1, [sp, #376]
ffffffff40031f40:	f940bbe0 	ldr	x0, [sp, #368]
ffffffff40031f44:	eb00003f 	cmp	x1, x0
ffffffff40031f48:	54001cc3 	b.cc	ffffffff400322e0 <exec+0x474>  // b.lo, b.ul, b.last
            goto bad;
        }

        if ((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0) {
ffffffff40031f4c:	f940efe0 	ldr	x0, [sp, #472]
ffffffff40031f50:	2a0003e3 	mov	w3, w0
ffffffff40031f54:	f940b3e0 	ldr	x0, [sp, #352]
ffffffff40031f58:	2a0003e1 	mov	w1, w0
ffffffff40031f5c:	f940bfe0 	ldr	x0, [sp, #376]
ffffffff40031f60:	0b000020 	add	w0, w1, w0
ffffffff40031f64:	2a0003e2 	mov	w2, w0
ffffffff40031f68:	2a0303e1 	mov	w1, w3
ffffffff40031f6c:	f94103e0 	ldr	x0, [sp, #512]
ffffffff40031f70:	940020fb 	bl	ffffffff4003a35c <allocuvm>
ffffffff40031f74:	93407c00 	sxtw	x0, w0
ffffffff40031f78:	f900efe0 	str	x0, [sp, #472]
ffffffff40031f7c:	f940efe0 	ldr	x0, [sp, #472]
ffffffff40031f80:	f100001f 	cmp	x0, #0x0
ffffffff40031f84:	54001b20 	b.eq	ffffffff400322e8 <exec+0x47c>  // b.none
            goto bad;
        }

        if (loaduvm(pgdir, (char*) ph.vaddr, ip, ph.off, ph.filesz) < 0) {
ffffffff40031f88:	f940b3e0 	ldr	x0, [sp, #352]
ffffffff40031f8c:	aa0003e1 	mov	x1, x0
ffffffff40031f90:	f940afe0 	ldr	x0, [sp, #344]
ffffffff40031f94:	2a0003e2 	mov	w2, w0
ffffffff40031f98:	f940bbe0 	ldr	x0, [sp, #368]
ffffffff40031f9c:	2a0003e4 	mov	w4, w0
ffffffff40031fa0:	2a0203e3 	mov	w3, w2
ffffffff40031fa4:	f94107e2 	ldr	x2, [sp, #520]
ffffffff40031fa8:	f94103e0 	ldr	x0, [sp, #512]
ffffffff40031fac:	940020a3 	bl	ffffffff4003a238 <loaduvm>
ffffffff40031fb0:	7100001f 	cmp	w0, #0x0
ffffffff40031fb4:	540019eb 	b.lt	ffffffff400322f0 <exec+0x484>  // b.tstop
ffffffff40031fb8:	14000002 	b	ffffffff40031fc0 <exec+0x154>
            continue;
ffffffff40031fbc:	d503201f 	nop
    for (i = 0, off = elf.phoff; i < elf.phnum; i++, off += sizeof(ph)) {
ffffffff40031fc0:	b941efe0 	ldr	w0, [sp, #492]
ffffffff40031fc4:	11000400 	add	w0, w0, #0x1
ffffffff40031fc8:	b901efe0 	str	w0, [sp, #492]
ffffffff40031fcc:	b941ebe0 	ldr	w0, [sp, #488]
ffffffff40031fd0:	1100e000 	add	w0, w0, #0x38
ffffffff40031fd4:	b901ebe0 	str	w0, [sp, #488]
ffffffff40031fd8:	794383e0 	ldrh	w0, [sp, #448]
ffffffff40031fdc:	2a0003e1 	mov	w1, w0
ffffffff40031fe0:	b941efe0 	ldr	w0, [sp, #492]
ffffffff40031fe4:	6b01001f 	cmp	w0, w1
ffffffff40031fe8:	54fff92b 	b.lt	ffffffff40031f0c <exec+0xa0>  // b.tstop
            goto bad;
        }
    }

    iunlockput(ip);
ffffffff40031fec:	f94107e0 	ldr	x0, [sp, #520]
ffffffff40031ff0:	94000489 	bl	ffffffff40033214 <iunlockput>
    ip = 0;
ffffffff40031ff4:	f90107ff 	str	xzr, [sp, #520]

    // Allocate two pages at the next page boundary.
    // Make the first inaccessible.  Use the second as the user stack.
    sz = align_up (sz, PTE_SZ);
ffffffff40031ff8:	f940efe0 	ldr	x0, [sp, #472]
ffffffff40031ffc:	913ffc00 	add	x0, x0, #0xfff
ffffffff40032000:	9274cc00 	and	x0, x0, #0xfffffffffffff000
ffffffff40032004:	f900efe0 	str	x0, [sp, #472]

    if ((sz = allocuvm(pgdir, sz, sz + 2 * PTE_SZ)) == 0) {
ffffffff40032008:	f940efe0 	ldr	x0, [sp, #472]
ffffffff4003200c:	2a0003e1 	mov	w1, w0
ffffffff40032010:	f940efe0 	ldr	x0, [sp, #472]
ffffffff40032014:	11400800 	add	w0, w0, #0x2, lsl #12
ffffffff40032018:	2a0003e2 	mov	w2, w0
ffffffff4003201c:	f94103e0 	ldr	x0, [sp, #512]
ffffffff40032020:	940020cf 	bl	ffffffff4003a35c <allocuvm>
ffffffff40032024:	93407c00 	sxtw	x0, w0
ffffffff40032028:	f900efe0 	str	x0, [sp, #472]
ffffffff4003202c:	f940efe0 	ldr	x0, [sp, #472]
ffffffff40032030:	f100001f 	cmp	x0, #0x0
ffffffff40032034:	54001620 	b.eq	ffffffff400322f8 <exec+0x48c>  // b.none
        goto bad;
    }

    clearpteu(pgdir, (char*) (sz - 2 * PTE_SZ));
ffffffff40032038:	f940efe0 	ldr	x0, [sp, #472]
ffffffff4003203c:	d1400800 	sub	x0, x0, #0x2, lsl #12
ffffffff40032040:	aa0003e1 	mov	x1, x0
ffffffff40032044:	f94103e0 	ldr	x0, [sp, #512]
ffffffff40032048:	94002185 	bl	ffffffff4003a65c <clearpteu>

    sp = sz;
ffffffff4003204c:	f940efe0 	ldr	x0, [sp, #472]
ffffffff40032050:	f900ebe0 	str	x0, [sp, #464]

    // Push argument strings, prepare rest of stack in ustack.
    for (argc = 0; argv[argc]; argc++) {
ffffffff40032054:	b901e7ff 	str	wzr, [sp, #484]
ffffffff40032058:	1400002d 	b	ffffffff4003210c <exec+0x2a0>
        if (argc >= MAXARG) {
ffffffff4003205c:	b941e7e0 	ldr	w0, [sp, #484]
ffffffff40032060:	71007c1f 	cmp	w0, #0x1f
ffffffff40032064:	540014e8 	b.hi	ffffffff40032300 <exec+0x494>  // b.pmore
            goto bad;
        }

        sp = (sp - (strlen(argv[argc]) + 1)) & ~7;
ffffffff40032068:	b941e7e0 	ldr	w0, [sp, #484]
ffffffff4003206c:	d37df000 	lsl	x0, x0, #3
ffffffff40032070:	f94013e1 	ldr	x1, [sp, #32]
ffffffff40032074:	8b000020 	add	x0, x1, x0
ffffffff40032078:	f9400000 	ldr	x0, [x0]
ffffffff4003207c:	97fff8ff 	bl	ffffffff40030478 <strlen>
ffffffff40032080:	11000400 	add	w0, w0, #0x1
ffffffff40032084:	93407c00 	sxtw	x0, w0
ffffffff40032088:	f940ebe1 	ldr	x1, [sp, #464]
ffffffff4003208c:	cb000020 	sub	x0, x1, x0
ffffffff40032090:	927df000 	and	x0, x0, #0xfffffffffffffff8
ffffffff40032094:	f900ebe0 	str	x0, [sp, #464]

        if (copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0) {
ffffffff40032098:	f940ebe0 	ldr	x0, [sp, #464]
ffffffff4003209c:	2a0003f4 	mov	w20, w0
ffffffff400320a0:	b941e7e0 	ldr	w0, [sp, #484]
ffffffff400320a4:	d37df000 	lsl	x0, x0, #3
ffffffff400320a8:	f94013e1 	ldr	x1, [sp, #32]
ffffffff400320ac:	8b000020 	add	x0, x1, x0
ffffffff400320b0:	f9400013 	ldr	x19, [x0]
ffffffff400320b4:	b941e7e0 	ldr	w0, [sp, #484]
ffffffff400320b8:	d37df000 	lsl	x0, x0, #3
ffffffff400320bc:	f94013e1 	ldr	x1, [sp, #32]
ffffffff400320c0:	8b000020 	add	x0, x1, x0
ffffffff400320c4:	f9400000 	ldr	x0, [x0]
ffffffff400320c8:	97fff8ec 	bl	ffffffff40030478 <strlen>
ffffffff400320cc:	11000400 	add	w0, w0, #0x1
ffffffff400320d0:	2a0003e3 	mov	w3, w0
ffffffff400320d4:	aa1303e2 	mov	x2, x19
ffffffff400320d8:	2a1403e1 	mov	w1, w20
ffffffff400320dc:	f94103e0 	ldr	x0, [sp, #512]
ffffffff400320e0:	940021de 	bl	ffffffff4003a858 <copyout>
ffffffff400320e4:	7100001f 	cmp	w0, #0x0
ffffffff400320e8:	5400110b 	b.lt	ffffffff40032308 <exec+0x49c>  // b.tstop
            goto bad;
        }

        ustack[argc] = sp;
ffffffff400320ec:	b941e7e0 	ldr	w0, [sp, #484]
ffffffff400320f0:	d37df000 	lsl	x0, x0, #3
ffffffff400320f4:	9100c3e1 	add	x1, sp, #0x30
ffffffff400320f8:	f940ebe2 	ldr	x2, [sp, #464]
ffffffff400320fc:	f8206822 	str	x2, [x1, x0]
    for (argc = 0; argv[argc]; argc++) {
ffffffff40032100:	b941e7e0 	ldr	w0, [sp, #484]
ffffffff40032104:	11000400 	add	w0, w0, #0x1
ffffffff40032108:	b901e7e0 	str	w0, [sp, #484]
ffffffff4003210c:	b941e7e0 	ldr	w0, [sp, #484]
ffffffff40032110:	d37df000 	lsl	x0, x0, #3
ffffffff40032114:	f94013e1 	ldr	x1, [sp, #32]
ffffffff40032118:	8b000020 	add	x0, x1, x0
ffffffff4003211c:	f9400000 	ldr	x0, [x0]
ffffffff40032120:	f100001f 	cmp	x0, #0x0
ffffffff40032124:	54fff9c1 	b.ne	ffffffff4003205c <exec+0x1f0>  // b.any
    }

    ustack[argc] = 0;
ffffffff40032128:	b941e7e0 	ldr	w0, [sp, #484]
ffffffff4003212c:	d37df000 	lsl	x0, x0, #3
ffffffff40032130:	9100c3e1 	add	x1, sp, #0x30
ffffffff40032134:	f820683f 	str	xzr, [x1, x0]

    // in ARM, parameters are passed in r0 and r1
    proc->tf->r0 = argc;
ffffffff40032138:	b0000580 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003213c:	911e0000 	add	x0, x0, #0x780
ffffffff40032140:	f9400000 	ldr	x0, [x0]
ffffffff40032144:	f9401400 	ldr	x0, [x0, #40]
ffffffff40032148:	b941e7e1 	ldr	w1, [sp, #484]
ffffffff4003214c:	f9000c01 	str	x1, [x0, #24]
    proc->tf->r1 = sp - (argc + 1) * 8;
ffffffff40032150:	b941e7e0 	ldr	w0, [sp, #484]
ffffffff40032154:	11000400 	add	w0, w0, #0x1
ffffffff40032158:	531d7000 	lsl	w0, w0, #3
ffffffff4003215c:	2a0003e1 	mov	w1, w0
ffffffff40032160:	b0000580 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40032164:	911e0000 	add	x0, x0, #0x780
ffffffff40032168:	f9400000 	ldr	x0, [x0]
ffffffff4003216c:	f9401400 	ldr	x0, [x0, #40]
ffffffff40032170:	f940ebe2 	ldr	x2, [sp, #464]
ffffffff40032174:	cb010041 	sub	x1, x2, x1
ffffffff40032178:	f9001001 	str	x1, [x0, #32]

    sp -= (argc + 1) * 8;
ffffffff4003217c:	b941e7e0 	ldr	w0, [sp, #484]
ffffffff40032180:	11000400 	add	w0, w0, #0x1
ffffffff40032184:	531d7000 	lsl	w0, w0, #3
ffffffff40032188:	2a0003e0 	mov	w0, w0
ffffffff4003218c:	f940ebe1 	ldr	x1, [sp, #464]
ffffffff40032190:	cb000020 	sub	x0, x1, x0
ffffffff40032194:	f900ebe0 	str	x0, [sp, #464]

    if (copyout(pgdir, sp, ustack, (argc + 1) * 8) < 0) {
ffffffff40032198:	f940ebe0 	ldr	x0, [sp, #464]
ffffffff4003219c:	2a0003e4 	mov	w4, w0
ffffffff400321a0:	b941e7e0 	ldr	w0, [sp, #484]
ffffffff400321a4:	11000400 	add	w0, w0, #0x1
ffffffff400321a8:	531d7001 	lsl	w1, w0, #3
ffffffff400321ac:	9100c3e0 	add	x0, sp, #0x30
ffffffff400321b0:	2a0103e3 	mov	w3, w1
ffffffff400321b4:	aa0003e2 	mov	x2, x0
ffffffff400321b8:	2a0403e1 	mov	w1, w4
ffffffff400321bc:	f94103e0 	ldr	x0, [sp, #512]
ffffffff400321c0:	940021a6 	bl	ffffffff4003a858 <copyout>
ffffffff400321c4:	7100001f 	cmp	w0, #0x0
ffffffff400321c8:	54000a4b 	b.lt	ffffffff40032310 <exec+0x4a4>  // b.tstop
        goto bad;
    }

    // Save program name for debugging.
    for (last = s = path; *s; s++) {
ffffffff400321cc:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400321d0:	f900ffe0 	str	x0, [sp, #504]
ffffffff400321d4:	f940ffe0 	ldr	x0, [sp, #504]
ffffffff400321d8:	f900fbe0 	str	x0, [sp, #496]
ffffffff400321dc:	1400000b 	b	ffffffff40032208 <exec+0x39c>
        if (*s == '/') {
ffffffff400321e0:	f940ffe0 	ldr	x0, [sp, #504]
ffffffff400321e4:	39400000 	ldrb	w0, [x0]
ffffffff400321e8:	7100bc1f 	cmp	w0, #0x2f
ffffffff400321ec:	54000081 	b.ne	ffffffff400321fc <exec+0x390>  // b.any
            last = s + 1;
ffffffff400321f0:	f940ffe0 	ldr	x0, [sp, #504]
ffffffff400321f4:	91000400 	add	x0, x0, #0x1
ffffffff400321f8:	f900fbe0 	str	x0, [sp, #496]
    for (last = s = path; *s; s++) {
ffffffff400321fc:	f940ffe0 	ldr	x0, [sp, #504]
ffffffff40032200:	91000400 	add	x0, x0, #0x1
ffffffff40032204:	f900ffe0 	str	x0, [sp, #504]
ffffffff40032208:	f940ffe0 	ldr	x0, [sp, #504]
ffffffff4003220c:	39400000 	ldrb	w0, [x0]
ffffffff40032210:	7100001f 	cmp	w0, #0x0
ffffffff40032214:	54fffe61 	b.ne	ffffffff400321e0 <exec+0x374>  // b.any
        }
    }

    safestrcpy(proc->name, last, sizeof(proc->name));
ffffffff40032218:	b0000580 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003221c:	911e0000 	add	x0, x0, #0x780
ffffffff40032220:	f9400000 	ldr	x0, [x0]
ffffffff40032224:	91034000 	add	x0, x0, #0xd0
ffffffff40032228:	52800202 	mov	w2, #0x10                  	// #16
ffffffff4003222c:	f940fbe1 	ldr	x1, [sp, #496]
ffffffff40032230:	97fff870 	bl	ffffffff400303f0 <safestrcpy>

    // Commit to the user image.
    oldpgdir = proc->pgdir;
ffffffff40032234:	b0000580 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40032238:	911e0000 	add	x0, x0, #0x780
ffffffff4003223c:	f9400000 	ldr	x0, [x0]
ffffffff40032240:	f9400400 	ldr	x0, [x0, #8]
ffffffff40032244:	f900e7e0 	str	x0, [sp, #456]
    proc->pgdir = pgdir;
ffffffff40032248:	b0000580 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003224c:	911e0000 	add	x0, x0, #0x780
ffffffff40032250:	f9400000 	ldr	x0, [x0]
ffffffff40032254:	f94103e1 	ldr	x1, [sp, #512]
ffffffff40032258:	f9000401 	str	x1, [x0, #8]
    proc->sz = sz;
ffffffff4003225c:	b0000580 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40032260:	911e0000 	add	x0, x0, #0x780
ffffffff40032264:	f9400000 	ldr	x0, [x0]
ffffffff40032268:	f940efe1 	ldr	x1, [sp, #472]
ffffffff4003226c:	f9000001 	str	x1, [x0]
    proc->tf->pc = elf.entry;
ffffffff40032270:	b0000580 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40032274:	911e0000 	add	x0, x0, #0x780
ffffffff40032278:	f9400000 	ldr	x0, [x0]
ffffffff4003227c:	f9401400 	ldr	x0, [x0, #40]
ffffffff40032280:	f940d3e1 	ldr	x1, [sp, #416]
ffffffff40032284:	f9000401 	str	x1, [x0, #8]
    proc->tf->sp = sp;
ffffffff40032288:	b0000580 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003228c:	911e0000 	add	x0, x0, #0x780
ffffffff40032290:	f9400000 	ldr	x0, [x0]
ffffffff40032294:	f9401400 	ldr	x0, [x0, #40]
ffffffff40032298:	f940ebe1 	ldr	x1, [sp, #464]
ffffffff4003229c:	f9000001 	str	x1, [x0]

    switchuvm(proc);
ffffffff400322a0:	b0000580 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400322a4:	911e0000 	add	x0, x0, #0x780
ffffffff400322a8:	f9400000 	ldr	x0, [x0]
ffffffff400322ac:	94001fab 	bl	ffffffff4003a158 <switchuvm>
    freevm(oldpgdir);
ffffffff400322b0:	f940e7e0 	ldr	x0, [sp, #456]
ffffffff400322b4:	940020a4 	bl	ffffffff4003a544 <freevm>
    return 0;
ffffffff400322b8:	52800000 	mov	w0, #0x0                   	// #0
ffffffff400322bc:	14000021 	b	ffffffff40032340 <exec+0x4d4>
        goto bad;
ffffffff400322c0:	d503201f 	nop
ffffffff400322c4:	14000014 	b	ffffffff40032314 <exec+0x4a8>
        goto bad;
ffffffff400322c8:	d503201f 	nop
ffffffff400322cc:	14000012 	b	ffffffff40032314 <exec+0x4a8>
        goto bad;
ffffffff400322d0:	d503201f 	nop
ffffffff400322d4:	14000010 	b	ffffffff40032314 <exec+0x4a8>
            goto bad;
ffffffff400322d8:	d503201f 	nop
ffffffff400322dc:	1400000e 	b	ffffffff40032314 <exec+0x4a8>
            goto bad;
ffffffff400322e0:	d503201f 	nop
ffffffff400322e4:	1400000c 	b	ffffffff40032314 <exec+0x4a8>
            goto bad;
ffffffff400322e8:	d503201f 	nop
ffffffff400322ec:	1400000a 	b	ffffffff40032314 <exec+0x4a8>
            goto bad;
ffffffff400322f0:	d503201f 	nop
ffffffff400322f4:	14000008 	b	ffffffff40032314 <exec+0x4a8>
        goto bad;
ffffffff400322f8:	d503201f 	nop
ffffffff400322fc:	14000006 	b	ffffffff40032314 <exec+0x4a8>
            goto bad;
ffffffff40032300:	d503201f 	nop
ffffffff40032304:	14000004 	b	ffffffff40032314 <exec+0x4a8>
            goto bad;
ffffffff40032308:	d503201f 	nop
ffffffff4003230c:	14000002 	b	ffffffff40032314 <exec+0x4a8>
        goto bad;
ffffffff40032310:	d503201f 	nop

    bad: if (pgdir) {
ffffffff40032314:	f94103e0 	ldr	x0, [sp, #512]
ffffffff40032318:	f100001f 	cmp	x0, #0x0
ffffffff4003231c:	54000060 	b.eq	ffffffff40032328 <exec+0x4bc>  // b.none
        freevm(pgdir);
ffffffff40032320:	f94103e0 	ldr	x0, [sp, #512]
ffffffff40032324:	94002088 	bl	ffffffff4003a544 <freevm>
    }

    if (ip) {
ffffffff40032328:	f94107e0 	ldr	x0, [sp, #520]
ffffffff4003232c:	f100001f 	cmp	x0, #0x0
ffffffff40032330:	54000060 	b.eq	ffffffff4003233c <exec+0x4d0>  // b.none
        iunlockput(ip);
ffffffff40032334:	f94107e0 	ldr	x0, [sp, #520]
ffffffff40032338:	940003b7 	bl	ffffffff40033214 <iunlockput>
    }
    return -1;
ffffffff4003233c:	12800000 	mov	w0, #0xffffffff            	// #-1
}
ffffffff40032340:	a9407bfd 	ldp	x29, x30, [sp]
ffffffff40032344:	a94153f3 	ldp	x19, x20, [sp, #16]
ffffffff40032348:	910843ff 	add	sp, sp, #0x210
ffffffff4003234c:	d65f03c0 	ret

ffffffff40032350 <fileinit>:
    struct spinlock lock;
    struct file file[NFILE];
} ftable;

void fileinit (void)
{
ffffffff40032350:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff40032354:	910003fd 	mov	x29, sp
    initlock(&ftable.lock, "ftable");
ffffffff40032358:	b0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003235c:	91174001 	add	x1, x0, #0x5d0
ffffffff40032360:	f0000440 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40032364:	91346000 	add	x0, x0, #0xd18
ffffffff40032368:	94000e3a 	bl	ffffffff40035c50 <initlock>
}
ffffffff4003236c:	d503201f 	nop
ffffffff40032370:	a8c17bfd 	ldp	x29, x30, [sp], #16
ffffffff40032374:	d65f03c0 	ret

ffffffff40032378 <filealloc>:

// Allocate a file structure.
struct file* filealloc (void)
{
ffffffff40032378:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff4003237c:	910003fd 	mov	x29, sp
    struct file *f;

    acquire(&ftable.lock);
ffffffff40032380:	f0000440 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40032384:	91346000 	add	x0, x0, #0xd18
ffffffff40032388:	94000e3f 	bl	ffffffff40035c84 <acquire>

    for (f = ftable.file; f < ftable.file + NFILE; f++) {
ffffffff4003238c:	f0000440 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40032390:	91356000 	add	x0, x0, #0xd58
ffffffff40032394:	f9000fe0 	str	x0, [sp, #24]
ffffffff40032398:	14000010 	b	ffffffff400323d8 <filealloc+0x60>
        if (f->ref == 0) {
ffffffff4003239c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400323a0:	b9400400 	ldr	w0, [x0, #4]
ffffffff400323a4:	7100001f 	cmp	w0, #0x0
ffffffff400323a8:	54000121 	b.ne	ffffffff400323cc <filealloc+0x54>  // b.any
            f->ref = 1;
ffffffff400323ac:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400323b0:	52800021 	mov	w1, #0x1                   	// #1
ffffffff400323b4:	b9000401 	str	w1, [x0, #4]
            release(&ftable.lock);
ffffffff400323b8:	f0000440 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff400323bc:	91346000 	add	x0, x0, #0xd18
ffffffff400323c0:	94000e3b 	bl	ffffffff40035cac <release>
            return f;
ffffffff400323c4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400323c8:	1400000d 	b	ffffffff400323fc <filealloc+0x84>
    for (f = ftable.file; f < ftable.file + NFILE; f++) {
ffffffff400323cc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400323d0:	9100a000 	add	x0, x0, #0x28
ffffffff400323d4:	f9000fe0 	str	x0, [sp, #24]
ffffffff400323d8:	90000460 	adrp	x0, ffffffff400be000 <ftable+0x2e8>
ffffffff400323dc:	9133e000 	add	x0, x0, #0xcf8
ffffffff400323e0:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff400323e4:	eb00003f 	cmp	x1, x0
ffffffff400323e8:	54fffda3 	b.cc	ffffffff4003239c <filealloc+0x24>  // b.lo, b.ul, b.last
        }
    }

    release(&ftable.lock);
ffffffff400323ec:	f0000440 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff400323f0:	91346000 	add	x0, x0, #0xd18
ffffffff400323f4:	94000e2e 	bl	ffffffff40035cac <release>
    return 0;
ffffffff400323f8:	d2800000 	mov	x0, #0x0                   	// #0
}
ffffffff400323fc:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40032400:	d65f03c0 	ret

ffffffff40032404 <filedup>:

// Increment ref count for file f.
struct file* filedup (struct file *f)
{
ffffffff40032404:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40032408:	910003fd 	mov	x29, sp
ffffffff4003240c:	f9000fe0 	str	x0, [sp, #24]
    acquire(&ftable.lock);
ffffffff40032410:	f0000440 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40032414:	91346000 	add	x0, x0, #0xd18
ffffffff40032418:	94000e1b 	bl	ffffffff40035c84 <acquire>

    if (f->ref < 1) {
ffffffff4003241c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032420:	b9400400 	ldr	w0, [x0, #4]
ffffffff40032424:	7100001f 	cmp	w0, #0x0
ffffffff40032428:	5400008c 	b.gt	ffffffff40032438 <filedup+0x34>
        panic("filedup");
ffffffff4003242c:	b0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40032430:	91176000 	add	x0, x0, #0x5d8
ffffffff40032434:	97fffd25 	bl	ffffffff400318c8 <panic>
    }

    f->ref++;
ffffffff40032438:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003243c:	b9400400 	ldr	w0, [x0, #4]
ffffffff40032440:	11000401 	add	w1, w0, #0x1
ffffffff40032444:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032448:	b9000401 	str	w1, [x0, #4]
    release(&ftable.lock);
ffffffff4003244c:	f0000440 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40032450:	91346000 	add	x0, x0, #0xd18
ffffffff40032454:	94000e16 	bl	ffffffff40035cac <release>
    return f;
ffffffff40032458:	f9400fe0 	ldr	x0, [sp, #24]
}
ffffffff4003245c:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40032460:	d65f03c0 	ret

ffffffff40032464 <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void fileclose (struct file *f)
{
ffffffff40032464:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
ffffffff40032468:	910003fd 	mov	x29, sp
ffffffff4003246c:	f9000fe0 	str	x0, [sp, #24]
    struct file ff;

    acquire(&ftable.lock);
ffffffff40032470:	f0000440 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40032474:	91346000 	add	x0, x0, #0xd18
ffffffff40032478:	94000e03 	bl	ffffffff40035c84 <acquire>

    if (f->ref < 1) {
ffffffff4003247c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032480:	b9400400 	ldr	w0, [x0, #4]
ffffffff40032484:	7100001f 	cmp	w0, #0x0
ffffffff40032488:	5400008c 	b.gt	ffffffff40032498 <fileclose+0x34>
        panic("fileclose");
ffffffff4003248c:	b0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40032490:	91178000 	add	x0, x0, #0x5e0
ffffffff40032494:	97fffd0d 	bl	ffffffff400318c8 <panic>
    }

    if (--f->ref > 0) {
ffffffff40032498:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003249c:	b9400400 	ldr	w0, [x0, #4]
ffffffff400324a0:	51000401 	sub	w1, w0, #0x1
ffffffff400324a4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400324a8:	b9000401 	str	w1, [x0, #4]
ffffffff400324ac:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400324b0:	b9400400 	ldr	w0, [x0, #4]
ffffffff400324b4:	7100001f 	cmp	w0, #0x0
ffffffff400324b8:	540000ad 	b.le	ffffffff400324cc <fileclose+0x68>
        release(&ftable.lock);
ffffffff400324bc:	f0000440 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff400324c0:	91346000 	add	x0, x0, #0xd18
ffffffff400324c4:	94000dfa 	bl	ffffffff40035cac <release>
ffffffff400324c8:	1400001e 	b	ffffffff40032540 <fileclose+0xdc>
        return;
    }

    ff = *f;
ffffffff400324cc:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff400324d0:	9100a3e0 	add	x0, sp, #0x28
ffffffff400324d4:	3dc0003e 	ldr	q30, [x1]
ffffffff400324d8:	3dc0043f 	ldr	q31, [x1, #16]
ffffffff400324dc:	f9401021 	ldr	x1, [x1, #32]
ffffffff400324e0:	3d80001e 	str	q30, [x0]
ffffffff400324e4:	3d80041f 	str	q31, [x0, #16]
ffffffff400324e8:	f9001001 	str	x1, [x0, #32]
    f->ref = 0;
ffffffff400324ec:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400324f0:	b900041f 	str	wzr, [x0, #4]
    f->type = FD_NONE;
ffffffff400324f4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400324f8:	b900001f 	str	wzr, [x0]
    release(&ftable.lock);
ffffffff400324fc:	f0000440 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40032500:	91346000 	add	x0, x0, #0xd18
ffffffff40032504:	94000dea 	bl	ffffffff40035cac <release>

    if (ff.type == FD_PIPE) {
ffffffff40032508:	b9402be0 	ldr	w0, [sp, #40]
ffffffff4003250c:	7100041f 	cmp	w0, #0x1
ffffffff40032510:	540000a1 	b.ne	ffffffff40032524 <fileclose+0xc0>  // b.any
        pipeclose(ff.pipe, ff.writable);
ffffffff40032514:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40032518:	3940c7e1 	ldrb	w1, [sp, #49]
ffffffff4003251c:	9400099e 	bl	ffffffff40034b94 <pipeclose>
ffffffff40032520:	14000008 	b	ffffffff40032540 <fileclose+0xdc>

    } else if (ff.type == FD_INODE) {
ffffffff40032524:	b9402be0 	ldr	w0, [sp, #40]
ffffffff40032528:	7100081f 	cmp	w0, #0x2
ffffffff4003252c:	540000a1 	b.ne	ffffffff40032540 <fileclose+0xdc>  // b.any
        begin_trans();
ffffffff40032530:	9400070f 	bl	ffffffff4003416c <begin_trans>
        iput(ff.ip);
ffffffff40032534:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40032538:	940002fc 	bl	ffffffff40033128 <iput>
        commit_trans();
ffffffff4003253c:	94000726 	bl	ffffffff400341d4 <commit_trans>
    }
}
ffffffff40032540:	a8c57bfd 	ldp	x29, x30, [sp], #80
ffffffff40032544:	d65f03c0 	ret

ffffffff40032548 <filestat>:

// Get metadata about file f.
int filestat (struct file *f, struct stat *st)
{
ffffffff40032548:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff4003254c:	910003fd 	mov	x29, sp
ffffffff40032550:	f9000fe0 	str	x0, [sp, #24]
ffffffff40032554:	f9000be1 	str	x1, [sp, #16]
    if (f->type == FD_INODE) {
ffffffff40032558:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003255c:	b9400000 	ldr	w0, [x0]
ffffffff40032560:	7100081f 	cmp	w0, #0x2
ffffffff40032564:	540001a1 	b.ne	ffffffff40032598 <filestat+0x50>  // b.any
        ilock(f->ip);
ffffffff40032568:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003256c:	f9400c00 	ldr	x0, [x0, #24]
ffffffff40032570:	94000265 	bl	ffffffff40032f04 <ilock>
        stati(f->ip, st);
ffffffff40032574:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032578:	f9400c00 	ldr	x0, [x0, #24]
ffffffff4003257c:	f9400be1 	ldr	x1, [sp, #16]
ffffffff40032580:	940003e7 	bl	ffffffff4003351c <stati>
        iunlock(f->ip);
ffffffff40032584:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032588:	f9400c00 	ldr	x0, [x0, #24]
ffffffff4003258c:	940002c5 	bl	ffffffff400330a0 <iunlock>

        return 0;
ffffffff40032590:	52800000 	mov	w0, #0x0                   	// #0
ffffffff40032594:	14000002 	b	ffffffff4003259c <filestat+0x54>
    }

    return -1;
ffffffff40032598:	12800000 	mov	w0, #0xffffffff            	// #-1
}
ffffffff4003259c:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff400325a0:	d65f03c0 	ret

ffffffff400325a4 <fileread>:

// Read from file f.
int fileread (struct file *f, char *addr, int n)
{
ffffffff400325a4:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff400325a8:	910003fd 	mov	x29, sp
ffffffff400325ac:	f90017e0 	str	x0, [sp, #40]
ffffffff400325b0:	f90013e1 	str	x1, [sp, #32]
ffffffff400325b4:	b9001fe2 	str	w2, [sp, #28]
    int r;

    if (f->readable == 0) {
ffffffff400325b8:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400325bc:	39402000 	ldrb	w0, [x0, #8]
ffffffff400325c0:	7100001f 	cmp	w0, #0x0
ffffffff400325c4:	54000061 	b.ne	ffffffff400325d0 <fileread+0x2c>  // b.any
        return -1;
ffffffff400325c8:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff400325cc:	1400002e 	b	ffffffff40032684 <fileread+0xe0>
    }

    if (f->type == FD_PIPE) {
ffffffff400325d0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400325d4:	b9400000 	ldr	w0, [x0]
ffffffff400325d8:	7100041f 	cmp	w0, #0x1
ffffffff400325dc:	540000e1 	b.ne	ffffffff400325f8 <fileread+0x54>  // b.any
        return piperead(f->pipe, addr, n);
ffffffff400325e0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400325e4:	f9400800 	ldr	x0, [x0, #16]
ffffffff400325e8:	b9401fe2 	ldr	w2, [sp, #28]
ffffffff400325ec:	f94013e1 	ldr	x1, [sp, #32]
ffffffff400325f0:	940009d0 	bl	ffffffff40034d30 <piperead>
ffffffff400325f4:	14000024 	b	ffffffff40032684 <fileread+0xe0>
    }

    if (f->type == FD_INODE) {
ffffffff400325f8:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400325fc:	b9400000 	ldr	w0, [x0]
ffffffff40032600:	7100081f 	cmp	w0, #0x2
ffffffff40032604:	540003a1 	b.ne	ffffffff40032678 <fileread+0xd4>  // b.any
        ilock(f->ip);
ffffffff40032608:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003260c:	f9400c00 	ldr	x0, [x0, #24]
ffffffff40032610:	9400023d 	bl	ffffffff40032f04 <ilock>

        if ((r = readi(f->ip, addr, f->off, n)) > 0) {
ffffffff40032614:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032618:	f9400c04 	ldr	x4, [x0, #24]
ffffffff4003261c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032620:	b9402000 	ldr	w0, [x0, #32]
ffffffff40032624:	b9401fe1 	ldr	w1, [sp, #28]
ffffffff40032628:	2a0103e3 	mov	w3, w1
ffffffff4003262c:	2a0003e2 	mov	w2, w0
ffffffff40032630:	f94013e1 	ldr	x1, [sp, #32]
ffffffff40032634:	aa0403e0 	mov	x0, x4
ffffffff40032638:	940003d4 	bl	ffffffff40033588 <readi>
ffffffff4003263c:	b9003fe0 	str	w0, [sp, #60]
ffffffff40032640:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40032644:	7100001f 	cmp	w0, #0x0
ffffffff40032648:	540000ed 	b.le	ffffffff40032664 <fileread+0xc0>
            f->off += r;
ffffffff4003264c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032650:	b9402001 	ldr	w1, [x0, #32]
ffffffff40032654:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40032658:	0b000021 	add	w1, w1, w0
ffffffff4003265c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032660:	b9002001 	str	w1, [x0, #32]
        }

        iunlock(f->ip);
ffffffff40032664:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032668:	f9400c00 	ldr	x0, [x0, #24]
ffffffff4003266c:	9400028d 	bl	ffffffff400330a0 <iunlock>

        return r;
ffffffff40032670:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40032674:	14000004 	b	ffffffff40032684 <fileread+0xe0>
    }

    panic("fileread");
ffffffff40032678:	b0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003267c:	9117c000 	add	x0, x0, #0x5f0
ffffffff40032680:	97fffc92 	bl	ffffffff400318c8 <panic>
}
ffffffff40032684:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff40032688:	d65f03c0 	ret

ffffffff4003268c <filewrite>:

//PAGEBREAK!
// Write to file f.
int filewrite (struct file *f, char *addr, int n)
{
ffffffff4003268c:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff40032690:	910003fd 	mov	x29, sp
ffffffff40032694:	f90017e0 	str	x0, [sp, #40]
ffffffff40032698:	f90013e1 	str	x1, [sp, #32]
ffffffff4003269c:	b9001fe2 	str	w2, [sp, #28]
    int r;
    int i;
    int max;
    int n1;

    if (f->writable == 0) {
ffffffff400326a0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400326a4:	39402400 	ldrb	w0, [x0, #9]
ffffffff400326a8:	7100001f 	cmp	w0, #0x0
ffffffff400326ac:	54000061 	b.ne	ffffffff400326b8 <filewrite+0x2c>  // b.any
        return -1;
ffffffff400326b0:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff400326b4:	1400005a 	b	ffffffff4003281c <filewrite+0x190>
    }

    if (f->type == FD_PIPE) {
ffffffff400326b8:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400326bc:	b9400000 	ldr	w0, [x0]
ffffffff400326c0:	7100041f 	cmp	w0, #0x1
ffffffff400326c4:	540000e1 	b.ne	ffffffff400326e0 <filewrite+0x54>  // b.any
        return pipewrite(f->pipe, addr, n);
ffffffff400326c8:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400326cc:	f9400800 	ldr	x0, [x0, #16]
ffffffff400326d0:	b9401fe2 	ldr	w2, [sp, #28]
ffffffff400326d4:	f94013e1 	ldr	x1, [sp, #32]
ffffffff400326d8:	94000959 	bl	ffffffff40034c3c <pipewrite>
ffffffff400326dc:	14000050 	b	ffffffff4003281c <filewrite+0x190>
    }

    if (f->type == FD_INODE) {
ffffffff400326e0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400326e4:	b9400000 	ldr	w0, [x0]
ffffffff400326e8:	7100081f 	cmp	w0, #0x2
ffffffff400326ec:	54000921 	b.ne	ffffffff40032810 <filewrite+0x184>  // b.any
        // the maximum log transaction size, including
        // i-node, indirect block, allocation blocks,
        // and 2 blocks of slop for non-aligned writes.
        // this really belongs lower down, since writei()
        // might be writing a device like the console.
        max = ((LOGSIZE - 1 - 1 - 2) / 2) * 512;
ffffffff400326f0:	5280c000 	mov	w0, #0x600                 	// #1536
ffffffff400326f4:	b90037e0 	str	w0, [sp, #52]
        i = 0;
ffffffff400326f8:	b9003fff 	str	wzr, [sp, #60]

        while (i < n) {
ffffffff400326fc:	14000037 	b	ffffffff400327d8 <filewrite+0x14c>
            n1 = n - i;
ffffffff40032700:	b9401fe1 	ldr	w1, [sp, #28]
ffffffff40032704:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40032708:	4b000020 	sub	w0, w1, w0
ffffffff4003270c:	b9003be0 	str	w0, [sp, #56]

            if (n1 > max) {
ffffffff40032710:	b9403be1 	ldr	w1, [sp, #56]
ffffffff40032714:	b94037e0 	ldr	w0, [sp, #52]
ffffffff40032718:	6b00003f 	cmp	w1, w0
ffffffff4003271c:	5400006d 	b.le	ffffffff40032728 <filewrite+0x9c>
                n1 = max;
ffffffff40032720:	b94037e0 	ldr	w0, [sp, #52]
ffffffff40032724:	b9003be0 	str	w0, [sp, #56]
            }

            begin_trans();
ffffffff40032728:	94000691 	bl	ffffffff4003416c <begin_trans>
            ilock(f->ip);
ffffffff4003272c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032730:	f9400c00 	ldr	x0, [x0, #24]
ffffffff40032734:	940001f4 	bl	ffffffff40032f04 <ilock>

            if ((r = writei(f->ip, addr + i, f->off, n1)) > 0) {
ffffffff40032738:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003273c:	f9400c04 	ldr	x4, [x0, #24]
ffffffff40032740:	b9803fe0 	ldrsw	x0, [sp, #60]
ffffffff40032744:	f94013e1 	ldr	x1, [sp, #32]
ffffffff40032748:	8b000021 	add	x1, x1, x0
ffffffff4003274c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032750:	b9402000 	ldr	w0, [x0, #32]
ffffffff40032754:	b9403be2 	ldr	w2, [sp, #56]
ffffffff40032758:	2a0203e3 	mov	w3, w2
ffffffff4003275c:	2a0003e2 	mov	w2, w0
ffffffff40032760:	aa0403e0 	mov	x0, x4
ffffffff40032764:	94000407 	bl	ffffffff40033780 <writei>
ffffffff40032768:	b90033e0 	str	w0, [sp, #48]
ffffffff4003276c:	b94033e0 	ldr	w0, [sp, #48]
ffffffff40032770:	7100001f 	cmp	w0, #0x0
ffffffff40032774:	540000ed 	b.le	ffffffff40032790 <filewrite+0x104>
                f->off += r;
ffffffff40032778:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003277c:	b9402001 	ldr	w1, [x0, #32]
ffffffff40032780:	b94033e0 	ldr	w0, [sp, #48]
ffffffff40032784:	0b000021 	add	w1, w1, w0
ffffffff40032788:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003278c:	b9002001 	str	w1, [x0, #32]
            }

            iunlock(f->ip);
ffffffff40032790:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032794:	f9400c00 	ldr	x0, [x0, #24]
ffffffff40032798:	94000242 	bl	ffffffff400330a0 <iunlock>
            commit_trans();
ffffffff4003279c:	9400068e 	bl	ffffffff400341d4 <commit_trans>

            if (r < 0) {
ffffffff400327a0:	b94033e0 	ldr	w0, [sp, #48]
ffffffff400327a4:	7100001f 	cmp	w0, #0x0
ffffffff400327a8:	5400022b 	b.lt	ffffffff400327ec <filewrite+0x160>  // b.tstop
                break;
            }

            if (r != n1) {
ffffffff400327ac:	b94033e1 	ldr	w1, [sp, #48]
ffffffff400327b0:	b9403be0 	ldr	w0, [sp, #56]
ffffffff400327b4:	6b00003f 	cmp	w1, w0
ffffffff400327b8:	54000080 	b.eq	ffffffff400327c8 <filewrite+0x13c>  // b.none
                panic("short filewrite");
ffffffff400327bc:	b0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400327c0:	91180000 	add	x0, x0, #0x600
ffffffff400327c4:	97fffc41 	bl	ffffffff400318c8 <panic>
            }

            i += r;
ffffffff400327c8:	b9403fe1 	ldr	w1, [sp, #60]
ffffffff400327cc:	b94033e0 	ldr	w0, [sp, #48]
ffffffff400327d0:	0b000020 	add	w0, w1, w0
ffffffff400327d4:	b9003fe0 	str	w0, [sp, #60]
        while (i < n) {
ffffffff400327d8:	b9403fe1 	ldr	w1, [sp, #60]
ffffffff400327dc:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff400327e0:	6b00003f 	cmp	w1, w0
ffffffff400327e4:	54fff8eb 	b.lt	ffffffff40032700 <filewrite+0x74>  // b.tstop
ffffffff400327e8:	14000002 	b	ffffffff400327f0 <filewrite+0x164>
                break;
ffffffff400327ec:	d503201f 	nop
        }

        return i == n ? n : -1;
ffffffff400327f0:	b9403fe1 	ldr	w1, [sp, #60]
ffffffff400327f4:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff400327f8:	6b00003f 	cmp	w1, w0
ffffffff400327fc:	54000061 	b.ne	ffffffff40032808 <filewrite+0x17c>  // b.any
ffffffff40032800:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40032804:	14000006 	b	ffffffff4003281c <filewrite+0x190>
ffffffff40032808:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff4003280c:	14000004 	b	ffffffff4003281c <filewrite+0x190>
    }

    panic("filewrite");
ffffffff40032810:	b0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40032814:	91184000 	add	x0, x0, #0x610
ffffffff40032818:	97fffc2c 	bl	ffffffff400318c8 <panic>
}
ffffffff4003281c:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff40032820:	d65f03c0 	ret

ffffffff40032824 <readsb>:
#define min(a, b) ((a) < (b) ? (a) : (b))
static void itrunc (struct inode*);

// Read the super block.
void readsb (int dev, struct superblock *sb)
{
ffffffff40032824:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40032828:	910003fd 	mov	x29, sp
ffffffff4003282c:	b9001fe0 	str	w0, [sp, #28]
ffffffff40032830:	f9000be1 	str	x1, [sp, #16]
    struct buf *bp;

    bp = bread(dev, 1);
ffffffff40032834:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40032838:	52800021 	mov	w1, #0x1                   	// #1
ffffffff4003283c:	97fff85e 	bl	ffffffff400309b4 <bread>
ffffffff40032840:	f90017e0 	str	x0, [sp, #40]
    memmove(sb, bp->data, sizeof(*sb));
ffffffff40032844:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032848:	9100a000 	add	x0, x0, #0x28
ffffffff4003284c:	52800202 	mov	w2, #0x10                  	// #16
ffffffff40032850:	aa0003e1 	mov	x1, x0
ffffffff40032854:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40032858:	97fff654 	bl	ffffffff400301a8 <memmove>
    brelse(bp);
ffffffff4003285c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032860:	97fff87c 	bl	ffffffff40030a50 <brelse>
}
ffffffff40032864:	d503201f 	nop
ffffffff40032868:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff4003286c:	d65f03c0 	ret

ffffffff40032870 <bzero>:

// Zero a block.
static void bzero (int dev, int bno)
{
ffffffff40032870:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40032874:	910003fd 	mov	x29, sp
ffffffff40032878:	b9001fe0 	str	w0, [sp, #28]
ffffffff4003287c:	b9001be1 	str	w1, [sp, #24]
    struct buf *bp;

    bp = bread(dev, bno);
ffffffff40032880:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40032884:	b9401be1 	ldr	w1, [sp, #24]
ffffffff40032888:	97fff84b 	bl	ffffffff400309b4 <bread>
ffffffff4003288c:	f90017e0 	str	x0, [sp, #40]
    memset(bp->data, 0, BSIZE);
ffffffff40032890:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032894:	9100a000 	add	x0, x0, #0x28
ffffffff40032898:	52804002 	mov	w2, #0x200                 	// #512
ffffffff4003289c:	52800001 	mov	w1, #0x0                   	// #0
ffffffff400328a0:	97fff5d8 	bl	ffffffff40030000 <memset>
    log_write(bp);
ffffffff400328a4:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400328a8:	94000667 	bl	ffffffff40034244 <log_write>
    brelse(bp);
ffffffff400328ac:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400328b0:	97fff868 	bl	ffffffff40030a50 <brelse>
}
ffffffff400328b4:	d503201f 	nop
ffffffff400328b8:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff400328bc:	d65f03c0 	ret

ffffffff400328c0 <balloc>:

// Blocks.

// Allocate a zeroed disk block.
static uint balloc (uint dev)
{
ffffffff400328c0:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
ffffffff400328c4:	910003fd 	mov	x29, sp
ffffffff400328c8:	b9001fe0 	str	w0, [sp, #28]
    int b, bi, m;
    struct buf *bp;
    struct superblock sb;

    bp = 0;
ffffffff400328cc:	f90023ff 	str	xzr, [sp, #64]
    readsb(dev, &sb);
ffffffff400328d0:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff400328d4:	9100a3e1 	add	x1, sp, #0x28
ffffffff400328d8:	97ffffd3 	bl	ffffffff40032824 <readsb>

    for (b = 0; b < sb.size; b += BPB) {
ffffffff400328dc:	b9004fff 	str	wzr, [sp, #76]
ffffffff400328e0:	1400005a 	b	ffffffff40032a48 <balloc+0x188>
        bp = bread(dev, BBLOCK(b, sb.ninodes));
ffffffff400328e4:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff400328e8:	113ffc01 	add	w1, w0, #0xfff
ffffffff400328ec:	7100001f 	cmp	w0, #0x0
ffffffff400328f0:	1a80b020 	csel	w0, w1, w0, lt	// lt = tstop
ffffffff400328f4:	130c7c00 	asr	w0, w0, #12
ffffffff400328f8:	2a0003e1 	mov	w1, w0
ffffffff400328fc:	b94033e0 	ldr	w0, [sp, #48]
ffffffff40032900:	53037c00 	lsr	w0, w0, #3
ffffffff40032904:	0b000020 	add	w0, w1, w0
ffffffff40032908:	11000c00 	add	w0, w0, #0x3
ffffffff4003290c:	2a0003e1 	mov	w1, w0
ffffffff40032910:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40032914:	97fff828 	bl	ffffffff400309b4 <bread>
ffffffff40032918:	f90023e0 	str	x0, [sp, #64]

        for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
ffffffff4003291c:	b9004bff 	str	wzr, [sp, #72]
ffffffff40032920:	1400003b 	b	ffffffff40032a0c <balloc+0x14c>
            m = 1 << (bi % 8);
ffffffff40032924:	b9404be0 	ldr	w0, [sp, #72]
ffffffff40032928:	12000800 	and	w0, w0, #0x7
ffffffff4003292c:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40032930:	1ac02020 	lsl	w0, w1, w0
ffffffff40032934:	b9003fe0 	str	w0, [sp, #60]

            if ((bp->data[bi / 8] & m) == 0) {  // Is block free?
ffffffff40032938:	b9404be0 	ldr	w0, [sp, #72]
ffffffff4003293c:	11001c01 	add	w1, w0, #0x7
ffffffff40032940:	7100001f 	cmp	w0, #0x0
ffffffff40032944:	1a80b020 	csel	w0, w1, w0, lt	// lt = tstop
ffffffff40032948:	13037c00 	asr	w0, w0, #3
ffffffff4003294c:	f94023e1 	ldr	x1, [sp, #64]
ffffffff40032950:	93407c00 	sxtw	x0, w0
ffffffff40032954:	8b000020 	add	x0, x1, x0
ffffffff40032958:	3940a000 	ldrb	w0, [x0, #40]
ffffffff4003295c:	2a0003e1 	mov	w1, w0
ffffffff40032960:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40032964:	0a000020 	and	w0, w1, w0
ffffffff40032968:	7100001f 	cmp	w0, #0x0
ffffffff4003296c:	540004a1 	b.ne	ffffffff40032a00 <balloc+0x140>  // b.any
                bp->data[bi / 8] |= m;  // Mark block in use.
ffffffff40032970:	b9404be0 	ldr	w0, [sp, #72]
ffffffff40032974:	11001c01 	add	w1, w0, #0x7
ffffffff40032978:	7100001f 	cmp	w0, #0x0
ffffffff4003297c:	1a80b020 	csel	w0, w1, w0, lt	// lt = tstop
ffffffff40032980:	13037c00 	asr	w0, w0, #3
ffffffff40032984:	2a0003e3 	mov	w3, w0
ffffffff40032988:	f94023e1 	ldr	x1, [sp, #64]
ffffffff4003298c:	93407c60 	sxtw	x0, w3
ffffffff40032990:	8b000020 	add	x0, x1, x0
ffffffff40032994:	3940a000 	ldrb	w0, [x0, #40]
ffffffff40032998:	13001c01 	sxtb	w1, w0
ffffffff4003299c:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff400329a0:	13001c00 	sxtb	w0, w0
ffffffff400329a4:	2a000020 	orr	w0, w1, w0
ffffffff400329a8:	13001c00 	sxtb	w0, w0
ffffffff400329ac:	12001c02 	and	w2, w0, #0xff
ffffffff400329b0:	f94023e1 	ldr	x1, [sp, #64]
ffffffff400329b4:	93407c60 	sxtw	x0, w3
ffffffff400329b8:	8b000020 	add	x0, x1, x0
ffffffff400329bc:	2a0203e1 	mov	w1, w2
ffffffff400329c0:	3900a001 	strb	w1, [x0, #40]
                log_write(bp);
ffffffff400329c4:	f94023e0 	ldr	x0, [sp, #64]
ffffffff400329c8:	9400061f 	bl	ffffffff40034244 <log_write>
                brelse(bp);
ffffffff400329cc:	f94023e0 	ldr	x0, [sp, #64]
ffffffff400329d0:	97fff820 	bl	ffffffff40030a50 <brelse>
                bzero(dev, b + bi);
ffffffff400329d4:	b9401fe2 	ldr	w2, [sp, #28]
ffffffff400329d8:	b9404fe1 	ldr	w1, [sp, #76]
ffffffff400329dc:	b9404be0 	ldr	w0, [sp, #72]
ffffffff400329e0:	0b000020 	add	w0, w1, w0
ffffffff400329e4:	2a0003e1 	mov	w1, w0
ffffffff400329e8:	2a0203e0 	mov	w0, w2
ffffffff400329ec:	97ffffa1 	bl	ffffffff40032870 <bzero>
                return b + bi;
ffffffff400329f0:	b9404fe1 	ldr	w1, [sp, #76]
ffffffff400329f4:	b9404be0 	ldr	w0, [sp, #72]
ffffffff400329f8:	0b000020 	add	w0, w1, w0
ffffffff400329fc:	1400001a 	b	ffffffff40032a64 <balloc+0x1a4>
        for (bi = 0; bi < BPB && b + bi < sb.size; bi++) {
ffffffff40032a00:	b9404be0 	ldr	w0, [sp, #72]
ffffffff40032a04:	11000400 	add	w0, w0, #0x1
ffffffff40032a08:	b9004be0 	str	w0, [sp, #72]
ffffffff40032a0c:	b9404be0 	ldr	w0, [sp, #72]
ffffffff40032a10:	713ffc1f 	cmp	w0, #0xfff
ffffffff40032a14:	5400010c 	b.gt	ffffffff40032a34 <balloc+0x174>
ffffffff40032a18:	b9404fe1 	ldr	w1, [sp, #76]
ffffffff40032a1c:	b9404be0 	ldr	w0, [sp, #72]
ffffffff40032a20:	0b000020 	add	w0, w1, w0
ffffffff40032a24:	2a0003e1 	mov	w1, w0
ffffffff40032a28:	b9402be0 	ldr	w0, [sp, #40]
ffffffff40032a2c:	6b00003f 	cmp	w1, w0
ffffffff40032a30:	54fff7a3 	b.cc	ffffffff40032924 <balloc+0x64>  // b.lo, b.ul, b.last
            }
        }

        brelse(bp);
ffffffff40032a34:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40032a38:	97fff806 	bl	ffffffff40030a50 <brelse>
    for (b = 0; b < sb.size; b += BPB) {
ffffffff40032a3c:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff40032a40:	11400400 	add	w0, w0, #0x1, lsl #12
ffffffff40032a44:	b9004fe0 	str	w0, [sp, #76]
ffffffff40032a48:	b9402be1 	ldr	w1, [sp, #40]
ffffffff40032a4c:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff40032a50:	6b00003f 	cmp	w1, w0
ffffffff40032a54:	54fff488 	b.hi	ffffffff400328e4 <balloc+0x24>  // b.pmore
    }

    panic("balloc: out of blocks");
ffffffff40032a58:	b0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40032a5c:	91188000 	add	x0, x0, #0x620
ffffffff40032a60:	97fffb9a 	bl	ffffffff400318c8 <panic>
}
ffffffff40032a64:	a8c57bfd 	ldp	x29, x30, [sp], #80
ffffffff40032a68:	d65f03c0 	ret

ffffffff40032a6c <bfree>:

// Free a disk block.
static void bfree (int dev, uint b)
{
ffffffff40032a6c:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff40032a70:	910003fd 	mov	x29, sp
ffffffff40032a74:	b9001fe0 	str	w0, [sp, #28]
ffffffff40032a78:	b9001be1 	str	w1, [sp, #24]
    struct buf *bp;
    struct superblock sb;
    int bi, m;

    readsb(dev, &sb);
ffffffff40032a7c:	910083e0 	add	x0, sp, #0x20
ffffffff40032a80:	aa0003e1 	mov	x1, x0
ffffffff40032a84:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40032a88:	97ffff67 	bl	ffffffff40032824 <readsb>
    bp = bread(dev, BBLOCK(b, sb.ninodes));
ffffffff40032a8c:	b9401fe2 	ldr	w2, [sp, #28]
ffffffff40032a90:	b9401be0 	ldr	w0, [sp, #24]
ffffffff40032a94:	530c7c01 	lsr	w1, w0, #12
ffffffff40032a98:	b9402be0 	ldr	w0, [sp, #40]
ffffffff40032a9c:	53037c00 	lsr	w0, w0, #3
ffffffff40032aa0:	0b000020 	add	w0, w1, w0
ffffffff40032aa4:	11000c00 	add	w0, w0, #0x3
ffffffff40032aa8:	2a0003e1 	mov	w1, w0
ffffffff40032aac:	2a0203e0 	mov	w0, w2
ffffffff40032ab0:	97fff7c1 	bl	ffffffff400309b4 <bread>
ffffffff40032ab4:	f9001fe0 	str	x0, [sp, #56]
    bi = b % BPB;
ffffffff40032ab8:	b9401be0 	ldr	w0, [sp, #24]
ffffffff40032abc:	12002c00 	and	w0, w0, #0xfff
ffffffff40032ac0:	b90037e0 	str	w0, [sp, #52]
    m = 1 << (bi % 8);
ffffffff40032ac4:	b94037e0 	ldr	w0, [sp, #52]
ffffffff40032ac8:	12000800 	and	w0, w0, #0x7
ffffffff40032acc:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40032ad0:	1ac02020 	lsl	w0, w1, w0
ffffffff40032ad4:	b90033e0 	str	w0, [sp, #48]

    if ((bp->data[bi / 8] & m) == 0) {
ffffffff40032ad8:	b94037e0 	ldr	w0, [sp, #52]
ffffffff40032adc:	11001c01 	add	w1, w0, #0x7
ffffffff40032ae0:	7100001f 	cmp	w0, #0x0
ffffffff40032ae4:	1a80b020 	csel	w0, w1, w0, lt	// lt = tstop
ffffffff40032ae8:	13037c00 	asr	w0, w0, #3
ffffffff40032aec:	f9401fe1 	ldr	x1, [sp, #56]
ffffffff40032af0:	93407c00 	sxtw	x0, w0
ffffffff40032af4:	8b000020 	add	x0, x1, x0
ffffffff40032af8:	3940a000 	ldrb	w0, [x0, #40]
ffffffff40032afc:	2a0003e1 	mov	w1, w0
ffffffff40032b00:	b94033e0 	ldr	w0, [sp, #48]
ffffffff40032b04:	0a000020 	and	w0, w1, w0
ffffffff40032b08:	7100001f 	cmp	w0, #0x0
ffffffff40032b0c:	54000081 	b.ne	ffffffff40032b1c <bfree+0xb0>  // b.any
        panic("freeing free block");
ffffffff40032b10:	b0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40032b14:	9118e000 	add	x0, x0, #0x638
ffffffff40032b18:	97fffb6c 	bl	ffffffff400318c8 <panic>
    }

    bp->data[bi / 8] &= ~m;
ffffffff40032b1c:	b94037e0 	ldr	w0, [sp, #52]
ffffffff40032b20:	11001c01 	add	w1, w0, #0x7
ffffffff40032b24:	7100001f 	cmp	w0, #0x0
ffffffff40032b28:	1a80b020 	csel	w0, w1, w0, lt	// lt = tstop
ffffffff40032b2c:	13037c00 	asr	w0, w0, #3
ffffffff40032b30:	2a0003e3 	mov	w3, w0
ffffffff40032b34:	f9401fe1 	ldr	x1, [sp, #56]
ffffffff40032b38:	93407c60 	sxtw	x0, w3
ffffffff40032b3c:	8b000020 	add	x0, x1, x0
ffffffff40032b40:	3940a000 	ldrb	w0, [x0, #40]
ffffffff40032b44:	13001c01 	sxtb	w1, w0
ffffffff40032b48:	b94033e0 	ldr	w0, [sp, #48]
ffffffff40032b4c:	13001c00 	sxtb	w0, w0
ffffffff40032b50:	2a2003e0 	mvn	w0, w0
ffffffff40032b54:	13001c00 	sxtb	w0, w0
ffffffff40032b58:	0a000020 	and	w0, w1, w0
ffffffff40032b5c:	13001c00 	sxtb	w0, w0
ffffffff40032b60:	12001c02 	and	w2, w0, #0xff
ffffffff40032b64:	f9401fe1 	ldr	x1, [sp, #56]
ffffffff40032b68:	93407c60 	sxtw	x0, w3
ffffffff40032b6c:	8b000020 	add	x0, x1, x0
ffffffff40032b70:	2a0203e1 	mov	w1, w2
ffffffff40032b74:	3900a001 	strb	w1, [x0, #40]
    log_write(bp);
ffffffff40032b78:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40032b7c:	940005b2 	bl	ffffffff40034244 <log_write>
    brelse(bp);
ffffffff40032b80:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40032b84:	97fff7b3 	bl	ffffffff40030a50 <brelse>
}
ffffffff40032b88:	d503201f 	nop
ffffffff40032b8c:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff40032b90:	d65f03c0 	ret

ffffffff40032b94 <iinit>:
    struct spinlock lock;
    struct inode inode[NINODE];
} icache;

void iinit (void)
{
ffffffff40032b94:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff40032b98:	910003fd 	mov	x29, sp
    initlock(&icache.lock, "icache");
ffffffff40032b9c:	b0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40032ba0:	91194001 	add	x1, x0, #0x650
ffffffff40032ba4:	90000460 	adrp	x0, ffffffff400be000 <ftable+0x2e8>
ffffffff40032ba8:	9133e000 	add	x0, x0, #0xcf8
ffffffff40032bac:	94000c29 	bl	ffffffff40035c50 <initlock>
}
ffffffff40032bb0:	d503201f 	nop
ffffffff40032bb4:	a8c17bfd 	ldp	x29, x30, [sp], #16
ffffffff40032bb8:	d65f03c0 	ret

ffffffff40032bbc <ialloc>:

//PAGEBREAK!
// Allocate a new inode with the given type on device dev.
// A free inode has a type of zero.
struct inode* ialloc (uint dev, short type)
{
ffffffff40032bbc:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
ffffffff40032bc0:	910003fd 	mov	x29, sp
ffffffff40032bc4:	b9001fe0 	str	w0, [sp, #28]
ffffffff40032bc8:	790037e1 	strh	w1, [sp, #26]
    int inum;
    struct buf *bp;
    struct dinode *dip;
    struct superblock sb;

    readsb(dev, &sb);
ffffffff40032bcc:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40032bd0:	9100a3e1 	add	x1, sp, #0x28
ffffffff40032bd4:	97ffff14 	bl	ffffffff40032824 <readsb>

    for (inum = 1; inum < sb.ninodes; inum++) {
ffffffff40032bd8:	52800020 	mov	w0, #0x1                   	// #1
ffffffff40032bdc:	b9004fe0 	str	w0, [sp, #76]
ffffffff40032be0:	14000028 	b	ffffffff40032c80 <ialloc+0xc4>
        bp = bread(dev, IBLOCK(inum));
ffffffff40032be4:	b9804fe0 	ldrsw	x0, [sp, #76]
ffffffff40032be8:	d343fc00 	lsr	x0, x0, #3
ffffffff40032bec:	11000800 	add	w0, w0, #0x2
ffffffff40032bf0:	2a0003e1 	mov	w1, w0
ffffffff40032bf4:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40032bf8:	97fff76f 	bl	ffffffff400309b4 <bread>
ffffffff40032bfc:	f90023e0 	str	x0, [sp, #64]
        dip = (struct dinode*) bp->data + inum % IPB;
ffffffff40032c00:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40032c04:	9100a001 	add	x1, x0, #0x28
ffffffff40032c08:	b9804fe0 	ldrsw	x0, [sp, #76]
ffffffff40032c0c:	92400800 	and	x0, x0, #0x7
ffffffff40032c10:	d37ae400 	lsl	x0, x0, #6
ffffffff40032c14:	8b000020 	add	x0, x1, x0
ffffffff40032c18:	f9001fe0 	str	x0, [sp, #56]

        if (dip->type == 0) {  // a free inode
ffffffff40032c1c:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40032c20:	79c00000 	ldrsh	w0, [x0]
ffffffff40032c24:	7100001f 	cmp	w0, #0x0
ffffffff40032c28:	54000221 	b.ne	ffffffff40032c6c <ialloc+0xb0>  // b.any
            memset(dip, 0, sizeof(*dip));
ffffffff40032c2c:	52800802 	mov	w2, #0x40                  	// #64
ffffffff40032c30:	52800001 	mov	w1, #0x0                   	// #0
ffffffff40032c34:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40032c38:	97fff4f2 	bl	ffffffff40030000 <memset>
            dip->type = type;
ffffffff40032c3c:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40032c40:	794037e1 	ldrh	w1, [sp, #26]
ffffffff40032c44:	79000001 	strh	w1, [x0]
            log_write(bp);   // mark it allocated on the disk
ffffffff40032c48:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40032c4c:	9400057e 	bl	ffffffff40034244 <log_write>
            brelse(bp);
ffffffff40032c50:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40032c54:	97fff77f 	bl	ffffffff40030a50 <brelse>
            return iget(dev, inum);
ffffffff40032c58:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff40032c5c:	2a0003e1 	mov	w1, w0
ffffffff40032c60:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40032c64:	94000049 	bl	ffffffff40032d88 <iget>
ffffffff40032c68:	1400000d 	b	ffffffff40032c9c <ialloc+0xe0>
        }

        brelse(bp);
ffffffff40032c6c:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40032c70:	97fff778 	bl	ffffffff40030a50 <brelse>
    for (inum = 1; inum < sb.ninodes; inum++) {
ffffffff40032c74:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff40032c78:	11000400 	add	w0, w0, #0x1
ffffffff40032c7c:	b9004fe0 	str	w0, [sp, #76]
ffffffff40032c80:	b94033e1 	ldr	w1, [sp, #48]
ffffffff40032c84:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff40032c88:	6b00003f 	cmp	w1, w0
ffffffff40032c8c:	54fffac8 	b.hi	ffffffff40032be4 <ialloc+0x28>  // b.pmore
    }

    panic("ialloc: no inodes");
ffffffff40032c90:	b0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40032c94:	91196000 	add	x0, x0, #0x658
ffffffff40032c98:	97fffb0c 	bl	ffffffff400318c8 <panic>
}
ffffffff40032c9c:	a8c57bfd 	ldp	x29, x30, [sp], #80
ffffffff40032ca0:	d65f03c0 	ret

ffffffff40032ca4 <iupdate>:

// Copy a modified in-memory inode to disk.
void iupdate (struct inode *ip)
{
ffffffff40032ca4:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40032ca8:	910003fd 	mov	x29, sp
ffffffff40032cac:	f9000fe0 	str	x0, [sp, #24]
    struct buf *bp;
    struct dinode *dip;

    bp = bread(ip->dev, IBLOCK(ip->inum));
ffffffff40032cb0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032cb4:	b9400002 	ldr	w2, [x0]
ffffffff40032cb8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032cbc:	b9400400 	ldr	w0, [x0, #4]
ffffffff40032cc0:	53037c00 	lsr	w0, w0, #3
ffffffff40032cc4:	11000800 	add	w0, w0, #0x2
ffffffff40032cc8:	2a0003e1 	mov	w1, w0
ffffffff40032ccc:	2a0203e0 	mov	w0, w2
ffffffff40032cd0:	97fff739 	bl	ffffffff400309b4 <bread>
ffffffff40032cd4:	f90017e0 	str	x0, [sp, #40]

    dip = (struct dinode*) bp->data + ip->inum % IPB;
ffffffff40032cd8:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032cdc:	9100a001 	add	x1, x0, #0x28
ffffffff40032ce0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032ce4:	b9400400 	ldr	w0, [x0, #4]
ffffffff40032ce8:	2a0003e0 	mov	w0, w0
ffffffff40032cec:	92400800 	and	x0, x0, #0x7
ffffffff40032cf0:	d37ae400 	lsl	x0, x0, #6
ffffffff40032cf4:	8b000020 	add	x0, x1, x0
ffffffff40032cf8:	f90013e0 	str	x0, [sp, #32]
    dip->type = ip->type;
ffffffff40032cfc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032d00:	79c02001 	ldrsh	w1, [x0, #16]
ffffffff40032d04:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40032d08:	79000001 	strh	w1, [x0]
    dip->major = ip->major;
ffffffff40032d0c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032d10:	79c02401 	ldrsh	w1, [x0, #18]
ffffffff40032d14:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40032d18:	79000401 	strh	w1, [x0, #2]
    dip->minor = ip->minor;
ffffffff40032d1c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032d20:	79c02801 	ldrsh	w1, [x0, #20]
ffffffff40032d24:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40032d28:	79000801 	strh	w1, [x0, #4]
    dip->nlink = ip->nlink;
ffffffff40032d2c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032d30:	79c02c01 	ldrsh	w1, [x0, #22]
ffffffff40032d34:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40032d38:	79000c01 	strh	w1, [x0, #6]
    dip->size = ip->size;
ffffffff40032d3c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032d40:	b9401801 	ldr	w1, [x0, #24]
ffffffff40032d44:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40032d48:	b9000801 	str	w1, [x0, #8]

    memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
ffffffff40032d4c:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40032d50:	91003003 	add	x3, x0, #0xc
ffffffff40032d54:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032d58:	91007000 	add	x0, x0, #0x1c
ffffffff40032d5c:	52800682 	mov	w2, #0x34                  	// #52
ffffffff40032d60:	aa0003e1 	mov	x1, x0
ffffffff40032d64:	aa0303e0 	mov	x0, x3
ffffffff40032d68:	97fff510 	bl	ffffffff400301a8 <memmove>
    log_write(bp);
ffffffff40032d6c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032d70:	94000535 	bl	ffffffff40034244 <log_write>
    brelse(bp);
ffffffff40032d74:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032d78:	97fff736 	bl	ffffffff40030a50 <brelse>
}
ffffffff40032d7c:	d503201f 	nop
ffffffff40032d80:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff40032d84:	d65f03c0 	ret

ffffffff40032d88 <iget>:

// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode* iget (uint dev, uint inum)
{
ffffffff40032d88:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40032d8c:	910003fd 	mov	x29, sp
ffffffff40032d90:	b9001fe0 	str	w0, [sp, #28]
ffffffff40032d94:	b9001be1 	str	w1, [sp, #24]
    struct inode *ip, *empty;

    acquire(&icache.lock);
ffffffff40032d98:	90000460 	adrp	x0, ffffffff400be000 <ftable+0x2e8>
ffffffff40032d9c:	9133e000 	add	x0, x0, #0xcf8
ffffffff40032da0:	94000bb9 	bl	ffffffff40035c84 <acquire>

    // Is the inode already cached?
    empty = 0;
ffffffff40032da4:	f90013ff 	str	xzr, [sp, #32]

    for (ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++) {
ffffffff40032da8:	90000460 	adrp	x0, ffffffff400be000 <ftable+0x2e8>
ffffffff40032dac:	9134e000 	add	x0, x0, #0xd38
ffffffff40032db0:	f90017e0 	str	x0, [sp, #40]
ffffffff40032db4:	14000025 	b	ffffffff40032e48 <iget+0xc0>
        if (ip->ref > 0 && ip->dev == dev && ip->inum == inum) {
ffffffff40032db8:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032dbc:	b9400800 	ldr	w0, [x0, #8]
ffffffff40032dc0:	7100001f 	cmp	w0, #0x0
ffffffff40032dc4:	540002ad 	b.le	ffffffff40032e18 <iget+0x90>
ffffffff40032dc8:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032dcc:	b9400000 	ldr	w0, [x0]
ffffffff40032dd0:	b9401fe1 	ldr	w1, [sp, #28]
ffffffff40032dd4:	6b00003f 	cmp	w1, w0
ffffffff40032dd8:	54000201 	b.ne	ffffffff40032e18 <iget+0x90>  // b.any
ffffffff40032ddc:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032de0:	b9400400 	ldr	w0, [x0, #4]
ffffffff40032de4:	b9401be1 	ldr	w1, [sp, #24]
ffffffff40032de8:	6b00003f 	cmp	w1, w0
ffffffff40032dec:	54000161 	b.ne	ffffffff40032e18 <iget+0x90>  // b.any
            ip->ref++;
ffffffff40032df0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032df4:	b9400800 	ldr	w0, [x0, #8]
ffffffff40032df8:	11000401 	add	w1, w0, #0x1
ffffffff40032dfc:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032e00:	b9000801 	str	w1, [x0, #8]
            release(&icache.lock);
ffffffff40032e04:	90000460 	adrp	x0, ffffffff400be000 <ftable+0x2e8>
ffffffff40032e08:	9133e000 	add	x0, x0, #0xcf8
ffffffff40032e0c:	94000ba8 	bl	ffffffff40035cac <release>
            return ip;
ffffffff40032e10:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032e14:	14000029 	b	ffffffff40032eb8 <iget+0x130>
        }

        if (empty == 0 && ip->ref == 0) {   // Remember empty slot.
ffffffff40032e18:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40032e1c:	f100001f 	cmp	x0, #0x0
ffffffff40032e20:	540000e1 	b.ne	ffffffff40032e3c <iget+0xb4>  // b.any
ffffffff40032e24:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032e28:	b9400800 	ldr	w0, [x0, #8]
ffffffff40032e2c:	7100001f 	cmp	w0, #0x0
ffffffff40032e30:	54000061 	b.ne	ffffffff40032e3c <iget+0xb4>  // b.any
            empty = ip;
ffffffff40032e34:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032e38:	f90013e0 	str	x0, [sp, #32]
    for (ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++) {
ffffffff40032e3c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032e40:	91014000 	add	x0, x0, #0x50
ffffffff40032e44:	f90017e0 	str	x0, [sp, #40]
ffffffff40032e48:	f94017e1 	ldr	x1, [sp, #40]
ffffffff40032e4c:	b0000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40032e50:	91336000 	add	x0, x0, #0xcd8
ffffffff40032e54:	eb00003f 	cmp	x1, x0
ffffffff40032e58:	54fffb03 	b.cc	ffffffff40032db8 <iget+0x30>  // b.lo, b.ul, b.last
        }
    }

    // Recycle an inode cache entry.
    if (empty == 0) {
ffffffff40032e5c:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40032e60:	f100001f 	cmp	x0, #0x0
ffffffff40032e64:	54000081 	b.ne	ffffffff40032e74 <iget+0xec>  // b.any
        panic("iget: no inodes");
ffffffff40032e68:	b0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40032e6c:	9119c000 	add	x0, x0, #0x670
ffffffff40032e70:	97fffa96 	bl	ffffffff400318c8 <panic>
    }

    ip = empty;
ffffffff40032e74:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40032e78:	f90017e0 	str	x0, [sp, #40]
    ip->dev = dev;
ffffffff40032e7c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032e80:	b9401fe1 	ldr	w1, [sp, #28]
ffffffff40032e84:	b9000001 	str	w1, [x0]
    ip->inum = inum;
ffffffff40032e88:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032e8c:	b9401be1 	ldr	w1, [sp, #24]
ffffffff40032e90:	b9000401 	str	w1, [x0, #4]
    ip->ref = 1;
ffffffff40032e94:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032e98:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40032e9c:	b9000801 	str	w1, [x0, #8]
    ip->flags = 0;
ffffffff40032ea0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032ea4:	b9000c1f 	str	wzr, [x0, #12]
    release(&icache.lock);
ffffffff40032ea8:	90000460 	adrp	x0, ffffffff400be000 <ftable+0x2e8>
ffffffff40032eac:	9133e000 	add	x0, x0, #0xcf8
ffffffff40032eb0:	94000b7f 	bl	ffffffff40035cac <release>

    return ip;
ffffffff40032eb4:	f94017e0 	ldr	x0, [sp, #40]
}
ffffffff40032eb8:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff40032ebc:	d65f03c0 	ret

ffffffff40032ec0 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode* idup (struct inode *ip)
{
ffffffff40032ec0:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40032ec4:	910003fd 	mov	x29, sp
ffffffff40032ec8:	f9000fe0 	str	x0, [sp, #24]
    acquire(&icache.lock);
ffffffff40032ecc:	90000460 	adrp	x0, ffffffff400be000 <ftable+0x2e8>
ffffffff40032ed0:	9133e000 	add	x0, x0, #0xcf8
ffffffff40032ed4:	94000b6c 	bl	ffffffff40035c84 <acquire>
    ip->ref++;
ffffffff40032ed8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032edc:	b9400800 	ldr	w0, [x0, #8]
ffffffff40032ee0:	11000401 	add	w1, w0, #0x1
ffffffff40032ee4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032ee8:	b9000801 	str	w1, [x0, #8]
    release(&icache.lock);
ffffffff40032eec:	90000460 	adrp	x0, ffffffff400be000 <ftable+0x2e8>
ffffffff40032ef0:	9133e000 	add	x0, x0, #0xcf8
ffffffff40032ef4:	94000b6e 	bl	ffffffff40035cac <release>
    return ip;
ffffffff40032ef8:	f9400fe0 	ldr	x0, [sp, #24]
}
ffffffff40032efc:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40032f00:	d65f03c0 	ret

ffffffff40032f04 <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void ilock (struct inode *ip)
{
ffffffff40032f04:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40032f08:	910003fd 	mov	x29, sp
ffffffff40032f0c:	f9000fe0 	str	x0, [sp, #24]
    struct buf *bp;
    struct dinode *dip;

    if (ip == 0 || ip->ref < 1) {
ffffffff40032f10:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032f14:	f100001f 	cmp	x0, #0x0
ffffffff40032f18:	540000a0 	b.eq	ffffffff40032f2c <ilock+0x28>  // b.none
ffffffff40032f1c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032f20:	b9400800 	ldr	w0, [x0, #8]
ffffffff40032f24:	7100001f 	cmp	w0, #0x0
ffffffff40032f28:	5400008c 	b.gt	ffffffff40032f38 <ilock+0x34>
        panic("ilock");
ffffffff40032f2c:	b0000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40032f30:	911a0000 	add	x0, x0, #0x680
ffffffff40032f34:	97fffa65 	bl	ffffffff400318c8 <panic>
    }

    acquire(&icache.lock);
ffffffff40032f38:	90000460 	adrp	x0, ffffffff400be000 <ftable+0x2e8>
ffffffff40032f3c:	9133e000 	add	x0, x0, #0xcf8
ffffffff40032f40:	94000b51 	bl	ffffffff40035c84 <acquire>
    while (ip->flags & I_BUSY) {
ffffffff40032f44:	14000005 	b	ffffffff40032f58 <ilock+0x54>
        sleep(ip, &icache.lock);
ffffffff40032f48:	90000460 	adrp	x0, ffffffff400be000 <ftable+0x2e8>
ffffffff40032f4c:	9133e001 	add	x1, x0, #0xcf8
ffffffff40032f50:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032f54:	94000a75 	bl	ffffffff40035928 <sleep>
    while (ip->flags & I_BUSY) {
ffffffff40032f58:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032f5c:	b9400c00 	ldr	w0, [x0, #12]
ffffffff40032f60:	12000000 	and	w0, w0, #0x1
ffffffff40032f64:	7100001f 	cmp	w0, #0x0
ffffffff40032f68:	54ffff01 	b.ne	ffffffff40032f48 <ilock+0x44>  // b.any
    }

    ip->flags |= I_BUSY;
ffffffff40032f6c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032f70:	b9400c00 	ldr	w0, [x0, #12]
ffffffff40032f74:	32000001 	orr	w1, w0, #0x1
ffffffff40032f78:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032f7c:	b9000c01 	str	w1, [x0, #12]
    release(&icache.lock);
ffffffff40032f80:	90000460 	adrp	x0, ffffffff400be000 <ftable+0x2e8>
ffffffff40032f84:	9133e000 	add	x0, x0, #0xcf8
ffffffff40032f88:	94000b49 	bl	ffffffff40035cac <release>

    if (!(ip->flags & I_VALID)) {
ffffffff40032f8c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032f90:	b9400c00 	ldr	w0, [x0, #12]
ffffffff40032f94:	121f0000 	and	w0, w0, #0x2
ffffffff40032f98:	7100001f 	cmp	w0, #0x0
ffffffff40032f9c:	540007c1 	b.ne	ffffffff40033094 <ilock+0x190>  // b.any
        bp = bread(ip->dev, IBLOCK(ip->inum));
ffffffff40032fa0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032fa4:	b9400002 	ldr	w2, [x0]
ffffffff40032fa8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032fac:	b9400400 	ldr	w0, [x0, #4]
ffffffff40032fb0:	53037c00 	lsr	w0, w0, #3
ffffffff40032fb4:	11000800 	add	w0, w0, #0x2
ffffffff40032fb8:	2a0003e1 	mov	w1, w0
ffffffff40032fbc:	2a0203e0 	mov	w0, w2
ffffffff40032fc0:	97fff67d 	bl	ffffffff400309b4 <bread>
ffffffff40032fc4:	f90017e0 	str	x0, [sp, #40]

        dip = (struct dinode*) bp->data + ip->inum % IPB;
ffffffff40032fc8:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40032fcc:	9100a001 	add	x1, x0, #0x28
ffffffff40032fd0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032fd4:	b9400400 	ldr	w0, [x0, #4]
ffffffff40032fd8:	2a0003e0 	mov	w0, w0
ffffffff40032fdc:	92400800 	and	x0, x0, #0x7
ffffffff40032fe0:	d37ae400 	lsl	x0, x0, #6
ffffffff40032fe4:	8b000020 	add	x0, x1, x0
ffffffff40032fe8:	f90013e0 	str	x0, [sp, #32]
        ip->type = dip->type;
ffffffff40032fec:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40032ff0:	79c00001 	ldrsh	w1, [x0]
ffffffff40032ff4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40032ff8:	79002001 	strh	w1, [x0, #16]
        ip->major = dip->major;
ffffffff40032ffc:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40033000:	79c00401 	ldrsh	w1, [x0, #2]
ffffffff40033004:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033008:	79002401 	strh	w1, [x0, #18]
        ip->minor = dip->minor;
ffffffff4003300c:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40033010:	79c00801 	ldrsh	w1, [x0, #4]
ffffffff40033014:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033018:	79002801 	strh	w1, [x0, #20]
        ip->nlink = dip->nlink;
ffffffff4003301c:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40033020:	79c00c01 	ldrsh	w1, [x0, #6]
ffffffff40033024:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033028:	79002c01 	strh	w1, [x0, #22]
        ip->size = dip->size;
ffffffff4003302c:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40033030:	b9400801 	ldr	w1, [x0, #8]
ffffffff40033034:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033038:	b9001801 	str	w1, [x0, #24]

        memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
ffffffff4003303c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033040:	91007003 	add	x3, x0, #0x1c
ffffffff40033044:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40033048:	91003000 	add	x0, x0, #0xc
ffffffff4003304c:	52800682 	mov	w2, #0x34                  	// #52
ffffffff40033050:	aa0003e1 	mov	x1, x0
ffffffff40033054:	aa0303e0 	mov	x0, x3
ffffffff40033058:	97fff454 	bl	ffffffff400301a8 <memmove>
        brelse(bp);
ffffffff4003305c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40033060:	97fff67c 	bl	ffffffff40030a50 <brelse>
        ip->flags |= I_VALID;
ffffffff40033064:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033068:	b9400c00 	ldr	w0, [x0, #12]
ffffffff4003306c:	321f0001 	orr	w1, w0, #0x2
ffffffff40033070:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033074:	b9000c01 	str	w1, [x0, #12]

        if (ip->type == 0) {
ffffffff40033078:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003307c:	79c02000 	ldrsh	w0, [x0, #16]
ffffffff40033080:	7100001f 	cmp	w0, #0x0
ffffffff40033084:	54000081 	b.ne	ffffffff40033094 <ilock+0x190>  // b.any
            panic("ilock: no type");
ffffffff40033088:	90000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003308c:	911a2000 	add	x0, x0, #0x688
ffffffff40033090:	97fffa0e 	bl	ffffffff400318c8 <panic>
        }
    }
}
ffffffff40033094:	d503201f 	nop
ffffffff40033098:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff4003309c:	d65f03c0 	ret

ffffffff400330a0 <iunlock>:

// Unlock the given inode.
void iunlock (struct inode *ip)
{
ffffffff400330a0:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff400330a4:	910003fd 	mov	x29, sp
ffffffff400330a8:	f9000fe0 	str	x0, [sp, #24]
    if (ip == 0 || !(ip->flags & I_BUSY) || ip->ref < 1) {
ffffffff400330ac:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400330b0:	f100001f 	cmp	x0, #0x0
ffffffff400330b4:	54000140 	b.eq	ffffffff400330dc <iunlock+0x3c>  // b.none
ffffffff400330b8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400330bc:	b9400c00 	ldr	w0, [x0, #12]
ffffffff400330c0:	12000000 	and	w0, w0, #0x1
ffffffff400330c4:	7100001f 	cmp	w0, #0x0
ffffffff400330c8:	540000a0 	b.eq	ffffffff400330dc <iunlock+0x3c>  // b.none
ffffffff400330cc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400330d0:	b9400800 	ldr	w0, [x0, #8]
ffffffff400330d4:	7100001f 	cmp	w0, #0x0
ffffffff400330d8:	5400008c 	b.gt	ffffffff400330e8 <iunlock+0x48>
        panic("iunlock");
ffffffff400330dc:	90000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400330e0:	911a6000 	add	x0, x0, #0x698
ffffffff400330e4:	97fff9f9 	bl	ffffffff400318c8 <panic>
    }

    acquire(&icache.lock);
ffffffff400330e8:	f0000440 	adrp	x0, ffffffff400be000 <ftable+0x2e8>
ffffffff400330ec:	9133e000 	add	x0, x0, #0xcf8
ffffffff400330f0:	94000ae5 	bl	ffffffff40035c84 <acquire>
    ip->flags &= ~I_BUSY;
ffffffff400330f4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400330f8:	b9400c00 	ldr	w0, [x0, #12]
ffffffff400330fc:	121f7801 	and	w1, w0, #0xfffffffe
ffffffff40033100:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033104:	b9000c01 	str	w1, [x0, #12]
    wakeup(ip);
ffffffff40033108:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003310c:	94000a5d 	bl	ffffffff40035a80 <wakeup>
    release(&icache.lock);
ffffffff40033110:	f0000440 	adrp	x0, ffffffff400be000 <ftable+0x2e8>
ffffffff40033114:	9133e000 	add	x0, x0, #0xcf8
ffffffff40033118:	94000ae5 	bl	ffffffff40035cac <release>
}
ffffffff4003311c:	d503201f 	nop
ffffffff40033120:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40033124:	d65f03c0 	ret

ffffffff40033128 <iput>:
// If that was the last reference, the inode cache entry can
// be recycled.
// If that was the last reference and the inode has no links
// to it, free the inode (and its content) on disk.
void iput (struct inode *ip)
{
ffffffff40033128:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff4003312c:	910003fd 	mov	x29, sp
ffffffff40033130:	f9000fe0 	str	x0, [sp, #24]
    acquire(&icache.lock);
ffffffff40033134:	f0000440 	adrp	x0, ffffffff400be000 <ftable+0x2e8>
ffffffff40033138:	9133e000 	add	x0, x0, #0xcf8
ffffffff4003313c:	94000ad2 	bl	ffffffff40035c84 <acquire>

    if (ip->ref == 1 && (ip->flags & I_VALID) && ip->nlink == 0) {
ffffffff40033140:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033144:	b9400800 	ldr	w0, [x0, #8]
ffffffff40033148:	7100041f 	cmp	w0, #0x1
ffffffff4003314c:	540004e1 	b.ne	ffffffff400331e8 <iput+0xc0>  // b.any
ffffffff40033150:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033154:	b9400c00 	ldr	w0, [x0, #12]
ffffffff40033158:	121f0000 	and	w0, w0, #0x2
ffffffff4003315c:	7100001f 	cmp	w0, #0x0
ffffffff40033160:	54000440 	b.eq	ffffffff400331e8 <iput+0xc0>  // b.none
ffffffff40033164:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033168:	79c02c00 	ldrsh	w0, [x0, #22]
ffffffff4003316c:	7100001f 	cmp	w0, #0x0
ffffffff40033170:	540003c1 	b.ne	ffffffff400331e8 <iput+0xc0>  // b.any
        // inode has no links: truncate and free inode.
        if (ip->flags & I_BUSY) {
ffffffff40033174:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033178:	b9400c00 	ldr	w0, [x0, #12]
ffffffff4003317c:	12000000 	and	w0, w0, #0x1
ffffffff40033180:	7100001f 	cmp	w0, #0x0
ffffffff40033184:	54000080 	b.eq	ffffffff40033194 <iput+0x6c>  // b.none
            panic("iput busy");
ffffffff40033188:	90000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003318c:	911a8000 	add	x0, x0, #0x6a0
ffffffff40033190:	97fff9ce 	bl	ffffffff400318c8 <panic>
        }

        ip->flags |= I_BUSY;
ffffffff40033194:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033198:	b9400c00 	ldr	w0, [x0, #12]
ffffffff4003319c:	32000001 	orr	w1, w0, #0x1
ffffffff400331a0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400331a4:	b9000c01 	str	w1, [x0, #12]
        release(&icache.lock);
ffffffff400331a8:	f0000440 	adrp	x0, ffffffff400be000 <ftable+0x2e8>
ffffffff400331ac:	9133e000 	add	x0, x0, #0xcf8
ffffffff400331b0:	94000abf 	bl	ffffffff40035cac <release>
        itrunc(ip);
ffffffff400331b4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400331b8:	94000078 	bl	ffffffff40033398 <itrunc>
        ip->type = 0;
ffffffff400331bc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400331c0:	7900201f 	strh	wzr, [x0, #16]
        iupdate(ip);
ffffffff400331c4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400331c8:	97fffeb7 	bl	ffffffff40032ca4 <iupdate>

        acquire(&icache.lock);
ffffffff400331cc:	f0000440 	adrp	x0, ffffffff400be000 <ftable+0x2e8>
ffffffff400331d0:	9133e000 	add	x0, x0, #0xcf8
ffffffff400331d4:	94000aac 	bl	ffffffff40035c84 <acquire>
        ip->flags = 0;
ffffffff400331d8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400331dc:	b9000c1f 	str	wzr, [x0, #12]
        wakeup(ip);
ffffffff400331e0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400331e4:	94000a27 	bl	ffffffff40035a80 <wakeup>
    }

    ip->ref--;
ffffffff400331e8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400331ec:	b9400800 	ldr	w0, [x0, #8]
ffffffff400331f0:	51000401 	sub	w1, w0, #0x1
ffffffff400331f4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400331f8:	b9000801 	str	w1, [x0, #8]
    release(&icache.lock);
ffffffff400331fc:	f0000440 	adrp	x0, ffffffff400be000 <ftable+0x2e8>
ffffffff40033200:	9133e000 	add	x0, x0, #0xcf8
ffffffff40033204:	94000aaa 	bl	ffffffff40035cac <release>
}
ffffffff40033208:	d503201f 	nop
ffffffff4003320c:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40033210:	d65f03c0 	ret

ffffffff40033214 <iunlockput>:

// Common idiom: unlock, then put.
void iunlockput (struct inode *ip)
{
ffffffff40033214:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40033218:	910003fd 	mov	x29, sp
ffffffff4003321c:	f9000fe0 	str	x0, [sp, #24]
    iunlock(ip);
ffffffff40033220:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033224:	97ffff9f 	bl	ffffffff400330a0 <iunlock>
    iput(ip);
ffffffff40033228:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003322c:	97ffffbf 	bl	ffffffff40033128 <iput>
}
ffffffff40033230:	d503201f 	nop
ffffffff40033234:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40033238:	d65f03c0 	ret

ffffffff4003323c <bmap>:
// listed in block ip->addrs[NDIRECT].

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint bmap (struct inode *ip, uint bn)
{
ffffffff4003323c:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff40033240:	910003fd 	mov	x29, sp
ffffffff40033244:	f9000fe0 	str	x0, [sp, #24]
ffffffff40033248:	b90017e1 	str	w1, [sp, #20]
    uint addr, *a;
    struct buf *bp;

    if (bn < NDIRECT) {
ffffffff4003324c:	b94017e0 	ldr	w0, [sp, #20]
ffffffff40033250:	71002c1f 	cmp	w0, #0xb
ffffffff40033254:	54000308 	b.hi	ffffffff400332b4 <bmap+0x78>  // b.pmore
        if ((addr = ip->addrs[bn]) == 0) {
ffffffff40033258:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff4003325c:	b94017e0 	ldr	w0, [sp, #20]
ffffffff40033260:	91001000 	add	x0, x0, #0x4
ffffffff40033264:	d37ef400 	lsl	x0, x0, #2
ffffffff40033268:	8b000020 	add	x0, x1, x0
ffffffff4003326c:	b9400c00 	ldr	w0, [x0, #12]
ffffffff40033270:	b9003fe0 	str	w0, [sp, #60]
ffffffff40033274:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40033278:	7100001f 	cmp	w0, #0x0
ffffffff4003327c:	54000181 	b.ne	ffffffff400332ac <bmap+0x70>  // b.any
            ip->addrs[bn] = addr = balloc(ip->dev);
ffffffff40033280:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033284:	b9400000 	ldr	w0, [x0]
ffffffff40033288:	97fffd8e 	bl	ffffffff400328c0 <balloc>
ffffffff4003328c:	b9003fe0 	str	w0, [sp, #60]
ffffffff40033290:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40033294:	b94017e0 	ldr	w0, [sp, #20]
ffffffff40033298:	91001000 	add	x0, x0, #0x4
ffffffff4003329c:	d37ef400 	lsl	x0, x0, #2
ffffffff400332a0:	8b000020 	add	x0, x1, x0
ffffffff400332a4:	b9403fe1 	ldr	w1, [sp, #60]
ffffffff400332a8:	b9000c01 	str	w1, [x0, #12]
        }

        return addr;
ffffffff400332ac:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff400332b0:	14000038 	b	ffffffff40033390 <bmap+0x154>
    }

    bn -= NDIRECT;
ffffffff400332b4:	b94017e0 	ldr	w0, [sp, #20]
ffffffff400332b8:	51003000 	sub	w0, w0, #0xc
ffffffff400332bc:	b90017e0 	str	w0, [sp, #20]

    if (bn < NINDIRECT) {
ffffffff400332c0:	b94017e0 	ldr	w0, [sp, #20]
ffffffff400332c4:	7101fc1f 	cmp	w0, #0x7f
ffffffff400332c8:	540005e8 	b.hi	ffffffff40033384 <bmap+0x148>  // b.pmore
        // Load indirect block, allocating if necessary.
        if ((addr = ip->addrs[NDIRECT]) == 0) {
ffffffff400332cc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400332d0:	b9404c00 	ldr	w0, [x0, #76]
ffffffff400332d4:	b9003fe0 	str	w0, [sp, #60]
ffffffff400332d8:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff400332dc:	7100001f 	cmp	w0, #0x0
ffffffff400332e0:	54000101 	b.ne	ffffffff40033300 <bmap+0xc4>  // b.any
            ip->addrs[NDIRECT] = addr = balloc(ip->dev);
ffffffff400332e4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400332e8:	b9400000 	ldr	w0, [x0]
ffffffff400332ec:	97fffd75 	bl	ffffffff400328c0 <balloc>
ffffffff400332f0:	b9003fe0 	str	w0, [sp, #60]
ffffffff400332f4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400332f8:	b9403fe1 	ldr	w1, [sp, #60]
ffffffff400332fc:	b9004c01 	str	w1, [x0, #76]
        }

        bp = bread(ip->dev, addr);
ffffffff40033300:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033304:	b9400000 	ldr	w0, [x0]
ffffffff40033308:	b9403fe1 	ldr	w1, [sp, #60]
ffffffff4003330c:	97fff5aa 	bl	ffffffff400309b4 <bread>
ffffffff40033310:	f9001be0 	str	x0, [sp, #48]
        a = (uint*) bp->data;
ffffffff40033314:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40033318:	9100a000 	add	x0, x0, #0x28
ffffffff4003331c:	f90017e0 	str	x0, [sp, #40]

        if ((addr = a[bn]) == 0) {
ffffffff40033320:	b94017e0 	ldr	w0, [sp, #20]
ffffffff40033324:	d37ef400 	lsl	x0, x0, #2
ffffffff40033328:	f94017e1 	ldr	x1, [sp, #40]
ffffffff4003332c:	8b000020 	add	x0, x1, x0
ffffffff40033330:	b9400000 	ldr	w0, [x0]
ffffffff40033334:	b9003fe0 	str	w0, [sp, #60]
ffffffff40033338:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff4003333c:	7100001f 	cmp	w0, #0x0
ffffffff40033340:	540001a1 	b.ne	ffffffff40033374 <bmap+0x138>  // b.any
            a[bn] = addr = balloc(ip->dev);
ffffffff40033344:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033348:	b9400000 	ldr	w0, [x0]
ffffffff4003334c:	97fffd5d 	bl	ffffffff400328c0 <balloc>
ffffffff40033350:	b9003fe0 	str	w0, [sp, #60]
ffffffff40033354:	b94017e0 	ldr	w0, [sp, #20]
ffffffff40033358:	d37ef400 	lsl	x0, x0, #2
ffffffff4003335c:	f94017e1 	ldr	x1, [sp, #40]
ffffffff40033360:	8b000020 	add	x0, x1, x0
ffffffff40033364:	b9403fe1 	ldr	w1, [sp, #60]
ffffffff40033368:	b9000001 	str	w1, [x0]
            log_write(bp);
ffffffff4003336c:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40033370:	940003b5 	bl	ffffffff40034244 <log_write>
        }

        brelse(bp);
ffffffff40033374:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40033378:	97fff5b6 	bl	ffffffff40030a50 <brelse>
        return addr;
ffffffff4003337c:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40033380:	14000004 	b	ffffffff40033390 <bmap+0x154>
    }

    panic("bmap: out of range");
ffffffff40033384:	90000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40033388:	911ac000 	add	x0, x0, #0x6b0
ffffffff4003338c:	97fff94f 	bl	ffffffff400318c8 <panic>
}
ffffffff40033390:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff40033394:	d65f03c0 	ret

ffffffff40033398 <itrunc>:
// Only called when the inode has no links
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void itrunc (struct inode *ip)
{
ffffffff40033398:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff4003339c:	910003fd 	mov	x29, sp
ffffffff400333a0:	f9000fe0 	str	x0, [sp, #24]
    int i, j;
    struct buf *bp;
    uint *a;

    for (i = 0; i < NDIRECT; i++) {
ffffffff400333a4:	b9003fff 	str	wzr, [sp, #60]
ffffffff400333a8:	1400001e 	b	ffffffff40033420 <itrunc+0x88>
        if (ip->addrs[i]) {
ffffffff400333ac:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff400333b0:	b9803fe0 	ldrsw	x0, [sp, #60]
ffffffff400333b4:	91001000 	add	x0, x0, #0x4
ffffffff400333b8:	d37ef400 	lsl	x0, x0, #2
ffffffff400333bc:	8b000020 	add	x0, x1, x0
ffffffff400333c0:	b9400c00 	ldr	w0, [x0, #12]
ffffffff400333c4:	7100001f 	cmp	w0, #0x0
ffffffff400333c8:	54000260 	b.eq	ffffffff40033414 <itrunc+0x7c>  // b.none
            bfree(ip->dev, ip->addrs[i]);
ffffffff400333cc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400333d0:	b9400000 	ldr	w0, [x0]
ffffffff400333d4:	2a0003e2 	mov	w2, w0
ffffffff400333d8:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff400333dc:	b9803fe0 	ldrsw	x0, [sp, #60]
ffffffff400333e0:	91001000 	add	x0, x0, #0x4
ffffffff400333e4:	d37ef400 	lsl	x0, x0, #2
ffffffff400333e8:	8b000020 	add	x0, x1, x0
ffffffff400333ec:	b9400c00 	ldr	w0, [x0, #12]
ffffffff400333f0:	2a0003e1 	mov	w1, w0
ffffffff400333f4:	2a0203e0 	mov	w0, w2
ffffffff400333f8:	97fffd9d 	bl	ffffffff40032a6c <bfree>
            ip->addrs[i] = 0;
ffffffff400333fc:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40033400:	b9803fe0 	ldrsw	x0, [sp, #60]
ffffffff40033404:	91001000 	add	x0, x0, #0x4
ffffffff40033408:	d37ef400 	lsl	x0, x0, #2
ffffffff4003340c:	8b000020 	add	x0, x1, x0
ffffffff40033410:	b9000c1f 	str	wzr, [x0, #12]
    for (i = 0; i < NDIRECT; i++) {
ffffffff40033414:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40033418:	11000400 	add	w0, w0, #0x1
ffffffff4003341c:	b9003fe0 	str	w0, [sp, #60]
ffffffff40033420:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40033424:	71002c1f 	cmp	w0, #0xb
ffffffff40033428:	54fffc2d 	b.le	ffffffff400333ac <itrunc+0x14>
        }
    }

    if (ip->addrs[NDIRECT]) {
ffffffff4003342c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033430:	b9404c00 	ldr	w0, [x0, #76]
ffffffff40033434:	7100001f 	cmp	w0, #0x0
ffffffff40033438:	54000640 	b.eq	ffffffff40033500 <itrunc+0x168>  // b.none
        bp = bread(ip->dev, ip->addrs[NDIRECT]);
ffffffff4003343c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033440:	b9400002 	ldr	w2, [x0]
ffffffff40033444:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033448:	b9404c00 	ldr	w0, [x0, #76]
ffffffff4003344c:	2a0003e1 	mov	w1, w0
ffffffff40033450:	2a0203e0 	mov	w0, w2
ffffffff40033454:	97fff558 	bl	ffffffff400309b4 <bread>
ffffffff40033458:	f9001be0 	str	x0, [sp, #48]
        a = (uint*) bp->data;
ffffffff4003345c:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40033460:	9100a000 	add	x0, x0, #0x28
ffffffff40033464:	f90017e0 	str	x0, [sp, #40]

        for (j = 0; j < NINDIRECT; j++) {
ffffffff40033468:	b9003bff 	str	wzr, [sp, #56]
ffffffff4003346c:	14000016 	b	ffffffff400334c4 <itrunc+0x12c>
            if (a[j]) {
ffffffff40033470:	b9803be0 	ldrsw	x0, [sp, #56]
ffffffff40033474:	d37ef400 	lsl	x0, x0, #2
ffffffff40033478:	f94017e1 	ldr	x1, [sp, #40]
ffffffff4003347c:	8b000020 	add	x0, x1, x0
ffffffff40033480:	b9400000 	ldr	w0, [x0]
ffffffff40033484:	7100001f 	cmp	w0, #0x0
ffffffff40033488:	54000180 	b.eq	ffffffff400334b8 <itrunc+0x120>  // b.none
                bfree(ip->dev, a[j]);
ffffffff4003348c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033490:	b9400000 	ldr	w0, [x0]
ffffffff40033494:	2a0003e2 	mov	w2, w0
ffffffff40033498:	b9803be0 	ldrsw	x0, [sp, #56]
ffffffff4003349c:	d37ef400 	lsl	x0, x0, #2
ffffffff400334a0:	f94017e1 	ldr	x1, [sp, #40]
ffffffff400334a4:	8b000020 	add	x0, x1, x0
ffffffff400334a8:	b9400000 	ldr	w0, [x0]
ffffffff400334ac:	2a0003e1 	mov	w1, w0
ffffffff400334b0:	2a0203e0 	mov	w0, w2
ffffffff400334b4:	97fffd6e 	bl	ffffffff40032a6c <bfree>
        for (j = 0; j < NINDIRECT; j++) {
ffffffff400334b8:	b9403be0 	ldr	w0, [sp, #56]
ffffffff400334bc:	11000400 	add	w0, w0, #0x1
ffffffff400334c0:	b9003be0 	str	w0, [sp, #56]
ffffffff400334c4:	b9403be0 	ldr	w0, [sp, #56]
ffffffff400334c8:	7101fc1f 	cmp	w0, #0x7f
ffffffff400334cc:	54fffd29 	b.ls	ffffffff40033470 <itrunc+0xd8>  // b.plast
            }
        }

        brelse(bp);
ffffffff400334d0:	f9401be0 	ldr	x0, [sp, #48]
ffffffff400334d4:	97fff55f 	bl	ffffffff40030a50 <brelse>
        bfree(ip->dev, ip->addrs[NDIRECT]);
ffffffff400334d8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400334dc:	b9400000 	ldr	w0, [x0]
ffffffff400334e0:	2a0003e2 	mov	w2, w0
ffffffff400334e4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400334e8:	b9404c00 	ldr	w0, [x0, #76]
ffffffff400334ec:	2a0003e1 	mov	w1, w0
ffffffff400334f0:	2a0203e0 	mov	w0, w2
ffffffff400334f4:	97fffd5e 	bl	ffffffff40032a6c <bfree>
        ip->addrs[NDIRECT] = 0;
ffffffff400334f8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400334fc:	b9004c1f 	str	wzr, [x0, #76]
    }

    ip->size = 0;
ffffffff40033500:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033504:	b900181f 	str	wzr, [x0, #24]
    iupdate(ip);
ffffffff40033508:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003350c:	97fffde6 	bl	ffffffff40032ca4 <iupdate>
}
ffffffff40033510:	d503201f 	nop
ffffffff40033514:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff40033518:	d65f03c0 	ret

ffffffff4003351c <stati>:

// Copy stat information from inode.
void stati (struct inode *ip, struct stat *st)
{
ffffffff4003351c:	d10043ff 	sub	sp, sp, #0x10
ffffffff40033520:	f90007e0 	str	x0, [sp, #8]
ffffffff40033524:	f90003e1 	str	x1, [sp]
    st->dev = ip->dev;
ffffffff40033528:	f94007e0 	ldr	x0, [sp, #8]
ffffffff4003352c:	b9400000 	ldr	w0, [x0]
ffffffff40033530:	2a0003e1 	mov	w1, w0
ffffffff40033534:	f94003e0 	ldr	x0, [sp]
ffffffff40033538:	b9000401 	str	w1, [x0, #4]
    st->ino = ip->inum;
ffffffff4003353c:	f94007e0 	ldr	x0, [sp, #8]
ffffffff40033540:	b9400401 	ldr	w1, [x0, #4]
ffffffff40033544:	f94003e0 	ldr	x0, [sp]
ffffffff40033548:	b9000801 	str	w1, [x0, #8]
    st->type = ip->type;
ffffffff4003354c:	f94007e0 	ldr	x0, [sp, #8]
ffffffff40033550:	79c02001 	ldrsh	w1, [x0, #16]
ffffffff40033554:	f94003e0 	ldr	x0, [sp]
ffffffff40033558:	79000001 	strh	w1, [x0]
    st->nlink = ip->nlink;
ffffffff4003355c:	f94007e0 	ldr	x0, [sp, #8]
ffffffff40033560:	79c02c01 	ldrsh	w1, [x0, #22]
ffffffff40033564:	f94003e0 	ldr	x0, [sp]
ffffffff40033568:	79001801 	strh	w1, [x0, #12]
    st->size = ip->size;
ffffffff4003356c:	f94007e0 	ldr	x0, [sp, #8]
ffffffff40033570:	b9401801 	ldr	w1, [x0, #24]
ffffffff40033574:	f94003e0 	ldr	x0, [sp]
ffffffff40033578:	b9001001 	str	w1, [x0, #16]
}
ffffffff4003357c:	d503201f 	nop
ffffffff40033580:	910043ff 	add	sp, sp, #0x10
ffffffff40033584:	d65f03c0 	ret

ffffffff40033588 <readi>:

//PAGEBREAK!
// Read data from inode.
int readi (struct inode *ip, char *dst, uint off, uint n)
{
ffffffff40033588:	a9ba7bfd 	stp	x29, x30, [sp, #-96]!
ffffffff4003358c:	910003fd 	mov	x29, sp
ffffffff40033590:	f9000bf3 	str	x19, [sp, #16]
ffffffff40033594:	f9001fe0 	str	x0, [sp, #56]
ffffffff40033598:	f9001be1 	str	x1, [sp, #48]
ffffffff4003359c:	b9002fe2 	str	w2, [sp, #44]
ffffffff400335a0:	b9002be3 	str	w3, [sp, #40]
    uint tot, m;
    struct buf *bp;

    if (ip->type == T_DEV) {
ffffffff400335a4:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff400335a8:	79c02000 	ldrsh	w0, [x0, #16]
ffffffff400335ac:	71000c1f 	cmp	w0, #0x3
ffffffff400335b0:	540004a1 	b.ne	ffffffff40033644 <readi+0xbc>  // b.any
        if (ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read) {
ffffffff400335b4:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff400335b8:	79c02400 	ldrsh	w0, [x0, #18]
ffffffff400335bc:	7100001f 	cmp	w0, #0x0
ffffffff400335c0:	5400020b 	b.lt	ffffffff40033600 <readi+0x78>  // b.tstop
ffffffff400335c4:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff400335c8:	79c02400 	ldrsh	w0, [x0, #18]
ffffffff400335cc:	7100241f 	cmp	w0, #0x9
ffffffff400335d0:	5400018c 	b.gt	ffffffff40033600 <readi+0x78>
ffffffff400335d4:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff400335d8:	79c02400 	ldrsh	w0, [x0, #18]
ffffffff400335dc:	2a0003e2 	mov	w2, w0
ffffffff400335e0:	d0000440 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff400335e4:	9131e001 	add	x1, x0, #0xc78
ffffffff400335e8:	93407c40 	sxtw	x0, w2
ffffffff400335ec:	d37cec00 	lsl	x0, x0, #4
ffffffff400335f0:	8b000020 	add	x0, x1, x0
ffffffff400335f4:	f9400000 	ldr	x0, [x0]
ffffffff400335f8:	f100001f 	cmp	x0, #0x0
ffffffff400335fc:	54000061 	b.ne	ffffffff40033608 <readi+0x80>  // b.any
            return -1;
ffffffff40033600:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40033604:	1400005c 	b	ffffffff40033774 <readi+0x1ec>
        }

        return devsw[ip->major].read(ip, dst, n);
ffffffff40033608:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003360c:	79c02400 	ldrsh	w0, [x0, #18]
ffffffff40033610:	2a0003e2 	mov	w2, w0
ffffffff40033614:	d0000440 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40033618:	9131e001 	add	x1, x0, #0xc78
ffffffff4003361c:	93407c40 	sxtw	x0, w2
ffffffff40033620:	d37cec00 	lsl	x0, x0, #4
ffffffff40033624:	8b000020 	add	x0, x1, x0
ffffffff40033628:	f9400003 	ldr	x3, [x0]
ffffffff4003362c:	b9402be0 	ldr	w0, [sp, #40]
ffffffff40033630:	2a0003e2 	mov	w2, w0
ffffffff40033634:	f9401be1 	ldr	x1, [sp, #48]
ffffffff40033638:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003363c:	d63f0060 	blr	x3
ffffffff40033640:	1400004d 	b	ffffffff40033774 <readi+0x1ec>
    }

    if (off > ip->size || off + n < off) {
ffffffff40033644:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40033648:	b9401800 	ldr	w0, [x0, #24]
ffffffff4003364c:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff40033650:	6b00003f 	cmp	w1, w0
ffffffff40033654:	540000e8 	b.hi	ffffffff40033670 <readi+0xe8>  // b.pmore
ffffffff40033658:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff4003365c:	b9402be0 	ldr	w0, [sp, #40]
ffffffff40033660:	0b000020 	add	w0, w1, w0
ffffffff40033664:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff40033668:	6b00003f 	cmp	w1, w0
ffffffff4003366c:	54000069 	b.ls	ffffffff40033678 <readi+0xf0>  // b.plast
        return -1;
ffffffff40033670:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40033674:	14000040 	b	ffffffff40033774 <readi+0x1ec>
    }

    if (off + n > ip->size) {
ffffffff40033678:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff4003367c:	b9402be0 	ldr	w0, [sp, #40]
ffffffff40033680:	0b000021 	add	w1, w1, w0
ffffffff40033684:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40033688:	b9401800 	ldr	w0, [x0, #24]
ffffffff4003368c:	6b00003f 	cmp	w1, w0
ffffffff40033690:	540000c9 	b.ls	ffffffff400336a8 <readi+0x120>  // b.plast
        n = ip->size - off;
ffffffff40033694:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40033698:	b9401801 	ldr	w1, [x0, #24]
ffffffff4003369c:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff400336a0:	4b000020 	sub	w0, w1, w0
ffffffff400336a4:	b9002be0 	str	w0, [sp, #40]
    }

    for (tot = 0; tot < n; tot += m, off += m, dst += m) {
ffffffff400336a8:	b9005fff 	str	wzr, [sp, #92]
ffffffff400336ac:	1400002d 	b	ffffffff40033760 <readi+0x1d8>
        bp = bread(ip->dev, bmap(ip, off / BSIZE));
ffffffff400336b0:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff400336b4:	b9400013 	ldr	w19, [x0]
ffffffff400336b8:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff400336bc:	53097c00 	lsr	w0, w0, #9
ffffffff400336c0:	2a0003e1 	mov	w1, w0
ffffffff400336c4:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff400336c8:	97fffedd 	bl	ffffffff4003323c <bmap>
ffffffff400336cc:	2a0003e1 	mov	w1, w0
ffffffff400336d0:	2a1303e0 	mov	w0, w19
ffffffff400336d4:	97fff4b8 	bl	ffffffff400309b4 <bread>
ffffffff400336d8:	f9002be0 	str	x0, [sp, #80]
        m = min(n - tot, BSIZE - off%BSIZE);
ffffffff400336dc:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff400336e0:	12002000 	and	w0, w0, #0x1ff
ffffffff400336e4:	52804001 	mov	w1, #0x200                 	// #512
ffffffff400336e8:	4b000021 	sub	w1, w1, w0
ffffffff400336ec:	b9402be2 	ldr	w2, [sp, #40]
ffffffff400336f0:	b9405fe0 	ldr	w0, [sp, #92]
ffffffff400336f4:	4b000040 	sub	w0, w2, w0
ffffffff400336f8:	6b00003f 	cmp	w1, w0
ffffffff400336fc:	1a809020 	csel	w0, w1, w0, ls	// ls = plast
ffffffff40033700:	b9004fe0 	str	w0, [sp, #76]
        memmove(dst, bp->data + off % BSIZE, m);
ffffffff40033704:	f9402be0 	ldr	x0, [sp, #80]
ffffffff40033708:	9100a001 	add	x1, x0, #0x28
ffffffff4003370c:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40033710:	92402000 	and	x0, x0, #0x1ff
ffffffff40033714:	8b000020 	add	x0, x1, x0
ffffffff40033718:	b9404fe2 	ldr	w2, [sp, #76]
ffffffff4003371c:	aa0003e1 	mov	x1, x0
ffffffff40033720:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40033724:	97fff2a1 	bl	ffffffff400301a8 <memmove>
        brelse(bp);
ffffffff40033728:	f9402be0 	ldr	x0, [sp, #80]
ffffffff4003372c:	97fff4c9 	bl	ffffffff40030a50 <brelse>
    for (tot = 0; tot < n; tot += m, off += m, dst += m) {
ffffffff40033730:	b9405fe1 	ldr	w1, [sp, #92]
ffffffff40033734:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff40033738:	0b000020 	add	w0, w1, w0
ffffffff4003373c:	b9005fe0 	str	w0, [sp, #92]
ffffffff40033740:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff40033744:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff40033748:	0b000020 	add	w0, w1, w0
ffffffff4003374c:	b9002fe0 	str	w0, [sp, #44]
ffffffff40033750:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff40033754:	f9401be1 	ldr	x1, [sp, #48]
ffffffff40033758:	8b000020 	add	x0, x1, x0
ffffffff4003375c:	f9001be0 	str	x0, [sp, #48]
ffffffff40033760:	b9405fe1 	ldr	w1, [sp, #92]
ffffffff40033764:	b9402be0 	ldr	w0, [sp, #40]
ffffffff40033768:	6b00003f 	cmp	w1, w0
ffffffff4003376c:	54fffa23 	b.cc	ffffffff400336b0 <readi+0x128>  // b.lo, b.ul, b.last
    }

    return n;
ffffffff40033770:	b9402be0 	ldr	w0, [sp, #40]
}
ffffffff40033774:	f9400bf3 	ldr	x19, [sp, #16]
ffffffff40033778:	a8c67bfd 	ldp	x29, x30, [sp], #96
ffffffff4003377c:	d65f03c0 	ret

ffffffff40033780 <writei>:

// PAGEBREAK!
// Write data to inode.
int writei (struct inode *ip, char *src, uint off, uint n)
{
ffffffff40033780:	a9ba7bfd 	stp	x29, x30, [sp, #-96]!
ffffffff40033784:	910003fd 	mov	x29, sp
ffffffff40033788:	f9000bf3 	str	x19, [sp, #16]
ffffffff4003378c:	f9001fe0 	str	x0, [sp, #56]
ffffffff40033790:	f9001be1 	str	x1, [sp, #48]
ffffffff40033794:	b9002fe2 	str	w2, [sp, #44]
ffffffff40033798:	b9002be3 	str	w3, [sp, #40]
    uint tot, m;
    struct buf *bp;

    if (ip->type == T_DEV) {
ffffffff4003379c:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff400337a0:	79c02000 	ldrsh	w0, [x0, #16]
ffffffff400337a4:	71000c1f 	cmp	w0, #0x3
ffffffff400337a8:	540004a1 	b.ne	ffffffff4003383c <writei+0xbc>  // b.any
        if (ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write) {
ffffffff400337ac:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff400337b0:	79c02400 	ldrsh	w0, [x0, #18]
ffffffff400337b4:	7100001f 	cmp	w0, #0x0
ffffffff400337b8:	5400020b 	b.lt	ffffffff400337f8 <writei+0x78>  // b.tstop
ffffffff400337bc:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff400337c0:	79c02400 	ldrsh	w0, [x0, #18]
ffffffff400337c4:	7100241f 	cmp	w0, #0x9
ffffffff400337c8:	5400018c 	b.gt	ffffffff400337f8 <writei+0x78>
ffffffff400337cc:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff400337d0:	79c02400 	ldrsh	w0, [x0, #18]
ffffffff400337d4:	2a0003e2 	mov	w2, w0
ffffffff400337d8:	d0000440 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff400337dc:	9131e001 	add	x1, x0, #0xc78
ffffffff400337e0:	93407c40 	sxtw	x0, w2
ffffffff400337e4:	d37cec00 	lsl	x0, x0, #4
ffffffff400337e8:	8b000020 	add	x0, x1, x0
ffffffff400337ec:	f9400400 	ldr	x0, [x0, #8]
ffffffff400337f0:	f100001f 	cmp	x0, #0x0
ffffffff400337f4:	54000061 	b.ne	ffffffff40033800 <writei+0x80>  // b.any
            return -1;
ffffffff400337f8:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff400337fc:	14000067 	b	ffffffff40033998 <writei+0x218>
        }

        return devsw[ip->major].write(ip, src, n);
ffffffff40033800:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40033804:	79c02400 	ldrsh	w0, [x0, #18]
ffffffff40033808:	2a0003e2 	mov	w2, w0
ffffffff4003380c:	d0000440 	adrp	x0, ffffffff400bd000 <bcache+0xeb0>
ffffffff40033810:	9131e001 	add	x1, x0, #0xc78
ffffffff40033814:	93407c40 	sxtw	x0, w2
ffffffff40033818:	d37cec00 	lsl	x0, x0, #4
ffffffff4003381c:	8b000020 	add	x0, x1, x0
ffffffff40033820:	f9400403 	ldr	x3, [x0, #8]
ffffffff40033824:	b9402be0 	ldr	w0, [sp, #40]
ffffffff40033828:	2a0003e2 	mov	w2, w0
ffffffff4003382c:	f9401be1 	ldr	x1, [sp, #48]
ffffffff40033830:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40033834:	d63f0060 	blr	x3
ffffffff40033838:	14000058 	b	ffffffff40033998 <writei+0x218>
    }

    if (off > ip->size || off + n < off) {
ffffffff4003383c:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40033840:	b9401800 	ldr	w0, [x0, #24]
ffffffff40033844:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff40033848:	6b00003f 	cmp	w1, w0
ffffffff4003384c:	540000e8 	b.hi	ffffffff40033868 <writei+0xe8>  // b.pmore
ffffffff40033850:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff40033854:	b9402be0 	ldr	w0, [sp, #40]
ffffffff40033858:	0b000020 	add	w0, w1, w0
ffffffff4003385c:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff40033860:	6b00003f 	cmp	w1, w0
ffffffff40033864:	54000069 	b.ls	ffffffff40033870 <writei+0xf0>  // b.plast
        return -1;
ffffffff40033868:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff4003386c:	1400004b 	b	ffffffff40033998 <writei+0x218>
    }

    if (off + n > MAXFILE * BSIZE) {
ffffffff40033870:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff40033874:	b9402be0 	ldr	w0, [sp, #40]
ffffffff40033878:	0b000021 	add	w1, w1, w0
ffffffff4003387c:	52830000 	mov	w0, #0x1800                	// #6144
ffffffff40033880:	72a00020 	movk	w0, #0x1, lsl #16
ffffffff40033884:	6b00003f 	cmp	w1, w0
ffffffff40033888:	54000069 	b.ls	ffffffff40033894 <writei+0x114>  // b.plast
        return -1;
ffffffff4003388c:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40033890:	14000042 	b	ffffffff40033998 <writei+0x218>
    }

    for (tot = 0; tot < n; tot += m, off += m, src += m) {
ffffffff40033894:	b9005fff 	str	wzr, [sp, #92]
ffffffff40033898:	1400002e 	b	ffffffff40033950 <writei+0x1d0>
        bp = bread(ip->dev, bmap(ip, off / BSIZE));
ffffffff4003389c:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff400338a0:	b9400013 	ldr	w19, [x0]
ffffffff400338a4:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff400338a8:	53097c00 	lsr	w0, w0, #9
ffffffff400338ac:	2a0003e1 	mov	w1, w0
ffffffff400338b0:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff400338b4:	97fffe62 	bl	ffffffff4003323c <bmap>
ffffffff400338b8:	2a0003e1 	mov	w1, w0
ffffffff400338bc:	2a1303e0 	mov	w0, w19
ffffffff400338c0:	97fff43d 	bl	ffffffff400309b4 <bread>
ffffffff400338c4:	f9002be0 	str	x0, [sp, #80]
        m = min(n - tot, BSIZE - off%BSIZE);
ffffffff400338c8:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff400338cc:	12002000 	and	w0, w0, #0x1ff
ffffffff400338d0:	52804001 	mov	w1, #0x200                 	// #512
ffffffff400338d4:	4b000021 	sub	w1, w1, w0
ffffffff400338d8:	b9402be2 	ldr	w2, [sp, #40]
ffffffff400338dc:	b9405fe0 	ldr	w0, [sp, #92]
ffffffff400338e0:	4b000040 	sub	w0, w2, w0
ffffffff400338e4:	6b00003f 	cmp	w1, w0
ffffffff400338e8:	1a809020 	csel	w0, w1, w0, ls	// ls = plast
ffffffff400338ec:	b9004fe0 	str	w0, [sp, #76]
        memmove(bp->data + off % BSIZE, src, m);
ffffffff400338f0:	f9402be0 	ldr	x0, [sp, #80]
ffffffff400338f4:	9100a001 	add	x1, x0, #0x28
ffffffff400338f8:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff400338fc:	92402000 	and	x0, x0, #0x1ff
ffffffff40033900:	8b000020 	add	x0, x1, x0
ffffffff40033904:	b9404fe2 	ldr	w2, [sp, #76]
ffffffff40033908:	f9401be1 	ldr	x1, [sp, #48]
ffffffff4003390c:	97fff227 	bl	ffffffff400301a8 <memmove>
        log_write(bp);
ffffffff40033910:	f9402be0 	ldr	x0, [sp, #80]
ffffffff40033914:	9400024c 	bl	ffffffff40034244 <log_write>
        brelse(bp);
ffffffff40033918:	f9402be0 	ldr	x0, [sp, #80]
ffffffff4003391c:	97fff44d 	bl	ffffffff40030a50 <brelse>
    for (tot = 0; tot < n; tot += m, off += m, src += m) {
ffffffff40033920:	b9405fe1 	ldr	w1, [sp, #92]
ffffffff40033924:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff40033928:	0b000020 	add	w0, w1, w0
ffffffff4003392c:	b9005fe0 	str	w0, [sp, #92]
ffffffff40033930:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff40033934:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff40033938:	0b000020 	add	w0, w1, w0
ffffffff4003393c:	b9002fe0 	str	w0, [sp, #44]
ffffffff40033940:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff40033944:	f9401be1 	ldr	x1, [sp, #48]
ffffffff40033948:	8b000020 	add	x0, x1, x0
ffffffff4003394c:	f9001be0 	str	x0, [sp, #48]
ffffffff40033950:	b9405fe1 	ldr	w1, [sp, #92]
ffffffff40033954:	b9402be0 	ldr	w0, [sp, #40]
ffffffff40033958:	6b00003f 	cmp	w1, w0
ffffffff4003395c:	54fffa03 	b.cc	ffffffff4003389c <writei+0x11c>  // b.lo, b.ul, b.last
    }

    if (n > 0 && off > ip->size) {
ffffffff40033960:	b9402be0 	ldr	w0, [sp, #40]
ffffffff40033964:	7100001f 	cmp	w0, #0x0
ffffffff40033968:	54000160 	b.eq	ffffffff40033994 <writei+0x214>  // b.none
ffffffff4003396c:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40033970:	b9401800 	ldr	w0, [x0, #24]
ffffffff40033974:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff40033978:	6b00003f 	cmp	w1, w0
ffffffff4003397c:	540000c9 	b.ls	ffffffff40033994 <writei+0x214>  // b.plast
        ip->size = off;
ffffffff40033980:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40033984:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff40033988:	b9001801 	str	w1, [x0, #24]
        iupdate(ip);
ffffffff4003398c:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40033990:	97fffcc5 	bl	ffffffff40032ca4 <iupdate>
    }

    return n;
ffffffff40033994:	b9402be0 	ldr	w0, [sp, #40]
}
ffffffff40033998:	f9400bf3 	ldr	x19, [sp, #16]
ffffffff4003399c:	a8c67bfd 	ldp	x29, x30, [sp], #96
ffffffff400339a0:	d65f03c0 	ret

ffffffff400339a4 <namecmp>:

//PAGEBREAK!
// Directories

int namecmp (const char *s, const char *t)
{
ffffffff400339a4:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff400339a8:	910003fd 	mov	x29, sp
ffffffff400339ac:	f9000fe0 	str	x0, [sp, #24]
ffffffff400339b0:	f9000be1 	str	x1, [sp, #16]
    return strncmp(s, t, DIRSIZ);
ffffffff400339b4:	528001c2 	mov	w2, #0xe                   	// #14
ffffffff400339b8:	f9400be1 	ldr	x1, [sp, #16]
ffffffff400339bc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400339c0:	97fff240 	bl	ffffffff400302c0 <strncmp>
}
ffffffff400339c4:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff400339c8:	d65f03c0 	ret

ffffffff400339cc <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode* dirlookup (struct inode *dp, char *name, uint *poff)
{
ffffffff400339cc:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
ffffffff400339d0:	910003fd 	mov	x29, sp
ffffffff400339d4:	f90017e0 	str	x0, [sp, #40]
ffffffff400339d8:	f90013e1 	str	x1, [sp, #32]
ffffffff400339dc:	f9000fe2 	str	x2, [sp, #24]
    uint off, inum;
    struct dirent de;

    if (dp->type != T_DIR) {
ffffffff400339e0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400339e4:	79c02000 	ldrsh	w0, [x0, #16]
ffffffff400339e8:	7100041f 	cmp	w0, #0x1
ffffffff400339ec:	54000080 	b.eq	ffffffff400339fc <dirlookup+0x30>  // b.none
        panic("dirlookup not DIR");
ffffffff400339f0:	90000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400339f4:	911b2000 	add	x0, x0, #0x6c8
ffffffff400339f8:	97fff7b4 	bl	ffffffff400318c8 <panic>
    }

    for (off = 0; off < dp->size; off += sizeof(de)) {
ffffffff400339fc:	b9004fff 	str	wzr, [sp, #76]
ffffffff40033a00:	14000027 	b	ffffffff40033a9c <dirlookup+0xd0>
        if (readi(dp, (char*) &de, off, sizeof(de)) != sizeof(de)) {
ffffffff40033a04:	9100e3e0 	add	x0, sp, #0x38
ffffffff40033a08:	52800203 	mov	w3, #0x10                  	// #16
ffffffff40033a0c:	b9404fe2 	ldr	w2, [sp, #76]
ffffffff40033a10:	aa0003e1 	mov	x1, x0
ffffffff40033a14:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40033a18:	97fffedc 	bl	ffffffff40033588 <readi>
ffffffff40033a1c:	7100401f 	cmp	w0, #0x10
ffffffff40033a20:	54000080 	b.eq	ffffffff40033a30 <dirlookup+0x64>  // b.none
            panic("dirlink read");
ffffffff40033a24:	90000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40033a28:	911b8000 	add	x0, x0, #0x6e0
ffffffff40033a2c:	97fff7a7 	bl	ffffffff400318c8 <panic>
        }

        if (de.inum == 0) {
ffffffff40033a30:	794073e0 	ldrh	w0, [sp, #56]
ffffffff40033a34:	7100001f 	cmp	w0, #0x0
ffffffff40033a38:	540002a0 	b.eq	ffffffff40033a8c <dirlookup+0xc0>  // b.none
            continue;
        }

        if (namecmp(name, de.name) == 0) {
ffffffff40033a3c:	9100e3e0 	add	x0, sp, #0x38
ffffffff40033a40:	91000800 	add	x0, x0, #0x2
ffffffff40033a44:	aa0003e1 	mov	x1, x0
ffffffff40033a48:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40033a4c:	97ffffd6 	bl	ffffffff400339a4 <namecmp>
ffffffff40033a50:	7100001f 	cmp	w0, #0x0
ffffffff40033a54:	540001e1 	b.ne	ffffffff40033a90 <dirlookup+0xc4>  // b.any
            // entry matches path element
            if (poff) {
ffffffff40033a58:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033a5c:	f100001f 	cmp	x0, #0x0
ffffffff40033a60:	54000080 	b.eq	ffffffff40033a70 <dirlookup+0xa4>  // b.none
                *poff = off;
ffffffff40033a64:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033a68:	b9404fe1 	ldr	w1, [sp, #76]
ffffffff40033a6c:	b9000001 	str	w1, [x0]
            }

            inum = de.inum;
ffffffff40033a70:	794073e0 	ldrh	w0, [sp, #56]
ffffffff40033a74:	b9004be0 	str	w0, [sp, #72]
            return iget(dp->dev, inum);
ffffffff40033a78:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40033a7c:	b9400000 	ldr	w0, [x0]
ffffffff40033a80:	b9404be1 	ldr	w1, [sp, #72]
ffffffff40033a84:	97fffcc1 	bl	ffffffff40032d88 <iget>
ffffffff40033a88:	1400000b 	b	ffffffff40033ab4 <dirlookup+0xe8>
            continue;
ffffffff40033a8c:	d503201f 	nop
    for (off = 0; off < dp->size; off += sizeof(de)) {
ffffffff40033a90:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff40033a94:	11004000 	add	w0, w0, #0x10
ffffffff40033a98:	b9004fe0 	str	w0, [sp, #76]
ffffffff40033a9c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40033aa0:	b9401800 	ldr	w0, [x0, #24]
ffffffff40033aa4:	b9404fe1 	ldr	w1, [sp, #76]
ffffffff40033aa8:	6b00003f 	cmp	w1, w0
ffffffff40033aac:	54fffac3 	b.cc	ffffffff40033a04 <dirlookup+0x38>  // b.lo, b.ul, b.last
        }
    }

    return 0;
ffffffff40033ab0:	d2800000 	mov	x0, #0x0                   	// #0
}
ffffffff40033ab4:	a8c57bfd 	ldp	x29, x30, [sp], #80
ffffffff40033ab8:	d65f03c0 	ret

ffffffff40033abc <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int dirlink (struct inode *dp, char *name, uint inum)
{
ffffffff40033abc:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
ffffffff40033ac0:	910003fd 	mov	x29, sp
ffffffff40033ac4:	f90017e0 	str	x0, [sp, #40]
ffffffff40033ac8:	f90013e1 	str	x1, [sp, #32]
ffffffff40033acc:	b9001fe2 	str	w2, [sp, #28]
    int off;
    struct dirent de;
    struct inode *ip;

    // Check that name is not present.
    if ((ip = dirlookup(dp, name, 0)) != 0) {
ffffffff40033ad0:	d2800002 	mov	x2, #0x0                   	// #0
ffffffff40033ad4:	f94013e1 	ldr	x1, [sp, #32]
ffffffff40033ad8:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40033adc:	97ffffbc 	bl	ffffffff400339cc <dirlookup>
ffffffff40033ae0:	f90023e0 	str	x0, [sp, #64]
ffffffff40033ae4:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40033ae8:	f100001f 	cmp	x0, #0x0
ffffffff40033aec:	540000a0 	b.eq	ffffffff40033b00 <dirlink+0x44>  // b.none
        iput(ip);
ffffffff40033af0:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40033af4:	97fffd8d 	bl	ffffffff40033128 <iput>
        return -1;
ffffffff40033af8:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40033afc:	14000031 	b	ffffffff40033bc0 <dirlink+0x104>
    }

    // Look for an empty dirent.
    for (off = 0; off < dp->size; off += sizeof(de)) {
ffffffff40033b00:	b9004fff 	str	wzr, [sp, #76]
ffffffff40033b04:	14000013 	b	ffffffff40033b50 <dirlink+0x94>
        if (readi(dp, (char*) &de, off, sizeof(de)) != sizeof(de)) {
ffffffff40033b08:	b9404fe1 	ldr	w1, [sp, #76]
ffffffff40033b0c:	9100c3e0 	add	x0, sp, #0x30
ffffffff40033b10:	52800203 	mov	w3, #0x10                  	// #16
ffffffff40033b14:	2a0103e2 	mov	w2, w1
ffffffff40033b18:	aa0003e1 	mov	x1, x0
ffffffff40033b1c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40033b20:	97fffe9a 	bl	ffffffff40033588 <readi>
ffffffff40033b24:	7100401f 	cmp	w0, #0x10
ffffffff40033b28:	54000080 	b.eq	ffffffff40033b38 <dirlink+0x7c>  // b.none
            panic("dirlink read");
ffffffff40033b2c:	90000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40033b30:	911b8000 	add	x0, x0, #0x6e0
ffffffff40033b34:	97fff765 	bl	ffffffff400318c8 <panic>
        }

        if (de.inum == 0) {
ffffffff40033b38:	794063e0 	ldrh	w0, [sp, #48]
ffffffff40033b3c:	7100001f 	cmp	w0, #0x0
ffffffff40033b40:	54000140 	b.eq	ffffffff40033b68 <dirlink+0xac>  // b.none
    for (off = 0; off < dp->size; off += sizeof(de)) {
ffffffff40033b44:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff40033b48:	11004000 	add	w0, w0, #0x10
ffffffff40033b4c:	b9004fe0 	str	w0, [sp, #76]
ffffffff40033b50:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40033b54:	b9401801 	ldr	w1, [x0, #24]
ffffffff40033b58:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff40033b5c:	6b00003f 	cmp	w1, w0
ffffffff40033b60:	54fffd48 	b.hi	ffffffff40033b08 <dirlink+0x4c>  // b.pmore
ffffffff40033b64:	14000002 	b	ffffffff40033b6c <dirlink+0xb0>
            break;
ffffffff40033b68:	d503201f 	nop
        }
    }

    strncpy(de.name, name, DIRSIZ);
ffffffff40033b6c:	9100c3e0 	add	x0, sp, #0x30
ffffffff40033b70:	91000800 	add	x0, x0, #0x2
ffffffff40033b74:	528001c2 	mov	w2, #0xe                   	// #14
ffffffff40033b78:	f94013e1 	ldr	x1, [sp, #32]
ffffffff40033b7c:	97fff1f9 	bl	ffffffff40030360 <strncpy>
    de.inum = inum;
ffffffff40033b80:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40033b84:	12003c00 	and	w0, w0, #0xffff
ffffffff40033b88:	790063e0 	strh	w0, [sp, #48]

    if (writei(dp, (char*) &de, off, sizeof(de)) != sizeof(de)) {
ffffffff40033b8c:	b9404fe1 	ldr	w1, [sp, #76]
ffffffff40033b90:	9100c3e0 	add	x0, sp, #0x30
ffffffff40033b94:	52800203 	mov	w3, #0x10                  	// #16
ffffffff40033b98:	2a0103e2 	mov	w2, w1
ffffffff40033b9c:	aa0003e1 	mov	x1, x0
ffffffff40033ba0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40033ba4:	97fffef7 	bl	ffffffff40033780 <writei>
ffffffff40033ba8:	7100401f 	cmp	w0, #0x10
ffffffff40033bac:	54000080 	b.eq	ffffffff40033bbc <dirlink+0x100>  // b.none
        panic("dirlink");
ffffffff40033bb0:	90000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40033bb4:	911bc000 	add	x0, x0, #0x6f0
ffffffff40033bb8:	97fff744 	bl	ffffffff400318c8 <panic>
    }

    return 0;
ffffffff40033bbc:	52800000 	mov	w0, #0x0                   	// #0
}
ffffffff40033bc0:	a8c57bfd 	ldp	x29, x30, [sp], #80
ffffffff40033bc4:	d65f03c0 	ret

ffffffff40033bc8 <skipelem>:
//   skipelem("///a//bb", name) = "bb", setting name = "a"
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char* skipelem (char *path, char *name)
{
ffffffff40033bc8:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40033bcc:	910003fd 	mov	x29, sp
ffffffff40033bd0:	f9000fe0 	str	x0, [sp, #24]
ffffffff40033bd4:	f9000be1 	str	x1, [sp, #16]
    char *s;
    int len;

    while (*path == '/') {
ffffffff40033bd8:	14000004 	b	ffffffff40033be8 <skipelem+0x20>
        path++;
ffffffff40033bdc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033be0:	91000400 	add	x0, x0, #0x1
ffffffff40033be4:	f9000fe0 	str	x0, [sp, #24]
    while (*path == '/') {
ffffffff40033be8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033bec:	39400000 	ldrb	w0, [x0]
ffffffff40033bf0:	7100bc1f 	cmp	w0, #0x2f
ffffffff40033bf4:	54ffff40 	b.eq	ffffffff40033bdc <skipelem+0x14>  // b.none
    }

    if (*path == 0) {
ffffffff40033bf8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033bfc:	39400000 	ldrb	w0, [x0]
ffffffff40033c00:	7100001f 	cmp	w0, #0x0
ffffffff40033c04:	54000061 	b.ne	ffffffff40033c10 <skipelem+0x48>  // b.any
        return 0;
ffffffff40033c08:	d2800000 	mov	x0, #0x0                   	// #0
ffffffff40033c0c:	1400002d 	b	ffffffff40033cc0 <skipelem+0xf8>
    }

    s = path;
ffffffff40033c10:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033c14:	f90017e0 	str	x0, [sp, #40]

    while (*path != '/' && *path != 0) {
ffffffff40033c18:	14000004 	b	ffffffff40033c28 <skipelem+0x60>
        path++;
ffffffff40033c1c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033c20:	91000400 	add	x0, x0, #0x1
ffffffff40033c24:	f9000fe0 	str	x0, [sp, #24]
    while (*path != '/' && *path != 0) {
ffffffff40033c28:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033c2c:	39400000 	ldrb	w0, [x0]
ffffffff40033c30:	7100bc1f 	cmp	w0, #0x2f
ffffffff40033c34:	540000a0 	b.eq	ffffffff40033c48 <skipelem+0x80>  // b.none
ffffffff40033c38:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033c3c:	39400000 	ldrb	w0, [x0]
ffffffff40033c40:	7100001f 	cmp	w0, #0x0
ffffffff40033c44:	54fffec1 	b.ne	ffffffff40033c1c <skipelem+0x54>  // b.any
    }

    len = path - s;
ffffffff40033c48:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40033c4c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40033c50:	cb000020 	sub	x0, x1, x0
ffffffff40033c54:	b90027e0 	str	w0, [sp, #36]

    if (len >= DIRSIZ) {
ffffffff40033c58:	b94027e0 	ldr	w0, [sp, #36]
ffffffff40033c5c:	7100341f 	cmp	w0, #0xd
ffffffff40033c60:	540000cd 	b.le	ffffffff40033c78 <skipelem+0xb0>
        memmove(name, s, DIRSIZ);
ffffffff40033c64:	528001c2 	mov	w2, #0xe                   	// #14
ffffffff40033c68:	f94017e1 	ldr	x1, [sp, #40]
ffffffff40033c6c:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40033c70:	97fff14e 	bl	ffffffff400301a8 <memmove>
ffffffff40033c74:	1400000e 	b	ffffffff40033cac <skipelem+0xe4>
    } else {
        memmove(name, s, len);
ffffffff40033c78:	b94027e0 	ldr	w0, [sp, #36]
ffffffff40033c7c:	2a0003e2 	mov	w2, w0
ffffffff40033c80:	f94017e1 	ldr	x1, [sp, #40]
ffffffff40033c84:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40033c88:	97fff148 	bl	ffffffff400301a8 <memmove>
        name[len] = 0;
ffffffff40033c8c:	b98027e0 	ldrsw	x0, [sp, #36]
ffffffff40033c90:	f9400be1 	ldr	x1, [sp, #16]
ffffffff40033c94:	8b000020 	add	x0, x1, x0
ffffffff40033c98:	3900001f 	strb	wzr, [x0]
    }

    while (*path == '/') {
ffffffff40033c9c:	14000004 	b	ffffffff40033cac <skipelem+0xe4>
        path++;
ffffffff40033ca0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033ca4:	91000400 	add	x0, x0, #0x1
ffffffff40033ca8:	f9000fe0 	str	x0, [sp, #24]
    while (*path == '/') {
ffffffff40033cac:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033cb0:	39400000 	ldrb	w0, [x0]
ffffffff40033cb4:	7100bc1f 	cmp	w0, #0x2f
ffffffff40033cb8:	54ffff40 	b.eq	ffffffff40033ca0 <skipelem+0xd8>  // b.none
    }

    return path;
ffffffff40033cbc:	f9400fe0 	ldr	x0, [sp, #24]
}
ffffffff40033cc0:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff40033cc4:	d65f03c0 	ret

ffffffff40033cc8 <namex>:

// Look up and return the inode for a path name.
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
static struct inode* namex (char *path, int nameiparent, char *name)
{
ffffffff40033cc8:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff40033ccc:	910003fd 	mov	x29, sp
ffffffff40033cd0:	f90017e0 	str	x0, [sp, #40]
ffffffff40033cd4:	b90027e1 	str	w1, [sp, #36]
ffffffff40033cd8:	f9000fe2 	str	x2, [sp, #24]
    struct inode *ip, *next;

    if (*path == '/') {
ffffffff40033cdc:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40033ce0:	39400000 	ldrb	w0, [x0]
ffffffff40033ce4:	7100bc1f 	cmp	w0, #0x2f
ffffffff40033ce8:	540000c1 	b.ne	ffffffff40033d00 <namex+0x38>  // b.any
        ip = iget(ROOTDEV, ROOTINO);
ffffffff40033cec:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40033cf0:	52800020 	mov	w0, #0x1                   	// #1
ffffffff40033cf4:	97fffc25 	bl	ffffffff40032d88 <iget>
ffffffff40033cf8:	f9001fe0 	str	x0, [sp, #56]
ffffffff40033cfc:	1400002d 	b	ffffffff40033db0 <namex+0xe8>
    } else {
        ip = idup(proc->cwd);
ffffffff40033d00:	90000580 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40033d04:	911e0000 	add	x0, x0, #0x780
ffffffff40033d08:	f9400000 	ldr	x0, [x0]
ffffffff40033d0c:	f9406400 	ldr	x0, [x0, #200]
ffffffff40033d10:	97fffc6c 	bl	ffffffff40032ec0 <idup>
ffffffff40033d14:	f9001fe0 	str	x0, [sp, #56]
    }

    while ((path = skipelem(path, name)) != 0) {
ffffffff40033d18:	14000026 	b	ffffffff40033db0 <namex+0xe8>
        ilock(ip);
ffffffff40033d1c:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40033d20:	97fffc79 	bl	ffffffff40032f04 <ilock>

        if (ip->type != T_DIR) {
ffffffff40033d24:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40033d28:	79c02000 	ldrsh	w0, [x0, #16]
ffffffff40033d2c:	7100041f 	cmp	w0, #0x1
ffffffff40033d30:	540000a0 	b.eq	ffffffff40033d44 <namex+0x7c>  // b.none
            iunlockput(ip);
ffffffff40033d34:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40033d38:	97fffd37 	bl	ffffffff40033214 <iunlockput>
            return 0;
ffffffff40033d3c:	d2800000 	mov	x0, #0x0                   	// #0
ffffffff40033d40:	1400002b 	b	ffffffff40033dec <namex+0x124>
        }

        if (nameiparent && *path == '\0') {
ffffffff40033d44:	b94027e0 	ldr	w0, [sp, #36]
ffffffff40033d48:	7100001f 	cmp	w0, #0x0
ffffffff40033d4c:	54000120 	b.eq	ffffffff40033d70 <namex+0xa8>  // b.none
ffffffff40033d50:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40033d54:	39400000 	ldrb	w0, [x0]
ffffffff40033d58:	7100001f 	cmp	w0, #0x0
ffffffff40033d5c:	540000a1 	b.ne	ffffffff40033d70 <namex+0xa8>  // b.any
            // Stop one level early.
            iunlock(ip);
ffffffff40033d60:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40033d64:	97fffccf 	bl	ffffffff400330a0 <iunlock>
            return ip;
ffffffff40033d68:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40033d6c:	14000020 	b	ffffffff40033dec <namex+0x124>
        }

        if ((next = dirlookup(ip, name, 0)) == 0) {
ffffffff40033d70:	d2800002 	mov	x2, #0x0                   	// #0
ffffffff40033d74:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40033d78:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40033d7c:	97ffff14 	bl	ffffffff400339cc <dirlookup>
ffffffff40033d80:	f9001be0 	str	x0, [sp, #48]
ffffffff40033d84:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40033d88:	f100001f 	cmp	x0, #0x0
ffffffff40033d8c:	540000a1 	b.ne	ffffffff40033da0 <namex+0xd8>  // b.any
            iunlockput(ip);
ffffffff40033d90:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40033d94:	97fffd20 	bl	ffffffff40033214 <iunlockput>
            return 0;
ffffffff40033d98:	d2800000 	mov	x0, #0x0                   	// #0
ffffffff40033d9c:	14000014 	b	ffffffff40033dec <namex+0x124>
        }

        iunlockput(ip);
ffffffff40033da0:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40033da4:	97fffd1c 	bl	ffffffff40033214 <iunlockput>
        ip = next;
ffffffff40033da8:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40033dac:	f9001fe0 	str	x0, [sp, #56]
    while ((path = skipelem(path, name)) != 0) {
ffffffff40033db0:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40033db4:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40033db8:	97ffff84 	bl	ffffffff40033bc8 <skipelem>
ffffffff40033dbc:	f90017e0 	str	x0, [sp, #40]
ffffffff40033dc0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40033dc4:	f100001f 	cmp	x0, #0x0
ffffffff40033dc8:	54fffaa1 	b.ne	ffffffff40033d1c <namex+0x54>  // b.any
    }

    if (nameiparent) {
ffffffff40033dcc:	b94027e0 	ldr	w0, [sp, #36]
ffffffff40033dd0:	7100001f 	cmp	w0, #0x0
ffffffff40033dd4:	540000a0 	b.eq	ffffffff40033de8 <namex+0x120>  // b.none
        iput(ip);
ffffffff40033dd8:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40033ddc:	97fffcd3 	bl	ffffffff40033128 <iput>
        return 0;
ffffffff40033de0:	d2800000 	mov	x0, #0x0                   	// #0
ffffffff40033de4:	14000002 	b	ffffffff40033dec <namex+0x124>
    }

    return ip;
ffffffff40033de8:	f9401fe0 	ldr	x0, [sp, #56]
}
ffffffff40033dec:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff40033df0:	d65f03c0 	ret

ffffffff40033df4 <namei>:

struct inode* namei (char *path)
{
ffffffff40033df4:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40033df8:	910003fd 	mov	x29, sp
ffffffff40033dfc:	f9000fe0 	str	x0, [sp, #24]
    char name[DIRSIZ];
    return namex(path, 0, name);
ffffffff40033e00:	910083e0 	add	x0, sp, #0x20
ffffffff40033e04:	aa0003e2 	mov	x2, x0
ffffffff40033e08:	52800001 	mov	w1, #0x0                   	// #0
ffffffff40033e0c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033e10:	97ffffae 	bl	ffffffff40033cc8 <namex>
}
ffffffff40033e14:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff40033e18:	d65f03c0 	ret

ffffffff40033e1c <nameiparent>:

struct inode* nameiparent (char *path, char *name)
{
ffffffff40033e1c:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40033e20:	910003fd 	mov	x29, sp
ffffffff40033e24:	f9000fe0 	str	x0, [sp, #24]
ffffffff40033e28:	f9000be1 	str	x1, [sp, #16]
    return namex(path, 1, name);
ffffffff40033e2c:	f9400be2 	ldr	x2, [sp, #16]
ffffffff40033e30:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40033e34:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033e38:	97ffffa4 	bl	ffffffff40033cc8 <namex>
}
ffffffff40033e3c:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40033e40:	d65f03c0 	ret

ffffffff40033e44 <initlog>:
struct log log;

static void recover_from_log(void);

void initlog(void)
{
ffffffff40033e44:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40033e48:	910003fd 	mov	x29, sp

    if (sizeof(struct logheader) >= BSIZE) {
        panic("initlog: too big logheader");
    }

    initlock(&log.lock, "log");
ffffffff40033e4c:	90000040 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40033e50:	911be001 	add	x1, x0, #0x6f8
ffffffff40033e54:	90000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40033e58:	91336000 	add	x0, x0, #0xcd8
ffffffff40033e5c:	9400077d 	bl	ffffffff40035c50 <initlock>
    readsb(ROOTDEV, &sb);
ffffffff40033e60:	910043e0 	add	x0, sp, #0x10
ffffffff40033e64:	aa0003e1 	mov	x1, x0
ffffffff40033e68:	52800020 	mov	w0, #0x1                   	// #1
ffffffff40033e6c:	97fffa6e 	bl	ffffffff40032824 <readsb>
    log.start = sb.size - sb.nlog;
ffffffff40033e70:	b94013e1 	ldr	w1, [sp, #16]
ffffffff40033e74:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40033e78:	4b000020 	sub	w0, w1, w0
ffffffff40033e7c:	2a0003e1 	mov	w1, w0
ffffffff40033e80:	90000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40033e84:	91336000 	add	x0, x0, #0xcd8
ffffffff40033e88:	b9004001 	str	w1, [x0, #64]
    log.size = sb.nlog;
ffffffff40033e8c:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40033e90:	2a0003e1 	mov	w1, w0
ffffffff40033e94:	90000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40033e98:	91336000 	add	x0, x0, #0xcd8
ffffffff40033e9c:	b9004401 	str	w1, [x0, #68]
    log.dev = ROOTDEV;
ffffffff40033ea0:	90000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40033ea4:	91336000 	add	x0, x0, #0xcd8
ffffffff40033ea8:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40033eac:	b9004c01 	str	w1, [x0, #76]
    recover_from_log();
ffffffff40033eb0:	940000a4 	bl	ffffffff40034140 <recover_from_log>
}
ffffffff40033eb4:	d503201f 	nop
ffffffff40033eb8:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40033ebc:	d65f03c0 	ret

ffffffff40033ec0 <install_trans>:

// Copy committed blocks from log to their home location
static void install_trans(void)
{
ffffffff40033ec0:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40033ec4:	910003fd 	mov	x29, sp
    int tail;
    struct buf *lbuf;
    struct buf *dbuf;

    for (tail = 0; tail < log.lh.n; tail++) {
ffffffff40033ec8:	b9002fff 	str	wzr, [sp, #44]
ffffffff40033ecc:	1400002f 	b	ffffffff40033f88 <install_trans+0xc8>
        lbuf = bread(log.dev, log.start+tail+1); // read log block
ffffffff40033ed0:	90000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40033ed4:	91336000 	add	x0, x0, #0xcd8
ffffffff40033ed8:	b9404c00 	ldr	w0, [x0, #76]
ffffffff40033edc:	2a0003e2 	mov	w2, w0
ffffffff40033ee0:	90000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40033ee4:	91336000 	add	x0, x0, #0xcd8
ffffffff40033ee8:	b9404001 	ldr	w1, [x0, #64]
ffffffff40033eec:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40033ef0:	0b000020 	add	w0, w1, w0
ffffffff40033ef4:	11000400 	add	w0, w0, #0x1
ffffffff40033ef8:	2a0003e1 	mov	w1, w0
ffffffff40033efc:	2a0203e0 	mov	w0, w2
ffffffff40033f00:	97fff2ad 	bl	ffffffff400309b4 <bread>
ffffffff40033f04:	f90013e0 	str	x0, [sp, #32]
        dbuf = bread(log.dev, log.lh.sector[tail]); // read dst
ffffffff40033f08:	90000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40033f0c:	91336000 	add	x0, x0, #0xcd8
ffffffff40033f10:	b9404c00 	ldr	w0, [x0, #76]
ffffffff40033f14:	2a0003e2 	mov	w2, w0
ffffffff40033f18:	90000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40033f1c:	91336001 	add	x1, x0, #0xcd8
ffffffff40033f20:	b9802fe0 	ldrsw	x0, [sp, #44]
ffffffff40033f24:	91005000 	add	x0, x0, #0x14
ffffffff40033f28:	d37ef400 	lsl	x0, x0, #2
ffffffff40033f2c:	8b000020 	add	x0, x1, x0
ffffffff40033f30:	b9400400 	ldr	w0, [x0, #4]
ffffffff40033f34:	2a0003e1 	mov	w1, w0
ffffffff40033f38:	2a0203e0 	mov	w0, w2
ffffffff40033f3c:	97fff29e 	bl	ffffffff400309b4 <bread>
ffffffff40033f40:	f9000fe0 	str	x0, [sp, #24]

        memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
ffffffff40033f44:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033f48:	9100a003 	add	x3, x0, #0x28
ffffffff40033f4c:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40033f50:	9100a000 	add	x0, x0, #0x28
ffffffff40033f54:	52804002 	mov	w2, #0x200                 	// #512
ffffffff40033f58:	aa0003e1 	mov	x1, x0
ffffffff40033f5c:	aa0303e0 	mov	x0, x3
ffffffff40033f60:	97fff092 	bl	ffffffff400301a8 <memmove>

        bwrite(dbuf);  // write dst to disk
ffffffff40033f64:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033f68:	97fff2a5 	bl	ffffffff400309fc <bwrite>
        brelse(lbuf);
ffffffff40033f6c:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40033f70:	97fff2b8 	bl	ffffffff40030a50 <brelse>
        brelse(dbuf);
ffffffff40033f74:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033f78:	97fff2b6 	bl	ffffffff40030a50 <brelse>
    for (tail = 0; tail < log.lh.n; tail++) {
ffffffff40033f7c:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40033f80:	11000400 	add	w0, w0, #0x1
ffffffff40033f84:	b9002fe0 	str	w0, [sp, #44]
ffffffff40033f88:	90000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40033f8c:	91336000 	add	x0, x0, #0xcd8
ffffffff40033f90:	b9405000 	ldr	w0, [x0, #80]
ffffffff40033f94:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff40033f98:	6b00003f 	cmp	w1, w0
ffffffff40033f9c:	54fff9ab 	b.lt	ffffffff40033ed0 <install_trans+0x10>  // b.tstop
    }
}
ffffffff40033fa0:	d503201f 	nop
ffffffff40033fa4:	d503201f 	nop
ffffffff40033fa8:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff40033fac:	d65f03c0 	ret

ffffffff40033fb0 <read_head>:

// Read the log header from disk into the in-memory log header
static void read_head(void)
{
ffffffff40033fb0:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40033fb4:	910003fd 	mov	x29, sp
    struct buf *buf;
    struct logheader *lh;
    int i;

    buf = bread(log.dev, log.start);
ffffffff40033fb8:	90000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40033fbc:	91336000 	add	x0, x0, #0xcd8
ffffffff40033fc0:	b9404c00 	ldr	w0, [x0, #76]
ffffffff40033fc4:	2a0003e2 	mov	w2, w0
ffffffff40033fc8:	90000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40033fcc:	91336000 	add	x0, x0, #0xcd8
ffffffff40033fd0:	b9404000 	ldr	w0, [x0, #64]
ffffffff40033fd4:	2a0003e1 	mov	w1, w0
ffffffff40033fd8:	2a0203e0 	mov	w0, w2
ffffffff40033fdc:	97fff276 	bl	ffffffff400309b4 <bread>
ffffffff40033fe0:	f90013e0 	str	x0, [sp, #32]
    lh = (struct logheader *) (buf->data);
ffffffff40033fe4:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40033fe8:	9100a000 	add	x0, x0, #0x28
ffffffff40033fec:	f9000fe0 	str	x0, [sp, #24]
    log.lh.n = lh->n;
ffffffff40033ff0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40033ff4:	b9400001 	ldr	w1, [x0]
ffffffff40033ff8:	90000460 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40033ffc:	91336000 	add	x0, x0, #0xcd8
ffffffff40034000:	b9005001 	str	w1, [x0, #80]

    for (i = 0; i < log.lh.n; i++) {
ffffffff40034004:	b9002fff 	str	wzr, [sp, #44]
ffffffff40034008:	14000010 	b	ffffffff40034048 <read_head+0x98>
        log.lh.sector[i] = lh->sector[i];
ffffffff4003400c:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40034010:	b9802fe0 	ldrsw	x0, [sp, #44]
ffffffff40034014:	d37ef400 	lsl	x0, x0, #2
ffffffff40034018:	8b000020 	add	x0, x1, x0
ffffffff4003401c:	b9400401 	ldr	w1, [x0, #4]
ffffffff40034020:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034024:	91336002 	add	x2, x0, #0xcd8
ffffffff40034028:	b9802fe0 	ldrsw	x0, [sp, #44]
ffffffff4003402c:	91005000 	add	x0, x0, #0x14
ffffffff40034030:	d37ef400 	lsl	x0, x0, #2
ffffffff40034034:	8b000040 	add	x0, x2, x0
ffffffff40034038:	b9000401 	str	w1, [x0, #4]
    for (i = 0; i < log.lh.n; i++) {
ffffffff4003403c:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40034040:	11000400 	add	w0, w0, #0x1
ffffffff40034044:	b9002fe0 	str	w0, [sp, #44]
ffffffff40034048:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff4003404c:	91336000 	add	x0, x0, #0xcd8
ffffffff40034050:	b9405000 	ldr	w0, [x0, #80]
ffffffff40034054:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff40034058:	6b00003f 	cmp	w1, w0
ffffffff4003405c:	54fffd8b 	b.lt	ffffffff4003400c <read_head+0x5c>  // b.tstop
    }

    brelse(buf);
ffffffff40034060:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40034064:	97fff27b 	bl	ffffffff40030a50 <brelse>
}
ffffffff40034068:	d503201f 	nop
ffffffff4003406c:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff40034070:	d65f03c0 	ret

ffffffff40034074 <write_head>:

// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void write_head(void)
{
ffffffff40034074:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40034078:	910003fd 	mov	x29, sp
    struct buf *buf;
    struct logheader *hb;
    int i;

    buf = bread(log.dev, log.start);
ffffffff4003407c:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034080:	91336000 	add	x0, x0, #0xcd8
ffffffff40034084:	b9404c00 	ldr	w0, [x0, #76]
ffffffff40034088:	2a0003e2 	mov	w2, w0
ffffffff4003408c:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034090:	91336000 	add	x0, x0, #0xcd8
ffffffff40034094:	b9404000 	ldr	w0, [x0, #64]
ffffffff40034098:	2a0003e1 	mov	w1, w0
ffffffff4003409c:	2a0203e0 	mov	w0, w2
ffffffff400340a0:	97fff245 	bl	ffffffff400309b4 <bread>
ffffffff400340a4:	f90013e0 	str	x0, [sp, #32]
    hb = (struct logheader *) (buf->data);
ffffffff400340a8:	f94013e0 	ldr	x0, [sp, #32]
ffffffff400340ac:	9100a000 	add	x0, x0, #0x28
ffffffff400340b0:	f9000fe0 	str	x0, [sp, #24]

    hb->n = log.lh.n;
ffffffff400340b4:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff400340b8:	91336000 	add	x0, x0, #0xcd8
ffffffff400340bc:	b9405001 	ldr	w1, [x0, #80]
ffffffff400340c0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400340c4:	b9000001 	str	w1, [x0]

    for (i = 0; i < log.lh.n; i++) {
ffffffff400340c8:	b9002fff 	str	wzr, [sp, #44]
ffffffff400340cc:	14000010 	b	ffffffff4003410c <write_head+0x98>
        hb->sector[i] = log.lh.sector[i];
ffffffff400340d0:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff400340d4:	91336001 	add	x1, x0, #0xcd8
ffffffff400340d8:	b9802fe0 	ldrsw	x0, [sp, #44]
ffffffff400340dc:	91005000 	add	x0, x0, #0x14
ffffffff400340e0:	d37ef400 	lsl	x0, x0, #2
ffffffff400340e4:	8b000020 	add	x0, x1, x0
ffffffff400340e8:	b9400401 	ldr	w1, [x0, #4]
ffffffff400340ec:	f9400fe2 	ldr	x2, [sp, #24]
ffffffff400340f0:	b9802fe0 	ldrsw	x0, [sp, #44]
ffffffff400340f4:	d37ef400 	lsl	x0, x0, #2
ffffffff400340f8:	8b000040 	add	x0, x2, x0
ffffffff400340fc:	b9000401 	str	w1, [x0, #4]
    for (i = 0; i < log.lh.n; i++) {
ffffffff40034100:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40034104:	11000400 	add	w0, w0, #0x1
ffffffff40034108:	b9002fe0 	str	w0, [sp, #44]
ffffffff4003410c:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034110:	91336000 	add	x0, x0, #0xcd8
ffffffff40034114:	b9405000 	ldr	w0, [x0, #80]
ffffffff40034118:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff4003411c:	6b00003f 	cmp	w1, w0
ffffffff40034120:	54fffd8b 	b.lt	ffffffff400340d0 <write_head+0x5c>  // b.tstop
    }

    bwrite(buf);
ffffffff40034124:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40034128:	97fff235 	bl	ffffffff400309fc <bwrite>
    brelse(buf);
ffffffff4003412c:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40034130:	97fff248 	bl	ffffffff40030a50 <brelse>
}
ffffffff40034134:	d503201f 	nop
ffffffff40034138:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff4003413c:	d65f03c0 	ret

ffffffff40034140 <recover_from_log>:

static void recover_from_log(void)
{
ffffffff40034140:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff40034144:	910003fd 	mov	x29, sp
    read_head();
ffffffff40034148:	97ffff9a 	bl	ffffffff40033fb0 <read_head>
    install_trans(); // if committed, copy from log to disk
ffffffff4003414c:	97ffff5d 	bl	ffffffff40033ec0 <install_trans>
    log.lh.n = 0;
ffffffff40034150:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034154:	91336000 	add	x0, x0, #0xcd8
ffffffff40034158:	b900501f 	str	wzr, [x0, #80]
    write_head(); // clear the log
ffffffff4003415c:	97ffffc6 	bl	ffffffff40034074 <write_head>
}
ffffffff40034160:	d503201f 	nop
ffffffff40034164:	a8c17bfd 	ldp	x29, x30, [sp], #16
ffffffff40034168:	d65f03c0 	ret

ffffffff4003416c <begin_trans>:

void begin_trans(void)
{
ffffffff4003416c:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff40034170:	910003fd 	mov	x29, sp
    acquire(&log.lock);
ffffffff40034174:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034178:	91336000 	add	x0, x0, #0xcd8
ffffffff4003417c:	940006c2 	bl	ffffffff40035c84 <acquire>

    while (log.busy) {
ffffffff40034180:	14000006 	b	ffffffff40034198 <begin_trans+0x2c>
        sleep(&log, &log.lock);
ffffffff40034184:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034188:	91336001 	add	x1, x0, #0xcd8
ffffffff4003418c:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034190:	91336000 	add	x0, x0, #0xcd8
ffffffff40034194:	940005e5 	bl	ffffffff40035928 <sleep>
    while (log.busy) {
ffffffff40034198:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff4003419c:	91336000 	add	x0, x0, #0xcd8
ffffffff400341a0:	b9404800 	ldr	w0, [x0, #72]
ffffffff400341a4:	7100001f 	cmp	w0, #0x0
ffffffff400341a8:	54fffee1 	b.ne	ffffffff40034184 <begin_trans+0x18>  // b.any
    }

    log.busy = 1;
ffffffff400341ac:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff400341b0:	91336000 	add	x0, x0, #0xcd8
ffffffff400341b4:	52800021 	mov	w1, #0x1                   	// #1
ffffffff400341b8:	b9004801 	str	w1, [x0, #72]
    release(&log.lock);
ffffffff400341bc:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff400341c0:	91336000 	add	x0, x0, #0xcd8
ffffffff400341c4:	940006ba 	bl	ffffffff40035cac <release>
}
ffffffff400341c8:	d503201f 	nop
ffffffff400341cc:	a8c17bfd 	ldp	x29, x30, [sp], #16
ffffffff400341d0:	d65f03c0 	ret

ffffffff400341d4 <commit_trans>:

void commit_trans(void)
{
ffffffff400341d4:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff400341d8:	910003fd 	mov	x29, sp
    if (log.lh.n > 0) {
ffffffff400341dc:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff400341e0:	91336000 	add	x0, x0, #0xcd8
ffffffff400341e4:	b9405000 	ldr	w0, [x0, #80]
ffffffff400341e8:	7100001f 	cmp	w0, #0x0
ffffffff400341ec:	540000ed 	b.le	ffffffff40034208 <commit_trans+0x34>
        write_head();    // Write header to disk -- the real commit
ffffffff400341f0:	97ffffa1 	bl	ffffffff40034074 <write_head>
        install_trans(); // Now install writes to home locations
ffffffff400341f4:	97ffff33 	bl	ffffffff40033ec0 <install_trans>
        log.lh.n = 0;
ffffffff400341f8:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff400341fc:	91336000 	add	x0, x0, #0xcd8
ffffffff40034200:	b900501f 	str	wzr, [x0, #80]
        write_head();    // Erase the transaction from the log
ffffffff40034204:	97ffff9c 	bl	ffffffff40034074 <write_head>
    }

    acquire(&log.lock);
ffffffff40034208:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff4003420c:	91336000 	add	x0, x0, #0xcd8
ffffffff40034210:	9400069d 	bl	ffffffff40035c84 <acquire>
    log.busy = 0;
ffffffff40034214:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034218:	91336000 	add	x0, x0, #0xcd8
ffffffff4003421c:	b900481f 	str	wzr, [x0, #72]
    wakeup(&log);
ffffffff40034220:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034224:	91336000 	add	x0, x0, #0xcd8
ffffffff40034228:	94000616 	bl	ffffffff40035a80 <wakeup>
    release(&log.lock);
ffffffff4003422c:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034230:	91336000 	add	x0, x0, #0xcd8
ffffffff40034234:	9400069e 	bl	ffffffff40035cac <release>
}
ffffffff40034238:	d503201f 	nop
ffffffff4003423c:	a8c17bfd 	ldp	x29, x30, [sp], #16
ffffffff40034240:	d65f03c0 	ret

ffffffff40034244 <log_write>:
//   bp = bread(...)
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void log_write(struct buf *b)
{
ffffffff40034244:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40034248:	910003fd 	mov	x29, sp
ffffffff4003424c:	f9000fe0 	str	x0, [sp, #24]
    struct buf *lbuf;
    int i;

    if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1) {
ffffffff40034250:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034254:	91336000 	add	x0, x0, #0xcd8
ffffffff40034258:	b9405000 	ldr	w0, [x0, #80]
ffffffff4003425c:	7100241f 	cmp	w0, #0x9
ffffffff40034260:	5400014c 	b.gt	ffffffff40034288 <log_write+0x44>
ffffffff40034264:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034268:	91336000 	add	x0, x0, #0xcd8
ffffffff4003426c:	b9405001 	ldr	w1, [x0, #80]
ffffffff40034270:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034274:	91336000 	add	x0, x0, #0xcd8
ffffffff40034278:	b9404400 	ldr	w0, [x0, #68]
ffffffff4003427c:	51000400 	sub	w0, w0, #0x1
ffffffff40034280:	6b00003f 	cmp	w1, w0
ffffffff40034284:	5400008b 	b.lt	ffffffff40034294 <log_write+0x50>  // b.tstop
        panic("too big a transaction");
ffffffff40034288:	f0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003428c:	911c0000 	add	x0, x0, #0x700
ffffffff40034290:	97fff58e 	bl	ffffffff400318c8 <panic>
    }

    if (!log.busy) {
ffffffff40034294:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034298:	91336000 	add	x0, x0, #0xcd8
ffffffff4003429c:	b9404800 	ldr	w0, [x0, #72]
ffffffff400342a0:	7100001f 	cmp	w0, #0x0
ffffffff400342a4:	54000081 	b.ne	ffffffff400342b4 <log_write+0x70>  // b.any
        panic("write outside of trans");
ffffffff400342a8:	f0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400342ac:	911c6000 	add	x0, x0, #0x718
ffffffff400342b0:	97fff586 	bl	ffffffff400318c8 <panic>
    }

    for (i = 0; i < log.lh.n; i++) {
ffffffff400342b4:	b9002fff 	str	wzr, [sp, #44]
ffffffff400342b8:	14000010 	b	ffffffff400342f8 <log_write+0xb4>
        if (log.lh.sector[i] == b->sector) { // log absorbtion?
ffffffff400342bc:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff400342c0:	91336001 	add	x1, x0, #0xcd8
ffffffff400342c4:	b9802fe0 	ldrsw	x0, [sp, #44]
ffffffff400342c8:	91005000 	add	x0, x0, #0x14
ffffffff400342cc:	d37ef400 	lsl	x0, x0, #2
ffffffff400342d0:	8b000020 	add	x0, x1, x0
ffffffff400342d4:	b9400400 	ldr	w0, [x0, #4]
ffffffff400342d8:	2a0003e1 	mov	w1, w0
ffffffff400342dc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400342e0:	b9400800 	ldr	w0, [x0, #8]
ffffffff400342e4:	6b00003f 	cmp	w1, w0
ffffffff400342e8:	54000160 	b.eq	ffffffff40034314 <log_write+0xd0>  // b.none
    for (i = 0; i < log.lh.n; i++) {
ffffffff400342ec:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff400342f0:	11000400 	add	w0, w0, #0x1
ffffffff400342f4:	b9002fe0 	str	w0, [sp, #44]
ffffffff400342f8:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff400342fc:	91336000 	add	x0, x0, #0xcd8
ffffffff40034300:	b9405000 	ldr	w0, [x0, #80]
ffffffff40034304:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff40034308:	6b00003f 	cmp	w1, w0
ffffffff4003430c:	54fffd8b 	b.lt	ffffffff400342bc <log_write+0x78>  // b.tstop
ffffffff40034310:	14000002 	b	ffffffff40034318 <log_write+0xd4>
            break;
ffffffff40034314:	d503201f 	nop
        }
    }

    log.lh.sector[i] = b->sector;
ffffffff40034318:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003431c:	b9400800 	ldr	w0, [x0, #8]
ffffffff40034320:	2a0003e2 	mov	w2, w0
ffffffff40034324:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034328:	91336001 	add	x1, x0, #0xcd8
ffffffff4003432c:	b9802fe0 	ldrsw	x0, [sp, #44]
ffffffff40034330:	91005000 	add	x0, x0, #0x14
ffffffff40034334:	d37ef400 	lsl	x0, x0, #2
ffffffff40034338:	8b000020 	add	x0, x1, x0
ffffffff4003433c:	b9000402 	str	w2, [x0, #4]
    lbuf = bread(b->dev, log.start+i+1);
ffffffff40034340:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034344:	b9400402 	ldr	w2, [x0, #4]
ffffffff40034348:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff4003434c:	91336000 	add	x0, x0, #0xcd8
ffffffff40034350:	b9404001 	ldr	w1, [x0, #64]
ffffffff40034354:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40034358:	0b000020 	add	w0, w1, w0
ffffffff4003435c:	11000400 	add	w0, w0, #0x1
ffffffff40034360:	2a0003e1 	mov	w1, w0
ffffffff40034364:	2a0203e0 	mov	w0, w2
ffffffff40034368:	97fff193 	bl	ffffffff400309b4 <bread>
ffffffff4003436c:	f90013e0 	str	x0, [sp, #32]

    memmove(lbuf->data, b->data, BSIZE);
ffffffff40034370:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40034374:	9100a003 	add	x3, x0, #0x28
ffffffff40034378:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003437c:	9100a000 	add	x0, x0, #0x28
ffffffff40034380:	52804002 	mov	w2, #0x200                 	// #512
ffffffff40034384:	aa0003e1 	mov	x1, x0
ffffffff40034388:	aa0303e0 	mov	x0, x3
ffffffff4003438c:	97ffef87 	bl	ffffffff400301a8 <memmove>
    bwrite(lbuf);
ffffffff40034390:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40034394:	97fff19a 	bl	ffffffff400309fc <bwrite>
    brelse(lbuf);
ffffffff40034398:	f94013e0 	ldr	x0, [sp, #32]
ffffffff4003439c:	97fff1ad 	bl	ffffffff40030a50 <brelse>

    if (i == log.lh.n) {
ffffffff400343a0:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff400343a4:	91336000 	add	x0, x0, #0xcd8
ffffffff400343a8:	b9405000 	ldr	w0, [x0, #80]
ffffffff400343ac:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff400343b0:	6b00003f 	cmp	w1, w0
ffffffff400343b4:	54000101 	b.ne	ffffffff400343d4 <log_write+0x190>  // b.any
        log.lh.n++;
ffffffff400343b8:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff400343bc:	91336000 	add	x0, x0, #0xcd8
ffffffff400343c0:	b9405000 	ldr	w0, [x0, #80]
ffffffff400343c4:	11000401 	add	w1, w0, #0x1
ffffffff400343c8:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff400343cc:	91336000 	add	x0, x0, #0xcd8
ffffffff400343d0:	b9005001 	str	w1, [x0, #80]
    }

    b->flags |= B_DIRTY; // XXX prevent eviction
ffffffff400343d4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400343d8:	b9400000 	ldr	w0, [x0]
ffffffff400343dc:	321e0001 	orr	w1, w0, #0x4
ffffffff400343e0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400343e4:	b9000001 	str	w1, [x0]
}
ffffffff400343e8:	d503201f 	nop
ffffffff400343ec:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff400343f0:	d65f03c0 	ret

ffffffff400343f4 <kmain>:
struct cpu	*cpu;

#define MB (1024*1024)

void kmain (void)
{
ffffffff400343f4:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff400343f8:	910003fd 	mov	x29, sp
    cpu = &cpus[0];
ffffffff400343fc:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034400:	913b6000 	add	x0, x0, #0xed8
ffffffff40034404:	f0000441 	adrp	x1, ffffffff400bf000 <icache+0x308>
ffffffff40034408:	91356021 	add	x1, x1, #0xd58
ffffffff4003440c:	f9000001 	str	x1, [x0]

    uart_init (P2V(UART0));
ffffffff40034410:	929fffe0 	mov	x0, #0xffffffffffff0000    	// #-65536
ffffffff40034414:	f2a12000 	movk	x0, #0x900, lsl #16
ffffffff40034418:	940019bf 	bl	ffffffff4003ab14 <uart_init>

    init_vmm ();
ffffffff4003441c:	94001651 	bl	ffffffff40039d60 <init_vmm>
    kpt_freerange (align_up(&end, PT_SZ), P2V_WO(INIT_KERNMAP));
ffffffff40034420:	90000580 	adrp	x0, ffffffff400e4000 <end>
ffffffff40034424:	91000000 	add	x0, x0, #0x0
ffffffff40034428:	913ffc00 	add	x0, x0, #0xfff
ffffffff4003442c:	9274cc00 	and	x0, x0, #0xfffffffffffff000
ffffffff40034430:	929fffe1 	mov	x1, #0xffffffffffff0000    	// #-65536
ffffffff40034434:	f2a80401 	movk	x1, #0x4020, lsl #16
ffffffff40034438:	9400167b 	bl	ffffffff40039e24 <kpt_freerange>
    paging_init (INIT_KERNMAP, PHYSTOP);
ffffffff4003443c:	d2a90001 	mov	x1, #0x48000000            	// #1207959552
ffffffff40034440:	d2a80400 	mov	x0, #0x40200000            	// #1075838976
ffffffff40034444:	94001941 	bl	ffffffff4003a948 <paging_init>

    kmem_init ();
ffffffff40034448:	97fff1f4 	bl	ffffffff40030c18 <kmem_init>
    kmem_init2(P2V(INIT_KERNMAP), P2V(PHYSTOP));
ffffffff4003444c:	929fffe1 	mov	x1, #0xffffffffffff0000    	// #-65536
ffffffff40034450:	f2a90001 	movk	x1, #0x4800, lsl #16
ffffffff40034454:	929fffe0 	mov	x0, #0xffffffffffff0000    	// #-65536
ffffffff40034458:	f2a80400 	movk	x0, #0x4020, lsl #16
ffffffff4003445c:	97fff1f9 	bl	ffffffff40030c40 <kmem_init2>

    trap_init ();				// vector table and stacks for models
ffffffff40034460:	94000be9 	bl	ffffffff40037404 <trap_init>
   
    gic_init(P2V(VIC_BASE));			// arm v2 gic init
ffffffff40034464:	929fffe0 	mov	x0, #0xffffffffffff0000    	// #-65536
ffffffff40034468:	f2a10000 	movk	x0, #0x800, lsl #16
ffffffff4003446c:	94001bce 	bl	ffffffff4003b3a4 <gic_init>
    uart_enable_rx ();				// interrupt for uart
ffffffff40034470:	940019de 	bl	ffffffff4003abe8 <uart_enable_rx>
    consoleinit ();				// console
ffffffff40034474:	97fff661 	bl	ffffffff40031df8 <consoleinit>
    pinit ();					// process (locks)
ffffffff40034478:	94000275 	bl	ffffffff40034e4c <pinit>

    binit ();					// buffer cache
ffffffff4003447c:	97fff0bc 	bl	ffffffff4003076c <binit>
    fileinit ();				// file table
ffffffff40034480:	97fff7b4 	bl	ffffffff40032350 <fileinit>
    iinit ();					// inode cache
ffffffff40034484:	97fff9c4 	bl	ffffffff40032b94 <iinit>
    ideinit ();					// ide (memory block device)
ffffffff40034488:	94000004 	bl	ffffffff40034498 <ideinit>

#ifdef INCLUDE_REMOVED
    timer_init (HZ);				// the timer (ticker)
#endif

    sti ();
ffffffff4003448c:	97fff00e 	bl	ffffffff400304c4 <sti>
    userinit();					// first user process
ffffffff40034490:	940002e1 	bl	ffffffff40035014 <userinit>
    scheduler();				// start running processes
ffffffff40034494:	94000496 	bl	ffffffff400356ec <scheduler>

ffffffff40034498 <ideinit>:
static long disksize;
static uchar *memdisk;

void ideinit(void)
{
    memdisk = _binary_fs_img_start;
ffffffff40034498:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff4003449c:	913ba000 	add	x0, x0, #0xee8
ffffffff400344a0:	90000041 	adrp	x1, ffffffff4003c000 <digits.0>
ffffffff400344a4:	91054021 	add	x1, x1, #0x150
ffffffff400344a8:	f9000001 	str	x1, [x0]
    disksize = (uint64)_binary_fs_img_size/512;
ffffffff400344ac:	90600260 	adrp	x0, 80000 <_binary_fs_img_size>
ffffffff400344b0:	91000000 	add	x0, x0, #0x0
ffffffff400344b4:	d349fc00 	lsr	x0, x0, #9
ffffffff400344b8:	aa0003e1 	mov	x1, x0
ffffffff400344bc:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff400344c0:	913b8000 	add	x0, x0, #0xee0
ffffffff400344c4:	f9000001 	str	x1, [x0]
}
ffffffff400344c8:	d503201f 	nop
ffffffff400344cc:	d65f03c0 	ret

ffffffff400344d0 <ideintr>:

// Interrupt handler.
void ideintr(void)
{
    // no-op
}
ffffffff400344d0:	d503201f 	nop
ffffffff400344d4:	d65f03c0 	ret

ffffffff400344d8 <iderw>:

// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void iderw(struct buf *b)
{
ffffffff400344d8:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff400344dc:	910003fd 	mov	x29, sp
ffffffff400344e0:	f9000fe0 	str	x0, [sp, #24]
    uchar *p;

    if(!(b->flags & B_BUSY)) {
ffffffff400344e4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400344e8:	b9400000 	ldr	w0, [x0]
ffffffff400344ec:	12000000 	and	w0, w0, #0x1
ffffffff400344f0:	7100001f 	cmp	w0, #0x0
ffffffff400344f4:	54000081 	b.ne	ffffffff40034504 <iderw+0x2c>  // b.any
        panic("iderw: buf not busy");
ffffffff400344f8:	f0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400344fc:	911cc000 	add	x0, x0, #0x730
ffffffff40034500:	97fff4f2 	bl	ffffffff400318c8 <panic>
    }

    if((b->flags & (B_VALID|B_DIRTY)) == B_VALID) {
ffffffff40034504:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034508:	b9400000 	ldr	w0, [x0]
ffffffff4003450c:	121f0400 	and	w0, w0, #0x6
ffffffff40034510:	7100081f 	cmp	w0, #0x2
ffffffff40034514:	54000081 	b.ne	ffffffff40034524 <iderw+0x4c>  // b.any
        panic("iderw: nothing to do");
ffffffff40034518:	f0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003451c:	911d2000 	add	x0, x0, #0x748
ffffffff40034520:	97fff4ea 	bl	ffffffff400318c8 <panic>
    }

    if(b->dev != 1) {
ffffffff40034524:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034528:	b9400400 	ldr	w0, [x0, #4]
ffffffff4003452c:	7100041f 	cmp	w0, #0x1
ffffffff40034530:	54000080 	b.eq	ffffffff40034540 <iderw+0x68>  // b.none
        panic("iderw: request not for disk 1");
ffffffff40034534:	f0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40034538:	911d8000 	add	x0, x0, #0x760
ffffffff4003453c:	97fff4e3 	bl	ffffffff400318c8 <panic>
    }

    if(b->sector >= disksize) {
ffffffff40034540:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034544:	b9400800 	ldr	w0, [x0, #8]
ffffffff40034548:	2a0003e1 	mov	w1, w0
ffffffff4003454c:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034550:	913b8000 	add	x0, x0, #0xee0
ffffffff40034554:	f9400000 	ldr	x0, [x0]
ffffffff40034558:	eb00003f 	cmp	x1, x0
ffffffff4003455c:	5400008b 	b.lt	ffffffff4003456c <iderw+0x94>  // b.tstop
        panic("iderw: sector out of range");
ffffffff40034560:	f0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40034564:	911e0000 	add	x0, x0, #0x780
ffffffff40034568:	97fff4d8 	bl	ffffffff400318c8 <panic>
    }

    p = memdisk + b->sector*512;
ffffffff4003456c:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034570:	913ba000 	add	x0, x0, #0xee8
ffffffff40034574:	f9400001 	ldr	x1, [x0]
ffffffff40034578:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003457c:	b9400800 	ldr	w0, [x0, #8]
ffffffff40034580:	53175800 	lsl	w0, w0, #9
ffffffff40034584:	2a0003e0 	mov	w0, w0
ffffffff40034588:	8b000020 	add	x0, x1, x0
ffffffff4003458c:	f90017e0 	str	x0, [sp, #40]

    if(b->flags & B_DIRTY){
ffffffff40034590:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034594:	b9400000 	ldr	w0, [x0]
ffffffff40034598:	121e0000 	and	w0, w0, #0x4
ffffffff4003459c:	7100001f 	cmp	w0, #0x0
ffffffff400345a0:	540001a0 	b.eq	ffffffff400345d4 <iderw+0xfc>  // b.none
        b->flags &= ~B_DIRTY;
ffffffff400345a4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400345a8:	b9400000 	ldr	w0, [x0]
ffffffff400345ac:	121d7801 	and	w1, w0, #0xfffffffb
ffffffff400345b0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400345b4:	b9000001 	str	w1, [x0]
        memmove(p, b->data, 512);
ffffffff400345b8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400345bc:	9100a000 	add	x0, x0, #0x28
ffffffff400345c0:	52804002 	mov	w2, #0x200                 	// #512
ffffffff400345c4:	aa0003e1 	mov	x1, x0
ffffffff400345c8:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400345cc:	97ffeef7 	bl	ffffffff400301a8 <memmove>
ffffffff400345d0:	14000006 	b	ffffffff400345e8 <iderw+0x110>
    } else {
        memmove(b->data, p, 512);
ffffffff400345d4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400345d8:	9100a000 	add	x0, x0, #0x28
ffffffff400345dc:	52804002 	mov	w2, #0x200                 	// #512
ffffffff400345e0:	f94017e1 	ldr	x1, [sp, #40]
ffffffff400345e4:	97ffeef1 	bl	ffffffff400301a8 <memmove>
    }

    b->flags |= B_VALID;
ffffffff400345e8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400345ec:	b9400000 	ldr	w0, [x0]
ffffffff400345f0:	321f0001 	orr	w1, w0, #0x2
ffffffff400345f4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400345f8:	b9000001 	str	w1, [x0]
}
ffffffff400345fc:	d503201f 	nop
ffffffff40034600:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff40034604:	d65f03c0 	ret

ffffffff40034608 <v2p>:
#define INIT_KERN_SZ	0x200000
#define INIT_KERNMAP 	(INIT_KERN_SZ + PHY_START)

#ifndef __ASSEMBLER__

static inline uint64 v2p(void *a) { return ((uint64) (a))  - (uint64)KERNBASE; }
ffffffff40034608:	d10043ff 	sub	sp, sp, #0x10
ffffffff4003460c:	f90007e0 	str	x0, [sp, #8]
ffffffff40034610:	f94007e1 	ldr	x1, [sp, #8]
ffffffff40034614:	d2c00020 	mov	x0, #0x100000000           	// #4294967296
ffffffff40034618:	8b000020 	add	x0, x1, x0
ffffffff4003461c:	910043ff 	add	sp, sp, #0x10
ffffffff40034620:	d65f03c0 	ret

ffffffff40034624 <kinit1>:
// 1. main() calls kinit1() while still using entrypgdir to place just
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void kinit1(void *vstart, void *vend)
{
ffffffff40034624:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40034628:	910003fd 	mov	x29, sp
ffffffff4003462c:	f9000fe0 	str	x0, [sp, #24]
ffffffff40034630:	f9000be1 	str	x1, [sp, #16]
    freerange(vstart, vend);
ffffffff40034634:	f9400be1 	ldr	x1, [sp, #16]
ffffffff40034638:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003463c:	94000012 	bl	ffffffff40034684 <freerange>
}
ffffffff40034640:	d503201f 	nop
ffffffff40034644:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40034648:	d65f03c0 	ret

ffffffff4003464c <kinit2>:

void kinit2(void *vstart, void *vend)
{
ffffffff4003464c:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40034650:	910003fd 	mov	x29, sp
ffffffff40034654:	f9000fe0 	str	x0, [sp, #24]
ffffffff40034658:	f9000be1 	str	x1, [sp, #16]
    freerange(vstart, vend);
ffffffff4003465c:	f9400be1 	ldr	x1, [sp, #16]
ffffffff40034660:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034664:	94000008 	bl	ffffffff40034684 <freerange>
    kmem.use_lock = 1;
ffffffff40034668:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff4003466c:	913bc000 	add	x0, x0, #0xef0
ffffffff40034670:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40034674:	b9004001 	str	w1, [x0, #64]
}
ffffffff40034678:	d503201f 	nop
ffffffff4003467c:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40034680:	d65f03c0 	ret

ffffffff40034684 <freerange>:

void freerange(void *vstart, void *vend)
{
ffffffff40034684:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40034688:	910003fd 	mov	x29, sp
ffffffff4003468c:	f9000fe0 	str	x0, [sp, #24]
ffffffff40034690:	f9000be1 	str	x1, [sp, #16]
    char *p;

    p = (char*)align_up (vstart, PTE_SZ);
ffffffff40034694:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034698:	913ffc00 	add	x0, x0, #0xfff
ffffffff4003469c:	9274cc00 	and	x0, x0, #0xfffffffffffff000
ffffffff400346a0:	f90017e0 	str	x0, [sp, #40]

    for(; p + PTE_SZ <= (char*)vend; p += PTE_SZ) {
ffffffff400346a4:	14000010 	b	ffffffff400346e4 <freerange+0x60>
        page_refcount[PA2IDX(v2p(p))] = 1;
ffffffff400346a8:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400346ac:	97ffffd7 	bl	ffffffff40034608 <v2p>
ffffffff400346b0:	aa0003e1 	mov	x1, x0
ffffffff400346b4:	b26287e0 	mov	x0, #0xffffffffc0000000    	// #-1073741824
ffffffff400346b8:	8b000020 	add	x0, x1, x0
ffffffff400346bc:	d34cfc01 	lsr	x1, x0, #12
ffffffff400346c0:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff400346c4:	913bc000 	add	x0, x0, #0xef0
ffffffff400346c8:	52800022 	mov	w2, #0x1                   	// #1
ffffffff400346cc:	b8217802 	str	w2, [x0, x1, lsl #2]
         kfree_page(p);
ffffffff400346d0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400346d4:	9400000d 	bl	ffffffff40034708 <kfree_page>
    for(; p + PTE_SZ <= (char*)vend; p += PTE_SZ) {
ffffffff400346d8:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400346dc:	91400400 	add	x0, x0, #0x1, lsl #12
ffffffff400346e0:	f90017e0 	str	x0, [sp, #40]
ffffffff400346e4:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400346e8:	91400400 	add	x0, x0, #0x1, lsl #12
ffffffff400346ec:	f9400be1 	ldr	x1, [sp, #16]
ffffffff400346f0:	eb00003f 	cmp	x1, x0
ffffffff400346f4:	54fffda2 	b.cs	ffffffff400346a8 <freerange+0x24>  // b.hs, b.nlast
    }
       
    
}
ffffffff400346f8:	d503201f 	nop
ffffffff400346fc:	d503201f 	nop
ffffffff40034700:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff40034704:	d65f03c0 	ret

ffffffff40034708 <kfree_page>:
// Free the page of physical memory pointed at by v,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void kfree_page(char *v)
{
ffffffff40034708:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff4003470c:	910003fd 	mov	x29, sp
ffffffff40034710:	f9000fe0 	str	x0, [sp, #24]
    
    struct run *r;

    if((uint64)v % PTE_SZ || v < end || v2p(v) >= PHYSTOP) {
ffffffff40034714:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034718:	92402c00 	and	x0, x0, #0xfff
ffffffff4003471c:	f100001f 	cmp	x0, #0x0
ffffffff40034720:	54000181 	b.ne	ffffffff40034750 <kfree_page+0x48>  // b.any
ffffffff40034724:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40034728:	90000580 	adrp	x0, ffffffff400e4000 <end>
ffffffff4003472c:	91000000 	add	x0, x0, #0x0
ffffffff40034730:	eb00003f 	cmp	x1, x0
ffffffff40034734:	540000e3 	b.cc	ffffffff40034750 <kfree_page+0x48>  // b.lo, b.ul, b.last
ffffffff40034738:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003473c:	97ffffb3 	bl	ffffffff40034608 <v2p>
ffffffff40034740:	aa0003e1 	mov	x1, x0
ffffffff40034744:	12b70000 	mov	w0, #0x47ffffff            	// #1207959551
ffffffff40034748:	eb00003f 	cmp	x1, x0
ffffffff4003474c:	54000109 	b.ls	ffffffff4003476c <kfree_page+0x64>  // b.plast
        cprintf("kfree_page(0x%x)\n", v);
ffffffff40034750:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40034754:	f0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40034758:	911e8000 	add	x0, x0, #0x7a0
ffffffff4003475c:	97fff3c6 	bl	ffffffff40031674 <cprintf>
        panic("kfree_page");
ffffffff40034760:	f0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40034764:	911ee000 	add	x0, x0, #0x7b8
ffffffff40034768:	97fff458 	bl	ffffffff400318c8 <panic>
    }

    // Fill with junk to catch dangling refs.
    //memset(v, 0x00, PG_SIZE);

    if(kmem.use_lock) {
ffffffff4003476c:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40034770:	913bc000 	add	x0, x0, #0xef0
ffffffff40034774:	b9404000 	ldr	w0, [x0, #64]
ffffffff40034778:	7100001f 	cmp	w0, #0x0
ffffffff4003477c:	54000080 	b.eq	ffffffff4003478c <kfree_page+0x84>  // b.none
        acquire(&kmem.lock);
ffffffff40034780:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40034784:	913bc000 	add	x0, x0, #0xef0
ffffffff40034788:	9400053f 	bl	ffffffff40035c84 <acquire>
    }

    page_refcount[PA2IDX(v2p(v))] -= 1;
ffffffff4003478c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034790:	97ffff9e 	bl	ffffffff40034608 <v2p>
ffffffff40034794:	aa0003e1 	mov	x1, x0
ffffffff40034798:	b26287e0 	mov	x0, #0xffffffffc0000000    	// #-1073741824
ffffffff4003479c:	8b000020 	add	x0, x1, x0
ffffffff400347a0:	d34cfc00 	lsr	x0, x0, #12
ffffffff400347a4:	f0000441 	adrp	x1, ffffffff400bf000 <icache+0x308>
ffffffff400347a8:	913bc021 	add	x1, x1, #0xef0
ffffffff400347ac:	b8607821 	ldr	w1, [x1, x0, lsl #2]
ffffffff400347b0:	51000422 	sub	w2, w1, #0x1
ffffffff400347b4:	f0000441 	adrp	x1, ffffffff400bf000 <icache+0x308>
ffffffff400347b8:	913bc021 	add	x1, x1, #0xef0
ffffffff400347bc:	b8207822 	str	w2, [x1, x0, lsl #2]

    r = (struct run*)v;
ffffffff400347c0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400347c4:	f90017e0 	str	x0, [sp, #40]
    if(page_refcount[PA2IDX(v2p(v))] == 0){
ffffffff400347c8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400347cc:	97ffff8f 	bl	ffffffff40034608 <v2p>
ffffffff400347d0:	aa0003e1 	mov	x1, x0
ffffffff400347d4:	b26287e0 	mov	x0, #0xffffffffc0000000    	// #-1073741824
ffffffff400347d8:	8b000020 	add	x0, x1, x0
ffffffff400347dc:	d34cfc01 	lsr	x1, x0, #12
ffffffff400347e0:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff400347e4:	913bc000 	add	x0, x0, #0xef0
ffffffff400347e8:	b8617800 	ldr	w0, [x0, x1, lsl #2]
ffffffff400347ec:	7100001f 	cmp	w0, #0x0
ffffffff400347f0:	540000c1 	b.ne	ffffffff40034808 <kfree_page+0x100>  // b.any
    r->next = kmem.freelist;
ffffffff400347f4:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400347f8:	913bc000 	add	x0, x0, #0xef0
ffffffff400347fc:	f9402401 	ldr	x1, [x0, #72]
ffffffff40034800:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034804:	f9000001 	str	x1, [x0]
    }
    if(page_refcount[PA2IDX(v2p(v))] > 0){
ffffffff40034808:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003480c:	97ffff7f 	bl	ffffffff40034608 <v2p>
ffffffff40034810:	aa0003e1 	mov	x1, x0
ffffffff40034814:	b26287e0 	mov	x0, #0xffffffffc0000000    	// #-1073741824
ffffffff40034818:	8b000020 	add	x0, x1, x0
ffffffff4003481c:	d34cfc01 	lsr	x1, x0, #12
ffffffff40034820:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034824:	913bc000 	add	x0, x0, #0xef0
ffffffff40034828:	b8617800 	ldr	w0, [x0, x1, lsl #2]
ffffffff4003482c:	7100001f 	cmp	w0, #0x0
ffffffff40034830:	5400014d 	b.le	ffffffff40034858 <kfree_page+0x150>
        if(kmem.use_lock) {
ffffffff40034834:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40034838:	913bc000 	add	x0, x0, #0xef0
ffffffff4003483c:	b9404000 	ldr	w0, [x0, #64]
ffffffff40034840:	7100001f 	cmp	w0, #0x0
ffffffff40034844:	54000240 	b.eq	ffffffff4003488c <kfree_page+0x184>  // b.none
            release(&kmem.lock);
ffffffff40034848:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff4003484c:	913bc000 	add	x0, x0, #0xef0
ffffffff40034850:	94000517 	bl	ffffffff40035cac <release>
        }
        return;
ffffffff40034854:	1400000e 	b	ffffffff4003488c <kfree_page+0x184>
    }
    kmem.freelist = r;
ffffffff40034858:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff4003485c:	913bc000 	add	x0, x0, #0xef0
ffffffff40034860:	f94017e1 	ldr	x1, [sp, #40]
ffffffff40034864:	f9002401 	str	x1, [x0, #72]

    if(kmem.use_lock) {
ffffffff40034868:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff4003486c:	913bc000 	add	x0, x0, #0xef0
ffffffff40034870:	b9404000 	ldr	w0, [x0, #64]
ffffffff40034874:	7100001f 	cmp	w0, #0x0
ffffffff40034878:	540000c0 	b.eq	ffffffff40034890 <kfree_page+0x188>  // b.none
        release(&kmem.lock);
ffffffff4003487c:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40034880:	913bc000 	add	x0, x0, #0xef0
ffffffff40034884:	9400050a 	bl	ffffffff40035cac <release>
ffffffff40034888:	14000002 	b	ffffffff40034890 <kfree_page+0x188>
        return;
ffffffff4003488c:	d503201f 	nop
    }
}
ffffffff40034890:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff40034894:	d65f03c0 	ret

ffffffff40034898 <kalloc>:

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char* kalloc(void)
{
ffffffff40034898:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff4003489c:	910003fd 	mov	x29, sp
    struct run *r;

    if(kmem.use_lock) {
ffffffff400348a0:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400348a4:	913bc000 	add	x0, x0, #0xef0
ffffffff400348a8:	b9404000 	ldr	w0, [x0, #64]
ffffffff400348ac:	7100001f 	cmp	w0, #0x0
ffffffff400348b0:	54000080 	b.eq	ffffffff400348c0 <kalloc+0x28>  // b.none
        acquire(&kmem.lock);
ffffffff400348b4:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400348b8:	913bc000 	add	x0, x0, #0xef0
ffffffff400348bc:	940004f2 	bl	ffffffff40035c84 <acquire>
    }

    r = kmem.freelist;
ffffffff400348c0:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400348c4:	913bc000 	add	x0, x0, #0xef0
ffffffff400348c8:	f9402400 	ldr	x0, [x0, #72]
ffffffff400348cc:	f9000fe0 	str	x0, [sp, #24]

    if(r) {
ffffffff400348d0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400348d4:	f100001f 	cmp	x0, #0x0
ffffffff400348d8:	540000c0 	b.eq	ffffffff400348f0 <kalloc+0x58>  // b.none
        kmem.freelist = r->next;
ffffffff400348dc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400348e0:	f9400001 	ldr	x1, [x0]
ffffffff400348e4:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400348e8:	913bc000 	add	x0, x0, #0xef0
ffffffff400348ec:	f9002401 	str	x1, [x0, #72]
    }

    if(kmem.use_lock) {
ffffffff400348f0:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400348f4:	913bc000 	add	x0, x0, #0xef0
ffffffff400348f8:	b9404000 	ldr	w0, [x0, #64]
ffffffff400348fc:	7100001f 	cmp	w0, #0x0
ffffffff40034900:	54000080 	b.eq	ffffffff40034910 <kalloc+0x78>  // b.none
        release(&kmem.lock);
ffffffff40034904:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40034908:	913bc000 	add	x0, x0, #0xef0
ffffffff4003490c:	940004e8 	bl	ffffffff40035cac <release>
    }
    if(r){
ffffffff40034910:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034914:	f100001f 	cmp	x0, #0x0
ffffffff40034918:	54000160 	b.eq	ffffffff40034944 <kalloc+0xac>  // b.none
    page_refcount[PA2IDX(v2p(r))] = 1;
ffffffff4003491c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034920:	97ffff3a 	bl	ffffffff40034608 <v2p>
ffffffff40034924:	aa0003e1 	mov	x1, x0
ffffffff40034928:	b26287e0 	mov	x0, #0xffffffffc0000000    	// #-1073741824
ffffffff4003492c:	8b000020 	add	x0, x1, x0
ffffffff40034930:	d34cfc01 	lsr	x1, x0, #12
ffffffff40034934:	f0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40034938:	913bc000 	add	x0, x0, #0xef0
ffffffff4003493c:	52800022 	mov	w2, #0x1                   	// #1
ffffffff40034940:	b8217802 	str	w2, [x0, x1, lsl #2]
    }
    return (char*)r;
ffffffff40034944:	f9400fe0 	ldr	x0, [sp, #24]
}
ffffffff40034948:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff4003494c:	d65f03c0 	ret

ffffffff40034950 <kpage_ref>:

void kpage_ref(void *pa){
ffffffff40034950:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40034954:	910003fd 	mov	x29, sp
ffffffff40034958:	f9000fe0 	str	x0, [sp, #24]
    if(kmem.use_lock) {
ffffffff4003495c:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40034960:	913bc000 	add	x0, x0, #0xef0
ffffffff40034964:	b9404000 	ldr	w0, [x0, #64]
ffffffff40034968:	7100001f 	cmp	w0, #0x0
ffffffff4003496c:	54000080 	b.eq	ffffffff4003497c <kpage_ref+0x2c>  // b.none
        acquire(&kmem.lock);
ffffffff40034970:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40034974:	913bc000 	add	x0, x0, #0xef0
ffffffff40034978:	940004c3 	bl	ffffffff40035c84 <acquire>
    }
    if(pa != NULL){
ffffffff4003497c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034980:	f100001f 	cmp	x0, #0x0
ffffffff40034984:	54000180 	b.eq	ffffffff400349b4 <kpage_ref+0x64>  // b.none
    page_refcount[PA2IDX((uint64)pa)] += 1;
ffffffff40034988:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff4003498c:	b26287e0 	mov	x0, #0xffffffffc0000000    	// #-1073741824
ffffffff40034990:	8b000020 	add	x0, x1, x0
ffffffff40034994:	d34cfc00 	lsr	x0, x0, #12
ffffffff40034998:	f0000441 	adrp	x1, ffffffff400bf000 <icache+0x308>
ffffffff4003499c:	913bc021 	add	x1, x1, #0xef0
ffffffff400349a0:	b8607821 	ldr	w1, [x1, x0, lsl #2]
ffffffff400349a4:	11000422 	add	w2, w1, #0x1
ffffffff400349a8:	f0000441 	adrp	x1, ffffffff400bf000 <icache+0x308>
ffffffff400349ac:	913bc021 	add	x1, x1, #0xef0
ffffffff400349b0:	b8207822 	str	w2, [x1, x0, lsl #2]
    }
    if(kmem.use_lock) {
ffffffff400349b4:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400349b8:	913bc000 	add	x0, x0, #0xef0
ffffffff400349bc:	b9404000 	ldr	w0, [x0, #64]
ffffffff400349c0:	7100001f 	cmp	w0, #0x0
ffffffff400349c4:	54000080 	b.eq	ffffffff400349d4 <kpage_ref+0x84>  // b.none
        release(&kmem.lock);
ffffffff400349c8:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400349cc:	913bc000 	add	x0, x0, #0xef0
ffffffff400349d0:	940004b7 	bl	ffffffff40035cac <release>
    }
}
ffffffff400349d4:	d503201f 	nop
ffffffff400349d8:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff400349dc:	d65f03c0 	ret

ffffffff400349e0 <pipealloc>:
    int readopen;   // read fd is still open
    int writeopen;  // write fd is still open
};

int pipealloc(struct file **f0, struct file **f1)
{
ffffffff400349e0:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff400349e4:	910003fd 	mov	x29, sp
ffffffff400349e8:	f9000fe0 	str	x0, [sp, #24]
ffffffff400349ec:	f9000be1 	str	x1, [sp, #16]
    struct pipe *p;

    p = 0;
ffffffff400349f0:	f90017ff 	str	xzr, [sp, #40]
    *f0 = *f1 = 0;
ffffffff400349f4:	f9400be0 	ldr	x0, [sp, #16]
ffffffff400349f8:	f900001f 	str	xzr, [x0]
ffffffff400349fc:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40034a00:	f9400001 	ldr	x1, [x0]
ffffffff40034a04:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034a08:	f9000001 	str	x1, [x0]

    if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0) {
ffffffff40034a0c:	97fff65b 	bl	ffffffff40032378 <filealloc>
ffffffff40034a10:	aa0003e1 	mov	x1, x0
ffffffff40034a14:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034a18:	f9000001 	str	x1, [x0]
ffffffff40034a1c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034a20:	f9400000 	ldr	x0, [x0]
ffffffff40034a24:	f100001f 	cmp	x0, #0x0
ffffffff40034a28:	540007e0 	b.eq	ffffffff40034b24 <pipealloc+0x144>  // b.none
ffffffff40034a2c:	97fff653 	bl	ffffffff40032378 <filealloc>
ffffffff40034a30:	aa0003e1 	mov	x1, x0
ffffffff40034a34:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40034a38:	f9000001 	str	x1, [x0]
ffffffff40034a3c:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40034a40:	f9400000 	ldr	x0, [x0]
ffffffff40034a44:	f100001f 	cmp	x0, #0x0
ffffffff40034a48:	540006e0 	b.eq	ffffffff40034b24 <pipealloc+0x144>  // b.none
        goto bad;
    }

    if((p = kmalloc (get_order(sizeof(*p)))) == 0) {
ffffffff40034a4c:	52804a00 	mov	w0, #0x250                 	// #592
ffffffff40034a50:	97fff285 	bl	ffffffff40031464 <get_order>
ffffffff40034a54:	97fff202 	bl	ffffffff4003125c <kmalloc>
ffffffff40034a58:	f90017e0 	str	x0, [sp, #40]
ffffffff40034a5c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034a60:	f100001f 	cmp	x0, #0x0
ffffffff40034a64:	54000640 	b.eq	ffffffff40034b2c <pipealloc+0x14c>  // b.none
        goto bad;
    }

    p->readopen = 1;
ffffffff40034a68:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034a6c:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40034a70:	b9024801 	str	w1, [x0, #584]
    p->writeopen = 1;
ffffffff40034a74:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034a78:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40034a7c:	b9024c01 	str	w1, [x0, #588]
    p->nwrite = 0;
ffffffff40034a80:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034a84:	b902441f 	str	wzr, [x0, #580]
    p->nread = 0;
ffffffff40034a88:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034a8c:	b902401f 	str	wzr, [x0, #576]

    initlock(&p->lock, "pipe");
ffffffff40034a90:	f94017e2 	ldr	x2, [sp, #40]
ffffffff40034a94:	f0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40034a98:	911f2001 	add	x1, x0, #0x7c8
ffffffff40034a9c:	aa0203e0 	mov	x0, x2
ffffffff40034aa0:	9400046c 	bl	ffffffff40035c50 <initlock>

    (*f0)->type = FD_PIPE;
ffffffff40034aa4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034aa8:	f9400000 	ldr	x0, [x0]
ffffffff40034aac:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40034ab0:	b9000001 	str	w1, [x0]
    (*f0)->readable = 1;
ffffffff40034ab4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034ab8:	f9400000 	ldr	x0, [x0]
ffffffff40034abc:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40034ac0:	39002001 	strb	w1, [x0, #8]
    (*f0)->writable = 0;
ffffffff40034ac4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034ac8:	f9400000 	ldr	x0, [x0]
ffffffff40034acc:	3900241f 	strb	wzr, [x0, #9]
    (*f0)->pipe = p;
ffffffff40034ad0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034ad4:	f9400000 	ldr	x0, [x0]
ffffffff40034ad8:	f94017e1 	ldr	x1, [sp, #40]
ffffffff40034adc:	f9000801 	str	x1, [x0, #16]
    (*f1)->type = FD_PIPE;
ffffffff40034ae0:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40034ae4:	f9400000 	ldr	x0, [x0]
ffffffff40034ae8:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40034aec:	b9000001 	str	w1, [x0]
    (*f1)->readable = 0;
ffffffff40034af0:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40034af4:	f9400000 	ldr	x0, [x0]
ffffffff40034af8:	3900201f 	strb	wzr, [x0, #8]
    (*f1)->writable = 1;
ffffffff40034afc:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40034b00:	f9400000 	ldr	x0, [x0]
ffffffff40034b04:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40034b08:	39002401 	strb	w1, [x0, #9]
    (*f1)->pipe = p;
ffffffff40034b0c:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40034b10:	f9400000 	ldr	x0, [x0]
ffffffff40034b14:	f94017e1 	ldr	x1, [sp, #40]
ffffffff40034b18:	f9000801 	str	x1, [x0, #16]

    return 0;
ffffffff40034b1c:	52800000 	mov	w0, #0x0                   	// #0
ffffffff40034b20:	1400001b 	b	ffffffff40034b8c <pipealloc+0x1ac>
        goto bad;
ffffffff40034b24:	d503201f 	nop
ffffffff40034b28:	14000002 	b	ffffffff40034b30 <pipealloc+0x150>
        goto bad;
ffffffff40034b2c:	d503201f 	nop

    //PAGEBREAK: 20
    bad:
    if(p) {
ffffffff40034b30:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034b34:	f100001f 	cmp	x0, #0x0
ffffffff40034b38:	540000c0 	b.eq	ffffffff40034b50 <pipealloc+0x170>  // b.none
        kfree (p, get_order(sizeof*p));
ffffffff40034b3c:	52804a00 	mov	w0, #0x250                 	// #592
ffffffff40034b40:	97fff249 	bl	ffffffff40031464 <get_order>
ffffffff40034b44:	2a0003e1 	mov	w1, w0
ffffffff40034b48:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034b4c:	97fff215 	bl	ffffffff400313a0 <kfree>
    }

    if(*f0) {
ffffffff40034b50:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034b54:	f9400000 	ldr	x0, [x0]
ffffffff40034b58:	f100001f 	cmp	x0, #0x0
ffffffff40034b5c:	54000080 	b.eq	ffffffff40034b6c <pipealloc+0x18c>  // b.none
        fileclose(*f0);
ffffffff40034b60:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034b64:	f9400000 	ldr	x0, [x0]
ffffffff40034b68:	97fff63f 	bl	ffffffff40032464 <fileclose>
    }

    if(*f1) {
ffffffff40034b6c:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40034b70:	f9400000 	ldr	x0, [x0]
ffffffff40034b74:	f100001f 	cmp	x0, #0x0
ffffffff40034b78:	54000080 	b.eq	ffffffff40034b88 <pipealloc+0x1a8>  // b.none
        fileclose(*f1);
ffffffff40034b7c:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40034b80:	f9400000 	ldr	x0, [x0]
ffffffff40034b84:	97fff638 	bl	ffffffff40032464 <fileclose>
    }

    return -1;
ffffffff40034b88:	12800000 	mov	w0, #0xffffffff            	// #-1
}
ffffffff40034b8c:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff40034b90:	d65f03c0 	ret

ffffffff40034b94 <pipeclose>:

void pipeclose(struct pipe *p, int writable)
{
ffffffff40034b94:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40034b98:	910003fd 	mov	x29, sp
ffffffff40034b9c:	f9000fe0 	str	x0, [sp, #24]
ffffffff40034ba0:	b90017e1 	str	w1, [sp, #20]
    acquire(&p->lock);
ffffffff40034ba4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034ba8:	94000437 	bl	ffffffff40035c84 <acquire>

    if(writable){
ffffffff40034bac:	b94017e0 	ldr	w0, [sp, #20]
ffffffff40034bb0:	7100001f 	cmp	w0, #0x0
ffffffff40034bb4:	540000e0 	b.eq	ffffffff40034bd0 <pipeclose+0x3c>  // b.none
        p->writeopen = 0;
ffffffff40034bb8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034bbc:	b9024c1f 	str	wzr, [x0, #588]
        wakeup(&p->nread);
ffffffff40034bc0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034bc4:	91090000 	add	x0, x0, #0x240
ffffffff40034bc8:	940003ae 	bl	ffffffff40035a80 <wakeup>
ffffffff40034bcc:	14000006 	b	ffffffff40034be4 <pipeclose+0x50>

    } else {
        p->readopen = 0;
ffffffff40034bd0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034bd4:	b902481f 	str	wzr, [x0, #584]
        wakeup(&p->nwrite);
ffffffff40034bd8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034bdc:	91091000 	add	x0, x0, #0x244
ffffffff40034be0:	940003a8 	bl	ffffffff40035a80 <wakeup>
    }

    if(p->readopen == 0 && p->writeopen == 0){
ffffffff40034be4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034be8:	b9424800 	ldr	w0, [x0, #584]
ffffffff40034bec:	7100001f 	cmp	w0, #0x0
ffffffff40034bf0:	540001a1 	b.ne	ffffffff40034c24 <pipeclose+0x90>  // b.any
ffffffff40034bf4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034bf8:	b9424c00 	ldr	w0, [x0, #588]
ffffffff40034bfc:	7100001f 	cmp	w0, #0x0
ffffffff40034c00:	54000121 	b.ne	ffffffff40034c24 <pipeclose+0x90>  // b.any
        release(&p->lock);
ffffffff40034c04:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034c08:	94000429 	bl	ffffffff40035cac <release>
        kfree (p, get_order(sizeof(*p)));
ffffffff40034c0c:	52804a00 	mov	w0, #0x250                 	// #592
ffffffff40034c10:	97fff215 	bl	ffffffff40031464 <get_order>
ffffffff40034c14:	2a0003e1 	mov	w1, w0
ffffffff40034c18:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034c1c:	97fff1e1 	bl	ffffffff400313a0 <kfree>
ffffffff40034c20:	14000004 	b	ffffffff40034c30 <pipeclose+0x9c>

    } else {
        release(&p->lock);
ffffffff40034c24:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034c28:	94000421 	bl	ffffffff40035cac <release>
    }
}
ffffffff40034c2c:	d503201f 	nop
ffffffff40034c30:	d503201f 	nop
ffffffff40034c34:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40034c38:	d65f03c0 	ret

ffffffff40034c3c <pipewrite>:

//PAGEBREAK: 40
int pipewrite(struct pipe *p, char *addr, int n)
{
ffffffff40034c3c:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff40034c40:	910003fd 	mov	x29, sp
ffffffff40034c44:	f90017e0 	str	x0, [sp, #40]
ffffffff40034c48:	f90013e1 	str	x1, [sp, #32]
ffffffff40034c4c:	b9001fe2 	str	w2, [sp, #28]
    int i;

    acquire(&p->lock);
ffffffff40034c50:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034c54:	9400040c 	bl	ffffffff40035c84 <acquire>

    for(i = 0; i < n; i++){
ffffffff40034c58:	b9003fff 	str	wzr, [sp, #60]
ffffffff40034c5c:	14000029 	b	ffffffff40034d00 <pipewrite+0xc4>
        while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
            if(p->readopen == 0 /*|| proc->killed*/){
ffffffff40034c60:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034c64:	b9424800 	ldr	w0, [x0, #584]
ffffffff40034c68:	7100001f 	cmp	w0, #0x0
ffffffff40034c6c:	540000a1 	b.ne	ffffffff40034c80 <pipewrite+0x44>  // b.any
                release(&p->lock);
ffffffff40034c70:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034c74:	9400040e 	bl	ffffffff40035cac <release>
                return -1;
ffffffff40034c78:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40034c7c:	1400002b 	b	ffffffff40034d28 <pipewrite+0xec>
            }

            wakeup(&p->nread);
ffffffff40034c80:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034c84:	91090000 	add	x0, x0, #0x240
ffffffff40034c88:	9400037e 	bl	ffffffff40035a80 <wakeup>
            sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
ffffffff40034c8c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034c90:	91091000 	add	x0, x0, #0x244
ffffffff40034c94:	f94017e1 	ldr	x1, [sp, #40]
ffffffff40034c98:	94000324 	bl	ffffffff40035928 <sleep>
        while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
ffffffff40034c9c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034ca0:	b9424401 	ldr	w1, [x0, #580]
ffffffff40034ca4:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034ca8:	b9424000 	ldr	w0, [x0, #576]
ffffffff40034cac:	11080000 	add	w0, w0, #0x200
ffffffff40034cb0:	6b00003f 	cmp	w1, w0
ffffffff40034cb4:	54fffd60 	b.eq	ffffffff40034c60 <pipewrite+0x24>  // b.none
        }

        p->data[p->nwrite++ % PIPESIZE] = addr[i];
ffffffff40034cb8:	b9803fe0 	ldrsw	x0, [sp, #60]
ffffffff40034cbc:	f94013e1 	ldr	x1, [sp, #32]
ffffffff40034cc0:	8b000021 	add	x1, x1, x0
ffffffff40034cc4:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034cc8:	b9424400 	ldr	w0, [x0, #580]
ffffffff40034ccc:	11000403 	add	w3, w0, #0x1
ffffffff40034cd0:	f94017e2 	ldr	x2, [sp, #40]
ffffffff40034cd4:	b9024443 	str	w3, [x2, #580]
ffffffff40034cd8:	12002000 	and	w0, w0, #0x1ff
ffffffff40034cdc:	39400022 	ldrb	w2, [x1]
ffffffff40034ce0:	f94017e1 	ldr	x1, [sp, #40]
ffffffff40034ce4:	2a0003e0 	mov	w0, w0
ffffffff40034ce8:	8b000020 	add	x0, x1, x0
ffffffff40034cec:	2a0203e1 	mov	w1, w2
ffffffff40034cf0:	39010001 	strb	w1, [x0, #64]
    for(i = 0; i < n; i++){
ffffffff40034cf4:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40034cf8:	11000400 	add	w0, w0, #0x1
ffffffff40034cfc:	b9003fe0 	str	w0, [sp, #60]
ffffffff40034d00:	b9403fe1 	ldr	w1, [sp, #60]
ffffffff40034d04:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40034d08:	6b00003f 	cmp	w1, w0
ffffffff40034d0c:	54fffc8b 	b.lt	ffffffff40034c9c <pipewrite+0x60>  // b.tstop
    }

    wakeup(&p->nread);  //DOC: pipewrite-wakeup1
ffffffff40034d10:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034d14:	91090000 	add	x0, x0, #0x240
ffffffff40034d18:	9400035a 	bl	ffffffff40035a80 <wakeup>
    release(&p->lock);
ffffffff40034d1c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034d20:	940003e3 	bl	ffffffff40035cac <release>
    return n;
ffffffff40034d24:	b9401fe0 	ldr	w0, [sp, #28]
}
ffffffff40034d28:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff40034d2c:	d65f03c0 	ret

ffffffff40034d30 <piperead>:

int piperead(struct pipe *p, char *addr, int n)
{
ffffffff40034d30:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff40034d34:	910003fd 	mov	x29, sp
ffffffff40034d38:	f90017e0 	str	x0, [sp, #40]
ffffffff40034d3c:	f90013e1 	str	x1, [sp, #32]
ffffffff40034d40:	b9001fe2 	str	w2, [sp, #28]
    int i;

    acquire(&p->lock);
ffffffff40034d44:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034d48:	940003cf 	bl	ffffffff40035c84 <acquire>

    while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
ffffffff40034d4c:	1400000f 	b	ffffffff40034d88 <piperead+0x58>
        if(proc->killed){
ffffffff40034d50:	f0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40034d54:	911e0000 	add	x0, x0, #0x780
ffffffff40034d58:	f9400000 	ldr	x0, [x0]
ffffffff40034d5c:	b9404000 	ldr	w0, [x0, #64]
ffffffff40034d60:	7100001f 	cmp	w0, #0x0
ffffffff40034d64:	540000a0 	b.eq	ffffffff40034d78 <piperead+0x48>  // b.none
            release(&p->lock);
ffffffff40034d68:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034d6c:	940003d0 	bl	ffffffff40035cac <release>
            return -1;
ffffffff40034d70:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40034d74:	14000034 	b	ffffffff40034e44 <piperead+0x114>
        }

        sleep(&p->nread, &p->lock); //DOC: piperead-sleep*/
ffffffff40034d78:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034d7c:	91090000 	add	x0, x0, #0x240
ffffffff40034d80:	f94017e1 	ldr	x1, [sp, #40]
ffffffff40034d84:	940002e9 	bl	ffffffff40035928 <sleep>
    while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
ffffffff40034d88:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034d8c:	b9424001 	ldr	w1, [x0, #576]
ffffffff40034d90:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034d94:	b9424400 	ldr	w0, [x0, #580]
ffffffff40034d98:	6b00003f 	cmp	w1, w0
ffffffff40034d9c:	540000a1 	b.ne	ffffffff40034db0 <piperead+0x80>  // b.any
ffffffff40034da0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034da4:	b9424c00 	ldr	w0, [x0, #588]
ffffffff40034da8:	7100001f 	cmp	w0, #0x0
ffffffff40034dac:	54fffd21 	b.ne	ffffffff40034d50 <piperead+0x20>  // b.any
    }

    for(i = 0; i < n; i++){  //DOC: piperead-copy
ffffffff40034db0:	b9003fff 	str	wzr, [sp, #60]
ffffffff40034db4:	14000018 	b	ffffffff40034e14 <piperead+0xe4>
        if(p->nread == p->nwrite) {
ffffffff40034db8:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034dbc:	b9424001 	ldr	w1, [x0, #576]
ffffffff40034dc0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034dc4:	b9424400 	ldr	w0, [x0, #580]
ffffffff40034dc8:	6b00003f 	cmp	w1, w0
ffffffff40034dcc:	540002e0 	b.eq	ffffffff40034e28 <piperead+0xf8>  // b.none
            break;
        }

        addr[i] = p->data[p->nread++ % PIPESIZE];
ffffffff40034dd0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034dd4:	b9424000 	ldr	w0, [x0, #576]
ffffffff40034dd8:	11000402 	add	w2, w0, #0x1
ffffffff40034ddc:	f94017e1 	ldr	x1, [sp, #40]
ffffffff40034de0:	b9024022 	str	w2, [x1, #576]
ffffffff40034de4:	12002003 	and	w3, w0, #0x1ff
ffffffff40034de8:	b9803fe0 	ldrsw	x0, [sp, #60]
ffffffff40034dec:	f94013e1 	ldr	x1, [sp, #32]
ffffffff40034df0:	8b000020 	add	x0, x1, x0
ffffffff40034df4:	f94017e2 	ldr	x2, [sp, #40]
ffffffff40034df8:	2a0303e1 	mov	w1, w3
ffffffff40034dfc:	8b010041 	add	x1, x2, x1
ffffffff40034e00:	39410021 	ldrb	w1, [x1, #64]
ffffffff40034e04:	39000001 	strb	w1, [x0]
    for(i = 0; i < n; i++){  //DOC: piperead-copy
ffffffff40034e08:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40034e0c:	11000400 	add	w0, w0, #0x1
ffffffff40034e10:	b9003fe0 	str	w0, [sp, #60]
ffffffff40034e14:	b9403fe1 	ldr	w1, [sp, #60]
ffffffff40034e18:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40034e1c:	6b00003f 	cmp	w1, w0
ffffffff40034e20:	54fffccb 	b.lt	ffffffff40034db8 <piperead+0x88>  // b.tstop
ffffffff40034e24:	14000002 	b	ffffffff40034e2c <piperead+0xfc>
            break;
ffffffff40034e28:	d503201f 	nop
    }

    wakeup(&p->nwrite);  //DOC: piperead-wakeup
ffffffff40034e2c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034e30:	91091000 	add	x0, x0, #0x244
ffffffff40034e34:	94000313 	bl	ffffffff40035a80 <wakeup>
    release(&p->lock);
ffffffff40034e38:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40034e3c:	9400039c 	bl	ffffffff40035cac <release>

    return i;
ffffffff40034e40:	b9403fe0 	ldr	w0, [sp, #60]
}
ffffffff40034e44:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff40034e48:	d65f03c0 	ret

ffffffff40034e4c <pinit>:
extern void trapret(void);

static void wakeup1(void *chan);

void pinit(void)
{
ffffffff40034e4c:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff40034e50:	910003fd 	mov	x29, sp
    initlock(&ptable.lock, "ptable");
ffffffff40034e54:	f0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40034e58:	911f4001 	add	x1, x0, #0x7d0
ffffffff40034e5c:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40034e60:	913d0000 	add	x0, x0, #0xf40
ffffffff40034e64:	9400037b 	bl	ffffffff40035c50 <initlock>
}
ffffffff40034e68:	d503201f 	nop
ffffffff40034e6c:	a8c17bfd 	ldp	x29, x30, [sp], #16
ffffffff40034e70:	d65f03c0 	ret

ffffffff40034e74 <allocproc>:
// Look in the process table for an UNUSED proc.
// If found, change state to EMBRYO and initialize
// state required to run in the kernel.
// Otherwise return 0.
static struct proc* allocproc(void)
{
ffffffff40034e74:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40034e78:	910003fd 	mov	x29, sp
    struct proc *p;
    char *sp;

    acquire(&ptable.lock);
ffffffff40034e7c:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40034e80:	913d0000 	add	x0, x0, #0xf40
ffffffff40034e84:	94000380 	bl	ffffffff40035c84 <acquire>

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
ffffffff40034e88:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40034e8c:	913e0000 	add	x0, x0, #0xf80
ffffffff40034e90:	f9000fe0 	str	x0, [sp, #24]
ffffffff40034e94:	14000008 	b	ffffffff40034eb4 <allocproc+0x40>
        if(p->state == UNUSED) {
ffffffff40034e98:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034e9c:	b9401800 	ldr	w0, [x0, #24]
ffffffff40034ea0:	7100001f 	cmp	w0, #0x0
ffffffff40034ea4:	540001c0 	b.eq	ffffffff40034edc <allocproc+0x68>  // b.none
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
ffffffff40034ea8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034eac:	91038000 	add	x0, x0, #0xe0
ffffffff40034eb0:	f9000fe0 	str	x0, [sp, #24]
ffffffff40034eb4:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40034eb8:	f0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40034ebc:	911e0000 	add	x0, x0, #0x780
ffffffff40034ec0:	eb00003f 	cmp	x1, x0
ffffffff40034ec4:	54fffea3 	b.cc	ffffffff40034e98 <allocproc+0x24>  // b.lo, b.ul, b.last
            goto found;
        }

    }

    release(&ptable.lock);
ffffffff40034ec8:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40034ecc:	913d0000 	add	x0, x0, #0xf40
ffffffff40034ed0:	94000377 	bl	ffffffff40035cac <release>
    return 0;
ffffffff40034ed4:	d2800000 	mov	x0, #0x0                   	// #0
ffffffff40034ed8:	14000048 	b	ffffffff40034ff8 <allocproc+0x184>
            goto found;
ffffffff40034edc:	d503201f 	nop

    found:
    p->state = EMBRYO;
ffffffff40034ee0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034ee4:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40034ee8:	b9001801 	str	w1, [x0, #24]
    p->pid = nextpid++;
ffffffff40034eec:	90000040 	adrp	x0, ffffffff4003c000 <digits.0>
ffffffff40034ef0:	91006000 	add	x0, x0, #0x18
ffffffff40034ef4:	b9400000 	ldr	w0, [x0]
ffffffff40034ef8:	11000402 	add	w2, w0, #0x1
ffffffff40034efc:	90000041 	adrp	x1, ffffffff4003c000 <digits.0>
ffffffff40034f00:	91006021 	add	x1, x1, #0x18
ffffffff40034f04:	b9000022 	str	w2, [x1]
ffffffff40034f08:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40034f0c:	b9001c20 	str	w0, [x1, #28]
    release(&ptable.lock);
ffffffff40034f10:	f0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40034f14:	913d0000 	add	x0, x0, #0xf40
ffffffff40034f18:	94000365 	bl	ffffffff40035cac <release>

    // Allocate kernel stack.
    if((p->kstack = alloc_page ()) == 0){
ffffffff40034f1c:	97fff14c 	bl	ffffffff4003144c <alloc_page>
ffffffff40034f20:	aa0003e1 	mov	x1, x0
ffffffff40034f24:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034f28:	f9000801 	str	x1, [x0, #16]
ffffffff40034f2c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034f30:	f9400800 	ldr	x0, [x0, #16]
ffffffff40034f34:	f100001f 	cmp	x0, #0x0
ffffffff40034f38:	540000a1 	b.ne	ffffffff40034f4c <allocproc+0xd8>  // b.any
        p->state = UNUSED;
ffffffff40034f3c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034f40:	b900181f 	str	wzr, [x0, #24]
        return 0;
ffffffff40034f44:	d2800000 	mov	x0, #0x0                   	// #0
ffffffff40034f48:	1400002c 	b	ffffffff40034ff8 <allocproc+0x184>
    }

    sp = p->kstack + KSTACKSIZE;
ffffffff40034f4c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034f50:	f9400800 	ldr	x0, [x0, #16]
ffffffff40034f54:	91400400 	add	x0, x0, #0x1, lsl #12
ffffffff40034f58:	f9000be0 	str	x0, [sp, #16]

    // Leave room for trap frame.
    sp -= sizeof (*p->tf);
ffffffff40034f5c:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40034f60:	d1044000 	sub	x0, x0, #0x110
ffffffff40034f64:	f9000be0 	str	x0, [sp, #16]
    p->tf = (struct trapframe*)sp;
ffffffff40034f68:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034f6c:	f9400be1 	ldr	x1, [sp, #16]
ffffffff40034f70:	f9001401 	str	x1, [x0, #40]

    // Set up new context to start executing at forkret,
    // which returns to trapret.
    sp -= 8;
ffffffff40034f74:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40034f78:	d1002000 	sub	x0, x0, #0x8
ffffffff40034f7c:	f9000be0 	str	x0, [sp, #16]
    *(uint64*)sp = (uint64)trapret;
ffffffff40034f80:	90000020 	adrp	x0, ffffffff40038000 <trapret>
ffffffff40034f84:	91000001 	add	x1, x0, #0x0
ffffffff40034f88:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40034f8c:	f9000001 	str	x1, [x0]

    sp -= 8;
ffffffff40034f90:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40034f94:	d1002000 	sub	x0, x0, #0x8
ffffffff40034f98:	f9000be0 	str	x0, [sp, #16]
    *(uint64*)sp = (uint64)p->kstack + KSTACKSIZE;
ffffffff40034f9c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034fa0:	f9400800 	ldr	x0, [x0, #16]
ffffffff40034fa4:	91400401 	add	x1, x0, #0x1, lsl #12
ffffffff40034fa8:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40034fac:	f9000001 	str	x1, [x0]

    sp -= sizeof (*p->context);
ffffffff40034fb0:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40034fb4:	d1036000 	sub	x0, x0, #0xd8
ffffffff40034fb8:	f9000be0 	str	x0, [sp, #16]
    p->context = (struct context*)sp;
ffffffff40034fbc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034fc0:	f9400be1 	ldr	x1, [sp, #16]
ffffffff40034fc4:	f9001801 	str	x1, [x0, #48]
    memset(p->context, 0, sizeof(*p->context));
ffffffff40034fc8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034fcc:	f9401800 	ldr	x0, [x0, #48]
ffffffff40034fd0:	52801b02 	mov	w2, #0xd8                  	// #216
ffffffff40034fd4:	52800001 	mov	w1, #0x0                   	// #0
ffffffff40034fd8:	97ffec0a 	bl	ffffffff40030000 <memset>
    // This is different from x86, in which the harderware pushes return
    // address before executing the callee. In ARM, return address is
    // loaded into the lr register, and push to the stack by the callee
    // (if and when necessary). We need to skip that instruction and let
    // it use our implementation.
    p->context->lr = (uint64)forkret+8;
ffffffff40034fdc:	b0000000 	adrp	x0, ffffffff40035000 <error_init>
ffffffff40034fe0:	91239001 	add	x1, x0, #0x8e4
ffffffff40034fe4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40034fe8:	f9401800 	ldr	x0, [x0, #48]
ffffffff40034fec:	91002021 	add	x1, x1, #0x8
ffffffff40034ff0:	f9006801 	str	x1, [x0, #208]

    return p;
ffffffff40034ff4:	f9400fe0 	ldr	x0, [sp, #24]
}
ffffffff40034ff8:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40034ffc:	d65f03c0 	ret

ffffffff40035000 <error_init>:

void error_init ()
{
ffffffff40035000:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff40035004:	910003fd 	mov	x29, sp
    panic ("failed to craft first process\n");
ffffffff40035008:	d0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003500c:	911f6000 	add	x0, x0, #0x7d8
ffffffff40035010:	97fff22e 	bl	ffffffff400318c8 <panic>

ffffffff40035014 <userinit>:

//PAGEBREAK: 32
// hand-craft the first user process. We link initcode.S into the kernel
// as a binary, the linker will generate __binary_initcode_start/_size
void userinit(void)
{
ffffffff40035014:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40035018:	910003fd 	mov	x29, sp
    struct proc *p;
    extern char _binary_initcode_start[], _binary_initcode_size[];

    p = allocproc();
ffffffff4003501c:	97ffff96 	bl	ffffffff40034e74 <allocproc>
ffffffff40035020:	f9000fe0 	str	x0, [sp, #24]
    initproc = p;
ffffffff40035024:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035028:	911e2000 	add	x0, x0, #0x788
ffffffff4003502c:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40035030:	f9000001 	str	x1, [x0]

    if((p->pgdir = kpt_alloc()) == NULL) {
ffffffff40035034:	9400138e 	bl	ffffffff40039e6c <kpt_alloc>
ffffffff40035038:	aa0003e1 	mov	x1, x0
ffffffff4003503c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035040:	f9000401 	str	x1, [x0, #8]
ffffffff40035044:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035048:	f9400400 	ldr	x0, [x0, #8]
ffffffff4003504c:	f100001f 	cmp	x0, #0x0
ffffffff40035050:	54000081 	b.ne	ffffffff40035060 <userinit+0x4c>  // b.any
        panic("userinit: out of memory?");
ffffffff40035054:	d0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40035058:	911fe000 	add	x0, x0, #0x7f8
ffffffff4003505c:	97fff21b 	bl	ffffffff400318c8 <panic>
    }

    inituvm(p->pgdir, _binary_initcode_start, (long)_binary_initcode_size);
ffffffff40035060:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035064:	f9400403 	ldr	x3, [x0, #8]
ffffffff40035068:	f05ffe40 	adrp	x0, 0 <_binary_initcode_size-0x50>
ffffffff4003506c:	91014000 	add	x0, x0, #0x50
ffffffff40035070:	2a0003e2 	mov	w2, w0
ffffffff40035074:	f0000020 	adrp	x0, ffffffff4003c000 <digits.0>
ffffffff40035078:	91040001 	add	x1, x0, #0x100
ffffffff4003507c:	aa0303e0 	mov	x0, x3
ffffffff40035080:	9400144e 	bl	ffffffff4003a1b8 <inituvm>

    p->sz = PTE_SZ;
ffffffff40035084:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035088:	d2820001 	mov	x1, #0x1000                	// #4096
ffffffff4003508c:	f9000001 	str	x1, [x0]

    // craft the trapframe as if
    memset(p->tf, 0, sizeof(*p->tf));
ffffffff40035090:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035094:	f9401400 	ldr	x0, [x0, #40]
ffffffff40035098:	52802202 	mov	w2, #0x110                 	// #272
ffffffff4003509c:	52800001 	mov	w1, #0x0                   	// #0
ffffffff400350a0:	97ffebd8 	bl	ffffffff40030000 <memset>

    //p->tf->r14_svc = (uint64)error_init;	//Lakshman
    p->tf->spsr = 0x00; // Lakshman spsr_usr ();
ffffffff400350a4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400350a8:	f9401400 	ldr	x0, [x0, #40]
ffffffff400350ac:	f900081f 	str	xzr, [x0, #16]
    p->tf->sp = PTE_SZ;	// set the user stack
ffffffff400350b0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400350b4:	f9401400 	ldr	x0, [x0, #40]
ffffffff400350b8:	d2820001 	mov	x1, #0x1000                	// #4096
ffffffff400350bc:	f9000001 	str	x1, [x0]
    p->tf->r30 = 0;	// lr_usr Lakshman
ffffffff400350c0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400350c4:	f9401400 	ldr	x0, [x0, #40]
ffffffff400350c8:	f900841f 	str	xzr, [x0, #264]

    // set the user pc. The actual pc loaded into r15_usr is in
    // p->tf, the trapframe.
    p->tf->pc = 0;					// beginning of initcode.S
ffffffff400350cc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400350d0:	f9401400 	ldr	x0, [x0, #40]
ffffffff400350d4:	f900041f 	str	xzr, [x0, #8]

    safestrcpy(p->name, "initcode", sizeof(p->name));
ffffffff400350d8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400350dc:	91034003 	add	x3, x0, #0xd0
ffffffff400350e0:	52800202 	mov	w2, #0x10                  	// #16
ffffffff400350e4:	d0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400350e8:	91206001 	add	x1, x0, #0x818
ffffffff400350ec:	aa0303e0 	mov	x0, x3
ffffffff400350f0:	97ffecc0 	bl	ffffffff400303f0 <safestrcpy>
    p->cwd = namei("/");
ffffffff400350f4:	d0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400350f8:	9120a000 	add	x0, x0, #0x828
ffffffff400350fc:	97fffb3e 	bl	ffffffff40033df4 <namei>
ffffffff40035100:	aa0003e1 	mov	x1, x0
ffffffff40035104:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035108:	f9006401 	str	x1, [x0, #200]

    p->state = RUNNABLE;
ffffffff4003510c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035110:	52800061 	mov	w1, #0x3                   	// #3
ffffffff40035114:	b9001801 	str	w1, [x0, #24]
}
ffffffff40035118:	d503201f 	nop
ffffffff4003511c:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40035120:	d65f03c0 	ret

ffffffff40035124 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int growproc(int n)
{
ffffffff40035124:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40035128:	910003fd 	mov	x29, sp
ffffffff4003512c:	b9001fe0 	str	w0, [sp, #28]
    uint sz;

    sz = proc->sz;
ffffffff40035130:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035134:	911e0000 	add	x0, x0, #0x780
ffffffff40035138:	f9400000 	ldr	x0, [x0]
ffffffff4003513c:	f9400000 	ldr	x0, [x0]
ffffffff40035140:	b9002fe0 	str	w0, [sp, #44]

    if(n > 0){
ffffffff40035144:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40035148:	7100001f 	cmp	w0, #0x0
ffffffff4003514c:	5400024d 	b.le	ffffffff40035194 <growproc+0x70>
        if((sz = allocuvm(proc->pgdir, sz, sz + n)) == 0) {
ffffffff40035150:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035154:	911e0000 	add	x0, x0, #0x780
ffffffff40035158:	f9400000 	ldr	x0, [x0]
ffffffff4003515c:	f9400403 	ldr	x3, [x0, #8]
ffffffff40035160:	b9401fe1 	ldr	w1, [sp, #28]
ffffffff40035164:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40035168:	0b000020 	add	w0, w1, w0
ffffffff4003516c:	2a0003e2 	mov	w2, w0
ffffffff40035170:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff40035174:	aa0303e0 	mov	x0, x3
ffffffff40035178:	94001479 	bl	ffffffff4003a35c <allocuvm>
ffffffff4003517c:	b9002fe0 	str	w0, [sp, #44]
ffffffff40035180:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40035184:	7100001f 	cmp	w0, #0x0
ffffffff40035188:	540002e1 	b.ne	ffffffff400351e4 <growproc+0xc0>  // b.any
            return -1;
ffffffff4003518c:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40035190:	1400001f 	b	ffffffff4003520c <growproc+0xe8>
        }

    } else if(n < 0){
ffffffff40035194:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40035198:	7100001f 	cmp	w0, #0x0
ffffffff4003519c:	5400024a 	b.ge	ffffffff400351e4 <growproc+0xc0>  // b.tcont
        if((sz = deallocuvm(proc->pgdir, sz, sz + n)) == 0) {
ffffffff400351a0:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400351a4:	911e0000 	add	x0, x0, #0x780
ffffffff400351a8:	f9400000 	ldr	x0, [x0]
ffffffff400351ac:	f9400403 	ldr	x3, [x0, #8]
ffffffff400351b0:	b9401fe1 	ldr	w1, [sp, #28]
ffffffff400351b4:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff400351b8:	0b000020 	add	w0, w1, w0
ffffffff400351bc:	2a0003e2 	mov	w2, w0
ffffffff400351c0:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff400351c4:	aa0303e0 	mov	x0, x3
ffffffff400351c8:	940014a2 	bl	ffffffff4003a450 <deallocuvm>
ffffffff400351cc:	b9002fe0 	str	w0, [sp, #44]
ffffffff400351d0:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff400351d4:	7100001f 	cmp	w0, #0x0
ffffffff400351d8:	54000061 	b.ne	ffffffff400351e4 <growproc+0xc0>  // b.any
            return -1;
ffffffff400351dc:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff400351e0:	1400000b 	b	ffffffff4003520c <growproc+0xe8>
        }
    }

    proc->sz = sz;
ffffffff400351e4:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400351e8:	911e0000 	add	x0, x0, #0x780
ffffffff400351ec:	f9400000 	ldr	x0, [x0]
ffffffff400351f0:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff400351f4:	f9000001 	str	x1, [x0]
    switchuvm(proc);
ffffffff400351f8:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400351fc:	911e0000 	add	x0, x0, #0x780
ffffffff40035200:	f9400000 	ldr	x0, [x0]
ffffffff40035204:	940013d5 	bl	ffffffff4003a158 <switchuvm>

    return 0;
ffffffff40035208:	52800000 	mov	w0, #0x0                   	// #0
}
ffffffff4003520c:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff40035210:	d65f03c0 	ret

ffffffff40035214 <fork>:

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int fork(void)
{
ffffffff40035214:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40035218:	910003fd 	mov	x29, sp
    int i, pid;
    struct proc *np;

    // Allocate process.
    if((np = allocproc()) == 0) {
ffffffff4003521c:	97ffff16 	bl	ffffffff40034e74 <allocproc>
ffffffff40035220:	f90013e0 	str	x0, [sp, #32]
ffffffff40035224:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40035228:	f100001f 	cmp	x0, #0x0
ffffffff4003522c:	54000061 	b.ne	ffffffff40035238 <fork+0x24>  // b.any
        return -1;
ffffffff40035230:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40035234:	14000070 	b	ffffffff400353f4 <fork+0x1e0>
    }

    // Copy process state from p.
    if((np->pgdir = copyuvm(proc->pgdir, proc->sz)) == 0){
ffffffff40035238:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003523c:	911e0000 	add	x0, x0, #0x780
ffffffff40035240:	f9400000 	ldr	x0, [x0]
ffffffff40035244:	f9400402 	ldr	x2, [x0, #8]
ffffffff40035248:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003524c:	911e0000 	add	x0, x0, #0x780
ffffffff40035250:	f9400000 	ldr	x0, [x0]
ffffffff40035254:	f9400000 	ldr	x0, [x0]
ffffffff40035258:	2a0003e1 	mov	w1, w0
ffffffff4003525c:	aa0203e0 	mov	x0, x2
ffffffff40035260:	94001516 	bl	ffffffff4003a6b8 <copyuvm>
ffffffff40035264:	aa0003e1 	mov	x1, x0
ffffffff40035268:	f94013e0 	ldr	x0, [sp, #32]
ffffffff4003526c:	f9000401 	str	x1, [x0, #8]
ffffffff40035270:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40035274:	f9400400 	ldr	x0, [x0, #8]
ffffffff40035278:	f100001f 	cmp	x0, #0x0
ffffffff4003527c:	54000141 	b.ne	ffffffff400352a4 <fork+0x90>  // b.any
        free_page(np->kstack);
ffffffff40035280:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40035284:	f9400800 	ldr	x0, [x0, #16]
ffffffff40035288:	97fff068 	bl	ffffffff40031428 <free_page>
        np->kstack = 0;
ffffffff4003528c:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40035290:	f900081f 	str	xzr, [x0, #16]
        np->state = UNUSED;
ffffffff40035294:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40035298:	b900181f 	str	wzr, [x0, #24]
        return -1;
ffffffff4003529c:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff400352a0:	14000055 	b	ffffffff400353f4 <fork+0x1e0>
    }

    np->sz = proc->sz;
ffffffff400352a4:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400352a8:	911e0000 	add	x0, x0, #0x780
ffffffff400352ac:	f9400000 	ldr	x0, [x0]
ffffffff400352b0:	f9400001 	ldr	x1, [x0]
ffffffff400352b4:	f94013e0 	ldr	x0, [sp, #32]
ffffffff400352b8:	f9000001 	str	x1, [x0]
    np->parent = proc;
ffffffff400352bc:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400352c0:	911e0000 	add	x0, x0, #0x780
ffffffff400352c4:	f9400001 	ldr	x1, [x0]
ffffffff400352c8:	f94013e0 	ldr	x0, [sp, #32]
ffffffff400352cc:	f9001001 	str	x1, [x0, #32]
    *np->tf = *proc->tf;
ffffffff400352d0:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400352d4:	911e0000 	add	x0, x0, #0x780
ffffffff400352d8:	f9400000 	ldr	x0, [x0]
ffffffff400352dc:	f9401401 	ldr	x1, [x0, #40]
ffffffff400352e0:	f94013e0 	ldr	x0, [sp, #32]
ffffffff400352e4:	f9401400 	ldr	x0, [x0, #40]
ffffffff400352e8:	aa0003e3 	mov	x3, x0
ffffffff400352ec:	d2802200 	mov	x0, #0x110                 	// #272
ffffffff400352f0:	aa0003e2 	mov	x2, x0
ffffffff400352f4:	aa0303e0 	mov	x0, x3
ffffffff400352f8:	97ffebe7 	bl	ffffffff40030294 <memcpy>

    // Clear r0 so that fork returns 0 in the child.
    np->tf->r0 = 0;
ffffffff400352fc:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40035300:	f9401400 	ldr	x0, [x0, #40]
ffffffff40035304:	f9000c1f 	str	xzr, [x0, #24]

    for(i = 0; i < NOFILE; i++) {
ffffffff40035308:	b9002fff 	str	wzr, [sp, #44]
ffffffff4003530c:	1400001e 	b	ffffffff40035384 <fork+0x170>
        if(proc->ofile[i]) {
ffffffff40035310:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035314:	911e0000 	add	x0, x0, #0x780
ffffffff40035318:	f9400001 	ldr	x1, [x0]
ffffffff4003531c:	b9802fe0 	ldrsw	x0, [sp, #44]
ffffffff40035320:	91002000 	add	x0, x0, #0x8
ffffffff40035324:	d37df000 	lsl	x0, x0, #3
ffffffff40035328:	8b000020 	add	x0, x1, x0
ffffffff4003532c:	f9400400 	ldr	x0, [x0, #8]
ffffffff40035330:	f100001f 	cmp	x0, #0x0
ffffffff40035334:	54000220 	b.eq	ffffffff40035378 <fork+0x164>  // b.none
            np->ofile[i] = filedup(proc->ofile[i]);
ffffffff40035338:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003533c:	911e0000 	add	x0, x0, #0x780
ffffffff40035340:	f9400001 	ldr	x1, [x0]
ffffffff40035344:	b9802fe0 	ldrsw	x0, [sp, #44]
ffffffff40035348:	91002000 	add	x0, x0, #0x8
ffffffff4003534c:	d37df000 	lsl	x0, x0, #3
ffffffff40035350:	8b000020 	add	x0, x1, x0
ffffffff40035354:	f9400400 	ldr	x0, [x0, #8]
ffffffff40035358:	97fff42b 	bl	ffffffff40032404 <filedup>
ffffffff4003535c:	aa0003e2 	mov	x2, x0
ffffffff40035360:	f94013e1 	ldr	x1, [sp, #32]
ffffffff40035364:	b9802fe0 	ldrsw	x0, [sp, #44]
ffffffff40035368:	91002000 	add	x0, x0, #0x8
ffffffff4003536c:	d37df000 	lsl	x0, x0, #3
ffffffff40035370:	8b000020 	add	x0, x1, x0
ffffffff40035374:	f9000402 	str	x2, [x0, #8]
    for(i = 0; i < NOFILE; i++) {
ffffffff40035378:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff4003537c:	11000400 	add	w0, w0, #0x1
ffffffff40035380:	b9002fe0 	str	w0, [sp, #44]
ffffffff40035384:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40035388:	71003c1f 	cmp	w0, #0xf
ffffffff4003538c:	54fffc2d 	b.le	ffffffff40035310 <fork+0xfc>
        }
    }

    np->cwd = idup(proc->cwd);
ffffffff40035390:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035394:	911e0000 	add	x0, x0, #0x780
ffffffff40035398:	f9400000 	ldr	x0, [x0]
ffffffff4003539c:	f9406400 	ldr	x0, [x0, #200]
ffffffff400353a0:	97fff6c8 	bl	ffffffff40032ec0 <idup>
ffffffff400353a4:	aa0003e1 	mov	x1, x0
ffffffff400353a8:	f94013e0 	ldr	x0, [sp, #32]
ffffffff400353ac:	f9006401 	str	x1, [x0, #200]

    pid = np->pid;
ffffffff400353b0:	f94013e0 	ldr	x0, [sp, #32]
ffffffff400353b4:	b9401c00 	ldr	w0, [x0, #28]
ffffffff400353b8:	b9001fe0 	str	w0, [sp, #28]
    np->state = RUNNABLE;
ffffffff400353bc:	f94013e0 	ldr	x0, [sp, #32]
ffffffff400353c0:	52800061 	mov	w1, #0x3                   	// #3
ffffffff400353c4:	b9001801 	str	w1, [x0, #24]
    safestrcpy(np->name, proc->name, sizeof(proc->name));
ffffffff400353c8:	f94013e0 	ldr	x0, [sp, #32]
ffffffff400353cc:	91034003 	add	x3, x0, #0xd0
ffffffff400353d0:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400353d4:	911e0000 	add	x0, x0, #0x780
ffffffff400353d8:	f9400000 	ldr	x0, [x0]
ffffffff400353dc:	91034000 	add	x0, x0, #0xd0
ffffffff400353e0:	52800202 	mov	w2, #0x10                  	// #16
ffffffff400353e4:	aa0003e1 	mov	x1, x0
ffffffff400353e8:	aa0303e0 	mov	x0, x3
ffffffff400353ec:	97ffec01 	bl	ffffffff400303f0 <safestrcpy>

    return pid;
ffffffff400353f0:	b9401fe0 	ldr	w0, [sp, #28]
}
ffffffff400353f4:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff400353f8:	d65f03c0 	ret

ffffffff400353fc <exit>:

// Exit the current process.  Does not return.
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.
void exit(void)
{
ffffffff400353fc:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40035400:	910003fd 	mov	x29, sp
    struct proc *p;
    int fd;

    if(proc == initproc) {
ffffffff40035404:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035408:	911e0000 	add	x0, x0, #0x780
ffffffff4003540c:	f9400001 	ldr	x1, [x0]
ffffffff40035410:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035414:	911e2000 	add	x0, x0, #0x788
ffffffff40035418:	f9400000 	ldr	x0, [x0]
ffffffff4003541c:	eb00003f 	cmp	x1, x0
ffffffff40035420:	54000081 	b.ne	ffffffff40035430 <exit+0x34>  // b.any
        panic("init exiting");
ffffffff40035424:	d0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40035428:	9120c000 	add	x0, x0, #0x830
ffffffff4003542c:	97fff127 	bl	ffffffff400318c8 <panic>
    }

    // Close all open files.
    for(fd = 0; fd < NOFILE; fd++){
ffffffff40035430:	b90017ff 	str	wzr, [sp, #20]
ffffffff40035434:	1400001f 	b	ffffffff400354b0 <exit+0xb4>
        if(proc->ofile[fd]){
ffffffff40035438:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003543c:	911e0000 	add	x0, x0, #0x780
ffffffff40035440:	f9400001 	ldr	x1, [x0]
ffffffff40035444:	b98017e0 	ldrsw	x0, [sp, #20]
ffffffff40035448:	91002000 	add	x0, x0, #0x8
ffffffff4003544c:	d37df000 	lsl	x0, x0, #3
ffffffff40035450:	8b000020 	add	x0, x1, x0
ffffffff40035454:	f9400400 	ldr	x0, [x0, #8]
ffffffff40035458:	f100001f 	cmp	x0, #0x0
ffffffff4003545c:	54000240 	b.eq	ffffffff400354a4 <exit+0xa8>  // b.none
            fileclose(proc->ofile[fd]);
ffffffff40035460:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035464:	911e0000 	add	x0, x0, #0x780
ffffffff40035468:	f9400001 	ldr	x1, [x0]
ffffffff4003546c:	b98017e0 	ldrsw	x0, [sp, #20]
ffffffff40035470:	91002000 	add	x0, x0, #0x8
ffffffff40035474:	d37df000 	lsl	x0, x0, #3
ffffffff40035478:	8b000020 	add	x0, x1, x0
ffffffff4003547c:	f9400400 	ldr	x0, [x0, #8]
ffffffff40035480:	97fff3f9 	bl	ffffffff40032464 <fileclose>
            proc->ofile[fd] = 0;
ffffffff40035484:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035488:	911e0000 	add	x0, x0, #0x780
ffffffff4003548c:	f9400001 	ldr	x1, [x0]
ffffffff40035490:	b98017e0 	ldrsw	x0, [sp, #20]
ffffffff40035494:	91002000 	add	x0, x0, #0x8
ffffffff40035498:	d37df000 	lsl	x0, x0, #3
ffffffff4003549c:	8b000020 	add	x0, x1, x0
ffffffff400354a0:	f900041f 	str	xzr, [x0, #8]
    for(fd = 0; fd < NOFILE; fd++){
ffffffff400354a4:	b94017e0 	ldr	w0, [sp, #20]
ffffffff400354a8:	11000400 	add	w0, w0, #0x1
ffffffff400354ac:	b90017e0 	str	w0, [sp, #20]
ffffffff400354b0:	b94017e0 	ldr	w0, [sp, #20]
ffffffff400354b4:	71003c1f 	cmp	w0, #0xf
ffffffff400354b8:	54fffc0d 	b.le	ffffffff40035438 <exit+0x3c>
        }
    }

    iput(proc->cwd);
ffffffff400354bc:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400354c0:	911e0000 	add	x0, x0, #0x780
ffffffff400354c4:	f9400000 	ldr	x0, [x0]
ffffffff400354c8:	f9406400 	ldr	x0, [x0, #200]
ffffffff400354cc:	97fff717 	bl	ffffffff40033128 <iput>
    proc->cwd = 0;
ffffffff400354d0:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400354d4:	911e0000 	add	x0, x0, #0x780
ffffffff400354d8:	f9400000 	ldr	x0, [x0]
ffffffff400354dc:	f900641f 	str	xzr, [x0, #200]

    acquire(&ptable.lock);
ffffffff400354e0:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400354e4:	913d0000 	add	x0, x0, #0xf40
ffffffff400354e8:	940001e7 	bl	ffffffff40035c84 <acquire>

    // Parent might be sleeping in wait().
    wakeup1(proc->parent);
ffffffff400354ec:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400354f0:	911e0000 	add	x0, x0, #0x780
ffffffff400354f4:	f9400000 	ldr	x0, [x0]
ffffffff400354f8:	f9401000 	ldr	x0, [x0, #32]
ffffffff400354fc:	94000143 	bl	ffffffff40035a08 <wakeup1>

    // Pass abandoned children to init.
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff40035500:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40035504:	913e0000 	add	x0, x0, #0xf80
ffffffff40035508:	f9000fe0 	str	x0, [sp, #24]
ffffffff4003550c:	14000018 	b	ffffffff4003556c <exit+0x170>
        if(p->parent == proc){
ffffffff40035510:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035514:	f9401001 	ldr	x1, [x0, #32]
ffffffff40035518:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003551c:	911e0000 	add	x0, x0, #0x780
ffffffff40035520:	f9400000 	ldr	x0, [x0]
ffffffff40035524:	eb00003f 	cmp	x1, x0
ffffffff40035528:	540001c1 	b.ne	ffffffff40035560 <exit+0x164>  // b.any
            p->parent = initproc;
ffffffff4003552c:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035530:	911e2000 	add	x0, x0, #0x788
ffffffff40035534:	f9400001 	ldr	x1, [x0]
ffffffff40035538:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003553c:	f9001001 	str	x1, [x0, #32]

            if(p->state == ZOMBIE) {
ffffffff40035540:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035544:	b9401800 	ldr	w0, [x0, #24]
ffffffff40035548:	7100141f 	cmp	w0, #0x5
ffffffff4003554c:	540000a1 	b.ne	ffffffff40035560 <exit+0x164>  // b.any
                wakeup1(initproc);
ffffffff40035550:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035554:	911e2000 	add	x0, x0, #0x788
ffffffff40035558:	f9400000 	ldr	x0, [x0]
ffffffff4003555c:	9400012b 	bl	ffffffff40035a08 <wakeup1>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff40035560:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035564:	91038000 	add	x0, x0, #0xe0
ffffffff40035568:	f9000fe0 	str	x0, [sp, #24]
ffffffff4003556c:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40035570:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035574:	911e0000 	add	x0, x0, #0x780
ffffffff40035578:	eb00003f 	cmp	x1, x0
ffffffff4003557c:	54fffca3 	b.cc	ffffffff40035510 <exit+0x114>  // b.lo, b.ul, b.last
            }
        }
    }

    // Jump into the scheduler, never to return.
    proc->state = ZOMBIE;
ffffffff40035580:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035584:	911e0000 	add	x0, x0, #0x780
ffffffff40035588:	f9400000 	ldr	x0, [x0]
ffffffff4003558c:	528000a1 	mov	w1, #0x5                   	// #5
ffffffff40035590:	b9001801 	str	w1, [x0, #24]
    sched();
ffffffff40035594:	94000089 	bl	ffffffff400357b8 <sched>

    panic("zombie exit");
ffffffff40035598:	d0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003559c:	91210000 	add	x0, x0, #0x840
ffffffff400355a0:	97fff0ca 	bl	ffffffff400318c8 <panic>

ffffffff400355a4 <wait>:
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int wait(void)
{
ffffffff400355a4:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff400355a8:	910003fd 	mov	x29, sp
    struct proc *p;
    int havekids, pid;

    acquire(&ptable.lock);
ffffffff400355ac:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400355b0:	913d0000 	add	x0, x0, #0xf40
ffffffff400355b4:	940001b4 	bl	ffffffff40035c84 <acquire>

    for(;;){
        // Scan through table looking for zombie children.
        havekids = 0;
ffffffff400355b8:	b90017ff 	str	wzr, [sp, #20]

        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff400355bc:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400355c0:	913e0000 	add	x0, x0, #0xf80
ffffffff400355c4:	f9000fe0 	str	x0, [sp, #24]
ffffffff400355c8:	1400002c 	b	ffffffff40035678 <wait+0xd4>
            if(p->parent != proc) {
ffffffff400355cc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400355d0:	f9401001 	ldr	x1, [x0, #32]
ffffffff400355d4:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400355d8:	911e0000 	add	x0, x0, #0x780
ffffffff400355dc:	f9400000 	ldr	x0, [x0]
ffffffff400355e0:	eb00003f 	cmp	x1, x0
ffffffff400355e4:	54000421 	b.ne	ffffffff40035668 <wait+0xc4>  // b.any
                continue;
            }

            havekids = 1;
ffffffff400355e8:	52800020 	mov	w0, #0x1                   	// #1
ffffffff400355ec:	b90017e0 	str	w0, [sp, #20]

            if(p->state == ZOMBIE){
ffffffff400355f0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400355f4:	b9401800 	ldr	w0, [x0, #24]
ffffffff400355f8:	7100141f 	cmp	w0, #0x5
ffffffff400355fc:	54000381 	b.ne	ffffffff4003566c <wait+0xc8>  // b.any
                // Found one.
                pid = p->pid;
ffffffff40035600:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035604:	b9401c00 	ldr	w0, [x0, #28]
ffffffff40035608:	b90013e0 	str	w0, [sp, #16]
                free_page(p->kstack);
ffffffff4003560c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035610:	f9400800 	ldr	x0, [x0, #16]
ffffffff40035614:	97ffef85 	bl	ffffffff40031428 <free_page>
                p->kstack = 0;
ffffffff40035618:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003561c:	f900081f 	str	xzr, [x0, #16]
                freevm(p->pgdir);
ffffffff40035620:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035624:	f9400400 	ldr	x0, [x0, #8]
ffffffff40035628:	940013c7 	bl	ffffffff4003a544 <freevm>
                p->state = UNUSED;
ffffffff4003562c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035630:	b900181f 	str	wzr, [x0, #24]
                p->pid = 0;
ffffffff40035634:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035638:	b9001c1f 	str	wzr, [x0, #28]
                p->parent = 0;
ffffffff4003563c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035640:	f900101f 	str	xzr, [x0, #32]
                p->name[0] = 0;
ffffffff40035644:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035648:	3903401f 	strb	wzr, [x0, #208]
                p->killed = 0;
ffffffff4003564c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035650:	b900401f 	str	wzr, [x0, #64]
                release(&ptable.lock);
ffffffff40035654:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40035658:	913d0000 	add	x0, x0, #0xf40
ffffffff4003565c:	94000194 	bl	ffffffff40035cac <release>

                return pid;
ffffffff40035660:	b94013e0 	ldr	w0, [sp, #16]
ffffffff40035664:	14000020 	b	ffffffff400356e4 <wait+0x140>
                continue;
ffffffff40035668:	d503201f 	nop
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff4003566c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035670:	91038000 	add	x0, x0, #0xe0
ffffffff40035674:	f9000fe0 	str	x0, [sp, #24]
ffffffff40035678:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff4003567c:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035680:	911e0000 	add	x0, x0, #0x780
ffffffff40035684:	eb00003f 	cmp	x1, x0
ffffffff40035688:	54fffa23 	b.cc	ffffffff400355cc <wait+0x28>  // b.lo, b.ul, b.last
            }
        }

        // No point waiting if we don't have any children.
        if(!havekids || proc->killed){
ffffffff4003568c:	b94017e0 	ldr	w0, [sp, #20]
ffffffff40035690:	7100001f 	cmp	w0, #0x0
ffffffff40035694:	540000e0 	b.eq	ffffffff400356b0 <wait+0x10c>  // b.none
ffffffff40035698:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003569c:	911e0000 	add	x0, x0, #0x780
ffffffff400356a0:	f9400000 	ldr	x0, [x0]
ffffffff400356a4:	b9404000 	ldr	w0, [x0, #64]
ffffffff400356a8:	7100001f 	cmp	w0, #0x0
ffffffff400356ac:	540000c0 	b.eq	ffffffff400356c4 <wait+0x120>  // b.none
            release(&ptable.lock);
ffffffff400356b0:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400356b4:	913d0000 	add	x0, x0, #0xf40
ffffffff400356b8:	9400017d 	bl	ffffffff40035cac <release>
            return -1;
ffffffff400356bc:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff400356c0:	14000009 	b	ffffffff400356e4 <wait+0x140>
        }

        // Wait for children to exit.  (See wakeup1 call in proc_exit.)
        sleep(proc, &ptable.lock);  //DOC: wait-sleep
ffffffff400356c4:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400356c8:	911e0000 	add	x0, x0, #0x780
ffffffff400356cc:	f9400002 	ldr	x2, [x0]
ffffffff400356d0:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400356d4:	913d0001 	add	x1, x0, #0xf40
ffffffff400356d8:	aa0203e0 	mov	x0, x2
ffffffff400356dc:	94000093 	bl	ffffffff40035928 <sleep>
        havekids = 0;
ffffffff400356e0:	17ffffb6 	b	ffffffff400355b8 <wait+0x14>
    }
}
ffffffff400356e4:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff400356e8:	d65f03c0 	ret

ffffffff400356ec <scheduler>:
//  - choose a process to run
//  - swtch to start running that process
//  - eventually that process transfers control
//      via swtch back to the scheduler.
void scheduler(void)
{
ffffffff400356ec:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff400356f0:	910003fd 	mov	x29, sp
    struct proc *p;

    for(;;){
        // Enable interrupts on this processor.
        sti();
ffffffff400356f4:	97ffeb74 	bl	ffffffff400304c4 <sti>

        // Loop over process table looking for process to run.
        acquire(&ptable.lock);
ffffffff400356f8:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400356fc:	913d0000 	add	x0, x0, #0xf40
ffffffff40035700:	94000161 	bl	ffffffff40035c84 <acquire>

        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff40035704:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40035708:	913e0000 	add	x0, x0, #0xf80
ffffffff4003570c:	f9000fe0 	str	x0, [sp, #24]
ffffffff40035710:	14000021 	b	ffffffff40035794 <scheduler+0xa8>
            if(p->state != RUNNABLE) {
ffffffff40035714:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035718:	b9401800 	ldr	w0, [x0, #24]
ffffffff4003571c:	71000c1f 	cmp	w0, #0x3
ffffffff40035720:	54000321 	b.ne	ffffffff40035784 <scheduler+0x98>  // b.any
            }

            // Switch to chosen process.  It is the process's job
            // to release ptable.lock and then reacquire it
            // before jumping back to us.
            proc = p;
ffffffff40035724:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035728:	911e0000 	add	x0, x0, #0x780
ffffffff4003572c:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40035730:	f9000001 	str	x1, [x0]
            switchuvm(p);
ffffffff40035734:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035738:	94001288 	bl	ffffffff4003a158 <switchuvm>

            p->state = RUNNING;
ffffffff4003573c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035740:	52800081 	mov	w1, #0x4                   	// #4
ffffffff40035744:	b9001801 	str	w1, [x0, #24]

            swtch(&cpu->scheduler, proc->context);
ffffffff40035748:	d0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff4003574c:	913b6000 	add	x0, x0, #0xed8
ffffffff40035750:	f9400000 	ldr	x0, [x0]
ffffffff40035754:	91002002 	add	x2, x0, #0x8
ffffffff40035758:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003575c:	911e0000 	add	x0, x0, #0x780
ffffffff40035760:	f9400000 	ldr	x0, [x0]
ffffffff40035764:	f9401800 	ldr	x0, [x0, #48]
ffffffff40035768:	aa0003e1 	mov	x1, x0
ffffffff4003576c:	aa0203e0 	mov	x0, x2
ffffffff40035770:	9400015e 	bl	ffffffff40035ce8 <swtch>
            // Process is done running for now.
            // It should have changed its p->state before coming back.
            proc = 0;
ffffffff40035774:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035778:	911e0000 	add	x0, x0, #0x780
ffffffff4003577c:	f900001f 	str	xzr, [x0]
ffffffff40035780:	14000002 	b	ffffffff40035788 <scheduler+0x9c>
                continue;
ffffffff40035784:	d503201f 	nop
        for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff40035788:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003578c:	91038000 	add	x0, x0, #0xe0
ffffffff40035790:	f9000fe0 	str	x0, [sp, #24]
ffffffff40035794:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40035798:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003579c:	911e0000 	add	x0, x0, #0x780
ffffffff400357a0:	eb00003f 	cmp	x1, x0
ffffffff400357a4:	54fffb83 	b.cc	ffffffff40035714 <scheduler+0x28>  // b.lo, b.ul, b.last
        }

        release(&ptable.lock);
ffffffff400357a8:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400357ac:	913d0000 	add	x0, x0, #0xf40
ffffffff400357b0:	9400013f 	bl	ffffffff40035cac <release>
        sti();
ffffffff400357b4:	17ffffd0 	b	ffffffff400356f4 <scheduler+0x8>

ffffffff400357b8 <sched>:
}

// Enter scheduler.  Must hold only ptable.lock
// and have changed proc->state.
void sched(void)
{
ffffffff400357b8:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff400357bc:	910003fd 	mov	x29, sp
    int intena;

    //show_callstk ("sched");

    if(!holding(&ptable.lock)) {
ffffffff400357c0:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400357c4:	913d0000 	add	x0, x0, #0xf40
ffffffff400357c8:	94000142 	bl	ffffffff40035cd0 <holding>
ffffffff400357cc:	7100001f 	cmp	w0, #0x0
ffffffff400357d0:	54000081 	b.ne	ffffffff400357e0 <sched+0x28>  // b.any
        panic("sched ptable.lock");
ffffffff400357d4:	d0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400357d8:	91214000 	add	x0, x0, #0x850
ffffffff400357dc:	97fff03b 	bl	ffffffff400318c8 <panic>
    }

    if(cpu->ncli != 1) {
ffffffff400357e0:	d0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff400357e4:	913b6000 	add	x0, x0, #0xed8
ffffffff400357e8:	f9400000 	ldr	x0, [x0]
ffffffff400357ec:	b9401400 	ldr	w0, [x0, #20]
ffffffff400357f0:	7100041f 	cmp	w0, #0x1
ffffffff400357f4:	54000080 	b.eq	ffffffff40035804 <sched+0x4c>  // b.none
        panic("sched locks");
ffffffff400357f8:	d0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400357fc:	9121a000 	add	x0, x0, #0x868
ffffffff40035800:	97fff032 	bl	ffffffff400318c8 <panic>
    }

    if(proc->state == RUNNING) {
ffffffff40035804:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035808:	911e0000 	add	x0, x0, #0x780
ffffffff4003580c:	f9400000 	ldr	x0, [x0]
ffffffff40035810:	b9401800 	ldr	w0, [x0, #24]
ffffffff40035814:	7100101f 	cmp	w0, #0x4
ffffffff40035818:	54000081 	b.ne	ffffffff40035828 <sched+0x70>  // b.any
        panic("sched running");
ffffffff4003581c:	d0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40035820:	9121e000 	add	x0, x0, #0x878
ffffffff40035824:	97fff029 	bl	ffffffff400318c8 <panic>
    }

    if(int_enabled ()) {
ffffffff40035828:	97ffeb2a 	bl	ffffffff400304d0 <int_enabled>
ffffffff4003582c:	7100001f 	cmp	w0, #0x0
ffffffff40035830:	54000080 	b.eq	ffffffff40035840 <sched+0x88>  // b.none
        panic("sched interruptible");
ffffffff40035834:	d0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40035838:	91222000 	add	x0, x0, #0x888
ffffffff4003583c:	97fff023 	bl	ffffffff400318c8 <panic>
    }

    intena = cpu->intena;
ffffffff40035840:	d0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40035844:	913b6000 	add	x0, x0, #0xed8
ffffffff40035848:	f9400000 	ldr	x0, [x0]
ffffffff4003584c:	b9401800 	ldr	w0, [x0, #24]
ffffffff40035850:	b9001fe0 	str	w0, [sp, #28]
    swtch(&proc->context, cpu->scheduler);
ffffffff40035854:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035858:	911e0000 	add	x0, x0, #0x780
ffffffff4003585c:	f9400000 	ldr	x0, [x0]
ffffffff40035860:	9100c002 	add	x2, x0, #0x30
ffffffff40035864:	d0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40035868:	913b6000 	add	x0, x0, #0xed8
ffffffff4003586c:	f9400000 	ldr	x0, [x0]
ffffffff40035870:	f9400400 	ldr	x0, [x0, #8]
ffffffff40035874:	aa0003e1 	mov	x1, x0
ffffffff40035878:	aa0203e0 	mov	x0, x2
ffffffff4003587c:	9400011b 	bl	ffffffff40035ce8 <swtch>
    cpu->intena = intena;
ffffffff40035880:	d0000440 	adrp	x0, ffffffff400bf000 <icache+0x308>
ffffffff40035884:	913b6000 	add	x0, x0, #0xed8
ffffffff40035888:	f9400000 	ldr	x0, [x0]
ffffffff4003588c:	b9401fe1 	ldr	w1, [sp, #28]
ffffffff40035890:	b9001801 	str	w1, [x0, #24]
}
ffffffff40035894:	d503201f 	nop
ffffffff40035898:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff4003589c:	d65f03c0 	ret

ffffffff400358a0 <yield>:

// Give up the CPU for one scheduling round.
void yield(void)
{
ffffffff400358a0:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff400358a4:	910003fd 	mov	x29, sp
    acquire(&ptable.lock);  //DOC: yieldlock
ffffffff400358a8:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400358ac:	913d0000 	add	x0, x0, #0xf40
ffffffff400358b0:	940000f5 	bl	ffffffff40035c84 <acquire>
    proc->state = RUNNABLE;
ffffffff400358b4:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400358b8:	911e0000 	add	x0, x0, #0x780
ffffffff400358bc:	f9400000 	ldr	x0, [x0]
ffffffff400358c0:	52800061 	mov	w1, #0x3                   	// #3
ffffffff400358c4:	b9001801 	str	w1, [x0, #24]
    sched();
ffffffff400358c8:	97ffffbc 	bl	ffffffff400357b8 <sched>
    release(&ptable.lock);
ffffffff400358cc:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400358d0:	913d0000 	add	x0, x0, #0xf40
ffffffff400358d4:	940000f6 	bl	ffffffff40035cac <release>
}
ffffffff400358d8:	d503201f 	nop
ffffffff400358dc:	a8c17bfd 	ldp	x29, x30, [sp], #16
ffffffff400358e0:	d65f03c0 	ret

ffffffff400358e4 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void forkret(void)
{
ffffffff400358e4:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff400358e8:	910003fd 	mov	x29, sp
    static int first = 1;

    // Still holding ptable.lock from scheduler.
    release(&ptable.lock);
ffffffff400358ec:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400358f0:	913d0000 	add	x0, x0, #0xf40
ffffffff400358f4:	940000ee 	bl	ffffffff40035cac <release>

    if (first) {
ffffffff400358f8:	f0000020 	adrp	x0, ffffffff4003c000 <digits.0>
ffffffff400358fc:	91007000 	add	x0, x0, #0x1c
ffffffff40035900:	b9400000 	ldr	w0, [x0]
ffffffff40035904:	7100001f 	cmp	w0, #0x0
ffffffff40035908:	540000a0 	b.eq	ffffffff4003591c <forkret+0x38>  // b.none
        // Some initialization functions must be run in the context
        // of a regular process (e.g., they call sleep), and thus cannot
        // be run from main().
        first = 0;
ffffffff4003590c:	f0000020 	adrp	x0, ffffffff4003c000 <digits.0>
ffffffff40035910:	91007000 	add	x0, x0, #0x1c
ffffffff40035914:	b900001f 	str	wzr, [x0]
        initlog();
ffffffff40035918:	97fff94b 	bl	ffffffff40033e44 <initlog>
    }

    // Return to "caller", actually trapret (see allocproc).
}
ffffffff4003591c:	d503201f 	nop
ffffffff40035920:	a8c17bfd 	ldp	x29, x30, [sp], #16
ffffffff40035924:	d65f03c0 	ret

ffffffff40035928 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void sleep(void *chan, struct spinlock *lk)
{
ffffffff40035928:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff4003592c:	910003fd 	mov	x29, sp
ffffffff40035930:	f9000fe0 	str	x0, [sp, #24]
ffffffff40035934:	f9000be1 	str	x1, [sp, #16]
    //show_callstk("sleep");

    if(proc == 0) {
ffffffff40035938:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003593c:	911e0000 	add	x0, x0, #0x780
ffffffff40035940:	f9400000 	ldr	x0, [x0]
ffffffff40035944:	f100001f 	cmp	x0, #0x0
ffffffff40035948:	54000081 	b.ne	ffffffff40035958 <sleep+0x30>  // b.any
        panic("sleep");
ffffffff4003594c:	d0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40035950:	91228000 	add	x0, x0, #0x8a0
ffffffff40035954:	97ffefdd 	bl	ffffffff400318c8 <panic>
    }

    if(lk == 0) {
ffffffff40035958:	f9400be0 	ldr	x0, [sp, #16]
ffffffff4003595c:	f100001f 	cmp	x0, #0x0
ffffffff40035960:	54000081 	b.ne	ffffffff40035970 <sleep+0x48>  // b.any
        panic("sleep without lk");
ffffffff40035964:	d0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40035968:	9122a000 	add	x0, x0, #0x8a8
ffffffff4003596c:	97ffefd7 	bl	ffffffff400318c8 <panic>

    // Must acquire ptable.lock in order to change p->state and then call
    // sched. Once we hold ptable.lock, we can be guaranteed that we won't
    // miss any wakeup (wakeup runs with ptable.lock locked), so it's okay
    // to release lk.
    if(lk != &ptable.lock){  //DOC: sleeplock0
ffffffff40035970:	f9400be1 	ldr	x1, [sp, #16]
ffffffff40035974:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40035978:	913d0000 	add	x0, x0, #0xf40
ffffffff4003597c:	eb00003f 	cmp	x1, x0
ffffffff40035980:	540000c0 	b.eq	ffffffff40035998 <sleep+0x70>  // b.none
        acquire(&ptable.lock);  //DOC: sleeplock1
ffffffff40035984:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40035988:	913d0000 	add	x0, x0, #0xf40
ffffffff4003598c:	940000be 	bl	ffffffff40035c84 <acquire>
        release(lk);
ffffffff40035990:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40035994:	940000c6 	bl	ffffffff40035cac <release>
    }

    // Go to sleep.
    proc->chan = chan;
ffffffff40035998:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003599c:	911e0000 	add	x0, x0, #0x780
ffffffff400359a0:	f9400000 	ldr	x0, [x0]
ffffffff400359a4:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff400359a8:	f9001c01 	str	x1, [x0, #56]
    proc->state = SLEEPING;
ffffffff400359ac:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400359b0:	911e0000 	add	x0, x0, #0x780
ffffffff400359b4:	f9400000 	ldr	x0, [x0]
ffffffff400359b8:	52800041 	mov	w1, #0x2                   	// #2
ffffffff400359bc:	b9001801 	str	w1, [x0, #24]
    sched();
ffffffff400359c0:	97ffff7e 	bl	ffffffff400357b8 <sched>

    // Tidy up.
    proc->chan = 0;
ffffffff400359c4:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400359c8:	911e0000 	add	x0, x0, #0x780
ffffffff400359cc:	f9400000 	ldr	x0, [x0]
ffffffff400359d0:	f9001c1f 	str	xzr, [x0, #56]

    // Reacquire original lock.
    if(lk != &ptable.lock){  //DOC: sleeplock2
ffffffff400359d4:	f9400be1 	ldr	x1, [sp, #16]
ffffffff400359d8:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400359dc:	913d0000 	add	x0, x0, #0xf40
ffffffff400359e0:	eb00003f 	cmp	x1, x0
ffffffff400359e4:	540000c0 	b.eq	ffffffff400359fc <sleep+0xd4>  // b.none
        release(&ptable.lock);
ffffffff400359e8:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff400359ec:	913d0000 	add	x0, x0, #0xf40
ffffffff400359f0:	940000af 	bl	ffffffff40035cac <release>
        acquire(lk);
ffffffff400359f4:	f9400be0 	ldr	x0, [sp, #16]
ffffffff400359f8:	940000a3 	bl	ffffffff40035c84 <acquire>
    }
}
ffffffff400359fc:	d503201f 	nop
ffffffff40035a00:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40035a04:	d65f03c0 	ret

ffffffff40035a08 <wakeup1>:

//PAGEBREAK!
// Wake up all processes sleeping on chan. The ptable lock must be held.
static void wakeup1(void *chan)
{
ffffffff40035a08:	d10083ff 	sub	sp, sp, #0x20
ffffffff40035a0c:	f90007e0 	str	x0, [sp, #8]
    struct proc *p;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
ffffffff40035a10:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40035a14:	913e0000 	add	x0, x0, #0xf80
ffffffff40035a18:	f9000fe0 	str	x0, [sp, #24]
ffffffff40035a1c:	14000010 	b	ffffffff40035a5c <wakeup1+0x54>
        if(p->state == SLEEPING && p->chan == chan) {
ffffffff40035a20:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035a24:	b9401800 	ldr	w0, [x0, #24]
ffffffff40035a28:	7100081f 	cmp	w0, #0x2
ffffffff40035a2c:	54000121 	b.ne	ffffffff40035a50 <wakeup1+0x48>  // b.any
ffffffff40035a30:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035a34:	f9401c00 	ldr	x0, [x0, #56]
ffffffff40035a38:	f94007e1 	ldr	x1, [sp, #8]
ffffffff40035a3c:	eb00003f 	cmp	x1, x0
ffffffff40035a40:	54000081 	b.ne	ffffffff40035a50 <wakeup1+0x48>  // b.any
            p->state = RUNNABLE;
ffffffff40035a44:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035a48:	52800061 	mov	w1, #0x3                   	// #3
ffffffff40035a4c:	b9001801 	str	w1, [x0, #24]
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++) {
ffffffff40035a50:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035a54:	91038000 	add	x0, x0, #0xe0
ffffffff40035a58:	f9000fe0 	str	x0, [sp, #24]
ffffffff40035a5c:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40035a60:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035a64:	911e0000 	add	x0, x0, #0x780
ffffffff40035a68:	eb00003f 	cmp	x1, x0
ffffffff40035a6c:	54fffda3 	b.cc	ffffffff40035a20 <wakeup1+0x18>  // b.lo, b.ul, b.last
        }
    }
}
ffffffff40035a70:	d503201f 	nop
ffffffff40035a74:	d503201f 	nop
ffffffff40035a78:	910083ff 	add	sp, sp, #0x20
ffffffff40035a7c:	d65f03c0 	ret

ffffffff40035a80 <wakeup>:

// Wake up all processes sleeping on chan.
void wakeup(void *chan)
{
ffffffff40035a80:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40035a84:	910003fd 	mov	x29, sp
ffffffff40035a88:	f9000fe0 	str	x0, [sp, #24]
    acquire(&ptable.lock);
ffffffff40035a8c:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40035a90:	913d0000 	add	x0, x0, #0xf40
ffffffff40035a94:	9400007c 	bl	ffffffff40035c84 <acquire>
    wakeup1(chan);
ffffffff40035a98:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035a9c:	97ffffdb 	bl	ffffffff40035a08 <wakeup1>
    release(&ptable.lock);
ffffffff40035aa0:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40035aa4:	913d0000 	add	x0, x0, #0xf40
ffffffff40035aa8:	94000081 	bl	ffffffff40035cac <release>
}
ffffffff40035aac:	d503201f 	nop
ffffffff40035ab0:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40035ab4:	d65f03c0 	ret

ffffffff40035ab8 <kill>:

// Kill the process with the given pid. Process won't exit until it returns
// to user space (see trap in trap.c).
int kill(int pid)
{
ffffffff40035ab8:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40035abc:	910003fd 	mov	x29, sp
ffffffff40035ac0:	b9001fe0 	str	w0, [sp, #28]
    struct proc *p;

    acquire(&ptable.lock);
ffffffff40035ac4:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40035ac8:	913d0000 	add	x0, x0, #0xf40
ffffffff40035acc:	9400006e 	bl	ffffffff40035c84 <acquire>

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff40035ad0:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40035ad4:	913e0000 	add	x0, x0, #0xf80
ffffffff40035ad8:	f90017e0 	str	x0, [sp, #40]
ffffffff40035adc:	14000018 	b	ffffffff40035b3c <kill+0x84>
        if(p->pid == pid){
ffffffff40035ae0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40035ae4:	b9401c00 	ldr	w0, [x0, #28]
ffffffff40035ae8:	b9401fe1 	ldr	w1, [sp, #28]
ffffffff40035aec:	6b00003f 	cmp	w1, w0
ffffffff40035af0:	54000201 	b.ne	ffffffff40035b30 <kill+0x78>  // b.any
            p->killed = 1;
ffffffff40035af4:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40035af8:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40035afc:	b9004001 	str	w1, [x0, #64]

            // Wake process from sleep if necessary.
            if(p->state == SLEEPING) {
ffffffff40035b00:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40035b04:	b9401800 	ldr	w0, [x0, #24]
ffffffff40035b08:	7100081f 	cmp	w0, #0x2
ffffffff40035b0c:	54000081 	b.ne	ffffffff40035b1c <kill+0x64>  // b.any
                p->state = RUNNABLE;
ffffffff40035b10:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40035b14:	52800061 	mov	w1, #0x3                   	// #3
ffffffff40035b18:	b9001801 	str	w1, [x0, #24]
            }

            release(&ptable.lock);
ffffffff40035b1c:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40035b20:	913d0000 	add	x0, x0, #0xf40
ffffffff40035b24:	94000062 	bl	ffffffff40035cac <release>
            return 0;
ffffffff40035b28:	52800000 	mov	w0, #0x0                   	// #0
ffffffff40035b2c:	1400000d 	b	ffffffff40035b60 <kill+0xa8>
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff40035b30:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40035b34:	91038000 	add	x0, x0, #0xe0
ffffffff40035b38:	f90017e0 	str	x0, [sp, #40]
ffffffff40035b3c:	f94017e1 	ldr	x1, [sp, #40]
ffffffff40035b40:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035b44:	911e0000 	add	x0, x0, #0x780
ffffffff40035b48:	eb00003f 	cmp	x1, x0
ffffffff40035b4c:	54fffca3 	b.cc	ffffffff40035ae0 <kill+0x28>  // b.lo, b.ul, b.last
        }
    }

    release(&ptable.lock);
ffffffff40035b50:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40035b54:	913d0000 	add	x0, x0, #0xf40
ffffffff40035b58:	94000055 	bl	ffffffff40035cac <release>
    return -1;
ffffffff40035b5c:	12800000 	mov	w0, #0xffffffff            	// #-1
}
ffffffff40035b60:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff40035b64:	d65f03c0 	ret

ffffffff40035b68 <procdump>:

//PAGEBREAK: 36
// Print a process listing to console.  For debugging. Runs when user
// types ^P on console. No lock to avoid wedging a stuck machine further.
void procdump(void)
{
ffffffff40035b68:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40035b6c:	910003fd 	mov	x29, sp
    };

    struct proc *p;
    char *state;

    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff40035b70:	d0000540 	adrp	x0, ffffffff400df000 <page_refcount+0x1f110>
ffffffff40035b74:	913e0000 	add	x0, x0, #0xf80
ffffffff40035b78:	f9000fe0 	str	x0, [sp, #24]
ffffffff40035b7c:	1400002a 	b	ffffffff40035c24 <procdump+0xbc>
        if(p->state == UNUSED) {
ffffffff40035b80:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035b84:	b9401800 	ldr	w0, [x0, #24]
ffffffff40035b88:	7100001f 	cmp	w0, #0x0
ffffffff40035b8c:	54000440 	b.eq	ffffffff40035c14 <procdump+0xac>  // b.none
            continue;
        }

        if(p->state >= 0 && p->state < NELEM(states) && states[p->state]) {
ffffffff40035b90:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035b94:	b9401800 	ldr	w0, [x0, #24]
ffffffff40035b98:	7100141f 	cmp	w0, #0x5
ffffffff40035b9c:	54000228 	b.hi	ffffffff40035be0 <procdump+0x78>  // b.pmore
ffffffff40035ba0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035ba4:	b9401801 	ldr	w1, [x0, #24]
ffffffff40035ba8:	f0000020 	adrp	x0, ffffffff4003c000 <digits.0>
ffffffff40035bac:	91008000 	add	x0, x0, #0x20
ffffffff40035bb0:	2a0103e1 	mov	w1, w1
ffffffff40035bb4:	f8617800 	ldr	x0, [x0, x1, lsl #3]
ffffffff40035bb8:	f100001f 	cmp	x0, #0x0
ffffffff40035bbc:	54000120 	b.eq	ffffffff40035be0 <procdump+0x78>  // b.none
            state = states[p->state];
ffffffff40035bc0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035bc4:	b9401801 	ldr	w1, [x0, #24]
ffffffff40035bc8:	f0000020 	adrp	x0, ffffffff4003c000 <digits.0>
ffffffff40035bcc:	91008000 	add	x0, x0, #0x20
ffffffff40035bd0:	2a0103e1 	mov	w1, w1
ffffffff40035bd4:	f8617800 	ldr	x0, [x0, x1, lsl #3]
ffffffff40035bd8:	f9000be0 	str	x0, [sp, #16]
ffffffff40035bdc:	14000004 	b	ffffffff40035bec <procdump+0x84>
        } else {
            state = "???";
ffffffff40035be0:	d0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40035be4:	91230000 	add	x0, x0, #0x8c0
ffffffff40035be8:	f9000be0 	str	x0, [sp, #16]
        }

        cprintf("%d %s %s\n", p->pid, state, p->name);
ffffffff40035bec:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035bf0:	b9401c01 	ldr	w1, [x0, #28]
ffffffff40035bf4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035bf8:	91034000 	add	x0, x0, #0xd0
ffffffff40035bfc:	aa0003e3 	mov	x3, x0
ffffffff40035c00:	f9400be2 	ldr	x2, [sp, #16]
ffffffff40035c04:	d0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40035c08:	91232000 	add	x0, x0, #0x8c8
ffffffff40035c0c:	97ffee9a 	bl	ffffffff40031674 <cprintf>
ffffffff40035c10:	14000002 	b	ffffffff40035c18 <procdump+0xb0>
            continue;
ffffffff40035c14:	d503201f 	nop
    for(p = ptable.proc; p < &ptable.proc[NPROC]; p++){
ffffffff40035c18:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035c1c:	91038000 	add	x0, x0, #0xe0
ffffffff40035c20:	f9000fe0 	str	x0, [sp, #24]
ffffffff40035c24:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40035c28:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035c2c:	911e0000 	add	x0, x0, #0x780
ffffffff40035c30:	eb00003f 	cmp	x1, x0
ffffffff40035c34:	54fffa63 	b.cc	ffffffff40035b80 <procdump+0x18>  // b.lo, b.ul, b.last
    }

    show_callstk("procdump: \n");
ffffffff40035c38:	d0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40035c3c:	91236000 	add	x0, x0, #0x8d8
ffffffff40035c40:	97ffeaa7 	bl	ffffffff400306dc <show_callstk>
}
ffffffff40035c44:	d503201f 	nop
ffffffff40035c48:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40035c4c:	d65f03c0 	ret

ffffffff40035c50 <initlock>:
#include "mmu.h"
#include "proc.h"
#include "spinlock.h"

void initlock(struct spinlock *lk, char *name)
{
ffffffff40035c50:	d10043ff 	sub	sp, sp, #0x10
ffffffff40035c54:	f90007e0 	str	x0, [sp, #8]
ffffffff40035c58:	f90003e1 	str	x1, [sp]
    lk->name = name;
ffffffff40035c5c:	f94007e0 	ldr	x0, [sp, #8]
ffffffff40035c60:	f94003e1 	ldr	x1, [sp]
ffffffff40035c64:	f9000401 	str	x1, [x0, #8]
    lk->locked = 0;
ffffffff40035c68:	f94007e0 	ldr	x0, [sp, #8]
ffffffff40035c6c:	b900001f 	str	wzr, [x0]
    lk->cpu = 0;
ffffffff40035c70:	f94007e0 	ldr	x0, [sp, #8]
ffffffff40035c74:	f900081f 	str	xzr, [x0, #16]
}
ffffffff40035c78:	d503201f 	nop
ffffffff40035c7c:	910043ff 	add	sp, sp, #0x10
ffffffff40035c80:	d65f03c0 	ret

ffffffff40035c84 <acquire>:
// Acquire the lock.
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void acquire(struct spinlock *lk)
{
ffffffff40035c84:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40035c88:	910003fd 	mov	x29, sp
ffffffff40035c8c:	f9000fe0 	str	x0, [sp, #24]
    pushcli();		// disable interrupts to avoid deadlock.
ffffffff40035c90:	97ffea1a 	bl	ffffffff400304f8 <pushcli>
    lk->locked = 1;	// set the lock status to make the kernel happy
ffffffff40035c94:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035c98:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40035c9c:	b9000001 	str	w1, [x0]
    // Record info about lock acquisition for debugging.
    lk->cpu = cpu;
    getcallerpcs(get_fp(), lk->pcs);

#endif
}
ffffffff40035ca0:	d503201f 	nop
ffffffff40035ca4:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40035ca8:	d65f03c0 	ret

ffffffff40035cac <release>:

// Release the lock.
void release(struct spinlock *lk)
{
ffffffff40035cac:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40035cb0:	910003fd 	mov	x29, sp
ffffffff40035cb4:	f9000fe0 	str	x0, [sp, #24]
    // The xchg being asm volatile ensures gcc emits it after
    // the above assignments (and after the critical section).
    xchg(&lk->locked, 0);
#endif

    lk->locked = 0; // set the lock state to keep the kernel happy
ffffffff40035cb8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035cbc:	b900001f 	str	wzr, [x0]
    popcli();
ffffffff40035cc0:	97ffea23 	bl	ffffffff4003054c <popcli>
}
ffffffff40035cc4:	d503201f 	nop
ffffffff40035cc8:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40035ccc:	d65f03c0 	ret

ffffffff40035cd0 <holding>:


// Check whether this cpu is holding the lock.
int holding(struct spinlock *lock)
{
ffffffff40035cd0:	d10043ff 	sub	sp, sp, #0x10
ffffffff40035cd4:	f90007e0 	str	x0, [sp, #8]
    return lock->locked; // && lock->cpu == cpus;
ffffffff40035cd8:	f94007e0 	ldr	x0, [sp, #8]
ffffffff40035cdc:	b9400000 	ldr	w0, [x0]
}
ffffffff40035ce0:	910043ff 	add	sp, sp, #0x10
ffffffff40035ce4:	d65f03c0 	ret

ffffffff40035ce8 <swtch>:
ffffffff40035ce8:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff40035cec:	a9bf73fb 	stp	x27, x28, [sp, #-16]!
ffffffff40035cf0:	a9bf6bf9 	stp	x25, x26, [sp, #-16]!
ffffffff40035cf4:	a9bf63f7 	stp	x23, x24, [sp, #-16]!
ffffffff40035cf8:	a9bf5bf5 	stp	x21, x22, [sp, #-16]!
ffffffff40035cfc:	a9bf53f3 	stp	x19, x20, [sp, #-16]!
ffffffff40035d00:	a9bf4bf1 	stp	x17, x18, [sp, #-16]!
ffffffff40035d04:	a9bf43ef 	stp	x15, x16, [sp, #-16]!
ffffffff40035d08:	a9bf3bed 	stp	x13, x14, [sp, #-16]!
ffffffff40035d0c:	a9bf33eb 	stp	x11, x12, [sp, #-16]!
ffffffff40035d10:	a9bf2be9 	stp	x9, x10, [sp, #-16]!
ffffffff40035d14:	a9bf23e7 	stp	x7, x8, [sp, #-16]!
ffffffff40035d18:	a9bf1be5 	stp	x5, x6, [sp, #-16]!
ffffffff40035d1c:	f81f8fe4 	str	x4, [sp, #-8]!
ffffffff40035d20:	910003f5 	mov	x21, sp
ffffffff40035d24:	f9000015 	str	x21, [x0]
ffffffff40035d28:	9100003f 	mov	sp, x1
ffffffff40035d2c:	f84087e4 	ldr	x4, [sp], #8
ffffffff40035d30:	a8c11be5 	ldp	x5, x6, [sp], #16
ffffffff40035d34:	a8c123e7 	ldp	x7, x8, [sp], #16
ffffffff40035d38:	a8c12be9 	ldp	x9, x10, [sp], #16
ffffffff40035d3c:	a8c133eb 	ldp	x11, x12, [sp], #16
ffffffff40035d40:	a8c13bed 	ldp	x13, x14, [sp], #16
ffffffff40035d44:	a8c143ef 	ldp	x15, x16, [sp], #16
ffffffff40035d48:	a8c14bf1 	ldp	x17, x18, [sp], #16
ffffffff40035d4c:	a8c153f3 	ldp	x19, x20, [sp], #16
ffffffff40035d50:	a8c15bf5 	ldp	x21, x22, [sp], #16
ffffffff40035d54:	a8c163f7 	ldp	x23, x24, [sp], #16
ffffffff40035d58:	a8c16bf9 	ldp	x25, x26, [sp], #16
ffffffff40035d5c:	a8c173fb 	ldp	x27, x28, [sp], #16
ffffffff40035d60:	a8c17bfd 	ldp	x29, x30, [sp], #16
ffffffff40035d64:	d61f03c0 	br	x30

ffffffff40035d68 <fetchint>:
// in r0. Arguments on the stack, from the user call to the C library
// system call function. The saved user sp points to the first argument.

// Fetch the int at addr from the current process.
int fetchint(uint64 addr, long *ip)
{
ffffffff40035d68:	d10043ff 	sub	sp, sp, #0x10
ffffffff40035d6c:	f90007e0 	str	x0, [sp, #8]
ffffffff40035d70:	f90003e1 	str	x1, [sp]
    if(addr >= proc->sz || addr+8 > proc->sz) {
ffffffff40035d74:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035d78:	911e0000 	add	x0, x0, #0x780
ffffffff40035d7c:	f9400000 	ldr	x0, [x0]
ffffffff40035d80:	f9400000 	ldr	x0, [x0]
ffffffff40035d84:	f94007e1 	ldr	x1, [sp, #8]
ffffffff40035d88:	eb00003f 	cmp	x1, x0
ffffffff40035d8c:	54000122 	b.cs	ffffffff40035db0 <fetchint+0x48>  // b.hs, b.nlast
ffffffff40035d90:	f94007e0 	ldr	x0, [sp, #8]
ffffffff40035d94:	91002001 	add	x1, x0, #0x8
ffffffff40035d98:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035d9c:	911e0000 	add	x0, x0, #0x780
ffffffff40035da0:	f9400000 	ldr	x0, [x0]
ffffffff40035da4:	f9400000 	ldr	x0, [x0]
ffffffff40035da8:	eb00003f 	cmp	x1, x0
ffffffff40035dac:	54000069 	b.ls	ffffffff40035db8 <fetchint+0x50>  // b.plast
        return -1;
ffffffff40035db0:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40035db4:	14000006 	b	ffffffff40035dcc <fetchint+0x64>
    }

    *ip = *(long*)(addr);
ffffffff40035db8:	f94007e0 	ldr	x0, [sp, #8]
ffffffff40035dbc:	f9400001 	ldr	x1, [x0]
ffffffff40035dc0:	f94003e0 	ldr	x0, [sp]
ffffffff40035dc4:	f9000001 	str	x1, [x0]
    return 0;
ffffffff40035dc8:	52800000 	mov	w0, #0x0                   	// #0
}
ffffffff40035dcc:	910043ff 	add	sp, sp, #0x10
ffffffff40035dd0:	d65f03c0 	ret

ffffffff40035dd4 <fetchstr>:

// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int fetchstr(uint64 addr, char **pp)
{
ffffffff40035dd4:	d10083ff 	sub	sp, sp, #0x20
ffffffff40035dd8:	f90007e0 	str	x0, [sp, #8]
ffffffff40035ddc:	f90003e1 	str	x1, [sp]
    char *s, *ep;

    if(addr >= proc->sz) {
ffffffff40035de0:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035de4:	911e0000 	add	x0, x0, #0x780
ffffffff40035de8:	f9400000 	ldr	x0, [x0]
ffffffff40035dec:	f9400000 	ldr	x0, [x0]
ffffffff40035df0:	f94007e1 	ldr	x1, [sp, #8]
ffffffff40035df4:	eb00003f 	cmp	x1, x0
ffffffff40035df8:	54000063 	b.cc	ffffffff40035e04 <fetchstr+0x30>  // b.lo, b.ul, b.last
        return -1;
ffffffff40035dfc:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40035e00:	1400001e 	b	ffffffff40035e78 <fetchstr+0xa4>
    }

    *pp = (char*)addr;
ffffffff40035e04:	f94007e1 	ldr	x1, [sp, #8]
ffffffff40035e08:	f94003e0 	ldr	x0, [sp]
ffffffff40035e0c:	f9000001 	str	x1, [x0]
    ep = (char*)proc->sz;
ffffffff40035e10:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035e14:	911e0000 	add	x0, x0, #0x780
ffffffff40035e18:	f9400000 	ldr	x0, [x0]
ffffffff40035e1c:	f9400000 	ldr	x0, [x0]
ffffffff40035e20:	f9000be0 	str	x0, [sp, #16]

    for(s = *pp; s < ep; s++) {
ffffffff40035e24:	f94003e0 	ldr	x0, [sp]
ffffffff40035e28:	f9400000 	ldr	x0, [x0]
ffffffff40035e2c:	f9000fe0 	str	x0, [sp, #24]
ffffffff40035e30:	1400000d 	b	ffffffff40035e64 <fetchstr+0x90>
        if(*s == 0) {
ffffffff40035e34:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035e38:	39400000 	ldrb	w0, [x0]
ffffffff40035e3c:	7100001f 	cmp	w0, #0x0
ffffffff40035e40:	540000c1 	b.ne	ffffffff40035e58 <fetchstr+0x84>  // b.any
            return s - *pp;
ffffffff40035e44:	f94003e0 	ldr	x0, [sp]
ffffffff40035e48:	f9400000 	ldr	x0, [x0]
ffffffff40035e4c:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40035e50:	cb000020 	sub	x0, x1, x0
ffffffff40035e54:	14000009 	b	ffffffff40035e78 <fetchstr+0xa4>
    for(s = *pp; s < ep; s++) {
ffffffff40035e58:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40035e5c:	91000400 	add	x0, x0, #0x1
ffffffff40035e60:	f9000fe0 	str	x0, [sp, #24]
ffffffff40035e64:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40035e68:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40035e6c:	eb00003f 	cmp	x1, x0
ffffffff40035e70:	54fffe23 	b.cc	ffffffff40035e34 <fetchstr+0x60>  // b.lo, b.ul, b.last
        }
    }

    return -1;
ffffffff40035e74:	12800000 	mov	w0, #0xffffffff            	// #-1
}
ffffffff40035e78:	910083ff 	add	sp, sp, #0x20
ffffffff40035e7c:	d65f03c0 	ret

ffffffff40035e80 <argint>:

// Fetch the nth (starting from 0) 32-bit system call argument.
// In our ABI, r0 contains system call index, r1-r4 contain parameters.
// now we support system calls with at most 4 parameters.
int argint(int n, long *ip)
{
ffffffff40035e80:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40035e84:	910003fd 	mov	x29, sp
ffffffff40035e88:	b9001fe0 	str	w0, [sp, #28]
ffffffff40035e8c:	f9000be1 	str	x1, [sp, #16]
    if (n > 3) {
ffffffff40035e90:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40035e94:	71000c1f 	cmp	w0, #0x3
ffffffff40035e98:	5400008d 	b.le	ffffffff40035ea8 <argint+0x28>
        panic ("too many system call parameters\n");
ffffffff40035e9c:	d0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40035ea0:	91246000 	add	x0, x0, #0x918
ffffffff40035ea4:	97ffee89 	bl	ffffffff400318c8 <panic>
    }

    *ip = *(&proc->tf->r1 + n);
ffffffff40035ea8:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035eac:	911e0000 	add	x0, x0, #0x780
ffffffff40035eb0:	f9400000 	ldr	x0, [x0]
ffffffff40035eb4:	f9401400 	ldr	x0, [x0, #40]
ffffffff40035eb8:	91008001 	add	x1, x0, #0x20
ffffffff40035ebc:	b9801fe0 	ldrsw	x0, [sp, #28]
ffffffff40035ec0:	d37df000 	lsl	x0, x0, #3
ffffffff40035ec4:	8b000020 	add	x0, x1, x0
ffffffff40035ec8:	f9400000 	ldr	x0, [x0]
ffffffff40035ecc:	aa0003e1 	mov	x1, x0
ffffffff40035ed0:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40035ed4:	f9000001 	str	x1, [x0]

    return 0;
ffffffff40035ed8:	52800000 	mov	w0, #0x0                   	// #0
}
ffffffff40035edc:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40035ee0:	d65f03c0 	ret

ffffffff40035ee4 <argptr>:

// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size n bytes.  Check that the pointer
// lies within the process address space.
int argptr(int n, char **pp, int size)
{
ffffffff40035ee4:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40035ee8:	910003fd 	mov	x29, sp
ffffffff40035eec:	b9001fe0 	str	w0, [sp, #28]
ffffffff40035ef0:	f9000be1 	str	x1, [sp, #16]
ffffffff40035ef4:	b9001be2 	str	w2, [sp, #24]
    long i;

    if(argint(n, &i) < 0) {
ffffffff40035ef8:	9100a3e0 	add	x0, sp, #0x28
ffffffff40035efc:	aa0003e1 	mov	x1, x0
ffffffff40035f00:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40035f04:	97ffffdf 	bl	ffffffff40035e80 <argint>
ffffffff40035f08:	7100001f 	cmp	w0, #0x0
ffffffff40035f0c:	5400006a 	b.ge	ffffffff40035f18 <argptr+0x34>  // b.tcont
        return -1;
ffffffff40035f10:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40035f14:	14000018 	b	ffffffff40035f74 <argptr+0x90>
    }

    if((uint64)i >= proc->sz || (uint64)i+size > proc->sz) {
ffffffff40035f18:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035f1c:	911e0000 	add	x0, x0, #0x780
ffffffff40035f20:	f9400000 	ldr	x0, [x0]
ffffffff40035f24:	f9400000 	ldr	x0, [x0]
ffffffff40035f28:	f94017e1 	ldr	x1, [sp, #40]
ffffffff40035f2c:	eb01001f 	cmp	x0, x1
ffffffff40035f30:	54000149 	b.ls	ffffffff40035f58 <argptr+0x74>  // b.plast
ffffffff40035f34:	b9801be0 	ldrsw	x0, [sp, #24]
ffffffff40035f38:	f94017e1 	ldr	x1, [sp, #40]
ffffffff40035f3c:	8b010001 	add	x1, x0, x1
ffffffff40035f40:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035f44:	911e0000 	add	x0, x0, #0x780
ffffffff40035f48:	f9400000 	ldr	x0, [x0]
ffffffff40035f4c:	f9400000 	ldr	x0, [x0]
ffffffff40035f50:	eb00003f 	cmp	x1, x0
ffffffff40035f54:	54000069 	b.ls	ffffffff40035f60 <argptr+0x7c>  // b.plast
        return -1;
ffffffff40035f58:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40035f5c:	14000006 	b	ffffffff40035f74 <argptr+0x90>
    }

    *pp = (char*)i;
ffffffff40035f60:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40035f64:	aa0003e1 	mov	x1, x0
ffffffff40035f68:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40035f6c:	f9000001 	str	x1, [x0]
    return 0;
ffffffff40035f70:	52800000 	mov	w0, #0x0                   	// #0
}
ffffffff40035f74:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff40035f78:	d65f03c0 	ret

ffffffff40035f7c <argstr>:
// Fetch the nth word-sized system call argument as a string pointer.
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int argstr(int n, char **pp)
{
ffffffff40035f7c:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40035f80:	910003fd 	mov	x29, sp
ffffffff40035f84:	b9001fe0 	str	w0, [sp, #28]
ffffffff40035f88:	f9000be1 	str	x1, [sp, #16]
    long addr;

    if(argint(n, &addr) < 0) {
ffffffff40035f8c:	9100a3e0 	add	x0, sp, #0x28
ffffffff40035f90:	aa0003e1 	mov	x1, x0
ffffffff40035f94:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40035f98:	97ffffba 	bl	ffffffff40035e80 <argint>
ffffffff40035f9c:	7100001f 	cmp	w0, #0x0
ffffffff40035fa0:	5400006a 	b.ge	ffffffff40035fac <argstr+0x30>  // b.tcont
        return -1;
ffffffff40035fa4:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40035fa8:	14000004 	b	ffffffff40035fb8 <argstr+0x3c>
    }

    return fetchstr(addr, pp);
ffffffff40035fac:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40035fb0:	f9400be1 	ldr	x1, [sp, #16]
ffffffff40035fb4:	97ffff88 	bl	ffffffff40035dd4 <fetchstr>
}
ffffffff40035fb8:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff40035fbc:	d65f03c0 	ret

ffffffff40035fc0 <syscall>:
        [SYS_mkdir]   sys_mkdir,
        [SYS_close]   sys_close,
};

void syscall(void)
{
ffffffff40035fc0:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40035fc4:	910003fd 	mov	x29, sp
    int num;
    int ret;

    num = proc->tf->r0;
ffffffff40035fc8:	d0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40035fcc:	911e0000 	add	x0, x0, #0x780
ffffffff40035fd0:	f9400000 	ldr	x0, [x0]
ffffffff40035fd4:	f9401400 	ldr	x0, [x0, #40]
ffffffff40035fd8:	f9400c00 	ldr	x0, [x0, #24]
ffffffff40035fdc:	b9001fe0 	str	w0, [sp, #28]

    //cprintf ("syscall(%d) from %s(%d)\n", num, proc->name, proc->pid);

    if((num > 0) && (num <= NELEM(syscalls)) && syscalls[num]) {
ffffffff40035fe0:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40035fe4:	7100001f 	cmp	w0, #0x0
ffffffff40035fe8:	5400034d 	b.le	ffffffff40036050 <syscall+0x90>
ffffffff40035fec:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40035ff0:	7100581f 	cmp	w0, #0x16
ffffffff40035ff4:	540002e8 	b.hi	ffffffff40036050 <syscall+0x90>  // b.pmore
ffffffff40035ff8:	f0000020 	adrp	x0, ffffffff4003c000 <digits.0>
ffffffff40035ffc:	91014000 	add	x0, x0, #0x50
ffffffff40036000:	b9801fe1 	ldrsw	x1, [sp, #28]
ffffffff40036004:	f8617800 	ldr	x0, [x0, x1, lsl #3]
ffffffff40036008:	f100001f 	cmp	x0, #0x0
ffffffff4003600c:	54000220 	b.eq	ffffffff40036050 <syscall+0x90>  // b.none
        ret = syscalls[num]();
ffffffff40036010:	d0000020 	adrp	x0, ffffffff4003c000 <digits.0>
ffffffff40036014:	91014000 	add	x0, x0, #0x50
ffffffff40036018:	b9801fe1 	ldrsw	x1, [sp, #28]
ffffffff4003601c:	f8617800 	ldr	x0, [x0, x1, lsl #3]
ffffffff40036020:	d63f0000 	blr	x0
ffffffff40036024:	b9001be0 	str	w0, [sp, #24]

        // in ARM, parameters to main (argc, argv) are passed in r0 and r1
        // do not set the return value if it is SYS_exec (the user program
        // anyway does not expect us to return anything).
        if (num != SYS_exec) {
ffffffff40036028:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003602c:	71001c1f 	cmp	w0, #0x7
ffffffff40036030:	54000380 	b.eq	ffffffff400360a0 <syscall+0xe0>  // b.none
            proc->tf->r0 = ret;
ffffffff40036034:	b0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40036038:	911e0000 	add	x0, x0, #0x780
ffffffff4003603c:	f9400000 	ldr	x0, [x0]
ffffffff40036040:	f9401400 	ldr	x0, [x0, #40]
ffffffff40036044:	b9801be1 	ldrsw	x1, [sp, #24]
ffffffff40036048:	f9000c01 	str	x1, [x0, #24]
        if (num != SYS_exec) {
ffffffff4003604c:	14000015 	b	ffffffff400360a0 <syscall+0xe0>
        }
    } else {
        cprintf("%d %s: unknown sys call %d\n", proc->pid, proc->name, num);
ffffffff40036050:	b0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40036054:	911e0000 	add	x0, x0, #0x780
ffffffff40036058:	f9400000 	ldr	x0, [x0]
ffffffff4003605c:	b9401c01 	ldr	w1, [x0, #28]
ffffffff40036060:	b0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40036064:	911e0000 	add	x0, x0, #0x780
ffffffff40036068:	f9400000 	ldr	x0, [x0]
ffffffff4003606c:	91034000 	add	x0, x0, #0xd0
ffffffff40036070:	b9401fe3 	ldr	w3, [sp, #28]
ffffffff40036074:	aa0003e2 	mov	x2, x0
ffffffff40036078:	b0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003607c:	91250000 	add	x0, x0, #0x940
ffffffff40036080:	97ffed7d 	bl	ffffffff40031674 <cprintf>
        proc->tf->r0 = -1;
ffffffff40036084:	b0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40036088:	911e0000 	add	x0, x0, #0x780
ffffffff4003608c:	f9400000 	ldr	x0, [x0]
ffffffff40036090:	f9401400 	ldr	x0, [x0, #40]
ffffffff40036094:	92800001 	mov	x1, #0xffffffffffffffff    	// #-1
ffffffff40036098:	f9000c01 	str	x1, [x0, #24]
    }
}
ffffffff4003609c:	d503201f 	nop
ffffffff400360a0:	d503201f 	nop
ffffffff400360a4:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff400360a8:	d65f03c0 	ret

ffffffff400360ac <argfd>:
#include "fcntl.h"

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int argfd(int n, int *pfd, struct file **pf)
{
ffffffff400360ac:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff400360b0:	910003fd 	mov	x29, sp
ffffffff400360b4:	b9002fe0 	str	w0, [sp, #44]
ffffffff400360b8:	f90013e1 	str	x1, [sp, #32]
ffffffff400360bc:	f9000fe2 	str	x2, [sp, #24]
    long fd;
    struct file *f;

    if(argint(n, &fd) < 0) {
ffffffff400360c0:	9100c3e0 	add	x0, sp, #0x30
ffffffff400360c4:	aa0003e1 	mov	x1, x0
ffffffff400360c8:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff400360cc:	97ffff6d 	bl	ffffffff40035e80 <argint>
ffffffff400360d0:	7100001f 	cmp	w0, #0x0
ffffffff400360d4:	5400006a 	b.ge	ffffffff400360e0 <argfd+0x34>  // b.tcont
        return -1;
ffffffff400360d8:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff400360dc:	14000023 	b	ffffffff40036168 <argfd+0xbc>
    }

    if(fd < 0 || fd >= NOFILE || (f=proc->ofile[fd]) == 0) {
ffffffff400360e0:	f9401be0 	ldr	x0, [sp, #48]
ffffffff400360e4:	f100001f 	cmp	x0, #0x0
ffffffff400360e8:	5400020b 	b.lt	ffffffff40036128 <argfd+0x7c>  // b.tstop
ffffffff400360ec:	f9401be0 	ldr	x0, [sp, #48]
ffffffff400360f0:	f1003c1f 	cmp	x0, #0xf
ffffffff400360f4:	540001ac 	b.gt	ffffffff40036128 <argfd+0x7c>
ffffffff400360f8:	b0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400360fc:	911e0000 	add	x0, x0, #0x780
ffffffff40036100:	f9400001 	ldr	x1, [x0]
ffffffff40036104:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40036108:	91002000 	add	x0, x0, #0x8
ffffffff4003610c:	d37df000 	lsl	x0, x0, #3
ffffffff40036110:	8b000020 	add	x0, x1, x0
ffffffff40036114:	f9400400 	ldr	x0, [x0, #8]
ffffffff40036118:	f9001fe0 	str	x0, [sp, #56]
ffffffff4003611c:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40036120:	f100001f 	cmp	x0, #0x0
ffffffff40036124:	54000061 	b.ne	ffffffff40036130 <argfd+0x84>  // b.any
        return -1;
ffffffff40036128:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff4003612c:	1400000f 	b	ffffffff40036168 <argfd+0xbc>
    }

    if(pfd) {
ffffffff40036130:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40036134:	f100001f 	cmp	x0, #0x0
ffffffff40036138:	540000a0 	b.eq	ffffffff4003614c <argfd+0xa0>  // b.none
        *pfd = fd;
ffffffff4003613c:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40036140:	2a0003e1 	mov	w1, w0
ffffffff40036144:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40036148:	b9000001 	str	w1, [x0]
    }

    if(pf) {
ffffffff4003614c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40036150:	f100001f 	cmp	x0, #0x0
ffffffff40036154:	54000080 	b.eq	ffffffff40036164 <argfd+0xb8>  // b.none
        *pf = f;
ffffffff40036158:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003615c:	f9401fe1 	ldr	x1, [sp, #56]
ffffffff40036160:	f9000001 	str	x1, [x0]
    }

    return 0;
ffffffff40036164:	52800000 	mov	w0, #0x0                   	// #0
}
ffffffff40036168:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff4003616c:	d65f03c0 	ret

ffffffff40036170 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int fdalloc(struct file *f)
{
ffffffff40036170:	d10083ff 	sub	sp, sp, #0x20
ffffffff40036174:	f90007e0 	str	x0, [sp, #8]
    int fd;

    for(fd = 0; fd < NOFILE; fd++){
ffffffff40036178:	b9001fff 	str	wzr, [sp, #28]
ffffffff4003617c:	14000019 	b	ffffffff400361e0 <fdalloc+0x70>
        if(proc->ofile[fd] == 0){
ffffffff40036180:	b0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40036184:	911e0000 	add	x0, x0, #0x780
ffffffff40036188:	f9400001 	ldr	x1, [x0]
ffffffff4003618c:	b9801fe0 	ldrsw	x0, [sp, #28]
ffffffff40036190:	91002000 	add	x0, x0, #0x8
ffffffff40036194:	d37df000 	lsl	x0, x0, #3
ffffffff40036198:	8b000020 	add	x0, x1, x0
ffffffff4003619c:	f9400400 	ldr	x0, [x0, #8]
ffffffff400361a0:	f100001f 	cmp	x0, #0x0
ffffffff400361a4:	54000181 	b.ne	ffffffff400361d4 <fdalloc+0x64>  // b.any
            proc->ofile[fd] = f;
ffffffff400361a8:	b0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400361ac:	911e0000 	add	x0, x0, #0x780
ffffffff400361b0:	f9400001 	ldr	x1, [x0]
ffffffff400361b4:	b9801fe0 	ldrsw	x0, [sp, #28]
ffffffff400361b8:	91002000 	add	x0, x0, #0x8
ffffffff400361bc:	d37df000 	lsl	x0, x0, #3
ffffffff400361c0:	8b000020 	add	x0, x1, x0
ffffffff400361c4:	f94007e1 	ldr	x1, [sp, #8]
ffffffff400361c8:	f9000401 	str	x1, [x0, #8]
            return fd;
ffffffff400361cc:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff400361d0:	14000008 	b	ffffffff400361f0 <fdalloc+0x80>
    for(fd = 0; fd < NOFILE; fd++){
ffffffff400361d4:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff400361d8:	11000400 	add	w0, w0, #0x1
ffffffff400361dc:	b9001fe0 	str	w0, [sp, #28]
ffffffff400361e0:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff400361e4:	71003c1f 	cmp	w0, #0xf
ffffffff400361e8:	54fffccd 	b.le	ffffffff40036180 <fdalloc+0x10>
        }
    }

    return -1;
ffffffff400361ec:	12800000 	mov	w0, #0xffffffff            	// #-1
}
ffffffff400361f0:	910083ff 	add	sp, sp, #0x20
ffffffff400361f4:	d65f03c0 	ret

ffffffff400361f8 <sys_dup>:

int sys_dup(void)
{
ffffffff400361f8:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff400361fc:	910003fd 	mov	x29, sp
    struct file *f;
    int fd;

    if(argfd(0, 0, &f) < 0) {
ffffffff40036200:	910043e0 	add	x0, sp, #0x10
ffffffff40036204:	aa0003e2 	mov	x2, x0
ffffffff40036208:	d2800001 	mov	x1, #0x0                   	// #0
ffffffff4003620c:	52800000 	mov	w0, #0x0                   	// #0
ffffffff40036210:	97ffffa7 	bl	ffffffff400360ac <argfd>
ffffffff40036214:	7100001f 	cmp	w0, #0x0
ffffffff40036218:	5400006a 	b.ge	ffffffff40036224 <sys_dup+0x2c>  // b.tcont
        return -1;
ffffffff4003621c:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036220:	1400000c 	b	ffffffff40036250 <sys_dup+0x58>
    }

    if((fd=fdalloc(f)) < 0) {
ffffffff40036224:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40036228:	97ffffd2 	bl	ffffffff40036170 <fdalloc>
ffffffff4003622c:	b9001fe0 	str	w0, [sp, #28]
ffffffff40036230:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40036234:	7100001f 	cmp	w0, #0x0
ffffffff40036238:	5400006a 	b.ge	ffffffff40036244 <sys_dup+0x4c>  // b.tcont
        return -1;
ffffffff4003623c:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036240:	14000004 	b	ffffffff40036250 <sys_dup+0x58>
    }

    filedup(f);
ffffffff40036244:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40036248:	97fff06f 	bl	ffffffff40032404 <filedup>

    return fd;
ffffffff4003624c:	b9401fe0 	ldr	w0, [sp, #28]
}
ffffffff40036250:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40036254:	d65f03c0 	ret

ffffffff40036258 <sys_read>:

int sys_read(void)
{
ffffffff40036258:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff4003625c:	910003fd 	mov	x29, sp
    struct file *f;
    long n;
    char *p;

    if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0) {
ffffffff40036260:	9100a3e0 	add	x0, sp, #0x28
ffffffff40036264:	aa0003e2 	mov	x2, x0
ffffffff40036268:	d2800001 	mov	x1, #0x0                   	// #0
ffffffff4003626c:	52800000 	mov	w0, #0x0                   	// #0
ffffffff40036270:	97ffff8f 	bl	ffffffff400360ac <argfd>
ffffffff40036274:	7100001f 	cmp	w0, #0x0
ffffffff40036278:	5400020b 	b.lt	ffffffff400362b8 <sys_read+0x60>  // b.tstop
ffffffff4003627c:	910083e0 	add	x0, sp, #0x20
ffffffff40036280:	aa0003e1 	mov	x1, x0
ffffffff40036284:	52800040 	mov	w0, #0x2                   	// #2
ffffffff40036288:	97fffefe 	bl	ffffffff40035e80 <argint>
ffffffff4003628c:	7100001f 	cmp	w0, #0x0
ffffffff40036290:	5400014b 	b.lt	ffffffff400362b8 <sys_read+0x60>  // b.tstop
ffffffff40036294:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40036298:	2a0003e1 	mov	w1, w0
ffffffff4003629c:	910063e0 	add	x0, sp, #0x18
ffffffff400362a0:	2a0103e2 	mov	w2, w1
ffffffff400362a4:	aa0003e1 	mov	x1, x0
ffffffff400362a8:	52800020 	mov	w0, #0x1                   	// #1
ffffffff400362ac:	97ffff0e 	bl	ffffffff40035ee4 <argptr>
ffffffff400362b0:	7100001f 	cmp	w0, #0x0
ffffffff400362b4:	5400006a 	b.ge	ffffffff400362c0 <sys_read+0x68>  // b.tcont
        return -1;
ffffffff400362b8:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff400362bc:	14000005 	b	ffffffff400362d0 <sys_read+0x78>
    }

    return fileread(f, p, n);
ffffffff400362c0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff400362c4:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff400362c8:	f94013e2 	ldr	x2, [sp, #32]
ffffffff400362cc:	97fff0b6 	bl	ffffffff400325a4 <fileread>
}
ffffffff400362d0:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff400362d4:	d65f03c0 	ret

ffffffff400362d8 <sys_write>:

int sys_write(void)
{
ffffffff400362d8:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff400362dc:	910003fd 	mov	x29, sp
    struct file *f;
    long n;
    char *p;

    if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0) {
ffffffff400362e0:	9100a3e0 	add	x0, sp, #0x28
ffffffff400362e4:	aa0003e2 	mov	x2, x0
ffffffff400362e8:	d2800001 	mov	x1, #0x0                   	// #0
ffffffff400362ec:	52800000 	mov	w0, #0x0                   	// #0
ffffffff400362f0:	97ffff6f 	bl	ffffffff400360ac <argfd>
ffffffff400362f4:	7100001f 	cmp	w0, #0x0
ffffffff400362f8:	5400020b 	b.lt	ffffffff40036338 <sys_write+0x60>  // b.tstop
ffffffff400362fc:	910083e0 	add	x0, sp, #0x20
ffffffff40036300:	aa0003e1 	mov	x1, x0
ffffffff40036304:	52800040 	mov	w0, #0x2                   	// #2
ffffffff40036308:	97fffede 	bl	ffffffff40035e80 <argint>
ffffffff4003630c:	7100001f 	cmp	w0, #0x0
ffffffff40036310:	5400014b 	b.lt	ffffffff40036338 <sys_write+0x60>  // b.tstop
ffffffff40036314:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40036318:	2a0003e1 	mov	w1, w0
ffffffff4003631c:	910063e0 	add	x0, sp, #0x18
ffffffff40036320:	2a0103e2 	mov	w2, w1
ffffffff40036324:	aa0003e1 	mov	x1, x0
ffffffff40036328:	52800020 	mov	w0, #0x1                   	// #1
ffffffff4003632c:	97fffeee 	bl	ffffffff40035ee4 <argptr>
ffffffff40036330:	7100001f 	cmp	w0, #0x0
ffffffff40036334:	5400006a 	b.ge	ffffffff40036340 <sys_write+0x68>  // b.tcont
        return -1;
ffffffff40036338:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff4003633c:	14000005 	b	ffffffff40036350 <sys_write+0x78>
    }

    return filewrite(f, p, n);
ffffffff40036340:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40036344:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40036348:	f94013e2 	ldr	x2, [sp, #32]
ffffffff4003634c:	97fff0d0 	bl	ffffffff4003268c <filewrite>
}
ffffffff40036350:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff40036354:	d65f03c0 	ret

ffffffff40036358 <sys_close>:

int sys_close(void)
{
ffffffff40036358:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff4003635c:	910003fd 	mov	x29, sp
    int fd;
    struct file *f;

    if(argfd(0, &fd, &f) < 0) {
ffffffff40036360:	910043e1 	add	x1, sp, #0x10
ffffffff40036364:	910073e0 	add	x0, sp, #0x1c
ffffffff40036368:	aa0103e2 	mov	x2, x1
ffffffff4003636c:	aa0003e1 	mov	x1, x0
ffffffff40036370:	52800000 	mov	w0, #0x0                   	// #0
ffffffff40036374:	97ffff4e 	bl	ffffffff400360ac <argfd>
ffffffff40036378:	7100001f 	cmp	w0, #0x0
ffffffff4003637c:	5400006a 	b.ge	ffffffff40036388 <sys_close+0x30>  // b.tcont
        return -1;
ffffffff40036380:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036384:	1400000d 	b	ffffffff400363b8 <sys_close+0x60>
    }

    proc->ofile[fd] = 0;
ffffffff40036388:	b0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003638c:	911e0000 	add	x0, x0, #0x780
ffffffff40036390:	f9400001 	ldr	x1, [x0]
ffffffff40036394:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40036398:	93407c00 	sxtw	x0, w0
ffffffff4003639c:	91002000 	add	x0, x0, #0x8
ffffffff400363a0:	d37df000 	lsl	x0, x0, #3
ffffffff400363a4:	8b000020 	add	x0, x1, x0
ffffffff400363a8:	f900041f 	str	xzr, [x0, #8]
    fileclose(f);
ffffffff400363ac:	f9400be0 	ldr	x0, [sp, #16]
ffffffff400363b0:	97fff02d 	bl	ffffffff40032464 <fileclose>

    return 0;
ffffffff400363b4:	52800000 	mov	w0, #0x0                   	// #0
}
ffffffff400363b8:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff400363bc:	d65f03c0 	ret

ffffffff400363c0 <sys_fstat>:

int sys_fstat(void)
{
ffffffff400363c0:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff400363c4:	910003fd 	mov	x29, sp
    struct file *f;
    struct stat *st;

    if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0) {
ffffffff400363c8:	910063e0 	add	x0, sp, #0x18
ffffffff400363cc:	aa0003e2 	mov	x2, x0
ffffffff400363d0:	d2800001 	mov	x1, #0x0                   	// #0
ffffffff400363d4:	52800000 	mov	w0, #0x0                   	// #0
ffffffff400363d8:	97ffff35 	bl	ffffffff400360ac <argfd>
ffffffff400363dc:	7100001f 	cmp	w0, #0x0
ffffffff400363e0:	5400010b 	b.lt	ffffffff40036400 <sys_fstat+0x40>  // b.tstop
ffffffff400363e4:	910043e0 	add	x0, sp, #0x10
ffffffff400363e8:	52800282 	mov	w2, #0x14                  	// #20
ffffffff400363ec:	aa0003e1 	mov	x1, x0
ffffffff400363f0:	52800020 	mov	w0, #0x1                   	// #1
ffffffff400363f4:	97fffebc 	bl	ffffffff40035ee4 <argptr>
ffffffff400363f8:	7100001f 	cmp	w0, #0x0
ffffffff400363fc:	5400006a 	b.ge	ffffffff40036408 <sys_fstat+0x48>  // b.tcont
        return -1;
ffffffff40036400:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036404:	14000004 	b	ffffffff40036414 <sys_fstat+0x54>
    }

    return filestat(f, st);
ffffffff40036408:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003640c:	f9400be1 	ldr	x1, [sp, #16]
ffffffff40036410:	97fff04e 	bl	ffffffff40032548 <filestat>
}
ffffffff40036414:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40036418:	d65f03c0 	ret

ffffffff4003641c <sys_link>:

// Create the path new as a link to the same inode as old.
int sys_link(void)
{
ffffffff4003641c:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff40036420:	910003fd 	mov	x29, sp
    char name[DIRSIZ], *new, *old;
    struct inode *dp, *ip;

    if(argstr(0, &old) < 0 || argstr(1, &new) < 0) {
ffffffff40036424:	910043e0 	add	x0, sp, #0x10
ffffffff40036428:	aa0003e1 	mov	x1, x0
ffffffff4003642c:	52800000 	mov	w0, #0x0                   	// #0
ffffffff40036430:	97fffed3 	bl	ffffffff40035f7c <argstr>
ffffffff40036434:	7100001f 	cmp	w0, #0x0
ffffffff40036438:	540000eb 	b.lt	ffffffff40036454 <sys_link+0x38>  // b.tstop
ffffffff4003643c:	910063e0 	add	x0, sp, #0x18
ffffffff40036440:	aa0003e1 	mov	x1, x0
ffffffff40036444:	52800020 	mov	w0, #0x1                   	// #1
ffffffff40036448:	97fffecd 	bl	ffffffff40035f7c <argstr>
ffffffff4003644c:	7100001f 	cmp	w0, #0x0
ffffffff40036450:	5400006a 	b.ge	ffffffff4003645c <sys_link+0x40>  // b.tcont
        return -1;
ffffffff40036454:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036458:	14000054 	b	ffffffff400365a8 <sys_link+0x18c>
    }

    if((ip = namei(old)) == 0) {
ffffffff4003645c:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40036460:	97fff665 	bl	ffffffff40033df4 <namei>
ffffffff40036464:	f9001fe0 	str	x0, [sp, #56]
ffffffff40036468:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003646c:	f100001f 	cmp	x0, #0x0
ffffffff40036470:	54000061 	b.ne	ffffffff4003647c <sys_link+0x60>  // b.any
        return -1;
ffffffff40036474:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036478:	1400004c 	b	ffffffff400365a8 <sys_link+0x18c>
    }

    begin_trans();
ffffffff4003647c:	97fff73c 	bl	ffffffff4003416c <begin_trans>

    ilock(ip);
ffffffff40036480:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40036484:	97fff2a0 	bl	ffffffff40032f04 <ilock>

    if(ip->type == T_DIR){
ffffffff40036488:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003648c:	79c02000 	ldrsh	w0, [x0, #16]
ffffffff40036490:	7100041f 	cmp	w0, #0x1
ffffffff40036494:	540000c1 	b.ne	ffffffff400364ac <sys_link+0x90>  // b.any
        iunlockput(ip);
ffffffff40036498:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003649c:	97fff35e 	bl	ffffffff40033214 <iunlockput>
        commit_trans();
ffffffff400364a0:	97fff74d 	bl	ffffffff400341d4 <commit_trans>
        return -1;
ffffffff400364a4:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff400364a8:	14000040 	b	ffffffff400365a8 <sys_link+0x18c>
    }

    ip->nlink++;
ffffffff400364ac:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff400364b0:	79c02c00 	ldrsh	w0, [x0, #22]
ffffffff400364b4:	12003c00 	and	w0, w0, #0xffff
ffffffff400364b8:	11000400 	add	w0, w0, #0x1
ffffffff400364bc:	12003c00 	and	w0, w0, #0xffff
ffffffff400364c0:	13003c01 	sxth	w1, w0
ffffffff400364c4:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff400364c8:	79002c01 	strh	w1, [x0, #22]
    iupdate(ip);
ffffffff400364cc:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff400364d0:	97fff1f5 	bl	ffffffff40032ca4 <iupdate>
    iunlock(ip);
ffffffff400364d4:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff400364d8:	97fff2f2 	bl	ffffffff400330a0 <iunlock>

    if((dp = nameiparent(new, name)) == 0) {
ffffffff400364dc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400364e0:	910083e1 	add	x1, sp, #0x20
ffffffff400364e4:	97fff64e 	bl	ffffffff40033e1c <nameiparent>
ffffffff400364e8:	f9001be0 	str	x0, [sp, #48]
ffffffff400364ec:	f9401be0 	ldr	x0, [sp, #48]
ffffffff400364f0:	f100001f 	cmp	x0, #0x0
ffffffff400364f4:	54000380 	b.eq	ffffffff40036564 <sys_link+0x148>  // b.none
        goto bad;
    }

    ilock(dp);
ffffffff400364f8:	f9401be0 	ldr	x0, [sp, #48]
ffffffff400364fc:	97fff282 	bl	ffffffff40032f04 <ilock>

    if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
ffffffff40036500:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40036504:	b9400001 	ldr	w1, [x0]
ffffffff40036508:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003650c:	b9400000 	ldr	w0, [x0]
ffffffff40036510:	6b00003f 	cmp	w1, w0
ffffffff40036514:	54000141 	b.ne	ffffffff4003653c <sys_link+0x120>  // b.any
ffffffff40036518:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003651c:	b9400401 	ldr	w1, [x0, #4]
ffffffff40036520:	910083e0 	add	x0, sp, #0x20
ffffffff40036524:	2a0103e2 	mov	w2, w1
ffffffff40036528:	aa0003e1 	mov	x1, x0
ffffffff4003652c:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40036530:	97fff563 	bl	ffffffff40033abc <dirlink>
ffffffff40036534:	7100001f 	cmp	w0, #0x0
ffffffff40036538:	5400008a 	b.ge	ffffffff40036548 <sys_link+0x12c>  // b.tcont
        iunlockput(dp);
ffffffff4003653c:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40036540:	97fff335 	bl	ffffffff40033214 <iunlockput>
        goto bad;
ffffffff40036544:	14000009 	b	ffffffff40036568 <sys_link+0x14c>
    }

    iunlockput(dp);
ffffffff40036548:	f9401be0 	ldr	x0, [sp, #48]
ffffffff4003654c:	97fff332 	bl	ffffffff40033214 <iunlockput>
    iput(ip);
ffffffff40036550:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40036554:	97fff2f5 	bl	ffffffff40033128 <iput>

    commit_trans();
ffffffff40036558:	97fff71f 	bl	ffffffff400341d4 <commit_trans>

    return 0;
ffffffff4003655c:	52800000 	mov	w0, #0x0                   	// #0
ffffffff40036560:	14000012 	b	ffffffff400365a8 <sys_link+0x18c>
        goto bad;
ffffffff40036564:	d503201f 	nop

    bad:
    ilock(ip);
ffffffff40036568:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003656c:	97fff266 	bl	ffffffff40032f04 <ilock>
    ip->nlink--;
ffffffff40036570:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40036574:	79c02c00 	ldrsh	w0, [x0, #22]
ffffffff40036578:	12003c00 	and	w0, w0, #0xffff
ffffffff4003657c:	51000400 	sub	w0, w0, #0x1
ffffffff40036580:	12003c00 	and	w0, w0, #0xffff
ffffffff40036584:	13003c01 	sxth	w1, w0
ffffffff40036588:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003658c:	79002c01 	strh	w1, [x0, #22]
    iupdate(ip);
ffffffff40036590:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40036594:	97fff1c4 	bl	ffffffff40032ca4 <iupdate>
    iunlockput(ip);
ffffffff40036598:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003659c:	97fff31e 	bl	ffffffff40033214 <iunlockput>
    commit_trans();
ffffffff400365a0:	97fff70d 	bl	ffffffff400341d4 <commit_trans>
    return -1;
ffffffff400365a4:	12800000 	mov	w0, #0xffffffff            	// #-1
}
ffffffff400365a8:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff400365ac:	d65f03c0 	ret

ffffffff400365b0 <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int isdirempty(struct inode *dp)
{
ffffffff400365b0:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff400365b4:	910003fd 	mov	x29, sp
ffffffff400365b8:	f9000fe0 	str	x0, [sp, #24]
    int off;
    struct dirent de;

    for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
ffffffff400365bc:	52800400 	mov	w0, #0x20                  	// #32
ffffffff400365c0:	b9003fe0 	str	w0, [sp, #60]
ffffffff400365c4:	14000015 	b	ffffffff40036618 <isdirempty+0x68>
        if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de)) {
ffffffff400365c8:	b9403fe1 	ldr	w1, [sp, #60]
ffffffff400365cc:	9100a3e0 	add	x0, sp, #0x28
ffffffff400365d0:	52800203 	mov	w3, #0x10                  	// #16
ffffffff400365d4:	2a0103e2 	mov	w2, w1
ffffffff400365d8:	aa0003e1 	mov	x1, x0
ffffffff400365dc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400365e0:	97fff3ea 	bl	ffffffff40033588 <readi>
ffffffff400365e4:	7100401f 	cmp	w0, #0x10
ffffffff400365e8:	54000080 	b.eq	ffffffff400365f8 <isdirempty+0x48>  // b.none
            panic("isdirempty: readi");
ffffffff400365ec:	b0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400365f0:	91258000 	add	x0, x0, #0x960
ffffffff400365f4:	97ffecb5 	bl	ffffffff400318c8 <panic>
        }

        if(de.inum != 0) {
ffffffff400365f8:	794053e0 	ldrh	w0, [sp, #40]
ffffffff400365fc:	7100001f 	cmp	w0, #0x0
ffffffff40036600:	54000060 	b.eq	ffffffff4003660c <isdirempty+0x5c>  // b.none
            return 0;
ffffffff40036604:	52800000 	mov	w0, #0x0                   	// #0
ffffffff40036608:	1400000a 	b	ffffffff40036630 <isdirempty+0x80>
    for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
ffffffff4003660c:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40036610:	11004000 	add	w0, w0, #0x10
ffffffff40036614:	b9003fe0 	str	w0, [sp, #60]
ffffffff40036618:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003661c:	b9401801 	ldr	w1, [x0, #24]
ffffffff40036620:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40036624:	6b00003f 	cmp	w1, w0
ffffffff40036628:	54fffd08 	b.hi	ffffffff400365c8 <isdirempty+0x18>  // b.pmore
        }
    }
    return 1;
ffffffff4003662c:	52800020 	mov	w0, #0x1                   	// #1
}
ffffffff40036630:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff40036634:	d65f03c0 	ret

ffffffff40036638 <sys_unlink>:

//PAGEBREAK!
int sys_unlink(void)
{
ffffffff40036638:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
ffffffff4003663c:	910003fd 	mov	x29, sp
    struct inode *ip, *dp;
    struct dirent de;
    char name[DIRSIZ], *path;
    uint off;

    if(argstr(0, &path) < 0) {
ffffffff40036640:	910063e0 	add	x0, sp, #0x18
ffffffff40036644:	aa0003e1 	mov	x1, x0
ffffffff40036648:	52800000 	mov	w0, #0x0                   	// #0
ffffffff4003664c:	97fffe4c 	bl	ffffffff40035f7c <argstr>
ffffffff40036650:	7100001f 	cmp	w0, #0x0
ffffffff40036654:	5400006a 	b.ge	ffffffff40036660 <sys_unlink+0x28>  // b.tcont
        return -1;
ffffffff40036658:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff4003665c:	1400006f 	b	ffffffff40036818 <sys_unlink+0x1e0>
    }

    if((dp = nameiparent(path, name)) == 0) {
ffffffff40036660:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40036664:	910083e1 	add	x1, sp, #0x20
ffffffff40036668:	97fff5ed 	bl	ffffffff40033e1c <nameiparent>
ffffffff4003666c:	f90027e0 	str	x0, [sp, #72]
ffffffff40036670:	f94027e0 	ldr	x0, [sp, #72]
ffffffff40036674:	f100001f 	cmp	x0, #0x0
ffffffff40036678:	54000061 	b.ne	ffffffff40036684 <sys_unlink+0x4c>  // b.any
        return -1;
ffffffff4003667c:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036680:	14000066 	b	ffffffff40036818 <sys_unlink+0x1e0>
    }

    begin_trans();
ffffffff40036684:	97fff6ba 	bl	ffffffff4003416c <begin_trans>

    ilock(dp);
ffffffff40036688:	f94027e0 	ldr	x0, [sp, #72]
ffffffff4003668c:	97fff21e 	bl	ffffffff40032f04 <ilock>

    // Cannot unlink "." or "..".
    if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0) {
ffffffff40036690:	910083e2 	add	x2, sp, #0x20
ffffffff40036694:	b0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40036698:	9125e001 	add	x1, x0, #0x978
ffffffff4003669c:	aa0203e0 	mov	x0, x2
ffffffff400366a0:	97fff4c1 	bl	ffffffff400339a4 <namecmp>
ffffffff400366a4:	7100001f 	cmp	w0, #0x0
ffffffff400366a8:	54000aa0 	b.eq	ffffffff400367fc <sys_unlink+0x1c4>  // b.none
ffffffff400366ac:	910083e2 	add	x2, sp, #0x20
ffffffff400366b0:	b0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400366b4:	91260001 	add	x1, x0, #0x980
ffffffff400366b8:	aa0203e0 	mov	x0, x2
ffffffff400366bc:	97fff4ba 	bl	ffffffff400339a4 <namecmp>
ffffffff400366c0:	7100001f 	cmp	w0, #0x0
ffffffff400366c4:	540009c0 	b.eq	ffffffff400367fc <sys_unlink+0x1c4>  // b.none
        goto bad;
    }

    if((ip = dirlookup(dp, name, &off)) == 0) {
ffffffff400366c8:	910053e1 	add	x1, sp, #0x14
ffffffff400366cc:	910083e0 	add	x0, sp, #0x20
ffffffff400366d0:	aa0103e2 	mov	x2, x1
ffffffff400366d4:	aa0003e1 	mov	x1, x0
ffffffff400366d8:	f94027e0 	ldr	x0, [sp, #72]
ffffffff400366dc:	97fff4bc 	bl	ffffffff400339cc <dirlookup>
ffffffff400366e0:	f90023e0 	str	x0, [sp, #64]
ffffffff400366e4:	f94023e0 	ldr	x0, [sp, #64]
ffffffff400366e8:	f100001f 	cmp	x0, #0x0
ffffffff400366ec:	540008c0 	b.eq	ffffffff40036804 <sys_unlink+0x1cc>  // b.none
        goto bad;
    }

    ilock(ip);
ffffffff400366f0:	f94023e0 	ldr	x0, [sp, #64]
ffffffff400366f4:	97fff204 	bl	ffffffff40032f04 <ilock>

    if(ip->nlink < 1) {
ffffffff400366f8:	f94023e0 	ldr	x0, [sp, #64]
ffffffff400366fc:	79c02c00 	ldrsh	w0, [x0, #22]
ffffffff40036700:	7100001f 	cmp	w0, #0x0
ffffffff40036704:	5400008c 	b.gt	ffffffff40036714 <sys_unlink+0xdc>
        panic("unlink: nlink < 1");
ffffffff40036708:	b0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003670c:	91262000 	add	x0, x0, #0x988
ffffffff40036710:	97ffec6e 	bl	ffffffff400318c8 <panic>
    }

    if(ip->type == T_DIR && !isdirempty(ip)){
ffffffff40036714:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40036718:	79c02000 	ldrsh	w0, [x0, #16]
ffffffff4003671c:	7100041f 	cmp	w0, #0x1
ffffffff40036720:	54000101 	b.ne	ffffffff40036740 <sys_unlink+0x108>  // b.any
ffffffff40036724:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40036728:	97ffffa2 	bl	ffffffff400365b0 <isdirempty>
ffffffff4003672c:	7100001f 	cmp	w0, #0x0
ffffffff40036730:	54000081 	b.ne	ffffffff40036740 <sys_unlink+0x108>  // b.any
        iunlockput(ip);
ffffffff40036734:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40036738:	97fff2b7 	bl	ffffffff40033214 <iunlockput>
        goto bad;
ffffffff4003673c:	14000033 	b	ffffffff40036808 <sys_unlink+0x1d0>
    }

    memset(&de, 0, sizeof(de));
ffffffff40036740:	9100c3e0 	add	x0, sp, #0x30
ffffffff40036744:	52800202 	mov	w2, #0x10                  	// #16
ffffffff40036748:	52800001 	mov	w1, #0x0                   	// #0
ffffffff4003674c:	97ffe62d 	bl	ffffffff40030000 <memset>

    if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de)) {
ffffffff40036750:	b94017e1 	ldr	w1, [sp, #20]
ffffffff40036754:	9100c3e0 	add	x0, sp, #0x30
ffffffff40036758:	52800203 	mov	w3, #0x10                  	// #16
ffffffff4003675c:	2a0103e2 	mov	w2, w1
ffffffff40036760:	aa0003e1 	mov	x1, x0
ffffffff40036764:	f94027e0 	ldr	x0, [sp, #72]
ffffffff40036768:	97fff406 	bl	ffffffff40033780 <writei>
ffffffff4003676c:	7100401f 	cmp	w0, #0x10
ffffffff40036770:	54000080 	b.eq	ffffffff40036780 <sys_unlink+0x148>  // b.none
        panic("unlink: writei");
ffffffff40036774:	b0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40036778:	91268000 	add	x0, x0, #0x9a0
ffffffff4003677c:	97ffec53 	bl	ffffffff400318c8 <panic>
    }

    if(ip->type == T_DIR){
ffffffff40036780:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40036784:	79c02000 	ldrsh	w0, [x0, #16]
ffffffff40036788:	7100041f 	cmp	w0, #0x1
ffffffff4003678c:	54000161 	b.ne	ffffffff400367b8 <sys_unlink+0x180>  // b.any
        dp->nlink--;
ffffffff40036790:	f94027e0 	ldr	x0, [sp, #72]
ffffffff40036794:	79c02c00 	ldrsh	w0, [x0, #22]
ffffffff40036798:	12003c00 	and	w0, w0, #0xffff
ffffffff4003679c:	51000400 	sub	w0, w0, #0x1
ffffffff400367a0:	12003c00 	and	w0, w0, #0xffff
ffffffff400367a4:	13003c01 	sxth	w1, w0
ffffffff400367a8:	f94027e0 	ldr	x0, [sp, #72]
ffffffff400367ac:	79002c01 	strh	w1, [x0, #22]
        iupdate(dp);
ffffffff400367b0:	f94027e0 	ldr	x0, [sp, #72]
ffffffff400367b4:	97fff13c 	bl	ffffffff40032ca4 <iupdate>
    }

    iunlockput(dp);
ffffffff400367b8:	f94027e0 	ldr	x0, [sp, #72]
ffffffff400367bc:	97fff296 	bl	ffffffff40033214 <iunlockput>

    ip->nlink--;
ffffffff400367c0:	f94023e0 	ldr	x0, [sp, #64]
ffffffff400367c4:	79c02c00 	ldrsh	w0, [x0, #22]
ffffffff400367c8:	12003c00 	and	w0, w0, #0xffff
ffffffff400367cc:	51000400 	sub	w0, w0, #0x1
ffffffff400367d0:	12003c00 	and	w0, w0, #0xffff
ffffffff400367d4:	13003c01 	sxth	w1, w0
ffffffff400367d8:	f94023e0 	ldr	x0, [sp, #64]
ffffffff400367dc:	79002c01 	strh	w1, [x0, #22]
    iupdate(ip);
ffffffff400367e0:	f94023e0 	ldr	x0, [sp, #64]
ffffffff400367e4:	97fff130 	bl	ffffffff40032ca4 <iupdate>
    iunlockput(ip);
ffffffff400367e8:	f94023e0 	ldr	x0, [sp, #64]
ffffffff400367ec:	97fff28a 	bl	ffffffff40033214 <iunlockput>

    commit_trans();
ffffffff400367f0:	97fff679 	bl	ffffffff400341d4 <commit_trans>

    return 0;
ffffffff400367f4:	52800000 	mov	w0, #0x0                   	// #0
ffffffff400367f8:	14000008 	b	ffffffff40036818 <sys_unlink+0x1e0>
        goto bad;
ffffffff400367fc:	d503201f 	nop
ffffffff40036800:	14000002 	b	ffffffff40036808 <sys_unlink+0x1d0>
        goto bad;
ffffffff40036804:	d503201f 	nop

    bad:
    iunlockput(dp);
ffffffff40036808:	f94027e0 	ldr	x0, [sp, #72]
ffffffff4003680c:	97fff282 	bl	ffffffff40033214 <iunlockput>
    commit_trans();
ffffffff40036810:	97fff671 	bl	ffffffff400341d4 <commit_trans>
    return -1;
ffffffff40036814:	12800000 	mov	w0, #0xffffffff            	// #-1
}
ffffffff40036818:	a8c57bfd 	ldp	x29, x30, [sp], #80
ffffffff4003681c:	d65f03c0 	ret

ffffffff40036820 <create>:

static struct inode* create(char *path, short type, short major, short minor)
{
ffffffff40036820:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
ffffffff40036824:	910003fd 	mov	x29, sp
ffffffff40036828:	f9000fe0 	str	x0, [sp, #24]
ffffffff4003682c:	79002fe1 	strh	w1, [sp, #22]
ffffffff40036830:	79002be2 	strh	w2, [sp, #20]
ffffffff40036834:	790027e3 	strh	w3, [sp, #18]
    uint off;
    struct inode *ip, *dp;
    char name[DIRSIZ];

    if((dp = nameiparent(path, name)) == 0) {
ffffffff40036838:	9100a3e0 	add	x0, sp, #0x28
ffffffff4003683c:	aa0003e1 	mov	x1, x0
ffffffff40036840:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40036844:	97fff576 	bl	ffffffff40033e1c <nameiparent>
ffffffff40036848:	f90027e0 	str	x0, [sp, #72]
ffffffff4003684c:	f94027e0 	ldr	x0, [sp, #72]
ffffffff40036850:	f100001f 	cmp	x0, #0x0
ffffffff40036854:	54000061 	b.ne	ffffffff40036860 <create+0x40>  // b.any
        return 0;
ffffffff40036858:	d2800000 	mov	x0, #0x0                   	// #0
ffffffff4003685c:	14000067 	b	ffffffff400369f8 <create+0x1d8>
    }

    ilock(dp);
ffffffff40036860:	f94027e0 	ldr	x0, [sp, #72]
ffffffff40036864:	97fff1a8 	bl	ffffffff40032f04 <ilock>

    if((ip = dirlookup(dp, name, &off)) != 0){
ffffffff40036868:	9100f3e1 	add	x1, sp, #0x3c
ffffffff4003686c:	9100a3e0 	add	x0, sp, #0x28
ffffffff40036870:	aa0103e2 	mov	x2, x1
ffffffff40036874:	aa0003e1 	mov	x1, x0
ffffffff40036878:	f94027e0 	ldr	x0, [sp, #72]
ffffffff4003687c:	97fff454 	bl	ffffffff400339cc <dirlookup>
ffffffff40036880:	f90023e0 	str	x0, [sp, #64]
ffffffff40036884:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40036888:	f100001f 	cmp	x0, #0x0
ffffffff4003688c:	54000240 	b.eq	ffffffff400368d4 <create+0xb4>  // b.none
        iunlockput(dp);
ffffffff40036890:	f94027e0 	ldr	x0, [sp, #72]
ffffffff40036894:	97fff260 	bl	ffffffff40033214 <iunlockput>
        ilock(ip);
ffffffff40036898:	f94023e0 	ldr	x0, [sp, #64]
ffffffff4003689c:	97fff19a 	bl	ffffffff40032f04 <ilock>

        if(type == T_FILE && ip->type == T_FILE) {
ffffffff400368a0:	79c02fe0 	ldrsh	w0, [sp, #22]
ffffffff400368a4:	7100081f 	cmp	w0, #0x2
ffffffff400368a8:	540000e1 	b.ne	ffffffff400368c4 <create+0xa4>  // b.any
ffffffff400368ac:	f94023e0 	ldr	x0, [sp, #64]
ffffffff400368b0:	79c02000 	ldrsh	w0, [x0, #16]
ffffffff400368b4:	7100081f 	cmp	w0, #0x2
ffffffff400368b8:	54000061 	b.ne	ffffffff400368c4 <create+0xa4>  // b.any
            return ip;
ffffffff400368bc:	f94023e0 	ldr	x0, [sp, #64]
ffffffff400368c0:	1400004e 	b	ffffffff400369f8 <create+0x1d8>
        }

        iunlockput(ip);
ffffffff400368c4:	f94023e0 	ldr	x0, [sp, #64]
ffffffff400368c8:	97fff253 	bl	ffffffff40033214 <iunlockput>

        return 0;
ffffffff400368cc:	d2800000 	mov	x0, #0x0                   	// #0
ffffffff400368d0:	1400004a 	b	ffffffff400369f8 <create+0x1d8>
    }

    if((ip = ialloc(dp->dev, type)) == 0) {
ffffffff400368d4:	f94027e0 	ldr	x0, [sp, #72]
ffffffff400368d8:	b9400000 	ldr	w0, [x0]
ffffffff400368dc:	79402fe1 	ldrh	w1, [sp, #22]
ffffffff400368e0:	97fff0b7 	bl	ffffffff40032bbc <ialloc>
ffffffff400368e4:	f90023e0 	str	x0, [sp, #64]
ffffffff400368e8:	f94023e0 	ldr	x0, [sp, #64]
ffffffff400368ec:	f100001f 	cmp	x0, #0x0
ffffffff400368f0:	54000081 	b.ne	ffffffff40036900 <create+0xe0>  // b.any
        panic("create: ialloc");
ffffffff400368f4:	b0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400368f8:	9126c000 	add	x0, x0, #0x9b0
ffffffff400368fc:	97ffebf3 	bl	ffffffff400318c8 <panic>
    }

    ilock(ip);
ffffffff40036900:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40036904:	97fff180 	bl	ffffffff40032f04 <ilock>
    ip->major = major;
ffffffff40036908:	f94023e0 	ldr	x0, [sp, #64]
ffffffff4003690c:	79402be1 	ldrh	w1, [sp, #20]
ffffffff40036910:	79002401 	strh	w1, [x0, #18]
    ip->minor = minor;
ffffffff40036914:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40036918:	794027e1 	ldrh	w1, [sp, #18]
ffffffff4003691c:	79002801 	strh	w1, [x0, #20]
    ip->nlink = 1;
ffffffff40036920:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40036924:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40036928:	79002c01 	strh	w1, [x0, #22]
    iupdate(ip);
ffffffff4003692c:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40036930:	97fff0dd 	bl	ffffffff40032ca4 <iupdate>

    if(type == T_DIR){  // Create . and .. entries.
ffffffff40036934:	79c02fe0 	ldrsh	w0, [sp, #22]
ffffffff40036938:	7100041f 	cmp	w0, #0x1
ffffffff4003693c:	54000401 	b.ne	ffffffff400369bc <create+0x19c>  // b.any
        dp->nlink++;  // for ".."
ffffffff40036940:	f94027e0 	ldr	x0, [sp, #72]
ffffffff40036944:	79c02c00 	ldrsh	w0, [x0, #22]
ffffffff40036948:	12003c00 	and	w0, w0, #0xffff
ffffffff4003694c:	11000400 	add	w0, w0, #0x1
ffffffff40036950:	12003c00 	and	w0, w0, #0xffff
ffffffff40036954:	13003c01 	sxth	w1, w0
ffffffff40036958:	f94027e0 	ldr	x0, [sp, #72]
ffffffff4003695c:	79002c01 	strh	w1, [x0, #22]
        iupdate(dp);
ffffffff40036960:	f94027e0 	ldr	x0, [sp, #72]
ffffffff40036964:	97fff0d0 	bl	ffffffff40032ca4 <iupdate>

        // No ip->nlink++ for ".": avoid cyclic ref count.
        if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0) {
ffffffff40036968:	f94023e0 	ldr	x0, [sp, #64]
ffffffff4003696c:	b9400400 	ldr	w0, [x0, #4]
ffffffff40036970:	2a0003e2 	mov	w2, w0
ffffffff40036974:	b0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40036978:	9125e001 	add	x1, x0, #0x978
ffffffff4003697c:	f94023e0 	ldr	x0, [sp, #64]
ffffffff40036980:	97fff44f 	bl	ffffffff40033abc <dirlink>
ffffffff40036984:	7100001f 	cmp	w0, #0x0
ffffffff40036988:	5400014b 	b.lt	ffffffff400369b0 <create+0x190>  // b.tstop
ffffffff4003698c:	f94027e0 	ldr	x0, [sp, #72]
ffffffff40036990:	b9400400 	ldr	w0, [x0, #4]
ffffffff40036994:	2a0003e2 	mov	w2, w0
ffffffff40036998:	b0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003699c:	91260001 	add	x1, x0, #0x980
ffffffff400369a0:	f94023e0 	ldr	x0, [sp, #64]
ffffffff400369a4:	97fff446 	bl	ffffffff40033abc <dirlink>
ffffffff400369a8:	7100001f 	cmp	w0, #0x0
ffffffff400369ac:	5400008a 	b.ge	ffffffff400369bc <create+0x19c>  // b.tcont
            panic("create dots");
ffffffff400369b0:	b0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400369b4:	91270000 	add	x0, x0, #0x9c0
ffffffff400369b8:	97ffebc4 	bl	ffffffff400318c8 <panic>
        }
    }

    if(dirlink(dp, name, ip->inum) < 0) {
ffffffff400369bc:	f94023e0 	ldr	x0, [sp, #64]
ffffffff400369c0:	b9400401 	ldr	w1, [x0, #4]
ffffffff400369c4:	9100a3e0 	add	x0, sp, #0x28
ffffffff400369c8:	2a0103e2 	mov	w2, w1
ffffffff400369cc:	aa0003e1 	mov	x1, x0
ffffffff400369d0:	f94027e0 	ldr	x0, [sp, #72]
ffffffff400369d4:	97fff43a 	bl	ffffffff40033abc <dirlink>
ffffffff400369d8:	7100001f 	cmp	w0, #0x0
ffffffff400369dc:	5400008a 	b.ge	ffffffff400369ec <create+0x1cc>  // b.tcont
        panic("create: dirlink");
ffffffff400369e0:	b0000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400369e4:	91274000 	add	x0, x0, #0x9d0
ffffffff400369e8:	97ffebb8 	bl	ffffffff400318c8 <panic>
    }

    iunlockput(dp);
ffffffff400369ec:	f94027e0 	ldr	x0, [sp, #72]
ffffffff400369f0:	97fff209 	bl	ffffffff40033214 <iunlockput>

    return ip;
ffffffff400369f4:	f94023e0 	ldr	x0, [sp, #64]
}
ffffffff400369f8:	a8c57bfd 	ldp	x29, x30, [sp], #80
ffffffff400369fc:	d65f03c0 	ret

ffffffff40036a00 <sys_open>:

int sys_open(void)
{
ffffffff40036a00:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff40036a04:	910003fd 	mov	x29, sp
    char *path;
    long fd, omode;
    struct file *f;
    struct inode *ip;

    if(argstr(0, &path) < 0 || argint(1, &omode) < 0) {
ffffffff40036a08:	910083e0 	add	x0, sp, #0x20
ffffffff40036a0c:	aa0003e1 	mov	x1, x0
ffffffff40036a10:	52800000 	mov	w0, #0x0                   	// #0
ffffffff40036a14:	97fffd5a 	bl	ffffffff40035f7c <argstr>
ffffffff40036a18:	7100001f 	cmp	w0, #0x0
ffffffff40036a1c:	540000eb 	b.lt	ffffffff40036a38 <sys_open+0x38>  // b.tstop
ffffffff40036a20:	910063e0 	add	x0, sp, #0x18
ffffffff40036a24:	aa0003e1 	mov	x1, x0
ffffffff40036a28:	52800020 	mov	w0, #0x1                   	// #1
ffffffff40036a2c:	97fffd15 	bl	ffffffff40035e80 <argint>
ffffffff40036a30:	7100001f 	cmp	w0, #0x0
ffffffff40036a34:	5400006a 	b.ge	ffffffff40036a40 <sys_open+0x40>  // b.tcont
        return -1;
ffffffff40036a38:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036a3c:	1400005d 	b	ffffffff40036bb0 <sys_open+0x1b0>
    }

    if(omode & O_CREATE){
ffffffff40036a40:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40036a44:	92770000 	and	x0, x0, #0x200
ffffffff40036a48:	f100001f 	cmp	x0, #0x0
ffffffff40036a4c:	540001c0 	b.eq	ffffffff40036a84 <sys_open+0x84>  // b.none
        begin_trans();
ffffffff40036a50:	97fff5c7 	bl	ffffffff4003416c <begin_trans>
        ip = create(path, T_FILE, 0, 0);
ffffffff40036a54:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40036a58:	52800003 	mov	w3, #0x0                   	// #0
ffffffff40036a5c:	52800002 	mov	w2, #0x0                   	// #0
ffffffff40036a60:	52800041 	mov	w1, #0x2                   	// #2
ffffffff40036a64:	97ffff6f 	bl	ffffffff40036820 <create>
ffffffff40036a68:	f9001fe0 	str	x0, [sp, #56]
        commit_trans();
ffffffff40036a6c:	97fff5da 	bl	ffffffff400341d4 <commit_trans>

        if(ip == 0) {
ffffffff40036a70:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40036a74:	f100001f 	cmp	x0, #0x0
ffffffff40036a78:	54000301 	b.ne	ffffffff40036ad8 <sys_open+0xd8>  // b.any
            return -1;
ffffffff40036a7c:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036a80:	1400004c 	b	ffffffff40036bb0 <sys_open+0x1b0>
        }

    } else {
        if((ip = namei(path)) == 0) {
ffffffff40036a84:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40036a88:	97fff4db 	bl	ffffffff40033df4 <namei>
ffffffff40036a8c:	f9001fe0 	str	x0, [sp, #56]
ffffffff40036a90:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40036a94:	f100001f 	cmp	x0, #0x0
ffffffff40036a98:	54000061 	b.ne	ffffffff40036aa4 <sys_open+0xa4>  // b.any
            return -1;
ffffffff40036a9c:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036aa0:	14000044 	b	ffffffff40036bb0 <sys_open+0x1b0>
        }

        ilock(ip);
ffffffff40036aa4:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40036aa8:	97fff117 	bl	ffffffff40032f04 <ilock>

        if(ip->type == T_DIR && omode != O_RDONLY){
ffffffff40036aac:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40036ab0:	79c02000 	ldrsh	w0, [x0, #16]
ffffffff40036ab4:	7100041f 	cmp	w0, #0x1
ffffffff40036ab8:	54000101 	b.ne	ffffffff40036ad8 <sys_open+0xd8>  // b.any
ffffffff40036abc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40036ac0:	f100001f 	cmp	x0, #0x0
ffffffff40036ac4:	540000a0 	b.eq	ffffffff40036ad8 <sys_open+0xd8>  // b.none
            iunlockput(ip);
ffffffff40036ac8:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40036acc:	97fff1d2 	bl	ffffffff40033214 <iunlockput>
            return -1;
ffffffff40036ad0:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036ad4:	14000037 	b	ffffffff40036bb0 <sys_open+0x1b0>
        }
    }

    if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
ffffffff40036ad8:	97ffee28 	bl	ffffffff40032378 <filealloc>
ffffffff40036adc:	f9001be0 	str	x0, [sp, #48]
ffffffff40036ae0:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40036ae4:	f100001f 	cmp	x0, #0x0
ffffffff40036ae8:	54000100 	b.eq	ffffffff40036b08 <sys_open+0x108>  // b.none
ffffffff40036aec:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40036af0:	97fffda0 	bl	ffffffff40036170 <fdalloc>
ffffffff40036af4:	93407c00 	sxtw	x0, w0
ffffffff40036af8:	f90017e0 	str	x0, [sp, #40]
ffffffff40036afc:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40036b00:	f100001f 	cmp	x0, #0x0
ffffffff40036b04:	5400014a 	b.ge	ffffffff40036b2c <sys_open+0x12c>  // b.tcont
        if(f) {
ffffffff40036b08:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40036b0c:	f100001f 	cmp	x0, #0x0
ffffffff40036b10:	54000060 	b.eq	ffffffff40036b1c <sys_open+0x11c>  // b.none
            fileclose(f);
ffffffff40036b14:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40036b18:	97ffee53 	bl	ffffffff40032464 <fileclose>
        }

        iunlockput(ip);
ffffffff40036b1c:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40036b20:	97fff1bd 	bl	ffffffff40033214 <iunlockput>
        return -1;
ffffffff40036b24:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036b28:	14000022 	b	ffffffff40036bb0 <sys_open+0x1b0>
    }

    iunlock(ip);
ffffffff40036b2c:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40036b30:	97fff15c 	bl	ffffffff400330a0 <iunlock>

    f->type = FD_INODE;
ffffffff40036b34:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40036b38:	52800041 	mov	w1, #0x2                   	// #2
ffffffff40036b3c:	b9000001 	str	w1, [x0]
    f->ip = ip;
ffffffff40036b40:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40036b44:	f9401fe1 	ldr	x1, [sp, #56]
ffffffff40036b48:	f9000c01 	str	x1, [x0, #24]
    f->off = 0;
ffffffff40036b4c:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40036b50:	b900201f 	str	wzr, [x0, #32]
    f->readable = !(omode & O_WRONLY);
ffffffff40036b54:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40036b58:	92400000 	and	x0, x0, #0x1
ffffffff40036b5c:	d3400000 	ubfx	x0, x0, #0, #1
ffffffff40036b60:	52000000 	eor	w0, w0, #0x1
ffffffff40036b64:	12001c00 	and	w0, w0, #0xff
ffffffff40036b68:	2a0003e1 	mov	w1, w0
ffffffff40036b6c:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40036b70:	39002001 	strb	w1, [x0, #8]
    f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
ffffffff40036b74:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40036b78:	92400000 	and	x0, x0, #0x1
ffffffff40036b7c:	f100001f 	cmp	x0, #0x0
ffffffff40036b80:	540000a1 	b.ne	ffffffff40036b94 <sys_open+0x194>  // b.any
ffffffff40036b84:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40036b88:	927f0000 	and	x0, x0, #0x2
ffffffff40036b8c:	f100001f 	cmp	x0, #0x0
ffffffff40036b90:	54000060 	b.eq	ffffffff40036b9c <sys_open+0x19c>  // b.none
ffffffff40036b94:	52800020 	mov	w0, #0x1                   	// #1
ffffffff40036b98:	14000002 	b	ffffffff40036ba0 <sys_open+0x1a0>
ffffffff40036b9c:	52800000 	mov	w0, #0x0                   	// #0
ffffffff40036ba0:	12001c01 	and	w1, w0, #0xff
ffffffff40036ba4:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40036ba8:	39002401 	strb	w1, [x0, #9]

    return fd;
ffffffff40036bac:	f94017e0 	ldr	x0, [sp, #40]
}
ffffffff40036bb0:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff40036bb4:	d65f03c0 	ret

ffffffff40036bb8 <sys_mkdir>:

int sys_mkdir(void)
{
ffffffff40036bb8:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40036bbc:	910003fd 	mov	x29, sp
    char *path;
    struct inode *ip;

    begin_trans();
ffffffff40036bc0:	97fff56b 	bl	ffffffff4003416c <begin_trans>

    if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
ffffffff40036bc4:	910043e0 	add	x0, sp, #0x10
ffffffff40036bc8:	aa0003e1 	mov	x1, x0
ffffffff40036bcc:	52800000 	mov	w0, #0x0                   	// #0
ffffffff40036bd0:	97fffceb 	bl	ffffffff40035f7c <argstr>
ffffffff40036bd4:	7100001f 	cmp	w0, #0x0
ffffffff40036bd8:	5400014b 	b.lt	ffffffff40036c00 <sys_mkdir+0x48>  // b.tstop
ffffffff40036bdc:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40036be0:	52800003 	mov	w3, #0x0                   	// #0
ffffffff40036be4:	52800002 	mov	w2, #0x0                   	// #0
ffffffff40036be8:	52800021 	mov	w1, #0x1                   	// #1
ffffffff40036bec:	97ffff0d 	bl	ffffffff40036820 <create>
ffffffff40036bf0:	f9000fe0 	str	x0, [sp, #24]
ffffffff40036bf4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40036bf8:	f100001f 	cmp	x0, #0x0
ffffffff40036bfc:	54000081 	b.ne	ffffffff40036c0c <sys_mkdir+0x54>  // b.any
        commit_trans();
ffffffff40036c00:	97fff575 	bl	ffffffff400341d4 <commit_trans>
        return -1;
ffffffff40036c04:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036c08:	14000005 	b	ffffffff40036c1c <sys_mkdir+0x64>
    }

    iunlockput(ip);
ffffffff40036c0c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40036c10:	97fff181 	bl	ffffffff40033214 <iunlockput>
    commit_trans();
ffffffff40036c14:	97fff570 	bl	ffffffff400341d4 <commit_trans>

    return 0;
ffffffff40036c18:	52800000 	mov	w0, #0x0                   	// #0
}
ffffffff40036c1c:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40036c20:	d65f03c0 	ret

ffffffff40036c24 <sys_mknod>:

int sys_mknod(void)
{
ffffffff40036c24:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff40036c28:	910003fd 	mov	x29, sp
    struct inode *ip;
    char *path;
    int len;
    long major, minor;

    begin_trans();
ffffffff40036c2c:	97fff550 	bl	ffffffff4003416c <begin_trans>

    if((len=argstr(0, &path)) < 0 ||
ffffffff40036c30:	9100a3e0 	add	x0, sp, #0x28
ffffffff40036c34:	aa0003e1 	mov	x1, x0
ffffffff40036c38:	52800000 	mov	w0, #0x0                   	// #0
ffffffff40036c3c:	97fffcd0 	bl	ffffffff40035f7c <argstr>
ffffffff40036c40:	b9003fe0 	str	w0, [sp, #60]
ffffffff40036c44:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff40036c48:	7100001f 	cmp	w0, #0x0
ffffffff40036c4c:	5400034b 	b.lt	ffffffff40036cb4 <sys_mknod+0x90>  // b.tstop
            argint(1, &major) < 0 || argint(2, &minor) < 0 ||
ffffffff40036c50:	910083e0 	add	x0, sp, #0x20
ffffffff40036c54:	aa0003e1 	mov	x1, x0
ffffffff40036c58:	52800020 	mov	w0, #0x1                   	// #1
ffffffff40036c5c:	97fffc89 	bl	ffffffff40035e80 <argint>
    if((len=argstr(0, &path)) < 0 ||
ffffffff40036c60:	7100001f 	cmp	w0, #0x0
ffffffff40036c64:	5400028b 	b.lt	ffffffff40036cb4 <sys_mknod+0x90>  // b.tstop
            argint(1, &major) < 0 || argint(2, &minor) < 0 ||
ffffffff40036c68:	910063e0 	add	x0, sp, #0x18
ffffffff40036c6c:	aa0003e1 	mov	x1, x0
ffffffff40036c70:	52800040 	mov	w0, #0x2                   	// #2
ffffffff40036c74:	97fffc83 	bl	ffffffff40035e80 <argint>
ffffffff40036c78:	7100001f 	cmp	w0, #0x0
ffffffff40036c7c:	540001cb 	b.lt	ffffffff40036cb4 <sys_mknod+0x90>  // b.tstop
            (ip = create(path, T_DEV, major, minor)) == 0){
ffffffff40036c80:	f94017e0 	ldr	x0, [sp, #40]
ffffffff40036c84:	f94013e1 	ldr	x1, [sp, #32]
ffffffff40036c88:	13003c21 	sxth	w1, w1
ffffffff40036c8c:	f9400fe2 	ldr	x2, [sp, #24]
ffffffff40036c90:	13003c42 	sxth	w2, w2
ffffffff40036c94:	2a0203e3 	mov	w3, w2
ffffffff40036c98:	2a0103e2 	mov	w2, w1
ffffffff40036c9c:	52800061 	mov	w1, #0x3                   	// #3
ffffffff40036ca0:	97fffee0 	bl	ffffffff40036820 <create>
ffffffff40036ca4:	f9001be0 	str	x0, [sp, #48]
            argint(1, &major) < 0 || argint(2, &minor) < 0 ||
ffffffff40036ca8:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40036cac:	f100001f 	cmp	x0, #0x0
ffffffff40036cb0:	54000081 	b.ne	ffffffff40036cc0 <sys_mknod+0x9c>  // b.any

        commit_trans();
ffffffff40036cb4:	97fff548 	bl	ffffffff400341d4 <commit_trans>
        return -1;
ffffffff40036cb8:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036cbc:	14000005 	b	ffffffff40036cd0 <sys_mknod+0xac>
    }

    iunlockput(ip);
ffffffff40036cc0:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40036cc4:	97fff154 	bl	ffffffff40033214 <iunlockput>
    commit_trans();
ffffffff40036cc8:	97fff543 	bl	ffffffff400341d4 <commit_trans>

    return 0;
ffffffff40036ccc:	52800000 	mov	w0, #0x0                   	// #0
}
ffffffff40036cd0:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff40036cd4:	d65f03c0 	ret

ffffffff40036cd8 <sys_chdir>:

int sys_chdir(void)
{
ffffffff40036cd8:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40036cdc:	910003fd 	mov	x29, sp
    char *path;
    struct inode *ip;

    if(argstr(0, &path) < 0 || (ip = namei(path)) == 0) {
ffffffff40036ce0:	910043e0 	add	x0, sp, #0x10
ffffffff40036ce4:	aa0003e1 	mov	x1, x0
ffffffff40036ce8:	52800000 	mov	w0, #0x0                   	// #0
ffffffff40036cec:	97fffca4 	bl	ffffffff40035f7c <argstr>
ffffffff40036cf0:	7100001f 	cmp	w0, #0x0
ffffffff40036cf4:	540000eb 	b.lt	ffffffff40036d10 <sys_chdir+0x38>  // b.tstop
ffffffff40036cf8:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40036cfc:	97fff43e 	bl	ffffffff40033df4 <namei>
ffffffff40036d00:	f9000fe0 	str	x0, [sp, #24]
ffffffff40036d04:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40036d08:	f100001f 	cmp	x0, #0x0
ffffffff40036d0c:	54000061 	b.ne	ffffffff40036d18 <sys_chdir+0x40>  // b.any
        return -1;
ffffffff40036d10:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036d14:	14000018 	b	ffffffff40036d74 <sys_chdir+0x9c>
    }

    ilock(ip);
ffffffff40036d18:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40036d1c:	97fff07a 	bl	ffffffff40032f04 <ilock>

    if(ip->type != T_DIR){
ffffffff40036d20:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40036d24:	79c02000 	ldrsh	w0, [x0, #16]
ffffffff40036d28:	7100041f 	cmp	w0, #0x1
ffffffff40036d2c:	540000a0 	b.eq	ffffffff40036d40 <sys_chdir+0x68>  // b.none
        iunlockput(ip);
ffffffff40036d30:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40036d34:	97fff138 	bl	ffffffff40033214 <iunlockput>
        return -1;
ffffffff40036d38:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036d3c:	1400000e 	b	ffffffff40036d74 <sys_chdir+0x9c>
    }

    iunlock(ip);
ffffffff40036d40:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40036d44:	97fff0d7 	bl	ffffffff400330a0 <iunlock>

    iput(proc->cwd);
ffffffff40036d48:	b0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40036d4c:	911e0000 	add	x0, x0, #0x780
ffffffff40036d50:	f9400000 	ldr	x0, [x0]
ffffffff40036d54:	f9406400 	ldr	x0, [x0, #200]
ffffffff40036d58:	97fff0f4 	bl	ffffffff40033128 <iput>
    proc->cwd = ip;
ffffffff40036d5c:	b0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40036d60:	911e0000 	add	x0, x0, #0x780
ffffffff40036d64:	f9400000 	ldr	x0, [x0]
ffffffff40036d68:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40036d6c:	f9006401 	str	x1, [x0, #200]

    return 0;
ffffffff40036d70:	52800000 	mov	w0, #0x0                   	// #0
}
ffffffff40036d74:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40036d78:	d65f03c0 	ret

ffffffff40036d7c <sys_exec>:

int sys_exec(void)
{
ffffffff40036d7c:	a9ad7bfd 	stp	x29, x30, [sp, #-304]!
ffffffff40036d80:	910003fd 	mov	x29, sp
    char *path, *argv[MAXARG];
    int i;
    uint64 uargv, uarg;

    if(argstr(0, &path) < 0 || argint(1, (long*)&uargv) < 0){
ffffffff40036d84:	910483e0 	add	x0, sp, #0x120
ffffffff40036d88:	aa0003e1 	mov	x1, x0
ffffffff40036d8c:	52800000 	mov	w0, #0x0                   	// #0
ffffffff40036d90:	97fffc7b 	bl	ffffffff40035f7c <argstr>
ffffffff40036d94:	7100001f 	cmp	w0, #0x0
ffffffff40036d98:	540000eb 	b.lt	ffffffff40036db4 <sys_exec+0x38>  // b.tstop
ffffffff40036d9c:	910063e0 	add	x0, sp, #0x18
ffffffff40036da0:	aa0003e1 	mov	x1, x0
ffffffff40036da4:	52800020 	mov	w0, #0x1                   	// #1
ffffffff40036da8:	97fffc36 	bl	ffffffff40035e80 <argint>
ffffffff40036dac:	7100001f 	cmp	w0, #0x0
ffffffff40036db0:	5400006a 	b.ge	ffffffff40036dbc <sys_exec+0x40>  // b.tcont
        return -1;
ffffffff40036db4:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036db8:	14000032 	b	ffffffff40036e80 <sys_exec+0x104>
    }

    memset(argv, 0, sizeof(argv));
ffffffff40036dbc:	910083e0 	add	x0, sp, #0x20
ffffffff40036dc0:	52802002 	mov	w2, #0x100                 	// #256
ffffffff40036dc4:	52800001 	mov	w1, #0x0                   	// #0
ffffffff40036dc8:	97ffe48e 	bl	ffffffff40030000 <memset>

    for(i=0;; i++){
ffffffff40036dcc:	b9012fff 	str	wzr, [sp, #300]
        if(i >= NELEM(argv)) {
ffffffff40036dd0:	b9412fe0 	ldr	w0, [sp, #300]
ffffffff40036dd4:	71007c1f 	cmp	w0, #0x1f
ffffffff40036dd8:	54000069 	b.ls	ffffffff40036de4 <sys_exec+0x68>  // b.plast
            return -1;
ffffffff40036ddc:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036de0:	14000028 	b	ffffffff40036e80 <sys_exec+0x104>
        }

        if(fetchint(uargv+8*i, (long*)&uarg) < 0) {
ffffffff40036de4:	b9412fe0 	ldr	w0, [sp, #300]
ffffffff40036de8:	531d7000 	lsl	w0, w0, #3
ffffffff40036dec:	93407c01 	sxtw	x1, w0
ffffffff40036df0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40036df4:	8b000020 	add	x0, x1, x0
ffffffff40036df8:	910043e1 	add	x1, sp, #0x10
ffffffff40036dfc:	97fffbdb 	bl	ffffffff40035d68 <fetchint>
ffffffff40036e00:	7100001f 	cmp	w0, #0x0
ffffffff40036e04:	5400006a 	b.ge	ffffffff40036e10 <sys_exec+0x94>  // b.tcont
            return -1;
ffffffff40036e08:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036e0c:	1400001d 	b	ffffffff40036e80 <sys_exec+0x104>
        }

        if(uarg == 0){
ffffffff40036e10:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40036e14:	f100001f 	cmp	x0, #0x0
ffffffff40036e18:	54000141 	b.ne	ffffffff40036e40 <sys_exec+0xc4>  // b.any
            argv[i] = 0;
ffffffff40036e1c:	b9812fe0 	ldrsw	x0, [sp, #300]
ffffffff40036e20:	d37df000 	lsl	x0, x0, #3
ffffffff40036e24:	910083e1 	add	x1, sp, #0x20
ffffffff40036e28:	f820683f 	str	xzr, [x1, x0]
            break;
ffffffff40036e2c:	d503201f 	nop
        if(fetchstr(uarg, &argv[i]) < 0) {
            return -1;
        }
    }

    return exec(path, argv);
ffffffff40036e30:	f94093e0 	ldr	x0, [sp, #288]
ffffffff40036e34:	910083e1 	add	x1, sp, #0x20
ffffffff40036e38:	97ffec0d 	bl	ffffffff40031e6c <exec>
ffffffff40036e3c:	14000011 	b	ffffffff40036e80 <sys_exec+0x104>
        if(fetchstr(uarg, &argv[i]) < 0) {
ffffffff40036e40:	f9400be2 	ldr	x2, [sp, #16]
ffffffff40036e44:	910083e1 	add	x1, sp, #0x20
ffffffff40036e48:	b9812fe0 	ldrsw	x0, [sp, #300]
ffffffff40036e4c:	d37df000 	lsl	x0, x0, #3
ffffffff40036e50:	8b000020 	add	x0, x1, x0
ffffffff40036e54:	aa0003e1 	mov	x1, x0
ffffffff40036e58:	aa0203e0 	mov	x0, x2
ffffffff40036e5c:	97fffbde 	bl	ffffffff40035dd4 <fetchstr>
ffffffff40036e60:	7100001f 	cmp	w0, #0x0
ffffffff40036e64:	5400006a 	b.ge	ffffffff40036e70 <sys_exec+0xf4>  // b.tcont
            return -1;
ffffffff40036e68:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036e6c:	14000005 	b	ffffffff40036e80 <sys_exec+0x104>
    for(i=0;; i++){
ffffffff40036e70:	b9412fe0 	ldr	w0, [sp, #300]
ffffffff40036e74:	11000400 	add	w0, w0, #0x1
ffffffff40036e78:	b9012fe0 	str	w0, [sp, #300]
        if(i >= NELEM(argv)) {
ffffffff40036e7c:	17ffffd5 	b	ffffffff40036dd0 <sys_exec+0x54>
}
ffffffff40036e80:	a8d37bfd 	ldp	x29, x30, [sp], #304
ffffffff40036e84:	d65f03c0 	ret

ffffffff40036e88 <sys_pipe>:

int sys_pipe(void)
{
ffffffff40036e88:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff40036e8c:	910003fd 	mov	x29, sp
    int *fd;
    struct file *rf, *wf;
    int fd0, fd1;

    if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0) {
ffffffff40036e90:	910083e0 	add	x0, sp, #0x20
ffffffff40036e94:	52800102 	mov	w2, #0x8                   	// #8
ffffffff40036e98:	aa0003e1 	mov	x1, x0
ffffffff40036e9c:	52800000 	mov	w0, #0x0                   	// #0
ffffffff40036ea0:	97fffc11 	bl	ffffffff40035ee4 <argptr>
ffffffff40036ea4:	7100001f 	cmp	w0, #0x0
ffffffff40036ea8:	5400006a 	b.ge	ffffffff40036eb4 <sys_pipe+0x2c>  // b.tcont
        return -1;
ffffffff40036eac:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036eb0:	1400002f 	b	ffffffff40036f6c <sys_pipe+0xe4>
    }

    if(pipealloc(&rf, &wf) < 0) {
ffffffff40036eb4:	910043e1 	add	x1, sp, #0x10
ffffffff40036eb8:	910063e0 	add	x0, sp, #0x18
ffffffff40036ebc:	97fff6c9 	bl	ffffffff400349e0 <pipealloc>
ffffffff40036ec0:	7100001f 	cmp	w0, #0x0
ffffffff40036ec4:	5400006a 	b.ge	ffffffff40036ed0 <sys_pipe+0x48>  // b.tcont
        return -1;
ffffffff40036ec8:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036ecc:	14000028 	b	ffffffff40036f6c <sys_pipe+0xe4>
    }

    fd0 = -1;
ffffffff40036ed0:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036ed4:	b9002fe0 	str	w0, [sp, #44]

    if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
ffffffff40036ed8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40036edc:	97fffca5 	bl	ffffffff40036170 <fdalloc>
ffffffff40036ee0:	b9002fe0 	str	w0, [sp, #44]
ffffffff40036ee4:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40036ee8:	7100001f 	cmp	w0, #0x0
ffffffff40036eec:	540000eb 	b.lt	ffffffff40036f08 <sys_pipe+0x80>  // b.tstop
ffffffff40036ef0:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40036ef4:	97fffc9f 	bl	ffffffff40036170 <fdalloc>
ffffffff40036ef8:	b9002be0 	str	w0, [sp, #40]
ffffffff40036efc:	b9402be0 	ldr	w0, [sp, #40]
ffffffff40036f00:	7100001f 	cmp	w0, #0x0
ffffffff40036f04:	5400024a 	b.ge	ffffffff40036f4c <sys_pipe+0xc4>  // b.tcont
        if(fd0 >= 0) {
ffffffff40036f08:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff40036f0c:	7100001f 	cmp	w0, #0x0
ffffffff40036f10:	5400012b 	b.lt	ffffffff40036f34 <sys_pipe+0xac>  // b.tstop
            proc->ofile[fd0] = 0;
ffffffff40036f14:	b0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40036f18:	911e0000 	add	x0, x0, #0x780
ffffffff40036f1c:	f9400001 	ldr	x1, [x0]
ffffffff40036f20:	b9802fe0 	ldrsw	x0, [sp, #44]
ffffffff40036f24:	91002000 	add	x0, x0, #0x8
ffffffff40036f28:	d37df000 	lsl	x0, x0, #3
ffffffff40036f2c:	8b000020 	add	x0, x1, x0
ffffffff40036f30:	f900041f 	str	xzr, [x0, #8]
        }

        fileclose(rf);
ffffffff40036f34:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40036f38:	97ffed4b 	bl	ffffffff40032464 <fileclose>
        fileclose(wf);
ffffffff40036f3c:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40036f40:	97ffed49 	bl	ffffffff40032464 <fileclose>

        return -1;
ffffffff40036f44:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036f48:	14000009 	b	ffffffff40036f6c <sys_pipe+0xe4>
    }

    fd[0] = fd0;
ffffffff40036f4c:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40036f50:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff40036f54:	b9000001 	str	w1, [x0]
    fd[1] = fd1;
ffffffff40036f58:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40036f5c:	91001000 	add	x0, x0, #0x4
ffffffff40036f60:	b9402be1 	ldr	w1, [sp, #40]
ffffffff40036f64:	b9000001 	str	w1, [x0]

    return 0;
ffffffff40036f68:	52800000 	mov	w0, #0x0                   	// #0
}
ffffffff40036f6c:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff40036f70:	d65f03c0 	ret

ffffffff40036f74 <sys_fork>:
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int sys_fork(void)
{
ffffffff40036f74:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff40036f78:	910003fd 	mov	x29, sp
    return fork();
ffffffff40036f7c:	97fff8a6 	bl	ffffffff40035214 <fork>
}
ffffffff40036f80:	a8c17bfd 	ldp	x29, x30, [sp], #16
ffffffff40036f84:	d65f03c0 	ret

ffffffff40036f88 <sys_exit>:

int sys_exit(void)
{
ffffffff40036f88:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff40036f8c:	910003fd 	mov	x29, sp
    exit();
ffffffff40036f90:	97fff91b 	bl	ffffffff400353fc <exit>
    return 0;  // not reached
ffffffff40036f94:	52800000 	mov	w0, #0x0                   	// #0
}
ffffffff40036f98:	a8c17bfd 	ldp	x29, x30, [sp], #16
ffffffff40036f9c:	d65f03c0 	ret

ffffffff40036fa0 <sys_wait>:

int sys_wait(void)
{
ffffffff40036fa0:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff40036fa4:	910003fd 	mov	x29, sp
    return wait();
ffffffff40036fa8:	97fff97f 	bl	ffffffff400355a4 <wait>
}
ffffffff40036fac:	a8c17bfd 	ldp	x29, x30, [sp], #16
ffffffff40036fb0:	d65f03c0 	ret

ffffffff40036fb4 <sys_kill>:

int sys_kill(void)
{
ffffffff40036fb4:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40036fb8:	910003fd 	mov	x29, sp
    long pid;

    if(argint(0, &pid) < 0) {
ffffffff40036fbc:	910063e0 	add	x0, sp, #0x18
ffffffff40036fc0:	aa0003e1 	mov	x1, x0
ffffffff40036fc4:	52800000 	mov	w0, #0x0                   	// #0
ffffffff40036fc8:	97fffbae 	bl	ffffffff40035e80 <argint>
ffffffff40036fcc:	7100001f 	cmp	w0, #0x0
ffffffff40036fd0:	5400006a 	b.ge	ffffffff40036fdc <sys_kill+0x28>  // b.tcont
        return -1;
ffffffff40036fd4:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40036fd8:	14000003 	b	ffffffff40036fe4 <sys_kill+0x30>
    }

    return kill(pid);
ffffffff40036fdc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40036fe0:	97fffab6 	bl	ffffffff40035ab8 <kill>
}
ffffffff40036fe4:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40036fe8:	d65f03c0 	ret

ffffffff40036fec <sys_getpid>:

int sys_getpid(void)
{
    return proc->pid;
ffffffff40036fec:	b0000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40036ff0:	911e0000 	add	x0, x0, #0x780
ffffffff40036ff4:	f9400000 	ldr	x0, [x0]
ffffffff40036ff8:	b9401c00 	ldr	w0, [x0, #28]
}
ffffffff40036ffc:	d65f03c0 	ret

ffffffff40037000 <sys_sbrk>:

int sys_sbrk(void)
{
ffffffff40037000:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40037004:	910003fd 	mov	x29, sp
    long addr;
    long n;

    if(argint(0, &n) < 0) {
ffffffff40037008:	910043e0 	add	x0, sp, #0x10
ffffffff4003700c:	aa0003e1 	mov	x1, x0
ffffffff40037010:	52800000 	mov	w0, #0x0                   	// #0
ffffffff40037014:	97fffb9b 	bl	ffffffff40035e80 <argint>
ffffffff40037018:	7100001f 	cmp	w0, #0x0
ffffffff4003701c:	5400006a 	b.ge	ffffffff40037028 <sys_sbrk+0x28>  // b.tcont
        return -1;
ffffffff40037020:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40037024:	1400000d 	b	ffffffff40037058 <sys_sbrk+0x58>
    }

    addr = proc->sz;
ffffffff40037028:	90000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003702c:	911e0000 	add	x0, x0, #0x780
ffffffff40037030:	f9400000 	ldr	x0, [x0]
ffffffff40037034:	f9400000 	ldr	x0, [x0]
ffffffff40037038:	f9000fe0 	str	x0, [sp, #24]

    if(growproc(n) < 0) {
ffffffff4003703c:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40037040:	97fff839 	bl	ffffffff40035124 <growproc>
ffffffff40037044:	7100001f 	cmp	w0, #0x0
ffffffff40037048:	5400006a 	b.ge	ffffffff40037054 <sys_sbrk+0x54>  // b.tcont
        return -1;
ffffffff4003704c:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40037050:	14000002 	b	ffffffff40037058 <sys_sbrk+0x58>
    }

    return addr;
ffffffff40037054:	f9400fe0 	ldr	x0, [sp, #24]
}
ffffffff40037058:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff4003705c:	d65f03c0 	ret

ffffffff40037060 <sys_sleep>:

int sys_sleep(void)
{
ffffffff40037060:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40037064:	910003fd 	mov	x29, sp
    long n;
    uint ticks0;

    if(argint(0, &n) < 0) {
ffffffff40037068:	910043e0 	add	x0, sp, #0x10
ffffffff4003706c:	aa0003e1 	mov	x1, x0
ffffffff40037070:	52800000 	mov	w0, #0x0                   	// #0
ffffffff40037074:	97fffb83 	bl	ffffffff40035e80 <argint>
ffffffff40037078:	7100001f 	cmp	w0, #0x0
ffffffff4003707c:	5400006a 	b.ge	ffffffff40037088 <sys_sleep+0x28>  // b.tcont
        return -1;
ffffffff40037080:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff40037084:	14000026 	b	ffffffff4003711c <sys_sleep+0xbc>
    }

    acquire(&tickslock);
ffffffff40037088:	90000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003708c:	911f8000 	add	x0, x0, #0x7e0
ffffffff40037090:	97fffafd 	bl	ffffffff40035c84 <acquire>

    ticks0 = ticks;
ffffffff40037094:	90000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40037098:	91208000 	add	x0, x0, #0x820
ffffffff4003709c:	b9400000 	ldr	w0, [x0]
ffffffff400370a0:	b9001fe0 	str	w0, [sp, #28]

    while(ticks - ticks0 < n){
ffffffff400370a4:	14000011 	b	ffffffff400370e8 <sys_sleep+0x88>
        if(proc->killed){
ffffffff400370a8:	90000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400370ac:	911e0000 	add	x0, x0, #0x780
ffffffff400370b0:	f9400000 	ldr	x0, [x0]
ffffffff400370b4:	b9404000 	ldr	w0, [x0, #64]
ffffffff400370b8:	7100001f 	cmp	w0, #0x0
ffffffff400370bc:	540000c0 	b.eq	ffffffff400370d4 <sys_sleep+0x74>  // b.none
            release(&tickslock);
ffffffff400370c0:	90000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400370c4:	911f8000 	add	x0, x0, #0x7e0
ffffffff400370c8:	97fffaf9 	bl	ffffffff40035cac <release>
            return -1;
ffffffff400370cc:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff400370d0:	14000013 	b	ffffffff4003711c <sys_sleep+0xbc>
        }

        sleep(&ticks, &tickslock);
ffffffff400370d4:	90000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400370d8:	911f8001 	add	x1, x0, #0x7e0
ffffffff400370dc:	90000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400370e0:	91208000 	add	x0, x0, #0x820
ffffffff400370e4:	97fffa11 	bl	ffffffff40035928 <sleep>
    while(ticks - ticks0 < n){
ffffffff400370e8:	90000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400370ec:	91208000 	add	x0, x0, #0x820
ffffffff400370f0:	b9400001 	ldr	w1, [x0]
ffffffff400370f4:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff400370f8:	4b000020 	sub	w0, w1, w0
ffffffff400370fc:	2a0003e1 	mov	w1, w0
ffffffff40037100:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40037104:	eb00003f 	cmp	x1, x0
ffffffff40037108:	54fffd0b 	b.lt	ffffffff400370a8 <sys_sleep+0x48>  // b.tstop
    }

    release(&tickslock);
ffffffff4003710c:	90000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40037110:	911f8000 	add	x0, x0, #0x7e0
ffffffff40037114:	97fffae6 	bl	ffffffff40035cac <release>
    return 0;
ffffffff40037118:	52800000 	mov	w0, #0x0                   	// #0
}
ffffffff4003711c:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40037120:	d65f03c0 	ret

ffffffff40037124 <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int sys_uptime(void)
{
ffffffff40037124:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40037128:	910003fd 	mov	x29, sp
    uint xticks;

    acquire(&tickslock);
ffffffff4003712c:	90000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40037130:	911f8000 	add	x0, x0, #0x7e0
ffffffff40037134:	97fffad4 	bl	ffffffff40035c84 <acquire>
    xticks = ticks;
ffffffff40037138:	90000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003713c:	91208000 	add	x0, x0, #0x820
ffffffff40037140:	b9400000 	ldr	w0, [x0]
ffffffff40037144:	b9001fe0 	str	w0, [sp, #28]
    release(&tickslock);
ffffffff40037148:	90000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003714c:	911f8000 	add	x0, x0, #0x7e0
ffffffff40037150:	97fffad7 	bl	ffffffff40035cac <release>

    return xticks;
ffffffff40037154:	b9401fe0 	ldr	w0, [sp, #28]
}
ffffffff40037158:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff4003715c:	d65f03c0 	ret

ffffffff40037160 <swi_handler>:
#include "arm.h"
#include "proc.h"

// trap routine
void swi_handler (struct trapframe *r, uint32 el, uint32 esr)
{
ffffffff40037160:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40037164:	910003fd 	mov	x29, sp
ffffffff40037168:	f9000fe0 	str	x0, [sp, #24]
ffffffff4003716c:	b90017e1 	str	w1, [sp, #20]
ffffffff40037170:	b90013e2 	str	w2, [sp, #16]
    //cprintf("\tswi_handler: %d\n", r->r0);
    proc->tf = r;
ffffffff40037174:	90000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40037178:	911e0000 	add	x0, x0, #0x780
ffffffff4003717c:	f9400000 	ldr	x0, [x0]
ffffffff40037180:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40037184:	f9001401 	str	x1, [x0, #40]
    syscall ();
ffffffff40037188:	97fffb8e 	bl	ffffffff40035fc0 <syscall>
}
ffffffff4003718c:	d503201f 	nop
ffffffff40037190:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40037194:	d65f03c0 	ret

ffffffff40037198 <irq_handler>:

// trap routine
void irq_handler (struct trapframe *r, uint32 el, uint32 esr)
{
ffffffff40037198:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff4003719c:	910003fd 	mov	x29, sp
ffffffff400371a0:	f9000fe0 	str	x0, [sp, #24]
ffffffff400371a4:	b90017e1 	str	w1, [sp, #20]
ffffffff400371a8:	b90013e2 	str	w2, [sp, #16]
    // proc points to the current process. If the kernel is
    // running scheduler, proc is NULL.
    if (proc != NULL) {
ffffffff400371ac:	90000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400371b0:	911e0000 	add	x0, x0, #0x780
ffffffff400371b4:	f9400000 	ldr	x0, [x0]
ffffffff400371b8:	f100001f 	cmp	x0, #0x0
ffffffff400371bc:	540000c0 	b.eq	ffffffff400371d4 <irq_handler+0x3c>  // b.none
        proc->tf = r;
ffffffff400371c0:	90000560 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff400371c4:	911e0000 	add	x0, x0, #0x780
ffffffff400371c8:	f9400000 	ldr	x0, [x0]
ffffffff400371cc:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff400371d0:	f9001401 	str	x1, [x0, #40]
    }

    pic_dispatch (r);
ffffffff400371d4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400371d8:	9400108a 	bl	ffffffff4003b400 <pic_dispatch>
}
ffffffff400371dc:	d503201f 	nop
ffffffff400371e0:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff400371e4:	d65f03c0 	ret

ffffffff400371e8 <dabort_handler>:

// trap routine
void dabort_handler (struct trapframe *r, uint32 el, uint32 esr)
{
ffffffff400371e8:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff400371ec:	910003fd 	mov	x29, sp
ffffffff400371f0:	f9000fe0 	str	x0, [sp, #24]
ffffffff400371f4:	b90017e1 	str	w1, [sp, #20]
ffffffff400371f8:	b90013e2 	str	w2, [sp, #16]
    uint64 fa;
    extern void show_callstk (char *s);
    cli();
ffffffff400371fc:	97ffe4af 	bl	ffffffff400304b8 <cli>

    // read the fault address register
    asm("MRS %[r], FAR_EL1": [r]"=r" (fa)::);
ffffffff40037200:	d5386000 	mrs	x0, far_el1
ffffffff40037204:	f90017e0 	str	x0, [sp, #40]
    
    cprintf ("data abort: instruction 0x%x, fault addr 0x%x\n",
ffffffff40037208:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003720c:	f9400400 	ldr	x0, [x0, #8]
ffffffff40037210:	f94017e2 	ldr	x2, [sp, #40]
ffffffff40037214:	aa0003e1 	mov	x1, x0
ffffffff40037218:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003721c:	91278000 	add	x0, x0, #0x9e0
ffffffff40037220:	97ffe915 	bl	ffffffff40031674 <cprintf>
             r->pc, fa);
  
    dump_trapframe (r);
ffffffff40037224:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40037228:	94000079 	bl	ffffffff4003740c <dump_trapframe>
    //show_callstk("Stack dump for data exception.");
}
ffffffff4003722c:	d503201f 	nop
ffffffff40037230:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff40037234:	d65f03c0 	ret

ffffffff40037238 <iabort_handler>:

// trap routine
void iabort_handler (struct trapframe *r, uint32 el, uint32 esr)
{
ffffffff40037238:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff4003723c:	910003fd 	mov	x29, sp
ffffffff40037240:	f9000fe0 	str	x0, [sp, #24]
ffffffff40037244:	b90017e1 	str	w1, [sp, #20]
ffffffff40037248:	b90013e2 	str	w2, [sp, #16]
    cli();
ffffffff4003724c:	97ffe49b 	bl	ffffffff400304b8 <cli>
    cprintf ("prefetch abort at: 0x%x\n", r->pc);
ffffffff40037250:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40037254:	f9400400 	ldr	x0, [x0, #8]
ffffffff40037258:	aa0003e1 	mov	x1, x0
ffffffff4003725c:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037260:	91284000 	add	x0, x0, #0xa10
ffffffff40037264:	97ffe904 	bl	ffffffff40031674 <cprintf>

    dump_trapframe (r);
ffffffff40037268:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003726c:	94000068 	bl	ffffffff4003740c <dump_trapframe>
}
ffffffff40037270:	d503201f 	nop
ffffffff40037274:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40037278:	d65f03c0 	ret

ffffffff4003727c <reset_handler>:

// trap routine
void reset_handler (struct trapframe *r, uint32 el, uint32 esr)
{
ffffffff4003727c:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40037280:	910003fd 	mov	x29, sp
ffffffff40037284:	f9000fe0 	str	x0, [sp, #24]
ffffffff40037288:	b90017e1 	str	w1, [sp, #20]
ffffffff4003728c:	b90013e2 	str	w2, [sp, #16]
    cli();
ffffffff40037290:	97ffe48a 	bl	ffffffff400304b8 <cli>
    cprintf ("reset at: 0x%x \n", r->pc);
ffffffff40037294:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40037298:	f9400400 	ldr	x0, [x0, #8]
ffffffff4003729c:	aa0003e1 	mov	x1, x0
ffffffff400372a0:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400372a4:	9128c000 	add	x0, x0, #0xa30
ffffffff400372a8:	97ffe8f3 	bl	ffffffff40031674 <cprintf>
}
ffffffff400372ac:	d503201f 	nop
ffffffff400372b0:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff400372b4:	d65f03c0 	ret

ffffffff400372b8 <und_handler>:

// trap routine
void und_handler (struct trapframe *r, uint32 el, uint32 esr)
{
ffffffff400372b8:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff400372bc:	910003fd 	mov	x29, sp
ffffffff400372c0:	f9000fe0 	str	x0, [sp, #24]
ffffffff400372c4:	b90017e1 	str	w1, [sp, #20]
ffffffff400372c8:	b90013e2 	str	w2, [sp, #16]
    cli();
ffffffff400372cc:	97ffe47b 	bl	ffffffff400304b8 <cli>
    cprintf ("und at: 0x%x \n", r->pc);
ffffffff400372d0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400372d4:	f9400400 	ldr	x0, [x0, #8]
ffffffff400372d8:	aa0003e1 	mov	x1, x0
ffffffff400372dc:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400372e0:	91292000 	add	x0, x0, #0xa48
ffffffff400372e4:	97ffe8e4 	bl	ffffffff40031674 <cprintf>
    dump_trapframe (r);
ffffffff400372e8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400372ec:	94000048 	bl	ffffffff4003740c <dump_trapframe>
}
ffffffff400372f0:	d503201f 	nop
ffffffff400372f4:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff400372f8:	d65f03c0 	ret

ffffffff400372fc <na_handler>:

// trap routine
void na_handler (struct trapframe *r, uint32 el, uint32 esr)
{
ffffffff400372fc:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40037300:	910003fd 	mov	x29, sp
ffffffff40037304:	f9000fe0 	str	x0, [sp, #24]
ffffffff40037308:	b90017e1 	str	w1, [sp, #20]
ffffffff4003730c:	b90013e2 	str	w2, [sp, #16]
    cli();
ffffffff40037310:	97ffe46a 	bl	ffffffff400304b8 <cli>
    cprintf ("n/a at: 0x%x \n", r->pc);
ffffffff40037314:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40037318:	f9400400 	ldr	x0, [x0, #8]
ffffffff4003731c:	aa0003e1 	mov	x1, x0
ffffffff40037320:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037324:	91296000 	add	x0, x0, #0xa58
ffffffff40037328:	97ffe8d3 	bl	ffffffff40031674 <cprintf>
}
ffffffff4003732c:	d503201f 	nop
ffffffff40037330:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40037334:	d65f03c0 	ret

ffffffff40037338 <fiq_handler>:

// trap routine
void fiq_handler (struct trapframe *r, uint32 el, uint32 esr)
{
ffffffff40037338:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff4003733c:	910003fd 	mov	x29, sp
ffffffff40037340:	f9000fe0 	str	x0, [sp, #24]
ffffffff40037344:	b90017e1 	str	w1, [sp, #20]
ffffffff40037348:	b90013e2 	str	w2, [sp, #16]
    cli();
ffffffff4003734c:	97ffe45b 	bl	ffffffff400304b8 <cli>
    cprintf ("fiq at: 0x%x \n", r->pc);
ffffffff40037350:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40037354:	f9400400 	ldr	x0, [x0, #8]
ffffffff40037358:	aa0003e1 	mov	x1, x0
ffffffff4003735c:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037360:	9129a000 	add	x0, x0, #0xa68
ffffffff40037364:	97ffe8c4 	bl	ffffffff40031674 <cprintf>
}
ffffffff40037368:	d503201f 	nop
ffffffff4003736c:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40037370:	d65f03c0 	ret

ffffffff40037374 <bad_handler>:

// trap routine
void bad_handler (struct trapframe *r, uint32 el, uint32 esr)
{
ffffffff40037374:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40037378:	910003fd 	mov	x29, sp
ffffffff4003737c:	f9000fe0 	str	x0, [sp, #24]
ffffffff40037380:	b90017e1 	str	w1, [sp, #20]
ffffffff40037384:	b90013e2 	str	w2, [sp, #16]
    cli();
ffffffff40037388:	97ffe44c 	bl	ffffffff400304b8 <cli>
    cprintf ("Bad Exception\n");
ffffffff4003738c:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037390:	9129e000 	add	x0, x0, #0xa78
ffffffff40037394:	97ffe8b8 	bl	ffffffff40031674 <cprintf>
}
ffffffff40037398:	d503201f 	nop
ffffffff4003739c:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff400373a0:	d65f03c0 	ret

ffffffff400373a4 <error_handler>:

// trap routine
void error_handler (struct trapframe *r, uint32 el, uint32 esr)
{
ffffffff400373a4:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff400373a8:	910003fd 	mov	x29, sp
ffffffff400373ac:	f9000fe0 	str	x0, [sp, #24]
ffffffff400373b0:	b90017e1 	str	w1, [sp, #20]
ffffffff400373b4:	b90013e2 	str	w2, [sp, #16]
    cli();
ffffffff400373b8:	97ffe440 	bl	ffffffff400304b8 <cli>
    cprintf ("Error Exception\n");
ffffffff400373bc:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400373c0:	912a2000 	add	x0, x0, #0xa88
ffffffff400373c4:	97ffe8ac 	bl	ffffffff40031674 <cprintf>
}
ffffffff400373c8:	d503201f 	nop
ffffffff400373cc:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff400373d0:	d65f03c0 	ret

ffffffff400373d4 <default_handler>:

// trap routine
void default_handler (struct trapframe *r, uint32 el, uint32 esr)
{
ffffffff400373d4:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff400373d8:	910003fd 	mov	x29, sp
ffffffff400373dc:	f9000fe0 	str	x0, [sp, #24]
ffffffff400373e0:	b90017e1 	str	w1, [sp, #20]
ffffffff400373e4:	b90013e2 	str	w2, [sp, #16]
    cli();
ffffffff400373e8:	97ffe434 	bl	ffffffff400304b8 <cli>
    cprintf ("Default Exception\n");
ffffffff400373ec:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400373f0:	912a8000 	add	x0, x0, #0xaa0
ffffffff400373f4:	97ffe8a0 	bl	ffffffff40031674 <cprintf>
}
ffffffff400373f8:	d503201f 	nop
ffffffff400373fc:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40037400:	d65f03c0 	ret

ffffffff40037404 <trap_init>:
// low-level init code: in real hardware, lower memory is usually mapped
// to flash during startup, we need to remap it to SDRAM
void trap_init ( )
{
    //Nothing to do
}
ffffffff40037404:	d503201f 	nop
ffffffff40037408:	d65f03c0 	ret

ffffffff4003740c <dump_trapframe>:

void dump_trapframe (struct trapframe *tf)
{
ffffffff4003740c:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40037410:	910003fd 	mov	x29, sp
ffffffff40037414:	f9000fe0 	str	x0, [sp, #24]
    cprintf ("     sp: 0x%x\n", tf->sp);
ffffffff40037418:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003741c:	f9400000 	ldr	x0, [x0]
ffffffff40037420:	aa0003e1 	mov	x1, x0
ffffffff40037424:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037428:	912ae000 	add	x0, x0, #0xab8
ffffffff4003742c:	97ffe892 	bl	ffffffff40031674 <cprintf>
    cprintf ("     pc: 0x%x\n", tf->pc);
ffffffff40037430:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40037434:	f9400400 	ldr	x0, [x0, #8]
ffffffff40037438:	aa0003e1 	mov	x1, x0
ffffffff4003743c:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037440:	912b2000 	add	x0, x0, #0xac8
ffffffff40037444:	97ffe88c 	bl	ffffffff40031674 <cprintf>
    cprintf ("   spsr: 0x%x\n", tf->spsr);
ffffffff40037448:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003744c:	f9400800 	ldr	x0, [x0, #16]
ffffffff40037450:	aa0003e1 	mov	x1, x0
ffffffff40037454:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037458:	912b6000 	add	x0, x0, #0xad8
ffffffff4003745c:	97ffe886 	bl	ffffffff40031674 <cprintf>
    cprintf ("     r0: 0x%x\n", tf->r0);
ffffffff40037460:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40037464:	f9400c00 	ldr	x0, [x0, #24]
ffffffff40037468:	aa0003e1 	mov	x1, x0
ffffffff4003746c:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037470:	912ba000 	add	x0, x0, #0xae8
ffffffff40037474:	97ffe880 	bl	ffffffff40031674 <cprintf>
    cprintf ("     r1: 0x%x\n", tf->r1);
ffffffff40037478:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003747c:	f9401000 	ldr	x0, [x0, #32]
ffffffff40037480:	aa0003e1 	mov	x1, x0
ffffffff40037484:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037488:	912be000 	add	x0, x0, #0xaf8
ffffffff4003748c:	97ffe87a 	bl	ffffffff40031674 <cprintf>
    cprintf ("     r2: 0x%x\n", tf->r2);
ffffffff40037490:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40037494:	f9401400 	ldr	x0, [x0, #40]
ffffffff40037498:	aa0003e1 	mov	x1, x0
ffffffff4003749c:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400374a0:	912c2000 	add	x0, x0, #0xb08
ffffffff400374a4:	97ffe874 	bl	ffffffff40031674 <cprintf>
    cprintf ("     r3: 0x%x\n", tf->r3);
ffffffff400374a8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400374ac:	f9401800 	ldr	x0, [x0, #48]
ffffffff400374b0:	aa0003e1 	mov	x1, x0
ffffffff400374b4:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400374b8:	912c6000 	add	x0, x0, #0xb18
ffffffff400374bc:	97ffe86e 	bl	ffffffff40031674 <cprintf>
    cprintf ("     r4: 0x%x\n", tf->r4);
ffffffff400374c0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400374c4:	f9401c00 	ldr	x0, [x0, #56]
ffffffff400374c8:	aa0003e1 	mov	x1, x0
ffffffff400374cc:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400374d0:	912ca000 	add	x0, x0, #0xb28
ffffffff400374d4:	97ffe868 	bl	ffffffff40031674 <cprintf>
    cprintf ("     r5: 0x%x\n", tf->r5);
ffffffff400374d8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400374dc:	f9402000 	ldr	x0, [x0, #64]
ffffffff400374e0:	aa0003e1 	mov	x1, x0
ffffffff400374e4:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400374e8:	912ce000 	add	x0, x0, #0xb38
ffffffff400374ec:	97ffe862 	bl	ffffffff40031674 <cprintf>
    cprintf ("     r6: 0x%x\n", tf->r6);
ffffffff400374f0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400374f4:	f9402400 	ldr	x0, [x0, #72]
ffffffff400374f8:	aa0003e1 	mov	x1, x0
ffffffff400374fc:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037500:	912d2000 	add	x0, x0, #0xb48
ffffffff40037504:	97ffe85c 	bl	ffffffff40031674 <cprintf>
    cprintf ("     r7: 0x%x\n", tf->r7);
ffffffff40037508:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003750c:	f9402800 	ldr	x0, [x0, #80]
ffffffff40037510:	aa0003e1 	mov	x1, x0
ffffffff40037514:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037518:	912d6000 	add	x0, x0, #0xb58
ffffffff4003751c:	97ffe856 	bl	ffffffff40031674 <cprintf>
    cprintf ("     r8: 0x%x\n", tf->r8);
ffffffff40037520:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40037524:	f9402c00 	ldr	x0, [x0, #88]
ffffffff40037528:	aa0003e1 	mov	x1, x0
ffffffff4003752c:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037530:	912da000 	add	x0, x0, #0xb68
ffffffff40037534:	97ffe850 	bl	ffffffff40031674 <cprintf>
    cprintf ("     r9: 0x%x\n", tf->r9);
ffffffff40037538:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003753c:	f9403000 	ldr	x0, [x0, #96]
ffffffff40037540:	aa0003e1 	mov	x1, x0
ffffffff40037544:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037548:	912de000 	add	x0, x0, #0xb78
ffffffff4003754c:	97ffe84a 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r10: 0x%x\n", tf->r10);
ffffffff40037550:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40037554:	f9403400 	ldr	x0, [x0, #104]
ffffffff40037558:	aa0003e1 	mov	x1, x0
ffffffff4003755c:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037560:	912e2000 	add	x0, x0, #0xb88
ffffffff40037564:	97ffe844 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r11: 0x%x\n", tf->r11);
ffffffff40037568:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003756c:	f9403800 	ldr	x0, [x0, #112]
ffffffff40037570:	aa0003e1 	mov	x1, x0
ffffffff40037574:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037578:	912e6000 	add	x0, x0, #0xb98
ffffffff4003757c:	97ffe83e 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r12: 0x%x\n", tf->r12);
ffffffff40037580:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40037584:	f9403c00 	ldr	x0, [x0, #120]
ffffffff40037588:	aa0003e1 	mov	x1, x0
ffffffff4003758c:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037590:	912ea000 	add	x0, x0, #0xba8
ffffffff40037594:	97ffe838 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r13: 0x%x\n", tf->r13);
ffffffff40037598:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003759c:	f9404000 	ldr	x0, [x0, #128]
ffffffff400375a0:	aa0003e1 	mov	x1, x0
ffffffff400375a4:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400375a8:	912ee000 	add	x0, x0, #0xbb8
ffffffff400375ac:	97ffe832 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r14: 0x%x\n", tf->r14);
ffffffff400375b0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400375b4:	f9404400 	ldr	x0, [x0, #136]
ffffffff400375b8:	aa0003e1 	mov	x1, x0
ffffffff400375bc:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400375c0:	912f2000 	add	x0, x0, #0xbc8
ffffffff400375c4:	97ffe82c 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r15: 0x%x\n", tf->r15);
ffffffff400375c8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400375cc:	f9404800 	ldr	x0, [x0, #144]
ffffffff400375d0:	aa0003e1 	mov	x1, x0
ffffffff400375d4:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400375d8:	912f6000 	add	x0, x0, #0xbd8
ffffffff400375dc:	97ffe826 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r16: 0x%x\n", tf->r16);
ffffffff400375e0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400375e4:	f9404c00 	ldr	x0, [x0, #152]
ffffffff400375e8:	aa0003e1 	mov	x1, x0
ffffffff400375ec:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400375f0:	912fa000 	add	x0, x0, #0xbe8
ffffffff400375f4:	97ffe820 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r17: 0x%x\n", tf->r17);
ffffffff400375f8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400375fc:	f9405000 	ldr	x0, [x0, #160]
ffffffff40037600:	aa0003e1 	mov	x1, x0
ffffffff40037604:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037608:	912fe000 	add	x0, x0, #0xbf8
ffffffff4003760c:	97ffe81a 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r18: 0x%x\n", tf->r18);
ffffffff40037610:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40037614:	f9405400 	ldr	x0, [x0, #168]
ffffffff40037618:	aa0003e1 	mov	x1, x0
ffffffff4003761c:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037620:	91302000 	add	x0, x0, #0xc08
ffffffff40037624:	97ffe814 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r19: 0x%x\n", tf->r19);
ffffffff40037628:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003762c:	f9405800 	ldr	x0, [x0, #176]
ffffffff40037630:	aa0003e1 	mov	x1, x0
ffffffff40037634:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037638:	91306000 	add	x0, x0, #0xc18
ffffffff4003763c:	97ffe80e 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r20: 0x%x\n", tf->r20);
ffffffff40037640:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40037644:	f9405c00 	ldr	x0, [x0, #184]
ffffffff40037648:	aa0003e1 	mov	x1, x0
ffffffff4003764c:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037650:	9130a000 	add	x0, x0, #0xc28
ffffffff40037654:	97ffe808 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r21: 0x%x\n", tf->r21);
ffffffff40037658:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003765c:	f9406000 	ldr	x0, [x0, #192]
ffffffff40037660:	aa0003e1 	mov	x1, x0
ffffffff40037664:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037668:	9130e000 	add	x0, x0, #0xc38
ffffffff4003766c:	97ffe802 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r22: 0x%x\n", tf->r22);
ffffffff40037670:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40037674:	f9406400 	ldr	x0, [x0, #200]
ffffffff40037678:	aa0003e1 	mov	x1, x0
ffffffff4003767c:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037680:	91312000 	add	x0, x0, #0xc48
ffffffff40037684:	97ffe7fc 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r23: 0x%x\n", tf->r23);
ffffffff40037688:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003768c:	f9406800 	ldr	x0, [x0, #208]
ffffffff40037690:	aa0003e1 	mov	x1, x0
ffffffff40037694:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037698:	91316000 	add	x0, x0, #0xc58
ffffffff4003769c:	97ffe7f6 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r24: 0x%x\n", tf->r24);
ffffffff400376a0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400376a4:	f9406c00 	ldr	x0, [x0, #216]
ffffffff400376a8:	aa0003e1 	mov	x1, x0
ffffffff400376ac:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400376b0:	9131a000 	add	x0, x0, #0xc68
ffffffff400376b4:	97ffe7f0 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r25: 0x%x\n", tf->r25);
ffffffff400376b8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400376bc:	f9407000 	ldr	x0, [x0, #224]
ffffffff400376c0:	aa0003e1 	mov	x1, x0
ffffffff400376c4:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400376c8:	9131e000 	add	x0, x0, #0xc78
ffffffff400376cc:	97ffe7ea 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r26: 0x%x\n", tf->r26);
ffffffff400376d0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400376d4:	f9407400 	ldr	x0, [x0, #232]
ffffffff400376d8:	aa0003e1 	mov	x1, x0
ffffffff400376dc:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400376e0:	91322000 	add	x0, x0, #0xc88
ffffffff400376e4:	97ffe7e4 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r27: 0x%x\n", tf->r27);
ffffffff400376e8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff400376ec:	f9407800 	ldr	x0, [x0, #240]
ffffffff400376f0:	aa0003e1 	mov	x1, x0
ffffffff400376f4:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff400376f8:	91326000 	add	x0, x0, #0xc98
ffffffff400376fc:	97ffe7de 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r28: 0x%x\n", tf->r28);
ffffffff40037700:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40037704:	f9407c00 	ldr	x0, [x0, #248]
ffffffff40037708:	aa0003e1 	mov	x1, x0
ffffffff4003770c:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037710:	9132a000 	add	x0, x0, #0xca8
ffffffff40037714:	97ffe7d8 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r29: 0x%x\n", tf->r29);
ffffffff40037718:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003771c:	f9408000 	ldr	x0, [x0, #256]
ffffffff40037720:	aa0003e1 	mov	x1, x0
ffffffff40037724:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037728:	9132e000 	add	x0, x0, #0xcb8
ffffffff4003772c:	97ffe7d2 	bl	ffffffff40031674 <cprintf>
    cprintf ("    r30: 0x%x\n", tf->r30);
ffffffff40037730:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40037734:	f9408400 	ldr	x0, [x0, #264]
ffffffff40037738:	aa0003e1 	mov	x1, x0
ffffffff4003773c:	90000020 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40037740:	91332000 	add	x0, x0, #0xcc8
ffffffff40037744:	97ffe7cc 	bl	ffffffff40031674 <cprintf>
}
ffffffff40037748:	d503201f 	nop
ffffffff4003774c:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40037750:	d65f03c0 	ret
	...

ffffffff40038000 <trapret>:
ffffffff40038000:	a9505ff6 	ldp	x22, x23, [sp, #256]
ffffffff40038004:	a94f73fe 	ldp	x30, x28, [sp, #240]
ffffffff40038008:	d51e4036 	msr	elr_el3, x22
ffffffff4003800c:	d51e4017 	msr	spsr_el3, x23
ffffffff40038010:	d518411c 	msr	sp_el0, x28
ffffffff40038014:	910003fd 	mov	x29, sp
ffffffff40038018:	a8c107a0 	ldp	x0, x1, [x29], #16
ffffffff4003801c:	a8c10fa2 	ldp	x2, x3, [x29], #16
ffffffff40038020:	a8c117a4 	ldp	x4, x5, [x29], #16
ffffffff40038024:	a8c11fa6 	ldp	x6, x7, [x29], #16
ffffffff40038028:	a8c127a8 	ldp	x8, x9, [x29], #16
ffffffff4003802c:	a8c12faa 	ldp	x10, x11, [x29], #16
ffffffff40038030:	a8c137ac 	ldp	x12, x13, [x29], #16
ffffffff40038034:	a8c13fae 	ldp	x14, x15, [x29], #16
ffffffff40038038:	a8c147b0 	ldp	x16, x17, [x29], #16
ffffffff4003803c:	a8c14fb2 	ldp	x18, x19, [x29], #16
ffffffff40038040:	a8c157b4 	ldp	x20, x21, [x29], #16
ffffffff40038044:	a8c15fb6 	ldp	x22, x23, [x29], #16
ffffffff40038048:	a8c167b8 	ldp	x24, x25, [x29], #16
ffffffff4003804c:	a8c16fba 	ldp	x26, x27, [x29], #16
ffffffff40038050:	f84087bc 	ldr	x28, [x29], #8
ffffffff40038054:	f94003bd 	ldr	x29, [x29]
ffffffff40038058:	d69f03e0 	eret
ffffffff4003805c:	d503201f 	nop
ffffffff40038060:	d503201f 	nop
ffffffff40038064:	d503201f 	nop
ffffffff40038068:	d503201f 	nop
ffffffff4003806c:	d503201f 	nop
ffffffff40038070:	d503201f 	nop
ffffffff40038074:	d503201f 	nop
ffffffff40038078:	d503201f 	nop
ffffffff4003807c:	d503201f 	nop
ffffffff40038080:	d503201f 	nop
ffffffff40038084:	d503201f 	nop
ffffffff40038088:	d503201f 	nop
ffffffff4003808c:	d503201f 	nop
ffffffff40038090:	d503201f 	nop
ffffffff40038094:	d503201f 	nop
ffffffff40038098:	d503201f 	nop
ffffffff4003809c:	d503201f 	nop
ffffffff400380a0:	d503201f 	nop
ffffffff400380a4:	d503201f 	nop
ffffffff400380a8:	d503201f 	nop
ffffffff400380ac:	d503201f 	nop
ffffffff400380b0:	d503201f 	nop
ffffffff400380b4:	d503201f 	nop
ffffffff400380b8:	d503201f 	nop
ffffffff400380bc:	d503201f 	nop
ffffffff400380c0:	d503201f 	nop
ffffffff400380c4:	d503201f 	nop
ffffffff400380c8:	d503201f 	nop
ffffffff400380cc:	d503201f 	nop
ffffffff400380d0:	d503201f 	nop
ffffffff400380d4:	d503201f 	nop
ffffffff400380d8:	d503201f 	nop
ffffffff400380dc:	d503201f 	nop
ffffffff400380e0:	d503201f 	nop
ffffffff400380e4:	d503201f 	nop
ffffffff400380e8:	d503201f 	nop
ffffffff400380ec:	d503201f 	nop
ffffffff400380f0:	d503201f 	nop
ffffffff400380f4:	d503201f 	nop
ffffffff400380f8:	d503201f 	nop
ffffffff400380fc:	d503201f 	nop
ffffffff40038100:	d503201f 	nop
ffffffff40038104:	d503201f 	nop
ffffffff40038108:	d503201f 	nop
ffffffff4003810c:	d503201f 	nop
ffffffff40038110:	d503201f 	nop
ffffffff40038114:	d503201f 	nop
ffffffff40038118:	d503201f 	nop
ffffffff4003811c:	d503201f 	nop
ffffffff40038120:	d503201f 	nop
ffffffff40038124:	d503201f 	nop
ffffffff40038128:	d503201f 	nop
ffffffff4003812c:	d503201f 	nop
ffffffff40038130:	d503201f 	nop
ffffffff40038134:	d503201f 	nop
ffffffff40038138:	d503201f 	nop
ffffffff4003813c:	d503201f 	nop
ffffffff40038140:	d503201f 	nop
ffffffff40038144:	d503201f 	nop
ffffffff40038148:	d503201f 	nop
ffffffff4003814c:	d503201f 	nop
ffffffff40038150:	d503201f 	nop
ffffffff40038154:	d503201f 	nop
ffffffff40038158:	d503201f 	nop
ffffffff4003815c:	d503201f 	nop
ffffffff40038160:	d503201f 	nop
ffffffff40038164:	d503201f 	nop
ffffffff40038168:	d503201f 	nop
ffffffff4003816c:	d503201f 	nop
ffffffff40038170:	d503201f 	nop
ffffffff40038174:	d503201f 	nop
ffffffff40038178:	d503201f 	nop
ffffffff4003817c:	d503201f 	nop
ffffffff40038180:	d503201f 	nop
ffffffff40038184:	d503201f 	nop
ffffffff40038188:	d503201f 	nop
ffffffff4003818c:	d503201f 	nop
ffffffff40038190:	d503201f 	nop
ffffffff40038194:	d503201f 	nop
ffffffff40038198:	d503201f 	nop
ffffffff4003819c:	d503201f 	nop
ffffffff400381a0:	d503201f 	nop
ffffffff400381a4:	d503201f 	nop
ffffffff400381a8:	d503201f 	nop
ffffffff400381ac:	d503201f 	nop
ffffffff400381b0:	d503201f 	nop
ffffffff400381b4:	d503201f 	nop
ffffffff400381b8:	d503201f 	nop
ffffffff400381bc:	d503201f 	nop
ffffffff400381c0:	d503201f 	nop
ffffffff400381c4:	d503201f 	nop
ffffffff400381c8:	d503201f 	nop
ffffffff400381cc:	d503201f 	nop
ffffffff400381d0:	d503201f 	nop
ffffffff400381d4:	d503201f 	nop
ffffffff400381d8:	d503201f 	nop
ffffffff400381dc:	d503201f 	nop
ffffffff400381e0:	d503201f 	nop
ffffffff400381e4:	d503201f 	nop
ffffffff400381e8:	d503201f 	nop
ffffffff400381ec:	d503201f 	nop
ffffffff400381f0:	d503201f 	nop
ffffffff400381f4:	d503201f 	nop
ffffffff400381f8:	d503201f 	nop
ffffffff400381fc:	d503201f 	nop
ffffffff40038200:	d503201f 	nop
ffffffff40038204:	d503201f 	nop
ffffffff40038208:	d503201f 	nop
ffffffff4003820c:	d503201f 	nop
ffffffff40038210:	d503201f 	nop
ffffffff40038214:	d503201f 	nop
ffffffff40038218:	d503201f 	nop
ffffffff4003821c:	d503201f 	nop
ffffffff40038220:	d503201f 	nop
ffffffff40038224:	d503201f 	nop
ffffffff40038228:	d503201f 	nop
ffffffff4003822c:	d503201f 	nop
ffffffff40038230:	d503201f 	nop
ffffffff40038234:	d503201f 	nop
ffffffff40038238:	d503201f 	nop
ffffffff4003823c:	d503201f 	nop
ffffffff40038240:	d503201f 	nop
ffffffff40038244:	d503201f 	nop
ffffffff40038248:	d503201f 	nop
ffffffff4003824c:	d503201f 	nop
ffffffff40038250:	d503201f 	nop
ffffffff40038254:	d503201f 	nop
ffffffff40038258:	d503201f 	nop
ffffffff4003825c:	d503201f 	nop
ffffffff40038260:	d503201f 	nop
ffffffff40038264:	d503201f 	nop
ffffffff40038268:	d503201f 	nop
ffffffff4003826c:	d503201f 	nop
ffffffff40038270:	d503201f 	nop
ffffffff40038274:	d503201f 	nop
ffffffff40038278:	d503201f 	nop
ffffffff4003827c:	d503201f 	nop
ffffffff40038280:	d503201f 	nop
ffffffff40038284:	d503201f 	nop
ffffffff40038288:	d503201f 	nop
ffffffff4003828c:	d503201f 	nop
ffffffff40038290:	d503201f 	nop
ffffffff40038294:	d503201f 	nop
ffffffff40038298:	d503201f 	nop
ffffffff4003829c:	d503201f 	nop
ffffffff400382a0:	d503201f 	nop
ffffffff400382a4:	d503201f 	nop
ffffffff400382a8:	d503201f 	nop
ffffffff400382ac:	d503201f 	nop
ffffffff400382b0:	d503201f 	nop
ffffffff400382b4:	d503201f 	nop
ffffffff400382b8:	d503201f 	nop
ffffffff400382bc:	d503201f 	nop
ffffffff400382c0:	d503201f 	nop
ffffffff400382c4:	d503201f 	nop
ffffffff400382c8:	d503201f 	nop
ffffffff400382cc:	d503201f 	nop
ffffffff400382d0:	d503201f 	nop
ffffffff400382d4:	d503201f 	nop
ffffffff400382d8:	d503201f 	nop
ffffffff400382dc:	d503201f 	nop
ffffffff400382e0:	d503201f 	nop
ffffffff400382e4:	d503201f 	nop
ffffffff400382e8:	d503201f 	nop
ffffffff400382ec:	d503201f 	nop
ffffffff400382f0:	d503201f 	nop
ffffffff400382f4:	d503201f 	nop
ffffffff400382f8:	d503201f 	nop
ffffffff400382fc:	d503201f 	nop
ffffffff40038300:	d503201f 	nop
ffffffff40038304:	d503201f 	nop
ffffffff40038308:	d503201f 	nop
ffffffff4003830c:	d503201f 	nop
ffffffff40038310:	d503201f 	nop
ffffffff40038314:	d503201f 	nop
ffffffff40038318:	d503201f 	nop
ffffffff4003831c:	d503201f 	nop
ffffffff40038320:	d503201f 	nop
ffffffff40038324:	d503201f 	nop
ffffffff40038328:	d503201f 	nop
ffffffff4003832c:	d503201f 	nop
ffffffff40038330:	d503201f 	nop
ffffffff40038334:	d503201f 	nop
ffffffff40038338:	d503201f 	nop
ffffffff4003833c:	d503201f 	nop
ffffffff40038340:	d503201f 	nop
ffffffff40038344:	d503201f 	nop
ffffffff40038348:	d503201f 	nop
ffffffff4003834c:	d503201f 	nop
ffffffff40038350:	d503201f 	nop
ffffffff40038354:	d503201f 	nop
ffffffff40038358:	d503201f 	nop
ffffffff4003835c:	d503201f 	nop
ffffffff40038360:	d503201f 	nop
ffffffff40038364:	d503201f 	nop
ffffffff40038368:	d503201f 	nop
ffffffff4003836c:	d503201f 	nop
ffffffff40038370:	d503201f 	nop
ffffffff40038374:	d503201f 	nop
ffffffff40038378:	d503201f 	nop
ffffffff4003837c:	d503201f 	nop
ffffffff40038380:	d503201f 	nop
ffffffff40038384:	d503201f 	nop
ffffffff40038388:	d503201f 	nop
ffffffff4003838c:	d503201f 	nop
ffffffff40038390:	d503201f 	nop
ffffffff40038394:	d503201f 	nop
ffffffff40038398:	d503201f 	nop
ffffffff4003839c:	d503201f 	nop
ffffffff400383a0:	d503201f 	nop
ffffffff400383a4:	d503201f 	nop
ffffffff400383a8:	d503201f 	nop
ffffffff400383ac:	d503201f 	nop
ffffffff400383b0:	d503201f 	nop
ffffffff400383b4:	d503201f 	nop
ffffffff400383b8:	d503201f 	nop
ffffffff400383bc:	d503201f 	nop
ffffffff400383c0:	d503201f 	nop
ffffffff400383c4:	d503201f 	nop
ffffffff400383c8:	d503201f 	nop
ffffffff400383cc:	d503201f 	nop
ffffffff400383d0:	d503201f 	nop
ffffffff400383d4:	d503201f 	nop
ffffffff400383d8:	d503201f 	nop
ffffffff400383dc:	d503201f 	nop
ffffffff400383e0:	d503201f 	nop
ffffffff400383e4:	d503201f 	nop
ffffffff400383e8:	d503201f 	nop
ffffffff400383ec:	d503201f 	nop
ffffffff400383f0:	d503201f 	nop
ffffffff400383f4:	d503201f 	nop
ffffffff400383f8:	d503201f 	nop
ffffffff400383fc:	d503201f 	nop
ffffffff40038400:	d503201f 	nop
ffffffff40038404:	d503201f 	nop
ffffffff40038408:	d503201f 	nop
ffffffff4003840c:	d503201f 	nop
ffffffff40038410:	d503201f 	nop
ffffffff40038414:	d503201f 	nop
ffffffff40038418:	d503201f 	nop
ffffffff4003841c:	d503201f 	nop
ffffffff40038420:	d503201f 	nop
ffffffff40038424:	d503201f 	nop
ffffffff40038428:	d503201f 	nop
ffffffff4003842c:	d503201f 	nop
ffffffff40038430:	d503201f 	nop
ffffffff40038434:	d503201f 	nop
ffffffff40038438:	d503201f 	nop
ffffffff4003843c:	d503201f 	nop
ffffffff40038440:	d503201f 	nop
ffffffff40038444:	d503201f 	nop
ffffffff40038448:	d503201f 	nop
ffffffff4003844c:	d503201f 	nop
ffffffff40038450:	d503201f 	nop
ffffffff40038454:	d503201f 	nop
ffffffff40038458:	d503201f 	nop
ffffffff4003845c:	d503201f 	nop
ffffffff40038460:	d503201f 	nop
ffffffff40038464:	d503201f 	nop
ffffffff40038468:	d503201f 	nop
ffffffff4003846c:	d503201f 	nop
ffffffff40038470:	d503201f 	nop
ffffffff40038474:	d503201f 	nop
ffffffff40038478:	d503201f 	nop
ffffffff4003847c:	d503201f 	nop
ffffffff40038480:	d503201f 	nop
ffffffff40038484:	d503201f 	nop
ffffffff40038488:	d503201f 	nop
ffffffff4003848c:	d503201f 	nop
ffffffff40038490:	d503201f 	nop
ffffffff40038494:	d503201f 	nop
ffffffff40038498:	d503201f 	nop
ffffffff4003849c:	d503201f 	nop
ffffffff400384a0:	d503201f 	nop
ffffffff400384a4:	d503201f 	nop
ffffffff400384a8:	d503201f 	nop
ffffffff400384ac:	d503201f 	nop
ffffffff400384b0:	d503201f 	nop
ffffffff400384b4:	d503201f 	nop
ffffffff400384b8:	d503201f 	nop
ffffffff400384bc:	d503201f 	nop
ffffffff400384c0:	d503201f 	nop
ffffffff400384c4:	d503201f 	nop
ffffffff400384c8:	d503201f 	nop
ffffffff400384cc:	d503201f 	nop
ffffffff400384d0:	d503201f 	nop
ffffffff400384d4:	d503201f 	nop
ffffffff400384d8:	d503201f 	nop
ffffffff400384dc:	d503201f 	nop
ffffffff400384e0:	d503201f 	nop
ffffffff400384e4:	d503201f 	nop
ffffffff400384e8:	d503201f 	nop
ffffffff400384ec:	d503201f 	nop
ffffffff400384f0:	d503201f 	nop
ffffffff400384f4:	d503201f 	nop
ffffffff400384f8:	d503201f 	nop
ffffffff400384fc:	d503201f 	nop
ffffffff40038500:	d503201f 	nop
ffffffff40038504:	d503201f 	nop
ffffffff40038508:	d503201f 	nop
ffffffff4003850c:	d503201f 	nop
ffffffff40038510:	d503201f 	nop
ffffffff40038514:	d503201f 	nop
ffffffff40038518:	d503201f 	nop
ffffffff4003851c:	d503201f 	nop
ffffffff40038520:	d503201f 	nop
ffffffff40038524:	d503201f 	nop
ffffffff40038528:	d503201f 	nop
ffffffff4003852c:	d503201f 	nop
ffffffff40038530:	d503201f 	nop
ffffffff40038534:	d503201f 	nop
ffffffff40038538:	d503201f 	nop
ffffffff4003853c:	d503201f 	nop
ffffffff40038540:	d503201f 	nop
ffffffff40038544:	d503201f 	nop
ffffffff40038548:	d503201f 	nop
ffffffff4003854c:	d503201f 	nop
ffffffff40038550:	d503201f 	nop
ffffffff40038554:	d503201f 	nop
ffffffff40038558:	d503201f 	nop
ffffffff4003855c:	d503201f 	nop
ffffffff40038560:	d503201f 	nop
ffffffff40038564:	d503201f 	nop
ffffffff40038568:	d503201f 	nop
ffffffff4003856c:	d503201f 	nop
ffffffff40038570:	d503201f 	nop
ffffffff40038574:	d503201f 	nop
ffffffff40038578:	d503201f 	nop
ffffffff4003857c:	d503201f 	nop
ffffffff40038580:	d503201f 	nop
ffffffff40038584:	d503201f 	nop
ffffffff40038588:	d503201f 	nop
ffffffff4003858c:	d503201f 	nop
ffffffff40038590:	d503201f 	nop
ffffffff40038594:	d503201f 	nop
ffffffff40038598:	d503201f 	nop
ffffffff4003859c:	d503201f 	nop
ffffffff400385a0:	d503201f 	nop
ffffffff400385a4:	d503201f 	nop
ffffffff400385a8:	d503201f 	nop
ffffffff400385ac:	d503201f 	nop
ffffffff400385b0:	d503201f 	nop
ffffffff400385b4:	d503201f 	nop
ffffffff400385b8:	d503201f 	nop
ffffffff400385bc:	d503201f 	nop
ffffffff400385c0:	d503201f 	nop
ffffffff400385c4:	d503201f 	nop
ffffffff400385c8:	d503201f 	nop
ffffffff400385cc:	d503201f 	nop
ffffffff400385d0:	d503201f 	nop
ffffffff400385d4:	d503201f 	nop
ffffffff400385d8:	d503201f 	nop
ffffffff400385dc:	d503201f 	nop
ffffffff400385e0:	d503201f 	nop
ffffffff400385e4:	d503201f 	nop
ffffffff400385e8:	d503201f 	nop
ffffffff400385ec:	d503201f 	nop
ffffffff400385f0:	d503201f 	nop
ffffffff400385f4:	d503201f 	nop
ffffffff400385f8:	d503201f 	nop
ffffffff400385fc:	d503201f 	nop
ffffffff40038600:	d503201f 	nop
ffffffff40038604:	d503201f 	nop
ffffffff40038608:	d503201f 	nop
ffffffff4003860c:	d503201f 	nop
ffffffff40038610:	d503201f 	nop
ffffffff40038614:	d503201f 	nop
ffffffff40038618:	d503201f 	nop
ffffffff4003861c:	d503201f 	nop
ffffffff40038620:	d503201f 	nop
ffffffff40038624:	d503201f 	nop
ffffffff40038628:	d503201f 	nop
ffffffff4003862c:	d503201f 	nop
ffffffff40038630:	d503201f 	nop
ffffffff40038634:	d503201f 	nop
ffffffff40038638:	d503201f 	nop
ffffffff4003863c:	d503201f 	nop
ffffffff40038640:	d503201f 	nop
ffffffff40038644:	d503201f 	nop
ffffffff40038648:	d503201f 	nop
ffffffff4003864c:	d503201f 	nop
ffffffff40038650:	d503201f 	nop
ffffffff40038654:	d503201f 	nop
ffffffff40038658:	d503201f 	nop
ffffffff4003865c:	d503201f 	nop
ffffffff40038660:	d503201f 	nop
ffffffff40038664:	d503201f 	nop
ffffffff40038668:	d503201f 	nop
ffffffff4003866c:	d503201f 	nop
ffffffff40038670:	d503201f 	nop
ffffffff40038674:	d503201f 	nop
ffffffff40038678:	d503201f 	nop
ffffffff4003867c:	d503201f 	nop
ffffffff40038680:	d503201f 	nop
ffffffff40038684:	d503201f 	nop
ffffffff40038688:	d503201f 	nop
ffffffff4003868c:	d503201f 	nop
ffffffff40038690:	d503201f 	nop
ffffffff40038694:	d503201f 	nop
ffffffff40038698:	d503201f 	nop
ffffffff4003869c:	d503201f 	nop
ffffffff400386a0:	d503201f 	nop
ffffffff400386a4:	d503201f 	nop
ffffffff400386a8:	d503201f 	nop
ffffffff400386ac:	d503201f 	nop
ffffffff400386b0:	d503201f 	nop
ffffffff400386b4:	d503201f 	nop
ffffffff400386b8:	d503201f 	nop
ffffffff400386bc:	d503201f 	nop
ffffffff400386c0:	d503201f 	nop
ffffffff400386c4:	d503201f 	nop
ffffffff400386c8:	d503201f 	nop
ffffffff400386cc:	d503201f 	nop
ffffffff400386d0:	d503201f 	nop
ffffffff400386d4:	d503201f 	nop
ffffffff400386d8:	d503201f 	nop
ffffffff400386dc:	d503201f 	nop
ffffffff400386e0:	d503201f 	nop
ffffffff400386e4:	d503201f 	nop
ffffffff400386e8:	d503201f 	nop
ffffffff400386ec:	d503201f 	nop
ffffffff400386f0:	d503201f 	nop
ffffffff400386f4:	d503201f 	nop
ffffffff400386f8:	d503201f 	nop
ffffffff400386fc:	d503201f 	nop
ffffffff40038700:	d503201f 	nop
ffffffff40038704:	d503201f 	nop
ffffffff40038708:	d503201f 	nop
ffffffff4003870c:	d503201f 	nop
ffffffff40038710:	d503201f 	nop
ffffffff40038714:	d503201f 	nop
ffffffff40038718:	d503201f 	nop
ffffffff4003871c:	d503201f 	nop
ffffffff40038720:	d503201f 	nop
ffffffff40038724:	d503201f 	nop
ffffffff40038728:	d503201f 	nop
ffffffff4003872c:	d503201f 	nop
ffffffff40038730:	d503201f 	nop
ffffffff40038734:	d503201f 	nop
ffffffff40038738:	d503201f 	nop
ffffffff4003873c:	d503201f 	nop
ffffffff40038740:	d503201f 	nop
ffffffff40038744:	d503201f 	nop
ffffffff40038748:	d503201f 	nop
ffffffff4003874c:	d503201f 	nop
ffffffff40038750:	d503201f 	nop
ffffffff40038754:	d503201f 	nop
ffffffff40038758:	d503201f 	nop
ffffffff4003875c:	d503201f 	nop
ffffffff40038760:	d503201f 	nop
ffffffff40038764:	d503201f 	nop
ffffffff40038768:	d503201f 	nop
ffffffff4003876c:	d503201f 	nop
ffffffff40038770:	d503201f 	nop
ffffffff40038774:	d503201f 	nop
ffffffff40038778:	d503201f 	nop
ffffffff4003877c:	d503201f 	nop
ffffffff40038780:	d503201f 	nop
ffffffff40038784:	d503201f 	nop
ffffffff40038788:	d503201f 	nop
ffffffff4003878c:	d503201f 	nop
ffffffff40038790:	d503201f 	nop
ffffffff40038794:	d503201f 	nop
ffffffff40038798:	d503201f 	nop
ffffffff4003879c:	d503201f 	nop
ffffffff400387a0:	d503201f 	nop
ffffffff400387a4:	d503201f 	nop
ffffffff400387a8:	d503201f 	nop
ffffffff400387ac:	d503201f 	nop
ffffffff400387b0:	d503201f 	nop
ffffffff400387b4:	d503201f 	nop
ffffffff400387b8:	d503201f 	nop
ffffffff400387bc:	d503201f 	nop
ffffffff400387c0:	d503201f 	nop
ffffffff400387c4:	d503201f 	nop
ffffffff400387c8:	d503201f 	nop
ffffffff400387cc:	d503201f 	nop
ffffffff400387d0:	d503201f 	nop
ffffffff400387d4:	d503201f 	nop
ffffffff400387d8:	d503201f 	nop
ffffffff400387dc:	d503201f 	nop
ffffffff400387e0:	d503201f 	nop
ffffffff400387e4:	d503201f 	nop
ffffffff400387e8:	d503201f 	nop
ffffffff400387ec:	d503201f 	nop
ffffffff400387f0:	d503201f 	nop
ffffffff400387f4:	d503201f 	nop
ffffffff400387f8:	d503201f 	nop
ffffffff400387fc:	d503201f 	nop
ffffffff40038800:	d503201f 	nop
ffffffff40038804:	d503201f 	nop
ffffffff40038808:	d503201f 	nop
ffffffff4003880c:	d503201f 	nop
ffffffff40038810:	d503201f 	nop
ffffffff40038814:	d503201f 	nop
ffffffff40038818:	d503201f 	nop
ffffffff4003881c:	d503201f 	nop
ffffffff40038820:	d503201f 	nop
ffffffff40038824:	d503201f 	nop
ffffffff40038828:	d503201f 	nop
ffffffff4003882c:	d503201f 	nop
ffffffff40038830:	d503201f 	nop
ffffffff40038834:	d503201f 	nop
ffffffff40038838:	d503201f 	nop
ffffffff4003883c:	d503201f 	nop
ffffffff40038840:	d503201f 	nop
ffffffff40038844:	d503201f 	nop
ffffffff40038848:	d503201f 	nop
ffffffff4003884c:	d503201f 	nop
ffffffff40038850:	d503201f 	nop
ffffffff40038854:	d503201f 	nop
ffffffff40038858:	d503201f 	nop
ffffffff4003885c:	d503201f 	nop
ffffffff40038860:	d503201f 	nop
ffffffff40038864:	d503201f 	nop
ffffffff40038868:	d503201f 	nop
ffffffff4003886c:	d503201f 	nop
ffffffff40038870:	d503201f 	nop
ffffffff40038874:	d503201f 	nop
ffffffff40038878:	d503201f 	nop
ffffffff4003887c:	d503201f 	nop
ffffffff40038880:	d503201f 	nop
ffffffff40038884:	d503201f 	nop
ffffffff40038888:	d503201f 	nop
ffffffff4003888c:	d503201f 	nop
ffffffff40038890:	d503201f 	nop
ffffffff40038894:	d503201f 	nop
ffffffff40038898:	d503201f 	nop
ffffffff4003889c:	d503201f 	nop
ffffffff400388a0:	d503201f 	nop
ffffffff400388a4:	d503201f 	nop
ffffffff400388a8:	d503201f 	nop
ffffffff400388ac:	d503201f 	nop
ffffffff400388b0:	d503201f 	nop
ffffffff400388b4:	d503201f 	nop
ffffffff400388b8:	d503201f 	nop
ffffffff400388bc:	d503201f 	nop
ffffffff400388c0:	d503201f 	nop
ffffffff400388c4:	d503201f 	nop
ffffffff400388c8:	d503201f 	nop
ffffffff400388cc:	d503201f 	nop
ffffffff400388d0:	d503201f 	nop
ffffffff400388d4:	d503201f 	nop
ffffffff400388d8:	d503201f 	nop
ffffffff400388dc:	d503201f 	nop
ffffffff400388e0:	d503201f 	nop
ffffffff400388e4:	d503201f 	nop
ffffffff400388e8:	d503201f 	nop
ffffffff400388ec:	d503201f 	nop
ffffffff400388f0:	d503201f 	nop
ffffffff400388f4:	d503201f 	nop
ffffffff400388f8:	d503201f 	nop
ffffffff400388fc:	d503201f 	nop
ffffffff40038900:	d503201f 	nop
ffffffff40038904:	d503201f 	nop
ffffffff40038908:	d503201f 	nop
ffffffff4003890c:	d503201f 	nop
ffffffff40038910:	d503201f 	nop
ffffffff40038914:	d503201f 	nop
ffffffff40038918:	d503201f 	nop
ffffffff4003891c:	d503201f 	nop
ffffffff40038920:	d503201f 	nop
ffffffff40038924:	d503201f 	nop
ffffffff40038928:	d503201f 	nop
ffffffff4003892c:	d503201f 	nop
ffffffff40038930:	d503201f 	nop
ffffffff40038934:	d503201f 	nop
ffffffff40038938:	d503201f 	nop
ffffffff4003893c:	d503201f 	nop
ffffffff40038940:	d503201f 	nop
ffffffff40038944:	d503201f 	nop
ffffffff40038948:	d503201f 	nop
ffffffff4003894c:	d503201f 	nop
ffffffff40038950:	d503201f 	nop
ffffffff40038954:	d503201f 	nop
ffffffff40038958:	d503201f 	nop
ffffffff4003895c:	d503201f 	nop
ffffffff40038960:	d503201f 	nop
ffffffff40038964:	d503201f 	nop
ffffffff40038968:	d503201f 	nop
ffffffff4003896c:	d503201f 	nop
ffffffff40038970:	d503201f 	nop
ffffffff40038974:	d503201f 	nop
ffffffff40038978:	d503201f 	nop
ffffffff4003897c:	d503201f 	nop
ffffffff40038980:	d503201f 	nop
ffffffff40038984:	d503201f 	nop
ffffffff40038988:	d503201f 	nop
ffffffff4003898c:	d503201f 	nop
ffffffff40038990:	d503201f 	nop
ffffffff40038994:	d503201f 	nop
ffffffff40038998:	d503201f 	nop
ffffffff4003899c:	d503201f 	nop
ffffffff400389a0:	d503201f 	nop
ffffffff400389a4:	d503201f 	nop
ffffffff400389a8:	d503201f 	nop
ffffffff400389ac:	d503201f 	nop
ffffffff400389b0:	d503201f 	nop
ffffffff400389b4:	d503201f 	nop
ffffffff400389b8:	d503201f 	nop
ffffffff400389bc:	d503201f 	nop
ffffffff400389c0:	d503201f 	nop
ffffffff400389c4:	d503201f 	nop
ffffffff400389c8:	d503201f 	nop
ffffffff400389cc:	d503201f 	nop
ffffffff400389d0:	d503201f 	nop
ffffffff400389d4:	d503201f 	nop
ffffffff400389d8:	d503201f 	nop
ffffffff400389dc:	d503201f 	nop
ffffffff400389e0:	d503201f 	nop
ffffffff400389e4:	d503201f 	nop
ffffffff400389e8:	d503201f 	nop
ffffffff400389ec:	d503201f 	nop
ffffffff400389f0:	d503201f 	nop
ffffffff400389f4:	d503201f 	nop
ffffffff400389f8:	d503201f 	nop
ffffffff400389fc:	d503201f 	nop
ffffffff40038a00:	d503201f 	nop
ffffffff40038a04:	d503201f 	nop
ffffffff40038a08:	d503201f 	nop
ffffffff40038a0c:	d503201f 	nop
ffffffff40038a10:	d503201f 	nop
ffffffff40038a14:	d503201f 	nop
ffffffff40038a18:	d503201f 	nop
ffffffff40038a1c:	d503201f 	nop
ffffffff40038a20:	d503201f 	nop
ffffffff40038a24:	d503201f 	nop
ffffffff40038a28:	d503201f 	nop
ffffffff40038a2c:	d503201f 	nop
ffffffff40038a30:	d503201f 	nop
ffffffff40038a34:	d503201f 	nop
ffffffff40038a38:	d503201f 	nop
ffffffff40038a3c:	d503201f 	nop
ffffffff40038a40:	d503201f 	nop
ffffffff40038a44:	d503201f 	nop
ffffffff40038a48:	d503201f 	nop
ffffffff40038a4c:	d503201f 	nop
ffffffff40038a50:	d503201f 	nop
ffffffff40038a54:	d503201f 	nop
ffffffff40038a58:	d503201f 	nop
ffffffff40038a5c:	d503201f 	nop
ffffffff40038a60:	d503201f 	nop
ffffffff40038a64:	d503201f 	nop
ffffffff40038a68:	d503201f 	nop
ffffffff40038a6c:	d503201f 	nop
ffffffff40038a70:	d503201f 	nop
ffffffff40038a74:	d503201f 	nop
ffffffff40038a78:	d503201f 	nop
ffffffff40038a7c:	d503201f 	nop
ffffffff40038a80:	d503201f 	nop
ffffffff40038a84:	d503201f 	nop
ffffffff40038a88:	d503201f 	nop
ffffffff40038a8c:	d503201f 	nop
ffffffff40038a90:	d503201f 	nop
ffffffff40038a94:	d503201f 	nop
ffffffff40038a98:	d503201f 	nop
ffffffff40038a9c:	d503201f 	nop
ffffffff40038aa0:	d503201f 	nop
ffffffff40038aa4:	d503201f 	nop
ffffffff40038aa8:	d503201f 	nop
ffffffff40038aac:	d503201f 	nop
ffffffff40038ab0:	d503201f 	nop
ffffffff40038ab4:	d503201f 	nop
ffffffff40038ab8:	d503201f 	nop
ffffffff40038abc:	d503201f 	nop
ffffffff40038ac0:	d503201f 	nop
ffffffff40038ac4:	d503201f 	nop
ffffffff40038ac8:	d503201f 	nop
ffffffff40038acc:	d503201f 	nop
ffffffff40038ad0:	d503201f 	nop
ffffffff40038ad4:	d503201f 	nop
ffffffff40038ad8:	d503201f 	nop
ffffffff40038adc:	d503201f 	nop
ffffffff40038ae0:	d503201f 	nop
ffffffff40038ae4:	d503201f 	nop
ffffffff40038ae8:	d503201f 	nop
ffffffff40038aec:	d503201f 	nop
ffffffff40038af0:	d503201f 	nop
ffffffff40038af4:	d503201f 	nop
ffffffff40038af8:	d503201f 	nop
ffffffff40038afc:	d503201f 	nop
ffffffff40038b00:	d503201f 	nop
ffffffff40038b04:	d503201f 	nop
ffffffff40038b08:	d503201f 	nop
ffffffff40038b0c:	d503201f 	nop
ffffffff40038b10:	d503201f 	nop
ffffffff40038b14:	d503201f 	nop
ffffffff40038b18:	d503201f 	nop
ffffffff40038b1c:	d503201f 	nop
ffffffff40038b20:	d503201f 	nop
ffffffff40038b24:	d503201f 	nop
ffffffff40038b28:	d503201f 	nop
ffffffff40038b2c:	d503201f 	nop
ffffffff40038b30:	d503201f 	nop
ffffffff40038b34:	d503201f 	nop
ffffffff40038b38:	d503201f 	nop
ffffffff40038b3c:	d503201f 	nop
ffffffff40038b40:	d503201f 	nop
ffffffff40038b44:	d503201f 	nop
ffffffff40038b48:	d503201f 	nop
ffffffff40038b4c:	d503201f 	nop
ffffffff40038b50:	d503201f 	nop
ffffffff40038b54:	d503201f 	nop
ffffffff40038b58:	d503201f 	nop
ffffffff40038b5c:	d503201f 	nop
ffffffff40038b60:	d503201f 	nop
ffffffff40038b64:	d503201f 	nop
ffffffff40038b68:	d503201f 	nop
ffffffff40038b6c:	d503201f 	nop
ffffffff40038b70:	d503201f 	nop
ffffffff40038b74:	d503201f 	nop
ffffffff40038b78:	d503201f 	nop
ffffffff40038b7c:	d503201f 	nop
ffffffff40038b80:	d503201f 	nop
ffffffff40038b84:	d503201f 	nop
ffffffff40038b88:	d503201f 	nop
ffffffff40038b8c:	d503201f 	nop
ffffffff40038b90:	d503201f 	nop
ffffffff40038b94:	d503201f 	nop
ffffffff40038b98:	d503201f 	nop
ffffffff40038b9c:	d503201f 	nop
ffffffff40038ba0:	d503201f 	nop
ffffffff40038ba4:	d503201f 	nop
ffffffff40038ba8:	d503201f 	nop
ffffffff40038bac:	d503201f 	nop
ffffffff40038bb0:	d503201f 	nop
ffffffff40038bb4:	d503201f 	nop
ffffffff40038bb8:	d503201f 	nop
ffffffff40038bbc:	d503201f 	nop
ffffffff40038bc0:	d503201f 	nop
ffffffff40038bc4:	d503201f 	nop
ffffffff40038bc8:	d503201f 	nop
ffffffff40038bcc:	d503201f 	nop
ffffffff40038bd0:	d503201f 	nop
ffffffff40038bd4:	d503201f 	nop
ffffffff40038bd8:	d503201f 	nop
ffffffff40038bdc:	d503201f 	nop
ffffffff40038be0:	d503201f 	nop
ffffffff40038be4:	d503201f 	nop
ffffffff40038be8:	d503201f 	nop
ffffffff40038bec:	d503201f 	nop
ffffffff40038bf0:	d503201f 	nop
ffffffff40038bf4:	d503201f 	nop
ffffffff40038bf8:	d503201f 	nop
ffffffff40038bfc:	d503201f 	nop
ffffffff40038c00:	d503201f 	nop
ffffffff40038c04:	d503201f 	nop
ffffffff40038c08:	d503201f 	nop
ffffffff40038c0c:	d503201f 	nop
ffffffff40038c10:	d503201f 	nop
ffffffff40038c14:	d503201f 	nop
ffffffff40038c18:	d503201f 	nop
ffffffff40038c1c:	d503201f 	nop
ffffffff40038c20:	d503201f 	nop
ffffffff40038c24:	d503201f 	nop
ffffffff40038c28:	d503201f 	nop
ffffffff40038c2c:	d503201f 	nop
ffffffff40038c30:	d503201f 	nop
ffffffff40038c34:	d503201f 	nop
ffffffff40038c38:	d503201f 	nop
ffffffff40038c3c:	d503201f 	nop
ffffffff40038c40:	d503201f 	nop
ffffffff40038c44:	d503201f 	nop
ffffffff40038c48:	d503201f 	nop
ffffffff40038c4c:	d503201f 	nop
ffffffff40038c50:	d503201f 	nop
ffffffff40038c54:	d503201f 	nop
ffffffff40038c58:	d503201f 	nop
ffffffff40038c5c:	d503201f 	nop
ffffffff40038c60:	d503201f 	nop
ffffffff40038c64:	d503201f 	nop
ffffffff40038c68:	d503201f 	nop
ffffffff40038c6c:	d503201f 	nop
ffffffff40038c70:	d503201f 	nop
ffffffff40038c74:	d503201f 	nop
ffffffff40038c78:	d503201f 	nop
ffffffff40038c7c:	d503201f 	nop
ffffffff40038c80:	d503201f 	nop
ffffffff40038c84:	d503201f 	nop
ffffffff40038c88:	d503201f 	nop
ffffffff40038c8c:	d503201f 	nop
ffffffff40038c90:	d503201f 	nop
ffffffff40038c94:	d503201f 	nop
ffffffff40038c98:	d503201f 	nop
ffffffff40038c9c:	d503201f 	nop
ffffffff40038ca0:	d503201f 	nop
ffffffff40038ca4:	d503201f 	nop
ffffffff40038ca8:	d503201f 	nop
ffffffff40038cac:	d503201f 	nop
ffffffff40038cb0:	d503201f 	nop
ffffffff40038cb4:	d503201f 	nop
ffffffff40038cb8:	d503201f 	nop
ffffffff40038cbc:	d503201f 	nop
ffffffff40038cc0:	d503201f 	nop
ffffffff40038cc4:	d503201f 	nop
ffffffff40038cc8:	d503201f 	nop
ffffffff40038ccc:	d503201f 	nop
ffffffff40038cd0:	d503201f 	nop
ffffffff40038cd4:	d503201f 	nop
ffffffff40038cd8:	d503201f 	nop
ffffffff40038cdc:	d503201f 	nop
ffffffff40038ce0:	d503201f 	nop
ffffffff40038ce4:	d503201f 	nop
ffffffff40038ce8:	d503201f 	nop
ffffffff40038cec:	d503201f 	nop
ffffffff40038cf0:	d503201f 	nop
ffffffff40038cf4:	d503201f 	nop
ffffffff40038cf8:	d503201f 	nop
ffffffff40038cfc:	d503201f 	nop
ffffffff40038d00:	d503201f 	nop
ffffffff40038d04:	d503201f 	nop
ffffffff40038d08:	d503201f 	nop
ffffffff40038d0c:	d503201f 	nop
ffffffff40038d10:	d503201f 	nop
ffffffff40038d14:	d503201f 	nop
ffffffff40038d18:	d503201f 	nop
ffffffff40038d1c:	d503201f 	nop
ffffffff40038d20:	d503201f 	nop
ffffffff40038d24:	d503201f 	nop
ffffffff40038d28:	d503201f 	nop
ffffffff40038d2c:	d503201f 	nop
ffffffff40038d30:	d503201f 	nop
ffffffff40038d34:	d503201f 	nop
ffffffff40038d38:	d503201f 	nop
ffffffff40038d3c:	d503201f 	nop
ffffffff40038d40:	d503201f 	nop
ffffffff40038d44:	d503201f 	nop
ffffffff40038d48:	d503201f 	nop
ffffffff40038d4c:	d503201f 	nop
ffffffff40038d50:	d503201f 	nop
ffffffff40038d54:	d503201f 	nop
ffffffff40038d58:	d503201f 	nop
ffffffff40038d5c:	d503201f 	nop
ffffffff40038d60:	d503201f 	nop
ffffffff40038d64:	d503201f 	nop
ffffffff40038d68:	d503201f 	nop
ffffffff40038d6c:	d503201f 	nop
ffffffff40038d70:	d503201f 	nop
ffffffff40038d74:	d503201f 	nop
ffffffff40038d78:	d503201f 	nop
ffffffff40038d7c:	d503201f 	nop
ffffffff40038d80:	d503201f 	nop
ffffffff40038d84:	d503201f 	nop
ffffffff40038d88:	d503201f 	nop
ffffffff40038d8c:	d503201f 	nop
ffffffff40038d90:	d503201f 	nop
ffffffff40038d94:	d503201f 	nop
ffffffff40038d98:	d503201f 	nop
ffffffff40038d9c:	d503201f 	nop
ffffffff40038da0:	d503201f 	nop
ffffffff40038da4:	d503201f 	nop
ffffffff40038da8:	d503201f 	nop
ffffffff40038dac:	d503201f 	nop
ffffffff40038db0:	d503201f 	nop
ffffffff40038db4:	d503201f 	nop
ffffffff40038db8:	d503201f 	nop
ffffffff40038dbc:	d503201f 	nop
ffffffff40038dc0:	d503201f 	nop
ffffffff40038dc4:	d503201f 	nop
ffffffff40038dc8:	d503201f 	nop
ffffffff40038dcc:	d503201f 	nop
ffffffff40038dd0:	d503201f 	nop
ffffffff40038dd4:	d503201f 	nop
ffffffff40038dd8:	d503201f 	nop
ffffffff40038ddc:	d503201f 	nop
ffffffff40038de0:	d503201f 	nop
ffffffff40038de4:	d503201f 	nop
ffffffff40038de8:	d503201f 	nop
ffffffff40038dec:	d503201f 	nop
ffffffff40038df0:	d503201f 	nop
ffffffff40038df4:	d503201f 	nop
ffffffff40038df8:	d503201f 	nop
ffffffff40038dfc:	d503201f 	nop
ffffffff40038e00:	d503201f 	nop
ffffffff40038e04:	d503201f 	nop
ffffffff40038e08:	d503201f 	nop
ffffffff40038e0c:	d503201f 	nop
ffffffff40038e10:	d503201f 	nop
ffffffff40038e14:	d503201f 	nop
ffffffff40038e18:	d503201f 	nop
ffffffff40038e1c:	d503201f 	nop
ffffffff40038e20:	d503201f 	nop
ffffffff40038e24:	d503201f 	nop
ffffffff40038e28:	d503201f 	nop
ffffffff40038e2c:	d503201f 	nop
ffffffff40038e30:	d503201f 	nop
ffffffff40038e34:	d503201f 	nop
ffffffff40038e38:	d503201f 	nop
ffffffff40038e3c:	d503201f 	nop
ffffffff40038e40:	d503201f 	nop
ffffffff40038e44:	d503201f 	nop
ffffffff40038e48:	d503201f 	nop
ffffffff40038e4c:	d503201f 	nop
ffffffff40038e50:	d503201f 	nop
ffffffff40038e54:	d503201f 	nop
ffffffff40038e58:	d503201f 	nop
ffffffff40038e5c:	d503201f 	nop
ffffffff40038e60:	d503201f 	nop
ffffffff40038e64:	d503201f 	nop
ffffffff40038e68:	d503201f 	nop
ffffffff40038e6c:	d503201f 	nop
ffffffff40038e70:	d503201f 	nop
ffffffff40038e74:	d503201f 	nop
ffffffff40038e78:	d503201f 	nop
ffffffff40038e7c:	d503201f 	nop
ffffffff40038e80:	d503201f 	nop
ffffffff40038e84:	d503201f 	nop
ffffffff40038e88:	d503201f 	nop
ffffffff40038e8c:	d503201f 	nop
ffffffff40038e90:	d503201f 	nop
ffffffff40038e94:	d503201f 	nop
ffffffff40038e98:	d503201f 	nop
ffffffff40038e9c:	d503201f 	nop
ffffffff40038ea0:	d503201f 	nop
ffffffff40038ea4:	d503201f 	nop
ffffffff40038ea8:	d503201f 	nop
ffffffff40038eac:	d503201f 	nop
ffffffff40038eb0:	d503201f 	nop
ffffffff40038eb4:	d503201f 	nop
ffffffff40038eb8:	d503201f 	nop
ffffffff40038ebc:	d503201f 	nop
ffffffff40038ec0:	d503201f 	nop
ffffffff40038ec4:	d503201f 	nop
ffffffff40038ec8:	d503201f 	nop
ffffffff40038ecc:	d503201f 	nop
ffffffff40038ed0:	d503201f 	nop
ffffffff40038ed4:	d503201f 	nop
ffffffff40038ed8:	d503201f 	nop
ffffffff40038edc:	d503201f 	nop
ffffffff40038ee0:	d503201f 	nop
ffffffff40038ee4:	d503201f 	nop
ffffffff40038ee8:	d503201f 	nop
ffffffff40038eec:	d503201f 	nop
ffffffff40038ef0:	d503201f 	nop
ffffffff40038ef4:	d503201f 	nop
ffffffff40038ef8:	d503201f 	nop
ffffffff40038efc:	d503201f 	nop
ffffffff40038f00:	d503201f 	nop
ffffffff40038f04:	d503201f 	nop
ffffffff40038f08:	d503201f 	nop
ffffffff40038f0c:	d503201f 	nop
ffffffff40038f10:	d503201f 	nop
ffffffff40038f14:	d503201f 	nop
ffffffff40038f18:	d503201f 	nop
ffffffff40038f1c:	d503201f 	nop
ffffffff40038f20:	d503201f 	nop
ffffffff40038f24:	d503201f 	nop
ffffffff40038f28:	d503201f 	nop
ffffffff40038f2c:	d503201f 	nop
ffffffff40038f30:	d503201f 	nop
ffffffff40038f34:	d503201f 	nop
ffffffff40038f38:	d503201f 	nop
ffffffff40038f3c:	d503201f 	nop
ffffffff40038f40:	d503201f 	nop
ffffffff40038f44:	d503201f 	nop
ffffffff40038f48:	d503201f 	nop
ffffffff40038f4c:	d503201f 	nop
ffffffff40038f50:	d503201f 	nop
ffffffff40038f54:	d503201f 	nop
ffffffff40038f58:	d503201f 	nop
ffffffff40038f5c:	d503201f 	nop
ffffffff40038f60:	d503201f 	nop
ffffffff40038f64:	d503201f 	nop
ffffffff40038f68:	d503201f 	nop
ffffffff40038f6c:	d503201f 	nop
ffffffff40038f70:	d503201f 	nop
ffffffff40038f74:	d503201f 	nop
ffffffff40038f78:	d503201f 	nop
ffffffff40038f7c:	d503201f 	nop
ffffffff40038f80:	d503201f 	nop
ffffffff40038f84:	d503201f 	nop
ffffffff40038f88:	d503201f 	nop
ffffffff40038f8c:	d503201f 	nop
ffffffff40038f90:	d503201f 	nop
ffffffff40038f94:	d503201f 	nop
ffffffff40038f98:	d503201f 	nop
ffffffff40038f9c:	d503201f 	nop
ffffffff40038fa0:	d503201f 	nop
ffffffff40038fa4:	d503201f 	nop
ffffffff40038fa8:	d503201f 	nop
ffffffff40038fac:	d503201f 	nop
ffffffff40038fb0:	d503201f 	nop
ffffffff40038fb4:	d503201f 	nop
ffffffff40038fb8:	d503201f 	nop
ffffffff40038fbc:	d503201f 	nop
ffffffff40038fc0:	d503201f 	nop
ffffffff40038fc4:	d503201f 	nop
ffffffff40038fc8:	d503201f 	nop
ffffffff40038fcc:	d503201f 	nop
ffffffff40038fd0:	d503201f 	nop
ffffffff40038fd4:	d503201f 	nop
ffffffff40038fd8:	d503201f 	nop
ffffffff40038fdc:	d503201f 	nop
ffffffff40038fe0:	d503201f 	nop
ffffffff40038fe4:	d503201f 	nop
ffffffff40038fe8:	d503201f 	nop
ffffffff40038fec:	d503201f 	nop
ffffffff40038ff0:	d503201f 	nop
ffffffff40038ff4:	d503201f 	nop
ffffffff40038ff8:	d503201f 	nop
ffffffff40038ffc:	d503201f 	nop

ffffffff40039000 <vectors>:
ffffffff40039000:	14000170 	b	ffffffff400395c0 <_el_current_bad_sync>
ffffffff40039004:	d503201f 	nop
ffffffff40039008:	d503201f 	nop
ffffffff4003900c:	d503201f 	nop
ffffffff40039010:	d503201f 	nop
ffffffff40039014:	d503201f 	nop
ffffffff40039018:	d503201f 	nop
ffffffff4003901c:	d503201f 	nop
ffffffff40039020:	d503201f 	nop
ffffffff40039024:	d503201f 	nop
ffffffff40039028:	d503201f 	nop
ffffffff4003902c:	d503201f 	nop
ffffffff40039030:	d503201f 	nop
ffffffff40039034:	d503201f 	nop
ffffffff40039038:	d503201f 	nop
ffffffff4003903c:	d503201f 	nop
ffffffff40039040:	d503201f 	nop
ffffffff40039044:	d503201f 	nop
ffffffff40039048:	d503201f 	nop
ffffffff4003904c:	d503201f 	nop
ffffffff40039050:	d503201f 	nop
ffffffff40039054:	d503201f 	nop
ffffffff40039058:	d503201f 	nop
ffffffff4003905c:	d503201f 	nop
ffffffff40039060:	d503201f 	nop
ffffffff40039064:	d503201f 	nop
ffffffff40039068:	d503201f 	nop
ffffffff4003906c:	d503201f 	nop
ffffffff40039070:	d503201f 	nop
ffffffff40039074:	d503201f 	nop
ffffffff40039078:	d503201f 	nop
ffffffff4003907c:	d503201f 	nop
ffffffff40039080:	14000170 	b	ffffffff40039640 <_el_current_bad_irq>
ffffffff40039084:	d503201f 	nop
ffffffff40039088:	d503201f 	nop
ffffffff4003908c:	d503201f 	nop
ffffffff40039090:	d503201f 	nop
ffffffff40039094:	d503201f 	nop
ffffffff40039098:	d503201f 	nop
ffffffff4003909c:	d503201f 	nop
ffffffff400390a0:	d503201f 	nop
ffffffff400390a4:	d503201f 	nop
ffffffff400390a8:	d503201f 	nop
ffffffff400390ac:	d503201f 	nop
ffffffff400390b0:	d503201f 	nop
ffffffff400390b4:	d503201f 	nop
ffffffff400390b8:	d503201f 	nop
ffffffff400390bc:	d503201f 	nop
ffffffff400390c0:	d503201f 	nop
ffffffff400390c4:	d503201f 	nop
ffffffff400390c8:	d503201f 	nop
ffffffff400390cc:	d503201f 	nop
ffffffff400390d0:	d503201f 	nop
ffffffff400390d4:	d503201f 	nop
ffffffff400390d8:	d503201f 	nop
ffffffff400390dc:	d503201f 	nop
ffffffff400390e0:	d503201f 	nop
ffffffff400390e4:	d503201f 	nop
ffffffff400390e8:	d503201f 	nop
ffffffff400390ec:	d503201f 	nop
ffffffff400390f0:	d503201f 	nop
ffffffff400390f4:	d503201f 	nop
ffffffff400390f8:	d503201f 	nop
ffffffff400390fc:	d503201f 	nop
ffffffff40039100:	14000170 	b	ffffffff400396c0 <_el_current_bad_fiq>
ffffffff40039104:	d503201f 	nop
ffffffff40039108:	d503201f 	nop
ffffffff4003910c:	d503201f 	nop
ffffffff40039110:	d503201f 	nop
ffffffff40039114:	d503201f 	nop
ffffffff40039118:	d503201f 	nop
ffffffff4003911c:	d503201f 	nop
ffffffff40039120:	d503201f 	nop
ffffffff40039124:	d503201f 	nop
ffffffff40039128:	d503201f 	nop
ffffffff4003912c:	d503201f 	nop
ffffffff40039130:	d503201f 	nop
ffffffff40039134:	d503201f 	nop
ffffffff40039138:	d503201f 	nop
ffffffff4003913c:	d503201f 	nop
ffffffff40039140:	d503201f 	nop
ffffffff40039144:	d503201f 	nop
ffffffff40039148:	d503201f 	nop
ffffffff4003914c:	d503201f 	nop
ffffffff40039150:	d503201f 	nop
ffffffff40039154:	d503201f 	nop
ffffffff40039158:	d503201f 	nop
ffffffff4003915c:	d503201f 	nop
ffffffff40039160:	d503201f 	nop
ffffffff40039164:	d503201f 	nop
ffffffff40039168:	d503201f 	nop
ffffffff4003916c:	d503201f 	nop
ffffffff40039170:	d503201f 	nop
ffffffff40039174:	d503201f 	nop
ffffffff40039178:	d503201f 	nop
ffffffff4003917c:	d503201f 	nop
ffffffff40039180:	14000170 	b	ffffffff40039740 <_el_current_bad_error>
ffffffff40039184:	d503201f 	nop
ffffffff40039188:	d503201f 	nop
ffffffff4003918c:	d503201f 	nop
ffffffff40039190:	d503201f 	nop
ffffffff40039194:	d503201f 	nop
ffffffff40039198:	d503201f 	nop
ffffffff4003919c:	d503201f 	nop
ffffffff400391a0:	d503201f 	nop
ffffffff400391a4:	d503201f 	nop
ffffffff400391a8:	d503201f 	nop
ffffffff400391ac:	d503201f 	nop
ffffffff400391b0:	d503201f 	nop
ffffffff400391b4:	d503201f 	nop
ffffffff400391b8:	d503201f 	nop
ffffffff400391bc:	d503201f 	nop
ffffffff400391c0:	d503201f 	nop
ffffffff400391c4:	d503201f 	nop
ffffffff400391c8:	d503201f 	nop
ffffffff400391cc:	d503201f 	nop
ffffffff400391d0:	d503201f 	nop
ffffffff400391d4:	d503201f 	nop
ffffffff400391d8:	d503201f 	nop
ffffffff400391dc:	d503201f 	nop
ffffffff400391e0:	d503201f 	nop
ffffffff400391e4:	d503201f 	nop
ffffffff400391e8:	d503201f 	nop
ffffffff400391ec:	d503201f 	nop
ffffffff400391f0:	d503201f 	nop
ffffffff400391f4:	d503201f 	nop
ffffffff400391f8:	d503201f 	nop
ffffffff400391fc:	d503201f 	nop
ffffffff40039200:	14000170 	b	ffffffff400397c0 <_el_current_sync>
ffffffff40039204:	d503201f 	nop
ffffffff40039208:	d503201f 	nop
ffffffff4003920c:	d503201f 	nop
ffffffff40039210:	d503201f 	nop
ffffffff40039214:	d503201f 	nop
ffffffff40039218:	d503201f 	nop
ffffffff4003921c:	d503201f 	nop
ffffffff40039220:	d503201f 	nop
ffffffff40039224:	d503201f 	nop
ffffffff40039228:	d503201f 	nop
ffffffff4003922c:	d503201f 	nop
ffffffff40039230:	d503201f 	nop
ffffffff40039234:	d503201f 	nop
ffffffff40039238:	d503201f 	nop
ffffffff4003923c:	d503201f 	nop
ffffffff40039240:	d503201f 	nop
ffffffff40039244:	d503201f 	nop
ffffffff40039248:	d503201f 	nop
ffffffff4003924c:	d503201f 	nop
ffffffff40039250:	d503201f 	nop
ffffffff40039254:	d503201f 	nop
ffffffff40039258:	d503201f 	nop
ffffffff4003925c:	d503201f 	nop
ffffffff40039260:	d503201f 	nop
ffffffff40039264:	d503201f 	nop
ffffffff40039268:	d503201f 	nop
ffffffff4003926c:	d503201f 	nop
ffffffff40039270:	d503201f 	nop
ffffffff40039274:	d503201f 	nop
ffffffff40039278:	d503201f 	nop
ffffffff4003927c:	d503201f 	nop
ffffffff40039280:	14000180 	b	ffffffff40039880 <_el_current_irq>
ffffffff40039284:	d503201f 	nop
ffffffff40039288:	d503201f 	nop
ffffffff4003928c:	d503201f 	nop
ffffffff40039290:	d503201f 	nop
ffffffff40039294:	d503201f 	nop
ffffffff40039298:	d503201f 	nop
ffffffff4003929c:	d503201f 	nop
ffffffff400392a0:	d503201f 	nop
ffffffff400392a4:	d503201f 	nop
ffffffff400392a8:	d503201f 	nop
ffffffff400392ac:	d503201f 	nop
ffffffff400392b0:	d503201f 	nop
ffffffff400392b4:	d503201f 	nop
ffffffff400392b8:	d503201f 	nop
ffffffff400392bc:	d503201f 	nop
ffffffff400392c0:	d503201f 	nop
ffffffff400392c4:	d503201f 	nop
ffffffff400392c8:	d503201f 	nop
ffffffff400392cc:	d503201f 	nop
ffffffff400392d0:	d503201f 	nop
ffffffff400392d4:	d503201f 	nop
ffffffff400392d8:	d503201f 	nop
ffffffff400392dc:	d503201f 	nop
ffffffff400392e0:	d503201f 	nop
ffffffff400392e4:	d503201f 	nop
ffffffff400392e8:	d503201f 	nop
ffffffff400392ec:	d503201f 	nop
ffffffff400392f0:	d503201f 	nop
ffffffff400392f4:	d503201f 	nop
ffffffff400392f8:	d503201f 	nop
ffffffff400392fc:	d503201f 	nop
ffffffff40039300:	14000190 	b	ffffffff40039940 <_el_current_fiq>
ffffffff40039304:	d503201f 	nop
ffffffff40039308:	d503201f 	nop
ffffffff4003930c:	d503201f 	nop
ffffffff40039310:	d503201f 	nop
ffffffff40039314:	d503201f 	nop
ffffffff40039318:	d503201f 	nop
ffffffff4003931c:	d503201f 	nop
ffffffff40039320:	d503201f 	nop
ffffffff40039324:	d503201f 	nop
ffffffff40039328:	d503201f 	nop
ffffffff4003932c:	d503201f 	nop
ffffffff40039330:	d503201f 	nop
ffffffff40039334:	d503201f 	nop
ffffffff40039338:	d503201f 	nop
ffffffff4003933c:	d503201f 	nop
ffffffff40039340:	d503201f 	nop
ffffffff40039344:	d503201f 	nop
ffffffff40039348:	d503201f 	nop
ffffffff4003934c:	d503201f 	nop
ffffffff40039350:	d503201f 	nop
ffffffff40039354:	d503201f 	nop
ffffffff40039358:	d503201f 	nop
ffffffff4003935c:	d503201f 	nop
ffffffff40039360:	d503201f 	nop
ffffffff40039364:	d503201f 	nop
ffffffff40039368:	d503201f 	nop
ffffffff4003936c:	d503201f 	nop
ffffffff40039370:	d503201f 	nop
ffffffff40039374:	d503201f 	nop
ffffffff40039378:	d503201f 	nop
ffffffff4003937c:	d503201f 	nop
ffffffff40039380:	14000190 	b	ffffffff400399c0 <_el_current_error>
ffffffff40039384:	d503201f 	nop
ffffffff40039388:	d503201f 	nop
ffffffff4003938c:	d503201f 	nop
ffffffff40039390:	d503201f 	nop
ffffffff40039394:	d503201f 	nop
ffffffff40039398:	d503201f 	nop
ffffffff4003939c:	d503201f 	nop
ffffffff400393a0:	d503201f 	nop
ffffffff400393a4:	d503201f 	nop
ffffffff400393a8:	d503201f 	nop
ffffffff400393ac:	d503201f 	nop
ffffffff400393b0:	d503201f 	nop
ffffffff400393b4:	d503201f 	nop
ffffffff400393b8:	d503201f 	nop
ffffffff400393bc:	d503201f 	nop
ffffffff400393c0:	d503201f 	nop
ffffffff400393c4:	d503201f 	nop
ffffffff400393c8:	d503201f 	nop
ffffffff400393cc:	d503201f 	nop
ffffffff400393d0:	d503201f 	nop
ffffffff400393d4:	d503201f 	nop
ffffffff400393d8:	d503201f 	nop
ffffffff400393dc:	d503201f 	nop
ffffffff400393e0:	d503201f 	nop
ffffffff400393e4:	d503201f 	nop
ffffffff400393e8:	d503201f 	nop
ffffffff400393ec:	d503201f 	nop
ffffffff400393f0:	d503201f 	nop
ffffffff400393f4:	d503201f 	nop
ffffffff400393f8:	d503201f 	nop
ffffffff400393fc:	d503201f 	nop
ffffffff40039400:	14000190 	b	ffffffff40039a40 <_el_lower_sync>
ffffffff40039404:	d503201f 	nop
ffffffff40039408:	d503201f 	nop
ffffffff4003940c:	d503201f 	nop
ffffffff40039410:	d503201f 	nop
ffffffff40039414:	d503201f 	nop
ffffffff40039418:	d503201f 	nop
ffffffff4003941c:	d503201f 	nop
ffffffff40039420:	d503201f 	nop
ffffffff40039424:	d503201f 	nop
ffffffff40039428:	d503201f 	nop
ffffffff4003942c:	d503201f 	nop
ffffffff40039430:	d503201f 	nop
ffffffff40039434:	d503201f 	nop
ffffffff40039438:	d503201f 	nop
ffffffff4003943c:	d503201f 	nop
ffffffff40039440:	d503201f 	nop
ffffffff40039444:	d503201f 	nop
ffffffff40039448:	d503201f 	nop
ffffffff4003944c:	d503201f 	nop
ffffffff40039450:	d503201f 	nop
ffffffff40039454:	d503201f 	nop
ffffffff40039458:	d503201f 	nop
ffffffff4003945c:	d503201f 	nop
ffffffff40039460:	d503201f 	nop
ffffffff40039464:	d503201f 	nop
ffffffff40039468:	d503201f 	nop
ffffffff4003946c:	d503201f 	nop
ffffffff40039470:	d503201f 	nop
ffffffff40039474:	d503201f 	nop
ffffffff40039478:	d503201f 	nop
ffffffff4003947c:	d503201f 	nop
ffffffff40039480:	140001c0 	b	ffffffff40039b80 <_el_lower_irq>
ffffffff40039484:	d503201f 	nop
ffffffff40039488:	d503201f 	nop
ffffffff4003948c:	d503201f 	nop
ffffffff40039490:	d503201f 	nop
ffffffff40039494:	d503201f 	nop
ffffffff40039498:	d503201f 	nop
ffffffff4003949c:	d503201f 	nop
ffffffff400394a0:	d503201f 	nop
ffffffff400394a4:	d503201f 	nop
ffffffff400394a8:	d503201f 	nop
ffffffff400394ac:	d503201f 	nop
ffffffff400394b0:	d503201f 	nop
ffffffff400394b4:	d503201f 	nop
ffffffff400394b8:	d503201f 	nop
ffffffff400394bc:	d503201f 	nop
ffffffff400394c0:	d503201f 	nop
ffffffff400394c4:	d503201f 	nop
ffffffff400394c8:	d503201f 	nop
ffffffff400394cc:	d503201f 	nop
ffffffff400394d0:	d503201f 	nop
ffffffff400394d4:	d503201f 	nop
ffffffff400394d8:	d503201f 	nop
ffffffff400394dc:	d503201f 	nop
ffffffff400394e0:	d503201f 	nop
ffffffff400394e4:	d503201f 	nop
ffffffff400394e8:	d503201f 	nop
ffffffff400394ec:	d503201f 	nop
ffffffff400394f0:	d503201f 	nop
ffffffff400394f4:	d503201f 	nop
ffffffff400394f8:	d503201f 	nop
ffffffff400394fc:	d503201f 	nop
ffffffff40039500:	140001d0 	b	ffffffff40039c40 <_el_lower_fiq>
ffffffff40039504:	d503201f 	nop
ffffffff40039508:	d503201f 	nop
ffffffff4003950c:	d503201f 	nop
ffffffff40039510:	d503201f 	nop
ffffffff40039514:	d503201f 	nop
ffffffff40039518:	d503201f 	nop
ffffffff4003951c:	d503201f 	nop
ffffffff40039520:	d503201f 	nop
ffffffff40039524:	d503201f 	nop
ffffffff40039528:	d503201f 	nop
ffffffff4003952c:	d503201f 	nop
ffffffff40039530:	d503201f 	nop
ffffffff40039534:	d503201f 	nop
ffffffff40039538:	d503201f 	nop
ffffffff4003953c:	d503201f 	nop
ffffffff40039540:	d503201f 	nop
ffffffff40039544:	d503201f 	nop
ffffffff40039548:	d503201f 	nop
ffffffff4003954c:	d503201f 	nop
ffffffff40039550:	d503201f 	nop
ffffffff40039554:	d503201f 	nop
ffffffff40039558:	d503201f 	nop
ffffffff4003955c:	d503201f 	nop
ffffffff40039560:	d503201f 	nop
ffffffff40039564:	d503201f 	nop
ffffffff40039568:	d503201f 	nop
ffffffff4003956c:	d503201f 	nop
ffffffff40039570:	d503201f 	nop
ffffffff40039574:	d503201f 	nop
ffffffff40039578:	d503201f 	nop
ffffffff4003957c:	d503201f 	nop
ffffffff40039580:	140001d0 	b	ffffffff40039cc0 <_el_lower_error>
ffffffff40039584:	d503201f 	nop
ffffffff40039588:	d503201f 	nop
ffffffff4003958c:	d503201f 	nop
ffffffff40039590:	d503201f 	nop
ffffffff40039594:	d503201f 	nop
ffffffff40039598:	d503201f 	nop
ffffffff4003959c:	d503201f 	nop
ffffffff400395a0:	d503201f 	nop
ffffffff400395a4:	d503201f 	nop
ffffffff400395a8:	d503201f 	nop
ffffffff400395ac:	d503201f 	nop
ffffffff400395b0:	d503201f 	nop
ffffffff400395b4:	d503201f 	nop
ffffffff400395b8:	d503201f 	nop
ffffffff400395bc:	d503201f 	nop

ffffffff400395c0 <_el_current_bad_sync>:
ffffffff400395c0:	d10083ff 	sub	sp, sp, #0x20
ffffffff400395c4:	a9bf77fc 	stp	x28, x29, [sp, #-16]!
ffffffff400395c8:	a9bf6ffa 	stp	x26, x27, [sp, #-16]!
ffffffff400395cc:	a9bf67f8 	stp	x24, x25, [sp, #-16]!
ffffffff400395d0:	a9bf5ff6 	stp	x22, x23, [sp, #-16]!
ffffffff400395d4:	a9bf57f4 	stp	x20, x21, [sp, #-16]!
ffffffff400395d8:	a9bf4ff2 	stp	x18, x19, [sp, #-16]!
ffffffff400395dc:	a9bf47f0 	stp	x16, x17, [sp, #-16]!
ffffffff400395e0:	a9bf3fee 	stp	x14, x15, [sp, #-16]!
ffffffff400395e4:	a9bf37ec 	stp	x12, x13, [sp, #-16]!
ffffffff400395e8:	a9bf2fea 	stp	x10, x11, [sp, #-16]!
ffffffff400395ec:	a9bf27e8 	stp	x8, x9, [sp, #-16]!
ffffffff400395f0:	a9bf1fe6 	stp	x6, x7, [sp, #-16]!
ffffffff400395f4:	a9bf17e4 	stp	x4, x5, [sp, #-16]!
ffffffff400395f8:	a9bf0fe2 	stp	x2, x3, [sp, #-16]!
ffffffff400395fc:	a9bf07e0 	stp	x0, x1, [sp, #-16]!
ffffffff40039600:	910443f5 	add	x21, sp, #0x110
ffffffff40039604:	d53e4036 	mrs	x22, elr_el3
ffffffff40039608:	d53e4017 	mrs	x23, spsr_el3
ffffffff4003960c:	a90f57fe 	stp	x30, x21, [sp, #240]
ffffffff40039610:	a9105ff6 	stp	x22, x23, [sp, #256]
ffffffff40039614:	910003e0 	mov	x0, sp
ffffffff40039618:	d2800021 	mov	x1, #0x1                   	// #1
ffffffff4003961c:	d5385202 	mrs	x2, esr_el1
ffffffff40039620:	97fff755 	bl	ffffffff40037374 <bad_handler>
ffffffff40039624:	14000000 	b	ffffffff40039624 <_el_current_bad_sync+0x64>
ffffffff40039628:	d503201f 	nop
ffffffff4003962c:	d503201f 	nop
ffffffff40039630:	d503201f 	nop
ffffffff40039634:	d503201f 	nop
ffffffff40039638:	d503201f 	nop
ffffffff4003963c:	d503201f 	nop

ffffffff40039640 <_el_current_bad_irq>:
ffffffff40039640:	d10083ff 	sub	sp, sp, #0x20
ffffffff40039644:	a9bf77fc 	stp	x28, x29, [sp, #-16]!
ffffffff40039648:	a9bf6ffa 	stp	x26, x27, [sp, #-16]!
ffffffff4003964c:	a9bf67f8 	stp	x24, x25, [sp, #-16]!
ffffffff40039650:	a9bf5ff6 	stp	x22, x23, [sp, #-16]!
ffffffff40039654:	a9bf57f4 	stp	x20, x21, [sp, #-16]!
ffffffff40039658:	a9bf4ff2 	stp	x18, x19, [sp, #-16]!
ffffffff4003965c:	a9bf47f0 	stp	x16, x17, [sp, #-16]!
ffffffff40039660:	a9bf3fee 	stp	x14, x15, [sp, #-16]!
ffffffff40039664:	a9bf37ec 	stp	x12, x13, [sp, #-16]!
ffffffff40039668:	a9bf2fea 	stp	x10, x11, [sp, #-16]!
ffffffff4003966c:	a9bf27e8 	stp	x8, x9, [sp, #-16]!
ffffffff40039670:	a9bf1fe6 	stp	x6, x7, [sp, #-16]!
ffffffff40039674:	a9bf17e4 	stp	x4, x5, [sp, #-16]!
ffffffff40039678:	a9bf0fe2 	stp	x2, x3, [sp, #-16]!
ffffffff4003967c:	a9bf07e0 	stp	x0, x1, [sp, #-16]!
ffffffff40039680:	910443f5 	add	x21, sp, #0x110
ffffffff40039684:	d53e4036 	mrs	x22, elr_el3
ffffffff40039688:	d53e4017 	mrs	x23, spsr_el3
ffffffff4003968c:	a90f57fe 	stp	x30, x21, [sp, #240]
ffffffff40039690:	a9105ff6 	stp	x22, x23, [sp, #256]
ffffffff40039694:	910003e0 	mov	x0, sp
ffffffff40039698:	d2800041 	mov	x1, #0x2                   	// #2
ffffffff4003969c:	d5385202 	mrs	x2, esr_el1
ffffffff400396a0:	97fff735 	bl	ffffffff40037374 <bad_handler>
ffffffff400396a4:	14000000 	b	ffffffff400396a4 <_el_current_bad_irq+0x64>
ffffffff400396a8:	d503201f 	nop
ffffffff400396ac:	d503201f 	nop
ffffffff400396b0:	d503201f 	nop
ffffffff400396b4:	d503201f 	nop
ffffffff400396b8:	d503201f 	nop
ffffffff400396bc:	d503201f 	nop

ffffffff400396c0 <_el_current_bad_fiq>:
ffffffff400396c0:	d10083ff 	sub	sp, sp, #0x20
ffffffff400396c4:	a9bf77fc 	stp	x28, x29, [sp, #-16]!
ffffffff400396c8:	a9bf6ffa 	stp	x26, x27, [sp, #-16]!
ffffffff400396cc:	a9bf67f8 	stp	x24, x25, [sp, #-16]!
ffffffff400396d0:	a9bf5ff6 	stp	x22, x23, [sp, #-16]!
ffffffff400396d4:	a9bf57f4 	stp	x20, x21, [sp, #-16]!
ffffffff400396d8:	a9bf4ff2 	stp	x18, x19, [sp, #-16]!
ffffffff400396dc:	a9bf47f0 	stp	x16, x17, [sp, #-16]!
ffffffff400396e0:	a9bf3fee 	stp	x14, x15, [sp, #-16]!
ffffffff400396e4:	a9bf37ec 	stp	x12, x13, [sp, #-16]!
ffffffff400396e8:	a9bf2fea 	stp	x10, x11, [sp, #-16]!
ffffffff400396ec:	a9bf27e8 	stp	x8, x9, [sp, #-16]!
ffffffff400396f0:	a9bf1fe6 	stp	x6, x7, [sp, #-16]!
ffffffff400396f4:	a9bf17e4 	stp	x4, x5, [sp, #-16]!
ffffffff400396f8:	a9bf0fe2 	stp	x2, x3, [sp, #-16]!
ffffffff400396fc:	a9bf07e0 	stp	x0, x1, [sp, #-16]!
ffffffff40039700:	910443f5 	add	x21, sp, #0x110
ffffffff40039704:	d53e4036 	mrs	x22, elr_el3
ffffffff40039708:	d53e4017 	mrs	x23, spsr_el3
ffffffff4003970c:	a90f57fe 	stp	x30, x21, [sp, #240]
ffffffff40039710:	a9105ff6 	stp	x22, x23, [sp, #256]
ffffffff40039714:	910003e0 	mov	x0, sp
ffffffff40039718:	d2800061 	mov	x1, #0x3                   	// #3
ffffffff4003971c:	d5385202 	mrs	x2, esr_el1
ffffffff40039720:	97fff715 	bl	ffffffff40037374 <bad_handler>
ffffffff40039724:	14000000 	b	ffffffff40039724 <_el_current_bad_fiq+0x64>
ffffffff40039728:	d503201f 	nop
ffffffff4003972c:	d503201f 	nop
ffffffff40039730:	d503201f 	nop
ffffffff40039734:	d503201f 	nop
ffffffff40039738:	d503201f 	nop
ffffffff4003973c:	d503201f 	nop

ffffffff40039740 <_el_current_bad_error>:
ffffffff40039740:	d10083ff 	sub	sp, sp, #0x20
ffffffff40039744:	a9bf77fc 	stp	x28, x29, [sp, #-16]!
ffffffff40039748:	a9bf6ffa 	stp	x26, x27, [sp, #-16]!
ffffffff4003974c:	a9bf67f8 	stp	x24, x25, [sp, #-16]!
ffffffff40039750:	a9bf5ff6 	stp	x22, x23, [sp, #-16]!
ffffffff40039754:	a9bf57f4 	stp	x20, x21, [sp, #-16]!
ffffffff40039758:	a9bf4ff2 	stp	x18, x19, [sp, #-16]!
ffffffff4003975c:	a9bf47f0 	stp	x16, x17, [sp, #-16]!
ffffffff40039760:	a9bf3fee 	stp	x14, x15, [sp, #-16]!
ffffffff40039764:	a9bf37ec 	stp	x12, x13, [sp, #-16]!
ffffffff40039768:	a9bf2fea 	stp	x10, x11, [sp, #-16]!
ffffffff4003976c:	a9bf27e8 	stp	x8, x9, [sp, #-16]!
ffffffff40039770:	a9bf1fe6 	stp	x6, x7, [sp, #-16]!
ffffffff40039774:	a9bf17e4 	stp	x4, x5, [sp, #-16]!
ffffffff40039778:	a9bf0fe2 	stp	x2, x3, [sp, #-16]!
ffffffff4003977c:	a9bf07e0 	stp	x0, x1, [sp, #-16]!
ffffffff40039780:	910443f5 	add	x21, sp, #0x110
ffffffff40039784:	d53e4036 	mrs	x22, elr_el3
ffffffff40039788:	d53e4017 	mrs	x23, spsr_el3
ffffffff4003978c:	a90f57fe 	stp	x30, x21, [sp, #240]
ffffffff40039790:	a9105ff6 	stp	x22, x23, [sp, #256]
ffffffff40039794:	910003e0 	mov	x0, sp
ffffffff40039798:	d2800081 	mov	x1, #0x4                   	// #4
ffffffff4003979c:	d5385202 	mrs	x2, esr_el1
ffffffff400397a0:	97fff6f5 	bl	ffffffff40037374 <bad_handler>
ffffffff400397a4:	14000000 	b	ffffffff400397a4 <_el_current_bad_error+0x64>
ffffffff400397a8:	d503201f 	nop
ffffffff400397ac:	d503201f 	nop
ffffffff400397b0:	d503201f 	nop
ffffffff400397b4:	d503201f 	nop
ffffffff400397b8:	d503201f 	nop
ffffffff400397bc:	d503201f 	nop

ffffffff400397c0 <_el_current_sync>:
ffffffff400397c0:	d10083ff 	sub	sp, sp, #0x20
ffffffff400397c4:	a9bf77fc 	stp	x28, x29, [sp, #-16]!
ffffffff400397c8:	a9bf6ffa 	stp	x26, x27, [sp, #-16]!
ffffffff400397cc:	a9bf67f8 	stp	x24, x25, [sp, #-16]!
ffffffff400397d0:	a9bf5ff6 	stp	x22, x23, [sp, #-16]!
ffffffff400397d4:	a9bf57f4 	stp	x20, x21, [sp, #-16]!
ffffffff400397d8:	a9bf4ff2 	stp	x18, x19, [sp, #-16]!
ffffffff400397dc:	a9bf47f0 	stp	x16, x17, [sp, #-16]!
ffffffff400397e0:	a9bf3fee 	stp	x14, x15, [sp, #-16]!
ffffffff400397e4:	a9bf37ec 	stp	x12, x13, [sp, #-16]!
ffffffff400397e8:	a9bf2fea 	stp	x10, x11, [sp, #-16]!
ffffffff400397ec:	a9bf27e8 	stp	x8, x9, [sp, #-16]!
ffffffff400397f0:	a9bf1fe6 	stp	x6, x7, [sp, #-16]!
ffffffff400397f4:	a9bf17e4 	stp	x4, x5, [sp, #-16]!
ffffffff400397f8:	a9bf0fe2 	stp	x2, x3, [sp, #-16]!
ffffffff400397fc:	a9bf07e0 	stp	x0, x1, [sp, #-16]!
ffffffff40039800:	910443f5 	add	x21, sp, #0x110
ffffffff40039804:	d53e4036 	mrs	x22, elr_el3
ffffffff40039808:	d53e4017 	mrs	x23, spsr_el3
ffffffff4003980c:	a90f57fe 	stp	x30, x21, [sp, #240]
ffffffff40039810:	a9105ff6 	stp	x22, x23, [sp, #256]
ffffffff40039814:	d5385202 	mrs	x2, esr_el1
ffffffff40039818:	d35afc58 	lsr	x24, x2, #26
ffffffff4003981c:	f100971f 	cmp	x24, #0x25
ffffffff40039820:	54000080 	b.eq	ffffffff40039830 <el1_da>  // b.none
ffffffff40039824:	f100871f 	cmp	x24, #0x21
ffffffff40039828:	540000c0 	b.eq	ffffffff40039840 <el1_ia>  // b.none
ffffffff4003982c:	14000009 	b	ffffffff40039850 <el1_default>

ffffffff40039830 <el1_da>:
ffffffff40039830:	910003e0 	mov	x0, sp
ffffffff40039834:	d2800021 	mov	x1, #0x1                   	// #1
ffffffff40039838:	97fff66c 	bl	ffffffff400371e8 <dabort_handler>
ffffffff4003983c:	14000000 	b	ffffffff4003983c <el1_da+0xc>

ffffffff40039840 <el1_ia>:
ffffffff40039840:	910003e0 	mov	x0, sp
ffffffff40039844:	d2800021 	mov	x1, #0x1                   	// #1
ffffffff40039848:	97fff67c 	bl	ffffffff40037238 <iabort_handler>
ffffffff4003984c:	14000000 	b	ffffffff4003984c <el1_ia+0xc>

ffffffff40039850 <el1_default>:
ffffffff40039850:	910003e0 	mov	x0, sp
ffffffff40039854:	d2800021 	mov	x1, #0x1                   	// #1
ffffffff40039858:	97fff6df 	bl	ffffffff400373d4 <default_handler>
ffffffff4003985c:	14000000 	b	ffffffff4003985c <el1_default+0xc>
ffffffff40039860:	d503201f 	nop
ffffffff40039864:	d503201f 	nop
ffffffff40039868:	d503201f 	nop
ffffffff4003986c:	d503201f 	nop
ffffffff40039870:	d503201f 	nop
ffffffff40039874:	d503201f 	nop
ffffffff40039878:	d503201f 	nop
ffffffff4003987c:	d503201f 	nop

ffffffff40039880 <_el_current_irq>:
ffffffff40039880:	d10083ff 	sub	sp, sp, #0x20
ffffffff40039884:	a9bf77fc 	stp	x28, x29, [sp, #-16]!
ffffffff40039888:	a9bf6ffa 	stp	x26, x27, [sp, #-16]!
ffffffff4003988c:	a9bf67f8 	stp	x24, x25, [sp, #-16]!
ffffffff40039890:	a9bf5ff6 	stp	x22, x23, [sp, #-16]!
ffffffff40039894:	a9bf57f4 	stp	x20, x21, [sp, #-16]!
ffffffff40039898:	a9bf4ff2 	stp	x18, x19, [sp, #-16]!
ffffffff4003989c:	a9bf47f0 	stp	x16, x17, [sp, #-16]!
ffffffff400398a0:	a9bf3fee 	stp	x14, x15, [sp, #-16]!
ffffffff400398a4:	a9bf37ec 	stp	x12, x13, [sp, #-16]!
ffffffff400398a8:	a9bf2fea 	stp	x10, x11, [sp, #-16]!
ffffffff400398ac:	a9bf27e8 	stp	x8, x9, [sp, #-16]!
ffffffff400398b0:	a9bf1fe6 	stp	x6, x7, [sp, #-16]!
ffffffff400398b4:	a9bf17e4 	stp	x4, x5, [sp, #-16]!
ffffffff400398b8:	a9bf0fe2 	stp	x2, x3, [sp, #-16]!
ffffffff400398bc:	a9bf07e0 	stp	x0, x1, [sp, #-16]!
ffffffff400398c0:	910443f5 	add	x21, sp, #0x110
ffffffff400398c4:	d53e4036 	mrs	x22, elr_el3
ffffffff400398c8:	d53e4017 	mrs	x23, spsr_el3
ffffffff400398cc:	a90f57fe 	stp	x30, x21, [sp, #240]
ffffffff400398d0:	a9105ff6 	stp	x22, x23, [sp, #256]
ffffffff400398d4:	910003e0 	mov	x0, sp
ffffffff400398d8:	d2800021 	mov	x1, #0x1                   	// #1
ffffffff400398dc:	d5385202 	mrs	x2, esr_el1
ffffffff400398e0:	97fff62e 	bl	ffffffff40037198 <irq_handler>
ffffffff400398e4:	a9505ff6 	ldp	x22, x23, [sp, #256]
ffffffff400398e8:	a94f73fe 	ldp	x30, x28, [sp, #240]
ffffffff400398ec:	d51e4036 	msr	elr_el3, x22
ffffffff400398f0:	d51e4017 	msr	spsr_el3, x23
ffffffff400398f4:	910003fd 	mov	x29, sp
ffffffff400398f8:	9100039f 	mov	sp, x28
ffffffff400398fc:	a8c107a0 	ldp	x0, x1, [x29], #16
ffffffff40039900:	a8c10fa2 	ldp	x2, x3, [x29], #16
ffffffff40039904:	a8c117a4 	ldp	x4, x5, [x29], #16
ffffffff40039908:	a8c11fa6 	ldp	x6, x7, [x29], #16
ffffffff4003990c:	a8c127a8 	ldp	x8, x9, [x29], #16
ffffffff40039910:	a8c12faa 	ldp	x10, x11, [x29], #16
ffffffff40039914:	a8c137ac 	ldp	x12, x13, [x29], #16
ffffffff40039918:	a8c13fae 	ldp	x14, x15, [x29], #16
ffffffff4003991c:	a8c147b0 	ldp	x16, x17, [x29], #16
ffffffff40039920:	a8c14fb2 	ldp	x18, x19, [x29], #16
ffffffff40039924:	a8c157b4 	ldp	x20, x21, [x29], #16
ffffffff40039928:	a8c15fb6 	ldp	x22, x23, [x29], #16
ffffffff4003992c:	a8c167b8 	ldp	x24, x25, [x29], #16
ffffffff40039930:	a8c16fba 	ldp	x26, x27, [x29], #16
ffffffff40039934:	f84087bc 	ldr	x28, [x29], #8
ffffffff40039938:	f94003bd 	ldr	x29, [x29]
ffffffff4003993c:	d69f03e0 	eret

ffffffff40039940 <_el_current_fiq>:
ffffffff40039940:	d10083ff 	sub	sp, sp, #0x20
ffffffff40039944:	a9bf77fc 	stp	x28, x29, [sp, #-16]!
ffffffff40039948:	a9bf6ffa 	stp	x26, x27, [sp, #-16]!
ffffffff4003994c:	a9bf67f8 	stp	x24, x25, [sp, #-16]!
ffffffff40039950:	a9bf5ff6 	stp	x22, x23, [sp, #-16]!
ffffffff40039954:	a9bf57f4 	stp	x20, x21, [sp, #-16]!
ffffffff40039958:	a9bf4ff2 	stp	x18, x19, [sp, #-16]!
ffffffff4003995c:	a9bf47f0 	stp	x16, x17, [sp, #-16]!
ffffffff40039960:	a9bf3fee 	stp	x14, x15, [sp, #-16]!
ffffffff40039964:	a9bf37ec 	stp	x12, x13, [sp, #-16]!
ffffffff40039968:	a9bf2fea 	stp	x10, x11, [sp, #-16]!
ffffffff4003996c:	a9bf27e8 	stp	x8, x9, [sp, #-16]!
ffffffff40039970:	a9bf1fe6 	stp	x6, x7, [sp, #-16]!
ffffffff40039974:	a9bf17e4 	stp	x4, x5, [sp, #-16]!
ffffffff40039978:	a9bf0fe2 	stp	x2, x3, [sp, #-16]!
ffffffff4003997c:	a9bf07e0 	stp	x0, x1, [sp, #-16]!
ffffffff40039980:	910443f5 	add	x21, sp, #0x110
ffffffff40039984:	d53e4036 	mrs	x22, elr_el3
ffffffff40039988:	d53e4017 	mrs	x23, spsr_el3
ffffffff4003998c:	a90f57fe 	stp	x30, x21, [sp, #240]
ffffffff40039990:	a9105ff6 	stp	x22, x23, [sp, #256]
ffffffff40039994:	910003e0 	mov	x0, sp
ffffffff40039998:	d2800021 	mov	x1, #0x1                   	// #1
ffffffff4003999c:	d5385202 	mrs	x2, esr_el1
ffffffff400399a0:	97fff666 	bl	ffffffff40037338 <fiq_handler>
ffffffff400399a4:	14000000 	b	ffffffff400399a4 <_el_current_fiq+0x64>
ffffffff400399a8:	d503201f 	nop
ffffffff400399ac:	d503201f 	nop
ffffffff400399b0:	d503201f 	nop
ffffffff400399b4:	d503201f 	nop
ffffffff400399b8:	d503201f 	nop
ffffffff400399bc:	d503201f 	nop

ffffffff400399c0 <_el_current_error>:
ffffffff400399c0:	d10083ff 	sub	sp, sp, #0x20
ffffffff400399c4:	a9bf77fc 	stp	x28, x29, [sp, #-16]!
ffffffff400399c8:	a9bf6ffa 	stp	x26, x27, [sp, #-16]!
ffffffff400399cc:	a9bf67f8 	stp	x24, x25, [sp, #-16]!
ffffffff400399d0:	a9bf5ff6 	stp	x22, x23, [sp, #-16]!
ffffffff400399d4:	a9bf57f4 	stp	x20, x21, [sp, #-16]!
ffffffff400399d8:	a9bf4ff2 	stp	x18, x19, [sp, #-16]!
ffffffff400399dc:	a9bf47f0 	stp	x16, x17, [sp, #-16]!
ffffffff400399e0:	a9bf3fee 	stp	x14, x15, [sp, #-16]!
ffffffff400399e4:	a9bf37ec 	stp	x12, x13, [sp, #-16]!
ffffffff400399e8:	a9bf2fea 	stp	x10, x11, [sp, #-16]!
ffffffff400399ec:	a9bf27e8 	stp	x8, x9, [sp, #-16]!
ffffffff400399f0:	a9bf1fe6 	stp	x6, x7, [sp, #-16]!
ffffffff400399f4:	a9bf17e4 	stp	x4, x5, [sp, #-16]!
ffffffff400399f8:	a9bf0fe2 	stp	x2, x3, [sp, #-16]!
ffffffff400399fc:	a9bf07e0 	stp	x0, x1, [sp, #-16]!
ffffffff40039a00:	910443f5 	add	x21, sp, #0x110
ffffffff40039a04:	d53e4036 	mrs	x22, elr_el3
ffffffff40039a08:	d53e4017 	mrs	x23, spsr_el3
ffffffff40039a0c:	a90f57fe 	stp	x30, x21, [sp, #240]
ffffffff40039a10:	a9105ff6 	stp	x22, x23, [sp, #256]
ffffffff40039a14:	910003e0 	mov	x0, sp
ffffffff40039a18:	d2800021 	mov	x1, #0x1                   	// #1
ffffffff40039a1c:	d5385202 	mrs	x2, esr_el1
ffffffff40039a20:	97fff661 	bl	ffffffff400373a4 <error_handler>
ffffffff40039a24:	14000000 	b	ffffffff40039a24 <_el_current_error+0x64>
ffffffff40039a28:	d503201f 	nop
ffffffff40039a2c:	d503201f 	nop
ffffffff40039a30:	d503201f 	nop
ffffffff40039a34:	d503201f 	nop
ffffffff40039a38:	d503201f 	nop
ffffffff40039a3c:	d503201f 	nop

ffffffff40039a40 <_el_lower_sync>:
ffffffff40039a40:	d10083ff 	sub	sp, sp, #0x20
ffffffff40039a44:	a9bf77fc 	stp	x28, x29, [sp, #-16]!
ffffffff40039a48:	a9bf6ffa 	stp	x26, x27, [sp, #-16]!
ffffffff40039a4c:	a9bf67f8 	stp	x24, x25, [sp, #-16]!
ffffffff40039a50:	a9bf5ff6 	stp	x22, x23, [sp, #-16]!
ffffffff40039a54:	a9bf57f4 	stp	x20, x21, [sp, #-16]!
ffffffff40039a58:	a9bf4ff2 	stp	x18, x19, [sp, #-16]!
ffffffff40039a5c:	a9bf47f0 	stp	x16, x17, [sp, #-16]!
ffffffff40039a60:	a9bf3fee 	stp	x14, x15, [sp, #-16]!
ffffffff40039a64:	a9bf37ec 	stp	x12, x13, [sp, #-16]!
ffffffff40039a68:	a9bf2fea 	stp	x10, x11, [sp, #-16]!
ffffffff40039a6c:	a9bf27e8 	stp	x8, x9, [sp, #-16]!
ffffffff40039a70:	a9bf1fe6 	stp	x6, x7, [sp, #-16]!
ffffffff40039a74:	a9bf17e4 	stp	x4, x5, [sp, #-16]!
ffffffff40039a78:	a9bf0fe2 	stp	x2, x3, [sp, #-16]!
ffffffff40039a7c:	a9bf07e0 	stp	x0, x1, [sp, #-16]!
ffffffff40039a80:	d5384115 	mrs	x21, sp_el0
ffffffff40039a84:	d53e4036 	mrs	x22, elr_el3
ffffffff40039a88:	d53e4017 	mrs	x23, spsr_el3
ffffffff40039a8c:	a90f57fe 	stp	x30, x21, [sp, #240]
ffffffff40039a90:	a9105ff6 	stp	x22, x23, [sp, #256]
ffffffff40039a94:	d5385202 	mrs	x2, esr_el1
ffffffff40039a98:	d35afc58 	lsr	x24, x2, #26
ffffffff40039a9c:	f100571f 	cmp	x24, #0x15
ffffffff40039aa0:	54000100 	b.eq	ffffffff40039ac0 <el0_svc>  // b.none
ffffffff40039aa4:	f100931f 	cmp	x24, #0x24
ffffffff40039aa8:	54000400 	b.eq	ffffffff40039b28 <el0_da>  // b.none
ffffffff40039aac:	f100831f 	cmp	x24, #0x20
ffffffff40039ab0:	54000440 	b.eq	ffffffff40039b38 <el0_ia>  // b.none
ffffffff40039ab4:	f100031f 	cmp	x24, #0x0
ffffffff40039ab8:	54000480 	b.eq	ffffffff40039b48 <el0_undef>  // b.none
ffffffff40039abc:	14000027 	b	ffffffff40039b58 <el0_default>

ffffffff40039ac0 <el0_svc>:
ffffffff40039ac0:	910003e0 	mov	x0, sp
ffffffff40039ac4:	d2800001 	mov	x1, #0x0                   	// #0
ffffffff40039ac8:	97fff5a6 	bl	ffffffff40037160 <swi_handler>
ffffffff40039acc:	a9505ff6 	ldp	x22, x23, [sp, #256]
ffffffff40039ad0:	a94f73fe 	ldp	x30, x28, [sp, #240]
ffffffff40039ad4:	d51e4036 	msr	elr_el3, x22
ffffffff40039ad8:	d51e4017 	msr	spsr_el3, x23
ffffffff40039adc:	d518411c 	msr	sp_el0, x28
ffffffff40039ae0:	910003fd 	mov	x29, sp
ffffffff40039ae4:	a8c107a0 	ldp	x0, x1, [x29], #16
ffffffff40039ae8:	a8c10fa2 	ldp	x2, x3, [x29], #16
ffffffff40039aec:	a8c117a4 	ldp	x4, x5, [x29], #16
ffffffff40039af0:	a8c11fa6 	ldp	x6, x7, [x29], #16
ffffffff40039af4:	a8c127a8 	ldp	x8, x9, [x29], #16
ffffffff40039af8:	a8c12faa 	ldp	x10, x11, [x29], #16
ffffffff40039afc:	a8c137ac 	ldp	x12, x13, [x29], #16
ffffffff40039b00:	a8c13fae 	ldp	x14, x15, [x29], #16
ffffffff40039b04:	a8c147b0 	ldp	x16, x17, [x29], #16
ffffffff40039b08:	a8c14fb2 	ldp	x18, x19, [x29], #16
ffffffff40039b0c:	a8c157b4 	ldp	x20, x21, [x29], #16
ffffffff40039b10:	a8c15fb6 	ldp	x22, x23, [x29], #16
ffffffff40039b14:	a8c167b8 	ldp	x24, x25, [x29], #16
ffffffff40039b18:	a8c16fba 	ldp	x26, x27, [x29], #16
ffffffff40039b1c:	f84087bc 	ldr	x28, [x29], #8
ffffffff40039b20:	f94003bd 	ldr	x29, [x29]
ffffffff40039b24:	d69f03e0 	eret

ffffffff40039b28 <el0_da>:
ffffffff40039b28:	910003e0 	mov	x0, sp
ffffffff40039b2c:	d2800001 	mov	x1, #0x0                   	// #0
ffffffff40039b30:	97fff5ae 	bl	ffffffff400371e8 <dabort_handler>
ffffffff40039b34:	14000000 	b	ffffffff40039b34 <el0_da+0xc>

ffffffff40039b38 <el0_ia>:
ffffffff40039b38:	910003e0 	mov	x0, sp
ffffffff40039b3c:	d2800001 	mov	x1, #0x0                   	// #0
ffffffff40039b40:	97fff5be 	bl	ffffffff40037238 <iabort_handler>
ffffffff40039b44:	14000000 	b	ffffffff40039b44 <el0_ia+0xc>

ffffffff40039b48 <el0_undef>:
ffffffff40039b48:	910003e0 	mov	x0, sp
ffffffff40039b4c:	d2800001 	mov	x1, #0x0                   	// #0
ffffffff40039b50:	97fff5da 	bl	ffffffff400372b8 <und_handler>
ffffffff40039b54:	14000000 	b	ffffffff40039b54 <el0_undef+0xc>

ffffffff40039b58 <el0_default>:
ffffffff40039b58:	910003e0 	mov	x0, sp
ffffffff40039b5c:	d2800001 	mov	x1, #0x0                   	// #0
ffffffff40039b60:	97fff61d 	bl	ffffffff400373d4 <default_handler>
ffffffff40039b64:	14000000 	b	ffffffff40039b64 <el0_default+0xc>
ffffffff40039b68:	d503201f 	nop
ffffffff40039b6c:	d503201f 	nop
ffffffff40039b70:	d503201f 	nop
ffffffff40039b74:	d503201f 	nop
ffffffff40039b78:	d503201f 	nop
ffffffff40039b7c:	d503201f 	nop

ffffffff40039b80 <_el_lower_irq>:
ffffffff40039b80:	d10083ff 	sub	sp, sp, #0x20
ffffffff40039b84:	a9bf77fc 	stp	x28, x29, [sp, #-16]!
ffffffff40039b88:	a9bf6ffa 	stp	x26, x27, [sp, #-16]!
ffffffff40039b8c:	a9bf67f8 	stp	x24, x25, [sp, #-16]!
ffffffff40039b90:	a9bf5ff6 	stp	x22, x23, [sp, #-16]!
ffffffff40039b94:	a9bf57f4 	stp	x20, x21, [sp, #-16]!
ffffffff40039b98:	a9bf4ff2 	stp	x18, x19, [sp, #-16]!
ffffffff40039b9c:	a9bf47f0 	stp	x16, x17, [sp, #-16]!
ffffffff40039ba0:	a9bf3fee 	stp	x14, x15, [sp, #-16]!
ffffffff40039ba4:	a9bf37ec 	stp	x12, x13, [sp, #-16]!
ffffffff40039ba8:	a9bf2fea 	stp	x10, x11, [sp, #-16]!
ffffffff40039bac:	a9bf27e8 	stp	x8, x9, [sp, #-16]!
ffffffff40039bb0:	a9bf1fe6 	stp	x6, x7, [sp, #-16]!
ffffffff40039bb4:	a9bf17e4 	stp	x4, x5, [sp, #-16]!
ffffffff40039bb8:	a9bf0fe2 	stp	x2, x3, [sp, #-16]!
ffffffff40039bbc:	a9bf07e0 	stp	x0, x1, [sp, #-16]!
ffffffff40039bc0:	d5384115 	mrs	x21, sp_el0
ffffffff40039bc4:	d53e4036 	mrs	x22, elr_el3
ffffffff40039bc8:	d53e4017 	mrs	x23, spsr_el3
ffffffff40039bcc:	a90f57fe 	stp	x30, x21, [sp, #240]
ffffffff40039bd0:	a9105ff6 	stp	x22, x23, [sp, #256]
ffffffff40039bd4:	910003e0 	mov	x0, sp
ffffffff40039bd8:	d2800001 	mov	x1, #0x0                   	// #0
ffffffff40039bdc:	d5385202 	mrs	x2, esr_el1
ffffffff40039be0:	97fff56e 	bl	ffffffff40037198 <irq_handler>
ffffffff40039be4:	a9505ff6 	ldp	x22, x23, [sp, #256]
ffffffff40039be8:	a94f73fe 	ldp	x30, x28, [sp, #240]
ffffffff40039bec:	d51e4036 	msr	elr_el3, x22
ffffffff40039bf0:	d51e4017 	msr	spsr_el3, x23
ffffffff40039bf4:	d518411c 	msr	sp_el0, x28
ffffffff40039bf8:	910003fd 	mov	x29, sp
ffffffff40039bfc:	a8c107a0 	ldp	x0, x1, [x29], #16
ffffffff40039c00:	a8c10fa2 	ldp	x2, x3, [x29], #16
ffffffff40039c04:	a8c117a4 	ldp	x4, x5, [x29], #16
ffffffff40039c08:	a8c11fa6 	ldp	x6, x7, [x29], #16
ffffffff40039c0c:	a8c127a8 	ldp	x8, x9, [x29], #16
ffffffff40039c10:	a8c12faa 	ldp	x10, x11, [x29], #16
ffffffff40039c14:	a8c137ac 	ldp	x12, x13, [x29], #16
ffffffff40039c18:	a8c13fae 	ldp	x14, x15, [x29], #16
ffffffff40039c1c:	a8c147b0 	ldp	x16, x17, [x29], #16
ffffffff40039c20:	a8c14fb2 	ldp	x18, x19, [x29], #16
ffffffff40039c24:	a8c157b4 	ldp	x20, x21, [x29], #16
ffffffff40039c28:	a8c15fb6 	ldp	x22, x23, [x29], #16
ffffffff40039c2c:	a8c167b8 	ldp	x24, x25, [x29], #16
ffffffff40039c30:	a8c16fba 	ldp	x26, x27, [x29], #16
ffffffff40039c34:	f84087bc 	ldr	x28, [x29], #8
ffffffff40039c38:	f94003bd 	ldr	x29, [x29]
ffffffff40039c3c:	d69f03e0 	eret

ffffffff40039c40 <_el_lower_fiq>:
ffffffff40039c40:	d10083ff 	sub	sp, sp, #0x20
ffffffff40039c44:	a9bf77fc 	stp	x28, x29, [sp, #-16]!
ffffffff40039c48:	a9bf6ffa 	stp	x26, x27, [sp, #-16]!
ffffffff40039c4c:	a9bf67f8 	stp	x24, x25, [sp, #-16]!
ffffffff40039c50:	a9bf5ff6 	stp	x22, x23, [sp, #-16]!
ffffffff40039c54:	a9bf57f4 	stp	x20, x21, [sp, #-16]!
ffffffff40039c58:	a9bf4ff2 	stp	x18, x19, [sp, #-16]!
ffffffff40039c5c:	a9bf47f0 	stp	x16, x17, [sp, #-16]!
ffffffff40039c60:	a9bf3fee 	stp	x14, x15, [sp, #-16]!
ffffffff40039c64:	a9bf37ec 	stp	x12, x13, [sp, #-16]!
ffffffff40039c68:	a9bf2fea 	stp	x10, x11, [sp, #-16]!
ffffffff40039c6c:	a9bf27e8 	stp	x8, x9, [sp, #-16]!
ffffffff40039c70:	a9bf1fe6 	stp	x6, x7, [sp, #-16]!
ffffffff40039c74:	a9bf17e4 	stp	x4, x5, [sp, #-16]!
ffffffff40039c78:	a9bf0fe2 	stp	x2, x3, [sp, #-16]!
ffffffff40039c7c:	a9bf07e0 	stp	x0, x1, [sp, #-16]!
ffffffff40039c80:	d5384115 	mrs	x21, sp_el0
ffffffff40039c84:	d53e4036 	mrs	x22, elr_el3
ffffffff40039c88:	d53e4017 	mrs	x23, spsr_el3
ffffffff40039c8c:	a90f57fe 	stp	x30, x21, [sp, #240]
ffffffff40039c90:	a9105ff6 	stp	x22, x23, [sp, #256]
ffffffff40039c94:	910003e0 	mov	x0, sp
ffffffff40039c98:	d2800001 	mov	x1, #0x0                   	// #0
ffffffff40039c9c:	d5385202 	mrs	x2, esr_el1
ffffffff40039ca0:	97fff5a6 	bl	ffffffff40037338 <fiq_handler>
ffffffff40039ca4:	14000000 	b	ffffffff40039ca4 <_el_lower_fiq+0x64>
ffffffff40039ca8:	d503201f 	nop
ffffffff40039cac:	d503201f 	nop
ffffffff40039cb0:	d503201f 	nop
ffffffff40039cb4:	d503201f 	nop
ffffffff40039cb8:	d503201f 	nop
ffffffff40039cbc:	d503201f 	nop

ffffffff40039cc0 <_el_lower_error>:
ffffffff40039cc0:	d10083ff 	sub	sp, sp, #0x20
ffffffff40039cc4:	a9bf77fc 	stp	x28, x29, [sp, #-16]!
ffffffff40039cc8:	a9bf6ffa 	stp	x26, x27, [sp, #-16]!
ffffffff40039ccc:	a9bf67f8 	stp	x24, x25, [sp, #-16]!
ffffffff40039cd0:	a9bf5ff6 	stp	x22, x23, [sp, #-16]!
ffffffff40039cd4:	a9bf57f4 	stp	x20, x21, [sp, #-16]!
ffffffff40039cd8:	a9bf4ff2 	stp	x18, x19, [sp, #-16]!
ffffffff40039cdc:	a9bf47f0 	stp	x16, x17, [sp, #-16]!
ffffffff40039ce0:	a9bf3fee 	stp	x14, x15, [sp, #-16]!
ffffffff40039ce4:	a9bf37ec 	stp	x12, x13, [sp, #-16]!
ffffffff40039ce8:	a9bf2fea 	stp	x10, x11, [sp, #-16]!
ffffffff40039cec:	a9bf27e8 	stp	x8, x9, [sp, #-16]!
ffffffff40039cf0:	a9bf1fe6 	stp	x6, x7, [sp, #-16]!
ffffffff40039cf4:	a9bf17e4 	stp	x4, x5, [sp, #-16]!
ffffffff40039cf8:	a9bf0fe2 	stp	x2, x3, [sp, #-16]!
ffffffff40039cfc:	a9bf07e0 	stp	x0, x1, [sp, #-16]!
ffffffff40039d00:	d5384115 	mrs	x21, sp_el0
ffffffff40039d04:	d53e4036 	mrs	x22, elr_el3
ffffffff40039d08:	d53e4017 	mrs	x23, spsr_el3
ffffffff40039d0c:	a90f57fe 	stp	x30, x21, [sp, #240]
ffffffff40039d10:	a9105ff6 	stp	x22, x23, [sp, #256]
ffffffff40039d14:	910003e0 	mov	x0, sp
ffffffff40039d18:	d2800001 	mov	x1, #0x0                   	// #0
ffffffff40039d1c:	d5385202 	mrs	x2, esr_el1
ffffffff40039d20:	97fff5a1 	bl	ffffffff400373a4 <error_handler>
ffffffff40039d24:	14000000 	b	ffffffff40039d24 <_el_lower_error+0x64>

ffffffff40039d28 <v2p>:
ffffffff40039d28:	d10043ff 	sub	sp, sp, #0x10
ffffffff40039d2c:	f90007e0 	str	x0, [sp, #8]
ffffffff40039d30:	f94007e1 	ldr	x1, [sp, #8]
ffffffff40039d34:	d2c00020 	mov	x0, #0x100000000           	// #4294967296
ffffffff40039d38:	8b000020 	add	x0, x1, x0
ffffffff40039d3c:	910043ff 	add	sp, sp, #0x10
ffffffff40039d40:	d65f03c0 	ret

ffffffff40039d44 <p2v>:
static inline void *p2v(uint64 a) { return (void *) ((a) + (uint64)KERNBASE); }
ffffffff40039d44:	d10043ff 	sub	sp, sp, #0x10
ffffffff40039d48:	f90007e0 	str	x0, [sp, #8]
ffffffff40039d4c:	f94007e1 	ldr	x1, [sp, #8]
ffffffff40039d50:	b2607fe0 	mov	x0, #0xffffffff00000000    	// #-4294967296
ffffffff40039d54:	8b000020 	add	x0, x1, x0
ffffffff40039d58:	910043ff 	add	sp, sp, #0x10
ffffffff40039d5c:	d65f03c0 	ret

ffffffff40039d60 <init_vmm>:
    struct spinlock lock;
    struct run *freelist;
} kpt_mem;

void init_vmm (void)
{
ffffffff40039d60:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff40039d64:	910003fd 	mov	x29, sp
    initlock(&kpt_mem.lock, "vm");
ffffffff40039d68:	d0000000 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40039d6c:	91336001 	add	x1, x0, #0xcd8
ffffffff40039d70:	d0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40039d74:	911e6000 	add	x0, x0, #0x798
ffffffff40039d78:	97ffefb6 	bl	ffffffff40035c50 <initlock>
    kpt_mem.freelist = NULL;
ffffffff40039d7c:	d0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40039d80:	911e6000 	add	x0, x0, #0x798
ffffffff40039d84:	f900201f 	str	xzr, [x0, #64]
}
ffffffff40039d88:	d503201f 	nop
ffffffff40039d8c:	a8c17bfd 	ldp	x29, x30, [sp], #16
ffffffff40039d90:	d65f03c0 	ret

ffffffff40039d94 <_kpt_free>:

static void _kpt_free (char *v)
{
ffffffff40039d94:	d10083ff 	sub	sp, sp, #0x20
ffffffff40039d98:	f90007e0 	str	x0, [sp, #8]
    struct run *r;

    r = (struct run*) v;
ffffffff40039d9c:	f94007e0 	ldr	x0, [sp, #8]
ffffffff40039da0:	f9000fe0 	str	x0, [sp, #24]
    r->next = kpt_mem.freelist;
ffffffff40039da4:	d0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40039da8:	911e6000 	add	x0, x0, #0x798
ffffffff40039dac:	f9402001 	ldr	x1, [x0, #64]
ffffffff40039db0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40039db4:	f9000001 	str	x1, [x0]
    kpt_mem.freelist = r;
ffffffff40039db8:	d0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40039dbc:	911e6000 	add	x0, x0, #0x798
ffffffff40039dc0:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40039dc4:	f9002001 	str	x1, [x0, #64]
}
ffffffff40039dc8:	d503201f 	nop
ffffffff40039dcc:	910083ff 	add	sp, sp, #0x20
ffffffff40039dd0:	d65f03c0 	ret

ffffffff40039dd4 <kpt_free>:


static void kpt_free (char *v)
{
ffffffff40039dd4:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40039dd8:	910003fd 	mov	x29, sp
ffffffff40039ddc:	f9000fe0 	str	x0, [sp, #24]
    if (v >= (char*)P2V(INIT_KERNMAP)) {
ffffffff40039de0:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40039de4:	92b7fc00 	mov	x0, #0xffffffff401fffff    	// #-3219128321
ffffffff40039de8:	eb00003f 	cmp	x1, x0
ffffffff40039dec:	54000089 	b.ls	ffffffff40039dfc <kpt_free+0x28>  // b.plast
        kfree_page(v);
ffffffff40039df0:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40039df4:	97ffea45 	bl	ffffffff40034708 <kfree_page>
        return;
ffffffff40039df8:	14000009 	b	ffffffff40039e1c <kpt_free+0x48>
    }
    
    acquire(&kpt_mem.lock);
ffffffff40039dfc:	d0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40039e00:	911e6000 	add	x0, x0, #0x798
ffffffff40039e04:	97ffefa0 	bl	ffffffff40035c84 <acquire>
    _kpt_free (v);
ffffffff40039e08:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40039e0c:	97ffffe2 	bl	ffffffff40039d94 <_kpt_free>
    release(&kpt_mem.lock);
ffffffff40039e10:	d0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40039e14:	911e6000 	add	x0, x0, #0x798
ffffffff40039e18:	97ffefa5 	bl	ffffffff40035cac <release>
}
ffffffff40039e1c:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40039e20:	d65f03c0 	ret

ffffffff40039e24 <kpt_freerange>:

// add some memory used for page tables (initialization code)
void kpt_freerange (uint64 low, uint64 hi)
{
ffffffff40039e24:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40039e28:	910003fd 	mov	x29, sp
ffffffff40039e2c:	f9000fe0 	str	x0, [sp, #24]
ffffffff40039e30:	f9000be1 	str	x1, [sp, #16]
    while (low < hi) {
ffffffff40039e34:	14000006 	b	ffffffff40039e4c <kpt_freerange+0x28>
        _kpt_free ((char*)low);
ffffffff40039e38:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40039e3c:	97ffffd6 	bl	ffffffff40039d94 <_kpt_free>
        low += PT_SZ;
ffffffff40039e40:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40039e44:	91400400 	add	x0, x0, #0x1, lsl #12
ffffffff40039e48:	f9000fe0 	str	x0, [sp, #24]
    while (low < hi) {
ffffffff40039e4c:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff40039e50:	f9400be0 	ldr	x0, [sp, #16]
ffffffff40039e54:	eb00003f 	cmp	x1, x0
ffffffff40039e58:	54ffff03 	b.cc	ffffffff40039e38 <kpt_freerange+0x14>  // b.lo, b.ul, b.last
    }
}
ffffffff40039e5c:	d503201f 	nop
ffffffff40039e60:	d503201f 	nop
ffffffff40039e64:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40039e68:	d65f03c0 	ret

ffffffff40039e6c <kpt_alloc>:

void* kpt_alloc (void)
{
ffffffff40039e6c:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff40039e70:	910003fd 	mov	x29, sp
    struct run *r;
    
    acquire(&kpt_mem.lock);
ffffffff40039e74:	d0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40039e78:	911e6000 	add	x0, x0, #0x798
ffffffff40039e7c:	97ffef82 	bl	ffffffff40035c84 <acquire>
    
    if ((r = kpt_mem.freelist) != NULL ) {
ffffffff40039e80:	d0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40039e84:	911e6000 	add	x0, x0, #0x798
ffffffff40039e88:	f9402000 	ldr	x0, [x0, #64]
ffffffff40039e8c:	f9000fe0 	str	x0, [sp, #24]
ffffffff40039e90:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40039e94:	f100001f 	cmp	x0, #0x0
ffffffff40039e98:	540000c0 	b.eq	ffffffff40039eb0 <kpt_alloc+0x44>  // b.none
        kpt_mem.freelist = r->next;
ffffffff40039e9c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40039ea0:	f9400001 	ldr	x1, [x0]
ffffffff40039ea4:	d0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40039ea8:	911e6000 	add	x0, x0, #0x798
ffffffff40039eac:	f9002001 	str	x1, [x0, #64]
    }

    release(&kpt_mem.lock);
ffffffff40039eb0:	d0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff40039eb4:	911e6000 	add	x0, x0, #0x798
ffffffff40039eb8:	97ffef7d 	bl	ffffffff40035cac <release>

    // Allocate a PT page if no inital pages is available
    if ((r == NULL) && ((r = kmalloc (PT_ORDER)) == NULL)) {
ffffffff40039ebc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40039ec0:	f100001f 	cmp	x0, #0x0
ffffffff40039ec4:	54000141 	b.ne	ffffffff40039eec <kpt_alloc+0x80>  // b.any
ffffffff40039ec8:	52800140 	mov	w0, #0xa                   	// #10
ffffffff40039ecc:	97ffdce4 	bl	ffffffff4003125c <kmalloc>
ffffffff40039ed0:	f9000fe0 	str	x0, [sp, #24]
ffffffff40039ed4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40039ed8:	f100001f 	cmp	x0, #0x0
ffffffff40039edc:	54000081 	b.ne	ffffffff40039eec <kpt_alloc+0x80>  // b.any
        panic("oom: kpt_alloc");
ffffffff40039ee0:	d0000000 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff40039ee4:	91338000 	add	x0, x0, #0xce0
ffffffff40039ee8:	97ffde78 	bl	ffffffff400318c8 <panic>
    }

    memset(r, 0, PT_SZ);
ffffffff40039eec:	52820002 	mov	w2, #0x1000                	// #4096
ffffffff40039ef0:	52800001 	mov	w1, #0x0                   	// #0
ffffffff40039ef4:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff40039ef8:	97ffd842 	bl	ffffffff40030000 <memset>
    return (char*) r;
ffffffff40039efc:	f9400fe0 	ldr	x0, [sp, #24]
}
ffffffff40039f00:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff40039f04:	d65f03c0 	ret

ffffffff40039f08 <walkpgdir>:

// Return the address of the PTE in page directory that corresponds to
// virtual address va.  If alloc!=0, create any required page table pages.
static pte_t* walkpgdir (pgd_t *pgdbase, const void *va, int alloc)
{
ffffffff40039f08:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
ffffffff40039f0c:	910003fd 	mov	x29, sp
ffffffff40039f10:	f90017e0 	str	x0, [sp, #40]
ffffffff40039f14:	f90013e1 	str	x1, [sp, #32]
ffffffff40039f18:	b9001fe2 	str	w2, [sp, #28]
    pgd_t *pgd;
    pmd_t *pmdbase;
    pmd_t *pmd;
    pte_t *ptebase;

    pgd = &pgdbase[PGD_IDX((uint64)va)];
ffffffff40039f1c:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40039f20:	d35efc00 	lsr	x0, x0, #30
ffffffff40039f24:	92400400 	and	x0, x0, #0x3
ffffffff40039f28:	d37df000 	lsl	x0, x0, #3
ffffffff40039f2c:	f94017e1 	ldr	x1, [sp, #40]
ffffffff40039f30:	8b000020 	add	x0, x1, x0
ffffffff40039f34:	f9001fe0 	str	x0, [sp, #56]

    if(*pgd & (ENTRY_TABLE | ENTRY_VALID)) {
ffffffff40039f38:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40039f3c:	f9400000 	ldr	x0, [x0]
ffffffff40039f40:	92400400 	and	x0, x0, #0x3
ffffffff40039f44:	f100001f 	cmp	x0, #0x0
ffffffff40039f48:	540000e0 	b.eq	ffffffff40039f64 <walkpgdir+0x5c>  // b.none
        pmdbase = (pmd_t*) p2v((*pgd) & PG_ADDR_MASK);
ffffffff40039f4c:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40039f50:	f9400000 	ldr	x0, [x0]
ffffffff40039f54:	92748c00 	and	x0, x0, #0xfffffffff000
ffffffff40039f58:	97ffff7b 	bl	ffffffff40039d44 <p2v>
ffffffff40039f5c:	f90027e0 	str	x0, [sp, #72]
ffffffff40039f60:	14000014 	b	ffffffff40039fb0 <walkpgdir+0xa8>
    } else {
        if (!alloc || (pmdbase = (pmd_t*) kpt_alloc()) == 0) {
ffffffff40039f64:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40039f68:	7100001f 	cmp	w0, #0x0
ffffffff40039f6c:	540000c0 	b.eq	ffffffff40039f84 <walkpgdir+0x7c>  // b.none
ffffffff40039f70:	97ffffbf 	bl	ffffffff40039e6c <kpt_alloc>
ffffffff40039f74:	f90027e0 	str	x0, [sp, #72]
ffffffff40039f78:	f94027e0 	ldr	x0, [sp, #72]
ffffffff40039f7c:	f100001f 	cmp	x0, #0x0
ffffffff40039f80:	54000061 	b.ne	ffffffff40039f8c <walkpgdir+0x84>  // b.any
            return 0;
ffffffff40039f84:	d2800000 	mov	x0, #0x0                   	// #0
ffffffff40039f88:	14000035 	b	ffffffff4003a05c <walkpgdir+0x154>
        }

        memset(pmdbase, 0, PT_SZ);
ffffffff40039f8c:	52820002 	mov	w2, #0x1000                	// #4096
ffffffff40039f90:	52800001 	mov	w1, #0x0                   	// #0
ffffffff40039f94:	f94027e0 	ldr	x0, [sp, #72]
ffffffff40039f98:	97ffd81a 	bl	ffffffff40030000 <memset>

        *pgd = v2p(pmdbase) | ENTRY_TABLE | ENTRY_VALID;
ffffffff40039f9c:	f94027e0 	ldr	x0, [sp, #72]
ffffffff40039fa0:	97ffff62 	bl	ffffffff40039d28 <v2p>
ffffffff40039fa4:	b2400401 	orr	x1, x0, #0x3
ffffffff40039fa8:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff40039fac:	f9000001 	str	x1, [x0]
    }

    pmd = &pmdbase[PMD_IDX(va)];
ffffffff40039fb0:	f94013e0 	ldr	x0, [sp, #32]
ffffffff40039fb4:	d355fc00 	lsr	x0, x0, #21
ffffffff40039fb8:	92402000 	and	x0, x0, #0x1ff
ffffffff40039fbc:	d37df000 	lsl	x0, x0, #3
ffffffff40039fc0:	f94027e1 	ldr	x1, [sp, #72]
ffffffff40039fc4:	8b000020 	add	x0, x1, x0
ffffffff40039fc8:	f9001be0 	str	x0, [sp, #48]

    if (*pmd & (ENTRY_TABLE | ENTRY_VALID)) {
ffffffff40039fcc:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40039fd0:	f9400000 	ldr	x0, [x0]
ffffffff40039fd4:	92400400 	and	x0, x0, #0x3
ffffffff40039fd8:	f100001f 	cmp	x0, #0x0
ffffffff40039fdc:	540000e0 	b.eq	ffffffff40039ff8 <walkpgdir+0xf0>  // b.none
        ptebase = (pte_t*) p2v((*pmd) & PG_ADDR_MASK);
ffffffff40039fe0:	f9401be0 	ldr	x0, [sp, #48]
ffffffff40039fe4:	f9400000 	ldr	x0, [x0]
ffffffff40039fe8:	92748c00 	and	x0, x0, #0xfffffffff000
ffffffff40039fec:	97ffff56 	bl	ffffffff40039d44 <p2v>
ffffffff40039ff0:	f90023e0 	str	x0, [sp, #64]
ffffffff40039ff4:	14000014 	b	ffffffff4003a044 <walkpgdir+0x13c>
    } else {
        if (!alloc || (ptebase = (pte_t*) kpt_alloc()) == 0) {
ffffffff40039ff8:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff40039ffc:	7100001f 	cmp	w0, #0x0
ffffffff4003a000:	540000c0 	b.eq	ffffffff4003a018 <walkpgdir+0x110>  // b.none
ffffffff4003a004:	97ffff9a 	bl	ffffffff40039e6c <kpt_alloc>
ffffffff4003a008:	f90023e0 	str	x0, [sp, #64]
ffffffff4003a00c:	f94023e0 	ldr	x0, [sp, #64]
ffffffff4003a010:	f100001f 	cmp	x0, #0x0
ffffffff4003a014:	54000061 	b.ne	ffffffff4003a020 <walkpgdir+0x118>  // b.any
           return 0;
ffffffff4003a018:	d2800000 	mov	x0, #0x0                   	// #0
ffffffff4003a01c:	14000010 	b	ffffffff4003a05c <walkpgdir+0x154>
        }

        // Make sure all those PTE_P bits are zero.
        memset(ptebase, 0, PT_SZ);
ffffffff4003a020:	52820002 	mov	w2, #0x1000                	// #4096
ffffffff4003a024:	52800001 	mov	w1, #0x0                   	// #0
ffffffff4003a028:	f94023e0 	ldr	x0, [sp, #64]
ffffffff4003a02c:	97ffd7f5 	bl	ffffffff40030000 <memset>

        // The permissions here are overly generous, but they can
        // be further restricted by the permissions in the page table
        // entries, if necessary.
        *pmd = v2p(ptebase) | ENTRY_TABLE | ENTRY_VALID;
ffffffff4003a030:	f94023e0 	ldr	x0, [sp, #64]
ffffffff4003a034:	97ffff3d 	bl	ffffffff40039d28 <v2p>
ffffffff4003a038:	b2400401 	orr	x1, x0, #0x3
ffffffff4003a03c:	f9401be0 	ldr	x0, [sp, #48]
ffffffff4003a040:	f9000001 	str	x1, [x0]
    }

    return &ptebase[PTE_IDX(va)];
ffffffff4003a044:	f94013e0 	ldr	x0, [sp, #32]
ffffffff4003a048:	d34cfc00 	lsr	x0, x0, #12
ffffffff4003a04c:	92402000 	and	x0, x0, #0x1ff
ffffffff4003a050:	d37df000 	lsl	x0, x0, #3
ffffffff4003a054:	f94023e1 	ldr	x1, [sp, #64]
ffffffff4003a058:	8b000020 	add	x0, x1, x0
}
ffffffff4003a05c:	a8c57bfd 	ldp	x29, x30, [sp], #80
ffffffff4003a060:	d65f03c0 	ret

ffffffff4003a064 <mappages>:

// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int mappages (pgd_t *pgdir, void *va, uint size, uint pa, uint64 ap)
{
ffffffff4003a064:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
ffffffff4003a068:	910003fd 	mov	x29, sp
ffffffff4003a06c:	f90017e0 	str	x0, [sp, #40]
ffffffff4003a070:	f90013e1 	str	x1, [sp, #32]
ffffffff4003a074:	b9001fe2 	str	w2, [sp, #28]
ffffffff4003a078:	b9001be3 	str	w3, [sp, #24]
ffffffff4003a07c:	f9000be4 	str	x4, [sp, #16]
    char *a, *last;
    pte_t *pte;

    a = (char*) align_dn(va, PTE_SZ);
ffffffff4003a080:	f94013e0 	ldr	x0, [sp, #32]
ffffffff4003a084:	9274cc00 	and	x0, x0, #0xfffffffffffff000
ffffffff4003a088:	f90027e0 	str	x0, [sp, #72]
    last = (char*) align_dn((uint64)va + size - 1, PTE_SZ);
ffffffff4003a08c:	b9401fe1 	ldr	w1, [sp, #28]
ffffffff4003a090:	f94013e0 	ldr	x0, [sp, #32]
ffffffff4003a094:	8b000020 	add	x0, x1, x0
ffffffff4003a098:	d1000400 	sub	x0, x0, #0x1
ffffffff4003a09c:	9274cc00 	and	x0, x0, #0xfffffffffffff000
ffffffff4003a0a0:	f90023e0 	str	x0, [sp, #64]

    for (;;) {
        if ((pte = walkpgdir(pgdir, a, 1)) == 0) {
ffffffff4003a0a4:	52800022 	mov	w2, #0x1                   	// #1
ffffffff4003a0a8:	f94027e1 	ldr	x1, [sp, #72]
ffffffff4003a0ac:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003a0b0:	97ffff96 	bl	ffffffff40039f08 <walkpgdir>
ffffffff4003a0b4:	f9001fe0 	str	x0, [sp, #56]
ffffffff4003a0b8:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003a0bc:	f100001f 	cmp	x0, #0x0
ffffffff4003a0c0:	54000061 	b.ne	ffffffff4003a0cc <mappages+0x68>  // b.any
            return -1;
ffffffff4003a0c4:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff4003a0c8:	1400001f 	b	ffffffff4003a144 <mappages+0xe0>
        }

        if (*pte & (ENTRY_PAGE | ENTRY_VALID)) {
ffffffff4003a0cc:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003a0d0:	f9400000 	ldr	x0, [x0]
ffffffff4003a0d4:	92400400 	and	x0, x0, #0x3
ffffffff4003a0d8:	f100001f 	cmp	x0, #0x0
ffffffff4003a0dc:	54000080 	b.eq	ffffffff4003a0ec <mappages+0x88>  // b.none
            panic("remap");
ffffffff4003a0e0:	b0000000 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003a0e4:	9133c000 	add	x0, x0, #0xcf0
ffffffff4003a0e8:	97ffddf8 	bl	ffffffff400318c8 <panic>
        }

        *pte = pa | ACCESS_FLAG | SH_IN_SH | ap | NON_SECURE_PA | MEM_ATTR_IDX_4 | ENTRY_PAGE | ENTRY_VALID;
ffffffff4003a0ec:	b9401be0 	ldr	w0, [sp, #24]
ffffffff4003a0f0:	32180800 	orr	w0, w0, #0x700
ffffffff4003a0f4:	2a0003e1 	mov	w1, w0
ffffffff4003a0f8:	f9400be0 	ldr	x0, [sp, #16]
ffffffff4003a0fc:	aa000021 	orr	x1, x1, x0
ffffffff4003a100:	d2800660 	mov	x0, #0x33                  	// #51
ffffffff4003a104:	aa000021 	orr	x1, x1, x0
ffffffff4003a108:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003a10c:	f9000001 	str	x1, [x0]

        if (a == last) {
ffffffff4003a110:	f94027e1 	ldr	x1, [sp, #72]
ffffffff4003a114:	f94023e0 	ldr	x0, [sp, #64]
ffffffff4003a118:	eb00003f 	cmp	x1, x0
ffffffff4003a11c:	54000100 	b.eq	ffffffff4003a13c <mappages+0xd8>  // b.none
            break;
        }

        a += PTE_SZ;
ffffffff4003a120:	f94027e0 	ldr	x0, [sp, #72]
ffffffff4003a124:	91400400 	add	x0, x0, #0x1, lsl #12
ffffffff4003a128:	f90027e0 	str	x0, [sp, #72]
        pa += PTE_SZ;
ffffffff4003a12c:	b9401be0 	ldr	w0, [sp, #24]
ffffffff4003a130:	11400400 	add	w0, w0, #0x1, lsl #12
ffffffff4003a134:	b9001be0 	str	w0, [sp, #24]
        if ((pte = walkpgdir(pgdir, a, 1)) == 0) {
ffffffff4003a138:	17ffffdb 	b	ffffffff4003a0a4 <mappages+0x40>
            break;
ffffffff4003a13c:	d503201f 	nop
    }
    return 0;
ffffffff4003a140:	52800000 	mov	w0, #0x0                   	// #0
}
ffffffff4003a144:	a8c57bfd 	ldp	x29, x30, [sp], #80
ffffffff4003a148:	d65f03c0 	ret

ffffffff4003a14c <flush_tlb>:

// flush all TLB
static void flush_tlb (void)
{
    asm("TLBI VMALLE1" : : :);
ffffffff4003a14c:	d508871f 	tlbi	vmalle1
}
ffffffff4003a150:	d503201f 	nop
ffffffff4003a154:	d65f03c0 	ret

ffffffff4003a158 <switchuvm>:

// Switch to the user page table (TTBR0)
void switchuvm (struct proc *p)
{
ffffffff4003a158:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff4003a15c:	910003fd 	mov	x29, sp
ffffffff4003a160:	f9000fe0 	str	x0, [sp, #24]
    uint64 val64;

    pushcli();
ffffffff4003a164:	97ffd8e5 	bl	ffffffff400304f8 <pushcli>

    if (p->pgdir == 0) {
ffffffff4003a168:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003a16c:	f9400400 	ldr	x0, [x0, #8]
ffffffff4003a170:	f100001f 	cmp	x0, #0x0
ffffffff4003a174:	54000081 	b.ne	ffffffff4003a184 <switchuvm+0x2c>  // b.any
        panic("switchuvm: no pgdir");
ffffffff4003a178:	b0000000 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003a17c:	9133e000 	add	x0, x0, #0xcf8
ffffffff4003a180:	97ffddd2 	bl	ffffffff400318c8 <panic>
    }

    val64 = (uint64) V2P(p->pgdir) | 0x00;
ffffffff4003a184:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003a188:	f9400400 	ldr	x0, [x0, #8]
ffffffff4003a18c:	aa0003e1 	mov	x1, x0
ffffffff4003a190:	d2c00020 	mov	x0, #0x100000000           	// #4294967296
ffffffff4003a194:	8b000020 	add	x0, x1, x0
ffffffff4003a198:	f90017e0 	str	x0, [sp, #40]

    asm("MSR TTBR0_EL1, %[v]": :[v]"r" (val64):);
ffffffff4003a19c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003a1a0:	d5182000 	msr	ttbr0_el1, x0
    flush_tlb();
ffffffff4003a1a4:	97ffffea 	bl	ffffffff4003a14c <flush_tlb>

    popcli();
ffffffff4003a1a8:	97ffd8e9 	bl	ffffffff4003054c <popcli>
}
ffffffff4003a1ac:	d503201f 	nop
ffffffff4003a1b0:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff4003a1b4:	d65f03c0 	ret

ffffffff4003a1b8 <inituvm>:

// Load the initcode into address 0 of pgdir. sz must be less than a page.
void inituvm (pgd_t *pgdir, char *init, uint sz)
{
ffffffff4003a1b8:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff4003a1bc:	910003fd 	mov	x29, sp
ffffffff4003a1c0:	f90017e0 	str	x0, [sp, #40]
ffffffff4003a1c4:	f90013e1 	str	x1, [sp, #32]
ffffffff4003a1c8:	b9001fe2 	str	w2, [sp, #28]
    char *mem;

    if (sz >= PTE_SZ) {
ffffffff4003a1cc:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003a1d0:	713ffc1f 	cmp	w0, #0xfff
ffffffff4003a1d4:	54000089 	b.ls	ffffffff4003a1e4 <inituvm+0x2c>  // b.plast
        panic("inituvm: more than a page");
ffffffff4003a1d8:	b0000000 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003a1dc:	91344000 	add	x0, x0, #0xd10
ffffffff4003a1e0:	97ffddba 	bl	ffffffff400318c8 <panic>
    }

    mem = alloc_page();
ffffffff4003a1e4:	97ffdc9a 	bl	ffffffff4003144c <alloc_page>
ffffffff4003a1e8:	f9001fe0 	str	x0, [sp, #56]
    memset(mem, 0, PTE_SZ);
ffffffff4003a1ec:	52820002 	mov	w2, #0x1000                	// #4096
ffffffff4003a1f0:	52800001 	mov	w1, #0x0                   	// #0
ffffffff4003a1f4:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003a1f8:	97ffd782 	bl	ffffffff40030000 <memset>
    mappages(pgdir, 0, PTE_SZ, v2p(mem), AP_RW_1_0);
ffffffff4003a1fc:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003a200:	97fffeca 	bl	ffffffff40039d28 <v2p>
ffffffff4003a204:	d2800804 	mov	x4, #0x40                  	// #64
ffffffff4003a208:	2a0003e3 	mov	w3, w0
ffffffff4003a20c:	52820002 	mov	w2, #0x1000                	// #4096
ffffffff4003a210:	d2800001 	mov	x1, #0x0                   	// #0
ffffffff4003a214:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003a218:	97ffff93 	bl	ffffffff4003a064 <mappages>
    memmove(mem, init, sz);
ffffffff4003a21c:	b9401fe2 	ldr	w2, [sp, #28]
ffffffff4003a220:	f94013e1 	ldr	x1, [sp, #32]
ffffffff4003a224:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003a228:	97ffd7e0 	bl	ffffffff400301a8 <memmove>
}
ffffffff4003a22c:	d503201f 	nop
ffffffff4003a230:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff4003a234:	d65f03c0 	ret

ffffffff4003a238 <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int loaduvm (pgd_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
ffffffff4003a238:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
ffffffff4003a23c:	910003fd 	mov	x29, sp
ffffffff4003a240:	f90017e0 	str	x0, [sp, #40]
ffffffff4003a244:	f90013e1 	str	x1, [sp, #32]
ffffffff4003a248:	f9000fe2 	str	x2, [sp, #24]
ffffffff4003a24c:	b90017e3 	str	w3, [sp, #20]
ffffffff4003a250:	b90013e4 	str	w4, [sp, #16]
    uint i, pa, n;
    pte_t *pte;

    if ((uint64) addr % PTE_SZ != 0) {
ffffffff4003a254:	f94013e0 	ldr	x0, [sp, #32]
ffffffff4003a258:	92402c00 	and	x0, x0, #0xfff
ffffffff4003a25c:	f100001f 	cmp	x0, #0x0
ffffffff4003a260:	54000080 	b.eq	ffffffff4003a270 <loaduvm+0x38>  // b.none
        panic("loaduvm: addr must be page aligned");
ffffffff4003a264:	b0000000 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003a268:	9134c000 	add	x0, x0, #0xd30
ffffffff4003a26c:	97ffdd97 	bl	ffffffff400318c8 <panic>
    }

    for (i = 0; i < sz; i += PTE_SZ) {
ffffffff4003a270:	b9004fff 	str	wzr, [sp, #76]
ffffffff4003a274:	14000033 	b	ffffffff4003a340 <loaduvm+0x108>
        if ((pte = walkpgdir(pgdir, addr + i, 0)) == 0) {
ffffffff4003a278:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff4003a27c:	f94013e1 	ldr	x1, [sp, #32]
ffffffff4003a280:	8b000020 	add	x0, x1, x0
ffffffff4003a284:	52800002 	mov	w2, #0x0                   	// #0
ffffffff4003a288:	aa0003e1 	mov	x1, x0
ffffffff4003a28c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003a290:	97ffff1e 	bl	ffffffff40039f08 <walkpgdir>
ffffffff4003a294:	f90023e0 	str	x0, [sp, #64]
ffffffff4003a298:	f94023e0 	ldr	x0, [sp, #64]
ffffffff4003a29c:	f100001f 	cmp	x0, #0x0
ffffffff4003a2a0:	54000081 	b.ne	ffffffff4003a2b0 <loaduvm+0x78>  // b.any
            panic("loaduvm: address should exist");
ffffffff4003a2a4:	b0000000 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003a2a8:	91356000 	add	x0, x0, #0xd58
ffffffff4003a2ac:	97ffdd87 	bl	ffffffff400318c8 <panic>
        }

        pa = PTE_ADDR(*pte);
ffffffff4003a2b0:	f94023e0 	ldr	x0, [sp, #64]
ffffffff4003a2b4:	f9400000 	ldr	x0, [x0]
ffffffff4003a2b8:	12144c00 	and	w0, w0, #0xfffff000
ffffffff4003a2bc:	b9003fe0 	str	w0, [sp, #60]

        if (sz - i < PTE_SZ) {
ffffffff4003a2c0:	b94013e1 	ldr	w1, [sp, #16]
ffffffff4003a2c4:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff4003a2c8:	4b000020 	sub	w0, w1, w0
ffffffff4003a2cc:	713ffc1f 	cmp	w0, #0xfff
ffffffff4003a2d0:	540000c8 	b.hi	ffffffff4003a2e8 <loaduvm+0xb0>  // b.pmore
            n = sz - i;
ffffffff4003a2d4:	b94013e1 	ldr	w1, [sp, #16]
ffffffff4003a2d8:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff4003a2dc:	4b000020 	sub	w0, w1, w0
ffffffff4003a2e0:	b9004be0 	str	w0, [sp, #72]
ffffffff4003a2e4:	14000003 	b	ffffffff4003a2f0 <loaduvm+0xb8>
        } else {
            n = PTE_SZ;
ffffffff4003a2e8:	52820000 	mov	w0, #0x1000                	// #4096
ffffffff4003a2ec:	b9004be0 	str	w0, [sp, #72]
        }

        if (readi(ip, p2v(pa), offset + i, n) != n) {
ffffffff4003a2f0:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff4003a2f4:	97fffe94 	bl	ffffffff40039d44 <p2v>
ffffffff4003a2f8:	aa0003e4 	mov	x4, x0
ffffffff4003a2fc:	b94017e1 	ldr	w1, [sp, #20]
ffffffff4003a300:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff4003a304:	0b000020 	add	w0, w1, w0
ffffffff4003a308:	b9404be3 	ldr	w3, [sp, #72]
ffffffff4003a30c:	2a0003e2 	mov	w2, w0
ffffffff4003a310:	aa0403e1 	mov	x1, x4
ffffffff4003a314:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003a318:	97ffe49c 	bl	ffffffff40033588 <readi>
ffffffff4003a31c:	2a0003e1 	mov	w1, w0
ffffffff4003a320:	b9404be0 	ldr	w0, [sp, #72]
ffffffff4003a324:	6b01001f 	cmp	w0, w1
ffffffff4003a328:	54000060 	b.eq	ffffffff4003a334 <loaduvm+0xfc>  // b.none
            return -1;
ffffffff4003a32c:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff4003a330:	14000009 	b	ffffffff4003a354 <loaduvm+0x11c>
    for (i = 0; i < sz; i += PTE_SZ) {
ffffffff4003a334:	b9404fe0 	ldr	w0, [sp, #76]
ffffffff4003a338:	11400400 	add	w0, w0, #0x1, lsl #12
ffffffff4003a33c:	b9004fe0 	str	w0, [sp, #76]
ffffffff4003a340:	b9404fe1 	ldr	w1, [sp, #76]
ffffffff4003a344:	b94013e0 	ldr	w0, [sp, #16]
ffffffff4003a348:	6b00003f 	cmp	w1, w0
ffffffff4003a34c:	54fff963 	b.cc	ffffffff4003a278 <loaduvm+0x40>  // b.lo, b.ul, b.last
        }
    }

    return 0;
ffffffff4003a350:	52800000 	mov	w0, #0x0                   	// #0
}
ffffffff4003a354:	a8c57bfd 	ldp	x29, x30, [sp], #80
ffffffff4003a358:	d65f03c0 	ret

ffffffff4003a35c <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int allocuvm (pgd_t *pgdir, uint oldsz, uint newsz)
{
ffffffff4003a35c:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff4003a360:	910003fd 	mov	x29, sp
ffffffff4003a364:	f9000bf3 	str	x19, [sp, #16]
ffffffff4003a368:	f90017e0 	str	x0, [sp, #40]
ffffffff4003a36c:	b90027e1 	str	w1, [sp, #36]
ffffffff4003a370:	b90023e2 	str	w2, [sp, #32]
    char *mem;
    uint64 a;

    if (newsz >= UADDR_SZ) {
ffffffff4003a374:	b94023e1 	ldr	w1, [sp, #32]
ffffffff4003a378:	12be0000 	mov	w0, #0xfffffff             	// #268435455
ffffffff4003a37c:	6b00003f 	cmp	w1, w0
ffffffff4003a380:	54000069 	b.ls	ffffffff4003a38c <allocuvm+0x30>  // b.plast
        return 0;
ffffffff4003a384:	52800000 	mov	w0, #0x0                   	// #0
ffffffff4003a388:	1400002f 	b	ffffffff4003a444 <allocuvm+0xe8>
    }

    if (newsz < oldsz) {
ffffffff4003a38c:	b94023e1 	ldr	w1, [sp, #32]
ffffffff4003a390:	b94027e0 	ldr	w0, [sp, #36]
ffffffff4003a394:	6b00003f 	cmp	w1, w0
ffffffff4003a398:	54000062 	b.cs	ffffffff4003a3a4 <allocuvm+0x48>  // b.hs, b.nlast
        return oldsz;
ffffffff4003a39c:	b94027e0 	ldr	w0, [sp, #36]
ffffffff4003a3a0:	14000029 	b	ffffffff4003a444 <allocuvm+0xe8>
    }

    a = align_up(oldsz, PTE_SZ);
ffffffff4003a3a4:	b94027e0 	ldr	w0, [sp, #36]
ffffffff4003a3a8:	913ffc00 	add	x0, x0, #0xfff
ffffffff4003a3ac:	9274cc00 	and	x0, x0, #0xfffffffffffff000
ffffffff4003a3b0:	f9001fe0 	str	x0, [sp, #56]

    for (; a < newsz; a += PTE_SZ) {
ffffffff4003a3b4:	1400001f 	b	ffffffff4003a430 <allocuvm+0xd4>
        mem = alloc_page();
ffffffff4003a3b8:	97ffdc25 	bl	ffffffff4003144c <alloc_page>
ffffffff4003a3bc:	f9001be0 	str	x0, [sp, #48]

        if (mem == 0) {
ffffffff4003a3c0:	f9401be0 	ldr	x0, [sp, #48]
ffffffff4003a3c4:	f100001f 	cmp	x0, #0x0
ffffffff4003a3c8:	54000141 	b.ne	ffffffff4003a3f0 <allocuvm+0x94>  // b.any
            cprintf("allocuvm out of memory\n");
ffffffff4003a3cc:	b0000000 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003a3d0:	9135e000 	add	x0, x0, #0xd78
ffffffff4003a3d4:	97ffdca8 	bl	ffffffff40031674 <cprintf>
            deallocuvm(pgdir, newsz, oldsz);
ffffffff4003a3d8:	b94027e2 	ldr	w2, [sp, #36]
ffffffff4003a3dc:	b94023e1 	ldr	w1, [sp, #32]
ffffffff4003a3e0:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003a3e4:	9400001b 	bl	ffffffff4003a450 <deallocuvm>
            return 0;
ffffffff4003a3e8:	52800000 	mov	w0, #0x0                   	// #0
ffffffff4003a3ec:	14000016 	b	ffffffff4003a444 <allocuvm+0xe8>
        }

        memset(mem, 0, PTE_SZ);
ffffffff4003a3f0:	52820002 	mov	w2, #0x1000                	// #4096
ffffffff4003a3f4:	52800001 	mov	w1, #0x0                   	// #0
ffffffff4003a3f8:	f9401be0 	ldr	x0, [sp, #48]
ffffffff4003a3fc:	97ffd701 	bl	ffffffff40030000 <memset>
        mappages(pgdir, (char*) a, PTE_SZ, v2p(mem), AP_RW_1_0);
ffffffff4003a400:	f9401ff3 	ldr	x19, [sp, #56]
ffffffff4003a404:	f9401be0 	ldr	x0, [sp, #48]
ffffffff4003a408:	97fffe48 	bl	ffffffff40039d28 <v2p>
ffffffff4003a40c:	d2800804 	mov	x4, #0x40                  	// #64
ffffffff4003a410:	2a0003e3 	mov	w3, w0
ffffffff4003a414:	52820002 	mov	w2, #0x1000                	// #4096
ffffffff4003a418:	aa1303e1 	mov	x1, x19
ffffffff4003a41c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003a420:	97ffff11 	bl	ffffffff4003a064 <mappages>
    for (; a < newsz; a += PTE_SZ) {
ffffffff4003a424:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003a428:	91400400 	add	x0, x0, #0x1, lsl #12
ffffffff4003a42c:	f9001fe0 	str	x0, [sp, #56]
ffffffff4003a430:	b94023e0 	ldr	w0, [sp, #32]
ffffffff4003a434:	f9401fe1 	ldr	x1, [sp, #56]
ffffffff4003a438:	eb00003f 	cmp	x1, x0
ffffffff4003a43c:	54fffbe3 	b.cc	ffffffff4003a3b8 <allocuvm+0x5c>  // b.lo, b.ul, b.last
    }

    return newsz;
ffffffff4003a440:	b94023e0 	ldr	w0, [sp, #32]
}
ffffffff4003a444:	f9400bf3 	ldr	x19, [sp, #16]
ffffffff4003a448:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff4003a44c:	d65f03c0 	ret

ffffffff4003a450 <deallocuvm>:
// Deallocate user pages to bring the process size from oldsz to
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int deallocuvm (pgd_t *pgdir, uint oldsz, uint newsz)
{
ffffffff4003a450:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff4003a454:	910003fd 	mov	x29, sp
ffffffff4003a458:	f9000fe0 	str	x0, [sp, #24]
ffffffff4003a45c:	b90017e1 	str	w1, [sp, #20]
ffffffff4003a460:	b90013e2 	str	w2, [sp, #16]
    pte_t *pte;
    uint64 a;
    uint pa;

    if (newsz >= oldsz) {
ffffffff4003a464:	b94013e1 	ldr	w1, [sp, #16]
ffffffff4003a468:	b94017e0 	ldr	w0, [sp, #20]
ffffffff4003a46c:	6b00003f 	cmp	w1, w0
ffffffff4003a470:	54000063 	b.cc	ffffffff4003a47c <deallocuvm+0x2c>  // b.lo, b.ul, b.last
        return oldsz;
ffffffff4003a474:	b94017e0 	ldr	w0, [sp, #20]
ffffffff4003a478:	14000031 	b	ffffffff4003a53c <deallocuvm+0xec>
    }

    for (a = align_up(newsz, PTE_SZ); a < oldsz; a += PTE_SZ) {
ffffffff4003a47c:	b94013e0 	ldr	w0, [sp, #16]
ffffffff4003a480:	913ffc00 	add	x0, x0, #0xfff
ffffffff4003a484:	9274cc00 	and	x0, x0, #0xfffffffffffff000
ffffffff4003a488:	f9001fe0 	str	x0, [sp, #56]
ffffffff4003a48c:	14000027 	b	ffffffff4003a528 <deallocuvm+0xd8>
        pte = walkpgdir(pgdir, (char*) a, 0);
ffffffff4003a490:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003a494:	52800002 	mov	w2, #0x0                   	// #0
ffffffff4003a498:	aa0003e1 	mov	x1, x0
ffffffff4003a49c:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003a4a0:	97fffe9a 	bl	ffffffff40039f08 <walkpgdir>
ffffffff4003a4a4:	f9001be0 	str	x0, [sp, #48]

        if (!pte) {
ffffffff4003a4a8:	f9401be0 	ldr	x0, [sp, #48]
ffffffff4003a4ac:	f100001f 	cmp	x0, #0x0
ffffffff4003a4b0:	540000e1 	b.ne	ffffffff4003a4cc <deallocuvm+0x7c>  // b.any
            // pte == 0 --> no page table for this entry
            // round it up to the next page directory
            a = align_up (a, PMD_SZ);
ffffffff4003a4b4:	f9401fe1 	ldr	x1, [sp, #56]
ffffffff4003a4b8:	b24053e0 	mov	x0, #0x1fffff              	// #2097151
ffffffff4003a4bc:	8b000020 	add	x0, x1, x0
ffffffff4003a4c0:	926ba800 	and	x0, x0, #0xffffffffffe00000
ffffffff4003a4c4:	f9001fe0 	str	x0, [sp, #56]
ffffffff4003a4c8:	14000015 	b	ffffffff4003a51c <deallocuvm+0xcc>

        } else if ((*pte & (ENTRY_PAGE | ENTRY_VALID)) != 0) {
ffffffff4003a4cc:	f9401be0 	ldr	x0, [sp, #48]
ffffffff4003a4d0:	f9400000 	ldr	x0, [x0]
ffffffff4003a4d4:	92400400 	and	x0, x0, #0x3
ffffffff4003a4d8:	f100001f 	cmp	x0, #0x0
ffffffff4003a4dc:	54000200 	b.eq	ffffffff4003a51c <deallocuvm+0xcc>  // b.none
            pa = PTE_ADDR(*pte);
ffffffff4003a4e0:	f9401be0 	ldr	x0, [sp, #48]
ffffffff4003a4e4:	f9400000 	ldr	x0, [x0]
ffffffff4003a4e8:	12144c00 	and	w0, w0, #0xfffff000
ffffffff4003a4ec:	b9002fe0 	str	w0, [sp, #44]

            if (pa == 0) {
ffffffff4003a4f0:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff4003a4f4:	7100001f 	cmp	w0, #0x0
ffffffff4003a4f8:	54000081 	b.ne	ffffffff4003a508 <deallocuvm+0xb8>  // b.any
                panic("deallocuvm");
ffffffff4003a4fc:	b0000000 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003a500:	91364000 	add	x0, x0, #0xd90
ffffffff4003a504:	97ffdcf1 	bl	ffffffff400318c8 <panic>
            }

            free_page(p2v(pa));
ffffffff4003a508:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff4003a50c:	97fffe0e 	bl	ffffffff40039d44 <p2v>
ffffffff4003a510:	97ffdbc6 	bl	ffffffff40031428 <free_page>
            *pte = 0;
ffffffff4003a514:	f9401be0 	ldr	x0, [sp, #48]
ffffffff4003a518:	f900001f 	str	xzr, [x0]
    for (a = align_up(newsz, PTE_SZ); a < oldsz; a += PTE_SZ) {
ffffffff4003a51c:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003a520:	91400400 	add	x0, x0, #0x1, lsl #12
ffffffff4003a524:	f9001fe0 	str	x0, [sp, #56]
ffffffff4003a528:	b94017e0 	ldr	w0, [sp, #20]
ffffffff4003a52c:	f9401fe1 	ldr	x1, [sp, #56]
ffffffff4003a530:	eb00003f 	cmp	x1, x0
ffffffff4003a534:	54fffae3 	b.cc	ffffffff4003a490 <deallocuvm+0x40>  // b.lo, b.ul, b.last
        }
    }

    return newsz;
ffffffff4003a538:	b94013e0 	ldr	w0, [sp, #16]
}
ffffffff4003a53c:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff4003a540:	d65f03c0 	ret

ffffffff4003a544 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void freevm (pgd_t *pgdir)
{
ffffffff4003a544:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff4003a548:	910003fd 	mov	x29, sp
ffffffff4003a54c:	f9000fe0 	str	x0, [sp, #24]
    uint i,j;
    char *v;
    pmd_t *pmdbase;

    if (pgdir == 0) {
ffffffff4003a550:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003a554:	f100001f 	cmp	x0, #0x0
ffffffff4003a558:	54000081 	b.ne	ffffffff4003a568 <freevm+0x24>  // b.any
        panic("freevm: no pgdir");
ffffffff4003a55c:	b0000000 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003a560:	91368000 	add	x0, x0, #0xda0
ffffffff4003a564:	97ffdcd9 	bl	ffffffff400318c8 <panic>
    }

    // release the user space memroy, but not page tables
    deallocuvm(pgdir, UADDR_SZ, 0);
ffffffff4003a568:	52800002 	mov	w2, #0x0                   	// #0
ffffffff4003a56c:	52a20001 	mov	w1, #0x10000000            	// #268435456
ffffffff4003a570:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003a574:	97ffffb7 	bl	ffffffff4003a450 <deallocuvm>

    // release the page tables
    for(j = 0; j < PTRS_PER_PGD; j++) {
ffffffff4003a578:	b9003bff 	str	wzr, [sp, #56]
ffffffff4003a57c:	14000030 	b	ffffffff4003a63c <freevm+0xf8>
        if(pgdir[j] & (ENTRY_TABLE | ENTRY_VALID)) {
ffffffff4003a580:	b9403be0 	ldr	w0, [sp, #56]
ffffffff4003a584:	d37df000 	lsl	x0, x0, #3
ffffffff4003a588:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff4003a58c:	8b000020 	add	x0, x1, x0
ffffffff4003a590:	f9400000 	ldr	x0, [x0]
ffffffff4003a594:	92400400 	and	x0, x0, #0x3
ffffffff4003a598:	f100001f 	cmp	x0, #0x0
ffffffff4003a59c:	540004a0 	b.eq	ffffffff4003a630 <freevm+0xec>  // b.none
            pmdbase = (pmd_t*) p2v(pgdir[j] & PG_ADDR_MASK);
ffffffff4003a5a0:	b9403be0 	ldr	w0, [sp, #56]
ffffffff4003a5a4:	d37df000 	lsl	x0, x0, #3
ffffffff4003a5a8:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff4003a5ac:	8b000020 	add	x0, x1, x0
ffffffff4003a5b0:	f9400000 	ldr	x0, [x0]
ffffffff4003a5b4:	92748c00 	and	x0, x0, #0xfffffffff000
ffffffff4003a5b8:	97fffde3 	bl	ffffffff40039d44 <p2v>
ffffffff4003a5bc:	f9001be0 	str	x0, [sp, #48]

            for (i = 0; i < PTRS_PER_PMD; i++) {
ffffffff4003a5c0:	b9003fff 	str	wzr, [sp, #60]
ffffffff4003a5c4:	14000016 	b	ffffffff4003a61c <freevm+0xd8>
                if (pmdbase[i] & (ENTRY_TABLE | ENTRY_VALID)) {
ffffffff4003a5c8:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff4003a5cc:	d37df000 	lsl	x0, x0, #3
ffffffff4003a5d0:	f9401be1 	ldr	x1, [sp, #48]
ffffffff4003a5d4:	8b000020 	add	x0, x1, x0
ffffffff4003a5d8:	f9400000 	ldr	x0, [x0]
ffffffff4003a5dc:	92400400 	and	x0, x0, #0x3
ffffffff4003a5e0:	f100001f 	cmp	x0, #0x0
ffffffff4003a5e4:	54000160 	b.eq	ffffffff4003a610 <freevm+0xcc>  // b.none
                    v = p2v(PT_ADDR(pmdbase[i]));
ffffffff4003a5e8:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff4003a5ec:	d37df000 	lsl	x0, x0, #3
ffffffff4003a5f0:	f9401be1 	ldr	x1, [sp, #48]
ffffffff4003a5f4:	8b000020 	add	x0, x1, x0
ffffffff4003a5f8:	f9400000 	ldr	x0, [x0]
ffffffff4003a5fc:	9274cc00 	and	x0, x0, #0xfffffffffffff000
ffffffff4003a600:	97fffdd1 	bl	ffffffff40039d44 <p2v>
ffffffff4003a604:	f90017e0 	str	x0, [sp, #40]
                    kpt_free(v);
ffffffff4003a608:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003a60c:	97fffdf2 	bl	ffffffff40039dd4 <kpt_free>
            for (i = 0; i < PTRS_PER_PMD; i++) {
ffffffff4003a610:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff4003a614:	11000400 	add	w0, w0, #0x1
ffffffff4003a618:	b9003fe0 	str	w0, [sp, #60]
ffffffff4003a61c:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff4003a620:	7107fc1f 	cmp	w0, #0x1ff
ffffffff4003a624:	54fffd29 	b.ls	ffffffff4003a5c8 <freevm+0x84>  // b.plast
                }
            }
            kpt_free((char*) pmdbase);
ffffffff4003a628:	f9401be0 	ldr	x0, [sp, #48]
ffffffff4003a62c:	97fffdea 	bl	ffffffff40039dd4 <kpt_free>
    for(j = 0; j < PTRS_PER_PGD; j++) {
ffffffff4003a630:	b9403be0 	ldr	w0, [sp, #56]
ffffffff4003a634:	11000400 	add	w0, w0, #0x1
ffffffff4003a638:	b9003be0 	str	w0, [sp, #56]
ffffffff4003a63c:	b9403be0 	ldr	w0, [sp, #56]
ffffffff4003a640:	71000c1f 	cmp	w0, #0x3
ffffffff4003a644:	54fff9e9 	b.ls	ffffffff4003a580 <freevm+0x3c>  // b.plast
        }
    }

    kpt_free((char*) pgdir);
ffffffff4003a648:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003a64c:	97fffde2 	bl	ffffffff40039dd4 <kpt_free>
}
ffffffff4003a650:	d503201f 	nop
ffffffff4003a654:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff4003a658:	d65f03c0 	ret

ffffffff4003a65c <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible page beneath
// the user stack (to trap stack underflow).
void clearpteu (pgd_t *pgdir, char *uva)
{
ffffffff4003a65c:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff4003a660:	910003fd 	mov	x29, sp
ffffffff4003a664:	f9000fe0 	str	x0, [sp, #24]
ffffffff4003a668:	f9000be1 	str	x1, [sp, #16]
    pte_t *pte;

    pte = walkpgdir(pgdir, uva, 0);
ffffffff4003a66c:	52800002 	mov	w2, #0x0                   	// #0
ffffffff4003a670:	f9400be1 	ldr	x1, [sp, #16]
ffffffff4003a674:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003a678:	97fffe24 	bl	ffffffff40039f08 <walkpgdir>
ffffffff4003a67c:	f90017e0 	str	x0, [sp, #40]
    if (pte == 0) {
ffffffff4003a680:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003a684:	f100001f 	cmp	x0, #0x0
ffffffff4003a688:	54000081 	b.ne	ffffffff4003a698 <clearpteu+0x3c>  // b.any
        panic("clearpteu");
ffffffff4003a68c:	b0000000 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003a690:	9136e000 	add	x0, x0, #0xdb8
ffffffff4003a694:	97ffdc8d 	bl	ffffffff400318c8 <panic>
    }

    // in ARM, we change the AP field (ap & 0x3) << 4)
    *pte = (*pte & ~(0x03 << 6)) | AP_RW_1;
ffffffff4003a698:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003a69c:	f9400000 	ldr	x0, [x0]
ffffffff4003a6a0:	9278f401 	and	x1, x0, #0xffffffffffffff3f
ffffffff4003a6a4:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003a6a8:	f9000001 	str	x1, [x0]
}
ffffffff4003a6ac:	d503201f 	nop
ffffffff4003a6b0:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff4003a6b4:	d65f03c0 	ret

ffffffff4003a6b8 <copyuvm>:
// of it for a child.|



pgd_t* copyuvm (pgd_t *pgdir, uint sz)
{
ffffffff4003a6b8:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
ffffffff4003a6bc:	910003fd 	mov	x29, sp
ffffffff4003a6c0:	f9000fe0 	str	x0, [sp, #24]
ffffffff4003a6c4:	b90017e1 	str	w1, [sp, #20]
    pgd_t *d;
    pte_t *pte;
    uint64 pa, i, ap;

    // allocate a new first level page directory
    d = kpt_alloc();
ffffffff4003a6c8:	97fffde9 	bl	ffffffff40039e6c <kpt_alloc>
ffffffff4003a6cc:	f90023e0 	str	x0, [sp, #64]
    if (d == NULL ) {
ffffffff4003a6d0:	f94023e0 	ldr	x0, [sp, #64]
ffffffff4003a6d4:	f100001f 	cmp	x0, #0x0
ffffffff4003a6d8:	54000061 	b.ne	ffffffff4003a6e4 <copyuvm+0x2c>  // b.any
        return NULL ;
ffffffff4003a6dc:	d2800000 	mov	x0, #0x0                   	// #0
ffffffff4003a6e0:	1400003e 	b	ffffffff4003a7d8 <copyuvm+0x120>
    }

    // copy the whole address space over (no COW)
    for (i = 0; i < sz; i += PTE_SZ) {
ffffffff4003a6e4:	f90027ff 	str	xzr, [sp, #72]
ffffffff4003a6e8:	14000037 	b	ffffffff4003a7c4 <copyuvm+0x10c>
        if ((pte = walkpgdir(pgdir, (void *) i, 0)) == 0) {
ffffffff4003a6ec:	f94027e0 	ldr	x0, [sp, #72]
ffffffff4003a6f0:	52800002 	mov	w2, #0x0                   	// #0
ffffffff4003a6f4:	aa0003e1 	mov	x1, x0
ffffffff4003a6f8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003a6fc:	97fffe03 	bl	ffffffff40039f08 <walkpgdir>
ffffffff4003a700:	f9001fe0 	str	x0, [sp, #56]
ffffffff4003a704:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003a708:	f100001f 	cmp	x0, #0x0
ffffffff4003a70c:	54000081 	b.ne	ffffffff4003a71c <copyuvm+0x64>  // b.any
            panic("copyuvm: pte should exist");
ffffffff4003a710:	b0000000 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003a714:	91372000 	add	x0, x0, #0xdc8
ffffffff4003a718:	97ffdc6c 	bl	ffffffff400318c8 <panic>
        }

        if (!(*pte & (ENTRY_PAGE | ENTRY_VALID))) {
ffffffff4003a71c:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003a720:	f9400000 	ldr	x0, [x0]
ffffffff4003a724:	92400400 	and	x0, x0, #0x3
ffffffff4003a728:	f100001f 	cmp	x0, #0x0
ffffffff4003a72c:	54000081 	b.ne	ffffffff4003a73c <copyuvm+0x84>  // b.any
            panic("copyuvm: page not present");
ffffffff4003a730:	b0000000 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003a734:	9137a000 	add	x0, x0, #0xde8
ffffffff4003a738:	97ffdc64 	bl	ffffffff400318c8 <panic>
        }
    
      *pte = *pte | PTE_AP_RO| PTE_COW;  // mark the page as copy-on-write
ffffffff4003a73c:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003a740:	f9400001 	ldr	x1, [x0]
ffffffff4003a744:	d2801000 	mov	x0, #0x80                  	// #128
ffffffff4003a748:	f2e01000 	movk	x0, #0x80, lsl #48
ffffffff4003a74c:	aa000021 	orr	x1, x1, x0
ffffffff4003a750:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003a754:	f9000001 	str	x1, [x0]
      ap = PTE_AP(*pte) | PTE_AP_RO| PTE_COW;  // mark the page as copy-on-write
ffffffff4003a758:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003a75c:	f9400000 	ldr	x0, [x0]
ffffffff4003a760:	927a0001 	and	x1, x0, #0x40
ffffffff4003a764:	d2801000 	mov	x0, #0x80                  	// #128
ffffffff4003a768:	f2e01000 	movk	x0, #0x80, lsl #48
ffffffff4003a76c:	aa000020 	orr	x0, x1, x0
ffffffff4003a770:	f9001be0 	str	x0, [sp, #48]

       kpage_ref((void*)PTE_ADDR(*pte));  // increment the reference count for the page
ffffffff4003a774:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003a778:	f9400000 	ldr	x0, [x0]
ffffffff4003a77c:	9274cc00 	and	x0, x0, #0xfffffffffffff000
ffffffff4003a780:	97ffe874 	bl	ffffffff40034950 <kpage_ref>

        pa = PTE_ADDR(*pte);
ffffffff4003a784:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003a788:	f9400000 	ldr	x0, [x0]
ffffffff4003a78c:	9274cc00 	and	x0, x0, #0xfffffffffffff000
ffffffff4003a790:	f90017e0 	str	x0, [sp, #40]

        flush_tlb();  // flush the TLB to ensure the new mapping is used
ffffffff4003a794:	97fffe6e 	bl	ffffffff4003a14c <flush_tlb>

        mappages(d, (void*) i, PTE_SZ, pa, ap);
ffffffff4003a798:	f94027e0 	ldr	x0, [sp, #72]
ffffffff4003a79c:	f94017e1 	ldr	x1, [sp, #40]
ffffffff4003a7a0:	f9401be4 	ldr	x4, [sp, #48]
ffffffff4003a7a4:	2a0103e3 	mov	w3, w1
ffffffff4003a7a8:	52820002 	mov	w2, #0x1000                	// #4096
ffffffff4003a7ac:	aa0003e1 	mov	x1, x0
ffffffff4003a7b0:	f94023e0 	ldr	x0, [sp, #64]
ffffffff4003a7b4:	97fffe2c 	bl	ffffffff4003a064 <mappages>
    for (i = 0; i < sz; i += PTE_SZ) {
ffffffff4003a7b8:	f94027e0 	ldr	x0, [sp, #72]
ffffffff4003a7bc:	91400400 	add	x0, x0, #0x1, lsl #12
ffffffff4003a7c0:	f90027e0 	str	x0, [sp, #72]
ffffffff4003a7c4:	b94017e0 	ldr	w0, [sp, #20]
ffffffff4003a7c8:	f94027e1 	ldr	x1, [sp, #72]
ffffffff4003a7cc:	eb00003f 	cmp	x1, x0
ffffffff4003a7d0:	54fff8e3 	b.cc	ffffffff4003a6ec <copyuvm+0x34>  // b.lo, b.ul, b.last

    }
    return d;
ffffffff4003a7d4:	f94023e0 	ldr	x0, [sp, #64]
}
ffffffff4003a7d8:	a8c57bfd 	ldp	x29, x30, [sp], #80
ffffffff4003a7dc:	d65f03c0 	ret

ffffffff4003a7e0 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char* uva2ka (pgd_t *pgdir, char *uva)
{
ffffffff4003a7e0:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff4003a7e4:	910003fd 	mov	x29, sp
ffffffff4003a7e8:	f9000fe0 	str	x0, [sp, #24]
ffffffff4003a7ec:	f9000be1 	str	x1, [sp, #16]
    pte_t *pte;

    pte = walkpgdir(pgdir, uva, 0);
ffffffff4003a7f0:	52800002 	mov	w2, #0x0                   	// #0
ffffffff4003a7f4:	f9400be1 	ldr	x1, [sp, #16]
ffffffff4003a7f8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003a7fc:	97fffdc3 	bl	ffffffff40039f08 <walkpgdir>
ffffffff4003a800:	f90017e0 	str	x0, [sp, #40]

    // make sure it exists
    if ((*pte & (ENTRY_PAGE | ENTRY_VALID)) == 0) {
ffffffff4003a804:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003a808:	f9400000 	ldr	x0, [x0]
ffffffff4003a80c:	92400400 	and	x0, x0, #0x3
ffffffff4003a810:	f100001f 	cmp	x0, #0x0
ffffffff4003a814:	54000061 	b.ne	ffffffff4003a820 <uva2ka+0x40>  // b.any
        return 0;
ffffffff4003a818:	d2800000 	mov	x0, #0x0                   	// #0
ffffffff4003a81c:	1400000d 	b	ffffffff4003a850 <uva2ka+0x70>
    }

    // make sure it is a user page
    if (PTE_AP(*pte) != AP_RW_1_0) {
ffffffff4003a820:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003a824:	f9400000 	ldr	x0, [x0]
ffffffff4003a828:	927a0400 	and	x0, x0, #0xc0
ffffffff4003a82c:	f101001f 	cmp	x0, #0x40
ffffffff4003a830:	54000060 	b.eq	ffffffff4003a83c <uva2ka+0x5c>  // b.none
        return 0;
ffffffff4003a834:	d2800000 	mov	x0, #0x0                   	// #0
ffffffff4003a838:	14000006 	b	ffffffff4003a850 <uva2ka+0x70>
    }

    return (char*) p2v(PTE_ADDR(*pte));
ffffffff4003a83c:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003a840:	f9400000 	ldr	x0, [x0]
ffffffff4003a844:	9274cc00 	and	x0, x0, #0xfffffffffffff000
ffffffff4003a848:	97fffd3f 	bl	ffffffff40039d44 <p2v>
ffffffff4003a84c:	d503201f 	nop
}
ffffffff4003a850:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff4003a854:	d65f03c0 	ret

ffffffff4003a858 <copyout>:

// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for user pages.
int copyout (pgd_t *pgdir, uint va, void *p, uint len)
{
ffffffff4003a858:	a9bb7bfd 	stp	x29, x30, [sp, #-80]!
ffffffff4003a85c:	910003fd 	mov	x29, sp
ffffffff4003a860:	f90017e0 	str	x0, [sp, #40]
ffffffff4003a864:	b90027e1 	str	w1, [sp, #36]
ffffffff4003a868:	f9000fe2 	str	x2, [sp, #24]
ffffffff4003a86c:	b90023e3 	str	w3, [sp, #32]
    char *buf, *pa0;
    uint64 n, va0;

    buf = (char*) p;
ffffffff4003a870:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003a874:	f90027e0 	str	x0, [sp, #72]

    while (len > 0) {
ffffffff4003a878:	1400002e 	b	ffffffff4003a930 <copyout+0xd8>
        va0 = align_dn(va, PTE_SZ);
ffffffff4003a87c:	b94027e0 	ldr	w0, [sp, #36]
ffffffff4003a880:	9274cc00 	and	x0, x0, #0xfffffffffffff000
ffffffff4003a884:	f9001fe0 	str	x0, [sp, #56]
        pa0 = uva2ka(pgdir, (char*) va0);
ffffffff4003a888:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003a88c:	aa0003e1 	mov	x1, x0
ffffffff4003a890:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003a894:	97ffffd3 	bl	ffffffff4003a7e0 <uva2ka>
ffffffff4003a898:	f9001be0 	str	x0, [sp, #48]

        if (pa0 == 0) {
ffffffff4003a89c:	f9401be0 	ldr	x0, [sp, #48]
ffffffff4003a8a0:	f100001f 	cmp	x0, #0x0
ffffffff4003a8a4:	54000061 	b.ne	ffffffff4003a8b0 <copyout+0x58>  // b.any
            return -1;
ffffffff4003a8a8:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff4003a8ac:	14000025 	b	ffffffff4003a940 <copyout+0xe8>
        }

        n = PTE_SZ - (va - va0);
ffffffff4003a8b0:	b94027e0 	ldr	w0, [sp, #36]
ffffffff4003a8b4:	f9401fe1 	ldr	x1, [sp, #56]
ffffffff4003a8b8:	cb000020 	sub	x0, x1, x0
ffffffff4003a8bc:	91400400 	add	x0, x0, #0x1, lsl #12
ffffffff4003a8c0:	f90023e0 	str	x0, [sp, #64]

        if (n > len) {
ffffffff4003a8c4:	b94023e0 	ldr	w0, [sp, #32]
ffffffff4003a8c8:	f94023e1 	ldr	x1, [sp, #64]
ffffffff4003a8cc:	eb00003f 	cmp	x1, x0
ffffffff4003a8d0:	54000069 	b.ls	ffffffff4003a8dc <copyout+0x84>  // b.plast
            n = len;
ffffffff4003a8d4:	b94023e0 	ldr	w0, [sp, #32]
ffffffff4003a8d8:	f90023e0 	str	x0, [sp, #64]
        }

        memmove(pa0 + (va - va0), buf, n);
ffffffff4003a8dc:	b94027e1 	ldr	w1, [sp, #36]
ffffffff4003a8e0:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003a8e4:	cb000020 	sub	x0, x1, x0
ffffffff4003a8e8:	f9401be1 	ldr	x1, [sp, #48]
ffffffff4003a8ec:	8b000020 	add	x0, x1, x0
ffffffff4003a8f0:	f94023e1 	ldr	x1, [sp, #64]
ffffffff4003a8f4:	2a0103e2 	mov	w2, w1
ffffffff4003a8f8:	f94027e1 	ldr	x1, [sp, #72]
ffffffff4003a8fc:	97ffd62b 	bl	ffffffff400301a8 <memmove>

        len -= n;
ffffffff4003a900:	f94023e0 	ldr	x0, [sp, #64]
ffffffff4003a904:	2a0003e1 	mov	w1, w0
ffffffff4003a908:	b94023e0 	ldr	w0, [sp, #32]
ffffffff4003a90c:	4b010000 	sub	w0, w0, w1
ffffffff4003a910:	b90023e0 	str	w0, [sp, #32]
        buf += n;
ffffffff4003a914:	f94027e1 	ldr	x1, [sp, #72]
ffffffff4003a918:	f94023e0 	ldr	x0, [sp, #64]
ffffffff4003a91c:	8b000020 	add	x0, x1, x0
ffffffff4003a920:	f90027e0 	str	x0, [sp, #72]
        va = va0 + PTE_SZ;
ffffffff4003a924:	f9401fe0 	ldr	x0, [sp, #56]
ffffffff4003a928:	11400400 	add	w0, w0, #0x1, lsl #12
ffffffff4003a92c:	b90027e0 	str	w0, [sp, #36]
    while (len > 0) {
ffffffff4003a930:	b94023e0 	ldr	w0, [sp, #32]
ffffffff4003a934:	7100001f 	cmp	w0, #0x0
ffffffff4003a938:	54fffa21 	b.ne	ffffffff4003a87c <copyout+0x24>  // b.any
    }

    return 0;
ffffffff4003a93c:	52800000 	mov	w0, #0x0                   	// #0
}
ffffffff4003a940:	a8c57bfd 	ldp	x29, x30, [sp], #80
ffffffff4003a944:	d65f03c0 	ret

ffffffff4003a948 <paging_init>:
// it that ARMv6's small brain cannot handle the case that memory
// be mapped in both 1-level page table and 2-level page. For
// initial kernel, we use 1MB mapping, other memory needs to be
// mapped as 4KB pages
void paging_init (uint64 phy_low, uint64 phy_hi)
{
ffffffff4003a948:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff4003a94c:	910003fd 	mov	x29, sp
ffffffff4003a950:	f9000fe0 	str	x0, [sp, #24]
ffffffff4003a954:	f9000be1 	str	x1, [sp, #16]
    mappages (P2V(&_kernel_pgtbl), P2V(phy_low), phy_hi - phy_low, phy_low, AP_RW_1_0);
ffffffff4003a958:	b07ffec0 	adrp	x0, 40013000 <_kernel_pgtbl>
ffffffff4003a95c:	91000001 	add	x1, x0, #0x0
ffffffff4003a960:	d2c00020 	mov	x0, #0x100000000           	// #4294967296
ffffffff4003a964:	cb000025 	sub	x5, x1, x0
ffffffff4003a968:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff4003a96c:	b2607fe0 	mov	x0, #0xffffffff00000000    	// #-4294967296
ffffffff4003a970:	8b000020 	add	x0, x1, x0
ffffffff4003a974:	aa0003e6 	mov	x6, x0
ffffffff4003a978:	f9400be0 	ldr	x0, [sp, #16]
ffffffff4003a97c:	2a0003e1 	mov	w1, w0
ffffffff4003a980:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003a984:	4b000020 	sub	w0, w1, w0
ffffffff4003a988:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff4003a98c:	d2800804 	mov	x4, #0x40                  	// #64
ffffffff4003a990:	2a0103e3 	mov	w3, w1
ffffffff4003a994:	2a0003e2 	mov	w2, w0
ffffffff4003a998:	aa0603e1 	mov	x1, x6
ffffffff4003a99c:	aa0503e0 	mov	x0, x5
ffffffff4003a9a0:	97fffdb1 	bl	ffffffff4003a064 <mappages>
    flush_tlb ();
ffffffff4003a9a4:	97fffdea 	bl	ffffffff4003a14c <flush_tlb>
}
ffffffff4003a9a8:	d503201f 	nop
ffffffff4003a9ac:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff4003a9b0:	d65f03c0 	ret

ffffffff4003a9b4 <ack_timer>:
struct spinlock tickslock;
uint ticks;

// acknowledge the timer, write any value to TIMER_INTCLR should do
static void ack_timer ()
{
ffffffff4003a9b4:	d10043ff 	sub	sp, sp, #0x10
    volatile uint * timer0 = P2V(TIMER0);
ffffffff4003a9b8:	929fffe0 	mov	x0, #0xffffffffffff0000    	// #-65536
ffffffff4003a9bc:	f2a38220 	movk	x0, #0x1c11, lsl #16
ffffffff4003a9c0:	f90007e0 	str	x0, [sp, #8]
    timer0[TIMER_INTCLR] = 1;
ffffffff4003a9c4:	f94007e0 	ldr	x0, [sp, #8]
ffffffff4003a9c8:	91003000 	add	x0, x0, #0xc
ffffffff4003a9cc:	52800021 	mov	w1, #0x1                   	// #1
ffffffff4003a9d0:	b9000001 	str	w1, [x0]
}
ffffffff4003a9d4:	d503201f 	nop
ffffffff4003a9d8:	910043ff 	add	sp, sp, #0x10
ffffffff4003a9dc:	d65f03c0 	ret

ffffffff4003a9e0 <timer_init>:

// initialize the timer: perodical and interrupt based
void timer_init(int hz)
{
ffffffff4003a9e0:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff4003a9e4:	910003fd 	mov	x29, sp
ffffffff4003a9e8:	b9001fe0 	str	w0, [sp, #28]
    volatile uint * timer0 = P2V(TIMER0);
ffffffff4003a9ec:	929fffe0 	mov	x0, #0xffffffffffff0000    	// #-65536
ffffffff4003a9f0:	f2a38220 	movk	x0, #0x1c11, lsl #16
ffffffff4003a9f4:	f90017e0 	str	x0, [sp, #40]

    initlock(&tickslock, "time");
ffffffff4003a9f8:	b0000000 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003a9fc:	91382001 	add	x1, x0, #0xe08
ffffffff4003aa00:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003aa04:	911f8000 	add	x0, x0, #0x7e0
ffffffff4003aa08:	97ffec92 	bl	ffffffff40035c50 <initlock>

    timer0[TIMER_LOAD] = CLK_HZ / hz;
ffffffff4003aa0c:	52884801 	mov	w1, #0x4240                	// #16960
ffffffff4003aa10:	72a001e1 	movk	w1, #0xf, lsl #16
ffffffff4003aa14:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003aa18:	1ac00c20 	sdiv	w0, w1, w0
ffffffff4003aa1c:	2a0003e1 	mov	w1, w0
ffffffff4003aa20:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003aa24:	b9000001 	str	w1, [x0]
    timer0[TIMER_CONTROL] = TIMER_EN|TIMER_PERIODIC|TIMER_32BIT|TIMER_INTEN;
ffffffff4003aa28:	f94017e0 	ldr	x0, [sp, #40]
ffffffff4003aa2c:	91002000 	add	x0, x0, #0x8
ffffffff4003aa30:	52801c41 	mov	w1, #0xe2                  	// #226
ffffffff4003aa34:	b9000001 	str	w1, [x0]

    pic_enable (PIC_TIMER01, isr_timer);
ffffffff4003aa38:	90000000 	adrp	x0, ffffffff4003a000 <walkpgdir+0xf8>
ffffffff4003aa3c:	91295001 	add	x1, x0, #0xa54
ffffffff4003aa40:	528001a0 	mov	w0, #0xd                   	// #13
ffffffff4003aa44:	94000237 	bl	ffffffff4003b320 <pic_enable>
}
ffffffff4003aa48:	d503201f 	nop
ffffffff4003aa4c:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff4003aa50:	d65f03c0 	ret

ffffffff4003aa54 <isr_timer>:

// interrupt service routine for the timer
void isr_timer (struct trapframe *tp, int irq_idx)
{
ffffffff4003aa54:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff4003aa58:	910003fd 	mov	x29, sp
ffffffff4003aa5c:	f9000fe0 	str	x0, [sp, #24]
ffffffff4003aa60:	b90017e1 	str	w1, [sp, #20]
    acquire(&tickslock);
ffffffff4003aa64:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003aa68:	911f8000 	add	x0, x0, #0x7e0
ffffffff4003aa6c:	97ffec86 	bl	ffffffff40035c84 <acquire>
    ticks++;
ffffffff4003aa70:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003aa74:	91208000 	add	x0, x0, #0x820
ffffffff4003aa78:	b9400000 	ldr	w0, [x0]
ffffffff4003aa7c:	11000401 	add	w1, w0, #0x1
ffffffff4003aa80:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003aa84:	91208000 	add	x0, x0, #0x820
ffffffff4003aa88:	b9000001 	str	w1, [x0]
    wakeup(&ticks);
ffffffff4003aa8c:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003aa90:	91208000 	add	x0, x0, #0x820
ffffffff4003aa94:	97ffebfb 	bl	ffffffff40035a80 <wakeup>
    release(&tickslock);
ffffffff4003aa98:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003aa9c:	911f8000 	add	x0, x0, #0x7e0
ffffffff4003aaa0:	97ffec83 	bl	ffffffff40035cac <release>
    ack_timer();
ffffffff4003aaa4:	97ffffc4 	bl	ffffffff4003a9b4 <ack_timer>
}
ffffffff4003aaa8:	d503201f 	nop
ffffffff4003aaac:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff4003aab0:	d65f03c0 	ret

ffffffff4003aab4 <micro_delay>:

// a short delay, use timer 1 as the source
void micro_delay (int us)
{
ffffffff4003aab4:	d10083ff 	sub	sp, sp, #0x20
ffffffff4003aab8:	b9000fe0 	str	w0, [sp, #12]
    volatile uint * timer1 = P2V(TIMER1);
ffffffff4003aabc:	929fffe0 	mov	x0, #0xffffffffffff0000    	// #-65536
ffffffff4003aac0:	f2a38240 	movk	x0, #0x1c12, lsl #16
ffffffff4003aac4:	f9000fe0 	str	x0, [sp, #24]

    // load the initial value to timer1, and configure it to be freerun
    timer1[TIMER_CONTROL] = TIMER_EN | TIMER_32BIT;
ffffffff4003aac8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003aacc:	91002000 	add	x0, x0, #0x8
ffffffff4003aad0:	52801041 	mov	w1, #0x82                  	// #130
ffffffff4003aad4:	b9000001 	str	w1, [x0]
    timer1[TIMER_LOAD] = us;
ffffffff4003aad8:	b9400fe1 	ldr	w1, [sp, #12]
ffffffff4003aadc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003aae0:	b9000001 	str	w1, [x0]

    // the register will wrap to 0xFFFFFFFF after decrement to 0
    while ((int)timer1[TIMER_CURVAL] > 0) {
ffffffff4003aae4:	d503201f 	nop
ffffffff4003aae8:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003aaec:	91001000 	add	x0, x0, #0x4
ffffffff4003aaf0:	b9400000 	ldr	w0, [x0]
ffffffff4003aaf4:	7100001f 	cmp	w0, #0x0
ffffffff4003aaf8:	54ffff8c 	b.gt	ffffffff4003aae8 <micro_delay+0x34>

    }

    // disable timer
    timer1[TIMER_CONTROL] = 0;
ffffffff4003aafc:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003ab00:	91002000 	add	x0, x0, #0x8
ffffffff4003ab04:	b900001f 	str	wzr, [x0]
}
ffffffff4003ab08:	d503201f 	nop
ffffffff4003ab0c:	910083ff 	add	sp, sp, #0x20
ffffffff4003ab10:	d65f03c0 	ret

ffffffff4003ab14 <uart_init>:
#define UART_TXI	(1 << 5)	// transmit interrupt
#define UART_BITRATE 19200

// enable uart
void uart_init (void *addr)
{
ffffffff4003ab14:	d10083ff 	sub	sp, sp, #0x20
ffffffff4003ab18:	f90007e0 	str	x0, [sp, #8]
    uint left;

    uart_base = addr;
ffffffff4003ab1c:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003ab20:	9120a000 	add	x0, x0, #0x828
ffffffff4003ab24:	f94007e1 	ldr	x1, [sp, #8]
ffffffff4003ab28:	f9000001 	str	x1, [x0]

    // set the bit rate: integer/fractional baud rate registers
    uart_base[UART_IBRD] = UART_CLK / (16 * UART_BITRATE);
ffffffff4003ab2c:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003ab30:	9120a000 	add	x0, x0, #0x828
ffffffff4003ab34:	f9400000 	ldr	x0, [x0]
ffffffff4003ab38:	91009000 	add	x0, x0, #0x24
ffffffff4003ab3c:	528009c1 	mov	w1, #0x4e                  	// #78
ffffffff4003ab40:	b9000001 	str	w1, [x0]

    left = UART_CLK % (16 * UART_BITRATE);
ffffffff4003ab44:	5292c000 	mov	w0, #0x9600                	// #38400
ffffffff4003ab48:	b9001fe0 	str	w0, [sp, #28]
    uart_base[UART_FBRD] = (left * 4 + UART_BITRATE / 2) / UART_BITRATE;
ffffffff4003ab4c:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003ab50:	11258000 	add	w0, w0, #0x960
ffffffff4003ab54:	531e7402 	lsl	w2, w0, #2
ffffffff4003ab58:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003ab5c:	9120a000 	add	x0, x0, #0x828
ffffffff4003ab60:	f9400000 	ldr	x0, [x0]
ffffffff4003ab64:	9100a000 	add	x0, x0, #0x28
ffffffff4003ab68:	529036a1 	mov	w1, #0x81b5                	// #33205
ffffffff4003ab6c:	72a369c1 	movk	w1, #0x1b4e, lsl #16
ffffffff4003ab70:	9ba17c41 	umull	x1, w2, w1
ffffffff4003ab74:	d360fc21 	lsr	x1, x1, #32
ffffffff4003ab78:	530b7c21 	lsr	w1, w1, #11
ffffffff4003ab7c:	b9000001 	str	w1, [x0]

    // enable trasmit and receive
    uart_base[UART_CR] |= (UARTCR_EN | UARTCR_RXE | UARTCR_TXE);
ffffffff4003ab80:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003ab84:	9120a000 	add	x0, x0, #0x828
ffffffff4003ab88:	f9400000 	ldr	x0, [x0]
ffffffff4003ab8c:	9100c000 	add	x0, x0, #0x30
ffffffff4003ab90:	b9400002 	ldr	w2, [x0]
ffffffff4003ab94:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003ab98:	9120a000 	add	x0, x0, #0x828
ffffffff4003ab9c:	f9400000 	ldr	x0, [x0]
ffffffff4003aba0:	9100c000 	add	x0, x0, #0x30
ffffffff4003aba4:	52806021 	mov	w1, #0x301                 	// #769
ffffffff4003aba8:	2a010041 	orr	w1, w2, w1
ffffffff4003abac:	b9000001 	str	w1, [x0]

    // enable FIFO
    uart_base[UART_LCR] |= UARTLCR_FEN;
ffffffff4003abb0:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003abb4:	9120a000 	add	x0, x0, #0x828
ffffffff4003abb8:	f9400000 	ldr	x0, [x0]
ffffffff4003abbc:	9100b000 	add	x0, x0, #0x2c
ffffffff4003abc0:	b9400001 	ldr	w1, [x0]
ffffffff4003abc4:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003abc8:	9120a000 	add	x0, x0, #0x828
ffffffff4003abcc:	f9400000 	ldr	x0, [x0]
ffffffff4003abd0:	9100b000 	add	x0, x0, #0x2c
ffffffff4003abd4:	321c0021 	orr	w1, w1, #0x10
ffffffff4003abd8:	b9000001 	str	w1, [x0]
}
ffffffff4003abdc:	d503201f 	nop
ffffffff4003abe0:	910083ff 	add	sp, sp, #0x20
ffffffff4003abe4:	d65f03c0 	ret

ffffffff4003abe8 <uart_enable_rx>:

// enable the receive (interrupt) for uart (after PIC has initialized)
void uart_enable_rx ()
{
ffffffff4003abe8:	a9bf7bfd 	stp	x29, x30, [sp, #-16]!
ffffffff4003abec:	910003fd 	mov	x29, sp
    uart_base[UART_IMSC] = UART_RXI;
ffffffff4003abf0:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003abf4:	9120a000 	add	x0, x0, #0x828
ffffffff4003abf8:	f9400000 	ldr	x0, [x0]
ffffffff4003abfc:	9100e000 	add	x0, x0, #0x38
ffffffff4003ac00:	52800201 	mov	w1, #0x10                  	// #16
ffffffff4003ac04:	b9000001 	str	w1, [x0]
    pic_enable(PIC_UART0, isr_uart);
ffffffff4003ac08:	90000000 	adrp	x0, ffffffff4003a000 <walkpgdir+0xf8>
ffffffff4003ac0c:	9132e001 	add	x1, x0, #0xcb8
ffffffff4003ac10:	52800020 	mov	w0, #0x1                   	// #1
ffffffff4003ac14:	940001c3 	bl	ffffffff4003b320 <pic_enable>
}
ffffffff4003ac18:	d503201f 	nop
ffffffff4003ac1c:	a8c17bfd 	ldp	x29, x30, [sp], #16
ffffffff4003ac20:	d65f03c0 	ret

ffffffff4003ac24 <uartputc>:

void uartputc (int c)
{
ffffffff4003ac24:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff4003ac28:	910003fd 	mov	x29, sp
ffffffff4003ac2c:	b9001fe0 	str	w0, [sp, #28]
    // wait a short period if the transmit FIFO is full
    while (uart_base[UART_FR] & UARTFR_TXFF) {
ffffffff4003ac30:	14000003 	b	ffffffff4003ac3c <uartputc+0x18>
        micro_delay(10);
ffffffff4003ac34:	52800140 	mov	w0, #0xa                   	// #10
ffffffff4003ac38:	97ffff9f 	bl	ffffffff4003aab4 <micro_delay>
    while (uart_base[UART_FR] & UARTFR_TXFF) {
ffffffff4003ac3c:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003ac40:	9120a000 	add	x0, x0, #0x828
ffffffff4003ac44:	f9400000 	ldr	x0, [x0]
ffffffff4003ac48:	91006000 	add	x0, x0, #0x18
ffffffff4003ac4c:	b9400000 	ldr	w0, [x0]
ffffffff4003ac50:	121b0000 	and	w0, w0, #0x20
ffffffff4003ac54:	7100001f 	cmp	w0, #0x0
ffffffff4003ac58:	54fffee1 	b.ne	ffffffff4003ac34 <uartputc+0x10>  // b.any
    }

    uart_base[UART_DR] = c;
ffffffff4003ac5c:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003ac60:	9120a000 	add	x0, x0, #0x828
ffffffff4003ac64:	f9400000 	ldr	x0, [x0]
ffffffff4003ac68:	b9401fe1 	ldr	w1, [sp, #28]
ffffffff4003ac6c:	b9000001 	str	w1, [x0]
}
ffffffff4003ac70:	d503201f 	nop
ffffffff4003ac74:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff4003ac78:	d65f03c0 	ret

ffffffff4003ac7c <uartgetc>:

//poll the UART for data
int uartgetc (void)
{
    if (uart_base[UART_FR] & UARTFR_RXFE) {
ffffffff4003ac7c:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003ac80:	9120a000 	add	x0, x0, #0x828
ffffffff4003ac84:	f9400000 	ldr	x0, [x0]
ffffffff4003ac88:	91006000 	add	x0, x0, #0x18
ffffffff4003ac8c:	b9400000 	ldr	w0, [x0]
ffffffff4003ac90:	121c0000 	and	w0, w0, #0x10
ffffffff4003ac94:	7100001f 	cmp	w0, #0x0
ffffffff4003ac98:	54000060 	b.eq	ffffffff4003aca4 <uartgetc+0x28>  // b.none
        return -1;
ffffffff4003ac9c:	12800000 	mov	w0, #0xffffffff            	// #-1
ffffffff4003aca0:	14000005 	b	ffffffff4003acb4 <uartgetc+0x38>
    }

    return uart_base[UART_DR];
ffffffff4003aca4:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003aca8:	9120a000 	add	x0, x0, #0x828
ffffffff4003acac:	f9400000 	ldr	x0, [x0]
ffffffff4003acb0:	b9400000 	ldr	w0, [x0]
}
ffffffff4003acb4:	d65f03c0 	ret

ffffffff4003acb8 <isr_uart>:

void isr_uart (struct trapframe *tf, int idx)
{
ffffffff4003acb8:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff4003acbc:	910003fd 	mov	x29, sp
ffffffff4003acc0:	f9000fe0 	str	x0, [sp, #24]
ffffffff4003acc4:	b90017e1 	str	w1, [sp, #20]
    if (uart_base[UART_MIS] & UART_RXI) {
ffffffff4003acc8:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003accc:	9120a000 	add	x0, x0, #0x828
ffffffff4003acd0:	f9400000 	ldr	x0, [x0]
ffffffff4003acd4:	91010000 	add	x0, x0, #0x40
ffffffff4003acd8:	b9400000 	ldr	w0, [x0]
ffffffff4003acdc:	121c0000 	and	w0, w0, #0x10
ffffffff4003ace0:	7100001f 	cmp	w0, #0x0
ffffffff4003ace4:	54000080 	b.eq	ffffffff4003acf4 <isr_uart+0x3c>  // b.none
        consoleintr(uartgetc);
ffffffff4003ace8:	90000000 	adrp	x0, ffffffff4003a000 <walkpgdir+0xf8>
ffffffff4003acec:	9131f000 	add	x0, x0, #0xc7c
ffffffff4003acf0:	97ffdb27 	bl	ffffffff4003198c <consoleintr>
    }

    // clear the interrupt
    uart_base[UART_ICR] = UART_RXI | UART_TXI;
ffffffff4003acf4:	b0000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003acf8:	9120a000 	add	x0, x0, #0x828
ffffffff4003acfc:	f9400000 	ldr	x0, [x0]
ffffffff4003ad00:	91011000 	add	x0, x0, #0x44
ffffffff4003ad04:	52800601 	mov	w1, #0x30                  	// #48
ffffffff4003ad08:	b9000001 	str	w1, [x0]
}
ffffffff4003ad0c:	d503201f 	nop
ffffffff4003ad10:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff4003ad14:	d65f03c0 	ret

ffffffff4003ad18 <gicd_set_bit>:

/*  id is m
 *  offset n= m DIV 32
 *  bit    pos = m MOD 32;
 */
static void gicd_set_bit(int base, int id, int bval) {
ffffffff4003ad18:	d10083ff 	sub	sp, sp, #0x20
ffffffff4003ad1c:	b9000fe0 	str	w0, [sp, #12]
ffffffff4003ad20:	b9000be1 	str	w1, [sp, #8]
ffffffff4003ad24:	b90007e2 	str	w2, [sp, #4]
	int offset = id/32;
ffffffff4003ad28:	b9400be0 	ldr	w0, [sp, #8]
ffffffff4003ad2c:	11007c01 	add	w1, w0, #0x1f
ffffffff4003ad30:	7100001f 	cmp	w0, #0x0
ffffffff4003ad34:	1a80b020 	csel	w0, w1, w0, lt	// lt = tstop
ffffffff4003ad38:	13057c00 	asr	w0, w0, #5
ffffffff4003ad3c:	b9001be0 	str	w0, [sp, #24]
	int bitpos = id%32;
ffffffff4003ad40:	b9400be0 	ldr	w0, [sp, #8]
ffffffff4003ad44:	6b0003e1 	negs	w1, w0
ffffffff4003ad48:	12001000 	and	w0, w0, #0x1f
ffffffff4003ad4c:	12001021 	and	w1, w1, #0x1f
ffffffff4003ad50:	5a814400 	csneg	w0, w0, w1, mi	// mi = first
ffffffff4003ad54:	b90017e0 	str	w0, [sp, #20]
	uint rval = GICD_REG(base+4*offset);
ffffffff4003ad58:	b9800fe0 	ldrsw	x0, [sp, #12]
ffffffff4003ad5c:	b0000541 	adrp	x1, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003ad60:	9120c021 	add	x1, x1, #0x830
ffffffff4003ad64:	f9400021 	ldr	x1, [x1]
ffffffff4003ad68:	8b010001 	add	x1, x0, x1
ffffffff4003ad6c:	b9401be0 	ldr	w0, [sp, #24]
ffffffff4003ad70:	531e7400 	lsl	w0, w0, #2
ffffffff4003ad74:	93407c00 	sxtw	x0, w0
ffffffff4003ad78:	8b000020 	add	x0, x1, x0
ffffffff4003ad7c:	f9400000 	ldr	x0, [x0]
ffffffff4003ad80:	b9001fe0 	str	w0, [sp, #28]
	if(bval)
ffffffff4003ad84:	b94007e0 	ldr	w0, [sp, #4]
ffffffff4003ad88:	7100001f 	cmp	w0, #0x0
ffffffff4003ad8c:	54000120 	b.eq	ffffffff4003adb0 <gicd_set_bit+0x98>  // b.none
		rval |= 1 << bitpos;
ffffffff4003ad90:	b94017e0 	ldr	w0, [sp, #20]
ffffffff4003ad94:	52800021 	mov	w1, #0x1                   	// #1
ffffffff4003ad98:	1ac02020 	lsl	w0, w1, w0
ffffffff4003ad9c:	2a0003e1 	mov	w1, w0
ffffffff4003ada0:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003ada4:	2a010000 	orr	w0, w0, w1
ffffffff4003ada8:	b9001fe0 	str	w0, [sp, #28]
ffffffff4003adac:	14000009 	b	ffffffff4003add0 <gicd_set_bit+0xb8>
	else
		rval &= ~(1<< bitpos);
ffffffff4003adb0:	b94017e0 	ldr	w0, [sp, #20]
ffffffff4003adb4:	52800021 	mov	w1, #0x1                   	// #1
ffffffff4003adb8:	1ac02020 	lsl	w0, w1, w0
ffffffff4003adbc:	2a2003e0 	mvn	w0, w0
ffffffff4003adc0:	2a0003e1 	mov	w1, w0
ffffffff4003adc4:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003adc8:	0a010000 	and	w0, w0, w1
ffffffff4003adcc:	b9001fe0 	str	w0, [sp, #28]
	GICD_REG(base+ 4*offset) = rval;
ffffffff4003add0:	b9800fe0 	ldrsw	x0, [sp, #12]
ffffffff4003add4:	b0000541 	adrp	x1, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003add8:	9120c021 	add	x1, x1, #0x830
ffffffff4003addc:	f9400021 	ldr	x1, [x1]
ffffffff4003ade0:	8b010001 	add	x1, x0, x1
ffffffff4003ade4:	b9401be0 	ldr	w0, [sp, #24]
ffffffff4003ade8:	531e7400 	lsl	w0, w0, #2
ffffffff4003adec:	93407c00 	sxtw	x0, w0
ffffffff4003adf0:	8b000020 	add	x0, x1, x0
ffffffff4003adf4:	aa0003e1 	mov	x1, x0
ffffffff4003adf8:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003adfc:	f9000020 	str	x0, [x1]
}
ffffffff4003ae00:	d503201f 	nop
ffffffff4003ae04:	910083ff 	add	sp, sp, #0x20
ffffffff4003ae08:	d65f03c0 	ret

ffffffff4003ae0c <gicc_set_bit>:


void gicc_set_bit(int base, int id, int bval) {
ffffffff4003ae0c:	d10083ff 	sub	sp, sp, #0x20
ffffffff4003ae10:	b9000fe0 	str	w0, [sp, #12]
ffffffff4003ae14:	b9000be1 	str	w1, [sp, #8]
ffffffff4003ae18:	b90007e2 	str	w2, [sp, #4]
	int offset = id/32;
ffffffff4003ae1c:	b9400be0 	ldr	w0, [sp, #8]
ffffffff4003ae20:	11007c01 	add	w1, w0, #0x1f
ffffffff4003ae24:	7100001f 	cmp	w0, #0x0
ffffffff4003ae28:	1a80b020 	csel	w0, w1, w0, lt	// lt = tstop
ffffffff4003ae2c:	13057c00 	asr	w0, w0, #5
ffffffff4003ae30:	b9001be0 	str	w0, [sp, #24]
	int bitpos = id%32;
ffffffff4003ae34:	b9400be0 	ldr	w0, [sp, #8]
ffffffff4003ae38:	6b0003e1 	negs	w1, w0
ffffffff4003ae3c:	12001000 	and	w0, w0, #0x1f
ffffffff4003ae40:	12001021 	and	w1, w1, #0x1f
ffffffff4003ae44:	5a814400 	csneg	w0, w0, w1, mi	// mi = first
ffffffff4003ae48:	b90017e0 	str	w0, [sp, #20]
	uint rval = GICC_REG(base+4*offset);
ffffffff4003ae4c:	b9800fe0 	ldrsw	x0, [sp, #12]
ffffffff4003ae50:	b0000541 	adrp	x1, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003ae54:	9120c021 	add	x1, x1, #0x830
ffffffff4003ae58:	f9400021 	ldr	x1, [x1]
ffffffff4003ae5c:	8b010001 	add	x1, x0, x1
ffffffff4003ae60:	b9401be0 	ldr	w0, [sp, #24]
ffffffff4003ae64:	531e7400 	lsl	w0, w0, #2
ffffffff4003ae68:	93407c00 	sxtw	x0, w0
ffffffff4003ae6c:	8b000020 	add	x0, x1, x0
ffffffff4003ae70:	91404000 	add	x0, x0, #0x10, lsl #12
ffffffff4003ae74:	f9400000 	ldr	x0, [x0]
ffffffff4003ae78:	b9001fe0 	str	w0, [sp, #28]
	if(bval)
ffffffff4003ae7c:	b94007e0 	ldr	w0, [sp, #4]
ffffffff4003ae80:	7100001f 	cmp	w0, #0x0
ffffffff4003ae84:	54000120 	b.eq	ffffffff4003aea8 <gicc_set_bit+0x9c>  // b.none
		rval |= 1 << bitpos;
ffffffff4003ae88:	b94017e0 	ldr	w0, [sp, #20]
ffffffff4003ae8c:	52800021 	mov	w1, #0x1                   	// #1
ffffffff4003ae90:	1ac02020 	lsl	w0, w1, w0
ffffffff4003ae94:	2a0003e1 	mov	w1, w0
ffffffff4003ae98:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003ae9c:	2a010000 	orr	w0, w0, w1
ffffffff4003aea0:	b9001fe0 	str	w0, [sp, #28]
ffffffff4003aea4:	14000009 	b	ffffffff4003aec8 <gicc_set_bit+0xbc>
	else
		rval &= ~(1<< bitpos);
ffffffff4003aea8:	b94017e0 	ldr	w0, [sp, #20]
ffffffff4003aeac:	52800021 	mov	w1, #0x1                   	// #1
ffffffff4003aeb0:	1ac02020 	lsl	w0, w1, w0
ffffffff4003aeb4:	2a2003e0 	mvn	w0, w0
ffffffff4003aeb8:	2a0003e1 	mov	w1, w0
ffffffff4003aebc:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003aec0:	0a010000 	and	w0, w0, w1
ffffffff4003aec4:	b9001fe0 	str	w0, [sp, #28]
	GICC_REG(base+ 4*offset) = rval;
ffffffff4003aec8:	b9800fe0 	ldrsw	x0, [sp, #12]
ffffffff4003aecc:	b0000541 	adrp	x1, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003aed0:	9120c021 	add	x1, x1, #0x830
ffffffff4003aed4:	f9400021 	ldr	x1, [x1]
ffffffff4003aed8:	8b010001 	add	x1, x0, x1
ffffffff4003aedc:	b9401be0 	ldr	w0, [sp, #24]
ffffffff4003aee0:	531e7400 	lsl	w0, w0, #2
ffffffff4003aee4:	93407c00 	sxtw	x0, w0
ffffffff4003aee8:	8b000020 	add	x0, x1, x0
ffffffff4003aeec:	91404000 	add	x0, x0, #0x10, lsl #12
ffffffff4003aef0:	aa0003e1 	mov	x1, x0
ffffffff4003aef4:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003aef8:	f9000020 	str	x0, [x1]
}
ffffffff4003aefc:	d503201f 	nop
ffffffff4003af00:	910083ff 	add	sp, sp, #0x20
ffffffff4003af04:	d65f03c0 	ret

ffffffff4003af08 <spi2id>:

static int spi2id(int spi)
{
ffffffff4003af08:	d10043ff 	sub	sp, sp, #0x10
ffffffff4003af0c:	b9000fe0 	str	w0, [sp, #12]
	return spi+32;
ffffffff4003af10:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff4003af14:	11008000 	add	w0, w0, #0x20
}
ffffffff4003af18:	910043ff 	add	sp, sp, #0x10
ffffffff4003af1c:	d65f03c0 	ret

ffffffff4003af20 <gd_spi_enable>:

static void gd_spi_enable(int spi)
{
ffffffff4003af20:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff4003af24:	910003fd 	mov	x29, sp
ffffffff4003af28:	b9001fe0 	str	w0, [sp, #28]
	int id = spi2id(spi);
ffffffff4003af2c:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003af30:	97fffff6 	bl	ffffffff4003af08 <spi2id>
ffffffff4003af34:	b9002fe0 	str	w0, [sp, #44]
	gicd_set_bit(GICD_ISENABLE, id, 1);
ffffffff4003af38:	52800022 	mov	w2, #0x1                   	// #1
ffffffff4003af3c:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff4003af40:	52802000 	mov	w0, #0x100                 	// #256
ffffffff4003af44:	97ffff75 	bl	ffffffff4003ad18 <gicd_set_bit>
}
ffffffff4003af48:	d503201f 	nop
ffffffff4003af4c:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff4003af50:	d65f03c0 	ret

ffffffff4003af54 <gd_spi_group0>:
/* By default, SPI is group 0
 * GIC spec ch4.3.4
 *
 */
static void gd_spi_group0(int spi)
{
ffffffff4003af54:	d10043ff 	sub	sp, sp, #0x10
ffffffff4003af58:	b9000fe0 	str	w0, [sp, #12]
	return;
ffffffff4003af5c:	d503201f 	nop
}
ffffffff4003af60:	910043ff 	add	sp, sp, #0x10
ffffffff4003af64:	d65f03c0 	ret

ffffffff4003af68 <gd_spi_target0>:

/* set target processor
 */
static void gd_spi_target0(int spi)
{
ffffffff4003af68:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff4003af6c:	910003fd 	mov	x29, sp
ffffffff4003af70:	b9001fe0 	str	w0, [sp, #28]
	int id=spi2id(spi);
ffffffff4003af74:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003af78:	97ffffe4 	bl	ffffffff4003af08 <spi2id>
ffffffff4003af7c:	b9003fe0 	str	w0, [sp, #60]
	int offset = id/4;
ffffffff4003af80:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff4003af84:	11000c01 	add	w1, w0, #0x3
ffffffff4003af88:	7100001f 	cmp	w0, #0x0
ffffffff4003af8c:	1a80b020 	csel	w0, w1, w0, lt	// lt = tstop
ffffffff4003af90:	13027c00 	asr	w0, w0, #2
ffffffff4003af94:	b9003be0 	str	w0, [sp, #56]
	int bitpos = (id%4)*8;
ffffffff4003af98:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff4003af9c:	6b0003e1 	negs	w1, w0
ffffffff4003afa0:	12000400 	and	w0, w0, #0x3
ffffffff4003afa4:	12000421 	and	w1, w1, #0x3
ffffffff4003afa8:	5a814400 	csneg	w0, w0, w1, mi	// mi = first
ffffffff4003afac:	531d7000 	lsl	w0, w0, #3
ffffffff4003afb0:	b90037e0 	str	w0, [sp, #52]
	uint rval = GICD_REG(GICD_ITARGET+4*offset);
ffffffff4003afb4:	b9403be0 	ldr	w0, [sp, #56]
ffffffff4003afb8:	531e7400 	lsl	w0, w0, #2
ffffffff4003afbc:	93407c00 	sxtw	x0, w0
ffffffff4003afc0:	b0000541 	adrp	x1, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003afc4:	9120c021 	add	x1, x1, #0x830
ffffffff4003afc8:	f9400021 	ldr	x1, [x1]
ffffffff4003afcc:	8b010000 	add	x0, x0, x1
ffffffff4003afd0:	91200000 	add	x0, x0, #0x800
ffffffff4003afd4:	f9400000 	ldr	x0, [x0]
ffffffff4003afd8:	b90033e0 	str	w0, [sp, #48]
	unsigned char tcpu=0x01;
ffffffff4003afdc:	52800020 	mov	w0, #0x1                   	// #1
ffffffff4003afe0:	3900bfe0 	strb	w0, [sp, #47]
	rval |= tcpu << bitpos;
ffffffff4003afe4:	3940bfe1 	ldrb	w1, [sp, #47]
ffffffff4003afe8:	b94037e0 	ldr	w0, [sp, #52]
ffffffff4003afec:	1ac02020 	lsl	w0, w1, w0
ffffffff4003aff0:	2a0003e1 	mov	w1, w0
ffffffff4003aff4:	b94033e0 	ldr	w0, [sp, #48]
ffffffff4003aff8:	2a010000 	orr	w0, w0, w1
ffffffff4003affc:	b90033e0 	str	w0, [sp, #48]
	GICD_REG(GICD_ITARGET+ 4*offset) = rval;	
ffffffff4003b000:	b9403be0 	ldr	w0, [sp, #56]
ffffffff4003b004:	531e7400 	lsl	w0, w0, #2
ffffffff4003b008:	93407c00 	sxtw	x0, w0
ffffffff4003b00c:	90000541 	adrp	x1, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003b010:	9120c021 	add	x1, x1, #0x830
ffffffff4003b014:	f9400021 	ldr	x1, [x1]
ffffffff4003b018:	8b010000 	add	x0, x0, x1
ffffffff4003b01c:	91200000 	add	x0, x0, #0x800
ffffffff4003b020:	aa0003e1 	mov	x1, x0
ffffffff4003b024:	b94033e0 	ldr	w0, [sp, #48]
ffffffff4003b028:	f9000020 	str	x0, [x1]
}
ffffffff4003b02c:	d503201f 	nop
ffffffff4003b030:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff4003b034:	d65f03c0 	ret

ffffffff4003b038 <gd_spi_setcfg>:

/* set cfg
 */
static void gd_spi_setcfg(int spi, int is_edge)
{
ffffffff4003b038:	a9bc7bfd 	stp	x29, x30, [sp, #-64]!
ffffffff4003b03c:	910003fd 	mov	x29, sp
ffffffff4003b040:	b9001fe0 	str	w0, [sp, #28]
ffffffff4003b044:	b9001be1 	str	w1, [sp, #24]
	int id=spi2id(spi);
ffffffff4003b048:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003b04c:	97ffffaf 	bl	ffffffff4003af08 <spi2id>
ffffffff4003b050:	b9003be0 	str	w0, [sp, #56]
	int offset = id/16;
ffffffff4003b054:	b9403be0 	ldr	w0, [sp, #56]
ffffffff4003b058:	11003c01 	add	w1, w0, #0xf
ffffffff4003b05c:	7100001f 	cmp	w0, #0x0
ffffffff4003b060:	1a80b020 	csel	w0, w1, w0, lt	// lt = tstop
ffffffff4003b064:	13047c00 	asr	w0, w0, #4
ffffffff4003b068:	b90037e0 	str	w0, [sp, #52]
	int bitpos = (id%16)*2;
ffffffff4003b06c:	b9403be0 	ldr	w0, [sp, #56]
ffffffff4003b070:	6b0003e1 	negs	w1, w0
ffffffff4003b074:	12000c00 	and	w0, w0, #0xf
ffffffff4003b078:	12000c21 	and	w1, w1, #0xf
ffffffff4003b07c:	5a814400 	csneg	w0, w0, w1, mi	// mi = first
ffffffff4003b080:	531f7800 	lsl	w0, w0, #1
ffffffff4003b084:	b90033e0 	str	w0, [sp, #48]
	uint rval = GICD_REG(GICD_ICFG+4*offset);
ffffffff4003b088:	b94037e0 	ldr	w0, [sp, #52]
ffffffff4003b08c:	531e7400 	lsl	w0, w0, #2
ffffffff4003b090:	93407c00 	sxtw	x0, w0
ffffffff4003b094:	90000541 	adrp	x1, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003b098:	9120c021 	add	x1, x1, #0x830
ffffffff4003b09c:	f9400021 	ldr	x1, [x1]
ffffffff4003b0a0:	8b010000 	add	x0, x0, x1
ffffffff4003b0a4:	91300000 	add	x0, x0, #0xc00
ffffffff4003b0a8:	f9400000 	ldr	x0, [x0]
ffffffff4003b0ac:	b9003fe0 	str	w0, [sp, #60]
	uint vmask=0x03;
ffffffff4003b0b0:	52800060 	mov	w0, #0x3                   	// #3
ffffffff4003b0b4:	b9002fe0 	str	w0, [sp, #44]
	rval &= ~(vmask << bitpos);
ffffffff4003b0b8:	b94033e0 	ldr	w0, [sp, #48]
ffffffff4003b0bc:	b9402fe1 	ldr	w1, [sp, #44]
ffffffff4003b0c0:	1ac02020 	lsl	w0, w1, w0
ffffffff4003b0c4:	2a2003e0 	mvn	w0, w0
ffffffff4003b0c8:	b9403fe1 	ldr	w1, [sp, #60]
ffffffff4003b0cc:	0a000020 	and	w0, w1, w0
ffffffff4003b0d0:	b9003fe0 	str	w0, [sp, #60]
	if (is_edge)
ffffffff4003b0d4:	b9401be0 	ldr	w0, [sp, #24]
ffffffff4003b0d8:	7100001f 	cmp	w0, #0x0
ffffffff4003b0dc:	54000100 	b.eq	ffffffff4003b0fc <gd_spi_setcfg+0xc4>  // b.none
		rval |= 0x02 << bitpos;
ffffffff4003b0e0:	b94033e0 	ldr	w0, [sp, #48]
ffffffff4003b0e4:	52800041 	mov	w1, #0x2                   	// #2
ffffffff4003b0e8:	1ac02020 	lsl	w0, w1, w0
ffffffff4003b0ec:	2a0003e1 	mov	w1, w0
ffffffff4003b0f0:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff4003b0f4:	2a010000 	orr	w0, w0, w1
ffffffff4003b0f8:	b9003fe0 	str	w0, [sp, #60]
	GICD_REG(GICD_ICFG+ 4*offset) = rval;	
ffffffff4003b0fc:	b94037e0 	ldr	w0, [sp, #52]
ffffffff4003b100:	531e7400 	lsl	w0, w0, #2
ffffffff4003b104:	93407c00 	sxtw	x0, w0
ffffffff4003b108:	90000541 	adrp	x1, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003b10c:	9120c021 	add	x1, x1, #0x830
ffffffff4003b110:	f9400021 	ldr	x1, [x1]
ffffffff4003b114:	8b010000 	add	x0, x0, x1
ffffffff4003b118:	91300000 	add	x0, x0, #0xc00
ffffffff4003b11c:	aa0003e1 	mov	x1, x0
ffffffff4003b120:	b9403fe0 	ldr	w0, [sp, #60]
ffffffff4003b124:	f9000020 	str	x0, [x1]
}
ffffffff4003b128:	d503201f 	nop
ffffffff4003b12c:	a8c47bfd 	ldp	x29, x30, [sp], #64
ffffffff4003b130:	d65f03c0 	ret

ffffffff4003b134 <gic_dist_configure>:

/*
 * TODO: process itype other than SPI
 */
static void gic_dist_configure(int itype, int num)
{
ffffffff4003b134:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff4003b138:	910003fd 	mov	x29, sp
ffffffff4003b13c:	b9001fe0 	str	w0, [sp, #28]
ffffffff4003b140:	b9001be1 	str	w1, [sp, #24]
	int spi= num;
ffffffff4003b144:	b9401be0 	ldr	w0, [sp, #24]
ffffffff4003b148:	b9002fe0 	str	w0, [sp, #44]
	gd_spi_setcfg(spi, 1);
ffffffff4003b14c:	52800021 	mov	w1, #0x1                   	// #1
ffffffff4003b150:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff4003b154:	97ffffb9 	bl	ffffffff4003b038 <gd_spi_setcfg>
	gd_spi_enable(spi);
ffffffff4003b158:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff4003b15c:	97ffff71 	bl	ffffffff4003af20 <gd_spi_enable>
	gd_spi_group0(spi);
ffffffff4003b160:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff4003b164:	97ffff7c 	bl	ffffffff4003af54 <gd_spi_group0>
	gd_spi_target0(spi);
ffffffff4003b168:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff4003b16c:	97ffff7f 	bl	ffffffff4003af68 <gd_spi_target0>
}
ffffffff4003b170:	d503201f 	nop
ffffffff4003b174:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff4003b178:	d65f03c0 	ret

ffffffff4003b17c <gic_dist_init>:
 * initial every spi pin 
 */
static void gic_dist_init() 
{
	/* cprintf("Found gic type: 0x%x\n", GICD_REG(GICD_TYPER)); here is 0x4 **/
}
ffffffff4003b17c:	d503201f 	nop
ffffffff4003b180:	d65f03c0 	ret

ffffffff4003b184 <gic_cpu_init>:
 *
 */
static void gic_cpu_init() 
{
	/* cprintf("gic cpuif type:0x%x\n", GICC_REG(GICC_IIDR)); no simulate in qemu */
	GICC_REG(GICC_PMR) = 0x0f; /* priority value 0 to 0xe is supported */
ffffffff4003b184:	90000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003b188:	9120c000 	add	x0, x0, #0x830
ffffffff4003b18c:	f9400000 	ldr	x0, [x0]
ffffffff4003b190:	aa0003e1 	mov	x1, x0
ffffffff4003b194:	d2800080 	mov	x0, #0x4                   	// #4
ffffffff4003b198:	f2a00020 	movk	x0, #0x1, lsl #16
ffffffff4003b19c:	8b000020 	add	x0, x1, x0
ffffffff4003b1a0:	aa0003e1 	mov	x1, x0
ffffffff4003b1a4:	d28001e0 	mov	x0, #0xf                   	// #15
ffffffff4003b1a8:	f9000020 	str	x0, [x1]
}
ffffffff4003b1ac:	d503201f 	nop
ffffffff4003b1b0:	d65f03c0 	ret

ffffffff4003b1b4 <gic_enable>:

/* enable group 0 only
 */
static void gic_enable()
{
	GICD_REG(GICD_CTLR) |= 1;
ffffffff4003b1b4:	90000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003b1b8:	9120c000 	add	x0, x0, #0x830
ffffffff4003b1bc:	f9400000 	ldr	x0, [x0]
ffffffff4003b1c0:	f9400001 	ldr	x1, [x0]
ffffffff4003b1c4:	90000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003b1c8:	9120c000 	add	x0, x0, #0x830
ffffffff4003b1cc:	f9400000 	ldr	x0, [x0]
ffffffff4003b1d0:	b2400021 	orr	x1, x1, #0x1
ffffffff4003b1d4:	f9000001 	str	x1, [x0]
	GICC_REG(GICC_CTLR) |= 1;
ffffffff4003b1d8:	90000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003b1dc:	9120c000 	add	x0, x0, #0x830
ffffffff4003b1e0:	f9400000 	ldr	x0, [x0]
ffffffff4003b1e4:	91404000 	add	x0, x0, #0x10, lsl #12
ffffffff4003b1e8:	f9400000 	ldr	x0, [x0]
ffffffff4003b1ec:	90000541 	adrp	x1, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003b1f0:	9120c021 	add	x1, x1, #0x830
ffffffff4003b1f4:	f9400021 	ldr	x1, [x1]
ffffffff4003b1f8:	91404021 	add	x1, x1, #0x10, lsl #12
ffffffff4003b1fc:	b2400000 	orr	x0, x0, #0x1
ffffffff4003b200:	f9000020 	str	x0, [x1]
}
ffffffff4003b204:	d503201f 	nop
ffffffff4003b208:	d65f03c0 	ret

ffffffff4003b20c <gic_disable>:

/* disable group 0 only
 */
void gic_disable()
{
	GICD_REG(GICD_CTLR) &= ~(uint)1;
ffffffff4003b20c:	90000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003b210:	9120c000 	add	x0, x0, #0x830
ffffffff4003b214:	f9400000 	ldr	x0, [x0]
ffffffff4003b218:	f9400001 	ldr	x1, [x0]
ffffffff4003b21c:	90000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003b220:	9120c000 	add	x0, x0, #0x830
ffffffff4003b224:	f9400000 	ldr	x0, [x0]
ffffffff4003b228:	927f7821 	and	x1, x1, #0xfffffffe
ffffffff4003b22c:	f9000001 	str	x1, [x0]
	GICD_REG(GICC_CTLR) &= ~(uint)1;
ffffffff4003b230:	90000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003b234:	9120c000 	add	x0, x0, #0x830
ffffffff4003b238:	f9400000 	ldr	x0, [x0]
ffffffff4003b23c:	f9400001 	ldr	x1, [x0]
ffffffff4003b240:	90000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003b244:	9120c000 	add	x0, x0, #0x830
ffffffff4003b248:	f9400000 	ldr	x0, [x0]
ffffffff4003b24c:	927f7821 	and	x1, x1, #0xfffffffe
ffffffff4003b250:	f9000001 	str	x1, [x0]
}
ffffffff4003b254:	d503201f 	nop
ffffffff4003b258:	d65f03c0 	ret

ffffffff4003b25c <gic_configure>:
/* configure and enable interrupt
 */
static void gic_configure(int itype, int num)
{
ffffffff4003b25c:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff4003b260:	910003fd 	mov	x29, sp
ffffffff4003b264:	b9001fe0 	str	w0, [sp, #28]
ffffffff4003b268:	b9001be1 	str	w1, [sp, #24]
	gic_dist_configure(itype, num);
ffffffff4003b26c:	b9401be1 	ldr	w1, [sp, #24]
ffffffff4003b270:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003b274:	97ffffb0 	bl	ffffffff4003b134 <gic_dist_configure>
}
ffffffff4003b278:	d503201f 	nop
ffffffff4003b27c:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff4003b280:	d65f03c0 	ret

ffffffff4003b284 <gic_eoi>:

void gic_eoi(int intn)
{
ffffffff4003b284:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff4003b288:	910003fd 	mov	x29, sp
ffffffff4003b28c:	b9001fe0 	str	w0, [sp, #28]
	GICC_REG(GICC_EOIR) = spi2id(intn);
ffffffff4003b290:	b9401fe0 	ldr	w0, [sp, #28]
ffffffff4003b294:	97ffff1d 	bl	ffffffff4003af08 <spi2id>
ffffffff4003b298:	2a0003e2 	mov	w2, w0
ffffffff4003b29c:	90000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003b2a0:	9120c000 	add	x0, x0, #0x830
ffffffff4003b2a4:	f9400000 	ldr	x0, [x0]
ffffffff4003b2a8:	aa0003e1 	mov	x1, x0
ffffffff4003b2ac:	d2800200 	mov	x0, #0x10                  	// #16
ffffffff4003b2b0:	f2a00020 	movk	x0, #0x1, lsl #16
ffffffff4003b2b4:	8b000020 	add	x0, x1, x0
ffffffff4003b2b8:	aa0003e1 	mov	x1, x0
ffffffff4003b2bc:	93407c40 	sxtw	x0, w2
ffffffff4003b2c0:	f9000020 	str	x0, [x1]
}
ffffffff4003b2c4:	d503201f 	nop
ffffffff4003b2c8:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff4003b2cc:	d65f03c0 	ret

ffffffff4003b2d0 <gic_getack>:

int gic_getack()
{
	return GICC_REG(GICC_IAR);
ffffffff4003b2d0:	90000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003b2d4:	9120c000 	add	x0, x0, #0x830
ffffffff4003b2d8:	f9400000 	ldr	x0, [x0]
ffffffff4003b2dc:	aa0003e1 	mov	x1, x0
ffffffff4003b2e0:	d2800180 	mov	x0, #0xc                   	// #12
ffffffff4003b2e4:	f2a00020 	movk	x0, #0x1, lsl #16
ffffffff4003b2e8:	8b000020 	add	x0, x1, x0
ffffffff4003b2ec:	f9400000 	ldr	x0, [x0]
}
ffffffff4003b2f0:	d65f03c0 	ret

ffffffff4003b2f4 <default_isr>:
#define NUM_INTSRC		32 // numbers of interrupt source supported

static ISR isrs[NUM_INTSRC];

static void default_isr (struct trapframe *tf, int n)
{
ffffffff4003b2f4:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff4003b2f8:	910003fd 	mov	x29, sp
ffffffff4003b2fc:	f9000fe0 	str	x0, [sp, #24]
ffffffff4003b300:	b90017e1 	str	w1, [sp, #20]
    cprintf ("unhandled interrupt: %d\n", n);
ffffffff4003b304:	b94017e1 	ldr	w1, [sp, #20]
ffffffff4003b308:	90000000 	adrp	x0, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003b30c:	91384000 	add	x0, x0, #0xe10
ffffffff4003b310:	97ffd8d9 	bl	ffffffff40031674 <cprintf>
}
ffffffff4003b314:	d503201f 	nop
ffffffff4003b318:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff4003b31c:	d65f03c0 	ret

ffffffff4003b320 <pic_enable>:


void pic_enable (int n, ISR isr)
{
ffffffff4003b320:	d10043ff 	sub	sp, sp, #0x10
ffffffff4003b324:	b9000fe0 	str	w0, [sp, #12]
ffffffff4003b328:	f90003e1 	str	x1, [sp]
	if(n < NUM_INTSRC) {
ffffffff4003b32c:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff4003b330:	71007c1f 	cmp	w0, #0x1f
ffffffff4003b334:	540000cc 	b.gt	ffffffff4003b34c <pic_enable+0x2c>
		isrs[n] = isr;
ffffffff4003b338:	90000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003b33c:	9120e000 	add	x0, x0, #0x838
ffffffff4003b340:	b9800fe1 	ldrsw	x1, [sp, #12]
ffffffff4003b344:	f94003e2 	ldr	x2, [sp]
ffffffff4003b348:	f8217802 	str	x2, [x0, x1, lsl #3]
	}
}
ffffffff4003b34c:	d503201f 	nop
ffffffff4003b350:	910043ff 	add	sp, sp, #0x10
ffffffff4003b354:	d65f03c0 	ret

ffffffff4003b358 <isr_init>:

void isr_init()
{
ffffffff4003b358:	d10043ff 	sub	sp, sp, #0x10
	int i;
	for (i=0; i< NUM_INTSRC; i++)
ffffffff4003b35c:	b9000fff 	str	wzr, [sp, #12]
ffffffff4003b360:	1400000a 	b	ffffffff4003b388 <isr_init+0x30>
		isrs[i] = default_isr;
ffffffff4003b364:	90000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003b368:	9120e000 	add	x0, x0, #0x838
ffffffff4003b36c:	b9800fe1 	ldrsw	x1, [sp, #12]
ffffffff4003b370:	90000002 	adrp	x2, ffffffff4003b000 <gd_spi_target0+0x98>
ffffffff4003b374:	910bd042 	add	x2, x2, #0x2f4
ffffffff4003b378:	f8217802 	str	x2, [x0, x1, lsl #3]
	for (i=0; i< NUM_INTSRC; i++)
ffffffff4003b37c:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff4003b380:	11000400 	add	w0, w0, #0x1
ffffffff4003b384:	b9000fe0 	str	w0, [sp, #12]
ffffffff4003b388:	b9400fe0 	ldr	w0, [sp, #12]
ffffffff4003b38c:	71007c1f 	cmp	w0, #0x1f
ffffffff4003b390:	54fffead 	b.le	ffffffff4003b364 <isr_init+0xc>
}
ffffffff4003b394:	d503201f 	nop
ffffffff4003b398:	d503201f 	nop
ffffffff4003b39c:	910043ff 	add	sp, sp, #0x10
ffffffff4003b3a0:	d65f03c0 	ret

ffffffff4003b3a4 <gic_init>:
/*
 * This section init gic according to CORTEX A15 reference manual
 * 8.3.1 distributor register and 8.3.2 
 */
void gic_init(void * base)
{
ffffffff4003b3a4:	a9be7bfd 	stp	x29, x30, [sp, #-32]!
ffffffff4003b3a8:	910003fd 	mov	x29, sp
ffffffff4003b3ac:	f9000fe0 	str	x0, [sp, #24]
	gic_base = base;
ffffffff4003b3b0:	90000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003b3b4:	9120c000 	add	x0, x0, #0x830
ffffffff4003b3b8:	f9400fe1 	ldr	x1, [sp, #24]
ffffffff4003b3bc:	f9000001 	str	x1, [x0]
	gic_dist_init();
ffffffff4003b3c0:	97ffff6f 	bl	ffffffff4003b17c <gic_dist_init>
	gic_cpu_init();
ffffffff4003b3c4:	97ffff70 	bl	ffffffff4003b184 <gic_cpu_init>
	isr_init();
ffffffff4003b3c8:	97ffffe4 	bl	ffffffff4003b358 <isr_init>

	gic_configure(SPI_TYPE, PIC_TIMER01);
ffffffff4003b3cc:	528001a1 	mov	w1, #0xd                   	// #13
ffffffff4003b3d0:	52800060 	mov	w0, #0x3                   	// #3
ffffffff4003b3d4:	97ffffa2 	bl	ffffffff4003b25c <gic_configure>
	gic_configure(SPI_TYPE, PIC_TIMER23);
ffffffff4003b3d8:	52800161 	mov	w1, #0xb                   	// #11
ffffffff4003b3dc:	52800060 	mov	w0, #0x3                   	// #3
ffffffff4003b3e0:	97ffff9f 	bl	ffffffff4003b25c <gic_configure>
	gic_configure(SPI_TYPE, PIC_UART0);
ffffffff4003b3e4:	52800021 	mov	w1, #0x1                   	// #1
ffffffff4003b3e8:	52800060 	mov	w0, #0x3                   	// #3
ffffffff4003b3ec:	97ffff9c 	bl	ffffffff4003b25c <gic_configure>

	gic_enable();
ffffffff4003b3f0:	97ffff71 	bl	ffffffff4003b1b4 <gic_enable>

}
ffffffff4003b3f4:	d503201f 	nop
ffffffff4003b3f8:	a8c27bfd 	ldp	x29, x30, [sp], #32
ffffffff4003b3fc:	d65f03c0 	ret

ffffffff4003b400 <pic_dispatch>:

/*
 * dispatch the interrupt
 */
void pic_dispatch (struct trapframe *tp)
{
ffffffff4003b400:	a9bd7bfd 	stp	x29, x30, [sp, #-48]!
ffffffff4003b404:	910003fd 	mov	x29, sp
ffffffff4003b408:	f9000fe0 	str	x0, [sp, #24]
	int intid, intn;
	intid = gic_getack(); /* iack */
ffffffff4003b40c:	97ffffb1 	bl	ffffffff4003b2d0 <gic_getack>
ffffffff4003b410:	b9002fe0 	str	w0, [sp, #44]
	intn = intid - 32;
ffffffff4003b414:	b9402fe0 	ldr	w0, [sp, #44]
ffffffff4003b418:	51008000 	sub	w0, w0, #0x20
ffffffff4003b41c:	b9002be0 	str	w0, [sp, #40]
	/* TODO: int disable here? **/
	isrs[intn](tp, intn);
ffffffff4003b420:	90000540 	adrp	x0, ffffffff400e3000 <ptable+0x30c0>
ffffffff4003b424:	9120e000 	add	x0, x0, #0x838
ffffffff4003b428:	b9802be1 	ldrsw	x1, [sp, #40]
ffffffff4003b42c:	f8617802 	ldr	x2, [x0, x1, lsl #3]
ffffffff4003b430:	b9402be1 	ldr	w1, [sp, #40]
ffffffff4003b434:	f9400fe0 	ldr	x0, [sp, #24]
ffffffff4003b438:	d63f0040 	blr	x2
	gic_eoi(intn);
ffffffff4003b43c:	b9402be0 	ldr	w0, [sp, #40]
ffffffff4003b440:	97ffff91 	bl	ffffffff4003b284 <gic_eoi>
}
ffffffff4003b444:	d503201f 	nop
ffffffff4003b448:	a8c37bfd 	ldp	x29, x30, [sp], #48
ffffffff4003b44c:	d65f03c0 	ret
