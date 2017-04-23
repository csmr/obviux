#!/bin/bash

obviux_version="0.0.1"

# Obviux - netinstall to OB desktop
#
# - First install debian netinstall - no desktops, only system utilities
# 1. Login as root, download this script:
#     $ wget -nc https://raw.githubusercontent.com/csmr/obviux/master/obviux.sh
# 2. enable exection flag after check:
#     $ chmod +x obviux.sh
# 3. and run it:
#     $ ./obviux.sh

path_obviux="/usr/share/obviux"
path_log="${path_obviux}/install-log.txt"
path_autostart="/etc/xdg/openbox/autostart"
url_repository="https://github.com/csmr/obviux/blob/master"

interactive_flag="n"
bugcheck_flag="n"

desktop_pack=(

  xorg lightdm dpkg-dev sudo
  openbox obconf obmenu desktop-base compton arandr

  network-manager-gnome network-manager-openvpn-gnome
  network-manager-pptp-gnome network-manager-vpnc-gnome

  # CLI utilities
  anacron bash-completion build-essential
  avahi-utils avahi-daemon libnss-mdns gvfs-bin 
  debconf-utils menu apt-xapian-index lintian 
  usbutils cpufrequtils screen tmux

  # unzip for github, compression utilities (unrar from non-free)
  unrar unace unalz unzip lzop rzip zip xz-utils arj bzip2

  # Media stuff
  alsa-base alsa-utils volumeicon-alsa lame 
  pulseaudio pulseaudio-module-x11 pavucontrol
  xfburn thunar-archive-plugin thunar-media-tags-plugin
  vlc vlc-plugin-notify

  # GTK utilities
  gparted gdebi geeqie evince 
  gimp gimp-plugin-registry 
  geany geany-plugins gnome-keyring gtrayicon
  gnumeric galculator gigolo catfish gsimplecal

  # net stuff
  ftp rsync sshfs whois openssh-client
  wireless-tools xchat xtightvncviewer
  iceweasel net-tools nmap ufw gufw
  transmission-gtk

)

desktop_pack_norecs=(

  tint2 lxappearance
  terminator tilda
  thunar thunar-volman 
  xfce4-power-manager xfce4-notifyd libnotify-bin 
  gtk2-engines-murrine gtk2-engines-pixbuf gtk2-engines

  # filesys
  e2fsprogs xfsprogs reiserfsprogs reiser4progs 
  jfsutils ntfs-3g fuse gvfs-fuse fusesmb

  # firmware
  firmware-linux firmware-iwlwifi firmware-ralink firmware-ipw2x00 ntp
  firmware-realtek intel-microcode amd64-microcode user-setup

  # utils
  mc ranger 
  file-roller synaptic clipit
  zenity wmctrl xinput xsel xdotool python-xdg suckless-tools gmrun
  scrot xfce4-screenshooter viewnior hsetroot xscreensaver
  bc gksu fbxkb htop rpl cowsay figlet dmz-cursor-theme
  vrms

  # fonts
  fonts-dejavu fonts-droid ttf-freefont ttf-liberation

  # dev tools
  git git-svn curl vim-tiny vim-nox nvim

)

function show_help {
  echo "Obviux - ob-desktop  $obviux_version
  run this script as root with:
  # ./obviux.sh [--option [--..]]

  Options:
  --ignore - Do NOT stop on any errors found
  --nobugcheck - Do NOT install listbugs to check for known issues
  --interactive - Stop and wait for user after each install piece"
  exit 1
}

# exit on any error
set -e 

# enter install path
mkdir -p "${path_obviux}" && cd "$_" 

# log everything
exec > >(tee $path_log) 2>&1  

# installs packges given in arg-array
function apt_get_runner {
# if any arguments were given, add them to apt-get call
apt_args=(-q -y)
log "Installing $*" 
apt-get "${apt_args[@]}" install "$@" 
log "Finished Installing $*\n"

if [ "$interactive_flag" == "y" ]; then
  read -p "Press [Enter] key to continue...";
fi
}

