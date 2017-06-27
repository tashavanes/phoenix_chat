use Mix.Config

# Update the instrumenters so that we can structure Phoenix logs
config :phoenix_chat, PhoenixChat.Endpoint,
  instrumenters: [Timber.Integrations.PhoenixInstrumenter]

# Structure Ecto logs
config :phoenix_chat, PhoenixChat.Repo,
  loggers: [{Timber.Integrations.EctoLogger, :log, [:info]}]

# Use Timber as the logger backend
# Feel free to add additional backends if you want to send you logs to multiple devices.
# Deliver logs via HTTP to the Timber API by using the Timber HTTP backend.
config :logger,
  backends: [Timber.LoggerBackends.HTTP],
  utc_log: true

config :timber,
  api_key: "312_cb35c8d2206d84f4:294506bba274ab152165996165708f9327f238c51ff03567df4fc02b0b614f0d"

# For dev / test environments, always log to STDOUT and format the logs properly
if Mix.env() == :dev || Mix.env() == :test do
  # Fall back to the default `:console` backend with the Timber custom formatter
  config :logger,
    backends: [:console],
    utc_log: true

  config :logger, :console,
    format: {Timber.Formatter, :format},
    metadata: [:timber_context, :event, :application, :file, :function, :line, :module]

  config :timber, Timber.Formatter,
    colorize: true,
    format: :logfmt,
    print_timestamps: true,
    print_log_level: true,
    print_metadata: false # turn this on to view the additiional metadata
end

# Need help?
# Email us: support@timber.io
# File an issue: https://github.com/timberio/timber-elixir/issues
