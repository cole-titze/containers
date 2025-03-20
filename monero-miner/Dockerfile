# Use a lightweight Alpine base image
FROM alpine:latest

# Install necessary dependencies
RUN apk add --no-cache git cmake build-base libuv-dev openssl-dev hwloc-dev linux-headers

# Clone the XMRig repository
RUN git clone https://github.com/xmrig/xmrig.git /xmrig

# Set working directory
WORKDIR /xmrig

# Build XMRig
RUN mkdir build && cd build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release -DUSE_HUGE_PAGES=ON && \
    make -j$(nproc)

# Copy compiled binary to root
RUN cp build/xmrig /usr/local/bin/

# Set default environment variables
ENV WALLET_ADDRESS=""
ENV MINING_POOL="pool.supportxmr.com:3333"

# Start mining using environment variables
CMD ["sh", "-c", "xmrig --donate-level 1 -o $MINING_POOL -u $WALLET_ADDRESS -p x -k --cpu-priority 5"]