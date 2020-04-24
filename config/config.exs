# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :sentrydemo, SentrydemoWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NJXXNMLf8x70WVaH+DCC+MuYD6FglPCilzs03YAdD9qNTd4VS9jC+mIZ6FLcINGX",
  render_errors: [view: SentrydemoWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Sentrydemo.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "2eEyyoaO"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Sentry
config :sentry, dsn: "https://d12a53b0255c47ab8cd8f04e488b4dee@sentry.io/5182105",
   included_environments: [:prod, :dev],
   environment_name: Mix.env
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
