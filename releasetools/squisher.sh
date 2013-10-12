# This script is included in squisher
# It is the final build step (after OTA package)

# set in squisher
# DEVICE_OUT=$ANDROID_BUILD_TOP/out/target/product/milestone2
# DEVICE_TOP=$ANDROID_BUILD_TOP/device/moto/milestone2
# VENDOR_TOP=$ANDROID_BUILD_TOP/vendor/motorola/milestone2
# DEVICE_COMMON=$ANDROID_BUILD_TOP/device/moto/milestone2

# Delete unwanted apps
rm -f $REPACK/ota/system/app/RomManager.apk
rm -f $REPACK/ota/system/app/RomManager.odex
rm -f $REPACK/ota/system/app/VideoEditor.apk
rm -f $REPACK/ota/system/app/VideoEditor.odex
rm -f $REPACK/ota/system/lib/libvideoeditor*
PWD_PATH=`pwd`
# Engle 删除Ringtones
cd "$REPACK/ota/system/media/audio/ringtones"
for ring in `ls *.ogg` 
do
    echo "rm $ring"
    if [ "$ring" != "Moto.ogg" ]; then
        rm "$ring"
    fi
done

# 删除 hwcomposer, it is for 3.0 kernel
rm -f $REPACK/ota/system/lib/hw/hwcomposer.default.so

cd "$REPACK/ota/system/lib/hw"
rm -f camera.goldfish.jpeg.so camera.goldfish.so gps.goldfish.so lights.goldfish.so sensors.goldfish.so
cd "$REPACK/ota/system/bin"
rm -f qemud qemu-props

cd "$PWD_PATH"
# Engle 替换物理键盘中的返回键为CTRL键
sed -i "s:key 158   BACK              WAKE_DROPPED:key 158   CTRL_RIGHT        WAKE_DROPPED:g" $REPACK/ota/system/usr/keylayout/sholes-keypad.kl
# Engle delete
rm -f $REPACK/ota/system/app/MotoPhonePortal.apk
# Engle 删除动态壁纸
WALLPAPERS_FILES="CMWallpapers.apk CMWallpapers.odex LiveWallpapers.apk LiveWallpapers.odex VisualizationWallpapers.apk VisualizationWallpapers.odex HoloSpiralWallpaper.apk HoloSpiralWallpaper.odex PhaseBeam.apk PhaseBeam.odex NoiseField.apk NoiseField.odex Galaxy4.apk Galaxy.odex MagicSmokeWallpapers.apk MagicSmokeWallpapers.odex"
WALLPAPERS_PACKAGE="$OUT/Engle_Mars-CM$MODVERSION-Wallpapers.zip"
rm -f $WALLPAPERS_PACKAGE

# Engle 删除TTS
cd "$REPACK/ota/system/tts/lang_pico"
for TTS_FILE in `ls *`
do
        if [ "$TTS_FILE" != "en-US_ta.bin" ]  && [ "$TTS_FILE" != "en-US_lh0_sg.bin" ]; then
                echo "delete $TTS_FILE"
                rm -f "$TTS_FILE"
        fi
done

cd "$REPACK/ota/system/app/"
for WALLPAPERFILE in $WALLPAPERS_FILES
do
        zip -ru9 "$WALLPAPERS_PACKAGE" "$WALLPAPERFILE"
        rm -f "$WALLPAPERFILE"
done
cd "$PWD_PATH"

# Remove big videos
rm -f $REPACK/ota/system/media/video/*.480p.mp4

# these scripts are not required or bad
rm -f $REPACK/ota/system/etc/init.d/04modules

# device specific kernel modules
cp $DEVICE_TOP/modules/* $REPACK/ota/system/lib/modules/

# add an empty script to prevent logcat errors (moto init.rc)
touch $REPACK/ota/system/bin/mount_ext3.sh
chmod +x $REPACK/ota/system/bin/mount_ext3.sh

mkdir -p $REPACK/ota/system/etc/terminfo/x
cp $REPACK/ota/system/etc/terminfo/l/linux $REPACK/ota/system/etc/terminfo/x/xterm

# prebuilt boot, devtree, logo & updater-script
rm -f $REPACK/ota/boot.img

cp -f $DEVICE_COMMON/updater-script $REPACK/ota/META-INF/com/google/android/updater-script
cp -f $DEVICE_TOP/overclock.conf $REPACK/ota/system/bootmenu/config/overclock.conf

# Opensource init binary
#cp -f $DEVICE_OUT/root/init $REPACK/ota/system/bootmenu/2nd-init/init

# Copy kernel & ramdisk
cp -f $DEVICE_OUT/kernel $REPACK/ota/system/bootmenu/2nd-boot/zImage
cp -f $DEVICE_OUT/ramdisk.img $REPACK/ota/system/bootmenu/2nd-boot/ramdisk

# Use a prebuilt adbd configured for root access instead of normal one, for dev purpose
cp -f $REPACK/ota/system/bootmenu/binary/adbd $REPACK/ota/system/bin/adbd

# use the static busybox as bootmenu shell, and some static utilities
#cp -f $DEVICE_OUT/utilities/busybox $REPACK/ota/system/bootmenu/binary/busybox
#cp -f $DEVICE_OUT/utilities/lsof $REPACK/ota/system/bootmenu/binary/lsof

# ril fix
cp -f $REPACK/ota/system/lib/hw/audio.a2dp.default.so $REPACK/ota/system/lib/liba2dp.so

