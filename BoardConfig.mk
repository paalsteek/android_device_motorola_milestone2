# Copyright (C) 2013 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# This file sets variables that control the way modules are built
# thorughout the system. It should not be used to conditionally
# disable makefiles (the proper mechanism to control what gets
# included in a build is to use PRODUCT_PACKAGES in a product
# definition file).
#

# WARNING: This line must come *before* including the proprietary
# variant, so that it gets overwritten by the parent (which goes
# against the traditional rules of inheritance).


#Engle, 只编译英文和中文
PRODUCT_LOCALES := zh_CN en_US
WITH_DEXPREOPT := true
WITH_GMS := true
USE_PREBUILT_RECOVERY := true

#Engle, SELINUX
HAVE_SELINUX := true
POLICYVERS := 24

# SELinux policies
BOARD_SEPOLICY_DIRS := device/moto/milestone2/selinux
BOARD_SEPOLICY_UNION := \
                         adbd.te \
                         app.te \
                         dpcp.te \
                         init.te \
                         mediaserver.te \
                         radio.te \
                         rild.te \
                         shell.te \
                         surfaceflinger.te \
                         system.te \
                         vold.te \

BOARD_SEPOLICY_REPLACE := assert.te

TARGET_CUSTOM_RELEASETOOL := ./device/moto/milestone2/releasetools/squisher

BOARD_USES_GENERIC_AUDIO := false

TARGET_NO_RADIOIMAGE := true
TARGET_NO_BOOTLOADER := true
TARGET_NO_PREINSTALL := true
TARGET_BOOTLOADER_BOARD_NAME := milestone2

# Board properties
# TARGET_GCC_VERSION_EXP := 4.6
TARGET_ARCH := arm
TARGET_BOARD_PLATFORM := omap3
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_ARCH_VARIANT_CPU := cortex-a8
TARGET_ARCH_VARIANT_FPU := neon
TARGET_CPU_VARIANT := cortex-a8

# Dalvik startup with a low memory footprint, refer to http://review.cyanogenmod.org/#/c/47757/
TARGET_ARCH_LOWMEM := true

# Engle, 添加FPU优化
#ARCH_ARM_HAVE_NEON := true
#OMAP_ENHANCEMENT := true
TARGET_OMAP3 := true
ARCH_ARM_HAVE_TLS_REGISTER := true
# Engle, 添加NEON对Bitmap在GC中的优化
#TARGET_USE_KRAIT_BIONIC_OPTIMIZATION ：= true
COMMON_GLOBAL_CFLAGS += -DTARGET_OMAP3 -DOMAP_COMPAT -DBINDER_COMPAT -DHAVE_SELINUX
COMMON_GLOBAL_CPPFLAGS += -DHAVE_SELINUX
ifdef OMAP_ENHANCEMENT
COMMON_GLOBAL_CFLAGS += -DOMAP_ENHANCEMENT -DTARGET_OMAP3 -DOMAP_ENHANCEMENT_CPCAM -DOMAP_ENHANCEMENT_VTC
endif

TARGET_GLOBAL_CFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mtune=cortex-a8 -mfpu=neon -mfloat-abi=softfp 
TARGET_arm_CFLAGS := mtune=cortex-a8 -mfpu=neon -O3

#TARGET_GLOBAL_CFLAGS += -O2 -mtune=cortex-a8 -march=armv7-a -mfpu=neon -mfloat-abi=softfp -funroll-loops
#TARGET_GLOBAL_CPPFLAGS += -O2 -mtune=cortex-a8 -march=armv7-a -mfpu=neon -mfloat-abi=softfp -funroll-loops
#TARGET_arm_CFLAGS := -O2 -mtune=cortex-a8 -march=armv7-a -mfpu=neon -mfloat-abi=softfp -funroll-loops
#TARGET_arm_CFLAGS := -O3 -fomit-frame-pointer -fstrict-aliasing -funswitch-loops \
#                       -fmodulo-sched -fmodulo-sched-allow-regmoves
#TARGET_thumb_CFLAGS := -mthumb \
#                        -O2 \
#                        -fomit-frame-pointer \
#                        -fstrict-aliasing

