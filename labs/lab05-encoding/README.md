# Lab 5 — Encoding forensics

## Diagnosis (before the fix)
* **file says:** `text/plain; charset=iso-8859-1` (from `evidence/file-before.txt`)
* **First 16 bytes:** (from `evidence/hexdump-before.txt`)

| Offset | Bytes | What they are |
| :--- | :--- | :--- |
| `00000000` | `d0 a2 d0 b0 d0 b1 2e e2` | Header text (`Таб.`) misinterpreted due to legacy 8-bit encoding |
| `00000008` | `84 96 3b d0 a4 d0 98 d0` | Symbol `№`, delimiter `;`, and Cyrillic header (`ФИ...`) |

* **Encoding:** `PT154` (Paratype Cyrillic/Asian 8-bit encoding) — **evidence:** Hexdump byte offsets and character mapping revealed PT154 encoding instead of UTF-8.
* **Line ending:** `CRLF` (`\r\n`) — **evidence:** Presence of carriage return (`0d 0a`) characters at the end of lines, typical for Windows-generated CSV files.
* **BOM:** `absent` — **evidence:** No Byte Order Mark (`ef bb bf` or `ff fe`) was found at offset `00000000` in `evidence/hexdump-before.txt`.

## What each application was doing wrong
* **Excel:** Assumed the default Windows system codepage (ANSI / Windows-1251) because the CSV file lacked a UTF-8 BOM, which caused PT154 Cyrillic characters to render as mojibake.
* **LibreOffice:** Failed to auto-detect the rare PT154 encoding and defaulted to UTF-8 or the system locale, resulting in corrupted Russian and Kazakh names.
* **cat:** Printed raw bytes directly to the Ubuntu terminal (which expects UTF-8) without character set conversion, displaying broken characters.

## Fix
* **Command / script:** `scripts/fix.sh`
* **Changed:** encoding `PT154` -> `UTF-8`; line ending `changed to` `LF` (`\n`); BOM `removed` (kept absent) because Linux/Ubuntu tools and modern CSV parsers handle UTF-8 without BOM natively, and `evidence/.gitattributes` (`*.csv -text`) was added to prevent Git from altering line endings.

## Verification
* **file after:** `evidence/staff-fixed.csv: Unicode text, UTF-8 text` (from `evidence/file-after.txt`)
* **Opened in:** Microsoft Excel, LibreOffice Calc, and `cat` on Ubuntu Server — `evidence/opens-correctly.png`
