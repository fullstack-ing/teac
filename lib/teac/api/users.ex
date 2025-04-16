defmodule Teac.Api.Users do
  @doc """
  Gets information about one or more users.

  doc source: https://dev.twitch.tv/docs/api/reference/#get-users

  You may look up users using their user ID, login name, or both but the sum total of the number of users you may look up is 100.
  For example, you may specify 50 IDs and 50 names or 100 IDs or names, but you cannot specify 100 IDs and 100 names.
  If you don’t specify IDs or login names, the request returns information about the user in the access token if you specify a user access token.

  ## Scope: [Teac.Scopes.User.read_email/0](Teac.Scopes.User.read_email/0)
  To include the user’s verified email address in the response, you must use a user access token that includes the user:read:email scope.

  ## Authorization
  Requires an app access token or user access token.
  """
  def get(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.fetch!(opts, :client_id)

    # Normalize parameters to lists of strings
    ids = opts |> Keyword.get(:id, []) |> List.wrap() |> Enum.map(&to_string/1)
    logins = opts |> Keyword.get(:login, []) |> List.wrap() |> Enum.map(&to_string/1)

    total = length(ids) + length(logins)

    cond do
      total > 100 ->
        {:error, "Total IDs and login names cannot exceed 100"}

      true ->
        # Convert to repeated query params
        params =
          Enum.map(ids, &{:id, &1}) ++ Enum.map(logins, &{:login, &1})

        case Req.get!(Teac.Api.api_uri() <> "users",
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

  @doc """
  Update User

  source docs: https://dev.twitch.tv/docs/api/reference/#update-user

  Updates the specified user’s information. The user ID in the OAuth token identifies the user whose information you want to update.
  To include the user’s verified email address in the response, the user access token must also include the user:read:email scope.

  ## Authorization

  Requires a user access token that includes the user:edit scope.
  """
  def put(opts) do
    token = Keyword.fetch!(opts, :token)
    client_id = Keyword.fetch!(opts, :client_id)
    description = Keyword.get(opts, :description, nil)

    case Req.put!(Teac.Api.api_uri() <> "users",
           headers: [
             {"Authorization", "Bearer #{token}"},
             {"Client-Id", client_id},
             {"Content-Type", "application/x-www-form-urlencoded"}
           ],
           form: [
             description: description
           ],
           decode_body: :json
         ) do
      %Req.Response{status: 200, body: %{"data" => data}} -> {:ok, data}
      %Req.Response{body: body} -> {:error, body}
    end
  end

  defmodule Blocks do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.fetch!(opts, :client_id)

      case Req.get!(Teac.Api.api_uri() <> "users/blocks",
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
      client_id = Keyword.fetch!(opts, :client_id)

      case Req.put!(Teac.Api.api_uri() <> "users/blocks",
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
      client_id = Keyword.fetch!(opts, :client_id)

      case Req.delete!(Teac.Api.api_uri() <> "users/blocks",
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

  defmodule Extensions do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.fetch!(opts, :client_id)

      case Req.get!(Teac.Api.api_uri() <> "users/extensions",
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
      client_id = Keyword.fetch!(opts, :client_id)

      case Req.put!(Teac.Api.api_uri() <> "users/extensions",
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

  defmodule Extensions.List do
    def get(opts) do
      token = Keyword.fetch!(opts, :token)
      client_id = Keyword.fetch!(opts, :client_id)

      case Req.get!(Teac.Api.api_uri() <> "users/extensions/list",
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
end
