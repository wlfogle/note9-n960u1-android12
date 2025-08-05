#!/bin/bash

# Galaxy Note 9 Stock Firmware Download Helper
# This script helps download the exact firmware for modification

DEVICE="SM-N960U1"
REGION="XAA"  # US Unlocked
VERSION="N960U1UEU9FVG2"

echo "=== Galaxy Note 9 Stock Firmware Download ==="
echo "Device: $DEVICE"
echo "Region: $REGION" 
echo "Version: $VERSION"
echo ""

echo "📥 Download Options:"
echo ""
echo "1. Manual Download (SamMobile)"
echo "   URL: https://www.sammobile.com/samsung/galaxy-note-9/firmware/SM-N960U1/XAA/"
echo "   Search for: $VERSION"
echo ""
echo "2. Manual Download (Samsung-Firmware.org)"
echo "   URL: https://samsung-firmware.org/"
echo "   Model: $DEVICE, Region: $REGION"
echo ""
echo "3. Frija Tool (Windows/Wine)"
echo "   Download: https://github.com/SlackingVeteran/frija/releases"
echo "   Command: frija.exe -m $DEVICE -r $REGION"
echo ""
echo "4. SamFirm Tool (Alternative)"
echo "   Download SamFirm and use: Model=$DEVICE, Region=$REGION"
echo ""

echo "📋 Expected Files After Download:"
echo "You should get these 4 files:"
echo "- AP_N960U1UEU9FVG2_N960U1OYM9FVG2_MQB63498166_REV00_user_low_ship_MULTI_CERT.tar.md5"
echo "- BL_N960U1UEU9FVG2_N960U1OYM9FVG2_MQB63498166_REV00_user_low_ship.tar.md5"
echo "- CP_N960U1UEU9FVG2_N960U1OYM9FVG2_MQB63498166_REV00_user_low_ship.tar.md5"
echo "- CSC_OYM_N960U1OYM9FVG2_MQB63498166_REV00_user_low_ship.tar.md5"
echo ""
echo "📁 Place downloaded files in: $(pwd)"
echo ""

# Check if firmware files exist
if ls AP_*.tar.md5 1> /dev/null 2>&1; then
    echo "✅ Firmware files found:"
    ls -la *_*.tar.md5
    echo ""
    echo "🚀 Ready to run: ./modify_firmware.sh"
else
    echo "⏳ Waiting for firmware files..."
    echo "After downloading, run: ./modify_firmware.sh"
fi

echo ""
echo "💡 Tips:"
echo "- Total download size: ~4-6 GB"
echo "- Use stable internet connection"
echo "- Verify MD5 checksums after download"
echo "- Keep original files as backup"

# Attempt to download using wget (will likely fail due to authentication)
echo ""
echo "🔍 Attempting direct download (may fail)..."

# Try sammobile direct link (usually fails)
wget -O "firmware_page.html" "https://www.sammobile.com/samsung/galaxy-note-9/firmware/SM-N960U1/XAA/" || echo "Direct download failed (expected)"

if [ -f "firmware_page.html" ]; then
    if grep -q "$VERSION" firmware_page.html; then
        echo "✅ Firmware version $VERSION found on SamMobile"
    else
        echo "⚠️  Firmware version may have changed"
    fi
    rm firmware_page.html
fi

echo ""
echo "📝 Next Steps:"
echo "1. Download firmware files manually using one of the methods above"
echo "2. Place all 4 .tar.md5 files in this directory"
echo "3. Run: ./modify_firmware.sh"
echo "4. Follow the modification script prompts"
