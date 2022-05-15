#!/bin/sh

# https://nixos.org/download.html#nix-install-windows

sh <(curl -L https://nixos.org/nix/install) --no-daemon

#Installation finished!  To ensure that the necessary environment
#variables are set, either log in again, or type
#
#  . ~/.nix-profile/etc/profile.d/nix.sh

sudo mkdir /nix
sudo chown $(whoami) /nix

# test
nix-env -i hello
which hello
# expect .*/\.nix\-profile/bin/hello
hello
# expect Hello, world!
