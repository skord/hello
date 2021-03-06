FROM elixir:1.8.2-otp-22-alpine 
RUN apk update && \
    apk upgrade && \
    apk add bash openssl nodejs-current npm
ENV MIX_ENV prod
WORKDIR /opt/app
COPY . /opt/app
WORKDIR /opt/app/assets
RUN npm install
WORKDIR /opt/app
RUN mix local.hex --force && \
    mix local.rebar --force
RUN mix do deps.get, deps.compile, phx.digest
RUN mix release --env=prod
ENV PORT 4000
EXPOSE 4000
CMD ["/opt/app/_build/prod/rel/hello/bin/hello", "foreground"]