FROM alpine:latest

WORKDIR /nfs

# Install NFS user-space server and RPC tools
RUN apk add --no-cache unfs3 rpcbind

# Create an NFS export directory
RUN mkdir -p /export && chmod 777 /export

# Add an exports file
RUN echo "/export *(rw,no_root_squash,fsid=0,sync)" > /etc/exports

# Expose NFS ports
EXPOSE 111/tcp 111/udp 2049/tcp 2049/udp

ENTRYPOINT ["/bin/sh", "-c", "rpcbind && unfsd -e /etc/exports -n 2049"]