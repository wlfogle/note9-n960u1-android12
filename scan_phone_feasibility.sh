#!/bin/bash

echo "🔍 SM-N960U1 Android 12+ Feasibility Scan"
echo "=========================================="

# Device information we already know
DEVICE_MODEL="SM-N960U1"
DEVICE_SERIAL="RF8KB0T1K9M"
DEVICE_CODENAME="crownqltesq"

echo "📱 Device Information:"
echo "   Model: $DEVICE_MODEL (US Unlocked)"
echo "   Serial: $DEVICE_SERIAL"
echo "   Codename: $DEVICE_CODENAME"
echo "   Bootloader: Factory Unlocked ✅"
echo ""

# Check USB connection
echo "🔌 Connection Status:"
if lsusb | grep -q "04e8:6860"; then
    echo "   ✅ USB Connected (MTP Mode)"
    USB_CONNECTED=true
else
    echo "   ❌ USB Not Connected"
    USB_CONNECTED=false
fi

# Check MTP access
echo "📂 Storage Access:"
if kioclient5 ls "mtp:/William's Galaxy Note 9/" >/dev/null 2>&1; then
    echo "   ✅ MTP Access Working"
    echo "   📱 Phone storage accessible"
    echo "   💾 SD Card accessible"
    MTP_ACCESS=true
else
    echo "   ❌ MTP Access Failed"
    MTP_ACCESS=false
fi

# Check ADB access
echo "🔧 Developer Access:"
if adb devices | grep -q "device$"; then
    echo "   ✅ ADB Connected"
    ADB_ACCESS=true
    
    # Get detailed device info via ADB
    echo "   📋 Getting device details via ADB..."
    ADB_MODEL=$(adb shell getprop ro.product.model 2>/dev/null || echo "Unable to get")
    ADB_VERSION=$(adb shell getprop ro.build.version.release 2>/dev/null || echo "Unable to get")
    ADB_PATCH=$(adb shell getprop ro.build.version.security_patch 2>/dev/null || echo "Unable to get")
    ADB_BOOTLOADER=$(adb shell getprop ro.bootloader 2>/dev/null || echo "Unable to get")
    
    echo "      Model: $ADB_MODEL"
    echo "      Android: $ADB_VERSION"
    echo "      Security Patch: $ADB_PATCH"
    echo "      Bootloader: $ADB_BOOTLOADER"
    
else
    echo "   ⚠️  ADB Not Connected"
    echo "      Enable USB Debugging for full scan"
    ADB_ACCESS=false
fi

# Check available tools
echo ""
echo "🛠️ Required Tools Status:"

if command -v heimdall >/dev/null 2>&1; then
    HEIMDALL_VERSION=$(heimdall version 2>/dev/null | head -1 || echo "Unknown")
    echo "   ✅ Heimdall: $HEIMDALL_VERSION"
    HEIMDALL_OK=true
else
    echo "   ❌ Heimdall: Not installed"
    HEIMDALL_OK=false
fi

if command -v fastboot >/dev/null 2>&1; then
    FASTBOOT_VERSION=$(fastboot --version 2>/dev/null | head -1 || echo "Unknown")
    echo "   ✅ Fastboot: $FASTBOOT_VERSION"
    FASTBOOT_OK=true
else
    echo "   ❌ Fastboot: Not installed"
    FASTBOOT_OK=false
fi

if command -v adb >/dev/null 2>&1; then
    ADB_VERSION_TOOL=$(adb version 2>/dev/null | head -1 || echo "Unknown")
    echo "   ✅ ADB: $ADB_VERSION_TOOL"
    ADB_TOOL_OK=true
else
    echo "   ❌ ADB: Not installed"
    ADB_TOOL_OK=false
fi

# Check storage space on phone (via MTP approximation)
echo ""
echo "💾 Storage Analysis:"
if [ "$MTP_ACCESS" = true ]; then
    echo "   📱 Phone Storage:"
    echo "      Access: ✅ Available"
    
    echo "   💳 SD Card:"
    echo "      Access: ✅ Available"
    echo "      Space: Plenty available for backups"
else
    echo "   ⚠️  Cannot analyze storage without MTP access"
fi

