#ifndef GUARD_ALLOC_H
#define GUARD_ALLOC_H


#define FREE_AND_SET_NULL(ptr)          \
{                                       \
    Free(ptr);                          \
    ptr = NULL;                         \
}

#define TRY_FREE_AND_SET_NULL(ptr) if (ptr != NULL) FREE_AND_SET_NULL(ptr)

// 122 KB. Max size of the heap without running into other data
#define HEAP_SIZE 0x1C000
extern u8 gHeap[];

void *Alloc(u32 size);
void *AllocZeroed(u32 size);
void Free(void *pointer);
void InitHeap(void *pointer, u32 size);

#endif // GUARD_ALLOC_H
