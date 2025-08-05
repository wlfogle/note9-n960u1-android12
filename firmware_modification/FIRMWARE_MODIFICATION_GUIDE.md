# Galaxy Note 9 Stock Firmware Modification Guide

## Overview
Modifying stock firmware allows us to:
- Add root access (Magisk) to stock firmware
- Enable debugging features
- Remove Samsung bloatware
- Create custom firmware without bootloader unlock
- Test modifications safely before flashing

## Device Information
- **Model**: SM-N960U1 (Galaxy Note 9 US Unlocked)
- **Firmware**: N960U1UEU9FVG2
- **Android**: 10
- **Architecture**: arm64

## Required Tools

### Linux Tools (Available)
- ✅ **heimdall** - Samsung firmware flashing
- ✅ **adb/fastboot** - Android debugging
- ✅ **7zip/unzip** - Archive extraction
- ⏳ **simg2img** - Sparse image conversion
- ⏳ **AIK (Android Image Kitchen)** - Boot image editing
- ⏳ **Magisk** - Root modification

## Step 1: Download and Extract Stock Firmware

```bash
# Download actual firmware (not HTML page)
# Use Frija tool or manual download from SamMobile

# Expected files:
# - AP_N960U1UEU9FVG2_N960U1OYM9FVG2_MQB63498166_REV00_user_low_ship_MULTI_CERT.tar.md5
# - BL_N960U1UEU9FVG2_N960U1OYM9FVG2_MQB63498166_REV00_user_low_ship.tar.md5  
# - CP_N960U1UEU9FVG2_N960U1OYM9FVG2_MQB63498166_REV00_user_low_ship.tar.md5
# - CSC_OYM_N960U1OYM9FVG2_MQB63498166_REV00_user_low_ship.tar.md5

# Extract AP file (contains boot, system, recovery)
tar -xf AP_*.tar.md5
```

## Step 2: Install Required Tools

```bash
# Install sparse image tools
sudo pacman -S android-tools simg2img img2simg

# Download Android Image Kitchen
wget https://github.com/osm0sis/Android-Image-Kitchen/archive/refs/heads/master.zip
unzip master.zip
mv Android-Image-Kitchen-master AIK

# Download latest Magisk
wget https://github.com/topjohnwu/Magisk/releases/latest/download/Magisk-v25.2.apk
```

## Step 3: Extract and Modify Boot Image

```bash
# Convert sparse system image to raw (if needed)
simg2img system.img.ext4 system_raw.img

# Extract boot image using AIK
cp boot.img AIK/
cd AIK
./unpackimg.sh boot.img

# The boot image will be unpacked to:
# - ramdisk/ (initramfs)
# - split_img/ (kernel + metadata)
```

## Step 4: Add Magisk to Boot Image

```bash
# Method 1: Magisk patch (recommended)
# 1. Install Magisk APK on device
# 2. Copy boot.img to device
# 3. Use Magisk to patch boot.img
# 4. Copy patched image back

# Method 2: Manual integration (advanced)
# Modify init.rc in ramdisk to load Magisk
```

## Step 5: Repack Modified Firmware

```bash
# Repack boot image
cd AIK
./repackimg.sh

# New patched boot image will be in AIK/image-new.img
cp image-new.img ../boot_rooted.img

# Create new AP tar file
tar -H ustar -c boot_rooted.img recovery.img system.img.ext4 > AP_ROOTED.tar
md5sum AP_ROOTED.tar >> AP_ROOTED.tar
mv AP_ROOTED.tar AP_ROOTED.tar.md5
```

## Step 6: Debloat System (Optional)

```bash
# Mount system image
mkdir system_mount
sudo mount -o loop system_raw.img system_mount

# Remove bloatware
sudo rm -rf system_mount/app/Facebook_stub
sudo rm -rf system_mount/app/SamsungBilling  
sudo rm -rf system_mount/app/BixbyAgent
# ... more removals as desired

# Unmount and convert back
sudo umount system_mount
img2simg system_raw.img system_debloated.img.ext4
```

