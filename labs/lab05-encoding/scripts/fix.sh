#!/usr/bin/env bash
# Lab 5 - convert staff-broken.csv to UTF-8

IN="evidence/staff-broken.csv"
OUT="evidence/staff-fixed.csv"

# convert from PT154 in UTF-8 and delete Windows str \r

iconv -f PT154 -t UTF-8 "$IN" | sed 's/\r$//' > "$OUT"

echo "Done, result:"
file -e csv "$OUT"
xxd -l 16 "$OUT"

