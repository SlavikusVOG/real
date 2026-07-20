#!/usr/bin/env bash
set -euo pipefail

# === Change before install ===
crypt_password="pass"
git_work_email="work@email.com"
ssh_port=50000
wifi_ssid="ssid"
wifi_password="pass"
root_password="pass"     # leave empty to set during install
user_password="pass"     # leave empty to set during install

# Hardcoded settings.
wlan_interface=wlan0
hostname=archpc          # unique name on your network
swapsize=20
swap_partition=""
windows_efi_volume=""    # only if Windows EFI partition differs from Linux
timezone=Europe/Minsk
username=slavikusvog
shell=/bin/zsh
keymap=us
install=(
    audio
    core-system
    cpu-amd
    fido
    fs-tools
    gpu-amd
    security
    slavikusvog
    sway
)
loadpackages

personal_scripts=(
    personal.slavikusvog.sh
    # cloud file manager
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
