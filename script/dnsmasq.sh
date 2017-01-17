#!/usr/bin/env bash

# make sure directories we need exist and are writable
sudo mkdir -pv $(brew --prefix)/sbin/
sudo chown -R $USER $(brew --prefix)/sbin/

sudo mkdir -pv $(brew --prefix)/etc/
sudo chown -R $USER $(brew --prefix)/etc/

# install dnsmasq and config to run on startup
brew install dnsmasq
sudo cp -v $(brew --prefix dnsmasq)/homebrew.mxcl.dnsmasq.plist /Library/LaunchDaemons

# add local DNS resolver for .localhost domain (so OS X queries dnsmasq)
[ -d /etc/resolver ] || sudo mkdir -v /etc/resolver
sudo bash -c 'echo "nameserver 127.0.0.1" > /etc/resolver/localhost'

# configure dnsmasq to send all .localhost traffic to the swarm cluster
export DOCKER_SWARM_IP=$(docker-machine ip swarm1)
echo "address=/localhost/${DOCKER_SWARM_IP}" > $(brew --prefix)/etc/dnsmasq.conf

# release the hounds
sudo launchctl load -w /Library/LaunchDaemons/homebrew.mxcl.dnsmasq.plist