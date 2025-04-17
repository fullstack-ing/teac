defmodule Teac.Api.Streams do
  def get(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.get(opts, :client_id, Teac.client_id())

    # Normalize parameters to lists of strings
    user_ids = opts |> Keyword.get(:user_ids, []) |> List.wrap() |> Enum.map(&to_string/1)
    user_logins = opts |> Keyword.get(:user_logins, []) |> List.wrap() |> Enum.map(&to_string/1)
    game_ids = opts |> Keyword.get(:game_ids, []) |> List.wrap() |> Enum.map(&to_string/1)

    total = length(user_ids) + length(user_logins) + length(game_ids)

    cond do
      total > 100 ->
        {:error, "Total IDs and login names cannot exceed 100"}

      true ->
        params =
          Enum.map(user_ids, &{:user_id, &1}) ++ Enum.map(user_logins, &{:user_login, &1})

        params =
          case Keyword.get(opts, :type) do
            nil ->
              params

            type ->
              if type in ["all", "live"] do
                params ++ [type: type]
              else
                params
              end
          end

        case Req.get!(Teac.api_uri() <> "streams",
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

  defmodule Followed do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())
      user_id = Keyword.fetch!(opts, :user_id)

      case Req.get!(Teac.api_uri() <> "streams/followed",
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
  end

  defmodule Key do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())
      broadcaster_id = Keyword.fetch!(opts, :broadcaster_id)

      case Req.get!(Teac.api_uri() <> "streams/key",
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

  defmodule Markers do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.get(opts, :client_id, Teac.client_id())

      case Req.get!(Teac.api_uri() <> "streams/markers",
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

      case Req.post!(Teac.api_uri() <> "streams/markers",
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
