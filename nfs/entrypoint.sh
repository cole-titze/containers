#!/bin/sh
set -e

# Ensure the export directory exists
mkdir -p /export
chmod 777 /export

# Configure /etc/exports
echo "/export *(rw,sync,no_subtree_check,no_root_squash)" > /etc/exports

# Start NFS server
rpcbind
nfsd
exportfs -rav
/usr/sbin/rpc.nfsd
/usr/sbin/rpc.mountd -F