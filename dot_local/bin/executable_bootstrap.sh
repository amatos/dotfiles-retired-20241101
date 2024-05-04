#!/bin/env bash

# Add 1password
if [ ! -e /etc/yum.repos.d/1password.repo ]; then
    sudo dnf -y install https://downloads.1password.com/linux/rpm/stable/x86_64/1password-latest.rpm
fi

# Add Starship
yes | sudo dnf copr enable atim/starship 2>&1

# Add Steam
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
                    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager --enable fedora-cisco-openh264 -y

# Command line tools or background services
sudo dnf -y install syncthing syncthing-tools git wget curl fish 1password-cli starship darkman variety fortune-mod \
                    cowsay lolcat eza btop trash-cli yad tldr cockpit
sudo dnf -y install https://github.com/twpayne/chezmoi/releases/download/v2.48.0/chezmoi-2.48.0-x86_64.rpm

# GUI tools
sudo dnf -y install meld kget steam gamemode mangohud smplayer smb4k waydroid fontforge fontforge-doc
sudo dnf -y install https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher-2.2.0-travis995.0f91801.x86_64.rpm

# Development tools
sudo dnf -y install cmake meson ninja-build go nodejs rust python perl ruby gcc llvm clang gdb lldb cmake \
                    extra-cmake-modules kf6-ki18n-devel kf6-krunner-devel gettext xdotool kf6-kcmutils-devel \
                    meld nodejs-bash-language-server.noarch diff-so-fancy.noarch

# Flatpaks
flatpak install -y --noninteractive md.obsidian.Obsidian

# Create Obsidian directory if required
if [ ! -e $HOME/Obsidian ]; then
    mkdir $HOME/Obsidian
fi
# Start syncthing
sudo systemctl enable --now syncthing@alberth
