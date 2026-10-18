# LAB 00

| What | Value | Where I got it |
| :--- | :--- | :--- |
| **CPU Model** | 11th Gen Intel(R) Core(TM) i3-1115G4 | `Get-CimInstance Win32_Processor` |
| **Cores / Threads** | 2 Cores / 4 Threads | `Get-CimInstance Win32_Processor` |
| **Total Memory** | 8 GB (1 module, Micron) | `Get-CimInstance Win32_PhysicalMemory` |
| **Memory Speed** | 3200 MHz | `Get-CimInstance Win32_PhysicalMemory` |
| **Disk Model & Type** | WDC PC SN530 SDBPNPZ-256G (NVMe SSD) | `Get-PhysicalDisk` |
| **Disk Free Space** | ~205 GB free on C: | `Get-Volume` |
| **Firmware Type** | UEFI | `Get-CimInstance Win32_BIOS` |
| **Virtualization** | True | `Get-CimInstance Win32_Processor` |
 
## What did not work
All commands executed successfully on Windows Powershell
