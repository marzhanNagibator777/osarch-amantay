# Lab 01: Your first virtual machine

## 1. Resource Allocation Justification
My host machine is a Windows laptop with an Intel Core i3 processor and 8 GB of RAM. Based on my host's constraints and the behavior of the VM, I allocated the following resources:

* **vCPU: 1 core**. My host has a basic i3 processor. Allocating more cores could slow down the host Windows OS, and 1 core is perfectly sufficient for a console-only Ubuntu Server.
* **RAM: 2048 MB (2 GB)**. Initially, I allocated 1024 MB. However, during the installation process, the Ubuntu Subiquity installer crashed with an Out-of-Memory (OOM) error (`generating crash report`) at the package extraction stage. Since Windows idle processes consume around 6 GB of my total 8 GB RAM, 2048 MB was the maximum safe amount I could allocate to allow the installer to finish successfully without freezing my host machine.
* **Disk: 20 GB (Dynamic)**. I initially experienced complete VM freezes because my host's C: drive had only 4 GB of free space. After clearing 90 GB on my host, I allocated a 20 GB virtual disk, which is more than enough for the base OS and future labs.

## 2. Break and Rollback Cycle
To prove the ability to revert changes, I performed the following steps:
1. **Snapshot**: Took a snapshot named `clean-install` immediately after the first successful boot and login.
2. **Break**: Deliberately deleted the server's hostname configuration file by running `sudo rm /etc/hostname`. 
3. **Verify Damage**: Ran `cat /etc/hostname` which returned `No such file or directory`. (See `evidence/broken.png`).
4. **Rollback**: Used VMware Snapshot Manager to revert to the `clean-install` state. (See `evidence/snapshot-list.png`).
5. **Verify Recovery**: Logged back in and ran `cat /etc/hostname` again. The file was restored, and the system output the correct hostname (`marzhan`).
