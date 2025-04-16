defmodule Teac.Scopes do
  @moduledoc """
  Twitch Auth Scopes
  """

  @doc """
  Get scope string by atom key. Example:

      TwitchAuth.Scopes.get(:user_read_email)
      iex> "user:read:email"
  """
  def get(key), do: Map.fetch!(all(), key)

  @doc "Get all scopes"
  def all do
    %{}
    |> Map.merge(Teac.Scopes.Analytics.all())
    |> Map.merge(Teac.Scopes.Bits.all())
    |> Map.merge(Teac.Scopes.Channel.all())
    |> Map.merge(Teac.Scopes.Clips.all())
    |> Map.merge(Teac.Scopes.Moderation.all())
    |> Map.merge(Teac.Scopes.User.all())
  end

  @doc "Get all scope values"
  def all_values, do: all() |> Map.values()

  @doc "Get all scope atoms"
  def all_keys, do: Map.keys(all())
end
