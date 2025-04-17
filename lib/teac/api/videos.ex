defmodule Teac.Api.Videos do
  def get(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.get(opts, :client_id, Teac.client_id())
    user_id = Keyword.fetch!(opts, :user_id)

    case Req.get!(Teac.api_uri() <> "videos",
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

  def delete(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.get(opts, :client_id, Teac.client_id())
    id = Keyword.fetch!(opts, :id)

    case Req.delete!(Teac.api_uri() <> "videos",
           headers: [
             {"Authorization", "Bearer #{token}"},
             {"Client-Id", client_id},
             {"Content-Type", "application/x-www-form-urlencoded"}
           ],
           params: [id: id]
         ) do
      %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
      %Req.Response{body: body} -> {:error, body}
    end
  end
end
