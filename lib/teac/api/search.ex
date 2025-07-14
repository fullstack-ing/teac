defmodule Teac.Api.Search do
  @moduledoc false

  defmodule Categories do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())
      query = Keyword.fetch!(opts, :query)

      case Req.get!(Teac.api_uri() <> "search/categories",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id}
             ],
             params: [query: query]
           ) do
        %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end
  end

  defmodule Channels do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())
      query = Keyword.fetch!(opts, :query)

      case Req.get!(Teac.api_uri() <> "search/channels",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id}
             ],
             params: [query: query]
           ) do
        %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end
  end
end
