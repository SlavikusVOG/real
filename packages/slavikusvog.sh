#!/usr/bin/env bash
set -euo pipefail

packages+=(
    # === Console utils ===
    jq # json parsing
    android-file-transfer   # Android phone mount: aft-mtp-mount ~/mnt
    cronie rsync    # For backups.
    flatpak         # A temporary substitude for some AUR packages.
    freerdp         # RDP client to connect to my Windows laptop.
    gocryptfs       # Better than encfs.
    gvim            # Text editor. GVIM package contains VIM with +clipboard support.
    htop            # Tool for pretty resources analysis.
    inetutils       # Needed for 'hostname' command, for backup script to discern different devices.
    less            # Tool for limiting terminal output.
    ncdu            # NCurses version of du, to see how much space is taken.
    net-tools       # For ifconfig for script that shows status of downloads/uploads.
    openssh         # Used to connect to SSH servers & generate ssh-keygen.
    ranger          # VI-like file manager.
    sbctl           # For signing EFIs for SecureBoot.
    tmux            # Terminal multiplexer.
    wireguard-tools # For connecting home PC to DO docker Swarm.
    wlsunset        # Control backlight color (warmer at night)
    zsh             # Alternative shell.

    # === Coding & Office ===
    code # VS Code.
    docker docker-compose # For homelab, buildx is needed for Rider debugging.
    dotnet-sdk-8.0 dotnet-sdk aspnet-runtime-8.0 aspnet-runtime aspnet-targeting-pack # .NET development
    firefox # I'm using it in kiosk mode for NitroType typing.
    git # For development.
    # gnome-keyring # Password manager.
    # github-cli # GitHub CLI.
    # libsecret # Password manager.
    libreoffice-fresh # Office packages.
    npm # NodeJS & NPM.
    okular qt6-multimedia-ffmpeg # KDE PFD reader (consider changing to something vi-like), requires qt6-multimedia backend.
    xournalpp # Handwritten brainstorming journal. (TODO: alternatively try Lorien: aur lorien-bin package)
    rclone # Remote file sync.

    # === Multimedia ===
    discord             # Official Discord client.
    imv                 # Image viewer.
    # jellyfin-mpv-shim   # For integrating mpv with jellyfin.
    mpv                 # Video player.
    # ncspot              # Console Spotify client.
    pavucontrol         # GUI volume control.
    steam               # Steam. Might rely on GPU drivers being installed first. Need to test.
    telegram-desktop    # Telegram messenger.
    # === Unused anymore ===
    # github-cli - needed for auth credential manager to be able to authenticate (without ssh).
    # gnome-keyring - saves passwords for GTK apps: git, github-cli, google-chrome.
    # virtualbox virtualbox-host-modules-arch virtualbox-guest-iso - for work, don't use it now.

    # === Sway desktop ===
    # polkit                  # privilege prompts for GUI apps (pavucontrol, flatpak, etc.)
    # libappindicator-gtk3    # tray icons (Discord, Telegram, etc.)
    # xdg-utils               # “open URL/file with default app” behavior

    # === AMD desktop / gaming ===
    # vulkan-tools    # vulkaninfo — quick GPU sanity check
    # nvtop           # GPU/CPU monitor in TUI (supports AMD)
    # gamemode        # Steam performance helper

    # === Useful additional tools ===
    # lsof            # “what’s using this port/file?”
    # bind-tools      # dig/nslookup for DNS debugging
    # restic          # pairs well with rclone for backups
    # syncthing       # if you want P2P sync between devices
)

services+=(
    docker  # All my projects & homelab.
    cronie  # CRON jobs (regular backups).
    sshd    # SSH server.
)

flatpak+=(
    us.zoom.Zoom
    com.github.IsmaelMartinez.teams_for_linux
    com.slack.Slack
    net.ankiweb.Anki
    # app.zen_browser.zen
    # com.jetbrains.Rider
)

aur+=(
    uhk-agent-appimage  # UHK agent.
)
