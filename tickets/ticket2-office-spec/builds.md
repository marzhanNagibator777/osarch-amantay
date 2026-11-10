# Hardware Builds and Justifications
 
## 1. Accountant
- **Load:** Secure financial software (1C), heavy Excel spreadsheets with macros, corporate email, and web-banking portals.
- **Bottleneck:** CPU single-core performance and reliable storage for database backups. Excel macros and 1C queries rely heavily on CPU processing speed.
- **Trade-off:** Chose a balanced 6-core processor (Intel Core i5) with 16 GB RAM and a fast 1 TB NVMe SSD. Skipped a dedicated GPU since onboard graphics are sufficient for accounting software, redirecting funds into higher reliability storage and a licensed Windows OS.
- **Minimum Requirements Check:** 16 GB RAM, 1 TB SSD, licensed OS, and monitor included.
 
## 2. Sales Manager
- **Load:** CRM system in a browser, 30–40 active tabs simultaneously, Excel, and up to four hours of daily video calls (Zoom/Teams)[cite: 15].
- **Bottleneck:** Memory (RAM), not CPU. Modern browsers running dozens of tabs alongside video conferencing consume 11–12 GB of RAM; on 8 GB the system would freeze and swap memory during client calls[cite: 15].
- **Trade-off:** Opted for a mid-range CPU (AMD Ryzen 5) and redirected the saved budget to install **32 GB of RAM** instead of the baseline 16 GB, ensuring smooth multitasking without lag[cite: 15].
- **Minimum Requirements Check:** 32 GB RAM (exceeds 16 GB minimum), 1 TB SSD, licensed OS, and monitor included.
 
## 3. Web Developer
- **Load:** Heavy IDEs (VS Code, WebStorm), local Docker containers, testing local servers, and compiling code.
- **Bottleneck:** CPU multi-core count and memory capacity for running containerized microservices.
- **Trade-off:** Invested heavily in a multi-core CPU and 32 GB of RAM. Saved slightly on monitor refresh rates (using standard 60Hz IPS) to stay within the total budget while keeping heavy development workloads fluid.
- **Minimum Requirements Check:** 32 GB RAM, 1 TB NVMe SSD, licensed OS, and monitor included.
 
## 4. Designer
- **Load:** Graphic design software (Adobe Photoshop, Illustrator, Figma) and photo/video asset rendering.
- **Bottleneck:** GPU acceleration and high-accuracy color display (monitor) alongside RAM for large project files.
- **Trade-off:** Allocated a larger portion of the budget to a color-accurate IPS monitor and a dedicated mid-range GPU, while keeping a reliable 6-core CPU that handles standard rendering tasks efficiently.
- **Minimum Requirements Check:** 16 GB RAM, 1 TB SSD, dedicated GPU, licensed OS, and color-calibrated monitor included.
