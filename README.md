| What | Value | Where I got it |
| :--- | :--- | :--- |
| **CPU Model** | Intel(R) N100 | `Get-CimInstance Win32_Processor` |
| **Cores / Threads** | 4 Cores / 4 Threads | `Get-CimInstance Win32_Processor` |
| **Total Memory** | 8 GB (1 module, Samsung) | `Get-CimInstance Win32_PhysicalMemory` |
| **Memory Speed** | 5600 MHz | `Get-CimInstance Win32_PhysicalMemory` |
| **Disk Model & Type**| SKhynix_HFS256GEM9X169N (NVMe SSD) | `Get-PhysicalDisk` |
| **Disk Free Space** | ~205 GB free on C: | `Get-Volume` |
| **Firmware Type** | UEFI (Version O71KT08A, Date: 9/22/2025) | `Get-CimInstance Win32_BIOS` |
| **Virtualization** | False | `Get-CimInstance Win32_Processor` |
 
## What did not work
All commands executed successfully on Windows PowerShell.
