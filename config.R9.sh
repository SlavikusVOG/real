#!/usr/bin/env bash
set -euo pipefail

# === Change before install ===
uki_cmdline="rd.luks.name=YOUR-DISK-UUID=root root=/dev/mapper/root rw"  # replace YOUR-DISK-UUID (blkid)
crypt_password="pass"
git_work_email="work@email.com"
ssh_port=50000
wifi_ssid="ssid"
wifi_password="pass"
hostname=archpc          # unique name on your network
root_password="pass"     # leave empty to set during install
user_password="pass"     # leave empty to set during install
swapsize=20
swap_partition=""
swap_file=""
wlan_interface=wlan0
windows_efi_volume=""    # only if Windows EFI partition differs from Linux

# === User / locale ===
timezone=Europe/Minsk
username=slavikusvog
shell=/bin/zsh
keymap=us

# === Packages ===
install=(
    cpu-amd
    gpu-amd              # your new file — NOT gpu-nvidia / gpu-nvidia-docker
    core-system
    security
    fido
    sway
    slavikusvog
    #slavikusvog-laptop  # uncomment for a laptop (brightness keys, etc.)
)
loadpackages

personal_scripts=(
    # personal.slavikusvog.sh   # create your own, or skip for now
    mega.sh
    security.sh
)

# === Script control ===
auto=1
hostinstall=0            # 0 = from Arch live ISO
aur_install=1
yay_ask=0
install_grub=0
install_systemdboot=1
encrypted_root=1
secure_boot=1
uki=1
install_folder=/eal-temp
install_flatpak=1
autologin=1