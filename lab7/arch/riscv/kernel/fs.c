#include "fs.h"
#include "buf.h"
#include "defs.h"
#include "slub.h"
#include "task_manager.h"
#include "virtio.h"
#include "vm.h"
#include "mm.h"

// --------------------------------------------------
// ----------- read and write interface -------------

void disk_op(int blockno, uint8_t *data, bool write) {
    struct buf b;
    b.disk = 0;
    b.blockno = blockno;
    b.data = (uint8_t *)PHYSICAL_ADDR(data);
    virtio_disk_rw((struct buf *)(PHYSICAL_ADDR(&b)), write);
}

#define disk_read(blockno, data) disk_op((blockno), (data), 0)
#define disk_write(blockno, data) disk_op((blockno), (data), 1)

// -------------------------------------------------
// ------------------ your code --------------------

int sfs_init();

int sfs_open(const char *path, uint32_t flags);

int sfs_close(int fd);

int sfs_seek(int fd, int32_t off, int fromwhere);

int sfs_read(int fd, char *buf, uint32_t len);

int sfs_write(int fd, char *buf, uint32_t len);

int sfs_get_files(const char* path, char* files[]);