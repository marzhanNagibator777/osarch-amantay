# Lab 4 — Partition, mirror, fail, recover

**Pair:** Marzhan Amantay  
**Machine:** Guest Ubuntu Server  
**Date:** November 8, 2026  

## What I did

### 1. Linux RAID 1 Setup
- Inspected initial storage layout with `lsblk`.
- Partitioned two 2GB disks (`sdb` and `sdc`) using `parted` with GPT and RAID flag.
- Created the mirror array `/dev/md0` using `mdadm --create`.
- Formatted the array with `mkfs.ext4`, mounted at `/mnt/mirror`, and generated test files (`proof.txt` and `random.bin`).
- Evidence: `./evidence/lsblk-before.txt`, `./evidence/array-healthy.txt`, `./evidence/checksum-before.txt`

### 2. Failure and Recovery
- Failed and removed `/dev/sdc1` from the array to simulate a disk crash.
- Unmounted and remounted the filesystem to flush caches, then verified data integrity using SHA-256 checksums (`MATCH`).
- Evidence: `./evidence/array-degraded.txt`, `./evidence/mdadm-detail.txt`, `./evidence/checksum-after-failure.txt`
- Added a third disk (`sdd1`) as a replacement, watched the automatic rebuild complete, and verified the final state.
- Evidence: `./evidence/array-rebuilt.txt`

---

## Result: Linux Device Roles

| Role | Device |
| :--- | :--- |
| Mirror half A | `sdb1` |
| Failed half | `sdc1` |
| Replacement (Spare) | `sdd1` |

---

## The Question
> *Your colleague deleted the wrong file from the mirror an hour ago. Does RAID 1 help? Why?*

No, RAID 1 does not help in this scenario. Mirroring instantly replicates all write operations—including accidental file deletions or corruptions—to both disks simultaneously. To recover from a human error like accidental deletion, the company must rely on regular file-level backups stored independently, not on hardware or RAID redundancy.

---

## What did not work the first time
During the setup, I encountered a host storage space limitation because the virtual machine files were tied to OneDrive, which caused a disk-full warning in VMware. I resolved this by freeing up host disk space before proceeding with the partition and RAID commands.

---

## Evidence
- [`./evidence/array-healthy.txt`](./evidence/array-healthy.txt) — Healthy state of the RAID 1 array (`[UU]`).
- [`./evidence/array-degraded.txt`](./evidence/array-degraded.txt) — Short degraded state overview via `/proc/mdstat`.
- [`./evidence/mdadm-detail.txt`](./evidence/mdadm-detail.txt) — Detailed array inspection and component states via `mdadm --detail`.
- [`./evidence/array-rebuilt.txt`](./evidence/array-rebuilt.txt) — Final rebuilt state of the array after adding the replacement disk.
- [`./evidence/checksum-before.txt`](./evidence/checksum-before.txt) — SHA-256 hashes of test files before failure.
- [`./evidence/checksum-after-failure.txt`](./evidence/checksum-after-failure.txt) — SHA-256 hashes verifying data survival after unmounting.
- [`./evidence/lsblk-before.txt`](./evidence/lsblk-before.txt) — Initial Linux block devices layout.
