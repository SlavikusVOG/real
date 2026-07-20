set -euo pipefail

dotfiles_repo="slavikusvog/dotfiles"

# Change default SSH port, disable Password auth and Root login.
sed -i "s/^#\?Port .*/Port ${ssh_port}/" /etc/ssh/sshd_config
sed -i "s/^#\?PasswordAuthentication .*/PasswordAuthentication no/" /etc/ssh/sshd_config
sed -i "s/^#\?PermitRootLogin .*/PermitRootLogin no/" /etc/ssh/sshd_config

# Add current user to docker group for sudo-less docker access.
usermod -aG docker $username

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

    # Make sure everything is owned by the user.
    chown -R $username:$username .
fi

# Install angular globally
npm i -g @angular/cli
# TODO: Add other global packages here.
