defmodule Teac.Api.EventSub do
  defmodule Conduits do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.get!(Teac.api_uri() <> "eventsub/conduits",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id}
             ],
             params: []
           ) do
        %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end

    def post(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.post!(Teac.api_uri() <> "eventsub/conduit",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id},
               {"Content-Type", "application/x-www-form-urlencoded"}
             ],
             form: [],
             decode_body: :json
           ) do
        %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end

    def patch(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.patch!(Teac.api_uri() <> "eventsub/conduit",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id},
               {"Content-Type", "application/x-www-form-urlencoded"}
             ],
             form: [],
             decode_body: :json
           ) do
        %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end

    def delete(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.delete!(Teac.api_uri() <> "eventsub/conduit",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id},
               {"Content-Type", "application/x-www-form-urlencoded"}
             ],
             form: [],
             decode_body: :json
           ) do
        %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end
  end

  defmodule Conduits.Shards do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.get!(Teac.api_uri() <> "eventsub/conduits/shards",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id}
             ],
             params: []
           ) do
        %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end

    def patch(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.patch!(Teac.api_uri() <> "eventsub/conduits/shards",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id},
               {"Content-Type", "application/x-www-form-urlencoded"}
             ],
             form: [],
             decode_body: :json
           ) do
        %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end
  end

  defmodule Subscriptions do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.get!(Teac.api_uri() <> "eventsub/subscriptions",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id}
             ],
             params: []
           ) do
        %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end

    def post(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())
      payload = Keyword.fetch!(opts, :payload)

      case Req.post!(Teac.api_uri() <> "eventsub/subscriptions",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id}
             ],
             json: payload,
             decode_body: :json
           ) do
        %Req.Response{status: 202, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end

    def delete(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.delete!(Teac.api_uri() <> "eventsub/subscriptions",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id},
               {"Content-Type", "application/x-www-form-urlencoded"}
             ],
             form: [],
             decode_body: :json
           ) do
        %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end
  end
end