# Wifi related defines
CONFIG_DRIVER_CUSTOM        := true
BOARD_WLAN_DEVICE           := wl1271
WPA_SUPPLICANT_VERSION      := VER_0_6_X
BOARD_WPA_SUPPLICANT_DRIVER := CUSTOM
WIFI_DRIVER_MODULE_PATH     := "/system/lib/modules/tiwlan_drv.ko"
WIFI_DRIVER_MODULE_NAME     := tiwlan_drv
WIFI_DRIVER_FW_STA_PATH     := "/system/etc/wifi/fw_wlan1271.bin"
WIFI_FIRMWARE_LOADER        := wlan_loader
PRODUCT_WIRELESS_TOOLS      := true
BOARD_SOFTAP_DEVICE         := wl1271
AP_CONFIG_DRIVER_WILINK     := true
AP_CONFIG_IEEE80211N        := true
WIFI_DRIVER_FW_AP_PATH      := "/system/etc/wifi/fw_tiwlan_ap.bin"
WPA_SUPPL_APPROX_USE_RSSI   := true
WPA_SUPPL_WITH_SIGNAL_POLL  := false
USES_TI_MAC80211            := true
# CM9
WIFI_DRIVER_LOADER_DELAY    := 200000
WIFI_AP_DRIVER_MODULE_PATH  := "/system/lib/modules/tiap_drv.ko"
WIFI_AP_DRIVER_MODULE_NAME  := tiap_drv
WIFI_AP_FIRMWARE_LOADER     := wlan_ap_loader
WIFI_AP_DRIVER_MODULE_ARG   := ""
BOARD_HOSTAPD_SERVICE_NAME  := hostap_netd
BOARD_HOSTAPD_NO_ENTROPY    := true
BOARD_HOSTAPD_DRIVER        := true
BOARD_HOSTAPD_DRIVER_NAME   := wilink
BOARD_HOSTAPD_TIAP_ROOT     := system/wlan/ti/WiLink_AP

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
TARGET_CUSTOM_BLUEDROID := ../../../device/moto/milestone2/bluedroid.c
# Usb Specific
BOARD_MASS_STORAGE_FILE_PATH := "/sys/devices/platform/usb_mass_storage/lun0/file"
TARGET_USE_CUSTOM_LUN_FILE_PATH := "/sys/devices/platform/usb_mass_storage/lun0/file"
BOARD_MTP_DEVICE := "/dev/mtp"
BOARD_VOLD_EMMC_SHARES_DEV_MAJOR := true

# Build options
TARGET_USERIMAGES_USE_EXT4 := false
BOARD_BOOTIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x00280000)
BOARD_RECOVERYIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x00500000)
BOARD_SYSTEMIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x07500000)
BOARD_USERDATAIMAGE_MAX_SIZE := $(call image-size-from-data-size,0x04ac0000)
# Engle, the 109 sbf system size.
BOARD_OTA_PARTITION_SIZE := 342624256
# Engle, because the OTA will delete some files (50M), so define it large
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 382624256 
BOARD_FLASH_BLOCK_SIZE := 131072

# OMX Stuff
HARDWARE_OMX := true
OMX_JPEG := true
OMX_VENDOR := ti
OMX_VENDOR_INCLUDES := \
   hardware/ti/omx/system/src/openmax_il/omx_core/inc \
   hardware/ti/omx/image/src/openmax_il/jpeg_enc/inc
OMX_VENDOR_WRAPPER := TI_OMX_Wrapper
BOARD_OPENCORE_LIBRARIES := libOMX_Core
BOARD_OPENCORE_FLAGS := -DHARDWARE_OMX=1
TARGET_USE_OMX_RECOVERY := true
TARGET_USE_OMAP_COMPAT  := true
BUILD_WITH_TI_AUDIO := 1
BUILD_PV_VIDEO_ENCODERS := 1

# Bootmenu
BOARD_USES_BOOTMENU := true
BOARD_WITH_CPCAP    := true
BOARD_MMC_DEVICE    := /dev/block/mmcblk1
BOARD_SDCARD_DEVICE_PRIMARY   := /dev/block/mmcblk0p1
BOARD_SDCARD_DEVICE_SECONDARY := /dev/block/mmcblk0
BOARD_SDEXT_DEVICE  := /dev/block/mmcblk0p2
BOARD_SYSTEM_DEVICE := /dev/block/mmcblk1p21
BOARD_DATA_DEVICE   := /dev/block/mmcblk1p26

