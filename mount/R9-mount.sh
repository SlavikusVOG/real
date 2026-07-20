#!/usr/bin/env bash
set -euo pipefail

# --- PARTUUIDs (GPT-level, never change unless you repartition) ---
PART_ROOT="1d36e5eb-0f25-463a-aff5-1442eb19fceb"
PART_DATA="bfd71422-9111-4d79-a56b-95c06a1f6808"
PART_EFI="3b4ea15a-5538-4cb1-9a7c-a32b57c3340a"

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
