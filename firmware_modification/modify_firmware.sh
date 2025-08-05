#!/bin/bash

# Galaxy Note 9 Firmware Modification Script
# This script modifies stock firmware to add root and custom features

set -e  # Exit on any error

DEVICE="SM-N960U1"
FIRMWARE_VERSION="N960U1UEU9FVG2"
WORK_DIR=$(pwd)
MAGISK_APK="Magisk-v29.0.apk"

echo "=== Galaxy Note 9 Firmware Modification Tool ==="
echo "Device: $DEVICE"
echo "Firmware: $FIRMWARE_VERSION"
echo "Working Directory: $WORK_DIR"
echo ""

# Function to check if file exists
check_file() {
    if [ ! -f "$1" ]; then
        echo "❌ Error: $1 not found!"
        echo "Please download the stock firmware first."
        exit 1
    fi
}

# Function to create directory if it doesn't exist
ensure_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        echo "✅ Created directory: $1"
    fi
}

# Step 1: Check prerequisites
echo "Step 1: Checking prerequisites..."
check_file "$MAGISK_APK"

if [ ! -d "AIK-Linux" ]; then
    echo "❌ Android Image Kitchen not found!"
    exit 1
fi

# Check for firmware files
AP_FILES=(AP_*.tar.md5)
if [ ! -f "${AP_FILES[0]}" ]; then
    echo "⚠️  Stock firmware not found!"
    echo "Please download firmware using:"
    echo "./download_firmware.sh"
    echo ""
    echo "Expected files:"
    echo "- AP_N960U1UEU9FVG2_*.tar.md5"
    echo "- BL_N960U1UEU9FVG2_*.tar.md5"
    echo "- CP_N960U1UEU9FVG2_*.tar.md5"  
    echo "- CSC_*N960U1*_*.tar.md5"
    exit 1
fi

echo "✅ Prerequisites check passed"
echo ""

# Step 2: Extract firmware
echo "Step 2: Extracting firmware..."
ensure_dir "extracted"
ensure_dir "modified"

# Find AP file
AP_FILE=$(ls AP_*.tar.md5 | head -1)
echo "📦 Extracting: $AP_FILE"

# Extract AP file
cd extracted
tar -xf "../$AP_FILE" 2>/dev/null || echo "⚠️  Some extraction warnings (normal)"

# Decompress LZ4 files if present
echo "🔄 Decompressing firmware images..."
for lz4_file in *.lz4; do
    if [ -f "$lz4_file" ]; then
        output_file="${lz4_file%.lz4}"
        echo "   Decompressing: $lz4_file → $output_file"
        lz4 -d "$lz4_file" "$output_file"
    fi
done

cd ..

echo "✅ Firmware extracted and decompressed"
echo ""

# Step 3: Modify boot image
echo "Step 3: Modifying boot image..."

if [ ! -f "extracted/boot.img" ]; then
    echo "❌ boot.img not found in firmware!"
    exit 1
fi

# Copy boot image to AIK-Linux
cp extracted/boot.img AIK-Linux/
cd AIK-Linux

# Unpack boot image
echo "📦 Unpacking boot image..."
bash unpackimg.sh boot.img

# Add root modifications to ramdisk
echo "🔧 Adding root modifications..."

# Enable ADB root
if [ -f "ramdisk/default.prop" ]; then
    echo "ro.secure=0" >> ramdisk/default.prop
    echo "ro.debuggable=1" >> ramdisk/default.prop
    echo "persist.service.adb.enable=1" >> ramdisk/default.prop
    echo "persist.sys.usb.config=mtp,adb" >> ramdisk/default.prop
    echo "✅ Added ADB root properties"
fi

# Add init.d support
ensure_dir "ramdisk/system/etc/init.d"
cat > ramdisk/system/etc/init.d/99custom << 'EOF'
#!/system/bin/sh
# Custom initialization script
# Add your custom commands here

# Enable performance governor
echo "performance" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor

# Set I/O scheduler
echo "deadline" > /sys/block/sda/queue/scheduler

echo "Custom init.d script executed" >> /data/local/tmp/custom_init.log
EOF

chmod 755 ramdisk/system/etc/init.d/99custom
echo "✅ Added init.d support"

# Repack boot image
echo "📦 Repacking boot image..."
bash repackimg.sh

# Copy modified boot image
cp image-new.img ../modified/boot_rooted.img
cd ..

echo "✅ Boot image modified"
echo ""

# Step 4: Create debloated system (optional)
echo "Step 4: Creating debloated system (optional)..."
echo "Do you want to debloat the system? (y/n)"
read -r debloat_choice

