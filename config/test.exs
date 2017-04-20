use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :ngeo_backend, NGEOBackend.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :ngeo_backend, NGEOBackend.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "test_ngeodb",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  pool_size: 10