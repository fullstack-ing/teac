defmodule Teac.Api.Chat.Badges do
  @doc """
    Gets the broadcaster’s list of custom chat badges. The list is empty if the broadcaster hasn’t created custom chat badges.
    For information about custom badges, see subscriber badges and Bits badges.

    source docs: https://dev.twitch.tv/docs/api/reference/#get-channel-chat-badges

    ## Authorization
    Requires an app access token or user access token.
  """
  def get(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.get(opts, :client_id, Teac.client_id())
    broadcaster_id = Keyword.fetch!(opts, :broadcaster_id)

    case Req.get!(Teac.api_uri() <> "chat/badges",
           headers: [
             {"Authorization", "Bearer #{token}"},
             {"Client-Id", client_id}
           ],
           params: [broadcaster_id: broadcaster_id]
         ) do
      %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
      %Req.Response{body: body} -> {:error, body}
    end
  end
end
