defmodule Teac.Scopes.Clips do
  @moduledoc "Clip management scopes"
  @edit "clips:edit"
  @scope_map %{
    clips_edit: @edit
  }
  use Teac.Scopes.Helper

  @doc """
  Manage Clips for a channel.

  API:
  - Create Clip: https://dev.twitch.tv/docs/api/reference#create-clip
  """
  def edit, do: @edit
end
