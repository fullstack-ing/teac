# Teac

Twitch Elixir API Client
For Twitch's REST and WebSocket API.

> ⚠️  Please note this is a work in progress. ⚠️   
> There is a ticket for varifying each and every http reset endpoint.    
> To check if a given endpoint been fully implamented, check the issues corrasponding to that endpoint.    

## Hex docs

https://hexdocs.pm/teac/readme.html

## Installation

This is currently a work in progress.

```elixir
def deps do
  [
    {:teac, "~> 0.1.0"}
    # {:teac, git: "https://github.com/fullstack-ing/teac"}
  ]
end
```

### .env
```bash
export TWITCH_CLIENT_ID=""
export TWITCH_CLIENT_SECRET=""
export TWITCH_API_URI="https://api.twitch.tv/helix/"
export TWITCH_AUTH_URI="https://id.twitch.tv/oauth2/"
export TWITCH_OAUTH_CALLBACK_URI="http://example.com:4000/oauth/callbacks/twitch/"
```

### config.ex

```elixir
config :teac,
  client_id: System.get_env("TWITCH_CLIENT_ID"),
  client_secret: System.get_env("TWITCH_CLIENT_SECRET"),
  api_uri: System.get_env("TWITCH_API_URI"),
  auth_uri: System.get_env("TWITCH_AUTH_URI"),
  oauth_callback_uri: System.get_env("TWITCH_OAUTH_CALLBACK_URI")
```

## Basic Usage. 

All the REST API endpoints are namedspaced under Teac.Api
Thus:
```elixir
Teac.Api.Bits.Leaderboards.get(token: "some_auth_token")
```

Though the documentation is still a work in progress you will want to check to see if the given endpoint requires a User or App token. 
Some endpoints can use either or but will limit the information if its in regards to the user in question (IE: their email)
Some endpoints are exclusively app flow token, and other exclusively user flow tokens. Again check the endpoints documentation. 
https://dev.twitch.tv/docs/api/reference/

## Example Application using this lib.
https://github.com/fullstack-ing/teac_example

## Using App Flow Auth token.

A genserver that fetches and mantains a valid auth token for Client Credential is provided.
IE: Server To Server or noted as on any endpoint as `Requires an app access token`

```elixir
def start(_type, _args) do
  children = [
    ...
    Teac.Oauth.ClientCredentialManager,
    ...
  ]
  opts = [strategy: :one_for_one, name: TeacExample.Supervisor]
  Supervisor.start_link(children, opts)
end
```

Assuming you provided your `.env` vars and have a running server.
You should be able to call that genserver to get a working token via.

```elixir
Teac.Oauth.ClientCredentialManager.get_token()
```

This should always return a valid app token.


## Developing
You will need the twitch cli tool.
https://dev.twitch.tv/docs/cli/

* Generate some mock data
  `twitch mock-api generate -c 6`

* Set Env Variables from mock output
  `export TWITCH_CLIENT_ID=your_client_id`
  `export TWITCH_CLIENT_SECRET=your_client_secret`
  `export TWITCH_API_URI="http://localhost:8080"`

* Start a mock twitch server.
  `twitch mock-api serve`

Assuming you have a Twitch mock server running to get the auth.
```elixir
{:ok, [%{"ID" => client_id, "Secret" => client_secret}]} = Teac.MockApi.clients()

{:ok, %{"access_token" => access_token}} =
  Teac.MockAuth.fetch_app_access_token(client_id: client_id, client_secret: client_secret)

opts = [token: access_token, client_id: client_id, client_secret: client_secret]
{:ok, data} = Teac.Api.Bits.Cheermotes.get(opts)
```

Every endpoint in the `Teac.Api` module takes an opts Keyword list.
By default most will require a `token` and `client_id`.

All the other options are also just passed in the Keyword list (opts).

