FROM alpine
RUN apk add --no-cache curl
RUN curl -sL https://github.com/gohugoio/hugo/releases/download/v0.31.1/hugo_0.31.1_Linux-64bit.tar.gz | tar zx

FROM node:9.3.0-alpine
RUN yarn global add firebase-tools && yarn cache clean
COPY --from=0 /hugo /usr/local/bin/hugo
