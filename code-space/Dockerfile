FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Update and install packages
RUN apt-get update && apt-get install -y curl && apt-get clean

# Create user for code-server
RUN useradd -m coder \
    && echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Switch to bash as default shell for coder user
RUN sed -i 's|^coder:.*:/bin/sh$|coder:x:1000:1000::/home/coder:/bin/bash|' /etc/passwd

# Install code-server (latest stable)
# https://github.com/coder/code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

USER coder
WORKDIR /code-space

# Expose port
EXPOSE 8090

# Start code-server on container start
CMD ["code-server", "--bind-addr", "0.0.0.0:8090", "/code-space"]