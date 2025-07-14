defmodule Teac.Api.GuestStar do
  @moduledoc false

  defmodule ChannelCettings do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.get!(Teac.api_uri() <> "guest_star/channel_settings",
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

    def put(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.put!(Teac.api_uri() <> "guest_star/channel_settings",
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

  defmodule Invites do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.get!(Teac.api_uri() <> "guest_star/invites",
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

      case Req.post!(Teac.api_uri() <> "guest_star/invites",
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

      case Req.delete!(Teac.api_uri() <> "guest_star/invites",
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

  defmodule Session do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.get!(Teac.api_uri() <> "guest_star/session",
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

      case Req.post!(Teac.api_uri() <> "guest_star/session",
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

      case Req.delete!(Teac.api_uri() <> "guest_star/session",
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

  defmodule Slot do
    def post(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.post!(Teac.api_uri() <> "guest_star/slot",
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

      case Req.patch!(Teac.api_uri() <> "guest_star/slot",
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

      case Req.delete!(Teac.api_uri() <> "guest_star/slot",
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

  defmodule SlotSettings do
    def patch(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.patch!(Teac.api_uri() <> "guest_star/slot_settings",
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
