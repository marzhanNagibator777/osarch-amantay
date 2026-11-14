# Office Hardware Specifications & Architectural Justifications

**Total Hardware & Licensing Expenditure:** 2,479,690 KZT  
**Remaining Contingency Buffer:** 520,310 KZT (out of 3,000,000 KZT budget cap, reserved for peripherals, surge protection, and KZT exchange volatility).

---

### Build 1 — Accountant
* **Load:** 1C:Enterprise accounting database client, multi-sheet Excel workbooks with macros, banking portals (e-Token/NCALayer), PDF archiving, and ERP reporting.
* **Bottleneck:** Single-thread CPU responsiveness and storage durability. 1C accounting operations and Excel formula recalculations execute predominantly on 1–2 threads, while continuous ledger writes demand a reliable SSD controller.
* **Trade-off:** Selected a 4-core Intel Core i3-14100 with integrated UHD 730 graphics instead of a 6-core i5 or discrete GPU, redirecting ~40,000 KZT toward a reliable Samsung 980 NVMe SSD with high endurance (TBW) and a flicker-free Dell monitor. Multi-core rendering power sits idle in accounting; storage reliability does not.
* **Hard Requirements Verified:** 16 GB dual-channel RAM, 1 TB NVMe SSD, licensed Windows 11 Pro OEM, 24" Full HD monitor.
* **Total:** 357,930 KZT (`budget.csv`, rows 2–8)

---

### Build 2 — Sales Manager
* **Load:** Web-based CRM (AmoCRM/Bitrix24), 35–45 simultaneous Chrome tabs, WhatsApp/Telegram desktop clients, Excel price lists, and 3–4 hours of daily Zoom/Meet video conferencing.
* **Bottleneck:** Memory capacity, not raw CPU clock speed. Chromium-based browsers with 40+ active tabs alongside real-time video encoding consume 12–15 GB of RAM; on 16 GB, Windows aggressively swaps to disk during live client calls.
* **Trade-off:** Chose a mid-tier Intel Core i5-13400 (using its integrated UHD 730 GPU) rather than an i7 or dedicated graphics card, spending the saved funds on **32 GB DDR4 RAM** and a 100 Hz IPS display to reduce eye strain during long call shifts.
* **Hard Requirements Verified:** 32 GB dual-channel RAM (exceeds 16 GB minimum), 1 TB NVMe SSD, licensed Windows 11 Pro OEM, 24" IPS monitor.
* **Total:** 428,930 KZT (`budget.csv`, rows 9–15)

---

### Build 3 — Web Developer
* **Load:** JetBrains WebStorm / VS Code, WSL2 Linux subsystem, 6–10 concurrent Docker containers (PostgreSQL, Redis, Node.js/Python backends), local Webpack/Vite builds, and browser dev tools.
* **Bottleneck:** Multi-core CPU throughput, DDR5 memory bandwidth, and random 4K IOPS storage speed. Compiling bundles and running containerized databases saturates both CPU threads and disk I/O queues.
* **Trade-off:** Invested heavily in an 8-core/16-thread **AMD Ryzen 7 7700** on the modern AM5 platform with **32 GB DDR5**, a high-IOPS Kingston KC3000 PCIe 4.0 SSD, and a 27" QHD (2560×1440) monitor for side-by-side code and terminal windows. Accepted relying on the Ryzen 7 7700's built-in Radeon integrated graphics instead of buying a discrete GPU, as 2D web development does not utilize 3D shaders.
* **Hard Requirements Verified:** 32 GB DDR5 RAM, 1 TB PCIe 4.0 NVMe SSD, licensed Windows 11 Pro OEM, 27" QHD monitor.
* **Total:** 649,920 KZT (`budget.csv`, rows 16–23)

---

### Build 4 — Graphic & Motion Designer
* **Load:** Adobe Photoshop, Illustrator, Premiere Pro, After Effects, Figma, and local AI asset upscaling/generation on high-resolution canvases.
* **Bottleneck:** GPU CUDA/Tensor acceleration, VRAM/system RAM capacity for uncompressed video/PSD layers, and display color accuracy. Without hardware GPU acceleration and ample RAM, timeline scrubbing and filter rendering stall completely.
* **Trade-off:** Allocated the largest share of the budget to an **NVIDIA GeForce RTX 4060 Ti 8GB**, **64 GB DDR5 RAM**, a 14-core Intel Core i5-14600K (leveraging Intel QuickSync for H.264/HEVC decoding), and a factory-calibrated **ASUS ProArt PA278QV** monitor (100% sRGB, $\Delta E < 2$). Accepted an 8 GB VRAM card instead of a 16 GB RTX 4070 Ti and a 1 TB SSD instead of 2 TB to keep the total office expenditure safely below 3,000,000 KZT.
* **Hard Requirements Verified:** 64 GB DDR5 RAM, 1 TB PCIe 4.0 NVMe SSD, licensed Windows 11 Pro OEM, 27" QHD calibrated monitor.
* **Total:** 1,042,910 KZT (`budget.csv`, rows 24–32)
