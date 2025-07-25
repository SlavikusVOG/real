#!/usr/bin/env bash
set -euo pipefail

# This is the main configuration file that you will edit.
# Also check out two more files: custom.sh and finish-install.sh, you might want to edit them as well.
# (NOTE TO SELF): update custom.sh before install

# This script assumes the following:
# 1. You have Intel CPU
# 2. You have Nvidia GPU
# 3. You have WIFI
# 4. You have Bluetooth
# 5. Your drive is in UEFI mode / GPT partitioning scheme
# 6. Uses RAM for Swap (assuming you have lots of spare RAM)
#
# If any of these are not true - you might need to tweak the script itself for your machine, not just this file.

hostinstall=0
username=slavikusvog
hostname=dell-e5550
timezone=Europe/Minsk
root_password="qwerty" # Leave empty to specify during install.
user_password="qwerty" # Leave empty to specify during install.
windows_efi_volume="" # Only necessary for multiboot, so that GRUB is able to generate proper config.
wlan_interface=wlan0
shell=/bin/zsh
keymap=us # Set to 'us' to have a regular keymap.
swapsize=0 # Swap size in Gigabytes, will be allocated on RAM.
service=(
    docker
    bluetooth
    cronie
    systemd-networkd
)

user_packages=(
    gvim            # Text editor. GVIM package contains VIM with +clipboard support.
    less            # Tool for limiting terminal output.
    htop            # Tool for pretty resources analysis.
    #steam          # Steam gaming client.
    code            # VS Code.
    discord         # Official Discord client.
    encfs           # Encryption filesystem client for protecting folders.

    # KDE PDF reader with many features (consider changing to vi-like one, KDE brings a lot of dependencies).
    # qt6-multimedia-ffmpeg or qt6-multimedia-gstreamer is a dependency of okular, preselect ffmpeg.
    okular qt6-multimedia-ffmpeg

    wireguard-tools     # For connecting home PC to DO docker Swarm.
    freerdp             # RDP client to connect to my Windows laptop.
    ncspot              # Console Spotify client.
    npm                 # NodeJS & NPM.
    libreoffice-fresh   # Office packages.
    ranger              # VI-like file manager.
    mpv                 # Video player.
    imv                 # Image viewer.
    openssh             # Used to connect to SSH servers & generate ssh-keygen.
    telegram-desktop    # Telegram messenger.
    thefuck             # Automatic wrong command fixing.
    tmux                # Terminal multiplexer.
    xournalpp           # Handwritten brainstorming journal. (TODO: alternatively try Lorien: aur lorien-bin package)
    ncdu                # NCurses version of du, to see how much space is taken.

    # Git for development: duplicated here in case we decide we don't need YAY.
    # github-cli is needed for auth credential manager to be able to authenticate (without ssh).
    git github-cli

    # Android phone mounting.
    android-file-transfer   # Usage: aft-mtp-mount ~/mnt

    # .NET development.
    dotnet-sdk-8.0 dotnet-sdk aspnet-runtime-8.0 aspnet-runtime
)

yay_user_packages=(
    zoom                # Messaging for work.
    teams-for-linux-bin # Teams (instead of Skype).
    anki-bin            # Anki cards app.
    rider               # .NET development.
)
