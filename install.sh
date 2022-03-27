#!/bin/bash
# Upgrade Debian to latest release and install unattended-upgrades
# Author: Yevgeniy Goncharov aka xck, http://sys-adm.in

# Upgrade Debian / to next release
apt-get update; apt-get -y upgrade; apt-get -y dist-upgrade; apt -y --purge autoremove
# apt -y full-upgrade

# Install unattended
apt-get -y install unattended-upgrades

# Enable all updates (default enable only security updates)
sed -i "/origin=Debian,codename=\${distro_codename}-updates/s/\/\///g" /etc/apt/apt.conf.d/50unattended-upgrades
sed -i "/origin=Debian,codename=\${distro_codename}-proposed-updates/s/\/\///g" /etc/apt/apt.conf.d/50unattended-upgrades

# Enable autoremove
sed -i "/^\/\/\Unattended-Upgrade::Remove-Unused-Dependencies/s/\/\///g" /etc/apt/apt.conf.d/50unattended-upgrades
sed -i "/^^Unattended-Upgrade::Remove-Unused-Dependencies \"false\";/s/^Unattended-Upgrade::Remove-Unused-Dependencies \"true\";//g" /etc/apt/apt.conf.d/50unattended-upgrades

# Enable automatic updates
echo -e "APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Unattended-Upgrade "1";" > /etc/apt/apt.conf.d/20auto-upgrades

# Refresh systemd
systemctl enable unattended-upgrades.service
systemctl restart unattended-upgrades.service

# Disable Automatic Updates on Debian
# sudo dpkg-reconfigure --priority=low unattended-upgrades