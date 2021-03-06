#!/bin/bash

# Author: David Medeiros
# Date: 2017-12-04
# Description: Adding ACL and Quota support to /home

apt update && apt upgrade -y

apt install -y acl attr

sudo cp -rfvp /etc/fstab /etc/fstab.orig

partition=$(df --output=source /home/ | tail -n1)

uuid=$(sudo blkid -s UUID -o value $partition)

sed -i '/.*\/home.*.*ext4.*/c\UUID='$uuid' \/home           ext4    defaults,usrjquota=aquota.user,grpjquota=aquota.group,jqfmt=vfsv0,user_xattr,acl,barrier=1        0       2' /etc/fstab

mount -o remount,rw /home
