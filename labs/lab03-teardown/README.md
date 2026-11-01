# Lab 03: Teardown without a screwdriver

Machine: ASUS VivoBook 15 X515EA (Host), Ubuntu Server 26.04 VM (Guest)  

---

## 1. The machine

* **Manufacturer:** ASUSTeK COMPUTER INC.
* **Exact Model:** ASUS VivoBook 15 X515EA (System Product: `VivoBook_ASUSLaptop X515EA_X515EA`, Version 1.0)
* **Identification Command (PowerShell on Host):**
  ```powershell
  Get-CimInstance Win32_ComputerSystemProduct | Format-List Name, Version, Vendor
  ```
* **Hardware Manual & Documentation Sources:**  
  ASUS does not publish a standalone public *Hardware Maintenance Manual (HMM)* for consumer VivoBook devices (as explicitly highlighted in Section 3 of the lab brief). In accordance with the course policy, official specifications and teardown documentation were combined:
  1. [Official ASUS VivoBook 15 X515EA Tech Specs](https://www.asus.com/laptops/for-home/everyday-use/asus-x515-11th-gen-intel/techspec/)
  2. [ASUS VivoBook 15 X515 Series User E-Manual](https://dlcdnets.asus.com/pub/ASUS/nb/X515EA/)
  3. [LaptopMedia / iFixit Hardware Teardown Guide for ASUS VivoBook 15 X515](https://laptopmedia.com/highlights/inside-asus-vivobook-15-x515-disassembly-and-upgrade-options/)

---

## 2. Components

Below is the internal architectural layout of the ASUS VivoBook 15 X515EA system board:

![ASUS VivoBook 15 X515EA Internal Layout](evidence/manual-figures/asus-x515ea-internal.png)

1. **CPU (Central Processing Unit):**
   * **What:** Intel Core i3-1115G4 (Tiger Lake), 2 physical cores / 4 threads, 3.00 GHz base clock, integrated under the unified heatsink.
   * **Connects to:** Soldered directly to the motherboard via BGA1449 (`SocketDesignation: U3E1`); direct point-to-point links to primary RAM channels and PCIe lanes.
   * **Limits:** Non-replaceable (BGA package). Thermal envelope bounded by a 15W–28W cTDP and single-fan heat pipe dissipation.

2. **Primary Memory (SO-DIMM Slot):**
   * **What:** 1× DDR4 SO-DIMM expansion slot (populated by an 8 GB Micron DDR4-3200 module, part `4ATF1G64HZ-3G2E1`).
   * **Connects to:** CPU integrated memory controller (Controller0-ChannelA).
   * **Limits:** Accepts DDR4 SO-DIMM only (260-pin, 1.2V). Slot hardware is officially limited to a maximum 16 GB SO-DIMM module.

3. **Primary Storage (M.2 NVMe Slot):**
   * **What:** 1× M.2 2280 M-Key PCIe SSD slot (populated by a 256 GB Western Digital PC SN530 NVMe drive).
   * **Connects to:** CPU/PCH high-speed PCIe lanes (routed via Intel VMD controller).
   * **Limits:** Keyed for M-key only; fits physical form factor 2280 (22 mm × 80 mm); PCIe 3.0 x4 bus interface.

4. **Secondary Storage (2.5" SATA Bay):**
   * **What:** 2.5-inch internal expansion bay with motherboard ribbon FPC connector for secondary SATA storage.
   * **Connects to:** Motherboard chipset (PCH SATA controller via flat ribbon flex-cable).
   * **Limits:** 2.5-inch drives up to 7.0 mm / 9.5 mm thickness only; SATA 3.0 interface capped at 6.0 Gbps (~550 MB/s sequential transfer rate).

5. **WLAN / Bluetooth Module:**
   * **What:** Intel/Realtek Wi-Fi + Bluetooth wireless adapter card.
   * **Connects to:** M.2 Key-E (2230) slot with two antenna micro-coaxial connectors (I-PEX/U.FL).
   * **Limits:** Interface form factor 2230 only; replaceable for Wi-Fi 6/6E modules.

6. **Cooling Assembly:**
   * **What:** Single radial blower fan and copper heat pipe conducting heat from the CPU die to the rear exhaust fins.
   * **Connects to:** Motherboard 4-pin PWM fan header and chassis exhaust vent.
   * **Limits:** Limits sustained multi-core boost clocks under heavy thermal dissipation loads (thermal throttling occurs above 90°C).

7. **Main Battery Pack:**
   * **What:** 2-cell Lithium-ion rechargeable battery (37 Wh, 4850 mAh).
   * **Connects to:** Direct multi-pin battery terminal connector on the lower edge of the motherboard.
   * **Limits:** Proprietary chassis screw mounting and custom form factor; cannot be expanded past manufacturer battery bay enclosure dimensions.

---

## 3. Upgrade verdict

### Upgradeability Assessment Table

| Component | Manual / Spec Sheet Says | OS Says (`windows-specs.txt`) | Verdict |
| :--- | :--- | :--- | :--- |
| **Memory (RAM)** | 1× SO-DIMM slot; max system memory 16 GB (ASUS spec page) | `MemoryDevices: 2`, `FormFactor: 12` (SO-DIMM), `MaxCapacity: 67108864` (64 GB) | **Partly:** 1 physical slot available. Can replace current 8 GB stick with a 16 GB module. |
| **Storage (SSD/HDD)** | 1× M.2 2280 PCIe 3.0 NVMe slot + optional 2.5" SATA bay | `NVMe WDC PC SN530`, `BusType: RAID` (Intel VMD), `Size: ~256 GB` | **Yes:** Fully replaceable with any standard M.2 2280 NVMe SSD, plus secondary 2.5" SATA drive expansion. |
| **CPU (Processor)** | Integrated Tiger Lake mobile processor on system board | `SocketDesignation: U3E1` (BGA1449), soldered to system board | **No:** CPU is soldered directly via Ball Grid Array (BGA). Cannot be removed or upgraded. |

### Technical Analysis of Discrepancies
* **Memory Capacity (`MaxCapacity`):** PowerShell reports `MaxCapacity: 64 GB`, whereas the official manufacturer specification sets the limit at 16 GB. The OS does not inspect motherboard traces; it merely reads the SMBIOS Type 16 table populated by firmware. The vendor BIOS template hardcodes the theoretical architectural maximum of the Intel Tiger Lake memory controller (64 GB) rather than the physical board routing limits. The service documentation is the authoritative ground truth: 16 GB is the validated hardware ceiling.
* **Storage Bus Type (`BusType`):** PowerShell reports `BusType: RAID` instead of `NVMe` for the WD SN530 SSD. This is caused by the ASUS default BIOS setting enabling Intel VMD (Intel Rapid Storage Technology), which hooks the NVMe controller behind a proprietary storage abstraction layer. The drive itself is physically an M.2 PCIe NVMe SSD.

---

## 4. Comparison table: Host (Windows) vs. Guest VM (Linux)

| Fact | Windows Field & Value (Host) | Linux Field & Value (Ubuntu Server VM) |
| :--- | :--- | :--- |
| **CPU Model** | `Win32_Processor.Name` = `11th Gen Intel(R) Core(TM) i3-1115G4 @ 3.00GHz` | `lscpu.Model name` = `11th Gen Intel(R) Core(TM) i3-1115G4 @ 3.00GHz` |
| **Physical Cores** | `Win32_Processor.NumberOfCores` = `2` | `lscpu.Core(s) per socket` × `Socket(s)` = `2` × `1` = `2` |
| **Logical CPUs** | `Win32_Processor.NumberOfLogicalProcessors` = `4` | `lscpu.CPU(s)` = `2` (Allocated vCPUs) |
| **Max Clock Speed** | `Win32_Processor.MaxClockSpeed` = `2995 MHz` | `lscpu.CPU max MHz` = *(Hypervisor abstracted / dynamic)* |
| **L2 / L3 Cache** | `Win32_Processor.L2CacheSize` = `2560 KB`, `L3CacheSize` = `6144 KB` | `lscpu.L2 cache` = `2.5 MiB`, `L3 cache` = `6 MiB` |
| **Total Memory** | `Win32_ComputerSystem.TotalPhysicalMemory` = `8269565952` bytes (~7.70 GiB) | `free -h.total` = `1.9Gi` (Virtual RAM allocation) |
| **Memory Type & Speed** | `Win32_PhysicalMemory.Speed` = `3200`, `FormFactor` = `12` (SO-DIMM) | `dmidecode -t 17.Form Factor` = `DIMM`, `Size` = `No Module Installed` (Virtual placeholder) |
| **Disk MediaType / SSD** | `Get-PhysicalDisk.MediaType` = `SSD` | `lsblk.ROTA` = `1` (Virtual disk emulates rotational device) |
| **Disk Interface / Bus** | `Get-PhysicalDisk.BusType` = `RAID` (Intel VMD NVMe) | `lsblk.TRAN` = `spi` (Abstracted VMware virtual SCSI bus) |
| **Motherboard Model** | `Win32_BaseBoard.Product` = `X515EA` (ASUSTeK) | `dmidecode -t 2.Product Name` = `440BX Desktop Reference Platform` (Intel/VMware) |

### Observation on Differences Between Host and VM
1. **Field Naming & Formatting:** Windows WMI/CIM classes present raw unformatted integer bytes (e.g., `8269565952` bytes) and numeric enumeration flags (`FormFactor: 12`), requiring manual decoding. Linux displays human-readable binary prefixes (`free -h` shows GiB = $1024^3$ bytes).
2. **Virtualization Abstraction:** The Linux VM intentionally masks physical reality. The real motherboard (`ASUS X515EA`) is replaced by an emulated `Intel 440BX` chipset dating back to 1998. The real NVMe SSD is abstracted as a virtual SCSI device (`sda` over `spi` bus with `ROTA=1`). This demonstrates why Part A commands must execute exclusively on the bare-metal host.

---

## Evidence

* [evidence/windows-specs.txt](evidence/windows-specs.txt) — Raw PowerShell transcript verifying physical hardware specifications of the ASUS VivoBook 15 host.
* [evidence/linux-specs.txt](evidence/linux-specs.txt) — Raw Linux command log verifying CPU, memory, and virtual storage abstraction in the Ubuntu guest.
* [evidence/manual-figures/asus-x515ea-internal.png](evidence/manual-figures/asus-x515ea-internal.png) — Annotated internal layout diagram identifying seven key motherboard components with connections and limitations.
