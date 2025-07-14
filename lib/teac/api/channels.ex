defmodule Teac.Api.Channels do
  alias Teac.Api
  import Ecto.Changeset

  @doc """
  Gets information about one or more channels.

  #### Authorization
  Requires an app access token or user access token.

  ### Parameters

  * broadcaster_ids : required    \
  list of one of more broadcaster_ids   \
  Max 100 IDs, ignores duplicates and not found.

  * token : required (app or user)

  * client_id : optinal (defaults to Teac.client_id())

  ### Examples

      iex> Teac.Api.Channels.get([123, 234], "some_token")
      iex> Teac.Api.Channels.get([123, 234], "some_token", "some_client_id")

      {:ok,
        {
          "broadcaster_id" =>  "1",
          "broadcaster_login" =>  "twitchdev",
          "broadcaster_name" =>  "TwitchDev",
          "broadcaster_language" =>  "en",
          "game_id" =>  "509670",
          "game_name" =>  "Science & Technology",
          "title" =>  "TwitchDev Monthly Update // May 6, 2021",
          "delay" =>  0,
          "tags" =>  ["DevsInTheKnow"],
          "content_classification_labels" => ["Gambling", "DrugsIntoxication", "MatureGame"],
          "is_branded_content" =>  false
        }...
      }
  """

  def get(opts) do
    case validate_get_opts(opts) do
      {:ok, %{broadcaster_ids: broadcaster_ids, token: token, client_id: client_id}} ->
        params =
          broadcaster_ids
          |> Enum.map(&to_string/1)
          |> Enum.map(&{:broadcaster_id, &1})

        [
          base_url: Api.uri("channels"),
          params: params,
          headers: Api.headers(token, client_id || Teac.client_id())
        ]
        |> Keyword.merge(Application.get_env(:teac, :api_req_options, []))
        |> Req.get!()
        |> Api.handle_response()

      error ->
        error
    end
  end

  defp validate_get_opts(opt) do
    data = %{}
    types = %{token: :string, client_id: :string, broadcaster_ids: {:array, :integer}}

    changeset =
      {data, types}
      |> cast(opt |> Map.new(), Map.keys(types))
      |> Api.default_client_id()
      |> validate_required([:token, :client_id, :broadcaster_ids])
      |> validate_length(:broadcaster_ids, min: 1, max: 100)

    case apply_action(changeset, :insert) do
      {:ok, data} -> {:ok, data}
      {:error, %Ecto.Changeset{errors: errors}} -> {:error, errors}
    end
  end

  def patch(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.get(opts, :client_id, Teac.client_id())
    broadcaster_id = Keyword.fetch!(opts, :broadcaster_id)

    case Req.patch!(Teac.api_uri() <> "channels",
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
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.get!(Teac.api_uri() <> "channels/ads",
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
        client_id = Keyword.get(opts, :client_id, Teac.client_id())

        case Req.post!(Teac.api_uri() <> "channels/ads/schedule/snooze",
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
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.post!(Teac.api_uri() <> "channels/commercial",
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

  defmodule Followed do
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

  defmodule Followers do
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

  defmodule Vips do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.get!(Teac.api_uri() <> "channels/vips",
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
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.delete!(Teac.api_uri() <> "channels/vips",
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
