import Config

config :teac,
  client_id: System.get_env("TWITCH_CLIENT_ID"),
  client_secret: System.get_env("TWITCH_CLIENT_SECRET"),
  api_uri: System.get_env("TWITCH_API_URI"),
  oauth_callback_uri: System.get_env("TWITCH_OAUTH_CALLBACK_URI")
