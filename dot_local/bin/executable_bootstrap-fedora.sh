#!/bin/env bash

### Add  Packages
# Add Starship
yes | sudo dnf copr enable atim/starship 2>&1
sudo dnf install -y starship

# Add CoolerControl
sudo dnf install dnf-plugins-core
yes | sudo dnf copr enable codifryed/CoolerControl
sudo dnf install -y coolercontrol
sudo systemctl enable --now coolercontrold

# Add Obsidian
flatpak install -y --noninteractive --system md.obsidian.Obsidian
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

### Start systemd entries
sudo systemctl enable cockpit.socket
sudo systemctl enable --now syncthing@alberth
