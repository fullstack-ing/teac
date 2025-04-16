defmodule Teac.Scopes.Analytics do
  @moduledoc "Analytics related scopes"
  @read_extension "analytics:read:extensions"
  @read_games "analytics:read:games"
  @scope_map %{
    analytics_read_extensions: @read_extension,
    analytics_read_games: @read_games
  }
  use Teac.Scopes.Helper

  @doc """
  View analytics data for the Twitch Extensions owned by the authenticated account.

  API:
    - [Get Extension Analytics:](https://dev.twitch.tv/docs/api/reference#get-extension-analytics)
  """
  def read_extension, do: @read_extension

  @doc """
  View analytics data for the games owned by the authenticated account.

  API:
    - Get Game Analytics: https://dev.twitch.tv/docs/api/reference#get-game-analytics
  """
  def read_games, do: @read_games
end
