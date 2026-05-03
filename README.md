<div align="center">
  <h1>Nexulation</h1>
  <p>
    <strong>Playbook for Windows 10 22H2 & 11 22H2+</strong>
  </p>
  <p>
  </p>

  <p>
    <a href="https://github.com/dyagyatis/Nexulation/releases">
      <img src="https://img.shields.io/github/v/release/dyagyatis/Nexulation?style=for-the-badge&color=blue" alt="Release">
    </a>
    <img src="https://img.shields.io/badge/Platform-Windows%2010%20%7C%2011-0078D6?style=for-the-badge&logo=windows" alt="Platform">
    <img src="https://img.shields.io/badge/AME%20Wizard-0.8.3-orange?style=for-the-badge" alt="AME Wizard">
  </p>
</div>

---

## ⚡ About

**Nexulation** is a custom Playbook for AME Wizard designed to transform a standard Windows installation into a streamlined, high-performance gaming machine.

Built specifically for competitive gaming titles like **CS2, Fortnite**, where every millisecond of latency counts. We strip away telemetry, bloatware, and unnecessary background services, leaving only what is essential for stability and gaming performance.

---

## 📥 Installation

### Requirements
* A clean installation of Windows 10 22H2 or 11 22H2+.
* Internet connection.

### Instructions
1.  Download the latest release (`Nexulation.apbx`) from the [Releases](https://github.com/dyagyatis/Nexulation/releases) page.
2.  Download [AME Wizard](https://download.ameliorated.io/AME%20Beta.zip).
3.  Launch AME Wizard.
4.  Drag and drop the `Nexulation.apbx` file into the application window.
5.  Follow the on-screen instructions to customize your installation.
6.  Wait for the process to finish and the system to reboot.

---

## ⚙️ For Developers (Building)

If you want to modify this playbook or build it from source:

1.  Clone the repository:
    ```bash
    git clone https://github.com/dyagyatis/Nexulation.git
    ```
2.  Modify the configuration files in `Configuration/main.yml` or `playbook.conf`.
3.  Run `BUILD.bat` to compile the new `.apbx` file.

---

## ⚠️ Disclaimer

This playbook makes deep changes to the Windows Registry and system services.
* The authors are not responsible for any data loss or instability.
* Use at your own risk.
* It is highly recommended to apply this only on a **fresh Windows installation**.

---

<div align="center">
  Created by <strong>dyagyatis</strong> | 2026
</div>
