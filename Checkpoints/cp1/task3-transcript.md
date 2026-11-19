# Task 3

## Diagnostic Transcript

| # | Evidence file (command) | What I expected | What I found | What I concluded |
| :--- | :--- | :--- | :--- | :--- |
| 1 | `00-README.txt` | list of evidence files | 22 command outputs from `office-srv` | start with failed units and timers |
| 2 | `05-systemctl-failed.txt` (`systemctl --failed`) | `nightly-report.service` failed | `legacy-sync.service` and `nightly-report.service` both failed | check both to see which one causes the ticket |
| 3 | `10-systemctl-status-legacy-sync.txt` | maybe `legacy-sync` is related | says `old office, no longer used`, runs `/bin/false` | dead end, unrelated old service |
| 4 | `06-systemctl-list-timers.txt` (`systemctl list-timers`) | maybe timer is off | `nightly-report.timer` is active and runs every 2 min | timer works, problem is in the service or script |
| 5 | `07-systemctl-status-nightly-report.txt` | error from `nightly-report.service` | `status=203/EXEC`, `Failed to execute /usr/local/bin/nightly-report.sh: No such file or directory` | file missing, no permissions, or bad shebang |
| 6 | `03-df-h.txt` (`df -h`) | check if disk is full | `/` is 48% used, 5.8G free | dead end, disk has space |
| 7 | `09-journalctl-nightly-report.txt` & `15-tail-nightly-report-log.txt` | when it stopped working | worked until Nov 09 14:18, failed starting Nov 09 14:20 | something changed at 14:20 on Nov 09 |
| 8 | `22-bash-history-aigerim.txt` | what changed on Nov 09 | `aigerim` copied `~/nightly-report.sh` to `/usr/local/bin/nightly-report.sh` at 14:20 | the new script file broke it |
| 9 | `13-ls-l-usr-local-bin.txt` & `20-ls-l-bin-bash.txt` | check if script or `/bin/bash` exists and has `+x` | both exist and have `-rwxr-xr-x` | dead end, permissions and files are fine |
| 10 | `16-cat-nightly-report-sh.txt` (`cat /usr/local/bin/nightly-report.sh`) | syntax error in the script | `#!/bin/bash` and `{ date; df -h /; free -h; } >> /var/log/nightly-report.log` look normal | plain `cat` hides special characters, check line endings |
| 11 | `17-cat-A-nightly-report-sh.txt` & `18-head-1-od-c.txt` | hidden characters in the script | `cat -A` shows `#!/bin/bash^M$` and `od -c` shows `\r \n` | root cause: Windows CRLF line endings make linux look for `/bin/bash\r`|

## Root Cause

The new /usr/local/bin/nightly-report.sh copied on Nov 09 was edited on Windows and has CRLF (\r\n) line endings instead of LF (\n), shown in 17-cat-A-nightly-report-sh.txt (^M$) and 18-head-1-od-c.txt (\r \n). Because of the \r after #!/bin/bash, the kernel cannot find the interpreter and fails with status=203/EXEC (No such file or directory)

## Fix

```bash
sudo sed -i 's/\r$//' /usr/local/bin/nightly-report.sh
sudo systemctl start nightly-report.service
```

## Verification

```bash
cat -A /usr/local/bin/nightly-report.sh
systemctl status nightly-report.service
tail -n 5 /var/log/nightly-report.log
systemctl is-enabled nightly-report.timer
```

Expected output:
- `cat -A` shows `#!/bin/bash$` without `^M`
- `systemctl status` shows `status=0/SUCCESS` instead of `203/EXEC`
- `nightly-report.log` has a new line with current date, `df -h /`, and `free -h`
- `systemctl is-enabled nightly-report.timer` prints `enabled` so it still runs after reboot
