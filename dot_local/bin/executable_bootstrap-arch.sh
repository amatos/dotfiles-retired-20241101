#!/bin/env bash

# Install required bootstrap packages
sudo pacman -Suy --needed --noconfirm go git base-devel fish

# Get yay from aur
git clone https://aur.archlinux.org/yay.git
pushd yay
makepkg
sudo pacman -U --needed --noconfirm yay*.pkg.tar.zst

# Install chezmoi
yay -Suy --needed --noconfirm chezmoi

if [ ! -e /etc/systemd/resolved.conf.d ]; then
    sudo mkdir /etc/systemd/resolved.conf.d
fi

# https://gitlab.freedesktop.org/drm/amd/-/issues/2967
echo "Creating power-pdm.service"
cat > "$HOME/power-dpm.service" << 'EOF'
[Unit]
Description=set the parameters power_dpm_force_performance_level

[Service]
Type=oneshot
ExecStart=/bin/bash -c 'echo high > /sys/class/drm/card*/device/power_dpm_force_performance_level'

[Install]
WantedBy=multi-user.target
EOF
sudo mv "$HOME/power-dpm.service" /usr/lib/systemd/system/power-dpm.service
systemctl daemon-reload
systemctl enable --now power-dpm.service

# Retrieve my PGP key
gpg --receive-key 5FC8FE1141FA769594E91E48F41BDBF6171A3BB4
chezmoi init http://github.com/amatos/dotfiles
chezmoi apply
