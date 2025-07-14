defmodule Teac.Api.Chat.Badges.Global do
  @doc """
  Gets Twitch’s list of chat badges, which users may use in any channel’s chat room.
  For information about chat badges, see Twitch Chat Badges Guide.

  source docs: https://dev.twitch.tv/docs/api/reference/#get-global-chat-badges

  ## Authorization

  Requires an app access token or user access token.
  """
  def get(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.get(opts, :client_id, Teac.client_id())
    user_id = Keyword.fetch!(opts, :user_id)

    case Req.get!(Teac.api_uri() <> "chat/badges/global",
           headers: [
             {"Authorization", "Bearer #{token}"},
             {"Client-Id", client_id}
           ],
           params: [user_id: user_id]
         ) do
      %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
      %Req.Response{body: body} -> {:error, body}
    end
  end
end