# Recovery
BOARD_HAS_NO_SELECT_BUTTON := true
TARGET_RECOVERY_FSTAB := device/moto/milestone2/recovery.fstab
TARGET_RECOVERY_INITRC := device/moto/milestone2/profiles/ramdisk/init-recovery.rc

#BOARD_HAS_SMALL_RECOVERY := true
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_HAS_NO_MISC_PARTITION := true
BOARD_USES_MMCUTILS := true
TARGET_RECOVERY_PIXEL_FORMAT := "BGRA_8888"
DEVICE_RESOLUTION := 480x854
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TW_EXTERNAL_STORAGE_PATH := "/sdcard"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "sdcard"
TW_DEFAULT_EXTERNAL_STORAGE := true
TW_FLASH_FROM_STORAGE := true 
BOARD_USE_CUSTOM_RECOVERY_FONT:= \"roboto_10x18.h\"
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_MAX_BRIGHTNESS := 255
TW_NO_BATT_PERCENT := true
TW_NO_REBOOT_RECOVERY := true
TW_NO_REBOOT_BOOTLOADER := true
TW_ALWAYS_RMRF := true

BOARD_RECOVERY_IGNORE_BOOTABLES := true
BOARD_NEVER_UMOUNT_SYSTEM := true
BOARD_CUSTOM_RECOVERY_KEYMAPPING:= ../../device/moto/milestone2/recovery_keys.c
#TARGET_RECOVERY_UI_LIB := librecovery_ui_generic
#TARGET_RECOVERY_UPDATER_LIBS += librecovery_updater_generic
TARGET_RECOVERY_PRE_COMMAND := "/system/bootmenu/script/reboot_command.sh"
TARGET_RECOVERY_PRE_COMMAND_CLEAR_REASON := true
BOARD_UMS_LUNFILE := /sys/class/android_usb/f_mass_storage/lun/file

# Egl Specific
USE_OPENGL_RENDERER := true
BOARD_EGL_CFG := device/moto/milestone2/egl.cfg
BOARD_USE_YUV422I_DEFAULT_COLORFORMAT := true
ENABLE_WEBGL := true
COMMON_GLOBAL_CFLAGS += -DSYSTEMUI_PBSIZE_HACK=1
COMMON_GLOBAL_CFLAGS += -DHAS_CONTEXT_PRIORITY -DDONT_USE_FENCE_SYNC

# TARGET_DISABLE_TRIPLE_BUFFERING can be used to disable triple buffering
# on per target basis. On crespo it is possible to do so in theory
# to save memory, however, there are currently some limitations in the
# OpenGL ES driver that in conjunction with disable triple-buffering
# would hurt performance significantly (see b/6016711)
TARGET_DISABLE_TRIPLE_BUFFERING := false
BOARD_ALLOW_EGL_HIBERNATION := true

# Camera
USE_CAMERA_STUB := false
BOARD_OVERLAY_BASED_CAMERA_HAL := true

# Other..
ENABLE_SENSORS_COMPAT := true
TARGET_PROXIMITY_SENSOR_LIMIT := 0x1F
BOARD_USES_AUDIO_LEGACY := true
ICS_AUDIO_BLOB := true

TARGET_PROVIDES_LIBAUDIO := true
BOARD_USE_KINETO_COMPATIBILITY := true
TARGET_BOOTANIMATION_USE_RGB565 := true
BOARD_USE_HARDCODED_FAST_TRACK_LATENCY_WHEN_DENIED := 160
BOARD_USES_LEGACY_RIL := true
BOARD_USE_LEGACY_SENSORS_FUSION := false

# Release tool
TARGET_PROVIDES_RELEASETOOLS := true
TARGET_RELEASETOOL_OTA_FROM_TARGET_SCRIPT := device/moto/milestone2/releasetools/common_ota_from_target_files

# adb root
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=0
ADDITIONAL_DEFAULT_PROPERTIES += ro.secure=0
ADDITIONAL_DEFAULT_PROPERTIES += ro.allow.mock.location=1

PRODUCT_PROPERTY_OVERRIDES = \
	ro.config.ringtone=Moto.ogg \

BOARD_NEEDS_CUTILS_LOG := true
#TARGET_USE_CUSTOM_SECOND_LUN_NUM := 0

