FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl jq git && \
    apt-get clean

# Get dotnet
RUN curl -L https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh && \
    chmod +x dotnet-install.sh && \
    ./dotnet-install.sh --version latest && \
    rm dotnet-install.sh

# Create non-root user with bash shell
RUN useradd -m -s /bin/bash coder && \
    echo "coder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Copy VS Code settings
COPY --chown=coder:coder settings.json /home/coder/.local/share/code-server/User/settings.json

# Switch to coder user
USER coder
ENV HOME=/home/coder

# Setup ssh folder permissions
RUN mkdir -p /home/coder/.ssh && \
    chmod 700 /home/coder/.ssh

# Create temporary directory for Copilot download
RUN mkdir -p /tmp/copilot

# Query GitHub Copilot latest version number
RUN VERSION=$(curl -s 'https://marketplace.visualstudio.com/_apis/public/gallery/extensionquery' \
  -H 'accept: application/json;api-version=7.2-preview.1;excludeUrls=true' \
  -H 'Content-Type: application/json' \
  --data '{"filters":[{"criteria":[{"filterType":7,"value":"github.copilot"}]}],"flags":2151}' \
  | jq -r '.results[0].extensions[0].versions[0].version') \
  && echo "[i] Version ${VERSION}" \
  && curl \
        -o "copilot-${VERSION}.vsix" \
        --compressed \
        "https://marketplace.visualstudio.com/_apis/public/gallery/publishers/GitHub/vsextensions/copilot/${VERSION}/vspackage" \
  && code-server --install-extension "copilot-${VERSION}.vsix"

EXPOSE 8090

CMD ["code-server", "--bind-addr", "0.0.0.0:8090", "/code-space"]