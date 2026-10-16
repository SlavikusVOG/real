#!/usr/bin/env bash
set -euo pipefail

# --- PARTUUIDs (GPT-level, never change unless you repartition) ---
PART_ROOT="1a89caf6-3342-4b36-9bf0-f90a470ccb5d"
PART_DATA="fa7feee3-556c-4be0-ad6b-0ba151ddc1e2"
PART_EFI="e676f5cf-4f60-44ae-af69-b83e28aca42a"

# --- Mapper names ---
MAP_ROOT="root"
MAP_DATA="data"

TARGET="/mnt"

resolve() {
    blkid -t PARTUUID="$1" -o device 2>/dev/null || {
        echo "FATAL: PARTUUID $1 not found" >&2; exit 1
    }
}

echo "=== Resolving partitions ==="
DEV_ROOT="$(resolve "$PART_ROOT")"
DEV_DATA="$(resolve "$PART_DATA")"
DEV_EFI="$(resolve "$PART_EFI")"

printf "  %-10s %s\n" "root:" "$DEV_ROOT" "data:" "$DEV_DATA" "efi:" "$DEV_EFI"

echo ""
echo "=== Opening LUKS ==="
for pair in "$DEV_ROOT:$MAP_ROOT" "$DEV_DATA:$MAP_DATA"; do
    dev="${pair%%:*}"
    name="${pair##*:}"
    if [ -e "/dev/mapper/$name" ]; then
        echo "  $name already open, skipping"
    else
        echo "  Opening $dev as $name..."
        cryptsetup luksOpen "$dev" "$name"
    fi
done

echo ""
echo "=== Mounting ==="
read -p "Format /dev/mapper/${MAP_ROOT} now on another TTY before proceeding"
mount /dev/mapper/$MAP_ROOT "$TARGET"
mkdir -p "$TARGET/mnt/data" "$TARGET/efi"
mount /dev/mapper/$MAP_DATA   "$TARGET/mnt/data"
mount -o umask=0077,uid=0,gid=0 "$DEV_EFI" "$TARGET/efi"

echo ""
echo "=== Result ==="
findmnt --target "$TARGET" --submounts --output TARGET,SOURCE,FSTYPE,OPTIONS
