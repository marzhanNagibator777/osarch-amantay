# Task 1 — Inventory and Interpret

## 1a. The computer in front of you

| Figure | This computer | Command it came from |
| :--- | :--- | :--- |
| CPU model | 11th Gen Intel(R) Core(TM) i3-1115G4 @ 3.00GHz | `Get-CimInstance Win32_Processor` |
| Cores / logical processors | 2 cores / 4 logical processors | `Get-CimInstance Win32_Processor` |
| Hardware virtualization: supported? enabled in firmware? | Supported (Intel VT-x), disabled in BIOS (`VirtualizationFirmwareEnabled: False`) | `Get-CimInstance Win32_Processor` |
| Memory: total / available now | 8 GB total (`8075748 KB`) / ~1.62 GB (`1700260 KB`) available | `Get-CimInstance Win32_OperatingSystem` |
| System disk: size, free space, SSD or HDD | 238.47 GB total (C: is 236.93 GB), 13.01 GB free, SSD (`NVMe WDC PC SN530`) | `Get-PhysicalDisk`, `Get-Volume -DriveLetter C` |
| Partition style of the system disk | GPT | `Get-Disk` |
| OS and version | Windows 11 Home Single Language, 10.0.26200 | `Get-CimInstance Win32_OperatingSystem` |

## 1b. Thin-and-light laptop questions

1. **Both guests?**
No, this laptop cannot run both guests from Labs 1-2 at the same time.
First, it has Windows 11 Home in S mode, which blocks installing VirtualBox or VMware, and Home edition does not have Hyper-V
Second, the math does not work out:
- RAM: The laptop has 8 GB total. If I leave 4 GB for Windows host, only 4 GB is left. In Labs 1-2 I used [X GB for Linux + Y GB for Windows = Z GB], so [4 + Z] GB is more than 8 GB. It will swap heavily on slow eMMC storage.
- Disk: There is only 31 GB free on the 128 GB eMMC. My Lab 1-2 disks were [X GB + Y GB], so even with dynamic disks, both OSes plus updates and pagefile will run out of the 31 GB free space.
- CPU: It only has 2 cores / 4 threads at 1.1 GHz, so running 3 OSes together will be very slow.

2. **Upgrade first?**
Nothing can be upgraded inside because the 8 GB RAM and 128 GB eMMC are soldered to the motherboard.
Instead, I would first switch out of Windows 11 S mode to regular Windows 11 Home (free in Microsoft Store) so a hypervisor can be installed. Then I would connect an external USB SSD to store the virtual disks, and run only one lightweight Linux VM (1-2 GB RAM) at a time instead of running both guests together.
