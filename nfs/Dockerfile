# Use a lightweight base image for Raspberry Pi
FROM ubuntu:latest

# Install required packages
RUN apt-get update && apt-get install -y \
    nfs-kernel-server \
    rpcbind \
    && rm -rf /var/lib/apt/lists/*

# Create the NFS share directory
RUN mkdir -p /nfs_share && chmod 777 /nfs_share

# Define the NFS exports configuration
RUN echo "/nfs_share *(rw,sync,no_subtree_check,no_root_squash)" > /etc/exports

# Expose NFS ports
EXPOSE 2049 111/udp 111/tcp

# Run NFS server in the foreground
CMD ["bash", "-c", "rpcbind && exportfs -r && service nfs-kernel-server start && tail -f /dev/null"]