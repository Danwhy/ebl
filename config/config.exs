# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :ebl,
  ecto_repos: [Ebl.Repo]

# Configures the endpoint
config :ebl, Ebl.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "cDpWHfaBFdzWrWWxdNJlOF5Lci70+joI43mIfNu8ihj6AErJKlS7uvcdZvU2UTk4",
  render_errors: [view: Ebl.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Ebl.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
