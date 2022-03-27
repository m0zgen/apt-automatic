# Unattended-upgrades installer

This script performs several steps:
* Upgrade server
* Install `unattended-upgrades`
* Enable all updates (updates, security)
* Enable `autoremove`

# Usage

Clone repo:
```bash
git clone https://github.com/m0zgen/apt-automatic.git
```

`cd` to `apt-automatic` catalog and run installer:

```bash
sudo ./install.sh
```