function log {
echo -e "$@"
}

# Handle command line arguments
while [ "$#" -gt 0 ]; do
  case $1 in
    -h|--help)
      show_help
      ;;
    --ignore)
      echo "*** Obviux -- Ignoring Errors"
      set +e # ignore errors
      ;;
    --bugcheck)
      echo "*** Obviux -- enable Bug Checking"
      bugcheck_flag="y"
      ;;
    --interactive)
      echo "-- Interactive Mode"
      interactive_flag="y"
      ;;
    *)
      # ignore unknown option
      ;;
  esac
  shift
done

# Make sure we have elevated privilages, or exit
if [ "$(whoami)" != "root" ]; then
  echo "Please start as superuser: run '\$ su' (asks root password) and try again. "
  exit 1
fi

echo "" > $path_log
log "*** Obviux starts! Installing base!"

log "*** Part I"
apt-get update
apt-get upgrade
apt_get_runner policykit-1

if [ "$bugcheck_flag" == "y" ]; then
  echo "***** ALIAS SETUP *****"
  echo alias hld='echo "alias hld = sudo apt-mark hold app_name" ; sudo apt-mark hold' >> ~/.bashrc 
  echo alias unhld='echo "alias unhld = sudo apt-mark unhold app_name" ; sudo apt-mark unhold' >> ~/.bashrc 
  apt_get_runner apt-listbugs
fi

# Enable non-free repo - for unrar and flashplayer
log "***** ENABLING NON-FREE REPO *****"
echo "deb http://http.debian.net/debian testing contrib non-free" > /etc/apt/sources.list.d/stretch.contrib.nonfree.list 
apt-get update
apt_get_runner "${desktop_pack[@]}"
cd 
apt_get_params+=('--no-install-recommends')
apt_get_runner "${desktop_pack_norecs[@]}"
apt_get_params=()


# temp test for installs
command -v curl || { echo >&2 "part I install curl fail"; exit 1; }
command -v nmap || { echo >&2 "part I install nmap fail"; exit 1; }
command -v ex || { echo >&2 "part I install ex (vim) fail"; exit 1; }

# Part I - end



log "*** Part II - Config"

# Get Openbox config-presets from GitHub -repo
wget -nc "${url_repository}/configs.tgz"
tar -xzv configs.tgz
cp -r ./config ~/.config

# add autostart conf for obviux
cat "${path_obviux}/config/openbox/autostart.xdg" > "$path_autostart"

# gksu run in sudo mode - gnomey
update-alternatives --set libgksu-gconf-defaults /usr/share/libgksu/debian/gconf-defaults.libgksu-sudo 
update-gconf-defaults 

# Part II - end



log "*** Part III - Theme - wip"
wget -nc https://github.com/shimmerproject/Greybird/archive/master.zip 
unzip -q master.zip 
# cd Greybird-master
# no build script cp -r Greybird-git /usr/share/themes 

# Display Manager
# todo# mv lightdm.conf lightdm.conf-orig 
# cd

# Part III - end



log "*** Part IV"

# add initial user to sudoer group
user_nick=$(getent passwd 1000 | awk -F: '{print $1}')
if [ "$user_nick" ]; then
  adduser "$user_nick" sudo 
fi

# add users to sudoers, so all users can sudo
echo "%sudo ALL = (ALL:ALL) ALL" > sud.tmp 
chmod 0440 sud.tmp
mv sud.tmp /etc/sudoers.d/all.users 

#games not in roots PATH
/usr/games/cowsay -W20 -e "^^" "Sudoing is now enabled for all (future) users." 

# Log data on how open source the package set is
echo "*** Non-free packages:"
vrms 

# Part IV - end

log "*** obviux.sh has installed a desktop to your Debian Stretch."
echo "*** You can find logs in '$path_log'"
echo "Please restart your computer. ('shutdown -r now')"
