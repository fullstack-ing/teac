defmodule Teac.Api.Channels.Followed do
  def get(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.get(opts, :client_id, Teac.client_id())
    user_id = Keyword.fetch!(opts, :user_id)
    params = [user_id: user_id]

    params =
      case Keyword.get(opts, :broadcaster_id) do
        nil -> params
        broadcaster_id -> params ++ [broadcaster_id: broadcaster_id]
      end

    case Req.get!(Teac.api_uri() <> "channels/followed",
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