##### Kernel stuff #####
TARGET_MODULES_WIFI_SOURCE := "system/wlan/ti/wilink_6_1/platforms/os/linux/"
TARGET_MODULES_AP_SOURCE := "system/wlan/ti/WiLink_AP/platforms/os/linux/"

API_MAKE := \
	make PREFIX=$(ANDROID_BUILD_TOP)/$(TARGET_OUT_INTERMEDIATES)/kernel_intermediates/build \
	ARCH=arm \
	CROSS_COMPILE=$(ANDROID_BUILD_TOP)/prebuilt/$(HOST_PREBUILT_TAG)/toolchain/arm-eabi-4.4.3/bin/arm-eabi- \
	HOST_PLATFORM=zoom2 \
	KERNEL_DIR=$(TARGET_OUT_INTERMEDIATES)/KERNEL_OBJ \

ext_modules:
	$(API_MAKE) -C $(TARGET_KERNEL_MODULES_EXT) modules
	find $(TARGET_KERNEL_MODULES_EXT)/ -name "*.ko" -exec mv {} \
		$(KERNEL_MODULES_OUT) \; || true
ifneq ($(strip $(USE_PREBUILT_RECOVERY)),true)
	mv $(KERNEL_MODULES_OUT)/hbootmod.ko $(PRODUCT_OUT)/system/bootmenu/2nd-boot/
endif
	$(API_MAKE) clean -C $(TARGET_MODULES_WIFI_SOURCE)
	$(API_MAKE) clean -C $(TARGET_MODULES_AP_SOURCE)
	$(API_MAKE) -C $(TARGET_MODULES_WIFI_SOURCE) HOST_PLATFORM=zoom2 KERNEL_DIR=$(KERNEL_OUT)
	$(API_MAKE) -C $(TARGET_MODULES_AP_SOURCE) HOST_PLATFORM=zoom2 KERNEL_DIR=$(KERNEL_OUT)
	mv $(TARGET_MODULES_WIFI_SOURCE)/tiwlan_drv.ko $(KERNEL_MODULES_OUT)
	mv $(TARGET_MODULES_AP_SOURCE)/tiap_drv.ko $(KERNEL_MODULES_OUT)
	arm-linux-androideabi-strip --strip-unneeded $(KERNEL_MODULES_OUT)/*

hboot:
	mkdir -p $(PRODUCT_OUT)/system/bootmenu/2nd-boot
	echo "$(BOARD_KERNEL_CMDLINE)" > $(PRODUCT_OUT)/system/bootmenu/2nd-boot/cmdline
ifneq ($(strip $(USE_PREBUILT_RECOVERY)),true)
	$(API_MAKE) -C $(ANDROID_BUILD_TOP)/device/moto/milestone2/hboot
	mv $(ANDROID_BUILD_TOP)/device/moto/milestone2/hboot/hboot.bin $(PRODUCT_OUT)/system/bootmenu/2nd-boot/
	$(API_MAKE) clean -C $(ANDROID_BUILD_TOP)/device/moto/milestone2/hboot
else
	cp -rf $(ANDROID_BUILD_TOP)/device/moto/milestone2/prebuilt/bootmenu $(PRODUCT_OUT)/system/
	$(shell if [ -f $(PRODUCT_OUT)/system/lib/modules/hbootmod.ko ]; then rm -r $(PRODUCT_OUT)/system/lib/modules/hbootmod.ko; fi;)

endif
# If kernel sources are present in repo, here is the location
TARGET_KERNEL_SOURCE := $(ANDROID_BUILD_TOP)/kernel/moto/milestone2
TARGET_KERNEL_CUSTOM_TOOLCHAIN := arm-eabi-4.4.3
TARGET_KERNEL_CONFIG  := mapphone_defconfig
BOARD_KERNEL_CMDLINE := console=/dev/null mem=498M init=/init ip=off brdrev=P3A omapfb.vram=0:4M
#TARGET_PREBUILT_KERNEL := $(ANDROID_BUILD_TOP)/device/moto/milestone2/kernel
# Extra : external modules sources
TARGET_KERNEL_MODULES_EXT := $(ANDROID_BUILD_TOP)/device/moto/milestone2/modules/sources/
TARGET_KERNEL_MODULES :=  ext_modules hboot

BOARD_HARDWARE_CLASS := device/moto/milestone2/cmhw/
