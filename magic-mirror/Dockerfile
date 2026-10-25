FROM arm64v8/alpine:latest AS build-env

RUN apk add --no-cache git
RUN apk add --update nodejs npm
WORKDIR /repos
RUN git clone https://github.com/MagicMirrorOrg/MagicMirror
WORKDIR /repos/MagicMirror

RUN npm run install-mm
# Upstream's lockfile can lag patched releases that Trivy flags; move these within their semver ranges
RUN npm update --no-audit --no-fund --omit=dev body-parser undici electron
RUN cp ./config/config.js.sample ./config/config.js
RUN sed -i "s|8080|8082|g" ./config/config.js
RUN sed -i 's|\["127\.0\.0\.1", "::ffff:127\.0\.0\.1", "::1"\]|\[\]|g' ./config/config.js
RUN sed -i 's|localhost|0\.0\.0\.0|g' ./config/config.js

# Run unprivileged. At startup MagicMirror writes config/basepath.js and js/positions.js,
# so only those two folders belong to the runtime user; npm needs a writable HOME.
RUN chown 1000:1000 config js
ENV HOME=/tmp
USER 1000:1000

EXPOSE 8082

ENTRYPOINT ["npm", "run", "server"]
