#!/bin/env bash

# Fix flicker issue with Wayland>100fps
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
if [ ! -e /usr/lib/systemd/system/power-dpm.service ]; then
    echo "Moving service to systemd/system"
    sudo mv "$HOME/power-dpm.service" /usr/lib/systemd/system/power-dpm.service
    echo "reloading daemons"
    sudo systemctl daemon-reload
else
    echo "removing service from from $HOME"
    rm ~/power-dpm.service
fi

# Check if service is running.  If not, enable and start it.
STATUS="$(systemctl is-active power-dpm.service)"
if [ ! "${STATUS}" = "active" ]; then
    sudo systemctl enable --now power-dpm.service
fi

### Add  Packages
# Add Starship
yes | sudo dnf copr enable atim/starship 2>&1
sudo dnf install -y starship

# Add CoolerControl
sudo dnf install dnf-plugins-core
yes | sudo dnf copr enable codifryed/CoolerControl
sudo dnf install coolercontrol
sudo systemctl enable --now coolercontrold

# Add Syncthing
sudo dnf install -y syncthing.x86_64 syncthing-tools.x86_64

# Add Steam
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-'$(rpm -E %fedora)'.noarch.rpm \
                    https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-'$(rpm -E %fedora)'.noarch.rpm
sudo dnf config-manager --enable fedora-cisco-openh264 -y

# Add Obsidian
flatpak install -y --noninteractive --system md.obsidian.Obsidian
# Create Obsidian directory if required
if [ ! -e "$HOME/Obsidian" ]; then
    mkdir "$HOME/Obsidian"
fi

# Add JetBrains tools
pushd ~/Downloads || exit
curl https://download-cdn.jetbrains.com/toolbox/jetbrains-toolbox-2.3.1.31116.tar.gz -o jetbrains-toolbox.tar.gz
tar xfvz jetbrains-toolbox.tar.gz
popd || return

# Add 1password
sudo dnf install -y https://downloads.1password.com/linux/rpm/stable/x86_64/1password-latest.rpm
sudo dnf install -y 1password-cli

### Start systemd entries
sudo systemctl enable cockpit.socket

sudo systemctl enable --now power-dpm.service
sudo systemctl enable --now syncthing@alberth
