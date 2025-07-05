FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Update and install packages
RUN apt-get update && apt-get install -y \
    curl wget git sudo vim gnupg2 ca-certificates \
    python3 python3-pip nodejs npm \
    && apt-get clean

# Create user for code-server
RUN useradd -m coder \
    && echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER coder
WORKDIR /home/coder

# Install code-server (latest stable)
# https://github.com/coder/code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Create project folder
RUN mkdir /home/coder/project

# Expose port
EXPOSE 8090

# Set environment variables
ENV PASSWORD=changeme

# Start code-server on container start
CMD ["code-server", "--bind-addr", "0.0.0.0:8090", "/home/coder/project"]