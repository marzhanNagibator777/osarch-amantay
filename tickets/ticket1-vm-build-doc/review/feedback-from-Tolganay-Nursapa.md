# Peer Review on Ticket 1 (VM Build Document)

* **Reviewer:** Tolganay Nursapa
* **Author of BUILD.md:** Marzhan Amantay
* **Host Platform tested on:** asus B340
* **Date:** 02.11.2026

---

## 1. Literal Execution Log

I followed `BUILD.md` strictly step-by-step, executing only the written instructions:

* **Step 1 (Wizard Mode):** Selected Typical mode as directed. Clear and straightforward.
* **Step 2 (OS & ISO Attachment):** Selected Linux / Ubuntu 64-bit and deferred ISO install. No issues.
* **Step 3 (Disk Sizing):** Configured 20 GB thin provisioned disk (split into multiple files). Verified non-preallocated status.
* **Step 4 (Hardware Allocation):** Allocated 2 GB RAM, 2 vCPUs, and attached ISO path cleanly.
* **Step 5 (Networking):** Selected NAT mode.
* **Step 6 (Installation & OpenSSH):** OS installation succeeded. Network received DHCP lease via NAT (`192.168.x.x`). OpenSSH was installed and verified active.
* **Step 7 (Verification):** Executed `uname -a` and ping tests. ICMP ping passed without packet loss.
* **Step 8 (Snapshot):** Successfully created baseline snapshot `clean-install`.

---

## 2. Issues / First Point of Friction

* **First point stuck:** Did not get stuck. The instructions were fully reproducible from a clean hypervisor state.
* **Minor observation / recommendation:** In Step 4, when allocating 2 cores, make sure to note that users on older 2-core / 2-thread laptops might want to leave 1 vCPU to avoid host UI stuttering.

---

## 3. Conclusion

The build manual works out of the box on an independent hardware environment. Environment reproduced successfully without deviations.
