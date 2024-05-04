#!/bin/env bash

# Fix flicker issue with Wayland>100fps
# https://gitlab.freedesktop.org/drm/amd/-/issues/2967
echo "Creating power-pdm.service"
cat > $HOME/power-dpm.service << 'EOF'
[Unit]
Description=set the parameters power_dpm_force_performance_level

[Service]
Type=oneshot
ExecStart=/bin/bash -c 'echo high > /sys/class/drm/card*/device/power_dpm_force_performance_level'

[Install]
WantedBy=multi-user.target
EOF
if [ ! -e /usr/lib/systemd/system/power-dpm.service ]; then
    echo "Moving service to systemd/system"
    sudo mv $HOME/power-dpm.service /usr/lib/systemd/system/power-dpm.service
    echo "reloading daemons"
    sudo systemctl daemon-reload
else
    echo "removing service from from $HOME"
    rm ~/power-dpm.service
fi

# Check if service i s running.  If not, enable and start it.
STATUS="$(systemctl is-active power-dpm.service)"
if [ ! "${STATUS}" = "active" ]; then
    sudo systemctl enable --now power-dpm.service
fi

### Add  Packages
# 1password
if [ ! -e /etc/yum.repos.d/1password.repo ]; then
    sudo dnf -y install https://downloads.1password.com/linux/rpm/stable/x86_64/1password-latest.rpm
fi

# Gitkraken
if [ ! -e /usr/bin/gitkraken ]; then
    sudo dnf install -y https://release.gitkraken.com/linux/gitkraken-amd64.rpm
fi

# Add Starship
yes | sudo dnf copr enable atim/starship 2>&1

# Add Steam
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
                    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager --enable fedora-cisco-openh264 -y

# Command line background packages
sudo dnf -y install syncthing syncthing-tools git wget curl fish 1password-cli starship darkman variety fortune-mod \
                    cowsay lolcat eza btop trash-cli yad tldr cockpit bat liquidctl
sudo dnf -y install https://github.com/twpayne/chezmoi/releases/download/v2.48.0/chezmoi-2.48.0-x86_64.rpm

# GUI packages
sudo dnf -y install meld kget steam gamemode mangohud smplayer smb4k waydroid fontforge fontforge-doc
sudo dnf -y install https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher-2.2.0-travis995.0f91801.x86_64.rpm

# Development packages
sudo dnf -y install cmake meson ninja-build go nodejs rust python perl ruby gcc llvm clang gdb lldb cmake \
                    extra-cmake-modules kf6-ki18n-devel kf6-krunner-devel gettext xdotool kf6-kcmutils-devel \
                    meld nodejs-bash-language-server.noarch diff-so-fancy.noarch
# Java
sudo dnf -y install java-11-openjdk-devel.x86_64 \
                    java-17-openjdk-devel.x86_64 \
                    java-21-openjdk-devel.x86_64

### Flatpaks
# Add Obsidian
flatpak install -y --noninteractive --system md.obsidian.Obsidian

# Add JetBrains tools
pushd ~/Downloads
curl https://download-cdn.jetbrains.com/toolbox/jetbrains-toolbox-2.3.1.31116.tar.gz -o jetbrains-toolbox.tar.gz
tar xfvz jetbrains-toolbox.tar.gz
popd

# Create Obsidian directory if required
if [ ! -e $HOME/Obsidian ]; then
    mkdir $HOME/Obsidian
fi

### Start systemd entries
# Start syncthing
sudo systemctl enable --now syncthing@alberth
sudo systemctl enable cockpit.socket