if [ "$debloat_choice" = "y" ] || [ "$debloat_choice" = "Y" ]; then
    echo "🗑️  Debloating system..."
    
    if [ -f "extracted/system.img.ext4" ]; then
        # Convert sparse to raw
        simg2img extracted/system.img.ext4 modified/system_raw.img
        
        # Mount system image
        ensure_dir "system_mount"
        sudo mount -o loop modified/system_raw.img system_mount
        
        # Remove bloatware
        echo "Removing Samsung bloatware..."
        sudo rm -rf system_mount/app/Facebook_stub 2>/dev/null || true
        sudo rm -rf system_mount/app/SamsungBilling 2>/dev/null || true
        sudo rm -rf system_mount/app/BixbyAgent 2>/dev/null || true
        sudo rm -rf system_mount/app/Netflix_* 2>/dev/null || true
        sudo rm -rf system_mount/priv-app/BixbyService 2>/dev/null || true
        
        # Unmount
        sudo umount system_mount
        rmdir system_mount
        
        # Convert back to sparse
        img2simg modified/system_raw.img modified/system_debloated.img.ext4
        rm modified/system_raw.img
        
        echo "✅ System debloated"
    else
        echo "⚠️  system.img.ext4 not found, skipping debloat"
    fi
else
    # Just copy original system
    cp extracted/system.img.ext4 modified/ 2>/dev/null || echo "No system image to copy"
fi

echo ""

# Step 5: Create custom firmware package
echo "Step 5: Creating custom firmware package..."
ensure_dir "CUSTOM_FIRMWARE_$DEVICE"

# Create custom AP file
cd modified
echo "📦 Creating custom AP file..."

# Use debloated system if available, otherwise original
if [ -f "system_debloated.img.ext4" ]; then
    SYSTEM_IMG="system_debloated.img.ext4"
else
    SYSTEM_IMG="../extracted/system.img.ext4"
fi

# Create new AP tar
tar -H ustar -c boot_rooted.img ../extracted/recovery.img $SYSTEM_IMG > AP_ROOTED.tar

# Add MD5 checksum
md5sum AP_ROOTED.tar >> AP_ROOTED.tar
mv AP_ROOTED.tar AP_ROOTED.tar.md5

# Copy to firmware package
mv AP_ROOTED.tar.md5 ../CUSTOM_FIRMWARE_$DEVICE/

cd ..

# Copy other firmware files
cp BL_*.tar.md5 CUSTOM_FIRMWARE_$DEVICE/ 2>/dev/null || echo "⚠️  No BL file found"
cp CP_*.tar.md5 CUSTOM_FIRMWARE_$DEVICE/ 2>/dev/null || echo "⚠️  No CP file found"  
cp CSC_*.tar.md5 CUSTOM_FIRMWARE_$DEVICE/ 2>/dev/null || echo "⚠️  No CSC file found"

# Create flash script
cat > CUSTOM_FIRMWARE_$DEVICE/flash.sh << 'EOF'
#!/bin/bash

echo "=== Flashing Custom Galaxy Note 9 Firmware ==="
echo ""
echo "⚠️  WARNING: This will:"
echo "- VOID YOUR WARRANTY permanently"
echo "- TRIP KNOX security (permanent)"
echo "- REQUIRE COMPLETE DATA WIPE"
echo "- Risk of BRICK (recoverable with stock firmware)"
echo ""
echo "Make sure your device is in Download Mode:"
echo "1. Turn off device"
echo "2. Hold Volume Down + Bixby + Power"
echo "3. Press Volume Up to continue"
echo ""
read -p "Continue? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo "Aborted."
    exit 1
fi

echo "Flashing firmware..."
heimdall flash --AP AP_ROOTED.tar.md5 --BL BL_*.tar.md5 --CP CP_*.tar.md5 --CSC CSC_*.tar.md5

echo ""
echo "✅ Flashing complete!"
echo "Device should reboot automatically."
echo "After first boot, install Magisk APK for root management."
EOF

chmod +x CUSTOM_FIRMWARE_$DEVICE/flash.sh

# Copy Magisk APK to firmware package
cp $MAGISK_APK CUSTOM_FIRMWARE_$DEVICE/

echo "✅ Custom firmware package created"
echo ""

# Step 6: Summary
echo "=== MODIFICATION COMPLETE ==="
echo ""
echo "📁 Custom firmware location: CUSTOM_FIRMWARE_$DEVICE/"
echo "📱 Modified components:"
echo "   ✅ Boot image with root modifications"
echo "   ✅ ADB root enabled by default"
echo "   ✅ Init.d support added"
if [ "$debloat_choice" = "y" ] || [ "$debloat_choice" = "Y" ]; then
    echo "   ✅ System debloated"
fi
echo "   ✅ Magisk APK included"
echo ""
echo "🔧 To flash:"
echo "   cd CUSTOM_FIRMWARE_$DEVICE"
echo "   ./flash.sh"
echo ""
echo "📋 Recovery options:"
echo "   1. Flash stock firmware from parent directory"
echo "   2. Individual component flash (boot, system, etc.)"
echo "   3. Emergency recovery via Download Mode"
echo ""
echo "⚠️  REMEMBER: This process will trip Knox permanently!"

ls -la CUSTOM_FIRMWARE_$DEVICE/
