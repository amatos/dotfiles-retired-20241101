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

# Retrieve my PGP key
gpg --receive-key 5FC8FE1141FA769594E91E48F41BDBF6171A3BB4
chezmoi init http://github.com/amatos/dotfiles
chezmoi apply
