# obviux

### Quick, light Openbox &amp; NeoVim -desktop for Debian Stretch (testing)

### I.Install base debian system from a netinstall -image (no desktop)
### II. Install git, and download copy of obviux.
- As root:
```shell
apt install git
git clone git@github.com:csmr/obviux.git
cd obviux
```
(- Alternatively, download `obviux.sh` and `configs.tgz` to target computer with wget, or use usb-transfer. More typing, validate obviux with `md5sum obviux.sh`)

### III. Enable and run obviux
```shell
chmod +x obviux.sh
./obviux.sh
```

The base desktop should install in 20 minutes. The main menu works by right-click on desktop, terminal popup with >F2>.
