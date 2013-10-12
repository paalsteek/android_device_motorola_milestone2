#
# Copyright (C) 2011 The Android Open Source Project
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

#
# This is the product configuration for a generic Motorola Milestone2 (milestone2)
#

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_eu_supl.mk)

$(call inherit-product, vendor/motorola/milestone2/milestone2-vendor.mk)

## (3)  Finally, the least specific parts, i.e. the non-GSM-specific aspects
PRODUCT_PROPERTY_OVERRIDES += \
    dalvik.vm.checkjni=false \
    dalvik.vm.dexopt-data-only=1 \
    dalvik.vm.heapmaxfree=2m \
    dalvik.vm.heapminfree=512k \
    dalvik.vm.heapsize=128m \
    dalvik.vm.heaptargetutilization=0.25 \
    dalvik.vm.lockprof.threshold=500 \
    net.dns1=8.25.56.26 \
    net.dns2=8.8.8.8 \
    persist.ril.enable=1 \
    persist.service.swiqi.enable=1 \
    ro.adb.secure=0 \
    ro.bq.gpu_to_cpu_unsupported=1 \
    ro.com.google.locationfeatures=1 \
    ro.hwui.disable_scissor_opt=true \
    ro.hwui.layer_cache_size=8 \
    ro.hwui.path_cache_size=2 \
    ro.hwui.texture_cache_size=12 \
    ro.kernel.android.checkjni=0 \
    ro.media.capture.classification=classE \
    ro.media.capture.flashIntensity=41 \
    ro.media.capture.flash=led \
    ro.media.capture.maxres=5m \
    ro.media.capture.torchIntensity=25 \
    ro.media.dec.jpeg.memcap=20000000 \
    ro.privacy.send.notification=off \
    ro.service.swiqi.supported=true \
    ro.sf.lcd_density=240 \
    ro.telephony.call_ring.delay=3000 \
    ro.telephony.call_ring.multiple=false \
    ro.url.safetylegal=http://www.motorola.com/staticfiles/Support/legal/?model=ME722 \
    ro.use.fl.rec.boot.upgrade=1 \
    ro.vold.umsdirtyratio=20

# Engle, add bluetooth    
PRODUCT_PACKAGES += bluetoothd libbluetooth libbluetoothd libbtio liba2dp audio.a2dp.milestone2 libnetcmdiface libdashplayer

# Engle add hardware encode/decode support
PRODUCT_PACKAGES += libstagefrighthw libstagefright_foundation

# Engle, 添加防火墙
#PRODUCT_PACKAGES += MobileSecretary Android-Autostarts
PRODUCT_PACKAGES += Android-Autostarts
# Add CMAccount support
PRODUCT_PACKAGES += volley CMAccount

# we have enough storage space to hold precise GC data
PRODUCT_TAGS += dalvik.gc.type-precise

DEVICE_PACKAGE_OVERLAYS += device/moto/milestone2/overlay

# Permissions
PRODUCT_COPY_FILES += \
	frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
	frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
	frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
	frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
	frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
	frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
	frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
	frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
	frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
	frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
	frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
	packages/wallpapers/LivePicker/android.software.live_wallpaper.xml:/system/etc/permissions/android.software.live_wallpaper.xml \


# FIXME in repo 
PRODUCT_PACKAGES += rild

# Radio fixes
# FRAMEWORKS_BASE_SUBDIRS += ../../$(LOCAL_PATH)/ril/

# recovery
PRODUCT_PACKAGES += recovery 
# ICS sound
PRODUCT_PACKAGES += \
	hcitool hciattach hcidump \
	libaudioutils audio.a2dp.default  \
	libaudiohw_legacy \
	bluetoothd \
	libbluetooth \
	libbluetoothd \
	libbtio \
	liba2dp \
	audio.a2dp.\
	milestone2 \
	libnetcmdiface \
	libdashplayer \
	dbus-daemon \
	libdbus \

# Engle should not add power.omap2, it has bug
#PRODUCT_PACKAGES += hwcomposer.default power.omap3
# PRODUCT_PACKAGES += hwcomposer.default

# Wifi packages
PRODUCT_PACKAGES += iwmulticall hostap wlan_loader wlan_cu wpa_supplicant
PRODUCT_PACKAGES += libhostapdcli libCustomWifi libwpa_client libtiOsLib
PRODUCT_PACKAGES += dhcpcd.conf hostapd.conf
PRODUCT_PACKAGES += tiap_loader tiap_cu ndc

# OMX stuff
PRODUCT_PACKAGES += dspexec libbridge libLCML libOMX_Core libstagefrighthw
PRODUCT_PACKAGES += libOMX.TI.AAC.encode libOMX.TI.AAC.decode libOMX.TI.AMR.decode libOMX.TI.AMR.encode
PRODUCT_PACKAGES += libOMX.TI.WBAMR.encode libOMX.TI.MP3.decode libOMX.TI.WBAMR.decode
PRODUCT_PACKAGES += libOMX.TI.Video.Decoder libOMX.TI.Video.encoder
PRODUCT_PACKAGES += libOMX.TI.JPEG.Encoder

# Milestone2 stuff
PRODUCT_PACKAGES += M2Parts
PRODUCT_PACKAGES += libfnc Usb

# Core stuff
PRODUCT_PACKAGES += charge_only_mode mot_boot_mode

# Publish that we support the live wallpaper feature.
PRODUCT_PACKAGES += librs_jni

# CM9 apps
PRODUCT_PACKAGES += CMFileManager Torch HwaSettings make_ext4fs

# Live wallpapers
PRODUCT_PACKAGES += LiveWallpapers LiveWallpapersPicker

#Engle, OTA Updater
# PRODUCT_PACKAGES += OTAUpdateCenter

#Engle, Log Colletor
PRODUCT_PACKAGES += LogCollector

#Engle, Swapper
# PRODUCT_PACKAGES += Swapper

# Experimental TI OpenLink
PRODUCT_PACKAGES += libnl_2 iw

PRODUCT_COPY_FILES += \
    $(OUT)/ramdisk.img:system/bootmenu/2nd-boot/ramdisk \
    $(OUT)/kernel:system/bootmenu/2nd-boot/zImage \
    system/bluetooth/data/main.conf:system/etc/bluetooth/main.conf \
    system/bluetooth/data/audio.conf:system/etc/bluetooth/audio.conf \
    system/bluetooth/data/auto_pairing.conf:system/etc/bluetooth/auto_pairing.conf \
    system/bluetooth/data/blacklist.conf:system/etc/bluetooth/blacklist.conf \
    system/bluetooth/data/input.conf:system/etc/bluetooth/input.conf \
    system/bluetooth/data/network.conf:system/etc/bluetooth/network.conf \


#    $(OUT)/utilities/lsof:system/bootmenu/binary/lsof \

# Blobs and bootmenu stuff
$(call inherit-product, device/moto/milestone2/milestone2-blobs.mk)
$(call inherit-product, device/moto/milestone2/bootmenu/bootmenu.mk)

$(call inherit-product, build/target/product/full_base.mk)
$(call inherit-product, frameworks/native/build/phone-hdpi-512-dalvik-heap.mk)

# Should be after the full_base include, which loads languages_full
PRODUCT_LOCALES += hdpi

PRODUCT_NAME := full_milestone2
PRODUCT_DEVICE := ME722