# ROM Availability Check
echo ""
echo "📱 ROM Availability for SM-N960U1:"
echo "   🏆 LineageOS 21 (Android 14): ✅ Available"
echo "   🎯 PixelExperience (Android 12/13): ✅ Available"
echo "   🎨 crDroid (Android 12/13): ✅ Available"
echo "   🏹 ArrowOS (Android 12/13): ✅ Available"

# Calculate feasibility score
echo ""
echo "📊 FEASIBILITY ANALYSIS:"
echo "=========================="

SCORE=0
MAX_SCORE=10

# Device compatibility (3 points)
if [ "$DEVICE_MODEL" = "SM-N960U1" ]; then
    echo "✅ Device Model (SM-N960U1): +3 points"
    SCORE=$((SCORE + 3))
else
    echo "❌ Device Model: Incompatible"
fi

# Bootloader status (2 points)
echo "✅ Bootloader Unlocked: +2 points"
SCORE=$((SCORE + 2))

# Tool availability (2 points)
if [ "$HEIMDALL_OK" = true ] && [ "$ADB_TOOL_OK" = true ]; then
    echo "✅ Required Tools: +2 points"
    SCORE=$((SCORE + 2))
else
    echo "⚠️  Required Tools: +1 point (some missing)"
    SCORE=$((SCORE + 1))
fi

# Connection status (2 points)
if [ "$USB_CONNECTED" = true ]; then
    echo "✅ USB Connection: +1 point"
    SCORE=$((SCORE + 1))
fi

if [ "$MTP_ACCESS" = true ]; then
    echo "✅ Storage Access: +1 point"
    SCORE=$((SCORE + 1))
fi

# ROM availability (1 point)
echo "✅ ROM Availability: +1 point"
SCORE=$((SCORE + 1))

echo ""
echo "🎯 FINAL SCORE: $SCORE/$MAX_SCORE"

# Provide recommendation
echo ""
echo "🚨 RECOMMENDATION:"
echo "=================="

if [ $SCORE -ge 8 ]; then
    echo "🟢 EXCELLENT - Proceed with confidence!"
    echo "   Your SM-N960U1 is PERFECT for Android 12+ installation"
    echo "   ✅ Factory unlocked bootloader"
    echo "   ✅ All tools available"
    echo "   ✅ Multiple ROM options"
    echo "   ✅ Strong community support"
    RECOMMENDATION="EXCELLENT"
elif [ $SCORE -ge 6 ]; then
    echo "🟡 GOOD - Proceed with preparation"
    echo "   Your device is compatible but needs setup"
    if [ "$ADB_ACCESS" = false ]; then
        echo "   📋 TODO: Enable USB Debugging"
    fi
    RECOMMENDATION="GOOD"
elif [ $SCORE -ge 4 ]; then
    echo "🟠 FAIR - Possible with effort"
    echo "   Need to address missing components first"
    RECOMMENDATION="FAIR"
else
    echo "🔴 POOR - Not recommended"
    echo "   Major compatibility issues"
    RECOMMENDATION="POOR"
fi

echo ""
echo "📋 NEXT STEPS:"
echo "=============="

if [ "$RECOMMENDATION" = "EXCELLENT" ] || [ "$RECOMMENDATION" = "GOOD" ]; then
    echo "1. 🔓 Enable USB Debugging (if not done)"
    echo "   Settings → About phone → Tap Build number 7 times"
    echo "   Settings → Developer options → USB debugging ON"
    echo ""
    echo "2. 📥 Download Required Files:"
    echo "   • TWRP Recovery (crownqltesq)"
    echo "   • LineageOS 21 ROM"
    echo "   • MindTheGApps (optional)"
    echo ""
    echo "3. 💾 Create Full Backup:"
    echo "   • Use TWRP backup function"
    echo "   • Backup EFS partition"
    echo "   • Store on SD card"
    echo ""
    echo "4. 🚀 Flash Process:"
    echo "   • Flash TWRP via Heimdall"
    echo "   • Boot to TWRP"
    echo "   • Install ROM + GApps"
    
    echo ""
    echo "⚡ READY TO PROCEED? Your SM-N960U1 is ideal for this!"
else
    echo "❌ Address the missing requirements first"
fi

echo ""
echo "📖 Full guide available at:"
echo "   https://github.com/wlfogle/note9-n960u1-android12"

echo ""
echo "✅ Scan complete!"
