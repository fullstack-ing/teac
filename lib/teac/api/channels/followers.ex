defmodule Teac.Api.Channels.Followers do
  def get(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.get(opts, :client_id, Teac.client_id())
    broadcaster_id = Keyword.fetch!(opts, :broadcaster_id)
    params = [broadcaster_id: broadcaster_id]

    params =
      case Keyword.get(opts, :user_id) do
        nil -> params
        user_id -> params ++ [user_id: user_id]
      end

    case Req.get!(Teac.api_uri() <> "channels/followers",
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
