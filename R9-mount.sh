#!/usr/bin/env bash
set -euo pipefail

# --- PARTUUIDs (GPT-level, never change unless you repartition) ---
PART_ROOT="c4690665-a801-4478-aef0-2813a871a6ee"
PART_DATA="88150716-018f-426b-ade5-bb123e5b1f5b"
PART_EFI="726A-9CD8"

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
