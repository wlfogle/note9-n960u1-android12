#!/bin/bash

echo "🔧 Samsung Galaxy Note 9 - Android 12+ Setup"
echo "=============================================="

# Create directories
mkdir -p downloads/{roms,recovery,tools,backups}
mkdir -p device_info

echo "📁 Created directory structure:"
tree . 2>/dev/null || ls -la

echo ""
echo "🔍 Checking device connection..."

# Try to get device info via MTP first
if kioclient5 ls "mtp:/William's Galaxy Note 9/" >/dev/null 2>&1; then
    echo "✅ Device accessible via MTP"
    
    # Try to get model info from device
    echo "📱 Device: William's Galaxy Note 9"
    echo "   Getting model information..."
    
    # Look for build.prop or system info
    if kioclient5 ls "mtp:/William's Galaxy Note 9/Phone/Documents/" >/dev/null 2>&1; then
        echo "   Phone storage accessible"
    fi
else
    echo "❌ Device not accessible via MTP"
fi

# Check ADB connection
if adb devices | grep -q "device$"; then
    echo "✅ ADB connection available"
    
    echo "📱 Getting device information via ADB:"
    echo "   Model: $(adb shell getprop ro.product.model 2>/dev/null || echo 'Unable to get model')"
    echo "   Device: $(adb shell getprop ro.product.device 2>/dev/null || echo 'Unable to get device')"
    echo "   Android Version: $(adb shell getprop ro.build.version.release 2>/dev/null || echo 'Unable to get version')"
    echo "   Security Patch: $(adb shell getprop ro.build.version.security_patch 2>/dev/null || echo 'Unable to get patch')"
    echo "   Bootloader: $(adb shell getprop ro.bootloader 2>/dev/null || echo 'Unable to get bootloader')"
    
    # Save device info
    adb shell getprop > device_info/device_props.txt 2>/dev/null
    echo "   Device properties saved to device_info/device_props.txt"
    
else
    echo "❌ ADB connection not available"
    echo "   Enable Developer Options and USB Debugging to get device info"
fi

# Check Heimdall
echo ""
echo "🛠️ Checking tools:"
if command -v heimdall >/dev/null 2>&1; then
    echo "✅ Heimdall installed: $(heimdall version 2>/dev/null | head -1 || echo 'Version check failed')"
else
    echo "❌ Heimdall not found"
fi

if command -v fastboot >/dev/null 2>&1; then
    echo "✅ Fastboot installed: $(fastboot --version 2>/dev/null | head -1 || echo 'Version check failed')"
else
    echo "❌ Fastboot not found"
fi

echo ""
echo "📚 Next Steps:"
echo "1. Enable Developer Options on your phone (Settings > About phone > Tap Build number 7 times)"
echo "2. Enable USB Debugging (Settings > Developer options > USB debugging)"
echo "3. Enable OEM Unlocking (Settings > Developer options > OEM unlocking)"
echo "4. Re-run this script to get device model information"
echo ""
echo "📋 ROM Recommendations for Note 9:"
echo "• LineageOS 19.1 (Android 12L) - Most stable"
echo "• PixelExperience (Android 12/13) - Pixel features"
echo "• crDroid (Android 12/13) - Heavy customization"
echo ""
echo "⚠️  WARNING: This process will:"
echo "• Void your warranty"
echo "• Erase all data (backup first!)"
echo "• Disable Samsung Knox/Pay permanently"
echo "• Risk bricking if done incorrectly"

# Download links function
cat << 'EOF' > download_links.txt
# Note 9 (crown) Download Links

## TWRP Recovery:
https://dl.twrp.me/crown/

## LineageOS 19.1 (Android 12L):
https://download.lineageos.org/crown

## PixelExperience:
https://download.pixelexperience.org/crown

## MindTheGApps (for LineageOS):
https://androidfilehost.com/?w=files&flid=322935

## Magisk (latest):
https://github.com/topjohnwu/Magisk/releases

## Stock Firmware (if recovery needed):
https://sammobile.com/samsung/galaxy-note-9/firmware/
EOF

echo ""
echo "📥 Download links saved to download_links.txt"
echo "🏁 Setup complete! Directory: $(pwd)"
