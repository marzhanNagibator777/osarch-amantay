# Feedback on Marzhan Amantay's BUILD.md
Reviewer: Tolganay Nursapa
Commit reviewed: https://github.com/marzhanNagibator777/osarch-amantay/blob/67114049c188f7e1635ff4f604f1b3d71e747c5a/tickets/ticket1-vm-build-doc/BUILD.md
Hypervisor I used: VMware Workstation Pro, version 26H1 (or 17.x)

## First step where I got stuck
Step number: None
What the step says: N/A
What I did: I followed the document sequentially from Step 1 to Step 8.
What happened / what I had to guess: I did not get completely blocked at any point because each step explicitly defined what to click and verified the resulting state with a check command.

## Other places I hesitated
- Step 4 (Hardware Allocation): I hesitated on whether to allocate 1 or 2 vCPUs since my laptop has a 4-thread processor. The guide explained that 2 cores are optimal for background tasks, but a brief note warning dual-core laptop users to keep 1 vCPU would remove any momentary doubt.
- Step 6 (Base OS Installation): During the installer partitioning screen, I paused to consider whether manual LVM configuration was required, but the guide's note on automatic defaults clarified the intended setup.

## Settings I would not have chosen without the document
- Selecting "I will install the operating system later" in Step 2: Normally I would attach the ISO on the first screen, but the explanation about VMware Easy Install bypassing OpenSSH and custom user setup convinced me to defer it.
- Unchecking "Allocate all disk space now" in Step 3: By default I usually preallocate storage, but the memory and disk budgeting explanation regarding host SSD exhaustion convinced me to keep thin provisioning active.
- Selecting NAT instead of Bridged in Step 5: I usually use Bridged at home, but the warning regarding Innotech campus Wi-Fi MAC address filtering explained why NAT was mandatory.

## One thing that worked well
- The explicit snapshot creation step (`clean-install`) with an immediate verification checkpoint in Step 8 ensures that the testing environment can be restored in seconds without redoing the entire installation.
