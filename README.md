# obviux

### Quick, light Openbox &amp; NeoVim -desktop for Debian Stretch (testing)

#### Install
> Requirements: netbook or better hw, can install debian from disk-image and login
1. Install base debian system from a netinstall -image (no desktop). Reboot.
2. In a root shell, install git, clone obviux -repo, and run obviux.sh
	```shell
	apt install git
	git clone https://github.com/csmr/obviux.git
	cd obviux
	chmod +x obviux.sh
	./obviux.sh
	```

- The base desktop should install in 20 minutes. The main menu works by right-click on desktop, terminal popup with F2.

- Alternative install: transfer `obviux.sh` and `config`-dir to target computer (with wget, usb-transfer). Validate installer with with `md5sum obviux.sh`, enable +x -flag and run.

