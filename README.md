# Teac

**TODO: Add description**

## Development

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

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `teac` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:teac, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/teac>.
