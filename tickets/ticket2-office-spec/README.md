# Ticket 2 — Office hardware specification
 
## 1. What was asked
"We are opening the second office and need four computers. accountant, sales, web developer, designer. Budget 3,000,000 tenge for everything. Everyone says we should just buy the same four machines, is that right? Make sure they last a few years. Monitors included."
 
## 2. What was actually needed
The request assumes that four identical computers can cover all office roles within the 3,000,000 KZT budget. However, this approach is incorrect because the workload for an accountant, a sales manager, a web developer, and a designer varies drastically in CPU, RAM, and GPU requirements. 
 
What the request left out:
- Specific software requirements (e.g., heavy IDEs and Docker for the web developer, heavy graphic suites for the designer, CRM and multitasking for sales, and secure 1C/Excel processing for accounting).
- Peripherals quality and licensing details for the operating systems.
 
What I assumed instead of an answer:
- Each machine must include a licensed operating system, a dedicated monitor, at least 16 GB of RAM, and a 1 TB SSD as per baseline requirements.
- Prices were sourced from an active vendor in Kazakhstan (`mechta.kz`) on November 10, 2026.
 
## 3. What I did
1. Analyzed the individual workloads and bottlenecks for all four office roles.
2. Designed customized hardware specifications for each role (`builds.md`) while strictly adhering to the 3,000,000 KZT total budget.
3. Compiled component pricing, sources, and dates into `budget.csv`.
4. Verified that all selected components are available from a vendor delivering to Kazakhstan.
 
## 4. Evidence
- [builds.md](builds.md) — Detailed configurations, loads, bottlenecks, and trade-offs for each role.
- [budget.csv](budget.csv) — Complete budget breakdown with components, models, KZT prices, sources, and dates.
- [pcpartpicker-links.md](evidence/pcpartpicker-links.md) — Links and references to vendor pricing and specifications.
 
## 5. Answers to Additional Questions
1. **Which of the four machines will you upgrade first, eighteen months from now, and why?**
   The web developer's machine will be upgraded first because software environments, local containers (Docker), and compilation tools rapidly increase in resource consumption over time, making CPU and RAM bottlenecks apparent much faster than in standard office roles.
2. **Price the same four as pre-built machines from a vendor. What does the company gain and what does it lose by not building them?**
   Pre-built branded systems cost roughly 15-20% more for equivalent performance. By building them ourselves, the company gains optimized hardware tailored to specific workloads within budget. However, it loses centralized single-vendor hardware warranty support, requiring troubleshooting component by component.
3. **One of these four people will complain about performance within a month. Which one, and about what?**
   The sales manager will complain within a month about browser freezes and lag during peak hours due to memory exhaustion caused by running 40+ browser tabs, a CRM system, and multiple simultaneous video calls.
 
## 6. What I would do differently
Next time, I would check local stock availability for power supplies with built-in surge protection more thoroughly, as component stock in local retail stores fluctuates rapidly and can shift the final budget unexpectedly.
