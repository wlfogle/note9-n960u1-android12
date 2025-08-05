# Samsung Galaxy Note 9 SM-N960U1 - Android 12+ Installation Guide

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Device: SM-N960U1](https://img.shields.io/badge/Device-SM--N960U1-blue.svg)](https://www.gsmarena.com/samsung_galaxy_note9-9163.php)
[![Android: 12+](https://img.shields.io/badge/Android-12+-green.svg)](https://developer.android.com/about/versions/12)

> **Complete guide to bypass Samsung's EOL restrictions and install Android 12+ on the Galaxy Note 9 US Unlocked variant**

## 🎯 **Quick Start**

**Your SM-N960U1 is PERFECT for custom ROMs!** The bootloader is factory unlocked, making this process straightforward.

### ⚡ **TL;DR Process:**
1. Enable USB Debugging
2. Flash TWRP Recovery
3. Install Android 12+ ROM
4. Enjoy modern Android!

[**📖 View Full Guide**](docs/installation-guide.md) | [**🛠️ Setup Scripts**](scripts/) | [**📱 Supported ROMs**](docs/supported-roms.md)

---

## 🚨 **Important Disclaimer**

**⚠️ WARNING: This process will:**
- Void your warranty permanently
- Trip Samsung Knox (disables Samsung Pay, Secure Folder, etc.)
- Erase all data on your device
- Risk bricking if done incorrectly

**✅ PROCEED ONLY IF:**
- You understand the risks
- You have backed up important data
- You have the correct model (SM-N960U1)
- You're comfortable with command line tools

---

## 📱 **Device Compatibility**

| Model | Codename | Bootloader | Status |
|-------|----------|------------|---------|
| SM-N960U1 | crownqltesq | ✅ Unlocked | ✅ Supported |
| SM-N960U | crownqlteue | ❌ Locked | ❌ Not Supported |
| SM-N960F | crown | ✅ Unlockable | ⚠️ Different Process |

**This guide is ONLY for SM-N960U1 (US Unlocked variant)**

---

## 🛠️ **NEW: Firmware Modification Toolkit**

Complete toolkit for creating custom rooted firmware packages:

### **📁 firmware_modification/ Directory:**
- **modify_firmware.sh** - Main firmware modification script
- **AIK-Linux/** - Android Image Kitchen for boot image manipulation
- **Magisk-v29.0.apk** - Latest Magisk APK for root management
- **download_firmware_direct.sh** - Direct firmware download utility
- **FIRMWARE_MODIFICATION_GUIDE.md** - Comprehensive modification guide

### **✨ Features:**
- ✅ **Automatic LZ4 decompression** of Samsung firmware
- ✅ **Boot image modification** with ADB root enabled
- ✅ **Init.d support** for custom initialization scripts
- ✅ **Optional debloating** - removes Samsung bloatware
- ✅ **Safe packaging** with MD5 checksums and recovery options
- ✅ **Error handling** and comprehensive logging

### **🚀 Quick Usage:**
```bash
cd firmware_modification/
./download_firmware_direct.sh    # Download stock firmware
./modify_firmware.sh             # Create rooted firmware package
# Flash the generated CUSTOM_FIRMWARE_SM-N960U1/ package
```

### **⚠️ Important Notes:**
- Creates **rooted firmware** with Magisk integration
- **Permanently trips Knox** security
- Includes **recovery options** for unbricking
- Works with **stock N960U1UEU9FVG2** firmware

---

## 🏆 **Why SM-N960U1 is Great for Custom ROMs**

- **Factory unlocked bootloader** (no OEM unlock needed)
- **No carrier restrictions**
- **Active development community**
- **Multiple ROM options available**
- **Easy recovery if something goes wrong**

---

## 📋 **What You'll Get**

### **Modern Android Features:**
- ✅ Android 12, 13, or 14 (depending on ROM choice)
- ✅ Latest security patches
- ✅ Material You design
- ✅ Privacy improvements
- ✅ Performance optimizations

### **Popular ROM Options:**
- **LineageOS 21** (Android 14) - Most stable
- **PixelExperience** (Android 12/13) - Pixel features
- **crDroid** (Android 12/13) - Heavy customization
- **ArrowOS** (Android 12/13) - Clean AOSP

---

## 🛠️ **Prerequisites**

### **Hardware:**
- Samsung Galaxy Note 9 SM-N960U1
- USB cable (data transfer capable)
- Computer running Linux, Windows, or macOS
- MicroSD card (recommended for backups)

### **Software:**
- ADB and Fastboot tools
- Heimdall (Samsung flashing tool)
- TWRP recovery image
- Custom ROM ZIP file
- GApps package (optional)

### **Knowledge:**
- Basic command line usage
- Understanding of Android system partitions
- Comfort with potentially risky procedures

---

## 📚 **Documentation**

| Document | Description |
|----------|-------------|
| [Installation Guide](docs/installation-guide.md) | Complete step-by-step process |
| [Supported ROMs](docs/supported-roms.md) | Available Android 12+ ROMs |
| [Troubleshooting](docs/troubleshooting.md) | Common issues and solutions |
| [Recovery Guide](docs/recovery.md) | How to unbrick your device |
| [FAQ](docs/faq.md) | Frequently asked questions |

---

## 🚀 **Quick Setup (Linux)**

```bash
# Clone this repository
git clone https://github.com/wlfogle/note9-n960u1-android12.git
cd note9-n960u1-android12

# Run setup script (Arch/Manjaro/Garuda)
./scripts/setup-arch.sh

# Or install manually
sudo pacman -S android-tools heimdall

# Enable USB debugging on your phone:
# Settings → About phone → Tap "Build number" 7 times
# Settings → Developer options → USB debugging (ON)

# Test connection
adb devices
```

---

## 🤝 **Contributing**

Found an issue or want to improve the guide?

1. **Fork** this repository
2. **Create** a feature branch (`git checkout -b feature/improvement`)
3. **Commit** your changes (`git commit -am 'Add improvement'`)
4. **Push** to the branch (`git push origin feature/improvement`)
5. **Create** a Pull Request

### **Contribution Guidelines:**
- Test all procedures before submitting
- Update documentation for any changes
- Include screenshots where helpful
- Follow existing formatting style

---

## 📊 **Success Stories**

| User | ROM | Android Version | Status |
|------|-----|-----------------|---------|
| @lou | LineageOS 21 | Android 14 | ✅ Working |
| @example | PixelExperience | Android 13 | ✅ Working |

*Add your success story via PR!*

---

## 🔗 **Useful Links**

- [XDA Note 9 Forum](https://forum.xda-developers.com/t/samsung-galaxy-note-9-sm-n960u-u1.3834787/)
- [LineageOS Downloads](https://download.lineageos.org/)
- [TWRP for Note 9](https://twrp.me/samsung/samsunggalaxynote9usunlocked.html)
- [Stock Firmware](https://sammobile.com/samsung/galaxy-note-9/firmware/SM-N960U1/)

---

## 📄 **License**

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## ⭐ **Support This Project**

If this guide helped you successfully install Android 12+ on your Note 9:

- ⭐ **Star** this repository
- 🍴 **Fork** and contribute improvements
- 📢 **Share** with other Note 9 users
- 💡 **Report** issues and suggest enhancements

---

**🚨 Remember: You proceed at your own risk. The authors are not responsible for bricked devices, voided warranties, or any other consequences.**

---

*Last updated: January 2025*
