FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl jq libicu74 git && \
    apt-get clean

# Create non-root user 'coder' with specific UID (e.g., 1001) and bash shell
RUN useradd -m -u 1001 -s /bin/bash coder
RUN mkdir /home/coder/source

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Prepare code-server directories as root
RUN chown -R coder:coder /home/coder/source 

RUN echo "coder uid: $(id -u coder)"

# Copy VS Code settings
COPY --chown=coder:coder settings.json /home/coder/.local/share/code-server/User/settings.json

# Switch to coder user
USER coder
ENV HOME=/home/coder
WORKDIR /home/coder

# Setup git user
RUN git config --global user.email "cole.titze@outlook.com"
RUN git config --global user.name "Cole Titze"

# Get dotnet
RUN curl -L https://dot.net/v1/dotnet-install.sh -o dotnet-install.sh && \
    chmod +x dotnet-install.sh && \
    ./dotnet-install.sh --channel STS && \
    rm dotnet-install.sh

ENV PATH="${HOME}/.dotnet:${PATH}"

# Setup ssh folder permissions
RUN mkdir -p /home/coder/source/.ssh && \
    chmod 700 /home/coder/source/.ssh

COPY --chown=coder:coder README.md /home/coder/source/README.md

# Install code-server extension 'continue.continue' as coder user
RUN code-server --install-extension continue.continue --extensions-dir /home/coder/.local/share/code-server/extensions

EXPOSE 8090

CMD ["code-server", "--bind-addr", "0.0.0.0:8090", "/home/coder/source"]