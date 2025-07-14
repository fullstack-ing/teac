# Teac

Twitch Elixir API Client
For Twitch's REST and WebSocket API.

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
Assuming you have a Twitch mock server running to get the auth.
```
{:ok, [%{"ID" => client_id, "Secret" => client_secret}]} = Teac.MockApi.clients()

{:ok, %{"access_token" => access_token}} =
  Teac.MockAuth.fetch_app_access_token(client_id: client_id, client_secret: client_secret)

opts = [token: access_token, client_id: client_id, client_secret: client_secret]
{:ok, data} = Teac.Api.Bits.Cheermotes.get(opts)
```

Every endpoint in the `Teac.Api` module takes an opts Keyword list.
By default most will require a `token` and `client_id`.

All the other options are also just passed in the Keyword list (opts).

### Scopes
- [x] All scopes have been implemented

### Analytics
- [ ] Extensions.get()
- [ ] Game.get()

### Bits
- [x] Cheermotes.get()
- [ ] Extensions.get()
- [ ] Extensions.put()
- [ ] Leaderboard.get()

### ChannelPoints
- [ ] CustomRewards.get()
- [ ] CustomRewards.post()
- [ ] CustomRewards.patch()
- [ ] CustomRewards.delete()
- [ ] Redemptions.get()
- [ ] Redemptions.patch()

### Channels
- [ ] get()
- [ ] patch()
- [ ] Ads.get()
- [ ] Ads.Schedule.Snooze.post()
- [ ] Commercial.post()
- [ ] Editors.get()
- [ ] Followed.get()
- [ ] Followers.get()
- [ ] Vips.get()
- [ ] Vips.delete()

### Charity
- [ ] Campaigns.get()
- [ ] Donations.get()

### Chat
- [x] Announcements.post()
- [x] Badges.get()
- [x] Badges.Global.get()
- [ ] Chatters.get()
- [ ] Color.get()
- [ ] Color.put()
- [x] Emotes.get()
- [x] Emotes.Global.get()
- [ ] Emotes.Set.get()
- [ ] Emotes.User.get()
- [x] Messages.post()
- [ ] Settings.get()
- [ ] Settings.patch()
- [ ] Shoutouts.post()

### Clips
- [ ] get()
- [ ] post()

### ContentClassificationLabels
- [ ] get()

### Entitlements
- [ ] Drops.get()
- [ ] Drops.patch()

### EventSub
- [ ] Conduits.get()
- [ ] Conduits.post()
- [ ] Conduits.patch()
- [ ] Conduits.delete()
- [ ] Conduits.Shards.get()
- [ ] Conduits.Shards.patch()
- [ ] Subscriptions.get()
- [ ] Subscriptions.post()
- [ ] Subscriptions.delete()

### Extensions do
- [ ] get()
- [ ] Chat.post()
- [ ] Configurations.get()
- [ ] Configurations.put()
- [ ] Live.get()
- [ ] Jwt.Secrets.get()
- [ ] PubSub.post()
- [ ] Released.get()
- [ ] RequiredConfiguration.put()
- [ ] Transactions.get()

### Games do
- [ ] get()
- [ ] Top.get()

### Goals
- [ ] get()

### GuestStar
- [ ] ChannelCettings.get()
- [ ] ChannelCettings.put()
- [ ] Invites.get()
- [ ] Invites.post()
- [ ] Invites.delete()
- [ ] Session.get()
- [ ] Session.post()
- [ ] Session.delete()
- [ ] Slot.get()
- [ ] Slot.post()
- [ ] Slot.delete()
- [ ] SlotSettings.patch()

### Hypetrain
- [ ] get()

### Moderation
- [ ] Automod.Settings.get()
- [ ] Automod.Settings.put()
- [ ] Bans.post()
- [ ] Bands.delete()
- [ ] Banned.get()
- [ ] BlockedTerms.get()
- [ ] BlockedTerms.post()
- [ ] BlockedTerms.delete()
- [ ] Channels.get()
- [ ] Chat.delete()
- [ ] Snforcements.Status.post()
- [ ] Moderators.get()
- [ ] Moderators.post()
- [ ] Moderators.delete()
- [ ] ShieldMode.get()
- [ ] ShieldMode.put()
- [ ] Warnings.post()
- [ ] UnbanRequests.get()
- [ ] UnbanRequests.patch()

### Polls
- [ ] get()
- [ ] post()
- [ ] patch()

### Predictions
- [ ] get()
- [ ] post()
- [ ] patch()

### Raids
- [ ] post()
- [ ] delete()

### Schedule
- [ ] get()
- [ ] delete()
- [ ] ICalendar.get()
- [ ] Segment.post()
- [ ] Segment.patch()
- [ ] Settings.patch()

### Search
- [ ] Categories.get()
- [ ] Channels.get()

### SharedChat
- [ ] get()

### Streams
- [ ] get()
- [ ] Followed.get()
- [ ] Markers.get()
- [ ] Markers.post()
- [ ] Tags.get()

### Subscriptions
- [ ] get()
- [ ] User.get()

### Tags
- [ ] get()

### Teams
- [ ] get()
- [ ] Channel.get()

### Users
- [x] get()
- [x] put()
- [ ] Blocks.get()
- [ ] Blocks.put()
- [ ] Blocks.delete()
- [ ] Extensions.get()
- [ ] Extensions.put()
- [ ] Extensions.List.get()

### Videos
- [ ] get()
- [ ] delete()

### Whipsers
- [ ] get()


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
