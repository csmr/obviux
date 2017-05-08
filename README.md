# obviux

### Quick, light Openbox &amp; NeoVim -desktop for Debian Stretch (testing)

#### Install
> Requirements: a netbook or better hardware, connection to a debian repo, know how to install debian from disk-image, and type terminal commands (six).

1. Install base debian system from a netinstall -image (no desktop). User and root accounts. Reboot.
2. Login as user. Then su to be root, install git, clone obviux -repo, and run obviux.sh:

	```shell
  su
	apt install git
	git clone https://github.com/csmr/obviux.git
	cd obviux
	chmod +x obviux.sh
	./obviux.sh
	```

- The base desktop should install in ~20 minutes. The main menu works by right-click on desktop, terminal popup with Menu -key.

#### Alternative install: transfer `obviux.sh` and `config`-dir to target computer (with wget/usb-transfer). Validate installer with with `md5sum obviux.sh`, enable +x -flag and run.

#### WIP
This installer is a work in progress. It should work(TM), each version is tested on a vm, but is not done yet. Help is much appreciated.

#### What?
- Obviux is a desktop environment -setup. To save time.
- Themed & pre-configured Openbox-desktop with 4 virtual desktops, pop-up-terminals, setup (neo)vim and base services (network manager, sound-server).
- Obviux env aims to be a lightweight experience, for a netbook, as much on desktop.
- Obviux provides "mouse-only" gui-facilities. At the moment provided using gnome 2 & 3 -apps.
