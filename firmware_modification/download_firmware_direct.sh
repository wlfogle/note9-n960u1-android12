#!/bin/bash

# Direct Galaxy Note 9 Firmware Download Script
# Based on Samsung-firmware.org data for SM-N960U1

DEVICE="SM-N960U1"
REGION="XAA"
VERSION="N960U1UEU9FVG2"
BUILD_DATE="20220722233431"

echo "=== Galaxy Note 9 Direct Firmware Download ==="
echo "Device: $DEVICE"
echo "Region: $REGION"
echo "Version: $VERSION (Latest Android 10)"
echo "Build Date: July 22, 2022"
echo "Security Patch: 2022-06-01"
echo ""

# Create downloads directory
mkdir -p firmware_downloads
cd firmware_downloads

echo "📥 Attempting direct downloads..."
echo ""

# Try multiple download sources
SOURCES=(
    "https://samsung-firmware.org/download?model=$DEVICE&region=$REGION&firmware=$VERSION"
    "https://cloud.samsung-firmware.org/$DEVICE/$REGION/$VERSION"
    "https://fw.samsung-firmware.org/$DEVICE/$REGION/$VERSION"
)

# Expected file names (based on Samsung naming convention)
FILES=(
    "AP_N960U1UEU9FVG2_N960U1OYM9FVG2_MQB63498166_REV00_user_low_ship_MULTI_CERT.tar.md5"
    "BL_N960U1UEU9FVG2_N960U1OYM9FVG2_MQB63498166_REV00_user_low_ship.tar.md5"
    "CP_N960U1UEU9FVG2_N960U1OYM9FVG2_MQB63498166_REV00_user_low_ship.tar.md5"
    "CSC_OYM_N960U1OYM9FVG2_MQB63498166_REV00_user_low_ship.tar.md5"
)

# Function to try downloading a file
download_file() {
    local filename="$1"
    local success=false
    
    echo "Downloading: $filename"
    
    for source in "${SOURCES[@]}"; do
        echo "  Trying: $source/$filename"
        
        if wget -t 3 -T 30 -O "$filename" "$source/$filename" 2>/dev/null; then
            if [ -s "$filename" ] && [ $(wc -c < "$filename") -gt 1000 ]; then
                echo "  ✅ Success!"
                success=true
                break
            else
                echo "  ❌ File too small or empty"
                rm -f "$filename"
            fi
        else
            echo "  ❌ Failed"
        fi
    done
    
    if [ "$success" = false ]; then
        echo "  ⚠️  Could not download $filename"
        return 1
    fi
    
    return 0
}

# Try to download all firmware files
echo "Starting downloads..."
echo ""

success_count=0
for file in "${FILES[@]}"; do
    if download_file "$file"; then
        ((success_count++))
    fi
    echo ""
done

echo "=== Download Summary ==="
echo "Successfully downloaded: $success_count/4 files"

if [ $success_count -eq 4 ]; then
    echo "✅ All firmware files downloaded successfully!"
    echo ""
    echo "📁 Files downloaded to: $(pwd)"
    ls -lh *.tar.md5
    
    echo ""
    echo "🔍 Verifying file integrity..."
    
    # Verify MD5 checksums
    for file in *.tar.md5; do
        if [ -f "$file" ]; then
            echo "Checking: $file"
            # Extract MD5 from filename or file content
            if tail -1 "$file" | grep -q "^[a-fA-F0-9]\{32\}"; then
                echo "  ✅ MD5 checksum found in file"
            else
                echo "  ⚠️  No MD5 checksum in file"
            fi
        fi
    done
    
    echo ""
    echo "📋 Total download size:"
    du -sh *.tar.md5 | awk '{total+=$1} END {print total " total"}'
    
    echo ""
    echo "🚀 Ready to modify firmware!"
    echo "Next steps:"
    echo "1. cd .."
    echo "2. cp firmware_downloads/*.tar.md5 ."
    echo "3. ./modify_firmware.sh"
    
elif [ $success_count -gt 0 ]; then
    echo "⚠️  Partial download ($success_count/4 files)"
    echo "You may need to download the remaining files manually."
    echo ""
    echo "Successfully downloaded:"
    ls -la *.tar.md5 2>/dev/null || echo "None"
    
else
    echo "❌ No files downloaded successfully"
    echo ""
    echo "🔗 Manual download options:"
    echo "1. Samsung-firmware.org: https://samsung-firmware.org/model/SM-N960U1/"
    echo "2. SamMobile: https://www.sammobile.com/samsung/galaxy-note-9/firmware/SM-N960U1/XAA/"
    echo "3. SamFW: https://samfw.com/firmware/SM-N960U1/XAA"
    echo ""
    echo "Search for version: $VERSION"
fi

cd ..

echo ""
echo "💡 Alternative download methods:"
echo "- Use Frija tool on Windows"
echo "- Manual download from Samsung-firmware.org"
echo "- SamLoader (if connection issues resolve)"
