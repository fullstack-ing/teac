defmodule Teac.Api.SharedChat do
  def get(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.fetch!(opts, :client_id)
    broadcaster_id = Keyword.fetch!(opts, :broadcaster_id)

    case Req.get!(Teac.Api.api_uri() <> "shared_chat/session",
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
