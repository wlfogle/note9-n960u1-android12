# SM-N960U1 Android 12+ Installation Guide

## ✅ **YOUR ADVANTAGES:**
- **SM-N960U1** = US Unlocked (BEST variant for custom ROMs!)
- **Bootloader already unlocked** (no OEM unlock needed)
- **Serial:** RF8KB0T1K9M
- **No carrier restrictions**

## 📋 **STEP-BY-STEP PLAN:**

### **PHASE 1: Enable ADB Access**
1. **Enable Developer Options:**
   ```
   Settings → About phone → Tap "Build number" 7 times
   ```

2. **Enable USB Debugging:**
   ```
   Settings → Developer options → USB debugging (ON)
   ```

3. **Test ADB connection:**
   ```bash
   adb devices
   # Should show: RF8KB0T1K9M device
   ```

### **PHASE 2: Choose Your ROM**

**🏆 RECOMMENDED: LineageOS 21 (Android 14)**
- Most stable option
- Active development
- Best hardware support

**🔍 WHERE TO FIND ROMS:**
1. **XDA Forums:** https://forum.xda-developers.com/t/samsung-galaxy-note-9-sm-n960u-u1.3834787/
2. **LineageOS Unofficial:** Search for "LineageOS 21 Note 9 N960U1"
3. **PixelExperience:** May have N960U1 builds

### **PHASE 3: Download Required Files**

**📥 MANUAL DOWNLOADS NEEDED:**
1. **TWRP Recovery:**
   - Go to: https://twrp.me/samsung/samsunggalaxynote9usunlocked.html
   - Download: `twrp-3.7.0_9-0-crownqltesq.img`

2. **ROM ZIP File:**
   - LineageOS 21 for crownqltesq
   - Or alternative from XDA

3. **GApps (Optional):**
   - MindTheGApps ARM64 for Android 14
   - Or MicroG for privacy

### **PHASE 4: Backup Everything**
```bash
# Run our backup script
./backup_before_flash.sh

# Additional manual backups in TWRP:
# - Boot partition
# - System partition  
# - EFS partition (CRITICAL!)
```

### **PHASE 5: Flash Process**

1. **Boot to Download Mode:**
   ```
   Power off → Hold: Vol Down + Bixby + Power
   ```

2. **Flash TWRP:**
   ```bash
   heimdall flash --RECOVERY twrp-3.7.0_9-0-crownqltesq.img --no-reboot
   ```

3. **Boot to TWRP immediately:**
   ```
   Vol Up + Bixby + Power (right after flash)
   ```

4. **In TWRP:**
   - Backup → Full system backup to SD card
   - Wipe → Advanced → System, Data, Cache, Dalvik
   - Install → ROM ZIP
   - Install → GApps ZIP (if using)
   - Reboot → System

## 🔧 **CURRENT STATUS:**

### **✅ COMPLETED:**
- [x] Tools installed (Heimdall, ADB)
- [x] Environment set up
- [x] Device model identified
- [x] Bootloader status confirmed (unlocked!)

### **📋 NEXT STEPS:**
1. **Enable USB debugging** on your phone
2. **Find working ROM** (check XDA forums)
3. **Download TWRP** manually
4. **Create full backup**
5. **Flash TWRP and ROM**

## 🔗 **KEY RESOURCES:**

**XDA Thread for N960U1:**
https://forum.xda-developers.com/t/samsung-galaxy-note-9-sm-n960u-u1.3834787/

**TWRP Official:**
https://twrp.me/samsung/samsunggalaxynote9usunlocked.html

**Stock Firmware (emergency):**
https://sammobile.com/samsung/galaxy-note-9/firmware/SM-N960U1/

## ⚠️ **CRITICAL WARNINGS:**
- **Knox will be permanently tripped**
- **Samsung Pay will stop working**
- **Always use N960U1/crownqltesq files**
- **Don't flash N960F (international) files**
- **Have stock firmware ready for recovery**

---

**🎯 NEXT ACTION:** Enable USB debugging, then I can help you find and download the right ROM!
