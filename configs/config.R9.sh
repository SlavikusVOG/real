#!/usr/bin/env bash
set -euo pipefail

# === Change before install ===
ssh_port=50000
wifi_ssid="ssid"
wifi_password="pass"
root_password="pass"     # leave empty to set during install
user_password="pass"     # leave empty to set during install

# Hardcoded settings.
wlan_interface=wlan0
hostname=Ryzen9-5950X# unique name on your network
swap_partition=""
swapsize=20
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
