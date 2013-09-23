#ifndef __IMAGES_H__
#define __IMAGES_H__
#include "types.h"
#include "buffers.h"

// Engle, 使用官方内核的地址避免crc32检查出错, https://github.com/Quarx2k/android_device_moto_jordan-common/commit/2b0682baf7474defa1c875baebf856eaf95d6f1a
#define KERNEL_DEST     0x83000000
#define RAMDISK_DEST    0x84000000
#define DEVTREE_DEST    0x85000000
#define CMDLINE_DEST    0x85100000

struct memory_image 
{
  void *data;
  size_t size;
};

struct buffer_handle 
{
	struct abstract_buffer abstract;
	void *rest;
	addr_t dest;
	uint32_t maxsize;
	uint32_t attrs;
	char name[0x24];
};

struct memory_image *image_find(uint8_t tag, struct memory_image *dest);
struct memory_image *image_unpack(uint8_t tag, struct memory_image *dest);

// Engle, 冷重置在一个关键的错误（包括CRC失败） https://github.com/Quarx2k/android_device_moto_jordan-common/commit/4824c9f9425c3de792dd160330ec5c5cb9afc8ea
int image_complete();

#endif // __IMAGES_H__
