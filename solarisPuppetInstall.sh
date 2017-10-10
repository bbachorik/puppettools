#!/bin/sh

# solarisPuppetInstall.sh
# version 0.1

# POC: ALTESS Unix Engineering

# Install PE Puppet agent package on Solaris
# Currently ONLY supports Solaris 10
# Usage: solarisPuppetInstall.sh <host1> <host2> ... <hostn>
#
# Changelog
# 01/14/2015 - None yet


for h in $@
do
  echo $h
  OS=`ssh -q $h "uname"`
  if [ "$OS" = "SunOS" ]; then
    OSVER=`ssh -q $h "uname -r"`

    case $OSVER in
      5.10)
        echo "Detected Solaris 10..."
        ssh -q $h "
          PATH=$PATH:/usr/sfw/bin
          cd /var/tmp
          /usr/sfw/bin/wget --no-check-certificate \
          https://puppet.altess.army.mil:8140/packages/current/solaris-10-sparc.bash
          chmod +x solaris-10-sparc.bash
          /var/tmp/solaris-10-sparc.bash
          "
          echo "Success: $h"
        ;;
      5.11)
        echo "Detected Solaris 11..."
        ssh -q $h "
          cd /var/tmp
          wget --no-check-certificate https://puppet.altess.army.mil:8140/packages/current/solaris-11-sparc.bash
          chmod +x solaris-11-sparc.bash
          /var/tmp/solaris-11-sparc.bash
          "
          echo "Success: $h"
        ;;
      *)
        echo "Version $OSVER of Solaris not supported!"
        echo "Failed: $h"
        ;;
    esac

  else
    echo "Only Solaris OS supported!"
    echo "Failed: $h"
  fi

done
