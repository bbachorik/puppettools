#!/bin/sh

# linuxPuppetInstall.sh
# version 0.1

# POC: ALTESS Unix Engineering

# Install PE Puppet agent package on RHEL
# Currently ONLY supports RHEL5/6
# Usage: linuxPuppetInstall.sh <host1> <host2> ... <hostn>
#
# Changelog
# 01/14/2015 - None yet


for h in $@
do
  echo $h
  ssh -qt $h "
    cd /var/tmp
    curl -k https://puppet:8140/packages/current/install.bash | sudo bash
    "
  echo "Success: $h"
done
