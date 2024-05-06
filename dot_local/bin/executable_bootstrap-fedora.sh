#!/bin/env bash

### Add  Packages
# Add Starship
yes | sudo dnf copr enable atim/starship > /dev/null
sudo dnf install -y starship

# Add CoolerControl
sudo dnf install dnf-plugins-core
yes | sudo dnf copr enable codifryed/CoolerControl > /dev/null
sudo dnf install -y coolercontrol
sudo systemctl enable --now coolercontrold

# Add Obsidian
sudo dnf install fedora-flathub-remote.noarch
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
sudo flatpak install -y --noninteractive --system md.obsidian.Obsidian
# Create Obsidian directory if required
if [ ! -e "$HOME/Obsidian" ]; then
    mkdir "$HOME/Obsidian"
fi

# Add Syncthing
sudo dnf install -y syncthing.x86_64 syncthing-tools.x86_64

# Add JetBrains tools
pushd ~/Downloads || exit
curl https://download-cdn.jetbrains.com/toolbox/jetbrains-toolbox-2.3.1.31116.tar.gz -o jetbrains-toolbox.tar.gz
tar xfvz jetbrains-toolbox.tar.gz
popd || return

# Add Cockpit
sudo dnf install -y cockpit

# Add Chezmoi
sudo dnf install https://github.com/twpayne/chezmoi/releases/download/v2.48.0/chezmoi-2.48.0-x86_64.rpm

### Start systemd entries
sudo systemctl enable cockpit.socket
sudo systemctl enable --now syncthing@alberth

### Run initial package install
sudo dnf install -y $(curl https://raw.githubusercontent.com/amatos/dotfiles/main/private_dot_config/packages/fedora-base)
