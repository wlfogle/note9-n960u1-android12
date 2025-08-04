#!/bin/bash

echo "📥 Downloading files for SM-N960U1 (crownqltesq)"
echo "================================================"

cd ~/note9_flash/downloads

# Create model-specific info
cat > device_info.txt << EOF
Device: Samsung Galaxy Note 9
Model: SM-N960U1
Serial: RF8KB0T1K9M
Codename: crownqltesq (for US variants)
Bootloader: Factory unlocked (no OEM unlock needed)
EOF

echo "✅ Device info saved"

# TWRP Recovery
echo ""
echo "📱 TWRP Recovery for SM-N960U1:"
echo "Download manually from: https://dl.twrp.me/crownqltesq/"
echo "Latest file should be: twrp-3.7.0_9-0-crownqltesq.img"

# LineageOS - Note 9 support status
echo ""
echo "🤔 Checking LineageOS support..."
echo "Note: SM-N960U1 support varies by ROM maintainer"

# Alternative ROMs that support N960U1
cat > rom_options.txt << EOF
# SM-N960U1 ROM Options (as of 2024/2025)

## 1. LineageOS-based ROMs:
- Check XDA forums for unofficial LineageOS builds
- Some maintainers create U1-specific builds

## 2. PixelExperience:
- Often has N960U1 support
- Check: https://download.pixelexperience.org/

## 3. AOSP-based ROMs:
- Many support both crown and crownqltesq
- Check XDA Developers forum

## 4. Stock-based Custom ROMs:
- OneUI-based customs may be safer
- Less chance of hardware issues

## XDA Forum for your device:
https://forum.xda-developers.com/t/samsung-galaxy-note-9-sm-n960u-u1.3834787/
EOF

echo "📋 ROM options saved to rom_options.txt"

# Download TWRP if available
echo ""
echo "🔧 Attempting to download TWRP..."
TWRP_URL="https://dl.twrp.me/crownqltesq/twrp-3.7.0_9-0-crownqltesq.img"
if curl -f -L -o recovery/twrp-crownqltesq.img "$TWRP_URL" 2>/dev/null; then
    echo "✅ TWRP downloaded successfully"
    ls -lh recovery/twrp-crownqltesq.img
else
    echo "❌ TWRP auto-download failed"
    echo "   Manual download needed from: https://dl.twrp.me/crownqltesq/"
fi

# Create backup script
cat > ../backup_before_flash.sh << 'EOF'
#!/bin/bash
echo "🛡️ Pre-flash backup for SM-N960U1"
echo "=================================="

# Check ADB connection
if ! adb devices | grep -q "device$"; then
    echo "❌ No ADB connection. Enable USB debugging first!"
    exit 1
fi

BACKUP_DIR="backups/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "📱 Getting device info..."
adb shell getprop ro.product.model > "$BACKUP_DIR/model.txt"
adb shell getprop ro.build.fingerprint > "$BACKUP_DIR/fingerprint.txt"
adb shell getprop > "$BACKUP_DIR/all_props.txt"

echo "💾 Backing up important partitions..."
# Note: These require root access or custom recovery
echo "EFS backup (requires root):"
echo "adb shell su -c 'dd if=/dev/block/sda3 of=/sdcard/efs_backup.img'"

echo "Boot partition backup:"
echo "adb shell su -c 'dd if=/dev/block/bootdevice/by-name/boot of=/sdcard/boot_backup.img'"

echo ""
echo "⚠️  For full backup, boot into TWRP and use the backup function"
echo "✅ Backup preparation complete"
echo "📁 Info saved to: $BACKUP_DIR"
EOF

chmod +x ../backup_before_flash.sh

# Safety reminder
echo ""
echo "🚨 IMPORTANT REMINDERS FOR SM-N960U1:"
echo "• Your bootloader is already unlocked (good!)"
echo "• Always use crownqltesq-specific files"
echo "• Don't flash SM-N960F (international) firmware"
echo "• Knox will be permanently tripped"
echo "• Make sure to backup EFS partition"
echo ""
echo "📁 Files will be saved to: $(pwd)"
echo "🔍 Check XDA forums for latest ROM availability"
echo "🛡️ Run ../backup_before_flash.sh before flashing"

# Create quick flash guide
cat > ../quick_flash_guide.txt << EOF
# Quick Flash Guide for SM-N960U1

## Prerequisites:
1. ✅ USB Debugging enabled
2. ✅ Device recognized by Heimdall
3. ✅ TWRP downloaded
4. ✅ ROM ZIP downloaded  
5. ✅ Backup created

## Flash Process:
1. Boot to Download Mode: Vol Down + Bixby + Power
2. Flash TWRP: heimdall flash --RECOVERY twrp-crownqltesq.img --no-reboot
3. Boot to TWRP: Vol Up + Bixby + Power (immediately after flash)
4. In TWRP: Wipe > Advanced > Select System, Data, Cache, Dalvik
5. Install ROM ZIP file
6. Install GApps (if needed)
7. Reboot > System

## If something goes wrong:
- Download Mode: Vol Down + Bixby + Power
- Flash stock firmware using Heimdall
- Stock firmware: sammobile.com or samsung-firmware.org
EOF

echo "📖 Quick guide saved to ../quick_flash_guide.txt"
echo "🏁 Download script complete!"
