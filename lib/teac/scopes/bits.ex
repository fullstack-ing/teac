defmodule Teac.Scopes.Bits do
  @moduledoc "Bits and cheering related scopes"
  @read "bits:read"
  @scope_map %{
    bits_read: @read
  }
  use Teac.Scopes.Helper

  @doc """
  View Bits information for a channel.

  API:
    - Get Bits Leaderboard: https://dev.twitch.tv/docs/api/reference#get-bits-leaderboard

  EventSub:
    - Channel Bits Use: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelbitsuse
    - Channel Cheer: https://dev.twitch.tv/docs/eventsub/eventsub-subscription-types/#channelcheer
  """
  def read, do: @read
end
