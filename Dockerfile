FROM  gplane/pnpm:latest as build-env

ADD package.json /app/package.json
ADD pnpm-lock.yaml /app/pnpm-lock.yaml
ADD index.js /app/index.js
WORKDIR /app

RUN pnpm install

FROM gcr.io/distroless/nodejs:latest
COPY --from=build-env /app /app
WORKDIR /app

EXPOSE 18083/tcp
ENV PORT=18083
ENV DAEMON_HOST=http://127.0.0.1:18081

CMD [ "index.js" ]