FROM debian:bullseye-slim

RUN apt-get update && apt-get install -y \
    build-essential cmake curl git ffmpeg libsndfile1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
RUN git clone https://github.com/ggerganov/whisper.cpp . && make

COPY run.sh /app/run.sh
RUN chmod +x run.sh

ENTRYPOINT ["/app/run.sh"]