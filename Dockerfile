FROM node:22.5.1-alpine3.19 AS test-build

RUN wget -qO- https://get.pnpm.io/install.sh | ENV="$HOME/.shrc" SHELL="$(which sh)" PNPM_VERSION=9.6.0 sh -
RUN mv /root/.local/share/pnpm/pnpm /usr/bin/

WORKDIR /usr/src/app
COPY example/package.json package.json
COPY example/pnpm-lock.yaml pnpm-lock.yaml
COPY example/scripts scripts

RUN pnpm fetch
RUN pnpm install -r --offline --ignore-pnpmfile --prod

WORKDIR /opt/warthog

COPY .npmrc .
COPY package.json .
COPY pnpm-lock.yaml .

RUN apk add jq
RUN jq 'del(.scripts.prepare)' package.json > .package.json && mv .package.json package.json
RUN pnpm fetch
RUN pnpm install -r --offline --ignore-pnpmfile --prod

COPY src/ src/

RUN pnpm link --global

ARG SCRIPT_PARALLELISM
ENV SCRIPT_PARALLELISM=$SCRIPT_PARALLELISM

ARG WARTHOG_TESTS_PATH
ENV WARTHOG_TESTS_PATH=$WARTHOG_TESTS_PATH

ARG REDIS_HOST
ENV REDIS_HOST=$REDIS_HOST

WORKDIR /usr/src/app
RUN pnpm install /opt/warthog

CMD ["tail", "-f", "/dev/null"]
