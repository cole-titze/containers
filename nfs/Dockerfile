# Use Alpine as the base image
FROM alpine:latest

# Install necessary NFS packages
RUN apk add --no-cache nfs-utils

# Create an NFS export directory
RUN mkdir -p /export && chmod 777 /export

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose NFS and related ports
EXPOSE 111/udp 111/tcp 2049/tcp 2049/udp

# Run the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]