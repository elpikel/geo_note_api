# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :geo_note_api,
  ecto_repos: [GeoNoteApi.Repo]

# Configures the endpoint
config :geo_note_api, GeoNoteApi.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "d0RXt+WLpIDqaaG2xEWo5/I+GlqQCmDUy8siv8Wr2gnQnMj+8MxyWCVqeurAzR+f",
  render_errors: [view: GeoNoteApi.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GeoNoteApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
