# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :remote_assessment,
  ecto_repos: [RemoteAssessment.Repo]

# Configures the endpoint
config :remote_assessment, RemoteAssessmentWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: RemoteAssessmentWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: RemoteAssessment.PubSub,
  live_view: [signing_salt: "XSuRzKZc"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, json_library: Jason, logger: false

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
