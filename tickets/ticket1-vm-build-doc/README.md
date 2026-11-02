# Ticket 1 — “New developer starts Monday, needs a test machine”

* **Host Platform:** ASUS VivoBook 15 X515EA (Intel Core i3-1115G4, 8 GB RAM, 256 GB NVMe SSD, Windows 11)
* **Deliverable Directory:** `tickets/ticket1-vm-build-doc/`

---

## 1. What was asked

The original support ticket was submitted by internal office management as follows:

> From: Aigerim T. (Office Manager)  
> Subject: test machine for new dev  
>  
> Hi, we have someone starting on Monday and he needs a test computer  
> set up. Nothing special, just so he can try things without breaking  
> anything. Can you write down how to do it so I can do the next one  
> myself? Thanks

---

## 2. What was actually needed

The submitted request is vague, omits critical engineering constraints, and mischaracterizes the requirements of developer sandboxes:

1. **Missing Information Left Out by the Request:**
   * **Target Stack & OS:** The request does not specify whether the developer requires Linux or Windows, which distribution is needed, or whether a GUI desktop is necessary.
   * **Host Resource Capacity:** No hardware specifications of the deployment host were provided.
   * **Network Architecture:** The request is silent on whether the machine requires external Internet access, campus intranet access, or complete physical isolation.
   * **Reproducibility & Recovery:** No provision was made for what happens when the developer inevitably breaks the system configuration.

2. **Where the Request is Conceptually Wrong:**
   * Aigerim states the machine is *"Nothing special, just so he can try things without breaking anything."* A developer testbox is never "nothing special": unhardened default hypervisor deployments bridged to campus Wi-Fi expose the company intranet to untested software and trigger campus MAC address filtering blocks. 

3. **What I Would Have Asked the Requester:**
   * What tech stack, programming runtimes, or database services will the developer run?
   * What are the exact physical RAM and storage specifications of the host machine?
   * Does the developer need to connect remotely via SSH/VS Code, or will they work solely inside the hypervisor window?

4. **Resource Calculations & Engineering Assumptions Made:**
   * **Real Host Specs:** Physical audit of my ASUS VivoBook 15 X515EA shows **8 GB (8,269,565,952 bytes) physical RAM** and a **256 GB (256,060,514,304 bytes) NVMe SSD**.
   * **Memory Budget Calculation:** Windows 11 requires a minimum of 4.0 GB RAM to operate smoothly without paging thrash. Allocating exactly **2048 MB (2 GB)** to the Ubuntu Linux test VM and leaving an allowance for an optional 2 GB secondary test VM guarantees at least 4.0 GB remains committed to the host OS.
   * **Storage Budget Calculation:** The host has ~14.5 GB free space on the active volume. Allocating a preallocated 20 GB disk would exhaust host storage immediately. Therefore, dynamic **Thin Provisioning (non-preallocated)** was mandatory: the guest exposes a 20 GB logical block capacity but initially consumes under 1.5 GB physically on the host SSD.
   * **Network Isolation:** NAT networking (`VMnet8`) was selected to bypass Innotech MAC-address campus filtering while granting outbound WAN access for package installation (`apt`, `git`).
   * **Snapshot Hygiene:** A baseline snapshot (`clean-install`) was introduced to protect Aigerim from having to rebuild the machine when experiments fail.

---

## 3. What I did

1. **Hypervisor Configuration:** Launched VMware Workstation Pro and initiated the VM wizard using *Typical* mode to guarantee standard chipset emulation.
2. **Resource Provisioning:**
   * Sized virtual memory to **2048 MB RAM** and virtual CPU to **1 socket / 2 cores**.
   * Created a **20.0 GB virtual disk** formatted as split files with **Thin Provisioning** (disabled *Allocate all disk space now*) to preserve host SSD capacity.
3. **Network Implementation:** Bound the virtual network interface to **NAT** (`VMnet8`), isolating the guest behind the host's IP while allowing outbound DHCP leases in the `192.168.140.0/24` scope.
4. **Operating System Deployment:** Installed Ubuntu Server LTS headlessly, provisioned a non-root administrative account, and installed the **OpenSSH Server** service for CLI terminal workflows.
5. **Connectivity and Environment Verification:**
   * Checked kernel architecture via `uname -a`.
   * Verified network reachability between disparate guest environments (bidirectional ping tests between Windows 11 at `192.168.140.132` and Ubuntu Server at `192.168.140.131` with zero packet loss).
