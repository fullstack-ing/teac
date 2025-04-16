defmodule Teac.Api.Channels do
  def get(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.fetch!(opts, :client_id)
    broadcaster_id = Keyword.fetch!(opts, :broadcaster_id)

    case Req.get!(Teac.Api.api_uri() <> "channels",
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

  def patch(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.fetch!(opts, :client_id)
    broadcaster_id = Keyword.fetch!(opts, :broadcaster_id)

    case Req.patch!(Teac.Api.api_uri() <> "channels",
           headers: [
             {"Authorization", "Bearer #{token}"},
             {"Client-Id", client_id},
             {"Content-Type", "application/x-www-form-urlencoded"}
           ],
           params: [broadcaster_id: broadcaster_id],
           form: [title: "asdf"],
           decode_body: :json
         ) do
      %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
      %Req.Response{body: body} -> {:error, body}
    end
  end

  defmodule Channels.Ads do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.fetch!(opts, :client_id)

      case Req.get!(Teac.Api.api_uri() <> "channels/ads",
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

    defmodule Ads.Schedule.Snooze do
      def post(opts) do
        token = Keyword.fetch!(opts, :token)
        client_id = Keyword.fetch!(opts, :client_id)

        case Req.post!(Teac.Api.api_uri() <> "channels/ads/schedule/snooze",
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

  defmodule Commercial do
    def post(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.fetch!(opts, :client_id)

      case Req.post!(Teac.Api.api_uri() <> "channels/commercial",
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

  defmodule Editors do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.fetch!(opts, :client_id)
      broadcaster_id = Keyword.fetch!(opts, :broadcaster_id)

      case Req.get!(Teac.Api.api_uri() <> "channels/editors",
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

  defmodule Followed do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.fetch!(opts, :client_id)
      user_id = Keyword.fetch!(opts, :user_id)
      params = [user_id: user_id]

      params =
        case Keyword.get(opts, :broadcaster_id) do
          nil -> params
          broadcaster_id -> params ++ [broadcaster_id: broadcaster_id]
        end

      case Req.get!(Teac.Api.api_uri() <> "channels/followed",
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

  defmodule Followers do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.fetch!(opts, :client_id)
      broadcaster_id = Keyword.fetch!(opts, :broadcaster_id)
      params = [broadcaster_id: broadcaster_id]

      params =
        case Keyword.get(opts, :user_id) do
          nil -> params
          user_id -> params ++ [user_id: user_id]
        end

      case Req.get!(Teac.Api.api_uri() <> "channels/followers",
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

  defmodule Vips do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.fetch!(opts, :client_id)

      case Req.get!(Teac.Api.api_uri() <> "channels/vips",
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

    def delete(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.fetch!(opts, :client_id)

      case Req.delete!(Teac.Api.api_uri() <> "channels/vips",
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
