import Config

config :teac,
  api_req_options: [plug: {Req.Test, Teac.Api}],
  client_id: "foobar_client_id",
  client_secret: "foobar_client_secret",
  api_uri: "http://foobar.com/mock/",
  auth_uri: "http://foobar.com/auth/",
  oauth_callback_uri: "http://localhost:4000/oauth/callbacks/twitch/"
