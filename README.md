<div align="center">
  <h1>🚀 Nexulation Core</h1>
  <p>
    <strong>High-Performance & Low-Latency AME Wizard Playbook for Windows 10 & 11</strong>
  </p>

  <p>
    <a href="https://github.com/dyagyatis/Nexulation/releases">
      <img src="https://img.shields.io/github/v/release/dyagyatis/Nexulation?style=for-the-badge&color=7289da" alt="Release">
    </a>
    <img src="https://img.shields.io/badge/Platform-Windows%2010%20%7C%2011-0078D6?style=for-the-badge&logo=windows" alt="Platform">
    <img src="https://img.shields.io/badge/AME%20Wizard-0.8.3-orange?style=for-the-badge" alt="AME Wizard">
    <img src="https://img.shields.io/badge/Architecture-x64-green?style=for-the-badge" alt="Architecture">
  </p>
</div>

---

## ⚡ About Nexulation

**Nexulation** is an advanced, scientifically engineered AME Wizard Playbook designed to optimize Windows 10 (22H2) and Windows 11 (22H2+) for competitive gaming (**CS2, Fortnite, Valorant**).

Unlike generic debloaters that break core Windows subsystems, Nexulation strictly adheres to **ZERO WAKEx64** low-latency principles — eliminating input lag, stabilizing frametimes, and removing unnecessary telemetry without breaking system integrity.

---

## 🔥 Key Engineering Features

- 🎯 **Win32PrioritySeparation = 0x18 (24)**: 1:1 quantum ratio between system and foreground application for smooth FPS and zero frame drops.
- ⚡ **Message Signaled Interrupts (MSI Mode)**: Automatic PCI-Express MSI mode configuration for GPU (High Priority), USB Host Controllers, Network Adapters, and NVMe drives.
- 🏎️ **Ultimate Performance & Zero Core Parking**: Locks CPU frequency scaling drops and disables Core Parking (`CPMINCORES = 100%`) to eliminate DPC/ISR spikes.
- 🖼️ **Native MPO & Flip Model Preserved**: Avoids forced FSO/FSE overrides that break DirectX Flip Model and cause stutters.
- 🛡️ **HVCI / Memory Integrity Disabled**: Disables Hypervisor Code Integrity (VBS/HVCI) in registry for +5–10% FPS boost.
- ⌨️ **Keyboard Responsiveness**: Sets `KeyboardDelay = 0` and `KeyboardSpeed = 31` for instantaneous key repeat.
- 📁 **Filesystem & Storage Tuning**:
  - Disables NTFS last access timestamps (`disablelastaccess 1`) and DOS 8.3 name creation (`disable8dot3 1`).
  - Forces active TRIM support (`DisableDeleteNotify 0`) for SSDs.
  - Disables background `ScheduledDefrag` tasks during gaming.
  - Disables file content indexing (`WSearch`) while preserving `SysMain` for HDDs.
- 🚫 **Background ETW Autologgers Killed**: Disables background `WMI\Autologger` tracing sessions (`DiagTrack`, `Circular Kernel`, `SQM`) freeing CPU cores.

---

## 📥 Installation

### Requirements
* A clean installation of **Windows 10 22H2** or **Windows 11 22H2–26H1**.
* Active Internet connection.

### Quick Start
1. Download `Nexulation.apbx` from the [Releases](https://github.com/dyagyatis/Nexulation/releases) page.
2. Download [AME Wizard](https://download.ameliorated.io/AME%20Beta.zip).
3. Open AME Wizard and drag-and-drop `Nexulation.apbx`.
4. Select your preferred options (Wallpapers, Browsers, Launchers, Gamer Tools).
5. Complete installation and reboot when prompted.

---

## 🛠️ Optional Gamer Tools (Included in UI)

During setup, you can optionally install curated tools directly:
- **Process Lasso** (CPU affinity & priority manager)
- **MSI Afterburner** (GPU tuning & monitoring)
- **LatencyMon** (DPC/ISR latency measurement)
- **7-Zip** & **Notepad++**

---

## ⚙️ Building from Source

```bash
git clone https://github.com/dyagyatis/Nexulation.git
cd Nexulation
BUILD.bat
```
The compiled Playbook will be saved as `Nexulation.apbx` (encrypted with standard AME password `malte`).

---

## ⚠️ Disclaimer

This playbook modifies system registry keys and Windows service configurations.
* Always backup critical data before applying.
* Designed and recommended for **fresh Windows installations**.

---

<div align="center">
  Created with ❤️ by <strong>dyagyatis</strong> | 2026
</div>