## Step 7: Add Custom Features

### Enable ADB Root by Default
```bash
# Edit default.prop in boot ramdisk
echo "ro.secure=0" >> ramdisk/default.prop
echo "ro.debuggable=1" >> ramdisk/default.prop
echo "persist.service.adb.enable=1" >> ramdisk/default.prop
```

### Add Custom Init Scripts  
```bash
# Add custom init.d support
mkdir -p ramdisk/system/etc/init.d
echo "#!/system/bin/sh" > ramdisk/system/etc/init.d/99custom
echo "# Custom initialization" >> ramdisk/system/etc/init.d/99custom
chmod 755 ramdisk/system/etc/init.d/99custom
```

## Step 8: Create Custom Firmware Package

```bash
# Organize final firmware
mkdir CUSTOM_FIRMWARE_N960U1
cp AP_ROOTED.tar.md5 CUSTOM_FIRMWARE_N960U1/
cp BL_*.tar.md5 CUSTOM_FIRMWARE_N960U1/  # Original bootloader
cp CP_*.tar.md5 CUSTOM_FIRMWARE_N960U1/  # Original modem  
cp CSC_*.tar.md5 CUSTOM_FIRMWARE_N960U1/ # Original CSC

# Create flash script
cat > CUSTOM_FIRMWARE_N960U1/flash.sh << 'EOF'
#!/bin/bash
echo "Flashing custom Note 9 firmware..."
heimdall flash --AP AP_ROOTED.tar.md5 --BL BL_*.tar.md5 --CP CP_*.tar.md5 --CSC CSC_*.tar.md5
EOF
```

## Step 9: Safety Testing

### Virtual Testing (Recommended)
```bash
# Test unpacking/repacking without changes first
cp boot.img boot_test.img
# Unpack and repack without modifications
# Flash test version first
```

### Incremental Testing
1. **Test 1**: Flash only modified boot (keep original system)
2. **Test 2**: Flash modified system (keep original boot)  
3. **Test 3**: Flash complete custom firmware

## Step 10: Flash Custom Firmware

```bash
# Enter Download Mode
adb reboot download

# Flash custom firmware
cd CUSTOM_FIRMWARE_N960U1
chmod +x flash.sh
./flash.sh
```

## Modifications We Can Make

### Security & Root
- ✅ **Magisk integration** - System-less root
- ✅ **ADB root enabled** - Development access
- ✅ **SELinux permissive** - Reduced restrictions
- ✅ **dm-verity disabled** - Allow system modifications

### Debloating  
- ✅ **Remove Samsung bloat** - Facebook, Bixby, etc.
- ✅ **Remove carrier apps** - Unnecessary services
- ✅ **Optimize system** - Remove unused features

### Custom Features
- ✅ **Init.d support** - Custom startup scripts
- ✅ **Busybox integration** - Advanced shell tools
- ✅ **Custom bootanimation** - Personalization
- ✅ **Performance tweaks** - CPU/GPU optimizations

## Safety & Recovery

### Always Keep Original
- Original firmware files for recovery
- Working boot.img backup
- Original system.img backup

### Test Strategy
1. Modify only boot.img first (easiest to recover)
2. Test all functions work normally
3. Then modify system.img if needed
4. Always flash one component at a time

### Recovery Options
1. **Download Mode** - Always available for firmware flash
2. **Stock firmware** - Can restore to original state
3. **Individual components** - Flash just boot or system if needed

## Expected Results

✅ **Rooted stock firmware** - Magisk with stock appearance
✅ **Debloated system** - Removed unnecessary apps  
✅ **Custom features** - Init.d, busybox, tweaks
✅ **Maintainable** - Can update components individually
❌ **Knox still trips** - When flashing modified AP
✅ **Reversible** - Can flash stock firmware anytime
