# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :phoenix_chat,
  ecto_repos: [PhoenixChat.Repo]

# Configures the endpoint
config :phoenix_chat, PhoenixChat.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "EWVAQTM+yUsJn/i16UfSZJR+uk1wsYpYW3sJuc+PTNzChpkPcP82LVt0Yu+0cOkE",
  render_errors: [view: PhoenixChat.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PhoenixChat.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import Timber, structured logging
import_config "timber.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: PhoenixChat.User,
  repo: PhoenixChat.Repo,
  module: PhoenixChat,
  logged_out_url: "/",
  email_from_name: "Tasha",
  email_from_email: "tasha@51percent.tech",
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :registerable],
  password_hash: "Someday"

config :coherence, PhoenixChat.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: System.get_env("NONEYA")
# %% End Coherence Configuration %%

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
