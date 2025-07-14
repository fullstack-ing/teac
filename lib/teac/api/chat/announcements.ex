defmodule Teac.Api.Chat.Announcements do
  @doc """
  Sends an announcement to the broadcaster’s chat room.

  source docs: https://dev.twitch.tv/docs/api/reference/#send-chat-announcement
  Rate Limits: One announcement may be sent every 2 seconds.

  ## Authorization

  Requires a user access token that includes the moderator:manage:announcements scope.
  """
  def post(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.get(opts, :client_id, Teac.client_id())
    broadcaster_id = Keyword.fetch!(opts, :broadcaster_id)
    moderator_id = Keyword.fetch!(opts, :moderator_id)
    message = Keyword.fetch!(opts, :message)
    color = Keyword.get(opts, :color, nil)

    case Req.post!(Teac.api_uri() <> "chat/announcements",
           headers: [
             {"Authorization", "Bearer #{token}"},
             {"Client-Id", client_id},
             {"Content-Type", "application/x-www-form-urlencoded"}
           ],
           form: [
             broadcaster_id: broadcaster_id,
             moderator_id: moderator_id,
             message: message,
             color: color
           ],
           decode_body: :json
         ) do
      %Req.Response{status: 204, body: %{"data" => data}} -> {:ok, data}
      %Req.Response{body: body} -> {:error, body}
    end
  end
end
