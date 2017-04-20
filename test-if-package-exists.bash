# dpkg -s returns 0 on package installed
if dpkg -s  &> /dev/null; then if apt-get -qq 
                 install ; then echo ok; else echo argh; fi fi
