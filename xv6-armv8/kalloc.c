// Physical memory allocator, intended to allocate
// memory for user processes, kernel stacks, page table pages,
// and pipe buffers. Allocates 4096-byte pages.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "spinlock.h"
#include "arm.h"
#define PA2IDX(pa) (((uint64)(pa) - PHY_START) / PTE_SZ)
int page_refcount[((PHYSTOP - PHY_START) / PTE_SZ)]; // max reference count for each page

void freerange(void *vstart, void *vend);
extern char end[]; // first address after kernel loaded from ELF file

struct run {
    struct run *next;
};

static struct {
    struct spinlock lock;
    int use_lock;
    struct run *freelist;
} kmem;

// Initialization happens in two phases.
// 1. main() calls kinit1() while still using entrypgdir to place just
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void kinit1(void *vstart, void *vend)
{
    freerange(vstart, vend);
}

void kinit2(void *vstart, void *vend)
{
    freerange(vstart, vend);
    kmem.use_lock = 1;
}

void freerange(void *vstart, void *vend)
{
    char *p;

    p = (char*)align_up (vstart, PTE_SZ);

    for(; p + PTE_SZ <= (char*)vend; p += PTE_SZ) {
        page_refcount[PA2IDX(v2p(p))] = 1;
         kfree_page(p);
    }
       
    
}

//PAGEBREAK: 21
// Free the page of physical memory pointed at by v,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void kfree_page(char *v)
{
    
    struct run *r;

    if((uint64)v % PTE_SZ || v < end || v2p(v) >= PHYSTOP) {
        cprintf("kfree_page(0x%x)\n", v);
        panic("kfree_page");
    }

    // Fill with junk to catch dangling refs.
    //memset(v, 0x00, PG_SIZE);

    if(kmem.use_lock) {
        acquire(&kmem.lock);
    }

    page_refcount[PA2IDX(v2p(v))] -= 1;

    r = (struct run*)v;
    if(page_refcount[PA2IDX(v2p(v))] == 0){
    r->next = kmem.freelist;
    }
    if(page_refcount[PA2IDX(v2p(v))] > 0){
        if(kmem.use_lock) {
            release(&kmem.lock);
        }
        return;
    }
    kmem.freelist = r;

    if(kmem.use_lock) {
        release(&kmem.lock);
    }
}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char* kalloc(void)
{
    struct run *r;

    if(kmem.use_lock) {
        acquire(&kmem.lock);
    }

    r = kmem.freelist;

    if(r) {
        kmem.freelist = r->next;
    }

    if(kmem.use_lock) {
        release(&kmem.lock);
    }
    if(r){
    page_refcount[PA2IDX(v2p(r))] = 1;
    }
    return (char*)r;
}

void kpage_ref(void *pa){
    if(kmem.use_lock) {
        acquire(&kmem.lock);
    }
    if(pa != NULL){
    page_refcount[PA2IDX((uint64)pa)] += 1;
    }
    if(kmem.use_lock) {
        release(&kmem.lock);
    }
}

