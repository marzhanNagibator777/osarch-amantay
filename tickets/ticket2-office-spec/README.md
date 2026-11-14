# Ticket 2 — “We are kitting out the new office”

* **Student:** Marzhan Amantay
* **Folder:** `tickets/ticket2-office-spec/`
* **Price Date:** November 14, 2026

---

## 1. What was asked

> From: Daniyar K. (Director)  
> Subject: computers for the new office  
>  
> We are opening the second office and need four computers — accountant,  
> sales, web developer, designer. Budget 3,000,000 tenge for everything.  
> Everyone says we should just buy the same four machines, is that right?  
> Make sure they last a few years. Monitors included.

---

## 2. What was actually needed

**The director’s idea to buy four identical machines is wrong.** Four identical 750,000 KZT computers would waste money on parts the accountant and sales manager do not need, while still being too weak (no dedicated video card, wrong monitor) for the designer.

1. **What the request left out:**
   * Exact programs each person uses (1C vs. 40 Chrome tabs vs. Docker vs. Adobe video/graphics).
   * Operating system licenses (commercial offices need licensed Windows 11 Pro).
   * Room for future upgrades so the computers last 3–4 years.
   * Extra budget for keyboards, mice, and price changes.

2. **What I would have asked the director:**
   * Does the designer only make 2D banners/UI in Figma, or also edit heavy video and 3D?
   * Does the company already own Windows licenses, or must we buy them with the PCs?
   * Should the 3,000,000 KZT budget also cover keyboards, mice, and delivery?

3. **What I assumed instead of an answer:**
   * Every PC gets at least 16 GB RAM, a 1 TB NVMe SSD, licensed Windows 11 Pro, and a monitor[cite: 61].
   * All prices were taken on **2026-11-14** from Kazakhstani stores (`technodom.kz` and `shop.kz`) that deliver to Almaty[cite: 61].
   * Spending **2,479,690 KZT** leaves **520,310 KZT** in reserve for peripherals and sudden KZT price increases.

---

## 3. What I did

1. Listed the daily programs and main hardware bottleneck for each of the four roles.
2. Created four different builds in `builds.md` within the 3,000,000 KZT budget, making sure every PC without a separate video card has a CPU with built-in graphics (`i3-14100`, `i5-13400`, `Ryzen 7 7700`).
3. Checked real prices in KZT on `technodom.kz` and `shop.kz` on `2026-11-14` and recorded them in `budget.csv`.
4. Chose motherboards with 4 RAM slots so memory can be easily added later.

### Answers to the three questions

1. **Which of the four machines will you upgrade first, eighteen months from now, and why?**  
   The **web developer’s PC** will be upgraded first by adding another 32 GB of RAM (to make 64 GB) and a second 2 TB SSD. Over 18 months, local Docker containers, test databases, and development tools grow heavier, and the chosen motherboard has empty slots ready for this upgrade.

2. **Price the same four as pre-built machines from a vendor. What does the company gain and what does it lose by not building them?**  
   Buying four comparable pre-built PCs with monitors and Windows Pro from Technodom/Shop.kz costs around **3,030,000 KZT** (about 22% more, slightly over budget).  
   * **What the company gains by buying pre-built:** One single store warranty on the whole PC, no time spent assembling parts, and ready to plug in immediately.  
   * **What the company loses by buying pre-built:** Over 500,000 KZT in extra markup, cheaper power supplies/cooling inside the case, and fewer free slots to upgrade later.

3. **One of these four people will complain about performance within a month. Which one, and about what?**  
   The **designer** is the most likely to complain within a month — specifically about **running out of video memory (8 GB VRAM on the RTX 4060 Ti)** or disk space when editing large 4K video/After Effects projects on a single 1 TB SSD. This was our conscious trade-off to keep all four machines inside the 3,000,000 KZT budget.

---

## 4. Evidence

* [builds.md](builds.md) — Explains the workload, bottleneck, and budget trade-off for each of the four roles[cite: 61].
* [budget.csv](budget.csv) — Full table of components, models, prices in KZT, stores, and the date (`2026-11-14`)[cite: 61].
* [evidence/pcpartpicker-links.md](evidence/pcpartpicker-links.md) — Store links and basic compatibility checks for the chosen parts[cite: 61].
* [evidence/vendor-quotes/technodom-shopkz-quotes.md](evidence/vendor-quotes/technodom-shopkz-quotes.md) — Summary of total build costs vs. pre-built store prices[cite: 61].

---

## 5. What I would do differently

* **Use only two motherboard models instead of four:** Buying the same motherboard model for Accountant/Sales and another single model for Developer/Designer would make BIOS updates and driver maintenance much easier for IT support.
* **Include surge protectors / UPS units in the budget:** Using ~120,000 KZT from the leftover buffer to buy battery backups (UPS) would protect the accountant's and designer's unsaved work during power drops.
