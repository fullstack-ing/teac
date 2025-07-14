defmodule Teac.Api.Chat.Emotes.Set do
  def get(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.get(opts, :client_id, Teac.client_id())
    emote_set_id = Keyword.fetch!(opts, :emote_set_id)

    case Req.get!(Teac.api_uri() <> "chat/emotes/set",
           headers: [
             {"Authorization", "Bearer #{token}"},
             {"Client-Id", client_id}
           ],
           params: [
             emote_set_id: emote_set_id
           ]
         ) do
      %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
      %Req.Response{body: body} -> {:error, body}
    end
  end
end
