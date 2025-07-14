defmodule Teac.Api.Channels.Editors do
  def get(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.get(opts, :client_id, Teac.client_id())
    broadcaster_id = Keyword.fetch!(opts, :broadcaster_id)

    case Req.get!(Teac.api_uri() <> "channels/editors",
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
