obj-m := cpufreq_boostedASS2.o


#point CCPATH to your toolchain in your compiled Android Source
#point KERNEL_DIR to your device kernel source
#See README for example

CCPATH := ~/path/to/your/toolchain/arm-eabi-4.4.3/bin
CROSS_COMPILE=$(CCPATH)/arm-eabi-
KERNEL_DIR ?= ~/path/to/device/kernel

all:
	$(MAKE) -C $(KERNEL_DIR) M=`pwd` ARCH=arm CROSS_COMPILE=$(CROSS_COMPILE) modules

clean:
	rm -rf *.o *~ core .depend .*.cmd *.ko *.mod.c .tmp_versions modules.order Module.symvers Module.markers

strip:
	for i in `ls | grep .ko`; do $(CROSS_COMPILE)strip --strip-debug $$i; done
	rm -rf *.o *~ core .depend .*.cmd *.mod.c .tmp_versions modules.order Module.symvers Module.markers