6. **State Preservation:** Generated a baseline snapshot titled `clean-install` immediately after initial package updates.
7. **Documentation Authoring:** Authored `BUILD.md` in explicit, plain English with screenshots and architectural rationale behind every setting for Aigerim.

### Settings That Differ From Default and Why

| Setting | Wizard Default | Selected Value | Reason for Departure |
| :--- | :--- | :--- | :--- |
| **OS Media Attachment** | Immediate ISO Mount (Easy Install) | *Install OS later* | Prevents VMware Easy Install from generating unwanted default accounts and bypassing network/OpenSSH setup prompts. |
| **Disk Allocation** | Single preallocated or thick file | 20 GB Thin Provisioned (Split) | Avoids consuming 20 GB of physical SSD space immediately on a host limited to 256 GB storage. |
| **Memory Allocation** | 4096 MB (on some Linux presets) | 2048 MB | Host has only 8 GB total RAM; capping VM at 2 GB ensures the host OS does not suffer memory exhaustion. |
| **Network Adapter** | Bridged or Host-only (varies) | NAT (`VMnet8`) | Bypasses Innotech campus Wi-Fi MAC address filtering while providing outbound Internet access. |

### What Went Wrong and How I Resolved It

* **Problem (Windows Firewall ICMP Drop):**  
  During cross-guest reachability validation, executing `ping -c 4 192.168.140.132` from the Linux guest to the Windows 11 guest timed out with 100% packet loss, despite both machines possessing valid DHCP leases on the `192.168.140.0/24` NAT subnet.
* **Root Cause:**  
  Windows 11 enables the Windows Defender Firewall by default on private and public network profiles, which blocks inbound ICMPv4 Echo Requests (ping) out of the box.
* **Resolution:**  
  Inside the Windows 11 guest, I opened an elevated administrative terminal and enabled the inbound echo request rule:
  ```cmd
  netsh advfirewall firewall add rule name="Allow ICMPv4-In" protocol=icmpv4:8,any dir=in action=allow
  ```
  Immediately after adding this firewall rule, re-running `ping -c 4 192.168.140.132` from Ubuntu returned replies with 0% packet loss and an average round-trip latency of 5.84 ms, verifying inter-guest connectivity[cite: 19].

---

## 4. Evidence

* [evidence/01-new-vm-wizard.png](evidence/01-new-vm-wizard.png) — Proves selection of the *Typical* wizard mode to guarantee hardware bus and chipset compatibility.
* [evidence/02-disk-settings.png](evidence/02-disk-settings.png) — Proves allocation of a 20 GB virtual disk with thin dynamic allocation (*Disk space is not preallocated*).
* [evidence/03-network-adapter.png](evidence/03-network-adapter.png) — Proves network configuration under NAT to avoid Innotech MAC address filtering.
* [evidence/04-guest-uname.txt](evidence/04-guest-uname.txt) — Command transcript of `uname -a` proving successful deployment of 64-bit Linux kernel `7.0.0-38-generic`[cite: 18].
* [evidence/05-ping-between-guests.txt](evidence/05-ping-between-guests.txt) — Log demonstrating bidirectional ICMP reachability (0% packet loss) between Windows (`192.168.140.132`) and Ubuntu (`192.168.140.131`)[cite: 19].
* [evidence/06-snapshot-list.png](evidence/06-snapshot-list.png) — Snapshot Manager tree verifying the baseline state `clean-install` exists for recovery.

---

## 5. What I would do differently

* **Implement Infrastructure-as-Code (Vagrant / Packer):**  
  Instead of relying on an interactive manual GUI wizard, I would author a `Vagrantfile` or Packer HCL configuration. This would allow Aigerim to run a single command (`vagrant up`) in terminal to provision the entire developer environment headlessly in under 3 minutes, eliminating manual human configuration errors entirely.
* **Automated Cloud-Init Provisioning:**  
  I would attach an automated `user-data` cloud-init configuration during the initial boot. This would automatically inject authorized corporate SSH public keys, create non-root developer accounts, and pre-install Docker, Git, and programming toolchains without requiring any interaction with the installer screens.
* **Export Pre-Packaged OVA Appliances:**  
  For non-technical office staff, distributing an exported `.ova` (Open Virtualization Appliance) template would reduce onboarding setup to a simple double-click file import, bypassing hardware sizing decisions altogether.
