FROM arm64v8/alpine:latest AS build-env
WORKDIR /llm

# Running as root
RUN apk update && apk upgrade
RUN apk add cmake
RUN apk add git

# Build app
RUN git clone https://github.com/ggerganov/llama.cpp.git
RUN apk add build-base
WORKDIR /llm/llama.cpp

# Create build directory and compile with CMake
RUN mkdir build && cd build && \
    cmake .. && \
    cmake --build . --config Release

# Generate image
FROM arm64v8/alpine:latest
WORKDIR /llm

# Running as root
RUN apk update && apk upgrade
# Install dependencies
RUN apk add --no-cache libstdc++ libgomp

RUN addgroup -S llmgroup && adduser -S llmuser 
USER llmuser

COPY --from=build-env --chown=llmuser:llmgroup /llm/llama.cpp/build/bin/llama-server .

EXPOSE 8083
ENTRYPOINT ["./llama-server", "--model", "./models/model.gguf", "--port", "8083", "--host", "0.0.0.0"]