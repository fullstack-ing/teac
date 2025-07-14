defmodule Teac.Api.Chat.Emotes.Global do
  def get(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.get(opts, :client_id, Teac.client_id())

    params =
      case Keyword.get(opts, :broadcaster_id) do
        nil -> []
        broadcaster_id -> [broadcaster_id: broadcaster_id]
      end

    case Req.get!(Teac.api_uri() <> "chat/emotes/global",
           headers: [
             {"Authorization", "Bearer #{token}"},
             {"Client-Id", client_id}
           ],
           params: params
         ) do
      %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
      %Req.Response{body: body} -> {:error, body}
    end
  end
end
