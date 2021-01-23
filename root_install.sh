#!/usr/bin/env bash

set -e

#-------------------------------------------------
# Install packages
#-------------------------------------------------

echo "Updating packages..."
sudo apt-get update && sudo apt-get -y upgrade

echo "Installing my packages..."
cat pkg/list.txt \
	| awk '{ print $1 }' \
	| xargs \
		--max-args=1 \
		sudo apt-get install --yes \

#-------------------------------------------------
# Create my user with escalated privileges
#-------------------------------------------------

sudo useradd \
	--create-home \
	--groups adm,dialout,cdrom,sudo,audio,video,plugdev,games,users,input,netdev,spi,i2c,gpio \
	--shell /usr/bin/zsh \
	zach || true

sed \
	--in-place \
	--regexp-extended \
	's/^# (%wheel ALL=\(ALL\) NOPASSWD: ALL)/\1/' \
	/etc/sudoers

#-------------------------------------------------
# Output script success 
#-------------------------------------------------

echo
printf "All done with the root install\n"
printf "Don't forget to set your password!"
echo
