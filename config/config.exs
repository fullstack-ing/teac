import Config

config :teac,
  mock_units: System.get_env("TWITCH_MOCK_UNITS") || "http://localhost:8080/units/",
  client_id: System.get_env("TWITCH_CLIENT_ID"),
  client_secret: System.get_env("TWITCH_CLIENT_SECRET"),
  api_uri: System.get_env("TWITCH_API_URI"),
  auth_uri: System.get_env("TWITCH_AUTH_URI"),
  oauth_callback_uri: System.get_env("TWITCH_OAUTH_CALLBACK_URI")
