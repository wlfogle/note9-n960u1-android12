# Samsung Galaxy Note 9 SM-N960U1 - Android 12+ Guide

## 🎉 **EXCELLENT MODEL FOR CUSTOM ROMS!**

**Your SM-N960U1 (US Unlocked) is one of the BEST Note 9 variants for custom ROMs:**
- ✅ **Bootloader is factory unlocked** (that's why no "OEM unlocking" option!)
- ✅ **No carrier restrictions**
- ✅ **Full LineageOS support**
- ✅ **Active development community**

**Serial:** RF8KB0T1K9M

## 📱 **SM-N960U1 Specific Information:**

### **Why No "OEM Unlocking" Option?**
- The SM-N960U1 comes with an **unlocked bootloader** from factory
- Samsung removed the toggle because it's permanently unlocked
- This is PERFECT for custom ROM installation!

### **ROM Compatibility:**
- ✅ LineageOS 19.1/20 (Android 12L/13)
- ✅ PixelExperience 12/13
- ✅ crDroid 9.x/10.x
- ✅ ArrowOS 12/13

## 🔧 **SM-N960U1 Flash Process:**

### **Step 1: Enable USB Debugging**
```
Settings → About phone → Tap "Build number" 7 times
Settings → Developer options → USB debugging (ON)
```

### **Step 2: Download Required Files**
- **TWRP:** `twrp-3.7.0_9-0-crownqltesq.img` (U1 specific)
- **LineageOS 20:** Latest nightly for crownqltesq
- **GApps:** MindTheGApps 13.0 ARM64

### **Step 3: Flash TWRP Recovery**
```bash
# Boot to Download Mode: Vol Down + Bixby + Power
heimdall flash --RECOVERY twrp-3.7.0_9-0-crownqltesq.img --no-reboot

# Immediately boot to recovery: Vol Up + Bixby + Power
```

### **Step 4: Install ROM**
1. **Backup current ROM** in TWRP
2. **Wipe:** System, Data, Cache, Dalvik
3. **Install:** LineageOS ZIP
4. **Install:** GApps ZIP
5. **Reboot** (first boot takes 10-15 minutes)

## 📥 **Download Links for SM-N960U1:**

### **TWRP Recovery:**
- https://dl.twrp.me/crownqltesq/
- File: `twrp-3.7.0_9-0-crownqltesq.img`

### **LineageOS 20 (Android 13):**
- https://download.lineageos.org/crownqltesq
- Latest nightly build

### **LineageOS 19.1 (Android 12L):**
- More stable, if you prefer Android 12

### **GApps:**
- MindTheGApps: https://androidfilehost.com/?w=files&flid=322935
- Choose ARM64, Android 13.0

## ⚠️ **SM-N960U1 Specific Warnings:**

1. **Knox will be permanently tripped** (goodbye Samsung Pay)
2. **Always use crownqltesq files**, not regular crown
3. **Don't flash international (SM-N960F) firmware**
4. **Backup your EFS partition** before flashing

## 🚀 **Advantages of Your Model:**
- Factory unlocked bootloader
- No carrier bloatware to remove
- Maximum ROM compatibility
- Active development support
- Easy recovery if something goes wrong

**Ready to proceed? Your SM-N960U1 is actually the BEST Note 9 for this process!**
