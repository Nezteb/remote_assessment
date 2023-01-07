FROM elixir:1.14.2 as build

ARG MIX_ENV=dev
ENV MIX_ENV $MIX_ENV

ARG DB_USERNAME
ENV DB_USERNAME $DB_USERNAME

ARG DB_PASSWORD
ENV DB_PASSWORD $DB_PASSWORD

ARG DB_HOSTNAME
ENV DB_HOSTNAME $DB_HOSTNAME

ARG DB_DATABASE
ENV DB_DATABASE $DB_DATABASE

WORKDIR /app

RUN apt-get update && apt-get install -y inotify-tools

RUN mix local.rebar --force
RUN mix local.hex --force

# install mix dependencies
COPY mix.exs mix.lock .
RUN mix deps.get --only $MIX_ENV

# copy compile configuration files
RUN mkdir config
COPY config/config.exs config/runtime.exs config/$MIX_ENV.exs config
COPY priv priv

# Compile project
COPY test test
COPY lib lib
RUN mix compile

EXPOSE 4000
CMD mix ecto.setup && mix phx.server

# TODO: Set up multi-stage builds for dev vs prod (using alpine image) for a smaller (more secure) image
# Create release
# RUN mix release

# FROM elixir:1.14.2-alpine AS runtime

# WORKDIR /app
# RUN chown nobody /app

# ARG MIX_ENV=dev
# ENV MIX_ENV $MIX_ENV

# # Only copy the final release from the build stage
# COPY --from=build --chown=nobody:root /app/_build/$MIX_ENV/rel/stord_assessment .

# USER nobody
# EXPOSE 4000

# CMD ["./bin/stord_assessment", "start"]
