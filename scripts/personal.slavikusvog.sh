set -euo pipefail

dotfiles_repo="slavikusvog/dotfiles"

if [[ $dotfiles_repo ]]; then
    # Load dotfiles.
    cd /home/$username
    git clone https://github.com/$dotfiles_repo dotfiles
    mv dotfiles/.git .git
    git config --global --add safe.directory /home/$username
    git reset --hard
    git remote rm origin
    git remote add origin git@github:$dotfiles_repo.git
    rm -R dotfiles
    echo "*" > .gitignore

    # Update work email for git configuration.
    sed -i "s/work@email.com/$git_work_email/" .gitconfig-work
    git update-index --assume-unchanged .gitconfig-work
    mv .git .dotfiles

    # Set crypt password for backup scripts.
    echo "export CRYPT_PASSWORD=$crypt_password" > /root/.secrets
    chmod 400 /root/.secrets

    # Skip, I'm using systemd-boot now
    # Apply GRUB configuration from dotfiles.
    #cp .etc/default/grub /etc/default/grub
    #grub-mkconfig -o /boot/grub/grub.cfg || true

    # Symlink machine-specific Sway config for my current device.
    ln -fs /home/$username/.config/sway/$hostname /home/$username/.config/sway/machine

    # Symlink machine-specific jellyfin-mpv-shim config.
    ln -fs /home/$username/.config/jellyfin-mpv-shim/conf.$hostname.json /home/$username/.config/jellyfin-mpv-shim/conf.json

    # Make sure everything is owned by the user.
    chown -R $username:$username .

    # Enable backups.
    echo "0 */4 * * * /home/$username/.local/bin/backup.sh" | crontab -
fi

# Install angular globally
npm i -g @angular/cli
