FROM alpine:latest

# Install NFS user-space server
RUN apk add --no-cache unfs3

# Create an NFS export directory
RUN mkdir -p /export && chmod 777 /export

# Add an exports file
RUN echo "/export *(rw,no_root_squash,fsid=0,sync)" > /etc/exports

# Expose NFS ports
EXPOSE 111/tcp 111/udp 2049/tcp 2049/udp

CMD ["unfsd", "-e", "/etc/exports", "-n"]