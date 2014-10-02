#!/bin/sh -ex

yum --assumeyes install cloud-init

# Remove unnecessary packages (and their dependencies)
# which can’t be removed until after the installation process
yum --assumeyes autoremove authconfig firewalld linux-firmware

# Clean up old yum repo data & logs
yum clean all
yum history new
rm --recursive --force /var/lib/yum/yumdb/*
rm --recursive --force /var/lib/yum/history/*
truncate --no-create --size=0 /var/log/yum.log

# Remove random-seed, so it’s not the same in every image
rm --force /var/lib/random-seed

dracut -H --force

# Change any incorrect SELinux context labels
fixfiles -R -a restore


