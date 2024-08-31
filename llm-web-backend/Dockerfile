FROM arm64v8/alpine:latest AS build-env
WORKDIR /llm

# Running as root
RUN apk update && apk upgrade
RUN apk add make
RUN apk add git

# Build app
RUN git clone https://github.com/ggerganov/llama.cpp.git
RUN apk add build-base
WORKDIR /llm/llama.cpp
RUN make

# Generate image
FROM arm64v8/alpine:latest
WORKDIR /llm

# Running as root
RUN apk update && apk upgrade
# Install dependencies
RUN apk add --no-cache libstdc++ libgomp

RUN addgroup -S llmgroup && adduser -S llmuser 
USER llmuser

COPY --from=build-env --chown=llmuser:llmgroup /llm/llama.cpp/llama-server .

EXPOSE 8083
ENTRYPOINT ["./llama-server", "--model", "./models/model.gguf", "--port", "8083", "--host", "0.0.0.0"]