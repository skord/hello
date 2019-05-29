FROM elixir:1.8.2-otp-22-alpine 
RUN apk update && \
    apk upgrade && \
    apk add bash openssl
ENV MIX_ENV prod
WORKDIR /opt/app
COPY . /opt/app
ENV DATABASE_URL ecto://USER:PASS@HOST/DATABASE
ENV SECRET_KEY_BASE f6USJXUMAZj2PN2ocJZBZ4CmB1EsNow2wrQtGbptzfSuQAWBCudkDppL7KrKi4Ry
RUN mix local.hex --force && \
    mix local.rebar --force
RUN mix do deps.get, deps.compile 
RUN mix release --env=prod
ENV PORT 4000
EXPOSE 4000
CMD ["/opt/app/_build/prod/rel/hello/bin/hello", "foreground"]