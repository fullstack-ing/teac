defmodule Teac.Api.Chat do
  defmodule Announcements do
    @doc """
    Sends an announcement to the broadcaster’s chat room.

    source docs: https://dev.twitch.tv/docs/api/reference/#send-chat-announcement
    Rate Limits: One announcement may be sent every 2 seconds.

    ## Authorization

    Requires a user access token that includes the moderator:manage:announcements scope.
    """
    def post(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())
      broadcaster_id = Keyword.fetch!(opts, :broadcaster_id)
      moderator_id = Keyword.fetch!(opts, :moderator_id)
      message = Keyword.fetch!(opts, :message)
      color = Keyword.get(opts, :color, nil)

      case Req.post!(Teac.api_uri() <> "chat/announcements",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id},
               {"Content-Type", "application/x-www-form-urlencoded"}
             ],
             form: [
               broadcaster_id: broadcaster_id,
               moderator_id: moderator_id,
               message: message,
               color: color
             ],
             decode_body: :json
           ) do
        %Req.Response{status: 204, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end
  end

  defmodule Badges do
    @doc """
      Gets the broadcaster’s list of custom chat badges. The list is empty if the broadcaster hasn’t created custom chat badges.
      For information about custom badges, see subscriber badges and Bits badges.

      source docs: https://dev.twitch.tv/docs/api/reference/#get-channel-chat-badges

      ## Authorization
      Requires an app access token or user access token.
    """
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())
      broadcaster_id = Keyword.fetch!(opts, :broadcaster_id)

      case Req.get!(Teac.api_uri() <> "chat/badges",
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

  defmodule Badges.Global do
    @doc """
    Gets Twitch’s list of chat badges, which users may use in any channel’s chat room.
    For information about chat badges, see Twitch Chat Badges Guide.

    source docs: https://dev.twitch.tv/docs/api/reference/#get-global-chat-badges

    ## Authorization

    Requires an app access token or user access token.
    """
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.get!(Teac.api_uri() <> "chat/badges/global",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id}
             ]
           ) do
        %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end
  end

  defmodule Chatters do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.get!(Teac.api_uri() <> "chat/chatters",
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
  end

  defmodule Color do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.get!(Teac.api_uri() <> "chat/color",
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

      case Req.put!(Teac.api_uri() <> "chat/color",
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

  defmodule Emotes do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())
      broadcaster_id = Keyword.get(opts, :broadcaster_id)

      case Req.get!(Teac.api_uri() <> "chat/emotes",
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

  defmodule Emotes.Global do
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

  defmodule Emotes.Set do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())
      emote_set_id = Keyword.fetch!(opts, :emote_set_id)

      case Req.get!(Teac.api_uri() <> "chat/emotes/set",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id}
             ],
             params: [
               emote_set_id: emote_set_id
             ]
           ) do
        %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end
  end

  defmodule Emotes.User do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.get!(Teac.api_uri() <> "chat/emotes/user",
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
  end

  defmodule Messages do
    def post(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())
      message = Keyword.fetch!(opts, :message)
      broadcaster_id = Keyword.fetch!(opts, :broadcaster_id)
      sender_id = Keyword.fetch!(opts, :sender_id)
      reply_parent_message_id = Keyword.get(opts, :reply_parent_message_id)

      case Req.post!(Teac.api_uri() <> "chat/messages",
             headers: [
               {"Authorization", "Bearer #{token}"},
               {"Client-Id", client_id},
               {"Content-Type", "application/x-www-form-urlencoded"}
             ],
             form: [
               message: message,
               broadcaster_id: broadcaster_id,
               sender_id: sender_id,
               reply_parent_message_id: reply_parent_message_id
             ],
             decode_body: :json
           ) do
        %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
        %Req.Response{body: body} -> {:error, body}
      end
    end
  end

  defmodule Settings do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())
      broadcaster_id = Keyword.fetch!(opts, :broadcaster_id)

      case Req.get!(Teac.api_uri() <> "chat/settings",
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
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.patch!(Teac.api_uri() <> "chat/settings",
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

  defmodule Shoutouts do
    def post(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.post!(Teac.api_uri() <> "chat/shoutouts",
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
