# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

config :ngeo_backend, ecto_repos: [NGEOBackend.Repo]

# Configures the endpoint
config :ngeo_backend, NGEOBackend.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rbKxpVBxbfazZLaC7We3OSl/h2u0JM1V5b4qSWfwyG8LnQy0r0/c3RU90h5TCT7l",
  render_errors: [view: NGEOBackend.ErrorView, accepts: ~w(html json)],
  pubsub: [name: NGEOBackend.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :ex_admin,
  repo: NGEOBackend.Repo,
  module: NGEOBackend,
  modules: [
    NGEOBackend.ExAdmin.Dashboard,
  ]
# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

config :xain, :after_callback, {Phoenix.HTML, :raw}

