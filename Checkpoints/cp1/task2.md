# task 2

# Allocation and Arithmetic
Host specs: 
- CPU: Intel Core i3-1115G4 (2 cores / 4 logical processors)
- RAM: 8 GB total (~7.7 GB usable, 1.62 GB available right now)
- Storage: 238.47 GB SSD, 13.01 GB free on C:
- Firmware: Virtualization is currently disabled in BIOS (VirtualizationFirmwareEnabled: False), so I need to enable Intel VT-x in BIOS first before booting 64-bild fron Vms

Can this laptop run both Ubuntu Server and Windows 11 at the same time?
- Yes, it can technically boot and run both guests simultaneously if I set minimal specs and use dynamically allocated disks, but it lags heavily because all 3 OSes share 2 physical cores and 8 GB RAM and C: drive gets almost completely full

| Guest | vCPUs | Memory | Disk size and type | Network adapters and mode |
| :--- | :--- | :--- | :--- | :--- |
| Ubuntu Server (CLI) | 1 vCPU | 1.5 GB (or 2 GB) | 15 GB, dynamically allocated | Adapter 1: NAT (internet)<br>Adapter 2: Host-Only (SSH from host) |
| Windows 11 | 1 vCPU | 2 GB | 25 GB, dynamically allocated | Adapter 1: NAT (internet) |

Arithmetic against Task 1 figures:
- **CPU:** Total 4 logical processors. I assign 1 vCPU to Ubuntu + 1 vCPU to Windows 11 = 2 vCPUs for guests, leaving 2 threads for the host. Since there are only 2 physical cores total, running 3 OSes causes CPU contention and lag.
- **RAM:** Total 8 GB (~7.7 GB usable). I assume the Windows 11 host needs at least 4 GB to stay usable. Giving 1.5 GB to Ubuntu + 2 GB to Windows 11 guest = **3.5 GB for guests**, leaving ~4.2 GB for the host ( 4.2 + 1.5 + 2 = 7.7 GB). Because my host already uses ~6 GB in background, running both guests forces heavy RAM swapping to the SSD.
- **Disk:** Total free space on C: is 13.01 G. Virtual max sizes are 15 GB + 25 GB = 40 GB, but with dynamic allocation Ubuntu takes ~3.5 GB and minimal Windows 11 takes ~8.5 GB = ~12 GB actual disk usage, leaving ~1 GB free on C: (very tight, which also slows down Windows pagefile).

What this configuration gives up:
It sacrifices smooth performance and sets the Windows 11 guest below its normal 4 GB RAM / 2 vCPU minimum. Both guests work, but the system lags due to swapping and low free disk space.

## Justification

- **Network mode (NAT + Host-Only on Ubuntu):** Bridged mode often fails on university/office networks because of MAC address filtering. NAT lets Ubuntu access the internet through my host's connection (so apt works), while the second Host-Only adapter creates a private local network between my laptop and Ubuntu so I can SSH into it from host PowerShell.
- **Dynamically allocated disks:** Fixed disks (15 GB + 25 GB = 40 GB) would not fit in my 13.01 GB free space at all. Dynamic disks only take actual used space (~12 GB total), allowing both VMs to fit.
- **Specs below minimum (1 vCPU, 2 GB RAM for Windows 11, CLI for Ubuntu):** Ubuntu Server has no GUI so 1.5 GB is enough. Windows 11 is cut to 2 GB and 1 vCPU so the host keeps 4 GB and does not crash completely.

## Verification Plan

1. **Check Ubuntu resources and disk (run inside Ubuntu terminal):**
   - free -h -> expected:  Mem: 1.4Gi (or  1.9Gi` if 2 GB assigned)
   - lsblk -> expected: virtual disk sda of 15G mounted at /

2. **Check Ubuntu internet access (run inside Ubuntu terminal):**
   - ping -c 4 8.8.8.8 -> expected: 4 packets transmitted, 4 received, 0% packet loss`

3. **Check SSH connection from host to Ubuntu:**
   - Inside Ubuntu run ip a -> expected: second interface (enp0s8) shows a Host-Only IP like 192.168.56.101
   - In Host PowerShell run ssh user@192.168.56.101 -> expected: connects and shows the Ubuntu bash prompt

4. **Check Windows 11 guest resources and internet (run in Guest PowerShell):**
   - Get-CimInstance Win32_OperatingSystem | Select-Object TotalVisibleMemorySize -> expected: around 2097152 KB (2 GB)
   - Test-Connection 8.8.8.8 -Count 2` -> expected: replies fromb 8.8.8.8 with Status: Success
