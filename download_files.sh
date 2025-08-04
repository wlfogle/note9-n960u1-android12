#!/bin/bash

echo "📥 SM-N960U1 File Download Manager"
echo "=================================="

cd /home/lou/note9_flash/downloads

echo "🎯 Target Device: SM-N960U1 (US Unlocked)"
echo "📱 Codename: crown (universal) / crownqltesq (US specific)"
echo ""

# Create download directories
mkdir -p recovery roms gapps magisk

echo "🔍 PHASE 1: TWRP Recovery"
echo "========================"

# For SM-N960U1, we can use the universal crown TWRP
echo "Downloading TWRP for Galaxy Note 9..."

# Try multiple TWRP sources for Note 9
TWRP_URLS=(
    "https://github.com/TeamWin/android_device_samsung_crown/releases/latest/download/twrp-crown.img"
    "https://androidfilehost.com/?fid=1395089523397913136"  # AFH mirror
)

echo "Attempting TWRP download from GitHub releases..."
if curl -L -f -o recovery/twrp-crown.img "https://github.com/TeamWin/android_device_samsung_crown/releases/latest/download/twrp-crown.img" 2>/dev/null; then
    echo "✅ TWRP downloaded from GitHub"
    ls -lah recovery/twrp-crown.img
else
    echo "❌ GitHub download failed, checking alternative sources..."
    
    # Manual TWRP info for user
    cat > recovery/TWRP_MANUAL_DOWNLOAD.txt << EOF
# TWRP Manual Download Instructions for SM-N960U1

Due to automated download limitations, please manually download TWRP:

## Option 1: XDA Forums
1. Go to: https://forum.xda-developers.com/t/recovery-official-twrp-for-galaxy-note-9-exynos-snapdragon.3834787/
2. Look for SM-N960U1 or "crown" builds
3. Download latest TWRP .img file
4. Save as: recovery/twrp-crown.img

## Option 2: TWRP Official (if available)
1. Go to: https://twrp.me/samsung/
2. Look for Galaxy Note 9 variants
3. Download for "crown" or "crownqltesq"

## Option 3: Lineage Recovery
If TWRP isn't available, LineageOS recovery can be used:
1. Download from LineageOS builds
2. Usually named: lineage-XX.X-recovery-crown.img

File should be ~30-50MB in size.
EOF
    
    echo "📄 Created manual download instructions"
fi

echo ""
echo "🚀 PHASE 2: LineageOS ROM"
echo "========================="

# LineageOS for Note 9 - checking official and unofficial sources
echo "Searching for LineageOS builds for SM-N960U1..."

# LineageOS official builds are discontinued for Note 9, but unofficial builds exist
cat > roms/LINEAGEOS_SOURCES.txt << EOF
# LineageOS Options for SM-N960U1

## Unofficial LineageOS Builds:
1. **XDA Forums - Most Active**
   - https://forum.xda-developers.com/t/samsung-galaxy-note-9-sm-n960u-u1.3834787/
   - Search for "LineageOS 20" or "LineageOS 21" threads
   - Look for recent builds (2024/2025)

2. **GitHub Releases**
   - Search GitHub for "lineageos_crown" or "lineageos_crownqltesq"
   - Look for device-specific repositories
   - Download latest nightly builds

3. **Alternative AOSP ROMs** (if LineageOS unavailable):
   - PixelExperience: Often has Note 9 support
   - crDroid: Good customization options
   - ArrowOS: Clean AOSP experience

## What to Download:
- File name: lineage-21.0-*-crown.zip (or similar)
- Size: ~1-2GB
- Date: Recent (2024/2025)

## Verify Before Flashing:
- Check XDA thread for latest working build
- Read recent user feedback
- Ensure it's for SM-N960U1 (not SM-N960F)
EOF

echo "📄 Created LineageOS source information"

echo ""
echo "📦 PHASE 3: GApps Package"
echo "========================="

echo "Downloading MindTheGApps for Android 14..."

# MindTheGApps is usually the most compatible
GAPPS_URL="https://androidfilehost.com/?fid=14655340768118475016"  # Example - would need current link

cat > gapps/GAPPS_OPTIONS.txt << EOF
# GApps Options for LineageOS 21 (Android 14)

## Recommended: MindTheGApps
- **Size:** ~600MB
- **Compatibility:** Excellent with LineageOS
- **Download:** https://androidfilehost.com/?w=files&flid=322935
- **Version:** 14.0 ARM64
- **File:** MindTheGapps-14.0.0-arm64-*.zip

## Alternative: NikGApps
- **Size:** ~400MB (Core package)
- **Customizable:** Multiple variants available
- **Download:** https://nikgapps.com/
- **Recommended:** Core or Basic package

## Alternative: OpenGApps (if available)
- **Size:** Variable (Nano: ~150MB)
- **Download:** https://opengapps.org/
- **Architecture:** arm64
- **Android:** 14.0
- **Variant:** nano or micro

## Installation Notes:
- Flash immediately after ROM (don't reboot first)
- Wipe dalvik cache after flashing
- First boot will take 10-15 minutes
EOF

echo "📄 Created GApps options guide"

echo ""
echo "🔐 PHASE 4: Magisk (Root)"
echo "========================="

echo "Downloading Magisk for root access..."

# Download latest Magisk
MAGISK_VERSION="v27.0"
if curl -L -f -o magisk/Magisk-${MAGISK_VERSION}.apk "https://github.com/topjohnwu/Magisk/releases/download/${MAGISK_VERSION}/Magisk-${MAGISK_VERSION}.apk" 2>/dev/null; then
    echo "✅ Magisk ${MAGISK_VERSION} downloaded"
    ls -lah magisk/
else
    echo "⚠️  Magisk auto-download failed"
    
    cat > magisk/MAGISK_DOWNLOAD.txt << EOF
# Magisk Root Download

## Latest Magisk:
1. Go to: https://github.com/topjohnwu/Magisk/releases/latest
2. Download: Magisk-vXX.X.apk
3. Save to: magisk/Magisk-latest.apk

## Installation:
- Flash via TWRP after ROM and GApps
- Or install APK after first boot
- Follow Magisk setup wizard

## Note:
- Root will trip SafetyNet
- Some banking apps may not work
- Knox will be permanently tripped
EOF
    
    echo "📄 Created Magisk download instructions"
fi

echo ""
echo "📊 DOWNLOAD SUMMARY"
echo "=================="
echo "📁 Directory structure:"
tree . 2>/dev/null || find . -type f | head -20

echo ""
echo "✅ Download preparation complete!"
echo ""
echo "📋 NEXT STEPS:"
echo "1. Enable USB debugging on your phone"
echo "2. Manually download missing files (see .txt guides)"
echo "3. Verify ADB connection"
echo "4. Create backup via TWRP"
echo "5. Flash ROM + GApps"

echo ""
echo "⚠️  IMPORTANT:"
echo "- Only use files specifically for SM-N960U1 or 'crown'"
echo "- Don't use SM-N960F (international) files"
echo "- Always backup before flashing"
echo "- Read XDA threads for latest working builds"

echo ""
echo "🔗 Resources:"
echo "   XDA Forum: https://forum.xda-developers.com/t/samsung-galaxy-note-9-sm-n960u-u1.3834787/"
echo "   Guide: https://github.com/wlfogle/note9-n960u1-android12"
